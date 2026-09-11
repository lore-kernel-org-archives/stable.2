Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8D6388390
	for <Stable@vger.kernel.org>; Fri, 11 Sep 2026 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120555; cv=none; b=bGIkMeslhhSDXWIy7/6vPPHP3t3POEmzf6XjLDW+HhGXxo27yCiBTKYQWkeBchb6DwycVw0azd50i6sQokMw+Pcz74N3mIXheJ2TXo98nNly9w2F4lifHW2Kjst4YgLTaed4ofPt7ZLy8RDi99s82nS1lAwtahTKoiYIv93+FhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120555; c=relaxed/simple;
	bh=VuviMpvIeFgYRASIvXl+KqtnYw1xdTgfVN1by1XKUWM=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=POejKHUgiWtA601XQtlCUmDzLLv0yvXGri/w5sfKUotJ/XZoLgxBgL6fCIE91iyD8shBHtBLwURiY4ziA0Yt7krtTb80tFrCqfnwK6FDqSPwVnJreni2Z0xUUJPLk+x7+5twM2K2YeiYjVEQhz+Vzz9FbbK+peHMeaeiEwRPDrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BOLqy/QD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BOLqy/QD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51B201F000FF;
	Fri, 11 Sep 2026 09:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789120554;
	bh=Et6annJT+5wLzlqA+4iTtoHXiCMAEqxgYFBn/73TW8Y=;
	h=Subject:To:From:Date;
	b=BOLqy/QD2lbE7Uu/rE3OSR9J2xaV013aWCcidR2F/DTjk8ulNLOG49gi+aNY9OQDo
	 D4RQWl2TxO+c/dvXhnl5naTW8CbiCAlin40+8n+ktw2FSt3KUgSlqXCbJX6Ec6B1Hk
	 AOhvLgQZHVUJztezW869VfDX6INbBS7iDk9QCRnY=
Subject: patch "iio: adc: ade9000: request interrupts after powering the device" added to char-misc-linus
To: antoniu.miclaus@analog.com,Stable@vger.kernel.org,jonathan.cameron@oss.qualcomm.com,joshua.crofts1@gmail.com
From: <gregkh@linuxfoundation.org>
Date: Fri, 11 Sep 2026 11:55:31 +0200
Message-ID: <2026091131-fifteen-mammary-24b3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ade9000: request interrupts after powering the device

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 88fda1ed51a579eb51980436abc6557006a520a3 Mon Sep 17 00:00:00 2001
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
Date: Fri, 7 Aug 2026 11:56:41 +0300
Subject: iio: adc: ade9000: request interrupts after powering the device

The IRQ handlers do SPI register accesses, but the interrupts were
requested before the vdd regulator was enabled. An interrupt arriving
while the chip is unpowered runs a handler against a dead chip, causing
SPI errors or garbage reads.

Request the interrupts after enabling the regulator. This keeps irq1
registered before ade9000_reset(), which waits on it, and lets devm free
the interrupts before the regulator is disabled.

Fixes: 81de7b4619fc ("iio: adc: add ade9000 support")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/adc/ade9000.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index c6c3ea953fea..51cb43755a1f 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -1705,18 +1705,6 @@ static int ade9000_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = ade9000_request_irq(dev, "irq0", ade9000_irq0_thread, indio_dev);
-	if (ret)
-		return ret;
-
-	ret = ade9000_request_irq(dev, "irq1", ade9000_irq1_thread, indio_dev);
-	if (ret)
-		return ret;
-
-	ret = ade9000_request_irq(dev, "dready", ade9000_dready_thread, indio_dev);
-	if (ret)
-		return ret;
-
 	/* External CMOS clock input (optional - crystal can be used instead) */
 	st->clkin = devm_clk_get_optional_enabled(dev, NULL);
 	if (IS_ERR(st->clkin))
@@ -1736,6 +1724,19 @@ static int ade9000_probe(struct spi_device *spi)
 		return dev_err_probe(&spi->dev, ret,
 				     "Failed to get and enable vdd regulator\n");
 
+	/* Request IRQs only after powering the chip; the handlers do SPI access. */
+	ret = ade9000_request_irq(dev, "irq0", ade9000_irq0_thread, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = ade9000_request_irq(dev, "irq1", ade9000_irq1_thread, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = ade9000_request_irq(dev, "dready", ade9000_dready_thread, indio_dev);
+	if (ret)
+		return ret;
+
 	indio_dev->channels = ade9000_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ade9000_channels);
 
-- 
2.55.0


