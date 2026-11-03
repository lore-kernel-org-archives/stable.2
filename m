Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700804;
	b=BtJ5KY+c5+EtmkCyvxpZGrxxeMRHI4Uj9+6jG/ODt5bawty+I6ciwMND5vsgjsAs+Ngf
	 Kz+11hcWKTjWC5EzLsQQt1kQB37PQKp1ForVWOuuOdrGEqLkpgpWKbr2GMMXT++5ZyC2w
	 uQwQtJZWsX3V2s+/AX99p4/PlsIvsvBJSX8S/3tdjLc2kwt70qF72ca5xTkzNCH3OtI4j
	 xcZpsAt2J+57o+Xz+nml/G2B6nIo+/ewpOfKkslCw6E5TwZ1wyn+G5am0p/1kq/XjlPgf
	 PCnGTZNJhCimPA6UnG7YpmEy1tYMFNBXf0AnFDoBbJqGTBHcr6qdCgNlLWJOZ1kafhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700804;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=358uIloGm7zgYRtMvfk0Vij4L17caruorv0tNFzQZtA=;
	b=RXn1pkRUyomwGsl1qrV9E/aGrxhQj/UAVjAbGUjquerSJ1Z3Gk6JqBV31j8XpsDS+kYs
	 vXTiO9MNjCyXluoo7B8+mDVO+T81smmsrcWkTy7ivipsLh0Xa7hBz+mYh8R2KV1wxulK8
	 9eWQ0YDHObmuXjTWMIItjqKa1+HK4ihIgANp1i3IXVZc/xuWx9a+PsfkO4o8hu6jZvwAz
	 wZ8mGeh00YqPeCeMtpzBmVVsBdlNBNl0b3rlfiJNVcIPf1uCa+P4s3VHVRBQiyWTryjig
	 7cLjeA7n6lAzDBjBalKISkyWggcHk3FjP10QxPDnrKv2w2d9QoCKDFjtTS9+BfZALeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XQoquMa4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9076083627
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XQoquMa4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6ED91F000C1;
	Tue,  3 Nov 2026 10:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793700804;
	bh=358uIloGm7zgYRtMvfk0Vij4L17caruorv0tNFzQZtA=;
	h=Subject:To:Cc:From:Date;
	b=XQoquMa4Utl7pC/zEKP2sCxF23BnrYmmDAwFDxVomL0Yo/ttelSjEilGnivEqbrJK
	 EPm80tmmVRIFK1RbQsgoDX+lb7w4nJGq/M8vwiPWyr12+FXWQ6sxtbKjZYLszKPb23
	 TC1hsOOzIcJqMXhhaOszhctppq/ShRIynYyNKLiM=
Subject: FAILED: patch "[PATCH] driver core: take parent lock in async device attach" failed to apply to 5.10-stable tree
To: mario.peter@leica-geosystems.com,dakr@kernel.org,dmitry.torokhov@gmail.com,johan@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Nov 2026 11:13:19 +0100
Message-ID: <2026110318-snide-showroom-1bf9@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 187a62f99da29b1a55602b0d401a783d8dc86161
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110318-snide-showroom-1bf9@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

