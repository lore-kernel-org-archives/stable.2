Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93034463B91
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791125536; cv=none; b=dC39Oksap30bE/urbTLgSFXdQNyv66apzuKRS4ScBtlJ90qlpPFjje3Jy/YijlrqkygllsDVNfO7whogdiVM40hhPhxqKuqLBYWJf6gaiiAEsmJo8OgjqrUeQ78mr87nPTOV0+T3QJJEYaPZx5ZY1U1usTTdlwtv0ch/Rnui3zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791125536; c=relaxed/simple;
	bh=3PSXjUUgkP+CTkZuRfK+qx3dquiLCcTTSglpG8kopjI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A/Eh5DfelyQAVK3wFveTY3nd9afrAYMuuLSOqlfNtvuUoFYG/Wod8GjtfQ8K+lJncTDr7PrS3NlxIt+0qMBU4o1w3Nky/zpIPOogxT5Uejf6EoXUALFuWxcalVqhjdPMNrcBdUCdUC9B4XR5gMQtPRJnWW/boFdRN0UkJ2+4OgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAnsVz5/; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAnsVz5/"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5ba42966d5fso763465e87.2
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 07:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791125530; x=1791730330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pcvaVcm7AzJh6OuMh0IbSjO1x/AShhDM4lk+aq/Dp1g=;
        b=eAnsVz5/SUnTqJP1to58ZQ/GocqiqUktGmRmlcOT0kguh4PJr1hzCuXPb7vzyEVBO5
         YQcA3ihao5ZqLaGAhuGhS+q8GrZONTHlW6MRXFQbAsGxOVcX2dJ8xKGqwN/lJoY0VDrn
         STm5IDTvgDYtkHvXyP8uXuveaW6YsUIkvjiYf3c+HojHRM4q1EZ3Vk27d2rqbbIokuqp
         XxPmByE0+F4R616D+p8tYc4yrDXYMmbyMZMdjDLLqbnXv/tsSDHEIa50vh0aEAtNRdBg
         jTbpfD7mWjZOiOoXXxY95bve20/cA8D+gvA2nVZl7fJSioArKfVfJq8CSSBpMr7f+efw
         NllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791125530; x=1791730330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pcvaVcm7AzJh6OuMh0IbSjO1x/AShhDM4lk+aq/Dp1g=;
        b=PlNUNr/S1iKROd3/XBR60fpZIML/LbfiC5EmO6tqbHB9r+rNpyepBSb1Q0znND3HK1
         F+6oC1Dwg9ZNjQnziOvlnp/rjrAYRqM44GjPo+I0nlGx4nC5eX9eujjSS9o4xRLzN50K
         zCs6SncDAUy7UC7AeAMx7dx6wyuyMm/GPop00aVQ2hlKd8vkLcgtFun3Tm+xgc8pgJxf
         kHJYZ8gmULxFQGr+28idFAZbIwkEvEssWhyfE7jk/oJdK69T6MVsgxaaEjFMCIV8IIqi
         oGlRTgscHP/yB68yvNzVEiGhpAqbL2kR7wkfmi00InD7xf6oOdICyCIwKnWK/IPgvB+L
         OJaQ==
X-Forwarded-Encrypted: i=1; AKwUvByzPUf3nr1RDbBN/r2dmOWYB4IByZKUkqaP07FngiNaZBfEszXRZW12V/sTsXvroTiZt+pg1BI=@vger.kernel.org
X-Gm-Message-State: AFq9FYK7RBtOY/lCe+YrBtHa77R21iPcidVbQDySb/z3fh6iIkFRuMJC
	gULnwnl8h/dRdjj6es03dIvieGPbPFAyOrilPEeNxOZmeMoQFtAkfWdc
X-Gm-Gg: AYBFou3eS1t9mNDh1Hn0x5BDCOOeQcL9nVPmM+yRyIZ5EVdnUIgWsChk4I+oLwAduxu
	/7ub8QFmTUfdkilpnxbF9L8A3tvr1IR3cg531I7vXGAvEzWXhVywG+LHv6XdKL97n/wLmG1VyDS
	8ni0AwHwYNWso9UedPDBbf2wuNPoNsVRNpoU7CKVZUvZMb81//hiPBDENT/H9zTWiyK0XguWjMh
	0CQ24HM9EMggrILVM0pn5MvgrEHzH2orxcJD5dmHS6oK/lI7oxomKpDCQWmUKqGZCmX56aEZXd8
	YoRp1sYkgOuW2lgSDRxAUlRyxJCo3iP1plemKi+e8ru8zk9CUmaPVdFJrtRPTD5mlc31dwCt/ih
	D4E97jjyjmhH/WkoBLiROZpxCCgXsixXO2cROZCpbNmbmyZTaxm/ud4MPYZ+xJMhVTFM+lzcD6O
	n3l90nYaS78lC/iabmeFyKY1dYXv5G24ZBZNuhljmTqZBN15FKAw03ISd5/DOHmVtZw447QX0tD
	/aqzJATnakgzoQL3wZMKFAWvvk+A0y0OpF2elPd6Q==
X-Received: by 2002:a05:6512:65d4:10b0:5ba:4329:1c6c with SMTP id 2adb3069b0e04-5bb93812b49mr2768336e87.6.1791125530191;
        Sun, 04 Oct 2026 07:52:10 -0700 (PDT)
