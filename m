Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAAE3F54BB
	for <Stable@vger.kernel.org>; Wed, 19 Aug 2026 07:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125646; cv=none; b=NpZjZxNfoqwq3vM13gNf3z4lBK8DrbFtKDd/LYsOsYNjHFAR0pUdCIDMRIzp//QeRVDZHk41cpDjCryjYuYHRFrNqsUdprsnlrJsynWTvrjXBnxp7A/tHAgi/G4Q4j+9BEJ9PkbmmdlTTByBHEeLRhBl+Ka6oIVSjZVD+nQrdDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125646; c=relaxed/simple;
	bh=2x2giMu5f2usi+lEnyy6qxvIUbUYgjmCvEo6DhRtSlo=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=RnRKrCIUoYnuGvhae6x+m9eEH/sWGlSI/5jdui9pjQqpSB7H9FUVsA3Ij1dttl+H+/gldmjUFw4OxfI4lorFIcrg7iIYMuEjipVM8Qzich9rYO+EXgn5w8YOaCkL3FT8GUJfVH7Wb+kyppvnoomAIiDSoBs8E64W0mN+wk00Fdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oI4fQRvw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oI4fQRvw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 553E81F000E9;
	Wed, 19 Aug 2026 07:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787125645;
	bh=A7++FK3lUkJc/hon6slMfI+3fBuzNWjisjGGpaCRpYM=;
	h=Subject:To:From:Date;
	b=oI4fQRvw0dWKJ4F2ssDgJODJfJSP7EcdbP34Ukh0oHHo0h8gjjSSoVeqoOSwx15f7
	 UFl8GE5Ka2PPQP2rufJgNRtqUYC3gJ++k71bLQ6NoG9WAs/VYvBkcmvqXPR7jdupHQ
	 1Hi/YHubHt4kC7g20ftj/KmAwiR4rPiW1+vutlU0=
Subject: patch "iio: buffer: Fix potential use-after-free in anonymous buffer release" added to char-misc-next
To: lars@metafoo.de,Stable@vger.kernel.org,andriy.shevchenko@intel.com,jonathan.cameron@oss.qualcomm.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Aug 2026 09:44:36 +0200
Message-ID: <2026081936-graffiti-snowman-e878@gregkh>
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
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

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


