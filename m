Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C49231197C
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 01:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784856306; cv=none; b=qMV7mzqn6sMGR0DNG7h1PglkZ6NdF7iyvO9mHo/nRdc1G66IFrb9ZUt6EUhq1qytV9TfLGpTGPmD3WOOiy2tjmRqdMntYfmv8CSJZjbk2JbBSJUpiJmdhbbDg3d7z3Jfw/RwybbFAV/ww/T5qIBQc9qdCM0wD8qhwRJMKFn6TQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784856306; c=relaxed/simple;
	bh=RwtWuzxPO5wb80DbwlAjmfLRtZptKDwdx55W+Lp49Is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NPtFXLnFjRk3C1tPJZz7JD/qBTV0S2VH/RmjdHXQ6PemDJcg1FrHTYieSX4MicvlYzR70SkBJPeNMvZ+f06iSxSGYJT/fz1rW7vHjonzCi7dARrU7hnLg/tBIY/L3n/iJGZqXdzrBLbxYTYvTrGMWUKJSC8yAE/V4wpFvsOqb4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvzJN5re; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvzJN5re"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02991F00A3E;
	Fri, 24 Jul 2026 01:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784856305;
	bh=tJX3L4/XXHznQfQo0TLJ2xluJ0ixdx2StBFFGnQ8SSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OvzJN5reJk/q3QLkxnRvZcpTawt8auuzumwNoJIar7yXJX5jNudK6WFM9t1IF8+Oj
	 5E3jKiSe64XQ2Jp1Mzl6sm3lTE7FELGIBwJ0KpJ5KlQZtNdLByhU+aCq9MlpwTHyBA
	 spQWI36EtogJapGYAvxyvW/LJ+9DOM18xfIeQ2e9vqRcKs6B7uwUmNiu9DeMizLYbO
	 jtfUKV/gEwMqxKcVtzpkQwKcS2a1O693h5pTPhEQ+90XAROGSFreApskVQjWAAb/Ph
	 lG/acMlF4PQnrpSSIFOhksQ4Vi9FQ42njdhP0wU90N3y3ttWsYJFc17fuJHfB+93UR
	 jO5q0++igc9mw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Stefano Brivio <sbrivio@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 5/7] netfilter: nft_set_pipapo: prepare pipapo_get helper for on-demand clone
Date: Thu, 23 Jul 2026 21:24:58 -0400
Message-ID: <20260724012500.3832837-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724012500.3832837-1-sashal@kernel.org>
References: <2026072016-unplowed-brush-0ff9@gregkh>
 <20260724012500.3832837-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

[ Upstream commit a238106703ab4ae1090b86eba128815b8626d8f1 ]

The helper uses priv->clone unconditionally which will fail once we do
the clone conditionally on first insert or removal.

'nft get element' from userspace needs to use priv->match since this
runs from rcu read side lock section.

Prepare for this by passing the match backend data as argument.

Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: 47e65eff5069 ("netfilter: nft_set_pipapo: don't leak bad clone into future transaction")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_set_pipapo.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 9b574fb4ed7e7a..46c64c7e8d4d51 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -502,6 +502,7 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
  * pipapo_get() - Get matching element reference given key data
  * @net:	Network namespace
  * @set:	nftables API set representation
+ * @m:		storage containing active/existing elements
  * @data:	Key data to be matched against existing elements
  * @genmask:	If set, check that element is active in given genmask
  * @tstamp:	timestamp to check for expired elements
@@ -515,12 +516,11 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
  */
 static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 					  const struct nft_set *set,
+					  const struct nft_pipapo_match *m,
 					  const u8 *data, u8 genmask,
 					  u64 tstamp, gfp_t gfp)
 {
 	struct nft_pipapo_elem *ret = ERR_PTR(-ENOENT);
-	struct nft_pipapo *priv = nft_set_priv(set);
-	struct nft_pipapo_match *m = priv->clone;
 	unsigned long *res_map, *fill_map = NULL;
 	struct nft_pipapo_field *f;
 	int i;
@@ -608,7 +608,10 @@ static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 static void *nft_pipapo_get(const struct net *net, const struct nft_set *set,
 			    const struct nft_set_elem *elem, unsigned int flags)
 {
-	return pipapo_get(net, set, (const u8 *)elem->key.val.data,
+	struct nft_pipapo *priv = nft_set_priv(set);
+	struct nft_pipapo_match *m = rcu_dereference(priv->match);
+
+	return pipapo_get(net, set, m, (const u8 *)elem->key.val.data,
 			  nft_genmask_cur(net), get_jiffies_64(), GFP_ATOMIC);
 }
 
@@ -1218,7 +1221,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 	else
 		end = start;
 
-	dup = pipapo_get(net, set, start, genmask, tstamp, GFP_KERNEL);
+	dup = pipapo_get(net, set, m, start, genmask, tstamp, GFP_KERNEL);
 	if (!IS_ERR(dup)) {
 		/* Check if we already have the same exact entry */
 		const struct nft_data *dup_key, *dup_end;
@@ -1240,7 +1243,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 
 	if (PTR_ERR(dup) == -ENOENT) {
 		/* Look for partially overlapping entries */
-		dup = pipapo_get(net, set, end, nft_genmask_next(net), tstamp,
+		dup = pipapo_get(net, set, m, end, nft_genmask_next(net), tstamp,
 				 GFP_KERNEL);
 	}
 
@@ -1810,16 +1813,18 @@ static void *nft_pipapo_deactivate(const struct net *net,
 				   const struct nft_set *set,
 				   const struct nft_set_elem *elem)
 {
+	const struct nft_pipapo *priv = nft_set_priv(set);
+	struct nft_pipapo_match *m = priv->clone;
 	struct nft_pipapo_elem *e;
 
-	e = pipapo_get(net, set, (const u8 *)elem->key.val.data,
+	e = pipapo_get(net, set, m, (const u8 *)elem->key.val.data,
 		       nft_genmask_next(net), nft_net_tstamp(net), GFP_KERNEL);
 	if (IS_ERR(e))
 		return NULL;
 
 	nft_set_elem_change_active(net, set, &e->ext);
 
-	return &e->priv;
+	return e;
 }
 
 /**
@@ -1845,8 +1850,9 @@ static bool nft_pipapo_flush(const struct net *net, const struct nft_set *set,
 {
 	struct nft_pipapo_elem *e = elem;
 
-	return pipapo_deactivate(net, set, (const u8 *)nft_set_ext_key(&e->ext),
-				 &e->ext);
+	nft_set_elem_change_active(net, set, &e->ext);
+
+	return true;
 }
 
 /**
-- 
2.53.0

