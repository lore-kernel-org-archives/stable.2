Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1D61ACEDE
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785244797; cv=none; b=MfTfNj1LobTZL5YbTDQrTBGP85ggvUzv4VIfT2QfljHeTdGIlJ9ypEBwXAZPmXk/9Q9sZlh8qtdD+kffcfYMGlFbE7GlbIeqFYXeppud6f8uBX5aMHxkVk37IIJlZIv5uixXAd7T7w5/0uwIfO/rMohlEWmOn2DgQgvBUWC24Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785244797; c=relaxed/simple;
	bh=cGLR5hsIR5GAzbJypL/PMOCdv0lFGx6kPlIHZxF3Vk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujemKFNaKx5Akv0UFZ35Yds3KNNPIaNydijgoEAUu3By5NkaMpCK8V5NbOoQ+Qd/lEdx1oJ23rG0F4Cc1wEYzNHWHS4gFpEqvEQzSxRAHlntzJ66thVOh9R3fw4hdvNIBSins1uTQ9e3zcEag7SSclx5Up2FQ6HqSHN0Mnd+ahk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2ssooxl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2ssooxl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDDE1F000E9;
	Tue, 28 Jul 2026 13:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785244795;
	bh=yJTNF07kupbbvpYvgV2XDWABF0/2zG3wX3UouCO9O3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K2ssooxlOQNxA5iWueAOjpJUllXuy9/J5mKjEM+v1WJFOjVDdRPdF7Ee0hs5GKITN
	 fbisfcZl63lT6NTeGJHTmEdOdTT5yGJD8tm03hS8QfLFE2WkA8DUtL1ipLXku5tuQA
	 or1ME9QRG23pEbSpd9LBq0cM07Facass1wzl5Kz3iKiUjpph53XLa0QZAcrsgVMI/v
	 JcKvzhqTVRVGUWCr4ErytOGU+7nPSlGOGAkzBcCshOalsznrpQfwSXXkCfwhdhHFrY
	 18BWSzjflZajZIn5Ix6Lqtz5mXQnwjJ+MFTwelzTupPy1AiPvm9/HLA9Fhl84SeSJJ
	 Shj2Q+BqfGyqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maoyi Xie <maoyixie.tju@gmail.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] net: ip6_tunnel: require CAP_NET_ADMIN in the device netns for changelink
Date: Tue, 28 Jul 2026 09:19:53 -0400
Message-ID: <20260728131953.3953668-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072023-unwashed-factoid-cc13@gregkh>
References: <2026072023-unwashed-factoid-cc13@gregkh>
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
index f0a8350eb52eb0..b788a06bd3a543 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -2053,6 +2053,9 @@ static int ip6_tnl_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 	struct ip_tunnel_encap ipencap;
 
+	if (!rtnl_dev_link_net_capable(dev, net))
+		return -EPERM;
+
 	if (dev == ip6n->fb_tnl_dev)
 		return -EINVAL;
 
-- 
2.53.0

