Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B5951EDF0
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 16:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910755; cv=none; b=V7pmRZbiWADFtqAWUxZq7JdQVfKFsOoKVsggQmriBDz5YnGyPgh/JIymwXhH2QBx5ZJ7efnLgU8/G4CdRLd8BjqPTzZBdVGwF0jnpNr5+PL7Vzr/e/uINTLx6l8J1726zJXtk3Pjlk2x27QCYkA8njTPl5QdFhAgC1heCZS8X8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910755; c=relaxed/simple;
	bh=PmA3B14IdHFKrCx/X7X3ZlYSbFv5GhxXreqYpXUB/IE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O47wZkhd/MoYGSsRtBzltcgAB7W/FlHbml7KW+6S/GJtKUCrSNx6AZMdpS/N5RSQmcM5S1LmoMobfvA8W21uNoDYFx4OgKSw45L6BoRGh18XefCkCnW8cyFIeToi3XBiIgBmbC3F7kHqBZiYmpYrndvzg4/W76DxrjG0i3GwMgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=miKb+NVA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="miKb+NVA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADAF1F000FF;
	Tue, 13 Oct 2026 16:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791910753;
	bh=lfy4if2FWqLwZaIrUPep/vMVzTHLBgj3phIufZi6Mt8=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=miKb+NVAGymSrLn3a9GnvBlViHN5abGjiYDCRGyhT6z+jYsLFOo4lVuZk1P/XBWbl
	 iu4K1tH5j+8qQrYKDGm3SBJUvd8Hnii3HRHF500EvvNd+gNJXnPJQdB56QaBJDGyCC
	 7THMLjDFCFIZwx1AAWc1UVW/neyFdBih41Qt0H0Vii3iw+KG5gQ0dp8yQbQgL2N50c
	 O3fKoOSPufkTnrBdEr2EVFqDk/unPXydVt7kObLpiSJ0vTwYTwB2Lt3BH3zEerJSwq
	 fDXFHVe5rw3aHXyKLj8+szpUeEyNics2TPZd/7w7+UohZ4USVn3cxxcNbjgmgxb9JT
	 bEGvGnZqZQKTA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y] mm/mremap: fix locked_vm leak from MREMAP_DONTUNMAP self-merge
Date: Tue, 13 Oct 2026 17:59:04 +0100
Message-ID: <20261013165904.2517439-1-ljs@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <2026101214-monetize-print-c590@gregkh>
References: <2026101214-monetize-print-c590@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MREMAP_DONTUNMAP feature is highly unusual in that it permits mremap()
operations that keep the original VMA in place.

Historically this has led to a lot of bugs where non-obvious interactions
occur between existing mremap() operations and the original VMA.

Fix another of these - self-merge.

Self-merge occurs when a VMA is moved in front of or behind itself and the
attributes of the VMA permit such a merge.

Practically this can only happen for unfaulted anonymous VMAs due to the
page offset equality requirement for merge:

                           |------------|
                           |            |
                           |            v
        |...........||-----------||...........|
        |           || unfaulted ||           |
        |...........||-----------||...........|
              ^            |
              |            |
              |------------|

This becomes problematic if the VMA is configured by the user to
mlock-on-fault, i.e. the VMA_LOCKED_BIT, VMA_LOCKONFAULT_BIT VMA flags are
set.

MREMAP_DONTUNMAP clears mlock flags for the source VMA and maintains them
for the destination VMA.

Self-merge makes this impossible (there is only one VMA) and incorrectly
clears the destination VMA's mlock flags.

This causes a leak in mm->locked_vm as clearing this flag does not
decrement the counter and the VMA no longer has VMA_LOCKED_BIT set so it
is not decremented on unmap.

Resolve this by simply disallowing a self-merge in this case - the source
and destination VMAs are kept distinct and then are able to have distinct
mlock() flags.

Update to make the now-redundant self-merge check a VM_WARN_ON_ONCE()
instead to guard against future regressions.

