Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9AC39AD33
	for <Stable@vger.kernel.org>; Wed, 19 Aug 2026 07:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125492; cv=none; b=FiBqy2120vP45/vMzHnthIgI77fJsPAYYYx9flnLkn14GuXIiGExi5kMk42WwJySroUKu+mUFUdQCPGtWL8it48Qr71yjqV+Enf6mnhxJTBhIo/7ZLvu2jQMDNs0qwauWxUFI5mF4RV1oyQ9TH66cbeTaKB8YIJ+Asq5Z6A8zKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125492; c=relaxed/simple;
	bh=FCF+djUuz8ZLqWDX2lWWFcPxaVIjgciNuKS4ymQCY9s=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=Ea1FgBzOChJa/mErWBHdZMlVCeA8s1U5lZSXqm9YCOpciqnAGgFIHifiRQrHr59kKrNW/pdYu3KHja4gJvMHcaOZz4AiypdZaIsOb7z9ZwTXzzlBUa4gI8isNL7zwY7f+1SVLDsPqCVIC0Pg78lgrVEjy6aOkebiyH6sTcDetZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rRQr/1pQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rRQr/1pQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5031F000E9;
	Wed, 19 Aug 2026 07:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787125486;
	bh=GxELEdBdvgQAjQuJPfZ523k5pak/UekeohzITWR+YN8=;
	h=Subject:To:From:Date;
	b=rRQr/1pQ4V9yRBZX8LjFixuuSKuCRTLzZl4xSsIvkyvPobMmaX1PCJZakso+U/KpR
	 4tll5xGuxdyDvpm6J8e1dwkPlGP54wfli+mOWjC5mt+9BvohKPAZ90GDNyeGrLPFd6
	 vQuWRGVTvGQwWgfQ6oJtFI7uRUTsIkVCO+ed4jmg=
Subject: patch "iio: buffer: Make IIO DMA fence release RCU-safe" added to char-misc-testing
To: lars@metafoo.de,Stable@vger.kernel.org,jonathan.cameron@oss.qualcomm.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Aug 2026 09:44:05 +0200
Message-ID: <2026081905-treachery-daringly-1920@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: buffer: Make IIO DMA fence release RCU-safe

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 8662e56c31cf23b61ca3d11b516efb94c35b8026 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Wed, 15 Jul 2026 08:42:45 -0700
Subject: iio: buffer: Make IIO DMA fence release RCU-safe

The `dma_fence` documentation states that if a custom release
implementation is provided, the `dma_fence` object must be freed in an
RCU-safe way. The current `iio_dma_fence` implementation uses `kfree()`,
which might result in a use-after-free.

Remove the custom `release` implementation. This makes the DMA fence core
fall back to `dma_fence_free()`, which calls `kfree_rcu()` on the fence.
This requires that the fence be the first member of `struct iio_dma_fence`.

Using the default release method for extended DMA fence structures is a
common pattern.

Reported-by: codex:gpt-5.6
Fixes: 3e26d9f08fbe ("iio: core: Add new DMABUF interface infrastructure")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/industrialio-buffer.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 31c06bffdce8..2c9ec93dff47 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -54,6 +54,10 @@ struct iio_dmabuf_priv {
 };
 
 struct iio_dma_fence {
+	/*
+	 * Must remain the first member so the default release callback can pass
+	 * the fence directly to dma_fence_free().
+	 */
 	struct dma_fence base;
 	spinlock_t lock; /* protects base */
 	struct iio_dmabuf_priv *priv;
@@ -1828,18 +1832,9 @@ iio_buffer_dma_fence_get_driver_name(struct dma_fence *fence)
 	return "iio";
 }
 
-static void iio_buffer_dma_fence_release(struct dma_fence *fence)
-{
-	struct iio_dma_fence *iio_fence =
-		container_of(fence, struct iio_dma_fence, base);
-
-	kfree(iio_fence);
-}
-
 static const struct dma_fence_ops iio_buffer_dma_fence_ops = {
 	.get_driver_name	= iio_buffer_dma_fence_get_driver_name,
 	.get_timeline_name	= iio_buffer_dma_fence_get_driver_name,
-	.release		= iio_buffer_dma_fence_release,
 };
 
 static int iio_buffer_enqueue_dmabuf(struct iio_dev_buffer_pair *ib,
-- 
2.55.0


