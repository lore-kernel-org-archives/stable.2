Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879043AE191;
	Wed, 30 Sep 2026 22:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790806901; cv=none; b=lwnLnuxh3y+HHaa8boaFcXjn2UVt2GeVtgKkfzEHqzk0U0oBWdGttUjqOv38sEZk6/4Fe9faPhspIW7ya18YBji0q/dKfjKdEc3IGzkWLpERg5vqa+L9odvC6qiOZv2P3ZdKs31/XNviLrTSud1kWH+0OOAocohxWJfOzjSUlWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790806901; c=relaxed/simple;
	bh=MC/lgYa0u9kPBiONMARRFiv6bk814TpB+dJOiCP4Wos=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BwSdf5G0ZzAAQtGBPIrVbUifSZ67zoBQedx9wINTNHbfMmSsWeOocBV3vb0+6mifj9FTIIKRmddzkkVffQba5qvowB9wMTzjBmWEKHmq5vERpwXrBPlGJv70eL7O2LOjKRmA1zB6D+w9vmQlfB6tWJmYk7wXQ57zjrHh8jC8hrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KuVGLKbx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KuVGLKbx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8DA1F000FF;
	Wed, 30 Sep 2026 22:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1790806900;
	bh=IKOEly26QwsjTOxELJ9kv4BjxWIGBNW52EqhkHZYQvo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KuVGLKbxKkvwypB/qMaVW0IqYJBeq7a3q8gHRIRZWTVgA4JjsbVFTHP3C1+i7LCza
	 ur+WSQvchGa6gu5sKk812nUMfWKZugQavpocZ8NjjkxUbdqYK9jbo3DLZJXX6cWkwO
	 7jXENUVygR56Og/yTSUQ/bJh5VLuunvUAsTvwTlo=
Date: Wed, 30 Sep 2026 15:21:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka
 <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, Brian Geffon <bgeffon@google.com>, Minchan Kim
 <minchan@kernel.org>, Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Anirudh Srinivasan
 <asrinivasan@oss.tenstorrent.com>, stable@vger.kernel.org,
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Subject: Re: [PATCH v2 0/2] mm/mremap: fix two issues with MREMAP_DONTUNMAP
Message-Id: <20260930152139.e8fc193b9c2880b625fda814@linux-foundation.org>
In-Reply-To: <20260930-fix-dontunmap-partial-self-merge-v2-0-f388985a0f0a@kernel.org>
References: <20260930-fix-dontunmap-partial-self-merge-v2-0-f388985a0f0a@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 19:47:08 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> The MREMAP_DONTUNMAP feature is highly unusual in that it permits mremap()
> operations that keep the original VMA in place.
> 
> Historically this has led to a lot of bugs where non-obvious interactions
> occur between existing mremap() operations and the original VMA.
> 
> Commit 397432cab17b ("mm/mremap: account mm->locked_vm correctly for
> MREMAP_DONTUNMAP") fixed an accidentally introduced bug around
> mm->locked_vm accounting, but this wasn't the only issue.
> 
> And thus history repeats itself, as it turns out that mm->locked_vm
> accounting is broken by MREMAP_DONTUNMAP yet again by two further cases,
> and has been broken ever since the feature was introduced.
> 
> Both relate to the fact that VMA_LOCKED_BIT is cleared on the source
> VMA (it has to be as all page tables are moved):
> 
> 1. If an unfaulted VMA_LOCKONFAULT_BIT anonymous VMA self-merges it
>    clears the VMA_LOCKED_BIT flag and permanently leaks mm->locked_vm
>    pages.
> 
> 2. If a partial mremap() is performed on a locked VMA there is a leak equal
>    to the number of pages not copied.
> 
> (Both for MREMAP_DONTUNMAP operations only)
> 
> Both issues can be fixed by treating the source range as distinct from the
> destination range, which is the definition of what MREMAP_DONTUNMAP does so
> is appropriate.

Thanks, updated.

> v2:
> * Added tags (thanks everybody!)
> * Updated 2/2 to avoid splitting the VMA if the VMA was not mlock()'d. It
>   is only meaningful and necessary to perform the split in this case. This
>   also fixes the proc_maps_race selftests that broke, as reported by
>   Anirudh.

Here's how v2 altered mm.git's mm-hotfixes-unstable branch.  Quite a
large change - are you sure that retaining the tags was appropriate?


 mm/mremap.c |   57 +++++++++++++++++++++++++++++---------------------
 mm/vma.c    |    2 -
 2 files changed, 35 insertions(+), 24 deletions(-)

--- a/mm/mremap.c~b
+++ a/mm/mremap.c
@@ -1037,7 +1037,7 @@ static void vrm_stat_account(struct vma_
 }
 
 static bool __check_map_count_against_split(struct mm_struct *mm,
-					    bool is_dontunmap,
+					    bool pre_split,
 					    bool before_unmaps)
 {
 	const int sys_map_count = get_sysctl_max_map_count();
@@ -1091,31 +1091,35 @@ static bool __check_map_count_against_sp
 	 */
 	map_count += 2;
 
-	/*
-	 * If MREMAP_DONTUNMAP is set and a partial operation is performed,
-	 * the VMA is split ahead of time and the -1 observed above doesn't
-	 * apply.
-	 */
-	if (is_dontunmap)
+	/* If pre-split, the -1 observed above doesn't apply. */
+	if (pre_split)
 		map_count++;
 
 	return map_count <= sys_map_count;
 }
 
+static bool needs_pre_split(struct vma_remap_struct *vrm)
+{
+	/*
+	 * An MREMAP_DONTUNMAP of a mlock()'d VMA needs to unlock the
+	 * source VMA, so split in this case.
+	 */
+	return (vrm->flags & MREMAP_DONTUNMAP) &&
+		vma_test(vrm->vma, VMA_LOCKED_BIT);
+}
+
 /* Do we violate the map count limit if we split VMAs when moving the VMA? */
 static bool check_map_count_against_split(struct vma_remap_struct *vrm)
 {
 	return __check_map_count_against_split(current->mm,
-					       vrm->flags & MREMAP_DONTUNMAP,
-					       /*before_unmaps=*/false);
+		needs_pre_split(vrm), /*before_unmaps=*/false);
 }
 
 /* Do we violate the map count limit if we split VMAs prior to early unmaps? */
 static bool check_map_count_against_split_early(struct vma_remap_struct *vrm)
 {
 	return __check_map_count_against_split(current->mm,
-					       vrm->flags & MREMAP_DONTUNMAP,
-					       /*before_unmaps=*/true);
+		vrm->flags & MREMAP_DONTUNMAP, /*before_unmaps=*/true);
 }
 
 /*
@@ -1159,9 +1163,9 @@ static unsigned long prep_move_vma(struc
 
 	/*
 	 * To account mlock()'d pages correctly in the MREMAP_DONTUNMAP
-	 * case perform any split ahead of time.
+	 * case perform any split ahead of time for an mlock()'d VMA.
 	 */
