Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8206A45D182;
	Fri, 21 Aug 2026 09:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787304937; cv=none; b=MTAhrKy+ChKNCiLaUbx8kRslZRbX8G0rEtIeSHwr5qgeo5dEczQRlkNG1OsV/rM6j3sYhJAZPMRiTMDAgtgkBnKisPR345prEkiTA9IEgKzlsxasq+rDHwvhcKJH9f13e1+qVj8lwqczzmVk6AHeNvczd8wve4ISEn24rtqCLvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787304937; c=relaxed/simple;
	bh=l0gH9fTm3UyeEWbm7xK2cPAmmJoL1MRwpxAyafHjWeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Na8RMZT0T+jZbu3R4MxEdtBzgWzAVMG86GRijW1Yq5vFaunzHt+7ImJSGPGdDdTCIEcLfgXJKpH9n2kbnSuLIa27246i736cCP/33tTsvEkuf6Ut04/+Moms+3aQwnxfXrUGDWxRPgmr06jhqbShG9EkD6lP/dBrXNphEgqyY6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GP+yCJ/v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GP+yCJ/v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19A61F000E9;
	Fri, 21 Aug 2026 09:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787304925;
	bh=gZ00JCMFLOZkD7TWSRvk7KOcPf2AJz5BGzj08wkZIKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GP+yCJ/vHD64prEdPw9Y5CrBrJbl+JIFtItD8beYZolXgC3r00HpX+7zOiKKuJJMn
	 +ZFE1twoxzkreNpQ8Qbi+u9CNP8zPi8LsboskF9YzDm2bZQoRnHjc7fx2+XYK8Xnn9
	 vFUIuXq+PgwZkmnKGbk+nx/atcx1yCynoCbBVJNM82/sce4UuLUQE2zIs6ETAfMMXj
	 cfM+E9rDIPnaztKmHFZBZVuHds5Q3C9PRMc56YTDnVmqpjs/a1VD2updo7Y3LAi4D6
	 ACLhr1wE2e1MoOkA9b4dzXqlh5Zcn2VKUmydw8QnMQDMNztDEKghJwekppihiliPaV
	 FTDYVcz+eI74Q==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wxLel-00000000GzH-2RMG;
	Fri, 21 Aug 2026 11:35:23 +0200
Date: Fri, 21 Aug 2026 11:35:23 +0200
From: Johan Hovold <johan@kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] USB: serial: fix driver deregistration order
Message-ID: <aogb2-XZXZHUprHe@hovoldconsulting.com>
References: <20260820145402.434447-1-johan@kernel.org>
 <20260820145402.434447-3-johan@kernel.org>
 <2b757e10-c39d-48e5-8240-5390053f6f99@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b757e10-c39d-48e5-8240-5390053f6f99@rowland.harvard.edu>

On Thu, Aug 20, 2026 at 11:47:05AM -0400, Alan Stern wrote:
> On Thu, Aug 20, 2026 at 04:54:02PM +0200, Johan Hovold wrote:
> > USB serial driver modules register one driver for the USB bus and one or
> > more drivers for the ports on the USB serial bus.
> > 
> > When unloading a driver module, the USB driver must be deregistered
> > before the USB serial bus drivers so that I/O is stopped before
> > unbinding the ports to avoid use-after-free in completion handlers
> > accessing port data.
> > 
> > Note that the order does not matter currently in the registration error
> > path as the USB driver is not bound until after the USB serial drivers
> > have been registered.
> 
> But __usb_serial_register_drivers() does usb_register(udriver) _before_ 
> calling usb_serial_register() for the serial_drivers.  Not _after_, as 
> claimed here.

It registers the driver, but it doesn't set up the id table and
therefore will not bind to any interface until after the serial drivers
have also been registered (as an optimisation).
 
> And if the order in the registration error path does not matter, why 
> does the patch change it?

For symmetry with deregistration and for the unlikely event that there
is ever a later error path added (or if the optimisation mentioned above
is removed).

> Also, what about the failure mode described in 765e0ba62613?  Not to 
> mention that it seems odd to register a parent device driver after a 
> child device driver, rather than before.  Or to unregister them in the 
> reverse order.

There is generally no issue registering a driver for a child device
after a driver for a parent so that everything is in place when the
parent driver registers the child device.

In fact, that is sort of what is done today by not setting up the
id_table until after the serial drivers have been registered even if
things are complicated by how dynamic id support is implemented for USB
serial.

As I'm not changing the registration order I sort of skimmed over the
dynamic id issue addressed by commit 765e0ba62613 ("usb-serial: new API
for driver registration"). But I guess need to revisit that to make sure
I don't reintroduce a race during deregistration.
 
> If the point is to avoid I/O operations completing after the device 
> structure has been deallocated, why not rely on the serial-bus drivers 
> to stop all their I/O when they are unbound?

The problem is that there are two drivers involved for the USB interface
and USB serial port, respectively, both of which can do I/O and where
the parent USB driver may access the driver data of the child ports.

Tearing things down properly is a bit involved as you know (and as can
be seen from the first patch in the series). Everything is therefore
managed from the parent driver disconnect callback and individual ports
are, for example, no longer allowed to be unbound independently (cf.
commit fdb838efa31e ("USB: serial: suppress driver bind attributes")).

The only remaining corner case should be driver deregistration.

> If these questions don't make sense, remember that I haven't done 
> serious work on this subsystem for 15 years or so and blame it on that.  
> :-)

Heh. They make perfect sense. Thanks for taking a look.

Johan
