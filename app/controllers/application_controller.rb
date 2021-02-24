class ApplicationController < ActionController::API
    before_action :authorized
    skip_before_action :authorized, only:[:routing_error]
    
    def routing_error
        render json: {"error": "Route Doesn't Exist Please Check Again."}
    end

    def authorized
        # received a param of device_id
        if device_params[:device_id]
            @device = Device.find_by(id: device_params[:device_id])
            if @device 
                if !@device.disabled_at 
                    @device 
                else
                    # could also consider a response of 401 unauthorized
                    render json: { "error": 'Device has been disabled' }, status: 500
                end
            else
                render json: { "error": 'Device not found' }, status: 500
            end
        end
    end

    private

    def device_params
        params.permit(:device_id)
    end

end
