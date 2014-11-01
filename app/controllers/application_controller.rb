require 'aws-sdk'

class ApplicationController < ActionController::Base
  	# => Prevent CSRF attacks by raising an exception.
  	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	#AWSAccessKeyId=AKIAJRXEWOJB2LNN2FHA
	#AWSSecretKey=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

  	device_token = ''
	aws_access_key = 'AKIAJRXEWOJB2LNN2FHA'
	aws_secret_key = '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'
	region = 'tokyo'
	application_arn = 'arn:aws:sns:ap-northeast-1:023045183369:app/GCM/rakuten_cafe_push'

	AWS.config(
	  access_key_id: aws_access_key,
	  secret_access_key: aws_secret_key,
	  region: region
	)

	sns = AWS::SNS.new
	client = sns.client
	response = client.create_endpoint(
	  platform_application_arn: application_arn,
	  token: device_token
	)
	endpoint_arn = response[:endpoint_arn]
	client.publish(target_arn: endpoint_arn, message: 'hogehoge')

end
