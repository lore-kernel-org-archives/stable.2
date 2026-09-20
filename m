Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0843C457D;
	Sun, 20 Sep 2026 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789913621; cv=none; b=cHDNuCSOPIW4uD1DBKSzE95wd/lONMw1uZUOKBTjb7mHdIWIFKdu6XxJqBZ5I6n8zPF5HaVTJ7o8gRqbUYb/Lrv7+RB/UxghYwnGLDUAONsRXqTrH4vrlmVBJ7j2dae7XKefTwYT8Ap7/7qSMllgc6VHd3urX5vxoUVcHJSldVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789913621; c=relaxed/simple;
	bh=yjmLeTXCkk2mbYGvT4Wqq1IUIfo5bp3zlxd9nUSq81E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RCyBKcwSObNWNnEyL2YChWnGPcy4l4Jj8hl7niuIXf0DmmqXe4bGkvAhQgRmzGRS8fB+AtVgu0bTVuFq0e+Pqd1ASPpiYQo8E6jq1O7xtLsKNco/O78EttzFfo0f7Yp/2ESbCKhoMHRfRFAxsoPHgTeBQwPHSVZ4j3wXuY1bNDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxvZxroO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxvZxroO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D269B1F000FF;
	Sun, 20 Sep 2026 14:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789913619;
	bh=xSrOUEQX5cEdTjwoeayswD1PWITxAREjqOm5wmTNA7M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nxvZxroOyGkQt3BsmWkXQQ4iPfEvmKakF2Otjj/Ox9xSBb43pEpVMox31SBQ7zzum
	 mcKVc0L3CDb0QcAruI7IS+MsABquxtd8G6hJPEJufUUMsgu69/ebD/uBnwl8OiTz/8
	 1h2cFLuRySdRSGjaCdVOFdQAP4GNAAZsH57aSr7RTCRXILJJgzUUJ9WP4JZbYznSZ6
	 blIuihj6jAMYeN9YmjBEc4/ENED/gRqYflUJXVClt/08zDf/e2nwhIPxBwZci7RRh8
	 75TsGgJhfnf99HugZ77WYn2N1//b98AqHlk/0FazP7KtnzzRHdQR9Z3H6eSsYtgngR
	 7KLL8wWmzWBCg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Sun, 20 Sep 2026 15:13:11 +0100
Subject: [PATCH 2/2] mm/mremap: fix locked_vm leak by splitting VMA for
 MREMAP_DONTUNMAP
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-fix-dontunmap-partial-self-merge-v1-2-6ffb556f8f8b@kernel.org>
References: <20260920-fix-dontunmap-partial-self-merge-v1-0-6ffb556f8f8b@kernel.org>
In-Reply-To: <20260920-fix-dontunmap-partial-self-merge-v1-0-6ffb556f8f8b@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, 
 Kiryl Shutsemau <kas@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9174; i=ljs@kernel.org;
 h=from:subject:message-id; bh=yjmLeTXCkk2mbYGvT4Wqq1IUIfo5bp3zlxd9nUSq81E=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLLWv+JS/l1vKVYZsvrnI4XsS0/faV54flr875Xv3Wv6P
 F53ikfs7ihlYRDjYpAVU2R5/kV8f5BI2LzOC/5uMHNYmUCGMHBxCsBEUu4w/I/Jyjz03GxiTfVu
 zd7ncx5wCVZFnp9d93/RN5X/pQfEE6cw/K/2mpi8wfufQ2KYSeizogbT1C9uvSXOJQ/uFd1U7PR
 sYwAA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

The MREMAP_DONTUNMAP feature is highly unusual in that it permits mremap()
operations that keep the original VMA in place.

Historically this has led to a lot of bugs where non-obvious interactions
occur between existing mremap() operations and the original VMA.

Fix another of these - partial copies.

The long-standing mremap() partial VMA logic has the baked-in assumption
that the originating VMA is unmapped and thus moved.

However MREMAP_DONTUNMAP defeats this by performing a partial copy
instead since it keeps the source VMA around.

An mremap(..., MREMAP_DONTUNMAP) operation disallows resizing of the VMA,
but the operation can be performed partially:

                           |-----------------|
                           |                 |
                           |                 v
                        <------>          <------>
                        .new_sz.           new_sz
                     |--.------.--|       |------|
                     |  .source.  |       | dest |
                     |--.------.--|       |------|
                     <------------>
                         old_sz

