class Api::DeviceController < ApplicationController
    # checks that device has not been terminated yet
    skip_before_action :authorized, only: [:register]

    def register
        # POST request, creates a device
        # Params phone_number, carrier
        # RETURNS device_id
            
        new_register = Device.create(phone_number: register_params[:phone_number], carrier: register_params[:carrier])
            
        # Device has validation where Carrier must be filled in, also Phonelib Validation
        if new_register.valid?
            render json: ({device_id: new_register.id}), status: 200
        else
            render json: {"error": new_register.errors.objects.first.full_message}, status: 500
        end

        
    end

    def alive
        # POST request, creates heartbeat linking to device.
        # Params device_id
        # RETURNS {}

        # in case authorized has a blip and returns something other than a device object
        begin
            Heartbeat.create(device: @device)
            render json:({}), status: 200
        rescue
            render json: ({"error": "Device was not found"}), status: 500
        end
        
    end

    def report
        # POST request, creates report for device
        # Params device_id, message, sender
        # RETURNS {}

        new_report = Report.create(device: @device, message: report_params[:message], sender: report_params[:sender])
        if new_report.valid?
            render json:({}), status: 200
        else
            render json: {"error": new_report.errors.objects.first.full_message}, status: 500
        end
    end

    def terminate
        # PATCH request set's disabled_at to current timestamp
        # Params device_id
        # RETURNS {}

        begin
            @device.update(disabled_at: Time.now)
            render json: {}, status: 200
        rescue
            render json:({"errors": "Device was not found"}), status: 500
        end
    end

    private

    # Normally I would also require an encompassing variables but since endpoints may be tested with postman for ease of use I am skipping that step
    
    def register_params
        params.permit(:phone_number, :carrier)
    end

    def report_params
        params.permit(:device_id, :message, :sender)
    end

end