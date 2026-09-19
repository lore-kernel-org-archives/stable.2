Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E285747C11B
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 11:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789816502; cv=none; b=TZkHFTJyF9fO//MwrCxFyDVkKh60/IE4YLPrCmf27MuHzxgjlpV3KjVLtl76+bjJb0Nmx5xDhSuaub+33fbZCoUgxbcAaHDDiTSoZfqzZ7Vr5hnNJ0rGvg1UaJ0LQ/gxROe+OdVYl26nR7BlSXzNAsgwzjGb5l03zfvjelkfyH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789816502; c=relaxed/simple;
	bh=dDiCOwJir3Eow7H+h3CMZcFK5UZECcB7tDkkWLhriEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIR7QrNph4lpjtuKYHYukUWKzmWMaJiuIY0L/z3PXzGFdnqUdI69FQ+fbAMz2Xs1u4YYEAUImdh3YJmYQOYdnxOSkhUt8r70YfMGe+oZ5ZYBevYQWk5oE14usLMInF+DoGdbETGLrxZoWbQs3EfyrCJkMax1CatOSeilqT/1qdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=CcQAWZ5q; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="CcQAWZ5q"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so1437719a91.1
        for <stable@vger.kernel.org>; Sat, 19 Sep 2026 04:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789816500; x=1790421300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rc6fcGKG41jrJsPUXiJFHSOZ1LLRuaRlU1RnZpipMiU=;
        b=CcQAWZ5q+k45DDZiJLKdclVYXOc+6E6Cd4nX+bfBmyixaqSO8SsrWxGMsNE/ikI4re
         anMBx30NPgExDMaLxVTHttDEMROp6cxE/AH6MB51TOfeZogiw8Txi+vJ8PHBdWgTDc3E
         iRntSgh6PafZRHPpv7xlNbC5B4LbkQr66MWuTck8TkocUEPfaxtavBIN48V24OQrVhIl
         DcmC6gVsW4QOQyiivOsZTMJMJHKU72fD1uVALG1XFxP1iTJXqVEsOPe6PEkYD9Yw7uil
         wabf0oS6keCG5Bpq6fK6AKX0CDch0locRVkMrr9ji22ocvSxNR/NqofcX4gl4RU84HD4
         opGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789816500; x=1790421300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rc6fcGKG41jrJsPUXiJFHSOZ1LLRuaRlU1RnZpipMiU=;
        b=DYfKKkvhwP/h2e8+wy/54SUQm0+8FBXXPgXAnibY8kKO+puME3aZSmEcInjYnbrP5m
         T92XdYliS+lJVj7DSeFsmnDUMgIjmksFWvr6EGZChE/SMbNuzCUksKUcwU0i7IqT1LFE
         z88oC7uNVJ2uOXDf1u5ZzL2gRSKPKO0Ctqny2mnZKPx3MJOu1J0odlIeOstYcbyWc3r6
         nfdX4HmtEEcsZksvGJgZn2C0ZrkXkd+kwKOnlJQTh6ufLczjAR5AH9QiZDGacJ9UO5x6
         6Pum5hdvvyBnkKHBG6jZPkQAp2WxOv0LXAl9vgVLdLmBuatLlzmwC9htw3Y09Mmwdz8l
         5dgA==
X-Forwarded-Encrypted: i=1; AKwUvBxPuDwDxbHh5lLiD6CILCH46KVwuW+wq/M9OMRRIpQlZTNhchvKxCEoqls+qubM24t/9oUtqg0=@vger.kernel.org
X-Gm-Message-State: AFuF++nnZdLhTLEX2EjnKJ7GkOFrUFIBsOiUzOoYp0TGhVVER5iJnYMc
	Wlj76hFVoZ3461DseDFVrDTY5s6KKUKOSmBleX2bA6n5XR4BaLl2Jzbw2StIVo75QGFB
