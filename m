Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED24D4C14F3;
	Wed, 14 Oct 2026 22:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792017648; cv=none; b=eLFYpKUjcF6zM9ZrhXnsPtA5aOIhjYBCxY0Vs6Kbj67BL5yantAIqs8R1JCra2f7dt/17fdpOey1aBFfRF7Jy4DNd1Xms1KpYbll1ObNujV29Xg1jZuo+upz1EXziD2KccE+ry4z59Q+9knUrZ/YL2KKdTZRXB/vfeTihQbaECQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792017648; c=relaxed/simple;
	bh=3zMKStu57wu1s210M0wBl0cKlpREHyiuH3D/r7Twb2k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=YF/2zTPm9pGulprOY4Di2JakZ38dm5MWSvXolBqqH0W9Te2dAP61lyqu0TBL717arHcrpRU+Ss+X30kSkOxQB8QJMBBVXi7GgqUOpmamd8RAJcIvjCJ9g4nUO3UubbbK/ArT0AQamxAPWKanWdwW0VdeonBk6D89ibAwm/QHEOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFXKXaju; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFXKXaju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A751B1F000C4;
	Wed, 14 Oct 2026 22:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792017645;
	bh=f+z6zAFLCvaCAmCvCFxJcssIZyFfbNiJ0CIpX6Ijf38=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To;
	b=AFXKXajuri2XUTwRNmk1+piowUIzxjFgNfzvRHTZhDWB6afoVS8fcTvZw5oWoRffc
	 iWGhZZiIQ4nwDiDUwIzxiZG5oB/re5tzPDDMvHTiwotPTDL5q3PRklCPm0zH6xo1tc
	 7x4ekZLEv0uXvnvZaq/jpjhcFXvG/VmJPhD7iOpW9FGPUBN8mpMWpBmgypASl58tc3
	 AiRwkXnO6Xtu39ozlXGBjDFEdwW7Zuyu67JoTITqHaZQi2TX8ENb5yvLt90Ud8UcFQ
	 5HY/4aBpBxGtqbo2VZ6GFU2U/RzHY5bGAuuTWZDKXoBbXRyfco57PUFGNiI8ijDo8C
	 YtRM1VpBklqWw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Oct 2026 00:40:42 +0200
Message-Id: <DM4X8JU9PXCU.T51SZD8XO7MG@kernel.org>
Cc: "Alan Stern" <stern@rowland.harvard.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 <driver-core@lists.linux.dev>, <linux-usb@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Mario Peter"
 <mario.peter@leica-geosystems.com>, <stable@vger.kernel.org>
To: "Johan Hovold" <johan@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] driver core: take parent lock on deferred probe
References: <20261013140615.1226992-1-johan@kernel.org>
 <DM3WA69YX6WE.2Q4DY9MIU7A0L@kernel.org>
 <ba24846a-7403-4bb1-a0cb-869cf1d44e05@rowland.harvard.edu>
 <DM40HVOBKMFI.3W1DK371ZWI80@kernel.org>
 <as86K1qm1sHtgTFL@hovoldconsulting.com>
 <DM4N25JXKTQM.3K7TP9HM68KQ2@kernel.org>
 <as-cW9ZwmMCPcftL@hovoldconsulting.com>
In-Reply-To: <as-cW9ZwmMCPcftL@hovoldconsulting.com>

On Wed Oct 14, 2026 at 5:14 PM CEST, Johan Hovold wrote:
> On Wed, Oct 14, 2026 at 04:42:09PM +0200, Danilo Krummrich wrote:
>> On Wed Oct 14, 2026 at 10:15 AM CEST, Johan Hovold wrote:
>
>> > But it's driver core that needs the extra reference. It seems
>> > reasonable to require that any subsystem that sets a new
>> > type->need_parent_lock also makes sure that any device of that type
>> > holds a reference to its parent. And importantly, it's already the cas=
e
>> > for the only user of this feature today (i.e. USB interfaces).
>>=20
>> Exactly, it is the driver core that needs the extra reference count; for=
 a field
