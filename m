Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4BF531AEB;
	Wed, 14 Oct 2026 13:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984704; cv=none; b=llML/vuUNlgG5GVYMUZgXDnRXAOtjEl4lHtxrUKwnmAFo0YmZDYGM4675HceNfKpnmH4sp03W2a4GHDKitSEppi/viNZO7qytaEu4ox531zA0rlGLOaoSG3U2cilQw+pizdaw2G00ldsKRJzzsRgEfXBFcObMx9hPUo0lzqiUNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984704; c=relaxed/simple;
	bh=OjCM+aL9NZUeGZVNuVtPkbyTIn5lcSxEPiIJVm01e90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecd0X2gX1TqpAHYSMYZTKcCFjGXJR84KfZZOl/BCErapnSUJouOXRF6hmRZbNOULuaKd0ZMSLsQmNXOq3ukej/evVkKnVLQhRJVsaePvX3SM/nXWTSwiYYUfh+PhVPVM5l2jqsDCb4FpGf5Z2JsUfTD2NoP+ETeuSg5HqosTB+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGGoGk/a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGGoGk/a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58BC1F00893;
	Wed, 14 Oct 2026 13:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791984690;
	bh=3ViBSbVmV6dB80ua1NOeQ0IVvjHoc00INBinToPWHRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jGGoGk/aze+38sWpNo3PfXZMZMFhdUvKwbsjOOxOo5iNEdFdsDJx3CCr+s3EB4w9+
	 Ywv1Wk++INELahUoaj59cbdY5zgOsua4D1i6X+q0F5aTc3/aFHHpiIdB83RzMa89Yx
	 BpsUYRQP465XOICdVJlth1U2gzE700FjLcVuxeuYT69l8EmuMsOV2Wq7D+V3gxM9KI
	 B9boh7yAPoynphlKwjg4QE7DdyvA09Fe5EK+phFSFl3hkeUYElTyiafJAS9cUm/SsO
	 VPbibRgT64vYnIg4ZtvS+uW0jPBE5caSDeG+pg1Ia0xOVVvzO2ljiZlFb9JXlEA8I8
	 0KYIm0y0MwyuQ==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xGz4q-00000005qCW-2YWd;
	Wed, 14 Oct 2026 15:31:28 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Mario Peter <mario.peter@leica-geosystems.com>,
	driver-core@lists.linux.dev,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] driver core: fix parent lock use-after-free on USB disconnect
Date: Wed, 14 Oct 2026 15:31:07 +0200
Message-ID: <20261014133109.1392265-2-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014133109.1392265-1-johan@kernel.org>
References: <20261014133109.1392265-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 drivers/base/bus.c         | 4 ++--
 drivers/base/dd.c          | 4 ++--
 drivers/usb/core/driver.c  | 1 -
 drivers/usb/core/message.c | 1 +
 include/linux/device.h     | 5 +++++
 include/linux/device/bus.h | 3 ---
 6 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index c51ad96d4de4..598e40d52f37 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -852,10 +852,10 @@ static int __must_check bus_rescan_devices_helper(struct device *dev,
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
index f6525a7ee8c5..974e04e79bda 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1166,7 +1166,7 @@ void device_initial_probe(struct device *dev)
  */
 static void __device_driver_lock(struct device *dev, struct device *parent)
 {
-	if (parent && dev->bus->need_parent_lock)
+	if (dev->type && dev->type->need_parent_lock && parent)
 		device_lock(parent);
 	device_lock(dev);
 }
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
index 0cd6dd2b6334..276768f47558 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1922,6 +1922,7 @@ const struct device_type usb_if_device_type = {
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
-- 
2.55.0