X-Gm-Gg: AYBFou2hHK+aqPFAbWc/d3hrvmpoIEqOe7ozwf4HoE1jrb0oHJg8n+vyCG2ueJo1EeH
	91a61v301ti+iFFqEXLzV0b9hZUqA+IFEdwviYCDG9PnhTfnU5Myfe5mSlMWuLn4SsITA4c3eNp
	ywP3LbAYBdh3VpOW1Ow1L9zIkrH+ZyCtK1cwiN3qqbVPaMVVsWDra9HqD7Rdmwbm7YApRF5itKL
	qdb98hMzgFl3R/xYCHlfUmW9H1TtbedW7dMduZBQxmuB67hhq5ja/OwSI6GDT4Q/nQscVsNNfGi
	s1H4Cqe8KUtP28QsxX+jdwe1g7fdvEkGJieebllPv2sKDFCHcm3nmgCC4bn4Yvc0v1w3Q2xoj99
	KQty39u3toZbrCApKVxSBBQbrNczMrfFWU2Fhs2UD9tAWB2PIfine2TLj+s09v9HYPKYLW1N8dF
	PBEisaSzrexmk8A8X/Fj01nR2BTrylyB/nWMwvW1eBdvJg9fgH4/S95xGkpyHeOmS0D5bYoDspq
	qFTr8aPzuJ3G+xGSsP6cwr65dG/UA==
X-Received: by 2002:a17:90a:da8d:b0:39e:6a81:5a92 with SMTP id 98e67ed59e1d1-39e6a815df2mr3737041a91.38.1789816500229;
        Sat, 19 Sep 2026 04:15:00 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0290e844esm531163a91.2.2026.09.19.04.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 04:14:59 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: zihanx@nebusec.ai,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	dsahern@kernel.org,
	idosch@nvidia.com,
	willemb@google.com,
	kuniyu@google.com,
	kees@kernel.org,
	richardbgobert@gmail.com,
	alice.kernel@fastmail.im,
	gal@nvidia.com,
	jibin.zhang@mediatek.com,
	luoxuanqiang@kylinos.cn,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>
Subject: [PATCH net v3 1/1] net: gso: limit recursive IP-in-IP segmentation
Date: Sat, 19 Sep 2026 11:14:40 +0000
Message-ID: <43510074c063f57e5738ecc55057e7fbbcdb1fbc.1789802623.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1789802623.git.zihanx@nebusec.ai>
References: <cover.1789802623.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPIP GSO/TSO support makes IP-in-IP GSO dispatch re-enter
inet_gso_segment() or ipv6_gso_segment() for every nested IP header. The
only state that tracks this nesting is encap_level, which records header
bytes and has no recursion bound. A sufficiently deep chain can consume the
kernel stack before a transport GSO callback is reached.

The unbounded callback nesting was introduced when inet_gso_segment() was
made stackable by "ipv4: gso: make inet_gso_segment() stackable". GRE GSO
support predated that change, and IP-in-IP GSO/TSO support later made the
affected path reachable.

The corresponding IPv6 stackable path was introduced separately by
"ipv6: gso: make ipv6_gso_segment() stackable". This patch uses the same
budget for IPv6, but the Fixes tag covers the IPv4 root cause only.

Limit the cumulative header budget for a GSO operation to GSO_MAX_HEADER
(256 bytes). Keep the consumed budget in skb_gso_cb and charge each header
before dispatching the next GSO callback. The callback wrapper checks the
same state, so direct IP handler re-entry and nested tunnel dispatch share
one monotonic budget. GRE and UDP context resets cannot restart it before
an inner GSO callback; other GSO tunnel and extension handlers charge their
stripped headers before inner dispatch as well.

GSO_MAX_HEADER is a practical header budget, not a measured stack-overflow
threshold or an architecture-independent stack-safety proof. With a zero
initial offset, 12 minimum-sized IPv4 headers consume 240 bytes; the next
header is rejected. IPv6 base headers, extension headers, and tunnel
headers use the budget faster. Validation of the preceding
implementation on x86_64 used a 16 KiB task stack and completed without a
stack-guard fault, but this does not establish a uniform margin for
architectures with smaller stacks.

Fixes: 3347c9602955 ("ipv4: gso: make inet_gso_segment() stackable")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>

---
changes in v3:
  - Treat an exhausted 256-byte budget as a callback-entry failure, including
    the zero-length check used by the common callback wrapper and IP handlers.
  - v2 Link: https://lore.kernel.org/all/cover.1789618203.git.zihanx@nebusec.ai/
