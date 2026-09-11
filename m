Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC214AA1E4;
	Fri, 11 Sep 2026 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150577; cv=none; b=NECDPvvtJ/7nAh/LyTap3ohh6oyTlsZPfWr1IDMJoTR2Kj931l/lI8rm4I9FyFHAo9muu9LnEDg9EiK4Ah6E72FsBMkN/sM5YNlF42UYdDDp5DNl0GgwYKdl1euojmvYcqz/oz+EMvUl2X4+Y2JPx/ZiVXVzbQh7sQT82u5aOAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150577; c=relaxed/simple;
	bh=unD1bACTbEL3QbNRseqgPpbhjnVkE5+IG8xF41To1EI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=bCarv/X5NUGjtA2tzK9G2OQCwRMlhbF2kk2jmcEbbWj+k8J3RYfrGA7eGZEH4gKet0x6guCBeQ5vA0ggOWUpo3LjAzkZh1hn5CfM3cyVdEPMBYEmBU4vVQYVEsllIYb+Mkvp34pcDw/gzHNz/HFtPrwNhY6XbkVVuWjiQREDDMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZlnZvSP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZlnZvSP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C831F0089A;
	Fri, 11 Sep 2026 18:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789150567;
	bh=7aBkvDAjs0rhAtrLr4xdw2vsPlHvsQzthg8lSC73E0o=;
	h=Date:From:To:Cc:Subject:References;
	b=iZlnZvSPk7pUxcflIhM2uPzZasm3skZ1jyQcuSKJtMnLtGofumD0s2dG9AaD443xb
	 eAuAs5rMT1TyYvFwm+2MSanJUyc7duxJn8i6enFLtPb/IS7hnNsE4sPOUOq1zzfBpZ
	 ZTLZEm+t1bdKFgO6S8WE8YrOztO8Phb1kvOD2Q6aQFuBvzd4gV9NiT7ABzNQgnjAi3
	 wacaEm7FXflDdp4wft7wuC7Hogf7MNqNdJRjphFkL7fLwUndSUKFH8tCWtP1XAsYmk
	 Ox1+mhPCYBpHi8WomvXfDM5jmtJiBGWRqjYYXwBnMWUB3rjK2tFY2RHf32WY+7NShp
	 4yGtpu23dK6Qg==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x55oW-000000094vZ-37Ue;
	Fri, 11 Sep 2026 14:17:28 -0400
Message-ID: <20260911181728.537106536@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 11 Sep 2026 14:16:38 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Bradley Morgan <include@grrlz.net>,
 =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [for-linus][PATCH 02/20] ftrace: fork: Initialize function graph state before
 copy_exec_state()
References: <20260911181636.485043797@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>

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

Cc: stable@vger.kernel.org
Fixes: 6b1c66c9cca9 ("exec_state: relocate dumpable information")
Reviewed-by: Bradley Morgan <include@grrlz.net>
Link: https://patch.msgid.link/20260822195321.962383-2-Jeremy.Jean@oss.cyber.gouv.fr
Assisted-by: Codex:gpt-5
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/fork.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 416758c8a3d4..a5934a317634 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2133,6 +2133,11 @@ __latent_entropy struct task_struct *copy_process(
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
@@ -2159,8 +2164,6 @@ __latent_entropy struct task_struct *copy_process(
 	 */
 	p->clear_child_tid = (clone_flags & CLONE_CHILD_CLEARTID) ? args->child_tid : NULL;
 
-	ftrace_graph_init_task(p);
-
 	rt_mutex_init_task(p);
 	raw_spin_lock_init(&p->blocked_lock);
 
-- 
2.53.0
