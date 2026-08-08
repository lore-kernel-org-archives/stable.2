Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3043DB64E
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 12:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786192151; cv=none; b=on2cfZH2Z4vI76Ff2fhgKzH4ikKiU5S8sHEtkCJ+v+no+YV5pczvGGa/cxgjhi/smhVa+RBseFiNvHxBPwJ/8x7qhQkC4BjjJ1h6EgXw/cnoJixrqA0eoPCaVJqRnN/0be+rCl/pjtcurEm36wYwtVqTCLQ75h1dT3YcmOd2As0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786192151; c=relaxed/simple;
	bh=t1kLFfsUNSFnODtUmRCnU1jFTNfbZehiicktigqv61Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3HpPl4BUpSKNZaZhCo0EprrZxqYh/XS51Z6kobESNWxMsv5eH0JDo4/Ff09U/F5UChbPR24yg7THBVP87xMKvlf0y+to2affC9y4KwfysAUX4UkBLeh3XX3+lwDz0hSpnUKIacQEcKpP3sNfIlBM2mPRxWbKwe9vNJR7YpWKP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WysbK9oY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WysbK9oY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D251F00A3A;
	Sat,  8 Aug 2026 12:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786192148;
	bh=ps4mrHvVE9Y+18oDoNLBESaDh2eKvhJu0OspCyc/sxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WysbK9oYwHoKXmh+GTLEDKHu7LgcuYD8lKeMfYj7IXlBaof4/bBEuMZZq9B5M8G8N
	 lARI6nVolPvmRCMoVg2Jbrf4p76aUrklUn6PceIXZIDNi/pSuy/+UXCQgfxE2dBpwi
	 +OwYeXGLYYwuh3gljJAPN70WQNdOlEUm8xxDe5y8QunX3yCWzc2OadfderZ9P4NLQA
	 z8nx+5kF6DDjUaYfh0t2kvBA6f+LIWkynhT4tlZMXZtzrqc5iSm3F+s+5DLzH9TB5o
	 EqWix7hn5K2IYud+ijrEwOnH0RQ5xV7sNFiXH25AziGv5+HUaMgjXgDR4DYHWMwg3r
	 VWzAsW/S+NjQQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] net: move skb_gro_receive_list from udp to core
Date: Sat,  8 Aug 2026 08:29:04 -0400
Message-ID: <20260808122905.253730-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072946-scavenger-smelting-3d16@gregkh>
References: <2026072946-scavenger-smelting-3d16@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 8928756d53d5b99dcd18073dc7738b8ebdbe7d96 ]

This helper function will be used for TCP fraglist GRO support

Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: e751256486d0 ("net: gro: fix double aggregation of flush-marked skbs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/gro.h      |  1 +
 net/core/gro.c         | 29 +++++++++++++++++++++++++++++
 net/ipv4/udp_offload.c | 29 -----------------------------
 3 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index 9260ed367c919..439aa18578f69 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -442,6 +442,7 @@ static inline __wsum ip6_gro_compute_pseudo(struct sk_buff *skb, int proto)
 }
 
 int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb);
+int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb);
 
 /* Pass the currently batched GRO_NORMAL SKBs up to the stack. */
 static inline void gro_normal_list(struct napi_struct *napi)
diff --git a/net/core/gro.c b/net/core/gro.c
index 1555e6bb5c9d7..616b34275e356 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -230,6 +230,35 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 	return 0;
 }
 
+int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
+{
+	if (unlikely(p->len + skb->len >= 65536))
+		return -E2BIG;
+
+	if (NAPI_GRO_CB(p)->last == p)
+		skb_shinfo(p)->frag_list = skb;
+	else
+		NAPI_GRO_CB(p)->last->next = skb;
+
+	skb_pull(skb, skb_gro_offset(skb));
+
+	NAPI_GRO_CB(p)->last = skb;
+	NAPI_GRO_CB(p)->count++;
+	p->data_len += skb->len;
+
+	/* sk ownership - if any - completely transferred to the aggregated packet */
+	skb->destructor = NULL;
+	skb->sk = NULL;
+	p->truesize += skb->truesize;
+	p->len += skb->len;
+
+	skb_shinfo(p)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
+
+	NAPI_GRO_CB(skb)->same_flow = 1;
+
+	return 0;
+}
+
 
 static void napi_gro_complete(struct napi_struct *napi, struct sk_buff *skb)
 {
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 84ae2759ff195..3bf41cc2ff90d 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -525,35 +525,6 @@ static struct sk_buff *udp4_ufo_fragment(struct sk_buff *skb,
 	return segs;
 }
 
-static int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
-{
-	if (unlikely(p->len + skb->len >= 65536))
-		return -E2BIG;
-
-	if (NAPI_GRO_CB(p)->last == p)
-		skb_shinfo(p)->frag_list = skb;
-	else
-		NAPI_GRO_CB(p)->last->next = skb;
-
-	skb_pull(skb, skb_gro_offset(skb));
-
-	NAPI_GRO_CB(p)->last = skb;
-	NAPI_GRO_CB(p)->count++;
-	p->data_len += skb->len;
-
-	/* sk ownership - if any - completely transferred to the aggregated packet */
-	skb->destructor = NULL;
-	skb->sk = NULL;
-	p->truesize += skb->truesize;
-	p->len += skb->len;
-
-	skb_shinfo(p)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
-
-	NAPI_GRO_CB(skb)->same_flow = 1;
-
-	return 0;
-}
-
 
 #define UDP_GRO_CNT_MAX 64
 static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
-- 
2.53.0

