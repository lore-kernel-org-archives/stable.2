Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793713402;
	b=ihpdF0SjvT2qgqkZqZJZNMyBZJplCEZlwZbKcjM1YzykFWYdTDYdMCipmvIzvMlUXszE
	 cPbzH2K+KRlvYL6sN/aLCzET/jgEveAHNllEjyb29a9Yp63b9tKselfbt01SE+lgiEPrF
	 yUCPqyoGaXsBr9z0nwPc276UX12mVCXfE+bWnj41WG0yyuaUArtIPZU+/VUaRPdOIdN/Y
	 xDTnp3QvTdiYt5fs+eHGCN8RkTg6kogWcUPztcbM8SeBCEHz4ZCT2DSim/XUR+fouGAcF
	 SR4cjmpVArBAeTPKzhaGo30FHUHmUEmmy3XUuRf4XMnnzdRw90KrdeDl8WaSKaLQubA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713402;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Q8iE5u425Fu605I0Hu7MTJth+LSxkFw1mFepff7Eqsw=;
	b=Y5Elgpfd/M7EbhQ01hfj21jdPrNSJHE2kOztX0QJD1k4n5GbXSTRPl70pUaSuWkdva1v
	 gxm6dgzja6+rCsH8QTSPsCXeFU/McRJJ2MtaCFA+n5Ytoa4pfA3Szrb2G5gjc5+hpSHIF
	 mRxZmhEk2qFuwnaT9oY7TLm/kaJ2TVVYNqEk6jUsv5ODc5+tUnHB+x/Aeag2HZ91vS3pE
	 L2Ws7PoVfzThLX95ZwJ0QVWsl7BU7vYizvo9TCQ/AvouxQ/CgX7RJ0W9X46p9hoU8aB/J
	 8IDzBsDa27WcPIWJnsy+/qSZJA1Ap1Yv6e/Hd9XTknRclWvScXALqwr4T3yRji1fvjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dFLCAxK5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6093606D816
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dFLCAxK5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8401F00A1A;
	Tue,  3 Nov 2026 13:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793713401;
	bh=Q8iE5u425Fu605I0Hu7MTJth+LSxkFw1mFepff7Eqsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dFLCAxK5sZliBKVGBcOpsL+xMfieuxhfa2/m/bt1nfJqTye9BcsRBX+4aHevrYqIR
	 NubpJ34UR3rN6VpMlDSI20Dtj3U1TU11x2anOKICq1CpwUUNm7ifyWBkg2XsKUyXh4
	 LP5kIaKwZbWVwC1x4ATqwEZZ3/DSUnyXCulgJDJis0iLaR8NIJUei1W76mz4tfwZkE
	 el13+fItu6QNfHcSwGqPhOzDn98AzK42SS0NZuOIelryTAiYzyrrj2C8C1QkNAAaL6
	 oBIm1H+1Aiv4qjtqyyhVqNOUGfERG3esAvTFziF+diCBvYVas0qEXz3G3B8VvZeZ+P
	 8QAbgg8PD85/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mario Peter <mario.peter@leica-geosystems.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Johan Hovold <johan@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] driver core: take parent lock in async device attach
Date: Tue,  3 Nov 2026 08:43:18 -0500
Message-ID: <20261103134302.3982320-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103134302.3982320-1-sashal@kernel.org>
References: <2026110312-lint-gizmo-6095@gregkh>
 <20261103134302.3982320-1-sashal@kernel.org>
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
index 707d65396f2e0..2a94aad0f71e4 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1042,6 +1042,38 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
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
@@ -1051,7 +1083,7 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
 		.want_async	= true,
 	};
 
-	device_lock(dev);
+	__device_driver_lock(dev, dev->parent);
 
 	/*
 	 * Check if device has already been removed or claimed. This may
@@ -1073,7 +1105,7 @@ static void __device_attach_async_helper(void *_dev, async_cookie_t cookie)
 	if (dev->parent)
 		pm_runtime_put(dev->parent);
 out_unlock:
-	device_unlock(dev);
+	__device_driver_unlock(dev, dev->parent);
 
 	put_device(dev);
 }
@@ -1130,8 +1162,11 @@ static int __device_attach(struct device *dev, bool allow_async)
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
 
@@ -1158,48 +1193,20 @@ EXPORT_SYMBOL_GPL(device_attach);
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

