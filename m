Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BDC3D5221
	for <Stable@vger.kernel.org>; Fri, 11 Sep 2026 09:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120593; cv=none; b=EZ1J+qfj9i238sOGREwnTyy0WElW1pUZGu8TYZarszvZFZAXEFBd4TE+hleqliT/tCAPQG+bza5Tlmoz65hADG1EMPaYoYPR0XJpm+BddIaMBcm9WOSIs1kPRVJbSX4uOFPfpNSvyqkMTeiHfwDs0wy3V4QZq4nrK1F7hQ0uaUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120593; c=relaxed/simple;
	bh=2O9Fnthz4wDsnNGRLZXvlAJ+Q8FOTKC8+AFjSYxXSwQ=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=CkQ7Ncbxt2VgUjD3Zr25xBUDbA1ww7xbvzxeDeIJZB+2XEd8XoPtSlc9Sx78BWH8+UrP0wvixyRiidoM7u8CZ4q+gDsAIMOzLavajjQugrLJSzDfIEYwLo9LW6djqCblZhNPGkaxj3+nGObscLi47VrYhd9YnJ6nIgQdozXu1Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mUMVd4OU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mUMVd4OU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7579D1F000FF;
	Fri, 11 Sep 2026 09:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789120591;
	bh=5gjeT6XLYTUQv8LQmoB2+vkBmeCJFGpxYPo7P6Y/XEo=;
	h=Subject:To:From:Date;
	b=mUMVd4OUpNFJG4GeERWxpgurRqKY8TOrYcCSCOm2WvEg4Z13npulqWJ94FGXQxgSF
	 0E+M2eTHrov7QAMQAXYaTSN3zeAGPUT4Lprh5F9I6vqi/BUAnmw6UtUNzHFI0Z7db7
	 hrvQpAjQyddlO9jU/s+ZBAjuTMC1g6+Fa1w/MoKo=
Subject: patch "iio: adc: rohm-bd79124: Fix channel initialization" added to char-misc-linus
To: mazziesaccount@gmail.com,Stable@vger.kernel.org,jonathan.cameron@oss.qualcomm.com
From: <gregkh@linuxfoundation.org>
Date: Fri, 11 Sep 2026 11:55:33 +0200
Message-ID: <2026091133-paper-viewable-ced2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: rohm-bd79124: Fix channel initialization

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From edd56c01d174153bf90160279742ff6f3ad27a93 Mon Sep 17 00:00:00 2001
From: Matti Vaittinen <mazziesaccount@gmail.com>
Date: Mon, 10 Aug 2026 10:50:21 +0300
Subject: iio: adc: rohm-bd79124: Fix channel initialization

The alarm limit register on BD79124 span to two consecutive registers.
The first register for high-limit containing also hysteresis
configuration. The initialization in driver writes only one 8-bit
register, overwriting the hysteresis and leaving the other limit
register uninitialized.

Fix the limit initialization by using the bd79124_write_int_to_reg(),
which correctly initializes the limit on both of the registers.

Fixes: 3f57a3b9ab74 ("iio: adc: Support ROHM BD79124 ADC")
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/adc/rohm-bd79124.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/rohm-bd79124.c b/drivers/iio/adc/rohm-bd79124.c
index eab5286763a7..2c031a5e9eb0 100644
--- a/drivers/iio/adc/rohm-bd79124.c
+++ b/drivers/iio/adc/rohm-bd79124.c
@@ -919,13 +919,13 @@ static int bd79124_chan_init(struct bd79124_data *data, int channel)
 {
 	int ret;
 
-	ret = regmap_write(data->map, BD79124_GET_HIGH_LIMIT_REG(channel),
-			   BD79124_HIGH_LIMIT_MAX);
+	ret = bd79124_write_int_to_reg(data, BD79124_GET_HIGH_LIMIT_REG(channel),
+				       BD79124_HIGH_LIMIT_MAX);
 	if (ret)
 		return ret;
 
-	return regmap_write(data->map, BD79124_GET_LOW_LIMIT_REG(channel),
-			    BD79124_LOW_LIMIT_MIN);
+	return bd79124_write_int_to_reg(data, BD79124_GET_LOW_LIMIT_REG(channel),
+					BD79124_LOW_LIMIT_MIN);
 }
 
 static int bd79124_get_gpio_pins(const struct iio_chan_spec *cs, int num_channels)
-- 
2.55.0


