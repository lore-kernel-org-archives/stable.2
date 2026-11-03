Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700783;
	b=AVcab5HiHs0WZ6Be/6mYL8nA7Ed+kZODjuauQ9zg9QAzT82sxWKEO/wudY5mlVQojTmu
	 C39xXTYgDdpJV7qcCFK6n+UJtgRxdaRTcWwrtv3E4qqvbk+hiXcCuGqBVs9/0TIpFKgN6
	 aXpqcQUPSh41ep2MSBiocN27YRvUsnPIbqQ0eB5K9e7JNyjjkiHq24JBptSk4h7DfzEZF
	 HHeS2OFBEZ5TuzRMPkWbCvcQJ2kHSAUY0YwjILm2I+5b0GITE0RqZgeVrqxIC2RB2Qg6A
	 oaHN4xFHwMD+jQ+sYNh44kpphX18XOyWCuuHn5PpIWG6CIuIVU1T2KLQG85I1qRTdYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700783;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=86YutdRMfC6y7QrUfSEClzQvua4YUd8EwmPtekY2Mws=;
	b=L0COIb97RVlOU8N40AQyMSYx49bALuMXQ6013SN9V5k4HE8OFVvDuUNgZ/7LIKrsB/Iv
	 bO8EcduI/Hl+CpR5BZ80od6dNSNMhdJaW/uIlnrQ9U8fAJR+CCI0sA3JF4BzXCW3HJVgK
	 ODhQx9cO1A/xbgSBFPL0ggidem+7bpUmzebnpzYEUbqnFV3tlzZ7Yyddxrb2fprJTokxs
	 kIqYxqmej2qQFKFhBTPq0WeIMmLacYyMZjt94OOGymVLRwruVzyDARaDLQiTFi5hRj3Jr
	 dN++644dnVrw0dFMbwj5YYQPrd8uJTNxWwlXRiBGhbeb12clGDPybmYjp38J18NX/kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bPba6NK4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FDE606EEAE
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=bPba6NK4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520271F000C1;
	Tue,  3 Nov 2026 10:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793700782;
	bh=86YutdRMfC6y7QrUfSEClzQvua4YUd8EwmPtekY2Mws=;
	h=Subject:To:Cc:From:Date;
	b=bPba6NK4x2aRFRf9Gq6ruZlZUa8Ya74ly4amu1/fRi7LNiASe3nJ72Ukc6UYOrmhm
	 gGwEYl3VF9g7QM/qliu6VV1tihn3Qj5axtNUOTaD2nqpqq8aQWpClOdZUXyAWYBiUB
	 2O4Q991l+NFBnLivG5bnilwVGmeVQmMHyZ5bRZUo=
Subject: FAILED: patch "[PATCH] driver core: fix parent lock use-after-free on USB disconnect" failed to apply to 5.15-stable tree
To: johan@kernel.org,dakr@kernel.org,stern@rowland.harvard.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:12:59 +0100
Message-ID: <2026110359-reps-winking-6c18@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0f554506a3fc6a21e714adf38cc3eb0ffe1bb452
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110359-reps-winking-6c18@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0f554506a3fc6a21e714adf38cc3eb0ffe1bb452 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Wed, 14 Oct 2026 15:31:07 +0200
Subject: [PATCH] driver core: fix parent lock use-after-free on USB disconnect

USB interfaces should be probed with their parent USB device lock held
and the USB bus therefore sets the need_parent_lock bus flag so that
driver core takes the parent lock when needed.

Driver core is only guaranteed to hold a reference to the parent device
during initial probe however and nothing prevents the device and its
parent from being deregistered and the parent potentially freed, for
example, while iterating over devices in driver_attach() or
bus_rescan_devices_helper().

