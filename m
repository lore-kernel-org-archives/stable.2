Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAD535DA43
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 04:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785124834; cv=none; b=at31SFc/7enHrlDfM5Q3CjZwYlo9Ixol4kbLYyxdaK9xReRj77I+mv9DjuGfP8QJJwZNSPY6vd5mNpYgTANOnSIyZ6qfO1yNHERdgP+Je+aakXixPDzwUJ4FqqnONxDytJ6tk/NKpDWmDkZQWhqLw7m6twUWZSXcVJkCqNenmqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785124834; c=relaxed/simple;
	bh=ItIBMm0ZHiehEa1XFbU9/tuXKWtpOMmM4NW1t7EZ0Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5FHZ5V1LKBcY4r1dqDoGwfIaocYgKpuav1sWIb9Qk2Yf0y1Jeqv5FPiLX5dLXO1HFuhlB+bsqN7umXlD/eXrWekwrFUlNb/Et3uFV2ZLn0SbGyM+PQZ7/W5A1T/48R6IqJiHNFQl1Vsap0n+zARe/IFFjtySJlM0oyUDG9+YsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v/S8fo9d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v/S8fo9d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BFE1F000E9;
	Mon, 27 Jul 2026 04:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785124832;
	bh=HNmuNRDOV1CKRYncOr3uGKc2JhN33vE7T+sxZG2hPKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=v/S8fo9dI2u0e0aQkxWnZchRESBpa1u8qQEzr8b+z+S6SbxGK/QfsgtcZP/u21/+R
	 gcNo3V6uhsCbaGdFnd2+l5KZGiAI11ABphpj8LmErJAU7H2PP/X8t3Yeel0z4+Sy8a
	 Xg8Blsbe1tdRYVQFzD1LKnJun4LI2d9kQ6kOhbQw=
Date: Mon, 27 Jul 2026 05:59:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH net 03/19] can: raw: add locking for raw flags bitfield
Message-ID: <2026072716-blurt-trickle-b2ef@gregkh>
References: <20260716155528.809908-1-mkl@pengutronix.de>
 <20260716155528.809908-4-mkl@pengutronix.de>
 <0f3b44bc-41bd-446a-bceb-bb2c9581ee6b@hartkopp.net>
 <2026072653-handheld-reliable-4a78@gregkh>
 <918a5842-9649-4c13-9291-f06fb3fa2910@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <918a5842-9649-4c13-9291-f06fb3fa2910@hartkopp.net>

On Sun, Jul 26, 2026 at 09:45:09PM +0200, Oliver Hartkopp wrote:
> 
> 
> On 26.07.26 13:17, Greg KH wrote:
> > On Sun, Jul 26, 2026 at 10:08:52AM +0200, Oliver Hartkopp wrote:
> > > Upstream commit 1e5185c090589f4146d728ab36417d8a5419f127
> > > 
> > > is missing in stable.
> > 
> > Which stable?  And why wasn't this tagged for stable inclusion to start
> > with?
> 
> This patch fixes commit 890e5198a6e5b238627c245fafea1a92670a86cd ("can: raw:
> use bitfields to store flags in struct raw_sock") introduced in 6.18:
> 
> $ git tag --contains 890e5198a6e5b238627c245fafea1a92670a86cd | head -1
> v6.18
> 
> So it would be needed for 6.18 and never.
> 
> I thought the tag
> 
> Fixes: 890e5198a6e5 ("can: raw: use bitfields to store flags in struct
> raw_sock")
> 
> would automatically tag this patch for stable with AUTOSEL.

Never rely on AUTOSEL if you know you want a patch merged, please just
follow the documentation for how to get a stable patch merged:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

thanks,

greg k-h
