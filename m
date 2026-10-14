Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C8339A06D
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 02:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791945538; cv=none; b=UQksVYIykaGScGqg8TWvAhM0fyTMGhtKFHohAaqdbiV5U5kufL/tG3VHShEkC0ucSO3SUJXszWGRzcgy/aaFP2ySCQiOPLThYk2FTe7KzDmPq4XXPWXALtPB2Pjxu3JkZxffgtcEGVT2ivwh5lKwml17JPhlWFNhVOLlZTtudJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791945538; c=relaxed/simple;
	bh=ScelcZyE52ZQd8lA4ACXuwYHHmFqpRNhs5nb7pATNtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O54GEw7xcvHn7Se37RH2XCIys32PmRusSivoZ2BI8LdygPLZd0h9sSmDiLIoYqtA4SXtAEO/O1ff4GMUZ1ldYI5vBkG87RrEaJdcKLaCEwIfC5yHGO191VuWDaQ6+GBWuwpV9p9U31JiahO5Q6gJySf96wMjZj2H7A2/1M7thgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=uGeFObiI; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="uGeFObiI"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-533930955a4so33749951cf.3
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 19:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1791945536; x=1792550336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=81rgxI9/Er4yjHtl/CLpwDXbGoyatzgl1W8u9x4gaMM=;
        b=uGeFObiINLfqftF5nht5CHrSapcKy+LW/RBD6bqkxCPwUkzTjc5EPRw0UcLma52IOy
         8kqEZDMTPk9O95FuNdA/R2K7NQwUzUR64Wag6M10t/VuG8LBUewCbOOl4IRlnKdnCcIt
         DjWEhBfmNbXly/g3H5QaPW3Z3k8Bm4914X72W7SqhOpol9xKw/8bdzcFaTCMzboI3tcm
         qPIYE01tbkU2+DQTMKdY6/RISSETnh09xnGLaocDI5XBoejNd00UuVDU1bG58n2i+rIs
         MN3H+QOtOHoM3Ly9IcahRtFkOVgbTofgRgDEUDowIDE3isLsivhdrvyPdD7fEiTL7rNz
         T0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791945536; x=1792550336;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=81rgxI9/Er4yjHtl/CLpwDXbGoyatzgl1W8u9x4gaMM=;
        b=V/Jaop6FGOMLAvVvHstQm04/y68R7nGH+kKng3jH0W4tjRSeMxBWq0Sx+XygjeGTTW
         LGk9uPTgZzik0dYYSLsYpKUwkFjwYJwrLmiw/JgQGrdrKFP5LJ25lMbAPNKNfyNYPeAj
         OP4szsXxIFFgqM5KYdS6VQLNFsmjzllcfGmFzmMbyK1DOVx4il79uzxcevkiVVQQLwms
         mZcmUg0JAandWD6OMozWqF3jtsvCfPepHb2zFHPiKS9fqHAm7+absEURyXDl2bzkSy57
         aBRAEj47bxrwjdLD/1Ya0BptzAnK7n2xHkalmBv/L8MhmoRhBLj/qKuxvIv8pEevqY7s
         eRQA==
X-Forwarded-Encrypted: i=1; AKwUvBw+VseP62tbCTQD++bdx3Nloh6kJ6kYvHtb9tnGSjWQVzf6or8Z6AoU5HGlWmKQisXnFvKkLcg=@vger.kernel.org
X-Gm-Message-State: AFq9FYI3SYyAw1GT0RAPSxT/uwxP0nUot2j9QiQEdARv2koE9xcI3pYP
	RBM2mK8ykeeM3f3cFP9JkIOg5o4vmBXlBuYk2u1NVIa3SfnOgl3AP+YqeOSZnqhkiA==
X-Gm-Gg: AYBFou1r97Gt1BcC72ruJRPj9wSsPCvVJ/Dw0ExQNs+YC1OZfb6q30N/Wk6Ml7JKiro
	T/iEhfqr11C3y3CWujXbPgkfe5a9oqq0SK5ssX//a7XnckJ3cH8FPKUDwNoCNXaDPRtIeUyAS27
	IJ32vECgJHIBiXnQKBqCBfj1WerfBCpur4QDV21HTkm0/X1GbkEOluyIzx1UNgsww7zE6yQTegl
	hilgTCRIplJvz5NdKUxbQU0b/uohfaMfWE5mD4hEUs0KuYUZqCtpGc31z+mjxDzKdAQk09ZOOj7
	VrILeaMFubkZmMDqJLLAO5gDINa8GhWnXTmOboZFgszJzWQ8j0vtTPmmijZRYxLa8oP/VEU9Pww
	LK5kvmZPyYq2JvcaeuqTl+K32FXTRcGV/vp2LG4i2uFqGSuGMA25yAytqijrPD+2/hXTfvhD7BR
	vE5w/Ss47yyLJx8njogePexPaZ3SsMhL+8Ojfv38StIJs9wc6RmHx7u5NQ0iV7qJip9uvReC0=
X-Received: by 2002:a05:622a:2483:b0:534:b7b2:6353 with SMTP id d75a77b69052e-5359fdcab5bmr204146021cf.56.1791945536079;
        Tue, 13 Oct 2026 19:38:56 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::4791])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b7c0214sm116472561cf.25.2026.10.13.19.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 19:38:54 -0700 (PDT)
Date: Tue, 13 Oct 2026 22:38:51 -0400
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
Message-ID: <9803935c-11d9-48a0-8d4c-95c478a724a8@rowland.harvard.edu>
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

There could be another reference that extends all the way to the child's 
release.

> USB interfaces already take an additional reference to their USB device in
> usb_set_configuration() and drop it in usb_release_interface(), so they should
> already be protected against this particular UAF.
> 
> The issue concerns a USB device and its parent hub's USB device.  (This makes me
> wonder whether probing a USB device actually requires the parent USB HUB
> device's lock to be held, or whether this is just a consequence of sharing the
> same usb_bus_type?)

The latter.

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

I was going to suggest that the driver core could acquire and release 
these extra references automatically for devices on a bus with 
need_parent_lock set, but it looks like that can't be done because the 
bus_type might not yet be set when device_initialize() runs.

However, is there any real reason why the driver core wouldn't want to 
guarantee that dev->parent will be a valid pointer up until the time 
when dev is released?  For every device that has a parent, not just USB?

On the other hand, there's something a bit weird about this whole thing.  
The problem arises when you want to probe a device whose parent has been 
deleted.  Isn't there some sort of protection to prevent that from ever 
happening?  I mean, doesn't deleting a device imply that all its 
descendants have been (or are in the process of being) deleted?  And of 
course, deleting and probing are mutually exclusive -- they can't race, 
right?

Alan Stern
