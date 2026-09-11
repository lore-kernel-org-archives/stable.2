Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477D42FD69E
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120542; cv=none; b=G0b+rwJR15X8sZa7U4tb1mUnoN5AuJXcu1uAsoDSmxbJF1b6dhV4hqII7yBQ95KY4zE7X0Wwq8HV1wourzFs23DNJhtMD9Z0N6py8CouYXbviYA8bN2kg1naEFKiVYOdESydLqSGUZCaNGG+vK//ujO0Hi8YQrgNihJmec3pt4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120542; c=relaxed/simple;
	bh=LJubOECF6XWs8IXoBXq14w5Z5iD6zbSLQm/PCQYPue4=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=Ho0GVIo7FMEASgZzojbB5jh4guLs7qbC6PVjTL2Am/QICB/KpcgpIiW1rSa0oqOhBCWra/M3GfQn1sw55M8AI9uH2cA8ZK5zzT3xxp+Sv3aT+T7FoabTrQyDpjnj+Cn7B6PjZL+u1bcYTVkG5k0PqWELobkJWsTs0W4eaHGF6Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TvjdgZnL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TvjdgZnL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B31D1F000FF;
	Fri, 11 Sep 2026 09:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789120540;
	bh=DxYtQ+IRmJ6qfSB4ScxqAoQtrxMimid+IqOgENv1Y8M=;
	h=Subject:To:From:Date;
	b=TvjdgZnL9MGsUsH0Y/68KfME17tMX7K5xTAvZ3EgqiAJLQ2vniY0+gB4ZBCIEtLKr
	 HYmErhbx18BSI8Qx1ESdB7lasIgyFoe5Zpau1bBIwQzEdkzxGi6PWWkm2DLeUkkWFz
	 UTDa9D/BdJaTJIYCf+1JsVZee1JHT41nTHNlPQVU=
Subject: patch "iio: health: max30102: fix NULL dereference in interrupt handler" added to char-misc-linus
To: marcochen.dev@gmail.com,jic23@kernel.org,jonathan.cameron@oss.qualcomm.com,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 11 Sep 2026 11:55:30 +0200
Message-ID: <2026091130-geologist-pox-959b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: health: max30102: fix NULL dereference in interrupt handler

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From f0ea4824deebf21dacfbe397c4b0a5fd3e745a8d Mon Sep 17 00:00:00 2001
From: Marco Chen <marcochen.dev@gmail.com>
Date: Sat, 8 Aug 2026 15:54:50 -0400
Subject: iio: health: max30102: fix NULL dereference in interrupt handler

The interrupt is requested in max30102_probe() and stays enabled
for the lifetime of the device, but indio_dev->active_scan_mask is only
valid while a buffer is enabled. When an interrupt arrives while no
buffer is enabled, the handler dereferences the NULL active_scan_mask:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
  Call trace:
   __bitmap_weight+0x64/0x98 (P)
   max30102_interrupt_handler+0x48/0x160 [max30102]

Call max30102_fifo_count() at the top of the handler and return early
unless it reports a FIFO sample is ready. Because FIFO_RDY is the only
interrupt source enabled in max30102_chip_init(), an invocation of
max30102_interrupt_handler() without the FIFO_RDY interrupt status bit
set carries no data to read and can return before touching
active_scan_mask. A negative return from max30102_fifo_count()
indicates a failed interrupt status read and is treated the same way.

Fixes: 90579b69e94b ("iio: health: max30102: Add MAX30105 support")
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Marco Chen <marcochen.dev@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/health/max30102.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index c37316c86f14..aee96167f01e 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -290,9 +290,15 @@ static irqreturn_t max30102_interrupt_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
 	struct max30102_data *data = iio_priv(indio_dev);
-	unsigned int measurements = bitmap_weight(indio_dev->active_scan_mask,
-						  iio_get_masklength(indio_dev));
-	int ret, cnt = 0;
+	unsigned int measurements;
+	int ret, cnt;
+
+	cnt = max30102_fifo_count(data);
+	if (cnt <= 0)
+		return IRQ_HANDLED;
+
+	measurements = bitmap_weight(indio_dev->active_scan_mask,
+				     iio_get_masklength(indio_dev));
 
 	mutex_lock(&data->lock);
 
-- 
2.55.0


