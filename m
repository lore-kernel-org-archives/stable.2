Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370116;
	b=PtmZKGSAA+S5NLAREe8nvGX76vM+dKdPfxvqcLOfaW8fkhp3QMX1NmC9sNBMBtUW/x2W
	 phAq8Vn0G34w+VLu8tLt3FktowdTOR3tF/wPIX8JgweOtYQ1HiAGNlZX6TpqbLL+O1tZY
	 zPfhby9GZmkBrFcMFPs3Lal2h0Emba7+2oCqErJaNNi3P5Kp4qfDXRtrJyC8AUWZw8wH5
	 h8mPV37qTChiLOQ9iZw+XyvSNvIbH3CZD1KZnrY2Z342fkTHgaOztrZ2z575MNd8ePWeU
	 4//bdKNmw+T8noqENRyf7KGIXJUIpEzQAgWQQF+H3kGxcES9RtbUCsAvJAqcMW5cDpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370116;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=y8BiM6X6WwYkxpoyilAb9oshK8+64NwBF72dcUdEkVY=;
	b=I5DpMQ1i7KJ6ARH/tStht0Ve/mOr50EDPHIzIeuHP6nSeekClt8+HNU0a/qyikrIRe9h
	 6cdd3WOfoDnKPIQMlokJivFgt4lbvqHx9Y+4GnP6W4ky4XY7TTQaNdFom5UZjcrzumvti
	 w3sAtWqfbq+nHFal4oiXKvLjTOmRFyHomzeszSI8HXppSoemwHS6MllSfYDQiM95KPXxL
	 FtMI+KF3Y0iymOu23eKGeiWR9TImmkZ0JilY0j6qA/NXzoFTzh0JbmaNlG2HSIWunAJie
	 ARUS0voyL18cnIyQBbyaplO2IutxobHbaLxY214cudM+NeqjOlk+Ah2fjYVzZgpwi9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="JacC91a/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0BD606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JacC91a/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCF01F0089F;
	Wed, 11 Nov 2026 04:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794370116;
	bh=y8BiM6X6WwYkxpoyilAb9oshK8+64NwBF72dcUdEkVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JacC91a/ASb2On33HnvI7IJ4TkIaQXBmmZhwBBM9KYMd5uahH8XtW0ruFQMEXH7xr
	 W/JLKwBPsDxSjKOG2l3+KXKBtzHhZQkcAJAkiqdD8+rKaYDrBYFBBVfKQrNmGiWIzL
	 f+VuRkZvZvHnWBnRLWBvJVn7LTXzqzZ1TV5WZM8cqrxns+rmiO5c8ta2ncIxH0qg5+
	 FeRvXsFD31sLJhng842T2PMhvNBryU9Nvv8oit7tLKdyPib75tlHCC9+Ng48UdZ3lC
	 s1tixrV9Itcv7Nso1IVppKiu7TmN9iwy9cW45V+XDdvg1l7F4+v9biyOMMHryJYHhD
	 yh3WbLofJDFJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hongfu Li <lihongfu@kylinos.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Hugh Dickins <hughd@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mm/memfd: fix hugetlb reservation accounting in error paths
Date: Tue, 10 Nov 2026 23:08:33 -0500
Message-ID: <20261111040811.1048431-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051417-failed-6.18-50ee565c1e90@kernel.org>
References: <20261107051417-failed-6.18-50ee565c1e90@kernel.org>
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

From: Hongfu Li <lihongfu@kylinos.cn>

[ Upstream commit 50ee565c1e900e247e439e4139839b060c968343 ]

If hugetlb_add_to_page_cache() in memfd_alloc_folio() fails with -EEXIST,
a concurrent fault has already instantiated the folio in the page cache,
and the reservation now belongs to that folio.  Calling
hugetlb_unreserve_pages() in that case incorrectly removes the region
backing the cached folio and releases one reservation more than it should,
leaving that folio in the page cache with no region recording it.

That leaves resv_huge_pages one page short until that folio is removed
from the page cache, so available_huge_pages() reports a page that is not
actually free and the pool can grant one reservation more than it can
back.  Applications using hugetlb memfds can then fail to allocate or
fault in a page they already reserved.  They see -ENOMEM or -ENOSPC from
the allocation or fault path even though the reservation and
HugePages_Free still look healthy.

So hold the hugetlb fault mutex from hugetlb_reserve_pages() until the
error-path unreserve completes to make the reserve, allocate and
instantiate steps atomic against concurrent faults.  With the mutex held
from the start, a concurrent fault can no longer consume the reservation
between reserve and allocate/instantiate.  If a fault completed before the
mutex was taken, it has already added the region for that index, so
hugetlb_reserve_pages() returns 0 and the error path leaves the region in
place.

Link: https://lore.kernel.org/20260927094757.31665-1-hongfu.li@linux.dev
Link: https://lore.kernel.org/20260903030134.7407-1-hongfu.li@linux.dev
Fixes: 717cf9357325 ("mm/memfd: reserve hugetlb folios before allocation")
Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: <stable@vger.kernel.org>
[ sashal: Used 0 instead of EMPTY_VMA_FLAGS in hugetlb_reserve_pages() to match the vm_flags_t API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/memfd.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index aa3c948e55738..d09157cd486a2 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -82,22 +82,31 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 		struct hstate *h = hstate_file(memfd);
 		int err = -ENOMEM;
 		long nr_resv;
+		u32 hash;
 
 		gfp_mask = htlb_alloc_mask(h);
 		gfp_mask &= ~(__GFP_HIGHMEM | __GFP_MOVABLE);
 		idx >>= huge_page_order(h);
 
+		/*
+		 * Serialize hugepage allocation and instantiation to prevent
+		 * races with concurrent allocations, as required by all other
+		 * callers of hugetlb_add_to_page_cache().
+		 */
+		hash = hugetlb_fault_mutex_hash(memfd->f_mapping, idx);
+		mutex_lock(&hugetlb_fault_mutex_table[hash]);
+
 		nr_resv = hugetlb_reserve_pages(inode, idx, idx + 1, NULL, 0);
-		if (nr_resv < 0)
-			return ERR_PTR(nr_resv);
+		if (nr_resv < 0) {
+			err = nr_resv;
+			goto out_unlock;
+		}
 
 		folio = alloc_hugetlb_folio_reserve(h,
 						    numa_node_id(),
 						    NULL,
 						    gfp_mask);
 		if (folio) {
-			u32 hash;
-
 			/*
 			 * Zero the folio to prevent information leaks to userspace.
 			 * Use folio_zero_user() which is optimized for huge/gigantic
@@ -112,20 +121,9 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 			 */
 			__folio_mark_uptodate(folio);
 
-			/*
-			 * Serialize hugepage allocation and instantiation to prevent
-			 * races with concurrent allocations, as required by all other
-			 * callers of hugetlb_add_to_page_cache().
-			 */
-			hash = hugetlb_fault_mutex_hash(memfd->f_mapping, idx);
-			mutex_lock(&hugetlb_fault_mutex_table[hash]);
-
 			err = hugetlb_add_to_page_cache(folio,
 							memfd->f_mapping,
 							idx);
-
-			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-
 			if (err) {
 				folio_put(folio);
 				goto err_unresv;
@@ -133,11 +131,14 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 
 			hugetlb_set_folio_subpool(folio, subpool_inode(inode));
 			folio_unlock(folio);
+			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			return folio;
 		}
 err_unresv:
 		if (nr_resv > 0)
 			hugetlb_unreserve_pages(inode, idx, idx + 1, 0);
+out_unlock:
+		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 		return ERR_PTR(err);
 	}
 #endif
-- 
2.53.0

