Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36574E36D0;
	Wed, 14 Oct 2026 14:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791989927; cv=none; b=Yie2Q00IoC+/SwA+DA0yWRtaHpLogNcVwASVEiwb8XUxnhAflA9DLYAxAA7EQ7o94XlpkrjvVpM1dQpb+mHM+5gKVw5q9+noLJbyTlBZ+V0GrYicUflgzsLjVnkBLUtqGQ4TR4wiGGYME3H9OU+xsoITasLthxELq7GUKCdEJPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791989927; c=relaxed/simple;
	bh=PpCmxhaMfmnmPpJ43Vt0tuPi8xBgG4Xfw0ApFv1iEn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dl8GWHGSQoJugFu1/xPDa1Po+03IotjZN5VYY7VHKV0ObnoGj5EaKRhBUZermYflDsiXORCQnxtHCOoZh80cixtMuPZUGIIcehHkQdKzmlIBN++wS6TZ0S2QC7DACgsY3V+9K8UKJ4KDyetSfy5ZO0LPfNAfjhhNheMtZI2rCWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uaq/TTJO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uaq/TTJO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 579611F000C4;
	Wed, 14 Oct 2026 14:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791989925;
	bh=m+ycLKuN3NTfWeAQrQcT1OYPGsZBNIjzMzYu9BZ8owc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Uaq/TTJOyyKO8ne89bJ7RY6OBkHy1nyuxSYBCC3dJ/k8Yh5fTa4/jIgyp89+j88F2
	 Ei5L8Q1faDSSUxZgpGy88aCV8LV4ksuAnIUh1cOWLbkyVuu4T6ZKqYh0P6WXRJMOjC
	 TcZs0s8z3+S64CujwYRgyAn31dU1jWYzfA96/Zc6t8oKREallkpoERO6oxuQ+iD+TQ
	 7RVIwPZTqiJvzdZGx1ZjSRBLf+jNeiJb1U7sY1CTl3biYWr6OIl3dyHmhNlaLX0B5w
	 qXrlsJoyTPlXha0ha1qWkPlLo4lC0O4Qc4QRIimxW8ZfG+bY5CFeks3SpdjQbZgKvl
	 S7LF2LQ6smcOA==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xH0RH-00000005rN6-1DS5;
	Wed, 14 Oct 2026 16:58:43 +0200
Date: Wed, 14 Oct 2026 16:58:43 +0200
From: Johan Hovold <johan@kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mario Peter <mario.peter@leica-geosystems.com>,
	driver-core@lists.linux.dev, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] driver core: take parent lock in async device
 attach
Message-ID: <as-Yo_ge-2C6NZRO@hovoldconsulting.com>
References: <20261014133109.1392265-1-johan@kernel.org>
 <20261014133109.1392265-4-johan@kernel.org>
 <a68b8b6c-c84e-44a2-baff-aff56824a465@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a68b8b6c-c84e-44a2-baff-aff56824a465@rowland.harvard.edu>

On Wed, Oct 14, 2026 at 10:52:48AM -0400, Alan Stern wrote:
> On Wed, Oct 14, 2026 at 03:31:09PM +0200, Johan Hovold wrote:
> > From: Mario Peter <mario.peter@leica-geosystems.com>

> > Take the parent lock in __device_attach_async_helper() as well, like
> > __driver_attach_async_helper() does, and move
> > __device_driver_lock/unlock() up for that. With this the warning was
> > gone in 300 boots on the board and in 6000 iterations in QEMU.
> > 
> > Fixes: 765230b5f084 ("driver-core: add asynchronous probing support for drivers")
> > Assisted-by: LLM
> > Signed-off-by: Mario Peter <mario.peter@leica-geosystems.com>

> > [ johan: switch to async_schedule_dev_nocall() to avoid deadlock if
> >          async_schedule_dev() runs synchronously when parent lock is
> > 	 held ]

> > @@ -1118,8 +1150,13 @@ static int __device_attach(struct device *dev, bool allow_async)
> >  	}
> >  out_unlock:
> >  	device_unlock(dev);
> > -	if (async)
> > -		async_schedule_dev(__device_attach_async_helper, dev);
> > +	if (async) {
> > +		if (!async_schedule_dev_nocall(__device_attach_async_helper, dev)) {
> > +			put_device(dev);
> > +			ret = 2;	/* retry synchronously */
> > +		}
> > +	}
> > +
> >  	return ret;
> >  }
> >  
> > @@ -1146,48 +1183,20 @@ EXPORT_SYMBOL_GPL(device_attach);
> >  void device_initial_probe(struct device *dev)
> >  {
> >  	struct subsys_private *sp = bus_to_subsys(dev->bus);
> > +	int ret;
> >  
> >  	if (!sp)
> >  		return;
> >  
> > -	if (sp->drivers_autoprobe)
> > -		__device_attach(dev, true);
> > +	if (sp->drivers_autoprobe) {
> > +		ret = __device_attach(dev, true);
> > +		if (ret == 2)
> > +			__device_attach(dev, false);
> > +	}
> >  
> >  	subsys_put(sp);
> >  }
> 
> These two pieces do not seem to be related to the changes mentioned in 
> the patch description.  Are they leftovers from some other patch?

They are needed since async_schedule_dev() may execute the callback
synchronously and in which case we'll deadlock if the caller already
holds the parent mutex (e.g. during initial probe).

I only highlighted the issue in the trailer section of the patch,
perhaps I should have amended the commit message proper.

Johan
