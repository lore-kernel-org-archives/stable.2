Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9554A3F37;
	Wed, 14 Oct 2026 08:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791965744; cv=none; b=UN3yIn/Qu9UeLbTmAHKLGmTMp7qpVZtT5rxESsdjadHgx/9E3rqrJa1dc3QU3QF3OGHryuU6W6SyMVFeGwp/PhAjwiQPTYRbK8RPwXWwjvQ4wYsxEvesyIDe4b1QEj2Qu6tXXPLQ4bvpEDgGnu3ZVBE3vjx/nrQZaCRkgYrhmRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791965744; c=relaxed/simple;
	bh=GkU1sRPAtfTEmXL4qSPPLZPsdl96Q4Lac2iBktml0Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKmiswCDAzJidg9ttE0bw8DeZuGdfsGdiSISr95YJZ4wK90KlhSgjPLEOmeVtkvKuMMKLF37S1qqS4/JCQWnB8vJYyek+mELsX/SjnSJQ/6bW9riBk5poqel+Kam505StopIof/TSH/b6PlK1iUvUbTjmID+bjtmfrxaq3Z6FnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSJl3MeR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSJl3MeR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24751F000FF;
	Wed, 14 Oct 2026 08:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791965741;
	bh=Ff39rq+Xpt06s7hBPSrU8RkdhlGjanvDISSNw4ovMXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CSJl3MeRFF/uoT0lJLFtTDzgeg2prznlo/FAxT/13QRHml9kWrsMyTR1aX6gkryTA
	 vajvvcXVrjHNW4JLG4XTUnOQEOXtYVFeThmTF3Zh6SFyo7CZUTOWx9f5YlIXTAVvHf
	 brtYZZzX3AIGT/IUZlqY4TGNhnnH2/TzbdHaRGsdhx1c9kZGW14hquYDgnzvR7ulJz
	 6TMLtSaAlkfviMDC+pVjfYcQaXT99yPUOESJW9HdhA0h1O7/jNrNA7QntpmRQyQVDq
	 X7oLyiO3GXtfKNkH3eBdyelbUl1z3etzfByagCYPqD0VMdPz3YFvxkA6U3zo+LvNEM
	 vWGuYIwdkx4iw==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xGu9D-00000005HL7-1Jsj;
	Wed, 14 Oct 2026 10:15:39 +0200
Date: Wed, 14 Oct 2026 10:15:39 +0200
From: Johan Hovold <johan@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	driver-core@lists.linux.dev, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mario Peter <mario.peter@leica-geosystems.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] driver core: take parent lock on deferred probe
Message-ID: <as86K1qm1sHtgTFL@hovoldconsulting.com>
References: <20261013140615.1226992-1-johan@kernel.org>
 <DM3WA69YX6WE.2Q4DY9MIU7A0L@kernel.org>
 <ba24846a-7403-4bb1-a0cb-869cf1d44e05@rowland.harvard.edu>
 <DM40HVOBKMFI.3W1DK371ZWI80@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM40HVOBKMFI.3W1DK371ZWI80@kernel.org>

On Tue, Oct 13, 2026 at 11:01:16PM +0200, Danilo Krummrich wrote:
> On Tue Oct 13, 2026 at 9:11 PM CEST, Alan Stern wrote:
> > On Tue, Oct 13, 2026 at 07:43:08PM +0200, Danilo Krummrich wrote:
> >> On Tue Oct 13, 2026 at 4:06 PM CEST, Johan Hovold wrote:
> >> > +void bus_probe_device_deferred(struct device *dev)
> >> > +{
> >> > +	if (dev->parent && dev->bus->need_parent_lock)
> >> > +		device_lock(dev->parent);
> >> 
> >> This looks like it has the same potential UAF as the other patch.  It's quite
> >> unfortunate we need the whole need_parent_lock thing just for USB.  IIUC the
> >> main reason USB needs this is because interface devices share resources of USB
> >> devices and we need to keep the locking order to avoid inversions, right?  Is
> >> there more to this from the USB side of things?
> >
> > That's pretty much it.
> >
> >> I think we can probably do something like this
> >> 
> >> 	struct device *parent = NULL;
> >> 
> >> 	scoped_guard(device, dev) {
> >> 		if (dev->p->dead)
> >> 			return;
> >> 	
> >> 		if (dev->bus->need_parent_lock)
> >> 			parent = get_device(dev->parent);
> >> 	}
> >> 
> >> to avoid the problem, but it's still a bit ugly.
> >> 
> >> > +	__bus_probe_device(dev);
> >> > +	if (dev->parent && dev->bus->need_parent_lock)
> >> > +		device_unlock(dev->parent);
> >> > +}
> >
> > Wouldn't it be simpler just to make each USB interface take a reference 
> > to its parent device?  And likewise for USB devices, if needed?
> 
> The driver core already holds a reference count of the parent between
> device_add() and device_del(), which is where a "parent" is technically defined.
> But the deferred retry can extend beyond device_del().

Yeah, but we could take a reference also to the parent under the
deferred_probe_mutex in deferred_probe_work_func().

And similarly, the device should be registered when __device_attach() is
called so that we can take another parent reference for async probing.

We do however have this bug already today for some other cases.
For example, bus_add_driver() loops over all devices on the bus, but
only checks if the device is dead after __driver_attach() has already
taken the parent lock.

> USB interfaces already take an additional reference to their USB device in
> usb_set_configuration() and drop it in usb_release_interface(), so they should
> already be protected against this particular UAF.

Right.

> The issue concerns a USB device and its parent hub's USB device.  (This makes me
> wonder whether probing a USB device actually requires the parent USB HUB
> device's lock to be held, or whether this is just a consequence of sharing the
> same usb_bus_type?)

Indeed. We could consider making this a device type attribute instead
and move it to usb_if_device_type. May speed up USB enumeration for
people using async probe too.

> In theory a USB device could also keep a reference count to its parent, but then
> the driver core code would rely on an implementation detail of its users; I'd
> prefer not to make driver core's access to dev->parent depend on references
> maintained by individual subsystems.
> 
> I'd even go a step further any say that if subsystems try to keep this pointer
> valid beyond what's guaranteed by the driver core, they should do this with a
> separate bus specific pointer.  The reason is that otherwise the lifetime and
> ownership definition of this pointer does not depend on API contracts, but on
> individual implementation details, which is a very common source for all kinds
> of bugs.

But it's driver core that needs the extra reference. It seems
reasonable to require that any subsystem that sets a new
type->need_parent_lock also makes sure that any device of that type
holds a reference to its parent. And importantly, it's already the case
for the only user of this feature today (i.e. USB interfaces).

Johan