changes in v2:
  - Replace the callback counter with a cumulative 256-byte header budget
    carried in skb_gso_cb.
  - Apply the budget at common callback entry and across IP, GRE, UDP, MPLS,
    NSH, ESP, and IPv6 extension dispatch, including GRE/UDP context resets.
  - Rebase the UDP hunk onto selected revision c9151088f167 and rerun both
    IPv4 PoCs; use the decoded crash evidence from unpatched 88c17de85ddb.
  - v1 Link: https://lore.kernel.org/all/cover.1789302084.git.zihanx@nebusec.ai/
 include/net/gso.h       | 29 +++++++++++++++++++++++++++++
 net/core/gso.c          |  7 +++++--
 net/ipv4/af_inet.c      |  7 ++++++-
 net/ipv4/esp4_offload.c |  9 +++++++--
 net/ipv4/gre_offload.c  |  2 ++
 net/ipv4/udp_offload.c  |  4 +++-
 net/ipv6/esp6_offload.c |  9 +++++++--
 net/ipv6/ip6_offload.c  | 11 ++++++++++-
 net/mpls/mpls_gso.c     |  2 ++
 net/nsh/nsh.c           |  2 ++
 10 files changed, 73 insertions(+), 9 deletions(-)

diff --git a/include/net/gso.h b/include/net/gso.h
index 2997544..bd3b3eb 100644
--- a/include/net/gso.h
+++ b/include/net/gso.h
@@ -19,10 +19,39 @@ struct skb_gso_cb {
 	int	encap_level;
 	__wsum	csum;
 	__u16	csum_start;
+	/* Bytes charged to the current GSO callback chain. */
+	u16	gso_header_len;
 };
 #define SKB_GSO_CB_OFFSET	32
 #define SKB_GSO_CB(skb) ((struct skb_gso_cb *)((skb)->cb + SKB_GSO_CB_OFFSET))
 
