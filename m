Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADA837DABC
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788976139; cv=none; b=jNtFIVvUWKsyv0WGjotOCOFRkjZnUL8wHzk0u9SuyTEI8cT206uA3M6/Z1M2nYGpJPPqcYEi4+8W5L4NtJpUBDoLcXx/bKXV2Y92uaaAdLO09K3cu1b/SfGws8QSJl8B40443iiduDPixGocCXt0xgmd1H1m0fV63Uula7jTHtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788976139; c=relaxed/simple;
	bh=LGb46X58GB7Vn+kIMETqQa9vLc9l4ky2jVIMRyOqtgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TLpH2Tpi3UXb9mJlGq3/a8xHLp4c4gYl/+ekjSHlGu/wins/UhznNmgJWJyMoKjPCUc+4aCupw08GrAqnjamQkioEy5kj5urY6nlzrWrceW7BkTBkl8JIHPFg3Txb4KdDmCODNfZE8IIPnhduS2Uv9CTWrErZWLj3y4BUS3Xvr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZJQjmae; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZJQjmae"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0BB1F000FF;
	Wed,  9 Sep 2026 17:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788976137;
	bh=YwcRKo6vAZThPOPSt1sF4JCSH0XL4A+3vOuW21Ecye0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YZJQjmaeOa3078lt1sGW0xMcbBcZZHFH/fO/e9p7mMFJxRsfhf250D3EJC/MDSGxn
	 6WvofkarUJiWNb2VzmWEO8jfChrX+ZYMKFN3H9F8kvZfhiMNhAm3KEKCrx6LQcDSBb
	 rrO6I5F15gBpWuPxqFWbGQmJ4Xp4tZVW3n+aelY366DDsgW0X/liMMSeayAyxdufwO
	 14vOMgS2SKakvz4fY8Dp1hIZJHVGbDnVnoveUqfWFk7LyVDJSDxr/T2kKjKDc3byIL
	 nhqXzC//jwxEQxXAGYxQhOf1f5GMiTjM9L/SS00jCgP4Zs+Cw5hkrUxVY9OaKqv/Fe
	 oScJy7fdgWgew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Sanket Goswami <Sanket.Goswami@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] platform/x86/amd/pmc: Move STB functionality to a new file for better code organization
Date: Wed,  9 Sep 2026 13:48:53 -0400
Message-ID: <20260909174855.3353995-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090317-buggy-snowboard-d47e@gregkh>
References: <2026090317-buggy-snowboard-d47e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

[ Upstream commit 0e914063ddd135407c0550b77a6f5bf779bf8384 ]

As the SoC evolves with each generation, the dynamics between the PMC and
STB layers within the PMC driver are becoming increasingly complex, making
it challenging to manage both in a single file and maintain code
readability.

Additionally, during silicon bringup, the PMC functionality is often
enabled first, with STB functionality added later. This can lead to missed
updates in the driver, potentially causing issues.

To address these challenges, it's beneficial to move all STB-related
changes to a separate file. This approach will better accommodate newer
SoCs, provide improved flexibility for desktop variants, and facilitate
the collection of additional debug information through STB mechanisms.

Also the additional checks for entering s2d_init have been moved from
the PMC probe to amd_pmc_s2d_init(). This adjustment makes more sense
following the transfer of code to the separate mp1_stb.c file.

Co-developed-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Link: https://lore.kernel.org/r/20241108070822.3912689-3-Shyam-sundar.S-k@amd.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[Backport dependency for 0225c1d637687 to Linux 6.1]
Move the existing PMC source into pmc/ and extract only the STB functions
already present in this stable tree. Add the composite-module Makefile and
a shared header containing the stable device structure and the declarations
needed by the split. No functions or new platform support are introduced.
Keep enable_stb, CPU gating and debugfs registration in their original PMC
paths; omit MP2, enhanced STB dumping and newer firmware/platform helpers.

Prepare the existing S2D initializer for the target's three-way cherry-pick:
provide stb_arg.s2d_msg_id using the existing 0xBE command, query DRAM size
with the existing 16 MiB default, and restore the PMC message port through
a common exit. Preserve the stable zero-address rejection before mapping.
The target then supplies SMU command error propagation without requiring
the intervening upstream feature additions or helper functions.

