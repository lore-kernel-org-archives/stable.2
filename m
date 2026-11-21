Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795276997;
	b=DMPP7tNCCJVyHjrch3rXuE6GKEge8YOfKv+robztn+jmz/J/ZULHbh1dzc8EvRyPpO8T
	 R7mR3Q1IjIeTLuWD79EyeZyrns6B92oDzzjT9KISMtQ61UbJZW/7IY+sMG9LPCnRN0+EM
	 duOTCAR+VvQVo4b4pnoKHVtXAVYseqCfsqV+7ijCbhl61Dz4TBkbljgu4eokqY/bL8/5b
	 9ZEf+HaonNAHGxc1pcdH9RiYeKPyKL/AU280EzdHVgKI0CQ6oDgrNFrDiRbRitA6gAfg2
	 gPtqfk+gprleyQ/GjjykQXCYklPXDfz84dpShu8YcvpKl8T3n2t1xoZetbfcg9jKcRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795276997;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=kQtR/PmrOPe+b32IwJ53yV0sN7VuoVDU7/08bj0Hnhk=;
	b=0izINYViDJIvP3pI+2FzX615SAREBELzgNVLJ5I//c/AT1NO2BL1YqIJCE3MNdRzAemo
	 kZ9Nw/KUdjYl79jTvYm3ZO7acJrBuTt8OlrwYl3cH6qnkHcRcki5W/RH/fb6bevt0cG8h
	 5TuM7cbTNmcmOizUUjTo6rDluCnCMVvEBhe+4RZX9E44QaT1Oeg5ZEpOjJyPbN8rWeRFh
	 C80A/G8ft0oUbIgNL+xnpFW+CUVNm0apASVYQE9Shou/NBSbYHwzBlQW5Z6yK4wfQk/8i
	 UbYH/nIReUVeyU0ShHqd5aQpQixfnCRu7jzpRTnBXgtrfTFSoYAXI47oOmWOCqYWXXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YS1mv0Zd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F63606A32A
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 16:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YS1mv0Zd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73921F000CA;
	Sat, 21 Nov 2026 16:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795276997;
	bh=kQtR/PmrOPe+b32IwJ53yV0sN7VuoVDU7/08bj0Hnhk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YS1mv0ZdGcWiRFfMStIUvrZh479IvpEBJ+qvvuZSLk3Ft1Tu3sV9xUII0/od9Li7x
	 IW/UVTcAwjr8v2YRO2IyWXI3b7vQb0rO4C6w2iXu20Tfbx/Ce0C6WmM3eXEuNnrhGB
	 4+3W3AoUKudpInzxiGGZFSfLFb7kRM9DLULE0XuK36tY+DH2BnozSq09JTLZebS6mz
	 OUkoFaF0bVPF1KcsrRb4o/PZnWc2vB7nb37gTubrevKQmsM0MVD5xdI+VwnOjclonr
	 ZWBXySKoBxZPjMSeoFp2RT/Q7EQSdzodWNyTyMfXZDR/0tckf/sexKWsa5xXkzhIz3
	 YcwompBGiE1xQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Sat, 21 Nov 2026 16:02:27 +0000
Subject: [PATCH 1/7] mm/vma: error out on invalid bounds in
 unmapped_area_topdown()
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
Message-Id: <20261121-some-more-ai-fixes-v1-1-236e925d9b64@kernel.org>
References: <20261121-some-more-ai-fixes-v1-0-236e925d9b64@kernel.org>
In-Reply-To: <20261121-some-more-ai-fixes-v1-0-236e925d9b64@kernel.org>
To: "Liam R. Howlett" <liam@infradead.org>, 
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Kees Cook <kees@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, 
 Ollie Wild <aaw@google.com>, Adrian Bunk <bunk@stusta.de>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, Joey Gouly <joey.gouly@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-mm@kvack.org, Chris Mason <mason@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4829; i=ljs@kernel.org;
 h=from:subject:message-id; bh=+4kE7CdMswTMuf4/1YP3lHCd+R2WBN1rK5h5dCacX84=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLIZD2zPlJS15juidKU60Phw59Yj3sHiL977RD16K3Tqy
 ubC8vQFHaUsDGJcDLJiiizPv4jvDxIJm9d5wd8NZg4rE8gQBi5OAZjIn2qG/545Zsfz1eNMDAP4
 fdf8m8fCVfal7tXl35M90gI0jPTX6DH8d7R/cP5hF7+E2en6mGYJs0PTw285Ny18eGKn0LqjUw9
 MZQQA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

unmapped_area_topdown() suffers from a class of bug arising from a mismatch
between how maple tree functions and VMA iterator functions express ranges
- the former inclusively, the latter exclusively.

