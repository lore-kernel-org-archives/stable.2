Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFE73B4EBB
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 22:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788908052; cv=none; b=icthZjBc/uKjTj95EqPvmKUb4GILW4YszWYyl0qEUYyj8pkGL2ZaFLCzYvo9qtszNRFCMkGsBaP3X4gY9g+d723qv72jAhs5xLi6COMS8S7n4u/crphLniFqpVZFPQ8Dva9Ml+Mw61jlZaskocyAUsCnTqKq62jzvGoPnXnk9is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788908052; c=relaxed/simple;
	bh=hBo6+MWqIJJWTzo7AILGpg46kwem+BE6XaQLlEbFz4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+wgfMi6Xye/vrDztpq4mWQ8NtzJ8fX6f3eRUv+ap1STcE5POkRxSW3980L2L6Jpgs5WIo/8ArHAHgpPKxlIAcyNSZflKB9BWG106mXSdatn1SDCcYNECiZIIEmpXOv8ICaqEfKcb0Nf4Ow+0I+fvEm88lsLikg337qyyQQqylg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7fJJUt0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7fJJUt0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028D21F00A3D;
	Tue,  8 Sep 2026 22:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788908051;
	bh=rC3KTR8wKNZJq4+z6fa9JU5pOc3dbu/raUjaz9bdCpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M7fJJUt0vyC/vXlASyPqmTxAmCZM8GZEneLg0eAeLY8y35T2vO+hpJOmO676KnOUM
	 RRSW+u8PCNrp80xlYXkyRGgkiPYfszZOyiT7CTN0GAc1uPl9gNGr/j4eX9qccMCBSZ
	 pHp0p31M2lNmD7U2e1apr9ryh3ZdEayZDqGk80L/T22JF/kFtp6Cc9cukNFVGb1kGG
	 a9uhC8aopJZQ7Y2U9+rdV+H8MN4puhO5g833Ye4VLBI3bMkbqbLjbUnorC23JXp2Nc
	 p8fsmNKQRnwn0xDb5pGf3rECTdIvG4b87c6IuE2Gvc3hsPVQqzrO+hAkMAcD6LFKIE
	 X/BQsQOQax4xA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Ido Schimmel <idosch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] ip: orphan prefetched skbs before multicast forwarding
Date: Tue,  8 Sep 2026 18:54:08 -0400
Message-ID: <20260908225408.538794-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908225408.538794-1-sashal@kernel.org>
References: <2026090319-antiques-palm-c286@gregkh>
 <20260908225408.538794-1-sashal@kernel.org>
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
index 5e582eab1ea19..5ef20e8467e31 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2100,6 +2100,9 @@ int ip_mr_input(struct sk_buff *skb)
 	if (IPCB(skb)->flags & IPSKB_FORWARDED)
 		goto dont_forward;
 
+	if (!local)
+		skb_orphan(skb);
+
 	mrt = ipmr_rt_fib_lookup(net, skb);
 	if (IS_ERR(mrt)) {
 		kfree_skb(skb);
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 94d2ab8689d88..403697fa5569d 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -555,6 +555,7 @@ int ip6_mc_input(struct sk_buff *skb)
 		if (deliver) {
 			skb2 = skb_clone(skb, GFP_ATOMIC);
 		} else {
+			skb_orphan(skb);
 			skb2 = skb;
 			skb = NULL;
 		}
-- 
2.53.0

