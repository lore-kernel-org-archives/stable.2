Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362623;
	b=dzS9ltvJGvzR7Bq+KuUj5QZLJTrr2l31A0Becr2LN0qaZKQSlvKn5kgcEmA9mrryHpyC
	 WDkPazJg6tp4P0DQJDcO86EjUMChNTjZiPaoMPYDEYa3DPb/hz4d1ZEnlWkI1Ckc0dYKp
	 gOqwYwGZ6uuyYc9gczMm/1ymQ6e2dDzgQLdkSxgITTadKbFJspSyXgV8JHvSNCh6JhMtg
	 P2okfqHa9N9nzE9Xfri3705K0MFO9TXGN3m+aI2ea4eb5go2gAKJky/rLxE534izP1dIl
	 9MpydlCxvwAeKNEU0tQxn0jjKHJqJ2UUZGZytjgvQNy9A0I8F44nD3bppchQqkKOPUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362623;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=IWhf/p57YEY6HBXPS2RDl2XRHk9xidKRMLV3zGZwV3Q=;
	b=WwtNZmWZ0O2EaNjKCJNPpAV4ISooFcErSkZWid+gEkyBJ47IQwZNmN2kNZXT+q0Rh9J/
	 T5TEOXZTD9PSLoLoiipxqXLuo/gutMSmiTIIxh4R77/rgd9v+pHx2wBNT2idiSpCa0zZN
	 sCdce8jVphmovwb4TtUZtuTbizhSNWRBnwJx9B4M3n5QTjULxfrlzJsa8PSYI729niHov
	 vyABVdVzrn7b5Wi2JpcI/wd07ntw7aoVFUyW2my12Tw0v2ISRgMgpWoGPYRRwVF0gFm6u
	 Y4A0TB3Sdp09I3vO1ndyqjM0fGQW0M/wF3Mr0maKgQ1Qd7e8uC7WhkvHK7Zaq2uyXqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EvHzSU8D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB377606A32A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EvHzSU8D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B9A41F0093C;
	Wed, 11 Nov 2026 02:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362623;
	bh=IWhf/p57YEY6HBXPS2RDl2XRHk9xidKRMLV3zGZwV3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EvHzSU8DTZDlqtAE6bXvRBCHek3bjG9Z4D/42yzfV19vgQcHS5UIlWVsi+LrxNS7P
	 8SqG0kuyyR+UCnffXP6+poEeqTfHdXRxJHRC8/sdgIXgu76V4ZzvhlchYKUSAa3DZp
	 /nDZigaEIq+T/YTQg8GF7h1Vw8/bmn+ryt3v1EEOez6FppDQaMPXdj2fm9t1WfqdyJ
	 jXu2+NoYqFa3U8Qdp+GKvBfYVH2PirQp1uW7IUpD6q6gfhtt+J1utgiNxF+6F3hdhb
	 xr5/pLiY+oshQgfgyjBEPQbaGbEdV6B6BmQR/Ol+dsyzTYCmiQiCUw/6UdHiTDDXCi
	 SLk3ONzsVC8ig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/6] Input: matrix_keypad - avoid repeatedly converting GPIO to IRQ
Date: Tue, 10 Nov 2026 21:03:37 -0500
Message-ID: <20261111020056.444668-2-sashal@kernel.org>
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

[ Upstream commit a96fb711c6be76bcfbcf594a865002fa7c0eb525 ]

There is no need to do conversion from GPIOs to interrupt numbers.
Convert row GPIOs to interrupt numbers once in probe() and use
this information when the driver needs to enable or disable given
interrupt line.

Link: https://lore.kernel.org/r/20240121053232.276968-1-dmitry.torokhov@gmail.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Stable-dep-of: 1527451f87df ("Revert "Input: matrix_keypad - force switch rows to input mode"")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/matrix_keypad.c | 48 ++++++++++++++------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 50fa764c82d2b..1cd1ffb80401a 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -27,6 +27,7 @@ struct matrix_keypad {
 	const struct matrix_keypad_platform_data *pdata;
 	struct input_dev *input_dev;
 	unsigned int row_shift;
+	unsigned int row_irqs[MATRIX_MAX_ROWS];
 
 	DECLARE_BITMAP(disabled_gpios, MATRIX_MAX_ROWS);
 
@@ -92,7 +93,7 @@ static void enable_row_irqs(struct matrix_keypad *keypad)
 		enable_irq(pdata->clustered_irq);
 	else {
 		for (i = 0; i < pdata->num_row_gpios; i++)
-			enable_irq(gpio_to_irq(pdata->row_gpios[i]));
+			enable_irq(keypad->row_irqs[i]);
 	}
 }
 
