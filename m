Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6164B4A3406
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784045042; cv=none; b=tBVUicLlQqOM0n/QNIo3mNLby6OxZrIC/aA8LIqHWcgbw2jd0k7/obPU2WuG68ndZebJvA5x6ePXeIB6hKFkHIDMW2uo8YaDG46Cuy019O016A1Wn0l9M7JheaYsoKWJhfGN1YIQUok/gk9qtGbuEPmwJfVYI76kqLH9BTTDPxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784045042; c=relaxed/simple;
	bh=ujlh7b9nF3eM72If/ZeiBFpwRTbdaLQC2moi1BMBpBI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Z5LyqqQoMn2qrMchK5YDqhZXfIMy3RJppOqjUuxVklKYBnumgZ4WcqhShJq3OPmdCRfb6hZOlhNxFh+COIm/o4/dZw0pNRq4u38BicGeH+DckHWivqaoPIoXHbkXb0OruRE1vDnSaGFLLtNKKKO19WfH7qH74c92/K05hWmjkcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YWq1wqku; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YWq1wqku"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBF11F000E9;
	Tue, 14 Jul 2026 16:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784045041;
	bh=ZAeHRrPdc/Oi6pZme14o9XvtXeVXxTn+4qPBm605J2g=;
	h=Subject:To:Cc:From:Date;
	b=YWq1wqkuaauug8oC5BVIUNXwQHGe9dlrB0AHlWupQQXK7qYPw7Rh7oH47b/FE4c17
	 JPueQINNlscr7FRiZyMWpJP+iFGFUbgZqCyGDsAHs3t0t6+7PuLjOyBpKmZNaVkrzT
	 n/O60rTrOK3CrlNRBEtqw0tCSX4M8XSejnb02+64=
Subject: FAILED: patch "[PATCH] USB: iowarrior: fix use-after-free on disconnect race" failed to apply to 6.18-stable tree
To: johan@kernel.org,gregkh@linuxfoundation.org,samsun1006219@gmail.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 18:03:55 +0200
Message-ID: <2026071455-frostily-swimsuit-a10b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x c602254ba4c10f60a73cd99d147874f86a3f485c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071455-frostily-swimsuit-a10b@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c602254ba4c10f60a73cd99d147874f86a3f485c Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Mon, 22 Jun 2026 17:26:09 +0200
Subject: [PATCH] USB: iowarrior: fix use-after-free on disconnect race

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

diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index 88c6d1d1da11..de2b236ef903 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -72,6 +72,7 @@ static struct usb_driver iowarrior_driver;
 
 /* Structure to hold all of our device specific stuff */
 struct iowarrior {
+	struct kref kref;
 	struct mutex mutex;			/* locks this structure */
 	struct usb_device *udev;		/* save off the usb device pointer */
 	struct usb_interface *interface;	/* the interface for this device */
@@ -240,8 +241,10 @@ static void iowarrior_write_callback(struct urb *urb)
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
@@ -637,6 +640,9 @@ static int iowarrior_open(struct inode *inode, struct file *file)
 	}
 	/* increment our usage count for the driver */
 	++dev->opened;
+
+	kref_get(&dev->kref);
+
 	/* save our object in the file's private structure */
 	file->private_data = dev;
 	retval = 0;
@@ -652,7 +658,6 @@ static int iowarrior_open(struct inode *inode, struct file *file)
 static int iowarrior_release(struct inode *inode, struct file *file)
 {
 	struct iowarrior *dev;
-	int retval = 0;
 
 	dev = file->private_data;
 	if (!dev)
@@ -660,29 +665,18 @@ static int iowarrior_release(struct inode *inode, struct file *file)
 
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
@@ -767,6 +761,7 @@ static int iowarrior_probe(struct usb_interface *interface,
 	if (!dev)
 		return retval;
 
+	kref_init(&dev->kref);
 	mutex_init(&dev->mutex);
 
 	atomic_set(&dev->intr_idx, 0);
@@ -885,7 +880,8 @@ static int iowarrior_probe(struct usb_interface *interface,
 	return retval;
 
 error:
-	iowarrior_delete(dev);
+	kref_put(&dev->kref, iowarrior_delete);
+
 	return retval;
 }
 
@@ -909,19 +905,14 @@ static void iowarrior_disconnect(struct usb_interface *interface)
 	usb_kill_anchored_urbs(&dev->submitted);
 
 	if (dev->opened) {
-		/* There is a process that holds a filedescriptor to the device ,
-		   so we only shutdown read-/write-ops going on.
-		   Deleting the device is postponed until close() was called.
-		 */
 		usb_kill_urb(dev->int_in_urb);
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

