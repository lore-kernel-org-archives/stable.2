Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B0631ED8B
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089470; cv=none; b=dnAVgs8C5FmER/eRB26+5kFQK6MUgz4yCc7f3cjDvRAUd9870CyU5ON1ci5yxHNC2H9Mr1I5IWSf5Nwud02Gtr7hKsapXyGzxD2hXH5FfEIDj9dWjFcFIzGF+8Gj8zvMV3CgoRJHlQFPGJlOQF+dtoQOVDrvWswG6j0YdjdpgaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089470; c=relaxed/simple;
	bh=UbQIDZpyrm0o32t9++GZ+nVrn0JWsanA7sErV169OO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PdCGKKK8IxHTDGt4y+FWVBW2HtzKVytMH8R0QgdKBoolJjJiaAu16iuUqGBgyYlbcvPQPjOqRqPePfQpXrGV0mDU7aN0twomArrSQfn4AUWaXhF/WnX+KgspGBsUfKpoAVXtmunczO4tM+Ar9SUQ40xjAG7xv5KXualpnhEIYko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktOlYY7e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktOlYY7e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DB01F000FF;
	Fri, 11 Sep 2026 01:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089469;
	bh=qH9b9xontdu/sJ363vnYY7GerFVKnkhDsUhuuJqXB8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ktOlYY7epQwn790LYjgHiKxXXcQfXpGZMIA/ENL00gWmG4ydPp3u3GiXmiOPLzIcv
	 pOXht896hvHinnaPnlvzAUgDu8XeDXQ4Shr6SBgJwBLG1gQcRzMiZl6SFGn6kcR63C
	 UMO5ETo8c64E3azgVTuUKPYWOTVqgAr82do0aimOR3YYfSS+OZ/h91yNUtycyfoBBd
	 6qcMGvsCFabzv0xSqqORJGeqSiuk6qoex++8T20kfTTELaWkU/XQHwwQMsRF8+N8rg
	 Iu2GastJJbiSUS7Rlrx/rfH7f4Ys1px5rO4TBqRR+4Kjyqm000KwMraexGYt5N46gT
	 P6prDAjl5HXcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	syzbot+f12658786a4153df5113@syzkaller.appspotmail.com,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Jann Horn <jannh@google.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Li Xinhai <lixinhai.lxh@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y] mm/mremap: reset unfaulted VMA page offset for MREMAP_DONTUNMAP
Date: Thu, 10 Sep 2026 21:17:46 -0400
Message-ID: <20260911011746.4048905-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090956-sampling-underpay-4fb9@gregkh>
References: <2026090956-sampling-underpay-4fb9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>

[ Upstream commit 35b0fb391b0df57383bc15985bb769f4555c97ba ]

Uniquely an mremap() invocation using the MREMAP_DONTUNMAP flag can reset
a faulted VMA into an unfaulted one.

It does so after the page tables have been moved to the copied VMA with
MREMAP_DONTUNMAP leaving the old VMA in place which is naturally unfaulted
as the page tables it had are no longer present.

However, in doing so, it violates the invariant that the anonymous page
offset of an unfaulted VMA is vma->vm_start >> PAGE_SHIFT.

This is because a VMA may have been faulted in, mremap()'d (causing a
delta between its page offset and vma->vm_start >> PAGE_SHIFT), and then
mremap()'d again with MREMAP_DONTUNMAP resulting in the unfaulting.

This condition is a violation of a fundamental assumption in mm, but now
also triggers an assert in assert_sane_pgoff() which explicitly checks for
this condition.

Correct it by resetting the VMA's page offset at the point of completing
the MREMAP_DONTUNMAP operation.

Link: https://lore.kernel.org/20260825-fix-mremap-dontunmap-pgoff-v1-1-39a40b2c98b3@kernel.org
Fixes: 1583aa278f5f ("mm: mremap: unlink anon_vmas when mremap with MREMAP_DONTUNMAP success")
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reported-by: syzbot+f12658786a4153df5113@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a87853b.ae6ddae5.3da009.0023.GAE@google.com/
Tested-by: syzbot+f12658786a4153df5113@syzkaller.appspotmail.com
Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Cc: Jann Horn <jannh@google.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Li Xinhai <lixinhai.lxh@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ adapted VMA page-offset helpers to use the branch’s single vm_pgoff field. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mremap.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index e9c8b1d05832b..a7bd785e603f3 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1321,18 +1321,29 @@ static void dontunmap_complete(struct vma_remap_struct *vrm,
 {
 	unsigned long start = vrm->addr;
 	unsigned long end = vrm->addr + vrm->old_len;
-	unsigned long old_start = vrm->vma->vm_start;
-	unsigned long old_end = vrm->vma->vm_end;
+	struct vm_area_struct *vma = vrm->vma;
+	unsigned long old_start = vma->vm_start;
+	unsigned long old_end = vma->vm_end;
 
 	/* We always clear VM_LOCKED[ONFAULT] on the old VMA. */
-	vm_flags_clear(vrm->vma, VM_LOCKED_MASK);
+	vm_flags_clear(vma, VM_LOCKED_MASK);
 
 	/*
 	 * anon_vma links of the old vma is no longer needed after its page
 	 * table has been moved.
 	 */
-	if (new_vma != vrm->vma && start == old_start && end == old_end)
-		unlink_anon_vmas(vrm->vma);
+	if (new_vma != vma && start == old_start && end == old_end) {
+		const pgoff_t pgoff_unfaulted = vma->vm_start >> PAGE_SHIFT;
+
+		unlink_anon_vmas(vma);
+		/*
+		 * The VMA is now unfaulted and it is an invariant that
+		 * unfaulted anonymous VMAs have page offset equal to
+		 * vma->vm_start >> PAGE_SHIFT.
+		 */
+		if (vma_is_anonymous(vma) && !vma->vm_file)
+			vma->vm_pgoff = pgoff_unfaulted;
+	}
 
 	/* Because we won't unmap we don't need to touch locked_vm. */
 }
-- 
2.53.0