@@ -105,7 +106,7 @@ static void disable_row_irqs(struct matrix_keypad *keypad)
 		disable_irq_nosync(pdata->clustered_irq);
 	else {
 		for (i = 0; i < pdata->num_row_gpios; i++)
-			disable_irq_nosync(gpio_to_irq(pdata->row_gpios[i]));
+			disable_irq_nosync(keypad->row_irqs[i]);
 	}
 }
 
@@ -233,7 +234,6 @@ static void matrix_keypad_stop(struct input_dev *dev)
 static void matrix_keypad_enable_wakeup(struct matrix_keypad *keypad)
 {
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
-	unsigned int gpio;
 	int i;
 
 	if (pdata->clustered_irq > 0) {
@@ -241,21 +241,16 @@ static void matrix_keypad_enable_wakeup(struct matrix_keypad *keypad)
 			keypad->gpio_all_disabled = true;
 	} else {
 
-		for (i = 0; i < pdata->num_row_gpios; i++) {
-			if (!test_bit(i, keypad->disabled_gpios)) {
-				gpio = pdata->row_gpios[i];
-
-				if (enable_irq_wake(gpio_to_irq(gpio)) == 0)
+		for (i = 0; i < pdata->num_row_gpios; i++)
+			if (!test_bit(i, keypad->disabled_gpios))
+				if (enable_irq_wake(keypad->row_irqs[i]) == 0)
 					__set_bit(i, keypad->disabled_gpios);
-			}
-		}
 	}
 }
 
 static void matrix_keypad_disable_wakeup(struct matrix_keypad *keypad)
 {
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
-	unsigned int gpio;
 	int i;
 
 	if (pdata->clustered_irq > 0) {
@@ -264,12 +259,9 @@ static void matrix_keypad_disable_wakeup(struct matrix_keypad *keypad)
 			keypad->gpio_all_disabled = false;
 		}
 	} else {
-		for (i = 0; i < pdata->num_row_gpios; i++) {
-			if (test_and_clear_bit(i, keypad->disabled_gpios)) {
-				gpio = pdata->row_gpios[i];
-				disable_irq_wake(gpio_to_irq(gpio));
-			}
-		}
+		for (i = 0; i < pdata->num_row_gpios; i++)
+			if (test_and_clear_bit(i, keypad->disabled_gpios))
+				disable_irq_wake(keypad->row_irqs[i]);
 	}
 }
 
@@ -306,7 +298,7 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 				   struct matrix_keypad *keypad)
 {
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
-	int i, err;
+	int i, irq, err;
 
 	/* initialized strobe lines as outputs, activated */
 	for (i = 0; i < pdata->num_col_gpios; i++) {
@@ -345,11 +337,19 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 		}
 	} else {
 		for (i = 0; i < pdata->num_row_gpios; i++) {
-			err = request_any_context_irq(
-					gpio_to_irq(pdata->row_gpios[i]),
+			irq = gpio_to_irq(pdata->row_gpios[i]);
+			if (irq < 0) {
+				err = irq;
+				dev_err(&pdev->dev,
+					"Unable to convert GPIO line %i to irq: %d\n",
+					pdata->row_gpios[i], err);
+				goto err_free_irqs;
+			}
+
+			err = request_any_context_irq(irq,
 					matrix_keypad_interrupt,
 					IRQF_TRIGGER_RISING |
-					IRQF_TRIGGER_FALLING,
+						IRQF_TRIGGER_FALLING,
 					"matrix-keypad", keypad);
 			if (err < 0) {
 				dev_err(&pdev->dev,
@@ -357,6 +357,8 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 					pdata->row_gpios[i]);
 				goto err_free_irqs;
 			}
+
+			keypad->row_irqs[i] = irq;
 		}
 	}
 
@@ -366,7 +368,7 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 
 err_free_irqs:
 	while (--i >= 0)
-		free_irq(gpio_to_irq(pdata->row_gpios[i]), keypad);
+		free_irq(keypad->row_irqs[i], keypad);
 	i = pdata->num_row_gpios;
 err_free_rows:
 	while (--i >= 0)
@@ -388,7 +390,7 @@ static void matrix_keypad_free_gpio(struct matrix_keypad *keypad)
 		free_irq(pdata->clustered_irq, keypad);
 	} else {
 		for (i = 0; i < pdata->num_row_gpios; i++)
-			free_irq(gpio_to_irq(pdata->row_gpios[i]), keypad);
+			free_irq(keypad->row_irqs[i], keypad);
 	}
 
 	for (i = 0; i < pdata->num_row_gpios; i++)
-- 
2.53.0

