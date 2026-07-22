Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7F9353A8A;
	Wed, 22 Jul 2026 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727369; cv=none; b=PELnKHjdPCefhIqYlDQfwK2ymYTXCCwdgsCzMrFLofmxpDHxs66AXNfWVp3mwhrvo7Hg8nkT5KH8o9RAWsZbcVtSHxeOmyv/WV1hRS/3bApVZ6UPoIIndk0QsvX4dJzsrbhY1p2X2ytaxYvHvNFljBLV4iNCw6IOQhrr+YOMQoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727369; c=relaxed/simple;
	bh=lytLbx90lJ+N4Y1x7HPjwJyuNOwUmtIajyrVL9ORe9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=neACpXCzDg2UH95SV4Fdt0tKKv18Vh006R3cfhdWroJSeu1FMamt0yJ3eBR12FAYIOUDjn2Ard4mFPro5kUUcgbK9Vh5QpsrYaAyBMGzZQPQvMt3pvOqPjBPD/OAsq3yM5SwEJflbDGkpoYQnV543O2TDUqVvY8UvJUGV1LgOzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CGSOX6wh; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CGSOX6wh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784727368; x=1816263368;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lytLbx90lJ+N4Y1x7HPjwJyuNOwUmtIajyrVL9ORe9c=;
  b=CGSOX6whufWEJkeYcitmS8XI2dfjxtIBET3z4aFjlQWKWi36CjYYsVPI
   IjoC20OKeEjrc03JylTw3EmFIHKd9tbzVMIVXyvH6TnykCLKY6zAx5vaZ
   etxBsAPwPaOINtT6A8SB83eR6UwrB3t3UAzffa37F8+dKQGiV2AmcSr6Y
   dccpDgS3X4F5D1Xg+qlCS6rAi1CBaVMJEjpt1HMvTAKtImT/fc90g/nQJ
   5QG9So+kW+kNBEU/2Bv59d3+TJnAl+988mca4wv1dyG0wDvPWfi46VCNf
   AExr+Mpsj/6OtUp2CfsTkDIH3w99vRA+0C6ZuNoax1TwkzvtUb+mAu9bV
   w==;
X-CSE-ConnectionGUID: 3PzQaGPsTTmsor19mkSxNA==
X-CSE-MsgGUID: Q+ZKWddRTL644dza+0/4Lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85453411"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="85453411"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 06:36:07 -0700
X-CSE-ConnectionGUID: 6RO5m1mCQie5VO7uUHEpZA==
X-CSE-MsgGUID: k2ECa/PtSwek7Hfu8l7qmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="263041002"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa005.fm.intel.com with ESMTP; 22 Jul 2026 06:36:04 -0700
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Raag Jadav <raag.jadav@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andi Shyti <andi.shyti@kernel.org>,
	Ramesh Babu B <ramesh.babu.b@intel.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	linux-kernel@vger.kernel.org,
	intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH v6 3/3] drm/xe/i2c: Keep the i2c controller always enabled
Date: Wed, 22 Jul 2026 15:35:54 +0200
Message-ID: <20260722133554.2079612-4-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260722133554.2079612-1-heikki.krogerus@linux.intel.com>
References: <20260722133554.2079612-1-heikki.krogerus@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/gpu/drm/xe/xe_i2c.c | 49 ++++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_i2c.h |  1 +
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
index f1bd4ddad26f5..a7737422baefc 100644
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
@@ -212,11 +213,40 @@ void xe_i2c_irq_postinstall(struct xe_device *xe)
 	xe_mmio_rmw32(mmio, I2C_CONFIG_CMD, PCI_COMMAND_INTX_DISABLE, 0);
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
@@ -226,6 +256,23 @@ static int xe_i2c_write(void *context, unsigned int reg, unsigned int val)
 	struct xe_i2c *i2c = context;
 
 	switch (reg) {
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
 	case DW_IC_SMBUS_INTR_MASK:
 		/* Make sure the Alert is never masked. */
 		val |= DW_IC_SMBUS_INTR_ALERT;
diff --git a/drivers/gpu/drm/xe/xe_i2c.h b/drivers/gpu/drm/xe/xe_i2c.h
index b200966b00484..d63adacfefe71 100644
--- a/drivers/gpu/drm/xe/xe_i2c.h
+++ b/drivers/gpu/drm/xe/xe_i2c.h
@@ -37,6 +37,7 @@ struct xe_i2c {
 	struct platform_device *pdev;
 	struct i2c_adapter *adapter;
 	struct i2c_client *client[XE_I2C_MAX_CLIENTS];
+	unsigned int ic_enable;
 
 	struct notifier_block bus_notifier;
 	struct work_struct work;
-- 
2.50.1

