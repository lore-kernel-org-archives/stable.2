Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C805B478E2B
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 16:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789228961; cv=none; b=eeNsBoOpAQ7mDbCLKmKw0jpjaTjskA+MRiB7XAIZwIxRzHRjeEpAECKp2q9l4cJnyrhs5tJOtMa0GWMfWh1TV+eyrDFcIWLN9Kn+xU2336UpJbGzNb60kgWDg2nqaKEDec4mrKGIfq5IsMfIhFTCZyHDBZghWJddpxyao6uQaZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789228961; c=relaxed/simple;
	bh=+wpib8FGjH1leiTPPxcPSkuHbcpa+RuMpRYy6rtmQxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bq4Sd0GW0cvnA0cSvmhWeQF9b9zEQhZR4CShDtETArjcrRanDvDLZoKdDc9x7WJVZhJ/kFHZ0TCmmFXdeJzq1UoQEkvQ0Rmzxk/xSmUW1l4PUrNVNQavYzgAk/JuqaaElGbnZZ57lZQqGHnZpnPGQ5iAK+9lAYx1rMUG7ZEWaFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnKKE9w2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnKKE9w2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399361F00899;
	Sat, 12 Sep 2026 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789228959;
	bh=51wKnOmPetp6AgGZBy9BdzR+e8phm62LcDw1CqcZGVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gnKKE9w2hUMugIN+14vpsc5++eoIVg9WHNDayzhbsUixCUY6VQU4scoCUDDqr62b7
	 7y1nzTlPxJjuOENq9oKaBPOSZuHrh6ExE1u17U0JdQi5GEYBQPxaHWbRhpFlt7osQy
	 Qr3TRpX9eWhZ33sZWEi0fVsWB/eY0AvXCgfKREK3w9JRZ/VWm5VSRuu1HpsLuJkPGq
	 AFfzuv/1oeSbNsWTT2IkSQK/Guz36XSX9sTp7nJZ5UvoYEHfcmFPchJ9Nbaax2d4nL
	 9+Sc4XjtrkfXTCEzej7zEhW68EK/ZSzqnFBHzRsdIII2MpD7EzXFzagS8UlpHgyElI
	 nnWHfiZ40yAlQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] drm/xe/i2c: Keep the i2c controller always enabled
Date: Sat, 12 Sep 2026 12:02:36 -0400
Message-ID: <20260912160236.3590141-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912160236.3590141-1-sashal@kernel.org>
References: <2026090913-blazer-trash-f040@gregkh>
 <20260912160236.3590141-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_i2c.c | 49 ++++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_i2c.h |  1 +
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
index 10b5c85e5e4d9..25c7eb725ce26 100644
--- a/drivers/gpu/drm/xe/xe_i2c.c
+++ b/drivers/gpu/drm/xe/xe_i2c.c
@@ -8,6 +8,7 @@
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
 #include <linux/container_of.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
@@ -220,11 +221,40 @@ static void xe_i2c_remove_irq(struct xe_i2c *i2c)
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
@@ -234,6 +264,23 @@ static int xe_i2c_write(void *context, unsigned int reg, unsigned int val)
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
 		/* Preserve the interrupt mask requested by the adapter driver. */
 		break;
diff --git a/drivers/gpu/drm/xe/xe_i2c.h b/drivers/gpu/drm/xe/xe_i2c.h
index ecd5f10358e29..6192e20feaa3f 100644
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

