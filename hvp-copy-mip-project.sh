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
# - Rebuild all of the VSBs first
# - Then Build the VIPs
# - Build the MIP project after the MIP VSB and other projects have been built/rebuilt

# Basic list of Files that need to be copied for each project type
# VSB: cc-conf/. h/config/auto.conf .cproject .gitignore .project vsb_bs.vxconfig 
#      .wrproject vsb.config **<proj_name>**.wpj
# VIP: .settings/. **bsp_r_e_v**/. .cproject .gitignore .project .wr* 
#      recalc.tm usr* vip.ld **project**.wpj vxWorks.makefile
#


####################################################################
# EDIT HERE FOR YOUR PROJECT DIRECTORIES- set these for your project
####################################################################
export PROJ_NAME=changeme
export SRC_WS=/path_to_src_workspace
export TGT_WS=/path_to_tartget_workspace
export DEPLOY_DIR=${PROJ_NAME}-deploy

export DEFAULT_HV=itl_hv
export DEFAULT_BSP=itl_generic_2_0_2_1

export VSB_ROOTOS=${PROJ_NAME}-rootos-vsb
export VIP_ROOTOS=${PROJ_NAME}-rootos-vip
export VIP_ROOTOS_BSP=${DEFAULT_BSP}


export VSB_BOOTAPP=${PROJ_NAME}-bootapp-vsb
export VIP_BOOTAPP=${PROJ_NAME}-bootapp-vip
export VIP_BOOTAPP_BSP=${DEFAULT_BSP}

export VSB_GOS01=${PROJ_NAME}-gos-64bit-vsb
export VIP_GOS01=${PROJ_NAME}-gos-64bit-vip
export VIP_GOS01_BSP=${DEFAULT_BSP}

export MIP=${PROJ_NAME}-mip
export MOS_VIP_BSP=${DEFAULT_BSP}
###########
# END EDIT
###########



# create workspace directory
mkdir -p ${TGT_WS}

#########
# DEPLOY_DIR 
# Note: if you don't have a deploy directory in your source project, comment this part out
#########
echo ${DEPLOY_DIR}
# copy cc-conf directory
cp -Rf ${SRC_WS}/${DEPLOY_DIR}/ ${TGT_WS}/


#########
# VSB_ROOTOS
#########
echo ${VSB_ROOTOS}
# This is the rootOS so hypervisor is involved
mkdir -p ${TGT_WS}/${VSB_ROOTOS}

# copy cc-conf directory
cp -Rf ${SRC_WS}/${VSB_ROOTOS}/cc-conf ${TGT_WS}/${VSB_ROOTOS}

# copy baremetal directory
cp -Rf ${SRC_WS}/${VSB_ROOTOS}/baremetal ${TGT_WS}/${VSB_ROOTOS}

# copy h/config/auto.conf
mkdir -p ${TGT_WS}/${VSB_ROOTOS}/h/config
cp ${SRC_WS}/${VSB_ROOTOS}/h/config/auto.conf ${TGT_WS}/${VSB_ROOTOS}/h/config/auto.conf 

# copy other files in VSB directory
cp ${SRC_WS}/${VSB_ROOTOS}/.cproject ${TGT_WS}/${VSB_ROOTOS}/.cproject
cp ${SRC_WS}/${VSB_ROOTOS}/.project ${TGT_WS}/${VSB_ROOTOS}/.project
cp ${SRC_WS}/${VSB_ROOTOS}/vsb_bs.vxconfig ${TGT_WS}/${VSB_ROOTOS}/vsb_bs.vxconfig
cp ${SRC_WS}/${VSB_ROOTOS}/.wrproject ${TGT_WS}/${VSB_ROOTOS}/.wrproject
cp ${SRC_WS}/${VSB_ROOTOS}/vsb.config ${TGT_WS}/${VSB_ROOTOS}/vsb.config
cp ${SRC_WS}/${VSB_ROOTOS}/${VSB_ROOTOS}.wpj ${TGT_WS}/${VSB_ROOTOS}/${VSB_ROOTOS}.wpj

#########
# VIP_ROOTOS
#########
echo ${VIP_ROOTOS}
# This is the rootOS so hypervisor is involved

mkdir -p ${TGT_WS}/${VIP_ROOTOS}

