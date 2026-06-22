Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB403379C40;
	Mon, 22 Jun 2026 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142053; cv=none; b=rS5W8I5C88oGvE0J4Dx/PA/JuuPANhh0cxR134iqVG9hQ0ZrRv7mdztnJTJEJdJOfEPLXJBCuqwkU3lobfD6QlxP9JJh+zk1swQYKWzqxPUvlkbWaIw3fiL/DgOggUpg3weatu+6U4hcHGkmHiHijc1jZKahH91vWk7E0tsNZac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142053; c=relaxed/simple;
	bh=gNVHHIX5newH5kihK8/wnZKOREtcCZakUcbBSmCN1cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+a4SYuh7+rAyPoVMB+1MVpsARQMkHFnm5YLp7vMg3RygZJdr/3QDxB+oMk3XLkSpYgP7YrDhZtg8qSAL/xdmviq8RuBlaHzAdYsWMrIxI84nREkrBf/RK3rYSa41YTjbFk1tsNx5ojQPcqa4hQDD397TrWqIlfHsRH6S1Kk6TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YeP3LvHp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YeP3LvHp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931401F00A3A;
	Mon, 22 Jun 2026 15:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782142051;
	bh=DWz/eLFK/9A9yZ6iAAf5ABx4uIdW8UyvIjL8hORVCPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YeP3LvHpxEr/UrlTQd6ALIOYL3JwY88gP7xDg1FZILXrSMtBx6D6yhEWUHQ3wQrYG
	 4z3tv7LFisWOoxRDcMn0x2GD3CgjQGxrWF2N5PbneQL8c+A/WYQJi4IkNMND3F7+JM
	 NT7v8zIi6g53PP1kUrwyoLBbmhl3tfxgS32Car75gm0kG1d/eoeRKzpm5MbiYrgxe3
	 XfBWgbchWZHSOekbW/1EHUmJobbtZ8V4mIpflzzfN8y6cM2JtXDBWesLsI9jeFku83
	 nQXeHEG81cpe/XiXqKHXxh4MieDDw5D9rLugyhPG95cSV2l8qyhyRTLE2jv+fqW/Ix
	 cdzHFaD4ET2kw==
Received: from johan by xi.lan with local (Exim 4.99.3)
	(envelope-from <johan@kernel.org>)
	id 1wbgYb-00000000UJ1-1C6E;
	Mon, 22 Jun 2026 17:27:29 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Juergen Stuber <starblue@users.sourceforge.net>,
	Yue Sun <samsun1006219@gmail.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Daniel Walker <dwalker@mvista.com>
Subject: [PATCH 3/4] USB: ldusb: fix use-after-free on disconnect race
Date: Mon, 22 Jun 2026 17:26:11 +0200
Message-ID: <20260622152612.116422-4-johan@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260622152612.116422-1-johan@kernel.org>
References: <20260622152612.116422-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mutex_unlock() may access the mutex structure after releasing the lock
and therefore cannot be used to manage lifetime of objects directly
(unlike spinlocks and refcounts). [1][2]

Use a kref to release the driver data to avoid use-after-free in
mutex_unlock() when release() races with disconnect().

[1] a51749ab34d9 ("locking/mutex: Document that mutex_unlock() is
                   non-atomic")
[2] 2b9d9e0a9ba0 ("locking/mutex: Clarify that mutex_unlock(), and most
                   other sleeping locks, can still use the lock object
                   after it's unlocked")

Fixes: ce0d7d3f575f ("usb: ldusb: ld_usb semaphore to mutex")
Cc: stable@vger.kernel.org	# 2.6.26
Cc: Daniel Walker <dwalker@mvista.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/misc/ldusb.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/misc/ldusb.c b/drivers/usb/misc/ldusb.c
index c74f142f6637..71132a15e771 100644
--- a/drivers/usb/misc/ldusb.c
+++ b/drivers/usb/misc/ldusb.c
@@ -150,6 +150,7 @@ MODULE_PARM_DESC(min_interrupt_out_interval, "Minimum interrupt out interval in
 
 /* Structure to hold all of our device specific stuff */
 struct ld_usb {
+	struct kref		kref;
 	struct mutex		mutex;		/* locks this structure */
 	struct usb_interface	*intf;		/* save off the usb interface pointer */
 	unsigned long		disconnected:1;
@@ -201,8 +202,10 @@ static void ld_usb_abort_transfers(struct ld_usb *dev)
 /*
  *	ld_usb_delete
  */
-static void ld_usb_delete(struct ld_usb *dev)
+static void ld_usb_delete(struct kref *kref)
 {
+	struct ld_usb *dev = container_of(kref, struct ld_usb, kref);
+
 	/* free data structures */
 	usb_free_urb(dev->interrupt_in_urb);
 	usb_free_urb(dev->interrupt_out_urb);
@@ -355,6 +358,8 @@ static int ld_usb_open(struct inode *inode, struct file *file)
 		goto unlock_exit;
 	}
 
+	kref_get(&dev->kref);
+
 	/* save device in the file's private structure */
 	file->private_data = dev;
 
@@ -381,17 +386,8 @@ static int ld_usb_release(struct inode *inode, struct file *file)
 
 	mutex_lock(&dev->mutex);
 
-	if (dev->open_count != 1) {
-		retval = -ENODEV;
+	if (dev->disconnected)
 		goto unlock_exit;
-	}
-	if (dev->disconnected) {
-		/* the device was unplugged before the file was released */
-		mutex_unlock(&dev->mutex);
-		/* unlock here as ld_usb_delete frees dev */
-		ld_usb_delete(dev);
-		goto exit;
-	}
 
 	/* wait until write transfer is finished */
 	if (dev->interrupt_out_busy)
@@ -401,7 +397,7 @@ static int ld_usb_release(struct inode *inode, struct file *file)
 
 unlock_exit:
 	mutex_unlock(&dev->mutex);
-
+	kref_put(&dev->kref, ld_usb_delete);
 exit:
 	return retval;
 }
@@ -659,6 +655,8 @@ static int ld_usb_probe(struct usb_interface *intf, const struct usb_device_id *
 	dev = kzalloc_obj(*dev);
 	if (!dev)
 		goto exit;
+
+	kref_init(&dev->kref);
 	mutex_init(&dev->mutex);
 	spin_lock_init(&dev->rbsl);
 	dev->intf = intf;
@@ -740,7 +738,7 @@ static int ld_usb_probe(struct usb_interface *intf, const struct usb_device_id *
 	return retval;
 
 error:
-	ld_usb_delete(dev);
+	kref_put(&dev->kref, ld_usb_delete);
 
 	return retval;
 }
@@ -768,18 +766,18 @@ static void ld_usb_disconnect(struct usb_interface *intf)
 
 	mutex_lock(&dev->mutex);
 
-	/* if the device is not opened, then we clean up right now */
-	if (!dev->open_count) {
-		mutex_unlock(&dev->mutex);
-		ld_usb_delete(dev);
-	} else {
-		dev->disconnected = 1;
+	dev->disconnected = 1;
+
+	if (dev->open_count) {
 		/* wake up pollers */
 		wake_up_interruptible_all(&dev->read_wait);
 		wake_up_interruptible_all(&dev->write_wait);
-		mutex_unlock(&dev->mutex);
 	}
 
+	mutex_unlock(&dev->mutex);
+
+	kref_put(&dev->kref, ld_usb_delete);
+
 	dev_info(&intf->dev, "LD USB Device #%d now disconnected\n",
 		 (minor - USB_LD_MINOR_BASE));
 }
-- 
2.53.0

