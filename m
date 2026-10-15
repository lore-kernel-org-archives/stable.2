Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA60547061;
	Thu, 15 Oct 2026 00:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792023528; cv=none; b=bQcIy4VvBs2h12l+4nBcTw0ynxXnQ7kanKxbVZ3xw47xmdgb6d6fI8BOD8HQi0+xUWha03q8u6AOel47MsuiMJWqC3f4rkoQD+kSDHwDvLRAOU4002jshgvrh05dCg5aRH/CeOy9lHDlI4MGYBrQBSGqIURkuajengkpE0Tn9pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792023528; c=relaxed/simple;
	bh=ewXiFF0dkYx1oW1z99Vo134lYaEXqI+knbGM+2ZIHGg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=gTaCmI3XohmfiK4V6kyWSbcsTa4CNlRwDYfAX4RNmry2CUSe/j/E47BnHaSLt5B9kh+ScrZiSsjrGWibvumd4i+OnjUHfjwCm1YHd05hF5GOj8MHgv3DrtFBs74wplORAK04GVoghlaPNUw+Sp2oef+FXcq2RnqzY5Wr+zS1Fec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7XjEDjd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7XjEDjd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977CB1F000C4;
	Thu, 15 Oct 2026 00:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792023526;
	bh=Qp0nD6Ti2x3T8NpaZrCeQlKRS+Nx7BmhthDtPhQxZxI=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=W7XjEDjdgFHlHHMnBR2tLE9LNEhVtBw4VpN7OSd2D7Hf3XLFUwJwjiklxjdsWXAPr
	 TM0apnR6rz1Fz7PqOGRbWaTFd2kGP9QrpH63qwgQHGYTaSpuA68ie4tBJMoMMvilbP
	 cliC8DwyaFUyRq1XYkEkCX3AwN4P6iFZYM0/lazuFaenCQwX7vXIlB7eM9k9YqB+pE
	 aZ50pIcniHj+FUxEvVcRKAaSCDbTL9+Ydw1S2zogh3Kec6c+viELWralHzjyEsNN5V
	 f4Tj2f4i++UBQ9oY1lLY6FQs4fRIPiBIm7A9NuTGPxHSmy5H/3245DvnZAsaT/TB6s
	 YL93MH3eU973g==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 02:18:43 +0200
Message-Id: <DM4ZBLHJLQJB.11A47MPAF74B8@kernel.org>
Subject: Re: [PATCH] driver core: take parent lock on deferred probe
Cc: "Alan Stern" <stern@rowland.harvard.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 <driver-core@lists.linux.dev>, <linux-usb@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Mario Peter"
 <mario.peter@leica-geosystems.com>, <stable@vger.kernel.org>
To: "Johan Hovold" <johan@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261013140615.1226992-1-johan@kernel.org>
 <DM3WA69YX6WE.2Q4DY9MIU7A0L@kernel.org>
 <ba24846a-7403-4bb1-a0cb-869cf1d44e05@rowland.harvard.edu>
 <DM40HVOBKMFI.3W1DK371ZWI80@kernel.org>
 <as86K1qm1sHtgTFL@hovoldconsulting.com>
 <DM4N25JXKTQM.3K7TP9HM68KQ2@kernel.org>
 <as-cW9ZwmMCPcftL@hovoldconsulting.com>
 <DM4X8JU9PXCU.T51SZD8XO7MG@kernel.org>
In-Reply-To: <DM4X8JU9PXCU.T51SZD8XO7MG@kernel.org>

On Thu Oct 15, 2026 at 12:40 AM CEST, Danilo Krummrich wrote:
> On Wed Oct 14, 2026 at 5:14 PM CEST, Johan Hovold wrote:
>> On Wed, Oct 14, 2026 at 04:42:09PM +0200, Danilo Krummrich wrote:
>>> On Wed Oct 14, 2026 at 10:15 AM CEST, Johan Hovold wrote:
>>
>>> > But it's driver core that needs the extra reference. It seems
>>> > reasonable to require that any subsystem that sets a new
>>> > type->need_parent_lock also makes sure that any device of that type
>>> > holds a reference to its parent. And importantly, it's already the ca=
se
>>> > for the only user of this feature today (i.e. USB interfaces).
>>>=20
>>> Exactly, it is the driver core that needs the extra reference count; fo=
r a field
>>> that is owned by the driver core, and for which the driver core manages=
 its
