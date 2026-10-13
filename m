Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576763C5826
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791911257; cv=none; b=HEUblV654GaD0GW2eeKF7y3XQHEtt83ioyVE70TUJ7ode+Ycdj3vBFrWOpqmYb1PW2ASgDwlpnbHEDIcXk08mehNs/SUMHoR3BvrmXFtU9129Vf4A5BBd0NGlv0YKCw8HHnpx3KDNMugH2sHiN9IRhYySdJB4zbNIBD7LINbsOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791911257; c=relaxed/simple;
	bh=61LDKYmDck4qX5S5p5ykD4ntVuOHiz4IIMNDzBnCeQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHILhqQDq/djxgThWXJIXEyY8D+N9V1gdAUi9NlCfyQtKW2DUKiMDV4+zBi9GvZqM734g7eWRhJUV7GBiWKFD1EJvP7Yam3ue3Z48XJpRkyObLklDg8HQv5f+2KJGXIf6dWAA7qcieedl9pox+wqihmexL6grJuF3UjMDGFCFdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e97X3yYX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e97X3yYX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D891F000FF;
	Tue, 13 Oct 2026 17:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791911255;
	bh=LeBdVW6R6v3TTt0Wm5gACDbS5lyJ7f9wKlNaD6vmYTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e97X3yYXXFq+7WlmG/8KwsycMJR61c8ftoBJRN8JbvWXgdnkvyo5b++xOijkP31J1
	 +OO7yEKTQWqbfW1kaa40DLV1OhdciJtZYzJRLJtZUttp74KCUlfB5+nFhNf/EvHbvH
	 aT/n2FUDWP7/pZv/0EFmRhK8Bsx3hZTRzm43uLMHHL/OcLiR6dHzMjAz9LdCOMTMpg
	 5T5/um7Th7t6b5ijRs6JCgivJyQrGyT2U8S4b3DXbxT93Yu2Yj5fR7AiBnz97zHzwT
	 n1ayQQwiGZ/2wlTnwipMqS40V9kG+Z6pwIEMQftBpjm8PKm3+uenNEnz9sgTYiT8cN
	 1NOzV2wk8aDfw==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: stable@vger.kernel.org
Cc: ljs@kernel.org
Subject: [PATCH 5.15.y] mm/mremap: fix locked_vm leak from MREMAP_DONTUNMAP self-merge
Date: Tue, 13 Oct 2026 18:07:30 +0100
Message-ID: <20261013170730.2523603-1-ljs@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <2026101221-cosmos-hyphen-4624@gregkh>
References: <2026101221-cosmos-hyphen-4624@gregkh>
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
index 071dd864a7b2..bd69dd6c5e9d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2581,7 +2581,7 @@ extern void __vma_link_rb(struct mm_struct *, struct vm_area_struct *,
 extern void unlink_file_vma(struct vm_area_struct *);
 extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
-	bool *need_rmap_locks);
+	bool *need_rmap_locks, bool keep_source);
 extern void exit_mmap(struct mm_struct *);
 
 static inline int check_data_rlimit(unsigned long rlim,
diff --git a/mm/mmap.c b/mm/mmap.c
index 273e06dad3c6..80307648c2ea 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3273,7 +3273,7 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
  */
 struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
-	bool *need_rmap_locks)
+	bool *need_rmap_locks, bool keep_source)
 {
 	struct vm_area_struct *vma = *vmap;
 	unsigned long vma_start = vma->vm_start;
@@ -3281,6 +3281,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	struct vm_area_struct *new_vma, *prev;
 	struct rb_node **rb_link, *rb_parent;
 	bool faulted_in_anon_vma = true;
+	bool can_self_merge = false;
 
 	/*
 	 * If anonymous vma has not yet been faulted, update new pgoff
@@ -3289,13 +3290,27 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma)) {
 		pgoff = addr >> PAGE_SHIFT;
 		faulted_in_anon_vma = false;
+		can_self_merge = true;
 	}
 
 	if (find_vma_links(mm, addr, addr + len, &prev, &rb_link, &rb_parent))
 		return NULL;	/* should never get here */
-	new_vma = vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
-			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
-			    vma->vm_userfaultfd_ctx);
+
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
+				    vma_policy(vma), vma->vm_userfaultfd_ctx);
 	if (new_vma) {
 		/*
 		 * Source vma may have been merged into new_vma
diff --git a/mm/mremap.c b/mm/mremap.c
index 3a3cf4cc2c63..35633236991f 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -614,7 +614,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 
 	new_pgoff = vma->vm_pgoff + ((old_addr - vma->vm_start) >> PAGE_SHIFT);
 	new_vma = copy_vma(&vma, new_addr, new_len, new_pgoff,
-			   &need_rmap_locks);
+			   &need_rmap_locks, flags & MREMAP_DONTUNMAP);
 	if (!new_vma) {
 		if (unlikely(flags & MREMAP_DONTUNMAP && vm_flags & VM_ACCOUNT))
 			vm_unacct_memory(new_len >> PAGE_SHIFT);
@@ -671,6 +671,9 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		untrack_pfn_moved(vma);
 
 	if (unlikely(!err && (flags & MREMAP_DONTUNMAP))) {
+		/* Self-merge is disallowed. */
+		VM_WARN_ON_ONCE(new_vma == vma);
+
 		/* We always clear VM_LOCKED[ONFAULT] on the old vma */
 		vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
 
@@ -678,7 +681,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		 * anon_vma links of the old vma is no longer needed after its page
 		 * table has been moved.
 		 */
-		if (new_vma != vma && vma->vm_start == old_addr &&
+		if (vma->vm_start == old_addr &&
 			vma->vm_end == (old_addr + old_len))
 			unlink_anon_vmas(vma);
 
-- 
2.56.0

