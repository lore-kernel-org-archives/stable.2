Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72175463B73
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 11:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790766862; cv=none; b=kDj4lxkbvdrhU63nOycQaheYRGytuBYtGPsbXMCmxOkdhvJYOpXwglIaR8evGahOsyiVRLBUz3PWC7NJNgBFg3tKNwC0i4Om35es2xRhpDf5TEdU3A5ibLBFC1BEYrT+0sqRi3svTPoT5aFxkPh1JboKZQqqAa47jEpXfGwlQq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790766862; c=relaxed/simple;
	bh=/eIfYOXGN/m3OXf6vosKYWhm5gaxLZmBNFGur06e4xE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=urjojm7eBabAaUL90KLfuoyDXezAGVB8zpVKz46eF9fVI4jmio2GmySh0R3Sp6ugHXCXLPXvqXcwXtW/41YKFw1PvIEfS85MdvQQIo4gZiXS7uaMtXjfOolE+DsILmrzaBmyAR2Kd5lNf5mEho9VM7HMFJv3So06enJ2AsKvxao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHo/XY5a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHo/XY5a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6231F000FF;
	Wed, 30 Sep 2026 11:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790766861;
	bh=IB/Yjv0INDC9uo9CiV9vyAI8wB6qGk8YWK5v6n2QwxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MHo/XY5a9F2Zzu9IPreuz8GNRKrhlpZObFPtj9hF7mMDVSosYfHwFzJI9u3SDpxJH
	 rNgAFpSeJiOn4K4UQsMDUBK0bewd5lRqRB5ps9aKJULF/l6GVqNGtjZpklj7+9etW7
	 XJDpsY1uPsAFN3A6B8BKrd+dMLZLg2eN6d6/jOLmw+u4hrNm0zocLvIgXFeIaDTQ0o
	 ef5UGlzorg1tNb3egE/cWQPoSH/TVZyrd0VUrw/FuySIASNZgdKMuw+JNwcodqYDoN
	 QXGvW2mjFf3UAedmDW3enYTnNnK7vkg0ddn2JI6yD3tonXCkZ1Wc7NKcxhy3LGESBS
	 h1WJP/TL7bmSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] netfilter: nf_tables: set->ops->insert returns opaque set element in case of EEXIST
Date: Wed, 30 Sep 2026 07:14:17 -0400
Message-ID: <20260930111419.1207335-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092922-sadly-mace-20a0@gregkh>
References: <2026092922-sadly-mace-20a0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 078996fcd657e6e0c3a72b7d5806d04c32e74250 ]

