class Sentiment
  def initialize(*pattern)
    @pattern = /#{"(" + pattern.map{|a| or_regex(a) }.join(').*(') + ")"}/
  end

  def analyze(phrase)
    sentiments = @pattern.match phrase
    !!sentiments
  end

  private

  def or_regex(phrase)
    return "#{phrase.join("|")}" if phrase.is_a? Array
    phrase
  end

end
