Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700797;
	b=N71bhtWK7uUJlJkBFrYwsMDG4XO6jGTavvFsPbGJb8RFMo1P2/G/sY3XKpDrQ01CgIBk
	 v9BZ7jKhYetUjVe6bYuTv8oxFbq07JP5h2Ly7vbvPH+Svh7LnKVOuQZKVD0r/JucfBUid
	 gZIva4/rkCa49BxAcYRv6v0qop73f8ixSVgQHWLj7JK+PRTpVL3nZeY8V0S1YvNsIFJOG
	 Kve68hs3CCFq79zmkKsppBU2VfMe3WlJ3SOvvB8QcjEpVWzl7IJfIH5nOgG7Ydaj6wO/2
	 N3B8JFxiTXWYCL53THrXm9Aydd/5H07E7hyrIc6NmZdH1pjWX9fMVvIvAqlUaqkUJog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700797;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=t0+8t8MyecGn3iM1v3GEM7jPMoD8j3KUWVHZQob9Ux8=;
	b=na/bX/nt8eK4H9TdcLHyDSVFbBksNLDTM6aiQtw8fHUq+rxMryzdxRHWK7ecf9Bb+i9q
	 Y8UURnB2zxvHcRx1oHZEJMRaFQVd5/lkk9ihtMwz50Y+En6c2vVRVEelrII1Erb0HAuL4
	 rEJ7vtluVzCFWxLwew+qYw04P7F4FceQXayOtX5O0HW98tMjNqphKwxkOZkC/e4ON3bm0
	 PcgZb28q4c565j08Z+0HU5e3ZnHwIq3HZefVvaM5CwFZThI8mbtWMzysv/eyTKIpHcsXY
	 wSEtuyZaG+FuvEM4Ybpz8mpXASo42kVo1Ml+VTxsOD4tN/tzkwergAPplbRW324LYMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="1eZ2//0C";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58BC606B10F
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1eZ2//0C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB021F000C1;
	Tue,  3 Nov 2026 10:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793700796;
	bh=t0+8t8MyecGn3iM1v3GEM7jPMoD8j3KUWVHZQob9Ux8=;
	h=Subject:To:Cc:From:Date;
	b=1eZ2//0CkzjwG3SZEEtxLC+VG33DNykxnD0cJDcDL0licnXBklhLCSp/oqXsgh3d3
	 Ix7Yjvwb6iFjAaS8Gr1bTokvB0sQmfm94rE62b89hpluA+ewGBS5C/GcwKURZymFqw
	 BmYNlQCwkhka902L5CzSZynlfjN/vrr1J2SG22j8=
Subject: FAILED: patch "[PATCH] driver core: take parent lock in async device attach" failed to apply to 6.12-stable tree
To: mario.peter@leica-geosystems.com,dakr@kernel.org,dmitry.torokhov@gmail.com,johan@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:13:13 +0100
Message-ID: <2026110313-outburst-clinking-4199@gregkh>
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


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 187a62f99da29b1a55602b0d401a783d8dc86161
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110313-outburst-clinking-4199@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 187a62f99da29b1a55602b0d401a783d8dc86161 Mon Sep 17 00:00:00 2001
From: Mario Peter <mario.peter@leica-geosystems.com>
Date: Wed, 14 Oct 2026 15:31:09 +0200
Subject: [PATCH] driver core: take parent lock in async device attach

For device types with need_parent_lock set (only USB interfaces),
probe() must run with the parent device locked. A synchronous attach
after device_add() gets this from the caller, e.g.
usb_set_configuration() holds the udev lock while adding interfaces.
__device_attach_async_helper() runs the probe from an async worker
instead, where that lock isn't held, and only takes device_lock(dev).

With async probing enabled for the hub driver (e.g. driver_async_probe=*
or driver_async_probe=hub), this races when a multi-TT hub is
configured. For multi-TT hubs, hub_probe() calls
usb_set_interface(hdev, 0, 1) to select the TT-per-port altsetting, and
usb_set_interface() creates the endpoint devices of the interface a
second time:

  usb_set_configuration()           async worker
    [udev locked]
    device_add(intf)
      queues the probe  ----------> __device_attach_async_helper()
                                      [intf locked, udev not locked]
                                      hub_probe()
                                        usb_set_interface(hdev, 0, 1)
    create_intf_ep_devs(intf)             create_intf_ep_devs(intf)

create_intf_ep_devs() checks and sets intf->ep_devs_created without a
lock of its own. If usb_set_configuration() has created ep_81 but not
yet set the flag, usb_set_interface() skips removing the endpoint
devices of the old altsetting and creates ep_81 again. With a
synchronous probe, hub_probe() runs inside device_add() with the udev
lock held, and usb_set_configuration() then finds ep_devs_created
already set.

Single-TT hubs don't call usb_set_interface() from hub_probe() and
don't show this warning, but their probe runs without the udev lock as
well.

On an i.MX8MM board with an onboard USB2514 hub this hit 11 of 100
boots:

  sysfs: cannot create duplicate filename '.../1-1/1-1:1.0/ep_81'
  Call trace:
   sysfs_warn_dup
   usb_create_ep_devs
   create_intf_ep_devs
   usb_set_interface
   hub_probe
   usb_probe_interface
   really_probe
   __device_attach_async_helper
   async_run_entry_fn

