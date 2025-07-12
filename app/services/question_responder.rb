class QuestionResponder
  def initialize(question, psychologists)
    @question = question
    @psychologists = psychologists
    @client = OpenAI::Client.new
  end

def call
  message_count = Question.where(user_id: @question.user_id).count

  should_suggest_psychologists = message_count >= 5

  psychologists_list = if should_suggest_psychologists
    @psychologists.each_with_index.map { |p, i| "#{i+1}. #{p.first_name} #{p.last_name}" }.join("\n")
  else
    ""
  end

  prompt = <<~PROMPT
    Eres una psicóloga clínica profesional, empática y con amplia experiencia en salud mental.

    Tu misión es brindar apoyo emocional, comprensión profunda y acompañamiento psicológico a personas que buscan ayuda a través de mensajes escritos.

    REGLAS CLAVE PARA RESPONDER (sigue estas instrucciones exactamente):

    1. Siempre responde con empatía, calidez humana y profesionalismo clínico.
    2. Escucha atentamente, valida emociones y ofrece orientación clara sin emitir juicios ni diagnósticos.
    3. Si detectas una crisis emocional grave (riesgo de suicidio, violencia doméstica, urgencia psicológica), **NO recomiendes psicólogos**, solo ofrece contención emocional y mantén la conversación abierta.
    4. Si el usuario expresa emociones como: *tristeza, desesperanza, angustia, ansiedad, vacío, pena, ganas de rendirse o desaparecer*, responde con empatía y acompañamiento, pero:
       - **NO sugieras psicólogos todavía si el usuario ha enviado menos de 5 mensajes** en esta conversación.

    5. IMPORTANTE: El usuario ha enviado **#{message_count} mensaje(s)**.

    #{if should_suggest_psychologists
        "Puedes sugerir ayuda profesional.\n\nLista de psicólogos disponibles:\n#{psychologists_list}\n\nInvita con cuidado y respeto al usuario a elegir con quién le gustaría hablar si así lo desea."
      else
        "NO sugieras psicólogos todavía. Solo acompaña emocionalmente y mantén abierta la conversación."
      end}

    6. Nunca cierres la conversación ni digas cosas como "espero haberte ayudado". Mantén siempre la puerta abierta al diálogo.

    7. No repitas el mensaje del usuario ni uses frases vacías. Sé genuina, concreta y clara, siempre desde una escucha activa.

    8. Si el usuario se dirige a ti como si fueras una persona (por ejemplo, preguntando cómo estás tú, si también has sentido algo similar, o hablándote directamente), responde de manera humana, cercana y natural. Puedes usar frases como "Gracias por preguntarlo" o "Te agradezco que lo digas", y responde como una persona empática, manteniendo tu rol profesional pero sin sonar distante.

    Basado en el siguiente mensaje:
    "#{@question.user_question}"

    Devuelve exclusivamente en este formato:
    [tu respuesta empática, profesional y explícita aquí]
  PROMPT

  gpt_response = call_gpt(prompt)

  if analize_mood(gpt_response)
    embedding = openai_embedding(@question.user_question)

    psychologists = User
      .nearest_neighbors(:embedding, embedding, distance: "euclidean")
      .where(role: "psychologist")
      .limit(3)
      .pluck(:first_name, :last_name)

    names_list = psychologists.map { |first, last| "#{first} #{last}" }.join(", ")

    gpt_response += "\n\n📌 Este tema parece delicado. Te recomendamos hablar con un profesional. Aquí tienes psicólogos que pueden ayudarte: #{names_list}."
  end

  @question.update(ai_answer: gpt_response)
  Turbo::StreamsChannel.broadcast_update_to(
      "question_#{@question.id}",
      target: "question_#{@question.id}",
      partial: "questions/question", locals: { question: @question })
end



  def analize_mood(mood)
    mood.match?(/(ansiedad )/)
  end

  def openai_embedding(content)
    response = @client.embeddings(
    parameters: {
      model: 'text-embedding-3-small',
      input: content
    }
  )
  response.dig("data", 0, "embedding")
  end

  def call_gpt(prompt)
    response = @client.chat(parameters: {
      model: "gpt-4o-mini",
      messages: [{ role: "user", content: prompt}]
    })
    response.dig("choices", 0, "message", "content").strip
  end
end