Stable-dep-of: 0225c1d63768 ("platform/x86/amd/pmc: Propagate SMU errors and validate S2D address")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/Makefile        |   3 +-
 drivers/platform/x86/amd/pmc/Makefile    |   4 +
 drivers/platform/x86/amd/pmc/mp1_stb.c   | 201 +++++++++++++++++++++++
 drivers/platform/x86/amd/{ => pmc}/pmc.c | 188 +--------------------
 drivers/platform/x86/amd/pmc/pmc.h       |  48 ++++++
 5 files changed, 257 insertions(+), 187 deletions(-)
 create mode 100644 drivers/platform/x86/amd/pmc/Makefile
 create mode 100644 drivers/platform/x86/amd/pmc/mp1_stb.c
 rename drivers/platform/x86/amd/{ => pmc}/pmc.c (82%)
 create mode 100644 drivers/platform/x86/amd/pmc/pmc.h

diff --git a/drivers/platform/x86/amd/Makefile b/drivers/platform/x86/amd/Makefile
index 2c229198e24c9..f04932b7a7d12 100644
--- a/drivers/platform/x86/amd/Makefile
+++ b/drivers/platform/x86/amd/Makefile
@@ -4,8 +4,7 @@
 # AMD x86 Platform-Specific Drivers
 #
 
-amd-pmc-y			:= pmc.o
-obj-$(CONFIG_AMD_PMC)		+= amd-pmc.o
+obj-$(CONFIG_AMD_PMC)		+= pmc/
 amd_hsmp-y			:= hsmp.o
 obj-$(CONFIG_AMD_HSMP)		+= amd_hsmp.o
 obj-$(CONFIG_AMD_PMF)		+= pmf/
