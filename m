Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A8A3A16A1;
	Wed, 24 Jun 2026 09:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293927; cv=none; b=Vx9/DbmcF6xJgUSDmy2OLvBy29134w0JIuSl4fQ6Wwb+7wSxOJihLmoCQeYa3y5SnEynoobYyibb3BV94VSdUhgzzo0pnx5fOsjJhYtw7zt+5Nf2ZLpQlxW5ImXDzSRfcZsL9Sud56WfmTqqir17hIc6SBk5ZbvLk9WAHdC7+yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293927; c=relaxed/simple;
	bh=M2YMAyyrXp+m7daGRk83FBoAsgDyiLWZKk8W6zjdrnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFD3QXGxmnJz1kOL1e5SV5QgjIghs0DdZSb3gZxtlZUmKfqAGpm0H7rNY57uw9kFvkjchHreMPTWkCOpwls5xDkj0YyWoo3fyzF+gIXYe4LLjIAoQV1rnlqz8afwg4cCCwG+g+IefolSKYm5bjd1T1uGlgneghQxg8QV/GDyv4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qRFYTXnE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qRFYTXnE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF251F000E9;
	Wed, 24 Jun 2026 09:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782293921;
	bh=HwV1spafxwZqAlW6qWIVPzH+VQ8S47/INwFY5X+vW84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=qRFYTXnEJeQ7p0Il9HzB8Gcdt6GhOBhMppeXIjxMYGd+tL1swUy7Cb1xJN64rB9Wr
	 UVvR6h+Q6b1ABEjXrEYUYZK/7tTIfLLFPIbKQGeWkfyHAjLxm9lm9xSIu49S4/tpts
	 G/13VZbx20tLGL3kauIbdteRfF84AW9LalZh2W7g=
Date: Wed, 24 Jun 2026 11:37:29 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Wongi Lee <qw3rtyp0@gmail.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jungwoo Lee <jwlee2217@gmail.com>
Subject: Re: Please apply 736b380e28d0 and eca856950f7c down to 6.1.y
Message-ID: <2026062416-amulet-paradox-cf7c@gregkh>
References: <ajuR7rZYU943EG6p@DESKTOP-19IMU7U.localdomain>
 <2026062417-conceal-driving-0ebd@gregkh>
 <ajujm9+82N1g/HgF@DESKTOP-19IMU7U.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajujm9+82N1g/HgF@DESKTOP-19IMU7U.localdomain>

On Wed, Jun 24, 2026 at 06:30:03PM +0900, Wongi Lee wrote:
> On Wed, Jun 24, 2026 at 11:00:45AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Jun 24, 2026 at 05:14:38PM +0900, Wongi Lee wrote:
> > > Hi,
> > > 
> > > Could the following upstream commits be queued for the active stable
> > > trees?
> > > 
> > >   commit 736b380e28d0480c7bc3e022f1950f31fe53a7c5
> > >   ("ipv6: account for fraggap on the paged allocation path")
> > 
> > I do not see that commit id in Linus's tree, are you sure it is correct?
> > 
> > >   commit eca856950f7cb1a221e02b99d758409f2c5cec42
> > >   ("ipv4: account for fraggap on the paged allocation path")
> > 
> > Same here, no id of that one in Linus's tree that I can see.
> > 
> > thanks,
> > 
> > greg k-h
> 
> 
> Hi Greg,
> 
> First, sorry for confusing you.
> 
> The commit IDs are from netdev/net.git:
> 
>   736b380e28d0480c7bc3e022f1950f31fe53a7c5
>   https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=736b380e28d0
> 
>   eca856950f7cb1a221e02b99d758409f2c5cec42
>   https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=eca856950f7c
> 
> They were applied to netdev without Cc: stable@vger.kernel.org, so I
> wanted to flag them for stable handling but I send it too fast (before
> merge).
> 
> I will resend the request with the Linus tree commit ID.

They have to be in Linus's tree, before we can take them in a stable
release, right?

And why were they not originally tagged with the cc: stable?  That would
save you time in the future as it would all just happen automatically.

thanks,

greg k-h
