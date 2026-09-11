Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A544229C6;
	Fri, 11 Sep 2026 06:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789109845; cv=none; b=YOZkdo5mh8MfS97KW+peBw97Q0PQpmZ3VUvPrPYVvQRVQFqK04Gjzn+2x2YP+W3LUVcIuIxtJ0C9+j7eBCKBudN9wlzy7takMcMz4H3ZC7ojOGG2M06aK/k25GLi5Fn280i31w3plFyJWJJMOM50IxS482i7O72c3J3XIsThspc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789109845; c=relaxed/simple;
	bh=3FHblAIpEe2pH53Ki8NE7YjEhXnvNEZgnHFyAWnhQbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVAAKaeitEuCGX1BXFf6ewMsJ+CJ3k9ha0RXlqN+qon8NFb/6jDKRyNKHTXq7DHLchZKFKlLyUPVpyKK435lQzqL00dEn7LAi6A8e2PohsoNtFWYG7XQkHJ/W13ZSwuGdal/XURyLoZ3puPJRcapjv4fIvgsrD5dIwLZzCQlRhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QmU6Spaa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmU6Spaa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5711F000FF;
	Fri, 11 Sep 2026 06:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789109824;
	bh=etTCAHWL2Mqig7zEniean6L3g438j4hu4Z+A2495nqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QmU6SpaayhcVaxjer/+RnevHt+j0L2x22eoqyRrAoi3fUX1Q83nKgL5KLkR1MQNGD
	 Mhz/BnZWT8IKbc3YH4P4+JZaVeSHvsXHjRue7+KeQ+j/Ai6K3X59tfslqhtPMcEx4d
	 MbJzUXio+hONMNkADQL65QPVcIByRpbNgGYTblBX0xyj4YeSKNHouq9KgEIMwRjMpV
	 Wf7t9+KWfiOiY+81ZsFAY8Mc/FJlp9wap435IByxWinGmrsFMh2qQ28ehv0SPPD+qa
	 uRhnGq2mL+omCkyQTIrwUSDZrf+eG6VRuw/QFwEBP8vdDNhyYN8XpEdRw3J7MCGkWp
	 RZsIYb1IueVKg==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x4vC1-00000002pQT-3BhS;
	Fri, 11 Sep 2026 08:57:01 +0200
Date: Fri, 11 Sep 2026 08:57:01 +0200
From: Johan Hovold <johan@kernel.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: cdc-acm: fix racy TIOCMIWAIT implementation
Message-ID: <aqOmPYE84n78GaYg@hovoldconsulting.com>
References: <ap56NTVMq8GlbjmR@hovoldconsulting.com>
 <72615ee3-46eb-4639-a408-ba29c1235d08@suse.com>
 <ap6LcHWDvIWF3oNK@hovoldconsulting.com>
 <bc055887-3029-4740-bec5-7e2fe4205992@suse.com>
 <ap6iJ6vkVIaxXFwn@hovoldconsulting.com>
 <f642f815-df4f-473b-aaa2-89153c08bc05@suse.com>
 <ap62IbbQti28M_SA@hovoldconsulting.com>
 <a9db0fce-2a2d-4896-a3c3-2afff4080168@suse.com>
 <ap-1YzIoyYsH_3V-@hovoldconsulting.com>
 <871c61a0-3834-4d58-a69b-96ddd3593873@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871c61a0-3834-4d58-a69b-96ddd3593873@suse.com>

On Tue, Sep 08, 2026 at 11:23:38AM +0200, Oliver Neukum wrote:
> On 08.09.26 09:12, Johan Hovold wrote:

> > I sent a v2 yesterday that should take care of it all:
> > 
> > 	https://lore.kernel.org/all/20260907095130.130636-1-johan@kernel.org/
> 
> Thank you. I misinterpreted your intent. Sorry.
> 
> I am afraid that patch has a few weaknesses.
> 
> 1. It mixes changes to measuring the old count and to how the sleeping works

It could possibly be split in two (i.e. my v1 + a separate change to
drop the old count), but the commit fixes the "racy tiocmiwait
implementation" and all of these races were there from the start. So it
does not seem necessary to break it up.

> 2. If you want to change the logic at all, then we have a first check for changes
> that is almost sure to fail.
>
> It seems to me that if you are going to touch the logic there at all, the
> sensible order of actions in the loop would be
> 
> A - check for signals
> B - schedule
> C - check for changes
> 
> That way we
> 
> i   - avoid calling into the scheduler if signals are pending
> ii  - avoid returning -ERESTARTSYS if we have a result we can report

This would be further changes to the current behaviour, which is also
reflected in serial core. Can possibly be done on top.

> iii - avoid rechecking for changes after only a few dozen cycles
> We have an inherent race against the hardware. The chance that we don't
> have to sleep is essentially zero.

Sure, but the code is more readable this way with a standard wait loop
(and it highlights the limitations of the interface).

Johan
