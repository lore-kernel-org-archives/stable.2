Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D53F32A3D7
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973564; cv=none; b=LfPp+zaf/kF9ONT/ts9RD6r8lcc0gmtqb3yF7KpC2tSZ/ZYfDaISajhB4CEkr5hrJr5JNbClE9GXZ1KauLCCdHwiS0PI6SiYia8bYUd99NqkzLKejPrraWVAEBiEYUxcGOxvLsy1S4QCFhpZpfBuMT7x3pM98uVKmM7uLAyGbf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973564; c=relaxed/simple;
	bh=4eeq5e+92tKE7PTjCBgAu+Sn9+h/LB0eUGkc2I7G22A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VbdX8bfz+RCaS72DbtSi/QyNnyrC/2RrqCdXv6YsTSRchHbZh9BoBN4JTqJblxpFlQNzTDiJCZ1Jbmr7olvvS+FBvtU05uoi0RvZq0jgky7qzohHZA20EJwx3E7Uf2i+5cb7tGEgKPD1Yi8If6TVFfIDnPeWmhg8VE8vj43VhdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuukYOdg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuukYOdg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5AB1F000FF;
	Wed,  9 Sep 2026 17:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788973560;
	bh=Z4T+8mGUb0vRdtfCqfHGtYJUrakx5d5MNP7KbluSxzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OuukYOdgYye9QYIh1j9c9nC21zv1e1WHGjlBiUGjIdbd2hekaEG+lWOIQcQvJZNtO
	 GGPW9Zol5vXIENNI+JeiMAzsBg1GP3BVpnbZLdhd6+qtfZ2VleedyqVZyHX6o46AGp
	 pFnIUIX2kbx64KgW5Xic1E7VkCA60eKTwOF8aiVKT6D2JHcNPAp4qh1PjrvcxjkxS+
	 HblAl7oRfQq/ba74bnE+iYB0VEwCUz/8SXlj6+XYR24wAQCb62olJ7mMwTmWzBHQSm
	 gB3VcvWlL5jcHpq0ZZkBFfejkwHbNuXBWXcpcAl7JYfs8rhu1axGfZGapKbWgjX+Sy
	 RCOkl3uaqnJ7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Sanket Goswami <Sanket.Goswami@amd.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] platform/x86/amd/pmc: Move STB functionality to a new file for better code organization
Date: Wed,  9 Sep 2026 13:05:56 -0400
Message-ID: <20260909170557.3185402-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090307-boss-eatable-41c7@gregkh>
References: <2026090307-boss-eatable-41c7@gregkh>
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

Backport adaptation for Linux 6.1 (dependency of 9cef693bce96):

Move only the existing amd_pmc_s2d_init() into pmc/mp1_stb.c, where the
target patch expects it. Keep the stable STB readers, writers, debugfs
registration, CPU gating and driver layout. Link the new object from the
existing AMD Makefile and share the device structure, enable_stb parameter
and command interface through a minimal pmc/pmc.h. No functions are added.
Omit the upstream subdirectory Makefile and newer MP2, quirks, custom STB
and CPU-support dependencies that do not exist in this stable tree.

Provide the target's message-port enum, STB command field and DRAM-size
query, with the existing 16 MiB fallback for unsupported firmware. Preserve
the stable zero-address rejection and restore MSG_PORT_PMC on that extra
error path, which is absent from the target's upstream context. Leave the
target's telemetry-size and mapping error-path changes for the target.