The page tables in the specified range are moved, but the original VMA is
kept intact.

This interacts poorly with mlock()'d VMAs, as the VMA_LOCKED_BIT flag is
cleared for the entire source VMA and set for the entire destination VMA.

This results in an mm->locked_vm leak as the change is therefore not
accounted correctly.

The clear solution here is to make the portion of the source VMA which is
mremap()'d distinct from the rest of it, a.k.a. split it.

Therefore resolve this issue by splitting it ahead of the rest of the
mremap() operation.

In order to make this change re-expose split_vma() in vma.h for
CONFIG_MMU (nommu doesn't compile mremap.c and uses a static helper
instead).

A quick search of how MREMAP_DONTUNMAP is used in the wild suggests that
the partial case is either unused or rarely used, so this should not result
in unreasonable VMA proliferation.

Since this makes every mremap() MREMAP_DONTUNMAP operation operate across
an entire, distinct, VMA, also eliminate now-redundant code checking for
this in dontunmap_complete().

Finally, update the sys_map_count check to account for this case.

Fixes: e346b3813067 ("mm/mremap: add MREMAP_DONTUNMAP to mremap()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/mremap.c | 81 ++++++++++++++++++++++++++++++++++++++-----------------------
 mm/vma.c    |  2 +-
 mm/vma.h    |  5 ++++
 3 files changed, 56 insertions(+), 32 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 73f52c45705c..49dc25d8a34d 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1037,6 +1037,7 @@ static void vrm_stat_account(struct vma_remap_struct *vrm,
 }
 
 static bool __check_map_count_against_split(struct mm_struct *mm,
+					    bool is_dontunmap,
 					    bool before_unmaps)
 {
 	const int sys_map_count = get_sysctl_max_map_count();
@@ -1088,26 +1089,38 @@ static bool __check_map_count_against_split(struct mm_struct *mm,
 	 * Therefore we must check to ensure we have headroom of 2 additional
 	 * VMAs.
 	 */
-	return map_count + 2 <= sys_map_count;
+	map_count += 2;
+
+	/*
+	 * If MREMAP_DONTUNMAP is set and a partial operation is performed,
+	 * the VMA is split ahead of time and the -1 observed above doesn't
+	 * apply.
+	 */
+	if (is_dontunmap)
+		map_count++;
+
+	return map_count <= sys_map_count;
 }
 
 /* Do we violate the map count limit if we split VMAs when moving the VMA? */
-static bool check_map_count_against_split(void)
+static bool check_map_count_against_split(struct vma_remap_struct *vrm)
 {
 	return __check_map_count_against_split(current->mm,
+					       vrm->flags & MREMAP_DONTUNMAP,
 					       /*before_unmaps=*/false);
 }
 
 /* Do we violate the map count limit if we split VMAs prior to early unmaps? */
-static bool check_map_count_against_split_early(void)
+static bool check_map_count_against_split_early(struct vma_remap_struct *vrm)
 {
 	return __check_map_count_against_split(current->mm,
+					       vrm->flags & MREMAP_DONTUNMAP,
 					       /*before_unmaps=*/true);
 }
 
 /*
- * Perform checks before attempting to write a VMA prior to it being
- * moved.
+ * Perform checks and preparation before attempting to write a VMA prior to it
+ * being moved.
  */
 static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
 {
@@ -1116,19 +1129,17 @@ static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
 	unsigned long old_addr = vrm->addr;
 	unsigned long old_len = vrm->old_len;
 	vm_flags_t dummy = vma->vm_flags;
+	const bool split_before = vma->vm_start != old_addr;
+	const bool split_after = vma->vm_end != old_addr + old_len;
 
-	/*
-	 * We'd prefer to avoid failure later on in do_munmap: we copy a VMA,
-	 * which may not merge, then (if MREMAP_DONTUNMAP is not set) unmap the
-	 * source, which may split, causing a net increase of 2 mappings.
-	 */
-	if (!check_map_count_against_split())
+	/* Avoid failure later on. */
+	if (!check_map_count_against_split(vrm))
 		return -ENOMEM;
 
 	if (vma->vm_ops && vma->vm_ops->may_split) {
-		if (vma->vm_start != old_addr)
+		if (split_before)
 			err = vma->vm_ops->may_split(vma, old_addr);
-		if (!err && vma->vm_end != old_addr + old_len)
+		if (!err && split_after)
 			err = vma->vm_ops->may_split(vma, old_addr + old_len);
 		if (err)
 			return err;
@@ -1146,6 +1157,21 @@ static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
 	if (err)
 		return err;
 
+	/*
+	 * To account mlock()'d pages correctly in the MREMAP_DONTUNMAP
+	 * case perform any split ahead of time.
+	 */
+	if (vrm->flags & MREMAP_DONTUNMAP) {
+		VMA_ITERATOR(vmi, vma->vm_mm, old_addr);
+
+		if (split_before)
+			err = split_vma(&vmi, vma, old_addr, 1);
+		if (!err && split_after)
+			err = split_vma(&vmi, vma, old_addr + old_len, 0);
+		vrm->vmi_needs_invalidate = true;
+		return err;
+	}
+
 	return 0;
 }
 
@@ -1330,11 +1356,8 @@ static int copy_vma_and_data(struct vma_remap_struct *vrm,
 static void dontunmap_complete(struct vma_remap_struct *vrm,
 			       struct vm_area_struct *new_vma)
 {
-	unsigned long start = vrm->addr;
-	unsigned long end = vrm->addr + vrm->old_len;
 	struct vm_area_struct *vma = vrm->vma;
-	unsigned long old_start = vma->vm_start;
-	unsigned long old_end = vma->vm_end;
+	const pgoff_t pgoff_unfaulted = vma->vm_start >> PAGE_SHIFT;
 
 	/* Self-merge is disallowed. */
 	VM_WARN_ON_ONCE(new_vma == vma);
@@ -1346,19 +1369,15 @@ static void dontunmap_complete(struct vma_remap_struct *vrm,
 	 * anon_vma links of the old vma is no longer needed after its page
 	 * table has been moved.
 	 */
-	if (start == old_start && end == old_end) {
-		const pgoff_t pgoff_unfaulted = vma->vm_start >> PAGE_SHIFT;
-
-		unlink_anon_vmas(vma);
-		/*
-		 * The VMA is now unfaulted and it is an invariant that
-		 * unfaulted anonymous VMAs have page offset equal to
-		 * vma->vm_start >> PAGE_SHIFT.
-		 */
-		vma_set_anon_pgoff(vma, pgoff_unfaulted);
-		if (vma_is_anonymous(vma) && !vma->vm_file)
-			vma_set_pgoff(vma, pgoff_unfaulted);
-	}
+	unlink_anon_vmas(vma);
+	/*
+	 * The VMA is now unfaulted and it is an invariant that
+	 * unfaulted anonymous VMAs have page offset equal to
+	 * vma->vm_start >> PAGE_SHIFT.
+	 */
+	vma_set_anon_pgoff(vma, pgoff_unfaulted);
+	if (vma_is_anonymous(vma) && !vma->vm_file)
+		vma_set_pgoff(vma, pgoff_unfaulted);
 }
 
 static unsigned long move_vma(struct vma_remap_struct *vrm)
@@ -2005,7 +2024,7 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 		return -EINTR;
 	vrm->mmap_locked = true;
 
-	if (!check_map_count_against_split_early()) {
+	if (!check_map_count_against_split_early(vrm)) {
 		mmap_write_unlock(mm);
 		return -ENOMEM;
 	}
diff --git a/mm/vma.c b/mm/vma.c
index 55d4d0939129..92a2fafd66ae 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -634,7 +634,7 @@ __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
  * Split a vma into two pieces at address 'addr', a new vma is allocated
  * either for the first part or the tail.
  */
-static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
+int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		     unsigned long addr, int new_below)
 {
 	if (vma->vm_mm->map_count >= get_sysctl_max_map_count())
diff --git a/mm/vma.h b/mm/vma.h
index 03ed8afd0c1f..b9b99fa02a86 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -555,6 +555,11 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *brkvma,
 unsigned long unmapped_area(struct vm_unmapped_area_info *info);
 unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info);
 
+#ifdef CONFIG_MMU
+int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	      unsigned long addr, int new_below);
+#endif
+
 static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma)
 {
 	/*

-- 
2.55.0