It also shows on v7.3-rc6 in QEMU, with dummy_hcd and a raw-gadget
program emulating a multi-TT hub: re-authorizing the hub in a loop,
while a SCHED_FIFO task preempts the writing task at random points for
3 ms, hit the warning in 29 of 6000 iterations.

Take the parent lock in __device_attach_async_helper() as well, like
__driver_attach_async_helper() does, and move
__device_driver_lock/unlock() up for that. With this the warning was
gone in 300 boots on the board and in 6000 iterations in QEMU.

Fixes: 765230b5f084 ("driver-core: add asynchronous probing support for drivers")
Signed-off-by: Mario Peter <mario.peter@leica-geosystems.com>
Cc: stable@vger.kernel.org	# 4.2
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
[ johan: switch to async_schedule_dev_nocall() to avoid deadlock if
         async_schedule_dev() runs synchronously when parent lock is
	 held ]
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20261014133109.1392265-4-johan@kernel.org
[ Fold the nested conditions into a single if statement; correct commit
  message to mention "device types" rather than "buses" for
  "need_parent_lock". - Danilo ]
Signed-off-by: Danilo Krummrich <dakr@kernel.org>

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 04e9977ed743..52123251965d 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1030,6 +1030,38 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
 	return ret == 0;
 }
 
+/*
+ * __device_driver_lock - acquire locks needed to manipulate dev->drv
+ * @dev: Device we will update driver info for
+ * @parent: Parent device. Needed if the device type requires parent lock
+ *
+ * This function will take the required locks for manipulating dev->drv.
+ * Normally this will just be the @dev lock, but when called for a USB
+ * interface, @parent lock will be held as well.
+ */
+static void __device_driver_lock(struct device *dev, struct device *parent)
+{
+	if (dev->type && dev->type->need_parent_lock && parent)
+		device_lock(parent);
+	device_lock(dev);
+}
+
+/*
+ * __device_driver_unlock - release locks needed to manipulate dev->drv
+ * @dev: Device we will update driver info for
+ * @parent: Parent device. Needed if the device type requires parent lock
+ *
+ * This function will release the required locks for manipulating dev->drv.
+ * Normally this will just be the @dev lock, but when called for a
+ * USB interface, @parent lock will be released as well.
+ */
+static void __device_driver_unlock(struct device *dev, struct device *parent)
+{
+	device_unlock(dev);
+	if (dev->type && dev->type->need_parent_lock && parent)
+		device_unlock(parent);
+}
+
 static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
 {
 	struct device *dev = _dev;
@@ -1039,7 +1071,7 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
 		.want_async	= true,
 	};
 
-	device_lock(dev);
+	__device_driver_lock(dev, dev->parent);
 
 	/*
 	 * Check if device has already been removed or claimed. This may
@@ -1061,7 +1093,7 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
 	if (dev->parent)
 		pm_runtime_put(dev->parent);
 out_unlock:
-	device_unlock(dev);
+	__device_driver_unlock(dev, dev->parent);
 
 	put_device(dev);
 }
@@ -1118,8 +1150,11 @@ static int __device_attach(struct device *dev, bool allow_async)
 	}
 out_unlock:
 	device_unlock(dev);
-	if (async)
-		async_schedule_dev(__device_attach_async_helper, dev);
+	if (async && !async_schedule_dev_nocall(__device_attach_async_helper, dev)) {
+		put_device(dev);
+		ret = 2;	/* retry synchronously */
+	}
+
 	return ret;
 }
 
@@ -1146,48 +1181,20 @@ EXPORT_SYMBOL_GPL(device_attach);
 void device_initial_probe(struct device *dev)
 {
 	struct subsys_private *sp = bus_to_subsys(dev->bus);
+	int ret;
 
 	if (!sp)
 		return;
 
-	if (sp->drivers_autoprobe)
-		__device_attach(dev, true);
+	if (sp->drivers_autoprobe) {
+		ret = __device_attach(dev, true);
+		if (ret == 2)
+			__device_attach(dev, false);
+	}
 
 	subsys_put(sp);
 }
 
-/*
- * __device_driver_lock - acquire locks needed to manipulate dev->drv
- * @dev: Device we will update driver info for
- * @parent: Parent device. Needed if the device type requires parent lock
- *
- * This function will take the required locks for manipulating dev->drv.
- * Normally this will just be the @dev lock, but when called for a USB
- * interface, @parent lock will be held as well.
- */
-static void __device_driver_lock(struct device *dev, struct device *parent)
-{
-	if (dev->type && dev->type->need_parent_lock && parent)
-		device_lock(parent);
-	device_lock(dev);
-}
-
-/*
- * __device_driver_unlock - release locks needed to manipulate dev->drv
- * @dev: Device we will update driver info for
- * @parent: Parent device. Needed if the device type requires parent lock
- *
- * This function will release the required locks for manipulating dev->drv.
- * Normally this will just be the @dev lock, but when called for a
- * USB interface, @parent lock will be released as well.
- */
-static void __device_driver_unlock(struct device *dev, struct device *parent)
-{
-	device_unlock(dev);
-	if (dev->type && dev->type->need_parent_lock && parent)
-		device_unlock(parent);
-}
-
 /**
  * device_driver_attach - attach a specific driver to a specific device
  * @drv: Driver to attach

