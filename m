Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274081;
	b=QyQvz4mJsaGfT8EI3wgMqKroczDo9pYTsmYT7olaz22bvROfaeJF9EE/71onmfnVDZm3
	 HS9xTpFCSiLyWyu1GryepBq9ynjaoUiIVmqnpMPS0DY/2HXNNE1kr3Y1Zb48P/gbDXDQp
	 kcXmG5Bl+acaGAwRWYedsge1+pRivt3IJKoZoS7auitbASf5mXlt12FzJFi6/wTikLkHb
	 uWb/ywMCzrdhBvQAyZeQ1KZOODtYTW5SYediK3uHtZfLZxdjKadKOw/cBrrhwnlByfKPS
	 UShAGz7+kONVBGLDXLC8ryqvgpy5+PPRuqbgVmm0/6HzsygLnGTSS+1mHJb4BMZ5seA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274081;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+RDMEaVHfVWw3NNZhIfU05owGFo3eSY3C16T9b4RXOE=;
	b=A9/jICQj3ZHoJ/ankfIJ9VJVeKmxZeZm/dMO4Uck+93VoPeOPnHonqZtoB9nULkKc5Yw
	 AjKrxDPl28rGYM4zHQZyL9y1sVMCuZhZ9y6DIbdlfcU7+Vv+QZplfb1DJn8XDByGdEpwP
	 Xz/i7bEN2RkgoJ7bslZVohj3ZwELprmGpPms4nFPmO0J09jxnfY9ZyK4Ezb+mqoJRU8EC
	 Tj0yvpDorTafPvW93Z1xLySBs/PuYonhbmyvyC+2pgKu1ITqf+/8AVqlIjbKZwNX/YJZe
	 2S6+UcdpNWPxnxlTsG0PuXKLAvEqKgRURkwHq4Nmume+6nLkEER2M5HApbWUmrUVdfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yo2P4tcI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9BE606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yo2P4tcI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29021F008A1;
	Tue, 10 Nov 2026 01:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274080;
	bh=+RDMEaVHfVWw3NNZhIfU05owGFo3eSY3C16T9b4RXOE=;
	h=From:To:Cc:Subject:Date;
	b=Yo2P4tcIwXZ/Vr6wicJncj2EVGx7Uf5V7W0cinxtdT9y3H6ZA4MbyuY78IpcYF7PD
	 s5N5zMVHdcOzrYfGJ9QrrglceRABUvJC3k5T4Bp6Hl01cPe40/xSJHKCh64nTVz21B
	 5cRLM812ZQisRX1TToI6yFk0LeOdubH21VV+XGXtMhKeta995qckoKkRm1QwCHUhyM
	 kkpdgICErx07MkZEREebI3ivMmkUYmP5vgqr66OHUvglOL1BwBBADh0Qis2ysmHcGA
	 qmR0+auD4UNV+Y19L9rbebIVdxCiQ8c1ALOM98VBHifa6tu5zrDDm/3fWikDvPfdwh
	 rc2XrTiPggsUw==
From: Sasha Levin <sashal@kernel.org>
To: gourry@gourry.net,
	usama.anjum@arm.com,
	david@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/userfaultfd: compare exact registration modes before skipping" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:27:58 -0500
Message-ID: <20261109202758-failed-5.10-05f64f211a25@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 05f64f211a25f7d9771d4fde109aad97174a1cf3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202758-failed-5.10-05f64f211a25@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




