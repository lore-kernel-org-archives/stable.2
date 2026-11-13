Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581390;
	b=X+ZkR2oXBgZ4PLqnxb0jd4Q6lP0fwRwgg3tOslUzfDYw0X/ZeDcbfQS73MtWIwI3xgk1
	 lDbFCaaAo2xySYFP3jLnyXQeUU+mz3oBrbgRBGsCUh+3AEtXe+ZysYySGF+bseJp8b2z2
	 2bXXre5zfX4Q8yS/CNwiH21JNmXH+gReZY2r2XWq3DF0IOG+/0Xz7XpSB6KuAl/N488C7
	 ubPKMiWMeCSIPisbqhtJ+uur29tnOwz3pWMeI+1gh2O9AMikOA7JYJzI2FVVKs9qIcEYb
	 R6hu9xXaj64ZHRKroaF8WjFLy5A+IqP3cHj9AKzXqMaNpOoavXdUSdvWvYHmi9Vznvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581390;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1O40dJQ0oCJgItG9zRcyNDFfCgSHzIlYS2wZsihKlW0=;
	b=hAOjiVu3MCULWsIbPp7VFmTOeljSSUxk8EPSd8+9y2YnF16Tg+WUMBTwPBi8ao2XyfCA
	 s8YEtnWX6sAJmLzkzXGlS2sfN/MI/4q8rXz14MfXjzIJ2jhBuDRTBHiSQzsoHwZ+pxBWM
	 V9ZP+9xr4J2KZx8Z+gn2BdFYfzzWcPXD15uw6fmt9Nb2FbUcng2U/TiGItCQaeeHTlUrx
	 gk0onAHVsEByJp59OJHSAL9yqkfJ1ylTKtCa8SrYR17y7pq7rx2SMvbiqjQOXHbZoRq93
	 opGEQqmS4e480Or2rhvxgXlwicbF86EGTi4WtFTd7tJws7upzBxg/ISEFwg/tBSck5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fwrfjtWd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1BC606A32E
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fwrfjtWd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968831F000C4;
	Fri, 13 Nov 2026 14:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794581390;
	bh=1O40dJQ0oCJgItG9zRcyNDFfCgSHzIlYS2wZsihKlW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fwrfjtWdZoApJ0ICl02FxZnTOfDcGN19i5kRG69EnI5Y4UDgETTX326kY7NLq31gf
	 rizB7FjyZig/1WkJKOE+R+J34dwi4uDplVrij7P4weUdWELBQHgKzoOYJMES1wD4Jf
	 LtzbM2RGKfT3VsdEc6GHnJ5Fe7QlSXiKL76X5OxuOn9UEqpPA6aYRO2wMwGDr4NuYJ
	 afy7vWGxlH3xNjPiCWdB/D2J7TXscflVnRpD6J8NuzS6QYZ27pdmml/2CavIpqOodp
	 NlO/Q8tKkez5kVy8534691tGUTPTVWqT3MoYZvqfxCJi4cH9U6yQ/mBGvLB+L7ijn+
	 GIeDmnmwD3RQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	SJ Park <sj@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Colin Cross <ccross@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] mm/vma: avoid losing atomic VMA flags when setting sticky VMA flags
Date: Fri, 13 Nov 2026 09:49:47 -0500
Message-ID: <20261113144810.1530088-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200142-failed-7.3-c386d799f423@kernel.org>
References: <20261109200142-failed-7.3-c386d799f423@kernel.org>
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

From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>

[ Upstream commit c386d799f423685952138cab8d89f0331825bdee ]

vma_merge_existing_range() merges an existing VMA (middle) when its
attributes have changed to match those of one or both adjacent VMAs.

Sticky flags are propagated if they are set in any of the merged VMAs. They
are initialised from vmg->vma_flags, which is assumed to contain middle's
sticky flags when the function is invoked.

However, the VMA write lock is not held for middle when they are first
populated, so concurrent updates to atomic VMA flags may occur, which will
be lost upon merge.

This can result in fork failing to propagate guard region markers and (if
file-backed) THP collapse discarding them.

Resolve this by propagating the sticky flags after middle is locked.

Make life easier by factoring this into propagate_sticky_flags(), which
treats vmg->vma_flags as its base (in case any sticky flags are set there),
updating it as sticky flags are accumulated from merged VMAs.

Also update vma_expand() to use propagate_sticky_flags() so all merge paths
utilise it.

