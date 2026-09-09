Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7178D559CB5
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973201; cv=none; b=lTN+LTSxkirKFP9ER8WouCnrsXWPS4IB8OPJvV4APxQxRDuoTodhmQYLeuekOiN4uegDnQRx1xyakjH2DCRpP8TSGnWis8uu1nMi5+1Q9ZisRw3LN6h8cyVtvf4YxbUFk+/3lWYpH1YHcXVHVeitJKXLuMfCd0NDLFgBl2QFBD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973201; c=relaxed/simple;
	bh=+KcfgTTTbMILj+6+q5grx+CRu1aIdE92YjewpzUxRrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n1N5CIQzYLaKWQRAI19AbX4lIfWu817Ps7c47pxJhlNzIUZJUYWoVA4/j4eSI3Jm3JOSzKydbf9C0PknMu8G0Yyl0PZXi6FX+DfH/C3r69OIBNBKH2nX3axmjJlXYEnJlXg79uHJQVWk16JR7KPxwOu8R7MX/NciRmpGqwXHGPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxqeWd74; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxqeWd74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1701F00893;
	Wed,  9 Sep 2026 16:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788973198;
	bh=wyY5ZtgIwUnVbWWoQPag8IYTI58TDUbZEe1nP0D9beA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PxqeWd74Y5ejx316o+/mzjourbY+R5dWF73FfZgFqpJ3a9YtAjuQcvJnNuGCch5Hw
	 lOYO7IBvV9bwm44eAiZwMKXSGWTUNym8Zxnip4pNtCQZeckhM6I/dnW4Ac1ZkCeo2G
	 yv1nOJvfPEsdej+BPkDUZtFylZ5jlbrGMLGgvkDZ4Juql/9fIHrhvqCNj/nZ6ApC5V
	 MlUel9VyxBV0WIOzWt5DwjXtF7zTwUBWzFRUM0yz7DALMKR+J5+tq1cA867m46qCTn
	 X/wh8u8//SL8bTCAi6EOM5Pg2s2fd1nneNKOkjtlxyd0JZkt+b0QPvV/OqPS5QaXGy
	 H6UWgrucQp8kQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Sanket Goswami <Sanket.Goswami@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] platform/x86/amd/pmc: Move STB functionality to a new file for better code organization
Date: Wed,  9 Sep 2026 12:59:55 -0400
Message-ID: <20260909165956.3156218-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090317-retool-chivalry-dde5@gregkh>
References: <2026090317-retool-chivalry-dde5@gregkh>
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

Backport adaptation for Linux 6.6:

Move only the existing S2D initialization routine to mp1_stb.c, renamed
to amd_stb_s2d_init. Keep the existing STB debugfs implementation, module
parameters, supported CPUs and suspend workarounds in pmc.c. Do not import
the newer custom-buffer helper, allocation changes or platform support.
No functions are added; the initializer is moved and renamed.

Retain IP-count/message-ID setup in the existing probe path before S2D
initialization. Share the S2D command definitions, use the stb_arg.s2d_msg_id
layout and named message ports expected by the target, and restore the PMC
message port through a common exit path. Only the existing command sender
and relocated initializer need cross-file declarations.

As in the upstream dependency, omit the old zero-address check from the
relocated initializer. Target 0225c1d637687b03726f00ac65b6def843d2c464 applies
unchanged and supplies command-error propagation and zero-address rejection
before ioremap. This dependency prepares that target's exact patch context.

Stable-dep-of: 0225c1d63768 ("platform/x86/amd/pmc: Propagate SMU errors and validate S2D address")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmc/Makefile  |  2 +-
 drivers/platform/x86/amd/pmc/mp1_stb.c | 58 +++++++++++++++++++++
 drivers/platform/x86/amd/pmc/pmc.c     | 72 ++++----------------------
 drivers/platform/x86/amd/pmc/pmc.h     | 27 +++++++++-
 4 files changed, 93 insertions(+), 66 deletions(-)
 create mode 100644 drivers/platform/x86/amd/pmc/mp1_stb.c

diff --git a/drivers/platform/x86/amd/pmc/Makefile b/drivers/platform/x86/amd/pmc/Makefile
index 4aaa29d351c90..a0e047a8f8364 100644
--- a/drivers/platform/x86/amd/pmc/Makefile
+++ b/drivers/platform/x86/amd/pmc/Makefile
@@ -4,5 +4,5 @@
 # AMD Power Management Controller Driver
 #
 
-amd-pmc-objs := pmc.o pmc-quirks.o
+amd-pmc-objs := pmc.o pmc-quirks.o mp1_stb.o
 obj-$(CONFIG_AMD_PMC) += amd-pmc.o
