Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792763290;
	b=UC1cL19p2eV6NCeXrrPtbkQnOMhRpiwaH2mhXDBPPyng9JRnj9NE58EYW0dzYAWB7RAu
	 YagPVZPzvc4oSu6rN6NKIsGiuZ3kinCtS1NvEHExk7FTR6qvBYoTBB4jVMup7sVoHPD0W
	 85+/SW7qExrnEq5oR4i7zWfuW00YQyFo8DoRAqiPKbMx/buRVInspuXDybvGbS0FBfOUu
	 8RFtMX1LTOTYIU9N/ixJP8bJHZMBGfiYLkZRGmk+7H+GqpIWZRkp/Z/8JuNKZucFPWI0C
	 bST5MtHWBC72f60hU/WJht0pNgUxzo3ZqSbW3eruVdBX6JZmGOjeX9kGTx2ajlIq7pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792763290;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=G051RCtTj/aOitt//0BQMpLgWk+aIYRCuFDvRT+dDow=;
	b=Ac4IaF6qfP1a6ddor9gph/5eOMlxzIoGLQMz2YbGco/kyFInIhK+++112PW0T1PvNoMA
	 EYBnAGtPrxcvb4Du6yRTIhVCs8g4/m/pikfpfwQ6aHRWzQthM2MvkVydcSdMw3j3C2uK3
	 I8Udes4hsAKUkqdX6rU9BTrFOaRo57/wY6CnDfxcFEH7h54KwaXLtYKyCucRqoCUA+93K
	 TNByU/aS1o/Re138+K/v+lbGrwFQle4R5skUkO/FH9e9lYJECzG2qa+GJOAWDNdq4JWp9
	 rXNLLdVkzlHJUxdLZ4wDDznnld2ezkEGrw8PiFyU4dSidZXoGX4dXsCceMi9O39Y8+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BrNWbR17;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D8F60A261A;
	Fri, 23 Oct 2026 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BrNWbR17
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B0D1F01825;
	Fri, 23 Oct 2026 13:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792763290;
	bh=G051RCtTj/aOitt//0BQMpLgWk+aIYRCuFDvRT+dDow=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BrNWbR17+oBuMwIuG7dEwUXWBpidc4FPmVZXUhVpfCqgodMj9N5hS2a/deBqIDhzQ
	 0cqK/pf94yEEoZPuWuvHwjYhunsTsxP9o5sl27q6hF7qNQO8GxweATd+OTTbqfmVYz
	 jgdCGDAwVp4i576LPGyxA1J5l58dcEkaaU/SceQmylIcIosYiOEO75mgL+upoGKise
	 2GLGUYIPFXj92BeIpmdTvktLkBPlwf9ninCqpN+sV90q95dtDeKGOGBBHLpStiSM2h
	 +oWN5aemU+1vd77qQKSWecQhhKzzlF6jDfgElXUjs315tPD3NeS3M4+gIttmHKEF/O
	 rM7+LaDxYAFtA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 23 Oct 2026 14:47:30 +0100
Subject: [PATCH 4/4] mm/vma: avoid losing atomic VMA flags when setting
 sticky VMA flags
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-fix-vma-atomic-v1-4-8ff4fae1fc85@kernel.org>
References: <20261023-fix-vma-atomic-v1-0-8ff4fae1fc85@kernel.org>
In-Reply-To: <20261023-fix-vma-atomic-v1-0-8ff4fae1fc85@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Davidlohr Bueso <dave@stgolabs.net>, 
 SJ Park <sj@kernel.org>, Kees Cook <kees@kernel.org>, 
 Colin Cross <ccross@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8606; i=ljs@kernel.org;
 h=from:subject:message-id; bh=jnauRsabm7fWTbCZvgqZyNtQKOOPKS6Lkrz/EtjN5R8=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJup7b+vWO3komTPaLjemqC/6GzFfw/p9XuM9v63+jec
 u+PHmkOHaUsDGJcDLJiiizPv4jvDxIJm9d5wd8NZg4rE8gQBi5OAZgI9ydGhpcTHJ/qRUw8vEE3
 7HtebcDVy74rvebuKVv67PXqPaW//1Qw/M9dUp76uD9+TmyxsPsMSWmufQcb/1RUrLl5YuYnFt3
 b07kA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

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

Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
Fixes: 2ab7f1bbafc9 ("mm/madvise: allow guard page install/remove under VMA lock")
Fixes: 49e14dabed7a ("mm: set the VM_MAYBE_GUARD flag on guard region install")
Cc: <stable@vger.kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/vma.c                          | 55 +++++++++++++++++++++------------------
 tools/testing/vma/include/dup.h   |  2 +-
 tools/testing/vma/include/stubs.h |  2 +-
 3 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index aa59005e2f42..a65e397d6f62 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -783,6 +783,27 @@ static void vmg_adjust_set_range(struct vma_merge_struct *vmg)
 	}
 }
 
