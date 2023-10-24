class DeliveriesController < ApplicationController
  def index
    @waiting = Delivery.where({ arrived: false })

    @received = Delivery.where({ arrived: true })

    render({ :template => "deliveries/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_deliveries = Delivery.where({ :id => the_id })

    @the_delivery = matching_deliveries.at(0)

    render({ :template => "deliveries/show" })
  end

  def create
    the_delivery = Delivery.new
    the_delivery.user_id = current_user.id
    the_delivery.description = params.fetch("description")
    the_delivery.details = params.fetch("details")
    the_delivery.supposed_to_arrive_on = params.fetch("supposed_to_arrive_on")
    the_delivery.arrived = false

    if the_delivery.valid?
      the_delivery.save
      redirect_to("/deliveries", { :notice => "Added to list." })
    else
      redirect_to("/deliveries", { :alert => the_delivery.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_delivery = Delivery.where({ :id => the_id }).at(0)

    the_delivery.arrived = true

    if the_delivery.valid?
      the_delivery.save
      redirect_to("/deliveries", { :notice => "Delivery updated successfully."} )
    else
      redirect_to("/deliveries", { :alert => the_delivery.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_delivery = Delivery.where({ :id => the_id }).at(0)

    the_delivery.destroy

    redirect_to("/deliveries", { :notice => "Delivery deleted successfully."} )
  end
end
