Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A0D3B9DBF;
	Wed, 30 Sep 2026 18:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790794054; cv=none; b=c4cGGSG2ZMhfHbFevYCgODLibuL6JvLGbYtRqbiLEPh/hFQhRwXe0WQsi2t8mLCGLTnF1YE0GdHBKn8f2FwZhwsWzZqjEo/5lgJPoYJAQYeYoE+ivNHQ9r5oJP3RRTvXP8tn+ZsDaEHuBSdxyOaUO8kvzeYSGisfEDMxMTUq6XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790794054; c=relaxed/simple;
	bh=tUFoyVFkU6ZHa5zI5wSdlRR1b78wdN+xDqu5gYMiGFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hEmHAsud3VcO9unNrrLhOTdjI4d3OaIcoEVM7l3qiV+w1vco7cOypGLPv5NgBegjRwiQu39ny87DXo8uzxfMNjB8XXJ1IEvzgzkNhoyaFgj3YRVqpJujx74IpXK11CvB+ygomcGMBkqU519SebO1wctP66nULgZjl2Z58ZYg3Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTSMkUSv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTSMkUSv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4E51F00899;
	Wed, 30 Sep 2026 18:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790794052;
	bh=e7f6U/kumMHx8CpSqywF0bFzraSlKuPIZ0c2Muo0YBY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZTSMkUSvrQgHEkkTTrdzjJ6bf5469pNBOJI3AwWW+IvHYWA2Cgd0yTx6GqAZsRXzZ
	 ppw5odIVivpHMGPQexVPUx+6vrMPQCMwcra9g5fVMkcoynkIsfBfIAFQTDNFC282hU
	 NkX98S8k+Nk4XSftU+W1FtRGHmv3IkJfdPbBl6Ww8GPoCapigpBQL6T7MR0gwUDA5I
	 GrN2NRC76mWDsUtsn8qMyZXqUdd/+ViwZBYagyX5Sp98c+bB6sIWOeRZgUpWEehkiR
	 yB733+Yl6iEOdXQqW63WkQBIXIL8+eJ37uOA7PwbLOJBk/y7XrUC70chE9gadYLLor
	 52SKSORhO5wsQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 30 Sep 2026 19:47:09 +0100
Subject: [PATCH v2 1/2] mm/mremap: fix locked_vm leak from MREMAP_DONTUNMAP
 self-merge
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-fix-dontunmap-partial-self-merge-v2-1-f388985a0f0a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7539; i=ljs@kernel.org;
 h=from:subject:message-id; bh=tUFoyVFkU6ZHa5zI5wSdlRR1b78wdN+xDqu5gYMiGFU=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLL2RtoWc1wquvm5Nb6e4UbbFU4Ty/uzEjxlFsoWx58+t
 +XpszcBHaUsDGJcDLJiiizPv4jvDxIJm9d5wd8NZg4rE8gQBi5OAZiI8BxGhpfcNxaFuhcdr7zh
 1Xnpapvz0xuB/1XiFs1LWqsX+XJzwDVGhneWs2+E5DyTZTjFkDG5fVHmkvtT037umZA8S9rLm5d
 vBw8A
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

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

