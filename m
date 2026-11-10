Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272505;
	b=1RjFFHCExSCRM3wPFrF/lXVN/tIr0PpqrgL8TMKL8iwR8P88iZ+ZpFz6oY0I+mmhXwgd
	 6vwxIZMPNtMBuzsEsbYliEAqB7vv/boFxcQf1niqfs1FDnJdueihu1jAJp9U5k6hn2QpG
	 skPH/ruDqpdebhUBLHFozNJXnCEh79Gil7/uXmlCwNXZHzPJwaKYRJJhrOL8VDr/JaXjL
	 2DZ1Fc5jUIOxSOFHOalgi1D/1b6Er/VBoobaeSEgGqrkneyp7AobJSO2mDTcxgSS8UyYE
	 uqEpcR+1EZ+VfARt4YGFifVIkBvGA8L+XH1C2JUeAGhxF4cg3T/SG+BYP+bijNsSUeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272505;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RRTpVMCTihhC1/G2CdaLfRMJvtLF8zyW6z2kOMLh9L0=;
	b=rIgBc3ZofraerQdsMUc4+6wWAamZLQM+WMAEXvtuK6ub+NGUu5rR0WQaBIA3O3svrKPk
	 e7zqS4KmnGOAqwlZC017Pza5ez6BRxU2FMPCnx9fmLG9DjmxDLW0OexZeDCzr4wnn14F0
	 cJ/h+co8fdoZQ809UsZjvTO/Bgk4h2bU5ygvsW9JawI3q0KIdhL+4LuglZ5gWS7/ohcjd
	 shN1DGnFX57W3IppxThY7BiLVPzPAG4anUnzepaSa0XTszKOBxaFR3bturiIUjH0XDdq8
	 9dqr9aw3htOnpiy3fV44WYDBdyPeKWoMyuoM+Qd+DpiDytDONxDx1n8Ef6Fsii/2b4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=baEBdJVV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4136F606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=baEBdJVV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746791F0089F;
	Tue, 10 Nov 2026 01:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272505;
	bh=RRTpVMCTihhC1/G2CdaLfRMJvtLF8zyW6z2kOMLh9L0=;
	h=From:To:Cc:Subject:Date;
	b=baEBdJVV4mdEMuCJqRGTqYTCOumJweCHVrKBKgIa/b1Kaz5VlvagfIfXjcKGIYdYx
	 qZ2rvXlc7josS2I2DaQJqPO0iL/Be7kDc/vws/NoS7GgU6hutBOB3PNtuTHKvFjVgS
	 NfxKw6mEgvbsJSw5cwcyUVz5XKxfsqn/sXeE25I+w9H2dGc4YDDR+WuH7JuvJ4p6Jg
	 7bkZQgF7bUlak7RnOSS9WcLLSOYHLVYQideIusGXZwojabAzN3m8J8cyd/HqjTvU7Y
	 /gY8iZPFMh/x4LIw41T/tjaCN9ThBc6EW8hjbYhXLtbprv71beNJWEg61acO/vArD3
	 3dQzR9L/WY7Ig==
From: Sasha Levin <sashal@kernel.org>
To: ljs@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	pfalcato@suse.de,
	gourry@gourry.net,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jannh@google.com,
	dave@stgolabs.net,
	sj@kernel.org,
	kees@kernel.org,
	ccross@google.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/vma: avoid losing atomic VMA flags when setting sticky VMA flags" failed to apply to 7.3-stable tree
Date: Mon,  9 Nov 2026 20:01:42 -0500
Message-ID: <20261109200142-failed-7.3-c386d799f423@kernel.org>
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
git cherry-pick -x c386d799f423685952138cab8d89f0331825bdee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200142-failed-7.3-c386d799f423@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c386d799f423685952138cab8d89f0331825bdee Mon Sep 17 00:00:00 2001
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 23 Oct 2026 14:47:30 +0100
Subject: [PATCH] mm/vma: avoid losing atomic VMA flags when setting sticky VMA
 flags

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
---
 mm/vma.c                          | 55 +++++++++++++++++--------------
 tools/testing/vma/include/dup.h   |  2 +-
 tools/testing/vma/include/stubs.h |  2 +-
 3 files changed, 32 insertions(+), 27 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 0325b39793136..af8e65ada23b2 100644
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
index a139774054828..dc4927d26296c 100644
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
index f786a585caf05..8d030a3ace848 100644
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
2.53.0