+static void propagate_sticky_flags(struct vma_merge_struct *vmg,
+		const struct vm_area_struct *vma)
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
@@ -818,6 +839,8 @@ static int commit_merge(struct vma_merge_struct *vmg)
 		return -ENOMEM;
 
 	vma_prepare(&vp);
+	/* Must be made visible before vma_complete() for rmap walkers. */
+	commit_sticky_flags(vmg);
 	/*
 	 * THP pages may need to do additional splits if we increase
 	 * middle->vm_start.
@@ -857,8 +880,8 @@ static bool can_merge_remove_vma(struct vm_area_struct *vma)
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
@@ -872,8 +895,6 @@ static bool can_merge_remove_vma(struct vm_area_struct *vma)
 static __must_check struct vm_area_struct *vma_merge_existing_range(
 		struct vma_merge_struct *vmg)
 {
-	vma_flags_t sticky_flags = vma_flags_and_mask(&vmg->vma_flags,
-						      VMA_STICKY_FLAGS);
 	struct vm_area_struct *middle = vmg->middle;
 	struct vm_area_struct *prev = vmg->prev;
 	struct vm_area_struct *next;
@@ -966,24 +987,18 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 
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
@@ -1054,7 +1069,6 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 	if (err || commit_merge(vmg))
 		goto abort;
 
-	vma_set_flags_mask(vmg->target, sticky_flags);
 	khugepaged_enter_vma(vmg->target, vmg->vm_flags);
 	vmg->state = VMA_MERGE_SUCCESS;
 	return vmg->target;
@@ -1241,16 +1255,11 @@ int vma_expand(struct vma_merge_struct *vmg)
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
 
@@ -1265,7 +1274,7 @@ int vma_expand(struct vma_merge_struct *vmg)
 	VM_WARN_ON_VMG(target->vm_start < vmg->start ||
 		       target->vm_end > vmg->end, vmg);
 
-	vma_flags_set_mask(&sticky_flags, target_sticky);
+	propagate_sticky_flags(vmg, target);
 
 	/*
 	 * If we are removing the next VMA or copying from a VMA
@@ -1282,18 +1291,14 @@ int vma_expand(struct vma_merge_struct *vmg)
 		return ret;
 
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
index 815401b19c57..c778fe437993 100644
--- a/tools/testing/vma/include/dup.h
+++ b/tools/testing/vma/include/dup.h
@@ -1212,7 +1212,7 @@ static inline void vma_assert_detached(struct vm_area_struct *vma)
 	WARN_ON_ONCE(vma_is_attached(vma));
 }
 
-static inline void vma_assert_write_locked(struct vm_area_struct *);
+static inline void vma_assert_write_locked(const struct vm_area_struct *);
 static inline void vma_mark_attached(struct vm_area_struct *vma)
 {
 	vma_assert_write_locked(vma);
diff --git a/tools/testing/vma/include/stubs.h b/tools/testing/vma/include/stubs.h
index f786a585caf0..8d030a3ace84 100644
--- a/tools/testing/vma/include/stubs.h
+++ b/tools/testing/vma/include/stubs.h
@@ -320,7 +320,7 @@ static inline void anon_vma_lock_write(struct anon_vma *anon_vma)
 {
 }
 
-static inline void vma_assert_write_locked(struct vm_area_struct *vma)
+static inline void vma_assert_write_locked(const struct vm_area_struct *vma)
 {
 }
 

-- 
2.56.0

