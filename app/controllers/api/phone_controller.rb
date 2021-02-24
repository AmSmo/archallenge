class Api::PhoneController < ApplicationController

    def register
        render json: ({"Where": "Register"}), status: 200
    end

    def alive
        render json:({"Where": "Alive"}), status: 200
    end

    def report
        render json:({"Where": "Report"}), status: 200
    end

    def terminate
        render json:({"Where": "Terminate"}), status: 200
    end

    def index
        render json:{devices: Device.all}
    end

end