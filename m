Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794371018;
	b=ngrrvdmBtzoejhYX4KYeTCbK14nl+FrHFHO/AsHu+bV423I3MsYuYnsfngTX1qWrlHaB
	 aGugOY3ZHB/WSz/AFAsjHOHuRzFUBm7WlUOZNCFrEoMe4KE8oZVONe/dkz7gaNOsIXayD
	 q4W46b1be7GiX6kDG8Mf2PbZbxq+Q5e+PCqDRg5mw6MJTAHTo8PpOjjwJID46hQkXnBuQ
	 QnT0TcZnH8GZzIKrSTDk8Rwivegxq9TSJck2mrQ5S6TaXpcTpsCvJtkNj4c2PDS4BHxha
	 VYNDUaNU/BzzhGWoJVc433rixlM9gMgeStynsogLnkEAWVaIa7+Q3mhIDCKP7otdvtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794371018;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JZTMy+7FWLGNRFWqZk3kZ03UhBfgk2gb/6SkelUfoeA=;
	b=2IINKjZhvxN6MulaDfbT7hja1+J/96J0oZ9NNB/2EcKjKHj9Fo7/UPVB6f0DHbvY9Vkg
	 l0C0L896G8chxRRvbEXng1uU86N5ZD2eTboYIKMcqe3hHO52LMFJQsdUQLWSs4xTbCShS
	 4h3N1pQbOCVopHCwTYJmkSveOX/gqWEKFJHfmPL0Aq6DVkOTVDCSpWt87LC4qE0OJreq6
	 HHtQ4LaEJMZIghTywMDzwKDT2wu5uK7LIYZlqJ6XGq5VFCQAnUqCY4wge2Q7WKmJ/1/AC
	 S5A6Wv2kGZwapPRt3/CsDe537B+H3lGfjaHtS5Bj8DM4VGNVz4oZ9YdOHKI4sxVvFHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YvKY30Em;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7294E606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YvKY30Em
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E10D91F0089F;
	Wed, 11 Nov 2026 04:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794371018;
	bh=JZTMy+7FWLGNRFWqZk3kZ03UhBfgk2gb/6SkelUfoeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YvKY30EmFC0etBeM8c1m78Icq1pjAhzavrZ0TSsew07k5w7wyRO7z2KtCMFGcTWFw
	 WtRks0exZjLjfUQqSC6sSAZn74HQtOxqSr/hAzUaGBCQt0enQoymXK8cdYe8Rn2gDE
	 s5MBmGZlKVhQlGVH1edPyLKfrjgNQnXb1JRKCTC9WodyuAmKyu47fGwUK7NWqpJ7Hh
	 wtdtu0DrOzxRh4l4zGi/aoEpx5Xi0D7GT9Io9BTMsBFYoiTcgzMME9x3Y9cjRWeMnM
	 smiiEnQEBwj2Pp4MjrpeKsiIHBgYeMQdGWOuA2zhr8PyqWkF0etMGpwqpMmDONzIKx
	 1Otg2TbBMvGtA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kyle Zeng <kylebot@openai.com>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Peter Xu <peterx@redhat.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Lokesh Gidra <lokeshgidra@google.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] mm/userfaultfd: only allocate anon_vma in CoW mappings
Date: Tue, 10 Nov 2026 23:23:35 -0500
Message-ID: <20261111042113.1071153-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050530-failed-7.3-514c9247db30@kernel.org>
References: <20261107050530-failed-7.3-514c9247db30@kernel.org>
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

[ Upstream commit 514c9247db305922591d806ec65d3c3fe420538d ]

find_vma_and_prepare_anon() can end up allocating an anon_vma in VMAs that
are not CoW mappings, which is wrong.

If we have a MAP_SHARED R/O file mapped, we lack VM_SHARED (but do have
VM_MAYSHARE) and lack VM_MAYWRITE.

While uffd later rejects such mappings (uffd registration requires
VM_MAYWRITE, see comment in validate_dst_vma) find_vma_and_prepare_anon()
still wrongly allocates an anon vma before it validates the vma.

This in turn later confuses copy_page_range()->vma_needs_copy() such
that we end up calling copy_hugetlb_page_range() with ranges that
actually do not contain *any* per-pagetable information that would
require copying, which is the basis for PMD-table sharing in the first
place.

copy_hugetlb_page_range() should not have to worry about shared
PMD tables at all: it doesn't make any sense to copy page tables that are
shared, as they can be fully recreated later. Ending up in the function
with shareable page tables is the real issue.

If a destination PMD table is shared in copy_hugetlb_page_range(), it
might get concurrently unshared as we are not holding relevant
locks, resulting in us using a page table that is no longer mapped and
possibly freed after calling:

	dst_pte = huge_pte_alloc(dst, dst_vma, addr, sz);

