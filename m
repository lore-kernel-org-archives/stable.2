Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362626;
	b=NolI/yAcApbHer48aXWX8yGbZ/QrBmF4lHubWJHbLvJrzkARqhWp5DG7gwMaZyxkL8Wn
	 x9aFr7CEdYo3/Bv0iDFQlEmkA8W+S/OmL6EvsUKnoyXRELo3StrHWj2X2gSMo1MrHuawS
	 YzRaDrgkKVjw135G6WglhNUMkliL0zmpEy1XsbISshKm5e5Hv3/7EuYgjH7khBO9mIvfQ
	 IknvAKpOYptGQkzcgigrPiFA8qaAVCAaHyWbqe7NjGcfww9BQdhRNqtr+Iu6QTRCYnvVG
	 847xuywhersE8pSqX2bIvisCwniIgcJL/0KPjLDiIDLtmu4zsTtm5mvQeQn3U/atUyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362626;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dh1M3AC8AO/18uGl8YhLz/4cSdq5odWcMP6vmmvowqI=;
	b=5MbRGOzd9bCUTNrQVC00Gc7SZyNs9AWRToRS85Zi5KQtcILHxp/0zqk9wJzZ/uTZfoFa
	 Njlj5j31ElRQ4A0F0dLrudqb2O07/TU1Yf6vrCi6nLKanzkMD+ivI64ntZ4rjoY7QW0Dz
	 0BQLkrUz3GRlveZtMMQj/lRFgkiMgI3evwqKfCyIiIU2ylbzRy26fJhtJOaF+8LMOG7xQ
	 7eqh2+XFeB64EKipmN1M1ezeohDsVsiQ/EM9/wcXFKo0/ALcsic5ePTZ+XGZD9O1v1OQq
	 tY3J/4JqOKBfZzCPY79GDWKLsABteoM2gcxvV7Gt+vq3vW1Jukj1ioc9Ro8P50C3vVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M6mpUM7q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E34606A33A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M6mpUM7q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4F71F0089F;
	Wed, 11 Nov 2026 02:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362625;
	bh=dh1M3AC8AO/18uGl8YhLz/4cSdq5odWcMP6vmmvowqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M6mpUM7q5iVJduo0VreCZbs7MmuwgMIkI9ZAUbi6MNTa6UzuG6ZhkZCRN0BB0ISaB
	 3njjjDUKgwdn8zj0KLdp0/vM8kPOv6RCUH4OCfGaPjofUFRPLUSUIFYMRkur8FFh4c
	 NxSiOxSKdEP1CBVYJcDGGhNop2HFdIutaqdpKvwrC0T9I+qQXYSuSRCdbtjmptzXwl
	 XCJLtgSuyooR3d6TSGT233xpeZPcIB3P1lE0J46q62kQYQLWdby++rFW5VdQSWJYcZ
	 osRDusNHR1JbycHwjt15dItztIsf6KfElwOlbrTwhY2gEuXteuO/DgItSnSfWr/UfB
	 +90fvknWQBe4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/6] Input: matrix_keypad - remove support for clustered interrupt
Date: Tue, 10 Nov 2026 21:03:40 -0500
Message-ID: <20261111020056.444668-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111020056.444668-1-sashal@kernel.org>
References: <20261107053642-failed-6.6-1527451f87df@kernel.org>
 <20261111020056.444668-1-sashal@kernel.org>
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

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

[ Upstream commit 5080f62adb126e28d316298505272efea0aed81a ]

