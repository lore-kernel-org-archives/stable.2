Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273510;
	b=fxChvSwOcRNVYfXF+j6pBWtGdIPMUbmpbZGFMBZholl4L+p/z1IMeNHV5Qdi7N756GJj
	 Gw3cW3b695qfGNRO6gsrJ1V4cscuwTzlWM/aIdMETD1nPzDTu6F7xUBrxO0JenSxSHuAA
	 VNNCacL9sQ05myM3MOEjJDUf6/fXZnZjmSnqLMTexFSoFdNPLtiCzH5OKJbqwq2IDRji0
	 a3Zr/LIboml9Kl0XPjoHkHCT6mcHde7q4zVma1huOQC/5DfUtdhXY8L2Nc8TVxi8M4UhM
	 wdAkOy18i9N9UaklIOpEAfJZtZL1LXSnmnyLvgMvSIdQAcBjQy968c7g8sPb29gtyjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273510;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XSyJQK9c8yEMVlxnebhD26ZQnutUpZYYO5QRLjKz2vI=;
	b=Mr+0cNgIjh+kEYNqamURASTQ5R09zmdQWjGae80q+cKHiXCtKQ8QnAUKW/Y2Ybr5Rni9
	 EcqcLKa7C6kU12bUaUGGyC99eeE4QuU/EpDP9b/pVGFcK9AmuWNnNc7Sl1k0QKt8R0My8
	 5PqWabZ1C1vIfi6iWqWSR30F+HvsYDeJ202LNA2hzH+0PT0epatWluwzoYgHWvTYZDaW8
	 EuQGNPZx2v4SNCLc0fYxFogJN6K6T1YHjmoA9nhA0Viw9YJd5SM3tNpwE2I/bFEmolzxy
	 0JTGmXyIiutW+tu9xUEJjQtuTGmz+TxNKN13bWouOfut5qp//oN25FWlorWBPJPz8mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gp2YB2eI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B60606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gp2YB2eI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13A01F0089F;
	Tue, 10 Nov 2026 01:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273510;
	bh=XSyJQK9c8yEMVlxnebhD26ZQnutUpZYYO5QRLjKz2vI=;
	h=From:To:Cc:Subject:Date;
	b=Gp2YB2eIY5CgB0DI46/R+OndpModOTrfEgwdBxOO02BfHeVgKKav+1VFVy1xTp0o8
	 bs/CSwnMJmpt27D2TIta/CwUOOvWN/2pTK3VbSvq9UXN2Qkm8G6GtSA+Bouwmb7OdQ
	 6dLURB+uO44MTXiSPiDjW/k4q/tWp+Pi4P/6A6jFaZrZMkGV00n13OL1l8crprbiw7
	 ENKQGTFPAGIBPNPMavaFeBweUDhD8WEtvme5XDEqMv/Th651lEbdVLAY0YAhaepC7V
	 FdjrcXh3cxZjmUfbvjkDD9jO/y3/TquVmxlGzMdcxw11kowiu7C/KD01H5omYsEGW3
	 l9BrVykF0Nusg==
From: Sasha Levin <sashal@kernel.org>
To: gourry@gourry.net,
	usama.anjum@arm.com,
	david@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/userfaultfd: compare exact registration modes before skipping" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:18:28 -0500
Message-ID: <20261109201828-failed-6.1-05f64f211a25@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 05f64f211a25f7d9771d4fde109aad97174a1cf3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201828-failed-6.1-05f64f211a25@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




