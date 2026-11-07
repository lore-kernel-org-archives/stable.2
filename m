Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047846;
	b=wkZAXNAgP5Wa9K3+qt6RE3lQyhm7Qg5xft4g8y+fvLYaaEoa0CsSfvnLV/TmW/dRZ4Sr
	 yNJ0hcdt87brIYrgWfjM31eoao4ZUEEpEkx6AKelpbVcULCdS2UBvj5PulN+Ei3rpCi+8
	 lJcBCKoPH79nG7uHX+4XZx8qm7P7UsbhCqBUyiJB/pmCKpi2cSfWOFxsq19iUYbxmpCG8
	 f77tAa2XVI/SLI+lUCu0gfHKEXEfsLzVxSuSQZ+zBBChs/g6Z5v2lA/YmznboImRzksW6
	 FaSDHaC7KsgAUv/3Q8YqxMXY3t95JUW9U6FH037EEFTq7NagZWxgE9BiYYGWaNLRnIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047846;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6Ajtz5qp68YrUlAe52wZx4HdhLVpKjsCZC7uiZ9tFVU=;
	b=YsnPH/wN8dax9lcWIX5V/IxLWIFcQ4ZZDWsOcGlZ4kJVZqezj8T9uaj/7WTDsixNbdNF
	 +rGap0lBZQOI2lwpfDal9k0bj/T1HhKdQL466DAK+8UBE8lu6xgwkC+ErQtpuSW9mUjpc
	 aAkDah58ugY5SaQsO1tvwoEhn38FaPTCqVNRdpBytghwBOeJYJw4HV+a8O1a18MNafAfL
	 BWxZ7o+M8JcjVeGKziUTOMJJJPxXjcMkUFGTrI7W+C/vcubbTVaqqO9JsTUYZ/FGLfSf1
	 I8eKzol1J57HWoSwuAncvLX9TmzzRGf8T6Hx6qeYFzC5YdTpXjfijxp5J7oecu4U9bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BR2rvgse;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F77606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BR2rvgse
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C071F0089F;
	Sat,  7 Nov 2026 10:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047845;
	bh=6Ajtz5qp68YrUlAe52wZx4HdhLVpKjsCZC7uiZ9tFVU=;
	h=From:To:Cc:Subject:Date;
	b=BR2rvgserLvFrH/+rGG9LPOrZThU+yKuzIJUOypBRgdw1xI/yGGtZGF/BAYgk3RVa
	 D8k/qiJbm8+kD0+5PTC20wMO5XwWg989j19fT5JvJdPs0o/CmRRlG7ykfGb6ju9ZU6
	 z8Ql1KvhXztWlpdiFE6puhr7DS6J1beQAkUFaBugrqpTgH+/MCtIKTZF39yo87WjP7
	 H/PmexYDQB7QZ6jiW4s7W3BHUviRf7+yWsVE11HvFCe52EaePNJWclEhuSxQ+aKOsT
	 kJIDTzsH61tp9d0BKG5OVO7izRIp6VtUvsT/sDs6RDB278Rzpa1tGv5ZVAsK+StKuF
	 tUAHz79Q3s3QA==
From: Sasha Levin <sashal@kernel.org>
To: sahaj123.sc@gmail.com,
	bartosz.golaszewski@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] gpio: pca953x: Handle direction register read errors in IRQ paths" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:37:24 -0500
Message-ID: <20261107053724-failed-6.6-a0fe26929350@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x a0fe269293509acdd93b9cfb3f46636f7b91b33a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053724-failed-6.6-a0fe26929350@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a0fe269293509acdd93b9cfb3f46636f7b91b33a Mon Sep 17 00:00:00 2001
From: Sahaj Chaudhari <sahaj123.sc@gmail.com>
Date: Sun, 18 Oct 2026 22:20:03 +0530
Subject: [PATCH] gpio: pca953x: Handle direction register read errors in IRQ
 paths

Three IRQ paths ignore the result of reading the direction registers
and then use the destination bitmap. pca953x_read_regs() does not populate
that bitmap when regmap_bulk_read() fails, leaving the callers to use
uninitialized stack data.

This can select incorrect GPIOs for direction changes during IRQ bus
synchronization, corrupt the saved input state during IRQ setup, or
produce incorrect pending interrupt decisions.

Check the read result at all three sites. Release irq_lock without
changing GPIO directions on failure, leave the IRQ history untouched
when pending detection fails, and propagate the error from IRQ setup.
The read helper already logs the error.

Fixes: 0f25fda840a9 ("gpio: pca953x: Zap ad-hoc reg_direction cache")
Cc: stable@vger.kernel.org
Signed-off-by: Sahaj Chaudhari <sahaj123.sc@gmail.com>
Link: https://patch.msgid.link/20261018165003.3372368-1-sahaj123.sc@gmail.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpio-pca953x.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 869ed4264d48a..afec5ec236968 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -867,6 +867,7 @@ static void pca953x_irq_bus_sync_unlock(struct irq_data *d)
 	DECLARE_BITMAP(irq_mask, MAX_LINE);
 	DECLARE_BITMAP(reg_direction, MAX_LINE);
 	int level;
+	int ret;
 
 	guard(mutex)(&chip->i2c_lock);
 
@@ -885,7 +886,9 @@ static void pca953x_irq_bus_sync_unlock(struct irq_data *d)
 	}
 
 	/* Switch direction to input if needed */
-	pca953x_read_regs(chip, chip->regs->direction, reg_direction);
+	ret = pca953x_read_regs(chip, chip->regs->direction, reg_direction);
+	if (ret)
+		goto out;
 
 	bitmap_or(irq_mask, chip->irq_trig_fall, chip->irq_trig_raise, gc->ngpio);
 	bitmap_or(irq_mask, irq_mask, chip->irq_trig_level_high, gc->ngpio);
@@ -895,6 +898,7 @@ static void pca953x_irq_bus_sync_unlock(struct irq_data *d)
 	for_each_andnot_bit(level, irq_mask, reg_direction, gc->ngpio)
 		pca953x_gpio_direction_input_unlocked(&chip->gpio_chip, level);
 
+out:
 	mutex_unlock(&chip->irq_lock);
 }
 
@@ -989,7 +993,9 @@ static bool pca953x_irq_pending(struct pca953x_chip *chip, unsigned long *pendin
 	}
 
 	/* Remove output pins from the equation */
-	pca953x_read_regs(chip, chip->regs->direction, reg_direction);
+	ret = pca953x_read_regs(chip, chip->regs->direction, reg_direction);
+	if (ret)
+		return false;
 
 	bitmap_copy(old_stat, chip->irq_stat, gc->ngpio);
 
@@ -1089,7 +1095,9 @@ static int pca953x_irq_setup(struct pca953x_chip *chip, int irq_base)
 	 * interrupt.  We have to rely on the previous read for
 	 * this purpose.
 	 */
-	pca953x_read_regs(chip, chip->regs->direction, reg_direction);
+	ret = pca953x_read_regs(chip, chip->regs->direction, reg_direction);
+	if (ret)
+		return ret;
 	bitmap_and(chip->irq_stat, irq_stat, reg_direction, gc->ngpio);
 	mutex_init(&chip->irq_lock);
 
-- 
2.53.0




