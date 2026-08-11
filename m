Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6202442C4FD;
	Tue, 11 Aug 2026 12:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450776; cv=none; b=s7VInrAmNeF2SEjPZKc3D4JvPQDLOUNdaozQ4/B3PoD0LNXoeWjraXYPOUwuNjXQkMkV/A36wwNkCoiXqSfaLp1o+SjpOAD2mTA1d4kzAdU+hY1OcxL0o5WNklLqvRkNsEwmCNJ1k5CuBcY82ZkjCyKUsEhztGbsz609QbLVC04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450776; c=relaxed/simple;
	bh=Voo+xHiqStdf7jWqXarHAA5e6PJ0l+BkgVLL81UVa74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wmf+/Q2bP05ps1q15oEfBTANRSibMuyPWKnzw02AtUEseoMhaEEr2XVmnlLU3m19VWFLCqDUqVqcMU+Nc8mdp/8fuOQfy7fMb/oUrI5GCxkth0i0jNr7QcaZI3ZDnhlfVF08kbt1Jq5YrZK+sD32cw2XMY0BB9U9MyWHi1XFyF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=n+Ha9kuK; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="n+Ha9kuK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+8W/d4LLQlVbQzfhZQzzBkGEKOaKtd2XQFHx2OVMtQQ=; b=n+Ha9kuK2XrU/ZaBNtrQPiha6n
	WTa6+7qzIoVWZTK5MVlDFNjylEB/MQO/Jo2CenNwNRlrFrBBh0yQKwtHivbqECEHD9lV8VZnr0KAO
	kgGkwOpbqalZRDoDIVGPchyoVAItq79GPMkyoWH3+v7RtR9l4WYpBbrv3W7/sCLOeO8TBCM2CK3Xn
	476/IfkQhdMHZ/aub6vV7JNU+W+3f3G6TkSCo9TaKwM9adYmdn9Xf8yDl27Y4qbtpjBsSwS/aw8lD
	xyghtSo4BpynLA3aVf9LWZkukmpR7ZKOLLixAwqVoZuQ/3vhrv3Q24OqFsw3V2TM2Hek7nQgH/hyG
	5AuPDkYA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wtlRz-003Yd3-0Y;
	Tue, 11 Aug 2026 12:19:23 +0000
Date: Tue, 11 Aug 2026 05:19:17 -0700
From: Breno Leitao <leitao@debian.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] ipv4: mcast: getsockopt: do not overwrite past
 optlen
Message-ID: <ansQ8gHcKdS_Q_ji@gmail.com>
References: <20260806-mcast_fix-v1-0-bed0a5518e57@debian.org>
 <20260806-mcast_fix-v1-1-bed0a5518e57@debian.org>
 <20260807174402.2dfc12d6@pumpkin>
 <anm9gImFEz6EkUZ9@gmail.com>
 <20260810222159.409357fa@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810222159.409357fa@pumpkin>
X-Debian-User: leitao

On Mon, Aug 10, 2026 at 10:21:59PM +0100, David Laight wrote:
> > You are saying that we have userspace program in the wild that doesn't honour
> > the contract above, right?
>
> I've just looked at the old history, since the code was added in 2.4.22 'optlen'
> has only needed to be the size of the fixed structure on entry and has been
> been updated to be the total size on exit.
> The maximum size of the buffer comes from its sl_count field.
> Code that doesn't use the glibc wrapper could be relying on it.
>
> There were definitely places where the driver code has traditionally not
> checked the length at all - and userspace wouldn't have set it.
> The last might have been in the decnet code.
> I'm pretty sure there are other places where the length provided to getsockopt()
> is only that of the fixed header, variable data then follows the header.
>
> IIRC there is a recently added one for async io.
> Can't remember where.
> It checks the 'header' size and takes the full length from within the header.
> That one definitely requires (and checks) for the short length.

Right, but I want to back up and figure out whether this is a bug that
should be fixed, or a bug that would break userpsace if we fix it.

I'm saying the kernel shouldn't write past optlen. If userspace
doesn't provide a big enough buffer, it shouldn't assume there is one
behind it to write into.

Looking at the existing users, I haven't found any that pass a smaller
optlen than needed, so I don't see anyone being impacted.

On the other hand, you're saying this is how it has always behaved
and there is userspace out there relying on it, so changing it now
would break things, right?

Depending on the answer, we have two paths ahead:

1) We declare these bugs and fix them, and proceed with sanity
2) We need to implement quirks in the getsockopt, which will resize
   "optlen" mid-air by looking at headers fields

So my question to you: can you point me to actual software that
passes a "small" optlen and expects the kernel to write past it? That
would help to decide about the two options above.

Thanks,
--breno

