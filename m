Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E178C3E5A03
	for <Stable@vger.kernel.org>; Wed, 19 Aug 2026 07:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125481; cv=none; b=k1E0lfoTU0r30Df86DewrdpmU8j+INqgk6ce5D4TwcyPZXgoc7jHmFg7Ar4oxw1c1SsGwSzy11e8k7a0Sz+3Z/REatO7o1t351v4FdPHFZ6+kDB6MOk9Ckxq9oknGBWXIZHSC2G/5wgReO0xDjYnEhCKJjKPShm2KJK9ewphvSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125481; c=relaxed/simple;
	bh=m660o+1W/FOcGmPuI3FHunVYosUjeOO8AYDUk/ir4og=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=XsMjJmMMopNaBD4RpxdxanVzUUQh7Gz27OW+rA7IYkHviA2Qg8JYJpZJceSeh/aK4Bdt4qAP6R3xxyBZ9AD3F5k7xW6X9T8CgtQOQcPl0RmJnlxirOIXaoAItzDLXijo2A6QBsPc1cjwYeCHrAxGo0hLVvBJR9WDgxQ9d59Aagg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ESFp7rPi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ESFp7rPi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB0111F00A3A;
	Wed, 19 Aug 2026 07:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787125477;
	bh=e0+Yeihjje4OkDT4NUadYelGk0qdiGMcUOUcu/gE89g=;
	h=Subject:To:From:Date;
	b=ESFp7rPi102tGfEmvGfMYiTK04XwF4vkA7Wd2cdLaJPBhUBPc6gpIecDYbiidpZ4v
	 /Xgq+a3D0dfgDHZ8WrPTsc4wB2HDMGKMfv3JBdJe94fsnCsvMuG+94mukuAUtYcRoU
	 4RM+AFL4rGVIYO/TxbMqWsju74CC6Zg0vr8/h/xc=
Subject: patch "iio: buffer: Fix potential use-after-free in anonymous buffer release" added to char-misc-testing
To: lars@metafoo.de,Stable@vger.kernel.org,andriy.shevchenko@intel.com,jonathan.cameron@oss.qualcomm.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Aug 2026 09:44:04 +0200
Message-ID: <2026081904-stench-sterilize-3493@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: buffer: Fix potential use-after-free in anonymous buffer release

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 6288b593e76eb10329326f2cd51e32557203b9e5 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Wed, 15 Jul 2026 08:42:43 -0700
Subject: iio: buffer: Fix potential use-after-free in anonymous buffer release

An anonymous buffer handle holds a reference to the underlying IIO device.
The reference is dropped in the buffer handle's release function. If the
device has been removed, either through unbind or hot-unplug, the buffer
handle might hold the last reference.

The release function takes the mutex for the buffer using a guard, which
means the unlock happens after all the code in the function, including
`iio_device_put()`. If the anonymous buffer holds the last reference this
might free both the IIO device and the buffer, which contains the mutex,
leading to use-after-free when the mutex is unlocked.

Fix this by using a scoped guard just around the buffer dmabuf list access,
making sure the mutex is unlocked before releasing the IIO device.

Version 10 of the patch that introduced this issue used this exact scheme
of first unlocking and then dropping the reference [1]. During review it
was suggested to use a guard instead, and version 11 made that change [2].

Reported-by: codex:gpt-5.6
Fixes: 3e26d9f08fbe ("iio: core: Add new DMABUF interface infrastructure")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Link: https://lore.kernel.org/linux-iio/20240605110845.86740-4-paul@crapouillou.net #[1]
Link: https://lore.kernel.org/linux-iio/20240618100302.72886-4-paul@crapouillou.net #[2]
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/industrialio-buffer.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 531fc4ccc15d..04b3916f89e2 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1619,12 +1619,16 @@ static int iio_buffer_chrdev_release(struct inode *inode, struct file *filep)
 
 	wake_up(&buffer->pollq);
 
-	guard(mutex)(&buffer->dmabufs_mutex);
-
-	/* Close all attached DMABUFs */
-	list_for_each_entry_safe(priv, tmp, &buffer->dmabufs, entry) {
-		list_del_init(&priv->entry);
-		iio_buffer_dmabuf_put(priv->attach);
+	/*
+	 * The mutex must be unlocked before iio_device_put(), which might drop the
+	 * last reference and free the buffer.
+	 */
+	scoped_guard(mutex, &buffer->dmabufs_mutex) {
+		/* Close all attached DMABUFs */
+		list_for_each_entry_safe(priv, tmp, &buffer->dmabufs, entry) {
+			list_del_init(&priv->entry);
+			iio_buffer_dmabuf_put(priv->attach);
+		}
 	}
 
 	kfree(ib);
-- 
2.55.0


