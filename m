Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B8F49364E;
	Sat, 22 Aug 2026 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.218.207.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787398450; cv=none; b=sK8tjeG/qDApBmHXLxfIcprOz8L/ySalNv5PyCoZcmEpPVSHX6HKrW/J6WwHas7xTp2mQY+RbIyrA18mbwIJ9Kt69Rwq9ruvT5KlkFLbzqLr1T8/GY96lo+/yzzdslj6mztAabTsIREQnOkKLdfc9JHMkda/CAXexiXk1IauV6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787398450; c=relaxed/simple;
	bh=BeEQDRK5kvzoxQya7wjOGqUv/zUe80AGzaNawRrsI/U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=N444SSeduKqSncFGf/MQEm2UJPvYKRviCS/4ttao9UsDZmQ43uTk5jL5XAVOOikWpa2vTJ7MCIPch9kZQ5tZV83DSJCQvsUp2qUw/En7l9dTo3IwQ5TolsiYVZyA9QRa+gIBjk9FYg1/6DwE5ym0HpbrAkJhhXd/sceRFWToWpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=g3XcHBIG; arc=none smtp.client-ip=185.218.207.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="g3XcHBIG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1787398443;
	bh=GNwyVkbrl/IZdn/NaEk3v2rcVEw/q2TX5VaMaY7Fz6A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=g3XcHBIGCwsDyRRltTA0CXu6mdQ3t4HGha31MglU1M7NlMpj/jeh0+kFAcIgLu9os
	 193Cse5ZjVk1d2pXg1/47VABuzinLhWeN43czqHojC4XvKbDwSj6UGUzVv30+mZnhD
	 RQ3hmNlvcrmak+RJg0vPnvx4j7dPlq/eKzMvi9nc=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4hRw6z52rGzGpCY;
	Sat, 22 Aug 2026 11:34:03 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4hRw6z1sVRzGpCG;
	Sat, 22 Aug 2026 11:34:03 +0000 (UTC)
Date: Sat, 22 Aug 2026 12:28:17 +0100
From: Bradley Morgan <include@grrlz.net>
To: =?ISO-8859-1?Q?J=E9r=E9my_Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, mgorman@suse.de
CC: bsegall@google.com, dietmar.eggemann@arm.com, kees@kernel.org,
 kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 rostedt@goodmis.org, vschneid@redhat.com, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_fork=3A_initialize_functi?=
 =?US-ASCII?Q?on_graph_state_before_copy=5Fexec=5Fstate=28=29?=
In-Reply-To: <20260822084927.547141-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260822084927.547141-2-Jeremy.Jean@oss.cyber.gouv.fr>
Message-ID: <E33C59B8-755C-403F-A06C-7B7DE3F81926@grrlz.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 22 August 2026 09:49:27 BST, "Jérémy Jean"
<Jeremy.Jean@oss.cyber.gouv.fr> wrote:
>dup_task_struct() copies the parent's task_struct, including ret_stack.
>ftrace_graph_init_task() clears the copied function graph state, but it
>currently runs after copy_exec_state().
>
>For non-CLONE_VM forks, copy_exec_state() allocates a new task_exec_state.
>If that allocation fails, copy_process() reaches bad_fork_free and
>free_task() calls ftrace_graph_exit_task(). Since the child still carries
>the parent's ret_stack pointer, the unwind frees the parent's active
>function graph return stack. The parent subsequently accesses freed memory
>from function_graph_enter_regs().
>

Wow! Real life use case?


