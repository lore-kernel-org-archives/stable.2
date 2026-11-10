Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272516;
	b=F/61kI7//DA8jnzT8u2qcIa12ClPiwj1RAoDXa0/6/GjFvV1iuSawhk04rTQz29XJdPW
	 VROS7lm9ZVba8sMh7VtVCg4M2x7iLLyL28h5RulkffeMxWDzhDdUNbxXcSSfBE/TU4Xcu
	 W7TuQTntnorSgRx23LTYHBBY4ABEDwBhKRWKZcKs5UXu2kZxVTFvElhXsUEmRn8TwIAFx
	 BWzEito5u+pLTx4VSR94f2WezGu/Bt/k5HjHrSrU6YUQBbxwUdLovoZWBC1HT2sMcGoLO
	 WQKq4dEjuP642vi7aR3grhWQAI4JaDOTT8rzIpi+LZMmc2bZfgsGRbv+tmWSuVFiUbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272516;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=koveL1yf1FBPbdzTiXl5Rtl8BJUqZKa5HozY8L+svr0=;
	b=eAyUSUTO/BhmNp3LC17BHczGHseetW8baNGCsDcH0XOBY0BwGqUJdGSDsfpQh5fgiZ5M
	 6WWI0Bx7f1KuBn6Oar925PWPlPvSSjQ1Bkskwpa5PA5q2s36n0YSs93R5WXLMEwnrZYjf
	 E3b63QCJvcCZrB7CEHJwBzCZsjUbFJ4tsGrq5kcLp+vHqMpZSuT9rShEhy16jlfjlNN58
	 hj0e0r8W9UDigoVcT0z0JJ3MZ6YqfneF0O1GdJ1P8r4ZSmNVZKOIR5JN3cqvM57p3bLT6
	 eqEYL4BwFFn142ak72PjbRnxD1c/T01SJDLKwn/eJu4l8IVLxVhRDrq21A9WZmKgGCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kurg125b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCB7606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kurg125b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B1041F0089F;
	Tue, 10 Nov 2026 01:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272516;
	bh=koveL1yf1FBPbdzTiXl5Rtl8BJUqZKa5HozY8L+svr0=;
	h=From:To:Cc:Subject:Date;
	b=kurg125bNqUa0CdZP/Q44NkauqoRQvP5xqKe5dHB1sT2O/MC8uqHCCtufb3mU9Z+A
	 rMpWf4qnVcAgTo0lrvwn1OSQ6Oa0MWnK/OSime4VWHhZVPsjhuh+j3cn307+hV1VlY
	 XRl88uUCSO6DyTl2+MCu367IPHhWF2iXMABtKF7yBPr3PORH0G52OTHEI0PC5kOuKG
	 KnFBaPMqiKWIc0vXNL5aIpnhnrEMTxauSfR6+a9SMtzbI/6dl1JnD2Ok7bP7kjSAU+
	 k2WydE0AlmpMk0D8vgXP2iFwpgK43ru+tI5Yi+1PGWL+ghAxM67B61XfKiBol+3l0+
	 BRsOYhSFc6OVA==
From: Sasha Levin <sashal@kernel.org>
To: gourry@gourry.net,
	usama.anjum@arm.com,
	david@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/userfaultfd: compare exact registration modes before skipping" failed to apply to 7.3-stable tree
Date: Mon,  9 Nov 2026 20:01:54 -0500
Message-ID: <20261109200154-failed-7.3-05f64f211a25@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 05f64f211a25f7d9771d4fde109aad97174a1cf3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200154-failed-7.3-05f64f211a25@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

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




