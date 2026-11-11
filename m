Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363215;
	b=Xk39nxXCu+KbG5LhNW2jsIZpGI/ZJlHM7GCaLWL6j04ouHybow1HLWtaMtTmB+ObDq1H
	 X0IJaYzpotOtTAYdRGawdWwGk2syCH628ItdPIR/f/pGBTXa3VTgZwvWW+YL1eeSpYPs/
	 +mw4NPy78wEayPyMafQfs3MuklVJelsY0kek/FLl6Dxaey+R+SAYDbfr8XbJRT/k5I+nc
	 bDdVA/NOOJMtqTLMb19VpDEiA6m1PHbeFXZaQh7zWQgDspAPfokR9reU+LvVexaM1HOwx
	 sPTKVVNtqx08uNusMtkqbiqL+KIlLyYP4Q/Nb9LqtqjH91Ii5JHPh41oZO+2V1RlLTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363215;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VwMP08Z2C6Eag0tointo2QY43BTaktJdOo5lQz9Ut4Q=;
	b=V7vXOxrtMUCQsJyxKvw03RtPLNamQg5lsckmkZJAjDr967BjdRbQ6r9g9mbm0pJJcD8Z
	 lPRdJK9Vk5PXsWVgpPv3PBiyHEdgzVkNusRV/wYihYcxjdk+0ZVfy8M6EBx5jbQFbzslz
	 SR64J+LGgImXr2qEwWS6wW09lfbirYL/3GWzmHpOYwmUfkoBt1VNt+YrMWhgiLVuCfWLN
	 5r8+YhzpCgVkY2jIeGOesrZwiea945JBMbq1C1zHb7ol1anBXBNOcadIipnWtxhUmqZVC
	 uOif3VzEm72oTW13LOoFgjBxBYKhLoliSCxo0NtYEOZ3BfEoj2+MtvW9Kn6nsLDMt9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Bx/8G/n2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71C2606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bx/8G/n2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F451F00A00;
	Wed, 11 Nov 2026 02:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794363215;
	bh=VwMP08Z2C6Eag0tointo2QY43BTaktJdOo5lQz9Ut4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bx/8G/n24A0ruK+1gt2f+adEpPd6qWjQJWTR62Ffenqey0Se7XF7agaseTmksQDta
	 +RdD4EwuBUrmf9rMO83nJKJlRZz0VApel/Y2nYRMknTm3RUwDyjURyh8ywZVxSxx7K
	 n14yQZtlQ9Ol02CbeLwauWx4VPGfkj32q2EDp89dT+W6OKDZkZbUv0IsUgyH9Epigi
	 rZGfU9Onr2tjbv1KGkjHAfqdgB1rJRUhPCEezjn125ZU26zAvfzVJkgQ63HMc8y7DP
	 uZC2z4I2ohUvPb5yxaH1P9toOumuUWbTwTL7ZkhVBVkIePHUff/Z6TMzoiQxmsHW0I
	 8IWqrSJV5hg8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sahaj Chaudhari <sahaj123.sc@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] gpio: pca953x: Handle direction register read errors in IRQ paths
Date: Tue, 10 Nov 2026 21:13:33 -0500
Message-ID: <20261111021326.573042-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111021326.573042-1-sashal@kernel.org>
References: <20261107053724-failed-6.6-a0fe26929350@kernel.org>
 <20261111021326.573042-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sahaj Chaudhari <sahaj123.sc@gmail.com>

[ Upstream commit a0fe269293509acdd93b9cfb3f46636f7b91b33a ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-pca953x.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index 6384c0760e0ee..dacb936ead643 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -763,6 +763,7 @@ static void pca953x_irq_bus_sync_unlock(struct irq_data *d)
 	DECLARE_BITMAP(irq_mask, MAX_LINE);
 	DECLARE_BITMAP(reg_direction, MAX_LINE);
 	int level;
+	int ret;
 
 	guard(mutex)(&chip->i2c_lock);
 
@@ -777,7 +778,9 @@ static void pca953x_irq_bus_sync_unlock(struct irq_data *d)
 	}
 
 	/* Switch direction to input if needed */
-	pca953x_read_regs(chip, chip->regs->direction, reg_direction);
+	ret = pca953x_read_regs(chip, chip->regs->direction, reg_direction);
+	if (ret)
+		goto out;
 
 	bitmap_or(irq_mask, chip->irq_trig_fall, chip->irq_trig_raise, gc->ngpio);
 	bitmap_or(irq_mask, irq_mask, chip->irq_trig_level_high, gc->ngpio);
@@ -789,6 +792,7 @@ static void pca953x_irq_bus_sync_unlock(struct irq_data *d)
 	for_each_set_bit(level, irq_mask, gc->ngpio)
 		pca953x_gpio_direction_input_unlocked(&chip->gpio_chip, level);
 
+out:
 	mutex_unlock(&chip->irq_lock);
 }
 
@@ -883,7 +887,9 @@ static bool pca953x_irq_pending(struct pca953x_chip *chip, unsigned long *pendin
 	}
 
 	/* Remove output pins from the equation */
-	pca953x_read_regs(chip, chip->regs->direction, reg_direction);
+	ret = pca953x_read_regs(chip, chip->regs->direction, reg_direction);
+	if (ret)
+		return false;
 
 	bitmap_copy(old_stat, chip->irq_stat, gc->ngpio);
 
@@ -984,7 +990,9 @@ static int pca953x_irq_setup(struct pca953x_chip *chip, int irq_base)
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

