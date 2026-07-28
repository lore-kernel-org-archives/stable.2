Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4553943E9CB
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785245441; cv=none; b=ClRc4m1bE5er5YgI4HHSV+E9GgQeDSWoHG3OTYbH3UujHGHPWLaBetctUvgekiAptRxAzMkrSvrNcFrylwhAvWo1vX9OTOFoOiOqll/Vpueqw/N125w1RRHPzDSikQ/TD13dPzj12FN3Wy37zSDVEZlMiRr0atcvYBBpjsbhvzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785245441; c=relaxed/simple;
	bh=JYif+IVnSPZkheG2x8dSrO5ARN3Z/tsJlNbhOMSsroI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c7RYgOmndKT14WZTDFoCYpcjA8rnF28iMYgjpRTaSjlg3nTGoXUDiwCVW8aDj5XvSXylkxux7vYZZ/NijeGmlxN5Phw1QfcF7ibqW0kKNCc5raGtDezQ36Z+I92thh3lRJ/+jqQmlgzlGFRpotUgmkYMF0pQF5nFjshDAB49c5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1mXfO1u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1mXfO1u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEDD1F000E9;
	Tue, 28 Jul 2026 13:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785245436;
	bh=Vey5SccemvtbQ6uXlCU9hOBFrSqDra/PKWnJA7I9Mnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m1mXfO1u0TahkBfyFPL6DyR0T/AQmYoZBPWEIlim9FLA51h1Xdii4bmp855AqeZPP
	 DDZjcRCvkalhCvfJYDyQA8/r4YgaKRKgC2VmxNx0iUo4eMrq2lrjydtzTtEqW9f1eC
	 p5d2GOnO+Uq5QrYvPZ/nAoaLflWJtRfFIabkr/I+Q+724sOyyFsYz8dmklTm5E8qF/
	 Ki3MIV/bk3U9E6saBLa9UeUqd7VOH/fYsvPWxnSDZLEOQWYnCIA53+S3gAVm9A2su8
	 9qH9rOOUNvOcUROMBazOp5lWhqW++u1xOsA3GUw220VPWTwF4mRoIsMSq6bi20M4lS
	 3sid1ag8+lMKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maoyi Xie <maoyixie.tju@gmail.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] net: ip6_tunnel: require CAP_NET_ADMIN in the device netns for changelink
Date: Tue, 28 Jul 2026 09:30:33 -0400
Message-ID: <20260728133033.3965038-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072023-majesty-rubbing-2664@gregkh>
References: <2026072023-majesty-rubbing-2664@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maoyi Xie <maoyixie.tju@gmail.com>

[ Upstream commit 2496fa0b7d180b3ad356b514e7ff93bb14e6140a ]

ip6_tnl_changelink() operates on at most two netns, dev_net(dev) and the
tunnel link netns t->net. They differ once the device is created in or
moved to a netns other than the one the request runs in. The rtnl
changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
caller privileged there but not in t->net can rewrite a tunnel that
lives in t->net.

Gate ip6_tnl_changelink() on rtnl_dev_link_net_capable() at its top,
before any attribute is parsed.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: 0bd8762824e7 ("ip6tnl: add x-netns support")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260612085941.3158249-5-maoyixie.tju@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6_tunnel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 5a2583a82f974f..825d40b505cde7 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -2055,6 +2055,9 @@ static int ip6_tnl_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 	struct ip_tunnel_encap ipencap;
 
+	if (!rtnl_dev_link_net_capable(dev, net))
+		return -EPERM;
+
 	if (dev == ip6n->fb_tnl_dev)
 		return -EINVAL;
 
-- 
2.53.0

