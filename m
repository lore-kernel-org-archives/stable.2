Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B0A3AE1BD
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976878; cv=none; b=eCS5oQDZsXK0faaoKKYiWGXtZZyW/naOsFvJa+YSqqgoLXbn2GvhmgXI75uNNiJJMhiFZBaHFNxnDJUyiQq3pyQWM5wddzZTzSBs4giw6Jtw7kqb/AZRDuLxRKIKD07Wtginb5vPzKfV84YYLXefmlV4zccImhegrH2cay06ieY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976878; c=relaxed/simple;
	bh=bAIMjF/OUVDMceHX18mIuEvH5xQexMLeBoys1RlD3Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSCVvcTjyS1Y1nATzAwSW1jlLuLxPEbOjZ9e8QMyhwDM5ei6ZORISUc7R4iluN+3uudEQri/8m2AIC7juhmkuzsG2/1/KTTRlQpRmS9yCO9Pa2l2Pbq89FE24yaaJaRXQacLFkrbkO0dv5NhvvFXdk+WzsT9Bp0dWE4OTJZOcJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=HEmL11r8; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="HEmL11r8"
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 73E1E20BAA;
	Mon, 21 Sep 2026 09:47:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1789976874;
	bh=N9Eofb66ADKeFDqJ7Q7eB0sxYyVHCANvockGYcIBooY=; h=From:To:Subject;
	b=HEmL11r8Lkcs6i6imJ8quk25ZjXptbEO9PFQR/CM0AEtqxFiTZCMGEeJ8XBnFgmIP
	 BtTsikkoFqbJinqennFSzPf1sDuokcoFCA5D6jYw0wMk5AoA/043PbtT6fiS9T6NVB
	 8bPrGjKjO53p1fp7jKicbeQHzx353aff0MFzLhNIougskvcHQpPav6gaXigCZuslsY
	 7dRpTi08VtzA375jjpGPAOTTSgkoUIEYpyEaKnIWTomYSR/iV9LuRNyNDGTIN8wMmU
	 pz4VosKUZ4c3qo7CzWlgqnwaYpbLEfFUEgetkHPbitNozEl0sdpLrHENYvLImv14O0
	 ZlTZAg8RMXVdw==
Date: Mon, 21 Sep 2026 09:47:53 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [linux-6.6.y] 6.6.158-rc1: stale ASSERT_RTNL() in
 __ipv6_dev_mc_dec() WARNs on IPV6_LEAVE_GROUP
Message-ID: <20260921074753.GC13965@francesco-nb>
References: <20260921074348.GB13965@francesco-nb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921074348.GB13965@francesco-nb>

Fixed Cc list ...

On Mon, Sep 21, 2026 at 09:43:50AM +0200, Francesco Dolcini wrote:
> Hello all,
> 
> Disclaimer: the commit/root-cause analysis below was produced with LLM
> assistance. The failure itself is reproduced and verified by our CI/CD
> (LAVA on-target test).
> 
> Our CI reproducibly hits this WARN on linux-6.6.y at 02cc578650be
> (6.6.158-rc1), on i.MX6, when a process leaves an IPv6 multicast group
> (e.g. avahi-daemon around a link flap):
> 
> WARNING: CPU: 0 PID: 418 at net/ipv6/mcast.c:1013 __ipv6_dev_mc_dec+0x180/0x184 [ipv6]
> RTNL: assertion failed at net/ipv6/mcast.c (1013)
>  __ipv6_dev_mc_dec [ipv6] from ipv6_sock_mc_drop+0x144/0x240 [ipv6]
>  ipv6_sock_mc_drop [ipv6] from do_ipv6_setsockopt+0x92c/0x1a48 [ipv6]
> 
> Cause: 24e6c4f46cd4 ("ipv6: mcast: Don't hold RTNL for IPV6_DROP_MEMBERSHIP
> and MCAST_LEAVE_GROUP.", upstream 2ceb71ce7d34) is in 6.6.y and drops RTNL
> from ipv6_sock_mc_drop(), but its same-series sibling e01b193e0b50
> ("ipv6: mcast: Use in6_dev_get() in ipv6_dev_mc_dec().", stable pick
> 98363feee397), which removes the now-stale ASSERT_RTNL() in
> __ipv6_dev_mc_dec(), was not backported alongside it.
> 
> Could 98363feee39760011bd2225558c0fef9487c449f be applied to linux-6.6.y?
> Or the problematic commit should be dropped
> 
