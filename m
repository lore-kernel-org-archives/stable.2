Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794672038;
	b=WXBwswEjpkZt+peA/qlyB9Xstwyqe8IxggpbV7xpPOba6ZLkk9qShLzO0ckibYPu5Fb2
	 1IKsNkcwN/+mHdb/h0msGwXfUlsFflpgEOT/w//nTJgVTQkCvHCLL9nCuJLtAFBfkha29
	 1YGp1OmqEQxsjW0bnsBq/DzX1U1rtwessJ746IHxL9FVFBKKfg3JUTCDF6hfn6yZrtyLk
	 cDkb7qTvAtaAKDnkXYXX2ujIX04QkzbHhH0UnJRwacca8AVS0we2EjcNQhJ8XEZBvVS+U
	 3QRtaG8m7logqW2SioKNcPk8TWsxKJ3C/W/Jessd/di4+WmXebmJRAap2q3oMkNgNBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672038;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lsmxITMmSW0elYEZ5EsLhhdo35zyPEVkSkFGzD291ag=;
	b=X6GxYbZqoesewBpTH6j/McfPRg+EWrCJEvYrlGvhHzMYXQLzHT8ul7Kvuj86fXH9ZTm7
	 yUl23O/WGjYLnF7d8zZfA73ug41oBdqQ0KBV+KykHAHXz/xeX+ZOahivDQY05+LN4KQ6N
	 xesTyhOlt6DhO4BFAvYKMNJldvhaQ4W8YhaMjHBAadBx9f/Q8rSlif6LlfBqtL169b7ea
	 ZGSSTSyIMlEooBQHTp4+ZUCdBurzCduEQrTEu2hBfk9Mfsbm2RwPxU6t3nc12voM3N+PO
	 EwzRYG9epYNp66qU9vnRqg/0KjTZLyM2GX5ccOUN5xB5zUlvTbJClOJqGVID/pejUmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIl1Tn27;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1455B606A32E
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIl1Tn27
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB14E1F000C4;
	Sat, 14 Nov 2026 16:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794672037;
	bh=lsmxITMmSW0elYEZ5EsLhhdo35zyPEVkSkFGzD291ag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aIl1Tn27N+LYxtIyWE/LinlqJRZkaW2LpIvXJKHiOlr89QJyfwGS0//92rok9Q5VD
	 q9coLQXsUV294Qaubj6iGQ8qwB6yNffVYZJ4Re29xLP4uWOKLLnCyw+w4Y2i8y5csk
	 IZ3+Aqf6XiYYg5jgvke9wYwgVmnajuvwFAfvAqs5kNR7V2Us54g+o2OL4o1v3F5S7I
	 IGzA55LEuw1exl67zXFnni6Da1hWdaLpqoGML1tOxFgJhH6b23oQJdGt/2Kwsux64V
	 iFrvHlUBzGhvJiI/z0hm5ppaVKxulxXBsRX3SfBxEcDICVthTixp1uA/W5rYAgL+Zw
	 AMlpEJAe2KUvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mm/shmem: fix accounting of swapin-error markers
Date: Sat, 14 Nov 2026 11:00:35 -0500
Message-ID: <20261114160024.3870080-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200307-failed-6.18-66ce68a249f4@kernel.org>
References: <20261109200307-failed-6.18-66ce68a249f4@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "David Hildenbrand (Arm)" <david@kernel.org>

[ Upstream commit 66ce68a249f4ac56cd6968aa6d8ded20fb4b7d09 ]

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
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Link: https://patch.msgid.link/20261029-fixes_shmem-v4-14-392fc715d8f6@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
[ sashal: adapted swap-entry handling to !non_swap_entry() and the existing swap-release APIs ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/shmem.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 6828611bcdfe0..eb052b1dad252 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -940,12 +940,11 @@ static void shmem_delete_from_page_cache(struct folio *folio, void *radswap)
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
 	const swp_entry_t swp = radix_to_swp_entry(radswap);
@@ -966,8 +965,10 @@ static long shmem_free_swap(struct address_space *mapping,
 	xas_unlock_irq(&xas);
 
 	/* A swapin-error marker holds no swap slot, so just drop it. */
-	if (nr_pages && !non_swap_entry(swp))
+	if (nr_pages && !non_swap_entry(swp)) {
 		free_swap_and_cache_nr(swp, nr_pages);
+		*nr_swaps_freed += nr_pages;
+	}
 
 	return nr_pages;
 }
@@ -1120,8 +1121,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			if (xa_is_value(folio)) {
 				if (unfalloc)
 					continue;
-				nr_swaps_freed += shmem_free_swap(mapping, indices[i],
-								  end - 1, folio);
+				shmem_free_swap(mapping, indices[i], end - 1,
+						folio, &nr_swaps_freed);
 				continue;
 			}
 
@@ -1188,13 +1189,11 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 
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
@@ -1215,7 +1214,6 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 					index = base;
 					break;
 				}
-				nr_swaps_freed += swaps_freed;
 				continue;
 			}
 
@@ -2238,11 +2236,10 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 	if (!skip_swapcache)
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
 	swap_free_nr(swap, nr_pages);
 }
 
-- 
2.53.0

