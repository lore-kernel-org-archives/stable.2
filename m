Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685F643B4A8
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 10:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123311; cv=none; b=b1FuvLTo6LUMo3EqKYoTySfbWtEsTlbkL3v9Vg40CqunHATKXzQVqqQUpIGrBzq8dzGbrU8WI1rDxfA2oN/SxNaAi0nlGVqHjBKCrJ33JeG0B2hufJDgREpaqLGqAZ5gSY1yErQAjLMFn6s/f2Oxc7RgqGxbaCU86DFz5R3BG2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123311; c=relaxed/simple;
	bh=lgcimzI3plNw2kfPxsjbAv30R6tZzAAW71Yn+hzzFoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7WmfyPFcfEJKGgaSfqNipixS4zIAdCBLqOU174CvQz7wkv2cFltB75EOvvojzSSyweHlhi/hO1JFKUxnwQWRh0clpl8EvRFuugcyccMV8JZBFlZNb+0Y+VD5bekVSCD2pMrDp2wsm2mCxMj4XKP26bo38gs/ZqKuvdWjW76ilQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wf6MQ2Cz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wf6MQ2Cz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046181F00899;
	Fri, 11 Sep 2026 10:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789123310;
	bh=HaaNPz88uxuqlMl3vaRrtMRjnQEPL90SG4/BPw1Z2yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wf6MQ2CzbGe5QwvwOpF6qhZECEJx2DbVgx9nKSYlh380eJZaRmFDIWOsB4qFbTJau
	 oOySgZcaNrHLMeqxIWLU8hy2MF9GvfO3vee/oxBcnOjFw40clcMBB5Nc7lM7NQlrpS
	 SdZOluyEDQqhu133PI2haoYG8HDrhso1EV0Wu0GI/mHUvDlvjCBV0Litp36VtBLZW6
	 Z1fxV0Bd++UTzB3IcSK+DF4uYfJdCa4q4+e0vIpz/Re4hBiMrGnk8SyWFT9JloT5gx
	 nXslPfLykHesM+HosSWH9Ps0hi9b8YGbVzSge2sxPITBreUCLKOiz6Xbu8xHfjAkVT
	 8ptXW0EgcoHPA==
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
Subject: [PATCH 6.1.y] mm/mremap: reset unfaulted VMA page offset for MREMAP_DONTUNMAP
Date: Fri, 11 Sep 2026 06:41:47 -0400
Message-ID: <20260911104147.197495-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090958-velcro-gorgeous-9f6f@gregkh>
References: <2026090958-velcro-gorgeous-9f6f@gregkh>
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
index 6ed28eeae5a84..7e39614d2e0e6 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -693,8 +693,18 @@ static unsigned long move_vma(struct vm_area_struct *vma,
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

