Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473CB49DB9C
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954638; cv=none; b=uVgt+nh0slqvJwb5Vw8oLvB0yyIwJcQgAbNnNVVQwojZEddzrpLM7tGsxapHTFXFyo1f/V+0z5BnjXtVuajT4eXnuAICwd5SaqdO2IFFFQFcu5/LMJORwmtQvm/2XAIn2/caccnto7dEC5Y2d3zu6b0byxtD22mtNwdVhpuSJvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954638; c=relaxed/simple;
	bh=l2qN0AsQVBSQ/4cArbYCshNbG5gP6RaDAhK6kXfp0Kg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cSkXLENh9zW/WKVrvdEf7x0lXg5nzE3QuO+U3L7f/3C5CMOtLI8rHvceU5Kp6zkajSCeU8tBhPVgDKoceMWZC8BVF1VtUz91rhMBfaYcgl/M9yX4aCShoPAnPF+Z+CX6Wz8QFlx7BJ1e+owQ6UpMjy7c8h6DIeDznVKtN+SQVp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vgKpwl/T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vgKpwl/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05811F00A3A;
	Wed,  9 Sep 2026 11:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954637;
	bh=9VVp61HHYgWINtYwb+M04Vn8wr8SVqoRszykEpFmWvE=;
	h=Subject:To:Cc:From:Date;
	b=vgKpwl/TiflQN7Uh3ICOgFOLB0PfGGCdlb03jaFr1cEXaY/cd28Ha1cpzi3g4lT7/
	 ae+l1P68Jgm7610SJ2Jjh9WGlQscP0yk47RYfoJcYt++itzHUL0nauUipbg1iU3yj2
	 KZZu1bg4stqkszzywJkgOxuNqOvj/i8upYhYsJTE=
Subject: FAILED: patch "[PATCH] drm/xe/i2c: Keep the i2c controller always enabled" failed to apply to 6.18-stable tree
To: heikki.krogerus@linux.intel.com,rodrigo.vivi@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:38:14 +0200
Message-ID: <2026090913-blazer-trash-f040@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 244abef7f280a6a84297bfab5fd2e77147bc419a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090913-blazer-trash-f040@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 244abef7f280a6a84297bfab5fd2e77147bc419a Mon Sep 17 00:00:00 2001
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
(cherry picked from commit 76cc14e2faed1adae20f4ee144ead0e3a7566c49)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/xe/xe_i2c.c b/drivers/gpu/drm/xe/xe_i2c.c
index 32767570e43d..d8fa68206f41 100644
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
index b200966b0048..d63adacfefe7 100644
--- a/drivers/gpu/drm/xe/xe_i2c.h
+++ b/drivers/gpu/drm/xe/xe_i2c.h
@@ -37,6 +37,7 @@ struct xe_i2c {
 	struct platform_device *pdev;
 	struct i2c_adapter *adapter;
 	struct i2c_client *client[XE_I2C_MAX_CLIENTS];
+	unsigned int ic_enable;
 
 	struct notifier_block bus_notifier;
 	struct work_struct work;

