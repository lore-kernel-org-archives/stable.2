Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362624;
	b=1QkUNmDL4V/9fYGXoGKMWbs1JMehr5wd9HDCZ7h23X+E25aTBKOmZYZ48GYnNMCcv9V+
	 AjdfHgnO5EU087L/BCzLUXH7MQHZLz/u/5rnRmoLmD5r/1tqkW5wqzUcJeoFqTNCKxdMz
	 1eynFealYwYfDTvSQ4ht+WTitRfOpm0yUM/Cgos2HP1crHSB6kDxMFpii2StOAjplswBt
	 CdzRUjcAt6aAZGArU4UUy24uEeJhrHUv/bMRCKEtYek7R0KIL4OzP9BpI1I6q0UnKcFM0
	 T6fqyJ9S03h01UOIQw5GKlWiQSNyEGokMHA7xQkCJFX2rgtQrbrbJmsvkCndP6Tsjmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362624;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8R5yhFTudALwYSqbvobKCTz6CjbJG29FFaSWu1j0pY0=;
	b=q83+p+IOhZTEBTEbhcCZuYavuJA113VCjD1ubI1DDTY4kEgsNMrpuFT6mprA72KA4IqZ
	 nCiIZU7PqgPXwWjusAJtQ5vrGiGmK7yVc7NYJua75Wdb2jj9QsU/jACoTxz2Ly9/vdW2F
	 eVVlO/Mt738JPg8rjYANlgfhWXUX7g/EqcRC0vd/QoDjErvLx7MrL2TXWIK0u9764Mkbu
	 FLHKsFAi+/IjImJPG+ZMkA4+f1eStssAYaTHzMtqDvclSmcjK46D5/e/nR8DyYlrJL2gW
	 buuibuwZipQaHm7zcT3NG0DW2KO9qRQ3tCh6WrsmV5H1eo+db9TXCTVjRbUEgpxVVXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dTLXsfPP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DB7606A333
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dTLXsfPP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86B81F0089F;
	Wed, 11 Nov 2026 02:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362624;
	bh=8R5yhFTudALwYSqbvobKCTz6CjbJG29FFaSWu1j0pY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dTLXsfPPwsfBhvh3Wmk1MH/yXnhuf8e/GJej6O4fwS5oKE4n0Ix1J5BgRSNTgJzYd
	 eTkzma4RwMFjxYH+XAx/oofHMMHkyITTguRY4Q3h5yBGaSLkmwwfTIgppPStjvyPAZ
	 1U2fM9VradwG+edYSD9/cZhjmLWb+AKZwn8CKGt5YuPkfKdn1N9udgTxqSN9TKOrwM
	 zSE1GMMb23uo4LqHHnyMZmm+jRzMKvr+os5prN04v2zacavt8ytHkytY9TQzENpq+G
	 HY/CAmwXeGjD3Zqlep9bW81j5zzoOk4N3/Nl+7i27dLlInQBieTPEsMN0eE4Nj/2CC
	 l7H6O1hnPSbiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/6] Input: matrix_keypad - consolidate handling of clustered interrupt
Date: Tue, 10 Nov 2026 21:03:38 -0500
Message-ID: <20261111020056.444668-3-sashal@kernel.org>
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

[ Upstream commit 8cf4b3683a713a4b54d44565e8a32b4cca357084 ]

Now that the driver stores interrupt numbers corresponding to individual
GPIOs in non-clustered mode, it is possible to unify handling of both
modes by storing clustered interrupt at position 0 and setting the
number of interrupts in this case to 1.

