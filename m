Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4586A2BEC2C
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 16:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784478678; cv=none; b=X1vDjlh5YlZ8x06TMkLW21QW4wyBPVaDSzzQFHL33VPG7s0Y+IFGosvPVzyK1nvhGnK1R6h8OxbSm9bAygB6D0F4AIpuot2EKmci2kKt85w1kHW2ELZXrp1Zx65+bP9nw/a8nv3EwM+m+CSzZUM5qmbAMEM3DFQesmZzWWl5VOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784478678; c=relaxed/simple;
	bh=6KD9SnE6JFA/6StnZlkgQoUQOoaI1PXZbcZwkdKBEbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUoe7SFT8IJ4q1eZWS3HjCLMfaLDB2RFPBlarIJXjlO0VHF2wbudZsOIoBjGe077HNDp2k1ziE+cs3le0YurJrmpQTDAiUkcOl2KRzNE59Gn0SfLeRV/Xkad+gO7N47Fy1vjwn9gd1ZBSPMnJpllXru+sN1/LnZsi6G6xj5EpO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENtX7LQS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENtX7LQS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C88F1F00A3A;
	Sun, 19 Jul 2026 16:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784478676;
	bh=MKAHXtUrzeCabd0wrO61LnxygmeEPsnY2lyHRCyr7WY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ENtX7LQSd1jOqqK/TtuYHgdtpq7WygDDVYHIAmslzAf3mSq80j+KNZTF4sVx8QhDf
	 AChRmRTlJWV1r5FY2vg25N0jmzyBtKHwvJq+TBEvbzu9cQx42Ijl8MZuye1lpaSd/9
	 RxxGdfyEiNNNUN77I2M8zNSRjjgri4nS2kU9pK28+24B9C4/dzxuJx72Rr1OucIUEt
	 5xz+BnYT8Qfjcy7/q05f4NntHhM5oCjRxpbhHJQsKys+RsLnpFv3kf1o0lbvAG5XHV
	 p1vKzV8/nHwvfJFFH1CBD671dWJm6VQAKJsd++2YueQxLFNsgFXf8AGXdtdrzuVcIr
	 qpcS8bvpHn5fg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	stable <stable@kernel.org>,
	Yue Sun <samsun1006219@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] USB: iowarrior: fix use-after-free on disconnect race
Date: Sun, 19 Jul 2026 12:31:13 -0400
Message-ID: <20260719163113.566274-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260719163113.566274-1-sashal@kernel.org>
References: <2026071456-grueling-pucker-b80f@gregkh>
 <20260719163113.566274-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit c602254ba4c10f60a73cd99d147874f86a3f485c ]

mutex_unlock() may access the mutex structure after releasing the lock
and therefore cannot be used to manage lifetime of objects directly
(unlike spinlocks and refcounts). [1][2]

Use a kref to release the driver data to avoid use-after-free in
mutex_unlock() when release() races with disconnect().

