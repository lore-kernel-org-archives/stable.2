Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4864A92C0;
	Wed,  2 Sep 2026 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788363429; cv=none; b=ZlMMxec641ufjnvDX8ftOx9bs3gN9bxJep9UnRuNZw7UhYqodZIfFHu6llPuhMkBALB+pDH+LeNJ6lsxV1z4kbwB1xyWY+2WY3K4IEMrbZohVvSlldx4rQDYL8HSbWfu4yNsm4/LXIvVXx/AqzIgv9PcUI8jhnc6Mg9IPCdnhFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788363429; c=relaxed/simple;
	bh=CG8/3kCMtjiLTNK0gdJUbxQM90rolvY7/w/XS4Lx25s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MIk0oYmHsuqdC4KxudZ4orlS1UWap8/bjzSIOrS/QhDsSeESfF3TuWhomDgoN4WxEC5xFhTCrfinb5LkkI+Ss9AhjjuEPGdjtt4xMEEVentxDFnIb9OR8Z2fSpPV3hWzW2zAzPmOfV6/xnzcsKa5tEumwp3unoekpuM05Xz3dCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 1a35cac6a6e411f19a56ed5b684f684d-20260902
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:a1d729e3-57dc-44a3-b4d5-f7b21592b09c,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:e31e44d117130ee6641c1ccc2238a6a5,BulkI
	D:nil,BulkQuantity:0,SF:102|136|865|898,TC:nil,Content:0|15|50,EDM:5|-100,
	IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1a35cac6a6e411f19a56ed5b684f684d-20260902
X-User: liwanwu@kylinos.cn
Received: from kylinos.cn [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwanwu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1363887071; Wed, 02 Sep 2026 23:36:44 +0800
From: Wanwu Li <liwanwu@kylinos.cn>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: liwanwu@kylinos.cn,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] sched_ext: Fix NULL sched deref in select_cpu_and sub-sched error path
Date: Wed,  2 Sep 2026 23:36:40 +0800
Message-Id: <20260902153640.144791-1-liwanwu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_select_cpu_and() errors out @p's scheduler when the root scheduler
has sub-scheds attached:

	scx_error(scx_task_sched(p), "... must be used");

scx_task_sched(p) is p->scx.sched, which is NULL for any task that is not
on an scx scheduler: it is memset() by init_scx_entity() and cleared by
scx_disable_and_exit_task() -- which sched_ext_dead() runs when a task
exits. It is also an rcu_dereference_protected() that must be called with
@p's pi_lock or rq lock held -- neither of which a BPF_PROG_TYPE_SYSCALL
program holds.

The wrapper is reachable from such a program -- scx_kfunc_context_filter()
allows the select_cpu kfunc group for BPF_PROG_TYPE_SYSCALL -- and the
program can pass any task, e.g. one obtained with bpf_task_from_pid() that
exited in between. scx_error() then calls scx_vexit(), which dereferences
sch->exit_info unconditionally, so passing NULL oopses the kernel.

This was triggered live on a v7.2 based kernel with a
BPF_PROG_TYPE_SYSCALL program calling the wrapper on an exited-but-not
reaped task while a sub-scheduler was attached (faulting instruction is
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
scx_kf_arg_task_ok()) and it is correct for the callers that actually take
this path: the only other callers are the struct_ops select_cpu/enqueue
ops, where @p is the caller's own task and p->scx.sched is its scheduler.
Just read it safely: use scx_task_sched_rcu() (valid under the guard(rcu)()
the wrapper already holds, no @p lock required) and fall back to @sch -- the
root scheduler, guaranteed non-NULL here -- when @p is not on an scx
scheduler, which is precisely the case that used to be NULL.

scx_bpf_dsq_insert_vtime() has the same error path but it is not reachable
with a NULL @p: SYSCALL programs are rejected for its kfunc set and @p is
always the calling scheduler's own task in the contexts where it runs, so
it is left unchanged.

The proper endgame for these COMPAT wrappers is removal once the
deprecation grace period is announced and elapsed; this fix only keeps
the window from oopsing the kernel until that happens.

Cc: <stable@vger.kernel.org>
Fixes: a5fa0708cbfd ("sched_ext: Enforce scheduling authority in dispatch and select_cpu operations")
Signed-off-by: Wanwu Li <liwanwu@kylinos.cn>
---
 kernel/sched/ext/idle.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

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