Link: https://lore.kernel.org/r/20240121053232.276968-2-dmitry.torokhov@gmail.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Stable-dep-of: 1527451f87df ("Revert "Input: matrix_keypad - force switch rows to input mode"")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/matrix_keypad.c | 63 ++++++++------------------
 1 file changed, 20 insertions(+), 43 deletions(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 1cd1ffb80401a..44ef600b8f191 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -27,9 +27,10 @@ struct matrix_keypad {
 	const struct matrix_keypad_platform_data *pdata;
 	struct input_dev *input_dev;
 	unsigned int row_shift;
-	unsigned int row_irqs[MATRIX_MAX_ROWS];
 
-	DECLARE_BITMAP(disabled_gpios, MATRIX_MAX_ROWS);
+	unsigned int row_irqs[MATRIX_MAX_ROWS];
+	unsigned int num_row_irqs;
+	DECLARE_BITMAP(wakeup_enabled_irqs, MATRIX_MAX_ROWS);
 
 	uint32_t last_key_state[MATRIX_MAX_COLS];
 	struct delayed_work work;
@@ -86,28 +87,18 @@ static bool row_asserted(const struct matrix_keypad_platform_data *pdata,
 
 static void enable_row_irqs(struct matrix_keypad *keypad)
 {
-	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
 	int i;
 
-	if (pdata->clustered_irq > 0)
-		enable_irq(pdata->clustered_irq);
-	else {
-		for (i = 0; i < pdata->num_row_gpios; i++)
-			enable_irq(keypad->row_irqs[i]);
-	}
+	for (i = 0; i < keypad->num_row_irqs; i++)
+		enable_irq(keypad->row_irqs[i]);
 }
 
 static void disable_row_irqs(struct matrix_keypad *keypad)
 {
-	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
 	int i;
 
-	if (pdata->clustered_irq > 0)
-		disable_irq_nosync(pdata->clustered_irq);
-	else {
-		for (i = 0; i < pdata->num_row_gpios; i++)
-			disable_irq_nosync(keypad->row_irqs[i]);
-	}
+	for (i = 0; i < keypad->num_row_irqs; i++)
+		disable_irq_nosync(keypad->row_irqs[i]);
 }
 
 /*
@@ -233,35 +224,20 @@ static void matrix_keypad_stop(struct input_dev *dev)
 
 static void matrix_keypad_enable_wakeup(struct matrix_keypad *keypad)
 {
-	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
 	int i;
 
-	if (pdata->clustered_irq > 0) {
-		if (enable_irq_wake(pdata->clustered_irq) == 0)
-			keypad->gpio_all_disabled = true;
-	} else {
-
-		for (i = 0; i < pdata->num_row_gpios; i++)
-			if (!test_bit(i, keypad->disabled_gpios))
-				if (enable_irq_wake(keypad->row_irqs[i]) == 0)
-					__set_bit(i, keypad->disabled_gpios);
-	}
+	for_each_clear_bit(i, keypad->wakeup_enabled_irqs, keypad->num_row_irqs)
+		if (enable_irq_wake(keypad->row_irqs[i]) == 0)
+			__set_bit(i, keypad->wakeup_enabled_irqs);
 }
 
 static void matrix_keypad_disable_wakeup(struct matrix_keypad *keypad)
 {
-	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
 	int i;
 
-	if (pdata->clustered_irq > 0) {
-		if (keypad->gpio_all_disabled) {
-			disable_irq_wake(pdata->clustered_irq);
-			keypad->gpio_all_disabled = false;
-		}
-	} else {
-		for (i = 0; i < pdata->num_row_gpios; i++)
-			if (test_and_clear_bit(i, keypad->disabled_gpios))
-				disable_irq_wake(keypad->row_irqs[i]);
+	for_each_set_bit(i, keypad->wakeup_enabled_irqs, keypad->num_row_irqs) {
+		disable_irq_wake(keypad->row_irqs[i]);
+		__clear_bit(i, keypad->wakeup_enabled_irqs);
 	}
 }
 
@@ -335,6 +311,9 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 				"Unable to acquire clustered interrupt\n");
 			goto err_free_rows;
 		}
+
+		keypad->row_irqs[0] = pdata->clustered_irq;
+		keypad->num_row_irqs = 1;
 	} else {
 		for (i = 0; i < pdata->num_row_gpios; i++) {
 			irq = gpio_to_irq(pdata->row_gpios[i]);
@@ -360,6 +339,8 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 
 			keypad->row_irqs[i] = irq;
 		}
+
+		keypad->num_row_irqs = pdata->num_row_gpios;
 	}
 
 	/* initialized as disabled - enabled by input->open */
@@ -386,12 +367,8 @@ static void matrix_keypad_free_gpio(struct matrix_keypad *keypad)
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
 	int i;
 
-	if (pdata->clustered_irq > 0) {
-		free_irq(pdata->clustered_irq, keypad);
-	} else {
-		for (i = 0; i < pdata->num_row_gpios; i++)
-			free_irq(keypad->row_irqs[i], keypad);
-	}
+	for (i = 0; i < keypad->num_row_irqs; i++)
+		free_irq(keypad->row_irqs[i], keypad);
 
 	for (i = 0; i < pdata->num_row_gpios; i++)
 		gpio_free(pdata->row_gpios[i]);
-- 
2.53.0

