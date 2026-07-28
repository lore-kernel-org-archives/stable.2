Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AB53B19DE
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253413; cv=none; b=lLko0S4U8gc8MR9UMasTwbsZRR3yxTZvwhb0XsnTskrwfX1tom6qq8cPAFhKDzAhWCT59kYGUlYkaGXm35TSFU2kEnIAuYFa4SBOzEigB431YJzKRbiZm1wqtVzdfKAozgM30bsQDRyohGU4Jwp2lOV1HAS2+zmhgS/O99IJxXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253413; c=relaxed/simple;
	bh=LylyFAlHSGBQn5uXkZ4ZbZWNSyG5Km3ZSDXpJQ/4I4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sA8/LDlFaWjBkcBjHeUzuekDJ+LRg7CAW0ikIbFKEWn2pMPTfb++jAD1/Ep5mxhnBzxBCbrrW4X7rzm484B4yPN/sdS98+vKA7F3JWNAc4ArV0ZHaMNRx2ydMJ5wSSwslEYQLvBDmTcV41/419P/m0wt4jaLdkWLj7vb58sDHJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4QNfHaK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4QNfHaK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587121F000E9;
	Tue, 28 Jul 2026 15:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785253412;
	bh=BNvAV33II6brkJ5jEhfuI7cLG6aVh6sx7ieUY8uTw60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A4QNfHaKLwx/GazwEhg/WRg1au1mEOvdOTkBhEY350kGsOPWWW0vfU7d/rIUkUXYo
	 EtmrJoiY1XvrLXsQuUSXnl0EIYp9gbDpBTESh5YPmC98N/buPfYCF+iXUt+k0vCxPX
	 fGqRI1CCD3ezq9YoavcCg9MWzEWwtXthgIltcbcKGR2YYgdBDn3SLoJoNhUFmcmxmq
	 btQ7Eh8REKV1g3pTe21ojn6FYAoBlhN9wnRSahlhfjf/R48QFEjqrwUPp5f4LQnaU7
	 bYIqtqPrbdVBnsdbwnOyi/0yoCfVbbbWSt1UiVwd6CQJMkDUTrapfJtlko/NWSiInn
	 /PxEpTWZPkXOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maoyi Xie <maoyixie.tju@gmail.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] net: ip6_tunnel: require CAP_NET_ADMIN in the device netns for changelink
Date: Tue, 28 Jul 2026 11:43:29 -0400
Message-ID: <20260728154329.4192359-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072024-alkalize-reliably-1c7e@gregkh>
References: <2026072024-alkalize-reliably-1c7e@gregkh>
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
index dda90c77f89840..f323bb514ba4fc 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -2113,6 +2113,9 @@ static int ip6_tnl_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 	struct ip_tunnel_encap ipencap;
 
+	if (!rtnl_dev_link_net_capable(dev, net))
+		return -EPERM;
+
 	if (dev == ip6n->fb_tnl_dev)
 		return -EINVAL;
 
-- 
2.53.0

