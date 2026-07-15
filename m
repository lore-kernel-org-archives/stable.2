Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CBA35F16F
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110236; cv=none; b=KDhMe4MfbO2VZSxkwbb2VcoH/XcjKwZYduXCgHK8y3BUUJXj4soXRjlf1UMkzeAHtX7PXOlv2OzV59l7Bdg2L1jc0jEo0p7THjf9dzTfglnU55ait31P/MUapdqZx96KbCpQDi1v0NzQUB8Fu1UCKNdeg5zEfiu5LxB1r25L7vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110236; c=relaxed/simple;
	bh=hnAQ5jgtLHz3gQ5ZKhKZyjxGDmsPNS4mdLlerCaHPgE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ajbEWO2EvG0oUp2oOzCc0zTIjxrUWMd1BmYnoc3IXLnBs6Xwsk4LVKptR0IOntOlnq8BPS8JGTK6NXU6UvVJ20UgimSPa26SrZm8BfP/L5YNi1FOaLodmBSJeAF8l2Z4Elcno5QuT7+dG4UqJ5x+0E0LHaJOo+HxlgMT2pbeXSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZgjGVgjb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZgjGVgjb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94DE31F000E9;
	Wed, 15 Jul 2026 10:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784110235;
	bh=dtS566iwB+fx//3rLAGSqaHutqf7aNVvI6LEmz2ba10=;
	h=Subject:To:Cc:From:Date;
	b=ZgjGVgjbEfkjPsw+1jiR8TbQMvKgg/EdkkzWA1J41Zy7r8ljM45olXb5vg3ykPZdv
	 gt6+qFukajmDV2S9ZH2/ScJHfAS+twsgS3z7b1Od2m/fpKbLAMCyKhX39P6NfYEDJb
	 BOj4DC5syiLVTyaxvxF4IEGUAA48QZRwYkDuXmM0=
Subject: FAILED: patch "[PATCH] crypto: atmel-sha204a - drop hwrng quality reduction for" failed to apply to 5.10-stable tree
To: thorsten.blum@linux.dev,ardb@kernel.org,herbert@gondor.apana.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Jul 2026 12:10:14 +0200
Message-ID: <2026071514-kindling-fried-4b7e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x ea5e57cc97185329dcc5ebdcaae7e1500bf0ad0b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071514-kindling-fried-4b7e@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ea5e57cc97185329dcc5ebdcaae7e1500bf0ad0b Mon Sep 17 00:00:00 2001
From: Thorsten Blum <thorsten.blum@linux.dev>
Date: Tue, 28 Apr 2026 12:14:32 +0200
Subject: [PATCH] crypto: atmel-sha204a - drop hwrng quality reduction for
 ATSHA204A

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

diff --git a/drivers/crypto/atmel-sha204a.c b/drivers/crypto/atmel-sha204a.c
index 5699bb532325..ed7d69bf6890 100644
--- a/drivers/crypto/atmel-sha204a.c
+++ b/drivers/crypto/atmel-sha204a.c
@@ -19,6 +19,12 @@
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
@@ -158,6 +164,7 @@ static const struct attribute_group atmel_sha204a_groups = {
 static int atmel_sha204a_probe(struct i2c_client *client)
 {
 	struct atmel_i2c_client_priv *i2c_priv;
+	const unsigned short *quality;
 	int ret;
 
 	ret = atmel_i2c_probe(client);
@@ -171,11 +178,9 @@ static int atmel_sha204a_probe(struct i2c_client *client)
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
@@ -203,14 +208,14 @@ static void atmel_sha204a_remove(struct i2c_client *client)
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

