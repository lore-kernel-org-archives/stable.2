Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717953;
	b=AvyBrKePxl7pTG5s8N2t3v97+j76mZWTwIVtprINikg8k/TkEynl/DN8QlWgMnU/i6T5
	 XJWYGWYfmx8L5ggin6Lgih0zxdLfcjX9wE3TrCioISydDtMvn87u0Cqiwru4WIjPFxpDT
	 ikitlfLkQY5IxaJSje7C/DpwRaDL6zMMUOZTQhnaxqtXS7dLYAZ3YWpFgUrYkPhHW2IXJ
	 lXgDS/nm6kbSWU+K+oXPH0ghqWILFztsrzpKYxFwcrLK735ijK1y2GDgGmsKZjreLcKBf
	 ExCD25/7f+sYIFCtd8hozkE1iQYZIQCPhyYZacdIOEp4dQ8qE7i/XlwMMSC+nVRK2PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717953;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bY4s1O8UmZfBGehYHnB9/Ofp1EokgbZx7BK2EaSHo8Y=;
	b=b5wrkTMgxGHWNd00DMboboAZiYXvXIwObbrQ7zKoQ0DGigfVUvIf/H0lqrJAWA0OYxSf
	 4ZTQN1o0GyQOf6fGAzX+d2A6RiQViQ99Nx44WQJk0IZ6A0JBFop9ltHYSlBCQgY9C6IKv
	 Uh1ffcaxDyQHWcuuE0ohEOW2v9ULNMJB7vYnUpU015+BF8WMUjhezv19CSxXQBzeFr7Bs
	 Gb9uv+sSCPyfPthClXEh1Jr0kTAGXrtgge9dBzIZqFUZe+zPSAK06wEpTCtPV16OIqQy3
	 YGgRVfDSCZCUh4KEVI8QRALZyE1rkonRTvLl2sjhl3aM3gj3Qpdj+mmueqcmYdECvhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GsGLTOie;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F94606D825
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GsGLTOie
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29F51F00A1A;
	Tue,  3 Nov 2026 14:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717953;
	bh=bY4s1O8UmZfBGehYHnB9/Ofp1EokgbZx7BK2EaSHo8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GsGLTOieXv8D5SJhqYPKQZyaW1VAIhhbTOVL/FXYyn7uHmwH8lfohI+PEMsw9zyAD
	 rAlKGefr43LIdttOrCc56m8CsGWds6It5v/l8cD+91cjBC0s/g1KEXiob2DerZPMZN
	 1VMFrZdRLdpNyyE3ufc/HHUS5GwfmQ2gjf5aegicsnKJbpuLgQW4h8VCPrsWAMfQPC
	 5so+Agl7drT944bGkdyCYohU7QfJ13fS5TxBt7YaiQ9+VM7C6vGKmg3KGse0xO7F4v
	 yCb7vrrJ4UcrCad3WUmRQLh+lz/xL5sMT5wwkXvj8ZBbir6ba+tuaz3dp6XFtJj7DR
	 Cq1ndQRIe4h5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] driver core: fix parent lock use-after-free on USB disconnect
Date: Tue,  3 Nov 2026 09:59:11 -0500
Message-ID: <20261103145825.4109901-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110359-reps-winking-6c18@gregkh>
References: <2026110359-reps-winking-6c18@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 0f554506a3fc6a21e714adf38cc3eb0ffe1bb452 ]

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
[ sashal: adjusted context for non-const USB type declarations and the older bus_type layout ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/bus.c         | 4 ++--
 drivers/base/dd.c          | 8 ++++----
 drivers/usb/core/driver.c  | 1 -
 drivers/usb/core/message.c | 1 +
 include/linux/device.h     | 5 +++++
 include/linux/device/bus.h | 3 ---
 6 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 3ec131d877120..2720b76adb70e 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -689,10 +689,10 @@ static int __must_check bus_rescan_devices_helper(struct device *dev,
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
index daa5ef3f38e92..2db800fcd3d1a 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1051,7 +1051,7 @@ void device_initial_probe(struct device *dev)
 /*
  * __device_driver_lock - acquire locks needed to manipulate dev->drv
  * @dev: Device we will update driver info for
- * @parent: Parent device. Needed if the bus requires parent lock
+ * @parent: Parent device. Needed if the device type requires parent lock
  *
  * This function will take the required locks for manipulating dev->drv.
  * Normally this will just be the @dev lock, but when called for a USB
@@ -1059,7 +1059,7 @@ void device_initial_probe(struct device *dev)
  */
 static void __device_driver_lock(struct device *dev, struct device *parent)
 {
-	if (parent && dev->bus->need_parent_lock)
+	if (dev->type && dev->type->need_parent_lock && parent)
 		device_lock(parent);
 	device_lock(dev);
 }
@@ -1067,7 +1067,7 @@ static void __device_driver_lock(struct device *dev, struct device *parent)
 /*
  * __device_driver_unlock - release locks needed to manipulate dev->drv
  * @dev: Device we will update driver info for
- * @parent: Parent device. Needed if the bus requires parent lock
+ * @parent: Parent device. Needed if the device type requires parent lock
  *
  * This function will release the required locks for manipulating dev->drv.
  * Normally this will just be the the @dev lock, but when called for a
@@ -1076,7 +1076,7 @@ static void __device_driver_lock(struct device *dev, struct device *parent)
 static void __device_driver_unlock(struct device *dev, struct device *parent)
 {
 	device_unlock(dev);
-	if (parent && dev->bus->need_parent_lock)
+	if (dev->type && dev->type->need_parent_lock && parent)
 		device_unlock(parent);
 }
 
diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
index 072968c40adea..0e7070814c26a 100644
--- a/drivers/usb/core/driver.c
+++ b/drivers/usb/core/driver.c
@@ -2027,5 +2027,4 @@ struct bus_type usb_bus_type = {
 	.name =		"usb",
 	.match =	usb_device_match,
 	.uevent =	usb_uevent,
-	.need_parent_lock =	true,
 };
diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 58046946411f1..037f90089eda4 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1915,6 +1915,7 @@ struct device_type usb_if_device_type = {
 	.name =		"usb_interface",
 	.release =	usb_release_interface,
 	.uevent =	usb_if_uevent,
+	.need_parent_lock =	true,
 };
 
 static struct usb_interface_assoc_descriptor *find_iad(struct usb_device *dev,
diff --git a/include/linux/device.h b/include/linux/device.h
index 8da560db91633..1e0fe91603962 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -84,6 +84,10 @@ int subsys_virtual_register(struct bus_type *subsys,
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
@@ -94,6 +98,7 @@ struct device_type {
 	void (*release)(struct device *dev);
 
 	const struct dev_pm_ops *pm;
+	bool need_parent_lock;
 };
 
 /* interface for exporting device attributes */
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index 062777a45a74d..0f805d2a3f018 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -67,8 +67,6 @@ struct fwnode_handle;
  * @p:		The private data of the driver core, only the driver core can
  *		touch this.
  * @lock_key:	Lock class key for use by the lock validator
- * @need_parent_lock:	When probing or removing a device on this bus, the
- *			device core should lock the device's parent.
  *
  * A bus is a channel between the processor and one or more devices. For the
  * purposes of the device model, all devices are connected via a bus, even if
@@ -111,7 +109,6 @@ struct bus_type {
 	struct subsys_private *p;
 	struct lock_class_key lock_key;
 
-	bool need_parent_lock;
 };
 
 extern int __must_check bus_register(struct bus_type *bus);
-- 
2.53.0

