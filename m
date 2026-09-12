Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E922134D4F9
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789222871; cv=none; b=PWGB6Z+bXATmwiVNwuBCHNPOoSybj2JtDNdCW4p2pWRieYkywA/1JSQ0qlZ+cQcyA26Wm3wJD/DXMzvvfpEFNZ/+FIW7fvjjkCi8xu0LCYq+u8kG/iWYX2/2rWgm+jNaPENW7VUTqk1++LbO+CIEpBIUcMBwBU+uGMAc49cUG5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789222871; c=relaxed/simple;
	bh=9teYQ10P6IsGREESl4SmI6enTrnSqisRBOVWwuAB3kU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kp7j0OnQpL7yv26gFXpgNtIdpst0iLfubVHMrkNy22eDUwmmJazCt3B8YXPslrqzKrsxEuNxrRsp735ovGs14NZbheAMpkT/ou/z+qzsS1TWPemY2H4dah04MDcT/ryhfbiNKu7j+BpzcTARQSalvZOzsZEJgjUlY8OgwGQV3zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjywW5g9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjywW5g9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DCA1F000FF;
	Sat, 12 Sep 2026 14:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789222869;
	bh=y63hj0rTb1xIjWvOnnp4wAreOb6D12N4Gj43rXZPR0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kjywW5g9PKslUvygi370aVBLiCe1q3IxIwvTTvTvDeT8ocv/GediGay5PyV97w2RR
	 a6RKrmk2JdeyfaHz2RVS970fZjXHHf0xPJu6fdFuct2jL4vm3x3MVCz65tI/gzicGz
	 SB9EXWcd0sIfqN/82witYeMcwj3WVsn/Sf6RVXlhkkbWf9YJPhXghYdbfRRRc0+y11
	 yklO0yuWzJ29mKuzw44PViiwq1Wf/Ds+wIUDphKdMB46mOTHQ/A0fW/WEOhTTtG9bZ
	 AZRcbRP8q1royG7MOkOygKQPTrW9mXdwXaKcLqx+bdaAu5FfqSU/tAYtTGKXu6BSFT
	 EovaPaeq4gzdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Raag Jadav <raag.jadav@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/3] i2c: designware: Global register definitions
Date: Sat, 12 Sep 2026 10:21:06 -0400
Message-ID: <20260912142107.2914896-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912142107.2914896-1-sashal@kernel.org>
References: <2026090957-lilac-mocha-69d6@gregkh>
 <20260912142107.2914896-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

[ Upstream commit 874ef9a6f2fc45d3f6021842d92fa5420fa4c825 ]

Moving the register definitions to a global header file
include/linux/designware_i2c.h. That removes the need to
duplicate them in the adaptation layers for this driver
outside of drivers/i2c/busses/. There is at least one of
those in drivers/gpu/drm/xe/xe_i2c.c.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Link: https://patch.msgid.link/20260811121008.1493015-2-heikki.krogerus@linux.intel.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
(cherry picked from commit 2ab2fb31411a494e4579dfacda986a2672f80e65)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Stable-dep-of: 244abef7f280 ("drm/xe/i2c: Keep the i2c controller always enabled")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 MAINTAINERS                                |   1 +
 drivers/i2c/busses/i2c-designware-common.c |   2 +
 drivers/i2c/busses/i2c-designware-core.h   |  85 +---------------
 drivers/i2c/busses/i2c-designware-master.c |   2 +
 drivers/i2c/busses/i2c-designware-slave.c  |   2 +
 include/linux/designware_i2c.h             | 107 +++++++++++++++++++++
 6 files changed, 116 insertions(+), 83 deletions(-)
 create mode 100644 include/linux/designware_i2c.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8014b9f8253ed..95cd976a068c0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26241,6 +26241,7 @@ R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 L:	linux-i2c@vger.kernel.org
 S:	Supported
 F:	drivers/i2c/busses/i2c-designware-*
+F:	include/linux/designware_i2c.h
 
 SYNOPSYS DESIGNWARE I2C DRIVER - AMDISP
 M:	Nirujogi Pratap <pratap.nirujogi@amd.com>
diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index e4dfa2ec58bb7..a1eca6cd4b75e 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -33,6 +33,8 @@
 #include <linux/types.h>
 #include <linux/units.h>
 
+#include <linux/designware_i2c.h>
+
 #include "i2c-designware-core.h"
 
 #define DW_IC_DEFAULT_BUS_CAPACITANCE_pF	100
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index c71aa2dd368d5..2c929a6e8da2a 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -18,6 +18,8 @@
 #include <linux/regmap.h>
 #include <linux/types.h>
 
