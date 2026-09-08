Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD1C492E55
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 23:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788908552; cv=none; b=JPdr1tKez2ATUfTDhTbi5wJpnRXMRevG6NUq9bD+LmFJmE0ABZWcBHNmPoHI0lsQA+1ed6N9YxgD0i7708RULmfxvseqDrAB6N0+f72jY8SiMvxdm9qdPxy977D1qvnn9j775/5KtYEgB5nJLvRDSZHAxqVRPy387JIhcBfgppc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788908552; c=relaxed/simple;
	bh=DdAHUusZsgq8pC7zD4ogjrIO6qJ7TmVHXzBPBw7vdNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJdDqrO3OvbZiH8fidVYmAtJon3TxMxnMCxybg+CyxtkF9kXtl8oCKwTTYlnrevvSyIrVVAVdy43b/k7tBGl30FRqOQI60EEj34e0Lqigesq7+DuG4A7ZzPKYtNL86JvvFL9U8U8K5ur8u9J2uy5BF17lb9UEVyngVHT/j2H0Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhrEHiE/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhrEHiE/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2991F00A3E;
	Tue,  8 Sep 2026 23:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788908550;
	bh=F/4TJ8YWiDj6B2ND98+TmdBMLZsyxRBgeAucvzVBXFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mhrEHiE/9QJwMM8pU6HO3rv1aIZi2i8BwOtEh8FEIz6PXyeoFwWDSbM0GasL52gsX
	 xNdeJhpGcCf9Z3bLdzJlkjlhFwI0cYEhPSRTNgbz5yq1midhssBlce/SZFho29Jn9J
	 0gbt3qQqDZ32jO0+rCtK/mg7sG2zrPEPw2u5J4A39SsP/m0CXadOmgAVoIVkMKsrZR
	 zPzUqkGqH8g5mArb0o69RDT4pur0QUHYrD3tmSWQAyCsewwu38rXnlXu7KkEjLzJuQ
	 5Z7kdXbIwFmH5fh4FGXr7fokm0sUcbJGdPLzyNT0rshAAND5wKbAhNbcMA1S86Z04A
	 aN7t533flC/VA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Ido Schimmel <idosch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] ip: orphan prefetched skbs before multicast forwarding
Date: Tue,  8 Sep 2026 19:02:27 -0400
Message-ID: <20260908230227.559723-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908230227.559723-1-sashal@kernel.org>
References: <2026090320-tiptop-scrooge-9ea0@gregkh>
 <20260908230227.559723-1-sashal@kernel.org>
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
index 6e4f91e76e2d3..bd8d828818aac 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2112,6 +2112,9 @@ int ip_mr_input(struct sk_buff *skb)
 	if (IPCB(skb)->flags & IPSKB_FORWARDED)
 		goto dont_forward;
 
+	if (!local)
+		skb_orphan(skb);
+
 	mrt = ipmr_rt_fib_lookup(net, skb);
 	if (IS_ERR(mrt)) {
 		kfree_skb(skb);
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 493666b0c6098..db2f74f7ccd37 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -557,6 +557,7 @@ int ip6_mc_input(struct sk_buff *skb)
 		if (deliver) {
 			skb2 = skb_clone(skb, GFP_ATOMIC);
 		} else {
+			skb_orphan(skb);
 			skb2 = skb;
 			skb = NULL;
 		}
-- 
2.53.0

