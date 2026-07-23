Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214A638E5D7
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825674; cv=none; b=PM83m7pq9EhJ9rapAnchazml4YWEw39u8LGyx3N1gSj5Y23/Gwr5w0Hk/EuzOmmeRicU18Aun5Svr8+Ou/Yqxxn20FYRiHluVf47d60Ic+gRjD72nS6TSIVScUAQSSEITXCjwLzA2WQQJLBsvP38AS+3DVPfK98AX1cewW7daC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825674; c=relaxed/simple;
	bh=AittW1WB6CkDclVJa8C0m/D5ftQnT95Ei/18SAC/uP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AobrMa9yi8X/D6lH7qin9PBZmjKk+Fct/grGVUTnKdKyuhycUTAJv4OkMSyL5T/lSV9zBu9YqzyiigUsX6pPghsbfsKdYzzEo8/0l9h0bAhNkHiRDkJyULHvFtgkByDyo4pFSfzM+gWTuh6bqCGOOGwRqgqGESBRrwAFb95EqZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VEtpyXVf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VEtpyXVf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A20B1F00A3D;
	Thu, 23 Jul 2026 16:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784825673;
	bh=cMP14NpFQVPIsz8tbtqtUw1LpgFwdtmjiRGa/u67u7U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VEtpyXVfWVVanr9K5vDYX6T7XP16sFNSdaLWQJa2po1fFcwVhkG7qiP7F5/23i9yt
	 IDccBpPGCKOQKN6zcL5CSuHdmBugoxjT8dmEoCAkSotjlNkjH78LhgKPai0l75ihI0
	 Svc2UNk5uKTzFxyXalaRIh2n2psqyo6r4eS4Z/AEtWB/8CLzG7x2VJ2Tum3jpCz23W
	 5UqjnyrX4DBM0BGywhZ1c2UmRH3dI+ER11DMZK5WLcF5J0a5pagjiXGg+2+FdTHzvf
	 8jDebtqYKRr+2IP6/CITGq9HCj1YfEi0l7tQCiDXHuI+ltHRgVcGdTUE2IEmrz10YZ
	 YZ3iGAT/Qq7DQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Stefano Brivio <sbrivio@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 6/8] netfilter: nft_set_pipapo: prepare pipapo_get helper for on-demand clone
Date: Thu, 23 Jul 2026 12:54:25 -0400
Message-ID: <20260723165427.3390871-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723165427.3390871-1-sashal@kernel.org>
References: <2026072016-hurling-turmoil-5fb2@gregkh>
 <20260723165427.3390871-1-sashal@kernel.org>
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
 net/netfilter/nft_set_pipapo.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index f2d4737c09bc40..12bb73111159cc 100644
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
@@ -515,17 +516,15 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
  */
 static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 					  const struct nft_set *set,
+					  const struct nft_pipapo_match *m,
 					  const u8 *data, u8 genmask,
 					  u64 tstamp, gfp_t gfp)
 {
 	struct nft_pipapo_elem *ret = ERR_PTR(-ENOENT);
-	struct nft_pipapo *priv = nft_set_priv(set);
 	unsigned long *res_map, *fill_map = NULL;
-	const struct nft_pipapo_match *m;
 	const struct nft_pipapo_field *f;
 	int i;
 
-	m = priv->clone;
 	if (m->bsize_max == 0)
 		return ret;
 
@@ -609,7 +608,10 @@ static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 static void *nft_pipapo_get(const struct net *net, const struct nft_set *set,
 			    const struct nft_set_elem *elem, unsigned int flags)
 {
-	return pipapo_get(net, set, (const u8 *)elem->key.val.data,
+	struct nft_pipapo *priv = nft_set_priv(set);
+	struct nft_pipapo_match *m = rcu_dereference(priv->match);
+
+	return pipapo_get(net, set, m, (const u8 *)elem->key.val.data,
 			 nft_genmask_cur(net), get_jiffies_64(),
 			 GFP_ATOMIC);
 }
@@ -1231,7 +1233,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 	else
 		end = start;
 
-	dup = pipapo_get(net, set, start, genmask, tstamp, GFP_KERNEL);
+	dup = pipapo_get(net, set, m, start, genmask, tstamp, GFP_KERNEL);
 	if (!IS_ERR(dup)) {
 		/* Check if we already have the same exact entry */
 		const struct nft_data *dup_key, *dup_end;
@@ -1253,7 +1255,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 
 	if (PTR_ERR(dup) == -ENOENT) {
 		/* Look for partially overlapping entries */
-		dup = pipapo_get(net, set, end, nft_genmask_next(net), tstamp,
+		dup = pipapo_get(net, set, m, end, nft_genmask_next(net), tstamp,
 				 GFP_KERNEL);
 	}
 
@@ -1837,16 +1839,18 @@ static void *nft_pipapo_deactivate(const struct net *net,
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
@@ -1872,8 +1876,9 @@ static bool nft_pipapo_flush(const struct net *net, const struct nft_set *set,
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

