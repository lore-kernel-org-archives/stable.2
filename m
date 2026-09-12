Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78CC2FFDEA
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 14:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789222872; cv=none; b=DduwzqxPwIevNd8ipkIVKFrUuNXITSkzEZR9nXTCfBO8R2ZjQWGb2kOAVKoTV1IjgpNR5ik+ix3psTwmOboC4qlbWrsyY6rAnuUh3SmdCMN4KUROCb8VqBxd/6Hn65V10/i/NdTVjW0zi8cYAZJTttCNFl+wv6W3HRDmi5oVXMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789222872; c=relaxed/simple;
	bh=9iTYdqrNPWSIQgCTal7lVszrAxfQhPDtLmV5skLt1mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fm+aAmS+C5CvT+hYdeNa442xgy0G8Dzx7PRLxkRkaKJ+sMxtN4L67eGqBwEKF8r216XOrui8mIyvrcByDDJd+CpDzSDX9fG75NmT8AtC4FViUyp+u2jDHQ7++9c57UeRpDVzxWOgmd6m6Ss75hD1BYsVbRgfZmKkOGKCM/n9PHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VO+Zy3je; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VO+Zy3je"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BA71F0089C;
	Sat, 12 Sep 2026 14:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789222870;
	bh=lnlon0QAurwCRnVLdU/5MVht1B96epfjgI8TNRM2J08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VO+Zy3jesKCq7SeVA2SipDDLH4ztXGDMJyPcU7zvCEDnzVZt1ydFgMXHri2gkPSNV
	 kQt2acFrrZkuYfQWCoHEiMmUH2SP4TUEV5bWrXyBW60xo2MPmjdqCoTvYqrJpOIGLC
	 Ch7wQ/LV3pWKcg0tzt2OXBHJ7nDRx8xpvxCcbIkcXayneJQB8iB10EajWhVmPKgROZ
	 9CWmjZkl4hRHvNHh0vtQW0fn5v/5LJp6VhtqmaTRLv3wHRyD/v6S62t2FHTALp/t1Y
	 6es83s65mCZ0C1N2CASoPZnhet+sMLVEMnLfSLq/UdonUCHJenJ/EZtdkBYUiaqt6H
	 CSEFUHm2BbSeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 3/3] drm/xe/i2c: Keep the i2c controller always enabled
Date: Sat, 12 Sep 2026 10:21:07 -0400
Message-ID: <20260912142107.2914896-3-sashal@kernel.org>
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

[ Upstream commit 244abef7f280a6a84297bfab5fd2e77147bc419a ]

Some platforms make an assumption that the i2c controller's
enabled state indicates also the power state of the
controller. This can create a problem when the controller is
in disabled state, because the hardware may assume
incorrectly that it is then also in low-power state.

To fix this, the controller is kept enabled by taking over
the IC_ENABLE register. The controller has to be disabled
when the configuration is updated and when the target
address or the slave address are assigned, so disabling it
when IC_CON, IC_TAR or IC_SAR registers are programmed, and
then re-enabling it again.

Fixes: f0e53aadd702 ("drm/xe: Support for I2C attached MCUs")
Cc: stable@vger.kernel.org
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://patch.msgid.link/20260811121008.1493015-4-heikki.krogerus@linux.intel.com
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
(cherry picked from commit 76cc14e2faed1adae20f4ee144ead0e3a7566c49)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
[ adapted the register-write switch to the older callback lacking the interrupt-handling prerequisite. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/regs/xe_i2c_regs.h |  2 +
 drivers/gpu/drm/xe/xe_i2c.c           | 57 ++++++++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_i2c.h           |  1 +
 3 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/regs/xe_i2c_regs.h b/drivers/gpu/drm/xe/regs/xe_i2c_regs.h
index f2e455e2bfe45..37550e4a20f80 100644
--- a/drivers/gpu/drm/xe/regs/xe_i2c_regs.h
+++ b/drivers/gpu/drm/xe/regs/xe_i2c_regs.h
@@ -20,4 +20,6 @@
 #define I2C_CONFIG_CMD			XE_REG(I2C_CONFIG_SPACE_OFFSET + PCI_COMMAND)
 #define I2C_CONFIG_PMCSR		XE_REG(I2C_CONFIG_SPACE_OFFSET + 0x84)
 
+#define I2C_REG(reg)			XE_REG((reg) + I2C_MEM_SPACE_OFFSET)
+
 #endif /* _XE_I2C_REGS_H_ */
diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
index f05f23221c1b7..21ed8f5e2499d 100644
--- a/drivers/gpu/drm/xe/xe_i2c.c
+++ b/drivers/gpu/drm/xe/xe_i2c.c
@@ -8,6 +8,7 @@
 #include <drm/drm_print.h>
 #include <linux/array_size.h>
 #include <linux/container_of.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
@@ -24,6 +25,8 @@
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
+#include <linux/designware_i2c.h>
+
 #include "regs/xe_i2c_regs.h"
 #include "regs/xe_irq_regs.h"
 
@@ -254,11 +257,40 @@ static void xe_i2c_remove_irq(struct xe_i2c *i2c)
 	irq_domain_remove(i2c->irqdomain);
 }
 
