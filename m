Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAB52AEEB
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790783080; cv=none; b=mIZ2+q5rCLtbcJ5tfa5l+hcc9xqilPssytF9B7xSkk1rQTqxIaKe+iZIVHe/KRqH9v+RIpdDptM0gYCgh6cHa3z/oLZx+h+lxh6vnszowXjZuNKa1UEmBcrbrfoYTL39uRHIzwcrDvcENvVlBWmkEB9T0ebdN095e273Z3E88XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790783080; c=relaxed/simple;
	bh=zYMpRF4jbt3bPVqD8p3TVQtecuEcUdif9skQreiW/BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bEIB+2ZXKlVi4APBv7ZRIhSoUeG3lFMQkbFta7vGkS1klYc9Y6mw/L9nmEXyBzr2Q66IKOHYjyww9V0gYzdi8FIJk21sxTE3urBnqN46XmuvNu8OsOq8v+rjxBNPaxC+nXMkCFEPFnA04Ssfl/hY+ktWEtAwdJJvQUVDmaDbP6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gxNlq9Mr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gxNlq9Mr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938F31F00898;
	Wed, 30 Sep 2026 15:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790783077;
	bh=YtFsVL1mkxX8yZJaTORh4cdEN3CT2GtDbw3kKNuXiCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gxNlq9Mrhx/PKA+1zT5vfsek11UwKuIn0UGadS6ttpzJO5cgYdD2By9/IgweUwv61
	 jWvMXGnNSQVPvrJ88VpEn1JBHvaPO9tEMRFM86pLyyevLw+V+Q0nc/suarb6jOVuX6
	 OTn3YGBKjry8xphoEU45pUGTz0c8InIFv57P0skSXmvqEq8j/JV1l/kQhhPOd1BJ0e
	 Ox7dgtg0J0kqWKc3G/3qfAWQxMbEQtVrIOlpYq3dc7xND2khJ9c5HkTl4jMSO99KDo
	 UktFNQan+2I6FiJtthhEWxGvkSblCxBOd9svDJfwUFT9o3fCCLqQQiv2mqM88z9I3m
	 vjbRqKk4UrgLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] netfilter: nf_tables: set->ops->insert returns opaque set element in case of EEXIST
Date: Wed, 30 Sep 2026 11:44:33 -0400
Message-ID: <20260930154434.2936893-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092923-masses-playroom-aefc@gregkh>
References: <2026092923-masses-playroom-aefc@gregkh>
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

Backport adaptation for Linux 5.15:
This tree represents opaque set elements as void pointers and does not
have struct nft_elem_priv, the backend priv members, or nft_elem_priv_cast().
Use void ** for the insert output parameter and return the existing backend
element pointer directly. Keep the frontend conversion through
nft_set_elem_ext() when insertion returns -EEXIST.

Resolve the pipapo conflict by retaining its existing initialization of e
at declaration and returning e directly. Update the output parameter's
documentation and omit the unrelated timeout declaration reordering.
No functions or element layout changes are introduced.

This preserves the catchall insertion context needed for target commit
70194dc37670bd08e44b471389861cc01bd3a3c9, whose two hunks apply unchanged.

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
index 2b977d5d6f30f..be271c66329e8 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -435,7 +435,7 @@ struct nft_set_ops {
 	int				(*insert)(const struct net *net,
 						  const struct nft_set *set,
 						  const struct nft_set_elem *elem,
-						  struct nft_set_ext **ext);
+						  void **priv);
 	void				(*activate)(const struct net *net,
 						    const struct nft_set *set,
 						    const struct nft_set_elem *elem);
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index c1b5b579ccd72..c1dffddd31be6 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6075,7 +6075,7 @@ EXPORT_SYMBOL_GPL(nft_set_catchall_lookup);
 static int nft_setelem_catchall_insert(const struct net *net,
 				       struct nft_set *set,
 				       const struct nft_set_elem *elem,
-				       struct nft_set_ext **pext)
+				       void **priv)
 {
 	struct nft_set_elem_catchall *catchall;
 	u8 genmask = nft_genmask_next(net);
@@ -6084,7 +6084,7 @@ static int nft_setelem_catchall_insert(const struct net *net,
 	list_for_each_entry(catchall, &set->catchall_list, list) {
 		ext = nft_set_elem_ext(set, catchall->elem);
 		if (nft_set_elem_active(ext, genmask)) {
-			*pext = ext;
+			*priv = catchall->elem;
 			return -EEXIST;
 		}
 	}
@@ -6102,14 +6102,15 @@ static int nft_setelem_catchall_insert(const struct net *net,
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
@@ -6255,6 +6256,7 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	struct nft_data_desc desc;
 	enum nft_registers dreg;
 	struct nft_trans *trans;
+	void *elem_priv;
 	u64 timeout;
 	u64 expiration;
 	int err, i;
@@ -6549,9 +6551,10 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 
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
index 028955a9cb092..ec12d0f814351 100644
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
index 1825db84c2223..ef8441fe586a1 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1233,13 +1233,13 @@ static struct nft_pipapo_match *pipapo_maybe_clone(const struct nft_set *set)
  * @net:	Network namespace
  * @set:	nftables API set representation
  * @elem:	nftables API element representation containing key data
- * @ext2:	Filled with pointer to &struct nft_set_ext in inserted element
+ * @elem_priv:	Filled with private pointer to inserted or existing element
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
@@ -1274,7 +1274,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 
 		if (!memcmp(start, dup_key->data, sizeof(*dup_key->data)) &&
 		    !memcmp(end, dup_end->data, sizeof(*dup_end->data))) {
-			*ext2 = &dup->ext;
+			*elem_priv = dup;
 			return -EEXIST;
 		}
 
@@ -1290,7 +1290,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 	if (PTR_ERR(dup) != -ENOENT) {
 		if (IS_ERR(dup))
 			return PTR_ERR(dup);
-		*ext2 = &dup->ext;
+		*elem_priv = dup;
 		return -ENOTEMPTY;
 	}
 
@@ -1352,7 +1352,7 @@ static int nft_pipapo_insert(const struct net *net, const struct nft_set *set,
 		put_cpu_ptr(m->scratch);
 	}
 
-	*ext2 = &e->ext;
+	*elem_priv = e;
 
 	pipapo_map(m, rulemap, e);
 
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 23e4e656f7f0c..db0ad96d1091e 100644
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

