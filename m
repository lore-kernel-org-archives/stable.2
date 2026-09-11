Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E713ABD88
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 02:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789092854; cv=none; b=mV0HrgjrzPAMaChg2w2ANoM6L8GGFbb1co9dIZu3OlH5MlGt45/ChVC5RT7fP2HmVGP8tdIA4UaCGFW1gD7RugCaxe3FG98hb/VuSiMY4Q3kCYwbHw63RIxmBBe9Ezkg5xbhDmKANlnf+Kqp/VgLwsnvPsIWpYVIQMewUclFhTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789092854; c=relaxed/simple;
	bh=tSEq//CjDHwYVOFa7uIn6X6EINRCRjVhDiAcPXE0VTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quYiA/cs9MOsRZi8dUbjO7wVAHUfnKQxe0YP70WB9RhTs8n01rvz0Ql7hV94ygpNsautgc5oz13GwPwf30SWJE7MhwPiHRtGGwbRvBjDTpcPbaMalKFcLcDlmdKRndn5go7+4fltotgTmRnTc/4pr34X3EOPa9b6XT0GBhTVr9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpCqE+yA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpCqE+yA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 227831F000FF;
	Fri, 11 Sep 2026 02:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789092853;
	bh=fWsXq71/VIU/zQr4arwr3cp/OMVjbuADlACUDGS81qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LpCqE+yA8jYTJVMxGz+if7GykW/uFwzN7BxzpGwotx+6+Y2ftfHsbBhBtPc9Ydj9S
	 u3WxKKJ+AWgfZA/pT/b2FPAWX03xNaASr4KnKIomSn+iMdZMrIeTmOjEDhbdUlp5J3
	 sN1HaXXjXuyM6vo8hrC9UE+Q8ld4dW4IRax/HZdlrA/iXWiv7Qfw0ZBHoofa22AmAr
	 QzgZLJv7ZtmnBqMWC36FnBKSkSOvTee0JjULv0IKafg3TTVoxRctCaclCGh2MldILi
	 hj1/S3kDW4eXP7ipO9P/5p3nWxVlJVeP18Z+0zQXOsGhJqKZZ1fmibbfmR3CZfJJ1P
	 +jSHyPX5hODKg==
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
Subject: [PATCH 6.12.y] mm/mremap: reset unfaulted VMA page offset for MREMAP_DONTUNMAP
Date: Thu, 10 Sep 2026 22:14:10 -0400
Message-ID: <20260911021410.42929-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090957-prideful-repulsive-38a0@gregkh>
References: <2026090957-prideful-repulsive-38a0@gregkh>
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
index 12af89b4342a7..9685ea816fde1 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -811,8 +811,18 @@ static unsigned long move_vma(struct vm_area_struct *vma,
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

