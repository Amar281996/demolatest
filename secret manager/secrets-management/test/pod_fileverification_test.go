package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraPodfile(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../TF-files",

		Vars: map[string]interface{}{
			"region": "us-east-2",
		},
	})
	/*defer terraform.Destroy(t, terraformOptions)*/
	terraform.InitAndApply(t, terraformOptions)
	pod_output := terraform.Output(t, terraformOptions, "pod_logs")
	pod_fileverification := terraform.Output(t, terraformOptions, "pod_file")
	assert.Equal(t, pod_fileverification, pod_output)
}
