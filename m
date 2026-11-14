Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794672714;
	b=PBFokN6vsGarw3j4TATMpYe6IrdZmxKtrC4BzOL/MZO5JxFMcwhsp1QsJzUuFcqEWZHm
	 5p3TBP1fwBvdCastxRUyZe0UeujpzNWIMQvGZCv9osNb6YjZkDdAqGVviwVEYd8fqAHhI
	 FDMqzcJOnFa/8m2TTt5BbqimHvs5Fl2htzsXY8W+sO+EU8xRvsGgesFKFY16vKAHDPKj4
	 LZiyX8wdw9zMPsn0GCO2EYEQoWGXG2H2E11aT/1fPVZcMBEqhXytom/Zb2I0UyQOTeBIs
	 uePGIiNlQnl+gDcid+RURg0azubfHvg8rHMxgqhJKGAfAvW1pdRfj1+PyuYfCwd26/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794672714;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kE4KlwIsScTrpUzhReJLJSKgU+4scfZGBmxZmXYvxH4=;
	b=SiYBTaRHOxm4+UBn9JU1rW6IDm/dyL/y5i6G9ePvL9QRXg5SPrfcqWm7e3gW8N9VINbA
	 1EAn37toobf8tN8MEk+Ygy6IZD+GTuWrQAC7yhVS0RS30kyULqEn4p1h77bIdw11q3YeX
	 XWb4f4Ge31UExxuhnKG1Wkq+uokHfbFciUNcatjZwbpdgUabYbzL+rWAvz+H1K6G8zPCb
	 u6yOvPuz5zHBJD7s1E3btsb5nsmqohcRvuB3COsxT0KUAPK6zfl97gba/bD18cyOYhBVR
	 RShkiJq4EupWO/F0MKw+gBxFNMMAASMHdrmwx1naBY+WTY0mpGKclch0Fck9dcSJGtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FrCwAUzu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA8E606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 16:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FrCwAUzu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592D11F000C4;
	Sat, 14 Nov 2026 16:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794672714;
	bh=kE4KlwIsScTrpUzhReJLJSKgU+4scfZGBmxZmXYvxH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FrCwAUzua436lT5ZyiOs/CDST3xUUwzgdwWoyV9tQkGwes2rfEiD+aK2ThkQJ0KHA
	 ebhDTCGlBq3oYYlJ0Ckx83F1f78O1NRnKDProDEhC4Ctrtq1X34Jniu7tJJoT4P4hP
	 K/bEIXNRTBUbPDbA6/jrMLzSNbKWdGdFuAQNyueIbe4tbuzym6wc550/6I8HZP6xGz
	 OdaN+dHTXEvp6tzFqPj1BZv/0z1RksAzkvbDG6uq36i8zcOMZsARpHHXcigIpGfY0v
	 +yBNYVFTOm5ziwNSXAiv1Yp7r59Q3Idve/FLYMMAnQbpsq1IIDZrDQ9mDm/flPhuPe
	 aKido6G4KE9qg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/shmem: fix accounting of swapin-error markers
Date: Sat, 14 Nov 2026 11:11:51 -0500
Message-ID: <20261114161135.3948184-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200658-failed-6.12-66ce68a249f4@kernel.org>
References: <20261109200658-failed-6.12-66ce68a249f4@kernel.org>
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
[ sashal: adapted newer swap APIs to the existing swp_entry_t-based interfaces ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/shmem.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 8de38d7a98f92..436d775d987f2 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -868,14 +868,14 @@ static void shmem_delete_from_page_cache(struct folio *folio, void *radswap)
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
+	const swp_entry_t swp = radix_to_swp_entry(radswap);
 	unsigned int nr_pages = 0;
 	pgoff_t base;
 	void *entry;
@@ -892,8 +892,11 @@ static long shmem_free_swap(struct address_space *mapping,
 	}
 	xas_unlock_irq(&xas);
 
-	if (nr_pages)
-		free_swap_and_cache_nr(radix_to_swp_entry(radswap), nr_pages);
+	/* A swapin-error marker holds no swap slot, so just drop it. */
+	if (nr_pages && !non_swap_entry(swp)) {
+		free_swap_and_cache_nr(swp, nr_pages);
+		*nr_swaps_freed += nr_pages;
+	}
 
 	return nr_pages;
 }
@@ -1046,8 +1049,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			if (xa_is_value(folio)) {
 				if (unfalloc)
 					continue;
-				nr_swaps_freed += shmem_free_swap(mapping, indices[i],
-								  end - 1, folio);
+				shmem_free_swap(mapping, indices[i], end - 1,
+						folio, &nr_swaps_freed);
 				continue;
 			}
 
@@ -1114,13 +1117,11 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 
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
@@ -1141,7 +1142,6 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 					index = base;
 					break;
 				}
-				nr_swaps_freed += swaps_freed;
 				continue;
 			}
 
@@ -2066,11 +2066,10 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 	folio_wait_writeback(folio);
 	delete_from_swap_cache(folio);
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

