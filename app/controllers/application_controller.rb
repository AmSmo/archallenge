class ApplicationController < ActionController::API
    before_action :authorized

    
    def authorized
        # received a param of device_id
        if params[:device_id]
            @device = Device.find_by(id: params[:device_id])
            if @device 
                if !@device.disabled_at 
                    @device 
                else
                    render json: { "error": 'Device has been disabled' }
                end
            else
                render json: { "error": 'Device not found' }, status: 500
            end
        end
    end

end
