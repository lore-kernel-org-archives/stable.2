Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0702D876A;
	Sat, 22 Aug 2026 19:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787428475; cv=none; b=f96eh0gxu2COB85nZ8bBsou8yHnC/9P2BXqq6aDmb9iAm5g1XtBS0a/ex6SEwDBqeJrCmrCUvgcU86ckBRdBqk3Utu/zyu7VY7Jke+YSDo39nq3fty5TTP7OTM2Vff+vub8eD+8DQWOEb4Pjt/vXqVaGF9KI9v2ub7vmD896y34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787428475; c=relaxed/simple;
	bh=oC0m2aVmuluMDJHzqSlSyukSsSeeaOAZ+1l9yuhIinc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gqcWs2XJesoW4vp059dV3/TFLBZr0VlPepxKFSxaEh9NmgmdgtGWOI+imEzBHsXKH4w2aiukG1pXOEL5AD1FtMmrtDvidduXxAYqlIb9Yx8ODYNZJsSrHSl/sV21MKKhyU3xU4bPmg7ZvqmEgkZ5oPLDfydUGfKfjp8RarsZ9yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=T6/GK7x8; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="T6/GK7x8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DeaaWX1ouakkcNaKozCGuM3FyQea1VdOoTXNpsxvZMc=; b=T6/GK7x8daDmjTIhhuJdakugFd
	u7Sc7g4itfX3T8oyRt69Mi0c5BqmafQ47rpExNKShdb7iwNrpStR/OSQ9E05iJs0wTQjvGO+FAft9
	x+NrHhL/ea/6HZf/x5mIy+zuPCkpXG2Ot1uZ83LizlZGiHrWBUYrWWJZO28Dq2Qjc/jS77idsLC+n
	UYXRUW3Vpr3zawqUybI4xhGzOf723p0UPUB+QM6SSsAMTAspZ80WPek0IbsdUvTcu003SEk1C5JZ7
	DURbGM2VLeAR5Lg6G5OnbPmqtGqZEh+lkZ9q1S3jVKVkpnHg8QydXU4yKFgQErU8APehke3XQGF0u
	94bsmKlQ==;
Received: from [151.115.150.205] (port=58538 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1wxrnU-00000001KTo-1srE;
	Sat, 22 Aug 2026 21:54:31 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	mgorman@suse.de
Cc: include@grrlz.net,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	kees@kernel.org,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rostedt@goodmis.org,
	vschneid@redhat.com,
	linux-trace-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH v2] fork: initialize function graph state before copy_exec_state()
Date: Sat, 22 Aug 2026 19:53:22 +0000
Message-ID: <20260822195321.962383-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

dup_task_struct() copies the parent's task_struct, including ret_stack.
ftrace_graph_init_task() clears the copied function graph state, but it
currently runs after copy_exec_state().

For non-CLONE_VM forks, copy_exec_state() allocates a new task_exec_state.
If that allocation fails, copy_process() reaches bad_fork_free and
free_task() calls ftrace_graph_exit_task(). Since the child still carries
the parent's ret_stack pointer, the unwind frees the parent's active
function graph return stack. The parent subsequently accesses freed memory
from function_graph_enter_regs().

KASAN reports:

[   22.190920] ==================================================================
[   22.195899] BUG: KASAN: slab-use-after-free in function_graph_enter_regs+0xa76/0xb90
[   22.200747] Write of size 8 at addr ff110000054dc0a8 by task repro/1
[   22.205134]
[   22.210770] CPU: 0 UID: 0 PID: 1 Comm: repro Not tainted 7.2.0-07732-g9328b3b03bdc-dirty #3 PREEMPT(lazy)
[   22.212576] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   22.213750] Call Trace:
[   22.215271]  <TASK>
[   22.216242]  ? ftrace_stub_direct_tramp+0x10/0x10
[   22.217774]  dump_stack_lvl+0x4e/0x70
[   22.220531]  print_report+0x157/0x4b4
[   22.223202]  ? fixup_red_left+0x9/0x30
[   22.224407]  ? complete_report_info+0x83/0x110
[   22.226679]  ? function_graph_enter_regs+0xa76/0xb90
[   22.228084]  kasan_report+0xce/0x100
[   22.230109]  ? function_graph_enter_regs+0xa76/0xb90
[   22.232860]  ? stack_trace_save+0x4/0xd0
[   22.234156]  function_graph_enter_regs+0xa76/0xb90
[   22.236090]  ? kasan_save_stack+0x30/0x50
[   22.237752]  ? __pfx_function_graph_enter_regs+0x10/0x10
[   22.238694]  ? ring_buffer_lock_reserve+0x345/0xf80
[   22.239628]  ? stack_trace_save+0x4/0xd0
[   22.242121]  ? stack_trace_save+0x4/0xd0
[   22.243588]  ftrace_graph_func+0xda/0x160
[   22.245362]  ? ftrace_stub_direct_tramp+0x10/0x10
[   22.246520]  0xffffffffa0000095
[   22.250528]  ? stack_trace_save+0x9/0xd0
[   22.251757]  ? ring_buffer_unlock_commit+0x11d/0x5c0
[   22.253152]  stack_trace_save+0x9/0xd0
[   22.254264]  kasan_save_stack+0x30/0x50
[   22.273631]  kasan_save_track+0x14/0x30
[   22.276763]  kasan_save_free_info+0x3b/0x70
[   22.278296]  __kasan_slab_free+0x43/0x70
[   22.280157]  kmem_cache_free+0xbf/0x3b0
[   22.282963]  ? ftrace_stub_direct_tramp+0x10/0x10
[   22.284001]  free_task+0xa2/0x160
[   22.285699]  ? ftrace_stub_direct_tramp+0x10/0x10
[   22.286752]  copy_process+0x2aae/0x7bc0

Initialize the child function graph state immediately after
dup_task_struct(), before the first fallible operation.

Fixes: 6b1c66c9cca9 ("exec_state: relocate dumpable information")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
Resending v2 as requested by adding Cc: linux-trace-kernel@vger.kernel.org

Changes in v2:
- Add the KASAN report excerpt to the commit message.
- Add a comment documenting why ftrace_graph_init_task() must run before
  fallible initialization.

v1: https://lore.kernel.org/all/20260821102207.3626491-2-Jeremy.Jean@oss.cyber.gouv.fr/

 kernel/fork.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 1e68404bd773..0d1ad92e2d33 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2139,6 +2139,11 @@ __latent_entropy struct task_struct *copy_process(
 	p = dup_task_struct(current, node);
 	if (!p)
 		goto fork_out;
+	/*
+	 * Must run before the first fallible op, so error paths never
+	 * free the parent's ret_stack.
+	 */
+	ftrace_graph_init_task(p);
 	retval = copy_exec_state(clone_flags, p);
 	if (retval)
 		goto bad_fork_free;
@@ -2165,8 +2170,6 @@ __latent_entropy struct task_struct *copy_process(
 	 */
 	p->clear_child_tid = (clone_flags & CLONE_CHILD_CLEARTID) ? args->child_tid : NULL;
 
-	ftrace_graph_init_task(p);
-
 	rt_mutex_init_task(p);
 	raw_spin_lock_init(&p->blocked_lock);
 
-- 
2.47.3
