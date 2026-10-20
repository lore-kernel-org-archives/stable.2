Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792454643;
	b=bpdqaFO2+o21jaUZ25vRmSn6WTHwYMAPB2/+b2aOyK27QRfNdxlgweQFCbL24n87+YBE
	 i2+33AfrmrkogHUukraeHUMMo6cHvUAmwAswMNDa2TnB9OS2NjES3/h5ZYdOuX65UEwSk
	 f+m7hVMIdfHFze2ptp95MkTRvqKyGfifQWvsaHXS0GfiDjZ8zr/zsC/Xsk7fjLK8uNVaY
	 /dlqqSgNGSHjtwn1p2NQbLf4MtgbdvbVXRyS90TCh/3wLb/nmXwmcJ+WYZfLPRt85ujmo
	 jGWERfeUzgjaMW7PxH4MzlKDVOaXKXPv3GvrnvA+wyxhbZpC04Q2J7BXL8Kv7XaSt4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792454643;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=axWZMFPByvKkMjH761qPv3ERo7QtLegoffOTCWE/MZM=;
	b=KmQ1Bk7lxnl2wjN++gFPhVJz0xMse9toSbHyNUKVAnH6OgNHbd5TksvYDBYOTfAXG0nc
	 gnpu8fpQ8r55a93mJxrsJyUhjGTfuthdRTxrx6QL7CgM4fKIJFBzSA1NYn9GwyGZF6U26
	 TArlMrdpHe4Q59cQt2NDkfkgiE/BwNDAi5ul3d3P2QQM/Mx8iVqwUeR2nqrMbZ/Pun+7B
	 vYhqpMoExVqBMNFQHcWg6xNukYQ6x5j4aIUW4ZZBjDu5iaOpCmBQdNaEdu4xycGGEMxWA
	 FxTb+TuEcVEdcL0vl7U/ata+g4jXHs3nQrHg7tnoRg3YP2jndSXa5fS28+YCmRFswyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TSJHBpB4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id F362C606A31C;
	Tue, 20 Oct 2026 00:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TSJHBpB4
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 386591F000C4;
	Tue, 20 Oct 2026 00:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792454642;
	bh=axWZMFPByvKkMjH761qPv3ERo7QtLegoffOTCWE/MZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TSJHBpB4snJpTVDfTts1K88oTZPA8YWSm/jcGUk+Swu5Os3dAm+XMnxVaEdb5SadJ
	 on48fkTo/2sLnAwGZ/rfsI/95nr4vbi7oRVyMm09nQ6W7qss8zpkrFoAuc4r60HAtp
	 LPmlNOAh4AnRebQNCCiqWrW/f2jJheHhIU1KiN4iHqhqmMn5u6yBu07jEu7z50b6e2
	 Z/iQTMptSup0+3xwT3ENKVAu7fM9OQEe1kBr4CqqH8VsCyb/ufkzAzXoy8N5DVSyEv
	 YXCzKQTOgTLuovGbBPkAu5Bgk8jCSaVaoapENn+xhAdfofyYIA18NQu/fSClYKfFpF
	 S/RpEHVNDe3jA==
Date: Tue, 20 Oct 2026 03:03:58 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] KEYS: Reject @datalen values over INT_MAX
Message-ID: <atav7khL0C0mAFf2@kernel.org>
References: <20261019181732.449591-1-jarkko@kernel.org>
 <20261019181732.449591-6-jarkko@kernel.org>
 <20261019193148.GE65095@quark>
 <ataGlDBhDaHsLT_q@kernel.org>
 <atat-Td-fEPQq3c0@kernel.org>
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
In-Reply-To: <atat-Td-fEPQq3c0@kernel.org>

On Tue, Oct 20, 2026 at 02:55:41AM +0300, Jarkko Sakkinen wrote:
> On Tue, Oct 20, 2026 at 12:07:32AM +0300, Jarkko Sakkinen wrote:
> > On Mon, Oct 19, 2026 at 12:31:48PM -0700, Eric Biggers wrote:
> > > On Mon, Oct 19, 2026 at 09:17:25PM +0300, Jarkko Sakkinen wrote:
> > > > Protect quota from overflowing by rejecting @datalen values that
> > > > surpass over INT_MAX.
> > > 
> > > Is there an example of how this can happen, and why the limit needs to
> > > still be so large?  add_key() for example limits the payload length to
> > > 1 MiB.
> > 
> > I did a bit scavenging, and to my knowleddge, no. So I would retain
> > this as safety measure but would not consider it as a bug fix.
> 
> While it is true that add_key() has 1 MiB limit there's also
> root quota. That was what I was originally thinking about
> now that I scratched my head a bit.
> 
> But...
> 
> However, it is capped by /proc/sys/kernel/keys/root_maxbytes, 
> SYSCTL_INT_MAX already.
> 
> So that makes the check this patch adds irrelevant, and thus
> it should be dropped.
> 
> Phew... At least it is now investigated in-depth enough, I
> think.

This also makes the other safe-guard useless, so I'll drop
that too.

And likely expand the patch set to address the entry points
that you mentioned.

Br, Jarkko
