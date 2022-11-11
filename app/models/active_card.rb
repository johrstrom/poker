class ActiveCard < SimpleDelegator

  attr_writer :active

  def initialize(card, active: false)
    super(card)
    @active = active
  end

  def active?
    !!active
  end
end
