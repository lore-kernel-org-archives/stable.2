Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363475;
	b=XGCMFfvqCDo6UG960UH/tiYeC+6KbmUxiqR5mmTkYVtiTffdVbK+1FTA4t+pLQ4zjRVV
	 VtQcBP0wONNmYEyouq2FzZBhi8O41uFc83uEXoG8TmlaWXvfwXkSfLQ/FJHqbGRq6ErE8
	 QdUpnnXo6UiOwWQGMy0pW0s+Orxi0yOI3C30EYc98eH1QIJ75qG46WTVTvV783FU4hRIk
	 I0spoUmlWBETXbc4rJ0vm1togM5FSxBo7vuJ77c6KTFFBZzVrpKdvZXBj6dGz8wKt2DNV
	 5SBkZx5pr2nPgdcAJ78FUoYCjsXGC+Kh+esdnwrtvHxzpqx8fHSOSuruzZ5FUfRYeLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363475;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vUeohrxDKS7jSzXBy4TmBomdmBmXsWj+AEroPC73T/E=;
	b=4KoBcPulE/OyJKaKv/C8veGxgUBTQbNSxND3V6Y5u0454EPlMMKRqDwNxZXcXJGLieev
	 CuNkd8mTxHS/ql9Z9n9uy8HVVZj8DBVp9hOpM7JrZt859/RsOIaPbPptd0ck16nb7di3k
	 UDOUuQyaI60DB026rnczGzyRYz1OxT7ynPqyQrHkq2xl4VxSxpOFmlwmb6vCnHh4Nfg3n
	 KIhaPkgHSlRl/WGylKFuYTcRwqG94GWfCwH2W6ygYevRJCW5knNOgVb/Ob+Evq0D5xM1Z
	 duLYR15ZWvX962NWf4bSCDR3scU8L7bfjNUX+nUlfvyAM507Ww1/bp6lsP+tu4YCNpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ORIElTq8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DCD606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ORIElTq8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6655F1F00A00;
	Wed, 11 Nov 2026 02:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794363474;
	bh=vUeohrxDKS7jSzXBy4TmBomdmBmXsWj+AEroPC73T/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ORIElTq8igl39hYuW/Y8SSsWW5hQqnXxB2Cqy3OtYpzh1UxycXJetwU10RXOEjbWS
	 FIbrvGLUAwEFYyyCeN0PRnwXRojxJCznsjRif7e/Zbq6izXO5weYBgW+WIrExw/XNH
	 ranwzqktp9MKUA1lidWhzt0kSd1blTIOSquOSp9psBUYKMA5Ni9kFwmTD10v+fLQ2J
	 r9yA5Ksx6SicQyGqk+I6EU+LEMw1d1EcWWxszAgYK4bksJ6eVqkEnOieg8kvxAueOw
	 d4TRYXvyoi9o28JGaQtABl87M3RwIWB90uI8h1HML54kDm0W2k5J/g8f9wIZJYNSDq
	 hmA1l4TOARiIw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sahaj Chaudhari <sahaj123.sc@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] gpio: pca953x: Handle direction register read errors in IRQ paths
Date: Tue, 10 Nov 2026 21:17:52 -0500
Message-ID: <20261111021736.618882-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111021736.618882-1-sashal@kernel.org>
References: <20261107055216-failed-6.1-a0fe26929350@kernel.org>
 <20261111021736.618882-1-sashal@kernel.org>
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
index 3ad235cd740be..5bf0964c16dde 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -766,6 +766,7 @@ static void pca953x_irq_bus_sync_unlock(struct irq_data *d)
 	DECLARE_BITMAP(irq_mask, MAX_LINE);
 	DECLARE_BITMAP(reg_direction, MAX_LINE);
 	int level;
+	int ret;
 
 	guard(mutex)(&chip->i2c_lock);
 
@@ -780,7 +781,9 @@ static void pca953x_irq_bus_sync_unlock(struct irq_data *d)
 	}
 
 	/* Switch direction to input if needed */
-	pca953x_read_regs(chip, chip->regs->direction, reg_direction);
+	ret = pca953x_read_regs(chip, chip->regs->direction, reg_direction);
+	if (ret)
+		goto out;
 
 	bitmap_or(irq_mask, chip->irq_trig_fall, chip->irq_trig_raise, gc->ngpio);
 	bitmap_complement(reg_direction, reg_direction, gc->ngpio);
@@ -790,6 +793,7 @@ static void pca953x_irq_bus_sync_unlock(struct irq_data *d)
 	for_each_set_bit(level, irq_mask, gc->ngpio)
 		pca953x_gpio_direction_input_unlocked(&chip->gpio_chip, level);
 
+out:
 	mutex_unlock(&chip->irq_lock);
 }
 
@@ -856,7 +860,9 @@ static bool pca953x_irq_pending(struct pca953x_chip *chip, unsigned long *pendin
 		return false;
 
 	/* Remove output pins from the equation */
-	pca953x_read_regs(chip, chip->regs->direction, reg_direction);
+	ret = pca953x_read_regs(chip, chip->regs->direction, reg_direction);
+	if (ret)
+		return false;
 
 	bitmap_copy(old_stat, chip->irq_stat, gc->ngpio);
 
@@ -941,7 +947,9 @@ static int pca953x_irq_setup(struct pca953x_chip *chip, int irq_base)
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

