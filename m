Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF79529B799
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 13:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785072123; cv=none; b=gQIAG4B3KlfzizmY37TE2syXhL1mPhLOGYq6Pw5tIYX5hZ2Xi3oP6vjRZCD8vIfxsw06TJGxKV3XJo3cV2y4mQA3Q/0B4N1gSVb/fUaMBNz1Wju/7i7ePnttzjT9E6vh61J5kMRtj9vp1nzIyQGdQPJAN7oWhbXxo2k9eT9SrFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785072123; c=relaxed/simple;
	bh=B2mUYdt64W6km+TeA66kBW2lzyKoxnO5PfKjF1XWPRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arcYrRt4aYHCom9XQ89it5oOt2MwPoohjPq6ALgaM1vIaqUkO/7rAO+mT03LP1qiV0eCcbp0PT+zXx0SVXEYImfkfOuDxqLTrfzYmEH5o5xy3ZAxWHhT4eHDwRWHOC+0eSCP6Mp4m2nxf5+sFcjoAXLDNyyDwTje9hX4a14gpYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6nzDYs7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6nzDYs7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD6F1F00A3F;
	Sun, 26 Jul 2026 13:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785072120;
	bh=IrYa/TcZcjuCbDzo+WtOKJEeLzZL3zjAzuP1ugGcqJA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z6nzDYs7oXwZ4WP0enRDtsuyihaKQOdLQ/tt6hXoNkVr6/jNiQTmMzvs8uPJPM66B
	 rUpsZMjs32NgB6Jx1uzLEfrDWaiGzXAyUp1fi7kI291Zvdo/bNAdgE/6MIETUWc//f
	 eZY+y1+0MmrSy1bqBXqPBRDls0VxSLusp13q8bPnTV/eF/ldhszcx0qw1XbuU79Q3u
	 VeT0zqM2EHDxUqCuIXBhVswzn6hwJl/f+xMC0inr2lNQwxPrY8fCFhyCsLDMHEZTnd
	 Q6eK6cv7Ek1xVWxkooCJUDpuNxPstoyTmgLyNOzl1QCVnogq2x2ESkXDISrlTaJMNw
	 L3I4q+vbYqhWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yiyang Chen <cyyzero16@gmail.com>,
	Balbir Singh <balbirs@nvidia.com>,
	"Dr. Thomas Orgis" <thomas.orgis@uni-hamburg.de>,
	Oleg Nesterov <oleg@redhat.com>,
	Wang Yaxin <wang.yaxin@zte.com.cn>,
	Yang Yang <yang.yang29@zte.com.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] taskstats: retain dead thread stats in TGID queries
Date: Sun, 26 Jul 2026 09:21:56 -0400
Message-ID: <20260726132156.327047-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726132156.327047-1-sashal@kernel.org>
References: <2026072046-broker-latter-538d@gregkh>
 <20260726132156.327047-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yiyang Chen <cyyzero16@gmail.com>

[ Upstream commit b3e4fbb04220efc3bc022bcf31b5689d39c6b111 ]

Patch series "taskstats: fix TGID dead-thread stat retention", v3.

This series fixes a taskstats TGID aggregation bug where fields added in
the TGID query path were not preserved after thread exit, and adds a
kselftest covering the regression.

The first patch keeps the cached TGID aggregate used for dead threads in
step with the fields already accumulated for live threads, and also fixes
the final TGID exit notification emitted when group_dead is true.

The second patch adds a kselftest that verifies TGID CPU stats do not
regress after a worker thread exits and has been reaped.

This patch (of 2):

fill_stats_for_tgid() builds TGID stats from two sources: the cached
aggregate in signal->stats and a scan of the live threads in the group.

However, fill_tgid_exit() only accumulates delay accounting into
signal->stats.  This means that once a thread exits, TGID queries lose the
fields that fill_stats_for_tgid() adds for live threads.

This gap was introduced incrementally by two earlier changes that extended
fill_stats_for_tgid() but did not make the corresponding update to
fill_tgid_exit():

- commit 8c733420bdd5 ("taskstats: add e/u/stime for TGID command")
  added ac_etime, ac_utime, and ac_stime to the TGID query path.
- commit b663a79c1915 ("taskstats: add context-switch counters")
  added nvcsw and nivcsw to the TGID query path.

As a result, those fields were accounted for live threads in TGID queries,
but were dropped from the cached TGID aggregate after thread exit.  The
final TGID exit notification emitted when group_dead is true also copies
that cached aggregate, so it loses the same fields.

Factor the per-task TGID accumulation into tgid_stats_add_task() and use
it in both fill_stats_for_tgid() and fill_tgid_exit().  This keeps the
cached aggregate used for dead threads aligned with the live-thread
accumulation used by TGID queries.

