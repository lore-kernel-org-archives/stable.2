Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB67F47F3A9
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789997522; cv=none; b=A6Tk4VwzYGLxBslO2/mzZJznX8nysnCQ0srMA79gn9Rd1Vl9DxIIGLFT4fEmFb2P57u/Y0mEEozPK/tw+l0xtiO6Ik06HYgoAAgRIxuWAm9OgdNPVfJS7OKatErVBnuNY4i6GVBsl1gH18AO/0XoYe8p99x6nhnxQ2nHvwohnkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789997522; c=relaxed/simple;
	bh=UmWz6412XqXQzFC6U39kvPHZXHcucpNklPepdyJTcSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udU9AK6REPumU2THKArdyDT3QTU6MqGMojjR4MQHQAQyYT5FPay6Utausa1L/Eq9M/s0RgIeU87N3/cOQApU0fXQn9qusweRmRdi+LZFYI/9dQY32LdN1tM+RL6uRPiweGdBhD2H08UPrQi9QHaQBqDRHjpvZzMXH8eT40kE/Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dUGaIBG+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dUGaIBG+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AB81F00898;
	Mon, 21 Sep 2026 13:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789997520;
	bh=UYr8tgOYQVsP3CRKO3AFFkPtq4Cu1bhvTZxhlOtzcuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dUGaIBG+CbFkoJ6qTUKWAALC25edYlDR9PNI2PeZUxy0TVYEqu5OUWFDTCsjsDFYa
	 N04VSC84h10OoTU5j5MoaYUlTuo4yuZD38eOmdjxOZi9cT24vZIePbRNhwghuCbS9Q
	 uMMEeKn8K5jusg9+jjYDQl7XBcoBORHvkBuAUIpE=
Date: Mon, 21 Sep 2026 14:24:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	KuniyukiIwashimakuniyu@google.com, EricDumazetedumazet@google.com
Subject: Re: [linux-6.6.y] 6.6.158-rc1: stale ASSERT_RTNL() in
 __ipv6_dev_mc_dec() WARNs on IPV6_LEAVE_GROUP
Message-ID: <2026092115-magnetism-breeching-5d92@gregkh>
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

On Mon, Sep 21, 2026 at 09:43:48AM +0200, Francesco Dolcini wrote:
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

There is no such commit id with that number in Linus's tree :(

Did your LLM make it up?

confused,

greg k-h
