Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365839;
	b=Qk1oU/vhjV1gTqJmUTiNUJfKnBikPHT2CgtWok7Fjjbo6lHW/zJgKMkcZtK5edBEU5/8
	 yqvHHKA0lIxaqg7w+EGz+47vJgwUL210DUZyq/slbMzcdo33+ZxyjzwqoRZtyx7V9CUAK
	 GkiB6kE2s0PrTNp4ihOs6JGLsffd68adf94B1/zluU0YMhrOu+94w/vWvavm/mhVsXBrk
	 nvHy71t4RUc/niR90GnKpycsSljFmmkcuvrrgO/XmnCwQk4ZkvWqwT38g1Q8dfKFLD7Iz
	 FIwPDC7bJria0+Dgu1NTXrTxfAcfKb15lwNTwWkmW3A2Cc9UWneE7SdTbf0YoeVtPzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365839;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aF7gK801UQ8t+z9+ltqKNv25BAXK4SGKtYNQjebH8Lo=;
	b=aS+f4t8wWYb1AOXpQTlO+0yc5z+IzhwGyCQCFFSzHkVxhX8LKVCugIC/zfzj4uC5IKqO
	 5M6/5W5XU5pbgfSl5CIM49YHZU2PYdZOOIVEflazfDIfSiWy7bxmV1RYv0FEN2Mr6K2Od
	 E81gPYg6AJ43yunGqVP+pulH1+KBV7ocN0uPlKriSE9aQZr9jRlauT1ZeSRTcScUhgu97
	 bKzvHmNhhBTLzYqykW2pBLPMvWNdpcGMcE1gD+DHC+1O/+zXZUPO2feVBMcDgZmn3lG2e
	 nYkbHcsk0d717HCzqYPPLxdXpm35iAQRoPLkbv0QcIk5i2qA3J9EjiJw8A3VSRBd50w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XsQJuWwz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFDE606A32D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XsQJuWwz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F178B1F0089F;
	Wed, 11 Nov 2026 02:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794365839;
	bh=aF7gK801UQ8t+z9+ltqKNv25BAXK4SGKtYNQjebH8Lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XsQJuWwzXnoBLYssA+IynjhGahRBPWSb0nS4qBp91LvEtioSfbD+tZzSI5fCeFdmS
	 E/xFLtnMJhyFzle9vwDerpsvTAJ8ZLwj5NoBGGvMJCde+VcQaRDJmP3f+Negb50yJZ
	 tbM1WtEC7j3ybuvNaqDwbW+6WLPhR5x17ZXdadPQTkApqRa9K17apaQADYz552ECkc
	 zVCP8VFTqoMrfT+NEc2iKj/u7V1/mm6Ww4gh7SslFYiGahr4wfsO86KwYUVIQNjEEs
	 T0eRvGLzDi1qGl5OtVYYCCci+h+qrHs0cIQK3+nPy/HlgBvY4O4pmL/M8HnbynzH0e
	 3848FBKDx0OvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hongyan Xu <getshell@seu.edu.cn>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mfd: da903x: Cancel IRQ work during teardown
Date: Tue, 10 Nov 2026 21:57:17 -0500
Message-ID: <20261111025654.812365-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061649-failed-5.10-fd2258999ecd@kernel.org>
References: <20261107061649-failed-5.10-fd2258999ecd@kernel.org>
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

From: Hongyan Xu <getshell@seu.edu.cn>

[ Upstream commit fd2258999ecdc7164ef0cda2d4102e4558a5660f ]

The IRQ handler disables the IRQ and schedules irq_work. Releasing the
IRQ does not drain that work, which can continue to use the devm-allocated
chip and notifier state.

Manage both IRQ-work cancellation and subdevice removal with devres.
Register the subdevice-removal action before requesting the IRQ, then add
the IRQ-work action after the request. This avoids leaving a live IRQ
without work cancellation if action registration fails. Devres cleanup
then disables the IRQ and drains the work before releasing the IRQ and
removing child devices. Register both actions before creating the children
so partial probe failures use the same ordering.

This issue was found by the author's in-house static analysis tool.
The patch was reviewed by the author against the latest mainline tree.

Fixes: 26b8f5e1e2d1 ("mfd: add base support for Dialog DA9030/DA9034 PMICs")
Cc: stable@vger.kernel.org
Suggested-by: Lee Jones <lee@kernel.org>
Assisted-by: Codex:GPT-5
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
Link: https://patch.msgid.link/20260814153019.1114-1-getshell@seu.edu.cn
Signed-off-by: Lee Jones <lee@kernel.org>
[ sashal: adapted da903x_remove() deletion to its int return type by also removing the return 0 statement ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/da903x.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/mfd/da903x.c b/drivers/mfd/da903x.c
index a818fbb559888..3ff1a00b409c3 100644
--- a/drivers/mfd/da903x.c
+++ b/drivers/mfd/da903x.c
@@ -421,6 +421,14 @@ static irqreturn_t da903x_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static void da903x_cancel_irq_work(void *data)
+{
+	struct da903x_chip *chip = data;
+
+	disable_irq(chip->client->irq);
+	cancel_work_sync(&chip->irq_work);
+}
+
 static const struct da903x_chip_ops da903x_ops[] = {
 	[0] = {
 		.init_chip	= da9030_init_chip,
@@ -456,6 +464,13 @@ static int da903x_remove_subdevs(struct da903x_chip *chip)
 	return device_for_each_child(chip->dev, NULL, __remove_subdev);
 }
 
+static void da903x_remove_subdevs_action(void *data)
+{
+	struct da903x_chip *chip = data;
+
+	da903x_remove_subdevs(chip);
+}
+
 static int da903x_add_subdevs(struct da903x_chip *chip,
 					struct da903x_platform_data *pdata)
 {
@@ -484,7 +499,6 @@ static int da903x_add_subdevs(struct da903x_chip *chip,
 	return 0;
 
 failed:
-	da903x_remove_subdevs(chip);
 	return ret;
 }
 
@@ -520,6 +534,11 @@ static int da903x_probe(struct i2c_client *client,
 	chip->ops->mask_events(chip, chip->events_mask);
 	chip->ops->read_events(chip, &tmp);
 
+	ret = devm_add_action_or_reset(&client->dev,
+				       da903x_remove_subdevs_action, chip);
+	if (ret)
+		return ret;
+
 	ret = devm_request_irq(&client->dev, client->irq, da903x_irq_handler,
 			IRQF_TRIGGER_FALLING,
 			"da903x", chip);
@@ -529,15 +548,12 @@ static int da903x_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	return da903x_add_subdevs(chip, pdata);
-}
-
-static int da903x_remove(struct i2c_client *client)
-{
-	struct da903x_chip *chip = i2c_get_clientdata(client);
+	ret = devm_add_action_or_reset(&client->dev, da903x_cancel_irq_work,
+				       chip);
+	if (ret)
+		return ret;
 
-	da903x_remove_subdevs(chip);
-	return 0;
+	return da903x_add_subdevs(chip, pdata);
 }
 
 static struct i2c_driver da903x_driver = {
@@ -545,7 +561,6 @@ static struct i2c_driver da903x_driver = {
 		.name	= "da903x",
 	},
 	.probe		= da903x_probe,
-	.remove		= da903x_remove,
 	.id_table	= da903x_id_table,
 };
 
-- 
2.53.0

