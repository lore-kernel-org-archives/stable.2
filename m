Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA6442E011
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 08:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783328398; cv=none; b=MFXl9kawrKGM8KPgoHfOeFrFujlqlNbTsfYN8Y1JlD5YVG+XTtbfcd0tVG4Uvua830m6+VU8eV5PC2CmVPfnZCJ+IIgCKQa2vMYbM7VD/tOWeUmkI203aBD6uKcEDj0svseNCErCRl/G5QYL5o7HBQVQLHMzWAvWYR7SOB7N6Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783328398; c=relaxed/simple;
	bh=RYkBCQDMTYKWKsolGeookIevCeyL7ZbSoRHQrqoBd5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsBh8y32+uLovwtYy6qfljVtC4qRktll4Qjk6W4wtcCUOZAR6Yr0LGmoJ422UMy8BNhc7Sxxx18THFlhGHhSf/c+eJTRErQlQpDwrVLrsn9msOwGrXUT1181I/jumMz+k3t8eDJECYvwieHTkTzZv04IwJc756nVc+1lp9CwF3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qOBZSYE5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x6MJmd2Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qOBZSYE5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x6MJmd2Y"
Date: Mon, 6 Jul 2026 10:59:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783328381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vJ73e2TvQ0rFtNoXD0QH2VGUWkqzGqzS10/2H4h+n4k=;
	b=qOBZSYE5vYKliEumGbZA3XnKKHeSIiWNf8I88I9kD6w5+2AviplZNIGoQhu8a3gJa583KH
	GQY6S2XVqEjvzx+8xE7VSTZCPmMTCJLqVRGpkQ2BCO1DAweE292i8DHZlxawzMlPbLUpWK
	FYCoaFn/0b/9pBlxhMlNsQd3b981siY6E6geIdp2FdfhNvYBoRxJRXUcNeSCe88bTPJzJJ
	w9zXi1/hTlsFmSf0it5MKKDytLiCQyWlmJIK/WvuKUUasTJNe7/t90DcI1i2Q8BMW1mFZT
	ezSS76Cw+wHkoRLu4TFfQ+BSQg/iOsy26Cpph+lVWnnatd+rKauBc5Zl69TqiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783328381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vJ73e2TvQ0rFtNoXD0QH2VGUWkqzGqzS10/2H4h+n4k=;
	b=x6MJmd2YGv03GD5CX6DtDGj8zK+Vfkf57pT5hdVfrrWUAjpukk4xI0WZhgOl9fXUGPfLWp
	u4gRUHJ0VFzFBABg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
	Jon Humphreys <j-humphreys@ti.com>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH v6.18 0/3] ARM: PREEMPT_RT backports
Message-ID: <20260706085940.3lUHUu8z@linutronix.de>
References: <20260629144131.788576-1-bigeasy@linutronix.de>
 <2026070229-rendering-plus-be9d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026070229-rendering-plus-be9d@gregkh>

On 2026-07-02 16:06:48 [+0200], Greg KH wrote:
> On Mon, Jun 29, 2026 at 04:41:28PM +0200, Sebastian Andrzej Siewior wrote:
> > Hi,
> > 
> > ARM missed the PREEMPT_RT window for v6.18. The following three patches
> > have been merged as of v7.1-rc1 and are the missing pieces.
> > 
> > I've been asked by people if it would be possible to include them in the
> > stable tree as it would make their life easier.
> 
> Why can't the -rt patchset just include these?  Why put the burden on
> us?

It is part of the -rt patchset. I've been asked if it would be possible
to include it (ARM support) as part of -stable tree. I've been looking
at what is missing and it included two Kconfig changes and one code
change. This looked small so I thought maybe, why not let's ask. I'm
sorry if it looked other than asking.

If this puts burden on you and it does not qualify for a stable change
then it can't be included.

> thanks,
> 
> greg k-h

Sebastian
