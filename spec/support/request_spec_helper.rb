module RequestSpecHelper
    def RequestSpecHelper.json(response)
        return JSON.parse(response.body)
    end
end