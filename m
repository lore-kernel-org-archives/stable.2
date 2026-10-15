Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3990415E5BB;
	Thu, 15 Oct 2026 06:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046909; cv=none; b=MaJ5eIROyZGuz1zlJpJ3Fik2akneXSqL/GnPc3GQayzLbeOLL5RIgp8glPJ/+1T5yOtmC/KtXnqsqakLWp6leA4Rg8TkMRjVzPOINUHA2JGN2qCHO7fWt/AKbWmZEkws6ZHPTTNVmdyPIrx/mApX20F5ZgdfT4EJ2ThTCuWZrLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046909; c=relaxed/simple;
	bh=x06vfpE1sVYyhtd6+t3pDnzhp4GcwfStVJjoGGp63fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rj35cr9SASRDJ/tyEHNVpkTSciE3cs0AWvAnQ97Tc+jD/f5m+K/BffEnlcWCNXaLORMS39K+0JeI1sc+0j9ac8LJ+RdYhBORk0otj3PpEqIQa4bo80M+Eiu9/obl60Dk0SPxogmDcpU+BK6V8UhGOEWvTjbWhf663FCQTon0AS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDBPhC3v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDBPhC3v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05AF1F000C4;
	Thu, 15 Oct 2026 06:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792046907;
	bh=dso/tIH4LiNIquidRJisKhpHbOzUSZnjCA6TuPe7msg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EDBPhC3vvoPIFCSjeH6OLfZoRLmI4fSqDnYTg1WOVjDB+YbC5UKJWVul2BE8JnpWy
	 pFpD1/szBkXixBhRT+7x7vol6oYzMMohjbHdMSlPr+ZgAkOQ1HaJaeFNso8L3m5q8V
	 aMsYVAUgx0QbncKBjsw/243ll6N3dYQ7muPukmUIDSAdFarJ4b4N0CFAFk5gWe4t67
	 5v1UIWGHSYgB38UWTqQDFa7J6t9CQCrydmwGoQoXLiQluvYviknkWdV68vjG9QktXh
	 0fsglpWDyrRANIQ+1UhN8+Duk6DIY3QVTHBAh1z0ffNEOHhTyjfvyDyrudBuPaJ1OG
	 xGTmvaL4gqC+Q==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xHFGL-00000005w4b-0mBf;
	Thu, 15 Oct 2026 08:48:25 +0200
Date: Thu, 15 Oct 2026 08:48:25 +0200
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
Message-ID: <atB3Octe0OaCLBUQ@hovoldconsulting.com>
References: <20261013140615.1226992-1-johan@kernel.org>
 <DM3WA69YX6WE.2Q4DY9MIU7A0L@kernel.org>
 <ba24846a-7403-4bb1-a0cb-869cf1d44e05@rowland.harvard.edu>
 <DM40HVOBKMFI.3W1DK371ZWI80@kernel.org>
 <as86K1qm1sHtgTFL@hovoldconsulting.com>
 <DM4N25JXKTQM.3K7TP9HM68KQ2@kernel.org>
 <as-cW9ZwmMCPcftL@hovoldconsulting.com>
 <DM4X8JU9PXCU.T51SZD8XO7MG@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4X8JU9PXCU.T51SZD8XO7MG@kernel.org>

On Thu, Oct 15, 2026 at 12:40:42AM +0200, Danilo Krummrich wrote:
> On Wed Oct 14, 2026 at 5:14 PM CEST, Johan Hovold wrote:
> > On Wed, Oct 14, 2026 at 04:42:09PM +0200, Danilo Krummrich wrote:

> > I understand your concern, but my reasoning is that this feature is only
> > needed when devices are tightly coupled with their parents and where it
> > therefore probably always make sense to pin the parent.
> >
> > Note that the need_parent_lock flag is now set in the device type struct
> > which also holds a pointer to the release function that drops the
> > reference. So it's pretty easy to check any theoretical further users.
> >
> >> Please, let's not add this API contract. Let's have the driver core deal with
> >> this internally.
> >
> > I can take another look at it, but the alternatives seemed either error
> > prone or a bit icky (e.g. a helper that returns a reference to the
> > parent after checking the dead flag under the device lock).
> 
> I thought some more about this, and since it is only the USB device type using
> it it's probably fine for now.  Should we ever gain new users of this API (which
> I do not hope), we can still change it and add something like the diff below.

Sounds good. It was variations of your two diffs that I had in mind as
well.

> I'd suggest to also add a comment in the USB code, explaining that this
> reference count (also) serves the purpose to fulfill the driver core API
> contract.

Sure, I'll do that.

Johan
