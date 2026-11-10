Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273219;
	b=C5PL9DHDX+Ltj2A0Sb3fz35s1wViGfFIkROa3hfVx8zOu+kR+RKxD5fXNUCbSLZJF2SW
	 5IjTdptdoaxBIAQD8PSTSAtkIZeVF+222aNQyssnYu2P4oCoAddkD5wCYT7UrYedPBiLX
	 5I6uPSHEp5/+wym3X1BSzyOZxooa2kuyVQN26nOgbzqTYmOC3t3jVq3ZpxBTAOYL/raHI
	 O7wfemcFrw4fmXqktF9uBO1zAoYD9AqueveHW2ckBJzOBGoa8zdqa6bzC6Xzf1zhKFx3b
	 t10yC+KxEUlGCF94YCGQ9rOmIEI1RXQMe6kID83Ui8A0v/hs4fjoegJUb6N5L1Xlx6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273219;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cyNM7Iqa639LNBgkeaY+7ZnCRSDIK5nF0mHB0zBvfL4=;
	b=gpaQsUdeIs5KAV5vHMKKpxIyQZAMYTcNq07aoXXCb+MjuvoBSPXTK7ULA1pDTsTV7dRo
	 chdomnWKTA8BUxLqW1VFF7LMKmYnTYQRzMVlQcSpGFsoM8iJvJTZt+3pdNFPbB2ZFw5XG
	 q7imcNtKy7cc2gkWsJu07lrK5czKp3mDJZDknePBK56trOFeuvamXjJE3ewqaQiYLyS64
	 Lwez2tYKpT83Akkdt8l8VViWvYMFjuDuQvReMRWG6LYpZYjoLRy2N9wJWHJWkr1X+UJnj
	 yFqV3X7y0ZNR2OrS0Sn+4d+QEx2LQCnwYl50KOnJOpDH8tJa67dysgvfqGrt29GbIBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gWmT5FU1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A79606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gWmT5FU1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BE11F0089F;
	Tue, 10 Nov 2026 01:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273218;
	bh=cyNM7Iqa639LNBgkeaY+7ZnCRSDIK5nF0mHB0zBvfL4=;
	h=From:To:Cc:Subject:Date;
	b=gWmT5FU13FwY054soOBHruD1IpJ8dH58gmpQd0HmzQu12kVr6pDfZbTLrdD+xU5MN
	 m/0+yLelCtjZBL4Vj1XobiRYGkoRuvF/gjSH+UFv2tFXeLOESYhXqTZt22sFOl/9qD
	 I2gtyqayOSsyyjNuPqHTSRKnvN8HZAaTupFytQ94xCkYcVs6ywqQOvBw9ugXbAwAqO
	 1IZlkBIkGVjSsXOVbS5kDnzpyDp1ccQN87cLv5vY8XJjrUazggyLneARMC70MtGh7z
	 I3ZW4abFg8PNGVPxmkXUyrI3JPgpLSOCvgvoCenLc559SmRqNGPKJX78zh7UftHxSw
	 f24nR6QxQCxOQ==
From: Sasha Levin <sashal@kernel.org>
To: josef@toxicpanda.com,
	ljs@kernel.org,
	usama.anjum@arm.com,
	david@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/mmu_notifier: finish non-blocking interval invalidation on error" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:13:36 -0500
Message-ID: <20261109201336-failed-6.6-6d65925777ec@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 6d65925777ecae9d7a571a327e41c63f3940a0c7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201336-failed-6.6-6d65925777ec@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




