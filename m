Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA6F4F93A9
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 21:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791840893; cv=none; b=TL7cm+038G+8xRR0Ie+HqQ34pRnNgDmMBUO1UJ2MSHNa76zkTEBYj+QEPsInpwOKrfNM7X4pERK1YGKLHPw5cQWupsv7lEE95hSs2ZWUFinJZQJeePnCF2y82kM9Jt1wkv9/WD/0RI59XCuU42LLLe4BdRuCCooQVqv83oL8QCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791840893; c=relaxed/simple;
	bh=TWDazYCIbng2AlZ1SIGL1DGE3MAmEH+Lvfyvgc5L+hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n+f7SojwJDW43icvRuP0vJCOH2kvT9/WOCk5pBFQ+OzYtW6HxwH/m0v7hyPofoaAv5K10FYKxvMGjl1Srazub6dBKpU7BHSi+Sob6NGlNJwcmNAG+nbWwNFokYfSlYsbvHl3b3suloeaQcu7DkoLFSOSRJFPlCarRdcy7emZ61k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ifadIbFI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ifadIbFI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5C41F0089B;
	Mon, 12 Oct 2026 21:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791840892;
	bh=3oBeSk2VOmjc5Z5VzUOQlsZZgjMQfExGXCzNP/vr7nU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ifadIbFIy/7QcfJoxb89KfnL97U6hjE8WYQUAsQO33E5nC9b6aULI4TmHwE4J2qrP
	 9h0aeEKNMHnSqwPzl5M9Glb5z4vddpfgIe1/RegYfeXRO9yVMB9ZmJgoi+S0vtsiHt
	 jEk2Snc4vyt0oOBT1jIAhzQIW+aqAJ3qZ9Nq7OO1FS8sEjRo9maZh0t5FcHcLfCjIF
	 wPBot/yUqaE2cIitMdr1hHIM9JiyzZzDjGL+7rWiOrk0B1lqPzi7TaVjjaC6WxQJWm
	 N/w09HXa/y4N/PBg97eLM3sqA5XW0t9lnr/5GR/EqXYrhDejLfPqqJRGjjeiLsv108
	 +IFvz/mrhB+ww==
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
Subject: [PATCH 6.6.y] mm/mremap: fix locked_vm leak by splitting VMA for MREMAP_DONTUNMAP
Date: Mon, 12 Oct 2026 17:34:49 -0400
Message-ID: <20261012213358.1595351-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101244-salon-hunger-c0f7@gregkh>
References: <2026101244-salon-hunger-c0f7@gregkh>
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
[ sashal: Moved split preparation from prep_move_vma() into the existing move_vma() implementation. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mremap.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index d35f603c9738e..db18cacb795b5 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -605,6 +605,8 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	int err = 0;
 	bool need_rmap_locks;
 	struct vma_iterator vmi;
+	const bool split_before = vma->vm_start != old_addr;
+	const bool split_after = vma->vm_end != old_addr + old_len;
 
 	/*
 	 * We'd prefer to avoid failure later on in do_munmap:
@@ -617,9 +619,9 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		to_account = new_len;
 
 	if (vma->vm_ops && vma->vm_ops->may_split) {
-		if (vma->vm_start != old_addr)
+		if (split_before)
 			err = vma->vm_ops->may_split(vma, old_addr);
-		if (!err && vma->vm_end != old_addr + old_len)
+		if (!err && split_after)
 			err = vma->vm_ops->may_split(vma, old_addr + old_len);
 		if (err)
 			return err;
@@ -637,6 +639,21 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	if (err)
 		return err;
 
+	/*
+	 * To account mlock()'d pages correctly in the MREMAP_DONTUNMAP
+	 * case perform any split ahead of time for an mlock()'d VMA.
+	 */
+	if ((flags & MREMAP_DONTUNMAP) && (vma->vm_flags & VM_LOCKED)) {
+		vma_iter_init(&vmi, mm, old_addr);
+
+		if (split_before)
+			err = split_vma(&vmi, vma, old_addr, 1);
+		if (!err && split_after)
+			err = split_vma(&vmi, vma, old_addr + old_len, 0);
+		if (err)
+			return err;
+	}
+
 	if (vm_flags & VM_ACCOUNT) {
 		if (security_vm_enough_memory_mm(mm, to_account >> PAGE_SHIFT))
 			return -ENOMEM;
-- 
2.53.0

