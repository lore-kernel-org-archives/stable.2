Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC643F1048;
	Fri, 28 Aug 2026 11:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787916055; cv=none; b=ACWSC1OfmhemYHoKiuHgmOqEswX4K+F+XcO81TwRQfetdB/xuZ3NCRW1PImw4ZiK0xiWV2/8aUb+DAHapLDlSafUkv8NESYMZ/aswy19Xu6/lFgF71BYJJz8DdTGYbREVBXNjgPjRZ0bSQoUO7m4QaTOOFf11NjU/CCw+r48CeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787916055; c=relaxed/simple;
	bh=MPZihmBDJp3NmShFBO9v65wDHg8y158TzBgEEqykUB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sCF2Dgyz4a0uYX96jrf2N0NcJNceDtl4/OhkrQ4ufBZ/zBFcAIPHlQgcCnUZkdlZ8I1Uj1/o4mC/AsKT8+U1RFsLGj99oAL0BbODsgIp0Sx6scdstyUjpSjIV7E6iadlwPNNx+H9N/VG4BVZbqQt9z883Kbgy7EwPcW6Li5nKOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxZKMQwU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxZKMQwU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE2AC1F000E9;
	Fri, 28 Aug 2026 11:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787916054;
	bh=/pc6re8PSjo9zjwKnd2Zf7CA9PyDezj2GQ4G0IaICR4=;
	h=From:Date:Subject:To:Cc;
	b=oxZKMQwUK484geEAy0aRc/4rxzyuz1n99jKBDpSjxzvpmmMVllFFQjHFwzBiCd5di
	 U4oS4gipBZEoqN5loE3X2wthQFOvzlrWGoySsd60wzig4xcNhTfAHNqIjqkhBHWgOK
	 8w4mW9sQOkR5v9D01d4HOqHpXl48fDwt+tsbh9lepHIwFpCYXcukQQdnWyP1zMqAG/
	 z6iIiY7sSOWCz+ruPEkNhFwqs4k0t8HNQcIqAfqtdvj268U7XZSspPoZ0U2GCoSdQn
	 qR4YLb5oVjOIxgPTQ/6qho0o13PXwNuNnJuV3+ud5ty5xXtThV8BS2CG4mTa3apBZc
	 EG/zhX/VXGG+g==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 28 Aug 2026 12:20:37 +0100
Subject: [PATCH] mm/mremap: account mm->locked_vm correctly for
 MREMAP_DONTUNMAP
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-mremap-fix-locked-vm-v1-1-c80be7505d1e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7biElwvpKdDBbaylLFCQQ/550H
 JiZDJECU4SpyRAoceTnriDaBsyh752Qt8ogOzl0Sip0gZz2aPnF6zEnbZgcrmochbWmF0pATX2
 gKvzbeSnlA71oK+RmAAAA
X-Change-ID: 20260828-mremap-fix-locked-vm-b8991ffc4181
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 sashiko-bot <sashiko-bot@kernel.org>, Kunwu Chan <kunwu.chan@gmail.com>, 
 stable@vger.kernel.org, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2839; i=ljs@kernel.org;
 h=from:subject:message-id; bh=MPZihmBDJp3NmShFBO9v65wDHg8y158TzBgEEqykUB0=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLIm5gucmiU3z/fgPv3a9oQrPHM/dDz+ftbxgGd5rvlkx
 sC0ZxpcHaUsDGJcDLJiiizPv4jvDxIJm9d5wd8NZg4rE8gQBi5OAZhIvjEjw6VjDzZvPmMzYbex
 LpPXD67JCp9a18z9VN7Rpfegbeq2Q1MZ/qfwvDAKmOvmuuultKL0rpN3379PTTwY/Vv5cdOKsFY
 jMR4A
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

When a VMA is mremap()'d with MREMAP_DONTUNMAP set, that results in the VMA
being copied, but the source VMA not being unmapped.

If the VMA is mlock()'d this is a legal operation, though the source VMA
has its VMA_LOCKED_BIT cleared.

However this is done in dontunmap_complete(), after mm->locked_vm was
incremented via vrm_stat_account(), resulting in double-counting.

Worse, this is not even corrected when source VMA is unmapped, due to
the VMA_LOCKED_BIT flag having been cleared.

This all works fine in the usual mremap() case (without MREMAP_DONTUNMAP),
as the source VMA is unmapped with VMA_LOCKED_BIT intact, at which time
mm->locked_vm is decremented accordingly.

Resolve the issue by invoking vrm_stat_account() only after
dontunmap_complete() has run.

Note that MREMAP_DONTUNMAP requires old_len == new_len, so no need to
account for a delta in size in this case.

The bug was introduced by commit b714ccb02a76 ("mm/mremap: complete
refactor of move_vma()") which incorrectly reordered the accounting and the
clearing of the VMA_LOCKED_BIT flag.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260825-fix-mremap-dontunmap-pgoff-v1-1-39a40b2c98b3@kernel.org
Reported-by: Kunwu Chan <kunwu.chan@gmail.com>
Closes: https://lore.kernel.org/all/20260828094823.594279-1-kunwu.chan@linux.dev/
Fixes: b714ccb02a76 ("mm/mremap: complete refactor of move_vma()")
Cc: stable@vger.kernel.org
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/mremap.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 2b4b523a86b8..7c368440fafe 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1355,12 +1355,11 @@ static void dontunmap_complete(struct vma_remap_struct *vrm,
 		if (vma_is_anonymous(vma) && !vma->vm_file)
 			vma_set_pgoff(vma, pgoff_unfaulted);
 	}
-
-	/* Because we won't unmap we don't need to touch locked_vm. */
 }
 
 static unsigned long move_vma(struct vma_remap_struct *vrm)
 {
+	const bool is_dontunmap = vrm->flags & MREMAP_DONTUNMAP;
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *new_vma;
 	unsigned long hiwater_vm;
@@ -1401,10 +1400,10 @@ static unsigned long move_vma(struct vma_remap_struct *vrm)
 	 */
 	hiwater_vm = mm->hiwater_vm;
 
-	vrm_stat_account(vrm, vrm->new_len);
-	if (unlikely(!err && (vrm->flags & MREMAP_DONTUNMAP)))
+	if (unlikely(is_dontunmap && !err))
 		dontunmap_complete(vrm, new_vma);
-	else
+	vrm_stat_account(vrm, vrm->new_len);
+	if (!is_dontunmap || err)
 		unmap_source_vma(vrm);
 
 	mm->hiwater_vm = hiwater_vm;

---
base-commit: aeddb4d52acfcc5ce5e988acd48f2906fe966ca3
change-id: 20260828-mremap-fix-locked-vm-b8991ffc4181

Best regards,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

