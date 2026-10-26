Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007759;
	b=qLJayVlWbfl5Ict8l5ARR5JAtWMRsoPSSEgKjPsoWW9OCIDJ1pGNd1442mrDbDj7mQQG
	 C6KYxMS8QtPqT6eM6T2n6Q63OQY5ZTHg4OEVZ676mMzi/0bR3Vo36n+TmQ3OGuZH4lhO0
	 aUA/J8wPnPau3736nANatbLPubHMk4f9FJCzOUD/Xhyy+3F7EonVAiq2vmITgXHJyctwn
	 BKdzLKta52UuVRdvWrvS2/Ojl35DvsizBwPUM4YRtpuOgfBK2iiuPaAKYIB7hSCj9XU9M
	 f6bZrg1G8/RMvyHCqqGI9UPB/4Sh31bsKrTInJLIKHx9MMkqnyvcvW7zoxgqDu+aQwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007759;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=mvZKYtjJONqhmHx9UTd6oM7xaC8eYsTGRgCqXckztow=;
	b=HP7KYclPKpukEvvedVGWpiqmfTHEZLiU9PJRn9D9UTm9HuM2NyiY8Dp4z0m3e25wo4r2
	 aGtYHhb21YvoKOf9JlFPY9hK4P5FUgDb7eTSpKAjZr429rFCVeq9DtG0HWA72JM31p3+6
	 cJTQvngmbuH4r74701lSAYYRbrKImn5jP07SP7UgPWr6UPWIhlPqwhCNvJTyYo4LBSH2t
	 hfSaj8yFloywsplAq3I42+1gPIIfbQzc/ICxhEOKnBOXyZfQfYb3hLbFEzW3t8hd8ib0x
	 o2/BbvNzBe0mn40JSHKoCNaCjWcWGw23jB22T425fxGyuwpI6KgwJM9vW0KKk3t+YsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IFJkaVff;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DB260A2625;
	Mon, 26 Oct 2026 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IFJkaVff
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341091F01481;
	Mon, 26 Oct 2026 09:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793007758;
	bh=mvZKYtjJONqhmHx9UTd6oM7xaC8eYsTGRgCqXckztow=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IFJkaVffg8V/Tq2zsOyrwUTHkmgAN7z2UXol3hm2HOIH+aJvGLAtJfL5mybzgrPag
	 cwzykKLSUJQreiBo+xkChyPpNSqRMSoBU09oLoodEt/0FAm1uFlsAJCMxiYLbrQy8q
	 xFTZsTDXdNaLGH7oEZJSVjcXIgK8w5zLeHUJ4+6YHIlLrVBQF9l4rO6RD2G+jNz1mk
	 fhSOfrxKtfWVmAR78B+A9TOLSTP3CmMbSIuKK9kZ7A/U37wqs84++yBYhXcmfwA3qy
	 8gsstED78sS4ogHO/Z1MGSTyTHr918Gb3pRhzmbuc4lGqme8j8zZjHiilQi6H4cupy
	 Iq1M7IFP/YU+g==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 26 Oct 2026 10:40:48 +0100
Subject: [PATCH 15/16] mm/shmem: fix accounting of swapin-error markers
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
Message-Id: <20261026-fixes_shmem-v1-15-703206d5fa0c@kernel.org>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
In-Reply-To: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 Vladimir Davydov <vdavydov.dev@gmail.com>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Lukas Czerner <lczerner@redhat.com>, Carlos Maiolino <cmaiolino@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Stevens <stevensd@chromium.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 William Kucharski <william.kucharski@oracle.com>, 
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Nhat Pham <nphamcs@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4415; i=david@kernel.org;
 h=from:subject:message-id; bh=ex+R5CTudd+Uv2VS81erAcqB58oiZJKAMktJTm4l9cM=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLuK0hMTZ2y7Hi+uvRV92XX5tr6nos2yozf4Jm/aMKz4
 PVWp8L+d5SyMIhxMMiKKbIEBd83ePlyXW21Gx8zzBxWJpAhDFycAjCRC48Y/insNBfUmnr6TcLT
 wzWSew98+/r+5OSmI63rJk6qEZ/52buekeHUqvityczrhARFvlc5Wcd9NZJ+8U0hSc792rmfk79
 cZeUGAA==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