Return struct nft_elem_priv instead of struct nft_set_ext for
consistency with ("netfilter: nf_tables: expose opaque set element as
struct nft_elem_priv") and to prepare the introduction of element
timeout updates from control path.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Backport notes for Linux 6.6:

The stable tree uses void * for private set elements and does not have
struct nft_elem_priv or the backend priv members. Keep that representation:
return the backend element through void ** and recover its extensions with
nft_set_elem_ext() in the -EEXIST caller. Update all insert implementations
consistently, including catchall insertion, so commit 70194dc37670 can be
applied without modification.

Preserve nft_add_set_elem()'s set_full handling and declaration order.
Keep pipapo's existing initialization of e and return that element directly;
do not introduce the unavailable nft_elem_priv_cast() helper. Correct the
pipapo output-parameter documentation to describe private element data.

Stable-dep-of: 70194dc37670 ("netfilter: nf_tables: skip expired catchall elements on insert and delete")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_tables.h |  2 +-
 net/netfilter/nf_tables_api.c     | 15 +++++++++------
 net/netfilter/nft_set_bitmap.c    |  4 ++--
 net/netfilter/nft_set_hash.c      |  8 ++++----
 net/netfilter/nft_set_pipapo.c    | 10 +++++-----
 net/netfilter/nft_set_rbtree.c    | 10 +++++-----
 6 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 4056d22724873..55fc808761cf1 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -462,7 +462,7 @@ struct nft_set_ops {
 	int				(*insert)(const struct net *net,
 						  const struct nft_set *set,
 						  const struct nft_set_elem *elem,
-						  struct nft_set_ext **ext);
+						  void **priv);
 	void				(*activate)(const struct net *net,
 						    const struct nft_set *set,
 						    const struct nft_set_elem *elem);
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index a9053667e3702..66bebe2f25f9e 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6553,7 +6553,7 @@ EXPORT_SYMBOL_GPL(nft_set_catchall_lookup);
 static int nft_setelem_catchall_insert(const struct net *net,
 				       struct nft_set *set,
 				       const struct nft_set_elem *elem,
-				       struct nft_set_ext **pext)
+				       void **priv)
 {
 	struct nft_set_elem_catchall *catchall;
 	u8 genmask = nft_genmask_next(net);
@@ -6562,7 +6562,7 @@ static int nft_setelem_catchall_insert(const struct net *net,
 	list_for_each_entry(catchall, &set->catchall_list, list) {
 		ext = nft_set_elem_ext(set, catchall->elem);
 		if (nft_set_elem_active(ext, genmask)) {
-			*pext = ext;
+			*priv = catchall->elem;
 			return -EEXIST;
 		}
 	}
@@ -6580,14 +6580,15 @@ static int nft_setelem_catchall_insert(const struct net *net,
 static int nft_setelem_insert(const struct net *net,
 			      struct nft_set *set,
 			      const struct nft_set_elem *elem,
-			      struct nft_set_ext **ext, unsigned int flags)
+			      void **elem_priv,
+			      unsigned int flags)
 {
 	int ret;
 
 	if (flags & NFT_SET_ELEM_CATCHALL)
-		ret = nft_setelem_catchall_insert(net, set, elem, ext);
+		ret = nft_setelem_catchall_insert(net, set, elem, elem_priv);
 	else
-		ret = set->ops->insert(net, set, elem, ext);
+		ret = set->ops->insert(net, set, elem, elem_priv);
 
 	return ret;
 }
@@ -6755,6 +6756,7 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	enum nft_registers dreg;
 	struct nft_trans *trans;
 	bool set_full = false;
+	void *elem_priv;
 	u64 timeout;
 	u64 expiration;
 	int err, i;
@@ -7063,9 +7065,10 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 
 	ext->genmask = nft_genmask_cur(ctx->net);
 
-	err = nft_setelem_insert(ctx->net, set, &elem, &ext2, flags);
+	err = nft_setelem_insert(ctx->net, set, &elem, &elem_priv, flags);
 	if (err) {
 		if (err == -EEXIST) {
+			ext2 = nft_set_elem_ext(set, elem_priv);
 			if (nft_set_ext_exists(ext, NFT_SET_EXT_DATA) ^
 			    nft_set_ext_exists(ext2, NFT_SET_EXT_DATA) ||
 			    nft_set_ext_exists(ext, NFT_SET_EXT_OBJREF) ^
diff --git a/net/netfilter/nft_set_bitmap.c b/net/netfilter/nft_set_bitmap.c
index cbf7f7825f1b8..06b77100bef71 100644
--- a/net/netfilter/nft_set_bitmap.c
+++ b/net/netfilter/nft_set_bitmap.c
@@ -123,7 +123,7 @@ static void *nft_bitmap_get(const struct net *net, const struct nft_set *set,
 
 static int nft_bitmap_insert(const struct net *net, const struct nft_set *set,
 			     const struct nft_set_elem *elem,
-			     struct nft_set_ext **ext)
+			     void **elem_priv)
 {
 	struct nft_bitmap *priv = nft_set_priv(set);
 	struct nft_bitmap_elem *new = elem->priv, *be;
@@ -132,7 +132,7 @@ static int nft_bitmap_insert(const struct net *net, const struct nft_set *set,
 
 	be = nft_bitmap_elem_find(set, new, genmask);
 	if (be) {
-		*ext = &be->ext;
+		*elem_priv = be;
 		return -EEXIST;
 	}
 
diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index 5a74ee4b7dfb3..60c0d72fb98b1 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -168,7 +168,7 @@ static bool nft_rhash_update(struct nft_set *set, const u32 *key,
 
 static int nft_rhash_insert(const struct net *net, const struct nft_set *set,
 			    const struct nft_set_elem *elem,
-			    struct nft_set_ext **ext)
+			    void **elem_priv)
 {
 	struct nft_rhash *priv = nft_set_priv(set);
 	struct nft_rhash_elem *he = elem->priv;
@@ -185,7 +185,7 @@ static int nft_rhash_insert(const struct net *net, const struct nft_set *set,
 	if (IS_ERR(prev))
 		return PTR_ERR(prev);
 	if (prev) {
-		*ext = &prev->ext;
+		*elem_priv = prev;
 		return -EEXIST;
 	}
 	return 0;
@@ -588,7 +588,7 @@ static u32 nft_jhash(const struct nft_set *set, const struct nft_hash *priv,
 
 static int nft_hash_insert(const struct net *net, const struct nft_set *set,
 			   const struct nft_set_elem *elem,
-			   struct nft_set_ext **ext)
+			   void **elem_priv)
 {
 	struct nft_hash_elem *this = elem->priv, *he;
 	struct nft_hash *priv = nft_set_priv(set);
@@ -600,7 +600,7 @@ static int nft_hash_insert(const struct net *net, const struct nft_set *set,
 		if (!memcmp(nft_set_ext_key(&this->ext),
 			    nft_set_ext_key(&he->ext), set->klen) &&
 		    nft_set_elem_active(&he->ext, genmask)) {
-			*ext = &he->ext;
+			*elem_priv = he;
 			return -EEXIST;
 		}
 	}
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 7c8d28a031ad5..b9d9218cb2ee3 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1260,13 +1260,13 @@ static struct nft_pipapo_match *pipapo_maybe_clone(const struct nft_set *set)
  * @net:	Network namespace
  * @set:	nftables API set representation
  * @elem:	nftables API element representation containing key data
- * @ext2:	Filled with pointer to &struct nft_set_ext in inserted element
+ * @elem_priv:	Filled with pointer to private element data
  *
  * Return: 0 on success, error pointer on failure.
  */
 static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 			     const struct nft_set_elem *elem,
-			     struct nft_set_ext **ext2)
+			     void **elem_priv)
 {
 	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
 	union nft_pipapo_map_bucket rulemap[NFT_PIPAPO_MAX_FIELDS];
@@ -1301,7 +1301,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 
 		if (!memcmp(start, dup_key->data, sizeof(*dup_key->data)) &&
 		    !memcmp(end, dup_end->data, sizeof(*dup_end->data))) {
-			*ext2 = &dup->ext;
+			*elem_priv = dup;
 			return -EEXIST;
 		}
 
@@ -1317,7 +1317,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 	if (PTR_ERR(dup) != -ENOENT) {
 		if (IS_ERR(dup))
 			return PTR_ERR(dup);
-		*ext2 = &dup->ext;
+		*elem_priv = dup;
 		return -ENOTEMPTY;
 	}
 
@@ -1379,7 +1379,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 		put_cpu_ptr(m->scratch);
 	}
 
-	*ext2 = &e->ext;
+	*elem_priv = e;
 
 	pipapo_map(m, rulemap, e);
 
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 9c9b07f2def1b..ac0bd348a46c2 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -319,7 +319,7 @@ static struct nft_rbtree_elem *nft_rbtree_prev_active(struct nft_rbtree_elem *rb
 
 static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 			       struct nft_rbtree_elem *new,
-			       struct nft_set_ext **ext)
+			       void **elem_priv)
 {
 	struct nft_rbtree_elem *rbe, *rbe_le = NULL, *rbe_ge = NULL, *rbe_prev;
 	struct rb_node *node, *next, *parent, **p, *first = NULL;
@@ -437,7 +437,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 	 */
 	if (rbe_ge && !nft_rbtree_cmp(set, new, rbe_ge) &&
 	    nft_rbtree_interval_start(rbe_ge) == nft_rbtree_interval_start(new)) {
-		*ext = &rbe_ge->ext;
+		*elem_priv = rbe_ge;
 		return -EEXIST;
 	}
 
@@ -446,7 +446,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 	 */
 	if (rbe_le && !nft_rbtree_cmp(set, new, rbe_le) &&
 	    nft_rbtree_interval_end(rbe_le) == nft_rbtree_interval_end(new)) {
-		*ext = &rbe_le->ext;
+		*elem_priv = rbe_le;
 		return -EEXIST;
 	}
 
@@ -506,7 +506,7 @@ static int __nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 
 static int nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 			     const struct nft_set_elem *elem,
-			     struct nft_set_ext **ext)
+			     void **elem_priv)
 {
 	struct nft_rbtree *priv = nft_set_priv(set);
 	struct nft_rbtree_elem *rbe = elem->priv;
@@ -520,7 +520,7 @@ static int nft_rbtree_insert(const struct net *net, const struct nft_set *set,
 
 		write_lock_bh(&priv->lock);
 		write_seqcount_begin(&priv->count);
-		err = __nft_rbtree_insert(net, set, rbe, ext);
+		err = __nft_rbtree_insert(net, set, rbe, elem_priv);
 		write_seqcount_end(&priv->count);
 		write_unlock_bh(&priv->lock);
 	} while (err == -EAGAIN);
-- 
2.53.0