+/* See "Disabling DW_apb_i2c" in the DesignWare DW_abp_i2c databook. */
+static void xe_i2c_disable(struct xe_i2c *i2c)
+{
+	int timeout = 100;
+	u32 status;
+
+	xe_mmio_rmw32(i2c->mmio, I2C_REG(DW_IC_ENABLE), DW_IC_ENABLE_ENABLE, 0);
+
+	do {
+		status = xe_mmio_read32(i2c->mmio, I2C_REG(DW_IC_ENABLE_STATUS));
+		if (!(status & DW_IC_ENABLE_ENABLE))
+			return;
+		/* Can't sleep here. */
+		udelay(25);
+	} while (timeout--);
+
+	dev_warn(i2c->drm_dev, "timeout in disabling i2c adapter\n");
+}
+
 static int xe_i2c_read(void *context, unsigned int reg, unsigned int *val)
 {
 	struct xe_i2c *i2c = context;
 
-	*val = xe_mmio_read32(i2c->mmio, XE_REG(reg + I2C_MEM_SPACE_OFFSET));
+	*val = xe_mmio_read32(i2c->mmio, I2C_REG(reg));
+
+	switch (reg) {
+	case DW_IC_ENABLE:
+	case DW_IC_ENABLE_STATUS:
+		FIELD_MODIFY(DW_IC_ENABLE_ENABLE, val,
+			     i2c->ic_enable & DW_IC_ENABLE_ENABLE);
+		break;
+	default:
+		break;
+	}
 
 	return 0;
 }
@@ -267,8 +299,29 @@ static int xe_i2c_write(void *context, unsigned int reg, unsigned int val)
 {
 	struct xe_i2c *i2c = context;
 
-	xe_mmio_write32(i2c->mmio, XE_REG(reg + I2C_MEM_SPACE_OFFSET), val);
+	switch (reg) {
+	case DW_IC_CON:
+	case DW_IC_TAR:
+	case DW_IC_SAR:
+		/* Disable the controller. */
+		xe_i2c_disable(i2c);
+
+		/* Write the register. */
+		xe_mmio_write32(i2c->mmio, I2C_REG(reg), val);
+
+		/* Enable the controller. */
+		xe_mmio_rmw32(i2c->mmio, I2C_REG(DW_IC_ENABLE), 0, DW_IC_ENABLE_ENABLE);
+		return 0;
+	case DW_IC_ENABLE:
+		i2c->ic_enable = val;
+		/* Other fields can be updated except the enable bit. */
+		val |= DW_IC_ENABLE_ENABLE;
+		break;
+	default:
+		break;
+	}
 
+	xe_mmio_write32(i2c->mmio, I2C_REG(reg), val);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/xe/xe_i2c.h b/drivers/gpu/drm/xe/xe_i2c.h
index 425d8160835f4..68124617f2bf9 100644
--- a/drivers/gpu/drm/xe/xe_i2c.h
+++ b/drivers/gpu/drm/xe/xe_i2c.h
@@ -34,6 +34,7 @@ struct xe_i2c {
 	struct platform_device *pdev;
 	struct i2c_adapter *adapter;
 	struct i2c_client *client[XE_I2C_MAX_CLIENTS];
+	unsigned int ic_enable;
 
 	struct notifier_block bus_notifier;
 	struct work_struct work;
-- 
2.53.0