Link: https://lore.kernel.org/cover.1776094300.git.cyyzero16@gmail.com
Link: https://lore.kernel.org/abd2a15d33343636ab5ba43d540bcfe508bd66c7.1776094300.git.cyyzero16@gmail.com
Fixes: 8c733420bdd5 ("taskstats: add e/u/stime for TGID command")
Fixes: b663a79c1915 ("taskstats: add context-switch counters")
Signed-off-by: Yiyang Chen <cyyzero16@gmail.com>
Acked-by: Balbir Singh <balbirs@nvidia.com>
Cc: Dr. Thomas Orgis <thomas.orgis@uni-hamburg.de>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Wang Yaxin <wang.yaxin@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/taskstats.c | 62 ++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/kernel/taskstats.c b/kernel/taskstats.c
index 6916bc152ce831..fd7dd09e44e9c6 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -188,13 +188,39 @@ static int fill_stats_for_pid(pid_t pid, struct taskstats *stats)
 	return 0;
 }
 
+static void tgid_stats_add_task(struct taskstats *stats,
+				struct task_struct *tsk, u64 now_ns)
+{
+	u64 delta, utime, stime;
+
+	/*
+	 * Each accounting subsystem calls its functions here to
+	 * accumulate its per-task stats for tsk, into the per-tgid structure
+	 *
+	 *	per-task-foo(stats, tsk);
+	 */
+	delayacct_add_tsk(stats, tsk);
+
+	/* calculate task elapsed time in nsec */
+	delta = now_ns - tsk->start_time;
+	/* Convert to micro seconds */
+	do_div(delta, NSEC_PER_USEC);
+	stats->ac_etime += delta;
+
+	task_cputime(tsk, &utime, &stime);
+	stats->ac_utime += div_u64(utime, NSEC_PER_USEC);
+	stats->ac_stime += div_u64(stime, NSEC_PER_USEC);
+
+	stats->nvcsw += tsk->nvcsw;
+	stats->nivcsw += tsk->nivcsw;
+}
+
 static int fill_stats_for_tgid(pid_t tgid, struct taskstats *stats)
 {
 	struct task_struct *tsk, *first;
 	unsigned long flags;
 	int rc = -ESRCH;
-	u64 delta, utime, stime;
-	u64 start_time;
+	u64 now_ns;
 
 	/*
 	 * Add additional stats from live tasks except zombie thread group
@@ -211,30 +237,12 @@ static int fill_stats_for_tgid(pid_t tgid, struct taskstats *stats)
 	else
 		memset(stats, 0, sizeof(*stats));
 
-	start_time = ktime_get_ns();
+	now_ns = ktime_get_ns();
 	for_each_thread(first, tsk) {
 		if (tsk->exit_state)
 			continue;
-		/*
-		 * Accounting subsystem can call its functions here to
-		 * fill in relevant parts of struct taskstsats as follows
-		 *
-		 *	per-task-foo(stats, tsk);
-		 */
-		delayacct_add_tsk(stats, tsk);
-
-		/* calculate task elapsed time in nsec */
-		delta = start_time - tsk->start_time;
-		/* Convert to micro seconds */
-		do_div(delta, NSEC_PER_USEC);
-		stats->ac_etime += delta;
 
-		task_cputime(tsk, &utime, &stime);
-		stats->ac_utime += div_u64(utime, NSEC_PER_USEC);
-		stats->ac_stime += div_u64(stime, NSEC_PER_USEC);
-
-		stats->nvcsw += tsk->nvcsw;
-		stats->nivcsw += tsk->nivcsw;
+		tgid_stats_add_task(stats, tsk, now_ns);
 	}
 
 	unlock_task_sighand(first, &flags);
@@ -253,18 +261,14 @@ static int fill_stats_for_tgid(pid_t tgid, struct taskstats *stats)
 static void fill_tgid_exit(struct task_struct *tsk)
 {
 	unsigned long flags;
+	u64 now_ns;
 
 	spin_lock_irqsave(&tsk->sighand->siglock, flags);
 	if (!tsk->signal->stats)
 		goto ret;
 
-	/*
-	 * Each accounting subsystem calls its functions here to
-	 * accumalate its per-task stats for tsk, into the per-tgid structure
-	 *
-	 *	per-task-foo(tsk->signal->stats, tsk);
-	 */
-	delayacct_add_tsk(tsk->signal->stats, tsk);
+	now_ns = ktime_get_ns();
+	tgid_stats_add_task(tsk->signal->stats, tsk, now_ns);
 ret:
 	spin_unlock_irqrestore(&tsk->sighand->siglock, flags);
 	return;
-- 
2.53.0

