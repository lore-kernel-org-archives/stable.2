Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60528531B01;
	Wed, 14 Oct 2026 13:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984698; cv=none; b=TMngoOTq2htMFA2QVLqERQAwxr2Lw5rh1wrx1nYLb+29lo2lzcMG7rSbtQPB3MbM6b2PbLp7XFvDF6Nr8XMUGEUEmfB6U1O8Fg2PStkZEjeqrBON7yIeYMwWgDq5f0X1EWG+wrJRgrpKGLwI4yGT8MixqR+qljvPgm+Vuoxuxfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984698; c=relaxed/simple;
	bh=KKFPtBaPI49EZJizBrN18iefWNosmLiTrPUViR7FNTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jATFHSNEG2iNq5cEHwELHSVbOEQEoV9DcdJyLUPJ+M0+4OokOELvxDsnrRv9h8OKS6Zrgru961Dm9G2Ifxb0SAhkxPwtEJkCX1IbBg700oCMjbDI6LLCyOA0mwyOrwuO/re04lq1r6g1AUPpRPf8OwM6obNT5x6viywxlSmMVVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+4qhai3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+4qhai3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3A21F000FF;
	Wed, 14 Oct 2026 13:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791984691;
	bh=pLwMjZIjBLGxjNCIoEsp4xwlcMA5qh4oScrVFPf/3vg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S+4qhai3F74wCWZ9wOkRctuTu1J0o6++uIJTxXPkEw142/Oply3FdM4OMMleEvBMV
	 623miBObGdxQmGC6WW26UXcWtuSCrqSOS9dtR3OSDIQr2RPtL+39EvLW2GdGA+oNKE
	 1L+UFwUhxEejhF1T54BIIX5/WxRUzOSa/sB6IMZZ8pP9oaEBs9AKAn4YoBShToPFF+
	 42Os+ipwMLhmTRxz9pVipOJPpK6PJ8e23+ldmRXwQsOb4R9R5UEkvq4TzdSTZPR5AY
	 W2lKGhNJckCV1CM3vKb5U26897Lc9keIthhH34zQ+G29A/lrOBYURIr5MIIz/Ed1Ed
	 RVWZqQxIZQefw==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xGz4q-00000005qCa-2dcY;
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
Subject: [PATCH v2 3/3] driver core: take parent lock in async device attach
Date: Wed, 14 Oct 2026 15:31:09 +0200
Message-ID: <20261014133109.1392265-4-johan@kernel.org>
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

From: Mario Peter <mario.peter@leica-geosystems.com>

On buses with need_parent_lock set (only USB), probe() must run with the
parent device locked. A synchronous attach after device_add() gets this
from the caller, e.g. usb_set_configuration() holds the udev lock while
adding interfaces. __device_attach_async_helper() runs the probe from an
async worker instead, where that lock isn't held, and only takes
device_lock(dev).

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
Assisted-by: LLM
Signed-off-by: Mario Peter <mario.peter@leica-geosystems.com>
[ johan: switch to async_schedule_dev_nocall() to avoid deadlock if
         async_schedule_dev() runs synchronously when parent lock is
	 held ]
Cc: stable@vger.kernel.org	# 4.2
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/base/dd.c | 85 ++++++++++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 38 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index f8f4c32b6c79..a5fa0f2a5409 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1030,6 +1030,38 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
 	return ret == 0;
 }
 
+/*
+ * __device_driver_lock - acquire locks needed to manipulate dev->drv
+ * @dev: Device we will update driver info for
+ * @parent: Parent device. Needed if the bus requires parent lock
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
+ * @parent: Parent device. Needed if the bus requires parent lock
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
@@ -1118,8 +1150,13 @@ static int __device_attach(struct device *dev, bool allow_async)
 	}
 out_unlock:
 	device_unlock(dev);
-	if (async)
-		async_schedule_dev(__device_attach_async_helper, dev);
+	if (async) {
+		if (!async_schedule_dev_nocall(__device_attach_async_helper, dev)) {
+			put_device(dev);
+			ret = 2;	/* retry synchronously */
+		}
+	}
+
 	return ret;
 }
 
@@ -1146,48 +1183,20 @@ EXPORT_SYMBOL_GPL(device_attach);
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
- * @parent: Parent device. Needed if the bus requires parent lock
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
- * @parent: Parent device. Needed if the bus requires parent lock
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
2.55.0

