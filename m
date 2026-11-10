Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272705;
	b=x00cequit/My/OlVQ1IqY5vQrl3bPWlZYtqQtHqp0aULYiKM1Eqr+k8brPzUX5yd5AyN
	 tHY3oVw5kmf7bsmE89oOItsyeIMd97t9ZpcW5x92pwpi4qnksDKgWaRyqOrBy4hT+IiIB
	 3CNAQJUxz2U4LakY7PFyZgivFy3Qya8xu0Hgio83P2FfTNmmkbL9SgN76eBx79+UFSJMl
	 VovgD1yx8rL1MKpjUMKDRLNs13MccIwnG/Jzmx0tHmyZpGZ7j46jUEw0fW1n+YCdpmZf0
	 7FxxAI/69u0L7YhoCwqiG1XpY0APJyzrNqdwgRt9Jt98iYiua4JWs6tk/9jko+aJvDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272705;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=O4xZ+hvZr4BAG69ETKcqZCwxGTZAhB12NQbZYxEPYI8=;
	b=dcwD2fMu/alRPI5lCKjqgavZFZyEPiFkQKoPB9M46LdymRQ9k9nwFd1akxqX4u43EkTn
	 HicqPtb15Ys8l3dDCxzeFIQobidq2no9duarq3KcrIikzYTGBY6NXwAEMV+5yqpRusbdb
	 78c8I3MRaIRZPMc2Qj2y3udlrWjSs9yCBNkVkBik7yObql32t2vi2bwr0AYM0hOzr6deL
	 o7lucSuVgTTUVLEsFgS6BGQgW7uJu/YifuR//K1t2/AZ3xpo0NUH7SpJHGGxx7KEZ5L7k
	 kAYaxRkCQObh11q9okr8Y2BGsqCgRkdHTAHn3tbVidH4hzZqzWmHzD8E4H89UKEAd3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I5bcxNur;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29788606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I5bcxNur
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370AA1F0089F;
	Tue, 10 Nov 2026 01:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272704;
	bh=O4xZ+hvZr4BAG69ETKcqZCwxGTZAhB12NQbZYxEPYI8=;
	h=From:To:Cc:Subject:Date;
	b=I5bcxNurj9QvwgNtHWEMFys6GfT4GVUVDjR6eFM2njsDa6XF2DG4tSQtCULJqDRe2
	 yjNCnsIpohfnfOffb+m47KCMLk/Yv+d0V/Hg6qnPgTJISNaxt6bej1SiPfWE1fsAcn
	 BGOX3v1DLan1uXZLgAERSAzPPHc9TZDPgRxYO+Je6D7P6RA6lP3SFUFPsngIeEP0aR
	 xj/FzBR8RiAUImZXIcA87hZ/PSVXPr+7XdQIL47CO8Q8Z69Dt3+zmK0QkHrXnlaujY
	 r1sMd+xCp4oo6XPRp2UCvhBeiHh2LxboClMDlsBp8zu8wsdiYi8sT4LllYyk4krGo/
	 6+BWzfG3SWCVQ==
From: Sasha Levin <sashal@kernel.org>
To: gourry@gourry.net,
	usama.anjum@arm.com,
	david@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/userfaultfd: compare exact registration modes before skipping" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:05:03 -0500
Message-ID: <20261109200502-failed-6.18-05f64f211a25@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 05f64f211a25f7d9771d4fde109aad97174a1cf3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200502-failed-6.18-05f64f211a25@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