# .settings/. **bsp_r_e_v**/. .cproject .gitignore .project .wr* recalc.tm 
# usr* vip.ld **project**.wpj vxWorks.makefile

# copy .settings directory
cp -Rf ${SRC_WS}/${VIP_ROOTOS}/.settings ${TGT_WS}/${VIP_ROOTOS}

# copy BSP dir
cp -Rf ${SRC_WS}/${VIP_ROOTOS}/${VIP_ROOTOS_BSP}/ ${TGT_WS}/${VIP_ROOTOS}/

# copy HV dir
cp -Rf ${SRC_WS}/${VIP_ROOTOS}/${DEFAULT_HV}/ ${TGT_WS}/${VIP_ROOTOS}/

# copy romfs files
#cp -Rf ${SRC_WS}/${VIP_ROOTOS}/default_romCompress ${TGT_WS}/${VIP_ROOTOS}/
#cp ${SRC_WS}/${VIP_ROOTOS}/content.romfs ${TGT_WS}/${VIP_ROOTOS}/content.romfs 


# copy other files in VIP directory
cp ${SRC_WS}/${VIP_ROOTOS}/.cproject ${TGT_WS}/${VIP_ROOTOS}/.cproject
cp ${SRC_WS}/${VIP_ROOTOS}/.gitignore ${TGT_WS}/${VIP_ROOTOS}/.gitignore
cp ${SRC_WS}/${VIP_ROOTOS}/.project ${TGT_WS}/${VIP_ROOTOS}/.project
cp ${SRC_WS}/${VIP_ROOTOS}/.wr* ${TGT_WS}/${VIP_ROOTOS}/
#cp ${SRC_WS}/${VIP_ROOTOS}/recalc.tm ${TGT_WS}/${VIP_ROOTOS}/recalc.tm
cp ${SRC_WS}/${VIP_ROOTOS}/*.c ${TGT_WS}/${VIP_ROOTOS}/
cp ${SRC_WS}/${VIP_ROOTOS}/*.h ${TGT_WS}/${VIP_ROOTOS}/
cp ${SRC_WS}/${VIP_ROOTOS}/${VIP_ROOTOS}.wpj ${TGT_WS}/${VIP_ROOTOS}/${VIP_ROOTOS}.wpj
cp ${SRC_WS}/${VIP_ROOTOS}/vxWorks.makefile ${TGT_WS}/${VIP_ROOTOS}/vxWorks.makefile

#########
# VSB_BOOTAPP
#########
echo ${VSB_BOOTAPP}

mkdir -p ${TGT_WS}/${VSB_BOOTAPP}
# copy cc-conf directory
cp -Rf ${SRC_WS}/${VSB_BOOTAPP}/cc-conf ${TGT_WS}/${VSB_BOOTAPP}

# copy h/config/auto.conf
mkdir -p ${TGT_WS}/${VSB_BOOTAPP}/h/config
cp ${SRC_WS}/${VSB_BOOTAPP}/h/config/auto.conf ${TGT_WS}/${VSB_BOOTAPP}/h/config/auto.conf 

# copy other files in VSB directory
cp ${SRC_WS}/${VSB_BOOTAPP}/.cproject ${TGT_WS}/${VSB_BOOTAPP}/.cproject
cp ${SRC_WS}/${VSB_BOOTAPP}/.project ${TGT_WS}/${VSB_BOOTAPP}/.project
cp ${SRC_WS}/${VSB_BOOTAPP}/vsb_bs.vxconfig ${TGT_WS}/${VSB_BOOTAPP}/vsb_bs.vxconfig
cp ${SRC_WS}/${VSB_BOOTAPP}/.wrproject ${TGT_WS}/${VSB_BOOTAPP}/.wrproject
cp ${SRC_WS}/${VSB_BOOTAPP}/vsb.config ${TGT_WS}/${VSB_BOOTAPP}/vsb.config
cp ${SRC_WS}/${VSB_BOOTAPP}/${VSB_BOOTAPP}.wpj ${TGT_WS}/${VSB_BOOTAPP}/${VSB_BOOTAPP}.wpj

#########
# VIP_BOOTAPP
#########
echo ${VIP_BOOTAPP}
mkdir -p ${TGT_WS}/${VIP_BOOTAPP}
# .settings/. **bsp_r_e_v**/. .cproject .gitignore .project .wr* recalc.tm 
# usr* vip.ld **project**.wpj vxWorks.makefile

