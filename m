Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D0E55820D
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091129; cv=none; b=fDgvxsPOBkNfgsv/+FYuZ/6+cpOO303vcFsKmgKPHAHjMcM3Ia52fqxno/R21E9wZh1H1JGSWgE27v2HBfrvvZEJC7OZSX7Xa7nl5surufo2CekNVjIPvXgCEPn/uTqp8ggj0+40vVj8H44e40okVkMB0i1O4c611nIgEN6AR0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091129; c=relaxed/simple;
	bh=LikQJKIKvOFVsVHdni60KovsOaZGa8ShAfCAP8M6YW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZxtmOg9R3Cs3xHbIg4KbzzDbUlTeSmueap+2fMFMTCWPs9Aq0S92I9af4FIqnBzHbeIRQJEL7EOVxuktz1JkpgLripmGH7keq4OIMmkbuyQma8WpSV+iukZDYSdtGAHxX9xhqn857JwGtM3o8PTcU9MkJUkpyK/qgHJf4Hm97+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXJxHkVi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXJxHkVi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A44E1F00893;
	Tue, 22 Sep 2026 15:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790091128;
	bh=TLPhFvFg+RRFytEuT73NVdN56dDnjQfSSoOvSO1G414=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XXJxHkViYICdtzJHgDyDD3JMa7dTvdOfRqL8xkvC40aUJRvcx/xcvoK1KsBg7vSDr
	 2jNBCV0F8D+dPd+OEouuAZMYWLXsnVsAF9nGQmNTyvITgWvsVHricI4cs05d7Ji8Ql
	 SEOIKwNFrHMBR8s7yP1tr+N8W/TmW8ByUUM6IlqO52BR0F41k+79Ebw8MDHyvThinG
	 aIO+N9Y6TbeeM4lrE5UghORMOVLyJBlIpnivjR3csDBfQbWlxl9Y6fz0mIApLE7yXj
	 Jx/Bwvlf0s9B/OupppJyDMfekmvv8a5vR4dAggpWc5TpViAmEKrTF5K4c77kCBCRjU
	 X78+o2xKiyhBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] signal: Move MMCID exit out of sighand lock
Date: Tue, 22 Sep 2026 11:32:05 -0400
Message-ID: <20260922153206.2821032-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092201-refining-banner-c772@gregkh>
References: <2026092201-refining-banner-c772@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 2b1642b881088bbf73fcb1147c474a198ec46729 ]

There is no need anymore to keep this under sighand lock as the current
code and the upcoming replacement are not depending on the exit state of a
task anymore.

That allows to use a mutex in the exit path.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251119172549.706439391@linutronix.de

[Backport to 6.18: Keep the MMCID declarations and CONFIG_SCHED_MM_CID
stub in include/linux/mm.h, where they live in this tree, and rename the
existing exit helper and its barrier-comment references there and in
kernel/sched/core.c. Preserve the stable helper's runqueue locking,
mm_cid_active store, memory barrier and per-CPU CID release, as well as
the separate sched_mm_cid_before_execve() implementation. This tree does
not have the upstream MMCID refactoring that moved the declarations to
sched.h and made the exec helper call the exit helper.

Move the existing exit cleanup before exit_signals() in do_exit(), as
upstream does. This removes the MMCID calls from the exit_signals() code
rewritten by d2710c8d938ae ("signal: Prevent exec() race"), allowing that
fix to apply without importing unrelated MMCID changes. No functions are
added.]