>>> lifetime.  If it needs an additional reference count for async or defer=
red work
>>> it should obtain the reference count for this scope explicitly.
>>
>> As I've mentioned, it's not just for async or deferred probe. It's also
>> needed when a driver gets added or when probe is triggered through
>> sysfs. The bus iterators only takes a reference to the each device and
>> not their parents before calling __driver_attach() etc.
>>
>>> USB interfaces already holding an additional reference makes the propos=
ed
>>> contract work for today's user, but I'd rather not make that prerequisi=
te of the
>>> API.  It would push a prerequisite for an implementation detail to the =
user.
>>
>> I understand your concern, but my reasoning is that this feature is only
>> needed when devices are tightly coupled with their parents and where it
>> therefore probably always make sense to pin the parent.
>>
>> Note that the need_parent_lock flag is now set in the device type struct
>> which also holds a pointer to the release function that drops the
>> reference. So it's pretty easy to check any theoretical further users.
>>
>>> Please, let's not add this API contract. Let's have the driver core dea=
l with
>>> this internally.
>>
>> I can take another look at it, but the alternatives seemed either error
>> prone or a bit icky (e.g. a helper that returns a reference to the
>> parent after checking the dead flag under the device lock).
>
> I thought some more about this, and since it is only the USB device type =
using
> it it's probably fine for now.  Should we ever gain new users of this API=
 (which
> I do not hope), we can still change it and add something like the diff be=
low.
>
> I'd suggest to also add a comment in the USB code, explaining that this
> reference count (also) serves the purpose to fulfill the driver core API
> contract.

I pasted the wrong diff, I meant the one below, but either should work.

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 3c36a2128f88..b3730d030f5f 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -161,8 +161,9 @@ bool bus_is_registered(const struct bus_type *bus);

 int bus_add_driver(struct device_driver *drv);
 void bus_remove_driver(struct device_driver *drv);
+struct device *device_get_parent_for_lock(struct device *dev);
 void device_release_driver_internal(struct device *dev, const struct devic=
e_driver *drv,
-				    struct device *parent);
+				    bool lock_parent);

 void driver_detach(const struct device_driver *drv);
 void driver_deferred_probe_del(struct device *dev);
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index fd2257f73253..9975f250d22e 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -637,11 +637,13 @@ void bus_probe_device(struct device *dev)

 void bus_probe_device_deferred(struct device *dev)
 {
-	if (dev->type && dev->type->need_parent_lock)
-		device_lock(dev->parent);
+	struct device *parent __free(put_device) =3D device_get_parent_for_lock(d=
ev);
+
+	if (parent)
+		device_lock(parent);
 	__bus_probe_device(dev);
-	if (dev->type && dev->type->need_parent_lock)
-		device_unlock(dev->parent);
+	if (parent)
+		device_unlock(parent);
 }

 /**
@@ -866,11 +868,13 @@ static int __must_check bus_rescan_devices_helper(str=
uct device *dev,
 	int ret =3D 0;

 	if (!dev->driver) {
-		if (dev->type && dev->type->need_parent_lock)
-			device_lock(dev->parent);
+		struct device *parent __free(put_device) =3D device_get_parent_for_lock(=
dev);
+
+		if (parent)
+			device_lock(parent);
 		ret =3D device_attach(dev);
-		if (dev->type && dev->type->need_parent_lock)
-			device_unlock(dev->parent);
+		if (parent)
+			device_unlock(parent);
 	}
 	return ret < 0 ? ret : 0;
 }
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5daa88fa724a..3a924c4e194e 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1676,8 +1676,7 @@ void device_links_unbind_consumers(struct device *dev=
)

 			device_links_write_unlock();

-			device_release_driver_internal(consumer, NULL,
-						       consumer->parent);
+			device_release_driver_internal(consumer, NULL, true);
 			put_device(consumer);
 			goto start;
 		}
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 52123251965d..6ff8d0653769 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1030,6 +1030,30 @@ static int __device_attach_driver(struct device_driv=
er *drv, void *_data)
 	return ret =3D=3D 0;
 }

+/*
+ * Pin the parent before taking its lock. A reference to dev alone does no=
t
+ * keep its parent alive after device_del().
+ *
+ * device_del() marks the device dead under its lock before dropping the
+ * registration reference to the parent. A dead device may still need to b=
e
+ * unbound; while dev->driver is set, device_del() cannot have completed t=
he
+ * unbind and dropped that reference either.
+ *
+ * The caller must hold a reference to dev and put the returned parent aft=
er
+ * its last access, including any temporary unlock/relock during unbind.
+ */
+struct device *device_get_parent_for_lock(struct device *dev)
+{
+	if (!dev->type || !dev->type->need_parent_lock)
+		return NULL;
+
+	guard(device)(dev);
+	if (dev->p->dead && !dev->driver)
+		return NULL;
+
+	return get_device(dev->parent);
+}
+
 /*
  * __device_driver_lock - acquire locks needed to manipulate dev->drv
  * @dev: Device we will update driver info for
@@ -1065,13 +1089,14 @@ static void __device_driver_unlock(struct device *d=
ev, struct device *parent)
 static void __device_attach_async_helper(void *_dev, async_cookie_t cookie=
)
 {
 	struct device *dev =3D _dev;
+	struct device *parent __free(put_device) =3D device_get_parent_for_lock(d=
ev);
 	struct device_attach_data data =3D {
 		.dev		=3D dev,
 		.check_async	=3D true,
 		.want_async	=3D true,
 	};

-	__device_driver_lock(dev, dev->parent);
+	__device_driver_lock(dev, parent);

 	/*
 	 * Check if device has already been removed or claimed. This may
@@ -1093,7 +1118,7 @@ static void __device_attach_async_helper(void *_dev, =
async_cookie_t cookie)
 	if (dev->parent)
 		pm_runtime_put(dev->parent);
 out_unlock:
-	__device_driver_unlock(dev, dev->parent);
+	__device_driver_unlock(dev, parent);

 	put_device(dev);
 }
@@ -1205,11 +1230,12 @@ void device_initial_probe(struct device *dev)
  */
 int device_driver_attach(const struct device_driver *drv, struct device *d=
ev)
 {
+	struct device *parent __free(put_device) =3D device_get_parent_for_lock(d=
ev);
 	int ret;

-	__device_driver_lock(dev, dev->parent);
+	__device_driver_lock(dev, parent);
 	ret =3D __driver_probe_device(drv, dev);
-	__device_driver_unlock(dev, dev->parent);
+	__device_driver_unlock(dev, parent);

 	/* also return probe errors as normal negative errnos */
 	if (ret > 0)
@@ -1223,14 +1249,15 @@ EXPORT_SYMBOL_GPL(device_driver_attach);
 static void __driver_attach_async_helper(void *_dev, async_cookie_t cookie=
)
 {
 	struct device *dev =3D _dev;
+	struct device *parent __free(put_device) =3D device_get_parent_for_lock(d=
ev);
 	const struct device_driver *drv;
 	int ret;

-	__device_driver_lock(dev, dev->parent);
+	__device_driver_lock(dev, parent);
 	drv =3D dev->p->async_driver;
 	dev->p->async_driver =3D NULL;
 	ret =3D driver_probe_device(drv, dev);
-	__device_driver_unlock(dev, dev->parent);
+	__device_driver_unlock(dev, parent);

 	dev_dbg(dev, "driver %s async attach completed: %d\n", drv->name, ret);

@@ -1296,9 +1323,11 @@ static int __driver_attach(struct device *dev, void =
*data)
 		return 0;
 	}

-	__device_driver_lock(dev, dev->parent);
+	struct device *parent __free(put_device) =3D device_get_parent_for_lock(d=
ev);
+
+	__device_driver_lock(dev, parent);
 	driver_probe_device(drv, dev);
-	__device_driver_unlock(dev, dev->parent);
+	__device_driver_unlock(dev, parent);

 	return 0;
 }