A failed swap read replaces the swap entry with a swapin-error marker in
the page-cache and subtracts its pages from "alloced" and "swapped";
however, it leaves their block charge in place.

Removing the marker during truncate then subtracts from "swapped" again.
This can underflow the counters or make swapped reach zero while other
pages remain swapped out, causing swapoff to loop without finding them.

When installing the marker, subtract only from "swapped" and let
shmem_recalc_inode() reduce "alloced" and release the block charge.

Make shmem_free_swap() report successful removal separately from the
number of swap pages freed, so removing a swapin-error marker does not
subtract from "swapped" again.

It's a bit confusing, but replacing a swapped out page by a swapin-error
marker in shmem_set_folio_swapin_error() behaves as follows:

Initially:
	alloced=1, swapped=1, nrpages=0
Calling shmem_recalc_inode(inode, 0, -1)
	-> swapped = 0
	-> freed =  1 - 0 - 0 = 1
	-> alloced -= freed
	-> alloced=0, swapped=0, block charge released

Fixes: 6cec2b95dadf ("mm/shmem: fix infinite loop when swap in shmem error at swapoff time")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 6b24b9d6db26e..f5b5c9a312c53 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1177,12 +1177,11 @@ static void shmem_delete_from_page_cache(struct folio *folio, void *radswap)
 }
 
 /*
- * Remove swap entry from page cache, free the swap and its page cache. Returns
- * the number of pages being freed. 0 means entry not found in XArray (0 pages
- * being freed).
+ * Remove a swap entry or swapin-error marker wholly within [index, end].
+ * Return whether it was removed, counting freed swap pages in nr_swaps_freed.
  */
-static long shmem_free_swap(struct address_space *mapping,
-			    pgoff_t index, pgoff_t end, void *radswap)
+static bool shmem_free_swap(struct address_space *mapping,
+		pgoff_t index, pgoff_t end, void *radswap, long *nr_swaps_freed)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
 	const softleaf_t swp = radix_to_swp_entry(radswap);
@@ -1203,8 +1202,10 @@ static long shmem_free_swap(struct address_space *mapping,
 	xas_unlock_irq(&xas);
 
 	/* A swapin-error marker holds no swap slot, so just drop it. */
-	if (nr_pages && softleaf_is_swap(swp))
+	if (nr_pages && softleaf_is_swap(swp)) {
 		swap_put_entries_direct(swp, nr_pages);
+		*nr_swaps_freed += nr_pages;
+	}
 
 	return nr_pages;
 }
@@ -1358,8 +1359,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 			if (xa_is_value(folio)) {
 				if (unfalloc)
 					continue;
-				nr_swaps_freed += shmem_free_swap(mapping, indices[i],
-								  end - 1, folio);
+				shmem_free_swap(mapping, indices[i], end - 1,
+						folio, &nr_swaps_freed);
 				continue;
 			}
 
@@ -1432,13 +1433,11 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 
 			if (xa_is_value(folio)) {
 				int order;
-				long swaps_freed;
 
 				if (unfalloc)
 					continue;
-				swaps_freed = shmem_free_swap(mapping, indices[i],
-							      end - 1, folio);
-				if (!swaps_freed) {
+				if (!shmem_free_swap(mapping, indices[i], end - 1,
+						     folio, &nr_swaps_freed)) {
 					pgoff_t base = indices[i];
 
 					order = shmem_confirm_swap(mapping, indices[i],
@@ -1459,7 +1458,6 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 					index = base;
 					break;
 				}
-				nr_swaps_freed += swaps_freed;
 				continue;
 			}
 
@@ -2420,11 +2418,10 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 	folio_put_swap(folio, NULL);
 	swap_cache_del_folio(folio);
 	/*
-	 * Don't treat swapin error folio as alloced. Otherwise inode->i_blocks
-	 * won't be 0 when inode is released and thus trigger WARN_ON(i_blocks)
-	 * in shmem_evict_inode().
+	 * Let shmem_recalc_inode() reduce alloced and release the block charge
+	 * for the freed swap pages.
 	 */
-	shmem_recalc_inode(inode, -nr_pages, -nr_pages);
+	shmem_recalc_inode(inode, 0, -nr_pages);
 }
 
 static int shmem_split_large_entry(struct inode *inode, pgoff_t index,

-- 
2.43.0

