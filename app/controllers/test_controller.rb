class TestController < ApplicationController
#  
  def index

    aws_access_key = 'AKIAJRXEWOJB2LNN2FHA'
    aws_secret_key = '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'
    region = 'tokyo'
    application_arn = 'arn:aws:sns:ap-northeast-1:023045183369:app/GCM/rakuten_cafe_push'
    sns = AWS::SNS.new
    AWS.config(
      access_key_id: aws_access_key,
      secret_access_key: aws_secret_key,
      region: region
    )
    client = sns.client
    # とりあえずUserの先頭にPublish
    response = client.create_platform_endpoint(
      platform_application_arn: application_arn,
      #token: User.first.registration_id # ユーザのデバイスID
      token:''
    )
    endpoint_arn = response[:endpoint_arn]
    client.publish(
      target_arn: endpoint_arn,
#      message: params[:message]
      message: 'This is test.'
    )


  end
end
