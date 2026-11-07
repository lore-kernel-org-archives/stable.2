Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045933;
	b=ql6g+vlVRMuZ55zWuh5Fu8ohJ5kK3YmSZnnLTRPlXbSyyxBBEVz0vH0Vq/HPqolfZnZC
	 kCEzNTLvXgLuw2WzAh3SBs5/OSp4/+SLZPVNiyRcj78atN2QTz8b3VosnOw7FNoGQWzyX
	 tlRapN0gCAmii3D1GbtghypiBmx3vXzX4XIx1RDOzx0YV+TI2G16v3Kr0/wvkBkv+vzMK
	 +4/s9otv0FQXmcbSYzmsFQs9dWExeq+JBAoJjCCKm3r25miGQ+5fiS8gjd9JrniVEmIqW
	 cCTPkoa9XuFX8Nk6YoWry/KGcQ+NYriZvVazFRSpOZALPqFqrJFYhnfsLUfIehXw+Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045933;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=T5Jkr4UtJyeAEXfPXYg5udwVQFW6Vr4nJKy/I9Intek=;
	b=U7pD9HnIILdAz/JOUPGkDSRb9gDHX4lyYimLD8P0GPGdu25paBK/icMbt6ItJuvjZNlb
	 qDqI6SMTxoSj5OtwrAi+4KIL9XNg481KsnScV80UbxuJdvusYcMtYujFX628OK/W/lqPo
	 F5kmTNnh3zhXYpBVygUKRhqWE3omuOs+ybdvO2eePnnqiY0yGWnkTOu79FS4kaKmU03hs
	 0dBtBfu69RZTUVVKMcklI4potdoP2wlMGBYsGZjFLFE7N1nr3DsvfdPtrzairMEIjAu2S
	 3IWxn2OW20AqVsyB3unka9c6wLcnxrhs+4tjI8IcIlB7/b3NzNKcj3SGeS5LWouEzwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hu61Lxj1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936C1606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hu61Lxj1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6601F0089F;
	Sat,  7 Nov 2026 10:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045933;
	bh=T5Jkr4UtJyeAEXfPXYg5udwVQFW6Vr4nJKy/I9Intek=;
	h=From:To:Cc:Subject:Date;
	b=hu61Lxj1gLrEY8GuE0jX9HCLAY86hz5imTMFpoZvkCUBymvZnsasNGW1EFZBqySBL
	 xYBlzP5GXyGDgAzjvtGYOZguAELJrYhU369ISHe52pjw5kBuo84ZFFDrrQy3gAlHfF
	 LQkJBH0+C2TtRpCLjTCiJV3/l4PhStsUwtJqfLBqaEfMckMOjlevsFA5cV3f35ezsM
	 lXGIXSafbIpvYjDifz7zw4oFSv5pAqn3IoEuJgOIIqIQ/mvUQjA+vvRQckiSfNpJiD
	 1VAf9S7mCnSpwFNV+N7lkEvdFskO/3BboNGGANS97ntU7BOQQ98R4rmnaiy6uh2Xxm
	 xr8dx0r197Y0g==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	akpm@linux-foundation.org,
	kylebot@openai.com,
	ljs@kernel.org,
	muchun.song@linux.dev,
	rppt@kernel.org,
	lance.yang@linux.dev,
	osalvador@suse.de,
	peterx@redhat.com,
	linmiaohe@huawei.com,
	lokeshgidra@google.com,
	liam@infradead.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/userfaultfd: only allocate anon_vma in CoW mappings" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:05:31 -0500
Message-ID: <20261107050530-failed-7.3-514c9247db30@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 514c9247db305922591d806ec65d3c3fe420538d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050530-failed-7.3-514c9247db30@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 514c9247db305922591d806ec65d3c3fe420538d Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 14 Oct 2026 13:53:11 +0200
Subject: [PATCH] mm/userfaultfd: only allocate anon_vma in CoW mappings

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
---
 mm/hugetlb.c     | 24 ++++++++++++------------
 mm/userfaultfd.c |  5 ++---
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 27e8136b18150..da5d04edf7c10 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4973,10 +4973,11 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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
@@ -4984,6 +4985,13 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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
@@ -4995,14 +5003,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
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
index da67d35cd9546..405f2d72f204e 100644
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
-- 
2.53.0




