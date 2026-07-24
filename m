Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576CA1419A4
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 01:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784856307; cv=none; b=Ho0KwyDK3KmZxSdUOudXTcFdYe7ymVQqaokVKXp7jD+zc+8m/6y1YFaSaUVshPns2O/NnzW+ZN3mzuvjq/3yF4ci09GTndSGjYO88QgAt/2HJ9iKWGDzGhFfvzn/RwyL+CuuivTfDicRjsdbgAmiA6z5mKkkepjrLSbySW7cc7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784856307; c=relaxed/simple;
	bh=lTarTVySyoopoUePhTN30I0zJ6dj9IAX0aTLI6VUC5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WiVguoaG/ew7MvPZS5L2ej3uA8dhTM7vKNl5xPVRo158flLx3KmdNwBR+8qdke4MuxNeQOAaLVwMREXqHZQglZ6xC+cFQJbtJqzcx1Bc3MqrNbqrQgDB0zpSihhd1fHwYP/OKNUtXBle6kZy5i9kj3tX1GaYpt/XUIrsRPotg04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mv6jgtbU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mv6jgtbU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1621F00A3D;
	Fri, 24 Jul 2026 01:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784856306;
	bh=i4B+tyxkA8ulCaK339+vsmmULgyo7Kzaoimo3lQKP+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Mv6jgtbUEFJRKaT2pTDQkO20Yc0C94AhmaNzev1qkYoUHj2fCHZuEeD2r2VRNyadC
	 2g1HxTfWAd2RuzMGDohwmArOdWCx61lBRyHM8kZPdvkjf6gRbEsI/+ODST54UoMImV
	 TTEmUS9l4cUgur5Atm3oxe2yf39tfnqzXiprcNQSmTcY0FbXKvBACZNFv9cySxHcS7
	 OXl2EcYQlXnh4vYqWYScAL7fyBkTBnRmTgY3FJ3hqRTNMgOgdHbDkVTuMHuPxq6HkR
	 xXZbCJx51m7rMcW+a0UPJxPlWCGx7MjXFgylINnXMOl9CSPDdPYeujy3TElLUefbQL
	 pi5xv3Cd2u8pA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>,
	Stefano Brivio <sbrivio@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 6/7] netfilter: nft_set_pipapo: move cloning of match info to insert/removal path
Date: Thu, 23 Jul 2026 21:24:59 -0400
Message-ID: <20260724012500.3832837-6-sashal@kernel.org>
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

[ Upstream commit 3f1d886cc7c3525d4dbeee24bfa9bb3fe0d48ddc ]

This set type keeps two copies of the sets' content,
   priv->match (live version, used to match from packet path)
   priv->clone (work-in-progress version of the 'future' priv->match).

All additions and removals are done on priv->clone.  When transaction
completes, priv->clone becomes priv->match and a new clone is allocated
for use by next transaction.

Problem is that the cloning requires GFP_KERNEL allocations but we
cannot fail at either commit or abort time.

This patch defers the clone until we get an insertion or removal
request.  This allows us to handle OOM situations correctly.

This also allows to remove ->dirty in a followup change:

If ->clone exists, ->dirty is always true
If ->clone is NULL, ->dirty is always false, no elements were added
or removed (except catchall elements which are external to the specific
set backend).

Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: 47e65eff5069 ("netfilter: nft_set_pipapo: don't leak bad clone into future transaction")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_set_pipapo.c | 82 +++++++++++++++++++++++++---------
 1 file changed, 61 insertions(+), 21 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 46c64c7e8d4d51..5b985ce8065f6c 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1191,6 +1191,41 @@ static int pipapo_realloc_scratch(struct nft_pipapo_match *clone,
 	return 0;
 }
 