Fixes: e346b3813067 ("mm/mremap: add MREMAP_DONTUNMAP to mremap()")
Cc: stable@vger.kernel.org
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/mremap.c                   |  8 ++++++--
 mm/vma.c                      | 17 ++++++++++++++++-
 mm/vma.h                      |  2 +-
 tools/testing/vma/tests/vma.c | 10 +++++-----
 4 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 1122282a1d6a..73f52c45705c 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1275,7 +1275,8 @@ static int copy_vma_and_data(struct vma_remap_struct *vrm,
 	PAGETABLE_MOVE(pmc, NULL, NULL, vrm->addr, vrm->new_addr, vrm->old_len);
 
 	new_vma = copy_vma(&vma, vrm->new_addr, vrm->new_len, new_pgoff,
-			   new_anon_pgoff, &pmc.need_rmap_locks);
+			   new_anon_pgoff, &pmc.need_rmap_locks,
+			   vrm->flags & MREMAP_DONTUNMAP);
 	if (!new_vma) {
 		vrm_uncharge(vrm);
 		*new_vma_ptr = NULL;
@@ -1335,6 +1336,9 @@ static void dontunmap_complete(struct vma_remap_struct *vrm,
 	unsigned long old_start = vma->vm_start;
 	unsigned long old_end = vma->vm_end;
 
+	/* Self-merge is disallowed. */
+	VM_WARN_ON_ONCE(new_vma == vma);
+
 	/* We always clear VMA_LOCKED[ONFAULT]_BIT on the old VMA. */
 	vma_clear_flags_mask(vma, VMA_LOCKED_MASK);
 
@@ -1342,7 +1346,7 @@ static void dontunmap_complete(struct vma_remap_struct *vrm,
 	 * anon_vma links of the old vma is no longer needed after its page
 	 * table has been moved.
 	 */
-	if (new_vma != vma && start == old_start && end == old_end) {
+	if (start == old_start && end == old_end) {
 		const pgoff_t pgoff_unfaulted = vma->vm_start >> PAGE_SHIFT;
 
 		unlink_anon_vmas(vma);
diff --git a/mm/vma.c b/mm/vma.c
index 0db3f1222cad..55d4d0939129 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1946,7 +1946,7 @@ static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
  */
 struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
-	pgoff_t anon_pgoff, bool *need_rmap_locks)
+	pgoff_t anon_pgoff, bool *need_rmap_locks, bool keep_source)
 {
 	struct vm_area_struct *vma = *vmap;
 	unsigned long old_vma_start = vma->vm_start;
@@ -1984,6 +1984,21 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	vmg.pgoff = pgoff;
 	vmg.anon_pgoff = anon_pgoff;
 	vmg.next = vma_iter_next_rewind(&vmi, NULL);
+
+	/*
+	 * If the original VMA is kept (MREMAP_DONTUNMAP), the source and
+	 * destination VMA must be treated distinctly.
+	 *
+	 * A merge violates this, so in this case disallow a self-merge.
+	 */
+	if (can_self_merge && keep_source) {
+		if (vmg.prev == vma)
+			vmg.prev = NULL;
+		if (vmg.next == vma)
+			vmg.next = NULL;
+		can_self_merge = false;
+	}
+
 	new_vma = vma_merge_copied_range(&vmg);
 
 	if (new_vma) {
diff --git a/mm/vma.h b/mm/vma.h
index b2c3bc832a48..03ed8afd0c1f 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -534,7 +534,7 @@ void unlink_file_vma_batch_add(struct unlink_vma_file_batch *vb,
 
 struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
-	pgoff_t anon_pgoff, bool *need_rmap_locks);
+	pgoff_t anon_pgoff, bool *need_rmap_locks, bool keep_source);
 
 struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *vma);
 
diff --git a/tools/testing/vma/tests/vma.c b/tools/testing/vma/tests/vma.c
index c8ef7b8cd46b..e973e0a6d1a8 100644
--- a/tools/testing/vma/tests/vma.c
+++ b/tools/testing/vma/tests/vma.c
@@ -40,7 +40,7 @@ static bool test_copy_vma(void)
 	vma = alloc_and_link_vma(&mm, 0x1000, 0x2000, 1, vma_flags);
 	vma_set_anonymous(vma);
 	vma_orig = vma;
-	vma_new = copy_vma(&vma, 0x2000, 0x1000, 1, 1, &need_locks);
+	vma_new = copy_vma(&vma, 0x2000, 0x1000, 1, 1, &need_locks, false);
 	ASSERT_EQ(vma_new, vma_orig);
 	ASSERT_EQ(vma, vma_orig);
 	ASSERT_EQ(vma_new->vm_start, 0x1000);
@@ -53,7 +53,7 @@ static bool test_copy_vma(void)
 	vma = alloc_and_link_vma(&mm, 0x2000, 0x3000, 2, vma_flags);
 	vma_set_anonymous(vma);
 	vma_orig = vma;
-	vma_new = copy_vma(&vma, 0x1000, 0x1000, 2, 2, &need_locks);
+	vma_new = copy_vma(&vma, 0x1000, 0x1000, 2, 2, &need_locks, false);
 	ASSERT_EQ(vma_new, vma_orig);
 	ASSERT_EQ(vma, vma_orig);
 	ASSERT_EQ(vma_new->vm_start, 0x1000);
@@ -71,7 +71,7 @@ static bool test_copy_vma(void)
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x4000, 3, vma_flags);
 	vma_set_anonymous(vma);
 	vma_orig = vma;
-	vma_new = copy_vma(&vma, 0x2000, 0x1000, 3, 3, &need_locks);
+	vma_new = copy_vma(&vma, 0x2000, 0x1000, 3, 3, &need_locks, false);
 	ASSERT_NE(vma_new, vma_orig);
 	ASSERT_EQ(vma_new, vma);
 	ASSERT_EQ(vma_new->vm_start, 0x1000);
@@ -82,7 +82,7 @@ static bool test_copy_vma(void)
 	/* Move backwards and do not merge. */
 
 	vma = alloc_and_link_vma(&mm, 0x3000, 0x5000, 3, vma_flags);
-	vma_new = copy_vma(&vma, 0, 0x2000, 0, 3, &need_locks);
+	vma_new = copy_vma(&vma, 0, 0x2000, 0, 3, &need_locks, false);
 	ASSERT_NE(vma_new, vma);
 	ASSERT_EQ(vma_new->vm_start, 0);
 	ASSERT_EQ(vma_new->vm_end, 0x2000);
@@ -95,7 +95,7 @@ static bool test_copy_vma(void)
 
 	vma = alloc_and_link_vma(&mm, 0, 0x2000, 0, vma_flags);
 	vma_next = alloc_and_link_vma(&mm, 0x6000, 0x8000, 6, vma_flags);
-	vma_new = copy_vma(&vma, 0x4000, 0x2000, 4, 4, &need_locks);
+	vma_new = copy_vma(&vma, 0x4000, 0x2000, 4, 4, &need_locks, false);
 	vma_assert_attached(vma_new);
 
 	ASSERT_EQ(vma_new, vma_next);

-- 
2.55.0

