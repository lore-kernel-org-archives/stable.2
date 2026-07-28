Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31CC448CED
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785248869; cv=none; b=pwBil3QeCI512bOfqROWGEXb8whCytAdiEG6zGXfRFupm6moLN61Nv7BayCQvrn4IDLydQWh8W1MFSZgX8FokYPx3904XvuztJFfYZd+P5dbo4aHYjOn0QJDk72lkoTLJIZ1MHOta/u0NVnEBH9cg+AFXGXKqYnTmVKkvvXdaGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785248869; c=relaxed/simple;
	bh=rKwSYjk1aa1lHnGWW/WvZEop4JlnNm0RfLvKXG998kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fS/TyAHDcHmfTlS/+xIxUXmR1h8MO1nRSJLBLikAZmbZYm1/KnJbaeMsZM3d+XBF5l57t25acsrO/I92eH5tbUG/gAIMXOddO5MnBGu16Cq0OaAmS+NQNxgr+LHFptiGCDeoVtk9uBY4gkePLvhCiFAWUj3eMZxundFxKO2/apc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHuTLnjy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHuTLnjy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C591F000E9;
	Tue, 28 Jul 2026 14:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785248867;
	bh=YcL9OVbTyhL3FU0RnJODm8ggdAiNxqGq9/WhCqxfKl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HHuTLnjyHEI6Lvr/6e2gSs6BdfGE/7ZLIwdmymTe7ij7QQ7JHaps8adGkQcDNM+cp
	 4m+Q8pWE5fyAuzhpmOj08IVG/um7hp7s45F/cICrqw49b5TkhrXjU8voAvzQp3s/Iw
	 M8rYPW7mBsZRRmx6eRPJ6NnwxTNlhFaBkFF2PEjiGaG6EbrAXMySYElEhmki2AATp8
	 8J/Q7la6g85EMmyelqAGoNpDftBG676yLVtxVqTzns3SpqgaxU+ULcHJrC64PQhlFC
	 Kl35Hlxa6Q7Y5F6X9L8qkmfWvISBtWtm5lT5qqk8iDH3j2HYP2Ge9e8hW37RGcrYxs
	 fOaHLogTaIAwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maoyi Xie <maoyixie.tju@gmail.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] net: ip6_tunnel: require CAP_NET_ADMIN in the device netns for changelink
Date: Tue, 28 Jul 2026 10:27:44 -0400
Message-ID: <20260728142744.4096199-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072024-poking-emit-1a0f@gregkh>
References: <2026072024-poking-emit-1a0f@gregkh>
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
index 53930c28b69469..2a953c8922f150 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -2084,6 +2084,9 @@ static int ip6_tnl_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 	struct ip_tunnel_encap ipencap;
 
+	if (!rtnl_dev_link_net_capable(dev, net))
+		return -EPERM;
+
 	if (dev == ip6n->fb_tnl_dev)
 		return -EINVAL;
 
-- 
2.53.0

