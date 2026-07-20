Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B837542BC41
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784557769; cv=none; b=ZRqcpbPacUNXBJ3s4vldHddMjTFjg1WLfivcI3VcuTy0iYn6L7jCFY1ohjszTN2oxFlkqYDekOYz1Mqh6utGNuCOjIxiGdd6Y4slPqzNemH3p0lcy91b39KxEdBtCI/nEvCODxe9dOtQngiimaaKumU1w8sBAsQIB3ydJy+nuHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784557769; c=relaxed/simple;
	bh=PwF+MZCA4VKWBk7bINutusSnvPASH3BztoPbnlFGvWg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qwe5/Gi3JcKqdUNofVFKeMuWGD8pEr8o84uvgBVc/FhaXw2MB51yo1sLYGnaYeok4+jAFKNm07j5DdnPFY68btwjq7IF5w0eucxKyQ6dOXippB6STy3I3lKUNqvjHBjNp7Y6b8oCfMrFp0Euc3qN2Nh4A/liUhkKnQ/71cUOtGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JgeBluLV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JgeBluLV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4521F000E9;
	Mon, 20 Jul 2026 14:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784557767;
	bh=nowr0wCrZjkz4fKB9aMxjJhMM/RCFHAcuIdJKyTF3AU=;
	h=Subject:To:Cc:From:Date;
	b=JgeBluLVMCefSFgfDItcHldjTddNvo3wYI2xLZOjBJdy/RIYcLiSSarNmVBh+Bsk3
	 634y9bWch7ZI825v3zjmBwaoiLelkQiPvUGd/7CAwbFWuBIxNZXZT9lf6zJw+edCfT
	 GZXqigPO3EYs6Cnkiz56lGhPBkpTOvWgL2ay04w8=
Subject: FAILED: patch "[PATCH] mm/damon/core: trace esz at first setup" failed to apply to 7.1-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 16:29:15 +0200
Message-ID: <2026072015-wilder-coastland-ba7c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7e6cc35f5283eab81a14231a64ecd640b690c48c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072015-wilder-coastland-ba7c@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7e6cc35f5283eab81a14231a64ecd640b690c48c Mon Sep 17 00:00:00 2001
From: SeongJae Park <sj@kernel.org>
Date: Wed, 20 May 2026 08:03:10 -0700
Subject: [PATCH] mm/damon/core: trace esz at first setup

DAMON traces effective size quota from the second update, only if a change
has been made by the update.  Tracing only changed updates was an
intentional decision to avoid unnecessary same value tracing.  Always
skipping the first value is just an unintended mistake.

The mistake makes the tracepoint based investigation incomplete, because
the first effective size quota is never traced.  It is not a big issue
when the 'consist' quota tuner is used, because it keeps changing the
quota in the usual setup.

However, when the 'temporal' tuner is used, the quota value is not changed
before the goal achievement status is completely changed.  For example, if
the DAMOS scheme is started with an under-achieved goal, the quota is set
to the maximum value, and kept the same value until the goal is achieved.
Because DAMON skips the first value, the user cannot know what effective
quota the current scheme is using.  Only after the goal is achieved, the
effective quota is changed to zero, and traced.

Unconditionally trace the initial quota value to fix this problem.

Note that the 'temporal' quota tuner was introduced by commit af738a6a00c1
("mm/damon/core: introduce DAMOS_QUOTA_GOAL_TUNER_TEMPORAL"), which was
added to 7.1-rc1.  But even with the 'consist' quota tuner, the tracing is
unintentionally incomplete.  Hence this commit marks the introduction of
the trace event as the broken commit.

Link: https://lore.kernel.org/20260520150311.80925-1-sj@kernel.org
Fixes: a86d695193bf ("mm/damon: add trace event for effective size quota")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 6.17.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/core.c b/mm/damon/core.c
index b33920873871..265d51ade25b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2899,6 +2899,8 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	if (!quota->total_charged_sz && !quota->charged_from) {
 		quota->charged_from = jiffies;
 		damos_set_effective_quota(c, s);
+		if (trace_damos_esz_enabled())
+			damos_trace_esz(c, s, quota);
 	}
 
 	/* New charge window starts */

