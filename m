Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2152218DF80
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089841; cv=none; b=u9HYRQYFTmP1UZznM53PIZaf12SqA9odSQEy4+2yN2zTJbLO5w9RrqFQIdUmsEAk0zoawF+4GzlF6/QtvUcTYzSO79l32Alvrtmpzy0ekcex6cFhmNjQngW68CIoGngR0KUoOsyBmc5i0Ct5XB9sJwL2dwAx8/yuZ5RuzfgfQD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089841; c=relaxed/simple;
	bh=nB/1IqsVFVbB2QEzd5meyJZfW3sVRn5zzrSZ0TEre/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3MxK6K/yCJb4Y3dE0MSU0Wpk1/nRQWTQVEsQ4Bij86WYx0sMMwjtzPZFNwys5YnqLXJQIZKsElbE6JuAHGW3853h/j9q92HyKPqn7kaRkWhTUhIjO4bq6vppkwfOlHsaE+Fndjm2HrBtPc/jofZwXxOtkyVPVqk0DD/NEr94sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4cYnUpH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4cYnUpH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9542E1F000FF;
	Fri, 11 Sep 2026 01:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089839;
	bh=7SL4psANQ2/c9rv1QrgK1uGG/ZX61DfOSjzECK6V1UE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c4cYnUpHoSl6xGn+ZhWdezLn3ZRMk0n4Dz3V6yuV4h1pkIi5Ih4TUvft5X4yIwrpt
	 mcot62lm0Y0oh5Fdaa74Ita/MbHKyxCJd7ta4RXWApocE+ztsGO+iH/rTaQc6Qhej+
	 KKp0mlAOF0gUzlXHZzCH4g5G7TR3trxy+fiGRjmNtsGT2DE+I4j88d4dghEo98eL81
	 T7KH+Tsqf9OtGaZpES3zOxx60bVmJ0/zRG7Dmqa4nkcyV/1rBe18A48pcN68XzyuDO
	 ln1WXOYqCLUR+dOfJuWEjfbadFIFx+Kf59FzavlZ8coMXmnXl1EvORgU/h0fX8hgz/
	 WQ3pFVOw7nkUA==
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
Subject: [PATCH 6.18.y] mm/mremap: reset unfaulted VMA page offset for MREMAP_DONTUNMAP
Date: Thu, 10 Sep 2026 21:23:56 -0400
Message-ID: <20260911012356.4072187-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090956-species-gyration-6377@gregkh>
References: <2026090956-species-gyration-6377@gregkh>
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
index 419a0ea0a8708..bdf63ffaad3d5 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1247,18 +1247,29 @@ static void dontunmap_complete(struct vma_remap_struct *vrm,
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

