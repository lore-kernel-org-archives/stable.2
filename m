Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362625;
	b=2zGrFMwszfBVFYCUSNCTI91cYoW0rx8KLfsBVbRsSGWVKU4Av/ebLefmcQfI95ERenc9
	 +doUAeyhQpDEBdmB/XbUGbzRrVqb99b7AfxhEYSp2QermlZ6R56K+4DJlbrx8SzBi9aph
	 k0CMXeM14cAfZ6/XT1D0CAso3PrxzTjawpJwnX5/L127rNTP0kBhaJjh09sG7kPUudlvS
	 5Wi848lczg0ksUAWWOJ+5pQpV5FiOVBnZ9BzQblaCY0uiZbeunVKwXxBthywp/6KpIuvK
	 7KZrYw+yZOJfE6SMyyuwJ2CxDbiCR5spOjwQViQauW9gtePpPTvFQssZ93IsB5oxAPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362625;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mmFcZ2hIqT1jnElguzKjSaQNfAZgYqtvCNwDNLMqDUQ=;
	b=orpgfhKNVbSLFDfFFVq64On1AszWfpyCcSgRaHyL1T4QN/WigfLKXas46XLQIw0lvDVK
	 zle/zBd5s+IJ9YtAIZyfB0q80i/0hsbG3+tPvDX6XnVZZA/cLB61HTzOR04vAM9+kCCfb
	 AMeqV2PTBs7SHwmI+j5C6LsDsZG+c+3cchMWdu/V4JGSbfEGXOCjCbJ/N1zD/97fClPAI
	 9A3TD3vQIWEDcBJpt7oYOofbkaYORellK4YqxoLFkcVBBg0h+dH18/J+Jtgc9yMaqEmfh
	 H9+8J8FDGhLDuALPrJnEJlP9kH8w+mxH5f5ybmW0Qu4CTzDDY/H1XNp8lV6YQMarNQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AbYriwik;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6D9606A333
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AbYriwik
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E271F00A03;
	Wed, 11 Nov 2026 02:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362624;
	bh=mmFcZ2hIqT1jnElguzKjSaQNfAZgYqtvCNwDNLMqDUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AbYriwikir1BhKDZyCsR/kSCvhieOaeltvoE2901HEFOirO1E7sdfOCFw2wuF1SPs
	 dduHcBzvRQLRLom/XMu+RFvIbhjI5Cu3EWlxTt+xk288Tp/mx3lB7z+6pMKibwrBW7
	 XN15ABdWyB2pF+EOQmerD6m57k8R2oJnEiku1q5DxSYhpEe4KThsiO0tEew/Lkjwvv
	 OcqVFx/+JOe6HYzXrW9Tm38yXuRfp5DXPgJK2CORsuFcSTYH6OzxE8KIlvp4innHZD
	 ZJd7zDkj6MNcKqKi8D/XtERbITo2QH2e/lWpYjANjmnBjSpPmevYzXQtcxDsabVSZB
	 /VEp4+Nt43HDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/6] Input: matrix_keypad - switch to using managed resources
Date: Tue, 10 Nov 2026 21:03:39 -0500
Message-ID: <20261111020056.444668-4-sashal@kernel.org>
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

[ Upstream commit 7d0f351da46098b3bbb147f886f059473b84ff48 ]

Switch the drivers to use managed resources (devm) to simplify error
handling and remove the need to have remove() implementation.