propagate_sticky_flags() also asserts that the VMA write lock is held for
the VMA whose sticky flags are being read, with a comment explaining why.

Another means by which atomic VMA flags can fail to be observed is when the
merge is finalised in commit_merge().

rmap locks are dropped in vma_complete() before the sticky flags are
written, meaning an rmap walker can observe the VMA without sticky flags
set, which can also result in retract_page_tables() discarding guard
markers.

Resolve this by assigning the sticky flags before dropping rmap locks,
factored into commit_sticky_flags() with a write assert on the VMA being
written to.

Also remove the vma_set_flags_mask() invocation at the end of
vma_merge_existing_range() as this was introduced by commit
64212ba02e66 ("mm: implement sticky VMA flags") to propagate sticky flags,
which is now redundant with the introduction of commit_sticky_flags().

The vma_set_flags_mask() invocation at the end of vma_expand() setting
sticky flags only is also removed for the same reason.

Also update vma_merge_existing_range()'s comment to reflect the fact that
vmg->vma_flags gets updated.

Finally, update the userland VMA tests to reflect a previously missed
const-ification in vma_assert_write_locked() which would otherwise cause a
warning when building them.

Link: https://lore.kernel.org/20261023-fix-vma-atomic-v1-4-8ff4fae1fc85@kernel.org
Fixes: 2ab7f1bbafc9 ("mm/madvise: allow guard page install/remove under VMA lock")
Fixes: 49e14dabed7a ("mm: set the VM_MAYBE_GUARD flag on guard region install")
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Jann Horn <jannh@google.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: SJ Park <sj@kernel.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Colin Cross <ccross@google.com>
Cc: <stable@vger.kernel.org>
[ sashal: Removed const from the propagate_sticky_flags() VMA parameter to match vma_assert_write_locked()'s non-const pointer requirement. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/vma.c                          | 55 +++++++++++++++++--------------
 tools/testing/vma/include/dup.h   |  2 +-
 tools/testing/vma/include/stubs.h |  2 +-
 3 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index e382fd32f0fff..92c42ca83b95a 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -807,6 +807,27 @@ static void vmg_adjust_set_range(struct vma_merge_struct *vmg)
 	}
 }
 
+static void propagate_sticky_flags(struct vma_merge_struct *vmg,
+		struct vm_area_struct *vma)
+{
+	const vma_flags_t sticky =
+		vma_flags_and_mask(&vma->flags, VMA_STICKY_FLAGS);
+
+	/* Write lock prevents concurrent atomic VMA flag updates. */
+	vma_assert_write_locked(vma);
+	vma_flags_set_mask(&vmg->vma_flags, sticky);
+}
+
+static void commit_sticky_flags(struct vma_merge_struct *vmg)
+{
+	const vma_flags_t sticky =
+		vma_flags_and_mask(&vmg->vma_flags, VMA_STICKY_FLAGS);
+	struct vm_area_struct *target = vmg->target;
+
+	vma_assert_write_locked(target);
+	vma_set_flags_mask(target, sticky);
+}
+
 /*
  * Actually perform the VMA merge operation.
  *
@@ -842,6 +863,8 @@ static int commit_merge(struct vma_merge_struct *vmg)
 		return -ENOMEM;
 
 	vma_prepare(&vp);
+	/* Must be made visible before vma_complete() for rmap walkers. */
+	commit_sticky_flags(vmg);
 	/*
 	 * THP pages may need to do additional splits if we increase
 	 * middle->vm_start.
@@ -881,8 +904,8 @@ static bool can_merge_remove_vma(struct vm_area_struct *vma)
  * merge.
  *
  * As part of this operation, if a merge occurs, the @vmg object will have its
- * vma, start, end, and pgoff fields modified to execute the merge. Subsequent
- * calls to this function should reset these fields.
+ * vma, start, end, pgoff and vma_flags fields modified to execute the merge.
+ * Subsequent calls to this function should reset these fields.
  *
  * Returns: The merged VMA if merge succeeds, or NULL otherwise.
  *
@@ -896,8 +919,6 @@ static bool can_merge_remove_vma(struct vm_area_struct *vma)
 static __must_check struct vm_area_struct *vma_merge_existing_range(
 		struct vma_merge_struct *vmg)
 {
-	vma_flags_t sticky_flags = vma_flags_and_mask(&vmg->vma_flags,
-						      VMA_STICKY_FLAGS);
 	struct vm_area_struct *middle = vmg->middle;
 	struct vm_area_struct *prev = vmg->prev;
 	struct vm_area_struct *next;
@@ -993,24 +1014,18 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 
 	/* No matter what happens, we will be adjusting middle. */
 	vma_start_write(middle);