diff --git a/drivers/platform/x86/amd/pmc/Makefile b/drivers/platform/x86/amd/pmc/Makefile
new file mode 100644
index 0000000000000..3c50d54f6aa2e
--- /dev/null
+++ b/drivers/platform/x86/amd/pmc/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_AMD_PMC) += amd-pmc.o
+amd-pmc-y := pmc.o mp1_stb.o
diff --git a/drivers/platform/x86/amd/pmc/mp1_stb.c b/drivers/platform/x86/amd/pmc/mp1_stb.c
new file mode 100644
index 0000000000000..52fc05a1bad68
--- /dev/null
+++ b/drivers/platform/x86/amd/pmc/mp1_stb.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD MP1 Smart Trace Buffer (STB) Layer
+ *
+ * Copyright (c) 2024, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Authors: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
+ *          Sanket Goswami <Sanket.Goswami@amd.com>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <asm/amd_nb.h>
+#include <linux/debugfs.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+
+#include "pmc.h"
+
+/* STB Spill to DRAM Parameters */
+#define S2D_TELEMETRY_BYTES_MAX		0x100000
+#define S2D_TELEMETRY_DRAMBYTES_MAX	0x1000000
+
+/* STB Registers */
+#define AMD_PMC_STB_PMI_0		0x03E30600
+#define FIFO_SIZE		4096
+
+/* STB Spill to DRAM Message Definition */
+#define STB_SPILL_TO_DRAM		0xBE
+
+enum s2d_arg {
+	S2D_TELEMETRY_SIZE = 0x01,
+	S2D_PHYS_ADDR_LOW,
+	S2D_PHYS_ADDR_HIGH,
+	S2D_NUM_SAMPLES,
+	S2D_DRAM_SIZE,
+};
+
+#ifdef CONFIG_SUSPEND
+int amd_pmc_write_stb(struct amd_pmc_dev *dev, u32 data)
+{
+	int err;
+
+	err = amd_smn_write(0, AMD_PMC_STB_PMI_0, data);
+	if (err) {
+		dev_err(dev->dev, "failed to write data in stb: 0x%X\n", AMD_PMC_STB_PMI_0);
+		return pcibios_err_to_errno(err);
+	}
+
+	return 0;
+}
+#endif
+
+static int amd_pmc_read_stb(struct amd_pmc_dev *dev, u32 *buf)
+{
+	int i, err;
+
+	for (i = 0; i < FIFO_SIZE; i++) {
+		err = amd_smn_read(0, AMD_PMC_STB_PMI_0, buf++);
+		if (err) {
+			dev_err(dev->dev, "error reading data from stb: 0x%X\n", AMD_PMC_STB_PMI_0);
+			return pcibios_err_to_errno(err);
+		}
+	}
+
+	return 0;
+}
+
+static int amd_pmc_stb_debugfs_open(struct inode *inode, struct file *filp)
+{
+	struct amd_pmc_dev *dev = filp->f_inode->i_private;
+	u32 size = FIFO_SIZE * sizeof(u32);
+	u32 *buf;
+	int rc;
+
+	buf = kzalloc(size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	rc = amd_pmc_read_stb(dev, buf);
+	if (rc) {
+		kfree(buf);
+		return rc;
+	}
+
+	filp->private_data = buf;
+	return rc;
+}
+
+static ssize_t amd_pmc_stb_debugfs_read(struct file *filp, char __user *buf, size_t size,
+					loff_t *pos)
+{
+	if (!filp->private_data)
+		return -EINVAL;
+
+	return simple_read_from_buffer(buf, size, pos, filp->private_data,
+				       FIFO_SIZE * sizeof(u32));
+}
+
+static int amd_pmc_stb_debugfs_release(struct inode *inode, struct file *filp)
+{
+	kfree(filp->private_data);
+	return 0;
+}
+
+const struct file_operations amd_pmc_stb_debugfs_fops = {
+	.owner = THIS_MODULE,
+	.open = amd_pmc_stb_debugfs_open,
+	.read = amd_pmc_stb_debugfs_read,
+	.release = amd_pmc_stb_debugfs_release,
+};
+
+static int amd_pmc_stb_debugfs_open_v2(struct inode *inode, struct file *filp)
+{
+	struct amd_pmc_dev *dev = filp->f_inode->i_private;
+	u32 *buf;
+
+	buf = kzalloc(S2D_TELEMETRY_BYTES_MAX, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	memcpy_fromio(buf, dev->stb_virt_addr, S2D_TELEMETRY_BYTES_MAX);
+	filp->private_data = buf;
+
+	return 0;
+}
+
+static ssize_t amd_pmc_stb_debugfs_read_v2(struct file *filp, char __user *buf, size_t size,
+					   loff_t *pos)
+{
+	if (!filp->private_data)
+		return -EINVAL;
+
+	return simple_read_from_buffer(buf, size, pos, filp->private_data,
+					S2D_TELEMETRY_BYTES_MAX);
+}
+
+static int amd_pmc_stb_debugfs_release_v2(struct inode *inode, struct file *filp)
+{
+	kfree(filp->private_data);
+	return 0;
+}
+
+const struct file_operations amd_pmc_stb_debugfs_fops_v2 = {
+	.owner = THIS_MODULE,
+	.open = amd_pmc_stb_debugfs_open_v2,
+	.read = amd_pmc_stb_debugfs_read_v2,
+	.release = amd_pmc_stb_debugfs_release_v2,
+};
+
+int amd_pmc_s2d_init(struct amd_pmc_dev *dev)
+{
+	u32 phys_addr_low, phys_addr_hi;
+	u64 stb_phys_addr;
+	u32 size = 0;
+	int ret = 0;
+
+	dev->stb_arg.s2d_msg_id = STB_SPILL_TO_DRAM;
+
+	/* Spill to DRAM feature uses separate SMU message port */
+	dev->msg_port = MSG_PORT_S2D;
+
+	amd_pmc_send_cmd(dev, S2D_TELEMETRY_SIZE, &size, dev->stb_arg.s2d_msg_id, true);
+	if (size != S2D_TELEMETRY_BYTES_MAX) {
+		ret = -EIO;
+		goto out;
+	}
+
+	/* Get DRAM size */
+	ret = amd_pmc_send_cmd(dev, S2D_DRAM_SIZE, &dev->dram_size, dev->stb_arg.s2d_msg_id, true);
+	if (ret || !dev->dram_size)
+		dev->dram_size = S2D_TELEMETRY_DRAMBYTES_MAX;
+
+	/* Get STB DRAM address */
+	amd_pmc_send_cmd(dev, S2D_PHYS_ADDR_LOW, &phys_addr_low, dev->stb_arg.s2d_msg_id, true);
+	amd_pmc_send_cmd(dev, S2D_PHYS_ADDR_HIGH, &phys_addr_hi, dev->stb_arg.s2d_msg_id, true);
+
+	if (!phys_addr_hi && !phys_addr_low) {
+		dev_err(dev->dev, "STB is not enabled on the system; disable enable_stb or contact system vendor\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	stb_phys_addr = ((u64)phys_addr_hi << 32 | phys_addr_low);
+
+	dev->stb_virt_addr = devm_ioremap(dev->dev, stb_phys_addr, dev->dram_size);
+	if (!dev->stb_virt_addr) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	/* Restore the default message port for subsequent SMU operations */
+	dev->msg_port = MSG_PORT_PMC;
+	return ret;
+}
diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
similarity index 82%
rename from drivers/platform/x86/amd/pmc.c
rename to drivers/platform/x86/amd/pmc/pmc.c
index 8eaeb1e8f9753..4740476df007b 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -28,6 +28,8 @@
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
 
+#include "pmc.h"
+
 /* SMU communication registers */
 #define AMD_PMC_REGISTER_MESSAGE	0x538
 #define AMD_PMC_REGISTER_RESPONSE	0x980
@@ -38,21 +40,15 @@
 #define AMD_PMC_SCRATCH_REG_YC		0xD14
 
 /* STB Registers */
-#define AMD_PMC_STB_PMI_0		0x03E30600
 #define AMD_PMC_STB_S2IDLE_PREPARE	0xC6000001
 #define AMD_PMC_STB_S2IDLE_RESTORE	0xC6000002
 #define AMD_PMC_STB_S2IDLE_CHECK	0xC6000003
 
 /* STB S2D(Spill to DRAM) has different message port offset */
-#define STB_SPILL_TO_DRAM		0xBE
 #define AMD_S2D_REGISTER_MESSAGE	0xA20
 #define AMD_S2D_REGISTER_RESPONSE	0xA80
 #define AMD_S2D_REGISTER_ARGUMENT	0xA88
 
-/* STB Spill to DRAM Parameters */
-#define S2D_TELEMETRY_BYTES_MAX		0x100000
-#define S2D_TELEMETRY_DRAMBYTES_MAX	0x1000000
-
 /* Base address of SMU for mapping physical address to virtual address */
 #define AMD_PMC_MAPPING_SIZE		0x01000
 #define AMD_PMC_BASE_ADDR_OFFSET	0x10000
@@ -100,19 +96,12 @@
 #define SOC_SUBSYSTEM_IP_MAX	12
 #define DELAY_MIN_US		2000
 #define DELAY_MAX_US		3000
-#define FIFO_SIZE		4096
 enum amd_pmc_def {
 	MSG_TEST = 0x01,
 	MSG_OS_HINT_PCO,
 	MSG_OS_HINT_RN,
 };
 
-enum s2d_arg {
-	S2D_TELEMETRY_SIZE = 0x01,
-	S2D_PHYS_ADDR_LOW,
-	S2D_PHYS_ADDR_HIGH,
-};
-
 struct amd_pmc_bit_map {
 	const char *name;
 	u32 bit_mask;
@@ -134,36 +123,11 @@ static const struct amd_pmc_bit_map soc15_ip_blk[] = {
 	{}
 };
 
-struct amd_pmc_dev {
-	void __iomem *regbase;
-	void __iomem *smu_virt_addr;
-	void __iomem *stb_virt_addr;
-	void __iomem *fch_virt_addr;
-	bool msg_port;
-	u32 base_addr;
-	u32 cpu_id;
-	u32 active_ips;
-/* SMU version information */
-	u8 smu_program;
-	u8 major;
-	u8 minor;
-	u8 rev;
-	struct device *dev;
-	struct pci_dev *rdev;
-	struct mutex lock; /* generic mutex lock */
-	struct dentry *dbgfs_dir;
-};
-
 static bool enable_stb;
 module_param(enable_stb, bool, 0644);
 MODULE_PARM_DESC(enable_stb, "Enable the STB debug mechanism");
 
 static struct amd_pmc_dev pmc;
-static int amd_pmc_send_cmd(struct amd_pmc_dev *dev, u32 arg, u32 *data, u8 msg, bool ret);
-static int amd_pmc_read_stb(struct amd_pmc_dev *dev, u32 *buf);
-#ifdef CONFIG_SUSPEND
-static int amd_pmc_write_stb(struct amd_pmc_dev *dev, u32 data);
-#endif
 
 static inline u32 amd_pmc_reg_read(struct amd_pmc_dev *dev, int reg_offset)
 {
@@ -192,88 +156,6 @@ struct smu_metrics {
 	u64 timecondition_notmet_totaltime[SOC_SUBSYSTEM_IP_MAX];
 } __packed;
 
-static int amd_pmc_stb_debugfs_open(struct inode *inode, struct file *filp)
-{
-	struct amd_pmc_dev *dev = filp->f_inode->i_private;
-	u32 size = FIFO_SIZE * sizeof(u32);
-	u32 *buf;
-	int rc;
-
-	buf = kzalloc(size, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	rc = amd_pmc_read_stb(dev, buf);
-	if (rc) {
-		kfree(buf);
-		return rc;
-	}
-
-	filp->private_data = buf;
-	return rc;
-}
-
-static ssize_t amd_pmc_stb_debugfs_read(struct file *filp, char __user *buf, size_t size,
-					loff_t *pos)
-{
-	if (!filp->private_data)
-		return -EINVAL;
-
-	return simple_read_from_buffer(buf, size, pos, filp->private_data,
-				       FIFO_SIZE * sizeof(u32));
-}
-
-static int amd_pmc_stb_debugfs_release(struct inode *inode, struct file *filp)
-{
-	kfree(filp->private_data);
-	return 0;
-}
-
-static const struct file_operations amd_pmc_stb_debugfs_fops = {
-	.owner = THIS_MODULE,
-	.open = amd_pmc_stb_debugfs_open,
-	.read = amd_pmc_stb_debugfs_read,
-	.release = amd_pmc_stb_debugfs_release,
-};
-
-static int amd_pmc_stb_debugfs_open_v2(struct inode *inode, struct file *filp)
-{
-	struct amd_pmc_dev *dev = filp->f_inode->i_private;
-	u32 *buf;
-
-	buf = kzalloc(S2D_TELEMETRY_BYTES_MAX, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	memcpy_fromio(buf, dev->stb_virt_addr, S2D_TELEMETRY_BYTES_MAX);
-	filp->private_data = buf;
-
-	return 0;
-}
-
-static ssize_t amd_pmc_stb_debugfs_read_v2(struct file *filp, char __user *buf, size_t size,
-					   loff_t *pos)
-{
-	if (!filp->private_data)
-		return -EINVAL;
-
-	return simple_read_from_buffer(buf, size, pos, filp->private_data,
-					S2D_TELEMETRY_BYTES_MAX);
-}
-
-static int amd_pmc_stb_debugfs_release_v2(struct inode *inode, struct file *filp)
-{
-	kfree(filp->private_data);
-	return 0;
-}
-
-static const struct file_operations amd_pmc_stb_debugfs_fops_v2 = {
-	.owner = THIS_MODULE,
-	.open = amd_pmc_stb_debugfs_open_v2,
-	.read = amd_pmc_stb_debugfs_read_v2,
-	.release = amd_pmc_stb_debugfs_release_v2,
-};
-
 static int amd_pmc_setup_smu_logging(struct amd_pmc_dev *dev)
 {
 	if (dev->cpu_id == AMD_CPU_ID_PCO) {
@@ -576,7 +458,7 @@ static void amd_pmc_dump_registers(struct amd_pmc_dev *dev)
 	dev_dbg(dev->dev, "AMD_PMC_REGISTER_MESSAGE:%x\n", value);
 }
 
-static int amd_pmc_send_cmd(struct amd_pmc_dev *dev, u32 arg, u32 *data, u8 msg, bool ret)
+int amd_pmc_send_cmd(struct amd_pmc_dev *dev, u32 arg, u32 *data, u8 msg, bool ret)
 {
 	int rc;
 	u32 val, message, argument, response;
@@ -867,70 +749,6 @@ static const struct pci_device_id pmc_pci_ids[] = {
 	{ }
 };
 
-static int amd_pmc_s2d_init(struct amd_pmc_dev *dev)
-{
-	u32 phys_addr_low, phys_addr_hi;
-	u64 stb_phys_addr;
-	u32 size = 0;
-
-	/* Spill to DRAM feature uses separate SMU message port */
-	dev->msg_port = 1;
-
-	amd_pmc_send_cmd(dev, S2D_TELEMETRY_SIZE, &size, STB_SPILL_TO_DRAM, 1);
-	if (size != S2D_TELEMETRY_BYTES_MAX)
-		return -EIO;
-
-	/* Get STB DRAM address */
-	amd_pmc_send_cmd(dev, S2D_PHYS_ADDR_LOW, &phys_addr_low, STB_SPILL_TO_DRAM, 1);
-	amd_pmc_send_cmd(dev, S2D_PHYS_ADDR_HIGH, &phys_addr_hi, STB_SPILL_TO_DRAM, 1);
-
-	if (!phys_addr_hi && !phys_addr_low) {
-		dev_err(dev->dev, "STB is not enabled on the system; disable enable_stb or contact system vendor\n");
-		return -EINVAL;
-	}
-
-	stb_phys_addr = ((u64)phys_addr_hi << 32 | phys_addr_low);
-
-	/* Clear msg_port for other SMU operation */
-	dev->msg_port = 0;
-
-	dev->stb_virt_addr = devm_ioremap(dev->dev, stb_phys_addr, S2D_TELEMETRY_DRAMBYTES_MAX);
-	if (!dev->stb_virt_addr)
-		return -ENOMEM;
-
-	return 0;
-}
-
-#ifdef CONFIG_SUSPEND
-static int amd_pmc_write_stb(struct amd_pmc_dev *dev, u32 data)
-{
-	int err;
-
-	err = amd_smn_write(0, AMD_PMC_STB_PMI_0, data);
-	if (err) {
-		dev_err(dev->dev, "failed to write data in stb: 0x%X\n", AMD_PMC_STB_PMI_0);
-		return pcibios_err_to_errno(err);
-	}
-
-	return 0;
-}
-#endif
-
-static int amd_pmc_read_stb(struct amd_pmc_dev *dev, u32 *buf)
-{
-	int i, err;
-
-	for (i = 0; i < FIFO_SIZE; i++) {
-		err = amd_smn_read(0, AMD_PMC_STB_PMI_0, buf++);
-		if (err) {
-			dev_err(dev->dev, "error reading data from stb: 0x%X\n", AMD_PMC_STB_PMI_0);
-			return pcibios_err_to_errno(err);
-		}
-	}
-
-	return 0;
-}
-
 static int amd_pmc_probe(struct platform_device *pdev)
 {
 	struct amd_pmc_dev *dev = &pmc;
diff --git a/drivers/platform/x86/amd/pmc/pmc.h b/drivers/platform/x86/amd/pmc/pmc.h
new file mode 100644
index 0000000000000..f372321eb37a0
--- /dev/null
+++ b/drivers/platform/x86/amd/pmc/pmc.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef PMC_H
+#define PMC_H
+
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+enum s2d_msg_port {
+	MSG_PORT_PMC,
+	MSG_PORT_S2D,
+};
+
+struct stb_arg {
+	u32 s2d_msg_id;
+};
+
+struct amd_pmc_dev {
+	void __iomem *regbase;
+	void __iomem *smu_virt_addr;
+	void __iomem *stb_virt_addr;
+	void __iomem *fch_virt_addr;
+	bool msg_port;
+	u32 base_addr;
+	u32 cpu_id;
+	u32 active_ips;
+	u32 dram_size;
+	struct stb_arg stb_arg;
+/* SMU version information */
+	u8 smu_program;
+	u8 major;
+	u8 minor;
+	u8 rev;
+	struct device *dev;
+	struct pci_dev *rdev;
+	struct mutex lock; /* generic mutex lock */
+	struct dentry *dbgfs_dir;
+};
+
+int amd_pmc_s2d_init(struct amd_pmc_dev *dev);
+int amd_pmc_send_cmd(struct amd_pmc_dev *dev, u32 arg, u32 *data, u8 msg, bool ret);
+#ifdef CONFIG_SUSPEND
+int amd_pmc_write_stb(struct amd_pmc_dev *dev, u32 data);
+#endif
+
+extern const struct file_operations amd_pmc_stb_debugfs_fops;
+extern const struct file_operations amd_pmc_stb_debugfs_fops_v2;
+
+#endif /* PMC_H */
-- 
2.53.0

