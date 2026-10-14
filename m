Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3194C6EF8;
	Wed, 14 Oct 2026 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791978810; cv=none; b=K7fAOAD867u9aszt+Smu6n9E5oUqPHlxCIF6Kwi6OxTUSCiS1NiuRtlGZ6RtCyiIDBuk8GgZqBsyzmD33yBv/c26cJjzSCyRC5VMbjh08f89l99sF7fnGULSRJpgxwZ1aFl2/rhYx0SIbWchedVvgcAR2Z8EjWzO/HH8qRj1WpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791978810; c=relaxed/simple;
	bh=4liNeH/vLJODztqvfH/8m6hfpRYfRIpQUuqbTUpTvlM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NCnZ4rukF/mXOJXEIgI378fDbp/c1n2GZXbAM7Q9knQ3LOEENo2iP8Rt8fbnMDhn29KLERUuIn5z8oXe2SUfiHYx2Qox+u5a4flX2eSFFfBnLZvxN+UcL/b7sWVpTZPDmDlUdqlYtTJ4Kd4TW6jIOq+Vc7SgdmJ//EAmAiyfNP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGmAMt3e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGmAMt3e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9A21F000FF;
	Wed, 14 Oct 2026 11:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791978803;
	bh=Uzdvz5cW6a2o/ObFU/gtLfu9gsnhDlXZ0EQ8P4QL8bY=;
	h=From:Date:Subject:To:Cc;
	b=TGmAMt3eTrPbWZ20yf0XuuW0ZoR2PYrHLiDE3AjcrWjAV7pEyYiU1EKsL0XkjWeO9
	 Rd3x0cPSVdHNWrbkO7xP6MvOKa1vEFa4gYpAahlqEmLcxxbKp7mw74IdaVLaFwH3pC
	 OwoZ9OSKgZA5MLdxUCFp2Nn3Bq+bYu744UHQEpRlSYPtULZKWy3BpwMccgahlDvA+W
	 ox1eAiaqOkjFNfOAUb4G66bIGO2ZBmg02Lx6O+SJBOQrQsOdU7EiRMpLQwke/NrEqq
	 Rm30slPKvO2sTafFusog2ZjtUhwc3QkTVzliMRKpr4oBhW4H92bPwMhVZ0R3rTtV4I
	 m16Hf7TFxSLRQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 14 Oct 2026 13:53:11 +0200
Subject: [PATCH] mm/userfaultfd: only allocate anon_vma in CoW mappings
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-copy_hugetlb_page_range-v1-1-5b68e03fe7fe@kernel.org>
X-B4-Tracking: v=1; b=H4sIACZtz2oC/yXMUQqDMBRE0a3I+1ZIUqlttyISYpzGV4qGJJYWc
 e9G+3lg5q4UERiRHsVKAR+OPE8ZsizIjmZyqHjIJiXUVQpZV3b2Pz0uDunda28cdDhnTX0ZGmn
 U/SZA+e0Dnvw9y233d1z6F2w6crRtO8S6zBJ7AAAA
X-Change-ID: 20261014-copy_hugetlb_page_range-743d71a2980e
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
 Peter Xu <peterx@redhat.com>, Miaohe Lin <linmiaohe@huawei.com>, 
 Lokesh Gidra <lokeshgidra@google.com>, 
 "Liam R. Howlett" <liam@infradead.org>
Cc: Kyle Zeng <kylebot@openai.com>, Lorenzo Stoakes <ljs@kernel.org>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5311; i=david@kernel.org;
 h=from:subject:message-id; bh=4liNeH/vLJODztqvfH/8m6hfpRYfRIpQUuqbTUpTvlM=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLO52rlLPGK+azO6X7yzz4jY/mlv7Nfs3dIP+reUr+O7
 49tYn5GRykLgxgHg6yYIktQ8H2Dly/X1Va78THDzGFlAhnCwMUpABM568bwP2/28aa/kQk6p9+8
 15fszl5cLqbaOSfrjOidBCV25XkLlzMy7HO8cpPzsG248N7lbPvcXCccDTk3qe9RtQJ/4eOskql
 ejAA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

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

Reported-by: Kyle Zeng <kylebot@openai.com>
Fixes: 867a43a34ff8a ("userfaultfd: use per-vma locks in userfaultfd operations")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb.c     | 24 ++++++++++++------------
 mm/userfaultfd.c |  5 ++---
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 63dc836061c99..60f9b209c8db1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4984,10 +4984,11 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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
@@ -4995,6 +4996,13 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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
@@ -5006,14 +5014,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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
index 0e0fe9bfef239..82b56a58fc40d 100644
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
@@ -145,7 +144,7 @@ static struct vm_area_struct *uffd_lock_vma(struct mm_struct *mm,
 		 * We know we're going to need an anon rmap, so check that
 		 * early.
 		 */
-		if (!(vma->vm_flags & VM_SHARED) && unlikely(!vma_has_anon_rmap(vma)))
+		if (vma_is_cow_mapping(vma) && unlikely(!vma_has_anon_rmap(vma)))
 			vma_end_read(vma);
 		else
 			return vma;

---

base-commit: 1d0b04a60516de48250b04227dcf483c6c09aab1

change-id: 20261014-copy_hugetlb_page_range-743d71a2980e

--

Cheers,

David

