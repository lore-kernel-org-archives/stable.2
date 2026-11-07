Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046460;
	b=g/lMK2Yl7KL97ALKjMLQwNpp3mWoE3PGzq9KPswNxcqj4CDjQiWEtLzcSy5p2r6gktUy
	 Oap96pDqCQ6XdLXnEoZ5TI66Dbjb5KZT70jlNQ+rsVX7Y3xr8t1dO0+AVd6GP0y9iBEZM
	 JLNpOtMe7qhU/CPPL1AYbgShBB7tmtGV6VNzL8GECNqCduYmPniDdv1cO+bNDMs4mIYc0
	 wQOELWAmgQoePAMeCZKaBzgzMW5Q7R9SVngaOhBYIezbjm+2AlBONSS7+MXk3G8h0VRZG
	 Yrl5dHJybKV4jVEgnrMT1H9+Yo/B5z89VxTtfagCgu3x/oEP5792aKl5rJv3Z8O3qJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046460;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=o1uWZGE7hthj009Nb/sfVxpUnFCC8weOJeYDzM+twHg=;
	b=h4iG3UZXXUAKiijdLbu6V61ius5Qs5oVlufI+foM+ovswUFFak697hjY/k1THavaIt6T
	 rKB4R61jT7T6SslZIhu3jkrgTItDjnLMGb1nG/Qx82ej5YNR84Ky2QQahdgxbIyOqj6b0
	 GJlGgx9EPHrl6nIZojDM9VYKstd0spiWXP4caTae6S95l/I+wB2lNPKCTrwTiSSTr75bs
	 RzRe4E1F+d19zco9ViSI7Tiu40q+8ECC6crJfjbhofH/Icrl2SCsUy7R4Et97943TrdnD
	 Gi0Jvu30tAU84Xv/ZpVkSpvExwLIPl+KhplIYD32NGfG188qoiCMYcMqrpPNZeeSdug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zrzm57Um;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EC4606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zrzm57Um
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E98B1F008A1;
	Sat,  7 Nov 2026 10:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046460;
	bh=o1uWZGE7hthj009Nb/sfVxpUnFCC8weOJeYDzM+twHg=;
	h=From:To:Cc:Subject:Date;
	b=Zrzm57UmDl6xlmQ1Is5aV0/xzeIkIBpRKVRGihFYSPurlucuuqAAiuIlYfjREj5zO
	 DpE+Clevpu2Vty3cBNCO2Lcr37GCOrzNEXL0cQeVGqkk3W3oJg6C8NekkgYZ11D5k1
	 POixoHb4VTJ0yUjhoA6FLOazVzr3K2HrDT5zqJyVFmpN2v0kIK01+b9dwnMtEa7ZWg
	 gkeZ8/gUEecw0nbtki7d4nba07pHzLt9QsqBmzoU4y71Wvwql9LI7fCcvD2c2a6RB2
	 pDBztiOMlqjy/I0FKvRt2P319OGk0+2z4OmHByuqknJZs5OrzN+CU8Y6wek6RK0zqg
	 0T8zDZoAPjzyQ==
From: Sasha Levin <sashal@kernel.org>
To: lihongfu@kylinos.cn,
	akpm@linux-foundation.org,
	david@kernel.org,
	baolin.wang@linux.alibaba.com,
	hughd@google.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	vivek.kasireddy@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/memfd: fix hugetlb reservation accounting in error paths" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:14:17 -0500
Message-ID: <20261107051417-failed-6.18-50ee565c1e90@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 50ee565c1e900e247e439e4139839b060c968343
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051417-failed-6.18-50ee565c1e90@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 50ee565c1e900e247e439e4139839b060c968343 Mon Sep 17 00:00:00 2001
From: Hongfu Li <lihongfu@kylinos.cn>
Date: Thu, 3 Sep 2026 11:01:34 +0800
Subject: [PATCH] mm/memfd: fix hugetlb reservation accounting in error paths

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
---
 mm/memfd.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index c708d92533f4a..0f6fff004f5e4 100644
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
 		nr_resv = hugetlb_reserve_pages(inode, idx, idx + 1, NULL, EMPTY_VMA_FLAGS);
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