+#include <linux/designware_i2c.h>
+
 #define DW_IC_DEFAULT_FUNCTIONALITY		(I2C_FUNC_I2C | \
 						 I2C_FUNC_SMBUS_BYTE | \
 						 I2C_FUNC_SMBUS_BYTE_DATA | \
@@ -25,23 +27,6 @@
 						 I2C_FUNC_SMBUS_BLOCK_DATA | \
 						 I2C_FUNC_SMBUS_I2C_BLOCK)
 
-#define DW_IC_CON_MASTER			BIT(0)
-#define DW_IC_CON_SPEED_STD			(1 << 1)
-#define DW_IC_CON_SPEED_FAST			(2 << 1)
-#define DW_IC_CON_SPEED_HIGH			(3 << 1)
-#define DW_IC_CON_SPEED_MASK			GENMASK(2, 1)
-#define DW_IC_CON_10BITADDR_SLAVE		BIT(3)
-#define DW_IC_CON_10BITADDR_MASTER		BIT(4)
-#define DW_IC_CON_RESTART_EN			BIT(5)
-#define DW_IC_CON_SLAVE_DISABLE			BIT(6)
-#define DW_IC_CON_STOP_DET_IFADDRESSED		BIT(7)
-#define DW_IC_CON_TX_EMPTY_CTRL			BIT(8)
-#define DW_IC_CON_RX_FIFO_FULL_HLD_CTRL		BIT(9)
-#define DW_IC_CON_BUS_CLEAR_CTRL		BIT(11)
-
-#define DW_IC_DATA_CMD_DAT			GENMASK(7, 0)
-#define DW_IC_DATA_CMD_FIRST_DATA_BYTE		BIT(11)
-
 /*
  * Register access parameters
  */
@@ -55,65 +40,9 @@
 #define DW_IC_FIFO_RX_FIELD			GENMASK(15, 8)
 #define DW_IC_FIFO_MIN_DEPTH			2
 
-/*
- * Registers offset
- */
-#define DW_IC_CON				0x00
-#define DW_IC_TAR				0x04
-#define DW_IC_SAR				0x08
-#define DW_IC_DATA_CMD				0x10
-#define DW_IC_SS_SCL_HCNT			0x14
-#define DW_IC_SS_SCL_LCNT			0x18
-#define DW_IC_FS_SCL_HCNT			0x1c
-#define DW_IC_FS_SCL_LCNT			0x20
-#define DW_IC_HS_SCL_HCNT			0x24
-#define DW_IC_HS_SCL_LCNT			0x28
-#define DW_IC_INTR_STAT				0x2c
-#define DW_IC_INTR_MASK				0x30
-#define DW_IC_RAW_INTR_STAT			0x34
-#define DW_IC_RX_TL				0x38
-#define DW_IC_TX_TL				0x3c
-#define DW_IC_CLR_INTR				0x40
-#define DW_IC_CLR_RX_UNDER			0x44
-#define DW_IC_CLR_RX_OVER			0x48
-#define DW_IC_CLR_TX_OVER			0x4c
-#define DW_IC_CLR_RD_REQ			0x50
-#define DW_IC_CLR_TX_ABRT			0x54
-#define DW_IC_CLR_RX_DONE			0x58
-#define DW_IC_CLR_ACTIVITY			0x5c
-#define DW_IC_CLR_STOP_DET			0x60
-#define DW_IC_CLR_START_DET			0x64
-#define DW_IC_CLR_GEN_CALL			0x68
-#define DW_IC_ENABLE				0x6c
-#define DW_IC_STATUS				0x70
-#define DW_IC_TXFLR				0x74
-#define DW_IC_RXFLR				0x78
-#define DW_IC_SDA_HOLD				0x7c
-#define DW_IC_TX_ABRT_SOURCE			0x80
-#define DW_IC_ENABLE_STATUS			0x9c
-#define DW_IC_CLR_RESTART_DET			0xa8
-#define DW_IC_SMBUS_INTR_MASK			0xcc
-#define DW_IC_COMP_PARAM_1			0xf4
-#define DW_IC_COMP_VERSION			0xf8
 #define DW_IC_SDA_HOLD_MIN_VERS			0x3131312A /* "111*" == v1.11* */
-#define DW_IC_COMP_TYPE				0xfc
 #define DW_IC_COMP_TYPE_VALUE			0x44570140 /* "DW" + 0x0140 */
 
