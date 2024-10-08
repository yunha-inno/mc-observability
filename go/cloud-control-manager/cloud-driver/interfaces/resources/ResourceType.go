// Cloud Driver Interface of CB-Spider.
// The CB-Spider is a sub-Framework of the Cloud-Barista Multi-Cloud Project.
// The CB-Spider Mission is to connect all the clouds with a single interface.
//
//      * Cloud-Barista: https://github.com/cloud-barista
//
// This is Resouces interfaces of Cloud Driver.
//
// by CB-Spider Team, 2024.06.

package resources

type RSType string

const (
	ALL          RSType = "all"
	IMAGE        RSType = "image"
	VPC          RSType = "vpc"
	SUBNET       RSType = "subnet"
	SG           RSType = "sg"
	KEY          RSType = "keypair"
	VM           RSType = "vm"
	VMMONITORING RSType = "vmmonitoring"
	NLB          RSType = "nlb"
	DISK         RSType = "disk"
	MYIMAGE      RSType = "myimage"
	CLUSTER      RSType = "cluster"
	NODEGROUP    RSType = "nodegroup"
)

func RSTypeString(rsType RSType) string {
	switch rsType {
	case ALL:
		return "All Resources"
	case IMAGE:
		return "VM Image"
	case VPC:
		return "VPC"
	case SUBNET:
		return "Subnet"
	case SG:
		return "Security Group"
	case KEY:
		return "VM KeyPair"
	case VM:
		return "VM"
	case NLB:
		return "Network Load Balancer"
	case DISK:
		return "disk"
	case MYIMAGE:
		return "MyImage(Snapshot)"
	case CLUSTER:
		return "Kubernetes Cluster"
	case NODEGROUP:
		return "Kubernetes NodeGroup"
	default:
		return string(rsType) + " is not supported Resource!!"

	}
}
