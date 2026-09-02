Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9859369D72;
	Wed,  2 Sep 2026 17:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368885; cv=none; b=PKn5wbpczjETB5s3ZhmXrulUSxtrXUt8L1YIIKKnTjnmEMz8T0LD4d7rto/f+qxOUPgKOSFlA7TMeO88BjNoiMOGQpv+hOZpZ2J70q5DyRMTL4R26z5RKHa0vB/IFL7QoJT+WVYJ77wuDTMAfkjIBxzbjfIeHK0lyzcVd5bHrPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368885; c=relaxed/simple;
	bh=eCn7F+broTaEae20rMz/DqPUMU0WFOkDFFoSuv/hBik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LGjHppvUF5vJOOr9vos96K5xAoyOxefFWA9/26w9uo0LCeMSbx/ZNB9PeCXUVGHyxPCYv4NlxKJnD5cuSW7rhydccPeyUJF+Nm6elWfCOpKkcN/tYQU22gBKikBAqBRsLdoF1trhVrRKq64bIjzTk1Z2TGn+8gZFcJoFmH40VB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d78c393ca6f011f19a56ed5b684f684d-20260903
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:d3ce66d6-4c88-4a38-9acc-95b1be91bf53,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:e8bbfc6a371588ae186ee2ff3d0d7e09,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|865|898,TC:nil,Content:0|15|50,EDM:5
	|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d78c393ca6f011f19a56ed5b684f684d-20260903
X-User: liwanwu@kylinos.cn
Received: from kylinos.cn [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwanwu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 276297971; Thu, 03 Sep 2026 01:07:56 +0800
From: Wanwu Li <liwanwu@kylinos.cn>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: liwanwu@kylinos.cn,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] sched_ext: Fix NULL sched deref in kfunc sub-sched error paths
Date: Thu,  3 Sep 2026 01:07:51 +0800
Message-Id: <20260902170751.256434-1-liwanwu@kylinos.cn>
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

The COMPAT kfunc wrappers scx_bpf_select_cpu_and() and
scx_bpf_dsq_insert_vtime() error out @p's scheduler when the root
scheduler has sub-scheds attached:

	scx_error(scx_task_sched(p), "... must be used");

scx_task_sched(p) is p->scx.sched, which is NULL for any task that is not
on an scx scheduler: it is memset() by init_scx_entity() and cleared by
scx_disable_and_exit_task() -- which sched_ext_dead() runs when a task
exits. It is also an rcu_dereference_protected() that must be called with
@p's pi_lock or rq lock held, which neither wrapper does. Passing NULL to
scx_error() reaches scx_vexit(), which dereferences sch->exit_info
unconditionally, oopsing the kernel.

Both wrappers are reachable with such a @p. scx_bpf_select_cpu_and() is in
the select_cpu kfunc group, which scx_kfunc_context_filter() opens to
BPF_PROG_TYPE_SYSCALL programs. scx_bpf_dsq_insert_vtime() is in the
enqueue_dispatch group, which ops.enqueue() and ops.dispatch() may call
with any KF_RCU task: the group has no kf_tasks validation, and
scx_dsq_insert_preamble() checks task ownership with scx_task_on_sched()
precisely because @p may be an arbitrary task.

Neither wrapper requires a contrived @p. Tasks that are never enabled --
kthreads and tasks of other classes under SCX_SWITCH_ALL=n -- keep
p->scx.sched NULL indefinitely; and a task handed over from
bpf_task_from_pid() can exit before the call lands, as its zombie stays
visible to pid lookups until it is reaped.

One concrete trigger exercised for this changelog: a SYSCALL program
calling the select_cpu_and wrapper on an exited-but-not-reaped task while
a sub-scheduler is attached (faulting instruction is the scx_vexit()
prologue "mov r15,[rdi+0x398]" with RDI=NULL and 0x398 the offset of
sch->exit_info):

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
   ? rseq_set_ids_get_csaddr+0x81/0x140
   ? __rseq_handle_slowpath+0xd0/0x130
   ? switch_fpu_return+0x51/0xd0
   ? arch_exit_to_user_mode_prepare.constprop.0+0x87/0xb0
   ? do_syscall_64+0xf3/0x460
   ? irqentry_exit+0x48/0x740
   ? clear_bhb_loop+0x40/0x90
   ? do_syscall_64+0x35/0x460
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
   </TASK>

