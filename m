Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ECD4FDE58
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660867; cv=none; b=Pxt0ur2XqoOM7nnnwgL0i/evdD4Q1SSTEmW4M6Ehx4qJOmtsFUbXn70zNnh7FrpQRBApHIl2fNzzw/JRRBB19NzxQ3dE7fFnnu1KynUpw6sx0HXOg7fPeMOEKJy4OCDEwbrOlFu+w1wybBSX3qJLeS5pPFExvrH734LNUa7MXz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660867; c=relaxed/simple;
	bh=dvh6b0KVOVdO6czJGXIWw6LrWejSjZKAVEyry5ExqTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nw0OS17NO+2CVqJUPKwQHVcifYD121FczFEE3dDJDck8Dxix3DMQS/duGjvfpLwaVw9bEkklhckId/AX/UnjXtuWtPvBKoIS8jZ+oy8UZOLWk1XeFbdSCNDCUXVgLuu18o958RtPS1RYfZB+YTVmGBtV90hJ4ZbBuI9v65xFECc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=YFl2stht; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="YFl2stht"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc147d86bebso1136262a12.0
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 09:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789660864; x=1790265664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZlZva5hZIzVbLlSUggdob5VRIXbC2xuvTEYkKIZQZEQ=;
        b=YFl2sthtspNz/La08f9YNpJH7Pebu0lYGR2HpRom3GIpS1LATUotuoGvfGCjQ1BlR8
         xpmjxYFHFY5BoydDp49U/LI/EwLzH1ommmtZ/3I38r8RA7spRckWvS97XgTMSViswZPa
         T5+FBLt+JabT5BSGabSEaulQHDQ9RrmcUBsOKqjN+R1CWHMYjM/+oBRpCw0JNil6G4jj
         22huUx4PsiUu+jYy93B3AqhsPCk4NU+SUqjCFJiXBuQiDnyVU1+G366nmgKs6sV70kuQ
         vcrcDznQkFivkTNvDTxQUiH4CqrmVBzULT6EioROSAOrHoabw9Nv38IddMeCtBCjz2fV
         U0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789660864; x=1790265664;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZlZva5hZIzVbLlSUggdob5VRIXbC2xuvTEYkKIZQZEQ=;
        b=YRMZ+pqEras8pyHkYbWnU1ToGfWY3PA7gdVmG96+vd1gGVREFISnOpkqc4xB61X3+n
         rxBQf1X/02WhMnWXnPALbwQ1vMlFwNHERpFc7qrf+gOAM+HW59AT9z/UEKddFzffKJVb
         BtbQ/8ay1DHEkmw54G0yMpQQytR3r15NWfMYkG7AC027OonBQ8e5ZWZX4rlC6qxSbUbo
         h/vyXMqa9yFAE2o0tVolTl3z3C+7kTFSCUZRpX2xCAQnnGQGnyT82ewAkFp9pek41SfR
         cOmpvytqFg5dfRE44kSJnZaptWl8sFcsO3QJ7674RzeSRAYZuop2anok7sXyL7BysmXu
         XYNA==
X-Forwarded-Encrypted: i=1; AKwUvBxaHraWE7zZJAgQdhRR8maJyPKsa7ZbFC88oIsXhj4g/Oscb6VZN8BG6uxJccAmptnlCf2XT4Y=@vger.kernel.org
X-Gm-Message-State: AFuF++l1e83oesRFfrkHRGgGBKGzmBnKKCjRoVxs5kwKAltmgoHiSE+z
	7ySt4pXoPPz74WcbqF4b40SKOMEzfiTYWwSL0/ngwU3hubfiN67TffxlUqS+QEF/1C1y
X-Gm-Gg: AYBFou14jDvLYvK3w3KK07gyULUMiZjHAfGuHOCwz1lC6WzWQ8bUyXz8JYQ8OZFMqAc
	qtcB+mB0gi6ZEeICFa9bjzC/THH1ZV7Hn6Y5xCBaNDg2V8a2vn4B6kQKDiz/8BpdXyvzDsQhtMi
	sE64y/AzXyK92tAkv5/jr2ddsFDFHdaukrhkNm2Bib96NaQL58EHRrG0zBC35nFgmfXq1VpOz2O
	RXz6AQhkoMDJlFLZkkxSbUt9kvVjhDsZM8aRtZIOAzjcpV5pj1Rw9lSxwcdm+r2kGpA62BgaMiK
	U4V9T5QzNKpk+Ko86iIejeonaL0EFCgRhjaCvbqXXP0zf19leSkFnJe5K63bO+C9bfZCe5avc98
	76OV/dOoYMyPwcs0+p2RhfkzoiqO/668pz5t8d/gf5XZE50Pki5CkYMMECVsE0EXtEEt0oBvHcf
	8TEOB6LYAChB6elZyswFbbEHeUNbQKk1H+OOA41aglvdUA+R06Gj4J7zbRacjnSzBXrHz5r+/rE
	BG0Shyt8SO7pWyhfbbIlYaB9zMoOO9hrI9e2tDv
X-Received: by 2002:a05:6a20:6a1d:b0:3bf:8a0e:dd99 with SMTP id adf61e73a8af0-3dd7263a165mr6355995637.17.1789660863994;
        Thu, 17 Sep 2026 09:01:03 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50c24487bsm3182043a12.12.2026.09.17.09.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 09:01:02 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/1] net: gso: limit recursive IP-in-IP segmentation