-	if (vrm->flags & MREMAP_DONTUNMAP) {
+	if (needs_pre_split(vrm)) {
 		VMA_ITERATOR(vmi, vma->vm_mm, old_addr);
 
 		if (split_before)
@@ -1356,8 +1360,11 @@ static int copy_vma_and_data(struct vma_
 static void dontunmap_complete(struct vma_remap_struct *vrm,
 			       struct vm_area_struct *new_vma)
 {
+	unsigned long start = vrm->addr;
+	unsigned long end = vrm->addr + vrm->old_len;
 	struct vm_area_struct *vma = vrm->vma;
-	const pgoff_t pgoff_unfaulted = vma->vm_start >> PAGE_SHIFT;
+	unsigned long old_start = vma->vm_start;
+	unsigned long old_end = vma->vm_end;
 
 	/* Self-merge is disallowed. */
 	VM_WARN_ON_ONCE(new_vma == vma);
@@ -1369,15 +1376,19 @@ static void dontunmap_complete(struct vm
 	 * anon_vma links of the old vma is no longer needed after its page
 	 * table has been moved.
 	 */
-	unlink_anon_vmas(vma);
-	/*
-	 * The VMA is now unfaulted and it is an invariant that
-	 * unfaulted anonymous VMAs have page offset equal to
-	 * vma->vm_start >> PAGE_SHIFT.
-	 */
-	vma_set_anon_pgoff(vma, pgoff_unfaulted);
-	if (vma_is_anonymous(vma) && !vma->vm_file)
-		vma_set_pgoff(vma, pgoff_unfaulted);
+	if (start == old_start && end == old_end) {
+		const pgoff_t pgoff_unfaulted = vma->vm_start >> PAGE_SHIFT;
+
+		unlink_anon_vmas(vma);
+		/*
+		 * The VMA is now unfaulted and it is an invariant that
+		 * unfaulted anonymous VMAs have page offset equal to
+		 * vma->vm_start >> PAGE_SHIFT.
+		 */
+		vma_set_anon_pgoff(vma, pgoff_unfaulted);
+		if (vma_is_anonymous(vma) && !vma->vm_file)
+			vma_set_pgoff(vma, pgoff_unfaulted);
+	}
 }
 
 static unsigned long move_vma(struct vma_remap_struct *vrm)
--- a/mm/vma.c~b
+++ a/mm/vma.c
@@ -635,7 +635,7 @@ out_free_vma:
  * either for the first part or the tail.
  */
 int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		     unsigned long addr, int new_below)
+	      unsigned long addr, int new_below)
 {
 	if (vma->vm_mm->map_count >= get_sysctl_max_map_count())
 		return -ENOMEM;
_

