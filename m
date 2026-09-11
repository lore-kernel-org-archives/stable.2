Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9DF442135
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123897; cv=none; b=rkuBI2N3LSIiTDs9UvuxuZW0OsnShxKecm2NrKMPp2YHpTI8ifqwkphPB3E1+sK5QUv6rCZh6TJz8z+vPz1HeGmCgatIALIdm2g8pRcFgN5U6+o56a0CC5NF2scDjN6zhkoNU6iiGu0J3+WPNzDtq7ZU7XT/BVDwY4Fhdgg/dkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123897; c=relaxed/simple;
	bh=o73SFsdIo9lOOMsbQfcxmGYMPn/VvBlb73xTArJzZLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DCpg/95IG3Jd0ISYtse2Q1SRAwvE64NUwSF6mrTlzVdvgJylzq0LKWZbxB9HG8KppD4huN8rV9dH6eK/ZhWSISEySgiBm4Z1opIHtLqyDprnJwNBbwxXEBkCTZGllGWuesVHyV3uenC4t4jA/h6GyySGliJMioKiZbMdVHRMJfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5jrGIoc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5jrGIoc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE13A1F000FF;
	Fri, 11 Sep 2026 10:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123896;
	bh=YAwX4VgTaTcUkn+9b7wYnYZ+0yudNyoz+bMybzHTmV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G5jrGIocKwAqMc4K1NMjeAFmS3RoYFw0exEiv5CkuXtEkABqSeN9fVKUI07XNDI3Z
	 tvFPxosCtVLObu2FI7yL5qlDhyl5odi4atOo5fRnUZHndJHO2pI8QSBSqyZC+NYUD/
	 o8rCxTc57VeKZmu7JiBi/CZiAUMxmGWe0jgY/OrLuKFx/O5VWwRm+FazxB8uJVaIKc
	 MUBcO/hI940/1e4QSebstqXSMjAOETRKdB9COEiSnqDYXMXcdWkAlJZXvZeEr0dZ/0
	 wdEQlQ8WqjyRNuwEUA7YNaKTeNnlExP3KfBEnjtyj9gACNsmLrLy2GWuDCnAYMIkZu
	 W2tx7I34x6upA==
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
Subject: [PATCH 5.15.y] mm/mremap: reset unfaulted VMA page offset for MREMAP_DONTUNMAP
Date: Fri, 11 Sep 2026 06:51:33 -0400
Message-ID: <20260911105133.272946-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090958-bonelike-alkaline-4d33@gregkh>
References: <2026090958-bonelike-alkaline-4d33@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
[ adapted dontunmap_complete() changes to move_vma() using direct vm_pgoff assignment instead of unavailable helpers. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mremap.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 3a3cf4cc2c632..89f198933af4a 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -679,8 +679,18 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 		 * table has been moved.
 		 */
 		if (new_vma != vma && vma->vm_start == old_addr &&
-			vma->vm_end == (old_addr + old_len))
+			vma->vm_end == (old_addr + old_len)) {
+			const pgoff_t pgoff_unfaulted = vma->vm_start >> PAGE_SHIFT;
+
 			unlink_anon_vmas(vma);
+			/*
+			 * The VMA is now unfaulted and it is an invariant that
+			 * unfaulted anonymous VMAs have page offset equal to
+			 * vma->vm_start >> PAGE_SHIFT.
+			 */
+			if (vma_is_anonymous(vma) && !vma->vm_file)
+				vma->vm_pgoff = pgoff_unfaulted;
+		}
 
 		/* Because we won't unmap we don't need to touch locked_vm */
 		return new_addr;
-- 
2.53.0

