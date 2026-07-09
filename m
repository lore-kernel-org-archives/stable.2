Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0162E11C7
	for <Stable@vger.kernel.org>; Thu,  9 Jul 2026 05:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575961; cv=none; b=Putub+wqzoc6s3J5TWYxNLsoBvs6NsAA/xKs/EITt+na5pIgA2c7PS9ThdWY7uT8BTSX1Z9/sPCiz/582KoyXIfzC54abtH8giQkmK3FobkGIbyfrfQekl8RmlD80JVDoLDW8swVmzha0tkl7MviDPrWyHxop+z480XfZVdUiA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575961; c=relaxed/simple;
	bh=8X7/3MejPNIQw3K2vYW/4916/Adqd5gm3gAI+KRKLbM=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=hPbZz1IDQRmnm0djpmu8sNw1kjUjpuCWN2TK8Fh2DVr6TaPVbbsff5nrQrCGQ3VvwCJVYOVNBpBp2C+mJlCKPWCOqD3EHM8LeCAo5aY2Rgk8FZx4i44ZQh5Rx8R5+XU1OshVbk72rE4FJ1t+dgHscX/+qkoNdacwvv2U4PU+eJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eVN08M7y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eVN08M7y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FB381F000E9;
	Thu,  9 Jul 2026 05:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783575960;
	bh=Ku2nKr8yHEh459UCw54HoRXeHAtlkAIab6SQ85CIQt0=;
	h=Subject:To:From:Date;
	b=eVN08M7yf8RJLWq2SlBxxr8J7IvmG/QL6Y9rc78IcVRet/65Hrv3ToKr6DN6OxP4j
	 pyLHV5HOB58R8A6ZOS9epNjEAKZUTC0UdIeGm2vNTLv31DXE6CLNUbhj3qfEzN4bGO
	 hqvZZ4a3P2vZBCvcyZ5c8yALQLNlYzjYqzcuq9ps=
Subject: patch "iio: event: Fix event FIFO reset race" added to char-misc-linus
To: lars@metafoo.de,Stable@vger.kernel.org,jic23@kernel.org,nuno.sa@analog.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 09 Jul 2026 07:44:53 +0200
Message-ID: <2026070953-sloping-unmanaged-f842@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: event: Fix event FIFO reset race

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From af791d295737ea6b6ff2c8d8488462a49c14af01 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Mon, 6 Jul 2026 21:48:26 -0700
Subject: iio: event: Fix event FIFO reset race
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

`iio_event_getfd()` creates the event file descriptor with
`anon_inode_getfd()`, which allocates a new fd, creates the anonymous
file and installs it in the process fd table before returning to the
caller.

The IIO code resets the event FIFO after `anon_inode_getfd()` has returned,
but before `IIO_GET_EVENT_FD_IOCTL` has copied the fd number to userspace.
But since fd tables are shared between threads, another thread can guess
the newly allocated fd number and issue a `read()` on it as soon as the fd
has been installed.

This means the `kfifo_to_user()` in `iio_event_chrdev_read()` can run in
parallel with the `kfifo_reset_out()` in `iio_event_getfd()`.

The kfifo documentation says that `kfifo_reset_out()` is only safe when it
is called from the reader thread and there is only one concurrent reader.
Otherwise it is dangerous and must be handled in the same way as
`kfifo_reset()`.

If that happens, `kfifo_to_user()` can advance the FIFO `out` index based
on state from before the reset, after the reset has already moved the `out`
index to the current `in` index. That can leave the FIFO with an `out`
index past the `in` index. A later `read()` can then see an underflowed
FIFO length and copy more data than the event FIFO buffer contains. This
can result in an out-of-bounds read and leak adjacent kernel memory to
userspace.

Move the FIFO reset before `anon_inode_getfd()`. At that point the event fd is
marked busy, but the new fd has not been installed yet, so userspace cannot
access it while the FIFO is reset.

Fixes: b91accafbb10 ("iio:event: Fix and cleanup locking")
Reported-by: Codex:gpt-5.5
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/industrialio-event.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index a0d6fcf2a9c9..e6730f52262a 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -207,6 +207,8 @@ static int iio_event_getfd(struct iio_dev *indio_dev)
 		goto unlock;
 	}
 
+	kfifo_reset_out(&ev_int->det_events);
+
 	iio_device_get(indio_dev);
 
 	fd = anon_inode_getfd("iio:event", &iio_event_chrdev_fileops,
@@ -214,10 +216,7 @@ static int iio_event_getfd(struct iio_dev *indio_dev)
 	if (fd < 0) {
 		clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
 		iio_device_put(indio_dev);
-	} else {
-		kfifo_reset_out(&ev_int->det_events);
 	}
-
 unlock:
 	mutex_unlock(&iio_dev_opaque->mlock);
 	return fd;
-- 
2.55.0