[ sashal: Reduced backport -- upstream 2b1642b881088 touches 4 file(s), this
  backport carries 4. Not backported here:
  include/linux/sched.h
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: d2710c8d938a ("signal: Prevent exec() race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mm.h  | 4 ++--
 kernel/exit.c       | 1 +
 kernel/sched/core.c | 6 +++---
 kernel/signal.c     | 2 --
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 50710a5d4a05f..2c0503bbcc190 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2516,7 +2516,7 @@ struct zap_details {
 void sched_mm_cid_before_execve(struct task_struct *t);
 void sched_mm_cid_after_execve(struct task_struct *t);
 void sched_mm_cid_fork(struct task_struct *t);
-void sched_mm_cid_exit_signals(struct task_struct *t);
+void sched_mm_cid_exit(struct task_struct *t);
 static inline int task_mm_cid(struct task_struct *t)
 {
 	return t->mm_cid;
@@ -2525,7 +2525,7 @@ static inline int task_mm_cid(struct task_struct *t)
 static inline void sched_mm_cid_before_execve(struct task_struct *t) { }
 static inline void sched_mm_cid_after_execve(struct task_struct *t) { }
 static inline void sched_mm_cid_fork(struct task_struct *t) { }
-static inline void sched_mm_cid_exit_signals(struct task_struct *t) { }
+static inline void sched_mm_cid_exit(struct task_struct *t) { }
 static inline int task_mm_cid(struct task_struct *t)
 {
 	/*
diff --git a/kernel/exit.c b/kernel/exit.c
index d60c1241923a9..de904800e630a 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -924,6 +924,7 @@ void __noreturn do_exit(long code)
 	user_events_exit(tsk);
 
 	io_uring_files_cancel();
+	sched_mm_cid_exit(tsk);
 	exit_signals(tsk);  /* sets PF_EXITING */
 
 	seccomp_filter_release(tsk);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 43f3ac16b0e8a..aad9813bd6171 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10545,7 +10545,7 @@ int __sched_mm_cid_migrate_from_try_steal_cid(struct rq *src_rq,
 	 *
 	 * The implicit barrier after cmpxchg per-mm/cpu cid before loading
 	 * rq->curr->mm_cid_active matches the barrier in
-	 * sched_mm_cid_exit_signals(), sched_mm_cid_before_execve(), and
+	 * sched_mm_cid_exit(), sched_mm_cid_before_execve(), and
 	 * sched_mm_cid_after_execve() between store to t->mm_cid_active and
 	 * load of per-mm/cpu cid.
 	 */
@@ -10665,7 +10665,7 @@ static void sched_mm_cid_remote_clear(struct mm_struct *mm, struct mm_cid *pcpu_
 	 *
 	 * The implicit barrier after cmpxchg per-mm/cpu cid before loading
 	 * rq->curr->mm_cid_active matches the barrier in
-	 * sched_mm_cid_exit_signals(), sched_mm_cid_before_execve(), and
+	 * sched_mm_cid_exit(), sched_mm_cid_before_execve(), and
 	 * sched_mm_cid_after_execve() between store to t->mm_cid_active and
 	 * load of per-mm/cpu cid.
 	 */
@@ -10810,7 +10810,7 @@ void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
 	task_work_add(curr, work, TWA_RESUME);
 }
 
-void sched_mm_cid_exit_signals(struct task_struct *t)
+void sched_mm_cid_exit(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
 	struct rq *rq;
diff --git a/kernel/signal.c b/kernel/signal.c
index b18f07a5b62d6..ec64845778457 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -3150,7 +3150,6 @@ void exit_signals(struct task_struct *tsk)
 	cgroup_threadgroup_change_begin(tsk);
 
 	if (thread_group_empty(tsk) || (tsk->signal->flags & SIGNAL_GROUP_EXIT)) {
-		sched_mm_cid_exit_signals(tsk);
 		tsk->flags |= PF_EXITING;
 		cgroup_threadgroup_change_end(tsk);
 		return;
@@ -3161,7 +3160,6 @@ void exit_signals(struct task_struct *tsk)
 	 * From now this task is not visible for group-wide signals,
 	 * see wants_signal(), do_signal_stop().
 	 */
-	sched_mm_cid_exit_signals(tsk);
 	tsk->flags |= PF_EXITING;
 
 	cgroup_threadgroup_change_end(tsk);
-- 
2.53.0

