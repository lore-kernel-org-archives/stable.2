Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556853033EC;
	Sun, 11 Oct 2026 21:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791754832; cv=none; b=gk9E65bU/31+gVWwt6JHfAFlA3vNJSpE2KvItOnZb/SkOPs/D9N6G4E/KxpJYxVzoykO83o01P+9BaKRucGCbsQlKYbyE3Ygk2ijWRzz0IAgDOxoRxI9TN7Tu3njInZeRbcid4n3SPjmecPQWVf0GrZJmaYpPTNDWLcBJFy/in4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791754832; c=relaxed/simple;
	bh=ydVGsx5/LPpcBfHSwzrjfBc3uMTl0iFbWjgN7FMFhp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwm4xX4+hjAB6Nuo8Jw5ygu25a3nUDo5mqlNcn/jhCI2bPUZcXH/KbCjRjwRT9tedaWufdL8MC9EI/arsKkbg+BByi9DCqf2vB3dyS2pVv0mfIA3+70JJFvS+KvqRwigUcvjlffQ1kMfBuwAAdRTfINxhRbq3Brw+8732AOnjys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hn8rJLvD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hn8rJLvD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B3F1F0089C;
	Sun, 11 Oct 2026 21:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791754831;
	bh=8w314+YIanrqZE4cOJ1DPFJJD2zirntDIy5iuyhTxNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hn8rJLvDzPdHQoRykbln8dUBurGcT2BEG7nsnOcJvfUpPudfYtOeW5QmciWScoxVG
	 HbtMsn7CJc+oqg3/1HlVaZvxZZI70gk6XC4xEEy7b/5CKclBajkIr+KzcMFUpy2zP7
	 ufWKItN85Q/cjkynUI4aRkVvuk0ttArUphkp1B+p2/+FW0mT/bGQIh8Kele9gIyyNB
	 yKBWby0QIvVTvmyonW5RivYupuPc+1Xhhok/yIhAR6FQJrqLLtySYjPQ9BuXurphw2
	 IY9xRTVbiJ9zFNSe1rGm/qtLsC/Lvwg/t8oguZ9us0t6pO8/6bv4itOJKd1/6v3uP3
	 DlYWwk9HQIa+A==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] sched_ext: Propagate every bypass depth change to the descendants
Date: Sun, 11 Oct 2026 11:40:27 -1000
Message-ID: <20261011214028.743546-2-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261011214028.743546-1-tj@kernel.org>
References: <20261011214028.743546-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bypass() propagates a depth change to the descendants only when the
scheduler's own depth crosses zero, so an own bypass that starts under an
ancestor's never reaches them. When the ancestor's bypass ends first, the
descendants leave bypass while the scheduler is still bypassing: a
sub-scheduler disabled under a PM suspend has its children re-queue their
tasks through their own BPF schedulers at resume, mid-teardown. If the own
bypass then ends, every descendant is decremented once more than incremented
and dec_bypass_depth() warns, though no current caller gets there.

Propagate on every call so that a descendant's depth is the sum of its own
bypasses and its ancestors'. The early return follows the walk, as a
descendant's depth is at least the scheduler's and nothing changes bypass
state unless the scheduler's own does.

Fixes: c7f0e467a27a ("sched_ext: Prepare bypass mode for hierarchical operation")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext/ext.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index a6a72ae7f815..3edb51bdd0ef 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -6216,22 +6216,23 @@ void scx_bypass(struct scx_sched *sch, bool bypass)
 	struct scx_sched *pos;
 	unsigned long flags;
 	int cpu;
+	bool changed;
 
 	raw_spin_lock_irqsave(&scx_bypass_lock, flags);
 
 	if (bypass) {
-		if (!inc_bypass_depth(sch))
-			goto unlock;
-
-		enable_bypass_dsp(sch);
+		changed = inc_bypass_depth(sch);
+		if (changed)
+			enable_bypass_dsp(sch);
 	} else {
-		if (!dec_bypass_depth(sch))
-			goto unlock;
+		changed = dec_bypass_depth(sch);
 	}
 
 	/*
 	 * Bypass state is propagated to all descendants - an scx_sched bypasses
-	 * if itself or any of its ancestors are in bypass mode.
+	 * if itself or any of its ancestors are in bypass mode. A descendant's
+	 * depth is the sum of its own bypasses and its ancestors', so every
+	 * call propagates whether or not @sch changed state.
 	 */
 	raw_spin_lock(&scx_sched_lock);
 	scx_for_each_descendant_pre(pos, sch) {
@@ -6244,6 +6245,13 @@ void scx_bypass(struct scx_sched *sch, bool bypass)
 	}
 	raw_spin_unlock(&scx_sched_lock);
 
+	/*
+	 * A descendant's depth is at least @sch's, so no bypass state changed
+	 * unless @sch's did.
+	 */
+	if (!changed)
+		goto unlock;
+
 	/*
 	 * No task property is changing. We just need to make sure all currently
 	 * queued tasks are re-queued according to the new scx_bypassing()
-- 
2.56.0

