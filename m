Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274091;
	b=RPAqppJNW2tPk4+e+s7o9/i0uNQp6vHtjNDjWGt4HWUQA6Zb4FWr6mGfCeLUYsVPN105
	 QZqtvK4mYzToibnSo8Cnc4AJk4sfEf6DJOG5l1Ya9AubnQLLDobWJELcZyyJcnWc/AYoW
	 R9fLGBd0/CS3XdHcCAq5mFf14LK0uYZvILY+qPEOvWTlA4mTa+CRROFLXwgCwiSQQGdbS
	 ylGQIJH5FHZF3LMIsagIfM/7FtWjj4Uz2AwGnmiatSN0v+Nf6K4Rh4B/er3nEsT1AKp+M
	 wBThTwtTafmszxvbBVzZoyEXlTc6n9wh4No6STsgya5KSsO+QAZ3ty7P+TTyNUnjHpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274091;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zsAhKAkD1Gdzjf5aL1DC6ym6O1jEiAhJPZYeyb8MU6Q=;
	b=ecHcgnGfXm8TU6nEqPp+JFvpEaH2uciea8FzTcfcQs1i4r8wglMboBsY5X/wjZN2G8/F
	 MICL/uH4PspKXcRMM4BMyKZ1LSp4Gj/FF6GSEMVuwttEe6BijzcMBhK1Rl/MWgyvb1bMc
	 JJIyNyClcWQ9TxGlpa9AZu09aWcXqvn9CMmuyNN9P5jptUKUmA6Zh8HDQIgF7cX+Sr5Ji
	 QnTInUvMBvOCibcVIf7kkYoJXaKSV+NfzWGzIZhb9mbz2zshoRHYq/qYMujmzdCA7e3v3
	 e8WRZSTRS8py9toK0HEkL5xb4BBn2izmKHvXWWumdlBpSgvDH1ucd5ssGf1UstcT1dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DW6UZqNX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2344606A32E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DW6UZqNX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B901F008A2;
	Tue, 10 Nov 2026 01:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274090;
	bh=zsAhKAkD1Gdzjf5aL1DC6ym6O1jEiAhJPZYeyb8MU6Q=;
	h=From:To:Cc:Subject:Date;
	b=DW6UZqNXjnJAYG+m+vt2KJJwaNUoTF4c6B/hG1hN0GOr5vJkfjAAyozcw69hf47GD
	 KXaSd8wkAq7wXT/Z9PbZmmiyBaCEklnRx9UepqgVA2NJhZ1IrBLelUQuo5R4lZtdov
	 YMetqTJonRD17P2xyWLvV2Pf9PnP6ky01TEWx9ZdtQT22aCFM4tWQFXZ9I+Rogzelj
	 A48wAlhvHJaa1XPIqmlq3HVXCSubA8YPvidc1U/o/z3MDKfcEm8Oohc+EKsKQ3k8vD
	 1GaNIMn2g5JD3leXVfquRUZk0g1E5UWCNfWTbVMFVPFvvoclgrfaMd8sm2clTxlE7C
	 AuywCX4+0BhJQ==
From: Sasha Levin <sashal@kernel.org>
To: josef@toxicpanda.com,
	ljs@kernel.org,
	usama.anjum@arm.com,
	david@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/mmu_notifier: finish non-blocking interval invalidation on error" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:28:09 -0500
Message-ID: <20261109202809-failed-5.10-6d65925777ec@kernel.org>
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
git cherry-pick -x 6d65925777ecae9d7a571a327e41c63f3940a0c7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202809-failed-5.10-6d65925777ec@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6d65925777ecae9d7a571a327e41c63f3940a0c7 Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Sat, 31 Oct 2026 10:39:57 +0100
Subject: [PATCH] mm/mmu_notifier: finish non-blocking interval invalidation on
 error

When an ordinary MMU notifier rejects a non-blocking invalidation, the
interval invalidation started beforehand is left unfinished: the caller
skips mmu_notifier_invalidate_range_end(). Subsequent interval notifier
operations can then wait forever.

The only in-tree trigger is nouveau SVM, which uses both notifier types
and rejects non-blocking invalidations. Reaping via the OOM reaper or
process_mrelease() can therefore leave the GPU fault worker stuck,
holding a reference that prevents the dying process's address space
and memory from being freed.

End the interval invalidation when an ordinary notifier fails a
non-blocking invalidation, like mn_itree_invalidate() already does when
an interval notifier fails. Make that handling clearer in the
documentation of mmu_notifier_invalidate_range_start_nonblock().

Fix generated by an LLM and sent by Josef Bacik in private.

Fixes: 99cb252f5e68 ("mm/mmu_notifier: add an interval tree notifier")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ david: simplify description, update function doc ]
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-28-d6437171ecc3@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 include/linux/mmu_notifier.h |  3 ++-
 mm/mmu_notifier.c            | 17 +++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index a11a44eef521e..5db78e5761c5c 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -483,7 +483,8 @@ mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
 /*
  * This version of mmu_notifier_invalidate_range_start() avoids blocking, but it
  * can return an error if a notifier can't proceed without blocking, in which
- * case you're not allowed to modify PTEs in the specified range.
+ * case you're not allowed to modify PTEs in the specified range or call
+ * mmu_notifier_invalidate_range_end().
  *
  * This is mainly intended for OOM handling.
  */
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index df69ba6e797f7..2e20f88e162d7 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -569,16 +569,25 @@ int __mmu_notifier_invalidate_range_start(struct mmu_notifier_range *range)
 {
 	struct mmu_notifier_subscriptions *subscriptions =
 		range->mm->notifier_subscriptions;
-	int ret;
+	const bool has_itree = subscriptions->has_itree;
+	int ret = 0;
 
-	if (subscriptions->has_itree) {
+	if (has_itree) {
 		ret = mn_itree_invalidate(subscriptions, range);
 		if (ret)
 			return ret;
 	}
 	if (!hlist_empty(&subscriptions->list))
-		return mn_hlist_invalidate_range_start(subscriptions, range);
-	return 0;
+		ret = mn_hlist_invalidate_range_start(subscriptions, range);
+
+	/*
+	 * On error, the non-blocking caller is not allowed to call
+	 * invalidate_range_end(), as in mn_itree_invalidate().
+	 */
+	if (ret && has_itree && !mmu_notifier_range_blockable(range))
+		mn_itree_inv_end(subscriptions);
+
+	return ret;
 }
 
 static void
-- 
2.53.0




