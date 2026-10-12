Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E712F9C37
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 22:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791845479; cv=none; b=Lz5/k6a8coyea1k/I8x79NSv+xEEYlyWYG/zHbVe53MXYXHBjWb0BYPk88W7BjpnfedZmmgoi8YcoECNkysAbx4WcQZ6uoVGJk0P0COANH91SBeGdxZ+67ujE4QNQkk4x0gK4msmfdajqGa242rP2Eszx3MwMkHQHmEgH2DvZX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791845479; c=relaxed/simple;
	bh=vWPXD5XbsfWTmoMrzz0RCOKIpduF68KfFRmL4LXxq/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNDro9rodP7yDxU1loeA25xDmo06fMnejw8eZbuwKmrz6rmeNsEG0dQjiTKzxTVzNPe7vj2imDIPmY5KHvDqkz3ymfGHYRzHPW7d+XBJXeRUU6sRgokTNq0dCfcb0tGIpazC+FcvRfHh4+IWWdK33/KI8VP4lUvEYXyxA1SHvpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6KWDHHr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6KWDHHr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFEE91F0089B;
	Mon, 12 Oct 2026 22:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791845478;
	bh=I7mtVKlMNY84jVTsGm7LMdPOrleJzgFfEHxXVUmPY88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h6KWDHHrQWCOt4Pmm4/Se1kVp7pBs5AZRzJe3lq4AwOJlBDKgrmVSg5GaV/1mf+eF
	 7sYGub2YcpPmvTXisNhHvWYMY/yvYXAMZUTFdokKM43+Q8SasGJXS8YQGm3V2S2Mhm
	 zZhQwljbH8zKOtA3PZU6S9581c6pyyNW49rN129zNWiYZVHgWDoNRVOml850GG1goH
	 9l5R1kc2KrMvKHozOheGWW/VdaoF4SeVPNMeFwfv9QlEgVfvDxemWZWWwu/QC1sXO1
	 KRW7Eo43ABRsmNAMKvwPwMLIQRZFus7LSrUAoKJfBCgPtrS3+gmvoj0Y16Zzq5TFxS
	 DIX5Y6tOQzZkw==
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
Subject: [PATCH 6.12.y] mm/mremap: fix locked_vm leak from MREMAP_DONTUNMAP self-merge
Date: Mon, 12 Oct 2026 18:51:15 -0400
Message-ID: <20261012225047.1862700-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101208-drudge-moonlight-bf51@gregkh>
References: <2026101208-drudge-moonlight-bf51@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>

[ Upstream commit 838bb60dc21553e32df90f2f3bac5b905376e7aa ]

Patch series "mm/mremap: fix two issues with MREMAP_DONTUNMAP", v2.

The MREMAP_DONTUNMAP feature is highly unusual in that it permits mremap()
operations that keep the original VMA in place.

Historically this has led to a lot of bugs where non-obvious interactions
occur between existing mremap() operations and the original VMA.

