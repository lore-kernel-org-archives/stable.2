Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4AB3BD24A
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000951; cv=none; b=V5xMScT+TT2NMHxVwJw5NiZGM+r5zQtvBUGBLVut2nGLL8LMCk/Y2g+2JofO9SCnyVw0J0mNEwks2v5POEUdY3iTXhRd13vJW0Ep1k0j8JW2+qB9qm755LRUU0+c7gcqOzX/I84POSalHKBwEX51TbvrpPO7Ww6kDy/u9rNv44E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000951; c=relaxed/simple;
	bh=VSabq/X1KSIGi03ub9aFzL2ULvmcIBEBYHFlcjWLyos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bruR4AYic3ok7JpAuNDc/CZxaGVpJcgP1awzrMfSYAvnhHhHNGce53whKbq9iSPFPWYaZuHN58iWinpieMJ095stvoG32yoJLUXja8i640EDc/3T2JtRiPLb25sbRpn8zdYyPlHISKDdOQATtOvaLmX79DVUDyviv+dJzF68puA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ULEx+z74; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ULEx+z74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF4C01F00898;
	Mon, 21 Sep 2026 14:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790000950;
	bh=3xbuSOfkEVZb3smL77G2xT77vDymlVm+Sg8C85PL77U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ULEx+z74egmEloOOSKVzLCM4s0UCD0dBghrBnvWXRVZVVbgTIYsGWjzOmIaPdeskC
	 z9DWAWN3rbb3vy5m/KR9g5kf0H0YJgjAL8H3KGrKRYgXv+oIgYpFlF9qfv6ZHvQe2S
	 xTrI6JChvpxmkO/k/TrS06pNMLM5g6OWSjFOEMvI=
Date: Mon, 21 Sep 2026 16:29:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [linux-6.6.y] 6.6.158-rc1: stale ASSERT_RTNL() in
 __ipv6_dev_mc_dec() WARNs on IPV6_LEAVE_GROUP
Message-ID: <2026092146-although-snippet-ed33@gregkh>
References: <20260921074348.GB13965@francesco-nb>
 <2026092115-magnetism-breeching-5d92@gregkh>
 <20260921142442.GA276016@francesco-nb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921142442.GA276016@francesco-nb>

On Mon, Sep 21, 2026 at 04:24:42PM +0200, Francesco Dolcini wrote:
> On Mon, Sep 21, 2026 at 02:24:41PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Sep 21, 2026 at 09:43:48AM +0200, Francesco Dolcini wrote:
> > > Hello all,
> > > 
> > > Disclaimer: the commit/root-cause analysis below was produced with LLM
> > > assistance. The failure itself is reproduced and verified by our CI/CD
> > > (LAVA on-target test).
> > > 
> > > Our CI reproducibly hits this WARN on linux-6.6.y at 02cc578650be
> > > (6.6.158-rc1), on i.MX6, when a process leaves an IPv6 multicast group
> > > (e.g. avahi-daemon around a link flap):
> > > 
> > > WARNING: CPU: 0 PID: 418 at net/ipv6/mcast.c:1013 __ipv6_dev_mc_dec+0x180/0x184 [ipv6]
> > > RTNL: assertion failed at net/ipv6/mcast.c (1013)
> > >  __ipv6_dev_mc_dec [ipv6] from ipv6_sock_mc_drop+0x144/0x240 [ipv6]
> > >  ipv6_sock_mc_drop [ipv6] from do_ipv6_setsockopt+0x92c/0x1a48 [ipv6]
> > > 
> > > Cause: 24e6c4f46cd4 ("ipv6: mcast: Don't hold RTNL for IPV6_DROP_MEMBERSHIP
> > > and MCAST_LEAVE_GROUP.", upstream 2ceb71ce7d34) is in 6.6.y and drops RTNL
> > > from ipv6_sock_mc_drop(), but its same-series sibling e01b193e0b50
> > > ("ipv6: mcast: Use in6_dev_get() in ipv6_dev_mc_dec().", stable pick
> > > 98363feee397), which removes the now-stale ASSERT_RTNL() in
> > > __ipv6_dev_mc_dec(), was not backported alongside it.
> > > 
> > > Could 98363feee39760011bd2225558c0fef9487c449f be applied to linux-6.6.y?
> > > Or the problematic commit should be dropped
> > 
> > There is no such commit id with that number in Linus's tree :(
> > Did your LLM make it up?
> 
> For sure it did ... and this is the reason I was upfront that the
> analysis is from an LLM :-(
> 
> What I know as a fact is this WARNING exist, the related folks and in Cc: and
> they can provide better guidance on what we should do (drop the patch or
> add some missing dependency).

You have the best way to test it, how about finding out what exact
commit is needed to be backported here and submit it?

thanks,

greg k-h