Date: Thu, 17 Sep 2026 16:00:41 +0000
Message-ID: <33280f6e07bccaaeef2c70f1754017e9517f5aa5.1789618203.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1789618203.git.zihanx@nebusec.ai>
References: <cover.1789618203.git.zihanx@nebusec.ai>
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
index 29975440c..c3d38f838 100644
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
+				      unsigned int len)
+{
+	struct skb_gso_cb *cb = SKB_GSO_CB(skb);
+
+	if (unlikely(cb->gso_header_len > GSO_MAX_HEADER ||
+		     len > GSO_MAX_HEADER - cb->gso_header_len))
+		return true;
+
+	cb->gso_header_len += len;
+	return false;
+}
+
+static inline struct sk_buff *
+skb_gso_segment_cb(struct sk_buff *skb,
+		   struct sk_buff *(*gso_segment)(struct sk_buff *,
+						  netdev_features_t),
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
index bcd156372..68e4acc11 100644
--- a/net/core/gso.c
+++ b/net/core/gso.c
@@ -19,7 +19,8 @@ struct sk_buff *skb_eth_gso_segment(struct sk_buff *skb,
 	rcu_read_lock();
 	list_for_each_entry_rcu(ptype, &net_hotdata.offload_base, list) {
 		if (ptype->type == type && ptype->callbacks.gso_segment) {
-			segs = ptype->callbacks.gso_segment(skb, features);
+			segs = skb_gso_segment_cb(skb, ptype->callbacks.gso_segment,
+						  features);
 			break;
 		}
 	}
@@ -50,7 +51,8 @@ struct sk_buff *skb_mac_gso_segment(struct sk_buff *skb,
 	rcu_read_lock();
 	list_for_each_entry_rcu(ptype, &net_hotdata.offload_base, list) {
 		if (ptype->type == type && ptype->callbacks.gso_segment) {
-			segs = ptype->callbacks.gso_segment(skb, features);
+			segs = skb_gso_segment_cb(skb, ptype->callbacks.gso_segment,
+						  features);
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
index 32d006c1a..415274d49 100644
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
+					  features);
 		if (!segs)
 			skb->network_header = skb_mac_header(skb) + nhoff - skb->head;
 	}
diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index abd77162f..cb2c4bbe6 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -141,7 +141,8 @@ static struct sk_buff *xfrm4_transport_gso_segment(struct xfrm_state *x,
 	skb->transport_header += x->props.header_len;
 	ops = rcu_dereference(inet_offloads[xo->proto]);
 	if (likely(ops && ops->callbacks.gso_segment))
-		segs = ops->callbacks.gso_segment(skb, features);
+		segs = skb_gso_segment_cb(skb, ops->callbacks.gso_segment,
+					  features);
 
 	return segs;
 }
@@ -182,7 +183,8 @@ static struct sk_buff *xfrm4_beet_gso_segment(struct xfrm_state *x,
 	__skb_pull(skb, skb_transport_offset(skb));
 	ops = rcu_dereference(inet_offloads[proto]);
 	if (likely(ops && ops->callbacks.gso_segment))
-		segs = ops->callbacks.gso_segment(skb, features);
+		segs = skb_gso_segment_cb(skb, ops->callbacks.gso_segment,
+					  features);
 
 	return segs;
 }
@@ -229,6 +231,9 @@ static struct sk_buff *esp4_gso_segment(struct sk_buff *skb,
 
 	if (!pskb_may_pull(skb, sizeof(*esph) + crypto_aead_ivsize(aead)))
 		return ERR_PTR(-EINVAL);
+	if (unlikely(gso_header_len_add(skb,
+					sizeof(*esph) + crypto_aead_ivsize(aead))))
+		return ERR_PTR(-EINVAL);
 
 	__skb_pull(skb, sizeof(*esph) + crypto_aead_ivsize(aead));
 
diff --git a/net/ipv4/gre_offload.c b/net/ipv4/gre_offload.c
index 5028c72d4..a973b552b 100644
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
index cf07c3c66..bcba85c6c 100644
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
index 22895521a..9f4fc9dae 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -177,7 +177,8 @@ static struct sk_buff *xfrm6_transport_gso_segment(struct xfrm_state *x,
 	skb->transport_header += x->props.header_len;
 	ops = rcu_dereference(inet6_offloads[xo->proto]);
 	if (likely(ops && ops->callbacks.gso_segment))
-		segs = ops->callbacks.gso_segment(skb, features);
+		segs = skb_gso_segment_cb(skb, ops->callbacks.gso_segment,
+					  features);
 
 	return segs;
 }
@@ -222,7 +223,8 @@ static struct sk_buff *xfrm6_beet_gso_segment(struct xfrm_state *x,
 	__skb_pull(skb, skb_transport_offset(skb));
 	ops = rcu_dereference(inet6_offloads[proto]);
 	if (likely(ops && ops->callbacks.gso_segment))
-		segs = ops->callbacks.gso_segment(skb, features);
+		segs = skb_gso_segment_cb(skb, ops->callbacks.gso_segment,
+					  features);
 
 	return segs;
 }
@@ -269,6 +271,9 @@ static struct sk_buff *esp6_gso_segment(struct sk_buff *skb,
 
 	if (!pskb_may_pull(skb, sizeof(*esph) + crypto_aead_ivsize(aead)))
 		return ERR_PTR(-EINVAL);
+	if (unlikely(gso_header_len_add(skb,
+					sizeof(*esph) + crypto_aead_ivsize(aead))))
+		return ERR_PTR(-EINVAL);
 
 	__skb_pull(skb, sizeof(*esph) + crypto_aead_ivsize(aead));
 
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 78f50c93c..2182e77ae 100644
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
+					  features);
 		if (!segs)
 			skb->network_header = skb_mac_header(skb) + nhoff - skb->head;
 	}
diff --git a/net/mpls/mpls_gso.c b/net/mpls/mpls_gso.c
index 34ab659f5..a535f4988 100644
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
index bfb775806..49d16283b 100644
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
2.43.0

