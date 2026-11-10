Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272519;
	b=vLLdL9hPemr+GIl5+8r8/iJjjWbD3PM/RL8bc3QegmoF224vq+Rn9HOSJOAu18r0t98f
	 eHVC82P2wkLFSeCVVSO0Nhr6SJkjktkgeFkAMaNuhUWiaiUJApTI1OAOc5vGcAanehE2A
	 f+GNB5qkyt3aHBpdVAHnkZrtN2KuPsgEnDwZTdmhJAf59H5lBtzI1Jdrju8KrZs8Zsrja
	 K4OxCJFCvCpOCD50HMXub1lnq4Qh0AAKnUGvXHK5Yb92X5Fg9OZWYMcCLaAf+22nBPqaW
	 6PJ0n6EX+wk144JWsbaHHfL+zs2IQeCYvrcxF4FbynXjKPN/oc43myPyOKcBSMa/6FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272519;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xgTqXdXy8RXmz+hNRMQHYULiBPfyMWBUs3BE+iCjwus=;
	b=zakHufSQYIUJHMop9Gy6g1Xwwh3UPddNCaKj+5aKrBxWTN4QWbjWZjXkwQK4aTBpkABe
	 PpXqcEU6ujK7Xnd39Xhuc8YCKDgR7Unem7eMSub72c2oujIXm5UHyucBlRhuVbnRNJriz
	 hzdoR+Sbb46cLyDgvDBrpa3CZKXNoujwK0o5jVJqhbIkd7ST3N0ZCW5AQUw1rWMuIg4/7
	 ImNBAX1Jl6OwuYpyfpFegADNJq2lHE0Yak1zOhaT7e+6lzL6MRc+tOXZZ23jIIN96BLCl
	 FiETqUqmIM8CypDhmqGmBRuNtFBRb5SJ9oQa17TeTYhWgGEPCi0bf102xraac9Spniw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ydb8EjsF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17C3606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ydb8EjsF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9131F0089F;
	Tue, 10 Nov 2026 01:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272518;
	bh=xgTqXdXy8RXmz+hNRMQHYULiBPfyMWBUs3BE+iCjwus=;
	h=From:To:Cc:Subject:Date;
	b=Ydb8EjsFqY2MtzZ1/XqpLOK54XwTIcSYhzanPwLCcD1nwZssKA5V3nbXTTyy5suka
	 /EzY+KZyz2EilOxXPlH8+i0oshgrgaY62gjMf4ZHaQdV/SzRCNhWW5CPcoddWcg2ub
	 zSMaUtrfkhM8SyNCJN7W167cj0Ruvr6CUrBltPf1fZFg9h+lb05Znqr1Qcfiq69cig
	 Q1T3R050aqvLvsPTqDnYx5OjpmFdZXbUT/EcHQRowFyXw5oyJFM2OxCQzX5eVF9Ej3
	 hoBIBBQHI1UgdQhtrZN+tio3dUSPyFPApZf1GrWRdI/t3X+N+fcnz8y+KamVoJY8oE
	 9qNTyt2W07Ahg==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	gourry@gourry.net,
	rppt@kernel.org,
	ljs@kernel.org,
	usama.anjum@arm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/userfaultfd: wake waiters when registration modes are removed" failed to apply to 7.3-stable tree
Date: Mon,  9 Nov 2026 20:01:56 -0500
Message-ID: <20261109200156-failed-7.3-4eee9c389b07@kernel.org>
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
git cherry-pick -x 4eee9c389b072e161549d46dcb1ae10b0222717e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200156-failed-7.3-4eee9c389b07@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 4eee9c389b072e161549d46dcb1ae10b0222717e Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:39:54 +0100
Subject: [PATCH] mm/userfaultfd: wake waiters when registration modes are
 removed

UFFDIO_REGISTER can replace MISSING or MINOR tracking without waking
faults that are already queued. For example, switching an anonymous
range from MISSING to WP leaves a missing-fault waiter asleep until
userspace explicitly wakes it.

When a registration change removes a UFFD mode, wake waiters in the
affected interval after updating the VMA. The VMA is write-locked at
this point, so no new faults can queue under the old modes and woken
threads cannot retry until mmap_write_unlock(). Waiters for retained
modes in the same interval may also wake and refault.

The hang reproduces for MISSING-to-WP and MINOR-to-MISSING transitions,
with both read and unread fault events.

Fixes: 63b2d4174c4a ("userfaultfd: wp: add the writeprotect API to userfaultfd ioctl")
Cc: stable@vger.kernel.org
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-25-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/userfaultfd.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index be630674fda9b..03f1b15bfe63e 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -2270,6 +2270,9 @@ static struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
 	return ret;
 }
 
+static void wake_userfault_range(struct userfaultfd_ctx *ctx,
+		unsigned long start, unsigned long end);
+
 /* Assumes mmap write lock taken, and mm_struct pinned. */
 static int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 			       struct vm_area_struct *vma,
@@ -2287,6 +2290,8 @@ static int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 		prev = vma;
 
 	for_each_vma_range(vmi, vma, end) {
+		const bool any_mode_removed = vma->vm_flags & __VM_UFFD_FLAGS & ~vm_flags;
+
 		cond_resched();
 
 		VM_WARN_ON_ONCE(!vma_can_userfault(vma, vm_flags, wp_async));
@@ -2332,6 +2337,10 @@ static int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
 		 */
 		userfaultfd_set_ctx(vma, ctx, vm_flags);
 
+		/* Retry faults for removed modes while the VMA is write-locked. */
+		if (any_mode_removed)
+			wake_userfault_range(ctx, start, vma_end);
+
 		if (vma_is_hugetlb(vma) && uffd_disable_huge_pmd_share(vma))
 			hugetlb_unshare_all_pmds(vma);
 
@@ -3648,6 +3657,17 @@ static __always_inline void wake_userfault(struct userfaultfd_ctx *ctx,
 		__wake_userfault(ctx, range);
 }
 
+static void wake_userfault_range(struct userfaultfd_ctx *ctx,
+		unsigned long start, unsigned long end)
+{
+	struct userfaultfd_wake_range range = {
+		.start = start,
+		.len = end - start,
+	};
+
+	wake_userfault(ctx, &range);
+}
+
 static __always_inline int validate_unaligned_range(
 	struct mm_struct *mm, __u64 start, __u64 len)
 {
-- 
2.53.0