# copy .settings directory
cp -Rf ${SRC_WS}/${VIP_BOOTAPP}/.settings ${TGT_WS}/${VIP_BOOTAPP}

# copy BSP dir
cp -Rf ${SRC_WS}/${VIP_BOOTAPP}/${VIP_BOOTAPP_BSP}/ ${TGT_WS}/${VIP_BOOTAPP}/

# copy romfs files
cp -Rf ${SRC_WS}/${VIP_BOOTAPP}/default_romCompress ${TGT_WS}/${VIP_BOOTAPP}/
cp ${SRC_WS}/${VIP_BOOTAPP}/content.romfs ${TGT_WS}/${VIP_BOOTAPP}/content.romfs 


# copy other files in VIP directory
cp ${SRC_WS}/${VIP_BOOTAPP}/.cproject ${TGT_WS}/${VIP_BOOTAPP}/.cproject
cp ${SRC_WS}/${VIP_BOOTAPP}/.gitignore ${TGT_WS}/${VIP_BOOTAPP}/.gitignore
cp ${SRC_WS}/${VIP_BOOTAPP}/.project ${TGT_WS}/${VIP_BOOTAPP}/.project
cp ${SRC_WS}/${VIP_BOOTAPP}/.wr* ${TGT_WS}/${VIP_BOOTAPP}/
cp ${SRC_WS}/${VIP_BOOTAPP}/recalc.tm ${TGT_WS}/${VIP_BOOTAPP}/recalc.tm
cp ${SRC_WS}/${VIP_BOOTAPP}/*.c ${TGT_WS}/${VIP_BOOTAPP}/
cp ${SRC_WS}/${VIP_BOOTAPP}/*.h ${TGT_WS}/${VIP_BOOTAPP}/
cp ${SRC_WS}/${VIP_BOOTAPP}/${VIP_BOOTAPP}.wpj ${TGT_WS}/${VIP_BOOTAPP}/${VIP_BOOTAPP}.wpj
cp ${SRC_WS}/${VIP_BOOTAPP}/vxWorks.makefile ${TGT_WS}/${VIP_BOOTAPP}/vxWorks.makefile

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


#########
# MIP
#########
echo ${MIP}
mkdir -p ${TGT_WS}/${MIP}
mkdir -p ${TGT_WS}/${MIP}/mos_vip

# copy .settings directory
cp -Rf ${SRC_WS}/${MIP}/.settings ${TGT_WS}/${MIP}

# copy XML directories
cp -Rf ${SRC_WS}/${MIP}/config653/ ${TGT_WS}/${MIP}/
cp -Rf ${SRC_WS}/${MIP}/hmActions/ ${TGT_WS}/${MIP}/

# copy extraRomfs files
cp -Rf ${SRC_WS}/${MIP}/extraRomfs ${TGT_WS}/${MIP}/

# copy other files in the MIP directory
cp ${SRC_WS}/${MIP}/.project  ${TGT_WS}/${MIP}
cp ${SRC_WS}/${MIP}/.wrproject  ${TGT_WS}/${MIP}
cp ${SRC_WS}/${MIP}/${MIP}.wpj  ${TGT_WS}/${MIP}
cp ${SRC_WS}/${MIP}/Makefile  ${TGT_WS}/${MIP}

# replace the absolute path from the wpj file with the $(PRJ_DIR) workbench variable
sed -i s#${SRC_WS}#'$(PRJ_DIR)'#g ${TGT_WS}/${MIP}/${MIP}.wpj

# The _defs.mos.mk file has an embedded path that must be changed for your final build location.
echo NOTE: You must edit the file ${MIP}/_defs.mos.mk and replace 'CHANGEME' with the Project Directory Path
echo __MOS_LOCATION = CHANGEME/${VIP_ROOTOS} > ${TGT_WS}/${MIP}/_defs.mos.mk
echo __MOS_VSB_LOCATION = CHANGEME/${VSB_ROOTOS} >> ${TGT_WS}/${MIP}/_defs.mos.mk
echo __MOS_BSP_LOCATION = CHANGEME/${VIP_ROOTOS}/${VIP_ROOTOS_BSP} >> ${TGT_WS}/${MIP}/_defs.mos.mk




