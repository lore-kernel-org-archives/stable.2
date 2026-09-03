Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1D31E1024;
	Thu,  3 Sep 2026 06:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788415602; cv=none; b=NPUgFoyS1vxgyxrTFS4WpK9p+wh5dB/reji1P4+zoGxZOhRvcgMwBHa4MLbNZYY0z7RnRuh6P/5/hMFCcQ7enUC4+qN5/L+KmQtQxxbCWzWv5bd1cjXQ/uwsGzsiaBqk1Y2ncjiL+g1cbBnoTAy3AXxAaje/ALK0g4oZWrclXZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788415602; c=relaxed/simple;
	bh=lOSn/f9jt6mTrrG7e4IjgLXfRnOgYfEpAOEkik4BAhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VBr6g3M8pbRCDLwT3pmPdSCdUTbK1VJahrzPVz21ggrmJwyHHsDCg4rJQQ5Kim/9daiJp1BJtz4pRBoq6k2HSchS5Z54ygV08HlrAgJv7GVhzSxjD6fFCA5Q+odt1F/FgbHXu3g7U9d5XjrjptWn2LUQ/ETJRQ+Yc2nqrZy4714=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9b7d3e10a75d11f19a56ed5b684f684d-20260903
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:0318e8aa-d825-4da4-a047-b1c7d9a7f534,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:663bb308bbb91c4a085768d6b4c7daf0,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|865|898,TC:nil,Content:0|15|50,EDM:5
	|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9b7d3e10a75d11f19a56ed5b684f684d-20260903
X-User: liwanwu@kylinos.cn
Received: from kylinos.cn [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwanwu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1425286893; Thu, 03 Sep 2026 14:06:30 +0800
From: Wanwu Li <liwanwu@kylinos.cn>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Wanwu Li <liwanwu@kylinos.cn>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] sched_ext: Fix NULL sched deref in kfunc sub-sched error paths
Date: Thu,  3 Sep 2026 14:06:26 +0800
Message-Id: <20260903060626.814951-1-liwanwu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260902153640.144791-1-liwanwu@kylinos.cn>
References: <20260902153640.144791-1-liwanwu@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the root scheduler has sub-scheds attached, the COMPAT kfunc
wrappers scx_bpf_select_cpu_and() and scx_bpf_dsq_insert_vtime() refuse
the call and report to @p's scheduler:

	scx_error(scx_task_sched(p), "... must be used");

The wrappers are reachable with tasks that have no scheduler.
scx_bpf_select_cpu_and() is in the select_cpu kfunc group, which
scx_kfunc_context_filter() opens to BPF_PROG_TYPE_SYSCALL programs;
scx_bpf_dsq_insert_vtime() is in the enqueue_dispatch group, which
ops.enqueue() and ops.dispatch() may call with any KF_RCU task -- the
group has no kf_tasks validation, and scx_dsq_insert_preamble() checks
task ownership with scx_task_on_sched() precisely because @p may be an
arbitrary task.

scx_task_sched(p) is p->scx.sched, which is NULL for tasks past
sched_ext_dead() -- which clears it via scx_disable_and_exit_task() on
exit -- and for idle tasks, which the enable paths skip as they are
never scheduled through SCX. It is also an rcu_dereference_protected()
that expects @p's pi_lock or rq lock, which neither wrapper holds.
Passing NULL to scx_error() reaches scx_vexit(), which dereferences
sch->exit_info, oopsing the kernel.