Since commit 524134d42231 ("USB: don't cancel queued resets when
unbinding drivers") USB interfaces hold a reference to their parent USB
device, but a parent hub may still go away while probing a USB device
(e.g. via the drivers_probe sysfs interface). This can lead to a
use-after-free when taking the parent device lock before checking the
device->p->dead flag of the device being probed.

As only USB interfaces actually need the parent lock, make the
need_parent_lock feature even more fine grained by making it a device
type rather than bus feature. By requiring that any users also make sure
that their devices hold a reference to their parents (like USB does),
driver core can lock a device and its parent without first checking if
the device has been deregistered.

Note that this will also increase parallelism when using asynchronous
probe as USB devices connected to the same hub can now be probed in
parallel.

Fixes: bf74ad5bc417 ("[PATCH] Hold the device's parent's lock during probe and remove")
Cc: stable@vger.kernel.org	# 2.6.16: 524134d42231: USB: don't cancel queued resets when unbinding drivers
Cc: stable@vger.kernel.org	# 2.6.16
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20261014133109.1392265-2-johan@kernel.org
[ Fix mention of bus vs. device type in __device_driver_{un}lock().
  - Danilo ]
Signed-off-by: Danilo Krummrich <dakr@kernel.org>

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index d17bd91490ee..d6668fb8ddea 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -849,10 +849,10 @@ static int __must_check bus_rescan_devices_helper(struct device *dev,
 	int ret = 0;
 
 	if (!dev->driver) {
-		if (dev->parent && dev->bus->need_parent_lock)
+		if (dev->type && dev->type->need_parent_lock)
 			device_lock(dev->parent);
 		ret = device_attach(dev);
-		if (dev->parent && dev->bus->need_parent_lock)
+		if (dev->type && dev->type->need_parent_lock)
 			device_unlock(dev->parent);
 	}
 	return ret < 0 ? ret : 0;
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index f6525a7ee8c5..d7a82c436c45 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1158,7 +1158,7 @@ void device_initial_probe(struct device *dev)
 /*
  * __device_driver_lock - acquire locks needed to manipulate dev->drv
  * @dev: Device we will update driver info for
- * @parent: Parent device. Needed if the bus requires parent lock
+ * @parent: Parent device. Needed if the device type requires parent lock
  *
  * This function will take the required locks for manipulating dev->drv.
  * Normally this will just be the @dev lock, but when called for a USB
@@ -1166,7 +1166,7 @@ void device_initial_probe(struct device *dev)
  */
 static void __device_driver_lock(struct device *dev, struct device *parent)
 {
-	if (parent && dev->bus->need_parent_lock)
+	if (dev->type && dev->type->need_parent_lock && parent)
 		device_lock(parent);
 	device_lock(dev);
 }
@@ -1174,7 +1174,7 @@ static void __device_driver_lock(struct device *dev, struct device *parent)
 /*
  * __device_driver_unlock - release locks needed to manipulate dev->drv
  * @dev: Device we will update driver info for
- * @parent: Parent device. Needed if the bus requires parent lock
+ * @parent: Parent device. Needed if the device type requires parent lock
  *
  * This function will release the required locks for manipulating dev->drv.
  * Normally this will just be the @dev lock, but when called for a
@@ -1183,7 +1183,7 @@ static void __device_driver_lock(struct device *dev, struct device *parent)
 static void __device_driver_unlock(struct device *dev, struct device *parent)
 {
 	device_unlock(dev);
-	if (parent && dev->bus->need_parent_lock)
+	if (dev->type && dev->type->need_parent_lock && parent)
 		device_unlock(parent);
 }
 
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 7f33fe5ba03b..bf660b15a0f6 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -2081,5 +2081,4 @@ const struct bus_type usb_bus_type = {
 	.name =		"usb",
 	.match =	usb_device_match,
 	.uevent =	usb_uevent,
-	.need_parent_lock =	true,
 };
diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 75e2bfd744a9..e8a582fef09f 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1916,6 +1916,7 @@ const struct device_type usb_if_device_type = {
 	.name =		"usb_interface",
 	.release =	usb_release_interface,
 	.uevent =	usb_if_uevent,
+	.need_parent_lock =	true,
 };
 
 static struct usb_interface_assoc_descriptor *find_iad(struct usb_device *dev,
diff --git a/include/linux/device.h b/include/linux/device.h
index aee79fd6b32b..ae05205742c0 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -83,6 +83,10 @@ int subsys_virtual_register(const struct bus_type *subsys,
  * information, equivalent to the kobj_type of a kobject.
  * If "name" is specified, the uevent will contain it in
  * the DEVTYPE variable.
+ *
+ * @need_parent_lock:	When probing or removing a device of this type,
+ *			driver core should lock the device's parent. Note that
+ *			the device must hold a reference to its parent.
  */
 struct device_type {
 	const char *name;
@@ -93,6 +97,7 @@ struct device_type {
 	void (*release)(struct device *dev);
 
 	const struct dev_pm_ops *pm;
+	bool need_parent_lock;
 };
 
 /**
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index a38f7229b8f4..526407a371e2 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -68,8 +68,6 @@ struct fwnode_handle;
  * @driver_override:	Set to true if this bus supports the driver_override
  *			mechanism, which allows userspace to force a specific
  *			driver to bind to a device via a sysfs attribute.
- * @need_parent_lock:	When probing or removing a device on this bus, the
- *			device core should lock the device's parent.
  *
  * A bus is a channel between the processor and one or more devices. For the
  * purposes of the device model, all devices are connected via a bus, even if
@@ -110,7 +108,6 @@ struct bus_type {
 	const struct dev_pm_ops *pm;
 
 	bool driver_override;
-	bool need_parent_lock;
 };
 
 int __must_check bus_register(const struct bus_type *bus);

