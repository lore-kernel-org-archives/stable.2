Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685CE595721
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888331; cv=none; b=j7S6WpUtmNBcYqPHYBkKM9M7U9ktMaOEvu3ttRGAO6hAEgSUGhbyQV5dseDrqmKRvGzsL6CCUG3JcUzs6SNDtupWNQcARWto3y2F2XQ6k8lv/39z2hQ75jiE7oCP9vKA8JwnNYbNDYSy/fJjX+pPxzYwHOuFEqwHGqUXgh+1LPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888331; c=relaxed/simple;
	bh=KLHMjw0HNy76BmKOiktrQOZo8euNdrXQCWk7Du4xjPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKOy59ppBwp/XKnlkKYeTRkH3bLhSkhIlbAq84GaKrPvZyK0b3nrjY0ryFk0CAETBKqeKrHCz+Yjrj0FBkviX25K8CH/+JsVT8aSHss+nRvFw70uJhWXLQilH2wICRDST/c6dErx/D8hwqvC/orajVqa7XZwbLv6YRNRHpUL15c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQwxM3N/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQwxM3N/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822F21F00AC4;
	Tue,  8 Sep 2026 17:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788888330;
	bh=0KCDyGA7RZpCxAdkTPfbAWayDggP6gx2yaUYI/z/48k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QQwxM3N/UIVikTG5isAbKp3v817h0a6NPCJ+xaL4C6NnQQtLJt6ITkT3YuhSmljhv
	 uVaU+NMcZ738Lb9SP28lxa6RndTeXjqmQeVdW54jAIeCn0PCZkwrVdjuGmFJDPxgmS
	 AqfzUmwShiP1FuUG0+f+eeM1LmCL+zk6fGvq/TI8diUKPOqvgVtpn39HfEZ0WpitDw
	 BNUPmhICMqBhoREtnm/3ZHXbQBTT7tUCbbs2GCRei0myRr04njoVcDuJJcGfZ4spMj
	 mC6+SR559+6NkuRiJnJtfbF01uZPKc/jIe9UNa/2NnlqqARKhaKYYD/sHRvkx1Rk6g
	 hKUb6mA0rWphQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Ido Schimmel <idosch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] ip: orphan prefetched skbs before multicast forwarding
Date: Tue,  8 Sep 2026 13:25:25 -0400
Message-ID: <20260908172525.78441-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908172525.78441-1-sashal@kernel.org>
References: <2026090318-afterglow-hash-e60c@gregkh>
 <20260908172525.78441-1-sashal@kernel.org>
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
index f0294b1148246..131b565c52051 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2140,6 +2140,9 @@ int ip_mr_input(struct sk_buff *skb)
 	if (IPCB(skb)->flags & IPSKB_FORWARDED)
 		goto dont_forward;
 
+	if (!local)
+		skb_orphan(skb);
+
 	mrt = ipmr_rt_fib_lookup(net, skb);
 	if (IS_ERR(mrt)) {
 		kfree_skb(skb);
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index bc535e79bdc8d..f0a98c61a087a 100644
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

