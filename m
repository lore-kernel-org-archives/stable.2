Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13972489895
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082033; cv=none; b=Os0gYTvmDdeVo/5idMumKgtrYRCol5RpEHJcjOB85ui4YuAMx13rlxTtVxQT5e9xw/gCRCXnJAykr3PjpYpBiVOBXc4pQgaC/5KVqAmsxO1Wz4i9SUdDFsc4F0ewcCBPxFDqxX/n17Pc+SN4S6SRvEhfzMNOLOGqUW+D7dQZPjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082033; c=relaxed/simple;
	bh=VpNmftKESgQS7k7vVzyVR1fNR1FeHDfNt5cO50P5Hcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GlRsugrpdX3ZLh6eZj3CpKGxJ96/4kHufymxrHGot+JcqZsMzC4adli1MCrbLGvglFBmGxKP5Z0Yn+5NqG11/tVUz+Qo1XNCjFP8D6+EqemhjJ2CLKsp/jYdW3rC+ZRbrVbO30slmP6r2Y9TDeDK6AAG3BJz+AVXq9u7L3JXPr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2EBAXWO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2EBAXWO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC061F000FF;
	Tue, 22 Sep 2026 13:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790082031;
	bh=n09Bzz0mxyA98Nhd2ahJq9QOTtWr2yO4aGNlZxRCe78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j2EBAXWOqVl5lTrZiUNF4woyJbvE9hn7g7G2vqNxxc9RbhgLQ9Zdov+tBomGsv7bM
	 G9qOO3yTZ9i6V/ucIj1pS5L2tJ1zR84tL/rBPJSwoEeXKj4/McTShyBbuWtgglawr5
	 8tGaZlU9Ga9Hm6KCkXQRKHWIHAwS5V0lOLc3hezKaeB8nUkWNPHYJdihVMwYXYcqR2
	 afGyGBytQ1bcF4MXcnKciqJH0VQ3fDsUnf6rub8KFc9thAtHVNNn9pI7zqZ3UeRTT6
	 srHYRUdFlNxHoe+J4DP7HCstLh/KW+jWXb4BrHQETS7UdAvCFpjhr6Ox4dbi8C2cRW
	 cv6Fy1xkk/7rA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Pavel Machek <pavel@nabladev.com>,
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] phy: renesas: rcar-gen3-usb2: Avoid long delay in atomic context
Date: Tue, 22 Sep 2026 09:00:29 -0400
Message-ID: <20260922130029.2357605-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092223-uneaten-padding-7cb4@gregkh>
References: <2026092223-uneaten-padding-7cb4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

