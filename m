Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794371607;
	b=XBU/5npxoPwNxcUyeQiztDwC2Fa8Vt/+fEgl2oDVZBzosXJJHc49i8/ve70vTQV+VkZu
	 USPhRXaBTHFIf4HomTO4Nx/tPNdSzFxCl43U/zrXmo4E7Kr0RiSms5M67rbs52cgEzH/N
	 4bpdX/b39NAlv1lsRTwAjnU89NDT/1lv4+i/KSoHTHTam33wXhQgE1sSc7sRNyRQdCLHi
	 FPM1X/bdH0SSbBdcV42y86Cjz32YMRIoGCLqnhSPUxx8SGqYz+OVjehfNTg6VLOEIIa+X
	 lMCVdA1eylIvs5rf4cyvvZ9Zk199Rd7MttkiFt9jBMl/D7e2X+8911z9FY+ns0HDJ3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794371607;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BYPdQNMP0XTjYTu0r0wE1l8i237A+gjxYj3IVSicfGE=;
	b=Pryt2tw2YANykljJsuIhfBzcDqRMNDaAoH8upbiwffBbD5MHaC1AUlwr4BAFfG5yH2DD
	 /sb8qfXbYatDfD0Lry2rGGodtdqYIO2f4IC8WdzRmPfM3hiY2RCDWJbq0x12UpiqhH9r3
	 kAXWoDyv56fuIpszjYn5ILzYZTFLCX3H9gKe5rRcqiEGvY46CYA2D15jCC1SS4bUX5sSW
	 TBMn09vqcUJ2zfYt5Azp8dGMU4PiIwkkE+ci7NtYJRFIdulMMIrSjSq7e6gX8ADwtZVTX
	 SEdaEB1CNEYed6AFzO/AGm0XkXUpMVT9/wtfbGQcEX1uEWvI6gDYFfAMIEWr0Apk59g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ajpi1LQA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61F9606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ajpi1LQA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD641F0089F;
	Wed, 11 Nov 2026 04:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794371607;
	bh=BYPdQNMP0XTjYTu0r0wE1l8i237A+gjxYj3IVSicfGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ajpi1LQAkyClSUCqOWL51g+Xtyv80eIVGN1kLkhlThlUI94Gr0jQ6i/WdLdEsRP6B
	 vOe93FjZXSOqVJ2C+tQXGORu8bfdUdxcfM/N5otKuRvxQ3BHK5NdNDg1ejZ/kYCgBX
	 v5exSPwVsc9VcuvV0878Si6TVCqqrfe4am2SD6cw5zb+Gix2BrieLNG9c73WHTBSYz
	 Bl/EAlu1ybqiqmvvvJUAJINwUYVxR5lYJiXzFQ4jruKxTK7bvIzfH5IBy+44l1KQOZ
	 aJmUELD/FabA6mnM6CpQ1msjxeHOy3ArMXA3NITxAAIvpcr1+w94Fgti+RwYfoNazw
	 KyjIyWOiAKkaQ==
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
Subject: [PATCH 6.18.y] mm/userfaultfd: only allocate anon_vma in CoW mappings
Date: Tue, 10 Nov 2026 23:33:24 -0500
Message-ID: <20261111043253.1106340-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051420-failed-6.18-514c9247db30@kernel.org>
References: <20261107051420-failed-6.18-514c9247db30@kernel.org>
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
[ sashal: Replaced newer VMA helpers with is_cow_mapping(vma->vm_flags) and the existing !vma->anon_vma check. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c     | 24 ++++++++++++------------
 mm/userfaultfd.c |  5 ++---
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index bf1188e9b1c9b..a499d9af05f18 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5629,10 +5629,11 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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
@@ -5640,6 +5641,13 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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
@@ -5651,14 +5659,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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
index 579445bddf561..e4a0cb3ad838a 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -48,8 +48,7 @@ struct vm_area_struct *find_vma_and_prepare_anon(struct mm_struct *mm,
 	vma = vma_lookup(mm, addr);
 	if (!vma)
 		vma = ERR_PTR(-ENOENT);
-	else if (!(vma->vm_flags & VM_SHARED) &&
-		 unlikely(anon_vma_prepare(vma)))
+	else if (is_cow_mapping(vma->vm_flags) && unlikely(anon_vma_prepare(vma)))
 		vma = ERR_PTR(-ENOMEM);
 
 	return vma;
@@ -77,7 +76,7 @@ static struct vm_area_struct *uffd_lock_vma(struct mm_struct *mm,
 		 * We know we're going to need to use anon_vma, so check
 		 * that early.
 		 */
-		if (!(vma->vm_flags & VM_SHARED) && unlikely(!vma->anon_vma))
+		if (is_cow_mapping(vma->vm_flags) && unlikely(!vma->anon_vma))
 			vma_end_read(vma);
 		else
 			return vma;
-- 
2.53.0

