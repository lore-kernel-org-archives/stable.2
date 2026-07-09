Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D2B3AA9CA
	for <Stable@vger.kernel.org>; Thu,  9 Jul 2026 05:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575890; cv=none; b=UyWTa8eqhTS8J9yihofW4xKC2ukKDKwzVJQpasF4tq8RYyHWYT4lFbvBrctcoLbuXzJlapjq6gC3uL0mP4yU9OKBM73VeU9rnqaiqQgkfTZYupCWm09wnyCUyk/Z6ii9zEOobRDePYIVswxSjs91XUdgWVI10HLTxWEixNwGJEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575890; c=relaxed/simple;
	bh=yBMD/JxlhjguYlXlia+nF8C+3mRSJbPS5WrLhI57vKk=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=eJ/Bp0o1YunjeaEchcprrT2pr087+8u8DIySClH7oxmuP+Cq5xffhBSinrGjTcFEADC2lzWI5WGcqDWayd+KG1HWmXpbSf+O3ndfxGzeVmmqwKgmyfAyZ5Voe/JCRfCSgfMCyQmJaqJaFW8/1AyIvne8I4a+gOhXvPu+vflokvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PGhmN98r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PGhmN98r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71281F000E9;
	Thu,  9 Jul 2026 05:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783575889;
	bh=8VkR4l1LFRH8NfYYI/tEaflzyrW+XFdiMBzYHeduqZI=;
	h=Subject:To:From:Date;
	b=PGhmN98ru9G4kYjDW+VMf4QjB5JmP3nNaulJlQVUEse6lqUKLQxIpktXuNec6hdkG
	 2NRJd297n7WXXNhfuze46ORw7PDNCHnMHkiCEJ8aQ5Grcf03TNeU4+TSB5MA6bPfkw
	 TRxNEKot/aiS+VWdXQxRouOYU/wu5nyFh51s14GI=
Subject: patch "iio: adc: ad7380: select REGMAP" added to char-misc-linus
To: samuel.moelius@trailofbits.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com,jic23@kernel.org,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 09 Jul 2026 07:44:45 +0200
Message-ID: <2026070945-cylinder-yanking-58c8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ad7380: select REGMAP

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 6697091b386a4e2830bdd38512c87a4befff2b32 Mon Sep 17 00:00:00 2001
From: Samuel Moelius <samuel.moelius@trailofbits.com>
Date: Tue, 2 Jun 2026 16:45:39 +0000
Subject: iio: adc: ad7380: select REGMAP
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The AD7380 driver uses generic regmap types and APIs. However, its
Kconfig entry does not select REGMAP.

As a result, AD7380 can be enabled from an allnoconfig-derived config
with SPI_MASTER=y while REGMAP remains unset, causing ad7380.o to fail
to build.

Fixes: b095217c104b ("iio: adc: ad7380: new driver for AD7380 ADCs")
Signed-off-by: Samuel Moelius <samuel.moelius@trailofbits.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/adc/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 1c663c98c6c9..6fb0766ca27a 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -328,6 +328,7 @@ config AD7298
 config AD7380
 	tristate "Analog Devices AD7380 ADC driver"
 	depends on SPI_MASTER
+	select REGMAP
 	select SPI_OFFLOAD
 	select IIO_BUFFER
 	select IIO_BUFFER_DMAENGINE
-- 
2.55.0


