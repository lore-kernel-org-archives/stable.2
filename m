Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794585797;
	b=Xq7yOD5Br3K2C8CemerTdn5pdhmXZdpVPBcDe4KzAsFDzvD9yQIZJeBix9IdVOjO8vn5
	 VNqnkReE6bshuvp/JLFDY4L54de6JvtLU+QA3hhdvJrBJ2iJh8Hs0yDY0QJZwokPR8He+
	 Fpq66WoEBgZ5CkKiC2HoVEpdsMWwfglikElOSFhtDQMcOpCmtog7VEqc/hJslBdwl/Ynm
	 ke5bWdehBSG4shak1tik8AzWRouQgB3haz6SphxDqfHRc+rgTCYvQvwXCLgFOGltryHZJ
	 kdCJ37bIkZH3L105ithmTP1sPwpXp9m8pkgR2xrokgSzMMIuBlQDjl6nsLHoHtqXBRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794585797;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=290jak9Pw55jCjJrq4EWYyUnmK24UEZ1TDvSeafpV04=;
	b=inNFQUDGT8Wyfrq/CCBKyB4YVYyvtNMz1XGNNiL+L3r5rKAJkPA8gUUlTi1RcSCHPiuz
	 dzz+badcnYT9KZaFWiZyPsWsppirUlE/4dPaNfvWavysINkDIVe7rvh+a6bgxjqgZ1Y5s
	 t38r0sr7bgZo13vyycZjIaBAfwxTjvxYxSbSWPjbqETaqR+VwZUi4zqjHCzIpOq/2Ltlh
	 iLek08llOvesVfRQMVwb3oaXrDM6608XECl0X6qk6JN8/6DNMA/lJIGM/XDqtdPLPzkDw
	 x6MetNeWyIbv6DbAssNuCgRDFSEX31do8Fk5MZoRMD78Btcbh2FfAevjti6cZESva5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gnzZvdfB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F271660A2608
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 16:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gnzZvdfB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2357A1F000C4;
	Fri, 13 Nov 2026 16:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794585796;
	bh=290jak9Pw55jCjJrq4EWYyUnmK24UEZ1TDvSeafpV04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gnzZvdfBpkJNEfV9y+EzBtdC0ct9ao6HMaiYUIyj1bJvvdE6xZIac8NQTpe5p9gev
	 MakJfsnZsaGv1yMU1ohq769x1y404odhNtzcG5Kp31nvqRDs+W3ZY8LxknT2rtM5Pp
	 ErDhqx+nGAndxxPzvPdnbL1yUJnFPRSbRCAgveyiKvTC5mwKLvZyJLlxfaXpUP/La1
	 vs5OpAWE3uqfQE6S70fqoY7bLrArE7hLnUvE0f6jgA94tC1gJZtU72Xy4Ru+aOgyTt
	 PCu3NVEj0zx4kSAFhBN5LXTJFS1njJnGdFYbp+52dNhR6Fj07DWT41Eq06AyUg28C9
	 UiEjgEspEVSYw==
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
Subject: [PATCH 6.18.y] mm/vma: avoid losing atomic VMA flags when setting sticky VMA flags
Date: Fri, 13 Nov 2026 11:03:13 -0500
Message-ID: <20261113152545.1862500-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200426-failed-6.18-c386d799f423@kernel.org>
References: <20261109200426-failed-6.18-c386d799f423@kernel.org>
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
[ sashal: Replaced bitmap-based VMA flag helpers with equivalent scalar vm_flags operations inline in existing functions. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/vma.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 0d4f344956642..6151a54699694 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -756,6 +756,9 @@ static int commit_merge(struct vma_merge_struct *vmg)
 		return -ENOMEM;
 
 	vma_prepare(&vp);
+	/* Must be made visible before vma_complete() for rmap walkers. */
+	vma_assert_write_locked(vmg->target);
+	vm_flags_set(vmg->target, vmg->vm_flags & VM_STICKY);
 	/*
 	 * THP pages may need to do additional splits if we increase
 	 * middle->vm_start.
@@ -794,8 +797,8 @@ static bool can_merge_remove_vma(struct vm_area_struct *vma)
  * merge.
  *
  * As part of this operation, if a merge occurs, the @vmg object will have its
- * vma, start, end, and pgoff fields modified to execute the merge. Subsequent
- * calls to this function should reset these fields.
+ * vma, start, end, pgoff and vm_flags fields modified to execute the merge.
+ * Subsequent calls to this function should reset these fields.
  *
  * Returns: The merged VMA if merge succeeds, or NULL otherwise.
  *
@@ -809,7 +812,6 @@ static bool can_merge_remove_vma(struct vm_area_struct *vma)
 static __must_check struct vm_area_struct *vma_merge_existing_range(
 		struct vma_merge_struct *vmg)
 {
-	vm_flags_t sticky_flags = vmg->vm_flags & VM_STICKY;
 	struct vm_area_struct *middle = vmg->middle;
 	struct vm_area_struct *prev = vmg->prev;
 	struct vm_area_struct *next;
@@ -904,17 +906,22 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 
 	/* No matter what happens, we will be adjusting middle. */
 	vma_start_write(middle);
+	/* Write lock prevents concurrent atomic VMA flag updates. */
+	vma_assert_write_locked(middle);
+	vmg->vm_flags |= middle->vm_flags & VM_STICKY;
 
 	if (merge_right) {
 		vma_start_write(next);
 		vmg->target = next;
-		sticky_flags |= (next->vm_flags & VM_STICKY);
+		vma_assert_write_locked(next);
+		vmg->vm_flags |= next->vm_flags & VM_STICKY;
 	}
 
 	if (merge_left) {
 		vma_start_write(prev);
 		vmg->target = prev;
-		sticky_flags |= (prev->vm_flags & VM_STICKY);
+		vma_assert_write_locked(prev);
+		vmg->vm_flags |= prev->vm_flags & VM_STICKY;
 	}
 
 	if (merge_both) {
@@ -984,7 +991,6 @@ static __must_check struct vm_area_struct *vma_merge_existing_range(
 	if (err || commit_merge(vmg))
 		goto abort;
 
-	vm_flags_set(vmg->target, sticky_flags);
 	khugepaged_enter_vma(vmg->target, vmg->vm_flags);
 	vmg->state = VMA_MERGE_SUCCESS;
 	return vmg->target;
@@ -1176,20 +1182,14 @@ int vma_expand(struct vma_merge_struct *vmg)
 	struct vm_area_struct *target = vmg->target;
 	struct vm_area_struct *next = vmg->next;
 	int ret = 0;
-	vm_flags_t sticky_flags;
-
-	sticky_flags = vmg->vm_flags & VM_STICKY;
-	sticky_flags |= target->vm_flags & VM_STICKY;
 
 	VM_WARN_ON_VMG(!target, vmg);
 
 	mmap_assert_write_locked(vmg->mm);
 	vma_start_write(target);
 
-	if (next && target != next && vmg->end == next->vm_end) {
-		sticky_flags |= next->vm_flags & VM_STICKY;
+	if (next && target != next && vmg->end == next->vm_end)
 		remove_next = true;
-	}
 
 	/* We must have a target. */
 	VM_WARN_ON_VMG(!target, vmg);
@@ -1202,6 +1202,9 @@ int vma_expand(struct vma_merge_struct *vmg)
 	VM_WARN_ON_VMG(target->vm_start < vmg->start ||
 		       target->vm_end > vmg->end, vmg);
 
+	vma_assert_write_locked(target);
+	vmg->vm_flags |= target->vm_flags & VM_STICKY;
+
 	/*
 	 * If we are removing the next VMA or copying from a VMA
 	 * (e.g. mremap()'ing), we must propagate anon_vma state.
@@ -1219,11 +1222,13 @@ int vma_expand(struct vma_merge_struct *vmg)
 	if (remove_next) {
 		vma_start_write(next);
 		vmg->__remove_next = true;
+
+		vma_assert_write_locked(next);
+		vmg->vm_flags |= next->vm_flags & VM_STICKY;
 	}
 	if (commit_merge(vmg))
 		goto nomem;
 
-	vm_flags_set(target, sticky_flags);
 	return 0;
 
 nomem:
-- 
2.53.0

