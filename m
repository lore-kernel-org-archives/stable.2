Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273505;
	b=rz7mxOtXc1I+CgDN3wfmgSIhs9utnkGHfkNYSmDlFkA/2N6LLYE27Amtm4oQNeWBq/Wk
	 ICEj9mNJ5xmtSit3b2sgFK7URQUcpHK9ybtvTVWvwSHOwCarKf/2ifewD417YlSes8XEh
	 6MuiqxHM7rDpSh58WavkQadJZHmLmUnwBzXhoS3D++WL4feqCrHyxD/LWLsAcI8+W6r+l
	 Aa3uleMETwNblIA/gjhJSCWshtbWNNh0XL9RrQJeYJxxPDps4KVeBHghBP9gNskf8mAI3
	 9Yj1KHRJ5j+0016ffbxP584MXLumYTFB/bf+xrTzIRiVhIBcfyPwEG8LfC8LAPZQmug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273505;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=uy+k4UDUSdQc3JexxIPyqU664c7YEk3+tI7BYAu9cRM=;
	b=xJuWJsZiaqoHNMzl445xJpfBHsuu5Aumq3jiJCLpIVwTtnX0+CTHzvj0iHAnVbwpRnId
	 g8TM3JfpP/drqJvRjb/dhW6FimgU/MlWRj9vHAOJf2UPMegmJUJumEvRPk5rieoD6klY+
	 pHGKXMNHjJDJ+pUVSHvWVWkOH99SsLqYghSXcRao2H4AJSo/epQCN8VdRb1kNbuz7yXxR
	 ELtHtYVwDqKGApAfVPI3BR6Cf/hJOP2dPr4f3baJNrw2NeH5hr+sLBrbsQjQ1RkefFgup
	 Xaj085IpKp+WZ6RMueLfAlyHwscL8lDedAXSa/9jsLx0/KC9+9/NEY0oE/bTAOb0XAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KuKrWXUM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755FA606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KuKrWXUM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9797F1F008A1;
	Tue, 10 Nov 2026 01:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273505;
	bh=uy+k4UDUSdQc3JexxIPyqU664c7YEk3+tI7BYAu9cRM=;
	h=From:To:Cc:Subject:Date;
	b=KuKrWXUMayl10XRemRbicafXj3MZBbX8UwEyIqLnWTs/B5sWWftKXXgK2mXsx+/1w
	 IDCKI4iX6BwnQVoI6YLuhSp4Sw91WW2bwoTigL6dE44umFh8YmpXrn0cxy3IYnIGaP
	 6P9nK3UsX4+gO7h+gYKhHXD1nQXz0xRfzJ6fUPk25fFyf++a+RP2Co51eK2qohVod7
	 FMyROgDPYogG/HhXRPtoprnYx+SeRveD7xHL9bzL1MnTp7WwNKGj0Bk8Cx0L9sFVQv
	 hflDm3anr6t8POdy35WkhUhnN9aHC0GOZrvlhtE64+ZuabEXtuoCRvzwgrZoFoVj4o
	 6tXbNsFRK4zEA==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	gourry@gourry.net,
	rppt@kernel.org,
	ljs@kernel.org,
	usama.anjum@arm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/userfaultfd: wake waiters when registration modes are removed" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:18:23 -0500
Message-ID: <20261109201823-failed-6.1-4eee9c389b07@kernel.org>
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
git cherry-pick -x 4eee9c389b072e161549d46dcb1ae10b0222717e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201823-failed-6.1-4eee9c389b07@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




