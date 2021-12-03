#!/bin/sh

# Created Wed Dec 16 14:52:56 EST 2020, richard.moore@windriver.com
#
# This script takes an HVP SR0640 hypervisor project that has been moved and fixes the path

####################################################################
# EDIT HERE FOR YOUR PROJECT DIRECTORIES- set these for your project
####################################################################
#export PROJ_NAME=zcu102
#export SRC_WS=/build/rmoore/hvp/hvp-sr0640/zcu102-hv3
#export TGT_WS=/build/rmoore/hvp/export/zcu102-vx32-lx 


export DEFAULT_BSP=xlnx_zynqmp_2_0_4_1

export HYPERVISOR=${PROJ_NAME}-hypervisor
export HYPERVISOR_BSP=${DEFAULT_BSP}

export VSB_GOS01=${PROJ_NAME}-vxworks32-gos-vsb
export VIP_GOS01=${PROJ_NAME}-vxworks32-gos-vip
export VIP_GOS01_BSP=${DEFAULT_BSP}

###########
# END EDIT
###########

print_usage_exit() {

    echo Usage: 
    echo -e '\t' $0 \<projname\>  \<original-absolute-path\> 
    echo
    echo Notes:
    echo - Must be run from top level project directory of copied project
    echo - projname is the part before `-hypervisor`
    echo - no trailing \/ on the paths
    echo - Source path can be found in first line of \<proj_dir\>\/projname-hypervisor\/deps.romfs.mk
    
        
    exit 1

}


# check parameters
if [ "$#" != 2 ]; then
    print_usage_exit
fi

# set parameters
export PROJ_NAME=$1
export SRC_WS=$2
export TGT_WS=$(pwd)


if [ ! -d $TGT_WS/$PROJ_NAME-hypervisor ]; then

    echo -------------------------
    echo Error, Please check target workspace path
    echo -------------------------
    print_usage_exit
fi



# change absolute paths in various files
echo Change absolute paths
for each in $(find $TGT_WS -name "*.mk")
do 
    echo updating $each
    sed -i s#$SRC_WS#$TGT_WS#g $each
done

for each in $(find $TGT_WS -name "*.wpj")
do 
    echo updating $each
    sed -i s#$SRC_WS#$TGT_WS#g $each
done

for each in $(find $TGT_WS -name "Makefile")
do 
    echo updating $each
    sed -i s#$SRC_WS#$TGT_WS#g $each
done

for each in $(find $TGT_WS -name "*.cdf")
do 
    echo updating $each
    sed -i s#$SRC_WS#$TGT_WS#g $each
done

