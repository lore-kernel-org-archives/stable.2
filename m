Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794673703;
	b=HkuE8saJJyI2n7AXVqfOPWnUGK1d40DCpbWm/+E+Lftf3HLKunJLTJeC/spncJZ0wqR0
	 ThIwWNao2vFiND6vcm/EBHMFFlGnK+MwLcDuUpwF+Eh6LEIoahtN6pyXDh5aqhlru5kT/
	 r0ZVxn6JvP6ph5SRdXknY17YydhF9hw26lzQApYaUyDZhw0MkwIf4+twYEcLFnzfDJ66p
	 d3R9NsGpjT23RSRQBRp4DfFxZKkUlVhKIIrx7pM70+sNpH/7fwmeCzsoG2+rzfMx/WfZF
	 Gzg0OT/Rqvy2lyj/5+i+/HBpYXutVouIcQOrq6LEvsqnemTDaFXX6a4J9LrJ9OUH2VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794673703;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zDXjTtj71MTfm3XcEKHVwWiUaRLyTjCPs6mURWOXY4E=;
	b=GMV1qqVmIzt8iANRH1BI6iWWMof5Eq2wWyh74pvjEPWP0ZoLipxoBnmKZ88+rmVXGTwy
	 nDyMxH8iXYbdRs72bSSWP5MYcFlqwn9oJzHHcTpUgn0OiQFhKZMUn53Qql+YvClKdVlx9
	 F3P/+0A7RhV+kUMEuQMGDmon4i3JA0bfRP21F2yFt2nOt+kq05wn4xiKje23w308ljTZ4
	 EvrQPRgltzPIK80lN8o7SWaIsoUktIVlBCihd06UZlJOnNEvVHMQmHceO5x71iw6+/EiH
	 n+ypWK/nD8XJ4CUkZrQ4YfskLYcBLgSpoE8Au+RpZODpss+O1XBGN0syful2yCII91A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DamEfowX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497E6606A327
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 16:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DamEfowX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B051F000C4;
	Sat, 14 Nov 2026 16:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794673702;
	bh=zDXjTtj71MTfm3XcEKHVwWiUaRLyTjCPs6mURWOXY4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DamEfowXei7aVaKuWVoMxpemxSnnLKdbsXP96NwbKeMm6zm0O9v4icwXw8ukySleB
	 K2qwNqmD8SjNkGIf11bniFvVMyFbFnu2dc6TJmp3+Lr/cQi1BSBx4R3gPfCtj1O9/+
	 lVX8me7FneI9dCoUG40IxWTtiq481nsWu8b7XrHVVwbdvQyj/C/AfP64qkohA3lqZk
	 2ch/EcdW6uk5uK5LFPrzJMNshnpb0gIQFN8YkR++0/K5FUtnV+keAuXtXskNYmZPVD
	 Gnm7+I3RAcyT3XU+P6mpRNwWYaAha7jyT5f7gOCfhL4AH3539vf5RwrHN+lxFExQVL
	 +9NBM8lbOEZ4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/shmem: fix accounting of swapin-error markers
Date: Sat, 14 Nov 2026 11:28:20 -0500
Message-ID: <20261114162454.4022501-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201118-failed-6.6-66ce68a249f4@kernel.org>
References: <20261109201118-failed-6.6-66ce68a249f4@kernel.org>
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
[ sashal: Adapted multi-page softleaf_t swap handling to older swp_entry_t APIs for single-page entries. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/shmem.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 0f7c7ec48837a..d5b662d5094bf 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -850,18 +850,24 @@ static void shmem_delete_from_page_cache(struct folio *folio, void *radswap)
 }
 
 /*
- * Remove swap entry from page cache, free the swap and its page cache.
+ * Remove a swap entry or swapin-error marker at index.
+ * Return whether it was removed, counting freed swap pages in nr_swaps_freed.
  */
-static int shmem_free_swap(struct address_space *mapping,
-			   pgoff_t index, void *radswap)
+static bool shmem_free_swap(struct address_space *mapping,
+		pgoff_t index, void *radswap, long *nr_swaps_freed)
 {
+	const swp_entry_t swp = radix_to_swp_entry(radswap);
 	void *old;
 
 	old = xa_cmpxchg_irq(&mapping->i_pages, index, radswap, NULL, 0);
 	if (old != radswap)
-		return -ENOENT;
-	free_swap_and_cache(radix_to_swp_entry(radswap));
-	return 0;
+		return false;
+	/* A swapin-error marker holds no swap slot, so just drop it. */
+	if (!non_swap_entry(swp)) {
+		free_swap_and_cache(swp);
+		(*nr_swaps_freed)++;
+	}
+	return true;
 }
 
 /*
@@ -1014,8 +1020,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			if (xa_is_value(folio)) {
 				if (unfalloc)
 					continue;
-				nr_swaps_freed += !shmem_free_swap(mapping,
-							indices[i], folio);
+				shmem_free_swap(mapping, indices[i], folio,
+						&nr_swaps_freed);
 				continue;
 			}
 
@@ -1083,12 +1089,12 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			if (xa_is_value(folio)) {
 				if (unfalloc)
 					continue;
-				if (shmem_free_swap(mapping, indices[i], folio)) {
+				if (!shmem_free_swap(mapping, indices[i], folio,
+						     &nr_swaps_freed)) {
 					/* Swap was replaced by page: retry */
 					index = indices[i];
 					break;
 				}
-				nr_swaps_freed++;
 				continue;
 			}
 
@@ -1842,11 +1848,10 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 	folio_wait_writeback(folio);
 	delete_from_swap_cache(folio);
 	/*
-	 * Don't treat swapin error folio as alloced. Otherwise inode->i_blocks
-	 * won't be 0 when inode is released and thus trigger WARN_ON(i_blocks)
-	 * in shmem_evict_inode().
+	 * Let shmem_recalc_inode() reduce alloced and release the block charge
+	 * for the freed swap pages.
 	 */
-	shmem_recalc_inode(inode, -1, -1);
+	shmem_recalc_inode(inode, 0, -1);
 	swap_free(swap);
 }
 
-- 
2.53.0