@@ -1372,8 +1401,11 @@ static void __device_release_driver(struct device *d=
ev, struct device *parent)

 void device_release_driver_internal(struct device *dev,
 				    const struct device_driver *drv,
-				    struct device *parent)
+				    bool lock_parent)
 {
+	struct device *parent __free(put_device) =3D lock_parent ?
+		device_get_parent_for_lock(dev) : NULL;
+
 	__device_driver_lock(dev, parent);

 	if (!drv || drv =3D=3D dev->driver)
@@ -1400,7 +1432,7 @@ void device_release_driver(struct device *dev)
 	 * within their ->remove callback for the same device, they
 	 * will deadlock right here.
 	 */
-	device_release_driver_internal(dev, NULL, NULL);
+	device_release_driver_internal(dev, NULL, false);
 }
 EXPORT_SYMBOL_GPL(device_release_driver);

@@ -1413,7 +1445,7 @@ EXPORT_SYMBOL_GPL(device_release_driver);
  */
 void device_driver_detach(struct device *dev)
 {
-	device_release_driver_internal(dev, NULL, dev->parent);
+	device_release_driver_internal(dev, NULL, true);
 }

 /**
@@ -1440,7 +1472,7 @@ void driver_detach(const struct device_driver *drv)
 		dev =3D dev_prv->device;
 		get_device(dev);
 		spin_unlock(&drv->p->klist_devices.k_lock);
-		device_release_driver_internal(dev, drv, dev->parent);
+		device_release_driver_internal(dev, drv, true);
 		put_device(dev);
 	}
 }
diff --git a/include/linux/device.h b/include/linux/device.h
index 7c7682e4dafe..7604060ff99b 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -85,8 +85,7 @@ int subsys_virtual_register(const struct bus_type *subsys=
,
  * the DEVTYPE variable.
  *
  * @need_parent_lock:	When probing or removing a device of this type,
- *			driver core should lock the device's parent. Note that
- *			the device must hold a reference to its parent.
+ *			driver core should lock the device's parent.
  */
 struct device_type {
 	const char *name;
