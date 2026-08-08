Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8176419310
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786198185; cv=none; b=iQf/t4sZdaJFM3Ar64RVJjxIuklW7RUmO23K1Qj0Fl98I3DtMJuVM+mlOW3r++u1GX4fVw9KhahDhvX7cQ1OE0E7kxsB79iv8UyjtKfuua7juBkkwKJONuWdKQhlTIjrodrMJZNpnL4OJgJFnMvaEeRlLjH1XYNG7K59FjZYjpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786198185; c=relaxed/simple;
	bh=fJTGi7pr/UBwnaw7EbPefbNQYSYeFWYEbuChFS1gAHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IiUy2lfeQtyq8L/YasCG6celVskFNOv0iEWsvAI50eoxzjT5WS9a8VpRnWEmEljRZiutLq2HRJ8khLunL6wlaQlfNK6+V14gZuIa+4kQEA1AoqtBVOyw9ym1wVgqattV9cUGZsCYFqbUuuz+lu34GG9asHxYYZ2XWlgWlu5lPDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIk0aiVm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIk0aiVm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDEDF1F000E9;
	Sat,  8 Aug 2026 14:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786198183;
	bh=nXb6T/P5gQRNLP5K34mScI3/IgE4qOFTdYiENXDvjHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PIk0aiVmK0dH8moJyc9LytlANkYPW9y9a+Lx30Dvvp3ha7jshCShklhQbZCLEae2B
	 cV9vyMqSj5J8XJ+gklALhtdu7QQpSE+tiwHmfb+EXVe3KykiIvOxoPWXav/8FNNH7l
	 HIKWm/4doHFAaJ5/klXQsoy8KLdXEZqzkd4ZDjaoyxIDNjR4p+tElQDPGsq5jPfJz+
	 cLVVyzEMyCZX1Zzils+W5Gg0gEGBE+2zd0QkQ60mLE34scrSohVyOW5IkOZxxdxxDC
	 6zFIW7rTPf0N0JdBvoMocPBg9OcAEYR1Np0hswfuhhI23V9HosN20JuxzusBfSHxmQ
	 BeucZkDY0nc8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] net: move skb_gro_receive_list from udp to core
Date: Sat,  8 Aug 2026 10:09:40 -0400
Message-ID: <20260808140941.339987-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072946-itunes-reviver-5817@gregkh>
References: <2026072946-itunes-reviver-5817@gregkh>
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
index a4fab706240d2..cc12df2009978 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -424,6 +424,7 @@ static inline __wsum ip6_gro_compute_pseudo(struct sk_buff *skb, int proto)
 }
 
 int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb);
+int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb);
 
 /* Pass the currently batched GRO_NORMAL SKBs up to the stack. */
 static inline void gro_normal_list(struct napi_struct *napi)
diff --git a/net/core/gro.c b/net/core/gro.c
index c5a9733d929a9..79e81889fcc4d 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -295,6 +295,35 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
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
index 35c014e10f24b..d25a1e3029632 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -524,35 +524,6 @@ static struct sk_buff *udp4_ufo_fragment(struct sk_buff *skb,
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

