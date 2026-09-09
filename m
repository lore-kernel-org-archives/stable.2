Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CD622A4F1
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945995; cv=none; b=FBoAHLebl9WqiQJmJPcAkpJOXsWl8I24JwpmpATmtpa5hNibWCudjNpzmJQk33xRtA5mJe4Bz/mCm1yFlOEh+GdvAr4qTc/owGUqqwvgRDORWI3iCYAONHOAojYEQZPgZagSjVstRNum3LhWpNjHNaDC+7YZihFxlIW/6QnNXcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945995; c=relaxed/simple;
	bh=gaBrGhni9P4+mLtKE2iJjPWVWJXn6bwN1UGdXQRRFgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9oO96OaE+Rq4L8QOAbJYZMKe//09I3mj+DutWkKEjQ3ok5rgGe8ZfMRLlERvLN1WhBG2nrviQzkN857AJzbsxguDFqugs0aPOg4WKEBTtChlz9XqgZa382/5qBCh/8mgmDkmZTSuinEA/THKPKA1HGwuC0hctdX372EqFAKIYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hANQflFp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hANQflFp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7312B1F00A3E;
	Wed,  9 Sep 2026 09:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788945994;
	bh=OwlBHejk5kBnWzfxZaW8/v/ovaenW/AR0hziknLTKhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hANQflFpvQ8p22MkGP4joJ+m+fr+nAVg7Jhn2ZJTJc9QCX0r3qRmumC19IqFfB5v7
	 1IQij9UaMnYAE2QR4rCjuqZWJZ6GTQLx9fbDNV7LpIGK+odvrnWXXNAqutdqBjBPgz
	 RWrODFvwaR3esQqUvr3m+FWtGVtUK1t7ZYBlIrGMqQxyvEOTxJOQaG1PtP2GWhoXLI
	 OPQ0GHahBsM+xTBMEWqFbNR2x1g66ZcaenK6k2/ga22ulBHu6I5707nVTOtJvVNN/t
	 dC2U98pSzr7GFn8srKfT2wj123VYG56QewefsfUm3eIJq7eU0jI3HTW1rrsWAl88cf
	 puQOWWhJ+0ldg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] sched: Add assert_balance_callbacks_empty helper
Date: Wed,  9 Sep 2026 05:26:29 -0400
Message-ID: <20260909092631.1296773-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090310-surround-endnote-4269@gregkh>
References: <2026090310-surround-endnote-4269@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Stultz <jstultz@google.com>

[ Upstream commit f9530b3183358bbf945f7c20d4a6e2048061ec50 ]

With proxy-exec utilizing pick-again logic, we can end up having
balance callbacks set by the preivous pick_next_task() call left
on the list.

So pull the warning out into a helper function, and make sure we
check it when we pick again.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://patch.msgid.link/20260324191337.1841376-8-jstultz@google.com
Stable-dep-of: f3629c63a4af ("sched/core: Make core-sched flips wait for in-flight selections")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c  | 1 +
 kernel/sched/sched.h | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b5b5897b595b4..09310f762cd51 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6880,6 +6880,7 @@ static void __sched notrace __schedule(int sched_mode)
 	}
 
 pick_again:
+	assert_balance_callbacks_empty(rq);
 	next = pick_next_task(rq, rq->donor, &rf);
 	rq_set_donor(rq, next);
 	if (unlikely(task_is_blocked(next))) {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 668841022dbf2..02df2334e06d0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1787,6 +1787,13 @@ static inline void scx_rq_clock_update(struct rq *rq, u64 clock) {}
 static inline void scx_rq_clock_invalidate(struct rq *rq) {}
 #endif /* !CONFIG_SCHED_CLASS_EXT */
 
+static inline void assert_balance_callbacks_empty(struct rq *rq)
+{
+	WARN_ON_ONCE(IS_ENABLED(CONFIG_PROVE_LOCKING) &&
+		     rq->balance_callback &&
+		     rq->balance_callback != &balance_push_callback);
+}
+
 /*
  * Lockdep annotation that avoids accidental unlocks; it's like a
  * sticky/continuous lockdep_assert_held().
@@ -1803,7 +1810,7 @@ static inline void rq_pin_lock(struct rq *rq, struct rq_flags *rf)
 
 	rq->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
 	rf->clock_update_flags = 0;
-	WARN_ON_ONCE(rq->balance_callback && rq->balance_callback != &balance_push_callback);
+	assert_balance_callbacks_empty(rq);
 }
 
 static inline void rq_unpin_lock(struct rq *rq, struct rq_flags *rf)
-- 
2.53.0

