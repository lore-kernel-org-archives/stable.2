Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECD930CDB6;
	Thu, 16 Jul 2026 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206010; cv=none; b=Tw/fO0ArF2zSM9lDR/IDem5TV2xpS5TDQdfbKyAwIrtAf0QZiakEw9GNkStXwafpe3gEb3kA4LOwjjfk7JFG/aM5DilfG+mKtdnvmYhP1mVzmrqNOw9oIQ+R4zx+1yswZnqJx+12iHx4aJ8/qlJq2Y2h6KT6RvoemKmfWoB338c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206010; c=relaxed/simple;
	bh=C7eFu3o0rtA9FRnDZW57qaLyWeEqocxv5Iv3vkbnPKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smDwFFRdX2DmzyXmrTXJsKRBeVwvw/VkLkq4YtRNveGoz/M4jYbZenRbUvIBjNIYH6ZwiCzQ6bAEFlkoNRRKCkZ05v8E5exKf7ob0fTahjYb8ueDTpo+wgGrF5DFxT5hTJQUyZ4JH93QiMGbW0UP7KzdrTrD20PMhG/i/o6ECvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=qiPpLp/z; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="qiPpLp/z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mripG43T9ZFUsT23WmUADzfv36/a0ORrux6eYEt8qjM=; b=qiPpLp/z+4rvLi7e9hwy41WdTq
	bCnprbrgS1hgG0x+lHqui7Ta/3KCSz5KcRqBY8J2+XGNGUHrm5dI2f3r5Zu8oERUy3+pxIU/wJYqF
	dwgVq2YZLKL50hV//0f27NUKLTX8RbAhRpY/cW/ToGeFhwWUlg4U7bPCDAF5yuWmQm3pIjkBd2KiM
	JKkzfw6axk2sy/ZH1L7v0+m4LewunxGgOcsWXcZrIvl9hPTMjORRL8XzREquu/m42HUy6d6Mi28Pm
	IGtDoNEutEagm4WDf4E5kk3CxZLio2TSZWvvZtgWGMAGDtAB3yY6wCpvhFrwAWSS6gvaJG2dSQQDn
	pYrY0oRw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <carnil@debian.org>)
	id 1wkLU6-003pZu-12;
	Thu, 16 Jul 2026 12:46:38 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 2C8D5BE2EE7; Thu, 16 Jul 2026 14:46:36 +0200 (CEST)
Date: Thu, 16 Jul 2026 14:46:36 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Wongi Lee <qw3rtyp0@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jungwoo Lee <jwlee2217@gmail.com>
Subject: Re: Please apply 736b380e28d0 and eca856950f7c down to 6.1.y
Message-ID: <aljSrJ_4uwHERDHk@eldamar.lan>
References: <ajuR7rZYU943EG6p@DESKTOP-19IMU7U.localdomain>
 <2026062417-conceal-driving-0ebd@gregkh>
 <ajujm9+82N1g/HgF@DESKTOP-19IMU7U.localdomain>
 <2026062416-amulet-paradox-cf7c@gregkh>
 <ajum4HXbhgdRl6Vz@DESKTOP-19IMU7U.localdomain>
 <akJ9gzZrhXMUomcg@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akJ9gzZrhXMUomcg@eldamar.lan>
X-Debian-User: carnil

Hi Greg,

On Mon, Jun 29, 2026 at 04:13:23PM +0200, Salvatore Bonaccorso wrote:
> Hi Greg,
> 
> On Wed, Jun 24, 2026 at 06:44:00PM +0900, Wongi Lee wrote:
> > On Wed, Jun 24, 2026 at 11:37:29AM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Jun 24, 2026 at 06:30:03PM +0900, Wongi Lee wrote:
> > > > On Wed, Jun 24, 2026 at 11:00:45AM +0200, Greg Kroah-Hartman wrote:
> > > > > On Wed, Jun 24, 2026 at 05:14:38PM +0900, Wongi Lee wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > Could the following upstream commits be queued for the active stable
> > > > > > trees?
> > > > > > 
> > > > > >   commit 736b380e28d0480c7bc3e022f1950f31fe53a7c5
> > > > > >   ("ipv6: account for fraggap on the paged allocation path")
> > > > > 
> > > > > I do not see that commit id in Linus's tree, are you sure it is correct?
> > > > > 
> > > > > >   commit eca856950f7cb1a221e02b99d758409f2c5cec42
> > > > > >   ("ipv4: account for fraggap on the paged allocation path")
> > > > > 
> > > > > Same here, no id of that one in Linus's tree that I can see.
> > > > > 
> > > > > thanks,
> > > > > 
> > > > > greg k-h
> > > > 
> > > > 
> > > > Hi Greg,
> > > > 
> > > > First, sorry for confusing you.
> > > > 
> > > > The commit IDs are from netdev/net.git:
> > > > 
> > > >   736b380e28d0480c7bc3e022f1950f31fe53a7c5
> > > >   https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=736b380e28d0
> > > > 
> > > >   eca856950f7cb1a221e02b99d758409f2c5cec42
> > > >   https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=eca856950f7c
> > > > 
> > > > They were applied to netdev without Cc: stable@vger.kernel.org, so I
> > > > wanted to flag them for stable handling but I send it too fast (before
> > > > merge).
> > > > 
> > > > I will resend the request with the Linus tree commit ID.
> > > 
> > > They have to be in Linus's tree, before we can take them in a stable
> > > release, right?
> > > 
> > > And why were they not originally tagged with the cc: stable?  That would
> > > save you time in the future as it would all just happen automatically.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > Right, my fault.
> > 
> > Also I just forgot cc'ing stable when sending it. I'll apply it next time.
> 
> Small heads-up: Both commits are now in Linus' tree and included in
> v7.2-rc1:
> 
> $ git describe --contains 736b380e28d0480c7bc3e022f1950f31fe53a7c5
> v7.2-rc1~29^2~66^2
> $ git describe --contains eca856950f7cb1a221e02b99d758409f2c5cec42
> v7.2-rc1~29^2~66^2~1
> 
> Can you queue those as needed down to the 6.1.y stable series?

Can you still pick this as well for 6.1.y? The upstream commit
eca856950f7cb1a221e02b99d758409f2c5cec42 does not apply cleanly to
6.1.y but this is just because it deletes a comment (the second hunk),
which was never added to 6.1.y.

Regards,
Salvatore