Keep the "error out @p's scheduler" attribution -- it is what every other
kfunc error path does (select_cpu_from_kfunc()'s cross_task,
scx_kf_arg_task_ok()) and it is correct for the callers that take this
path with a live task: p->scx.sched is their scheduler. Just read it
safely: use scx_task_sched_rcu() (valid under the guard(rcu)() both
wrappers already hold, no @p lock required) and fall back to @sch -- the
root scheduler, guaranteed non-NULL here -- when @p is not on an scx
scheduler, which is precisely the case that used to be NULL.

These COMPAT wrappers are scheduled for eventual removal once the
deprecation grace period elapses, but until then -- and regardless of
their removal timeline -- they must not oops the kernel on a task they
are handed; this fix makes the error path safe.

Cc: <stable@vger.kernel.org>
Fixes: a5fa0708cbfd ("sched_ext: Enforce scheduling authority in dispatch and select_cpu operations")
Signed-off-by: Wanwu Li <liwanwu@kylinos.cn>
---

Changes v1 -> v2:
 - Extend the same fallback to scx_bpf_dsq_insert_vtime() as suggested
   by Andrea (and flagged by sashiko-bot); rewrite the reachability
   argument in the commit message accordingly.

 kernel/sched/ext/ext.c  | 9 +++++++--
 kernel/sched/ext/idle.c | 9 +++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index 10af28a9f2c0..fdfaa7e9c8f5 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -8943,10 +8943,15 @@ __bpf_kfunc void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64 dsq_id,
 #ifdef CONFIG_EXT_SUB_SCHED
 	/*
 	 * Disallow if any sub-scheds are attached. There is no way to tell
-	 * which scheduler called us, just error out @p's scheduler.
+	 * which scheduler called us, so error out @p's scheduler -- but read
+	 * it under RCU (@p's locks aren't necessarily held here) and fall
+	 * back to @sch if @p isn't on an scx scheduler: enqueue/dispatch
+	 * contexts may pass any KF_RCU task, and p->scx.sched is NULL for
+	 * one that has exited or is managed by another scheduler.
 	 */
 	if (unlikely(!list_empty(&sch->children))) {
-		scx_error(scx_task_sched(p), "__scx_bpf_dsq_insert_vtime() must be used");
+		scx_error(scx_task_sched_rcu(p) ?: sch,
+			  "__scx_bpf_dsq_insert_vtime() must be used");
 		return;
 	}
 #endif
diff --git a/kernel/sched/ext/idle.c b/kernel/sched/ext/idle.c
index d2973fb3af6d..014599d82bb0 100644
--- a/kernel/sched/ext/idle.c
+++ b/kernel/sched/ext/idle.c
@@ -1142,10 +1142,15 @@ __bpf_kfunc s32 scx_bpf_select_cpu_and(struct task_struct *p, s32 prev_cpu, u64
 #ifdef CONFIG_EXT_SUB_SCHED
 	/*
 	 * Disallow if any sub-scheds are attached. There is no way to tell
-	 * which scheduler called us, just error out @p's scheduler.
+	 * which scheduler called us, so error out @p's scheduler -- but read
+	 * it under RCU (@p's locks aren't held here) and fall back to @sch if
+	 * @p isn't on an scx scheduler: a BPF_PROG_TYPE_SYSCALL prog can pass
+	 * any task and p->scx.sched is NULL for one that has exited or is
+	 * managed by another scheduler.
 	 */
 	if (unlikely(!list_empty(&sch->children))) {
-		scx_error(scx_task_sched(p), "__scx_bpf_select_cpu_and() must be used");
+		scx_error(scx_task_sched_rcu(p) ?: sch,
+			  "__scx_bpf_select_cpu_and() must be used");
 		return -EINVAL;
 	}
 #endif
-- 
2.25.1

