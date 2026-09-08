Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510E55947FF
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 17:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888335; cv=none; b=nsAur9OtkLIQ5NRchkUU+2i/LYwytdOEJetL5NmnKsyxBNd1uiD/u9p5IeGtH9bBma+sKwvmgJtf+j2JDmMZbRlbWsnv6sZIkccmUdY3de0IHln7CiXR/BrPbwkTGJ6VVi5uxVGiLvVGXZ8T7i4JS6E5wIfaV59hgG7rybU2lg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888335; c=relaxed/simple;
	bh=KLHMjw0HNy76BmKOiktrQOZo8euNdrXQCWk7Du4xjPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TS0BzQKkNg6KlkIOdWHhvmh1M9ZiyiePpscET8DAxlzhHSygczNwdl1Uq9dhH2AzDjbGpcRAeS7/DP8S8dWccfoalm4Q+hZKOFk+C5EpY7Y5Ox43pyB17nXeNJ+XiBwPkbPCVf2vlNx0OGeFJcDlBjh+WQE5Z5cccm9gGbt/ABs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNKyUQ5T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNKyUQ5T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1F01F00A3E;
	Tue,  8 Sep 2026 17:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788888333;
	bh=0KCDyGA7RZpCxAdkTPfbAWayDggP6gx2yaUYI/z/48k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DNKyUQ5T0fmFMyL+tnhfnCe2Wcql4/EHcvvNs7o5BF7RcN37Y4BoMeYTHg/k23K/8
	 FjdzRQ7aEBK7aFGJBqjloON9ow9EIv2WPWRS9pP/r/kno97+Sk5tRHVSdlO7USj2Hr
	 K3oVwOdld2UAfjUgedmg7zOZOujxnv3tF0JRctBaUExryvAZlGUvZE+DEgm9MOZXpm
	 vs3czl3q5V//Ld3OCanu4VJLo6xYSA5Fecwbou5dVvdHqAeI0xksE+ovz6TbS3iYt5
	 BoC65QpgwvEcw5UpMZsxNENxz3ftkWL4JYiCwmQPkYb3TqzCn4/J53gpasoHmtQcXi
	 AaJgBHBVIj8zw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Ido Schimmel <idosch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] ip: orphan prefetched skbs before multicast forwarding
Date: Tue,  8 Sep 2026 13:25:29 -0400
Message-ID: <20260908172529.78857-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908172529.78857-1-sashal@kernel.org>
References: <2026090318-afterglow-hash-e60c@gregkh>
 <20260908172529.78857-1-sashal@kernel.org>
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

