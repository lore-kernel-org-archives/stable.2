Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1773C1FC110
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 15:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784474943; cv=none; b=k/ef01b28xEMQNrHxobp8sPFwMlqlKXC5edO/gM47XSEzn7qPnd8AzPw9cDF80JyMDYPGhi5R3Fkxvs27TJKYArgI1BLQU16iznACfBSel39qRyMzaaTyAfkKznz5r6HpgWyV5UJC4uzvCaHjHi5o4o0mczU92Q6GTGiPIWidls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784474943; c=relaxed/simple;
	bh=Od4myDi+qFFdkH6+vAxHW38WtKVKEsk/FiOQhveSjtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NworxryzpRzIjkXhreibj6t8qusbhKMb3PZiBeO2wyvu2Nttd+p01LNkSJl+iKOMYNezMfhbQv0Jbtm441UEHU6ClaFNPqEqtpwHuqVJc8eIm1p0dPLNHrQUXdf6AnDe1cx1mz5YGbfjZAGs6sFoh7XCTFF/9usDegtFDY/hEfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiW5WtCQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiW5WtCQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0071F000E9;
	Sun, 19 Jul 2026 15:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784474941;
	bh=rI9m02877FPyXkJkBzTUwHqYpVkgBApzLFkXZSdOPro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DiW5WtCQmxlNvwTbczi9EsgfhD/uxtCoQtsphuzFebTlSDIA5qHCCe2ZQLOAYHR0T
	 eJKulvv6iSuqWzNpJR1QX4ac/O2ngSnf1HmCwcmqmag1YoAPTBKXkK7+glxQVbWJAQ
	 x0aAVMZuWXbEC0TgLTwdaFBTNnIZcVXyJSHi2/6R83ZuCUV80hoB7UNn1JooX0/T6I
	 Q+zSZrX+sh00ty1pEMU9DX1Jz4DQ/jFnXq7ViuGHERpGGv+QHV0mFb1fDcxVksab+u
	 hlHma9RxRyq0OOYV8doWlNkORcdFNDXLNcq1BcjSgg5s4ZCDqEyMv7maUhWflBsMfc
	 tbvBvNoRVd7bw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] usb: iowarrior: remove inherent race with minor number
Date: Sun, 19 Jul 2026 11:28:58 -0400
Message-ID: <20260719152859.190429-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071456-chihuahua-thyself-7200@gregkh>
References: <2026071456-chihuahua-thyself-7200@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Oliver Neukum <oneukum@suse.com>

[ Upstream commit 56dd29088c9d9510c48a8ebad2465248fde36551 ]

The driver saves the minor number it gets upon registration
in its descriptor for debugging purposes. However, there is
inevitably a window between registration and saving the correct
minor in a descriptor. During this window the debugging output
will be wrong.
As wrong debug output is worse than no debug output, just
remove it.

Signed-off-by: Oliver Neukum <oneukum@suse.com>
Link: https://patch.msgid.link/20260312094619.1590556-1-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: c602254ba4c1 ("USB: iowarrior: fix use-after-free on disconnect race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/misc/iowarrior.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/misc/iowarrior.c b/drivers/usb/misc/iowarrior.c
index 5606c5a2624a78..770f0044d8e2ff 100644
--- a/drivers/usb/misc/iowarrior.c
+++ b/drivers/usb/misc/iowarrior.c
@@ -74,7 +74,6 @@ struct iowarrior {
 	struct mutex mutex;			/* locks this structure */
 	struct usb_device *udev;		/* save off the usb device pointer */
 	struct usb_interface *interface;	/* the interface for this device */
-	unsigned char minor;			/* the starting minor number for this device */
 	struct usb_endpoint_descriptor *int_out_endpoint;	/* endpoint for reading (needed for IOW56 only) */
 	struct usb_endpoint_descriptor *int_in_endpoint;	/* endpoint for reading */
 	struct urb *int_in_urb;		/* the urb for reading data */
@@ -246,7 +245,6 @@ static void iowarrior_write_callback(struct urb *urb)
  */
 static inline void iowarrior_delete(struct iowarrior *dev)
 {
-	dev_dbg(&dev->interface->dev, "minor %d\n", dev->minor);
 	kfree(dev->int_in_buffer);
 	usb_free_urb(dev->int_in_urb);
 	kfree(dev->read_queue);
@@ -297,9 +295,6 @@ static ssize_t iowarrior_read(struct file *file, char __user *buffer,
 		goto exit;
 	}
 
-	dev_dbg(&dev->interface->dev, "minor %d, count = %zd\n",
-		dev->minor, count);
-
 	/* read count must be packet size (+ time stamp) */
 	if ((count != dev->report_size)
 	    && (count != (dev->report_size + 1))) {
@@ -379,8 +374,6 @@ static ssize_t iowarrior_write(struct file *file,
 		retval = -ENODEV;
 		goto exit;
 	}
-	dev_dbg(&dev->interface->dev, "minor %d, count = %zd\n",
-		dev->minor, count);
 	/* if count is 0 we're already done */
 	if (count == 0) {
 		retval = 0;
@@ -523,9 +516,6 @@ static long iowarrior_ioctl(struct file *file, unsigned int cmd,
 		goto error_out;
 	}
 
-	dev_dbg(&dev->interface->dev, "minor %d, cmd 0x%.4x, arg %ld\n",
-		dev->minor, cmd, arg);
-
 	retval = 0;
 	io_res = 0;
 	switch (cmd) {
@@ -672,8 +662,6 @@ static int iowarrior_release(struct inode *inode, struct file *file)
 	if (!dev)
 		return -ENODEV;
 
-	dev_dbg(&dev->interface->dev, "minor %d\n", dev->minor);
-
 	/* lock our device */
 	mutex_lock(&dev->mutex);
 
@@ -776,6 +764,7 @@ static int iowarrior_probe(struct usb_interface *interface,
 	struct usb_host_interface *iface_desc;
 	int retval = -ENOMEM;
 	int res;
+	int minor;
 
 	/* allocate memory for our device state and initialize it */
 	dev = kzalloc(sizeof(struct iowarrior), GFP_KERNEL);
@@ -891,12 +880,12 @@ static int iowarrior_probe(struct usb_interface *interface,
 		goto error;
 	}
 
-	dev->minor = interface->minor;
+	minor = interface->minor;
 
 	/* let the user know what node this device is now attached to */
 	dev_info(&interface->dev, "IOWarrior product=0x%x, serial=%s interface=%d "
 		 "now attached to iowarrior%d\n", dev->product_id, dev->chip_serial,
-		 iface_desc->desc.bInterfaceNumber, dev->minor - IOWARRIOR_MINOR_BASE);
+		 iface_desc->desc.bInterfaceNumber, minor - IOWARRIOR_MINOR_BASE);
 	return retval;
 
 error:
-- 
2.53.0

