Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A533D0BEC
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 14:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785247202; cv=none; b=WDE9NmOzhLyrFBG/p6oqNuuooKmP3K40hwpdx89hl/57E4bTh45khqkR87uT467/zsJ/4NB7UxgSZLKUrJ2bcdehLdE/BrmrqHTOVrA2vZx5NYcbrnPouaCg/OY/TNj9NDz+6jtTbxTKp6bhWXi5dYtGKMx9ro/JAiS5v+xYwyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785247202; c=relaxed/simple;
	bh=5IM4xfgxxEJY6cwjjtb8R56hhRZrGuKGN/tDQ+8SVvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e9A998WOqetUd4yW+W0di2LDE4a0WRExi8ZPhhUmIvsMIzFiwud1cdNpnkPBhvD0p+i4WHCRxNgiG55FuefjTIh/XONyPmKe76pIyZrU2TaCyiw+toAvytDrfznUKu5cgSNRdmidxKqsE+P+08qmenM+8mg3nOSKY1gf7ndM9wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaxwcggj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaxwcggj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18C71F000E9;
	Tue, 28 Jul 2026 13:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785247200;
	bh=xRKyqk/ZzQpkUxX9OS5pwYbm8ug2POQ8jwco12yMLLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aaxwcggjtTagdXtyLRdB8+2dgiUfPmWWl8W0sEuIKzub4wu+lCeZMMAnk6Skw8pJk
	 gQ0ZqUTGNU/mYamAagNWuFLbPgAnsTyg5lsQPEcduQFFRlsJ3FGkbvuVGBrRAS0XEb
	 6KFncPQ/YZH/ybl+AlD02PEo7j9md9IHgkxlHTTiMQ9Y9OjAypho79LbViuSke49cj
	 w3HnIdnQ+GrViOOuv2+u/FbhR2VL77YsQkpqB033sMIi8swOzPLpRdb70a7fzCq+W+
	 q0CbXEAa8DqNzO/imzA9IcsvypshbHARNj8dKaAMnUCcaJt7bf9meXrQ0BQwXFzqy3
	 UHUC/d5L+dO6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maoyi Xie <maoyixie.tju@gmail.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] net: ip6_tunnel: require CAP_NET_ADMIN in the device netns for changelink
Date: Tue, 28 Jul 2026 09:59:50 -0400
Message-ID: <20260728135950.4067044-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072024-tactical-enquirer-b40c@gregkh>
References: <2026072024-tactical-enquirer-b40c@gregkh>
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
index a1a2e785063c35..042c9caaeeadfb 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -2057,6 +2057,9 @@ static int ip6_tnl_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 	struct ip_tunnel_encap ipencap;
 
+	if (!rtnl_dev_link_net_capable(dev, net))
+		return -EPERM;
+
 	if (dev == ip6n->fb_tnl_dev)
 		return -EINVAL;
 
-- 
2.53.0

