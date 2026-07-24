Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339C42459DD
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 01:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784856297; cv=none; b=VVxYWoaPhsiho9gxwyxL30rr8+1dZKziEiPsnSCY9xMBL8zRvKqQuB7/cn32GyKp8etP7LYBQ+HiRQUuoCTYySEDcJRyU4FtYDrRNdALYrkGEg7A1L1JRe4cUSlJyKkrZQaYjz65fEODHlZvX++VzJJbLr9PSLZfFevSDVDMFmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784856297; c=relaxed/simple;
	bh=5LkJkmAdDFAQ31i6WzvQy1T1Kyg9MTxLI+lRijP5Q00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KM46I0IN8c9bUfXN02XtDUe3OtKuhubhn+PxfQjZT6a20HbhIInW6/6VzREbmEik/XDuVSWxUXlSMDLdOZgYAEjpnVrisEBALG7EJFNRg2dTYC9Kf1fW7IFH+rWBDasObeLF5XIVU/zoAi4e7HzeL8XtrST4K1Cs+FqxnRxWUIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKuEkKFD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKuEkKFD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1841F000E9;
	Fri, 24 Jul 2026 01:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784856295;
	bh=PNH4WjsK/MMT0MUqETIKf70dfH2DZRUbDN2B+cAJuNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QKuEkKFDqrqa6qjrAC8mGiS4zHGlnn6/ZnQWYVihFiFXRDnxLQQyUTtbfXYMzzj5k
	 I5D2N7GcGbai8LAtTvxuc16++5ccAcdD74r5t1hECVwLyBINIm0bOOm5bJrriME7Lr
	 mwRvx/HIMNlofYShBq54a2MAOkvMFA0BmmxBmo0L/4ZkCcMEeQ00aQPFDQPUeuafuy
	 XOJP9I5BeWAt+EqCwLbgGaA7dlv/ZY1hSvc3ZkJz6DKznhK6yMNtDVDYnHUlw17K9v
	 M+VjORRaB/9d2GTpQWtjp8JA+4ae0lekFTyajoiMxNoPThvIDn3AXu2z7Hnn3wPpcJ
	 GeVOeYk8I3qtA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/7] netfilter: nf_tables: pass context structure to nft_parse_register_load
Date: Thu, 23 Jul 2026 21:24:47 -0400
Message-ID: <20260724012453.3832653-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072054-refresh-tumble-391b@gregkh>
References: <2026072054-refresh-tumble-391b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 7ea0522ef81a335c2d3a0ab1c8a4fab9a23c4a03 ]

Mechanical transformation, no logical changes intended.

Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: d07955dd34ec ("netfilter: nft_fib: reject fib expression on the netdev egress hook")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_tables.h | 3 ++-
 net/ipv4/netfilter/nft_dup_ipv4.c | 4 ++--
 net/ipv6/netfilter/nft_dup_ipv6.c | 4 ++--
 net/netfilter/nf_tables_api.c     | 3 ++-
 net/netfilter/nft_bitwise.c       | 4 ++--
 net/netfilter/nft_byteorder.c     | 2 +-
 net/netfilter/nft_cmp.c           | 6 +++---
 net/netfilter/nft_ct.c            | 2 +-
 net/netfilter/nft_dup_netdev.c    | 2 +-
 net/netfilter/nft_dynset.c        | 4 ++--
 net/netfilter/nft_exthdr.c        | 2 +-
 net/netfilter/nft_fwd_netdev.c    | 6 +++---
 net/netfilter/nft_hash.c          | 2 +-
 net/netfilter/nft_lookup.c        | 2 +-
 net/netfilter/nft_masq.c          | 4 ++--
 net/netfilter/nft_meta.c          | 2 +-
 net/netfilter/nft_nat.c           | 8 ++++----
 net/netfilter/nft_objref.c        | 2 +-
 net/netfilter/nft_payload.c       | 2 +-
 net/netfilter/nft_queue.c         | 2 +-
 net/netfilter/nft_range.c         | 2 +-
 net/netfilter/nft_redir.c         | 4 ++--
 net/netfilter/nft_tproxy.c        | 4 ++--
 23 files changed, 39 insertions(+), 37 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 3329c2eaea9f07..166621818a405e 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -252,7 +252,8 @@ static inline enum nft_registers nft_type_to_reg(enum nft_data_types type)
 int nft_parse_u32_check(const struct nlattr *attr, int max, u32 *dest);
 int nft_dump_register(struct sk_buff *skb, unsigned int attr, unsigned int reg);
 