diff --git a/drivers/platform/x86/amd/pmc/mp1_stb.c b/drivers/platform/x86/amd/pmc/mp1_stb.c
new file mode 100644
index 0000000000000..afb9555d63ea7
--- /dev/null
+++ b/drivers/platform/x86/amd/pmc/mp1_stb.c
@@ -0,0 +1,58 @@
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
+#include <linux/device.h>
+#include <linux/io.h>
+
+#include "pmc.h"
+
+#define S2D_TELEMETRY_DRAMBYTES_MAX	0x1000000
+
+int amd_stb_s2d_init(struct amd_pmc_dev *dev)
+{
+	u32 phys_addr_low, phys_addr_hi;
+	u64 stb_phys_addr;
+	u32 size = 0;
+	int ret = 0;
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
diff --git a/drivers/platform/x86/amd/pmc/pmc.c b/drivers/platform/x86/amd/pmc/pmc.c
index bf6c7ca247e24..01ea2fd9a8181 100644
--- a/drivers/platform/x86/amd/pmc/pmc.c
+++ b/drivers/platform/x86/amd/pmc/pmc.c
@@ -52,10 +52,6 @@
 #define AMD_S2D_REGISTER_RESPONSE	0xA80
 #define AMD_S2D_REGISTER_ARGUMENT	0xA88
 
-/* STB Spill to DRAM Parameters */
-#define S2D_TELEMETRY_BYTES_MAX		0x100000
-#define S2D_TELEMETRY_DRAMBYTES_MAX	0x1000000
-
 /* Base address of SMU for mapping physical address to virtual address */
 #define AMD_PMC_MAPPING_SIZE		0x01000
 #define AMD_PMC_BASE_ADDR_OFFSET	0x10000
@@ -102,14 +98,6 @@ enum amd_pmc_def {
 	MSG_OS_HINT_RN,
 };
 
-enum s2d_arg {
-	S2D_TELEMETRY_SIZE = 0x01,
-	S2D_PHYS_ADDR_LOW,
-	S2D_PHYS_ADDR_HIGH,
-	S2D_NUM_SAMPLES,
-	S2D_DRAM_SIZE,
-};
-
 struct amd_pmc_bit_map {
 	const char *name;
 	u32 bit_mask;
@@ -154,7 +142,6 @@ MODULE_PARM_DESC(delay_suspend,
 		 "Delays s2idle by 2.5 seconds to work around buggy ECs, often causing keyboard issues after suspend. 0: don't delay, 1: do delay, -1 (default): let amd_pmc decide. If you need this please report this to: platform-driver-x86@vger.kernel.org");
 
 static struct amd_pmc_dev pmc;
-static int amd_pmc_send_cmd(struct amd_pmc_dev *dev, u32 arg, u32 *data, u8 msg, bool ret);
 static int amd_pmc_read_stb(struct amd_pmc_dev *dev, u32 *buf);
 static int amd_pmc_write_stb(struct amd_pmc_dev *dev, u32 data);
 
@@ -245,12 +232,12 @@ static int amd_pmc_stb_debugfs_open_v2(struct inode *inode, struct file *filp)
 		return -ENOMEM;
 
 	/* Spill to DRAM num_samples uses separate SMU message port */
-	dev->msg_port = 1;
+	dev->msg_port = MSG_PORT_S2D;
 
 	/* Get the num_samples to calculate the last push location */
-	ret = amd_pmc_send_cmd(dev, S2D_NUM_SAMPLES, &num_samples, dev->s2d_msg_id, true);
+	ret = amd_pmc_send_cmd(dev, S2D_NUM_SAMPLES, &num_samples, dev->stb_arg.s2d_msg_id, true);
 	/* Clear msg_port for other SMU operation */
-	dev->msg_port = 0;
+	dev->msg_port = MSG_PORT_PMC;
 	if (ret) {
 		dev_err(dev->dev, "error: S2D_NUM_SAMPLES not supported : %d\n", ret);
 		kfree(buf);
@@ -304,11 +291,11 @@ static void amd_pmc_get_ip_info(struct amd_pmc_dev *dev)
 	case AMD_CPU_ID_YC:
 	case AMD_CPU_ID_CB:
 		dev->num_ips = 12;
-		dev->s2d_msg_id = 0xBE;
+		dev->stb_arg.s2d_msg_id = 0xBE;
 		break;
 	case AMD_CPU_ID_PS:
 		dev->num_ips = 21;
-		dev->s2d_msg_id = 0x85;
+		dev->stb_arg.s2d_msg_id = 0x85;
 		break;
 	}
 }
@@ -625,7 +612,7 @@ static void amd_pmc_dump_registers(struct amd_pmc_dev *dev)
 	dev_dbg(dev->dev, "AMD_%s_REGISTER_MESSAGE:%x\n", dev->msg_port ? "S2D" : "PMC", value);
 }
 