-#define DW_IC_INTR_RX_UNDER			BIT(0)
-#define DW_IC_INTR_RX_OVER			BIT(1)
-#define DW_IC_INTR_RX_FULL			BIT(2)
-#define DW_IC_INTR_TX_OVER			BIT(3)
-#define DW_IC_INTR_TX_EMPTY			BIT(4)
-#define DW_IC_INTR_RD_REQ			BIT(5)
-#define DW_IC_INTR_TX_ABRT			BIT(6)
-#define DW_IC_INTR_RX_DONE			BIT(7)
-#define DW_IC_INTR_ACTIVITY			BIT(8)
-#define DW_IC_INTR_STOP_DET			BIT(9)
-#define DW_IC_INTR_START_DET			BIT(10)
-#define DW_IC_INTR_GEN_CALL			BIT(11)
-#define DW_IC_INTR_RESTART_DET			BIT(12)
-#define DW_IC_INTR_MST_ON_HOLD			BIT(13)
-
 #define DW_IC_INTR_DEFAULT_MASK			(DW_IC_INTR_RX_FULL | \
 						 DW_IC_INTR_TX_ABRT | \
 						 DW_IC_INTR_STOP_DET)
@@ -123,16 +52,6 @@
 						 DW_IC_INTR_RX_UNDER | \
 						 DW_IC_INTR_RD_REQ)
 
-#define DW_IC_ENABLE_ENABLE			BIT(0)
-#define DW_IC_ENABLE_ABORT			BIT(1)
-
-#define DW_IC_STATUS_ACTIVITY			BIT(0)
-#define DW_IC_STATUS_TFE			BIT(2)
-#define DW_IC_STATUS_RFNE			BIT(3)
-#define DW_IC_STATUS_MASTER_ACTIVITY		BIT(5)
-#define DW_IC_STATUS_SLAVE_ACTIVITY		BIT(6)
-#define DW_IC_STATUS_MASTER_HOLD_TX_FIFO_EMPTY	BIT(7)
-
 #define DW_IC_SDA_HOLD_RX_SHIFT			16
 #define DW_IC_SDA_HOLD_RX_MASK			GENMASK(23, 16)
 
diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index 7a301c8b604ef..a1bcc3797e4ff 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -25,6 +25,8 @@
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
+#include <linux/designware_i2c.h>
+
 #include "i2c-designware-core.h"
 
 #define AMD_TIMEOUT_MIN_US	25
diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
index ad0d5fbfa6d5e..0abcc7757b231 100644
--- a/drivers/i2c/busses/i2c-designware-slave.c
+++ b/drivers/i2c/busses/i2c-designware-slave.c
@@ -19,6 +19,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
+#include <linux/designware_i2c.h>
+
 #include "i2c-designware-core.h"
 
 int i2c_dw_reg_slave(struct i2c_client *slave)
