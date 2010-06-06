class Api::V1::BedsController < Api::V1::ApiController
  authenticate "organisation"

  define_restful_class Bed

  def available
    @organisation = @current_user.organisations.first
    @beds = @organisation.find_beds({
      :start_date => params[:start_date],
      :end_date   => params[:end_date],
      :day        => params[:day],
      :beds       => params[:beds],
      :latitude   => params[:latitude],
      :longitude  => params[:longitude],
      :radius     => params[:radius],
      })
  end

  def reserve_beds
    @organisation = @current_user.organisations.first
    params[:bed_ids].each do |bed_id|
      @organisation.reserve_bed({
        :start_date => params[:start_date],
        :end_date   => params[:end_date],
        :day        => params[:day],
        :bed_id    => bed_id})
    end

    render :nothing => true, :status => :ok
  end
end
