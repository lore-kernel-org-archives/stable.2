Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A0D3C65F4;
	Wed, 30 Sep 2026 18:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790794057; cv=none; b=mCpjg8nJLUkmvm040CZH7xm2lda7EvnA5ItaRbqcdTq+XkPdghoVZUZ8TjGaVcN28pomfFiepK7qKG0fKwD5jWi+Ow9IrIZjhH0NFSf9fvoEPvKlObOiJ3YjCnAiwAoi1iSOqFhEKKWE6bqWCiEN39Yy4dM3czX74EG/dgtok8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790794057; c=relaxed/simple;
	bh=RmPHKL0hFSVoI5I9q2hu/CMtvlH0NAiHKpfeInjxFEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oVpJUOUrZRkMxV4qKGJvwS8yfUwIq7Xwdd9ZI9Sbua3x3Q/dmOxk1ZPBFesk8l7Ruq+ZqEAJAu/k81s9Z+TJm6AOLFnQzLUoSWIYTzpJac/Uq33lwynmJWV+e458nxPmL2YKZW1qa7AiJnV4CtZnAehcOOOJVSTGg+P4gAZLwI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAsmU2wD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAsmU2wD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E441F00898;
	Wed, 30 Sep 2026 18:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790794055;
	bh=Ov7QGq/mg3vaAJFg5WEdif+xuhC9RlGRRbBlN0+Yz4E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HAsmU2wDDyXvYLWdQkCs2SKv++4dtZzC6ttYPsOxim2ODSpAPm/tvz4cBav4SCZnF
	 14wmk3ZcgpeX5iONBzg5+pHrEEjuozGfNqNPqXbYveMfSG4tZNgRAyqm30+iAmsvyy
	 myAovp8cVTdm2ZcBonTQh3qv9OISAHdGJWnHRLzXF/2+E2EXNHkv7W44jPFS28oJug
	 AbWIKoXO4pgwic6C1Gl8/QnYGenkMoqlxp9soTbO4VjBTKVx1moqUrJ7qzZHeJKlJu
	 F+Fqroie8Yzns0L+fsAeJWRfSSfxiyGW+iYkP+2a129i3F8ppNcgo/ePpXbKANhbH5
	 FtyiTfDYpwxyQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 30 Sep 2026 19:47:10 +0100
Subject: [PATCH v2 2/2] mm/mremap: fix locked_vm leak by splitting VMA for
 MREMAP_DONTUNMAP
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-fix-dontunmap-partial-self-merge-v2-2-f388985a0f0a@kernel.org>
References: <20260930-fix-dontunmap-partial-self-merge-v2-0-f388985a0f0a@kernel.org>
In-Reply-To: <20260930-fix-dontunmap-partial-self-merge-v2-0-f388985a0f0a@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, 
 Kiryl Shutsemau <kas@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, stable@vger.kernel.org, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8051; i=ljs@kernel.org;
 h=from:subject:message-id; bh=RmPHKL0hFSVoI5I9q2hu/CMtvlH0NAiHKpfeInjxFEs=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLL2RtpmdbavnbRkzbMJTmeKG6qfX2555Oa0ViQ0OPRv0
 O9Z61M5OkpZGMS4GGTFFFmefxHfHyQSNq/zgr8bzBxWJpAhDFycAjCR+1WMDP8WRjrdr3jKt276
 0bOCU1w57jukVASsTFh2q0Hv46yQ9qmMDAcfWNlqvvQ7WsrAJcSSullzQQuXUulP3ufrTTwFdx1
 dyAcA
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
mremap() operation if the VMA is mlock()'d.

This is valid, as the source VMA will lose its VMA_LOCKED_BIT flag, so if a
partial remap it will become distinct from the rest of the VMA.

In order to make this change re-expose split_vma() in vma.h for
CONFIG_MMU (nommu doesn't compile mremap.c and uses a static helper
instead).

Finally, update the sys_map_count check to account for this case.

