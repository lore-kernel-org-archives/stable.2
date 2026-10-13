Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A2A518148;
	Tue, 13 Oct 2026 21:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791925281; cv=none; b=HoGsBJlOHyW/R6puQ6d9MSvfKUAgBuDGqqZhxi/L1NP//g0C4ANCX4J50y2SoR6CZA+p40+uPPlFGHcZpQJBPKEDtMmoSZt9qALkAUoOHL+P+XhQzZ9mCLvW9kh1U7ARL6JtgChhLx/44Jy+GPEC/01FR78NXRuMGbvfSHE5U0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791925281; c=relaxed/simple;
	bh=Z5QE8bDGwjv5rpz0E6KvjEKBlO2PL0gMiX6i/nSwbI4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=NvuYQY73552/cGD2sb6pLktiy6ISF2rdgIm3RbTtgS24SvtoOy/C3ltWit+4Ph/4XeStx1fb8UODbrH2dQpgv36DqEai1Oh7DelKXpLdsIjmt29aooBT17yk0mJWkL4YvE2VMizR3xDp9Qtd5cw7RCKIYE6sovPiW4ogkbUloiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bkgxwb8k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bkgxwb8k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E7D1F000FF;
	Tue, 13 Oct 2026 21:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791925280;
	bh=Pi/onS5WtRQMlO8FS9+xnweQOK38nFxgcItu9oVclZc=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To;
	b=Bkgxwb8kRgeWfVfeeZcRxvKNQNPflLWum9CcF1B566WzH3xACQW7zpJyShAF3K2dH
	 XWcpqSD2QWZ0fkbe169FnGbQDOg01JCGEM4A883eRARN8SXTyq51ngI8P/hU4SkpRq
	 oo/SWcbKMuGsyWO8evcVYbeYzfkRmv3Q/o3yGc2+ox8xBdN33R8eUddVcS9d8PCPbY
	 c7YulMljG+lESEAcAZU8iSMQXQxD3m5/kLgV6vcMC3z8RfjjUmbb2DHzgi7Nq9O6dP
	 +dnEA9LuTuZkXr2bwVFiOVQX1q6A6iYDlxiZ46FIItWb9lNWrpmzJz5eYuIiPJkxx/
	 XZjVg/KX3E+lw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Oct 2026 23:01:16 +0200
Message-Id: <DM40HVOBKMFI.3W1DK371ZWI80@kernel.org>
To: "Alan Stern" <stern@rowland.harvard.edu>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] driver core: take parent lock on deferred probe
Cc: "Johan Hovold" <johan@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 <driver-core@lists.linux.dev>, <linux-usb@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Mario Peter"
 <mario.peter@leica-geosystems.com>, <stable@vger.kernel.org>
References: <20261013140615.1226992-1-johan@kernel.org>
 <DM3WA69YX6WE.2Q4DY9MIU7A0L@kernel.org>
 <ba24846a-7403-4bb1-a0cb-869cf1d44e05@rowland.harvard.edu>
In-Reply-To: <ba24846a-7403-4bb1-a0cb-869cf1d44e05@rowland.harvard.edu>

On Tue Oct 13, 2026 at 9:11 PM CEST, Alan Stern wrote:
> On Tue, Oct 13, 2026 at 07:43:08PM +0200, Danilo Krummrich wrote:
>> On Tue Oct 13, 2026 at 4:06 PM CEST, Johan Hovold wrote:
>> > +void bus_probe_device_deferred(struct device *dev)
>> > +{
>> > +	if (dev->parent && dev->bus->need_parent_lock)
>> > +		device_lock(dev->parent);
>>=20
>> This looks like it has the same potential UAF as the other patch.  It's =
quite
>> unfortunate we need the whole need_parent_lock thing just for USB.  IIUC=
 the
>> main reason USB needs this is because interface devices share resources =
of USB
>> devices and we need to keep the locking order to avoid inversions, right=
?  Is
>> there more to this from the USB side of things?
>
> That's pretty much it.
>
>> I think we can probably do something like this
>>=20
>> 	struct device *parent =3D NULL;
>>=20
>> 	scoped_guard(device, dev) {
>> 		if (dev->p->dead)
>> 			return;
>> =09
>> 		if (dev->bus->need_parent_lock)
>> 			parent =3D get_device(dev->parent);
>> 	}
>>=20
>> to avoid the problem, but it's still a bit ugly.
>>=20
>> > +	__bus_probe_device(dev);
>> > +	if (dev->parent && dev->bus->need_parent_lock)
>> > +		device_unlock(dev->parent);
>> > +}
>
> Wouldn't it be simpler just to make each USB interface take a reference=
=20
> to its parent device?  And likewise for USB devices, if needed?

The driver core already holds a reference count of the parent between
device_add() and device_del(), which is where a "parent" is technically def=
ined.
But the deferred retry can extend beyond device_del().

USB interfaces already take an additional reference to their USB device in
usb_set_configuration() and drop it in usb_release_interface(), so they sho=
uld
already be protected against this particular UAF.

The issue concerns a USB device and its parent hub's USB device.  (This mak=
es me
wonder whether probing a USB device actually requires the parent USB HUB
device's lock to be held, or whether this is just a consequence of sharing =
the
same usb_bus_type?)

In theory a USB device could also keep a reference count to its parent, but=
 then
the driver core code would rely on an implementation detail of its users; I=
'd
prefer not to make driver core's access to dev->parent depend on references
maintained by individual subsystems.

I'd even go a step further any say that if subsystems try to keep this poin=
ter
valid beyond what's guaranteed by the driver core, they should do this with=
 a
separate bus specific pointer.  The reason is that otherwise the lifetime a=
nd
ownership definition of this pointer does not depend on API contracts, but =
on
individual implementation details, which is a very common source for all ki=
nds
of bugs.
