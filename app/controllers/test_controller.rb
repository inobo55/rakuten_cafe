class TestController < ApplicationController
#  
  def index
	sns = AWS::SNS.new
    client = sns.client
    # とりあえずUserの先頭にPublish
    response = client.create_platform_endpoint(
      platform_application_arn: 'arn:aws:sns:ap-northeast-1:023045183369:app/GCM/rakuten_cafe_push',
      token: User.first.registration_id
    )
    endpoint_arn = response[:endpoint_arn]
    client.publish(
      target_arn: endpoint_arn,
      message: params[:message]
    )


  end
end
