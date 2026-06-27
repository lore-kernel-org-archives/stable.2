Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766F03A6F1C;
	Sat, 27 Jun 2026 10:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782555725; cv=none; b=UYTYTjnFfA1HbSyvlss6dc1/+rCTeXFelZV9alKfLxGRHw3j1FK3INgNr/n/uTpMEYDENYf1JfEtE2Kbu+AHONGpi0eM9dYBRMQts5MRMKMjB95zWmZdoNfhZZFOm79PDjjR06WD/R0gO4bLjTau0sROmSfflpEWie17bDgSknU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782555725; c=relaxed/simple;
	bh=CrqL5zn7yI4MCRYIaLzw2lJUhaUoXewXoyUyshgOgcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/Pi+0/4KiqOUWSZKRr+v7EXCAg4d3KAuWZBB+kHQRADqBSy+VMWzfgJ/Ic9L8ktV05Ytd2YNdVLgzxUZrVCxwYNRljltNpRBozfFu9OyIbNOrrbOWww5aBS0nAeiE83eevgy87FF7ANmIa0AdyZ1Gb9PnlcFpUtozkjxvmJY7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PnBZ2HMP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PnBZ2HMP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967811F00A3A;
	Sat, 27 Jun 2026 10:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782555719;
	bh=Q899v03ZWXfCVkSxO59/VGpQ8Uz+6O2Ls/+ikiowuag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PnBZ2HMPuN0PU4nAoFVlJ70jrWu6cxqkEavk15dhCCus/aqa1L4WcxhixH/a1oW/V
	 z3kV5LIbRygzgJ7zZFXg2Q5tyFmYLXEGh4QY8DRu1YEychDobog3AUb2wryEQnFsTn
	 cuXyt7h32BvCQh2FooKm6pdXzEm0AeAve8JlNgN0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 7.1.2
Date: Sat, 27 Jun 2026 11:20:36 +0100
Message-ID: <2026062736-vagrancy-oversight-7052@gregkh>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026062736-truffle-storeroom-8dbb@gregkh>
References: <2026062736-truffle-storeroom-8dbb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index 331223761fff..29a08bc059dd 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -229,7 +229,6 @@ Code  Seq#    Include File                                             Comments
                                                                        <mailto:gregkh@linuxfoundation.org>
 'a'   all    linux/atm*.h, linux/sonet.h                               ATM on linux
                                                                        <http://lrcwww.epfl.ch/>
-'a'   00-0F  drivers/crypto/qat/qat_common/adf_cfg_common.h            conflict! qat driver
 'b'   00-FF                                                            conflict! bit3 vme host bridge
                                                                        <mailto:natalia@nikhefk.nikhef.nl>
 'b'   00-0F  linux/dma-buf.h                                           conflict!
diff --git a/Makefile b/Makefile
index 39baa3275447..78662694be58 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 7
 PATCHLEVEL = 1
