Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343112;
	b=gvuey+9iZgPrwgo74rqVI60E+54/zJpVl+K6wkqKftNZZHK5e3K+uNzrtvqxQ4JD5g5y
	 Jj7awltQ5T5qF6MR+BZUEXhHVJs14IqPdtWOkPHTwpelZUsM3AnZOyVlmMlviMXzx7dIF
	 vtokPf5VY2PxjwXxHv2GpHHK1lCYcG7u9bO8B3Ya83HUk3/8abIijvIHhRk28JkmGLvF5
	 jToNJz4bRRsL+RmBmpwbvpl6z5BF6cw0GZ7pFu0pRBmho5lb1oYdv09JPIrpADP9hwJIi
	 nc232QNvolMG2oe0F0lUQsAgf6R8FwNT4yTkephUsF1UO0SgDn23GC67EsXAt7y6IdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343112;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=rWL1Kmv7mAHkdWfEPS1Zn8rv1uvTakq1n0zWir5tjAY=;
	b=wdWXmJrYZlyOljYfUqLj3QwMAs/S21w/OLYtiacbqSXg4Ga2MB5wV6QjAgNCtRpuflZe
	 iboONFKMEaTjiVmBlHkvyhGBF8ICORFHH35uCknE0bUN0PVQu2SQOcxfgTUgo7Sff9BNt
	 MmgqvA1C0LjIuNT63gdvZnfVIRMCwMRkNBeoBkueDJvaHtNqkcbSv/WrwydWULYfifDlS
	 H1+Ae2FM8RpuETBAZ4Xc4NX/Oa4lENvPmaH4CbWoI0kVO8xrdfQ0wg4IXRuRXAZqQQrTS
	 dUj+GYq+M8+7ilw2kaCaia+ihcckOYFFWlK0jj12Ov2YmWUei9r4HrfQVW5IgFqdhkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0cniXBB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F1760A262D;
	Tue, 10 Nov 2026 20:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0cniXBB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5091F0089F;
	Tue, 10 Nov 2026 20:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794343111;
	bh=rWL1Kmv7mAHkdWfEPS1Zn8rv1uvTakq1n0zWir5tjAY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=S0cniXBBSbAKwPU5LJmTHsLUkrO1HqQv11rasfD/psGONH8eC80I8KSQwkTkjLI6b
	 XnkUDdUwQnPhFRf2NLkslK6dq3W/sAqOlctTZBNTtzKtrcfAsDU6JIqa1ONcsRkjgv
	 oZhy/GycQfPdplQGnKDAco8MZO1QEF1y4gDVcgwljEOrzxVNfhGDM+L1brF3OjeFGW
	 Zek42g0D77m/bI2HQuIdj7GTt1YdDVJsuBNyyYK4hFERt4aqts0zSPkbR7mmVcMFr+
	 IX9vlzjAJBEbkwd36sFrboVpmjb5aeMSmLXcWCM4WIXFboWhg3b4QF0SRVHERCrX47
	 Db6onH4qFIZsw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 10 Nov 2026 21:35:46 +0100
Subject: [PATCH v3 6/9] RFC: net: limit folio refcount when copying skb
 frag references
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-refcount_overflow_stable-v3-6-318625d63a98@kernel.org>
References: <20261110-refcount_overflow_stable-v3-0-318625d63a98@kernel.org>
In-Reply-To: <20261110-refcount_overflow_stable-v3-0-318625d63a98@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, 
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Song Liu <songliubraving@fb.com>, 
 Rik van Riel <riel@surriel.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Hugh Dickins <hughd@google.com>, 
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 John Hubbard <jhubbard@nvidia.com>, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 fuse-devel@lists.linux.dev, linux-arch@vger.kernel.org, 
 iommu@lists.linux.dev, netdev@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7051; i=david@kernel.org;
 h=from:subject:message-id; bh=8WcF+eMICV96yVCjGSTifLoav7b/cDE4tGUfm9+Di/I=;
 b=owGbwMvMwCF2QOXvyb15Z08znlZLYsj63BDO94xPoTdwnfeynl5fLReXSVd9StZMtGd1+rXHe
 63no4h1HaUsDGIcDLJiiizX1uWkBq9pdSyLMnSDmcPKBDKEgYtTACbiMY3hf/WMGttfF3rMLma/
 XXOe52Bjneaq3cyslXH7s2YorZuunMHwT2uhp6DtOVubC/MdjD+V3zGZvuVu0H6XfV4LvofabH0
 RwA0A
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Various networking features copy frag references of an skb, for example
when unsharing a cloned skb (AF_PACKET trimming a clone), when copying an
skb (nft dup) or when building NFQUEUE messages. This is an effective
way for multiplying folio references held by an skb, allowing for
exceeding folio refcount limits.

