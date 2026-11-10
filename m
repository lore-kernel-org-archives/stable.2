Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272950;
	b=j6GL15tqwWziNEKDhzjNCp+aiUeKtOgtajvQe7lQjgl/OaJFB4CWXww0B+ZJLP9xuG1P
	 yxhFsGIUjOPj2NwTfkXfesLXTwsCpNR52FUa222MWBN9xlz0h8hbTwy5hreJvD5Y4LH9u
	 lfv260cqDFuByVd/tqbDU8f8Qx5TCnDB/cRYShgQNRr3d1I1L/cvr73HSoNDQxANf0AIa
	 je8wYS/M9VslDUcABtcjJa7k7H15fXcA41wunl3k9BABXvYH1rqV8nHQAe+cO3RmoZyig
	 1XG1GsiThf3cRK9NyNsVKdNATKCLUoqHl/h00i3H8cn46J8Bt69iwMHfp24tGVrhhVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272950;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wFWRiiecKgHUwz7/WpmTBYT6NiqQAp84rqYeZTbKBic=;
	b=F9dWTkDtSv3wjjtjB6eeh7J7u7k8X6PtLHWRIbxfEtY9iopLu+qKaMsAnzRUwDf06LDk
	 T4ktVlHotAiLtCQlb/Yi1mSdS4Ku+s2CHHb/DOJirhVTI+LKGzH8hRYaOAXzSizV4jbdP
	 bC8LzDrkZkhjrZLRXyMAgzuS/M3YCpond23MHQ2Ke6ea8TgIDxmTJBDwo/VpSqkilW3P4
	 vvVA9L0nYOxbdJD3f87sPjC02k49Dqh+ZojYpF4iiMru7I6bcxpvgfI9R9Q/ZvV5mbXli
	 X+1TfwKiWZze06t7XYI/9qjZ9sFQiFCI+Opccs4Pfu7eY3fe9sazNWttLtL+OcL67xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mnWjNRIR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E693606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mnWjNRIR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9AA1F0089F;
	Tue, 10 Nov 2026 01:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272950;
	bh=wFWRiiecKgHUwz7/WpmTBYT6NiqQAp84rqYeZTbKBic=;
	h=From:To:Cc:Subject:Date;
	b=mnWjNRIRIbjFDFolFQaWx3GdAwehqbrv0Upouz5/ytuHHp9On+P9tNkB6i1VcXyX1
	 MJeD7EYBo/TZUlX6QxygtHXjqYRWxLY3etlavw4LrVCJXas7cTkim2yu+zMk4SlJOs
	 p9k01MEeMYfm03Sbt8hgxjLCswyfqVwCNlSQmkwCWLzOQtR7OiIApCRFRVybWT5Jr9
	 Kg5iX9YVvAYDR3VV9nDiAdwFRBukFNmDmZxMPjoNIad+5BbtyIjZ0wqIMtG1Ay2HlN
	 vnv0ad35GuaLPeGBm7uNBY6jBuFTRiZ45MoDO2SQHkiFDlBosTKBZ1skNU81UIhDP9
	 HqAmWOReQbFcw==
From: Sasha Levin <sashal@kernel.org>
To: gourry@gourry.net,
	usama.anjum@arm.com,
	david@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/userfaultfd: compare exact registration modes before skipping" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:09:08 -0500
Message-ID: <20261109200908-failed-6.12-05f64f211a25@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 05f64f211a25f7d9771d4fde109aad97174a1cf3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200908-failed-6.12-05f64f211a25@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




