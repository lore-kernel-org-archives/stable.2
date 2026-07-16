Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A9732AABC;
	Thu, 16 Jul 2026 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212519; cv=none; b=S/kGr7r7dgc3UGfoPWYvRg1PjwY6blYYDmUPD7Hkh75ickPUIlxl/npoQZPMjlu7HJqj8A5KVVbbpJZa6NV24ogfYPgj1irDWA4R5E3Ta1CXAzQAsbPa4qLdfwABZkTbhILKHfun2vBbHBopiBJgLIABy0cO0ivpP2ot/q9FXG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212519; c=relaxed/simple;
	bh=tI6eGVujEQz+se3/5kUt9v2hbjwpTGiGm/4kqsAnpFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHeoSL9/VgWLX+3BOGol3V8NnqPO7Y6Uwcb7L/OpvYHhUlmK9SGVlatGIYu8jNB7KxdrNXv55hw1p7OMVWf/afaplhTXnSbYdIVRZihYX1i0hNIWr08g9uTjkvrcOylGq9u7cjJKAJ5quKkTyj1pgDL/yPZorZODF7OJPrikFyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R8GYxoeh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R8GYxoeh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F7B1F00A3A;
	Thu, 16 Jul 2026 14:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784212518;
	bh=WfYOXDPVJiDhZJzHJ60q7OH+ShSGL2GD7yqQK0LSNDo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R8GYxoehJNGuBKNmeMP56ejtqddJgB27Hr+tTV5wm2kInCEgLnLaiw3tbdj+hXmLw
	 6flGOeeBmnwG5PSS/ZzHJp75n5GdjtlpICxIU2wrh9SvN2znRz8mQejh5urx2Rc+Q8
	 tWtsWws5tRdUpoOy1YeSVUuaM4TOREYKf4kMwk+c=
Date: Thu, 16 Jul 2026 15:35:24 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Wongi Lee <qw3rtyp0@gmail.com>, stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jungwoo Lee <jwlee2217@gmail.com>
Subject: Re: Please apply 736b380e28d0 and eca856950f7c down to 6.1.y
Message-ID: <2026071658-marigold-native-a83f@gregkh>
References: <ajuR7rZYU943EG6p@DESKTOP-19IMU7U.localdomain>
 <2026062417-conceal-driving-0ebd@gregkh>
 <ajujm9+82N1g/HgF@DESKTOP-19IMU7U.localdomain>
 <2026062416-amulet-paradox-cf7c@gregkh>
 <ajum4HXbhgdRl6Vz@DESKTOP-19IMU7U.localdomain>
 <akJ9gzZrhXMUomcg@eldamar.lan>
 <aljSrJ_4uwHERDHk@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aljSrJ_4uwHERDHk@eldamar.lan>

On Thu, Jul 16, 2026 at 02:46:36PM +0200, Salvatore Bonaccorso wrote:
> Hi Greg,
> 
> On Mon, Jun 29, 2026 at 04:13:23PM +0200, Salvatore Bonaccorso wrote:
> > Hi Greg,
> > 
> > On Wed, Jun 24, 2026 at 06:44:00PM +0900, Wongi Lee wrote:
> > > On Wed, Jun 24, 2026 at 11:37:29AM +0200, Greg Kroah-Hartman wrote:
> > > > On Wed, Jun 24, 2026 at 06:30:03PM +0900, Wongi Lee wrote:
> > > > > On Wed, Jun 24, 2026 at 11:00:45AM +0200, Greg Kroah-Hartman wrote:
> > > > > > On Wed, Jun 24, 2026 at 05:14:38PM +0900, Wongi Lee wrote:
> > > > > > > Hi,
> > > > > > > 
> > > > > > > Could the following upstream commits be queued for the active stable
> > > > > > > trees?
> > > > > > > 
> > > > > > >   commit 736b380e28d0480c7bc3e022f1950f31fe53a7c5
> > > > > > >   ("ipv6: account for fraggap on the paged allocation path")
> > > > > > 
> > > > > > I do not see that commit id in Linus's tree, are you sure it is correct?
> > > > > > 
> > > > > > >   commit eca856950f7cb1a221e02b99d758409f2c5cec42
> > > > > > >   ("ipv4: account for fraggap on the paged allocation path")
> > > > > > 
> > > > > > Same here, no id of that one in Linus's tree that I can see.
> > > > > > 
> > > > > > thanks,
> > > > > > 
> > > > > > greg k-h
> > > > > 
> > > > > 
> > > > > Hi Greg,
> > > > > 
> > > > > First, sorry for confusing you.
> > > > > 
> > > > > The commit IDs are from netdev/net.git:
> > > > > 
> > > > >   736b380e28d0480c7bc3e022f1950f31fe53a7c5
> > > > >   https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=736b380e28d0
> > > > > 
> > > > >   eca856950f7cb1a221e02b99d758409f2c5cec42
> > > > >   https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=eca856950f7c
> > > > > 
> > > > > They were applied to netdev without Cc: stable@vger.kernel.org, so I
> > > > > wanted to flag them for stable handling but I send it too fast (before
> > > > > merge).
> > > > > 
> > > > > I will resend the request with the Linus tree commit ID.
> > > > 
> > > > They have to be in Linus's tree, before we can take them in a stable
> > > > release, right?
> > > > 
> > > > And why were they not originally tagged with the cc: stable?  That would
> > > > save you time in the future as it would all just happen automatically.
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > Right, my fault.
> > > 
> > > Also I just forgot cc'ing stable when sending it. I'll apply it next time.
> > 
> > Small heads-up: Both commits are now in Linus' tree and included in
> > v7.2-rc1:
> > 
> > $ git describe --contains 736b380e28d0480c7bc3e022f1950f31fe53a7c5
> > v7.2-rc1~29^2~66^2
> > $ git describe --contains eca856950f7cb1a221e02b99d758409f2c5cec42
> > v7.2-rc1~29^2~66^2~1
> > 
> > Can you queue those as needed down to the 6.1.y stable series?
> 
> Can you still pick this as well for 6.1.y? The upstream commit
> eca856950f7cb1a221e02b99d758409f2c5cec42 does not apply cleanly to
> 6.1.y but this is just because it deletes a comment (the second hunk),
> which was never added to 6.1.y.

Now applied, thanks.

greg k-h
