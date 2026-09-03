Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDDF4A499D
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445972; cv=none; b=d7uyS43N7vJybGsNZap9jhaPdOwtWI8lCsqNEdzRHX+UOjlTc1rYSsL++w281c4+plnTtuSA7NN2i4cb86t+d45etEs0BuXPm6o9NUyqkGd/F726inam3HKizbW1Zvds1nS92C0xNxegdQoR9uSgMGS/XQkXGWD/OME7EPdEum0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445972; c=relaxed/simple;
	bh=t8wHT9zi3At8RDk4JeZBrayXjYsbZkqfuFzYFnv9Nvw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ousNKgwsYzXRSrtssgaWj6rKNJthkYwZr6mWmB4GrE6V5FucjNXRBxNT5VQJKd1/l5iafUM9dt2JbSuLUWw99ciTrXtTgCVEyktevASc7OS+bL4tWXUO66LOP5cPHWEb76wFgWSFNRrPBlwmYmFPNSOo0be+y8ms5pR9PY6uxtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K2VGAPyu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K2VGAPyu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6861A1F00A3D;
	Thu,  3 Sep 2026 14:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445962;
	bh=OCbAklC0SBWyWjcRf+bSZpvYyiwyB8eex1ZzKVLcrcw=;
	h=Subject:To:Cc:From:Date;
	b=K2VGAPyulynm9XNDa060o31ReNYE8J6jS4QfD4fXykgeaIW8ZPGyZYRdcFdpxxEE/
	 /vf5GUDQSiRXjjl4nwY4Z3tPzBc9YXhlQ2WfnLUTKQm0eV+VvXzQe6iFiIjryP3ZQZ
	 3+aliEeeeqG4pYjCgLpv2UsWjHPsDbXEs+moZgT4=
Subject: FAILED: patch "[PATCH] sched_ext: Fix inverted ops.core_sched_before() invocation" failed to apply to 6.18-stable tree
To: tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:14:59 +0200
Message-ID: <2026090359-grew-grab-d96a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x f7b6d128dd49a6eec09066ecfd29095f12588786
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090359-grew-grab-d96a@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f7b6d128dd49a6eec09066ecfd29095f12588786 Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Sat, 15 Aug 2026 13:08:28 -1000
Subject: [PATCH] sched_ext: Fix inverted ops.core_sched_before() invocation

scx_prio_less() implements prio_less() semantics - %true means that @a is
the lower priority and should run after @b. ops.core_sched_before() is
documented to return %true when @a should run before @b. scx_prio_less()
returns the op's value as-is, inverting the documented semantics at runtime.

Call the op with the arguments swapped.

scx_qmap followed the wiring instead of the documentation and returned %true
for the younger task, so the two inversions canceled out and it behaved as
intended. Flip its comparison to match. scx_qmap is likely the only current
user in or out of the kernel tree. Any scheduler written the same way needs
the same flip, while schedulers following the documentation are fixed by
this change.

Fixes: 7b0888b7cc19 ("sched_ext: Implement core-sched support")
Cc: stable@vger.kernel.org # v6.12+
Signed-off-by: Tejun Heo <tj@kernel.org>

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 2ae1df58939d..9014c814a00a 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -3528,6 +3528,8 @@ void ext_server_init(struct rq *rq)
  *
  * When ops.core_sched_before() is enabled, @p->scx.core_sched_at is used to
  * implement FIFO ordering within each local DSQ. See pick_task_scx().
+ *
+ * Return: %true if @a should run after @b.
  */
 bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 		   bool in_fi)
@@ -3536,6 +3538,10 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 	struct scx_sched *sch_b = scx_task_sched(b);
 
 	/*
+	 * scx_prio_less() returns whether @a should run after @b while
+	 * ops.core_sched_before() returns whether its first argument should run
+	 * before the second. Swap the arguments.
+	 *
 	 * The const qualifiers are dropped from task_struct pointers when
 	 * calling ops.core_sched_before(). Accesses are controlled by the
 	 * verifier.
@@ -3544,8 +3550,8 @@ bool scx_prio_less(const struct task_struct *a, const struct task_struct *b,
 	    !scx_bypassing(sch_a, task_cpu(a)))
 		return SCX_CALL_OP_2TASKS_RET(sch_a, core_sched_before,
 					      task_rq(a),
-					      (struct task_struct *)a,
-					      (struct task_struct *)b);
+					      (struct task_struct *)b,
+					      (struct task_struct *)a);
 	else
 		return time_after64(a->scx.core_sched_at, b->scx.core_sched_at);
 }
diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index dd0434437835..723f45fe0cbc 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -900,7 +900,7 @@ static s64 task_qdist(struct task_struct *p)
 bool BPF_STRUCT_OPS(qmap_core_sched_before,
 		    struct task_struct *a, struct task_struct *b)
 {
-	return task_qdist(a) > task_qdist(b);
+	return task_qdist(a) < task_qdist(b);
 }
 
 /*

