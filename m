Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D343566C6D
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 22:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907032; cv=none; b=e0bbJPnEdMmzC2zBUcmRXppZzBDxYHjwDFU3PfifwiHv9h/hYFG9O5nJteZAmlv0zwddObC+KKX6OuQN4Bc3YqUtCp962ik/3YfZGijD1BK8cYBjnsM4bKGfXGa/kgSfSbeJ6wremFuXO21BGcwe8AT1LvnRYDyHEFUjwTci6zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907032; c=relaxed/simple;
	bh=TpCiLhw4fC965Rb3IT12gy4z9e3Cbz/BZL2bV+6BlL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hBNimUnZnKw9KCrOCssdpaiNGOyuvdUS4fDfmxWoB70yDRXs6y8lVq9IKYzOnLbhVa97zT/a2PnYL3httiiXuCL5B71ineztXP2p7h7N2k4+OvLwmQe/nNz8jRobQNEhsfUr0tEwLNq0wPpaiZZZdpU0HIg/YE1ERJEDs9zV79Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLlxlaSg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLlxlaSg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675091F00A3F;
	Tue,  8 Sep 2026 22:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907029;
	bh=sKXNR+TbjXzGNdPDoWypRRG88bh3bxFz56y9jzrYimo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hLlxlaSgduWOvALvHk7nv5NJ/8J4WTE9B4zb9z++A4FGLUJlzYKWXJBVHtyrxQJ/Q
	 2w3MIqU9u6Es5sDQ+qX2DPX5KAAoUMNuiSVOaOCmIy1OOKiBFRY3owhpIOoJJjlJos
	 YFmF5MtzJuT/P5OgWYjTWQnqICEwLSep2wtDminFnhyOBqfZSn8UBMkMVzCE1Sl4mJ
	 T1SKp5fluTSYFEq9OnN0aO6LXa3DyYMh/4gRwVUhozPEOu/+0IeqF8vmGIN1TKxEHm
	 UHQ/xkTf87kAKbYyfCoxE385LykPxNEoT1H6iS+e8Aim9B/qAMwHIiePgbDWqkyeaB
	 /U3M8oDhl/EMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhiling Zou <zhilinz@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Ido Schimmel <idosch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] ip: orphan prefetched skbs before multicast forwarding
Date: Tue,  8 Sep 2026 18:37:05 -0400
Message-ID: <20260908223705.504692-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908223705.504692-1-sashal@kernel.org>
References: <2026090319-football-expel-7883@gregkh>
 <20260908223705.504692-1-sashal@kernel.org>
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
index f64651c0dea6c..948f6faf1d04f 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -2125,6 +2125,9 @@ int ip_mr_input(struct sk_buff *skb)
 	if (IPCB(skb)->flags & IPSKB_FORWARDED)
 		goto dont_forward;
 
+	if (!local)
+		skb_orphan(skb);
+
 	mrt = ipmr_rt_fib_lookup(net, skb);
 	if (IS_ERR(mrt)) {
 		kfree_skb(skb);
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index a341427a5fa43..614998b5af2d4 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -572,6 +572,7 @@ int ip6_mc_input(struct sk_buff *skb)
 		if (deliver) {
 			skb2 = skb_clone(skb, GFP_ATOMIC);
 		} else {
+			skb_orphan(skb);
 			skb2 = skb;
 			skb = NULL;
 		}
-- 
2.53.0

