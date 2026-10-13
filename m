Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB54153C3DB
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 19:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791918714; cv=none; b=k1TfqzASXfgPQAQexEEW2+In2vlvc8c3Tfv70MN9Tbzsv7wtALNXHa/rHXvFMhJff9gA8q/cTjsc7nCI3Et9a7awhZHis8cuRuk9I94jdp8b4IC0h++iBj8urjEVfKXs13iWGYedWGafWqVAoml548IA0xwdYMuw7uO080YCK/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791918714; c=relaxed/simple;
	bh=3HuQAdiPdsh0jwsZb5sHsgSWrdEkCX/qTBEkBhJKRIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LrHr+QYom4m0U4YKscjAzgEkLSb0unaX/705Y5Fw+QYk78NAIydywhvlcoLi3Xj2B4eP2bk+CH1i2D49ryJgC67TIzgjhSwjw9eRnsi8swoGZDIwGyjzJ0OT/IfS8IZZO+rYwOfQL4Ba7Jy/epz/wSV7007T6Z+LMfQfckaglOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=jYB5HlbR; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="jYB5HlbR"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-53396adbc53so41720651cf.3
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 12:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1791918710; x=1792523510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EUvFEr9KZQAlEL8z8vQRJTx2wZ9st4nMmUN/wIzO9UQ=;
        b=jYB5HlbRG5U/2bWjeQZ0e1BIVUMFP+thLqGog9vaQfAEiKHAPsF198vD52pAlmjbu3
         wzhTppJOCWuUFd6tzpAxIpKlGqshaJ3Ap8ACpWD9T0UbdCfbIEmkUMO6h7yX/0dB+45L
         nbirKPSHlsE7kepk2T70UlSzu17r5edw7hmV3/DlCvvRPMmHH+aURwXGw1Exgz8eVujJ
         NQKVFkwMXILXElBEKaYr0VU8uYpIcMFQU6T5kdutbaH3VI1X55DyFvzLuS5UdkAR/uuW
         0jGQvTFiBCwlNc4U3yhH/kmtaO4lctSTz3+EhBP9Ah/xhUT9cV/+OuAdw/G4HZd375QO
         CviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791918710; x=1792523510;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EUvFEr9KZQAlEL8z8vQRJTx2wZ9st4nMmUN/wIzO9UQ=;
        b=2u3wxRwywEc83Km7P2qrBdCm8kDkvurQxYX9SMhpuwfnoikPxeVCfYx2GCAJYpuxXd
         ZHDQaAg118akF5BiPDxWE8GquqiUsrHvunA35GyxfQFInbf6cRJOZvpWlJddXi9oPaxz
         DfNJL9Xc4BEsKgUp1UbfnXeJBZjElU8cL+GAZ2mDVZl/jbfIej6Eq5OTyA40Xt2aZp5d
         ORQ3TEbeMIAF6CGwo6ViS25EfJlFN1gQEXKYZI53abUmf1Dj4MCxC0PWi1oe+rJtL/e7
         ziU1uggu3RHIf0dz9176e30HHRQ5ZskXIcLLMyK3nhLSl1nlDTM4rkdjeGpMrk0un49Q
         JnyQ==
X-Forwarded-Encrypted: i=1; AKwUvBxSjfm0LAJBltHtMyuxzN3SpKPQmShsHOYa0vq2CdMHu4L2Kb8jT2Jvuzv75+0Jfb0LbW59PGg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKzUgDslP9s3MAuv10CMcXx+V2ixKfI5D/0paTaRfIgXH8Q3KQF
	iURmmCx04Ii1pjmRrnlPCyYhvOz8WR+0JqKFdRsyNwTP5UU4RN7uEc7+mmJ3GlDukA==
X-Gm-Gg: AYBFou2UhLgPHdfUGCz9Pw9tt/4HSHC1qQ7ne6UDUbbJ139BHcYK+T2KIj4sJeZe79i
	IK19c68Y1tPQAJxQfVn51AAaPeNjsPuo57god0bPLHoAuGeOqQ5f26rQW4cO0xXrKCSc4aIH64D
	bDD18fJ9A0s4/YunWQPsp0DGonaVXFebeSnSRtABKLfpiV4VhFcFk39QzFpqE8WDZdjAyX0yeen
	/KWjkQQ5OoulZAh8oBLDeY+eXn5PzL3VJ5vcVR7ckS+yiiHthTAeO1mkHhsAVVHOYjl94DsbckO
	N4/B4RLPfCMPcXNyP9titNypo2bCxTOVBFIiJTXTQm9ctEebi6D30A/8bLZFzRnU9xipHSHvVZX
	fqUcCOikTgvkLC5LQBCrVDer8OqK76qqx2YoupKrRDsOGWp8D6lS2cw8LtpUaLO8goeYuPD0LDd
	x1IVs9qK1OzGCz/ainwTsQt9sck/f1avouwrD7baMVBp+Doo4iKH7gPTjDcYN5lJRAt4vkAZ7Xm
	75PIXPW9x7usH7fj8hsxk+tuj7L4NBlwRWMsVWvRg==
X-Received: by 2002:a05:622a:48e:b0:535:a5fb:67fa with SMTP id d75a77b69052e-535a5fb84aamr206754931cf.70.1791918710428;
        Tue, 13 Oct 2026 12:11:50 -0700 (PDT)
Received: from rowland.harvard.edu ([2607:fb60:1011:2006:2008:aeb7:73d7:d8ff])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b7ad30csm109382571cf.23.2026.10.13.12.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 12:11:49 -0700 (PDT)
Date: Tue, 13 Oct 2026 15:11:46 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	driver-core@lists.linux.dev, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mario Peter <mario.peter@leica-geosystems.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] driver core: take parent lock on deferred probe
Message-ID: <ba24846a-7403-4bb1-a0cb-869cf1d44e05@rowland.harvard.edu>
References: <20261013140615.1226992-1-johan@kernel.org>
 <DM3WA69YX6WE.2Q4DY9MIU7A0L@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM3WA69YX6WE.2Q4DY9MIU7A0L@kernel.org>

On Tue, Oct 13, 2026 at 07:43:08PM +0200, Danilo Krummrich wrote:
> On Tue Oct 13, 2026 at 4:06 PM CEST, Johan Hovold wrote:
> > +void bus_probe_device_deferred(struct device *dev)
> > +{
> > +	if (dev->parent && dev->bus->need_parent_lock)
> > +		device_lock(dev->parent);
> 
> This looks like it has the same potential UAF as the other patch.  It's quite
> unfortunate we need the whole need_parent_lock thing just for USB.  IIUC the
> main reason USB needs this is because interface devices share resources of USB
> devices and we need to keep the locking order to avoid inversions, right?  Is
> there more to this from the USB side of things?

That's pretty much it.

> I think we can probably do something like this
> 
> 	struct device *parent = NULL;
> 
> 	scoped_guard(device, dev) {
> 		if (dev->p->dead)
> 			return;
> 	
> 		if (dev->bus->need_parent_lock)
> 			parent = get_device(dev->parent);
> 	}
> 
> to avoid the problem, but it's still a bit ugly.
> 
> > +	__bus_probe_device(dev);
> > +	if (dev->parent && dev->bus->need_parent_lock)
> > +		device_unlock(dev->parent);
> > +}

Wouldn't it be simpler just to make each USB interface take a reference 
to its parent device?  And likewise for USB devices, if needed?

Alan Stern
