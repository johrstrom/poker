# frozen_string_literal: true

class SimulationsController < ApplicationController
  def new
    id = 'abc123'
    Rails.cache.fetch(id, expires_in: 6.hours) do
      Simulation.new
    end
    redirect_to(action: 'show', id:)
  end

  def show; end

  def destroy; end
end
