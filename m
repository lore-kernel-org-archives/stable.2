Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BD538F65B
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 16:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825670; cv=none; b=ssPNt0V7qeImaquuxVTEwKYNy5RX6SdVIAHU+vzmA2heaGMYGWAqIldRsvcLrb6TZeOigRYuO3eRsvTaNdLdZvGe5VCUlSWOYN0Yt3gst2c0GJHViOLk5SE2pB8KD7XXW7LegxYEWklk/G8WdfoZhTeueOsoHZxfXk1w23ZgT1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825670; c=relaxed/simple;
	bh=flXcjxOVNQjZsf0E3aLvbiZGcZkPCgk9Qtm9KNzzqtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eS+LC1zqtIQFxs9bfF827gfKTZp0HJQQ4xkkUQLg3oDq0aK5U8XefSbjiQco/WYvv2NVNTxfXro/X4FGirzPF7v3C/z22RrdJxaJ+DG9kplPjuIqnOjjknyXdmTnA26dSRTcY+5IHC4f/tlt9w7HTk1Z9RzYf+1JVGQB/w87BoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTGyEacf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTGyEacf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A7221F000E9;
	Thu, 23 Jul 2026 16:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784825669;
	bh=vyHAFOQFBtclmfY+Iag5tbp5TBx1umZrDqq3/3T4d5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CTGyEacfwbcfW197pHh3pp2eHr3XP4buvs6hvxl8eJXd4MMmTHTb3YLLAOukWIj1O
	 RXbWl48tWamVDxaxe9Ju0zqto3JiV+dwzlJlVrIDIuoO2SpMWwM+/goc1r63EE6ZUE
	 GgUEHhZJ2/spd17NI+Jh5dHoAm90wKNXhUsyDMgonEcRuzN/T417R4uhee/cV/Kkww
	 hWpLqQ5ZzfFRNd3+BCRdbiv6KHl7L1TIyXhcsZoRaYGXHReHRhzSaLPtBRxk+tL+Ml
	 Y1HS41b3SBVGeYT2VYApY5/jQgBnOE3bSS+unv4/auk5D7sTVka5vpS/da7DYnKFJa
	 rXltO/rU1pd6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/8] netfilter: nft_set_pipapo: use GFP_KERNEL for insertions
Date: Thu, 23 Jul 2026 12:54:20 -0400
Message-ID: <20260723165427.3390871-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072016-hurling-turmoil-5fb2@gregkh>
References: <2026072016-hurling-turmoil-5fb2@gregkh>
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
 net/netfilter/nft_set_pipapo.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 4bede370c8b83a..00f0b270f08842 100644
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
@@ -528,13 +529,13 @@ static struct nft_pipapo_elem *pipapo_get(const struct net *net,
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
@@ -609,7 +610,8 @@ static void *nft_pipapo_get(const struct net *net, const struct nft_set *set,
 			    const struct nft_set_elem *elem, unsigned int flags)
 {
 	return pipapo_get(net, set, (const u8 *)elem->key.val.data,
-			 nft_genmask_cur(net), get_jiffies_64());
+			 nft_genmask_cur(net), get_jiffies_64(),
+			 GFP_ATOMIC);
 }
 
 /**
@@ -1218,7 +1220,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 	else
 		end = start;
 
-	dup = pipapo_get(net, set, start, genmask, tstamp);
+	dup = pipapo_get(net, set, start, genmask, tstamp, GFP_KERNEL);
 	if (!IS_ERR(dup)) {
 		/* Check if we already have the same exact entry */
 		const struct nft_data *dup_key, *dup_end;
@@ -1240,7 +1242,8 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 
 	if (PTR_ERR(dup) == -ENOENT) {
 		/* Look for partially overlapping entries */
-		dup = pipapo_get(net, set, end, nft_genmask_next(net), tstamp);
+		dup = pipapo_get(net, set, end, nft_genmask_next(net), tstamp,
+				 GFP_KERNEL);
 	}
 
 	if (PTR_ERR(dup) != -ENOENT) {
@@ -1840,7 +1843,8 @@ static void *pipapo_deactivate(const struct net *net, const struct nft_set *set,
 {
 	struct nft_pipapo_elem *e;
 
-	e = pipapo_get(net, set, data, nft_genmask_next(net), nft_net_tstamp(net));
+	e = pipapo_get(net, set, data, nft_genmask_next(net),
+		       nft_net_tstamp(net), GFP_KERNEL);
 	if (IS_ERR(e))
 		return NULL;
 
-- 
2.53.0

