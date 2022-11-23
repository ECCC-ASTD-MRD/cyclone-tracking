

# Definition of ssm packages to load for compiling

LOAD_ARCHITECTURE=. r.env.dot --arch amd64

#Intel Compiler
SSM_COMPILER = /fs/ssm/main/opt/intelcomp/inteloneapi-2022.1.2
SSM_CODE_TOOLS= eccc/mrd/rpn/code-tools/1.5.5


#For timing
#SSM_COMPILER = -d /fs/ssm/hpco/tmp/eccc/201402/03/base -d main/opt/intelcomp/intelcomp-2016.1.156 -p /fs/ssm/hpco/exp/jdm536/code-tools/code-tools_2.0_all -d main/opt/perftools/perftools-2.0/intel-2016.1.156 
#LIBPERF="-libsys hpcoperf"

# RMNLIB
SSM_RMNLIB = eccc/mrd/rpn/libs/20220216
RMNLIB = rmn