This is not specific to large pagecache folios, but with them it is a
lot easier to reach the refcount limit, as page table mappings can cheaply
create many references.

Let's introduce skb_frag_try_ref() and skb_frags_try_ref(), which use
try_get_page(), and use them in pskb_expand_head(), __pskb_copy_fclone(),
skb_zerocopy() and pskb_carve_inside_*(). All of these can already fail,
and their callers handle that.

Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/skbuff_ref.h | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 net/core/skbuff.c          | 35 +++++++++++++++++++-----------
 2 files changed, 76 insertions(+), 12 deletions(-)

diff --git a/include/linux/skbuff_ref.h b/include/linux/skbuff_ref.h
index b6f6da556ee90..560ddc863bbec 100644
--- a/include/linux/skbuff_ref.h
+++ b/include/linux/skbuff_ref.h
@@ -44,6 +44,33 @@ static __always_inline void skb_frag_ref(struct sk_buff *skb, int f)
 		       skb->pp_recycle);
 }
 
+/**
+ * skb_frag_try_ref - try to acquire a reference on a paged fragment of an skb
+ * @skb: the buffer
+ * @f: the fragment offset
+ *
+ * Like skb_frag_ref(), but acquires non-page_pool page references using
+ * try_get_page(), refusing additional references to a page whose refcount is
+ * at its limit.
+ *
+ * Return: True if a reference was acquired, otherwise false.
+ */
+static __always_inline __must_check bool skb_frag_try_ref(struct sk_buff *skb,
+							  int f)
+{
+	netmem_ref netmem = skb_frag_netmem(&skb_shinfo(skb)->frags[f]);
+
+#ifdef CONFIG_PAGE_POOL
+	if (skb->pp_recycle && napi_pp_get_page(netmem))
+		return true;
+#endif
+	if (netmem_is_net_iov(netmem)) {
+		net_iov_inc_ref(netmem_to_net_iov(netmem));
+		return true;
+	}
+	return try_get_page(netmem_to_page(netmem));
+}
+
 bool napi_pp_put_page(netmem_ref netmem);
 
 /**
@@ -83,4 +110,30 @@ static __always_inline void skb_frag_unref(struct sk_buff *skb, int f)
 				 skb->pp_recycle);
 }
 
+/**
+ * skb_frags_try_ref - try to acquire references on all paged fragments
+ * @skb: the buffer
+ *
+ * Try to acquire a reference on each paged fragment of @skb using
+ * skb_frag_try_ref(). On failure, acquired references are dropped.
+ *
+ * Must not be used on skbs with managed frag references.
+ *
+ * Return: True if all references were acquired, otherwise false.
+ */
+static inline __must_check bool skb_frags_try_ref(struct sk_buff *skb)
+{
+	int i;
+
+	DEBUG_NET_WARN_ON_ONCE(skb_zcopy_managed(skb));
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		if (unlikely(!skb_frag_try_ref(skb, i))) {
+			while (i--)
+				skb_frag_unref(skb, i);
+			return false;
+		}
+	}
+	return true;
+}
+
 #endif	/* _LINUX_SKBUFF_REF_H */
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 8da53d5b76fc2..1d44e9a4152e5 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2254,7 +2254,13 @@ struct sk_buff *__pskb_copy_fclone(struct sk_buff *skb, int headroom,
 		n->pp_recycle = skb->pp_recycle;
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 			skb_shinfo(n)->frags[i] = skb_shinfo(skb)->frags[i];
-			skb_frag_ref(n, i);
+			if (!skb_frag_try_ref(n, i)) {
+				/* Drop the references acquired so far. */
+				skb_shinfo(n)->nr_frags = i;
+				kfree_skb(n);
+				n = NULL;
+				goto out;
+			}
 		}
 		skb_shinfo(n)->nr_frags = i;
 		skb_shinfo(n)->flags |= skb_shinfo(skb)->flags & SKBFL_SHARED_FRAG;
