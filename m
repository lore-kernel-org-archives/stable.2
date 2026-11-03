Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719003;
	b=GreEw9o20amRmQkK/EA4ZdjpvRDx7PQwtV729mknjCgoHjYA3u7g9eecYEZdvn9OcWUi
	 ZkNiFyd3tJ9Nh3tiZmU9uZnAAy8SPZrbV+JLB0Dnj1f/CmgHKv0QRAcOjP3xZWp8+aAn/
	 I+M3ND5yq3V+QlGd8tJN0Aw3opOy+UanHDhrcpg8Wl/7PQlUnTr3d4qkRrXGEosBmTJEr
	 3WmyM1Y6vtGGa9cTWHKTEhqPQ7KCOJOVtWsGO1+cY0KM/+he0YK38gDKh75CBH+hLm/5O
	 ha/WWeYLGK4Z1FZM0BWhI8lkTc608BQkesDhr+BMqxaHlOXc8z+5JzEV/TF8LSiOaHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719003;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Zga5JcQxfzkI0TmNcPjxGJTXcFP19Tpx25rgK3hl4N4=;
	b=D1nM5PdOixP3X2HlRQbQz/pSCJjW19j8U2XxwjFUQRKMH6aSTdbOaRwoofOUtYggBK/+
	 kM63XsaRiwbb/UMSzb3k+5mQopLbNdFXSijdFAv5XrpSc+11BddoxcjT27PptIYRMEtY4
	 owJD7RwBDNImwRC4bOzTB4ZKQc23PeDERFnSXzbPUbWD57d2hARhR5WEWG0tPpoHURLco
	 B+UeHowr7S5sk+Jes/coACn7/3323KAqXryorQO4Tj+DtbuHZ9ZMyT9fULdLz+W9+P2tl
	 XQ0VrwEfx/P2vyCzztHo8Eg9GSeSq9IQVZKDkkHRXNgbUqqdeitafuD4ek9Ulxxw9aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gl7UuAhu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF2B606A7BA
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gl7UuAhu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A25FE1F0093A;
	Tue,  3 Nov 2026 15:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793719003;
	bh=Zga5JcQxfzkI0TmNcPjxGJTXcFP19Tpx25rgK3hl4N4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gl7UuAhuNOtONi1ddBnPa9D+RwMnTKdJzVGkFkN6Vl2IkTbibe9MfzxCPe0KQ91XP
	 J+DcfxsqJrRfMD9k0MX6ZI2XTaYUvq9Jbmjvl+a+gRDJgDGunWcUkHAy82hnA//hlq
	 gBaTFEsUWiXM0Y2M97aLIrK2iQ0GWY59osXmFEbMi41RQnvp+66cWrPfP/1bwQGqLH
	 4DKpEqjsFkNvQc0n3a6TVWVxlhuaDFZyBQFRVc+C5EYKyZkG0w95lQSvEDkHuABMx+
	 ZYDX2lxBeeljwJ7dL+7uBYXGcRVaojGPQiuqipK2lvU6O3sjC3jNfDJJ3gUPlX6mDM
	 7CR2xdvPXKCbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mario Peter <mario.peter@leica-geosystems.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] driver core: take parent lock in async device attach
Date: Tue,  3 Nov 2026 10:16:40 -0500
Message-ID: <20261103151630.247511-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103151630.247511-1-sashal@kernel.org>
References: <2026110314-chloride-agony-d0f9@gregkh>
 <20261103151630.247511-1-sashal@kernel.org>
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

From: Mario Peter <mario.peter@leica-geosystems.com>

[ Upstream commit 187a62f99da29b1a55602b0d401a783d8dc86161 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/dd.c | 83 +++++++++++++++++++++++++----------------------
 1 file changed, 45 insertions(+), 38 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 4accc885a9d44..eaee6121c9475 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1041,6 +1041,38 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
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
@@ -1050,7 +1082,7 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
 		.want_async	= true,
 	};
 
-	device_lock(dev);
+	__device_driver_lock(dev, dev->parent);
 
 	/*
 	 * Check if device has already been removed or claimed. This may
@@ -1072,7 +1104,7 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
 	if (dev->parent)
 		pm_runtime_put(dev->parent);
 out_unlock:
-	device_unlock(dev);
+	__device_driver_unlock(dev, dev->parent);
 
 	put_device(dev);
 }
@@ -1129,8 +1161,11 @@ static int __device_attach(struct device *dev, bool allow_async)
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
 
@@ -1157,48 +1192,20 @@ EXPORT_SYMBOL_GPL(device_attach);
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
-- 
2.53.0

