Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794170174;
	b=3IWyVsQDf870gew3mW+Egd6phHt4PyG2BJSlLz6KF4JNsYT+kUgsdtoyXKsZBvED9Urd
	 msJnH/f8o8ngkyEo9iXhYuFyg5dzpnh73LtQi1HuIWlgz85HGCuEISg2xUBJkDR2otcRg
	 ajHgIwSODt5r280cBktF/lF+eDemYPGLVshsK0B69pj7sdYKKykLlyMGdZTneNDj24gcq
	 bVfs74pa0Q+nYdQaQF8MZjovexNT3Fhw/PLpofIIS04IIGRldy1qFg/vCZ4zcAgBEPMXM
	 x4oLq4wDBa5y79HIC2zW5oThURR8Bv88I9od00s34FG7OuDjOpZ7/CMNRjc1MC1PFsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794170174;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6SJM0ngoDq0bBIILBZZXnXuX0hTy0w2UcXjsd4RO6IY=;
	b=rPp64S4tJNC0RlrWhWLZcTo3ck2HjldNiEMVEichfaPP+OkhIT7zyeheqiIP5a0zkK7b
	 RAsRLE9kJu8UrfB2WgBzxgqJRTC9I/eATdQYyiGVN/Tzegm/jFZTLBIsiKV0Z0e+MtjjQ
	 MNAr8CJkmmFO+njOIm5KVRNkvQDIudslEGGOEqEZfpfQpyO+lSFwlPDefRfDlHkr4EI3s
	 8NEKUQ3IPTKVV6q7sife296eq2A3WHhtm+XL77T5nYK0/K8JgV5arc/I4Dzs1G6xfZQ48
	 6f2KeyyffejmcpfGdSOqYGklP3L/ewXgSt8OxOvfB84Ax/WhTXQAPDT8TXdSbIOLw0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aHyYDJii;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C143C606A33C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 20:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aHyYDJii
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D871F008A6;
	Sun,  8 Nov 2026 20:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794170173;
	bh=6SJM0ngoDq0bBIILBZZXnXuX0hTy0w2UcXjsd4RO6IY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aHyYDJiibqoPE1OG66Hc7Rnm+YVqXajTwIhMjIqRgxmoalwFzUdSdHMERodAvB8qv
	 n2rpf7B5B6rkxZG4qrVn/ygLnQShFSOe9Vhwtk/tqBLzddwgY3slbiPT0pA+qwaruk
	 cRAsvzauQGCANi/x2p3EOfeAniY08ofLQcrEWPZ5oX/88uA+5T9eP4P3lS7PVrghr2
	 qePLShoatiiLhEQAsBKGVk589HG3YQO8t/n1OQkKei1y298xAUq/07IkQ3WrAGP4DD
	 vMsNEd/MHHR9kJBOdWOM9WwoPdq1b/Blsocno5AbaNqmEUa8F/H59zjldk/cuBFYmD
	 OIvN7pN8JoZdg==
Date: Sun, 8 Nov 2026 12:36:12 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Greg KH <greg@kroah.com>
Cc: Sasha Levin <sashal@kernel.org>, aalbersh@kernel.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] fsverity: Explicitly require FMODE_READ
 to retrieve hashes" failed to apply to 6.18-stable tree
Message-ID: <20261108203612.GA3277@sol>
References: <20261107051544-failed-6.18-1acb4fd2d011@kernel.org>
 <20261107190447.GA6049@quark>
 <au-Ux9Sunxhat_jo@laps>
 <20261107212633.GA137269@quark>
 <2026110824-steerable-unopened-a5d8@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026110824-steerable-unopened-a5d8@gregkh>

On Sun, Nov 08, 2026 at 08:47:35AM -0500, Greg KH wrote:
> On Sat, Nov 07, 2026 at 01:26:33PM -0800, Eric Biggers wrote:
> > On Sat, Nov 07, 2026 at 04:14:47PM -0500, Sasha Levin wrote:
> > > So I feel we have had the Cc discussion quite a few times now. We really have
> > > to limit how many mails end up going out: this last release had thousands of
> > > mails which took hours to send. Adding more lists will simply kill the mail
> > > server and will harm everyone.
> > > 
> > > We have solutions for that!
> > > 
> > > See Konstantin's writeup[1] about lei with filters like dfn: or dfhh:.
> > > 
> > > We're not going to change this on our end: the kernel.org folks will complain,
> > > mails will take days, and people will be grumpy at us.
> > > 
> > > If this is really not something you can work around, then we can figure out a
> > > filter to exclude your patches so that all of us can continue being happy going
> > > forward.
> > > 
> > > 
> > > [1] https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started
> > 
> > I've already started to use lei to work around this issue with the
> > stable process, but everyone else will as well, which seems unlikely to
> > work well.  This also effectively means that subsystem mailing lists are
> > deprecated, as some of the development process is happening off-list.
> 
> No, all of the people involved in the patch that failed is copied.  It's
> very odd that people who are not on the s-o-b chain would want to get
> notice that a patch did not apply.

No, it's not odd at all.  Same reason we have subsystem mailing lists at
all: Linux kernel development is a collaborative process and lots of
people are involved, not just the people in MAINTAINERS (who also change
over time, may be unresponsive, go on vacation, etc.).  Just because
someone doesn't have a tag on a commit doesn't mean they weren't
involved or don't need to know about it.  We need to catch regressions
and missed backports, and failing to Cc the subsystem list is a very bad
start as then some of the people best able to help are left in the dark
unless they happen to take the time to use the lei workaround.

- Eric
