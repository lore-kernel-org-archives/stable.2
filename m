Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA633403EE
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 05:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787980767; cv=none; b=JSQxmb929NmaqvawR+lnRbQPrCXK+QNqqy2bagEjq8EfG0/hYnDI7bR/oYtkuiqJn+Nezh8FLkzenePDOrOphTOnMXy5Zanj9RueATCAS9/FMqoYkaWpOug7IoZqtiXWG7QFGlemBqkmGVfypqxzHv9p/RzB9kK7dIEN5sRtUX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787980767; c=relaxed/simple;
	bh=N5sjqb/zw9ASvTEE8Hllfd0zkPG9J/Kd00cWmd3GhIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJwpEVF/okaMKFJLLnY1+gLmB7VIOyJhss6qzq8FD0DfHc+nUJSK/09Uyq5B2FOoQ6EigqboDiuwqzjGdQUq7T965yfDmHPZGvfJgRLHQuHq/+TMyZopI3b4o2P9+LbptTo6A11LNem4gNgmf2JKNuSGVKkzd5p3cQjuE9t9cmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=pkARSe/o; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="pkARSe/o"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3964e76d0f4so1729342a91.3
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 22:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787980766; x=1788585566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ckRsItiMlwCXbk/2pMelqO4FEC5xTGYSxBkgI5zsRhQ=;
        b=pkARSe/oRX7NzSAfHpOc3qkxRnzraHMJfn8EDIZtPd5JsSBOOpJjzyh4LYhYeoNHjK
         gsaqo6szh7fYtyR8dk+IKqXolkha+sgIOnOhtC7UMcxzxnsLZu2FqSmIezCUHot4cyZy
         0hswRLZeMWZKzEqOusqP84dNsS+gB5gQFfi91ZK8PeK4FHVeIlb/SK4GGVVusvBIZoMZ
         o0OnwvBUfUmziUvCBg5o7Mai1cD7/LFOL1ZP/nveDS+paAjv86sAhY4h6i0HX+RAdFCL
         r0DVV5NUVCrTRQaXQUS91RYcyyxRLD5kQPbq/bWK/6SGts2n790uGW8t4EoJRSs+/Ne8
         LbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787980766; x=1788585566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ckRsItiMlwCXbk/2pMelqO4FEC5xTGYSxBkgI5zsRhQ=;
        b=JuPueToGfUajiP0BMZ0iUASn4pAksshSTC1uzIbHfuJUev3D+agPB9Grr74Lvo8FI3
         zu+QsE2zWRXpyGfbiX2flvZ4olZ9EPRkoJ6O4s0YI9OQj6XT8SrOhh1eWfvbiff65tMU
         HWufbe6hGNcB/2j17cdHqlY5DeH62KBYefsicNMy+/T9fc76W6mzxehCTiKwRZvmYCTV
         sIBVY+wmFZhNNhYKNtUspCJ9lpziKQfzuge9q0hXmV7uo0oo9IJ3ohl0/2d4p7t22Qv4
         5UbZ3W43MUcl6MU3mCbSxHDyvSOZfh8rTv2W7uHb4SxtA/c91eUDUiUN7n7tlX+D3YKe
         Cpog==
X-Forwarded-Encrypted: i=1; AKwUvBxr62LI9sLAC1t9y8JkJwHR99m7s5LmGMz/F2sUg0qhn1rx/9+jjeuB3tHnyRpl7cOf/2dCqrU=@vger.kernel.org
X-Gm-Message-State: AFuF++mpoOHmtYRDighRVTTyhUJ/9nx4bSwDB5PxgYUJiLoJb5oLLCC1
	QhXmUWXizjfEkJjfIjq3PN8id6RuHN6t75a6gpWwu7G0mlhTX6G+s4RR4kjzS8PdEFTY
X-Gm-Gg: AYBFou3dIZrXMMFcXUaMc987wnHSLHqeUEpX3y4aDo3cPKNO/7SErc9ZS5+lRHWubkK
	RtCpUoYGTVVMvYeyWmIqZHayY6Q22puWyz6s4uRm36yleUYUT3K4mxIA760sVnm9uYGBo8mqRQi
	LGs4iXnhM/Tvtl5hUj4L6K19wRmQrfkSbobjfBy0eQc1oUyl3gewk7cPXriWZJgOo2ThSKtqT0D
	CcBGTLxKZbZrRGDu+fMS7QNe2xY4gY2AN2iIIwDWSmeVrzutENLdiDd9yAB7++7E/2qfe6s4BUH
	t6jp2YWrCtaaI/sUGqdqzm8Ncso2pB4pXYM06nv5YQAjMgRT9GJo8mIZffZF4xrye4/ZM948WKK
	aidh0RLWTqQhvFju+63o4SrJFwn3QOSeo7GzTzcXM1tGmHaTApKlxgAh11NCpT4l8myXPKSQm/d
	8zYj/7ABN9KsvX/viVgLz0/THM0+z43XMHAT28ts8uDcCRNoZREDTzmre+48Bp/ruNI2B8jbcD3
	qizLQOin5DW7A==
X-Received: by 2002:a17:90a:e185:b0:37f:eafd:3505 with SMTP id 98e67ed59e1d1-396d0ecbdb9mr22265417a91.6.1787980765542;
        Fri, 28 Aug 2026 22:19:25 -0700 (PDT)
