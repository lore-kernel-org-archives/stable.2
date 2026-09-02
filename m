Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4123945562D;
	Wed,  2 Sep 2026 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788391852; cv=none; b=OP1ljOiwCzfW0TnlV/r4V8uycqOLjuafjNkBIxMITJoq0Fw5eSF6ljafcvAR5lIUDXRd0JdErmWIiCdVF2cHWyfz5Vm4nv/oyxlBlWGoIhm9o9fCi/LtdFJVBtS7TKYKvUacuSjTs2bxG1pqDuM4MK+3PESFQHspec1kEOVxLrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788391852; c=relaxed/simple;
	bh=Ki955AuPcL8ptd7DA7YclqDVfMByL7PliZlA0BuzWms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kqYVergInM7dcOm91h1+I30t3J76LBZSOLcDRKW5DPlAdNSqxH8+/4NRiKMiyIWnmVWJ5J0nw4nW5dTVb0BDH4ndqq3zpVrliCO3CSZ9JdOrf9u2UZHeKfWfvLDH1tywba6l1uCmWtwtisMfeNXurYffX7Cn+Hs/bCYvtmtNUYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ND/DOedc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ND/DOedc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C45B4C2BCFC;
	Wed,  2 Sep 2026 23:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788391851;
	bh=Ki955AuPcL8ptd7DA7YclqDVfMByL7PliZlA0BuzWms=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ND/DOedcrMFnCY8DfibfP9hDng7EM/361nNjI71Mf0DliHbjkIPxRVh2AfLVoPMnd
	 AbmSFB6qHaq7ORwA9Sm46tCoz8VXHzx3r8KqAqbHyR3qi4Hh2gD8kz5zy5d6H474v9
	 p1gAuoCFI5dA1a8GPx3RsJZ0nR8LbTQ/wpKwOIzZrcg633GODwyQeVmJZFnmnbVQ6P
	 HXsSLmssiEO7h3X9S2riqCtbIaeBhU2ByB6uhauITdLKWW7kdZ6g+UHPtvNvzLgDrs
	 UBae/1LJKXGV69tj5EZvQnl/Usor0RN91bJJeTyoVH7iqbfm0IrpO96iOf8bbVmBgS
	 rpBHM6ja5WI1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DDAC624DA;
	Wed,  2 Sep 2026 23:30:51 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Wed, 02 Sep 2026 16:30:48 -0700
Subject: [PATCH 2/3] mm: hugetlb: Fix out_put_pages subpool reserve
 calculation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-hugetlb-subpool-always-track-used-v1-2-de1cd14bd713@google.com>
References: <20260902-hugetlb-subpool-always-track-used-v1-0-de1cd14bd713@google.com>
In-Reply-To: <20260902-hugetlb-subpool-always-track-used-v1-0-de1cd14bd713@google.com>
To: Alex Shi <alexs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Hongxiang Lou <louhongxiang@huawei.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Nhat Pham <nphamcs@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Peter Xu <peterx@redhat.com>, Randy Dunlap <rdunlap@infradead.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, Usama Arif <usama.arif@linux.dev>, 
 Vlastimil Babka <vbabka@kernel.org>, Wupeng Ma <mawupeng1@huawei.com>, 
 Yanteng Si <si.yanteng@linux.dev>, fvdl@google.com, jthoughton@google.com, 
 rientjes@google.com, vannapurve@google.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Ackerley Tng <ackerleytng@google.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788391851; l=5066;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=WAOJFELA74ZYgV3pRllA7LgbuGP3A6AKBVLXZF1SPnM=;
 b=EvrECO8aOK8i8SdPmLnnbqA1aqPFmPt+mDbbQUb1DM/nBfqdJX4cMT23/J5MKT+VUWwKjNMa6
 9CDPBG1/YNxDRRb2PM6VS+pRvMwSrcWckOcrsVb6nsXBqt40xL3f5DV
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

When reserving pages for a mapping fails during global accounting, the
error path rolls back the adjustments made to the subpool.

Currently, this rollback was performed in two separate steps:

1. Returning only the portion of reservations originally satisfied from the
   subpool
2. Separately adjusting the subpool used pages counter for the portion that
   was requested from the global pool.

In (1.), because the used pages counter had not yet been decremented for
the global portion, the subpool observed an inflated used pages count. If
the mount was configured with both a minimum size and a maximum size, this
inflated count prevented the subpool from recognizing that usage fell below
the minimum size guarantee.

As a result, the subpool failed to restore its reserved pages counter and
instead returned that a global reservation should be dropped. The
mount-time reservation is permanently destroyed, leaving global reservation
counts depleted and causing an underflow when the filesystem is eventually
unmounted.