@@ -2298,7 +2304,6 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 	unsigned int size = osize + nhead + ntail;
 	long off;
 	u8 *data;
-	int i;
 
 	if (unlikely(nhead < 0)) {
 		DEBUG_NET_WARN_ON_ONCE(1);
@@ -2335,12 +2340,10 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 	 * be since all we did is relocate the values
 	 */
 	if (skb_cloned(skb)) {
-		if (skb_orphan_frags(skb, gfp_mask))
+		if (skb_orphan_frags(skb, gfp_mask) || !skb_frags_try_ref(skb))
 			goto nofrags;
 		if (skb_zcopy(skb))
 			net_zcopy_get(skb_uarg(skb));
-		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
-			skb_frag_ref(skb, i);
 
 		if (skb_has_frag_list(skb))
 			skb_clone_fraglist(skb);
@@ -3896,7 +3899,8 @@ EXPORT_SYMBOL_GPL(skb_zerocopy_headlen);
  *
  *	Return value:
  *	0: everything is OK
- *	-ENOMEM: couldn't orphan frags of @from due to lack of memory
+ *	-ENOMEM: couldn't orphan frags of @from due to lack of memory, or
+ *	         couldn't take additional references to the frags of @from
  *	-EFAULT: skb_copy_bits() found some problem with skb geometry, or readable head
  *      payload would be mixed with unreadable frags.
  */
@@ -3961,7 +3965,11 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
 					len);
 		skb_frag_size_set(&skb_shinfo(to)->frags[j], size);
 		len -= size;
-		skb_frag_ref(to, j);
+		if (!skb_frag_try_ref(to, j)) {
+			/* The caller frees @to, dropping the acquired refs. */
+			skb_shinfo(to)->nr_frags = j;
+			return -ENOMEM;
+		}
 		j++;
 	}
 	skb_shinfo(to)->nr_frags = j;
@@ -6966,7 +6974,6 @@ static void skb_carve_reset_headers(struct sk_buff *skb)
 static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
 				    const int headlen, gfp_t gfp_mask)
 {
-	int i;
 	unsigned int size = skb_end_offset(skb);
 	int new_hlen = headlen - off;
 	u8 *data;
@@ -6994,14 +7001,12 @@ static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
 			frags[skb_shinfo(skb)->nr_frags]));
 	if (skb_cloned(skb)) {
 		/* drop the old head gracefully */
-		if (skb_orphan_frags(skb, gfp_mask)) {
+		if (skb_orphan_frags(skb, gfp_mask) || !skb_frags_try_ref(skb)) {
 			skb_kfree_head(data);
 			return -ENOMEM;
 		}
 		if (skb_zcopy(skb))
 			net_zcopy_get(skb_uarg(skb));
-		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
-			skb_frag_ref(skb, i);
 		if (skb_has_frag_list(skb))
 			skb_clone_fraglist(skb);
 		skb_release_data(skb, SKB_CONSUMED);
@@ -7131,7 +7136,13 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
 				skb_frag_off_add(&shinfo->frags[0], off - pos);
 				skb_frag_size_sub(&shinfo->frags[0], off - pos);
 			}
-			skb_frag_ref(skb, i);
+			if (!skb_frag_try_ref(skb, i)) {
+				/* We referenced frags i - k ... i - 1 so far. */
+				while (k--)
+					skb_frag_unref(skb, --i);
+				skb_kfree_head(data);
+				return -ENOMEM;
+			}
 			k++;
 		}
 		pos += fsize;

-- 
2.56.0