>> that is owned by the driver core, and for which the driver core manages =
its
>> lifetime.  If it needs an additional reference count for async or deferr=
ed work
>> it should obtain the reference count for this scope explicitly.
>
> As I've mentioned, it's not just for async or deferred probe. It's also
> needed when a driver gets added or when probe is triggered through
> sysfs. The bus iterators only takes a reference to the each device and
> not their parents before calling __driver_attach() etc.
>
>> USB interfaces already holding an additional reference makes the propose=
d
>> contract work for today's user, but I'd rather not make that prerequisit=
e of the
>> API.  It would push a prerequisite for an implementation detail to the u=
ser.
>
> I understand your concern, but my reasoning is that this feature is only
> needed when devices are tightly coupled with their parents and where it
> therefore probably always make sense to pin the parent.
>
> Note that the need_parent_lock flag is now set in the device type struct
> which also holds a pointer to the release function that drops the
> reference. So it's pretty easy to check any theoretical further users.
>
>> Please, let's not add this API contract. Let's have the driver core deal=
 with
>> this internally.
>
> I can take another look at it, but the alternatives seemed either error
> prone or a bit icky (e.g. a helper that returns a reference to the
> parent after checking the dead flag under the device lock).

I thought some more about this, and since it is only the USB device type us=
ing
it it's probably fine for now.  Should we ever gain new users of this API (=
which
I do not hope), we can still change it and add something like the diff belo=
w.

I'd suggest to also add a comment in the USB code, explaining that this
reference count (also) serves the purpose to fulfill the driver core API
contract.

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 3c36a2128f88..8193bf924726 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -101,6 +101,8 @@ struct driver_private {
  * @async_driver: pointer to device driver awaiting probe via async_probe
  * @deferred_probe_reason: capture the -EPROBE_DEFER message emitted with
  *			   dev_err_probe() for later retrieval via debugfs
+ * @deferred_parent_ref: parent reference held until release for device ty=
pes
+ *			 with &struct device_type.need_parent_lock set.
  * @device: pointer back to the struct device that this structure is
  *	    associated with.
  * @dead: This device is currently either in the process of or has been
@@ -118,6 +120,7 @@ struct device_private {
 	struct list_head deferred_probe;
 	const struct device_driver *async_driver;
 	char *deferred_probe_reason;
+	struct device *deferred_parent_ref;
 	struct device *device;
 	u8 dead:1;
 };
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 5daa88fa724a..45050f90294b 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2641,6 +2641,8 @@ static void device_release(struct kobject *kobj)
 	else
 		WARN(1, KERN_ERR "Device '%s' does not have a release() function, it is =
broken and must be fixed. See Documentation/core-api/kobject.rst.\n",
 			dev_name(dev));
+	if (p)
+		put_device(p->deferred_parent_ref);
 	kfree(p);
 }
=20
@@ -3682,6 +3684,9 @@ int device_add(struct device *dev)
 	pr_debug("device: '%s': %s\n", dev_name(dev), __func__);
=20
 	parent =3D get_device(dev->parent);
+	/* Parent locking must remain safe after device_del(). */
+	if (dev->type && dev->type->need_parent_lock)
+		dev->p->deferred_parent_ref =3D get_device(parent);
 	kobj =3D get_device_parent(dev, parent);
 	if (IS_ERR(kobj)) {
 		error =3D PTR_ERR(kobj);
@@ -3828,6 +3833,7 @@ int device_add(struct device *dev)
 parent_error:
 	put_device(parent);
 name_error:
+	put_device(dev->p->deferred_parent_ref);
 	kfree(dev->p);
 	dev->p =3D NULL;
 	goto done;
@@ -4697,6 +4703,10 @@ int device_move(struct device *dev, struct device *n=
ew_parent,
 		goto out;
 	}
 	old_parent =3D dev->parent;
+	if (dev->type && dev->type->need_parent_lock) {
+		dev->p->deferred_parent_ref =3D get_device(new_parent);
+		put_device(old_parent);
+	}
 	dev->parent =3D new_parent;
 	if (old_parent)
 		klist_remove(&dev->p->knode_parent);
@@ -4715,6 +4725,10 @@ int device_move(struct device *dev, struct device *n=
ew_parent,
 				if (new_parent)
 					klist_remove(&dev->p->knode_parent);
 				dev->parent =3D old_parent;
+				if (dev->type && dev->type->need_parent_lock) {
+					dev->p->deferred_parent_ref =3D get_device(old_parent);
+					put_device(new_parent);
+				}
 				if (old_parent) {
 					klist_add_tail(&dev->p->knode_parent,
 						       &old_parent->p->klist_children);
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
