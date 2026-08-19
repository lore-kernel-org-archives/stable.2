Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0423F1AA1
	for <Stable@vger.kernel.org>; Wed, 19 Aug 2026 07:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125526; cv=none; b=RuIzZoNuBAM3nUwUPWxts1VdoNe31XWx8hXfe3BLJdFsmOVRKTwZA28PgZiu4rmYJ1z4TGSlxpRb0qdyX2ZN1D+6JJaWjq+dbWaLMPLu9Rx4Y3xIyJi1inD2lv89DgyKZFLZ3WZDluw0LilDvp333R1Zf2KQDRiKUhqn0mcrSs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125526; c=relaxed/simple;
	bh=xmNATnvhigGF+7qS1swfi4e8E27RI6LMZtkVdFQI2Io=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=FFTOMZFltd5dVxWQvpzw2L51rakTLQjd2ULHLJ18l7/wfYO/DgrpyTJCeUkk2bxfvom3bW3PQmYc/TIpZ883++I8Q33fbsVgXjhd2bzmWL7e5mRYpRc5umihm9l0Lyh5NysCCAhBSDH6D0E9l+FGEjW72anbCQ7l4zSF2qd9mcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pJZFRnr4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pJZFRnr4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3935D1F000E9;
	Wed, 19 Aug 2026 07:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787125525;
	bh=eMrnSjnRPGhlWurkbQAdXOlmQhU6N2z+t0ZNXRKxovA=;
	h=Subject:To:From:Date;
	b=pJZFRnr4Y2HiM03GoxwDoEfQPvhh9uLAInjPfjDXNr7+H7zTzkV6HNpgZgKgUkwCa
	 zXjYNAswhecE6iIT2X3UvVYIT/370OwqiqpAlI3goaO0SxKy5mo/ERnEXrRO3qeZYi
	 OvbXYSB7yVvPMKct9vsN/gKyj70m9O+q9lei3q7M=
Subject: patch "iio: light: opt4001: Fix power down clearing bits of the wrong" added to char-misc-testing
To: nikhilgtr@gmail.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com,jic23@kernel.org,jonathan.cameron@oss.qualcomm.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Aug 2026 09:44:07 +0200
Message-ID: <2026081907-tannery-panama-f453@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: light: opt4001: Fix power down clearing bits of the wrong

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 3b2cd82c524c75a2173f2e3f874652a75f81cd1d Mon Sep 17 00:00:00 2001
From: Nikhil Gautam <nikhilgtr@gmail.com>
Date: Tue, 14 Jul 2026 17:01:31 +0530
Subject: iio: light: opt4001: Fix power down clearing bits of the wrong
 register

opt4001_power_down() intends to clear the operating mode bits in the
CTRL register but reads OPT4001_DEVICE_ID instead of OPT4001_CTRL, so
the value written back to CTRL contains device ID bits rather than the
current configuration.

Fix and simplify this by using regmap_clear_bits() on the CTRL register
directly in the devm action, and drop opt4001_power_down() which has no
other users.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Fixes: 9a9608418292 ("iio: light: Add support for TI OPT4001 light sensor")
Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/light/opt4001.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
index dd152d921b48..288e699734af 100644
--- a/drivers/iio/light/opt4001.c
+++ b/drivers/iio/light/opt4001.c
@@ -222,33 +222,14 @@ static int opt4001_set_conf(struct opt4001_chip *chip)
 	return ret;
 }
 
-static int opt4001_power_down(struct opt4001_chip *chip)
-{
-	struct device *dev = &chip->client->dev;
-	int ret;
-	unsigned int reg;
-
-	ret = regmap_read(chip->regmap, OPT4001_DEVICE_ID, &reg);
-	if (ret) {
-		dev_err(dev, "Failed to read configuration\n");
-		return ret;
-	}
-
-	/* MODE_OFF is 0x0 so just set bits to 0 */
-	reg &= ~OPT4001_CTRL_OPER_MODE_MASK;
-
-	ret = regmap_write(chip->regmap, OPT4001_CTRL, reg);
-	if (ret)
-		dev_err(dev, "Failed to set configuration to power down\n");
-
-	return ret;
-}
-
 static void opt4001_chip_off_action(void *data)
 {
 	struct opt4001_chip *chip = data;
+	int ret;
 
-	opt4001_power_down(chip);
+	ret = regmap_clear_bits(chip->regmap, OPT4001_CTRL, OPT4001_CTRL_OPER_MODE_MASK);
+	if (ret)
+		dev_err(&chip->client->dev, "Failed to power down\n");
 }
 
 static const struct iio_chan_spec opt4001_channels[] = {
-- 
2.55.0


