Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63D85519A9
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 22:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788908051; cv=none; b=dcU6jUnDUDZ2kUDy+XsjITekKEl+1m70/bDGSOhS3+miKzJnzMzwN1BcuJiTAMh888iYumusQ47hx4RXL468J9jr3YQE1pKGWgJ4DF3jHcw4IVO/gL4uDp/HDpFEocMR5NfcrNfQPRzJcI9e9YAT8wvr82w0VHh82JYxUcucroM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788908051; c=relaxed/simple;
	bh=hBo6+MWqIJJWTzo7AILGpg46kwem+BE6XaQLlEbFz4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQxvX1Q/iAbnueeaw4NSxuqQ31SRpmx0cbXpuqlkHbgtfZ3OobWettozIcQl8lJg2dUMzfhMy+NWYIcykR2XdFxuXpWepQ1r1rxEHmpUUZCawmT2EbG5onSxBOqL3wmhOgNX0S90Z/ogB26FYqYMVWZaCdNwJ3y2tLK5z3t3Es0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W577Pi2+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W577Pi2+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054FA1F00A3E;
	Tue,  8 Sep 2026 22:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788908049;
	bh=rC3KTR8wKNZJq4+z6fa9JU5pOc3dbu/raUjaz9bdCpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W577Pi2+rHQ2xX3462PEEo8jUPUDMpFScG2LbxlacO85f/HFbywYUW7PbUp+dssxf
	 2BTczqvGod6I9beBW/T2uayOsFbYSipSbjuldpNxCzIzr6HLptp3Xd/7yGooSowvth
	 raQVutPnnilj5cDBk6PjmJ8IEA2SlD1Lf1pv68f1UC09DGvHqjiNjT9cXcd5CigCq5
	 4fp+DtMBcAM6XcUIliXKJIAO9qHbauk0VdM90KRgUCO7JSAbes3FLHmksoN1d+IVt0
	 TrUvVH3gYRkHhlp2LSJBDyCXFkQVxzV9PJjcsPebP0Eoe9L/3lSyDmoZSx5GHh3XJ4
	 v76sERu+QxXFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Ido Schimmel <idosch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] ip: orphan prefetched skbs before multicast forwarding
Date: Tue,  8 Sep 2026 18:54:06 -0400
Message-ID: <20260908225406.538697-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908225406.538697-1-sashal@kernel.org>
References: <2026090319-antiques-palm-c286@gregkh>
 <20260908225406.538697-1-sashal@kernel.org>
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

