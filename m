Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F19446832
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 16:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784911504; cv=none; b=WAI8UOZdNCQdGyk9mvhHBkGXrNo59rTLolVVApkjDP9d9jlrMqCpoA/h6St9JM1Yyo9fz4VkpOAEPr4JY3/GVJ7JSyZN3SWJizZ1PSxW9SXwjbXXF2KrrizdGqMfonFxZabiuHLyEpHaQgypXe4sTdTCfZmh77xGBhOR/HnXpJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784911504; c=relaxed/simple;
	bh=RO39h6VnHf/8qL+DOENlbKV92uPosz8n7LehAljCIzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AooKYEAg6ULTajxNjJcaFGUXklZPCDYLgDzFgDHy089O8dc3Mqx8nuHXThvTFxvuYAul+vnL97JVnaFx044dXrd/jUHqzG7/UAKM6CLB8u3vD56yrZfCwj+dyS0i4AYeMwA+3wtWvCECDbe7rprqEIF9/WdxNB9q1BdhQIVXSLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwFFqmJ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwFFqmJ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C501F00A3D;
	Fri, 24 Jul 2026 16:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784911500;
	bh=dbNRZ3hC1DyE8Lw/nXLpkDSJOWPrRsI0ltFQVmhIdKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hwFFqmJ1DueB821aXdCXiBZWmKMY4/vttmgvw01i19dZU5LFwP9JS7cY2Xbgj4mDg
	 YpQikSu+aaoj9OFOXMb3pG9cXDj2upyXequLLCjZPUdZX4IWSTavvzCCL/XRqQT+wS
	 uv4UnGu6fe7IL7NGlvSCizv1jo+e5f0dc6owTdFi2tq5DJLSjqF/ny+bA4rmoJQQYC
	 VSl4xQ/SxMc5Bwjp3F8aFoPDWZYzy3TUp2AbKoSKGB24TRf0+gWL7i2GRLXWI6Nbiw
	 jUID33DoabYD5o7ysidcYJkCSssTjp0HA6G6akDu12rbtFhOAAM+MOmIBfujQ7bBIA
	 DYiM8h1M1DAKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] landlock: Fix LANDLOCK_SCOPE_SIGNAL bypass on the SIGIO path
Date: Fri, 24 Jul 2026 12:44:56 -0400
Message-ID: <20260724164456.469658-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724164456.469658-1-sashal@kernel.org>
References: <2026072036-petticoat-useable-12b3@gregkh>
 <20260724164456.469658-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bryam Vargas <hexlabsecurity@proton.me>

[ Upstream commit 4b80320ca7ed03d6e683f95b6066565dc97b9f92 ]

LANDLOCK_SCOPE_SIGNAL must prevent a sandboxed process from signaling
processes outside its Landlock domain.  It can be bypassed through the
asynchronous SIGIO delivery path.

A sandboxed process that owns any file or socket can arm it with
fcntl(fd, F_SETOWN, -pgid), fcntl(fd, F_SETSIG, SIGKILL) and O_ASYNC, so
that an I/O event makes the kernel deliver the chosen signal to the
whole process group.  As the head of its process group's task list (the
default position right after fork()) that group can also hold the
non-sandboxed process that launched it, e.g. a supervisor or a security
monitor.  The sandbox can thus kill or signal the processes
LANDLOCK_SCOPE_SIGNAL is meant to protect from it.

The scope is enforced in hook_file_send_sigiotask() against the Landlock
domain recorded at F_SETOWN time, not the live domain of the sender.
control_current_fowner() decides whether to record that domain and skips
recording it when the fowner target is in the caller's thread group,
which is safe only for a single-task target (PIDTYPE_PID, PIDTYPE_TGID).
For a process group (PIDTYPE_PGID) pid_task() returns only one member;
recording is skipped whenever that member shares the caller's thread
group, and hook_file_send_sigiotask() then lets the signal fan out to
the whole group unchecked.

Record the domain for every non single-process target so the scope is
enforced against each group member at delivery time.

