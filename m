Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273810;
	b=bsRwQY8aWqancJhiWu9FATAo7oQiMUNJuH0t65dmblj4oJ+SeKh+ZV+KPAnbJ1HL8P6i
	 bjWSEyzgPkTvy9ebc/SBKQBOeSi8R+gdgS+eeHnDget2E9k52o7JkT89cRvu7HgpUxxIO
	 1s+fvRJ9cXEcKbD9IPLA0/r2rhAZeqqNNkbpPB8ixX2nrn8kvF6pPuy2YVGJ+xmviq+qD
	 XW6M0G7Ce6ngqmAQISBHyRx/j6DH5DUb8N6m82ISuPGz6i9EP8oqmG2UpQGuTlIzshfjy
	 sh2grN0Q8EjI/jnioiZfiJ+4MSE0TzoKeApMYE2qVN1YXFaP1xgVBJ9GU3oOg5BK1pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273810;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PFWlr2YT0CCqa5p9cFwJPuhzzEJL3F9AWmy0RN9AV58=;
	b=KzXd9xOdlR4d8J+Mwy1cAlexLoRPtyROyX5yWjWAq1LuwIGF1fOHAZsPMHyH/5/TXYLk
	 czahI1e4GxNyV5q0SqfLR0AT8/dtSLvLqlsu3bzWjjVBTxJuKr2KsWxAKY28joOwHZ2u7
	 CY+O5KzFg/EGEvTgPpz6uUV/lntjyS+clmRddiGH4fMceF6J3imw0P2SiHnSIxpYzwwgU
	 C+A2jxTNc0/rWk3TDo3L/xfLq4MglLSUSZyM3IA0wOulfYJjVXSmFxPGujsN/aTxm7q0Z
	 xLSnotgPDX8jX2GO36zhhD1TPA44w2pwC9k0LqcypSsjG/vgA/lMNMtNmVuAJrrjH4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AoSBeAcN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FCB6071876
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AoSBeAcN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18FD1F008A1;
	Tue, 10 Nov 2026 01:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273810;
	bh=PFWlr2YT0CCqa5p9cFwJPuhzzEJL3F9AWmy0RN9AV58=;
	h=From:To:Cc:Subject:Date;
	b=AoSBeAcNI9wH+PZ3PhxtJ/K13351BQ5OvsPHK2EEwh6V+SUik0xkJHxrBLttgoSgP
	 SFtm5v6Vw6+2ssQRlg96nmkgCr50f0RZsRZM23IoWLOpPy0nyun+FWVSPRzj9QCvT4
	 5lU4/13S7ly/hW2Xzy7Jue94RWWf69gpvnJUaCPL72+sMx/wdFh7JhDAAp6CKhXUqd
	 GnlrYoLxs12klXl3XC2eZYetuOv0bhbzgJrGuTNhr5KYmNiwO7b8HP5zGu92qASGoX
	 33W4akO5EjtZIQofPyRee9FReoz0/J7rEI8+5CAWLWYt8LG5VsJ/EDFgZZAbBzKtUS
	 B2gS94XLOPScw==
From: Sasha Levin <sashal@kernel.org>
To: gourry@gourry.net,
	usama.anjum@arm.com,
	david@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/userfaultfd: compare exact registration modes before skipping" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:23:28 -0500
Message-ID: <20261109202328-failed-5.15-05f64f211a25@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 05f64f211a25f7d9771d4fde109aad97174a1cf3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202328-failed-5.15-05f64f211a25@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 05f64f211a25f7d9771d4fde109aad97174a1cf3 Mon Sep 17 00:00:00 2001
From: Gregory Price <gourry@gourry.net>
Date: Sat, 31 Oct 2026 10:39:55 +0100
Subject: [PATCH] mm/userfaultfd: compare exact registration modes before
 skipping

Changing registration from MISSING|WP to WP returns success but leaves
MISSING enabled. The no-op check sees that WP is already set and skips
the update, so later accesses to missing pages still wait for userspace.

Skip the update only when the current and requested UFFD modes match
exactly.

Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
[ david: apply fixup from Lorenzo ]
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-26-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/userfaultfd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 03f1b15bfe63e..dac696bda19f0 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2291,6 +2291,7 @@ static int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 
 	for_each_vma_range(vmi, vma, end) {
 		const bool any_mode_removed = vma->vm_flags & __VM_UFFD_FLAGS & ~vm_flags;
+		const vma_flags_t curr_vma_flags = vma_flags_and_mask(&vma->flags, __VMA_UFFD_FLAGS);
 
 		cond_resched();
 
@@ -2304,7 +2305,7 @@ static int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 		 * userfaultfd and with the right tracking mode too.
 		 */
 		if (vma->vm_userfaultfd_ctx.ctx == ctx &&
-		    vma_test_all_mask(vma, vma_flags))
+		    vma_flags_same_pair(&curr_vma_flags, &vma_flags))
 			goto skip;
 
 		/*
-- 
2.53.0