[ Upstream commit 48e97c59a49c9e90270f5e3d221db253b76de5da ]

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
[ adapted newer SoC configuration references to Linux 6.12’s existing channel structure. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 302 ++++++++++++++++++++---
 1 file changed, 261 insertions(+), 41 deletions(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index c7d6321981e06..f457225239b18 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -25,6 +25,7 @@
 #include <linux/reset.h>
 #include <linux/string.h>
 #include <linux/usb/of.h>
+#include <linux/wait.h>
 #include <linux/workqueue.h>
 
 /******* USB2.0 Host registers (original offset is +0x200) *******/
@@ -90,6 +91,13 @@
 #define USB2_OBINT_IDCHG_EN		BIT(0)
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
@@ -120,6 +128,7 @@ struct rcar_gen3_chan {
 	struct rcar_gen3_phy rphys[NUM_OF_PHYS];
 	struct regulator *vbus;
 	struct work_struct work;
+	wait_queue_head_t otg_init_done;
 	spinlock_t lock;	/* protects access to hardware and driver data structure. */
 	enum usb_dr_mode dr_mode;
 	u32 obint_enable_bits;
@@ -127,6 +136,13 @@ struct rcar_gen3_chan {
 	bool is_otg_channel;
 	bool uses_otg_pins;
 	bool soc_no_adp_ctrl;
+	/*
+	 * The OTG can be initialized only once and needs to release the spinlock
+	 * and wait for 20 ms due to hardware constraints. If a thread executes
+	 * PHY configuration code while the OTG PHY is waiting for the 20 ms, the
+	 * thread will have to wait for the OTG PHY initialization to complete.
+	 */
+	bool otg_initializing;
 };
 
 struct rcar_gen3_phy_drv_data {
@@ -346,26 +362,58 @@ static ssize_t role_store(struct device *dev, struct device_attribute *attr,
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
+
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
 
-	if (sysfs_streq(buf, "host"))
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
@@ -379,7 +427,10 @@ static ssize_t role_store(struct device *dev, struct device_attribute *attr,
 			rcar_gen3_init_for_peri(ch);
 	}
 
-	return count;
+unlock:
+	spin_unlock_irqrestore(&ch->lock, flags);
+exit:
+	return ret ?: count;
 }
 
 static ssize_t role_show(struct device *dev, struct device_attribute *attr,
@@ -395,14 +446,11 @@ static ssize_t role_show(struct device *dev, struct device_attribute *attr,
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
@@ -416,7 +464,11 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
 		val = readl(usb2_base + USB2_ADPCTRL);
 		writel(val | USB2_ADPCTRL_IDPULLUP, usb2_base + USB2_ADPCTRL);
 	}
-	mdelay(20);
+}
+
+static void rcar_gen3_init_otg_phase1(struct rcar_gen3_chan *ch)
+{
+	void __iomem *usb2_base = ch->base;
 
 	writel(0xffffffff, usb2_base + USB2_OBINTSTA);
 	writel(ch->obint_enable_bits, usb2_base + USB2_OBINTEN);
@@ -430,6 +482,7 @@ static irqreturn_t rcar_gen3_phy_usb2_irq(int irq, void *_ch)
 	void __iomem *usb2_base = ch->base;
 	struct device *dev = ch->dev;
 	irqreturn_t ret = IRQ_NONE;
+	unsigned long flags;
 	u32 status;
 
 	pm_runtime_get_noresume(dev);
@@ -437,29 +490,98 @@ static irqreturn_t rcar_gen3_phy_usb2_irq(int irq, void *_ch)
 	if (pm_runtime_suspended(dev))
 		goto rpm_put;
 
-	scoped_guard(spinlock, &ch->lock) {
-		status = readl(usb2_base + USB2_OBINTSTA);
-		if (status & ch->obint_enable_bits) {
-			dev_vdbg(dev, "%s: %08x\n", __func__, status);
-			writel(ch->obint_enable_bits, usb2_base + USB2_OBINTSTA);
-			rcar_gen3_device_recognition(ch);
-			ret = IRQ_HANDLED;
-		}
+	spin_lock_irqsave(&ch->lock, flags);
+
+	status = readl(usb2_base + USB2_OBINTSTA);
+	if (status & ch->obint_enable_bits) {
+		dev_vdbg(dev, "%s: %08x\n", __func__, status);
+		writel(ch->obint_enable_bits, usb2_base + USB2_OBINTSTA);
+
+		ret = IRQ_HANDLED;
+
+		/* This should not happen! */
+		if (ch->otg_initializing)
+			goto unlock;
+
+		rcar_gen3_device_recognition(ch);
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
+	 * Don't report channel->obint_enable_bits IRQs. These are
+	 * unmasked anyway in rcar_gen3_init_otg_phase1().
+	 */
+	val = readl(usb2_base + USB2_OBINTEN);
+	val &= ~channel->obint_enable_bits;
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
@@ -472,12 +594,30 @@ static int rcar_gen3_phy_usb2_init(struct phy *p)
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
 
 	rphy->initialized = true;
 
-	return 0;
+unlock:
+	spin_unlock_irqrestore(&channel->lock, flags);
+
+	return ret;
 }
 
 static int rcar_gen3_phy_usb2_exit(struct phy *p)
@@ -485,9 +625,32 @@ static int rcar_gen3_phy_usb2_exit(struct phy *p)
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
 
@@ -497,7 +660,9 @@ static int rcar_gen3_phy_usb2_exit(struct phy *p)
 		val &= ~USB2_INT_ENABLE_UCOM_INTEN;
 	writel(val, usb2_base + USB2_INT_ENABLE);
 
-	return 0;
+unlock:
+	spin_unlock_irqrestore(&channel->lock, flags);
+	return ret;
 }
 
 static int rcar_gen3_phy_usb2_power_on(struct phy *p)
@@ -505,8 +670,10 @@ static int rcar_gen3_phy_usb2_power_on(struct phy *p)
 	struct rcar_gen3_phy *rphy = phy_get_drvdata(p);
 	struct rcar_gen3_chan *channel = rphy->ch;
 	void __iomem *usb2_base = channel->base;
+	int retries = NUM_OF_PHYS;
+	unsigned long flags;
 	u32 val;
-	int ret = 0;
+	int ret;
 
 	if (channel->vbus) {
 		ret = regulator_enable(channel->vbus);
@@ -514,7 +681,27 @@ static int rcar_gen3_phy_usb2_power_on(struct phy *p)
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
@@ -529,27 +716,59 @@ static int rcar_gen3_phy_usb2_power_on(struct phy *p)
 	/* The powered flag should be set for any other phys anyway */
 	rphy->powered = true;
 
-	return 0;
+unlock:
+	spin_unlock_irqrestore(&channel->lock, flags);
+
+disable_regulator:
+	if (ret && channel->vbus)
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
+	}
+
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
 	}
 
-	if (channel->vbus)
+unlock:
+	spin_unlock_irqrestore(&channel->lock, flags);
+
+	if (!ret && channel->vbus)
 		ret = regulator_disable(channel->vbus);
 
 	return ret;
@@ -763,6 +982,7 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 		channel->obint_enable_bits = USB2_OBINT_IDCHG_EN;
 
 	spin_lock_init(&channel->lock);
+	init_waitqueue_head(&channel->otg_init_done);
 	for (i = 0; i < NUM_OF_PHYS; i++) {
 		channel->rphys[i].phy = devm_phy_create(dev, NULL,
 							phy_data->phy_usb2_ops);
-- 
2.53.0

