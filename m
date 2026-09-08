Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A43434984
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 19:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895725; cv=none; b=l6MgjB4JscsQ3FCU4dOWbPNS9iRcWeEqNAMfEwQQ4W6L11xu+Cwh8JFZfBnSkwtWKEfQ3IM/9xXpWdd3Esyxe4UJpquXqbUi8fWKnh9z1yWA6yahbtdUqFlQX8jAUCoerTZhK9tkpkRYQGmq5yBQI2OWmHLNEk7q2Nd7p4WIJoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895725; c=relaxed/simple;
	bh=3tMcT998QZrFv09yR5cjwZBhrc8pAzhOjhzcbVAKz0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUFKXFGwZyPZALzZ6TkCBm3yhalIjFSAyuNB3qoGbAEm+AvKRxj2TZolM+yQZ6n/xJzGoyvQ+Me3jeICJZwB0vtxN8QWFHugU2M7JNhWlAkDwpfLULsMOD/uNY36taFEtmZ/Qb0FMI5mp1B3Ipa9ttewvabzlP7Yq8VRNr5PcXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBWYPjBq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBWYPjBq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465FC1F00A3D;
	Tue,  8 Sep 2026 19:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788895716;
	bh=crpqPHN0+cMmMHjaOWOffv20skx3aBPUFY/pGlNem8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mBWYPjBqhBdoEmtzWd23IAW6rvCPguD01QJrrp+Zbf2GeBSfrLrYNjP0iicnRLb7W
	 Pk6S1aumQ/Y5uUMNJaCAmJOoMpgwo9bWMs847Xt9cTAwRC2//F0Ii1/bYQJ0vlm+ju
	 0VI8BqxAuF08Gw2l60zwO8nB1PYdUYqQFAPF5b5F95lDU+fERMQH37huthXMlX+Vhc
	 vpAaaEbW4TQwIFhWhFRmP5dN6QNtjKzPX0rVqURqFa8oWd1xAP6m6iJzc3i1n6rwlv
	 B/ChswH9SuHUD8u8nvlsIJOW3NE197fC8YYewYC90jJkrsGt0NS1tGsW7XE7/FHzfl
	 ao/nAdUYAe3Hg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Ido Schimmel <idosch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] ip: orphan prefetched skbs before multicast forwarding
Date: Tue,  8 Sep 2026 15:28:32 -0400
Message-ID: <20260908192832.296634-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908192832.296634-1-sashal@kernel.org>
References: <2026090318-pusher-lucid-87ba@gregkh>
 <20260908192832.296634-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhiling Zou <zhilinz@nebusec.ai>

[ Upstream commit e36ce6e78fe3fc3c071a26750783b7ba081ce10d ]

IPv4 and IPv6 input preserve an skb->sk association installed by
bpf_sk_assign() so that local delivery can use the selected socket under
RCU. Both address families can also prefetch a socket in UDP early demux.
In both paths (BPF and UDP early demux) a reference is not guaranteed to
be held on the socket.

When a multicast packet is not locally deliverable, IPv6 hands the
original skb to ip6_mr_input(). IPv4's ip_mr_input() similarly keeps the
original skb when local delivery is not needed. Either path can put the
skb on an unresolved multicast route queue or forward it after the
receive-side RCU section ends.

After the prefetched socket is destroyed, a later skb free invokes
sock_pfree() and dereferences the stale skb->sk. Orphan the skb before
each non-local multicast forwarding path. Local delivery retains the
original skb; the existing skb_clone() calls provide multicast forwarding
with a socket-free clone.

Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
Fixes: 08842c43d016 ("udp: no longer touch sk->sk_refcnt in early demux")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/0c52eb3d7532aaf8bccf37e0f7c922143c639735.1786552223.git.zhilinz@nebusec.ai
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/ipmr.c      | 3 +++
 net/ipv6/ip6_input.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index af9412a507cf3..93d08e343a256 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2139,6 +2139,9 @@ int ip_mr_input(struct sk_buff *skb)
 	if (IPCB(skb)->flags & IPSKB_FORWARDED)
 		goto dont_forward;
 
+	if (!local)
+		skb_orphan(skb);
+
 	mrt = ipmr_rt_fib_lookup(net, skb);
 	if (IS_ERR(mrt)) {
 		kfree_skb(skb);
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index e775a5a766692..9b6eaae0c6c80 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -566,6 +566,7 @@ int ip6_mc_input(struct sk_buff *skb)
 		if (deliver) {
 			skb2 = skb_clone(skb, GFP_ATOMIC);
 		} else {
+			skb_orphan(skb);
 			skb2 = skb;
 			skb = NULL;
 		}
-- 
2.53.0