-int nft_parse_register_load(const struct nlattr *attr, u8 *sreg, u32 len);
+int nft_parse_register_load(const struct nft_ctx *ctx,
+			    const struct nlattr *attr, u8 *sreg, u32 len);
 int nft_parse_register_store(const struct nft_ctx *ctx,
 			     const struct nlattr *attr, u8 *dreg,
 			     const struct nft_data *data,
diff --git a/net/ipv4/netfilter/nft_dup_ipv4.c b/net/ipv4/netfilter/nft_dup_ipv4.c
index 0bcd6aee60008c..000539b94e1ef7 100644
--- a/net/ipv4/netfilter/nft_dup_ipv4.c
+++ b/net/ipv4/netfilter/nft_dup_ipv4.c
@@ -40,13 +40,13 @@ static int nft_dup_ipv4_init(const struct nft_ctx *ctx,
 	if (tb[NFTA_DUP_SREG_ADDR] == NULL)
 		return -EINVAL;
 
-	err = nft_parse_register_load(tb[NFTA_DUP_SREG_ADDR], &priv->sreg_addr,
+	err = nft_parse_register_load(ctx, tb[NFTA_DUP_SREG_ADDR], &priv->sreg_addr,
 				      sizeof(struct in_addr));
 	if (err < 0)
 		return err;
 
 	if (tb[NFTA_DUP_SREG_DEV])
-		err = nft_parse_register_load(tb[NFTA_DUP_SREG_DEV],
+		err = nft_parse_register_load(ctx, tb[NFTA_DUP_SREG_DEV],
 					      &priv->sreg_dev, sizeof(int));
 
 	return err;
diff --git a/net/ipv6/netfilter/nft_dup_ipv6.c b/net/ipv6/netfilter/nft_dup_ipv6.c
index 70a405b4006f96..5a7abea7739c76 100644
--- a/net/ipv6/netfilter/nft_dup_ipv6.c
+++ b/net/ipv6/netfilter/nft_dup_ipv6.c
@@ -38,13 +38,13 @@ static int nft_dup_ipv6_init(const struct nft_ctx *ctx,
 	if (tb[NFTA_DUP_SREG_ADDR] == NULL)
 		return -EINVAL;
 
-	err = nft_parse_register_load(tb[NFTA_DUP_SREG_ADDR], &priv->sreg_addr,
+	err = nft_parse_register_load(ctx, tb[NFTA_DUP_SREG_ADDR], &priv->sreg_addr,
 				      sizeof(struct in6_addr));
 	if (err < 0)
 		return err;
 
 	if (tb[NFTA_DUP_SREG_DEV])
-		err = nft_parse_register_load(tb[NFTA_DUP_SREG_DEV],
+		err = nft_parse_register_load(ctx, tb[NFTA_DUP_SREG_DEV],
 					      &priv->sreg_dev, sizeof(int));
 
 	return err;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index a8904f73c5976d..8b7e49996d0424 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -10442,7 +10442,8 @@ static int nft_validate_register_load(enum nft_registers reg, unsigned int len)
 	return 0;
 }
 
-int nft_parse_register_load(const struct nlattr *attr, u8 *sreg, u32 len)
+int nft_parse_register_load(const struct nft_ctx *ctx,
+			    const struct nlattr *attr, u8 *sreg, u32 len)
 {
 	u32 reg;
 	int err;
diff --git a/net/netfilter/nft_bitwise.c b/net/netfilter/nft_bitwise.c
index 1899ea88fdf10f..d8adee26ff0230 100644
--- a/net/netfilter/nft_bitwise.c
+++ b/net/netfilter/nft_bitwise.c
@@ -172,7 +172,7 @@ static int nft_bitwise_init(const struct nft_ctx *ctx,
 
 	priv->len = len;
 
-	err = nft_parse_register_load(tb[NFTA_BITWISE_SREG], &priv->sreg,
+	err = nft_parse_register_load(ctx, tb[NFTA_BITWISE_SREG], &priv->sreg,
 				      priv->len);
 	if (err < 0)
 		return err;
@@ -365,7 +365,7 @@ static int nft_bitwise_fast_init(const struct nft_ctx *ctx,
 	struct nft_bitwise_fast_expr *priv = nft_expr_priv(expr);
 	int err;
 
-	err = nft_parse_register_load(tb[NFTA_BITWISE_SREG], &priv->sreg,
+	err = nft_parse_register_load(ctx, tb[NFTA_BITWISE_SREG], &priv->sreg,
 				      sizeof(u32));
 	if (err < 0)
 		return err;
diff --git a/net/netfilter/nft_byteorder.c b/net/netfilter/nft_byteorder.c
index 605178133d9eb3..60b18efadf5ccd 100644
--- a/net/netfilter/nft_byteorder.c
+++ b/net/netfilter/nft_byteorder.c
@@ -139,7 +139,7 @@ static int nft_byteorder_init(const struct nft_ctx *ctx,
 
 	priv->len = len;
 
-	err = nft_parse_register_load(tb[NFTA_BYTEORDER_SREG], &priv->sreg,
+	err = nft_parse_register_load(ctx, tb[NFTA_BYTEORDER_SREG], &priv->sreg,
 				      priv->len);
 	if (err < 0)
 		return err;
diff --git a/net/netfilter/nft_cmp.c b/net/netfilter/nft_cmp.c
index 963cf831799cdb..30181e12409dd7 100644
--- a/net/netfilter/nft_cmp.c
+++ b/net/netfilter/nft_cmp.c
@@ -83,7 +83,7 @@ static int nft_cmp_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 	if (err < 0)
 		return err;
 
-	err = nft_parse_register_load(tb[NFTA_CMP_SREG], &priv->sreg, desc.len);
+	err = nft_parse_register_load(ctx, tb[NFTA_CMP_SREG], &priv->sreg, desc.len);
 	if (err < 0)
 		return err;
 
@@ -221,7 +221,7 @@ static int nft_cmp_fast_init(const struct nft_ctx *ctx,
 	if (err < 0)
 		return err;
 
-	err = nft_parse_register_load(tb[NFTA_CMP_SREG], &priv->sreg, desc.len);
+	err = nft_parse_register_load(ctx, tb[NFTA_CMP_SREG], &priv->sreg, desc.len);
 	if (err < 0)
 		return err;
 
@@ -321,7 +321,7 @@ static int nft_cmp16_fast_init(const struct nft_ctx *ctx,
 	if (err < 0)
 		return err;
 
-	err = nft_parse_register_load(tb[NFTA_CMP_SREG], &priv->sreg, desc.len);
+	err = nft_parse_register_load(ctx, tb[NFTA_CMP_SREG], &priv->sreg, desc.len);
 	if (err < 0)
 		return err;
 
diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index 931cf351566268..e2ef510ab04894 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -621,7 +621,7 @@ static int nft_ct_set_init(const struct nft_ctx *ctx,
 	}
 
 	priv->len = len;
-	err = nft_parse_register_load(tb[NFTA_CT_SREG], &priv->sreg, len);
+	err = nft_parse_register_load(ctx, tb[NFTA_CT_SREG], &priv->sreg, len);
 	if (err < 0)
 		goto err1;
 
diff --git a/net/netfilter/nft_dup_netdev.c b/net/netfilter/nft_dup_netdev.c
index 63507402716d1a..6e0a66588fb32c 100644
--- a/net/netfilter/nft_dup_netdev.c
+++ b/net/netfilter/nft_dup_netdev.c
@@ -40,7 +40,7 @@ static int nft_dup_netdev_init(const struct nft_ctx *ctx,
 	if (tb[NFTA_DUP_SREG_DEV] == NULL)
 		return -EINVAL;
 
-	return nft_parse_register_load(tb[NFTA_DUP_SREG_DEV], &priv->sreg_dev,
+	return nft_parse_register_load(ctx, tb[NFTA_DUP_SREG_DEV], &priv->sreg_dev,
 				       sizeof(int));
 }
 
diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index 5f58ac874005ae..6e71b937fb3542 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -222,7 +222,7 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 			return err;
 	}
 
-	err = nft_parse_register_load(tb[NFTA_DYNSET_SREG_KEY], &priv->sreg_key,
+	err = nft_parse_register_load(ctx, tb[NFTA_DYNSET_SREG_KEY], &priv->sreg_key,
 				      set->klen);
 	if (err < 0)
 		return err;
@@ -233,7 +233,7 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 		if (set->dtype == NFT_DATA_VERDICT)
 			return -EOPNOTSUPP;
 
-		err = nft_parse_register_load(tb[NFTA_DYNSET_SREG_DATA],
+		err = nft_parse_register_load(ctx, tb[NFTA_DYNSET_SREG_DATA],
 					      &priv->sreg_data, set->dlen);
 		if (err < 0)
 			return err;
diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index a7cb4dd6205e9f..f3fefe70abff2c 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -590,7 +590,7 @@ static int nft_exthdr_tcp_set_init(const struct nft_ctx *ctx,
 	priv->flags  = flags;
 	priv->op     = op;
 
-	return nft_parse_register_load(tb[NFTA_EXTHDR_SREG], &priv->sreg,
+	return nft_parse_register_load(ctx, tb[NFTA_EXTHDR_SREG], &priv->sreg,
 				       priv->len);
 }
 
diff --git a/net/netfilter/nft_fwd_netdev.c b/net/netfilter/nft_fwd_netdev.c
index 6f6b3551346256..0a551c16020379 100644
--- a/net/netfilter/nft_fwd_netdev.c
+++ b/net/netfilter/nft_fwd_netdev.c
@@ -52,7 +52,7 @@ static int nft_fwd_netdev_init(const struct nft_ctx *ctx,
 	if (tb[NFTA_FWD_SREG_DEV] == NULL)
 		return -EINVAL;
 
-	return nft_parse_register_load(tb[NFTA_FWD_SREG_DEV], &priv->sreg_dev,
+	return nft_parse_register_load(ctx, tb[NFTA_FWD_SREG_DEV], &priv->sreg_dev,
 				       sizeof(int));
 }
 
@@ -187,12 +187,12 @@ static int nft_fwd_neigh_init(const struct nft_ctx *ctx,
 		return -EOPNOTSUPP;
 	}
 
-	err = nft_parse_register_load(tb[NFTA_FWD_SREG_DEV], &priv->sreg_dev,
+	err = nft_parse_register_load(ctx, tb[NFTA_FWD_SREG_DEV], &priv->sreg_dev,
 				      sizeof(int));
 	if (err < 0)
 		return err;
 
-	return nft_parse_register_load(tb[NFTA_FWD_SREG_ADDR], &priv->sreg_addr,
+	return nft_parse_register_load(ctx, tb[NFTA_FWD_SREG_ADDR], &priv->sreg_addr,
 				       addr_len);
 }
 
diff --git a/net/netfilter/nft_hash.c b/net/netfilter/nft_hash.c
index e5631e88b285ca..e15d0edc761c29 100644
--- a/net/netfilter/nft_hash.c
+++ b/net/netfilter/nft_hash.c
@@ -91,7 +91,7 @@ static int nft_jhash_init(const struct nft_ctx *ctx,
 
 	priv->len = len;
 
-	err = nft_parse_register_load(tb[NFTA_HASH_SREG], &priv->sreg, len);
+	err = nft_parse_register_load(ctx, tb[NFTA_HASH_SREG], &priv->sreg, len);
 	if (err < 0)
 		return err;
 
diff --git a/net/netfilter/nft_lookup.c b/net/netfilter/nft_lookup.c
index fc0ac535d0d8e1..a1ec9dcdc29879 100644
--- a/net/netfilter/nft_lookup.c
+++ b/net/netfilter/nft_lookup.c
@@ -111,7 +111,7 @@ static int nft_lookup_init(const struct nft_ctx *ctx,
 	if (IS_ERR(set))
 		return PTR_ERR(set);
 
-	err = nft_parse_register_load(tb[NFTA_LOOKUP_SREG], &priv->sreg,
+	err = nft_parse_register_load(ctx, tb[NFTA_LOOKUP_SREG], &priv->sreg,
 				      set->klen);
 	if (err < 0)
 		return err;
diff --git a/net/netfilter/nft_masq.c b/net/netfilter/nft_masq.c
index 026b4f87d96cca..93bc2851acb49f 100644
--- a/net/netfilter/nft_masq.c
+++ b/net/netfilter/nft_masq.c
@@ -54,13 +54,13 @@ static int nft_masq_init(const struct nft_ctx *ctx,
 	}
 
 	if (tb[NFTA_MASQ_REG_PROTO_MIN]) {
-		err = nft_parse_register_load(tb[NFTA_MASQ_REG_PROTO_MIN],
+		err = nft_parse_register_load(ctx, tb[NFTA_MASQ_REG_PROTO_MIN],
 					      &priv->sreg_proto_min, plen);
 		if (err < 0)
 			return err;
 
 		if (tb[NFTA_MASQ_REG_PROTO_MAX]) {
-			err = nft_parse_register_load(tb[NFTA_MASQ_REG_PROTO_MAX],
+			err = nft_parse_register_load(ctx, tb[NFTA_MASQ_REG_PROTO_MAX],
 						      &priv->sreg_proto_max,
 						      plen);
 			if (err < 0)
diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 587ef60c8f32ba..54f377b7ce074d 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -657,7 +657,7 @@ int nft_meta_set_init(const struct nft_ctx *ctx,
 	}
 
 	priv->len = len;
-	err = nft_parse_register_load(tb[NFTA_META_SREG], &priv->sreg, len);
+	err = nft_parse_register_load(ctx, tb[NFTA_META_SREG], &priv->sreg, len);
 	if (err < 0)
 		return err;
 
diff --git a/net/netfilter/nft_nat.c b/net/netfilter/nft_nat.c
index ba7bcce724efde..fed4f88cf9e7d1 100644
--- a/net/netfilter/nft_nat.c
+++ b/net/netfilter/nft_nat.c
@@ -213,13 +213,13 @@ static int nft_nat_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 	priv->family = family;
 
 	if (tb[NFTA_NAT_REG_ADDR_MIN]) {
-		err = nft_parse_register_load(tb[NFTA_NAT_REG_ADDR_MIN],
+		err = nft_parse_register_load(ctx, tb[NFTA_NAT_REG_ADDR_MIN],
 					      &priv->sreg_addr_min, alen);
 		if (err < 0)
 			return err;
 
 		if (tb[NFTA_NAT_REG_ADDR_MAX]) {
-			err = nft_parse_register_load(tb[NFTA_NAT_REG_ADDR_MAX],
+			err = nft_parse_register_load(ctx, tb[NFTA_NAT_REG_ADDR_MAX],
 						      &priv->sreg_addr_max,
 						      alen);
 			if (err < 0)
@@ -233,13 +233,13 @@ static int nft_nat_init(const struct nft_ctx *ctx, const struct nft_expr *expr,
 
 	plen = sizeof_field(struct nf_nat_range, min_proto.all);
 	if (tb[NFTA_NAT_REG_PROTO_MIN]) {
-		err = nft_parse_register_load(tb[NFTA_NAT_REG_PROTO_MIN],
+		err = nft_parse_register_load(ctx, tb[NFTA_NAT_REG_PROTO_MIN],
 					      &priv->sreg_proto_min, plen);
 		if (err < 0)
 			return err;
 
 		if (tb[NFTA_NAT_REG_PROTO_MAX]) {
-			err = nft_parse_register_load(tb[NFTA_NAT_REG_PROTO_MAX],
+			err = nft_parse_register_load(ctx, tb[NFTA_NAT_REG_PROTO_MAX],
 						      &priv->sreg_proto_max,
 						      plen);
 			if (err < 0)
diff --git a/net/netfilter/nft_objref.c b/net/netfilter/nft_objref.c
index 0017bd3418722e..a789ff9463c3a7 100644
--- a/net/netfilter/nft_objref.c
+++ b/net/netfilter/nft_objref.c
@@ -143,7 +143,7 @@ static int nft_objref_map_init(const struct nft_ctx *ctx,
 	if (!(set->flags & NFT_SET_OBJECT))
 		return -EINVAL;
 
-	err = nft_parse_register_load(tb[NFTA_OBJREF_SET_SREG], &priv->sreg,
+	err = nft_parse_register_load(ctx, tb[NFTA_OBJREF_SET_SREG], &priv->sreg,
 				      set->klen);
 	if (err < 0)
 		return err;
diff --git a/net/netfilter/nft_payload.c b/net/netfilter/nft_payload.c
index ae3277424b839e..22409dffce75a7 100644
--- a/net/netfilter/nft_payload.c
+++ b/net/netfilter/nft_payload.c
@@ -857,7 +857,7 @@ static int nft_payload_set_init(const struct nft_ctx *ctx,
 	}
 	priv->csum_type = csum_type;
 
-	return nft_parse_register_load(tb[NFTA_PAYLOAD_SREG], &priv->sreg,
+	return nft_parse_register_load(ctx, tb[NFTA_PAYLOAD_SREG], &priv->sreg,
 				       priv->len);
 }
 
diff --git a/net/netfilter/nft_queue.c b/net/netfilter/nft_queue.c
index da29e92c03e276..c6a13ef03ea122 100644
--- a/net/netfilter/nft_queue.c
+++ b/net/netfilter/nft_queue.c
@@ -136,7 +136,7 @@ static int nft_queue_sreg_init(const struct nft_ctx *ctx,
 	struct nft_queue *priv = nft_expr_priv(expr);
 	int err;
 
-	err = nft_parse_register_load(tb[NFTA_QUEUE_SREG_QNUM],
+	err = nft_parse_register_load(ctx, tb[NFTA_QUEUE_SREG_QNUM],
 				      &priv->sreg_qnum, sizeof(u32));
 	if (err < 0)
 		return err;
diff --git a/net/netfilter/nft_range.c b/net/netfilter/nft_range.c
index 832f0d725a9e24..229f274f182382 100644
--- a/net/netfilter/nft_range.c
+++ b/net/netfilter/nft_range.c
@@ -83,7 +83,7 @@ static int nft_range_init(const struct nft_ctx *ctx, const struct nft_expr *expr
 		goto err2;
 	}
 
-	err = nft_parse_register_load(tb[NFTA_RANGE_SREG], &priv->sreg,
+	err = nft_parse_register_load(ctx, tb[NFTA_RANGE_SREG], &priv->sreg,
 				      desc_from.len);
 	if (err < 0)
 		goto err2;
diff --git a/net/netfilter/nft_redir.c b/net/netfilter/nft_redir.c
index 08b408d3e113db..98ab0533051824 100644
--- a/net/netfilter/nft_redir.c
+++ b/net/netfilter/nft_redir.c
@@ -50,13 +50,13 @@ static int nft_redir_init(const struct nft_ctx *ctx,
 
 	plen = sizeof_field(struct nf_nat_range, min_proto.all);
 	if (tb[NFTA_REDIR_REG_PROTO_MIN]) {
-		err = nft_parse_register_load(tb[NFTA_REDIR_REG_PROTO_MIN],
+		err = nft_parse_register_load(ctx, tb[NFTA_REDIR_REG_PROTO_MIN],
 					      &priv->sreg_proto_min, plen);
 		if (err < 0)
 			return err;
 
 		if (tb[NFTA_REDIR_REG_PROTO_MAX]) {
-			err = nft_parse_register_load(tb[NFTA_REDIR_REG_PROTO_MAX],
+			err = nft_parse_register_load(ctx, tb[NFTA_REDIR_REG_PROTO_MAX],
 						      &priv->sreg_proto_max,
 						      plen);
 			if (err < 0)
diff --git a/net/netfilter/nft_tproxy.c b/net/netfilter/nft_tproxy.c
index adb50c39572e2a..f066e09c8d1e19 100644
--- a/net/netfilter/nft_tproxy.c
+++ b/net/netfilter/nft_tproxy.c
@@ -254,14 +254,14 @@ static int nft_tproxy_init(const struct nft_ctx *ctx,
 	}
 
 	if (tb[NFTA_TPROXY_REG_ADDR]) {
-		err = nft_parse_register_load(tb[NFTA_TPROXY_REG_ADDR],
+		err = nft_parse_register_load(ctx, tb[NFTA_TPROXY_REG_ADDR],
 					      &priv->sreg_addr, alen);
 		if (err < 0)
 			return err;
 	}
 
 	if (tb[NFTA_TPROXY_REG_PORT]) {
-		err = nft_parse_register_load(tb[NFTA_TPROXY_REG_PORT],
+		err = nft_parse_register_load(ctx, tb[NFTA_TPROXY_REG_PORT],
 					      &priv->sreg_port, sizeof(u16));
 		if (err < 0)
 			return err;
-- 
2.53.0

