commit_id=$(git rev-parse --verify HEAD)

git diff-tree --no-commit-id --name-only -r $commit_id > changes.txt


path=$(pwd)

filename="$path/changes.txt"

while read -r line
do
    name="$line"
    echo "Name read from file - $name"
    
    
    case $name in
      *Sales*) echo "starts with Sales"
      
      ;;
      *Orders*) echo "contains Orders"
      
      ;;
       *UserSample*) echo "UserSample lambda Function Changed"
      
      
      commit_id=$(git rev-parse --verify HEAD)

	  git diff-tree --no-commit-id --name-only -r $commit_id

      export current_dir=$(pwd)

	  cd $current_dir/Config/Source/Lambda/UserSample/

	  npm install --production

	  sudo sh bundle.sh

	  ls -art

	 lambda_arn=$(sudo cat /var/lib/jenkins/workspace/Detect-Updated-Files/Config/CFN-Stacks/ResourceDetailInStack.json | jq .Stacks[].Outputs[1].OutputValue)

	 sed -e 's/^"//' -e 's/"$//' <<<"$lambda_arn"

	 echo $lambda_arn

	lambda_arn_final=$(echo "$lambda_arn" | tr -d '\"')

	aws lambda update-function-code --function-name $lambda_arn_final --zip-file fileb://$current_dir/Config/Source/Lambda/UserSample/lambda.zip --publish ;;
      
    esac
    
done < "$filename"
