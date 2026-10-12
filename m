Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93894ABBC6
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791822446; cv=none; b=XO4sPy5c93ZRC3G/hrYARI2Cbkxa9LnU3qG06d9PgOLUMtOWh4Ke/PillIHfvOAOdAEYQ8OoXFmho6DSqtZrKtK7lmbSXrBj+uMWnEUddhoA6UPqoAVZKEyn3F3I3PG7LRxYVO3FE8NiybdAghayaH4MKF3KK4qJzpBE1mY8Bq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791822446; c=relaxed/simple;
	bh=CeQFaQO/scHJNlccN6i888WtR70DXIxChKBfyTXAeVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G1Bg04/cZsFUR/r2yJMEDkezAu3c9g5HiCS/79Xqs5URiP2T2BRHgqNQtTy4D/crkKHfHHgXsTRf5n4DEC5KZzOQs5M+Lo4oS6I/3Zg4nfwfR//d1lxypZYCBbpaUwLPRnukMbgyMKbfRogATruZc/X+7Ntvy5mGGCTQXKuICyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXJzHjru; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXJzHjru"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DAA1F0089B;
	Mon, 12 Oct 2026 16:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791822443;
	bh=UGh/gsD5AUu2P6DHgBdi+riyrltFVhUjz3K3KiCwtQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SXJzHjruqqye+18crbMtWA4M0HYc/kE6x7nZBTyW07YWI4MekmHVsdkTPBVRMMI5D
	 60mXvN3R3VuGnxlRkJuJlHH6kKHk1vYO1zgpcjbWb4DFFADNRv1ZRtyN1Hn7MunxJW
	 nw3yByNADtTJByFIyp0PSx/gPYnmKNCKx8lHdb+NwqE1inLKRw1da8QrUnTFBxlj7D
	 NwSWt4F1nxx5eWtheURd+3wOoUVDKvs32cv2oeGu8gA6Yz77om8VsY+DrM/oZMR6N0
	 HcoY8Q/5iguOcZtyFHoWbSfzOVi5IRVwrS2/LjtJFXKt++UD8cuSPei9PRCYsX+sZ+
	 SRu2DnOEz2yJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Pedro Falcato <pfalcato@suse.de>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Brian Geffon <bgeffon@google.com>,
	Minchan Kim <minchan@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mm/mremap: fix locked_vm leak by splitting VMA for MREMAP_DONTUNMAP
Date: Mon, 12 Oct 2026 12:27:20 -0400
Message-ID: <20261012162625.1093939-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101242-endurable-dwelled-87d2@gregkh>
References: <2026101242-endurable-dwelled-87d2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>

[ Upstream commit 597e4b9ab48a3f841080f627722064853d3f650e ]

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

Link: https://lore.kernel.org/20260930-fix-dontunmap-partial-self-merge-v2-2-f388985a0f0a@kernel.org
Fixes: e346b3813067 ("mm/mremap: add MREMAP_DONTUNMAP to mremap()")
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Tested-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Brian Geffon <bgeffon@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: <stable@vger.kernel.org>
[ sashal: adapted newer VMA and map-count helpers to direct flag access and existing map-count checks. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mremap.c | 31 +++++++++++++++++++++++--------
 mm/vma.c    |  4 ++--
 mm/vma.h    |  5 +++++
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index e60a63a36ea0b..5d1322dca0359 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1025,8 +1025,8 @@ static void vrm_stat_account(struct vma_remap_struct *vrm,
 }
 
 /*
- * Perform checks before attempting to write a VMA prior to it being
- * moved.
+ * Perform checks and preparation before attempting to write a VMA prior to it
+ * being moved.
  */
 static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
 {
@@ -1035,18 +1035,17 @@ static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
 	unsigned long old_addr = vrm->addr;
 	unsigned long old_len = vrm->old_len;
 	vm_flags_t dummy = vma->vm_flags;
+	const bool split_before = vma->vm_start != old_addr;
+	const bool split_after = vma->vm_end != old_addr + old_len;
 
-	/*
-	 * We'd prefer to avoid failure later on in do_munmap:
-	 * which may split one vma into three before unmapping.
-	 */
+	/* Avoid failure later on. */
 	if (current->mm->map_count >= sysctl_max_map_count - 3)
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
@@ -1064,6 +1063,22 @@ static unsigned long prep_move_vma(struct vma_remap_struct *vrm)
 	if (err)
 		return err;
 
+	/*
+	 * To account mlock()'d pages correctly in the MREMAP_DONTUNMAP
+	 * case perform any split ahead of time for an mlock()'d VMA.
+	 */
+	if ((vrm->flags & MREMAP_DONTUNMAP) &&
+	    (vma->vm_flags & VM_LOCKED)) {
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
 
diff --git a/mm/vma.c b/mm/vma.c
index d1158fdcde287..fd7e968ad707f 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -584,8 +584,8 @@ __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
  * Split a vma into two pieces at address 'addr', a new vma is allocated
  * either for the first part or the tail.
  */
-static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		     unsigned long addr, int new_below)
+int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	      unsigned long addr, int new_below)
 {
 	if (vma->vm_mm->map_count >= sysctl_max_map_count)
 		return -ENOMEM;
diff --git a/mm/vma.h b/mm/vma.h
index 4c7ea8b893ab7..5534216cea4d1 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -409,6 +409,11 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *brkvma,
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
2.53.0

