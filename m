Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15A93ACF11
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785069732; cv=none; b=YTDon6TyjmevIKnTGTz0nT64sYQboN6gNzNc4TtCmeymZIH1cdE8JiA42Bf1uqi7hVOc/odtXjZB6FypbUPLuUr6Q+UIommwm6EwAjj3T0gnrVoACgiXIlj5kFkhIfQcoXD42BojkicBcbdpOtbwW5f5vxMmmqlBZ6kG/OiCm0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785069732; c=relaxed/simple;
	bh=KJb2JEf3lNKqaKNabLYhVR9TGFtU+iO2emKAW+a/mJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZATF/k453niuoPij6FskreNHx6Orhkx3YpOtAJ3s090a/uCslHCX5cdBYjt2wo9JuR6jQ+J/EOI3ANkYpBo9OdXPmWOLItCx79IRlZutlK1Y2hZav6k8qddokMgLKOXvAjJMLvxzwGY05/Ol2VS6MRADVoxMQQPHLPFzVCXf9Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKaLOfRN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKaLOfRN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3A0A1F00A3D;
	Sun, 26 Jul 2026 12:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785069730;
	bh=S4gWWGDd/7OEImA2tOYpW3BkWBvJMm/Bp3JwsRRIfV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bKaLOfRNJutE+emTULXM3TQZvH+3+nzts0FQlBFJzkOgIjzbglz0+hcwJx8MeUfde
	 sd8xWVveSCOWsFnrjBn2BkimfC5lemtdysREKAz+0ahyAbs5YIq5V3SjImDsCp6mHx
	 q7vgkcibiLOzSqL6vYN9NGRioj8XaKJTDQLe1maiIjWi12NPks0As6xK+VN/rR8QFw
	 rz/HxeA0NipBNwLmh5eyyM7ZUYUhf2V/SFOujXAkDqsaG3SyZaadgXzVwWqSzF4507
	 7InJkCnL3JY9ndCz+2KMEp2QRSs3n3/5ktUI7rypvlCrvrd8bHTw2oySqHpZCpmVYl
	 5cs3HiJYk5s9w==
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
Subject: [PATCH 6.6.y 2/2] taskstats: retain dead thread stats in TGID queries
Date: Sun, 26 Jul 2026 08:42:07 -0400
Message-ID: <20260726124207.101107-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726124207.101107-1-sashal@kernel.org>
References: <2026072045-canteen-finisher-8a4e@gregkh>
 <20260726124207.101107-1-sashal@kernel.org>
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
index 069419c18df0bf..e47e13a5a579bd 100644
--- a/kernel/taskstats.c
+++ b/kernel/taskstats.c
@@ -210,13 +210,39 @@ static int fill_stats_for_pid(pid_t pid, struct taskstats *stats)
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
@@ -233,30 +259,12 @@ static int fill_stats_for_tgid(pid_t tgid, struct taskstats *stats)
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
@@ -275,18 +283,14 @@ static int fill_stats_for_tgid(pid_t tgid, struct taskstats *stats)
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

