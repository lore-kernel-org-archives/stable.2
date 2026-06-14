Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865B2247291
	for <Stable@vger.kernel.org>; Sun, 14 Jun 2026 05:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781416697; cv=none; b=cW6d1wO3I/KLLjKqem0mHnCqiSbmB3AZIbbjsfluRL7zWIxAWgXToWz2yO3tDSPNhaJA8YNxPHqTKe4p5iXmt3mdnfsjyDLlQD+qHZMxDFPQuGlN8z0wVzIbLV2KOho3ln5L1TQyIW+2+kI7/CX80fog1Os/W9KX+RWwolYpxMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781416697; c=relaxed/simple;
	bh=TMpdAV35MZkiZegHnUGOg35OOF+7mtE2IHk3xbECTro=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=qmlV3Z7U0kCbQTj3zKYheVZ2D/vXWpIAxdFPZYDTPV5pW18O+uqxo/qnCcrciPMzamQN2d5uwXLI0qBn3SNNIwx9nhO6WcEtvbtj4bu0GepCOO6iMWInIYmSQb1au9run2GIH/Kd80YZSRt2lmv1o8rren9cI4dpRcUncOGg9yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tD7EVDg8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tD7EVDg8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92FC21F000E9;
	Sun, 14 Jun 2026 05:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781416696;
	bh=sofgPu6UVYSUNB3gG/HhnE9cABL7H8cKsYR63vW0v74=;
	h=Subject:To:From:Date;
	b=tD7EVDg8vRXQWHsZvqev5uh7QNkDTyBbRWIrO5hFQBGmRZSqJ2L0Tk7JoTEZvg7JG
	 4iwJMyPzucpmH+PWSKqJ7baA2vTl2pGxLnriABgC/wtdci4y95NknotQL6O1WTYCwH
	 1Q87/bG4NeH/hKQC0kGYru+FSULNk4Hw8CDRgnHw=
Subject: patch "iio: adc: ad4062: add GPIOLIB dependency" added to char-misc-testing
To: arnd@arndb.de,Stable@vger.kernel.org,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 14 Jun 2026 07:57:15 +0200
Message-ID: <2026061415-bacon-thirty-8021@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad4062: add GPIOLIB dependency

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From a5b7991d5a737df71a5e4230554481255af64ed4 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 15 May 2026 11:07:53 +0200
Subject: iio: adc: ad4062: add GPIOLIB dependency

The ad4062 driver gained support for the gpiochip and now fails
to build when GPIOLIB is disabled:

390-linux-ld: drivers/iio/adc/ad4062.o: in function `ad4062_gpio_get':
drivers/iio/adc/ad4062.c:1383:(.text+0x3dc): undefined reference to `gpiochip_get_data`

Add a Kconfig dependency for this.

Fixes: da1d3596b1e4 ("iio: adc: ad4062: Add GPIO Controller support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index a9dedbb8eb46..2dcb9980d7c8 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -78,6 +78,7 @@ config AD4030
 config AD4062
 	tristate "Analog Devices AD4062 Driver"
 	depends on I3C
+	depends on GPIOLIB
 	select REGMAP_I3C
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
-- 
2.54.0


