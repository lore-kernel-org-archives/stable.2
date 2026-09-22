Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC24F2737FC
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065655; cv=none; b=Cefm+v++pnFHiMMMFw9PiN8NWj1zsa1LEgYqJz2aKK9sxlARHb/0TXSwICxO4eozmfvgCbxJol6vmoKNcChrqOCbLokIxtwzL4jXP5MzTNpXGASsdW20X62nKlueLFZOeuFjT9utuPTkPovAmuGkGKFSyxWsasBuPe/Jyvwmshs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065655; c=relaxed/simple;
	bh=794CbgSUTH2kcQ4XMWi0t2f+gEHXpy7kzM2MD0PbIgg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mhrnvBpPJXoVWHXSR3SxgFtmLojpLcQc2mNCDelz8yyupWFn29qpAkeA3qkEfM2hnvX24rUoB7/iOlQL79tULyVlGgvBKQfMyq4IAXgZJiupGvIjwlUNaDB0qWWX/FVEgdI4pj4fzq7OdQPpKcn1QNTVH6Xsy2coNAOvTcPINXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DKFhvHPq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DKFhvHPq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC8C1F000FF;
	Tue, 22 Sep 2026 08:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790065653;
	bh=c+OfcLc6DnW4bck6QTg4iHoNdxa/Ch4yNReNktpr3+o=;
	h=Subject:To:Cc:From:Date;
	b=DKFhvHPqdvGYIdXKf1D4XSKKyQKxT/VDUNQTa2u0Y1OFE4WGQxUefOaKsorEwrhkX
	 1nxhtuYNsjmUMvl3oEyp6vmaokKAGLr/0oOp1cKeYgZj5CySrHajbrchWs/CCVELBh
	 O9hiXyqfw3dpYHjyHFcU3AMizIoBEZqkOARuwRvQ=
Subject: FAILED: patch "[PATCH] phy: renesas: rcar-gen3-usb2: Avoid long delay in atomic" failed to apply to 6.6-stable tree
To: claudiu.beznea.uj@bp.renesas.com,iwamatsu@nigauri.org,manivannan.sadhasivam@oss.qualcomm.com,pavel@nabladev.com,vkoul@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 10:27:22 +0200
Message-ID: <2026092221-handsfree-elevation-2dfc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 48e97c59a49c9e90270f5e3d221db253b76de5da
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092221-handsfree-elevation-2dfc@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 48e97c59a49c9e90270f5e3d221db253b76de5da Mon Sep 17 00:00:00 2001
From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Date: Thu, 16 Jul 2026 21:32:46 +0300
Subject: [PATCH] phy: renesas: rcar-gen3-usb2: Avoid long delay in atomic
 context

