Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FE93F326A
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791912681; cv=none; b=KX78ujBb/S9iCwB4EhVf0KNOTH/QieoK9MYGPZatenjTtQImrV/WAaHzvOaWGPUSJ3ihCXniyfnM0eN1dqog5ffam6EJpvN9iGE3aKrMjAblsUlMgyJahsCehDaVqaOt7C/IEQyrus7n0oNOW3IrL6YNjVyQHi9tSRg2rEsTsCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791912681; c=relaxed/simple;
	bh=9mrCqlwDR6uqlqCwwKfgnYlxFaq0N8xH8mMgKo1Ryok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AICdLQWrL6mQSrMHaIxOSlGFihnKxCAKivzmdp16ropC4Xf30ZV+RlFdo+aZZUbbLFA/ashPUg4thWtBZXwacte7i0RuJcQfVL5V8zy9uf3N+Wb4C0KqorV0t7oX+KEPTGmW+fU97aaXcy7jEvprFKZecYOMzjTARBfXjOAOS1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YW6Hqza9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YW6Hqza9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663481F000FF;
	Tue, 13 Oct 2026 17:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791912679;
	bh=2HGZRSUDBGC+CLn5uvDMT7rosRjKjR37Wd7RRpxYQJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YW6Hqza9V3FLE2BukAlfgjI/hR8GHixFB70jVg1x7LjhVnX6gaGrzfH6snTP/8ZIq
	 p77ZZSDwwrQWMwYFpOzgy+wNzXOU+mTqb6PeaAHiXP2Kc+vOC+8+0sKmo/sVKysELB
	 iWS8I3CIV60P3EFy8qpVbokVabd+H1z1SZn1K0cLDipzIgvswGqCUvJ0EFc2ucmYdU
	 UMyOsWk63vpUtH4rXQOWCUeedouq9OCxIacggy/fksKw8W0yGQUu4+Xq6sY4MFWIxq
	 iNt1Mkb773s9b6pRSOYgPl/f7wl5/4+7IYX+rX54un7dFJuzCLKC4XgL5Ws7UTY/bz
	 D5PMTAZa0MUKg==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: stable@vger.kernel.org
Cc: ljs@kernel.org
Subject: [PATCH 5.10.y] mm/mremap: fix locked_vm leak from MREMAP_DONTUNMAP self-merge
Date: Tue, 13 Oct 2026 18:31:15 +0100
Message-ID: <20261013173115.2539223-1-ljs@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <2026101236-scarce-latrine-01e7@gregkh>
References: <2026101236-scarce-latrine-01e7@gregkh>
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
[ ljs - Converted to work with vma_merge(), tweaked commit msg, removed
  redundant self-merge code and comment. ]
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 include/linux/mm.h |  2 +-
 mm/mmap.c          | 23 +++++++++++++++++++----
 mm/mremap.c        | 16 ++++------------
 3 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 4787d39bbad4..38825a944ee5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2562,7 +2562,7 @@ extern void __vma_link_rb(struct mm_struct *, struct vm_area_struct *,
 extern void unlink_file_vma(struct vm_area_struct *);
 extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
-	bool *need_rmap_locks);
+	bool *need_rmap_locks, bool keep_source);
 extern void exit_mmap(struct mm_struct *);
 
 static inline int check_data_rlimit(unsigned long rlim,
diff --git a/mm/mmap.c b/mm/mmap.c
index 4d5e9d085f0a..68a2b51fd380 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3322,7 +3322,7 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
  */
 struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
-	bool *need_rmap_locks)
+	bool *need_rmap_locks, bool keep_source)
 {
 	struct vm_area_struct *vma = *vmap;
 	unsigned long vma_start = vma->vm_start;
@@ -3330,6 +3330,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	struct vm_area_struct *new_vma, *prev;
 	struct rb_node **rb_link, *rb_parent;
 	bool faulted_in_anon_vma = true;
+	bool can_self_merge = false;
 
 	/*
 	 * If anonymous vma has not yet been faulted, update new pgoff
@@ -3338,13 +3339,27 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
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
index 3334c4022210..cb83305e5bd3 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -368,7 +368,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 
 	new_pgoff = vma->vm_pgoff + ((old_addr - vma->vm_start) >> PAGE_SHIFT);
 	new_vma = copy_vma(&vma, new_addr, new_len, new_pgoff,
-			   &need_rmap_locks);
+			   &need_rmap_locks, flags & MREMAP_DONTUNMAP);
 	if (!new_vma)
 		return -ENOMEM;
 
@@ -424,6 +424,9 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		untrack_pfn_moved(vma);
 
 	if (unlikely(!err && (flags & MREMAP_DONTUNMAP))) {
+		/* Self-merge is disallowed. */
+		VM_WARN_ON_ONCE(new_vma == vma);
+
 		if (vm_flags & VM_ACCOUNT) {
 			/* Always put back VM_ACCOUNT since we won't unmap */
 			vma->vm_flags |= VM_ACCOUNT;
@@ -431,17 +434,6 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 			vm_acct_memory(new_len >> PAGE_SHIFT);
 		}
 
-		/*
-		 * VMAs can actually be merged back together in copy_vma
-		 * calling merge_vma. This can happen with anonymous vmas
-		 * which have not yet been faulted, so if we were to consider
-		 * this VMA split we'll end up adding VM_ACCOUNT on the
-		 * next VMA, which is completely unrelated if this VMA
-		 * was re-merged.
-		 */
-		if (split && new_vma == vma)
-			split = 0;
-
 		/* We always clear VM_LOCKED[ONFAULT] on the old vma */
 		vma->vm_flags &= VM_LOCKED_CLEAR_MASK;
 
-- 
2.56.0

