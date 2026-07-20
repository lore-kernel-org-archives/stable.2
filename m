Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D2C2E7366
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559656; cv=none; b=taThlqvouyZiWislsUnSS5Matr5XTTfPD3zUY0TYMunXFg0OZULkm+DamggFjg4b5NzaW5cUaj+qq6oqIZ6H+q1mHxdchrBkRuCsfW/VtqG8AxtSVsm628l36iWoW80jQpA1pEPcPV9eQQ1AJ5lYcZb8v1y7HLLIaLMuC7Su/5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559656; c=relaxed/simple;
	bh=O2ZjQOwkW9wHi+jGpkN69UUYN9M7DRncU3CFIIlssn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2Q3jnmPvQcHlRf3z5AH/gZzUEXoO9qOogQC75VYua1aLjf60CpDSLCvS7RB5A5gNkrLWz01SftSacOLudCqkySq5bRQ7F/7A5Q/q8YVaFoDhc6F6e3rYqYUvUt/TSi6w7JZaLZttfGsExMZYWNGA3GuN9qML4OIMUEhEs9HhCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqzgxvoR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqzgxvoR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F591F00A3E;
	Mon, 20 Jul 2026 15:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784559655;
	bh=tuHCDEZhdyotNk2mxTj7wkruGxzXHzseHMEeQwEZa5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CqzgxvoRxld+Rr/0irvDeksqIsYRJfpGhIP5P9Nn+5gAnvVa3bISEslAa8dHNxpoR
	 n/gm31ThelqWmcqqI2J4J91025167CM39NFRgcMD/r8OSSGpeSul070sAAKY+oMSoY
	 To6BZER4/405sUeUmk0QdbpwS7xqr9SjKNjCuFDz9bcYEkbDZueFHJD/YzFjQJjtI+
	 XBdfmou8JfeIFFzVKUu1WIo6+en4WMqpL2wgIgY4XGvTvkkGVCnyY+JHHqUpb9z/uP
	 suNCMFSdpYonyUs7eCAWBn5ZQs6XriA5hBT4JuMOGc00Jl2kq02jqvHkuoW5Ii/yBz
	 LZO9J1woCi3Lg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Ard Biesheuvel <ardb@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] crypto: atmel-sha204a - drop hwrng quality reduction for ATSHA204A
Date: Mon, 20 Jul 2026 11:00:51 -0400
Message-ID: <20260720150051.1918796-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720150051.1918796-1-sashal@kernel.org>
References: <2026071513-seducing-second-a53b@gregkh>
 <20260720150051.1918796-1-sashal@kernel.org>
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
index 77c0968b696337..040bed27c7d544 100644
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
@@ -95,6 +101,7 @@ static int atmel_sha204a_probe(struct i2c_client *client,
 			       const struct i2c_device_id *id)
 {
 	struct atmel_i2c_client_priv *i2c_priv;
+	const unsigned short *quality;
 	int ret;
 
 	ret = atmel_i2c_probe(client, id);
@@ -108,11 +115,9 @@ static int atmel_sha204a_probe(struct i2c_client *client,
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
@@ -137,14 +142,14 @@ static int atmel_sha204a_remove(struct i2c_client *client)
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