[ sashal: Reduced backport -- upstream 0e914063ddd13 touches 4 file(s), this
  backport carries 5. Not backported here:
  drivers/platform/x86/amd/pmc/Makefile
  drivers/platform/x86/amd/pmc/pmc.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 9cef693bce96 ("platform/x86/amd/pmc: Restore msg_port on amd_stb_s2d_init() error paths")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 MAINTAINERS                            |  1 +
 drivers/platform/x86/amd/Makefile      |  2 +-
 drivers/platform/x86/amd/pmc.c         | 69 ++----------------------
 drivers/platform/x86/amd/pmc/mp1_stb.c | 73 ++++++++++++++++++++++++++
 drivers/platform/x86/amd/pmc/pmc.h     | 46 ++++++++++++++++
 5 files changed, 125 insertions(+), 66 deletions(-)
 create mode 100644 drivers/platform/x86/amd/pmc/mp1_stb.c
 create mode 100644 drivers/platform/x86/amd/pmc/pmc.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a02522a3ec08a..1d337ca054917 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1031,6 +1031,7 @@ M:	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/amd/pmc.c
+F:	drivers/platform/x86/amd/pmc/
 
 AMD PMF DRIVER
 M:	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
diff --git a/drivers/platform/x86/amd/Makefile b/drivers/platform/x86/amd/Makefile
index 2c229198e24c9..4aad005d6061f 100644
--- a/drivers/platform/x86/amd/Makefile
+++ b/drivers/platform/x86/amd/Makefile
@@ -4,7 +4,7 @@
 # AMD x86 Platform-Specific Drivers
 #
 
-amd-pmc-y			:= pmc.o
+amd-pmc-y			:= pmc.o pmc/mp1_stb.o
 obj-$(CONFIG_AMD_PMC)		+= amd-pmc.o
 amd_hsmp-y			:= hsmp.o
 obj-$(CONFIG_AMD_HSMP)		+= amd_hsmp.o
diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index 8eaeb1e8f9753..0514b3749cbf4 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -28,6 +28,8 @@
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
 
+#include "pmc/pmc.h"
+
 /* SMU communication registers */
 #define AMD_PMC_REGISTER_MESSAGE	0x538
 #define AMD_PMC_REGISTER_RESPONSE	0x980
@@ -44,14 +46,12 @@
 #define AMD_PMC_STB_S2IDLE_CHECK	0xC6000003
 
 /* STB S2D(Spill to DRAM) has different message port offset */
-#define STB_SPILL_TO_DRAM		0xBE
 #define AMD_S2D_REGISTER_MESSAGE	0xA20
 #define AMD_S2D_REGISTER_RESPONSE	0xA80
 #define AMD_S2D_REGISTER_ARGUMENT	0xA88
 
 /* STB Spill to DRAM Parameters */
 #define S2D_TELEMETRY_BYTES_MAX		0x100000
-#define S2D_TELEMETRY_DRAMBYTES_MAX	0x1000000
 
 /* Base address of SMU for mapping physical address to virtual address */
 #define AMD_PMC_MAPPING_SIZE		0x01000
@@ -107,12 +107,6 @@ enum amd_pmc_def {
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
@@ -134,32 +128,11 @@ static const struct amd_pmc_bit_map soc15_ip_blk[] = {
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
-static bool enable_stb;
+bool enable_stb;
 module_param(enable_stb, bool, 0644);
 MODULE_PARM_DESC(enable_stb, "Enable the STB debug mechanism");
 
 static struct amd_pmc_dev pmc;
-static int amd_pmc_send_cmd(struct amd_pmc_dev *dev, u32 arg, u32 *data, u8 msg, bool ret);
 static int amd_pmc_read_stb(struct amd_pmc_dev *dev, u32 *buf);
 #ifdef CONFIG_SUSPEND
 static int amd_pmc_write_stb(struct amd_pmc_dev *dev, u32 data);
@@ -576,7 +549,7 @@ static void amd_pmc_dump_registers(struct amd_pmc_dev *dev)
 	dev_dbg(dev->dev, "AMD_PMC_REGISTER_MESSAGE:%x\n", value);
 }
 
-static int amd_pmc_send_cmd(struct amd_pmc_dev *dev, u32 arg, u32 *data, u8 msg, bool ret)
+int amd_pmc_send_cmd(struct amd_pmc_dev *dev, u32 arg, u32 *data, u8 msg, bool ret)
 {
 	int rc;
 	u32 val, message, argument, response;
@@ -867,40 +840,6 @@ static const struct pci_device_id pmc_pci_ids[] = {
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
 #ifdef CONFIG_SUSPEND
 static int amd_pmc_write_stb(struct amd_pmc_dev *dev, u32 data)
 {
diff --git a/drivers/platform/x86/amd/pmc/mp1_stb.c b/drivers/platform/x86/amd/pmc/mp1_stb.c
new file mode 100644
index 0000000000000..c5de2b6208c3b
--- /dev/null
+++ b/drivers/platform/x86/amd/pmc/mp1_stb.c
@@ -0,0 +1,73 @@
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
+/* STB Spill to DRAM Parameters */
+#define S2D_TELEMETRY_BYTES_MAX		0x100000
+#define S2D_TELEMETRY_DRAMBYTES_MAX	0x1000000
+#define STB_SPILL_TO_DRAM		0xBE
+
+enum s2d_arg {
+	S2D_TELEMETRY_SIZE = 0x01,
+	S2D_PHYS_ADDR_LOW,
+	S2D_PHYS_ADDR_HIGH,
+	S2D_DRAM_SIZE = 0x05,
+};
+
+int amd_pmc_s2d_init(struct amd_pmc_dev *dev)
+{
+	u32 phys_addr_low, phys_addr_hi;
+	u64 stb_phys_addr;
+	u32 size = 0;
+	int ret;
+
+	if (!enable_stb)
+		return 0;
+
+	dev->stb_arg.s2d_msg_id = STB_SPILL_TO_DRAM;
+
+	/* Spill to DRAM feature uses separate SMU message port */
+	dev->msg_port = MSG_PORT_S2D;
+
+	amd_pmc_send_cmd(dev, S2D_TELEMETRY_SIZE, &size, dev->stb_arg.s2d_msg_id, true);
+	if (size != S2D_TELEMETRY_BYTES_MAX)
+		return -EIO;
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
+		dev->msg_port = MSG_PORT_PMC;
+		return -EINVAL;
+	}
+
+	stb_phys_addr = ((u64)phys_addr_hi << 32 | phys_addr_low);
+
+	/* Clear msg_port for other SMU operation */
+	dev->msg_port = MSG_PORT_PMC;
+
+	dev->stb_virt_addr = devm_ioremap(dev->dev, stb_phys_addr, dev->dram_size);
+	if (!dev->stb_virt_addr)
+		return -ENOMEM;
+
+	return 0;
+}
diff --git a/drivers/platform/x86/amd/pmc/pmc.h b/drivers/platform/x86/amd/pmc/pmc.h
new file mode 100644
index 0000000000000..9ad673c4d560f
--- /dev/null
+++ b/drivers/platform/x86/amd/pmc/pmc.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* AMD SoC Power Management Controller Driver */
+
+#ifndef PMC_H
+#define PMC_H
+
+#include <linux/types.h>
+#include <linux/mutex.h>
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
+extern bool enable_stb;
+
+int amd_pmc_s2d_init(struct amd_pmc_dev *dev);
+int amd_pmc_send_cmd(struct amd_pmc_dev *dev, u32 arg, u32 *data, u8 msg, bool ret);
+
+#endif /* PMC_H */
-- 
2.53.0

