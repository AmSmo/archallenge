class Api::DeviceController < ApplicationController

    def register
        # POST request, creates a device
        # Params phone_number, carrier
        # RETURNS device_id
        
        #format phone number to es164 standard
        sanitized_number = DeviceHelper.format_phone(register_params[:phone_number])
        
        if sanitized_number
            carrier = register_params[:carrier]
            
            new_register = Device.create(phone_number: sanitized_number, carrier: carrier)
            puts sanitized_number
            # Device has validation where Carrier must be filled in
            if new_register.valid?
                render json: ({device_id: new_register.id}), status: 200
            else
                render json: {"error": new_register.errors.objects.first.full_message}, status: 500
            end

        else
            # did not format appropriately and could not be successfully transitioned to a US based number
            render json: {"error": "invalid phone number."}, status: 500
        end
    end

    def alive
        # POST request, creates heartbeat linking to device.
        # Params device_id
        # RETURNS {}
        current_device = Device.find_by(id: device_params[:device_id])
        puts "HELLO #{current_device},or: #{device_params[:device_id]}"
        if current_device

            render json:({"Where": current_device}), status: 200
        else
            render json: {"error": "No such device found."}, status: 500
        end
    end

    def report
        # POST request, creates report for device
        # Params device_id, message, sender
        # RETURNS {}
        render json:({"Where": "Report"}), status: 200
    end

    def terminate
        # PATCH request set's disabled_at to current timestamp
        # Params device_id
        # RETURNS {}
        render json:({"Where": "Terminate"}), status: 200
    end

    private

    # Normally I would also require an encompassing variables but since endpoints may be tested with postman for ease of use I am skipping that step
    
    def register_params
        params.permit(:phone_number, :carrier)
    end

    def device_params
        params.permit(:device_id)
    end

    def report_params
        params.permit(:device_id, :message, :sender)
    end

end