Received: from dau-home-pc.. ([212.35.161.1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bb7c795b22sm2360569e87.36.2026.10.04.07.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 07:52:09 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Mazin Al Haddad <mazin@getstate.dev>,
	Matthias May <matthias.may@westermo.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v4] ip6_gre: use skb_vlan_inet_prepare() instead of pskb_inet_may_pull()
Date: Sun,  4 Oct 2026 17:52:04 +0300
Message-ID: <20261004145205.226974-1-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip6gre_tunnel_xmit() and ip6erspan_tunnel_xmit() check the packet length
with pskb_inet_may_pull(), which looks at skb->protocol only, while the
code that follows parses the packet through VLAN tags with
skb_protocol(skb, true). The parsing started to look through the tags
with the two commits in the Fixes tags; the check was left as it was.
A VLAN-tagged frame whose inner IPv4/IPv6 header is not in the linear
area passes the check, and the inner header is read anyway. A 20 byte
tagged frame on ip6gretap and a 10 byte frame on ip6erspan are sent
out, while an untagged frame that is too short for its IP header is
already dropped.

Use skb_vlan_inet_prepare(), as the IPv6 receive path does since
commit 81c734dae203 ("ip6_tunnel: use skb_vlan_inet_prepare() in
__ip6_tnl_rcv()"). The second argument (inner_proto_inherit) depends on
the device: ip6gre_tunnel_xmit() serves both ip6gre (ARPHRD_IP6GRE, no
MAC header) and ip6gretap (ARPHRD_ETHER), so it is
dev->type != ARPHRD_ETHER there; ip6erspan is always an Ethernet device,
so it is false. vxlan does the same with no_eth_encap.

The tag walk starts at skb->mac_len - VLAN_HLEN, or at ETH_HLEN if
skb->mac_len is 0, and on transmit skb->mac_len is still what the skb
was received with. For a packet that came in through an NBMA gre
device and is routed out of a VLAN on ip6gretap or ip6erspan, the walk
starts inside the inner IPv4 header. Clear skb->mac_len for Ethernet
devices first.

An ip6gre device created without a remote uses ip6gre_header_ops, and
ip6gre_header() pushes a pseudo IPv6 header in front of the packet, so
there skb->data is not where the packet starts. skb_vlan_inet_prepare()
would move the network header onto that pseudo header, whose payload
length and GRE words are never written, and an ICMPv6 error for the
packet then quotes them: KMSAN reports uninit-value in
icmpv6_push_pending_frames(). Keep pskb_inet_may_pull() for that case,
as before this change.

With this change the two short frames above are dropped. gre_gso.sh,
l2_tos_ttl_inherit.sh and the mirror_gre, mirror_gre_vlan,
mirror_gre_bridge_1q and mirror_gre_changes forwarding selftests pass.
A constant true instead breaks the ip6gretap cases of mirror_gre.sh,
and a constant false breaks the ip6gre GSO cases of gre_gso.sh.

Fixes: 3f8a8447fd0b ("ip6_gre: use actual protocol to select xmit")
Fixes: b09ab9c92e50 ("ip6_tunnel: allow to inherit from VLAN encapsulated IP")
Reported-by: syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6023ea32e206eef7920a
Suggested-by: Eric Dumazet <edumazet@kernel.org>
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>

---

v4: Anton Danilov takes over the patch, as Eric suggested in the v3 thread.
 - inner_proto_inherit follows the device type instead of being a
   constant.
 - Clear skb->mac_len for Ethernet devices before the VLAN walk.
 - Keep pskb_inet_may_pull() for ip6gre with header_ops.
 - Fixes tags point at the commits that made the parsing look through
   VLAN tags, instead of d8a6213d70ac ("geneve: fix header validation
   in geneve[6]_xmit_skb"), which only added the helper.
 - Discussion: https://lore.kernel.org/netdev/20261003220513.107668-1-littlesmilingcloud@gmail.com/
v3: https://lore.kernel.org/netdev/20260119112512.28196-1-fw@strlen.de/
v2: https://lore.kernel.org/netdev/20260106144529.1424886-1-edumazet@google.com/
v1: https://lore.kernel.org/netdev/20260105100330.2258612-1-edumazet@google.com/

 net/ipv6/ip6_gre.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index e61cb10b50dc..f48141820fb5 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -883,8 +883,22 @@ static netdev_tx_t ip6gre_tunnel_xmit(struct sk_buff *skb,
 	__be16 payload_protocol;
 	int ret;
 
-	if (!pskb_inet_may_pull(skb))
-		goto tx_err;
+	if (dev->type != ARPHRD_ETHER && dev->header_ops) {
+		/* ip6gre_header() has pushed a pseudo header in front of
+		 * the packet, so skb->data is not where the packet starts.
+		 */
+		if (!pskb_inet_may_pull(skb))
+			goto tx_err;
+	} else {
+		/* The VLAN tag walks below start at skb->mac_len - VLAN_HLEN,
+		 * or at ETH_HLEN if it is 0, and a forwarded skb still has
+		 * the mac_len of the device it was received on.
+		 */
+		if (dev->type == ARPHRD_ETHER)
+			skb->mac_len = 0;
+		if (skb_vlan_inet_prepare(skb, dev->type != ARPHRD_ETHER))
+			goto tx_err;
+	}
 
 	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
 		goto tx_err;
@@ -934,7 +948,12 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 	__u32 mtu;
 	int nhoff;
 
-	if (!pskb_inet_may_pull(skb))
+	/* The VLAN tag walks below start at skb->mac_len - VLAN_HLEN, or at
+	 * ETH_HLEN if it is 0, and a forwarded skb still has the mac_len of
+	 * the device it was received on.
+	 */
+	skb->mac_len = 0;
+	if (skb_vlan_inet_prepare(skb, false))
 		goto tx_err;
 
 	if (!ip6_tnl_xmit_ctl(t, &t->parms.laddr, &t->parms.raddr))
-- 
2.47.3