To fix it, do not allocate an anon_vma in non-CoW mappings and add a
safety guard to copy_hugetlb_page_range(), making sure that we never
end up messing with shared PMD tables in there.

Before commit 867a43a34ff8a ("userfaultfd: use per-vma locks in userfaultfd
operations") we would always validate the VMA before allocating an
anon_vma, and consequently never wrongly allocate an anon_vma.

As uffd_lock_vma() is part of the same lookup machinery and
also contains a misleading VM_SHARED check, change that one as well
directly for consistency.

A follow-up cleanup will stop taking the hugetlb_vma_lock_read(src_vma)
lock in copy_hugetlb_page_range() entirely. Further, the usage of
VM_SHARED in userfaultfd code should be cleaned up later to focus on
CoW vs. non-CoW mappings.

Link: https://lore.kernel.org/20261014-copy_hugetlb_page_range-v1-1-5b68e03fe7fe@kernel.org
Fixes: 867a43a34ff8 ("userfaultfd: use per-vma locks in userfaultfd operations")
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Kyle Zeng <kylebot@openai.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Kyle Zeng <kylebot@openai.com>
Tested-by: Kyle Zeng <kylebot@openai.com>
Acked-by: Muchun Song <muchun.song@linux.dev>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Tested-by: Lance Yang <lance.yang@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Peter Xu <peterx@redhat.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Lokesh Gidra <lokeshgidra@google.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: <stable@vger.kernel.org>
[ sashal: Replaced vma_has_anon_rmap(vma) with a direct vma->anon_vma check in uffd_lock_vma(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c     | 24 ++++++++++++------------
 mm/userfaultfd.c |  5 ++---
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 09665fd220752..860c3c6b7673f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4939,10 +4939,11 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		raw_write_seqcount_begin(&src->write_protect_seq);
 	} else {
 		/*
-		 * For shared mappings the vma lock must be held before
-		 * calling hugetlb_walk() in the src vma. Otherwise, the
-		 * returned ptep could go away if part of a shared pmd and
-		 * another thread calls huge_pmd_unshare.
+		 * Shared mappings only need copying when we could have
+		 * information stored in page tables (e.g., userfaultfd PTE
+		 * bits or markers), which is incompatible with PMD sharing.
+		 * Still take the hugetlb VMA lock for now to satisfy
+		 * hugetlb_walk()'s locking requirements.
 		 */
 		hugetlb_vma_lock_read(src_vma);
 	}
@@ -4950,6 +4951,13 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	last_addr_mask = hugetlb_mask_last_page(h);
 	for (addr = src_vma->vm_start; addr < src_vma->vm_end; addr += sz) {
 		spinlock_t *src_ptl, *dst_ptl;
+
+		if (WARN_ON_ONCE(want_pmd_share(src_vma, addr) ||
+				 want_pmd_share(dst_vma, addr))) {
+			ret = -EINVAL;
+			break;
+		}
+
 		src_pte = hugetlb_walk(src_vma, addr, sz);
 		if (!src_pte) {
 			addr |= last_addr_mask;
@@ -4961,14 +4969,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			break;
 		}
 
-#ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
-		/* If the pagetables are shared, there is nothing to do */
-		if (ptdesc_pmd_is_shared(virt_to_ptdesc(dst_pte))) {
-			addr |= last_addr_mask;
-			continue;
-		}
-#endif
-
 		dst_ptl = huge_pte_lock(h, dst, dst_pte);
 		src_ptl = huge_pte_lockptr(h, src, src_pte);
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index cc37b60fc3e81..f8e2b7f2f61c6 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -115,8 +115,7 @@ struct vm_area_struct *find_vma_and_prepare_anon(struct mm_struct *mm,
 	vma = vma_lookup(mm, addr);
 	if (!vma)
 		vma = ERR_PTR(-ENOENT);
-	else if (!(vma->vm_flags & VM_SHARED) &&
-		 unlikely(anon_vma_prepare(vma)))
+	else if (vma_is_cow_mapping(vma) && unlikely(anon_vma_prepare(vma)))
 		vma = ERR_PTR(-ENOMEM);
 
 	return vma;
@@ -144,7 +143,7 @@ static struct vm_area_struct *uffd_lock_vma(struct mm_struct *mm,
 		 * We know we're going to need to use anon_vma, so check
 		 * that early.
 		 */
-		if (!(vma->vm_flags & VM_SHARED) && unlikely(!vma->anon_vma))
+		if (vma_is_cow_mapping(vma) && unlikely(!vma->anon_vma))
 			vma_end_read(vma);
 		else
 			return vma;
-- 
2.53.0

