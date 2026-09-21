Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14A546C823
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790000693; cv=none; b=h0ck7BzO1K44hopoz/SFf2vOwXHHKkMoEiAb9sVf8uIDNjXz0gZKGdgbRCXRYxwkksikuAmrjHM1ErVf9/RKLlLm82WyCj8IBOX3L3/emUat73K6i0TQMzTN/lnviTdgqswYubeoiUqRZidIk/7v0NJycy2aqtiKCCc7bTdlljI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790000693; c=relaxed/simple;
	bh=Eb6W4jbJt5N+kv5pZWJnNwvHc5jlxdc8xtZJbQ1/f5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQ43Gl8tYH0ptxkT4fNtMIJ0UjsPQDlw0DMoW4c9Wu9WPOPS/pYaNMEsEyJTNfARw9iKt2o1asaXf1rgULSXrh5e9+E1qKLKL6gK1GotTUh5lgaGfg7PtWkHdKVkO4Wjd1vBCserSEIa8VWXgtOBsptHnBPShGOaHKv3mipxoog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=yLVtprH1; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="yLVtprH1"
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 3DF48227EF;
	Mon, 21 Sep 2026 16:24:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1790000686;
	bh=A0/c/bnV6Dsl2x4jIVPXD36HIgM/E4zR6LvXyCcH9pw=; h=From:To:Subject;
	b=yLVtprH1I8ggT0FKNC24K2Y45zkC6UcVL1vgb+fo9aRuIh9xiTqEDmmkfu+oUW5z2
	 n3wvIjiTEq9N8a/pQ0E59ojQDsJ/l1+pd5ki+j40/9hA3tCV5ddIXlMrXvsazvIUNA
	 jEQ30+fwIvO3mWCMXBS4F119KcXdotWxxJsMjAfjZV69YIP4Tp67ayM0FNJiHs3LYg
	 2tGkxclzwsGX3CJTOagigLk0uf3EM8CFBxmirG35d/SV2t1oLMREetzNsSKDW4zyf7
	 oszRPxTLaKF+a+QNojzEKpETfKCIWsM2ALnTtoJ4KGUKHuaiN855kenNp1v/7fd0j+
	 zenpLGmR7lUWw==
Date: Mon, 21 Sep 2026 16:24:42 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [linux-6.6.y] 6.6.158-rc1: stale ASSERT_RTNL() in
 __ipv6_dev_mc_dec() WARNs on IPV6_LEAVE_GROUP
Message-ID: <20260921142442.GA276016@francesco-nb>
References: <20260921074348.GB13965@francesco-nb>
 <2026092115-magnetism-breeching-5d92@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026092115-magnetism-breeching-5d92@gregkh>

On Mon, Sep 21, 2026 at 02:24:41PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Sep 21, 2026 at 09:43:48AM +0200, Francesco Dolcini wrote:
> > Hello all,
> > 
> > Disclaimer: the commit/root-cause analysis below was produced with LLM
> > assistance. The failure itself is reproduced and verified by our CI/CD
> > (LAVA on-target test).
> > 
> > Our CI reproducibly hits this WARN on linux-6.6.y at 02cc578650be
> > (6.6.158-rc1), on i.MX6, when a process leaves an IPv6 multicast group
> > (e.g. avahi-daemon around a link flap):
> > 
> > WARNING: CPU: 0 PID: 418 at net/ipv6/mcast.c:1013 __ipv6_dev_mc_dec+0x180/0x184 [ipv6]
> > RTNL: assertion failed at net/ipv6/mcast.c (1013)
> >  __ipv6_dev_mc_dec [ipv6] from ipv6_sock_mc_drop+0x144/0x240 [ipv6]
> >  ipv6_sock_mc_drop [ipv6] from do_ipv6_setsockopt+0x92c/0x1a48 [ipv6]
> > 
> > Cause: 24e6c4f46cd4 ("ipv6: mcast: Don't hold RTNL for IPV6_DROP_MEMBERSHIP
> > and MCAST_LEAVE_GROUP.", upstream 2ceb71ce7d34) is in 6.6.y and drops RTNL
> > from ipv6_sock_mc_drop(), but its same-series sibling e01b193e0b50
> > ("ipv6: mcast: Use in6_dev_get() in ipv6_dev_mc_dec().", stable pick
> > 98363feee397), which removes the now-stale ASSERT_RTNL() in
> > __ipv6_dev_mc_dec(), was not backported alongside it.
> > 
> > Could 98363feee39760011bd2225558c0fef9487c449f be applied to linux-6.6.y?
> > Or the problematic commit should be dropped
> 
> There is no such commit id with that number in Linus's tree :(
> Did your LLM make it up?

For sure it did ... and this is the reason I was upfront that the
analysis is from an LLM :-(

What I know as a fact is this WARNING exist, the related folks and in Cc: and
they can provide better guidance on what we should do (drop the patch or
add some missing dependency).

Thanks,
Francesco