>KASAN reports:
>
>[   22.190920]
>==================================================================
>[   22.195899] BUG: KASAN: slab-use-after-free in
>function_graph_enter_regs+0xa76/0xb90
>[   22.200747] Write of size 8 at addr ff110000054dc0a8 by task repro/1
>[   22.205134]
>[   22.210770] CPU: 0 UID: 0 PID: 1 Comm: repro Not tainted
>7.2.0-07732-g9328b3b03bdc-dirty #3 PREEMPT(lazy)
>[   22.212576] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>1.16.3-debian-1.16.3-2 04/01/2014
>[   22.213750] Call Trace:
>[   22.215271]  <TASK>
>[   22.216242]  ? ftrace_stub_direct_tramp+0x10/0x10
>[   22.217774]  dump_stack_lvl+0x4e/0x70
>[   22.220531]  print_report+0x157/0x4b4
>[   22.223202]  ? fixup_red_left+0x9/0x30
>[   22.224407]  ? complete_report_info+0x83/0x110
>[   22.226679]  ? function_graph_enter_regs+0xa76/0xb90
>[   22.228084]  kasan_report+0xce/0x100
>[   22.230109]  ? function_graph_enter_regs+0xa76/0xb90
>[   22.232860]  ? stack_trace_save+0x4/0xd0
>[   22.234156]  function_graph_enter_regs+0xa76/0xb90
>[   22.236090]  ? kasan_save_stack+0x30/0x50
>[   22.237752]  ? __pfx_function_graph_enter_regs+0x10/0x10
>[   22.238694]  ? ring_buffer_lock_reserve+0x345/0xf80
>[   22.239628]  ? stack_trace_save+0x4/0xd0
>[   22.242121]  ? stack_trace_save+0x4/0xd0
>[   22.243588]  ftrace_graph_func+0xda/0x160
>[   22.245362]  ? ftrace_stub_direct_tramp+0x10/0x10
>[   22.246520]  0xffffffffa0000095
>[   22.250528]  ? stack_trace_save+0x9/0xd0
>[   22.251757]  ? ring_buffer_unlock_commit+0x11d/0x5c0
>[   22.253152]  stack_trace_save+0x9/0xd0
>[   22.254264]  kasan_save_stack+0x30/0x50
>[   22.273631]  kasan_save_track+0x14/0x30
>[   22.276763]  kasan_save_free_info+0x3b/0x70
>[   22.278296]  __kasan_slab_free+0x43/0x70
>[   22.280157]  kmem_cache_free+0xbf/0x3b0
>[   22.282963]  ? ftrace_stub_direct_tramp+0x10/0x10
>[   22.284001]  free_task+0xa2/0x160
>[   22.285699]  ? ftrace_stub_direct_tramp+0x10/0x10
>[   22.286752]  copy_process+0x2aae/0x7bc0
>

I see.

>Initialize the child function graph state immediately after
>dup_task_struct(), before the first fallible operation.
>
>Fixes: 6b1c66c9cca9 ("exec_state: relocate dumpable information")

Ack.

>Cc: stable@vger.kernel.org
>Assisted-by: Codex:gpt-5

Good, declared AI.

Reviewed-by: Bradley Morgan <include@grrlz.net>


>Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
>---
>Changes in v2:
>- Add the KASAN report excerpt to the commit message.
>- Add a comment documenting why ftrace_graph_init_task() must run before
>  fallible initialization.
>
>v1: https://lore.kernel.org/all/20260821102207.3626491-2-Jeremy.Jean@oss.cyber.gouv.fr/
>
> kernel/fork.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>
>diff --git a/kernel/fork.c b/kernel/fork.c
>index 1e68404bd773..0d1ad92e2d33 100644
>--- a/kernel/fork.c
>+++ b/kernel/fork.c
>@@ -2139,6 +2139,11 @@ __latent_entropy struct task_struct *copy_process(
> 	p = dup_task_struct(current, node);
> 	if (!p)
> 		goto fork_out;
>+	/*
>+	 * Must run before the first fallible op, so error paths never
>+	 * free the parent's ret_stack.
>+	 */

Used my suggestion, good.

↓ good fix.

>+	ftrace_graph_init_task(p);
> 	retval = copy_exec_state(clone_flags, p);
> 	if (retval)
> 		goto bad_fork_free;
>@@ -2165,8 +2170,6 @@ __latent_entropy struct task_struct *copy_process(
> 	 */
> 	p->clear_child_tid = (clone_flags & CLONE_CHILD_CLEARTID) ? args->child_tid : NULL;
> 
>-	ftrace_graph_init_task(p);
>-
> 	rt_mutex_init_task(p);
> 	raw_spin_lock_init(&p->blocked_lock);
> 
>

Thanks!
