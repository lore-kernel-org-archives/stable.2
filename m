Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794406085;
	b=nZtHWDMAuSRyQQBs+7pRv4YvXSP+CPJmzAn/pVqQDTMhpxMkyoG7viBoyyPhJCsh630a
	 fCfxRnBOi0LcIFMh7BLOsHSZl+PmO/i9RnNGQfN9yzXAcf48p2BOh926D3FSm7DrDHZQW
	 kst2sC5jQzKxYPKXEFgu5G4VN7ulFm6m9RjzloRmwAYpk5+cPgLcH3HRZQ1JPXZw9UtJY
	 ld9a/YwiBDSzBFB++KK0Z3Tkc9u/MoZBc+y3XSMGnbTYrnCuP8e0F+1x1GSQZlSLTvz38
	 FjegrNEbGzxgkj0mfWy4ettmjY/cKBSDKW0QZ2XVG0hw5Sw6u7e8DUaPuXItCgdG3wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794406085;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XTzKPK0obESxwbNjGbS2R3joW7YIj0S69qniHfaNtBI=;
	b=I1akYvs9uz4kWPHHVu9TbKicqoAUUW31D99AZGarDnHc5UYlgebhBIGK6V/XlIgS/BIu
	 HFQqfFC48PigLcwLGDZSYTnBB7XSKgszBqfFQXs2giufsY8eYRoIA142fnogjDFOr+3AF
	 QMo1Dxpgq+VdAY93DRnc5CyOhE2oa5vNa+KV4mSe7tZDOHd8HLPc9vy+iJcTwZp2D37ha
	 zv6voIZuVYAmJReF1Y50dbyzax45UPKjG/FbhjIGKDHA1WYfk0PJujvHbHqAHAciDVXHy
	 DeaR2CRD0Wu55zhyNMPunpyXUr3L67lyi2iHYb/Dafu7N2ZLwwsQ8SvT5hg/lY9bCZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D4J6Un7b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AF9606A327
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D4J6Un7b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469311F00A06;
	Wed, 11 Nov 2026 14:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794406085;
	bh=XTzKPK0obESxwbNjGbS2R3joW7YIj0S69qniHfaNtBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D4J6Un7boB9xIeUzKBC0RKdEGCtfgAJ+L/PBSzlrAWlnbimRA/7aiWgrivlkgWBlt
	 Rf//jOcdmPEEZg4r+/BQHRMy00uZKO6bWGY+9VwXnP8aMz/M0O7gOaKJYVJa6ITprG
	 UlYor9CrBUV5C3dUUJPv2VgrygUhHqm26aED+Mw/eDJSYQXVEw260MQFXgp+EEPvU/
	 N0drUwu91Zjg7Xf/bumBdQbgVWxxSwwybvte3pCkP7b4QM3zahkKnXB3SpXph86TP9
	 dK+ionWWMzoB80BWd13ZIw4I/UVm6lcA0ecEVv51/siWtbAnsCezbV1ll8Edy7zFa3
	 KgGrxAXqc8Ouw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] filemap: find_lock_entries() now updates start offset
Date: Wed, 11 Nov 2026 09:08:01 -0500
Message-ID: <20261111140714.2196934-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054738-failed-6.1-ebd1a08c1921@kernel.org>
References: <20261107054738-failed-6.1-ebd1a08c1921@kernel.org>
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

From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>

[ Upstream commit 3392ca121872dd8c33015c7703d4981c78819be3 ]

Patch series "Rework find_get_entries() and find_lock_entries()", v3.

Originally the callers of find_get_entries() and find_lock_entries() were
keeping track of the start index themselves as they traverse the search
range.

This resulted in hacky code such as in shmem_undo_range():

			index = folio->index + folio_nr_pages(folio) - 1;

where the - 1 is only present to stay in the right spot after incrementing
index later.  This sort of calculation was also being done on every folio
despite not even using index later within that function.

These patches change find_get_entries() and find_lock_entries() to
calculate the new index instead of leaving it to the callers so we can
avoid all these complications.

This patch (of 2):

Initially, find_lock_entries() was being passed in the start offset as a
value.  That left the calculation of the offset to the callers.  This led
to complexity in the callers trying to keep track of the index.

Now find_lock_entries() takes in a pointer to the start offset and updates
the value to be directly after the last entry found.  If no entry is
found, the offset is not changed.  This gets rid of multiple hacky
calculations that kept track of the start offset.

Link: https://lkml.kernel.org/r/20221017161800.2003-1-vishal.moola@gmail.com
Link: https://lkml.kernel.org/r/20221017161800.2003-2-vishal.moola@gmail.com
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: ebd1a08c1921 ("mm/shmem: report RCU-tasks quiescent states while undoing a range")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/filemap.c  | 15 ++++++++++++---
 mm/internal.h |  2 +-
 mm/shmem.c    |  8 ++------
 mm/truncate.c | 11 +++--------
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index e26b58aa3c6e4..7c996dc4dad28 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2125,16 +2125,16 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
  *
  * Return: The number of entries which were found.
  */
-unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
+unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices)
 {
-	XA_STATE(xas, &mapping->i_pages, start);
+	XA_STATE(xas, &mapping->i_pages, *start);
 	struct folio *folio;
 
 	rcu_read_lock();
 	while ((folio = find_get_entry(&xas, end, XA_PRESENT))) {
 		if (!xa_is_value(folio)) {
-			if (folio->index < start)
+			if (folio->index < *start)
 				goto put;
 			if (folio->index + folio_nr_pages(folio) - 1 > end)
 				goto put;
@@ -2157,6 +2157,15 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
 	}
 	rcu_read_unlock();
 
+	if (folio_batch_count(fbatch)) {
+		unsigned long nr = 1;
+		int idx = folio_batch_count(fbatch) - 1;
+
+		folio = fbatch->folios[idx];
+		if (!xa_is_value(folio) && !folio_test_hugetlb(folio))
+			nr = folio_nr_pages(folio);
+		*start = indices[idx] + nr;
+	}
 	return folio_batch_count(fbatch);
 }
 
diff --git a/mm/internal.h b/mm/internal.h
index 3e3dfc8e0bc6a..f99d9812c48d7 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -125,7 +125,7 @@ static inline void force_page_cache_readahead(struct address_space *mapping,
 	force_page_cache_ra(&ractl, nr_to_read);
 }
 
-unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
+unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
 unsigned find_get_entries(struct address_space *mapping, pgoff_t start,
 		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
diff --git a/mm/shmem.c b/mm/shmem.c
index 97288239d98a5..420d4e3b79e35 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -931,21 +931,18 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 
 	folio_batch_init(&fbatch);
 	index = start;
-	while (index < end && find_lock_entries(mapping, index, end - 1,
+	while (index < end && find_lock_entries(mapping, &index, end - 1,
 			&fbatch, indices)) {
 		for (i = 0; i < folio_batch_count(&fbatch); i++) {
 			folio = fbatch.folios[i];
 
-			index = indices[i];
-
 			if (xa_is_value(folio)) {
 				if (unfalloc)
 					continue;
 				nr_swaps_freed += !shmem_free_swap(mapping,
-								index, folio);
+							indices[i], folio);
 				continue;
 			}
-			index += folio_nr_pages(folio) - 1;
 
 			if (!unfalloc || !folio_test_uptodate(folio))
 				truncate_inode_folio(mapping, folio);
@@ -954,7 +951,6 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
 		cond_resched();
-		index++;
 	}
 
 	/*
diff --git a/mm/truncate.c b/mm/truncate.c
index 7297ad6b5aac5..cd6768ca5b975 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -385,9 +385,8 @@ void truncate_inode_pages_range(struct address_space *mapping,
 
 	folio_batch_init(&fbatch);
 	index = start;
-	while (index < end && find_lock_entries(mapping, index, end - 1,
+	while (index < end && find_lock_entries(mapping, &index, end - 1,
 			&fbatch, indices)) {
-		index = indices[folio_batch_count(&fbatch) - 1] + 1;
 		truncate_folio_batch_exceptionals(mapping, &fbatch, indices);
 		for (i = 0; i < folio_batch_count(&fbatch); i++)
 			truncate_cleanup_folio(fbatch.folios[i]);
@@ -534,20 +533,17 @@ unsigned long invalidate_mapping_pagevec(struct address_space *mapping,
 	int i;
 
 	folio_batch_init(&fbatch);
-	while (find_lock_entries(mapping, index, end, &fbatch, indices)) {
+	while (find_lock_entries(mapping, &index, end, &fbatch, indices)) {
 		for (i = 0; i < folio_batch_count(&fbatch); i++) {
 			struct folio *folio = fbatch.folios[i];
 
 			/* We rely upon deletion not changing folio->index */
-			index = indices[i];
 
 			if (xa_is_value(folio)) {
 				count += invalidate_exceptional_entry(mapping,
-								      index,
-								      folio);
+							     indices[i], folio);
 				continue;
 			}
-			index += folio_nr_pages(folio) - 1;
 
 			ret = mapping_evict_folio(mapping, folio);
 			folio_unlock(folio);
@@ -566,7 +562,6 @@ unsigned long invalidate_mapping_pagevec(struct address_space *mapping,
 		folio_batch_remove_exceptionals(&fbatch);
 		folio_batch_release(&fbatch);
 		cond_resched();
-		index++;
 	}
 	return count;
 }
-- 
2.53.0

