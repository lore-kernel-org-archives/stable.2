Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045755;
	b=F5sTKficrNFAescdW68jD1Vtoh47wi1qJhWwWLGD7qsWwY9ytjhHncZHJpMsBOCB5agA
	 jY/LkN1/8/Jxd+UgKBcsWfuaJKg6aE/9ESMbfyzSBRXkAT8Q+yx6d6OnfChQK1XnAo+vZ
	 S5upp/fXKS7ZuhvSQpx3Ye3BOyeSLxEvZQXQW8pwoIuyoT2gr7qG0W9dnBYAqYgXmgJpq
	 RQqPL0H/UMEKyLd6XHmZC79KFNxG9VInCjN1+7A6P93HGEhtAK94PYL38XvSPp3VivrRE
	 EB/m1IBBbC5wFfLmDOShDmbzBi8ZytXgOPAKnJ6yOiXcVlXeAJC+Rpkk2qRBmqj3+aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045755;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NO5KJ5pcsXAG+kFZDskS3eh8fgYXBx+VoFwuMzVLtTk=;
	b=mCJ7JSXRYXXgfG9PF80qFTgfubrMx1zyC+9MvmuK6I07aD/MMgvwSnRH2fD/C3UWFnBY
	 DkdYIcid8UZ4nPhGm8em0sPZIFKMjkW4MWLGxD5FT7vRU0DEwfgjD1Q5V6O0hX36op/fX
	 V29UjTKXpuo8QKs+XvflF/2Z8QSz6DW06p1KoXPz1qw+XwufrJwcF4ZO6F41I1hLBW9VV
	 HQKppj8PXIsNhCFHZ2HCMG8/LkMCiqXD+ubR6Y2X8G34XlCkaF3Gd8dLb/jzyEljSgM4P
	 DtZpWG9IUclW4j4+qGkwUYC+bQV5OdO4WQo494gMUbs5UkYo/Kd/47JPrzEEcMQu4+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NCDQExrw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803B8606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NCDQExrw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22D91F0089F;
	Sat,  7 Nov 2026 10:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045755;
	bh=NO5KJ5pcsXAG+kFZDskS3eh8fgYXBx+VoFwuMzVLtTk=;
	h=From:To:Cc:Subject:Date;
	b=NCDQExrw724PYSEGo4Mweqq0amEbzxTv2oXrc8zA1gPLEA50kKzAbZ+TJHZJq++PU
	 h7UHQ4E8BZRm4ooNA//hAKc+CDomS8rI4UmQ0VPUTn0sHSAS71s66r7vmRyc/Gzatc
	 UlVNEALZuw/krGBKJj+GYODXu87z3IJmTeMgfm8rgzUfHFK8x687Fh/etHJjLjFVX6
	 izaNF+7Oy9P2dYw9iis+ejZxWif9vylhBTb4fwCIU1d5jshIph0h6x6tJSUsP/qpoZ
	 YnnEh5Ot0zYz0oK4ipLSwT6GwvJIy1bY7KMKPZjzSOjAtNW7630Su/O1QfrTEU924c
	 JlEyUQCEdtjKw==
From: Sasha Levin <sashal@kernel.org>
To: heikki.krogerus@linux.intel.com,
	rodrigo.vivi@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/xe/i2c: Keep the i2c controller always enabled" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:02:33 -0500
Message-ID: <20261107050233-failed-7.3-76cc14e2faed@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 76cc14e2faed1adae20f4ee144ead0e3a7566c49
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050233-failed-7.3-76cc14e2faed@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 76cc14e2faed1adae20f4ee144ead0e3a7566c49 Mon Sep 17 00:00:00 2001
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date: Tue, 11 Aug 2026 14:10:08 +0200
Subject: [PATCH] drm/xe/i2c: Keep the i2c controller always enabled

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
---
 drivers/gpu/drm/xe/xe_i2c.c | 49 ++++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/xe/xe_i2c.h |  1 +
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
index 32767570e43d4..d8fa68206f418 100644
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
@@ -215,11 +216,40 @@ void xe_i2c_irq_postinstall(struct xe_device *xe)
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
@@ -229,6 +259,23 @@ static int xe_i2c_write(void *context, unsigned int reg, unsigned int val)
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
2.53.0




