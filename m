Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FD537DEBC
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 07:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791272851; cv=none; b=XZ+juk4gurC4zEmyfEvNOoqTG+1pcSOCDViEZ2O9iXJFo20crG0JCFcheCzvWMsP0+69SZTGyNZSee/5c36ztte0096KEVjL2ga0AS/dsZfmy6Z+cqt0bmR8U5o95HnRz93Eznb/xVHUfGVRx7MD+ygJvAMYEzc3LezRRxCveLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791272851; c=relaxed/simple;
	bh=O9af9ISELmDABa778a5Id1LSmGt+0QMXuNeXCfTQUo8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=c8uGu1VQ9y1csnrrZty3EQ0Wq9ElcOJz1aE+cO9V7Bzd/+6dKPLI6mhJQu8vvK9AOqL4Hq+KK5Mk4xTimd9MtMXQtHA1wxdgMRwYw/Agf+q/GbJD6pTzEZaWMWRxnNUMCRVzEnIm0pSgMbzi9nv97yO2zIbaobM1Ygll9Kd8IiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wLTTWrsn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wLTTWrsn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29871F000FF;
	Tue,  6 Oct 2026 07:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791272850;
	bh=kpyC8XGE4N3gPw3K5BJJWKA5RW1J0T9GROioe0iYsqM=;
	h=Subject:To:Cc:From:Date;
	b=wLTTWrsntQ+/6UC01P9DFGEPqyyy2KKoXXP4Bmag2vTPonzWwqIGB0uU9EcxVD6B2
	 t2yXfeTWKV/kCdeTQhJUkvSll5n8QVFzCZ9UkH49DFp2xEK+WPTG0GkIIMlwfL5wrI
	 eQPZG8O4RkoXiDc9TyHq2Iv6hfXTI4EKtogky0lg=
Subject: FAILED: patch "[PATCH] iio: health: max30102: fix NULL dereference in interrupt" failed to apply to 6.1-stable tree
To: marcochen.dev@gmail.com,jic23@kernel.org,jonathan.cameron@oss.qualcomm.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 06 Oct 2026 09:47:18 +0200
Message-ID: <2026100618-alone-skyward-6cdd@gregkh>
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
git cherry-pick -x f0ea4824deebf21dacfbe397c4b0a5fd3e745a8d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100618-alone-skyward-6cdd@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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
 