+#define GSO_MAX_HEADER	256
+
+static inline bool gso_header_len_add(struct sk_buff *skb,
+					       unsigned int len)
+{
+	struct skb_gso_cb *cb = SKB_GSO_CB(skb);
+
+	if (unlikely(cb->gso_header_len >= GSO_MAX_HEADER ||
+		     len > GSO_MAX_HEADER - cb->gso_header_len))
+		return true;
+
+	cb->gso_header_len += len;
+	return false;
+}
+
+static inline struct sk_buff *
+skb_gso_segment_cb(struct sk_buff *skb,
+			struct sk_buff *(*gso_segment)(struct sk_buff *,
+						netdev_features_t),
+			netdev_features_t features)
+{
+	if (unlikely(gso_header_len_add(skb, 0)))
+		return ERR_PTR(-EINVAL);
+
+	return gso_segment(skb, features);
+}
+
 static inline int skb_tnl_header_len(const struct sk_buff *inner_skb)
 {
 	return (skb_mac_header(inner_skb) - inner_skb->head) -
diff --git a/net/core/gso.c b/net/core/gso.c
index bcd1563..4b6cba2 100644
--- a/net/core/gso.c
+++ b/net/core/gso.c
@@ -19,7 +19,8 @@ struct sk_buff *skb_eth_gso_segment(struct sk_buff *skb,
 	rcu_read_lock();
 	list_for_each_entry_rcu(ptype, &net_hotdata.offload_base, list) {
 		if (ptype->type == type && ptype->callbacks.gso_segment) {
-			segs = ptype->callbacks.gso_segment(skb, features);
+			segs = skb_gso_segment_cb(skb, ptype->callbacks.gso_segment,
+						    features);
 			break;
 		}
 	}
@@ -50,7 +51,8 @@ struct sk_buff *skb_mac_gso_segment(struct sk_buff *skb,
 	rcu_read_lock();
 	list_for_each_entry_rcu(ptype, &net_hotdata.offload_base, list) {
 		if (ptype->type == type && ptype->callbacks.gso_segment) {
-			segs = ptype->callbacks.gso_segment(skb, features);
+			segs = skb_gso_segment_cb(skb, ptype->callbacks.gso_segment,
+						    features);
 			break;
 		}
 	}
@@ -117,6 +119,7 @@ struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
 
 	SKB_GSO_CB(skb)->mac_offset = skb_headroom(skb);
 	SKB_GSO_CB(skb)->encap_level = 0;
+	SKB_GSO_CB(skb)->gso_header_len = 0;
 
 	skb_reset_mac_header(skb);
 	skb_reset_mac_len(skb);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 32d006c..1a4aa95 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1375,6 +1375,8 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 	int id;
 
 	skb_reset_network_header(skb);
+	if (unlikely(gso_header_len_add(skb, 0)))
+		goto out;
 	nhoff = skb_network_header(skb) - skb_mac_header(skb);
 	if (unlikely(!pskb_may_pull(skb, sizeof(*iph))))
 		goto out;
@@ -1390,6 +1392,8 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 	/* Warning: after this point, iph might be no longer valid */
 	if (unlikely(!pskb_may_pull(skb, ihl)))
 		goto out;
+	if (unlikely(gso_header_len_add(skb, ihl)))
+		goto out;
 	__skb_pull(skb, ihl);
 
 	encap = SKB_GSO_CB(skb)->encap_level > 0;
@@ -1408,7 +1412,8 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 
 	ops = rcu_dereference(inet_offloads[proto]);
 	if (likely(ops && ops->callbacks.gso_segment)) {
-		segs = ops->callbacks.gso_segment(skb, features);
+		segs = skb_gso_segment_cb(skb, ops->callbacks.gso_segment,
+					   features);
 		if (!segs)
 			skb->network_header = skb_mac_header(skb) + nhoff - skb->head;
 	}
diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index abd7716..11311c7 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -141,7 +141,8 @@ static struct sk_buff *xfrm4_transport_gso_segment(struct xfrm_state *x,
 	skb->transport_header += x->props.header_len;
 	ops = rcu_dereference(inet_offloads[xo->proto]);
 	if (likely(ops && ops->callbacks.gso_segment))
-		segs = ops->callbacks.gso_segment(skb, features);
+		segs = skb_gso_segment_cb(skb, ops->callbacks.gso_segment,
+					   features);
 
 	return segs;
 }
@@ -182,7 +183,8 @@ static struct sk_buff *xfrm4_beet_gso_segment(struct xfrm_state *x,
 	__skb_pull(skb, skb_transport_offset(skb));
 	ops = rcu_dereference(inet_offloads[proto]);
 	if (likely(ops && ops->callbacks.gso_segment))
-		segs = ops->callbacks.gso_segment(skb, features);
+		segs = skb_gso_segment_cb(skb, ops->callbacks.gso_segment,
+					   features);
 
 	return segs;
 }
@@ -229,6 +231,9 @@ static struct sk_buff *esp4_gso_segment(struct sk_buff *skb,
 
 	if (!pskb_may_pull(skb, sizeof(*esph) + crypto_aead_ivsize(aead)))
 		return ERR_PTR(-EINVAL);
+	if (unlikely(gso_header_len_add(skb,
+				 sizeof(*esph) + crypto_aead_ivsize(aead))))
+		return ERR_PTR(-EINVAL);
 
 	__skb_pull(skb, sizeof(*esph) + crypto_aead_ivsize(aead));
 
diff --git a/net/ipv4/gre_offload.c b/net/ipv4/gre_offload.c
index 5028c72..a973b55 100644
--- a/net/ipv4/gre_offload.c
+++ b/net/ipv4/gre_offload.c
@@ -32,6 +32,8 @@ static struct sk_buff *gre_gso_segment(struct sk_buff *skb,
 
 	if (unlikely(!pskb_may_pull(skb, tnl_hlen)))
 		goto out;
+	if (unlikely(gso_header_len_add(skb, tnl_hlen)))
+		goto out;
 
 	/* setup inner skb. */
 	skb->encapsulation = 0;
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index cf07c3c..bcba85c 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -188,6 +188,8 @@ static struct sk_buff *__skb_udp_tunnel_segment(struct sk_buff *skb,
 
 	if (unlikely(!pskb_may_pull(skb, tnl_hlen)))
 		goto out;
+	if (unlikely(gso_header_len_add(skb, tnl_hlen)))
+		goto out;
 
 	uh = udp_hdr(skb);
 
@@ -242,7 +244,7 @@ static struct sk_buff *__skb_udp_tunnel_segment(struct sk_buff *skb,
 	}
 
 	/* segment inner packet. */
-	segs = gso_inner_segment(skb, features);
+	segs = skb_gso_segment_cb(skb, gso_inner_segment, features);
 	if (IS_ERR_OR_NULL(segs)) {
 		skb_gso_error_unwind(skb, protocol, tnl_hlen, mac_offset,
 				     mac_len);
diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index 2289552..ab86136 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -177,7 +177,8 @@ static struct sk_buff *xfrm6_transport_gso_segment(struct xfrm_state *x,
 	skb->transport_header += x->props.header_len;
 	ops = rcu_dereference(inet6_offloads[xo->proto]);
 	if (likely(ops && ops->callbacks.gso_segment))
-		segs = ops->callbacks.gso_segment(skb, features);
+		segs = skb_gso_segment_cb(skb, ops->callbacks.gso_segment,
+					   features);
 
 	return segs;
 }
@@ -222,7 +223,8 @@ static struct sk_buff *xfrm6_beet_gso_segment(struct xfrm_state *x,
 	__skb_pull(skb, skb_transport_offset(skb));
 	ops = rcu_dereference(inet6_offloads[proto]);
 	if (likely(ops && ops->callbacks.gso_segment))
-		segs = ops->callbacks.gso_segment(skb, features);
+		segs = skb_gso_segment_cb(skb, ops->callbacks.gso_segment,
+					   features);
 
 	return segs;
 }
@@ -269,6 +271,9 @@ static struct sk_buff *esp6_gso_segment(struct sk_buff *skb,
 
 	if (!pskb_may_pull(skb, sizeof(*esph) + crypto_aead_ivsize(aead)))
 		return ERR_PTR(-EINVAL);
+	if (unlikely(gso_header_len_add(skb,
+				 sizeof(*esph) + crypto_aead_ivsize(aead))))
+		return ERR_PTR(-EINVAL);
 
 	__skb_pull(skb, sizeof(*esph) + crypto_aead_ivsize(aead));
 
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 78f50c9..b53c542 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -79,6 +79,8 @@ static int ipv6_gso_pull_exthdrs(struct sk_buff *skb, int proto)
 
 		if (unlikely(!pskb_may_pull(skb, len)))
 			break;
+		if (unlikely(gso_header_len_add(skb, len)))
+			return -EINVAL;
 
 		opth = (void *)skb->data;
 		proto = opth->nexthdr;
@@ -104,9 +106,13 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 	bool gso_partial;
 
 	skb_reset_network_header(skb);
+	if (unlikely(gso_header_len_add(skb, 0)))
+		goto out;
 	nhoff = skb_network_header(skb) - skb_mac_header(skb);
 	if (unlikely(!pskb_may_pull(skb, sizeof(*ipv6h))))
 		goto out;
+	if (unlikely(gso_header_len_add(skb, sizeof(*ipv6h))))
+		goto out;
 
 	encap = SKB_GSO_CB(skb)->encap_level > 0;
 	if (encap)
@@ -118,6 +124,8 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 	segs = ERR_PTR(-EPROTONOSUPPORT);
 
 	proto = ipv6_gso_pull_exthdrs(skb, ipv6h->nexthdr);
+	if (unlikely(proto < 0))
+		goto out;
 
 	if (skb->encapsulation &&
 	    skb_shinfo(skb)->gso_type & (SKB_GSO_IPXIP4 | SKB_GSO_IPXIP6))
@@ -132,7 +140,8 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 		if (!skb_reset_transport_header_careful(skb))
 			goto out;
 
-		segs = ops->callbacks.gso_segment(skb, features);
+		segs = skb_gso_segment_cb(skb, ops->callbacks.gso_segment,
+					   features);
 		if (!segs)
 			skb->network_header = skb_mac_header(skb) + nhoff - skb->head;
 	}
diff --git a/net/mpls/mpls_gso.c b/net/mpls/mpls_gso.c
index 34ab659..a535f49 100644
--- a/net/mpls/mpls_gso.c
+++ b/net/mpls/mpls_gso.c
@@ -36,6 +36,8 @@ static struct sk_buff *mpls_gso_segment(struct sk_buff *skb,
 		goto out;
 	if (unlikely(!pskb_may_pull(skb, mpls_hlen)))
 		goto out;
+	if (unlikely(gso_header_len_add(skb, mpls_hlen)))
+		goto out;
 
 	/* Setup inner SKB. */
 	mpls_protocol = skb->protocol;
diff --git a/net/nsh/nsh.c b/net/nsh/nsh.c
index bfb7758..49d1628 100644
--- a/net/nsh/nsh.c
+++ b/net/nsh/nsh.c
@@ -95,6 +95,8 @@ static struct sk_buff *nsh_gso_segment(struct sk_buff *skb,
 		goto out;
 	if (unlikely(!pskb_may_pull(skb, nsh_len)))
 		goto out;
+	if (unlikely(gso_header_len_add(skb, nsh_len)))
+		goto out;
 
 	proto = tun_p_to_eth_p(nsh_hdr(skb)->np);
 	if (!proto)
-- 
2.55.0.windows.3