One concrete trigger exercised while developing the fix: a
BPF_PROG_TYPE_SYSCALL program calling the select_cpu_and wrapper on an
exited-but-not-reaped task while a sub-scheduler was attached (its pid
stays findable while the zombie is unreaped; faulting instruction is
the scx_vexit() prologue "mov r15,[rdi+0x398]" with RDI=NULL and 0x398
the offset of sch->exit_info):

  sched_ext: BPF scheduler "kfunc_subsched_null" enabled
  sched_ext: BPF sub-scheduler "kfunc_subsched_null" enabled
  sched_ext: Unassociated program run_select_cpu_ (id 76)
  BUG: kernel NULL pointer dereference, address: 0000000000000398
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  Oops: Oops: 0000 [#1] SMP NOPTI
  CPU: 7 UID: 0 PID: 8201 Comm: kfunc_test_runn Tainted: G W
  RIP: 0010:scx_vexit+0x25/0xa0
  Code: ... <4c> 8b bf 98 03 00 00 ...
  CR2: 0000000000000398
  Call Trace:
   <TASK>
   __scx_exit+0x4f/0x70
   scx_bpf_select_cpu_and+0xab/0xb0
   bpf_prog_430ed61a7b66e03a_run_select_cpu_and+0x9c/0xe7
   ? __x64_sys_bpf+0x2c/0x40
   bpf_prog_test_run_syscall+0x130/0x2f0
   __sys_bpf+0x930/0x10d0
   ? __x64_sys_bpf+0x2c/0x40
   __x64_sys_bpf+0x2c/0x40
   do_syscall_64+0xbc/0x460
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
   </TASK>

Read @p's scheduler under RCU instead, which the wrappers can do from
their guard(rcu)(): fault it when it can be determined, and when it
can't be determined -- @p is a task past sched_ext_dead() or an idle
task -- there is nothing obviously wrong to report, so just refuse the
call as before without faulting any scheduler.

These COMPAT wrappers are scheduled for eventual removal once the
deprecation grace period elapses, but until then -- and regardless of
their removal timeline -- they must not oops the kernel on a task they
are handed.

Cc: <stable@vger.kernel.org>
Fixes: a5fa0708cbfd ("sched_ext: Enforce scheduling authority in dispatch and select_cpu operations")
Suggested-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Wanwu Li <liwanwu@kylinos.cn>
---

Changes v2 -> v3:
 - Per Tejun: when the task's scheduler can't be determined (tasks past
   sched_ext_dead() and idle tasks), refuse the call instead of faulting
   the root scheduler; keep faulting @p's scheduler when determinable.
 - Update the comments: fix the wording.

 kernel/sched/ext/ext.c  | 11 +++++++++--
 kernel/sched/ext/idle.c | 11 +++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 10af28a9f2c0..1c9e4eace89e 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -8943,10 +8943,17 @@ __bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id,
 #ifdef CONFIG_EXT_SUB_SCHED
 	/*
 	 * Disallow if any sub-scheds are attached. There is no way to tell
-	 * which scheduler called us, just error out @p's scheduler.
+	 * which scheduler called us, so error out @p's scheduler -- read it
+	 * under RCU as @p's locks aren't necessarily held here. @p may be a
+	 * task past sched_ext_dead() or an idle task, in which case its
+	 * scheduler can't be determined and there is nothing obviously wrong
+	 * to report; just refuse the call.
 	 */
 	if (unlikely(!list_empty(&sch->children))) {
-		scx_error(scx_task_sched(p), "__scx_bpf_dsq_insert_vtime() must be used");
+		struct scx_sched *tsch = scx_task_sched_rcu(p);
+
+		if (tsch)
+			scx_error(tsch, "__scx_bpf_dsq_insert_vtime() must be used");
 		return;
 	}
 #endif
diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
index d2973fb3af6d..aa9fb6de0ad6 100644
--- a/kernel/sched/ext/idle.c
+++ b/kernel/sched/ext/idle.c
@@ -1142,10 +1142,17 @@ __bpf_kfunc s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64
 #ifdef CONFIG_EXT_SUB_SCHED
 	/*
 	 * Disallow if any sub-scheds are attached. There is no way to tell
-	 * which scheduler called us, just error out @p's scheduler.
+	 * which scheduler called us, so error out @p's scheduler -- read it
+	 * under RCU as @p's locks aren't necessarily held here. @p may be a
+	 * task past sched_ext_dead() or an idle task, in which case its
+	 * scheduler can't be determined and there is nothing obviously wrong
+	 * to report; just refuse the call.
 	 */
 	if (unlikely(!list_empty(&sch->children))) {
-		scx_error(scx_task_sched(p), "__scx_bpf_select_cpu_and() must be used");
+		struct scx_sched *tsch = scx_task_sched_rcu(p);
+
+		if (tsch)
+			scx_error(tsch, "__scx_bpf_select_cpu_and() must be used");
 		return -EINVAL;
 	}
 #endif
-- 
2.25.1

