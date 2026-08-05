Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB5D42B731
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 11:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785929936; cv=none; b=A3tG/6NA6pClxmYohGEcRqJd4n/nEw1HKAaTF+UPJkPmshIPAQwK2TCK0815ttP6zGSfqheJthsAx8DU9WompNbWICkD6gFwcnJ6nosRsRz67lY4gTtYPvDVQyaHw85oN6tEZDD3tQuq74ABhWHK7g/WbpNhMESIGcTwJSlhXsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785929936; c=relaxed/simple;
	bh=DQHqDdW0pZOiv5bUjFfJZluWbai/erVOJt2xlL13w6M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=vCTnloos6jmLimo43Q7GWD3ojXeTmw/ijtLMUPH2dlMy5l+VhuDBsD1YPc3+bdxK0kCA7kjv42YzJybPHyl1mNxTUMBPr7fg+eu88BYT7nmje7U50Cp7eU8XJ1fi3ifkK8ayg9BkOymaD3+tEv/qyKwvMXdXC3go2AMzdvTYIw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MZLAmqWb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MZLAmqWb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B549B1F000E9;
	Wed,  5 Aug 2026 11:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785929934;
	bh=4Ow8fPae6VehR/ADlEsjpFaxXVnxRCgbeQemr5zPS9s=;
	h=Subject:To:Cc:From:Date;
	b=MZLAmqWbLiWfLEL7AtVI8MxJXofyWy4XQV82McMtrEtGu3RbJGUEoDfSalrtX7tlP
	 QFfSr6pejRBjffDJU2BeORkmHZe8O6kkXrt3CDLzaeJ+og0Sbg7S2wIabUVmnC10qK
	 T9QaKXpXla8kIiAPdcAP0pV/4dxkbWaT8ZwLn7WE=
Subject: FAILED: patch "[PATCH] gpio: pca953x: fix pca953x_irq_bus_sync_unlock regmap lock" failed to apply to 6.18-stable tree
To: mark.tomlinson@alliedtelesis.co.nz,bartosz.golaszewski@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:38:29 +0200
Message-ID: <2026080529-subsystem-decorator-c2e3@gregkh>
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
git cherry-pick -x 9dc325327babe7f159e84cbe9380a45342da0585
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080529-subsystem-decorator-c2e3@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9dc325327babe7f159e84cbe9380a45342da0585 Mon Sep 17 00:00:00 2001
From: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Date: Thu, 9 Jul 2026 16:51:16 +1200
Subject: [PATCH] gpio: pca953x: fix pca953x_irq_bus_sync_unlock regmap lock

Locking is disabled in the regmap config as this driver uses its own
lock. This means that all calls to regmap functions (read or write) must
hold the i2c_lock. The function pca953x_irq_bus_sync_unlock() did not do
this, and it was therefore possible that multiple threads could cause an
incorrect register to be read/written.

A previous patch partly fixed this, but only protected the write to the
interrupt mask register, and not the read from the direction register.

Fixes: bfc6444b57dc ("gpio: pca953x: fix pca953x_irq_bus_sync_unlock race")
Cc: stable@vger.kernel.org
Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Link: https://patch.msgid.link/20260709045116.2304246-1-mark.tomlinson@alliedtelesis.co.nz
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index f6b870b7b352..e03bf1b12091 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -604,20 +604,28 @@ static int pca953x_read_regs(struct pca953x_chip *chip, int reg, unsigned long *
 	return 0;
 }
 
-static int pca953x_gpio_direction_input(struct gpio_chip *gc, unsigned off)
+static int pca953x_gpio_direction_input_unlocked(struct gpio_chip *gc,
+						 unsigned int off)
 {
 	struct pca953x_chip *chip = gpiochip_get_data(gc);
 	u8 dirreg = chip->recalc_addr(chip, chip->regs->direction, off);
 	u8 bit = pca953x_get_bit_mask(chip, off);
 
-	guard(mutex)(&chip->i2c_lock);
-
 	if (PCA_CHIP_TYPE(chip->driver_data) == TCA6418_TYPE)
 		return regmap_update_bits(chip->regmap, dirreg, bit, 0);
 
 	return regmap_update_bits(chip->regmap, dirreg, bit, bit);
 }
 
+static int pca953x_gpio_direction_input(struct gpio_chip *gc, unsigned int off)
+{
+	struct pca953x_chip *chip = gpiochip_get_data(gc);
+
+	guard(mutex)(&chip->i2c_lock);
+
+	return pca953x_gpio_direction_input_unlocked(gc, off);
+}
+
 static int pca953x_gpio_direction_output(struct gpio_chip *gc,
 		unsigned off, int val)
 {
@@ -855,9 +863,10 @@ static void pca953x_irq_bus_sync_unlock(struct irq_data *d)
 	DECLARE_BITMAP(reg_direction, MAX_LINE);
 	int level;
 
+	guard(mutex)(&chip->i2c_lock);
+
 	if (chip->driver_data & PCA_PCAL) {
 		DECLARE_BITMAP(latched_inputs, MAX_LINE);
-		guard(mutex)(&chip->i2c_lock);
 
 		/* Enable latch on edge-triggered interrupt-enabled inputs */
 		bitmap_or(latched_inputs, chip->irq_trig_fall, chip->irq_trig_raise, gc->ngpio);
@@ -879,7 +888,7 @@ static void pca953x_irq_bus_sync_unlock(struct irq_data *d)
 
 	/* Look for any newly setup interrupt */
 	for_each_andnot_bit(level, irq_mask, reg_direction, gc->ngpio)
-		pca953x_gpio_direction_input(&chip->gpio_chip, level);
+		pca953x_gpio_direction_input_unlocked(&chip->gpio_chip, level);
 
 	mutex_unlock(&chip->irq_lock);
 }