This is problematic with an exclusive upper bound of 0, as it translates
to an inclusive upper bound of ULONG_MAX, that is a range which extends to
the end of the address space, and start < end or equivalent comparisons
evaluate false in a situation where in fact the expression should evaluate
true.

unmapped_area_topdown() calls vma_iter_area_highest() to position the VMA
iterator into the next highest empty range spanning [low_limit,
high_limit), iteratively reducing high_limit without checking whether it
has reached 0.

This can result in a [low_limit, 0) pair being passed to
vma_iter_area_highest() and thus unexpected underflow. Consider:

    vm_start        = 0x30000
    stack_guard_gap = 0x100000
    info->length    = 0x1000
    high_limit      = vm_start_gap() = 0
    high_limit - 1  = ULONG_MAX
    window          = [low_limit, ULONG_MAX]
    vma_iter_end()  = ULONG_MAX + 1 = 0
    gap             = 0 - info->length = 0xfffffffffffff000

The result is page aligned and below the IS_ERR_VALUE() range, so it
does not look like an error. What follows depends on the caller:

 - mmap() with no hint can fail with -ENOMEM while space is free. The
   bottom-up fallback is skipped, and __get_unmapped_area() refuses the
   address as above TASK_SIZE.
 - On x86-64, find_nearest_trampoline() can pick the address for the
   uprobe trampoline. _install_special_mapping() then inserts a VMA
   whose vm_end is 0, and exit_mmap() frees kernel page tables that
   every mm shares.
 - On powerpc64 with the hash MMU, slice_get_unmapped_area() can pass
   the address to alloc_extended_context(), which then writes out of
   bounds of mm->context.extended_id[].

mmap() can succeed with an address from the wrapped window where the
range above TASK_SIZE is too short for the request and its alignment
padding. On s390 that range is one page, so this takes no more than the
default stack_guard_gap.

Fix the issue by converting the loop into one that explicitly tests
low_limit < high_limit.

Additionally, simplify the logic by declaring the VMA iterator in the
loop (it is reset on each iteration anyway) and exiting with the correct
output value on success rather than performing a goto when an iteration is
required.

Reported-by: Chris Mason <mason@kernel.org>
Fixes: 58c5d0d6d522 ("mm/mmap: regression fix for unmapped_area{_topdown}")
Cc: <stable@vger.kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/vma.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index c82e9306b11a..09bbcdb4971b 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -3369,8 +3369,6 @@ unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 {
 	unsigned long length, gap, gap_end;
 	unsigned long low_limit, high_limit;
-	struct vm_area_struct *tmp;
-	VMA_ITERATOR(vmi, current->mm, 0);
 
 	/* Adjust search length to account for worst case alignment overhead */
 	length = info->length + info->align_mask + info->start_gap;
@@ -3381,31 +3379,31 @@ unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 	if (low_limit < mmap_min_addr)
 		low_limit = mmap_min_addr;
 	high_limit = info->high_limit;
-retry:
-	if (vma_iter_area_highest(&vmi, low_limit, high_limit, length))
-		return -ENOMEM;
 
-	gap = vma_iter_end(&vmi) - info->length;
-	gap -= (gap - info->align_offset) & info->align_mask;
-	gap_end = vma_iter_end(&vmi);
-	tmp = vma_next(&vmi);
-	 /* Avoid prev check if possible */
-	if (tmp && vma_test_any_mask(tmp, VMA_STARTGAP_FLAGS)) {
-		if (vm_start_gap(tmp) < gap_end) {
+	while (low_limit < high_limit) {
+		VMA_ITERATOR(vmi, current->mm, 0);
+		struct vm_area_struct *tmp;
+
+		if (vma_iter_area_highest(&vmi, low_limit, high_limit, length))
+			break;
+
+		gap = vma_iter_end(&vmi) - info->length;
+		gap -= (gap - info->align_offset) & info->align_mask;
+		gap_end = vma_iter_end(&vmi);
+		tmp = vma_next(&vmi);
+		/* Avoid prev check if possible */
+		if (tmp && vma_test_any_mask(tmp, VMA_STARTGAP_FLAGS)) {
+			if (vm_start_gap(tmp) >= gap_end)
+				return gap;
 			high_limit = vm_start_gap(tmp);
-			vma_iter_reset(&vmi);
-			goto retry;
-		}
-	} else {
-		tmp = vma_prev(&vmi);
-		if (tmp && vm_end_gap(tmp) > gap) {
+		} else {
+			tmp = vma_prev(&vmi);
+			if (!tmp || vm_end_gap(tmp) <= gap)
+				return gap;
 			high_limit = tmp->vm_start;
-			vma_iter_reset(&vmi);
-			goto retry;
 		}
 	}
-
-	return gap;
+	return -ENOMEM;
 }
 
 /*

-- 
2.56.0