-SUBLEVEL = 1
+SUBLEVEL = 2
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 6981b55d582a..843f85d3e3f9 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -807,7 +807,6 @@ static int add_memory_block(unsigned long block_id, int nid, unsigned long state
 	mem->start_section_nr = block_id * sections_per_block;
 	mem->state = state;
 	mem->nid = nid;
-	mem->altmap = altmap;
 	INIT_LIST_HEAD(&mem->group_next);
 
 #ifndef CONFIG_NUMA
@@ -825,6 +824,8 @@ static int add_memory_block(unsigned long block_id, int nid, unsigned long state
 	if (ret)
 		return ret;
 
+	mem->altmap = altmap;
+
 	if (group) {
 		mem->group = group;
 		list_add(&mem->group_next, &group->memory_blocks);
diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
index 2505df1f4e69..6741270e0a98 100644
--- a/drivers/char/agp/amd64-agp.c
+++ b/drivers/char/agp/amd64-agp.c
@@ -546,7 +546,7 @@ static int agp_amd64_probe(struct pci_dev *pdev,
 	/* Fill in the mode register */
 	pci_read_config_dword(pdev, bridge->capndx+PCI_AGP_STATUS, &bridge->mode);
 
-	if (cache_nbs(pdev, cap_ptr) == -1) {
+	if (cache_nbs(pdev, cap_ptr) < 0) {
 		agp_put_bridge(bridge);
 		return -ENODEV;
 	}
diff --git a/drivers/crypto/intel/qat/qat_common/adf_cfg.c b/drivers/crypto/intel/qat/qat_common/adf_cfg.c
index c202209f17d5..ea5d72d5090c 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_cfg.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_cfg.c
@@ -103,16 +103,6 @@ static void adf_cfg_section_del_all(struct list_head *head);
 static void adf_cfg_section_del_all_except(struct list_head *head,
 					   const char *section_name);
 
-void adf_cfg_del_all(struct adf_accel_dev *accel_dev)
-{
-	struct adf_cfg_device_data *dev_cfg_data = accel_dev->cfg;
-
-	down_write(&dev_cfg_data->lock);
-	adf_cfg_section_del_all(&dev_cfg_data->sec_list);
-	up_write(&dev_cfg_data->lock);
-	clear_bit(ADF_STATUS_CONFIGURED, &accel_dev->status);
-}
-
 void adf_cfg_del_all_except(struct adf_accel_dev *accel_dev,
 			    const char *section_name)
 {
diff --git a/drivers/crypto/intel/qat/qat_common/adf_cfg.h b/drivers/crypto/intel/qat/qat_common/adf_cfg.h
index 2afa6f0d15c5..108032b39242 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_cfg.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_cfg.h
@@ -34,7 +34,6 @@ void adf_cfg_dev_remove(struct adf_accel_dev *accel_dev);
 void adf_cfg_dev_dbgfs_add(struct adf_accel_dev *accel_dev);
 void adf_cfg_dev_dbgfs_rm(struct adf_accel_dev *accel_dev);
 int adf_cfg_section_add(struct adf_accel_dev *accel_dev, const char *name);
-void adf_cfg_del_all(struct adf_accel_dev *accel_dev);
 void adf_cfg_del_all_except(struct adf_accel_dev *accel_dev,
 			    const char *section_name);
 int adf_cfg_add_key_value_param(struct adf_accel_dev *accel_dev,
diff --git a/drivers/crypto/intel/qat/qat_common/adf_cfg_common.h b/drivers/crypto/intel/qat/qat_common/adf_cfg_common.h
index 81e9e9d7eccd..d63f4dcccbb5 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_cfg_common.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_cfg_common.h
@@ -4,18 +4,11 @@
 #define ADF_CFG_COMMON_H_
 
 #include <linux/types.h>
-#include <linux/ioctl.h>
 
 #define ADF_CFG_MAX_STR_LEN 64
 #define ADF_CFG_MAX_KEY_LEN_IN_BYTES ADF_CFG_MAX_STR_LEN
 #define ADF_CFG_MAX_VAL_LEN_IN_BYTES ADF_CFG_MAX_STR_LEN
 #define ADF_CFG_MAX_SECTION_LEN_IN_BYTES ADF_CFG_MAX_STR_LEN
-#define ADF_CFG_BASE_DEC 10
-#define ADF_CFG_BASE_HEX 16
-#define ADF_CFG_ALL_DEVICES 0xFE
-#define ADF_CFG_NO_DEVICE 0xFF
-#define ADF_CFG_AFFINITY_WHATEVER 0xFF
-#define MAX_DEVICE_NAME_SIZE 32
 #define ADF_MAX_DEVICES (32 * 32)
 #define ADF_DEVS_ARRAY_SIZE BITS_TO_LONGS(ADF_MAX_DEVICES)
 
@@ -51,29 +44,4 @@ enum adf_device_type {
 	DEV_420XX,
 	DEV_6XXX,
 };
-
-struct adf_dev_status_info {
-	enum adf_device_type type;
-	__u32 accel_id;
-	__u32 instance_id;
-	__u8 num_ae;
-	__u8 num_accel;
-	__u8 num_logical_accel;
-	__u8 banks_per_accel;
-	__u8 state;
-	__u8 bus;
-	__u8 dev;
-	__u8 fun;
-	char name[MAX_DEVICE_NAME_SIZE];
-};
-
-#define ADF_CTL_IOC_MAGIC 'a'
-#define IOCTL_CONFIG_SYS_RESOURCE_PARAMETERS _IOW(ADF_CTL_IOC_MAGIC, 0, \
-		struct adf_user_cfg_ctl_data)
-#define IOCTL_STOP_ACCEL_DEV _IOW(ADF_CTL_IOC_MAGIC, 1, \
-		struct adf_user_cfg_ctl_data)
-#define IOCTL_START_ACCEL_DEV _IOW(ADF_CTL_IOC_MAGIC, 2, \
-		struct adf_user_cfg_ctl_data)
-#define IOCTL_STATUS_ACCEL_DEV _IOW(ADF_CTL_IOC_MAGIC, 3, __u32)
-#define IOCTL_GET_NUM_DEVICES _IOW(ADF_CTL_IOC_MAGIC, 4, __s32)
 #endif
diff --git a/drivers/crypto/intel/qat/qat_common/adf_cfg_user.h b/drivers/crypto/intel/qat/qat_common/adf_cfg_user.h
deleted file mode 100644
index 421f4fb8b4dd..000000000000
--- a/drivers/crypto/intel/qat/qat_common/adf_cfg_user.h
+++ /dev/null
@@ -1,38 +0,0 @@
-/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0-only) */
-/* Copyright(c) 2014 - 2020 Intel Corporation */
-#ifndef ADF_CFG_USER_H_
-#define ADF_CFG_USER_H_
-
-#include "adf_cfg_common.h"
-#include "adf_cfg_strings.h"
-
-struct adf_user_cfg_key_val {
-	char key[ADF_CFG_MAX_KEY_LEN_IN_BYTES];
-	char val[ADF_CFG_MAX_VAL_LEN_IN_BYTES];
-	union {
-		struct adf_user_cfg_key_val *next;
-		__u64 padding3;
-	};
-	enum adf_cfg_val_type type;
-} __packed;
-
-struct adf_user_cfg_section {
-	char name[ADF_CFG_MAX_SECTION_LEN_IN_BYTES];
-	union {
-		struct adf_user_cfg_key_val *params;
-		__u64 padding1;
-	};
-	union {
-		struct adf_user_cfg_section *next;
-		__u64 padding3;
-	};
-} __packed;
-
-struct adf_user_cfg_ctl_data {
-	union {
-		struct adf_user_cfg_section *config_section;
-		__u64 padding;
-	};
-	__u8 device_id;
-} __packed;
-#endif
diff --git a/drivers/crypto/intel/qat/qat_common/adf_common_drv.h b/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
index 7b8b295ac459..8ff35dd840f3 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
+++ b/drivers/crypto/intel/qat/qat_common/adf_common_drv.h
@@ -68,10 +68,7 @@ int adf_devmgr_add_dev(struct adf_accel_dev *accel_dev,
 void adf_devmgr_rm_dev(struct adf_accel_dev *accel_dev,
 		       struct adf_accel_dev *pf);
 struct list_head *adf_devmgr_get_head(void);
-struct adf_accel_dev *adf_devmgr_get_dev_by_id(u32 id);
 struct adf_accel_dev *adf_devmgr_pci_to_accel_dev(struct pci_dev *pci_dev);
-int adf_devmgr_verify_id(u32 id);
-void adf_devmgr_get_num_dev(u32 *num);
 int adf_devmgr_in_reset(struct adf_accel_dev *accel_dev);
 int adf_dev_started(struct adf_accel_dev *accel_dev);
 int adf_dev_restarting_notify(struct adf_accel_dev *accel_dev);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c b/drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c
index c2e6f0cb7480..f01f2946de6e 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_ctl_drv.c
@@ -2,410 +2,13 @@
 /* Copyright(c) 2014 - 2020 Intel Corporation */
 
 #include <crypto/algapi.h>
+#include <linux/errno.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
-#include <linux/slab.h>
-#include <linux/fs.h>
-#include <linux/bitops.h>
-#include <linux/pci.h>
-#include <linux/cdev.h>
-#include <linux/uaccess.h>
 
-#include "adf_accel_devices.h"
 #include "adf_common_drv.h"
-#include "adf_cfg.h"
-#include "adf_cfg_common.h"
-#include "adf_cfg_user.h"
-
-#define ADF_CFG_MAX_SECTION 512
-#define ADF_CFG_MAX_KEY_VAL 256
-
-#define DEVICE_NAME "qat_adf_ctl"
-
-static DEFINE_MUTEX(adf_ctl_lock);
-static long adf_ctl_ioctl(struct file *fp, unsigned int cmd, unsigned long arg);
-
-static const struct file_operations adf_ctl_ops = {
-	.owner = THIS_MODULE,
-	.unlocked_ioctl = adf_ctl_ioctl,
-	.compat_ioctl = compat_ptr_ioctl,
-};
-
-static const struct class adf_ctl_class = {
-	.name = DEVICE_NAME,
-};
-
-struct adf_ctl_drv_info {
-	unsigned int major;
-	struct cdev drv_cdev;
-};
-
-static struct adf_ctl_drv_info adf_ctl_drv;
-
-static void adf_chr_drv_destroy(void)
-{
-	device_destroy(&adf_ctl_class, MKDEV(adf_ctl_drv.major, 0));
-	cdev_del(&adf_ctl_drv.drv_cdev);
-	class_unregister(&adf_ctl_class);
-	unregister_chrdev_region(MKDEV(adf_ctl_drv.major, 0), 1);
-}
-
-static int adf_chr_drv_create(void)
-{
-	dev_t dev_id;
-	struct device *drv_device;
-	int ret;
-
-	if (alloc_chrdev_region(&dev_id, 0, 1, DEVICE_NAME)) {
-		pr_err("QAT: unable to allocate chrdev region\n");
-		return -EFAULT;
-	}
-
-	ret = class_register(&adf_ctl_class);
-	if (ret)
-		goto err_chrdev_unreg;
-
-	adf_ctl_drv.major = MAJOR(dev_id);
-	cdev_init(&adf_ctl_drv.drv_cdev, &adf_ctl_ops);
-	if (cdev_add(&adf_ctl_drv.drv_cdev, dev_id, 1)) {
-		pr_err("QAT: cdev add failed\n");
-		goto err_class_destr;
-	}
-
-	drv_device = device_create(&adf_ctl_class, NULL,
-				   MKDEV(adf_ctl_drv.major, 0),
-				   NULL, DEVICE_NAME);
-	if (IS_ERR(drv_device)) {
-		pr_err("QAT: failed to create device\n");
-		goto err_cdev_del;
-	}
-	return 0;
-err_cdev_del:
-	cdev_del(&adf_ctl_drv.drv_cdev);
-err_class_destr:
-	class_unregister(&adf_ctl_class);
-err_chrdev_unreg:
-	unregister_chrdev_region(dev_id, 1);
-	return -EFAULT;
-}
-
-static struct adf_user_cfg_ctl_data *adf_ctl_alloc_resources(unsigned long arg)
-{
-	struct adf_user_cfg_ctl_data *cfg_data;
-
-	cfg_data = memdup_user((void __user *)arg, sizeof(*cfg_data));
-	if (IS_ERR(cfg_data))
-		pr_err("QAT: failed to copy from user cfg_data.\n");
-	return cfg_data;
-}
-
-static int adf_add_key_value_data(struct adf_accel_dev *accel_dev,
-				  const char *section,
-				  const struct adf_user_cfg_key_val *key_val)
-{
-	if (key_val->type == ADF_HEX) {
-		long *ptr = (long *)key_val->val;
-		long val = *ptr;
-
-		if (adf_cfg_add_key_value_param(accel_dev, section,
-						key_val->key, (void *)val,
-						key_val->type)) {
-			dev_err(&GET_DEV(accel_dev),
-				"failed to add hex keyvalue.\n");
-			return -EFAULT;
-		}
-	} else {
-		if (adf_cfg_add_key_value_param(accel_dev, section,
-						key_val->key, key_val->val,
-						key_val->type)) {
-			dev_err(&GET_DEV(accel_dev),
-				"failed to add keyvalue.\n");
-			return -EFAULT;
-		}
-	}
-	return 0;
-}
-
-static int adf_copy_key_value_data(struct adf_accel_dev *accel_dev,
-				   struct adf_user_cfg_ctl_data *ctl_data)
-{
-	struct adf_user_cfg_key_val key_val;
-	struct adf_user_cfg_key_val *params_head;
-	struct adf_user_cfg_section section, *section_head;
-	int i, j;
-
-	section_head = ctl_data->config_section;
-
-	for (i = 0; section_head && i < ADF_CFG_MAX_SECTION; i++) {
-		if (copy_from_user(&section, (void __user *)section_head,
-				   sizeof(*section_head))) {
-			dev_err(&GET_DEV(accel_dev),
-				"failed to copy section info\n");
-			goto out_err;
-		}
-
-		if (adf_cfg_section_add(accel_dev, section.name)) {
-			dev_err(&GET_DEV(accel_dev),
-				"failed to add section.\n");
-			goto out_err;
-		}
-
-		params_head = section.params;
-
-		for (j = 0; params_head && j < ADF_CFG_MAX_KEY_VAL; j++) {
-			if (copy_from_user(&key_val, (void __user *)params_head,
-					   sizeof(key_val))) {
-				dev_err(&GET_DEV(accel_dev),
-					"Failed to copy keyvalue.\n");
-				goto out_err;
-			}
-			if (adf_add_key_value_data(accel_dev, section.name,
-						   &key_val)) {
-				goto out_err;
-			}
-			params_head = key_val.next;
-		}
-		section_head = section.next;
-	}
-	return 0;
-out_err:
-	adf_cfg_del_all(accel_dev);
-	return -EFAULT;
-}
-
-static int adf_ctl_ioctl_dev_config(struct file *fp, unsigned int cmd,
-				    unsigned long arg)
-{
-	struct adf_user_cfg_ctl_data *ctl_data;
-	struct adf_accel_dev *accel_dev;
-	int ret = 0;
-
-	ctl_data = adf_ctl_alloc_resources(arg);
-	if (IS_ERR(ctl_data))
-		return PTR_ERR(ctl_data);
-
-	accel_dev = adf_devmgr_get_dev_by_id(ctl_data->device_id);
-	if (!accel_dev) {
-		ret = -EFAULT;
-		goto out;
-	}
-
-	if (adf_dev_started(accel_dev)) {
-		ret = -EFAULT;
-		goto out;
-	}
-
-	if (adf_copy_key_value_data(accel_dev, ctl_data)) {
-		ret = -EFAULT;
-		goto out;
-	}
-	set_bit(ADF_STATUS_CONFIGURED, &accel_dev->status);
-out:
-	kfree(ctl_data);
-	return ret;
-}
-
-static int adf_ctl_is_device_in_use(int id)
-{
-	struct adf_accel_dev *dev;
-
-	list_for_each_entry(dev, adf_devmgr_get_head(), list) {
-		if (id == dev->accel_id || id == ADF_CFG_ALL_DEVICES) {
-			if (adf_devmgr_in_reset(dev) || adf_dev_in_use(dev)) {
-				dev_info(&GET_DEV(dev),
-					 "device qat_dev%d is busy\n",
-					 dev->accel_id);
-				return -EBUSY;
-			}
-		}
-	}
-	return 0;
-}
-
-static void adf_ctl_stop_devices(u32 id)
-{
-	struct adf_accel_dev *accel_dev;
-
-	list_for_each_entry(accel_dev, adf_devmgr_get_head(), list) {
-		if (id == accel_dev->accel_id || id == ADF_CFG_ALL_DEVICES) {
-			if (!adf_dev_started(accel_dev))
-				continue;
-
-			/* First stop all VFs */
-			if (!accel_dev->is_vf)
-				continue;
-
-			adf_dev_down(accel_dev);
-		}
-	}
-
-	list_for_each_entry(accel_dev, adf_devmgr_get_head(), list) {
-		if (id == accel_dev->accel_id || id == ADF_CFG_ALL_DEVICES) {
-			if (!adf_dev_started(accel_dev))
-				continue;
-
-			adf_dev_down(accel_dev);
-		}
-	}
-}
-
-static int adf_ctl_ioctl_dev_stop(struct file *fp, unsigned int cmd,
-				  unsigned long arg)
-{
-	int ret;
-	struct adf_user_cfg_ctl_data *ctl_data;
-
-	ctl_data = adf_ctl_alloc_resources(arg);
-	if (IS_ERR(ctl_data))
-		return PTR_ERR(ctl_data);
-
-	if (adf_devmgr_verify_id(ctl_data->device_id)) {
-		pr_err("QAT: Device %d not found\n", ctl_data->device_id);
-		ret = -ENODEV;
-		goto out;
-	}
-
-	ret = adf_ctl_is_device_in_use(ctl_data->device_id);
-	if (ret)
-		goto out;
-
-	if (ctl_data->device_id == ADF_CFG_ALL_DEVICES)
-		pr_info("QAT: Stopping all acceleration devices.\n");
-	else
-		pr_info("QAT: Stopping acceleration device qat_dev%d.\n",
-			ctl_data->device_id);
-
-	adf_ctl_stop_devices(ctl_data->device_id);
-
-out:
-	kfree(ctl_data);
-	return ret;
-}
-
-static int adf_ctl_ioctl_dev_start(struct file *fp, unsigned int cmd,
-				   unsigned long arg)
-{
-	int ret;
-	struct adf_user_cfg_ctl_data *ctl_data;
-	struct adf_accel_dev *accel_dev;
-
-	ctl_data = adf_ctl_alloc_resources(arg);
-	if (IS_ERR(ctl_data))
-		return PTR_ERR(ctl_data);
-
-	ret = -ENODEV;
-	accel_dev = adf_devmgr_get_dev_by_id(ctl_data->device_id);
-	if (!accel_dev)
-		goto out;
-
-	dev_info(&GET_DEV(accel_dev),
-		 "Starting acceleration device qat_dev%d.\n",
-		 ctl_data->device_id);
-
-	ret = adf_dev_up(accel_dev, false);
-
-	if (ret) {
-		dev_err(&GET_DEV(accel_dev), "Failed to start qat_dev%d\n",
-			ctl_data->device_id);
-		adf_dev_down(accel_dev);
-	}
-out:
-	kfree(ctl_data);
-	return ret;
-}
-
-static int adf_ctl_ioctl_get_num_devices(struct file *fp, unsigned int cmd,
-					 unsigned long arg)
-{
-	u32 num_devices = 0;
-
-	adf_devmgr_get_num_dev(&num_devices);
-	if (copy_to_user((void __user *)arg, &num_devices, sizeof(num_devices)))
-		return -EFAULT;
-
-	return 0;
-}
-
-static int adf_ctl_ioctl_get_status(struct file *fp, unsigned int cmd,
-				    unsigned long arg)
-{
-	struct adf_hw_device_data *hw_data;
-	struct adf_dev_status_info dev_info;
-	struct adf_accel_dev *accel_dev;
-
-	if (copy_from_user(&dev_info, (void __user *)arg,
-			   sizeof(struct adf_dev_status_info))) {
-		pr_err("QAT: failed to copy from user.\n");
-		return -EFAULT;
-	}
-
-	accel_dev = adf_devmgr_get_dev_by_id(dev_info.accel_id);
-	if (!accel_dev)
-		return -ENODEV;
-
-	hw_data = accel_dev->hw_device;
-	dev_info.state = adf_dev_started(accel_dev) ? DEV_UP : DEV_DOWN;
-	dev_info.num_ae = hw_data->get_num_aes(hw_data);
-	dev_info.num_accel = hw_data->get_num_accels(hw_data);
-	dev_info.num_logical_accel = hw_data->num_logical_accel;
-	dev_info.banks_per_accel = hw_data->num_banks
-					/ hw_data->num_logical_accel;
-	strscpy(dev_info.name, hw_data->dev_class->name, sizeof(dev_info.name));
-	dev_info.instance_id = hw_data->instance_id;
-	dev_info.type = hw_data->dev_class->type;
-	dev_info.bus = accel_to_pci_dev(accel_dev)->bus->number;
-	dev_info.dev = PCI_SLOT(accel_to_pci_dev(accel_dev)->devfn);
-	dev_info.fun = PCI_FUNC(accel_to_pci_dev(accel_dev)->devfn);
-
-	if (copy_to_user((void __user *)arg, &dev_info,
-			 sizeof(struct adf_dev_status_info))) {
-		dev_err(&GET_DEV(accel_dev), "failed to copy status.\n");
-		return -EFAULT;
-	}
-	return 0;
-}
-
-static long adf_ctl_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
-{
-	int ret;
-
-	if (mutex_lock_interruptible(&adf_ctl_lock))
-		return -EFAULT;
-
-	switch (cmd) {
-	case IOCTL_CONFIG_SYS_RESOURCE_PARAMETERS:
-		ret = adf_ctl_ioctl_dev_config(fp, cmd, arg);
-		break;
-
-	case IOCTL_STOP_ACCEL_DEV:
-		ret = adf_ctl_ioctl_dev_stop(fp, cmd, arg);
-		break;
-
-	case IOCTL_START_ACCEL_DEV:
-		ret = adf_ctl_ioctl_dev_start(fp, cmd, arg);
-		break;
-
-	case IOCTL_GET_NUM_DEVICES:
-		ret = adf_ctl_ioctl_get_num_devices(fp, cmd, arg);
-		break;
-
-	case IOCTL_STATUS_ACCEL_DEV:
-		ret = adf_ctl_ioctl_get_status(fp, cmd, arg);
-		break;
-	default:
-		pr_err_ratelimited("QAT: Invalid ioctl %d\n", cmd);
-		ret = -EFAULT;
-		break;
-	}
-	mutex_unlock(&adf_ctl_lock);
-	return ret;
-}
 
 static int __init adf_register_ctl_device_driver(void)
 {
-	if (adf_chr_drv_create())
-		goto err_chr_dev;
-
 	if (adf_init_misc_wq())
 		goto err_misc_wq;
 
@@ -437,15 +40,11 @@ static int __init adf_register_ctl_device_driver(void)
 err_aer:
 	adf_exit_misc_wq();
 err_misc_wq:
-	adf_chr_drv_destroy();
-err_chr_dev:
-	mutex_destroy(&adf_ctl_lock);
 	return -EFAULT;
 }
 
 static void __exit adf_unregister_ctl_device_driver(void)
 {
-	adf_chr_drv_destroy();
 	adf_exit_misc_wq();
 	adf_exit_aer();
 	adf_exit_vf_wq();
@@ -453,7 +52,6 @@ static void __exit adf_unregister_ctl_device_driver(void)
 	qat_crypto_unregister();
 	qat_compression_unregister();
 	adf_clean_vf_map(false);
-	mutex_destroy(&adf_ctl_lock);
 }
 
 module_init(adf_register_ctl_device_driver);
diff --git a/drivers/crypto/intel/qat/qat_common/adf_dev_mgr.c b/drivers/crypto/intel/qat/qat_common/adf_dev_mgr.c
index e050de16ab5d..161863841a52 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_dev_mgr.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_dev_mgr.c
@@ -45,19 +45,6 @@ static struct vf_id_map *adf_find_vf(u32 bdf)
 	return NULL;
 }
 
-static int adf_get_vf_real_id(u32 fake)
-{
-	struct list_head *itr;
-
-	list_for_each(itr, &vfs_table) {
-		struct vf_id_map *ptr =
-			list_entry(itr, struct vf_id_map, list);
-		if (ptr->fake_id == fake)
-			return ptr->id;
-	}
-	return -1;
-}
-
 /**
  * adf_clean_vf_map() - Cleans VF id mappings
  * @vf: flag indicating whether mappings is cleaned
@@ -304,63 +291,6 @@ struct adf_accel_dev *adf_devmgr_pci_to_accel_dev(struct pci_dev *pci_dev)
 }
 EXPORT_SYMBOL_GPL(adf_devmgr_pci_to_accel_dev);
 
-struct adf_accel_dev *adf_devmgr_get_dev_by_id(u32 id)
-{
-	struct list_head *itr;
-	int real_id;
-
-	mutex_lock(&table_lock);
-	real_id = adf_get_vf_real_id(id);
-	if (real_id < 0)
-		goto unlock;
-
-	id = real_id;
-
-	list_for_each(itr, &accel_table) {
-		struct adf_accel_dev *ptr =
-				list_entry(itr, struct adf_accel_dev, list);
-		if (ptr->accel_id == id) {
-			mutex_unlock(&table_lock);
-			return ptr;
-		}
-	}
-unlock:
-	mutex_unlock(&table_lock);
-	return NULL;
-}
-
-int adf_devmgr_verify_id(u32 id)
-{
-	if (id == ADF_CFG_ALL_DEVICES)
-		return 0;
-
-	if (adf_devmgr_get_dev_by_id(id))
-		return 0;
-
-	return -ENODEV;
-}
-
-static int adf_get_num_dettached_vfs(void)
-{
-	struct list_head *itr;
-	int vfs = 0;
-
-	mutex_lock(&table_lock);
-	list_for_each(itr, &vfs_table) {
-		struct vf_id_map *ptr =
-			list_entry(itr, struct vf_id_map, list);
-		if (ptr->bdf != ~0 && !ptr->attached)
-			vfs++;
-	}
-	mutex_unlock(&table_lock);
-	return vfs;
-}
-
-void adf_devmgr_get_num_dev(u32 *num)
-{
-	*num = num_devices - adf_get_num_dettached_vfs();
-}
-
 /**
  * adf_dev_in_use() - Check whether accel_dev is currently in use
  * @accel_dev: Pointer to acceleration device.
diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
index ae30b47e4514..731792f06993 100644
--- a/drivers/iio/adc/ti-ads1298.c
+++ b/drivers/iio/adc/ti-ads1298.c
@@ -279,6 +279,7 @@ static const u8 ads1298_pga_settings[] = { 6, 1, 2, 3, 4, 8, 12 };
 static int ads1298_get_scale(struct ads1298_private *priv,
 			     int channel, int *val, int *val2)
 {
+	unsigned int pga_idx;
 	int ret;
 	unsigned int regval;
 	u8 gain;
@@ -302,7 +303,11 @@ static int ads1298_get_scale(struct ads1298_private *priv,
 	if (ret)
 		return ret;
 
-	gain = ads1298_pga_settings[FIELD_GET(ADS1298_MASK_CH_PGA, regval)];
+	pga_idx = FIELD_GET(ADS1298_MASK_CH_PGA, regval);
+	if (pga_idx >= ARRAY_SIZE(ads1298_pga_settings))
+		return -EINVAL;
+
+	gain = ads1298_pga_settings[pga_idx];
 	*val /= gain; /* Full scale is VREF / gain */
 
 	*val2 = ADS1298_BITS_PER_SAMPLE - 1; /* Signed, hence the -1 */
diff --git a/drivers/iio/light/veml6075.c b/drivers/iio/light/veml6075.c
index edbb43407054..f7eb159e5cb4 100644
--- a/drivers/iio/light/veml6075.c
+++ b/drivers/iio/light/veml6075.c
@@ -100,7 +100,7 @@ static const struct iio_chan_spec veml6075_channels[] = {
 
 static int veml6075_request_measurement(struct veml6075_data *data)
 {
-	int ret, conf, int_time;
+	int ret, conf, int_time, int_index;
 
 	ret = regmap_read(data->regmap, VEML6075_CMD_CONF, &conf);
 	if (ret < 0)
@@ -117,7 +117,11 @@ static int veml6075_request_measurement(struct veml6075_data *data)
 	 * time for all possible configurations. Using a 1.50 factor simplifies
 	 * operations and ensures reliability under all circumstances.
 	 */
-	int_time = veml6075_it_ms[FIELD_GET(VEML6075_CONF_IT, conf)];
+	int_index = FIELD_GET(VEML6075_CONF_IT, conf);
+	if (int_index >= ARRAY_SIZE(veml6075_it_ms))
+		return -EINVAL;
+
+	int_time = veml6075_it_ms[int_index];
 	msleep(int_time + (int_time / 2));
 
 	/* shutdown again, data registers are still accessible */
diff --git a/drivers/media/test-drivers/vidtv/vidtv_mux.c b/drivers/media/test-drivers/vidtv/vidtv_mux.c
index f0134e38a1fb..ea2ea53102f9 100644
--- a/drivers/media/test-drivers/vidtv/vidtv_mux.c
+++ b/drivers/media/test-drivers/vidtv/vidtv_mux.c
@@ -101,7 +101,8 @@ static int vidtv_mux_pid_ctx_init(struct vidtv_mux *m)
 	/* add a ctx for all PMT sections */
 	while (p) {
 		pid = vidtv_psi_get_pat_program_pid(p);
-		vidtv_mux_create_pid_ctx_once(m, pid);
+		if (!vidtv_mux_create_pid_ctx_once(m, pid))
+			goto free;
 		p = p->next;
 	}
 
@@ -170,6 +171,9 @@ static u32 vidtv_mux_push_si(struct vidtv_mux *m)
 	nit_ctx = vidtv_mux_get_pid_ctx(m, VIDTV_NIT_PID);
 	eit_ctx = vidtv_mux_get_pid_ctx(m, VIDTV_EIT_PID);
 
+	if (!pat_ctx || !sdt_ctx || !nit_ctx || !eit_ctx)
+		return 0;
+
 	pat_args.offset             = m->mux_buf_offset;
 	pat_args.continuity_counter = &pat_ctx->cc;
 
@@ -186,6 +190,8 @@ static u32 vidtv_mux_push_si(struct vidtv_mux *m)
 		}
 
 		pmt_ctx = vidtv_mux_get_pid_ctx(m, pmt_pid);
+		if (!pmt_ctx)
+			continue;
 
 		pmt_args.offset             = m->mux_buf_offset;
 		pmt_args.pmt                = m->si.pmt_secs[i];
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 2af0c4d0ad82..035b46e13666 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -850,8 +850,10 @@ static int dw8250_probe(struct platform_device *pdev)
 	 */
 	if (data->clk) {
 		err = clk_notifier_register(data->clk, &data->clk_notifier);
-		if (err)
+		if (err) {
+			serial8250_unregister_port(data->data.line);
 			return dev_err_probe(dev, err, "Failed to set the clock notifier\n");
+		}
 		queue_work(system_dfl_wq, &data->clk_work);
 	}
 
diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 17da115b1e78..3b0f836a9822 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -905,12 +905,9 @@ static void qcom_geni_serial_handle_rx_dma(struct uart_port *uport, bool drop)
 	port->rx_dma_addr = 0;
 
 	rx_in = readl(uport->membase + SE_DMA_RX_LEN_IN);
-	if (!rx_in) {
-		dev_warn(uport->dev, "serial engine reports 0 RX bytes in!\n");
-		return;
-	}
-
-	if (!drop)
+	if (!rx_in)
+		dev_warn_ratelimited(uport->dev, "serial engine reports 0 RX bytes in!\n");
+	else if (!drop)
 		handle_rx_uart(uport, rx_in);
 
 	ret = geni_se_rx_dma_prep(&port->se, port->rx_buf,
diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
index 4d2d46c95fef..7d40eacc21b3 100644
--- a/drivers/tty/vt/vc_screen.c
+++ b/drivers/tty/vt/vc_screen.c
@@ -686,7 +686,7 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 	}
 	*ppos += written;
 	ret = written;
-	if (written)
+	if (written && vc)
 		vcs_scr_updated(vc);
 
 	return ret;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index c105aaf9ff5d..71f9fcefc0eb 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1037,6 +1037,10 @@ static int fuse_try_move_folio(struct fuse_copy_state *cs, struct folio **foliop
 	if (WARN_ON(folio_test_mlocked(oldfolio)))
 		goto out_fallback_unlock;
 
+	err = lock_request(cs->req);
+	if (err)
+		goto out_fallback_unlock;
+
 	replace_page_cache_folio(oldfolio, newfolio);
 
 	folio_get(newfolio);
@@ -1050,20 +1054,7 @@ static int fuse_try_move_folio(struct fuse_copy_state *cs, struct folio **foliop
 	 */
 	pipe_buf_release(cs->pipe, buf);
 
-	err = 0;
-	spin_lock(&cs->req->waitq.lock);
-	if (test_bit(FR_ABORTED, &cs->req->flags))
-		err = -ENOENT;
-	else
-		*foliop = newfolio;
-	spin_unlock(&cs->req->waitq.lock);
-
-	if (err) {
-		folio_unlock(newfolio);
-		folio_put(newfolio);
-		goto out_put_old;
-	}
-
+	*foliop = newfolio;
 	folio_unlock(oldfolio);
 	/* Drop ref for ap->pages[] array */
 	folio_put(oldfolio);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f94f3dc082c6..b31d0dffaf4c 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -380,8 +380,14 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 	 * aio and closes the fd before the aio completes.  Since aio takes its
 	 * own ref to the file, the IO completion has to drop the ref, which is
 	 * how the fuse server can end up closing its clients' files.
+	 *
+	 * Exception is virtio-fs, which is not affected by the above (server is
+	 * on host, cannot close open files in guest).  Virtio-fs needs sync
+	 * release, because the num_waiting mechanism to wait for all requests
+	 * before commencing with fs shutdown doesn't work if submounts are
+	 * used.
 	 */
-	fuse_file_put(ff, false);
+	fuse_file_put(ff, ff->fm->fc->auto_submounts);
 }
 
 void fuse_release_common(struct file *file, bool isdir)
diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 665153f1720e..0baa58d1dbfc 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -36,30 +36,19 @@
  * second map contains a reference to the entry in the first map.
  */
 
-static struct workqueue_struct *nfsd_export_wq;
-
 #define	EXPKEY_HASHBITS		8
 #define	EXPKEY_HASHMAX		(1 << EXPKEY_HASHBITS)
 #define	EXPKEY_HASHMASK		(EXPKEY_HASHMAX -1)
 
-static void expkey_release(struct work_struct *work)
+static void expkey_put(struct kref *ref)
 {
-	struct svc_expkey *key = container_of(to_rcu_work(work),
-					      struct svc_expkey, ek_rwork);
+	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
 
 	if (test_bit(CACHE_VALID, &key->h.flags) &&
 	    !test_bit(CACHE_NEGATIVE, &key->h.flags))
 		path_put(&key->ek_path);
 	auth_domain_put(key->ek_client);
-	kfree(key);
-}
-
-static void expkey_put(struct kref *ref)
-{
-	struct svc_expkey *key = container_of(ref, struct svc_expkey, h.ref);
-
-	INIT_RCU_WORK(&key->ek_rwork, expkey_release);
-	queue_rcu_work(nfsd_export_wq, &key->ek_rwork);
+	kfree_rcu(key, ek_rcu);
 }
 
 static int expkey_upcall(struct cache_detail *cd, struct cache_head *h)
@@ -364,13 +353,11 @@ static void export_stats_destroy(struct export_stats *stats)
 					    EXP_STATS_COUNTERS_NUM);
 }
 
-static void svc_export_release(struct work_struct *work)
+static void svc_export_release(struct rcu_head *rcu_head)
 {
-	struct svc_export *exp = container_of(to_rcu_work(work),
-					      struct svc_export, ex_rwork);
+	struct svc_export *exp = container_of(rcu_head, struct svc_export,
+			ex_rcu);
 
-	path_put(&exp->ex_path);
-	auth_domain_put(exp->ex_client);
 	nfsd4_fslocs_free(&exp->ex_fslocs);
 	export_stats_destroy(exp->ex_stats);
 	kfree(exp->ex_stats);
@@ -382,8 +369,9 @@ static void svc_export_put(struct kref *ref)
 {
 	struct svc_export *exp = container_of(ref, struct svc_export, h.ref);
 
-	INIT_RCU_WORK(&exp->ex_rwork, svc_export_release);
-	queue_rcu_work(nfsd_export_wq, &exp->ex_rwork);
+	path_put(&exp->ex_path);
+	auth_domain_put(exp->ex_client);
+	call_rcu(&exp->ex_rcu, svc_export_release);
 }
 
 static int svc_export_upcall(struct cache_detail *cd, struct cache_head *h)
@@ -1492,36 +1480,6 @@ const struct seq_operations nfs_exports_op = {
 	.show	= e_show,
 };
 
-/**
- * nfsd_export_wq_init - allocate the export release workqueue
- *
- * Called once at module load. The workqueue runs deferred svc_export and
- * svc_expkey release work scheduled by queue_rcu_work() in the cache put
- * callbacks.
- *
- * Return values:
- *   %0: workqueue allocated
- *   %-ENOMEM: allocation failed
- */
-int nfsd_export_wq_init(void)
-{
-	nfsd_export_wq = alloc_workqueue("nfsd_export", WQ_UNBOUND, 0);
-	if (!nfsd_export_wq)
-		return -ENOMEM;
-	return 0;
-}
-
-/**
- * nfsd_export_wq_shutdown - drain and free the export release workqueue
- *
- * Called once at module unload. Per-namespace teardown in
- * nfsd_export_shutdown() has already drained all deferred work.
- */
-void nfsd_export_wq_shutdown(void)
-{
-	destroy_workqueue(nfsd_export_wq);
-}
-
 /*
  * Initialize the exports module.
  */
@@ -1583,9 +1541,6 @@ nfsd_export_shutdown(struct net *net)
 
 	cache_unregister_net(nn->svc_expkey_cache, net);
 	cache_unregister_net(nn->svc_export_cache, net);
-	/* Drain deferred export and expkey release work. */
-	rcu_barrier();
-	flush_workqueue(nfsd_export_wq);
 	cache_destroy_net(nn->svc_expkey_cache, net);
 	cache_destroy_net(nn->svc_export_cache, net);
 	svcauth_unix_purge(net);
diff --git a/fs/nfsd/export.h b/fs/nfsd/export.h
index b05399374574..d2b09cd76145 100644
--- a/fs/nfsd/export.h
+++ b/fs/nfsd/export.h
@@ -7,7 +7,6 @@
 
 #include <linux/sunrpc/cache.h>
 #include <linux/percpu_counter.h>
-#include <linux/workqueue.h>
 #include <uapi/linux/nfsd/export.h>
 #include <linux/nfs4.h>
 
@@ -76,7 +75,7 @@ struct svc_export {
 	u32			ex_layout_types;
 	struct nfsd4_deviceid_map *ex_devid_map;
 	struct cache_detail	*cd;
-	struct rcu_work		ex_rwork;
+	struct rcu_head		ex_rcu;
 	unsigned long		ex_xprtsec_modes;
 	struct export_stats	*ex_stats;
 };
@@ -93,7 +92,7 @@ struct svc_expkey {
 	u32			ek_fsid[6];
 
 	struct path		ek_path;
-	struct rcu_work		ek_rwork;
+	struct rcu_head		ek_rcu;
 };
 
 #define EX_ISSYNC(exp)		(!((exp)->ex_flags & NFSEXP_ASYNC))
@@ -111,8 +110,6 @@ __be32 check_nfsd_access(struct svc_export *exp, struct svc_rqst *rqstp,
 /*
  * Function declarations
  */
-int			nfsd_export_wq_init(void);
-void			nfsd_export_wq_shutdown(void);
 int			nfsd_export_init(struct net *);
 void			nfsd_export_shutdown(struct net *);
 void			nfsd_export_flush(struct net *);
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 04e3954d54bd..7cb8f9506745 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2320,12 +2320,9 @@ static int __init init_nfsd(void)
 	if (retval)
 		goto out_free_pnfs;
 	nfsd_lockd_init();	/* lockd->nfsd callbacks */
-	retval = nfsd_export_wq_init();
-	if (retval)
-		goto out_free_lockd;
 	retval = register_pernet_subsys(&nfsd_net_ops);
 	if (retval < 0)
-		goto out_free_export_wq;
+		goto out_free_lockd;
 	retval = register_cld_notifier();
 	if (retval)
 		goto out_free_subsys;
@@ -2354,8 +2351,6 @@ static int __init init_nfsd(void)
 	unregister_cld_notifier();
 out_free_subsys:
 	unregister_pernet_subsys(&nfsd_net_ops);
-out_free_export_wq:
-	nfsd_export_wq_shutdown();
 out_free_lockd:
 	nfsd_lockd_shutdown();
 	nfsd_drc_slab_free();
@@ -2376,7 +2371,6 @@ static void __exit exit_nfsd(void)
 	nfsd4_destroy_laundry_wq();
 	unregister_cld_notifier();
 	unregister_pernet_subsys(&nfsd_net_ops);
-	nfsd_export_wq_shutdown();
 	nfsd_drc_slab_free();
 	nfsd_lockd_shutdown();
 	nfsd4_free_slabs();
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 3eb3b1711acb..95d0ea045cfb 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -613,6 +613,11 @@ int smb2_check_user_session(struct ksmbd_work *work)
 					sess_id, work->sess->id);
 			return -EINVAL;
 		}
+		if (work->sess->state != SMB2_SESSION_VALID) {
+			pr_err("compound request on a non-valid session (state %d)\n",
+					work->sess->state);
+			return -EINVAL;
+		}
 		return 1;
 	}
 
diff --git a/io_uring/net.c b/io_uring/net.c
index ee848eb65ec9..bf60cd393b11 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1733,7 +1733,7 @@ int io_socket(struct io_kiocb *req, unsigned int issue_flags)
 int io_connect_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_connect *conn = io_kiocb_to_cmd(req, struct io_connect);
-	struct io_async_msghdr *io;
+	struct sockaddr_storage *addr;
 
 	if (sqe->len || sqe->buf_index || sqe->rw_flags || sqe->splice_fd_in)
 		return -EINVAL;
@@ -1742,17 +1742,17 @@ int io_connect_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	conn->addr_len =  READ_ONCE(sqe->addr2);
 	conn->in_progress = conn->seen_econnaborted = false;
 
-	io = io_msg_alloc_async(req);
-	if (unlikely(!io))
+	addr = io_uring_alloc_async_data(NULL, req);
+	if (unlikely(!addr))
 		return -ENOMEM;
 
-	return move_addr_to_kernel(conn->addr, conn->addr_len, &io->addr);
+	return move_addr_to_kernel(conn->addr, conn->addr_len, addr);
 }
 
 int io_connect(struct io_kiocb *req, unsigned int issue_flags)
 {
 	struct io_connect *connect = io_kiocb_to_cmd(req, struct io_connect);
-	struct io_async_msghdr *io = req->async_data;
+	struct sockaddr_storage *addr = req->async_data;
 	unsigned file_flags;
 	int ret;
 	bool force_nonblock = issue_flags & IO_URING_F_NONBLOCK;
@@ -1766,8 +1766,7 @@ int io_connect(struct io_kiocb *req, unsigned int issue_flags)
 
 	file_flags = force_nonblock ? O_NONBLOCK : 0;
 
-	ret = __sys_connect_file(req->file, &io->addr, connect->addr_len,
-				 file_flags);
+	ret = __sys_connect_file(req->file, addr, connect->addr_len, file_flags);
 	if ((ret == -EAGAIN || ret == -EINPROGRESS || ret == -ECONNABORTED)
 	    && force_nonblock) {
 		if (ret == -EINPROGRESS) {
@@ -1796,7 +1795,6 @@ int io_connect(struct io_kiocb *req, unsigned int issue_flags)
 out:
 	if (ret < 0)
 		req_set_fail(req);
-	io_req_msg_cleanup(req, issue_flags);
 	io_req_set_res(req, ret, 0);
 	return IOU_COMPLETE;
 }
@@ -1806,15 +1804,15 @@ int io_connect(struct io_kiocb *req, unsigned int issue_flags)
  * which in turn end up in mnt_want_write() which will grab the fs
  * percpu start write sem. This can trigger a lockdep warning.
  */
-static int io_bind_file_create(const struct io_async_msghdr *io, int addr_len)
+static int io_bind_file_create(const struct sockaddr_storage *addr, int addr_len)
 {
 	const struct sockaddr_un *sun;
 
-	if (io->addr.ss_family != AF_UNIX)
+	if (addr->ss_family != AF_UNIX)
 		return 0;
 	if (addr_len <= offsetof(struct sockaddr_un, sun_path))
 		return 0;
-	sun = (const struct sockaddr_un *) &io->addr;
+	sun = (const struct sockaddr_un *) addr;
 	return sun->sun_path[0] != '\0';
 }
 
@@ -1822,7 +1820,7 @@ int io_bind_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_bind *bind = io_kiocb_to_cmd(req, struct io_bind);
 	struct sockaddr __user *uaddr;
-	struct io_async_msghdr *io;
+	struct sockaddr_storage *addr;
 	int ret;
 
 	if (sqe->len || sqe->buf_index || sqe->rw_flags || sqe->splice_fd_in)
@@ -1831,21 +1829,23 @@ int io_bind_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	uaddr = u64_to_user_ptr(READ_ONCE(sqe->addr));
 	bind->addr_len =  READ_ONCE(sqe->addr2);
 
-	io = io_msg_alloc_async(req);
-	if (unlikely(!io))
+	addr = io_uring_alloc_async_data(NULL, req);
+	if (unlikely(!addr))
 		return -ENOMEM;
-	ret = move_addr_to_kernel(uaddr, bind->addr_len, &io->addr);
+
+	ret = move_addr_to_kernel(uaddr, bind->addr_len, addr);
 	if (unlikely(ret))
 		return ret;
-	if (io_bind_file_create(io, bind->addr_len))
+	if (io_bind_file_create(addr, bind->addr_len))
 		req->flags |= REQ_F_FORCE_ASYNC;
 	return 0;
 }
 
+
 int io_bind(struct io_kiocb *req, unsigned int issue_flags)
 {
 	struct io_bind *bind = io_kiocb_to_cmd(req, struct io_bind);
-	struct io_async_msghdr *io = req->async_data;
+	struct sockaddr_storage *addr = req->async_data;
 	struct socket *sock;
 	int ret;
 
@@ -1853,7 +1853,7 @@ int io_bind(struct io_kiocb *req, unsigned int issue_flags)
 	if (unlikely(!sock))
 		return -ENOTSOCK;
 
-	ret = __sys_bind_socket(sock, &io->addr, bind->addr_len);
+	ret = __sys_bind_socket(sock, addr, bind->addr_len);
 	if (ret < 0)
 		req_set_fail(req);
 	io_req_set_res(req, ret, 0);
diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index c3ef52b70811..34cd320a427b 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -203,7 +203,7 @@ const struct io_issue_def io_issue_defs[] = {
 		.unbound_nonreg_file	= 1,
 		.pollout		= 1,
 #if defined(CONFIG_NET)
-		.async_size		= sizeof(struct io_async_msghdr),
+		.async_size		= sizeof(struct sockaddr_storage),
 		.prep			= io_connect_prep,
 		.issue			= io_connect,
 #else
@@ -503,7 +503,7 @@ const struct io_issue_def io_issue_defs[] = {
 		.needs_file		= 1,
 		.prep			= io_bind_prep,
 		.issue			= io_bind,
-		.async_size		= sizeof(struct io_async_msghdr),
+		.async_size		= sizeof(struct sockaddr_storage),
 #else
 		.prep			= io_eopnotsupp_prep,
 #endif
