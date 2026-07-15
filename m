Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09EA43B6DE
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 10:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784110234; cv=none; b=FPAgLWDkhxj3MrJhu/4Jh2loF5/l0AkYZkvomD71lDj5/XavQAaMCD2+LEl3K4Rc59iGrMl8ZtsnW93QW2geBzwu7rVMt72GJf4xUqIne0we3VyK2A5p8+igvYQA4oH+aHp6ukDXr7f0bbe7/MFN5RMz+P/2bitZKdEg5pfAsd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784110234; c=relaxed/simple;
	bh=NClUR1EEKBpzKir3+9rV8MF9XqWumTB0ZT4e+DNIO9s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=InlTU02EnlHT/5fCtHyQrHSk7+mh4zg7Ycjb4J24/U87StlVBICkfFzDkGqif1+zKOh+sQ4Ox/Ei7G9SzTpOWwexp71rYRHSM86oN8OiFRUDmMAeMIZeLwTPoRtH1EEkLY0ZLag2Hwm7qDXRu2fLq2VnQ9lJTqkQ3IuLqja1QI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c+SILwz6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c+SILwz6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F271B1F000E9;
	Wed, 15 Jul 2026 10:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784110232;
	bh=epGlb5xoqQia+KB3YhWuXdCyQc6c9Dvu3eeNstqnhO4=;
	h=Subject:To:Cc:From:Date;
	b=c+SILwz6L7EcWdZ1MYCmxDngCqzrYwN9gxjKf8Z+yi+mHUh5158rDsoD2W3KTJB2+
	 +Pe90EXcotw0cNPRIPL9JJ3Hz+1loO21C9rq0IANPptbyFsRXueelZAMUnavYwlc1I
	 gR+JWUnCfOwjkmg+/BJxiSglsnhQ/QZpt2wGHAvg=
Subject: FAILED: patch "[PATCH] crypto: atmel-sha204a - drop hwrng quality reduction for" failed to apply to 6.1-stable tree
To: thorsten.blum@linux.dev,ardb@kernel.org,herbert@gondor.apana.org.au
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Jul 2026 12:10:13 +0200
Message-ID: <2026071513-flatness-crepe-f5ee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x ea5e57cc97185329dcc5ebdcaae7e1500bf0ad0b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071513-flatness-crepe-f5ee@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

