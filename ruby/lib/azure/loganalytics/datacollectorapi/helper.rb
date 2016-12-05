module Azure
  module Loganalytics
    module Datacollectorapi

      def is_success(res)
        return (res.code == 202) ? true : false
      end

    end
  end
end
