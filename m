Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDA236B910;
	Tue, 25 Aug 2026 07:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787644537; cv=none; b=LJ/dgzT5IwbmORkiwPSoe0Qwvulohmr2/P++pOBT2fg2QiFHeCa/f6quXB862ARlknHnGcA/MBpS+h3CBP+wRuwysTFZ1TasHmf+Cq1wnRL3PqQvZWEMRDqSYepnzYIJG3vwnRQ9U68Y7IVvf85NK5NPudoyCBs/KKmMvlDi124=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787644537; c=relaxed/simple;
	bh=XAjv6WtrWWzCB6YeREY2fuaNyp9p5PNb3fFaAqJ2NVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AxGWvqgOLroK6I2J6JtNa6AICmkqNaadvYCm8i1pIZK48UxCA2sPmVp/h2LOYVDPT25/BirXmqmJM5J86b87CmCXRraFw1zHZm44oiZchfJw8VhLHVsS7TXewUT9y0w/qc80l3KRO48CsR2iUK4Yx+aWQQD7hNbM0GK1c7JjE0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhUM9DpS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhUM9DpS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914011F000E9;
	Tue, 25 Aug 2026 07:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787644536;
	bh=yhrTrxCBc00NwW0qUXfxz5rqpATbkL+cccg5ndk3DOA=;
	h=From:Date:Subject:To:Cc;
	b=HhUM9DpSj6ZkEzU5cwmyQ5RXsssO8cVqBAGv/VeXMmcTHyAmHUQ24pCgP047DjJj4
	 gqrhNq8/Ae0JRp1nr3gBVa4XYJ61+ecUvkD0X6UgoBN545Jrefi6UUO1aaS0ks9nme
	 yubv4nfOBEajsfM0NOTO+PTAYZxSo2Pf3AghAxB7M1ZWzdvQtBZoxSNDHeYFrof+YK
	 UM26+ThGmkiZoLtGpRs9C8PX/GlWMYokZKCMpGoxqGOJbXeDl+xOQCQ2XXZGL7AhIl
	 GU2u8mi9/Uownq0zkEkesRzPWs6rL4Cw6L0m6Jsjc6LXze5TAQRe7feGLjrrm/IGB7
	 Olw+zNie+1D1A==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 25 Aug 2026 08:55:26 +0100
Subject: [PATCH] mm/mremap: reset unfaulted VMA page offset for
 MREMAP_DONTUNMAP
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-fix-mremap-dontunmap-pgoff-v1-1-39a40b2c98b3@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MywqAIBAAfyX23EJZ2eNXooPUantIRSuC6N+zb
 jMwzA2RAlOEIbsh0MmRnU1S5hnMq7KGkJfkIAohi07UqPnCLdCmPC7O7of9yBunNSrZtWVVU98
 3BGngA6X6n4/T87xdfPTObAAAAA==
X-Change-ID: 20260824-fix-mremap-dontunmap-pgoff-a687134e995e
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 Li Xinhai <lixinhai.lxh@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 syzbot+f12658786a4153df5113@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2999; i=ljs@kernel.org;
 h=from:subject:message-id; bh=XAjv6WtrWWzCB6YeREY2fuaNyp9p5PNb3fFaAqJ2NVM=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLJ6vYo2Ht5/Yt8eMwWhH+nyQiprNOdO7+4+YKIsNa96W
 sCs2ae/dZSyMIhxMciKKbI8/yK+P0gkbF7nBX83mDmsTCBDGLg4BWAidk8ZGbo3rwxj9fv0f/UE
 kdbLE1ecNl36+2B/2MvF9T8LtdZp585nZLh+mvPfTjfvv0JR/x7psqi2edybGCHLduiAtEJxvcN
 2PQ4A
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

Uniquely an mremap() invocation using the MREMAP_DONTUNMAP flag can reset
a faulted VMA into an unfaulted one.

It does so after the page tables have been moved to the copied VMA with
MREMAP_DONTUNMAP leaving the old VMA in place which is naturally unfaulted
as the page tables it had are no longer present.

However, in doing so, it violates the invariant that the anonymous page
offset of an unfaulted VMA is vma->vm_start >> PAGE_SHIFT.

This is because a VMA may have been faulted in, mremap()'d (causing a delta
between its page offset and vma->vm_start >> PAGE_SHIFT), and then
mremap()'d again with MREMAP_DONTUNMAP resulting in the unfaulting.

This condition is a violation of a fundamental assumption in mm, but now
also triggers an assert in assert_sane_pgoff() which explicitly checks for
this condition.

Correct it by resetting the VMA's page offset at the point of completing
the MREMAP_DONTUNMAP operation.

Reported-by: syzbot+f12658786a4153df5113@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a87853b.ae6ddae5.3da009.0023.GAE@google.com/
Fixes: 1583aa278f5f ("mm: mremap: unlink anon_vmas when mremap with MREMAP_DONTUNMAP success")
Cc: stable@vger.kernel.org
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/mremap.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index e8df5cdb0ac9..2b4b523a86b8 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1331,18 +1331,30 @@ static void dontunmap_complete(struct vma_remap_struct *vrm,
 {
 	unsigned long start = vrm->addr;
 	unsigned long end = vrm->addr + vrm->old_len;
-	unsigned long old_start = vrm->vma->vm_start;
-	unsigned long old_end = vrm->vma->vm_end;
+	struct vm_area_struct *vma = vrm->vma;
+	unsigned long old_start = vma->vm_start;
+	unsigned long old_end = vma->vm_end;
 
 	/* We always clear VMA_LOCKED[ONFAULT]_BIT on the old VMA. */
-	vma_clear_flags_mask(vrm->vma, VMA_LOCKED_MASK);
+	vma_clear_flags_mask(vma, VMA_LOCKED_MASK);
 
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
+		vma_set_anon_pgoff(vma, pgoff_unfaulted);
+		if (vma_is_anonymous(vma) && !vma->vm_file)
+			vma_set_pgoff(vma, pgoff_unfaulted);
+	}
 
 	/* Because we won't unmap we don't need to touch locked_vm. */
 }

---
base-commit: efecab401cb15fd3bb9bc05990609acb6b267ff2
change-id: 20260824-fix-mremap-dontunmap-pgoff-a687134e995e

Best regards,
-- 
Lorenzo Stoakes (ARM) <ljs@kernel.org>