The OTG PHY initialization sequence needs to wait for 20 ms at a specific
step, as described in commit 72c0339c115b ("phy: renesas:
rcar-gen3-usb2: follow the hardware manual procedure").

Commit 55a387ebb921 ("phy: renesas: rcar-gen3-usb2: Lock around hardware
registers and driver data") tried to address various problems in the
rcar-gen3-usb2 driver and converted the mutex protecting HW register
accesses to a spin lock, leaving, however, a long delay in the critical
section protected by the spin lock. This may become a problem,
especially on RT kernels.

To address this, release the spin lock before sleeping for 20 ms as
required by the HW manual and reacquire it afterwards. To avoid other
threads entering the critical section and configuring the HW while the
software is waiting for the OTG initialization to complete, introduce the
otg_initializing variable alongside the otg_init_done wait queue. Any
other thread trying to configure the HW while the OTG PHY initialization
is in progress waits for the wait queue instead of immediately returning
errors to PHY users. The IRQs were also disabled while waiting for the OTG
PHY initialization to complete, as the interrupt handler may also apply HW
settings.

The OTG can only be initialized once. It is initialized by the first PHY
that calls struct phy_ops::rcar_gen3_phy_usb2_init().

To avoid failures when multiple PHYs call struct
phy_ops::rcar_gen3_phy_usb2_init() simultaneously, and the PHY responsible
for initializing the OTG either fails or deinit quiqly and another PHY
takes over the PHY init role), the code waiting for the
channel->otg_init_done wait queue retries up to NUM_OF_PHYS times.

Fixes: 55a387ebb921 ("phy: renesas: rcar-gen3-usb2: Lock around hardware registers and driver data")
Cc: stable@vger.kernel.org
Reported-by: Pavel Machek <pavel@nabladev.com>
Closes: https://lore.kernel.org/all/afhkX2Ys2BG1gnqy@duo.ucw.cz
Reported-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Closes: https://lore.kernel.org/all/afhkX2Ys2BG1gnqy@duo.ucw.cz
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Link: https://lore.kernel.org/all/afhkX2Ys2BG1gnqy@duo.ucw.cz
Link: https://patch.msgid.link/20260716183246.3183877-1-claudiu.beznea+renesas@tuxon.dev
Signed-off-by: Vinod Koul <vkoul@kernel.org>

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 9ae9975d3255..b5ba751805aa 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -27,6 +27,7 @@
 #include <linux/reset.h>
 #include <linux/string.h>
 #include <linux/usb/of.h>
+#include <linux/wait.h>
 #include <linux/workqueue.h>
 
 /******* USB2.0 Host registers (original offset is +0x200) *******/
@@ -106,6 +107,13 @@
 /*  RZ/G2L specific */
 #define USB2_LINECTRL1_USB2_IDMON	BIT(0)
 
+/*
+ * The OTG initialization is expected to finish in 20ms. Choose a large enough
+ * timeout to avoid waiters exit prematurely the waiting section under heavy
+ * CPU load.
+ */
+#define USB2_OTG_INIT_TIMEOUT		msecs_to_jiffies(120)
+
 #define NUM_OF_PHYS			4
 enum rcar_gen3_phy_index {
 	PHY_INDEX_BOTH_HC,
@@ -138,12 +146,20 @@ struct rcar_gen3_chan {
 	struct rcar_gen3_phy rphys[NUM_OF_PHYS];
 	struct regulator *vbus;
 	struct work_struct work;
+	wait_queue_head_t otg_init_done;
 	spinlock_t lock;	/* protects access to hardware and driver data structure. */
 	enum usb_dr_mode dr_mode;
 	bool extcon_host;
 	bool is_otg_channel;
 	bool uses_otg_pins;
 	bool otg_internal_reg;
+	/*
+	 * The OTG can be initialized only once and needs to release the spinlock
+	 * and wait for 20 ms due to hardware constraints. If a thread executes
+	 * PHY configuration code while the OTG PHY is waiting for the 20 ms, the
+	 * thread will have to wait for the OTG PHY initialization to complete.
+	 */
+	bool otg_initializing;
 };
 
 struct rcar_gen3_phy_drv_data {
@@ -392,26 +408,58 @@ static ssize_t role_store(struct device *dev, struct device_attribute *attr,
 	struct rcar_gen3_chan *ch = dev_get_drvdata(dev);
 	bool is_b_device;
 	enum phy_mode cur_mode, new_mode;
+	int retries = NUM_OF_PHYS;
+	unsigned long flags;
+	int ret = -EIO;
 
-	guard(spinlock_irqsave)(&ch->lock);
+	spin_lock_irqsave(&ch->lock, flags);
 
-	if (!ch->is_otg_channel || !rcar_gen3_is_any_otg_rphy_initialized(ch))
-		return -EIO;
+	if (!ch->is_otg_channel)
+		goto unlock;
 
-	if (sysfs_streq(buf, "host"))
+	while (retries-- && ch->otg_initializing) {
+		spin_unlock_irqrestore(&ch->lock, flags);
+
+		ret = wait_event_timeout(ch->otg_init_done, !ch->otg_initializing,
+					 USB2_OTG_INIT_TIMEOUT);
+		ret = ret ? 0 : -ETIMEDOUT;
+		if (ret && !retries)
+			goto exit;
+
+		spin_lock_irqsave(&ch->lock, flags);
+	}
+
+	/* If another thread started a new initialization just return -EBUSY. */
+	if (ch->otg_initializing) {
+		ret = -EBUSY;
+		goto unlock;
+	} else {
+		ret = 0;
+	}
+
+	if (!rcar_gen3_is_any_otg_rphy_initialized(ch)) {
+		ret = -EIO;
+		goto unlock;
+	}
+
+	if (sysfs_streq(buf, "host")) {
 		new_mode = PHY_MODE_USB_HOST;
-	else if (sysfs_streq(buf, "peripheral"))
+	} else if (sysfs_streq(buf, "peripheral")) {
 		new_mode = PHY_MODE_USB_DEVICE;
-	else
-		return -EINVAL;
+	} else {
+		ret = -EINVAL;
+		goto unlock;
+	}
 
 	/* is_b_device: true is B-Device. false is A-Device. */
 	is_b_device = rcar_gen3_check_id(ch);
 	cur_mode = rcar_gen3_get_phy_mode(ch);
 
 	/* If current and new mode is the same, this returns the error */
-	if (cur_mode == new_mode)
-		return -EINVAL;
+	if (cur_mode == new_mode) {
+		ret = -EINVAL;
+		goto unlock;
+	}
 
 	if (new_mode == PHY_MODE_USB_HOST) { /* And is_host must be false */
 		if (!is_b_device)	/* A-Peripheral */
@@ -425,7 +473,10 @@ static ssize_t role_store(struct device *dev, struct device_attribute *attr,
 			rcar_gen3_init_for_peri(ch);
 	}
 
-	return count;
+unlock:
+	spin_unlock_irqrestore(&ch->lock, flags);
+exit:
+	return ret ?: count;
 }
 
 static ssize_t role_show(struct device *dev, struct device_attribute *attr,
@@ -441,14 +492,11 @@ static ssize_t role_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(role);
 
-static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
+static void rcar_gen3_init_otg_phase0(struct rcar_gen3_chan *ch)
 {
 	void __iomem *usb2_base = ch->base;
 	u32 val;
 
-	if (!ch->is_otg_channel || rcar_gen3_is_any_otg_rphy_initialized(ch))
-		return;
-
 	/* Should not use functions of read-modify-write a register */
 	val = readl(usb2_base + USB2_LINECTRL1);
 	val = (val & ~USB2_LINECTRL1_DP_RPD) | USB2_LINECTRL1_DPRPD_EN |
@@ -471,7 +519,11 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
 			writel(val | USB2_ADPCTRL_IDPULLUP, usb2_base + USB2_ADPCTRL);
 		}
 	}
-	mdelay(20);
+}
+
+static void rcar_gen3_init_otg_phase1(struct rcar_gen3_chan *ch)
+{
+	void __iomem *usb2_base = ch->base;
 
 	writel(0xffffffff, usb2_base + USB2_OBINTSTA);
 	writel(ch->phy_data->obint_enable_bits, usb2_base + USB2_OBINTEN);
@@ -502,6 +554,7 @@ static irqreturn_t rcar_gen3_phy_usb2_irq(int irq, void *_ch)
 	void __iomem *usb2_base = ch->base;
 	struct device *dev = ch->dev;
 	irqreturn_t ret = IRQ_NONE;
+	unsigned long flags;
 	u32 status;
 
 	pm_runtime_get_noresume(dev);
@@ -509,33 +562,102 @@ static irqreturn_t rcar_gen3_phy_usb2_irq(int irq, void *_ch)
 	if (pm_runtime_suspended(dev))
 		goto rpm_put;
 
-	scoped_guard(spinlock, &ch->lock) {
-		status = readl(usb2_base + USB2_OBINTSTA);
-		if (status & ch->phy_data->obint_enable_bits) {
-			dev_vdbg(dev, "%s: %08x\n", __func__, status);
-			if (ch->phy_data->vblvl_ctrl)
-				writel(USB2_OBINTSTA_CLEAR, usb2_base + USB2_OBINTSTA);
-			else
-				writel(ch->phy_data->obint_enable_bits, usb2_base + USB2_OBINTSTA);
-			rcar_gen3_device_recognition(ch);
-			rcar_gen3_configure_vblvl_ctrl(ch);
-			ret = IRQ_HANDLED;
-		}
+	spin_lock_irqsave(&ch->lock, flags);
+
+	status = readl(usb2_base + USB2_OBINTSTA);
+	if (status & ch->phy_data->obint_enable_bits) {
+		dev_vdbg(dev, "%s: %08x\n", __func__, status);
+		if (ch->phy_data->vblvl_ctrl)
+			writel(USB2_OBINTSTA_CLEAR, usb2_base + USB2_OBINTSTA);
+		else
+			writel(ch->phy_data->obint_enable_bits, usb2_base + USB2_OBINTSTA);
+
+		ret = IRQ_HANDLED;
+
+		/* This should not happen! */
+		if (ch->otg_initializing)
+			goto unlock;
+
+		rcar_gen3_device_recognition(ch);
+		rcar_gen3_configure_vblvl_ctrl(ch);
 	}
 
+unlock:
+	spin_unlock_irqrestore(&ch->lock, flags);
 rpm_put:
 	pm_runtime_put_noidle(dev);
 	return ret;
 }
 
+static void rcar_gen3_phy_usb2_irqs_mask_all(struct rcar_gen3_chan *channel,
+					     u32 *masked_irqs_bits)
+{
+	u32 val, bitmask = USB2_INT_ENABLE_UCOM_INTEN;
+	void __iomem *usb2_base = channel->base;
+
+	for (unsigned int i = 0; i < NUM_OF_PHYS; i++)
+		bitmask |= channel->rphys[i].int_enable_bits;
+
+	val = readl(usb2_base + USB2_INT_ENABLE);
+	*masked_irqs_bits = val & bitmask;
+	val &= ~bitmask;
+	writel(val, usb2_base + USB2_INT_ENABLE);
+
+	/*
+	 * Don't report channel->phy_data->obint_enable_bits IRQs. These are
+	 * unmasked anyway in rcar_gen3_init_otg_phase1().
+	 */
+	val = readl(usb2_base + USB2_OBINTEN);
+	val &= ~channel->phy_data->obint_enable_bits;
+	writel(val, usb2_base + USB2_OBINTEN);
+}
+
+static void rcar_gen3_phy_usb2_irqs_unmask(struct rcar_gen3_chan *channel,
+					   u32 irqs_bits)
+{
+	u32 val, bitmask = USB2_INT_ENABLE_UCOM_INTEN;
+	void __iomem *usb2_base = channel->base;
+
+	for (unsigned int i = 0; i < NUM_OF_PHYS; i++)
+		bitmask |= channel->rphys[i].int_enable_bits;
+
+	val = readl(usb2_base + USB2_INT_ENABLE);
+	val &= ~bitmask;
+	val |= irqs_bits;
+	writel(val, usb2_base + USB2_INT_ENABLE);
+}
+
 static int rcar_gen3_phy_usb2_init(struct phy *p)
 {
 	struct rcar_gen3_phy *rphy = phy_get_drvdata(p);
 	struct rcar_gen3_chan *channel = rphy->ch;
 	void __iomem *usb2_base = channel->base;
+	int retries = NUM_OF_PHYS;
+	unsigned long flags;
 	u32 val;
+	int ret;
 
-	guard(spinlock_irqsave)(&channel->lock);
+	spin_lock_irqsave(&channel->lock, flags);
+
+	while (retries-- && channel->otg_initializing) {
+		spin_unlock_irqrestore(&channel->lock, flags);
+
+		ret = wait_event_timeout(channel->otg_init_done, !channel->otg_initializing,
+					 USB2_OTG_INIT_TIMEOUT);
+		ret = ret ? 0 : -ETIMEDOUT;
+		if (ret && !retries)
+			return ret;
+
+		spin_lock_irqsave(&channel->lock, flags);
+	}
+
+	/* If another thread started a new initialization just return -EBUSY. */
+	if (channel->otg_initializing) {
+		ret = -EBUSY;
+		goto unlock;
+	} else {
+		ret = 0;
+	}
 
 	/* Initialize USB2 part */
 	val = readl(usb2_base + USB2_INT_ENABLE);
@@ -548,8 +670,23 @@ static int rcar_gen3_phy_usb2_init(struct phy *p)
 	}
 
 	/* Initialize otg part (only if we initialize a PHY with IRQs). */
-	if (rphy->int_enable_bits)
-		rcar_gen3_init_otg(channel);
+	if (rphy->int_enable_bits && channel->is_otg_channel &&
+	    !rcar_gen3_is_any_otg_rphy_initialized(channel)) {
+		u32 masked_irq_bits = 0;
+
+		rcar_gen3_init_otg_phase0(channel);
+		rcar_gen3_phy_usb2_irqs_mask_all(channel, &masked_irq_bits);
+		channel->otg_initializing = true;
+		spin_unlock_irqrestore(&channel->lock, flags);
+
+		fsleep(20000);
+
+		spin_lock_irqsave(&channel->lock, flags);
+		rcar_gen3_phy_usb2_irqs_unmask(channel, masked_irq_bits);
+		rcar_gen3_init_otg_phase1(channel);
+		channel->otg_initializing = false;
+		wake_up_all(&channel->otg_init_done);
+	}
 
 	if (channel->phy_data->vblvl_ctrl) {
 		/* SIDDQ mode release */
@@ -568,7 +705,10 @@ static int rcar_gen3_phy_usb2_init(struct phy *p)
 
 	rphy->initialized = true;
 
-	return 0;
+unlock:
+	spin_unlock_irqrestore(&channel->lock, flags);
+
+	return ret;
 }
 
 static int rcar_gen3_phy_usb2_exit(struct phy *p)
@@ -576,9 +716,32 @@ static int rcar_gen3_phy_usb2_exit(struct phy *p)
 	struct rcar_gen3_phy *rphy = phy_get_drvdata(p);
 	struct rcar_gen3_chan *channel = rphy->ch;
 	void __iomem *usb2_base = channel->base;
+	int retries = NUM_OF_PHYS;
+	unsigned long flags;
 	u32 val;
+	int ret;
 
-	guard(spinlock_irqsave)(&channel->lock);
+	spin_lock_irqsave(&channel->lock, flags);
+
+	while (retries-- && channel->otg_initializing) {
+		spin_unlock_irqrestore(&channel->lock, flags);
+
+		ret = wait_event_timeout(channel->otg_init_done, !channel->otg_initializing,
+					 USB2_OTG_INIT_TIMEOUT);
+		ret = ret ? 0 : -ETIMEDOUT;
+		if (ret && !retries)
+			return ret;
+
+		spin_lock_irqsave(&channel->lock, flags);
+	}
+
+	/* If another thread started a new initialization just return -EBUSY. */
+	if (channel->otg_initializing) {
+		ret = -EBUSY;
+		goto unlock;
+	} else {
+		ret = 0;
+	}
 
 	rphy->initialized = false;
 
@@ -588,7 +751,9 @@ static int rcar_gen3_phy_usb2_exit(struct phy *p)
 		val &= ~USB2_INT_ENABLE_UCOM_INTEN;
 	writel(val, usb2_base + USB2_INT_ENABLE);
 
-	return 0;
+unlock:
+	spin_unlock_irqrestore(&channel->lock, flags);
+	return ret;
 }
 
 static int rcar_gen3_phy_usb2_power_on(struct phy *p)
@@ -596,8 +761,10 @@ static int rcar_gen3_phy_usb2_power_on(struct phy *p)
 	struct rcar_gen3_phy *rphy = phy_get_drvdata(p);
 	struct rcar_gen3_chan *channel = rphy->ch;
 	void __iomem *usb2_base = channel->base;
+	int retries = NUM_OF_PHYS;
+	unsigned long flags;
 	u32 val;
-	int ret = 0;
+	int ret;
 
 	if (channel->vbus && !channel->otg_internal_reg) {
 		ret = regulator_enable(channel->vbus);
@@ -605,7 +772,27 @@ static int rcar_gen3_phy_usb2_power_on(struct phy *p)
 			return ret;
 	}
 
-	guard(spinlock_irqsave)(&channel->lock);
+	spin_lock_irqsave(&channel->lock, flags);
+
+	while (retries-- && channel->otg_initializing) {
+		spin_unlock_irqrestore(&channel->lock, flags);
+
+		ret = wait_event_timeout(channel->otg_init_done, !channel->otg_initializing,
+					 USB2_OTG_INIT_TIMEOUT);
+		ret = ret ? 0 : -ETIMEDOUT;
+		if (ret && !retries)
+			goto disable_regulator;
+
+		spin_lock_irqsave(&channel->lock, flags);
+	}
+
+	/* If another thread started a new initialization just return -EBUSY. */
+	if (channel->otg_initializing) {
+		ret = -EBUSY;
+		goto unlock;
+	} else {
+		ret = 0;
+	}
 
 	if (!rcar_gen3_are_all_rphys_power_off(channel))
 		goto out;
@@ -620,27 +807,59 @@ static int rcar_gen3_phy_usb2_power_on(struct phy *p)
 	/* The powered flag should be set for any other phys anyway */
 	rphy->powered = true;
 
-	return 0;
+unlock:
+	spin_unlock_irqrestore(&channel->lock, flags);
+
+disable_regulator:
+	if (ret && channel->vbus && !channel->otg_internal_reg)
+		regulator_disable(channel->vbus);
+
+	return ret;
 }
 
 static int rcar_gen3_phy_usb2_power_off(struct phy *p)
 {
 	struct rcar_gen3_phy *rphy = phy_get_drvdata(p);
 	struct rcar_gen3_chan *channel = rphy->ch;
-	int ret = 0;
+	int retries = NUM_OF_PHYS;
+	unsigned long flags;
+	int ret;
 
-	scoped_guard(spinlock_irqsave, &channel->lock) {
-		rphy->powered = false;
+	spin_lock_irqsave(&channel->lock, flags);
 
-		if (rcar_gen3_are_all_rphys_power_off(channel)) {
-			u32 val = readl(channel->base + USB2_USBCTR);
+	while (retries-- && channel->otg_initializing) {
+		spin_unlock_irqrestore(&channel->lock, flags);
 
-			val |= USB2_USBCTR_PLL_RST;
-			writel(val, channel->base + USB2_USBCTR);
-		}
+		ret = wait_event_timeout(channel->otg_init_done, !channel->otg_initializing,
+					 USB2_OTG_INIT_TIMEOUT);
+		ret = ret ? 0 : -ETIMEDOUT;
+		if (ret && !retries)
+			return ret;
+
+		spin_lock_irqsave(&channel->lock, flags);
 	}
 
-	if (channel->vbus && !channel->otg_internal_reg)
+	/* If another thread started a new initialization just return -EBUSY. */
+	if (channel->otg_initializing) {
+		ret = -EBUSY;
+		goto unlock;
+	} else {
+		ret = 0;
+	}
+
+	rphy->powered = false;
+
+	if (rcar_gen3_are_all_rphys_power_off(channel)) {
+		u32 val = readl(channel->base + USB2_USBCTR);
+
+		val |= USB2_USBCTR_PLL_RST;
+		writel(val, channel->base + USB2_USBCTR);
+	}
+
+unlock:
+	spin_unlock_irqrestore(&channel->lock, flags);
+
+	if (!ret && channel->vbus && !channel->otg_internal_reg)
 		ret = regulator_disable(channel->vbus);
 
 	return ret;
@@ -1022,6 +1241,7 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 		return ret;
 
 	spin_lock_init(&channel->lock);
+	init_waitqueue_head(&channel->otg_init_done);
 	for (i = 0; i < NUM_OF_PHYS; i++) {
 		channel->rphys[i].phy = devm_phy_create(dev, NULL,
 							channel->phy_data->phy_usb2_ops);