There are no users of this functionality in the mainline kernel (it was
only available to boards using platform data and not device tree).
Remove it to simplify the code.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20240805014710.1961677-2-dmitry.torokhov@gmail.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Stable-dep-of: 1527451f87df ("Revert "Input: matrix_keypad - force switch rows to input mode"")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/matrix_keypad.c | 61 ++++++++++----------------
 1 file changed, 22 insertions(+), 39 deletions(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 695c03e075b56..9e6837217f441 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -29,7 +29,6 @@ struct matrix_keypad {
 	unsigned int row_shift;
 
 	unsigned int row_irqs[MATRIX_MAX_ROWS];
-	unsigned int num_row_irqs;
 	DECLARE_BITMAP(wakeup_enabled_irqs, MATRIX_MAX_ROWS);
 
 	uint32_t last_key_state[MATRIX_MAX_COLS];
@@ -89,7 +88,7 @@ static void enable_row_irqs(struct matrix_keypad *keypad)
 {
 	int i;
 
-	for (i = 0; i < keypad->num_row_irqs; i++)
+	for (i = 0; i < keypad->pdata->num_row_gpios; i++)
 		enable_irq(keypad->row_irqs[i]);
 }
 
@@ -97,7 +96,7 @@ static void disable_row_irqs(struct matrix_keypad *keypad)
 {
 	int i;
 
-	for (i = 0; i < keypad->num_row_irqs; i++)
+	for (i = 0; i < keypad->pdata->num_row_gpios; i++)
 		disable_irq_nosync(keypad->row_irqs[i]);
 }
 
@@ -226,7 +225,8 @@ static void matrix_keypad_enable_wakeup(struct matrix_keypad *keypad)
 {
 	int i;
 
-	for_each_clear_bit(i, keypad->wakeup_enabled_irqs, keypad->num_row_irqs)
+	for_each_clear_bit(i, keypad->wakeup_enabled_irqs,
+			   keypad->pdata->num_row_gpios)
 		if (enable_irq_wake(keypad->row_irqs[i]) == 0)
 			__set_bit(i, keypad->wakeup_enabled_irqs);
 }
@@ -235,7 +235,8 @@ static void matrix_keypad_disable_wakeup(struct matrix_keypad *keypad)
 {
 	int i;
 
-	for_each_set_bit(i, keypad->wakeup_enabled_irqs, keypad->num_row_irqs) {
+	for_each_set_bit(i, keypad->wakeup_enabled_irqs,
+			 keypad->pdata->num_row_gpios) {
 		disable_irq_wake(keypad->row_irqs[i]);
 		__clear_bit(i, keypad->wakeup_enabled_irqs);
 	}
@@ -303,48 +304,30 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 		gpio_direction_input(pdata->row_gpios[i]);
 	}
 
-	if (pdata->clustered_irq > 0) {
+	for (i = 0; i < pdata->num_row_gpios; i++) {
+		irq = gpio_to_irq(pdata->row_gpios[i]);
+		if (irq < 0) {
+			err = irq;
+			dev_err(&pdev->dev,
+				"Unable to convert GPIO line %i to irq: %d\n",
+				pdata->row_gpios[i], err);
+			return err;
+		}
+
 		err = devm_request_any_context_irq(&pdev->dev,
-				pdata->clustered_irq,
+				irq,
 				matrix_keypad_interrupt,
-				pdata->clustered_irq_flags,
+				IRQF_TRIGGER_RISING |
+					IRQF_TRIGGER_FALLING,
 				"matrix-keypad", keypad);
 		if (err < 0) {
 			dev_err(&pdev->dev,
-				"Unable to acquire clustered interrupt\n");
+				"Unable to acquire interrupt for GPIO line %i\n",
+				pdata->row_gpios[i]);
 			return err;
 		}
 
-		keypad->row_irqs[0] = pdata->clustered_irq;
-		keypad->num_row_irqs = 1;
-	} else {
-		for (i = 0; i < pdata->num_row_gpios; i++) {
-			irq = gpio_to_irq(pdata->row_gpios[i]);
-			if (irq < 0) {
-				err = irq;
-				dev_err(&pdev->dev,
-					"Unable to convert GPIO line %i to irq: %d\n",
-					pdata->row_gpios[i], err);
-				return err;
-			}
-
-			err = devm_request_any_context_irq(&pdev->dev,
-					irq,
-					matrix_keypad_interrupt,
-					IRQF_TRIGGER_RISING |
-						IRQF_TRIGGER_FALLING,
-					"matrix-keypad", keypad);
-			if (err < 0) {
-				dev_err(&pdev->dev,
-					"Unable to acquire interrupt for GPIO line %i\n",
-					pdata->row_gpios[i]);
-				return err;
-			}
-
-			keypad->row_irqs[i] = irq;
-		}
-
-		keypad->num_row_irqs = pdata->num_row_gpios;
+		keypad->row_irqs[i] = irq;
 	}
 
 	/* initialized as disabled - enabled by input->open */
-- 
2.53.0

