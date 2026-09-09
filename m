Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE224570C2;
	Wed,  9 Sep 2026 21:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788990578; cv=none; b=vCxc+65hLtPRmCUeA8lYm10rRNZ6qm2PmtyICej8t4bHtQTARGbQLkviq0C8bgpibejpGwOxb1W8cYLK4zWp0MKJRZamRppkGbVj+AMfOcIewQcbQQfTdfneBIbzvyACO63BEmVTif14qWepDqPW6ajXButxMSyrqGLprxAtIKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788990578; c=relaxed/simple;
	bh=IpuMmCTHCH6IIMy98L5rBZSj/YgZOfEudC6ymLrW5rQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fRWYyrR1w3zEBgaZsoaxjfmSkD8oR9DqtejspP+bgIkLSsFlvls2xka8tkNRrtr7jBe23+q04HyGdAqM56AMPNuYCjWkSWSP4vBtDP89CzQKZU17AMIX6tUUe9RyC/ovI49Fxf5t1Ofz9c+PR21mYyldYY/dDmZ7b7mqxODV654=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNHx/EH0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNHx/EH0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED555C2BCFB;
	Wed,  9 Sep 2026 21:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788990578;
	bh=IpuMmCTHCH6IIMy98L5rBZSj/YgZOfEudC6ymLrW5rQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bNHx/EH0Cb/hdSNbAr+oD0OQovE5QEj0dxlpPO3XinstfZhmjO9wICxnPHSmm/dJ+
	 cc7ia0kzDRkO3zzhv8nHqzIR2gGA6KAngFpMyRaqFmoDIrt+n6Me4leX6j0dsS+S9p
	 IZa4dKmY2Hs2LSmxqzXoO9eROJc55i+jgu7z0RwF6yDTD5Tzd9xaYCmjSi8Rs5sX9d
	 F4dWuQ9ZeqgM9WZIRiiUFuW0w1l+lls0hHWzOBzbFCNTVas2wybWzv0eBch9NsrP03
	 Nomi8NeA0qdb9bJmNXVc+KPR7Ue8j+kIIt3LCwYkx57cQZyzB1dQirLfqdXcJeAMyj
	 XoFwWIsgbXEWQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE74C88E41;
	Wed,  9 Sep 2026 21:49:37 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Wed, 09 Sep 2026 14:49:28 -0700
Subject: [PATCH v2 3/4] mm: hugetlb: Fix subpool usage leak on allocation
 failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-hugetlb-subpool-always-track-used-v2-3-30c5d83b572a@google.com>
References: <20260909-hugetlb-subpool-always-track-used-v2-0-30c5d83b572a@google.com>
In-Reply-To: <20260909-hugetlb-subpool-always-track-used-v2-0-30c5d83b572a@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788990577; l=3569;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=cYJ89cnWWYewpfV2xJr1JZku8Dzt8E3hqm4GB5Ws6/g=;
 b=saJolngd03Eu0+scYnu3x47RfGTgFmOprIS5lh7xp/uDq2/hCD/CKZYbPTtBY4n9Hn7uqo2rO
 V8dm6FOIsbRBfyagUeDDamv2dWK3Q7IFZscOJPx3Tg8l77vta/SfUMo
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

When folio allocation fails early (e.g. buddy allocation failure or
cgroup charging failure) and a reservation was not used (meaning an
unreserved global page was needed), the subpool page acquired during the
allocation attempt must still be returned.

Currently, the subpool cleanup error path only returns the page to the
subpool if a reservation was used. If no reservation was used, it skips
releasing the page back to the subpool, permanently leaking the subpool's
used pages counter.

With subpools now always tracking used pages, always release the page
back to the subpool whenever a subpool page was acquired.

Opportunistically rename the local variables tracking global reservations
needed and global reservations returned. This clarifies the accounting:
a value of zero for needed global reservations indicates an existing
reservation satisfies the allocation, while a non-zero value indicates
new global pages are required.

Adjust global reservations using the difference between reservations
needed and reservations returned to properly handle races where concurrent
threads interact with the same subpool.

Fixes: a833a693a490 ("mm: hugetlb: fix incorrect fallback for subpool")
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Cc: stable@vger.kernel.org
---
 mm/hugetlb.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9eb9f3442574c..652cfb55c6e6e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2957,7 +2957,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	struct hugepage_subpool *spool = subpool_vma(vma);
 	struct hstate *h = hstate_vma(vma);
 	struct folio *folio;
-	long retval, gbl_chg, gbl_reserve;
+	long retval, gbl_resv_get;
 	map_chg_state map_chg;
 	struct mempolicy_interpreted mpoli;
 	gfp_t gfp = htlb_alloc_mask(h);
@@ -2996,8 +2996,8 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	 * Or if it can get one from the pool reservation directly.
 	 */
 	if (map_chg) {
-		gbl_chg = hugepage_subpool_get_pages(spool, 1);
-		if (gbl_chg < 0) {
+		gbl_resv_get = hugepage_subpool_get_pages(spool, 1);
+		if (gbl_resv_get < 0) {
 			ret = -ENOSPC;
 			goto out_end_reservation;
 		}
@@ -3006,7 +3006,7 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		 * If we have the vma reservation ready, no need for extra
 		 * global reservation.
 		 */
-		gbl_chg = 0;
+		gbl_resv_get = 0;
 	}
 
 	/*
@@ -3017,10 +3017,10 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 		alloc_flags |= HUGETLB_ALLOC_CHARG_CGROUP_RSVD;
 
 	/*
-	 * gbl_chg == 0 indicates a reservation exists for this
+	 * gbl_resv_get == 0 indicates a reservation exists for this
 	 * allocation, so try to use it.
 	 */
-	if (gbl_chg == 0)
+	if (gbl_resv_get == 0)
 		alloc_flags |= HUGETLB_ALLOC_USE_GLOBAL_RESERVATIONS;
 
 	/* Takes reference on mpol. */
@@ -3074,13 +3074,10 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
 	return folio;
 
 out_subpool_put:
-	/*
-	 * put page to subpool iff the quota of subpool's rsv_hpages is used
-	 * during hugepage_subpool_get_pages.
-	 */
-	if (map_chg && !gbl_chg) {
-		gbl_reserve = hugepage_subpool_put_pages(spool, 1);
-		hugetlb_acct_memory(h, -gbl_reserve);
+	if (map_chg) {
+		long gbl_resv_put = hugepage_subpool_put_pages(spool, 1);
+
+		hugetlb_acct_memory(h, gbl_resv_get - gbl_resv_put);
 	}
 
 out_end_reservation:

-- 
2.55.0.1007.g17ff1f9808-goog


