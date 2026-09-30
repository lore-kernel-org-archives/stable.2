Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D34B4FB9AC
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790777143; cv=none; b=ZmE9Hn6p9WHm3YQVyvI0GXFB0bjsC+euk7oXA/HwCk6TroflmX0w7kUmWdvoFbw30zMQrbTmj1D2l9CL9peBvBgP5GfZXZkVm+t21tBy3Ejc66UflC62kxDKPwFcCgpI4Erl6UI7HTIqYBh9abzfhFI662CKU1LAIHwZB18gNJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790777143; c=relaxed/simple;
	bh=cYtmcHvhzq0hYRwZyrSTONUrjXLkDeHmsfZGlFS4v28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXlmkrdQCiVehmtNpdBbTiRSlR4rjg4KOwOG0CZogrEn25ZmraRgUl+6nNLGsR+gi0GZDcsDiEwZJSTg4L/DcJQbfJeRJ8E9spHH4vA9vtiShBvZPUD94k2//cxJC8QTcakSyeyF8OoqqowrSYSkzoW5py87cUdeq+M/Ngc76+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLCN2EfE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLCN2EfE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508341F0089D;
	Wed, 30 Sep 2026 14:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790777135;
	bh=QGs0YzIA/bUHHVeAWv6M6zloouZU6sfhKram1J8IeMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hLCN2EfEfmVV2Iffjn5PJU2tP6pjUDy7k+VKfc4J7uOfQc7YcH9kolWAASWzj7TG2
	 Og7C7ynLq8g4wM8LUvcB6/8Gd5R8yrACyziK61lCaWGEKsUw+OkrMrfzo3uaTO/xiP
	 UXgNYzRRGOaprbfgOmsmGDhHxo4OEzzrmzURFIZNuCO6qUPwN/p81Vxm9eTBgQCQJl
	 1pSThyPFDKzufcgG5Lof2xGt4Mjtx023yReS4qNUsWVp2yx88zJZV9e8K0c9rRmusw
	 HFmy9gqPSD5J4R3WuRELEarl1frojv7Vwy7pGuO/eJMjBmLKQlNNb5lEwlyg5bkCoR
	 FxeIqxseKwAmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] netfilter: nf_tables: set->ops->insert returns opaque set element in case of EEXIST
Date: Wed, 30 Sep 2026 10:05:32 -0400
Message-ID: <20260930140533.1823830-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092923-thievish-makeshift-9a83@gregkh>
References: <2026092923-thievish-makeshift-9a83@gregkh>
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

Backport notes for Linux 6.1:
Keep the existing void-pointer representation of opaque set elements.
The typed nft_elem_priv API and embedded priv members are not present in
this branch, so return backend element pointers through void ** and derive
the extension with nft_set_elem_ext() in the EEXIST handling path.

Preserve the stable set_full accounting and PIPAPO's early initialization
of e, and omit the unrelated timeout declaration reorder. No functions or
new element representations are introduced. This prepares the catchall
insert context for 70194dc37670 ("netfilter: nf_tables: skip expired
catchall elements on insert and delete"); its timestamp and expiration
helpers already exist in this branch.

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
index 7e63281f2d5a8..b8f283a6e718f 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -454,7 +454,7 @@ struct nft_set_ops {
 	int				(*insert)(const struct net *net,
 						  const struct nft_set *set,
 						  const struct nft_set_elem *elem,
-						  struct nft_set_ext **ext);
+						  void **priv);
 	void				(*activate)(const struct net *net,
 						    const struct nft_set *set,
 						    const struct nft_set_elem *elem);
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 96b0638c220a7..5238241c9a0b3 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6218,7 +6218,7 @@ EXPORT_SYMBOL_GPL(nft_set_catchall_lookup);
 static int nft_setelem_catchall_insert(const struct net *net,
 				       struct nft_set *set,
 				       const struct nft_set_elem *elem,
-				       struct nft_set_ext **pext)
+				       void **priv)
 {
 	struct nft_set_elem_catchall *catchall;
 	u8 genmask = nft_genmask_next(net);
@@ -6227,7 +6227,7 @@ static int nft_setelem_catchall_insert(const struct net *net,
 	list_for_each_entry(catchall, &set->catchall_list, list) {
 		ext = nft_set_elem_ext(set, catchall->elem);
 		if (nft_set_elem_active(ext, genmask)) {
-			*pext = ext;
+			*priv = catchall->elem;
 			return -EEXIST;
 		}
 	}
@@ -6245,14 +6245,15 @@ static int nft_setelem_catchall_insert(const struct net *net,
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
@@ -6420,6 +6421,7 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	enum nft_registers dreg;
 	struct nft_trans *trans;
 	bool set_full = false;
+	void *elem_priv;
 	u64 timeout;
 	u64 expiration;
 	int err, i;
@@ -6728,9 +6730,10 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 
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
index 4b37c6684bff6..c27ba1c5ae5da 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1260,13 +1260,13 @@ static struct nft_pipapo_match *pipapo_maybe_clone(const struct nft_set *set)
  * @net:	Network namespace
  * @set:	nftables API set representation
  * @elem:	nftables API element representation containing key data
- * @ext2:	Filled with pointer to &struct nft_set_ext in inserted element
+ * @elem_priv:	Filled with pointer to opaque set element
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
index 433094c4200f9..e82e5cf107ee4 100644
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