That recording is necessary but not sufficient on its own: the kernel
signals a process group through its members' thread-group leaders, and
the leader of the registrant's own process can carry a different
Landlock domain than the sibling thread that armed the owner.
domain_is_scoped() would then deny that leader, even though commit
18eb75f3af40 ("landlock: Always allow signals between threads of the
same process") requires same-process delivery to be allowed.
hook_task_kill() avoids this by evaluating same_thread_group() live, per
recipient; the SIGIO path instead delegates the whole decision to a
single registration-time check, which a process-group fan-out cannot
honor.

So also record the registrant's thread group next to its domain and
exempt it at delivery: hook_file_send_sigiotask() allows the signal
whenever the recipient belongs to the registrant's own process,
restoring the same-process guarantee while keeping out-of-domain group
members blocked.  The direct kill() path (hook_task_kill) already
evaluates the live domain and is unaffected.

Fixes: 18eb75f3af40 ("landlock: Always allow signals between threads of the same process")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Reviewed-by: Günther Noack <gnoack3000@gmail.com>
Link: https://patch.msgid.link/56bffc24f3d0d08b45a686a48e99766b0a0821fa.1780614610.git.hexlabsecurity@proton.me
[mic: Check pid_type earlier and improve comment, fix commit message,
fix comment formatting]
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/landlock/fs.c   | 14 ++++++++++++++
 security/landlock/fs.h   | 10 ++++++++++
 security/landlock/task.c | 11 +++++++++++
 3 files changed, 35 insertions(+)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index da7089f6ad39e5..bb4a9e82156a69 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1665,6 +1665,14 @@ static bool control_current_fowner(struct fown_struct *const fown)
 	 */
 	lockdep_assert_held(&fown->lock);
 
+	/*
+	 * A process-group or session owner (PIDTYPE_PGID/PIDTYPE_SID) fans the
+	 * signal out to every member at delivery time, so record the domain and
+	 * let hook_file_send_sigiotask() check the live scope per recipient.
+	 */
+	if (fown->pid_type != PIDTYPE_PID && fown->pid_type != PIDTYPE_TGID)
+		return true;
+
 	/*
 	 * Some callers (e.g. fcntl_dirnotify) may not be in an RCU read-side
 	 * critical section.
@@ -1681,6 +1689,7 @@ static void hook_file_set_fowner(struct file *file)
 {
 	struct landlock_ruleset *prev_dom;
 	struct landlock_cred_security fown_subject = {};
+	struct pid *prev_tg, *fown_tg = NULL;
 	size_t fown_layer = 0;
 
 	/*
@@ -1706,21 +1715,26 @@ static void hook_file_set_fowner(struct file *file)
 		if (new_subject) {
 			landlock_get_ruleset(new_subject->domain);
 			fown_subject = *new_subject;
+			fown_tg = get_pid(task_tgid(current));
 		}
 	}
 
 	prev_dom = landlock_file(file)->fown_subject.domain;
+	prev_tg = landlock_file(file)->fown_tg;
 	landlock_file(file)->fown_subject = fown_subject;
+	landlock_file(file)->fown_tg = fown_tg;
 #ifdef CONFIG_AUDIT
 	landlock_file(file)->fown_layer = fown_layer;
 #endif /* CONFIG_AUDIT*/
 
 	/* May be called in an RCU read-side critical section. */
 	landlock_put_ruleset_deferred(prev_dom);
+	put_pid(prev_tg);
 }
 
 static void hook_file_free_security(struct file *file)
 {
+	put_pid(landlock_file(file)->fown_tg);
 	landlock_put_ruleset_deferred(landlock_file(file)->fown_subject.domain);
 }
 
diff --git a/security/landlock/fs.h b/security/landlock/fs.h
index 9a37b63a3b9abf..8b8c0415ea225c 100644
--- a/security/landlock/fs.h
+++ b/security/landlock/fs.h
@@ -70,6 +70,16 @@ struct landlock_file_security {
 	 * euid.
 	 */
 	struct landlock_cred_security fown_subject;
+	/**
+	 * @fown_tg: Thread group of the task that set the file owner, pinned
+	 * while @fown_subject holds a domain.  It lets
+	 * hook_file_send_sigiotask() always allow a SIGIO delivered to the
+	 * owner's own process -- e.g. the thread-group leader reached through a
+	 * process-group owner -- matching the same-process exemption of
+	 * hook_task_kill().  NULL when no domain is recorded.  Protected by
+	 * file->f_owner->lock, like @fown_subject.
+	 */
+	struct pid *fown_tg;
 };
 
 /**
diff --git a/security/landlock/task.c b/security/landlock/task.c
index 21e34deb09511c..085bbbf2fa7ef4 100644
--- a/security/landlock/task.c
+++ b/security/landlock/task.c
@@ -314,6 +314,17 @@ static int hook_file_send_sigiotask(struct task_struct *tsk,
 	if (!subject->domain)
 		return 0;
 
+	/*
+	 * Always allow delivery to the file owner's own process, including a
+	 * thread-group leader reached through a process-group owner.  This
+	 * mirrors hook_task_kill()'s same-process exemption and preserves the
+	 * guarantee of commit 18eb75f3af40 ("landlock: Always allow signals
+	 * between threads of the same process"), which the registration-time
+	 * check cannot honor for a process-group target.
+	 */
+	if (task_tgid(tsk) == landlock_file(fown->file)->fown_tg)
+		return 0;
+
 	scoped_guard(rcu)
 	{
 		is_scoped = domain_is_scoped(subject->domain,
-- 
2.53.0