+	propagate_sticky_flags(vmg, middle);
 
 	if (merge_right) {
-		vma_flags_t next_sticky;
-
 		vma_start_write(next);
 		vmg->target = next;
-		next_sticky = vma_flags_and_mask(&next->flags, VMA_STICKY_FLAGS);
-		vma_flags_set_mask(&sticky_flags, next_sticky);
+		propagate_sticky_flags(vmg, next);
 	}
 
 	if (merge_left) {
-		vma_flags_t prev_sticky;
-
 		vma_start_write(prev);
 		vmg->target = prev;
-
-		prev_sticky = vma_flags_and_mask(&prev->flags, VMA_STICKY_FLAGS);
-		vma_flags_set_mask(&sticky_flags, prev_sticky);
+		propagate_sticky_flags(vmg, prev);
 	}
 
 	if (merge_both) {
@@ -1081,7 +1096,6 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 	if (err || commit_merge(vmg))
 		goto abort;
 
-	vma_set_flags_mask(vmg->target, sticky_flags);
 	khugepaged_enter_vma(vmg->target, vmg->vm_flags);
 	vmg->state = VMA_MERGE_SUCCESS;
 	return vmg->target;
@@ -1274,16 +1288,11 @@ int vma_expand(struct vma_merge_struct *vmg)
 	struct vm_area_struct *target = vmg->target;
 	struct vm_area_struct *next = vmg->next;
 	bool remove_next = false;
-	vma_flags_t sticky_flags =
-		vma_flags_and_mask(&vmg->vma_flags, VMA_STICKY_FLAGS);
-	vma_flags_t target_sticky;
 	int ret = 0;
 
 	mmap_assert_write_locked(vmg->mm);
 	vma_start_write(target);
 
-	target_sticky = vma_flags_and_mask(&target->flags, VMA_STICKY_FLAGS);
-
 	if (next && target != next && vmg->end == next->vm_end)
 		remove_next = true;
 
@@ -1298,7 +1307,7 @@ int vma_expand(struct vma_merge_struct *vmg)
 	VM_WARN_ON_VMG(target->vm_start < vmg->start ||
 		       target->vm_end > vmg->end, vmg);
 
-	vma_flags_set_mask(&sticky_flags, target_sticky);
+	propagate_sticky_flags(vmg, target);
 
 	/*
 	 * If we are removing the next VMA or copying from a VMA
@@ -1315,18 +1324,14 @@ int vma_expand(struct vma_merge_struct *vmg)
 		goto nomem;
 
 	if (remove_next) {
-		vma_flags_t next_sticky;
-
 		vma_start_write(next);
 		vmg->__remove_next = true;
 
-		next_sticky = vma_flags_and_mask(&next->flags, VMA_STICKY_FLAGS);
-		vma_flags_set_mask(&sticky_flags, next_sticky);
+		propagate_sticky_flags(vmg, next);
 	}
 	if (commit_merge(vmg))
 		goto nomem;
 
-	vma_set_flags_mask(target, sticky_flags);
 	return 0;
 
 nomem:
diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/dup.h
index b5abd7802d7d1..856283d3e800c 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -1202,7 +1202,7 @@ static inline void vma_assert_detached(struct vm_area_struct *vma)
 	WARN_ON_ONCE(vma_is_attached(vma));
 }
 
-static inline void vma_assert_write_locked(struct vm_area_struct *);
+static inline void vma_assert_write_locked(const struct vm_area_struct *);
 static inline void vma_mark_attached(struct vm_area_struct *vma)
 {
 	vma_assert_write_locked(vma);
diff --git a/tools/testing/vma/include/stubs.h b/tools/testing/vma/include/stubs.h
index ab441162ac10e..227652c9b81bf 100644
--- a/tools/testing/vma/include/stubs.h
+++ b/tools/testing/vma/include/stubs.h
@@ -298,7 +298,7 @@ static inline void anon_vma_lock_write(struct anon_vma *anon_vma)
 {
 }
 
-static inline void vma_assert_write_locked(struct vm_area_struct *vma)
+static inline void vma_assert_write_locked(const struct vm_area_struct *vma)
 {
 }
 
-- 
2.53.0