[1] a51749ab34d9 ("locking/mutex: Document that mutex_unlock() is non-atomic")
[2] 2b9d9e0a9ba0 ("locking/mutex: Clarify that mutex_unlock(), and most
                   other sleeping locks, can still use the lock object
                   after it's unlocked")

Fixes: 946b960d13c1 ("USB: add driver for iowarrior devices.")
Cc: stable <stable@kernel.org>
Reported-by: Yue Sun <samsun1006219@gmail.com>
Link: https://lore.kernel.org/r/20260618080204.38322-1-samsun1006219@gmail.com
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260622152612.116422-2-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/misc/iowarrior.c | 57 +++++++++++++++---------------------
 1 file changed, 24 insertions(+), 33 deletions(-)

diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index 770f0044d8e2ff..7a754449c81412 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -71,6 +71,7 @@ static struct usb_driver iowarrior_driver;
 
 /* Structure to hold all of our device specific stuff */
 struct iowarrior {
+	struct kref kref;
 	struct mutex mutex;			/* locks this structure */
 	struct usb_device *udev;		/* save off the usb device pointer */
 	struct usb_interface *interface;	/* the interface for this device */
@@ -243,8 +244,10 @@ static void iowarrior_write_callback(struct urb *urb)
 /*
  *	iowarrior_delete
  */
-static inline void iowarrior_delete(struct iowarrior *dev)
+static inline void iowarrior_delete(struct kref *kref)
 {
+	struct iowarrior *dev = container_of(kref, struct iowarrior, kref);
+
 	kfree(dev->int_in_buffer);
 	usb_free_urb(dev->int_in_urb);
 	kfree(dev->read_queue);
@@ -641,6 +644,9 @@ static int iowarrior_open(struct inode *inode, struct file *file)
 	}
 	/* increment our usage count for the driver */
 	++dev->opened;
+
+	kref_get(&dev->kref);
+
 	/* save our object in the file's private structure */
 	file->private_data = dev;
 	retval = 0;
@@ -656,7 +662,6 @@ static int iowarrior_open(struct inode *inode, struct file *file)
 static int iowarrior_release(struct inode *inode, struct file *file)
 {
 	struct iowarrior *dev;
-	int retval = 0;
 
 	dev = file->private_data;
 	if (!dev)
@@ -664,29 +669,18 @@ static int iowarrior_release(struct inode *inode, struct file *file)
 
 	/* lock our device */
 	mutex_lock(&dev->mutex);
+	dev->opened = 0;	/* we're closing now */
 
-	if (dev->opened <= 0) {
-		retval = -ENODEV;	/* close called more than once */
-		mutex_unlock(&dev->mutex);
-	} else {
-		dev->opened = 0;	/* we're closing now */
-		retval = 0;
-		if (dev->present) {
-			/*
-			   The device is still connected so we only shutdown
-			   pending read-/write-ops.
-			 */
-			usb_kill_urb(dev->int_in_urb);
-			wake_up_interruptible(&dev->read_wait);
-			wake_up_interruptible(&dev->write_wait);
-			mutex_unlock(&dev->mutex);
-		} else {
-			/* The device was unplugged, cleanup resources */
-			mutex_unlock(&dev->mutex);
-			iowarrior_delete(dev);
-		}
+	if (dev->present) {
+		usb_kill_urb(dev->int_in_urb);
+		wake_up_interruptible(&dev->read_wait);
+		wake_up_interruptible(&dev->write_wait);
 	}
-	return retval;
+	mutex_unlock(&dev->mutex);
+
+	kref_put(&dev->kref, iowarrior_delete);
+
+	return 0;
 }
 
 static __poll_t iowarrior_poll(struct file *file, poll_table * wait)
@@ -771,6 +765,7 @@ static int iowarrior_probe(struct usb_interface *interface,
 	if (!dev)
 		return retval;
 
+	kref_init(&dev->kref);
 	mutex_init(&dev->mutex);
 
 	atomic_set(&dev->intr_idx, 0);
@@ -889,7 +884,8 @@ static int iowarrior_probe(struct usb_interface *interface,
 	return retval;
 
 error:
-	iowarrior_delete(dev);
+	kref_put(&dev->kref, iowarrior_delete);
+
 	return retval;
 }
 
@@ -910,20 +906,15 @@ static void iowarrior_disconnect(struct usb_interface *interface)
 	dev->present = 0;
 
 	if (dev->opened) {
-		/* There is a process that holds a filedescriptor to the device ,
-		   so we only shutdown read-/write-ops going on.
-		   Deleting the device is postponed until close() was called.
-		 */
 		usb_kill_urb(dev->int_in_urb);
 		usb_kill_anchored_urbs(&dev->submitted);
 		wake_up_interruptible(&dev->read_wait);
 		wake_up_interruptible(&dev->write_wait);
-		mutex_unlock(&dev->mutex);
-	} else {
-		/* no process is using the device, cleanup now */
-		mutex_unlock(&dev->mutex);
-		iowarrior_delete(dev);
 	}
+
+	mutex_unlock(&dev->mutex);
+
+	kref_put(&dev->kref, iowarrior_delete);
 }
 
 /* usb specific object needed to register this driver with the usb subsystem */
-- 
2.53.0

