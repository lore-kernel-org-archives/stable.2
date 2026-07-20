Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015D2171AF
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784550990; cv=none; b=k35J3OhzhH/+npALzX0/p5NYyYWNs7OlRIwho0/QVKGraojNiFvcPbJZGdvkrv/WrgGOmG2M+lvFRyWyUJhTdVDOeFCzXnCnEHHwYzO1vFdO5pDzhPqSmcZ2C+FaUtE77HyRVwCDVr6Nsz7wNLZ8GOp4ZGfMwbarZJg6Agp1hdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784550990; c=relaxed/simple;
	bh=d+jh9meMTgZIGsSlWwHTHnmfeMq1+sq7F/KMu0bLwak=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YKcskgRxEVVt2cVcHZSBCiVA2KMj8ISbvJnQPVxLI6ALLpgei/Z5or7maxxfgDr88h/SdIzJob8TEhKnF56IBXi5FLFLy60lc9//6hrBc16qrmzjusr9++L4lV0jxK9iKeXRHrfBphacSz3qvVvh6cNqTTVB7EQx4xjyXcp+jHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TCPVS4iY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TCPVS4iY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 660241F000E9;
	Mon, 20 Jul 2026 12:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784550988;
	bh=LVHXv8z8c998JTtRJSanEjoBMbupEMGRIsdsN++j7Jc=;
	h=Subject:To:Cc:From:Date;
	b=TCPVS4iYSm3l4nmkdsIfDhZ6A1tlaXqyimFJ5wpB0RN/yeeZU7FWH2gLEsRvfG9p0
	 ppPWbw3VM52JyoS3YhGtkA9tFI08uBQ7z1YwSXamQ2EvSzfHuqiPYyRQIHvSqmQNjA
	 VJ2tffLhYdqSh8jSz1kAkk0+hRMLLOCurq0RWOfg=
Subject: FAILED: patch "[PATCH] gpu/buddy: bail out of try_harder when alignment cannot be" failed to apply to 6.12-stable tree
To: Arunpravin.PaneerSelvam@amd.com,christian.koenig@amd.com,john.olender@gmail.com,matthew.auld@intel.com,timur.kristof@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 14:36:17 +0200
Message-ID: <2026072017-endless-bagging-0d2e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 56bc6384314fb9ae98975fb2af8b143097ede3dc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072017-endless-bagging-0d2e@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 56bc6384314fb9ae98975fb2af8b143097ede3dc Mon Sep 17 00:00:00 2001
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Date: Thu, 9 Jul 2026 18:40:50 +0530
Subject: [PATCH] gpu/buddy: bail out of try_harder when alignment cannot be
 honoured
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The try_harder contiguous fallback could return a range whose start
offset did not match the caller's min_block_size. When a candidate's
start is misaligned, realign it: free the misaligned run and reallocate
exactly @size at the next lower min_block_size boundary. This keeps the
returned size unchanged with no surplus to trim, and rejects the request
only when no aligned candidate fits.

v2: align misaligned candidates down to min_block_size instead of
    bailing out, for both the RHS and LHS paths (Matthew).

Fixes: 0a1844bf0b53 ("drm/buddy: Improve contiguous memory allocation")
Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Tested-by: John Olender <john.olender@gmail.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Link: https://patch.msgid.link/20260709131050.1022759-1-Arunpravin.PaneerSelvam@amd.com

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index eb1457376307..b12d3a2ac630 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -1084,22 +1084,30 @@ static int __gpu_buddy_alloc_range(struct gpu_buddy *mm,
 			     blocks, total_allocated_on_err);
 }
 
+static int __alloc_contig_aligned_retry(struct gpu_buddy *mm,
+					u64 unaligned_offset,
+					u64 size,
+					u64 min_block_size,
+					struct list_head *blocks)
+{
+	u64 aligned_offset = round_down(unaligned_offset, min_block_size);
+
+	return __gpu_buddy_alloc_range(mm, aligned_offset, size, NULL, blocks);
+}
+
 static int __alloc_contig_try_harder(struct gpu_buddy *mm,
 				     u64 size,
 				     u64 min_block_size,
 				     struct list_head *blocks)
 {
-	u64 rhs_offset, lhs_offset, lhs_size, filled;
+	u64 rhs_offset, lhs_offset, filled;
 	struct gpu_buddy_block *block;
 	unsigned int tree, order;
-	LIST_HEAD(blocks_lhs);
-	unsigned long pages;
 	u64 modify_size;
 	int err;
 
 	modify_size = rounddown_pow_of_two(size);
-	pages = modify_size >> ilog2(mm->chunk_size);
-	order = fls(pages) - 1;
+	order = ilog2(modify_size) - ilog2(mm->chunk_size);
 	if (order == 0)
 		return -ENOSPC;
 
@@ -1115,31 +1123,48 @@ static int __alloc_contig_try_harder(struct gpu_buddy *mm,
 		while (iter) {
 			block = rbtree_get_free_block(iter);
 
-			/* Allocate blocks traversing RHS */
 			rhs_offset = gpu_buddy_block_offset(block);
+
+			/* Allocate blocks traversing RHS */
 			err =  __gpu_buddy_alloc_range(mm, rhs_offset, size,
 						       &filled, blocks);
-			if (!err || err != -ENOSPC)
+			if (err && err != -ENOSPC)
 				return err;
-
-			lhs_size = max((size - filled), min_block_size);
-			if (!IS_ALIGNED(lhs_size, min_block_size))
-				lhs_size = round_up(lhs_size, min_block_size);
-
-			/* Allocate blocks traversing LHS */
-			lhs_offset = gpu_buddy_block_offset(block) - lhs_size;
-			err =  __gpu_buddy_alloc_range(mm, lhs_offset, lhs_size,
-						       NULL, &blocks_lhs);
-			if (!err) {
-				list_splice(&blocks_lhs, blocks);
+			if (!err && IS_ALIGNED(rhs_offset, min_block_size))
 				return 0;
-			} else if (err != -ENOSPC) {
+			if (!err) {
+				/* Allocate the unaligned RHS offset using round_down */
+				gpu_buddy_free_list_internal(mm, blocks);
+				err = __alloc_contig_aligned_retry(mm, rhs_offset,
+								   size,
+								   min_block_size,
+								   blocks);
+				if (!err)
+					return 0;
+				if (err != -ENOSPC) {
+					gpu_buddy_free_list_internal(mm, blocks);
+					return err;
+				}
+				goto next;
+			}
+
+			if (size - filled > rhs_offset)
+				goto next;
+
+			lhs_offset = rhs_offset - (size - filled);
+
+			/* Allocate the unaligned LHS offset using round_down */
+			gpu_buddy_free_list_internal(mm, blocks);
+			err = __alloc_contig_aligned_retry(mm, lhs_offset, size,
+							   min_block_size, blocks);
+			if (!err)
+				return 0;
+			if (err != -ENOSPC) {
 				gpu_buddy_free_list_internal(mm, blocks);
 				return err;
 			}
-			/* Free blocks for the next iteration */
+next:
 			gpu_buddy_free_list_internal(mm, blocks);
-
 			iter = rb_prev(iter);
 		}
 	}

