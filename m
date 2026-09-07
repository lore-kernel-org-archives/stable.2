Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD71455173;
	Mon,  7 Sep 2026 10:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788775283; cv=none; b=QawtqK97fAn3fVnwkHLCGKRYL1cicbUw7ekz/LA3vLBQFPh59q/GyGBs/CqoYl6gccd53JRslDK18vDTaNClivm8wacGg6qtyYfDjekA/Op3QrBpc+H/clx8wrP70peQ6uSA4Xy5njgTtZ25OUDh3mps08yeMq8gBXJHt9ApTpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788775283; c=relaxed/simple;
	bh=/fSsiqKj3k/kIzDtr2yip2SiXGA8j/AI3EvzsklzrZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvFfZEd/BBiA0qqAdE/G3H1i/NYkSwtwDmAxQmDFPoJNXUJ7xEtBzdpaXp3YTfdnxNx8EWS+EYeLzpxQVGR8vcdg9xGcobAxgDDfibfYt1M/N8M9pMalwo53hPuu0Wcrx3zTKR7cew3zf5f9iZH8qsbSz9qPUXrNIlpO+bC0GOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dcKAP4ba; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dcKAP4ba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 601921F00A3A;
	Mon,  7 Sep 2026 10:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788775282;
	bh=MrzkdFyLsg8VSci/26jo62CvSvmhxQiUSnpAWUUjNQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dcKAP4bahn6xer7l9tZ2cgYBBM8vYOIbXeoi9FSczUIsQXp5igKDV+tapAr+rKLjT
	 dkQOn14JthQ0afts9hejvMrdnZ16KpUWESG3A6Q/ObvzvLdpnf8rZT1ka28dxb7Gdz
	 onl0TOpullaZ9HOizg5TleHotFjXziQYGOHzKJ2benAIeLHV4cUTUc6YvlENSuXrN3
	 nA0k1gdH7IwZ7JK8F8cmlkPhllDvSBnKA4hpMWjU5xu3GeLNm0cxIRWq9XBi2+0mY+
	 Ct0RudmeFzNYvdxpAqOT3IfWwS85V7XR+SQ53kouAHy7IwEpkQBp70VqNYtOW1CtrV
	 bxEUgaDiHz0sA==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x3WAC-00000000Y9p-0tfh;
	Mon, 07 Sep 2026 12:01:20 +0200
Date: Mon, 7 Sep 2026 12:01:20 +0200
From: Johan Hovold <johan@kernel.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: cdc-acm: fix racy TIOCMIWAIT implementation
Message-ID: <ap6LcHWDvIWF3oNK@hovoldconsulting.com>
References: <20260907065501.101013-1-johan@kernel.org>
 <e231a7e9-7aa9-40ea-8ac6-57855b4ac811@suse.com>
 <ap56NTVMq8GlbjmR@hovoldconsulting.com>
 <72615ee3-46eb-4639-a408-ba29c1235d08@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72615ee3-46eb-4639-a408-ba29c1235d08@suse.com>

On Mon, Sep 07, 2026 at 11:50:41AM +0200, Oliver Neukum wrote:
> On 07.09.26 10:47, Johan Hovold wrote:
> > On Mon, Sep 07, 2026 at 10:17:38AM +0200, Oliver Neukum wrote:
> >> On 07.09.26 08:55, Johan Hovold wrote:
> >>> The wakeup condition needs to be checked after adding the task to the
> >>> waitqueue and updating the task state to avoid missing a racing modem
> >>> status update or disconnect.
> >>
> >> I am sorry, but in this case I have to ask:
> >> Isn't TIOCMIWAIT inherently racy against the hardware?
> > 
> > What do you mean?
> 
> The interface does not state from or to which state it changed.
> Now you could say that it is implicitly the last time TIOCMGET
> was called, but that is
> 
> 1. not clearly stated
> 2. not enforceable

Right. The original implementation (and serial core) have always stored
the counters on entry and compared to that. So that is the defacto
semantics.

> > Looking at the implementation again now, it seems further changes are
> > needed to fix the implementation, though. The completion handler should
> > not be updating old_count. That's for each TIOCMIWAIT to do.
> 
> I am sorry to be obnoxious about that, but I am afraid that would
> break TIOCGICOUNT

Why do you think so? TIOCGICOUNT just returns the current counters.

Johan
