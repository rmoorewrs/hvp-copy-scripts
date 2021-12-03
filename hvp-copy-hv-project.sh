#!/bin/sh

# Created Wed Dec 16 14:52:56 EST 2020, richard.moore@windriver.com
#
# This is a **VERY** simple-minded example of a script to copy a 
# VSB and VIP project to a new location. It *will not* take extra files 
# into account, such as complex source trees added to the VIP.
# please add these manually
#
# When opening the new workspace in WB, you must import the workspace
# File->Import->General->Existing Projects into Workspace->Select root directory->Browse (to top level of new workspace)
#
# NOTE: while this will change the path of the project, you can't change the names
#
# Build/Rebuild recommendations
# - Rebuild (clean/build) all of the VSBs first
# - Then Build the VIPs


# Basic list of Files that need to be copied for each project type
# VSB: cc-conf/. h/config/auto.conf .cproject .gitignore .project vsb_bs.vxconfig 
#      .wrproject vsb.config **<proj_name>**.wpj
# VIP: .settings/. **bsp_r_e_v**/. .cproject .gitignore .project .wr* 
#      recalc.tm usr* vip.ld **project**.wpj vxWorks.makefile
#


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
    echo -e '\t' $0 \<proj-name\> \<path-to-source-proj\> \<path-to-target-proj\>
    echo
    echo Example:
    echo -e '\t' $0 zcu102 \/home\/foo\/ws1 \/home\/bar\/ws2
    echo Notes:
    echo - Target project workspace directory should exist
    echo - no trailing \/ on the paths
    echo - Project name cannot be changed, it must match the source project name. Workspace name can differ.
    echo - Source path can be found in first line of \<proj_dir\>\/projname-hypervisor\/deps.romfs.mk
    
        
    exit 1

}


# check parameters
if [ "$#" != 3 ]; then
    print_usage_exit
fi

# set parameters
export PROJ_NAME=$1
export SRC_WS=$2
export TGT_WS=$3

if [ ! -d $SRC_WS ]; then

    echo -------------------------
    echo Error, Please check source workspace path
    echo -------------------------
    print_usage_exit
fi

if [ ! -d $TGT_WS ]; then

    echo -------------------------
    echo Error, Please check target workspace path
    echo -------------------------
    print_usage_exit
fi




# create workspace directory
# mkdir -p ${TGT_WS}
 

#########
# HYPERVISOR
#########
echo ${HYPERVISOR}
mkdir -p ${TGT_WS}

# copy subdirs
echo Copy hypervisor project
cp -Rf ${SRC_WS}/${HYPERVISOR} ${TGT_WS}

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


#########
# VSB_GOS01
#########
echo ${VSB_GOS01}
mkdir -p ${TGT_WS}/${VSB_GOS01}
# copy cc-conf directory
cp -Rf ${SRC_WS}/${VSB_GOS01}/cc-conf ${TGT_WS}/${VSB_GOS01}

# copy h/config/auto.conf
mkdir -p ${TGT_WS}/${VSB_GOS01}/h/config
cp ${SRC_WS}/${VSB_GOS01}/h/config/auto.conf ${TGT_WS}/${VSB_GOS01}/h/config/auto.conf 

# copy other files in VSB directory
cp ${SRC_WS}/${VSB_GOS01}/.cproject ${TGT_WS}/${VSB_GOS01}/.cproject
cp ${SRC_WS}/${VSB_GOS01}/.project ${TGT_WS}/${VSB_GOS01}/.project
cp ${SRC_WS}/${VSB_GOS01}/vsb_bs.vxconfig ${TGT_WS}/${VSB_GOS01}/vsb_bs.vxconfig
cp ${SRC_WS}/${VSB_GOS01}/.wrproject ${TGT_WS}/${VSB_GOS01}/.wrproject
cp ${SRC_WS}/${VSB_GOS01}/vsb.config ${TGT_WS}/${VSB_GOS01}/vsb.config
cp ${SRC_WS}/${VSB_GOS01}/${VSB_GOS01}.wpj ${TGT_WS}/${VSB_GOS01}/${VSB_GOS01}.wpj

#########
# VIP_GOS01
#########
echo ${VIP_GOS01}
mkdir -p ${TGT_WS}/${VIP_GOS01}

# copy .settings directory
cp -Rf ${SRC_WS}/${VIP_GOS01}/.settings ${TGT_WS}/${VIP_GOS01}

# copy BSP dir
cp -Rf ${SRC_WS}/${VIP_GOS01}/${VIP_GOS01_BSP}/ ${TGT_WS}/${VIP_GOS01}/


# copy other files in VIP directory
cp ${SRC_WS}/${VIP_GOS01}/.cproject ${TGT_WS}/${VIP_GOS01}/.cproject
cp ${SRC_WS}/${VIP_GOS01}/.gitignore ${TGT_WS}/${VIP_GOS01}/.gitignore
cp ${SRC_WS}/${VIP_GOS01}/.project ${TGT_WS}/${VIP_GOS01}/.project
cp ${SRC_WS}/${VIP_GOS01}/.wr* ${TGT_WS}/${VIP_GOS01}/
cp ${SRC_WS}/${VIP_GOS01}/recalc.tm ${TGT_WS}/${VIP_GOS01}/recalc.tm
cp ${SRC_WS}/${VIP_GOS01}/*.c ${TGT_WS}/${VIP_GOS01}/
cp ${SRC_WS}/${VIP_GOS01}/*.h ${TGT_WS}/${VIP_GOS01}/
cp ${SRC_WS}/${VIP_GOS01}/${VIP_GOS01}.wpj ${TGT_WS}/${VIP_GOS01}/${VIP_GOS01}.wpj
cp ${SRC_WS}/${VIP_GOS01}/vxWorks.makefile ${TGT_WS}/${VIP_GOS01}/vxWorks.makefile




# replace the absolute path from the wpj file with the $(PRJ_DIR) workbench variable
#sed -i s#${SRC_WS}#'$(PRJ_DIR)'#g ${TGT_WS}/${MIP}/${MIP}.wpj

# The _defs.mos.mk file has an embedded path that must be changed for your final build location.
# echo NOTE: You must edit the file ${MIP}/_defs.mos.mk and replace 'CHANGEME' with the Project Directory Path
# echo __MOS_LOCATION = CHANGEME/${VIP_ROOTOS} > ${TGT_WS}/${MIP}/_defs.mos.mk
# echo __MOS_VSB_LOCATION = CHANGEME/${HYPERVISOR} >> ${TGT_WS}/${MIP}/_defs.mos.mk
# echo __MOS_BSP_LOCATION = CHANGEME/${VIP_ROOTOS}/${HYPERVISOR_BSP} >> ${TGT_WS}/${MIP}/_defs.mos.mk




