Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3718A311973
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 01:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784856303; cv=none; b=cOMPqugKOk2Vinw31alIbnFKEjED5xHaeO1X9f5jusDS8Cg5Goc3vLh0i2AOpQM5jgWTqlu/KMquLfmzfMnUl0JD9ihXMvpt3lS48+sJnk81IyeY2haIZbbkQpSY7F5rbEbzVKSzgVsjCfPL12Wp0h3yzA14Y9TiCy6eD1c/hZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784856303; c=relaxed/simple;
	bh=VuzcotVhaxUrA4wW9y7XDr/FQzdl2suBSR/IrDjvUiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+F7WwoitnAJBvxXM0CU59JFo+/kxR+PlNTWAr18ZXKi8HEfvY7GiQz9QYqly7AEVUBMy9X9leJ+JDLToADwXolQsrsycfvXyr7Sbk4hCsKFp8/xqjWl62JJQ/LTuBtgLQOwk3gilwHwAqYC/Hg+Ay9QOHms5ElJ2Zo4nJq9QCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLxCA2DO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLxCA2DO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7DA1F000E9;
	Fri, 24 Jul 2026 01:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784856302;
	bh=ND2todzpp8c76gR6SjmE7meEqKvT+/T89ri6iukzd3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YLxCA2DOs1wY9SM0uvpu8LfcJAXs7gvskNcjIXNl64olZxp5UadYK2HGJH5eyHEB8
	 R7uqI91HRjiNwGtbmCn4yqkikSA2L4MxDK09TAH/9tj3d/iqCp16X/2O4Xdf/JcB8g
	 U9wB2CdgVFxJJIgCvXcziOgQWQvbobfYPXDtLUwuUKFel8I8s5jBKYy93lG5SHpJ0/
	 D2xXnGpjHfbW29ZicICu6B6WwIdRNMZoUuwYh99P97RXoEYlXpweN2F4qEUCyv25GU
	 km2TrRr2oS5bs8CgaRBjwiwsyKrrg9RZhi3G4KKgFLOgIw3qgmeenXeAE4ynzEpmA9
	 MoTa7t/gIY6rg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/7] netfilter: nft_set_pipapo: use GFP_KERNEL for insertions
Date: Thu, 23 Jul 2026 21:24:54 -0400
Message-ID: <20260724012500.3832837-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072016-unplowed-brush-0ff9@gregkh>
References: <2026072016-unplowed-brush-0ff9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 5b651783d80b97167ecd27dc6a4408c694873902 ]

An earlier attempt changed this to GFP_KERNEL, but the get helper is
also called for get requests from userspace, which uses rcu.

Let the caller pass in the kmalloc flags to allow insertions
to schedule if needed.

Suggested-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Stable-dep-of: 47e65eff5069 ("netfilter: nft_set_pipapo: don't leak bad clone into future transaction")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_set_pipapo.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 39623bb726a5ec..a01905381b5365 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -505,6 +505,7 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
  * @data:	Key data to be matched against existing elements
  * @genmask:	If set, check that element is active in given genmask
  * @tstamp:	timestamp to check for expired elements
+ * @gfp:	the type of memory to allocate (see kmalloc).
  *
  * This is essentially the same as the lookup function, except that it matches
  * key data against the uncommitted copy and doesn't use preallocated maps for
@@ -515,7 +516,7 @@ bool nft_pipapo_lookup(const struct net *net, const struct nft_set *set,
 static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 					  const struct nft_set *set,
 					  const u8 *data, u8 genmask,
-					  u64 tstamp)
+					  u64 tstamp, gfp_t gfp)
 {
 	struct nft_pipapo_elem *ret = ERR_PTR(-ENOENT);
 	struct nft_pipapo *priv = nft_set_priv(set);
@@ -527,13 +528,13 @@ static struct nft_pipapo_elem *pipapo_get(const struct net *net,
 	if (m->bsize_max == 0)
 		return ret;
 
-	res_map = kmalloc_array(m->bsize_max, sizeof(*res_map), GFP_ATOMIC);
+	res_map = kmalloc_array(m->bsize_max, sizeof(*res_map), gfp);
 	if (!res_map) {
 		ret = ERR_PTR(-ENOMEM);
 		goto out;
 	}
 
-	fill_map = kcalloc(m->bsize_max, sizeof(*res_map), GFP_ATOMIC);
+	fill_map = kcalloc(m->bsize_max, sizeof(*res_map), gfp);
 	if (!fill_map) {
 		ret = ERR_PTR(-ENOMEM);
 		goto out;
@@ -608,7 +609,7 @@ static void *nft_pipapo_get(const struct net *net, const struct nft_set *set,
 			    const struct nft_set_elem *elem, unsigned int flags)
 {
 	return pipapo_get(net, set, (const u8 *)elem->key.val.data,
-			  nft_genmask_cur(net), get_jiffies_64());
+			  nft_genmask_cur(net), get_jiffies_64(), GFP_ATOMIC);
 }
 
 /**
@@ -1217,7 +1218,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 	else
 		end = start;
 
-	dup = pipapo_get(net, set, start, genmask, tstamp);
+	dup = pipapo_get(net, set, start, genmask, tstamp, GFP_KERNEL);
 	if (!IS_ERR(dup)) {
 		/* Check if we already have the same exact entry */
 		const struct nft_data *dup_key, *dup_end;
@@ -1239,7 +1240,8 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 
 	if (PTR_ERR(dup) == -ENOENT) {
 		/* Look for partially overlapping entries */
-		dup = pipapo_get(net, set, end, nft_genmask_next(net), tstamp);
+		dup = pipapo_get(net, set, end, nft_genmask_next(net), tstamp,
+				 GFP_KERNEL);
 	}
 
 	if (PTR_ERR(dup) != -ENOENT) {
@@ -1814,7 +1816,8 @@ static void *pipapo_deactivate(const struct net *net, const struct nft_set *set,
 {
 	struct nft_pipapo_elem *e;
 
-	e = pipapo_get(net, set, data, nft_genmask_next(net), nft_net_tstamp(net));
+	e = pipapo_get(net, set, data, nft_genmask_next(net),
+		       nft_net_tstamp(net), GFP_KERNEL);
 	if (IS_ERR(e))
 		return NULL;
 
-- 
2.53.0

