Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232562877DE
	for <Stable@vger.kernel.org>; Sun, 14 Jun 2026 06:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781417071; cv=none; b=CoHqG/txj+JaJeOTdrf4mFfiK0m9FCBj8DEPVDJaWnVC80+wslY0GsfutpbIcy05Me73TDYrNR7I6LCGj4jzcaLwqYjq11GaHcQikPvzC+l/oU5GYcnkhPfjRkT2GK26pRkwzhbcvinKBJTLz+/uuN1AqvOG0q20eDCUYbY7/vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781417071; c=relaxed/simple;
	bh=I0xoKZMl0Ve7P4srZf/OqPddrPvWB99g2YCfz/h7gJk=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=rCmyv2qGP6U2vyfT0u1ENLoYUfCbAh9JWBCWKhVKKoI+I5ofsgYqRTRJIIlSWrPN6kq//5BNNVCYe1jf6Rf+ujZjQ5ESi3Hk6X6oB69FdmOncHtlb9sC5ZhNc7VXZRkV/Cyf5jF0aLMQOWPyIm9LZtgeB8OoIGlCMTZJi7KKjOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=li3TCMX5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="li3TCMX5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B811F000E9;
	Sun, 14 Jun 2026 06:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781417069;
	bh=pN74bmhpcyCz087diixhEeyw9uJM2+eWydfQDT7J7zo=;
	h=Subject:To:From:Date;
	b=li3TCMX5QHg62aiAdboDgIwKNEerq+sGleNEed6eY+1lfpjVYdBN5+gAcSsSVhLSC
	 1EYgPtGWHjAvIDiscwfRsEALAMVl19qIlDlH+ew6pY6ZGCa81zjOiflWoW+ix9pEWs
	 /+TA2T2YccGiuWaRokCxyXikSaHxmN5P/PfGTcGk=
Subject: patch "iio: adc: ad4062: add GPIOLIB dependency" added to char-misc-next
To: arnd@arndb.de,Stable@vger.kernel.org,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 14 Jun 2026 08:03:28 +0200
Message-ID: <2026061428-shorts-lisp-2d2a@gregkh>
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
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

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


