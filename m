Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807918;
	b=ttLLNcwSDRlVkkM/bH0lEvzW43XKjoxeoV0fy/jWyynQ5F0ZNoMZzUdggMLyLJghO+Mg
	 zlegGObtg/mO3lkRuzaLxpST56BO5tabK0yIKDAfTqoUEmNqEm5RNp7xl/Zdbs4pRRxv2
	 +WmeZB7qK4iDPfPv/j08FCmAnRh4fxPOGT8pdrV+kHcQU23CGtYvcoNfXaVLAoyLzKSXF
	 wgFBFbMXFsnFePA6qRvHtIBq9iIzMdLUCI/CDD07gp4O1EYj+WLpGCdj8i5A1jPsS6HVW
	 0NvkHFRDECUHf0xSRRhoH7woumMAgvZd/dmH7NR5IYOqgeoY/JcdQClWmRxsAQUkZfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807918;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mvRMKEVmclkdGqYc1LxvLGz4/cikVy9gbxUr6+VgkYA=;
	b=UWvqUoFp6jzXYSy/uU7ERWbwadvdMqHUTQ1VhOINj3ThKEfZl4o9z+RxS7VMEib96V5k
	 eAkAZQX5YKiHXGK3tKJz0gnT9e6MHyD3V4jYSIsgU+ay8tNjHRUqGtyekW3HKTKMaZj+3
	 SGKN6oUz0B2WM8UijzOMIg/ARm0J80djg2A/RBBrzklyc0j4UGfM7zOJMoAj4TejWhY0G
	 DdEYWdHB0QQGHFPoJrJWFxVtArJ4zKTqCECcbMzFpWvgwwpgN/X25ZE2KEQPluFpWNORD
	 2hQkKGgq0W91khNBWK76YgkeeGMosXP46E0Wnqv4zMgotUbOLP4eugFHrHeyVP+D6Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MQK3AtnL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EAC606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MQK3AtnL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36B01F00A02;
	Wed,  4 Nov 2026 15:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793807917;
	bh=mvRMKEVmclkdGqYc1LxvLGz4/cikVy9gbxUr6+VgkYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MQK3AtnLiOmkFzhUXWx3vILI73r7irP/8hWJwnl08oXzhKd/ryPNvcSHdBp1Oitlv
	 xeDdGemUOAr1l3KgVohWkM6Y6m2axR7VbhUeItMTzWl1LOZzRc9GFsJKQ1FrFRE79C
	 Ae3AWg8C96ZStt8vzfe6sds89AEWt8BMQe0TwQ8t/U7dBr4ERBF9Y0FV1gxGUAQQXo
	 3L0Zz0poGfW4rZ4fjTMY4cZ8z+QTT5YdzOK5pEjRJtpqLwO8CmWRrthOpAk6K20+rq
	 4VURq++knNPEEGwx01FYR55XUQqVkG4ilsU0KtvHgt63ukXDz9k9GfPuJANDVNplZC
	 MY8lHHCIppqgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@redhat.com>,
	Gavin Guo <gavinguo@igalia.com>,
	Muchun Song <muchun.song@linux.dev>,
	Peter Xu <peterx@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/5] mm,hugetlb: sort out folio locking in the faulting path
Date: Wed,  4 Nov 2026 10:58:30 -0500
Message-ID: <20261104155731.3920547-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104155731.3920547-1-sashal@kernel.org>
References: <2026110456-remix-oversold-9ee1@gregkh>
 <20261104155731.3920547-1-sashal@kernel.org>
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

From: Oscar Salvador <osalvador@suse.de>

[ Upstream commit 9293fb4765527c0d2375eb441d045a5a75f5210d ]

Recent conversations showed that there was a misunderstanding about why we
were locking the folio prior to call in hugetlb_wp().  In fact, as soon as
we have the folio mapped into the pagetables, we no longer need to hold it
locked, because we know that no concurrent truncation could have happened.

There is only one case where the folio needs to be locked, and that is
when we are handling an anonymous folio, because hugetlb_wp() will check
whether it can re-use it exclusively for the process that is faulting it
in.

So, pass the folio locked to hugetlb_wp() when that is the case.

Link: https://lkml.kernel.org/r/20250627102904.107202-3-osalvador@suse.de
Link: https://lkml.kernel.org/r/20250630144212.156938-3-osalvador@suse.de
Signed-off-by: Oscar Salvador <osalvador@suse.de>
Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: Gavin Guo <gavinguo@igalia.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 824cc56bf43c ("mm/hugetlb: fix use-after-free of a new anon folio")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4d80b8497142a..5196c1a816e38 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6116,6 +6116,7 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 	pte_t new_pte;
 	bool new_folio, new_pagecache_folio = false;
 	u32 hash = hugetlb_fault_mutex_hash(mapping, vmf->pgoff);
+	bool folio_locked = true;
 
 	/*
 	 * Currently, we are forced to kill the process in the event the
@@ -6282,6 +6283,14 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 
 	hugetlb_count_add(pages_per_huge_page(h), mm);
 	if ((vmf->flags & FAULT_FLAG_WRITE) && !(vma->vm_flags & VM_SHARED)) {
+		/*
+		 * No need to keep file folios locked. See comment in
+		 * hugetlb_fault().
+		 */
+		if (!anon_rmap) {
+			folio_locked = false;
+			folio_unlock(folio);
+		}
 		/* Optimization, do the COW without a second fault */
 		ret = hugetlb_wp(vmf);
 	}
@@ -6296,7 +6305,8 @@ static vm_fault_t hugetlb_no_page(struct address_space *mapping,
 	if (new_folio)
 		folio_set_hugetlb_migratable(folio);
 
-	folio_unlock(folio);
+	if (folio_locked)
+		folio_unlock(folio);
 out:
 	hugetlb_vma_unlock_read(vma);
 
@@ -6480,15 +6490,20 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	if (flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
 		if (!huge_pte_write(vmf.orig_pte)) {
-			/* hugetlb_wp() requires page locks of pte_page(vmf.orig_pte) */
+			/*
+			 * Anonymous folios need to be lock since hugetlb_wp()
+			 * checks whether we can re-use the folio exclusively
+			 * for us in case we are the only user of it.
+			 */
 			folio = page_folio(pte_page(vmf.orig_pte));
-			if (!folio_trylock(folio)) {
+			if (folio_test_anon(folio) && !folio_trylock(folio)) {
 				need_wait_lock = true;
 				goto out_ptl;
 			}
 			folio_get(folio);
 			ret = hugetlb_wp(&vmf);
-			folio_unlock(folio);
+			if (folio_test_anon(folio))
+				folio_unlock(folio);
 			folio_put(folio);
 			goto out_ptl;
 		} else if (likely(flags & FAULT_FLAG_WRITE)) {
-- 
2.53.0