Fixes: e346b3813067 ("mm/mremap: add MREMAP_DONTUNMAP to mremap()")
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Tested-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: <stable@vger.kernel.org>
(cherry picked from commit 838bb60dc21553e32df90f2f3bac5b905376e7aa)
[ ljs - Converted to work with vma_merge(), tweaked commit msg. ]
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 include/linux/mm.h |  2 +-
 mm/mmap.c          | 23 +++++++++++++++++++----
 mm/mremap.c        |  7 +++++--
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4f0aa81257c5..279c121ef6b3 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2822,7 +2822,7 @@ extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void unlink_file_vma(struct vm_area_struct *);
 extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
-	bool *need_rmap_locks);
+	bool *need_rmap_locks, bool keep_source);
 extern void exit_mmap(struct mm_struct *);
 
 void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas);
diff --git a/mm/mmap.c b/mm/mmap.c
index f93526b3df0c..cab176cb607e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3329,13 +3329,14 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
  */
 struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
-	bool *need_rmap_locks)
+	bool *need_rmap_locks, bool keep_source)
 {
 	struct vm_area_struct *vma = *vmap;
 	unsigned long vma_start = vma->vm_start;
 	struct mm_struct *mm = vma->vm_mm;
 	struct vm_area_struct *new_vma, *prev;
 	bool faulted_in_anon_vma = true;
+	bool can_self_merge = false;
 
 	validate_mm_mt(mm);
 	/*
@@ -3345,15 +3346,29 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma)) {
 		pgoff = addr >> PAGE_SHIFT;
 		faulted_in_anon_vma = false;
+		can_self_merge = true;
 	}
 
 	new_vma = find_vma_prev(mm, addr, &prev);
 	if (new_vma && new_vma->vm_start < addr + len)
 		return NULL;	/* should never get here */
 
-	new_vma = vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
-			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
-			    vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+	/*
+	 * If the original VMA is kept (MREMAP_DONTUNMAP), the source and
+	 * destination VMA must be treated distinctly.
+	 *
+	 * A merge violates this, so in this case disallow a self-merge. A
+	 * self-merge can only occur if the new range is immediately adjacent to
+	 * the source VMA, so simply do not attempt to merge in that case.
+	 */
+	if (can_self_merge && keep_source &&
+	    (addr == vma->vm_end || vma->vm_start == addr + len))
+		new_vma = NULL;
+	else
+		new_vma = vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
+				    vma->anon_vma, vma->vm_file, pgoff,
+				    vma_policy(vma), vma->vm_userfaultfd_ctx,
+				    anon_vma_name(vma));
 	if (new_vma) {
 		/*
 		 * Source vma may have been merged into new_vma
diff --git a/mm/mremap.c b/mm/mremap.c
index 6ed28eeae5a8..d2d24d92c6d5 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -624,7 +624,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 
 	new_pgoff = vma->vm_pgoff + ((old_addr - vma->vm_start) >> PAGE_SHIFT);
 	new_vma = copy_vma(&vma, new_addr, new_len, new_pgoff,
-			   &need_rmap_locks);
+			   &need_rmap_locks, flags & MREMAP_DONTUNMAP);
 	if (!new_vma) {
 		if (vm_flags & VM_ACCOUNT)
 			vm_unacct_memory(to_account >> PAGE_SHIFT);
@@ -685,6 +685,9 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		untrack_pfn_clear(vma);
 
 	if (unlikely(!err && (flags & MREMAP_DONTUNMAP))) {
+		/* Self-merge is disallowed. */
+		VM_WARN_ON_ONCE(new_vma == vma);
+
 		/* We always clear VM_LOCKED[ONFAULT] on the old vma */
 		vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
 
@@ -692,7 +695,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		 * anon_vma links of the old vma is no longer needed after its page
 		 * table has been moved.
 		 */
-		if (new_vma != vma && vma->vm_start == old_addr &&
+		if (vma->vm_start == old_addr &&
 			vma->vm_end == (old_addr + old_len))
 			unlink_anon_vmas(vma);
 
-- 
2.56.0