Additionally, if concurrent threads modified subpool usage during the
reservation attempt, calculating the rollback amount using stale local
variables could cause global reservation counts to diverge.

Now that used pages are always tracked within the subpool, return the
entire requested page count to the subpool in a single call. Global
reservations are then adjusted using the difference between the
reservations originally requested and those returned, fixing the issues
described above.

Fixes: 1d3f9bb4c8af ("mm/hugetlb: restore failed global reservations to subpool")
Cc: stable@vger.kernel.org
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 mm/hugetlb.c | 49 +++++++++++++++++++++++--------------------------
 1 file changed, 23 insertions(+), 26 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 66b6601abb069..d84ef044d1346 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6674,12 +6674,14 @@ long hugetlb_reserve_pages(struct inode *inode,
 		struct vm_area_struct *vma,
 		vma_flags_t vma_flags)
 {
-	long chg = -1, add = -1, spool_resv, gbl_resv;
+	long chg = -1, add = -1;
 	struct hstate *h = hstate_inode(inode);
 	struct hugepage_subpool *spool = subpool_inode(inode);
 	struct resv_map *resv_map;
 	struct hugetlb_cgroup *h_cg = NULL;
-	long gbl_reserve, regions_needed = 0;
+	long regions_needed = 0;
+	long gbl_resv_get;
+	long gbl_resv_put;
 	int err;
 
 	/* This should never happen */
@@ -6754,9 +6756,9 @@ long hugetlb_reserve_pages(struct inode *inode,
 	 * the subpool has a minimum size, there may be some global
 	 * reservations already in place (gbl_reserve).
 	 */
-	gbl_reserve = hugepage_subpool_get_pages(spool, chg);
-	if (gbl_reserve < 0) {
-		err = gbl_reserve;
+	gbl_resv_get = hugepage_subpool_get_pages(spool, chg);
+	if (gbl_resv_get < 0) {
+		err = gbl_resv_get;
 		goto out_uncharge_cgroup;
 	}
 
@@ -6764,7 +6766,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	 * Check enough hugepages are available for the reservation.
 	 * Hand the pages back to the subpool if there are not
 	 */
-	err = hugetlb_acct_memory(h, gbl_reserve);
+	err = hugetlb_acct_memory(h, gbl_resv_get);
 	if (err < 0)
 		goto out_put_pages;
 
@@ -6783,7 +6785,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 		add = region_add(resv_map, from, to, regions_needed, h, h_cg);
 
 		if (unlikely(add < 0)) {
-			hugetlb_acct_memory(h, -gbl_reserve);
+			hugetlb_acct_memory(h, -gbl_resv_get);
 			err = add;
 			goto out_put_pages;
 		} else if (unlikely(chg > add)) {
@@ -6819,26 +6821,21 @@ long hugetlb_reserve_pages(struct inode *inode,
 	}
 	return chg;
 
-out_put_pages:
-	spool_resv = chg - gbl_reserve;
-	if (spool_resv) {
-		/* put sub pool's reservation back, chg - gbl_reserve */
-		gbl_resv = hugepage_subpool_put_pages(spool, spool_resv);
-		/*
-		 * subpool's reserved pages can not be put back due to race,
-		 * return to hstate.
-		 */
-		hugetlb_acct_memory(h, -gbl_resv);
-	}
-	/* Restore used_hpages for pages that failed global reservation */
-	if (gbl_reserve && spool) {
-		unsigned long flags;
+ out_put_pages:
+	/*
+	 * Return all that was requested from the subpool, let subpool
+	 * tell us the new number of reservations that need to be
+	 * returned to the global pool.
+	 */
+	gbl_resv_put = hugepage_subpool_put_pages(spool, chg);
+	/*
+	 * There may be a difference between the number of
+	 * reservations to consume and the number to restore now if
+	 * there are multiple threads interacting with the subpool -
+	 * restore the difference.
+	 */
+	hugetlb_acct_memory(h, gbl_resv_get - gbl_resv_put);
 
-		spin_lock_irqsave(&spool->lock, flags);
-		if (spool->max_hpages != -1)
-			spool->used_hpages -= gbl_reserve;
-		unlock_or_release_subpool(spool, flags);
-	}
 out_uncharge_cgroup:
 	hugetlb_cgroup_uncharge_cgroup_rsvd(hstate_index(h),
 					    chg * pages_per_huge_page(h), h_cg);

-- 
2.55.0.970.g62bdec98f9-goog


