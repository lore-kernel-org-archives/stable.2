Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACFC2F39B5
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 07:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791272854; cv=none; b=llgKBXuhDkEVQTtu5WPL/JdtJ1EvTQ7q0BuXEwowSio0p0z6/gZk4+mReVauu12IMB9F/b9GWY8Ncd4BjqqqhKymnhGTD7mzyKLBIRCBmJUpB6JCEbgeytt7BdY9mSX1kfNEKSz/7Q/CcU/D1BJS4psW0ubY9qFQZkaea3OkQO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791272854; c=relaxed/simple;
	bh=7Ah2Mkg5CrZ9E+J9ObiupOekaZdku3Q3FClOHFlCJ/I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iZKzisiKW5DIVL9ob9hAZ2NBxIXY+T0c0tulE/kUIpKPNPNXWMrP3YBG8+pF27qsaKjTJggK15bTulxYkHSDxT9tMoMwmwg3jEVSuYIO+RWUhcLwt0KC1GaVZmsnMrHP2mU1yksLpIShLReO4RdCKqoVx/OMFC/+oPFIMDo3u2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pvf5/maZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pvf5/maZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBA71F000FF;
	Tue,  6 Oct 2026 07:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791272853;
	bh=ShFtNcgcsyGQsF2ox6GkC7TsJ0a42BHyoL3cHrzD6Kw=;
	h=Subject:To:Cc:From:Date;
	b=pvf5/maZMywx5RfdEMGXde6IBAXuldzW5L8oJYSfH7eWTkv6Fs3ZUdkb8eOJmyX6u
	 +lhh6NeEMzbPHgKgQNqcaq7RMYyI1Vrnx2tbSbNABMsdsEbPsKnj5+8f6OdMbUZFKj
	 0zAPEEuC6fjJz/SC2ZaBAmiqx0E5tzPHESDqzua4=
Subject: FAILED: patch "[PATCH] iio: health: max30102: fix NULL dereference in interrupt" failed to apply to 5.10-stable tree
To: marcochen.dev@gmail.com,jic23@kernel.org,jonathan.cameron@oss.qualcomm.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 06 Oct 2026 09:47:19 +0200
Message-ID: <2026100619-duct-seducing-23f5@gregkh>
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
git cherry-pick -x f0ea4824deebf21dacfbe397c4b0a5fd3e745a8d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100619-duct-seducing-23f5@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f0ea4824deebf21dacfbe397c4b0a5fd3e745a8d Mon Sep 17 00:00:00 2001
From: Marco Chen <marcochen.dev@gmail.com>
Date: Sat, 8 Aug 2026 15:54:50 -0400
Subject: [PATCH] iio: health: max30102: fix NULL dereference in interrupt
 handler

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
 

