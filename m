Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A5D5226BF
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 16:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791910125; cv=none; b=OKEf12o5GWWdqnbByZvE4mYiVNo4EM54a++5Zdg3gPsQmSAmME17J4YDF/zftumUh7hU4uD9i36DxSoxI7Mmzn6bTnUTZlts4b2Ro2CDW+ETMDtqjdyySOckhxQPM9q5nb5UwrqPhpJFqg3fck7knppRIFydI6auAbyELz5mI2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791910125; c=relaxed/simple;
	bh=kH6PVbdCdR/YZom3xg9JBY5LJ4KbUTrTI+LWL8MKpiA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y4w9cZkxbYE1TuWcvftlSc3XVG0ej4R6YIUrfin7cONLv+GNkf0HmMNtlyLsVwl3h2N0zolm64JwdufyNoj+fd58g86GLawli5VKUMnwrwq8zjJO58jjmasNY+PyksYOM5Bpvf6D5koJ+VWdFW1x8Org6aMheIv7AeuNSj/8nkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLW4Vss9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLW4Vss9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AE81F00898
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 16:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791910122;
	bh=5i8ER2T8wp5AvP3jicWqLnw2aG9hMk+CPRtS/3TTtnA=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=jLW4Vss9CUUD+QJAvtvWLg/4/LdeZxX2q0ooWkD5yWE6aIVKUqV184B/4Tz4at+7S
	 eMyKicSBirrlj0+5JzdtpQ3IaWpdcElnnlED4JamtMlPnvB5OyskipzbMlmNvakwNX
	 Z1B69+bZRIGtCSIIqG01V6vaaJs2Uznq0EWlA/B4Tznydbxs62eVjlaoI0BG+fcKd3
	 L5kuCK0dT6ZoX9q49bVHYIJ1jBarOTX39Oj+eVn+QQC93g5rgTfgQD7Y1qmL1oSaSP
	 E5tTTL/lI3Zntg2MPmT0HiH0j0vOBLD2f8c1tYjBF7qEne/T2JncyoFssI3+5TUsrM
	 JaJjxmWVCYXew==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: stable@vger.kernel.org
Subject: [PATCH 6.6.y] mm/mremap: fix locked_vm leak from MREMAP_DONTUNMAP self-merge
Date: Tue, 13 Oct 2026 17:48:37 +0100
Message-ID: <20261013164837.2509912-1-ljs@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <2026101210-unicycle-configure-b7b7@gregkh>
References: <2026101210-unicycle-configure-b7b7@gregkh>
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
index 09669ea23084..c365c33b9c3a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3313,7 +3313,7 @@ extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void unlink_file_vma(struct vm_area_struct *);
 extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
-	bool *need_rmap_locks);
+	bool *need_rmap_locks, bool keep_source);
 extern void exit_mmap(struct mm_struct *);
 
 static inline int check_data_rlimit(unsigned long rlim,
diff --git a/mm/mmap.c b/mm/mmap.c
index 8cf23a07ae50..374a6e02c299 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3383,13 +3383,14 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
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
 	VMA_ITERATOR(vmi, mm, addr);
 
 	/*
@@ -3399,15 +3400,29 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma)) {
 		pgoff = addr >> PAGE_SHIFT;
 		faulted_in_anon_vma = false;
+		can_self_merge = true;
 	}
 
 	new_vma = find_vma_prev(mm, addr, &prev);
 	if (new_vma && new_vma->vm_start < addr + len)
 		return NULL;	/* should never get here */
 
-	new_vma = vma_merge(&vmi, mm, prev, addr, addr + len, vma->vm_flags,
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
+		new_vma = vma_merge(&vmi, mm, prev, addr, addr + len,
+				    vma->vm_flags, vma->anon_vma, vma->vm_file,
+				    pgoff, vma_policy(vma),
+				    vma->vm_userfaultfd_ctx, anon_vma_name(vma));
 	if (new_vma) {
 		/*
 		 * Source vma may have been merged into new_vma
diff --git a/mm/mremap.c b/mm/mremap.c
index d458ef218a37..18cbc4b526df 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -645,7 +645,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	vma_start_write(vma);
 	new_pgoff = vma->vm_pgoff + ((old_addr - vma->vm_start) >> PAGE_SHIFT);
 	new_vma = copy_vma(&vma, new_addr, new_len, new_pgoff,
-			   &need_rmap_locks);
+			   &need_rmap_locks, flags & MREMAP_DONTUNMAP);
 	if (!new_vma) {
 		if (vm_flags & VM_ACCOUNT)
 			vm_unacct_memory(to_account >> PAGE_SHIFT);
@@ -706,6 +706,9 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		untrack_pfn_clear(vma);
 
 	if (unlikely(!err && (flags & MREMAP_DONTUNMAP))) {
+		/* Self-merge is disallowed. */
+		VM_WARN_ON_ONCE(new_vma == vma);
+
 		/* We always clear VM_LOCKED[ONFAULT] on the old vma */
 		vm_flags_clear(vma, VM_LOCKED_MASK);
 
@@ -713,7 +716,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		 * anon_vma links of the old vma is no longer needed after its page
 		 * table has been moved.
 		 */
-		if (new_vma != vma && vma->vm_start == old_addr &&
+		if (vma->vm_start == old_addr &&
 			vma->vm_end == (old_addr + old_len))
 			unlink_anon_vmas(vma);
 
-- 
2.56.0

