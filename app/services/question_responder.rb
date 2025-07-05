class QuestionResponder
  def initialize(question)
    @question = question
    @client = OpenAI::Client.new
  end

  def call
    gpt_response = call_gpt(@question.user_question)
    if analize_mood(gpt_response)
      openai_embedding(@question.user_question)
    end
    @question.update(ai_answer: gpt_response)
  end

  def analize_mood(mood)
    mood.match?(/(ansiedad)/)
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