diff --git a/include/linux/designware_i2c.h b/include/linux/designware_i2c.h
new file mode 100644
index 0000000000000..53f37f18a7229
--- /dev/null
+++ b/include/linux/designware_i2c.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Synopsys DesignWare I2C register definitions
+ *
+ * Copyright (C) 2026, Intel Corporation
+ */
+
+#ifndef __LINUX_DESIGNWARE_I2C_H
+#define __LINUX_DESIGNWARE_I2C_H
+
+#include <linux/bits.h>
+
+/*
+ * Registers offset
+ */
+#define DW_IC_CON				0x00
+#define DW_IC_TAR				0x04
+#define DW_IC_SAR				0x08
+#define DW_IC_DATA_CMD				0x10
+#define DW_IC_SS_SCL_HCNT			0x14
+#define DW_IC_SS_SCL_LCNT			0x18
+#define DW_IC_FS_SCL_HCNT			0x1c
+#define DW_IC_FS_SCL_LCNT			0x20
+#define DW_IC_HS_SCL_HCNT			0x24
+#define DW_IC_HS_SCL_LCNT			0x28
+#define DW_IC_INTR_STAT				0x2c
+#define DW_IC_INTR_MASK				0x30
+#define DW_IC_RAW_INTR_STAT			0x34
+#define DW_IC_RX_TL				0x38
+#define DW_IC_TX_TL				0x3c
+#define DW_IC_CLR_INTR				0x40
+#define DW_IC_CLR_RX_UNDER			0x44
+#define DW_IC_CLR_RX_OVER			0x48
+#define DW_IC_CLR_TX_OVER			0x4c
+#define DW_IC_CLR_RD_REQ			0x50
+#define DW_IC_CLR_TX_ABRT			0x54
+#define DW_IC_CLR_RX_DONE			0x58
+#define DW_IC_CLR_ACTIVITY			0x5c
+#define DW_IC_CLR_STOP_DET			0x60
+#define DW_IC_CLR_START_DET			0x64
+#define DW_IC_CLR_GEN_CALL			0x68
+#define DW_IC_ENABLE				0x6c
+#define DW_IC_STATUS				0x70
+#define DW_IC_TXFLR				0x74
+#define DW_IC_RXFLR				0x78
+#define DW_IC_SDA_HOLD				0x7c
+#define DW_IC_TX_ABRT_SOURCE			0x80
+#define DW_IC_ENABLE_STATUS			0x9c
+#define DW_IC_CLR_RESTART_DET			0xa8
+#define DW_IC_SMBUS_INTR_STAT			0xc8
+#define DW_IC_SMBUS_INTR_MASK			0xcc
+#define DW_IC_CLR_SMBUS_INTR			0xd4
+#define DW_IC_COMP_PARAM_1			0xf4
+#define DW_IC_COMP_VERSION			0xf8
+#define DW_IC_COMP_TYPE				0xfc
+
+/* DW_IC_CON bits */
+#define DW_IC_CON_MASTER			BIT(0)
+#define DW_IC_CON_SPEED_STD			(1 << 1)
+#define DW_IC_CON_SPEED_FAST			(2 << 1)
+#define DW_IC_CON_SPEED_HIGH			(3 << 1)
+#define DW_IC_CON_SPEED_MASK			GENMASK(2, 1)
+#define DW_IC_CON_10BITADDR_SLAVE		BIT(3)
+#define DW_IC_CON_10BITADDR_MASTER		BIT(4)
+#define DW_IC_CON_RESTART_EN			BIT(5)
+#define DW_IC_CON_SLAVE_DISABLE			BIT(6)
+#define DW_IC_CON_STOP_DET_IFADDRESSED		BIT(7)
+#define DW_IC_CON_TX_EMPTY_CTRL			BIT(8)
+#define DW_IC_CON_RX_FIFO_FULL_HLD_CTRL		BIT(9)
+#define DW_IC_CON_BUS_CLEAR_CTRL		BIT(11)
+
+/* DW_IC_DATA_CMD bits */
+#define DW_IC_DATA_CMD_DAT			GENMASK(7, 0)
+#define DW_IC_DATA_CMD_FIRST_DATA_BYTE		BIT(11)
+
+/* DW_IC_INTR_* bits */
+#define DW_IC_INTR_RX_UNDER			BIT(0)
+#define DW_IC_INTR_RX_OVER			BIT(1)
+#define DW_IC_INTR_RX_FULL			BIT(2)
+#define DW_IC_INTR_TX_OVER			BIT(3)
+#define DW_IC_INTR_TX_EMPTY			BIT(4)
+#define DW_IC_INTR_RD_REQ			BIT(5)
+#define DW_IC_INTR_TX_ABRT			BIT(6)
+#define DW_IC_INTR_RX_DONE			BIT(7)
+#define DW_IC_INTR_ACTIVITY			BIT(8)
+#define DW_IC_INTR_STOP_DET			BIT(9)
+#define DW_IC_INTR_START_DET			BIT(10)
+#define DW_IC_INTR_GEN_CALL			BIT(11)
+#define DW_IC_INTR_RESTART_DET			BIT(12)
+#define DW_IC_INTR_MST_ON_HOLD			BIT(13)
+
+/* DW_IC_ENABLE bits */
+#define DW_IC_ENABLE_ENABLE			BIT(0)
+#define DW_IC_ENABLE_ABORT			BIT(1)
+
+/* DW_IC_STATUS bits */
+#define DW_IC_STATUS_ACTIVITY			BIT(0)
+#define DW_IC_STATUS_TFE			BIT(2)
+#define DW_IC_STATUS_RFNE			BIT(3)
+#define DW_IC_STATUS_MASTER_ACTIVITY		BIT(5)
+#define DW_IC_STATUS_SLAVE_ACTIVITY		BIT(6)
+#define DW_IC_STATUS_MASTER_HOLD_TX_FIFO_EMPTY	BIT(7)
+
+/* DW_IC_SMBUS_INTR_* bits */
+#define DW_IC_SMBUS_INTR_ALERT			BIT(10)
+
+#endif /* __LINUX_DESIGNWARE_I2C_H */
-- 
2.53.0