-static int amd_pmc_send_cmd(struct amd_pmc_dev *dev, u32 arg, u32 *data, u8 msg, bool ret)
+int amd_pmc_send_cmd(struct amd_pmc_dev *dev, u32 arg, u32 *data, u8 msg, bool ret)
 {
 	int rc;
 	u32 val, message, argument, response;
@@ -992,49 +979,6 @@ static const struct pci_device_id pmc_pci_ids[] = {
 	{ }
 };
 
-static int amd_pmc_s2d_init(struct amd_pmc_dev *dev)
-{
-	u32 phys_addr_low, phys_addr_hi;
-	u64 stb_phys_addr;
-	u32 size = 0;
-	int ret;
-
-	/* Spill to DRAM feature uses separate SMU message port */
-	dev->msg_port = 1;
-
-	/* Get num of IP blocks within the SoC */
-	amd_pmc_get_ip_info(dev);
-
-	amd_pmc_send_cmd(dev, S2D_TELEMETRY_SIZE, &size, dev->s2d_msg_id, true);
-	if (size != S2D_TELEMETRY_BYTES_MAX)
-		return -EIO;
-
-	/* Get DRAM size */
-	ret = amd_pmc_send_cmd(dev, S2D_DRAM_SIZE, &dev->dram_size, dev->s2d_msg_id, true);
-	if (ret || !dev->dram_size)
-		dev->dram_size = S2D_TELEMETRY_DRAMBYTES_MAX;
-
-	/* Get STB DRAM address */
-	amd_pmc_send_cmd(dev, S2D_PHYS_ADDR_LOW, &phys_addr_low, dev->s2d_msg_id, true);
-	amd_pmc_send_cmd(dev, S2D_PHYS_ADDR_HIGH, &phys_addr_hi, dev->s2d_msg_id, true);
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
-	dev->stb_virt_addr = devm_ioremap(dev->dev, stb_phys_addr, dev->dram_size);
-	if (!dev->stb_virt_addr)
-		return -ENOMEM;
-
-	return 0;
-}
-
 static int amd_pmc_write_stb(struct amd_pmc_dev *dev, u32 data)
 {
 	int err;
@@ -1118,7 +1062,9 @@ static int amd_pmc_probe(struct platform_device *pdev)
 	mutex_init(&dev->lock);
 
 	if (enable_stb && amd_pmc_is_stb_supported(dev)) {
-		err = amd_pmc_s2d_init(dev);
+		/* Get num of IP blocks within the SoC */
+		amd_pmc_get_ip_info(dev);
+		err = amd_stb_s2d_init(dev);
 		if (err)
 			goto err_pci_dev_put;
 	}
diff --git a/drivers/platform/x86/amd/pmc/pmc.h b/drivers/platform/x86/amd/pmc/pmc.h
index bea65810de5ab..2ac84bb68a2fc 100644
--- a/drivers/platform/x86/amd/pmc/pmc.h
+++ b/drivers/platform/x86/amd/pmc/pmc.h
@@ -14,18 +14,38 @@
 #include <linux/types.h>
 #include <linux/mutex.h>
 
+/* STB Spill to DRAM Parameters */
+#define S2D_TELEMETRY_BYTES_MAX		0x100000
+
+enum s2d_arg {
+	S2D_TELEMETRY_SIZE = 0x01,
+	S2D_PHYS_ADDR_LOW,
+	S2D_PHYS_ADDR_HIGH,
+	S2D_NUM_SAMPLES,
+	S2D_DRAM_SIZE,
+};
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
 struct amd_pmc_dev {
 	void __iomem *regbase;
 	void __iomem *smu_virt_addr;
 	void __iomem *stb_virt_addr;
 	void __iomem *fch_virt_addr;
-	bool msg_port;
+	enum s2d_msg_port msg_port;
 	u32 base_addr;
 	u32 cpu_id;
 	u32 active_ips;
 	u32 dram_size;
 	u32 num_ips;
-	u32 s2d_msg_id;
+	struct stb_arg stb_arg;
 /* SMU version information */
 	u8 smu_program;
 	u8 major;
@@ -56,4 +76,7 @@ void amd_pmc_quirks_init(struct amd_pmc_dev *dev);
 #define AMD_CPU_ID_SP			0x14A4
 #define PCI_DEVICE_ID_AMD_1AH_M20H_ROOT 0x1507
 
+int amd_stb_s2d_init(struct amd_pmc_dev *dev);
+int amd_pmc_send_cmd(struct amd_pmc_dev *dev, u32 arg, u32 *data, u8 msg, bool ret);
+
 #endif /* PMC_H */
-- 
2.53.0

