Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5DC43C7C5
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 07:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976636; cv=none; b=V2fWlOgWHGo3i8flq8MeLeNoxB/dJPMQyb+0wudphVVIRpj5hVN/s0O7dt47NVpQSs3a7VDyl9aJ/5crUKtQZMtoJgGxuOOYEYLQJdDFuBQE5URZhgkgFyU8VIDdikc18DypcYa2Cq9YcYEjXEXxXOS6im3PJCSEHTZsqXNX8t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976636; c=relaxed/simple;
	bh=xQiD1gvDBtgwKsLzEjHBCLcpswkU70fXpTPSYAdX6+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fs2sODXvACt2k+1qfgIMLGJeOdtssv8YOuWOny3LH/ZBof4lD4/HxbVOo5btJTpjBijTxzxvzE0wrgPv06N82fw7sGAmlJHW8IC2bETN5sPuJ+nwbI47AwaOGr1bwxOL7YzrQfgq1Mam0Vb0EMOz9K1ceOxojWQyJnpN4O3S8Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=muhIq8qy; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="muhIq8qy"
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id C949320B6C;
	Mon, 21 Sep 2026 09:43:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1789976630;
	bh=xQiD1gvDBtgwKsLzEjHBCLcpswkU70fXpTPSYAdX6+Q=; h=From:To:Subject;
	b=muhIq8qy8gDN8EEuu5oq1K5UYQ9P2P+OdcLLK/jDUDci8hxX4cOVMMWuznkwmCTHD
	 qOOkicDfBnafkiinJZqdNaw2CSRJhW5P/ZEj/uA3oLZE3/YPKGGCCbKF4dPXgoGs67
	 XDumpnPxOL8AwsgBXrpdtLnVceTaGpOl/AMXsfvI47+7wqyOLYv8PKjHWL5iRj0KMc
	 oNR4lqHXZHURMhCONYLOCVYWlxOe5DzpB1gtMRG56zrhiuVnCNadt3yd3e6oHpw2ym
	 0iX38Y8e8cqsGuPz2jVkf7XUAu1XEnAv6qdNpyYQbQWKCjVQFxNigFMMZoJQW+qtNL
	 p+9waOZldtJQA==
Date: Mon, 21 Sep 2026 09:43:48 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: KuniyukiIwashimakuniyu@google.com, EricDumazetedumazet@google.com,
	JakubKicinskikuba@kernel.org
Subject: [linux-6.6.y] 6.6.158-rc1: stale ASSERT_RTNL() in
 __ipv6_dev_mc_dec() WARNs on IPV6_LEAVE_GROUP
Message-ID: <20260921074348.GB13965@francesco-nb>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello all,

Disclaimer: the commit/root-cause analysis below was produced with LLM
assistance. The failure itself is reproduced and verified by our CI/CD
(LAVA on-target test).

Our CI reproducibly hits this WARN on linux-6.6.y at 02cc578650be
(6.6.158-rc1), on i.MX6, when a process leaves an IPv6 multicast group
(e.g. avahi-daemon around a link flap):

WARNING: CPU: 0 PID: 418 at net/ipv6/mcast.c:1013 __ipv6_dev_mc_dec+0x180/0x184 [ipv6]
RTNL: assertion failed at net/ipv6/mcast.c (1013)
 __ipv6_dev_mc_dec [ipv6] from ipv6_sock_mc_drop+0x144/0x240 [ipv6]
 ipv6_sock_mc_drop [ipv6] from do_ipv6_setsockopt+0x92c/0x1a48 [ipv6]

Cause: 24e6c4f46cd4 ("ipv6: mcast: Don't hold RTNL for IPV6_DROP_MEMBERSHIP
and MCAST_LEAVE_GROUP.", upstream 2ceb71ce7d34) is in 6.6.y and drops RTNL
from ipv6_sock_mc_drop(), but its same-series sibling e01b193e0b50
("ipv6: mcast: Use in6_dev_get() in ipv6_dev_mc_dec().", stable pick
98363feee397), which removes the now-stale ASSERT_RTNL() in
__ipv6_dev_mc_dec(), was not backported alongside it.

Could 98363feee39760011bd2225558c0fef9487c449f be applied to linux-6.6.y?
Or the problematic commit should be dropped

Francesco

