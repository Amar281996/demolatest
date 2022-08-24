package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraAscp(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../TF-files",

		Vars: map[string]interface{}{
			"region": "us-east-2",
		},
	})
	/*defer terraform.Destroy(t, terraformOptions)*/
	terraform.InitAndApply(t, terraformOptions)
	//terraform.OutputASCP_installation(t, terraformOptions)
	output := terraform.Output(t, terraformOptions, "ASCP_installation")
	secret_arn := terraform.Output(t, terraformOptions, "secret_arn")
	assert.Equal(t, secret_arn, output)
}
