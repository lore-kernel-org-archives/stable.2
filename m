Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794438576;
	b=c7B/yZi7e52wJCZKA6HVF8uXB2UCTGZyt860+q/091yiueXnT+DoNZvkd6wTO2jRqgoS
	 qwAGR2i2RN9hrIw93EOmIxvHuC/Ht22oBtje+IJBiXgJsASKD8FOfQ9K4s5OdAgjF2VRS
	 1owh8WPHG55r2RsePZMloc48Bn5W1ly13Z7uXESI3V7Q53Fpm6tJKimZS5SJYoEVLvQNS
	 1n4r19f/ad+2M+DYrlkZK+q+DWQGKd4W9gP6/3e9AjQzP9dlpgeVOg5sv+Wajq9WqHJ/B
	 m0PcgzMgQDC4suP8vjIPf8ySpNGRWTVDGU4dUFM2yb8fAX3m0lgAbq9yOUFluC1BLNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438576;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/tYTYKK53mvCkGZK1NUY9WCNouBcH51hGVZUzJfhX9E=;
	b=c6l3KfAJRTNKk9UsleS84OU3fQl95AVJ4lp5oMxk/EMTT0UwRSzyh+nn9XAte06z5ve/
	 yYCnaaPsmjd31lPv+Mi6c3ePfRrOWe60hTy+Pj7zT+Dam945IbYMYQ9oQzxJn2I132LGM
	 HZS/7abTuKRkbxE77ke78CRRTbDeCbUSDUL/o5IhVHXlGLsX5mT6W+i1YvMIv1Fgok6hC
	 EWgdGw8ecgyiBFhBsAiwjTfghJs4HfboVc5PpyPJ12FJLn8N1LyMvWh7WJxk53KUvksxp
	 T3KidFMjtWZbVNxgiReB7CCg6enO+pz+F2ksdznYYlzXqdrawywkzxaX9rTUYvOdcig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nHf9fdSU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEC5606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nHf9fdSU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1661F00A05;
	Wed, 11 Nov 2026 23:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794438576;
	bh=/tYTYKK53mvCkGZK1NUY9WCNouBcH51hGVZUzJfhX9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nHf9fdSU3I05BRZ51qo1zeY9cC7vD8P+ZpEbt4dADeaH1fcystbktQDegN2xh7ZZY
	 69ksuD5eLPNtFKfvi7XDdypbVDmb0EE/KS2BM3tAgn1krsbwQO45NGzG1DsLhicP9T
	 SlfVY+aDvpVHiXnXQthchff0DC+P4yow/gpm4sjTYmYsKb6RPCI8pfo2A0qF8oVFoK
	 QBq/jN2yaP1khTgXTswm/8kIMAUolAQADHJoywtbY8gf7tXOM9sTe6nL+VjJ2Uaf/z
	 ssBqKR02Llnf396opXU5hqGCKD9gc+dbfNdV07HyjY7WUHkYD17j7/nZsKCUgVFlKd
	 UJyk2WAY2dJvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Mason <mason@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Adam Litke <agl@us.ibm.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Rik van Riel <riel@surriel.com>,
	Peter Xu <peterx@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/hugetlb: fix endless write fault on a leftover uffd bit
Date: Wed, 11 Nov 2026 18:09:32 -0500
Message-ID: <20261111230910.388136-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053848-failed-6.6-f61e1cf15fb4@kernel.org>
References: <20261107053848-failed-6.6-f61e1cf15fb4@kernel.org>
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

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit f61e1cf15fb44f9cf89d43d8ef01f926322bb1c4 ]

hugetlb_fault() resolves the uffd bit on a write fault only if the VMA is
registered for userfaultfd write protection, and hugetlb_wp() bails out
for any entry with the uffd bit set assuming hugetlb_fault() has already
resolved it.

When a read-only hugetlb entry with the uffd bit set is mapped in a VMA
that is not registered for uffd-wp, a write fault to it never makes
progress. If the access comes from the kernel, e.g. read(2) from
/dev/zero into such page, the task spins in the page fault handler,
ignores SIGKILL and keeps holding the locks taken by the system call.

Such entries should not exist, but an unprivileged user can create them,
for example with MADV_DONTNEED of a page protected with UFFDIO_RWPROTECT
or with UFFDIO_COPY in MODE_WP racing with UFFDIO_UNREGISTER.

Clear the uffd bit when the VMA is not registered for uffd-wp and let the
fault proceed to hugetlb_wp(), like do_wp_page() does for regular pages.

Note that a FOLL_FORCE write to a page protected with UFFDIO_RWPROTECT in
a private VMA that was made PROT_NONE now drops the RWP protection of
that page.

Original fix generated by an LLM and sent in private by Josef.

[rppt@kernel.org: massage commit message]
[david@kernel.org: convert comment into a TODO]
Link: https://lore.kernel.org/20261015-urgent_fixes-v1-6-42796911043b@kernel.org
Fixes: 60d5b473d61b ("mm/hugetlb: fix uffd wr-protection for CoW optimization path")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Chris Mason <mason@kernel.org>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Adam Litke <agl@us.ibm.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>
Cc: <stable@vger.kernel.org>
[ sashal: adapted hugetlb fault handling to local variables and older UFFD-WP helpers for synchronous-only userfaultfd support ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 34eedfec4ff8a..6a8b6b69dfffe 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6216,23 +6216,33 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		goto out_ptl;
 
 	/* Handle userfault-wp first, before trying to lock more pages */
-	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(huge_ptep_get(ptep)) &&
+	if (huge_pte_uffd_wp(huge_ptep_get(ptep)) &&
 	    (flags & FAULT_FLAG_WRITE) && !huge_pte_write(entry)) {
-		struct vm_fault vmf = {
-			.vma = vma,
-			.address = haddr,
-			.real_address = address,
-			.flags = flags,
-		};
+		if (userfaultfd_wp(vma)) {
+			struct vm_fault vmf = {
+				.vma = vma,
+				.address = haddr,
+				.real_address = address,
+				.flags = flags,
+			};
 
-		spin_unlock(ptl);
-		if (pagecache_folio) {
-			folio_unlock(pagecache_folio);
-			folio_put(pagecache_folio);
+			spin_unlock(ptl);
+			if (pagecache_folio) {
+				folio_unlock(pagecache_folio);
+				folio_put(pagecache_folio);
+			}
+			hugetlb_vma_unlock_read(vma);
+			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
+			return handle_userfault(&vmf, VM_UFFD_WP);
 		}
-		hugetlb_vma_unlock_read(vma);
-		mutex_unlock(&hugetlb_fault_mutex_table[hash]);
-		return handle_userfault(&vmf, VM_UFFD_WP);
+
+		/*
+		 * TODO: fix all cases where uffd PTE bits remain in VMAs that
+		 * are no longer registered with uffd.
+		 */
+		entry = huge_pte_clear_uffd_wp(entry);
+		set_huge_pte_at(mm, haddr, ptep, entry, huge_page_size(h));
+		/* Fallthrough to CoW */
 	}
 
 	/*
-- 
2.53.0

