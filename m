Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669D036A376;
	Wed, 14 Oct 2026 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791989509; cv=none; b=CbdTVOivyVuTYxjLdw63YmhYFmpdHyQHySOuElvEgdyG+lO6ac+r36PDv8fshKZyfpkmuWMj2Z7wcg9lBSqxsCyHAJfAOlGnTCJPoFyG8cQGWJMakKi/XrrM/BRHUJbEWSweYfY0UeeM+z8Zyp/TIkrNN2fJRm5LXRS933VXDrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791989509; c=relaxed/simple;
	bh=Xl+glkhfyjyGl++0X8RPdtpiZVNuqTgxxcI9eF/B+EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTTBgDZJ1/KJ54qH5VuWxgVO8kiqqjPJXjczYAmrpLP1cb/w3isp+XhA1o3a+fGfDDuUcCI0wD5gH/qdhQdt2Ms8KGV7iX9z5+dOO533pO205PdVc6heeccO20VS2O6l+rhP4nSZqBytvMWsCssWJW1+X6wc7E0uRU3j2TCPbC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csDIMM5x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csDIMM5x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23B51F000C4;
	Wed, 14 Oct 2026 14:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791989507;
	bh=lIuHampH6XPDLRiQvCykQRKzguHtJTDH8XDYB2DKimM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=csDIMM5xz5ezOurVZw1LpXGwKSGRZNE2XuYfWEnpwlVLapxVnp00DYYFrRib5k0+C
	 R0pniemqsO/+5x1drUK4Z7n41/FJXSJoMgU0W+fLxwg+6WdoA7eakdaAwXlPbCjZ7r
	 NDgX6NWvyRpOUoQvFD2JvAyKsvz2vbazm0reekVkPzynkaOAPfpL9GrkEDxHx9OFl5
	 QDNkK0NW7xBvGdt0WTs3lhIka+Wq4ydRu7vHhglJUzmknMj7oZv2HGKQISuWSRtJcS
	 FyN2Db2/igJ6Hy6sHi2qFD0By4X7nLzR0siFLMHIXbkasOWghOLRsd8lX0qQpw5t2O
	 W3+bIJ+CyUYkA==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xH0KX-00000005rHP-2jS2;
	Wed, 14 Oct 2026 16:51:45 +0200
Date: Wed, 14 Oct 2026 16:51:45 +0200
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
Message-ID: <as-XAQsMcCCklpoO@hovoldconsulting.com>
References: <20261013140615.1226992-1-johan@kernel.org>
 <DM3WA69YX6WE.2Q4DY9MIU7A0L@kernel.org>
 <ba24846a-7403-4bb1-a0cb-869cf1d44e05@rowland.harvard.edu>
 <DM40HVOBKMFI.3W1DK371ZWI80@kernel.org>
 <9803935c-11d9-48a0-8d4c-95c478a724a8@rowland.harvard.edu>
 <DM4MTGIILY95.YZSDZOIBBZZT@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4MTGIILY95.YZSDZOIBBZZT@kernel.org>

On Wed, Oct 14, 2026 at 04:30:48PM +0200, Danilo Krummrich wrote:
> On Wed Oct 14, 2026 at 4:38 AM CEST, Alan Stern wrote:

> > On the other hand, there's something a bit weird about this whole thing.  
> > The problem arises when you want to probe a device whose parent has been 
> > deleted.  Isn't there some sort of protection to prevent that from ever 
> > happening?  I mean, doesn't deleting a device imply that all its 
> > descendants have been (or are in the process of being) deleted?  And of 
> > course, deleting and probing are mutually exclusive -- they can't race, 
> > right?
> 
> Yes, that's what the dev->p->dead check under the device lock protects against.
> But the new code accesses dev->parent before acquiring the device lock and
> reaching that check.

It's not just the new code; we have the same issue in __driver_attach()
bus_rescan_devices_helper() for synchronous probe too.

Johan
