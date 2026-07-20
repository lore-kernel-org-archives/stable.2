Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B75436353
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562500; cv=none; b=G0mgAMcKUhWcv6c0h2BRgkuVnZ+MuUg2qezuD/yVp32d7h1bWLrwyFXJj8U6WCFAPXvykEovPN2bEZYpMwm+M1SVMOhz+e4djNRy+TRo4kQyCiM0i1nvnCsrBvIi0PvHljF7FLVQNYXqwUrQ5R7/mo9KSJqBEnzAmBK9QwYyf7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562500; c=relaxed/simple;
	bh=w4zfD2pdyozLOKYIw3j+Fja1ovaf9N05giwdWl/BF7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrOf3hvTKW05keF+T/YTcJifEcGsRzlAneU1mQC7wvhykB1HhAWQuMK5h+7P+Y0qjsgG/vYwszwokKKqEhJPzK/fgDkL+cVSlui8+pXb7oQYYecsow7MhAVlEvDEWnDJy7veAZELH2Ig/TKlMH4cZpEcW/F91+ahqQa4FKWuGpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1ySpFgG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1ySpFgG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D2A1F00A3F;
	Mon, 20 Jul 2026 15:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784562497;
	bh=pTawEM9kSsOq7B4Z/4N1oJharYisNiQXf3FSXmiSHeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d1ySpFgGIG8nTNicUdX3c7xYhI6ONKXp00o/eOLkIyhGSeQqFicrDwliWWPdhxZiY
	 4oIEJu5X02UnJU4Csx/J49mjIqjZg19y9+m7f40loW8nucBnqo5gFKG6QPsDQI2wqC
	 KPhXYB9j8d2UJyXNagVnFPAgN0pLh+Fpm1PNZ13my9WmS08YRigsmnRGzJjRQd9+eg
	 BRJr89O9evwMHSvP2T4fQE7VWtT4N7+3bquGeqBEvsBgx8b0sK5A1V10S8VWLgIqd7
	 FW+eErPBtEmZCrElRKpmCalPYvuJK5wrootUKDKIoAHMncSSXtCLyUT4QNFo/N8bwT
	 7E63iGEq3s27g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Ard Biesheuvel <ardb@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] crypto: atmel-sha204a - drop hwrng quality reduction for ATSHA204A
Date: Mon, 20 Jul 2026 11:48:13 -0400
Message-ID: <20260720154813.2319486-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720154813.2319486-1-sashal@kernel.org>
References: <2026071514-kindling-fried-4b7e@gregkh>
 <20260720154813.2319486-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit ea5e57cc97185329dcc5ebdcaae7e1500bf0ad0b ]

Commit 8006aff15516 ("crypto: atmel-sha204a - Set hwrng quality to
lowest possible") reduced the hwrng quality to 1 based on a review by
Bill Cox [1]. However, despite its title, the review only tested the
ATSHA204, not the ATSHA204A.

In the same thread, Atmel engineer Landon Cox wrote "this behavior has
been eliminated entirely"[2] in the ATSHA204A and "this problem does not
affect the ATECC108 or the ATECC108A (or the ATSHA204A)"[3].

According to the official ATSHA204A datasheet [4], the device contains a
high-quality hardware RNG that combines its output with an internal seed
value stored in EEPROM or SRAM to generate random numbers. The device
also implements all security functions using SHA-256, and the driver
uses the chip's Random command in seed-update mode.

Keep 'quality = 1' for ATSHA204, but drop the explicit hwrng quality
reduction for ATSHA204A and fall back to the hwrng core default.

[1] https://www.metzdowd.com/pipermail/cryptography/2014-December/023858.html
[2] https://www.metzdowd.com/pipermail/cryptography/2014-December/023852.html
[3] https://www.metzdowd.com/pipermail/cryptography/2014-December/023886.html
[4] https://ww1.microchip.com/downloads/en/DeviceDoc/ATSHA204A-Data-Sheet-40002025A.pdf

Fixes: 8006aff15516 ("crypto: atmel-sha204a - Set hwrng quality to lowest possible")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/atmel-sha204a.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index 033ed7cb64b695..2626dbf5dd1a07 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -18,6 +18,12 @@
 #include <linux/workqueue.h>
 #include "atmel-i2c.h"
 
+/*
+ * According to review by Bill Cox [1], the ATSHA204 has very low entropy.
+ * [1] https://www.metzdowd.com/pipermail/cryptography/2014-December/023858.html
+ */
+static const unsigned short atsha204_quality = 1;
+
 static void atmel_sha204a_rng_done(struct atmel_i2c_work_data *work_data,
 				   void *areq, int status)
 {
@@ -96,6 +102,7 @@ static int atmel_sha204a_probe(struct i2c_client *client,
 			       const struct i2c_device_id *id)
 {
 	struct atmel_i2c_client_priv *i2c_priv;
+	const unsigned short *quality;
 	int ret;
 
 	ret = atmel_i2c_probe(client, id);
@@ -109,11 +116,9 @@ static int atmel_sha204a_probe(struct i2c_client *client,
 	i2c_priv->hwrng.name = dev_name(&client->dev);
 	i2c_priv->hwrng.read = atmel_sha204a_rng_read;
 
-	/*
-	 * According to review by Bill Cox [1], this HWRNG has very low entropy.
-	 * [1] https://www.metzdowd.com/pipermail/cryptography/2014-December/023858.html
-	 */
-	i2c_priv->hwrng.quality = 1;
+	quality = i2c_get_match_data(client);
+	if (quality)
+		i2c_priv->hwrng.quality = *quality;
 
 	ret = devm_hwrng_register(&client->dev, &i2c_priv->hwrng);
 	if (ret)
@@ -138,14 +143,14 @@ static int atmel_sha204a_remove(struct i2c_client *client)
 }
 
 static const struct of_device_id atmel_sha204a_dt_ids[] __maybe_unused = {
-	{ .compatible = "atmel,atsha204", },
+	{ .compatible = "atmel,atsha204", .data = &atsha204_quality },
 	{ .compatible = "atmel,atsha204a", },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, atmel_sha204a_dt_ids);
 
 static const struct i2c_device_id atmel_sha204a_id[] = {
-	{ "atsha204" },
+	{ "atsha204", (kernel_ulong_t)&atsha204_quality },
 	{ "atsha204a" },
 	{ /* sentinel */ }
 };
-- 
2.53.0