+static bool nft_pipapo_transaction_mutex_held(const struct nft_set *set)
+{
+#ifdef CONFIG_PROVE_LOCKING
+	const struct net *net = read_pnet(&set->net);
+	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
+
+	return lockdep_is_held(&nft_net->commit_mutex);
+#else
+	return true;
+#endif
+}
+
+static struct nft_pipapo_match *pipapo_clone(struct nft_pipapo_match *old);
+
+/**
+ * pipapo_maybe_clone() - Build clone for pending data changes, if not existing
+ * @set:	nftables API set representation
+ *
+ * Return: newly created or existing clone, if any. NULL on allocation failure
+ */
+static struct nft_pipapo_match *pipapo_maybe_clone(const struct nft_set *set)
+{
+	struct nft_pipapo *priv = nft_set_priv(set);
+	struct nft_pipapo_match *m;
+
+	if (priv->clone)
+		return priv->clone;
+
+	m = rcu_dereference_protected(priv->match,
+				      nft_pipapo_transaction_mutex_held(set));
+	priv->clone = pipapo_clone(m);
+
+	return priv->clone;
+}
+
 /**
  * nft_pipapo_insert() - Validate and insert ranged elements
  * @net:	Network namespace
@@ -1208,14 +1243,17 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 	union nft_pipapo_map_bucket rulemap[NFT_PIPAPO_MAX_FIELDS];
 	const u8 *start = (const u8 *)elem->key.val.data, *end;
 	struct nft_pipapo_elem *e = elem->priv, *dup;
+	struct nft_pipapo_match *m = pipapo_maybe_clone(set);
 	struct nft_pipapo *priv = nft_set_priv(set);
-	struct nft_pipapo_match *m = priv->clone;
 	u8 genmask = nft_genmask_next(net);
 	u64 tstamp = nft_net_tstamp(net);
 	struct nft_pipapo_field *f;
 	const u8 *start_p, *end_p;
 	int i, bsize_max, err = 0;
 
+	if (!m)
+		return -ENOMEM;
+
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_KEY_END))
 		end = (const u8 *)nft_set_ext_key_end(ext)->data;
 	else
@@ -1737,7 +1775,10 @@ static void pipapo_reclaim_match(struct rcu_head *rcu)
 static void nft_pipapo_commit(const struct nft_set *set)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
-	struct nft_pipapo_match *new_clone, *old;
+	struct nft_pipapo_match *old;
+
+	if (!priv->clone)
+		return;
 
 	if (time_after_eq(jiffies, priv->last_gc + nft_set_gc_interval(set)))
 		pipapo_gc_scan(set, priv->clone);
@@ -1745,18 +1786,13 @@ static void nft_pipapo_commit(const struct nft_set *set)
 	if (!priv->dirty)
 		goto out;
 
-	new_clone = pipapo_clone(priv->clone);
-	if (!new_clone)
-		goto out;
-
+	old = rcu_replace_pointer(priv->match, priv->clone,
+				  nft_pipapo_transaction_mutex_held(set));
+	priv->clone = NULL;
 	priv->dirty = false;
 
-	old = rcu_access_pointer(priv->match);
-	rcu_assign_pointer(priv->match, priv->clone);
 	if (old)
 		call_rcu(&old->rcu, pipapo_reclaim_match);
-
-	priv->clone = new_clone;
 out:
 	pipapo_gc_queue(set);
 }
@@ -1764,21 +1800,15 @@ static void nft_pipapo_commit(const struct nft_set *set)
 static void nft_pipapo_abort(const struct nft_set *set)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
-	struct nft_pipapo_match *new_clone, *m;
 
 	if (!priv->dirty)
 		return;
 
-	m = rcu_dereference(priv->match);
-
-	new_clone = pipapo_clone(m);
-	if (!new_clone)
+	if (!priv->clone)
 		return;
-
 	priv->dirty = false;
-
 	pipapo_free_match(priv->clone);
-	priv->clone = new_clone;
+	priv->clone = NULL;
 }
 
 /**
@@ -1813,10 +1843,15 @@ static void *nft_pipapo_deactivate(const struct net *net,
 				   const struct nft_set *set,
 				   const struct nft_set_elem *elem)
 {
-	const struct nft_pipapo *priv = nft_set_priv(set);
-	struct nft_pipapo_match *m = priv->clone;
+	struct nft_pipapo_match *m = pipapo_maybe_clone(set);
 	struct nft_pipapo_elem *e;
 
+	/* removal must occur on priv->clone, if we are low on memory
+	 * we have no choice and must fail the removal request.
+	 */
+	if (!m)
+		return NULL;
+
 	e = pipapo_get(net, set, m, (const u8 *)elem->key.val.data,
 		       nft_genmask_next(net), nft_net_tstamp(net), GFP_KERNEL);
 	if (IS_ERR(e))
@@ -2102,7 +2137,12 @@ static void nft_pipapo_walk(const struct nft_ctx *ctx, struct nft_set *set,
 
 	switch (iter->type) {
 	case NFT_ITER_UPDATE:
-		m = priv->clone;
+		m = pipapo_maybe_clone(set);
+		if (!m) {
+			iter->err = -ENOMEM;
+			return;
+		}
+
 		nft_pipapo_do_walk(ctx, set, m, iter);
 		break;
 	case NFT_ITER_READ:
-- 
2.53.0