Received: from gmail.com ([202.201.12.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396dda7c922sm5569572a91.7.2026.08.28.22.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 22:19:25 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Phil Sutter <phil@nwl.cc>,
	Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	coreteam@netfilter.org,
	Zihan Xi <zihanx@nebusec.ai>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>
Subject: [PATCH nf 1/1] netfilter: nf_dup: prevent asynchronous duplicate recursion
Date: Sat, 29 Aug 2026 05:19:03 +0000
Message-ID: <8e45ea5d0cf764267a90d959fa40f0f831aabf08.1787903722.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1787903722.git.zihanx@nebusec.ai>
References: <cover.1787903722.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nf_dup_ipv4() and nf_dup_ipv6() use current->in_nf_duplicate to keep
duplicated packets from being duplicated again while ip_local_out() or
ip6_local_out() walks netfilter hooks. The task flag is cleared as soon
as the output function returns.

NFQUEUE can retain a duplicate and return from the output hook. A later
NF_ACCEPT verdict resumes the same skb at the following hook from the
verdict task, after in_nf_duplicate has been cleared. A later TEE target
or dup expression can then duplicate it again. With an earlier queue
hook and a later duplication hook, one packet can sustain an unbounded
packet generation loop.

Record the duplication state in the cloned skb as well as the task. The
skb flag survives queuing, reinjection, and skb metadata copies, so an
asynchronously resumed duplicate cannot enter either IPv4 or IPv6
duplication helper again. Copy the flag through nf_copy() so fragments
retain the same state. Keep the task flag for the nested xtables jumpstack.

Fixes: cd58bcd9787e ("netfilter: xt_TEE: have cloned packet travel through Xtables too")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 include/linux/skbuff.h           | 7 +++++++
 net/ipv4/netfilter/nf_dup_ipv4.c | 3 ++-
 net/ipv6/netfilter/nf_dup_ipv6.c | 3 ++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 5522716df8ff..f5c7b7b1cede 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -812,6 +812,7 @@ enum skb_tstamp_type {
  *	@redirected: packet was redirected by packet classifier
  *	@from_ingress: packet was redirected from the ingress path
  *	@nf_skip_egress: packet shall skip nf egress - see netfilter_netdev.h
+ *	@nf_duplicated: packet was generated by a netfilter duplication action
  *	@peeked: this packet has been seen already, so stats have been
  *		done for it, don't do them again
  *	@nf_trace: netfilter packet trace flag
@@ -1023,6 +1024,9 @@ struct sk_buff {
 #ifdef CONFIG_NETFILTER_SKIP_EGRESS
 	__u8			nf_skip_egress:1;
 #endif
+#if IS_ENABLED(CONFIG_NF_DUP_IPV4) || IS_ENABLED(CONFIG_NF_DUP_IPV6)
+	__u8			nf_duplicated:1;
+#endif
 #ifdef CONFIG_SKB_DECRYPTED
 	__u8			decrypted:1;
 #endif
@@ -5200,6 +5204,9 @@ static inline void nf_copy(struct sk_buff *dst, const struct sk_buff *src)
 	nf_conntrack_put(skb_nfct(dst));
 #endif
 	dst->slow_gro = src->slow_gro;
+#if IS_ENABLED(CONFIG_NF_DUP_IPV4) || IS_ENABLED(CONFIG_NF_DUP_IPV6)
+	dst->nf_duplicated = src->nf_duplicated;
+#endif
 	__nf_copy(dst, src, true);
 }
 
diff --git a/net/ipv4/netfilter/nf_dup_ipv4.c b/net/ipv4/netfilter/nf_dup_ipv4.c
index 9a773502f10a..8fe31a0db063 100644
--- a/net/ipv4/netfilter/nf_dup_ipv4.c
+++ b/net/ipv4/netfilter/nf_dup_ipv4.c
@@ -54,7 +54,7 @@ void nf_dup_ipv4(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 	struct iphdr *iph;
 
 	local_bh_disable();
-	if (current->in_nf_duplicate)
+	if (current->in_nf_duplicate || skb->nf_duplicated)
 		goto out;
 	/*
 	 * Copy the skb, and route the copy. Will later return %XT_CONTINUE for
@@ -86,6 +86,7 @@ void nf_dup_ipv4(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 		--iph->ttl;
 
 	if (nf_dup_ipv4_route(net, skb, gw, oif)) {
+		skb->nf_duplicated = 1;
 		current->in_nf_duplicate = true;
 		ip_local_out(net, skb->sk, skb);
 		current->in_nf_duplicate = false;
diff --git a/net/ipv6/netfilter/nf_dup_ipv6.c b/net/ipv6/netfilter/nf_dup_ipv6.c
index 6da3102b7c1b..e0fdb43d7d3d 100644
--- a/net/ipv6/netfilter/nf_dup_ipv6.c
+++ b/net/ipv6/netfilter/nf_dup_ipv6.c
@@ -48,7 +48,7 @@ void nf_dup_ipv6(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 		 const struct in6_addr *gw, int oif)
 {
 	local_bh_disable();
-	if (current->in_nf_duplicate)
+	if (current->in_nf_duplicate || skb->nf_duplicated)
 		goto out;
 	skb = pskb_copy(skb, GFP_ATOMIC);
 	if (skb == NULL)
@@ -64,6 +64,7 @@ void nf_dup_ipv6(struct net *net, struct sk_buff *skb, unsigned int hooknum,
 		--iph->hop_limit;
 	}
 	if (nf_dup_ipv6_route(net, skb, gw, oif)) {
+		skb->nf_duplicated = 1;
 		current->in_nf_duplicate = true;
 		ip6_local_out(net, skb->sk, skb);
 		current->in_nf_duplicate = false;
-- 
2.43.0

