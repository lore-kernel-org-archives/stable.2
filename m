Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02926547071
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 00:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849903; cv=none; b=NsTbju7kOW5EKZ2UTABocozyk7pYapAtX86ZrEt1f3oN7UUnwSlcS5n8tiBb6Nsbj+7LczIRX3ohDpcoN397HmOi2QwKD3yZ9U9cC2leXYTvHAieQ+BVp5q/e15Tk20tjBKVaavISW+f0v00EnDQSJ5G2X3xpz5Vvk5ecL/0k5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849903; c=relaxed/simple;
	bh=Lrk8EUWQF0GJeJAXuJeaeVclrn9TiHVtzATjmSNYI8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X7itzoY9bk1DnEnhZUJSLT4A4S1Yc5RwSuNEf4S7NS+Ys78HJlai/JLzQj5Rr6X3hu8cbMovx7Rmt/X5zqq2Gi1W9GUboeh/t9Ywd0QTUhx+3uvceqAfmF1AEE/yxKDy/2B+5W44n/93lcSnzPdMtpoevJ5Jyg5BQyh+Cr2GzxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShwipROF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShwipROF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983D01F0089B;
	Tue, 13 Oct 2026 00:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791849901;
	bh=2QNeMEUgNZSXr9VSug9KweY6uJry2s9udC3C2+7mFVY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ShwipROF7oWiFPaacW/CgJE4LiCfbAh9AJ0rVZwnoZwYq/Z0kDypGWXhk2yQWlWMD
	 9m18Ee9IwsIJW0vi8oMBzNtnMO9VY0idxV1IjBMmQWrw9JOFYPbqL0Eojzdi8pndGc
	 RRHBoaG+0f4G1krGvDtSLcZst0OOSezK8ijDZ9IWgtg7TwrX+uUYhO6xuHJgU3Z3Ye
	 UwLPd/uhs9Qmssf9gdVoRiSMPvTjrw8C/f7n9SIkt5iwvl70zC7uQ34bNR3V4NrpcJ
	 YiemG0H8utwnSU0CzSOeDDHqFM+Wg1LHUeMXru9TxXb+vWuWrzXyW0G3k93IRQAGw3
	 jZRJ1E7oCkysA==
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
Subject: [PATCH 5.15.y] mm/mremap: fix locked_vm leak by splitting VMA for MREMAP_DONTUNMAP
Date: Mon, 12 Oct 2026 20:04:59 -0400
Message-ID: <20261013000436.2136151-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101246-scarcity-surely-e659@gregkh>
References: <2026101246-scarcity-surely-e659@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>

[ Upstream commit 597e4b9ab48a3f841080f627722064853d3f650e ]

The MREMAP_DONTUNMAP feature is highly unusual in that it permits mremap()
operations that keep the original VMA in place.

Historically this has led to a lot of bugs where non-obvious interactions
occur between existing mremap() operations and the original VMA.

Fix another of these - partial copies.

The long-standing mremap() partial VMA logic has the baked-in assumption
that the originating VMA is unmapped and thus moved.

However MREMAP_DONTUNMAP defeats this by performing a partial copy
instead since it keeps the source VMA around.

An mremap(..., MREMAP_DONTUNMAP) operation disallows resizing of the VMA,
but the operation can be performed partially:

                           |-----------------|
                           |                 |
                           |                 v
                        <------>          <------>
                        .new_sz.           new_sz
                     |--.------.--|       |------|
                     |  .source.  |       | dest |
                     |--.------.--|       |------|
                     <------------>
                         old_sz

The page tables in the specified range are moved, but the original VMA is
kept intact.

This interacts poorly with mlock()'d VMAs, as the VMA_LOCKED_BIT flag is
cleared for the entire source VMA and set for the entire destination VMA.

This results in an mm->locked_vm leak as the change is therefore not
accounted correctly.

The clear solution here is to make the portion of the source VMA which is
mremap()'d distinct from the rest of it, a.k.a. split it.

Therefore resolve this issue by splitting it ahead of the rest of the
mremap() operation if the VMA is mlock()'d.

This is valid, as the source VMA will lose its VMA_LOCKED_BIT flag, so if a
partial remap it will become distinct from the rest of the VMA.

In order to make this change re-expose split_vma() in vma.h for
CONFIG_MMU (nommu doesn't compile mremap.c and uses a static helper
instead).

Finally, update the sys_map_count check to account for this case.

Note that the early check does not use needs_pre_split() - this is because
the VMA has not been looked up by this point, so be conservative and assume
that the VMA is mlock()'d in this case for the purposes of the
sys_map_count check.

Link: https://lore.kernel.org/20260930-fix-dontunmap-partial-self-merge-v2-2-f388985a0f0a@kernel.org
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
[ sashal: Inlined VMA preparation into move_vma() because the upstream preparation helpers are absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mremap.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 89f198933af4a..f7a5f1106699d 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -578,6 +578,8 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	int split = 0;
 	int err = 0;
 	bool need_rmap_locks;
+	const bool split_before = vma->vm_start != old_addr;
+	const bool split_after = vma->vm_end != old_addr + old_len;
 
 	/*
 	 * We'd prefer to avoid failure later on in do_munmap:
@@ -587,9 +589,9 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		return -ENOMEM;
 
 	if (vma->vm_ops && vma->vm_ops->may_split) {
-		if (vma->vm_start != old_addr)
+		if (split_before)
 			err = vma->vm_ops->may_split(vma, old_addr);
-		if (!err && vma->vm_end != old_addr + old_len)
+		if (!err && split_after)
 			err = vma->vm_ops->may_split(vma, old_addr + old_len);
 		if (err)
 			return err;
@@ -607,6 +609,19 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	if (err)
 		return err;
 
+	/*
+	 * To account mlock()'d pages correctly in the MREMAP_DONTUNMAP
+	 * case perform any split ahead of time for an mlock()'d VMA.
+	 */
+	if ((flags & MREMAP_DONTUNMAP) && (vma->vm_flags & VM_LOCKED)) {
+		if (split_before)
+			err = split_vma(mm, vma, old_addr, 1);
+		if (!err && split_after)
+			err = split_vma(mm, vma, old_addr + old_len, 0);
+		if (err)
+			return err;
+	}
+
 	if (unlikely(flags & MREMAP_DONTUNMAP && vm_flags & VM_ACCOUNT)) {
 		if (security_vm_enough_memory_mm(mm, new_len >> PAGE_SHIFT))
 			return -ENOMEM;
-- 
2.53.0