Link: https://lore.kernel.org/r/20240121053232.276968-3-dmitry.torokhov@gmail.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Stable-dep-of: 1527451f87df ("Revert "Input: matrix_keypad - force switch rows to input mode"")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/matrix_keypad.c | 89 +++++++-------------------
 1 file changed, 24 insertions(+), 65 deletions(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 44ef600b8f191..695c03e075b56 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -278,38 +278,41 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 
 	/* initialized strobe lines as outputs, activated */
 	for (i = 0; i < pdata->num_col_gpios; i++) {
-		err = gpio_request(pdata->col_gpios[i], "matrix_kbd_col");
+		err = devm_gpio_request(&pdev->dev,
+					pdata->col_gpios[i], "matrix_kbd_col");
 		if (err) {
 			dev_err(&pdev->dev,
 				"failed to request GPIO%d for COL%d\n",
 				pdata->col_gpios[i], i);
-			goto err_free_cols;
+			return err;
 		}
 
 		gpio_direction_output(pdata->col_gpios[i], !pdata->active_low);
 	}
 
 	for (i = 0; i < pdata->num_row_gpios; i++) {
-		err = gpio_request(pdata->row_gpios[i], "matrix_kbd_row");
+		err = devm_gpio_request(&pdev->dev,
+					pdata->row_gpios[i], "matrix_kbd_row");
 		if (err) {
 			dev_err(&pdev->dev,
 				"failed to request GPIO%d for ROW%d\n",
 				pdata->row_gpios[i], i);
-			goto err_free_rows;
+			return err;
 		}
 
 		gpio_direction_input(pdata->row_gpios[i]);
 	}
 
 	if (pdata->clustered_irq > 0) {
-		err = request_any_context_irq(pdata->clustered_irq,
+		err = devm_request_any_context_irq(&pdev->dev,
+				pdata->clustered_irq,
 				matrix_keypad_interrupt,
 				pdata->clustered_irq_flags,
 				"matrix-keypad", keypad);
 		if (err < 0) {
 			dev_err(&pdev->dev,
 				"Unable to acquire clustered interrupt\n");
-			goto err_free_rows;
+			return err;
 		}
 
 		keypad->row_irqs[0] = pdata->clustered_irq;
@@ -322,10 +325,11 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 				dev_err(&pdev->dev,
 					"Unable to convert GPIO line %i to irq: %d\n",
 					pdata->row_gpios[i], err);
-				goto err_free_irqs;
+				return err;
 			}
 
-			err = request_any_context_irq(irq,
+			err = devm_request_any_context_irq(&pdev->dev,
+					irq,
 					matrix_keypad_interrupt,
 					IRQF_TRIGGER_RISING |
 						IRQF_TRIGGER_FALLING,
@@ -334,7 +338,7 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 				dev_err(&pdev->dev,
 					"Unable to acquire interrupt for GPIO line %i\n",
 					pdata->row_gpios[i]);
-				goto err_free_irqs;
+				return err;
 			}
 
 			keypad->row_irqs[i] = irq;
@@ -345,36 +349,8 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 
 	/* initialized as disabled - enabled by input->open */
 	disable_row_irqs(keypad);
-	return 0;
-
-err_free_irqs:
-	while (--i >= 0)
-		free_irq(keypad->row_irqs[i], keypad);
-	i = pdata->num_row_gpios;
-err_free_rows:
-	while (--i >= 0)
-		gpio_free(pdata->row_gpios[i]);
-	i = pdata->num_col_gpios;
-err_free_cols:
-	while (--i >= 0)
-		gpio_free(pdata->col_gpios[i]);
-
-	return err;
-}
-
-static void matrix_keypad_free_gpio(struct matrix_keypad *keypad)
-{
-	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
-	int i;
-
-	for (i = 0; i < keypad->num_row_irqs; i++)
-		free_irq(keypad->row_irqs[i], keypad);
-
-	for (i = 0; i < pdata->num_row_gpios; i++)
-		gpio_free(pdata->row_gpios[i]);
 
-	for (i = 0; i < pdata->num_col_gpios; i++)
-		gpio_free(pdata->col_gpios[i]);
+	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -473,12 +449,13 @@ static int matrix_keypad_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	keypad = kzalloc(sizeof(struct matrix_keypad), GFP_KERNEL);
-	input_dev = input_allocate_device();
-	if (!keypad || !input_dev) {
-		err = -ENOMEM;
-		goto err_free_mem;
-	}
+	keypad = devm_kzalloc(&pdev->dev, sizeof(*keypad), GFP_KERNEL);
+	if (!keypad)
+		return -ENOMEM;
+
+	input_dev = devm_input_allocate_device(&pdev->dev);
+	if (!input_dev)
+		return -ENOMEM;
 
 	keypad->input_dev = input_dev;
 	keypad->pdata = pdata;
@@ -489,7 +466,6 @@ static int matrix_keypad_probe(struct platform_device *pdev)
 
 	input_dev->name		= pdev->name;
 	input_dev->id.bustype	= BUS_HOST;
-	input_dev->dev.parent	= &pdev->dev;
 	input_dev->open		= matrix_keypad_start;
 	input_dev->close	= matrix_keypad_stop;
 
@@ -499,7 +475,7 @@ static int matrix_keypad_probe(struct platform_device *pdev)
 					 NULL, input_dev);
 	if (err) {
 		dev_err(&pdev->dev, "failed to build keymap\n");
-		goto err_free_mem;
+		return -ENOMEM;
 	}
 
 	if (!pdata->no_autorepeat)
@@ -509,32 +485,16 @@ static int matrix_keypad_probe(struct platform_device *pdev)
 
 	err = matrix_keypad_init_gpio(pdev, keypad);
 	if (err)
-		goto err_free_mem;
+		return err;
 
 	err = input_register_device(keypad->input_dev);
 	if (err)
-		goto err_free_gpio;
+		return err;
 
 	device_init_wakeup(&pdev->dev, pdata->wakeup);
 	platform_set_drvdata(pdev, keypad);
 
 	return 0;
-
-err_free_gpio:
-	matrix_keypad_free_gpio(keypad);
-err_free_mem:
-	input_free_device(input_dev);
-	kfree(keypad);
-	return err;
-}
-
-static void matrix_keypad_remove(struct platform_device *pdev)
-{
-	struct matrix_keypad *keypad = platform_get_drvdata(pdev);
-
-	matrix_keypad_free_gpio(keypad);
-	input_unregister_device(keypad->input_dev);
-	kfree(keypad);
 }
 
 #ifdef CONFIG_OF
@@ -547,7 +507,6 @@ MODULE_DEVICE_TABLE(of, matrix_keypad_dt_match);
 
 static struct platform_driver matrix_keypad_driver = {
 	.probe		= matrix_keypad_probe,
-	.remove_new	= matrix_keypad_remove,
 	.driver		= {
 		.name	= "matrix-keypad",
 		.pm	= pm_sleep_ptr(&matrix_keypad_pm_ops),
-- 
2.53.0

