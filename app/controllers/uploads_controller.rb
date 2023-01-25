class UploadsController < ApplicationController
    attr_accessor :collection, :divisor

    def create
        json_data = JSON.parse(request.body.read)
        @collection = json_data["number_collection"]
        @divisor = json_data["div_by"]
        updated_collection = processCollection(@collection, @divisor)
        render json: { status: 'success', updated_collection: updated_collection }, status: :ok
    end

    def dropNumbersThatAreDividedByDivisor (collection, divisor)
        updated_collection = collection.reject { |n|  n % divisor == 0 }
        return updated_collection
    end

    def sortCollection (collection)
        updated_collection = collection.sort
        return updated_collection
    end

    def processCollection (collection, divisor)
        updated_collection = dropNumbersThatAreDividedByDivisor(collection, divisor)
        updated_collection = sortCollection(updated_collection)
        return updated_collection
    end
end