Note that the early check does not use needs_pre_split() - this is because
the VMA has not been looked up by this point, so be conservative and assume
that the VMA is mlock()'d in this case for the purposes of the
sys_map_count check.

Fixes: e346b3813067 ("mm/mremap: add MREMAP_DONTUNMAP to mremap()")
Cc: stable@vger.kernel.org
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/mremap.c | 62 +++++++++++++++++++++++++++++++++++++++++++++----------------
 mm/vma.c    |  4 ++--
 mm/vma.h    |  5 +++++
 3 files changed, 53 insertions(+), 18 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 73f52c45705c..5c72545db175 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1037,6 +1037,7 @@ static void vrm_stat_account(struct vma_remap_struct *vrm,
 }
 
 static bool __check_map_count_against_split(struct mm_struct *mm,
+					    bool pre_split,
 					    bool before_unmaps)
 {
 	const int sys_map_count = get_sysctl_max_map_count();
@@ -1088,26 +1089,42 @@ static bool __check_map_count_against_split(struct mm_struct *mm,
 	 * Therefore we must check to ensure we have headroom of 2 additional
 	 * VMAs.
 	 */
-	return map_count + 2 <= sys_map_count;
+	map_count += 2;
+
+	/* If pre-split, the -1 observed above doesn't apply. */
+	if (pre_split)
+		map_count++;
+
+	return map_count <= sys_map_count;
+}
+
+static bool needs_pre_split(struct vma_remap_struct *vrm)
+{
+	/*
+	 * An MREMAP_DONTUNMAP of a mlock()'d VMA needs to unlock the
+	 * source VMA, so split in this case.
+	 */
+	return (vrm->flags & MREMAP_DONTUNMAP) &&
+		vma_test(vrm->vma, VMA_LOCKED_BIT);
 }
 
 /* Do we violate the map count limit if we split VMAs when moving the VMA? */
-static bool check_map_count_against_split(void)
+static bool check_map_count_against_split(struct vma_remap_struct *vrm)
 {
 	return __check_map_count_against_split(current->mm,
-					       /*before_unmaps=*/false);
+		needs_pre_split(vrm), /*before_unmaps=*/false);
 }
 
 /* Do we violate the map count limit if we split VMAs prior to early unmaps? */
-static bool check_map_count_against_split_early(void)
+static bool check_map_count_against_split_early(struct vma_remap_struct *vrm)
 {
 	return __check_map_count_against_split(current->mm,
-					       /*before_unmaps=*/true);
+		vrm->flags & MREMAP_DONTUNMAP, /*before_unmaps=*/true);
 }
 
 /*
- * Perform checks before attempting to write a VMA prior to it being
- * moved.
+ * Perform checks and preparation before attempting to write a VMA prior to it
+ * being moved.
  */
 static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
 {
@@ -1116,19 +1133,17 @@ static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
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
@@ -1146,6 +1161,21 @@ static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
 	if (err)
 		return err;
 
+	/*
+	 * To account mlock()'d pages correctly in the MREMAP_DONTUNMAP
+	 * case perform any split ahead of time for an mlock()'d VMA.
+	 */
+	if (needs_pre_split(vrm)) {
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
 
@@ -2005,7 +2035,7 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 		return -EINTR;
 	vrm->mmap_locked = true;
 
-	if (!check_map_count_against_split_early()) {
+	if (!check_map_count_against_split_early(vrm)) {
 		mmap_write_unlock(mm);
 		return -ENOMEM;
 	}
diff --git a/mm/vma.c b/mm/vma.c
index 55d4d0939129..c8f3d2de6052 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -634,8 +634,8 @@ __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
  * Split a vma into two pieces at address 'addr', a new vma is allocated
  * either for the first part or the tail.
  */
-static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		     unsigned long addr, int new_below)
+int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	      unsigned long addr, int new_below)
 {
 	if (vma->vm_mm->map_count >= get_sysctl_max_map_count())
 		return -ENOMEM;
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

