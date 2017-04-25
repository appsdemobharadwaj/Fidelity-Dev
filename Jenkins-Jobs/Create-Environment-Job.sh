sudo git reset --hard

sudo git checkout master

sudo git remote rm origin

sudo git remote add origin https://appsdemobharadwaj:Webhosting123@github.com/appsdemobharadwaj/Fidelity-Dev.git

export current_dir=$(pwd)

#cat $current_dir/Config/CFN-Scripts/CreateStack-CFN.json

cd $current_dir/Config/Source/Lambda/UserSample/

pwd 

sudo chmod -R 777 *

npm install --production

sudo sh bundle.sh

export AWS_ACCESS_KEY_ID=AKIAIEJVXIYWTDWUCOTA
export AWS_SECRET_ACCESS_KEY=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
export AWS_DEFAULT_REGION=us-east-2
export AWS_DEFAULT_OUTPUT_FORMAT=json

export S3Bucket=fidelityautomation

#aws s3 mb s3://$S3Bucket

aws s3 cp lambda.zip s3://$S3Bucket/lambda.zip

aws cloudformation create-stack --stack-name apigateway${BUILD_NUMBER} --template-body file:///var/lib/jenkins/workspace/Create-Environment-Test/Config/CFN-Scripts/CreateStack-CFN.json --capabilities CAPABILITY_IAM --parameters ParameterKey=S3Bucket,ParameterValue=$S3Bucket

aws cloudformation wait stack-create-complete --stack-name apigateway${BUILD_NUMBER}

#ApiId=$(sudo aws cloudformation describe-stacks --output json --stack-name apigateway${BUILD_NUMBER} --query Stacks[0].Outputs)

#export ApiGatewayEndpoint="$ApiId.execute-api.us-east-2.amazonaws.com/v1"

cd /var/lib/jenkins/workspace/Create-Environment-Test/Config/CFN-Stacks/

pwd

aws cloudformation describe-stacks --stack-name apigateway${BUILD_NUMBER} > /var/lib/jenkins/workspace/Create-Environment-Test/Config/CFN-Stacks/ResourceDetailInStack.json || aws cloudformation describe-stacks --stack-name apigateway${BUILD_NUMBER} > ResourceDetailInStack.json

cd /var/lib/jenkins/workspace/Create-Environment-Test/

sudo chmod -R 777 .

echo "build number is ${BUILD_NUMBER}" > build.txt

sudo git add .

sudo git commit -m "Updated By Jenkins Build - ${BUILD_NUMBER}"

sudo git status

sudo git push origin master -f

echo $ApiGatewayEndpoint