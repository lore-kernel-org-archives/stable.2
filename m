Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFA6264A86
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 15:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784474237; cv=none; b=SBs0C6z2e1rWPt7qRYD+llnBmu9qbti6ffLNnB1Iqw5ydyWAl8yoLJ8C9R/yqGq/rsnVUel4VHq38CuMjEZGnSCjjDV5IPnpnFlBaU8Vz2KIJAUql9bu7RrnAWMw6lUR3EpdwSXRsMS7V0lSYEQMQlLfUmZU97mMa3pLoXhSMQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784474237; c=relaxed/simple;
	bh=ij5GZRuQPByDTcTVWt3V33AFEAb5OsMrsyAm3RvTeTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHbsd7aqkZcz19srIlO1bspRCa6z8Rj4Q74dxc41XzxkG0poytG/K8cS8Z8UiaEyAbz5oPXuZxG4tbjjp789JzaG88iup4m8DNGelpbB7tfxCGqFS+KSF1BWV2uYl8FK3dLSSgU023WYwZPf7Elis4P2iljtCQKiSRBjjd1FZSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EacvaV3p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EacvaV3p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2331F000E9;
	Sun, 19 Jul 2026 15:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784474236;
	bh=i1GwLJ7bipidWoNHw2FEiAQjTNegF2KYwQu4YL+SIJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EacvaV3pPCn7Gn/ea9PHBRmsC5nNqbS83b7wSsha16aBAE0b5jGgi149pmc6OPOgO
	 tVzhN7SsMML6T8fpty1nV8LxdwTnP1hWSDvJnUQds9CfIxMfBqVw2jCA0keC/52Hv4
	 0UxvCe9qTvqVC9kYFZCH5Szfko4jJwdW0Vz8iCIBbYDi7dT0u9TdtRpitL1TCk6u2d
	 GQbxz4L/fyFVFrWYIJSokFl8ffkIIRA9ZusR1YacrY9I1cY1WALWbclRNBuDEY0mC2
	 +J2+K4tHv25nsWL6Oj+/6vE4k8Wh2RDJXHW1Fue7qala4ldbKp8DIzV0lvOQICDmQg
	 FQ/unPvbWJvVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] usb: iowarrior: remove inherent race with minor number
Date: Sun, 19 Jul 2026 11:17:13 -0400
Message-ID: <20260719151714.124320-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071455-trustful-avatar-54ed@gregkh>
References: <2026071455-trustful-avatar-54ed@gregkh>
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
index 4fae04094021e3..2d0c65c1c32740 100644
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