Commit 397432cab17b ("mm/mremap: account mm->locked_vm correctly for
MREMAP_DONTUNMAP") fixed an accidentally introduced bug around
mm->locked_vm accounting, but this wasn't the only issue.

And thus history repeats itself, as it turns out that mm->locked_vm
accounting is broken by MREMAP_DONTUNMAP yet again by two further cases,
and has been broken ever since the feature was introduced.

Both relate to the fact that VMA_LOCKED_BIT is cleared on the source VMA
(it has to be as all page tables are moved):

1. If an unfaulted VMA_LOCKONFAULT_BIT anonymous VMA self-merges it
   clears the VMA_LOCKED_BIT flag and permanently leaks mm->locked_vm
   pages.

2. If a partial mremap() is performed on a locked VMA there is a leak equal
   to the number of pages not copied.

(Both for MREMAP_DONTUNMAP operations only)

Both issues can be fixed by treating the source range as distinct from the
destination range, which is the definition of what MREMAP_DONTUNMAP does
so is appropriate.

In case 1, simply disallow the self-merge, keeping adjacent source and
destination VMAs distinct.

In case 2, split the source range ahead of time if the VMA is mlock()'d,
so accounting is always correct.

Both changes were tested locally and confirmed to fix the issues.

For the purposes of a backport, the fixes are kept distinct, a follow-up
series can add self-tests.

This patch (of 2):

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

Update dontunmap_complete() to make the now-redundant self-merge check a
VM_WARN_ON_ONCE() instead to guard against future regressions.

Also update the VMA userland tests to reflect the change.

Link: https://lore.kernel.org/20260930-fix-dontunmap-partial-self-merge-v2-0-f388985a0f0a@kernel.org
Link: https://lore.kernel.org/20260930-fix-dontunmap-partial-self-merge-v2-1-f388985a0f0a@kernel.org
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
[ sashal: translated can_self_merge logic to the inverse faulted_in_anon_vma flag. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mremap.c             |  7 +++++--
 mm/vma.c                | 17 ++++++++++++++++-
 mm/vma.h                |  2 +-
 tools/testing/vma/vma.c |  4 ++--
 4 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 9685ea816fde1..1c7841bbcf632 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -742,7 +742,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	vma_start_write(vma);
 	new_pgoff = vma->vm_pgoff + ((old_addr - vma->vm_start) >> PAGE_SHIFT);
 	new_vma = copy_vma(&vma, new_addr, new_len, new_pgoff,
-			   &need_rmap_locks);
+			   &need_rmap_locks, flags & MREMAP_DONTUNMAP);
 	if (!new_vma) {
 		if (vm_flags & VM_ACCOUNT)
 			vm_unacct_memory(to_account >> PAGE_SHIFT);
@@ -803,6 +803,9 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		untrack_pfn_clear(vma);
 
 	if (unlikely(!err && (flags & MREMAP_DONTUNMAP))) {
+		/* Self-merge is disallowed. */
+		VM_WARN_ON_ONCE(new_vma == vma);
+
 		/* We always clear VM_LOCKED[ONFAULT] on the old vma */
 		vm_flags_clear(vma, VM_LOCKED_MASK);
 
@@ -810,7 +813,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		 * anon_vma links of the old vma is no longer needed after its page
 		 * table has been moved.
 		 */
-		if (new_vma != vma && vma->vm_start == old_addr &&
+		if (vma->vm_start == old_addr &&
 			vma->vm_end == (old_addr + old_len)) {
 			const pgoff_t pgoff_unfaulted = vma->vm_start >> PAGE_SHIFT;
 
diff --git a/mm/vma.c b/mm/vma.c
index 3df4cf796c7ff..081c601f8d5bb 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1641,7 +1641,7 @@ int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
  */
 struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
-	bool *need_rmap_locks)
+	bool *need_rmap_locks, bool keep_source)
 {
 	struct vm_area_struct *vma = *vmap;
 	unsigned long vma_start = vma->vm_start;
@@ -1667,6 +1667,21 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	vmg.vma = NULL; /* New VMA range. */
 	vmg.pgoff = pgoff;
 	vmg.next = vma_iter_next_rewind(&vmi, NULL);
+
+	/*
+	 * If the original VMA is kept (MREMAP_DONTUNMAP), the source and
+	 * destination VMA must be treated distinctly.
+	 *
+	 * A merge violates this, so in this case disallow a self-merge.
+	 */
+	if (!faulted_in_anon_vma && keep_source) {
+		if (vmg.prev == vma)
+			vmg.prev = NULL;
+		if (vmg.next == vma)
+			vmg.next = NULL;
+		faulted_in_anon_vma = true;
+	}
+
 	new_vma = vma_merge_new_range(&vmg);
 
 	if (new_vma) {
diff --git a/mm/vma.h b/mm/vma.h
index 729fe3741e897..4498f5f1e8dee 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -333,7 +333,7 @@ int vma_link(struct mm_struct *mm, struct vm_area_struct *vma);
 
 struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
-	bool *need_rmap_locks);
+	bool *need_rmap_locks, bool keep_source);
 
 struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma);
 
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index 9074aaced9c5a..46edffe9c55ac 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -1501,7 +1501,7 @@ static bool test_copy_vma(void)
 	/* Move backwards and do not merge. */
 
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, flags);
-	vma_new = copy_vma(&vma, 0, 0x2000, 0, &need_locks);
+	vma_new = copy_vma(&vma, 0, 0x2000, 0, &need_locks, false);
 
 	ASSERT_NE(vma_new, vma);
 	ASSERT_EQ(vma_new->vm_start, 0);
@@ -1514,7 +1514,7 @@ static bool test_copy_vma(void)
 
 	vma = alloc_and_link_vma(&mm, 0, 0x2000, 0, flags);
 	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x8000, 6, flags);
-	vma_new = copy_vma(&vma, 0x4000, 0x2000, 4, &need_locks);
+	vma_new = copy_vma(&vma, 0x4000, 0x2000, 4, &need_locks, false);
 
 	ASSERT_EQ(vma_new, vma_next);
 
-- 
2.53.0

