Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0324B1C5F27;
	Wed, 24 Jun 2026 06:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782281854; cv=none; b=bgOKgL0dBh9LNYDOxIznpMbgndt5O5TTrjddpHwAgtRFQuho45xTltUO04a1A+hojLpYmK14DwXn3epgmy0+Hld1249twfJ8jRl1sdm1FasZ8ib9XDJmiUYxBr5runJ6LZ9MEn51T7Q6jJh9l/xxbJ6iMueqebf4yheZ4r07Ymc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782281854; c=relaxed/simple;
	bh=v90PhLcJLyT/2ztDpcv2ajbHy++PTPvl6RpvzQ986F0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EJiRft2t6TR7OB7qyiRbsw71CAI0IoQs2qxg380So1dqdrgEvNjRSYT5vpBqDVQF0ilE2hFb+7bq65DoxBgJpwZPSwnvWvX9eVE/fnvTo0bKfm7f5Dhm6A2Bns2+vP62o4OU5YTtQq4IcWlqAGr30+cJFqgQvq+z/MfbSs1rfkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LXvPmPBy; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LXvPmPBy"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782281848; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=gPiqJ8EAvjFK9ofq3L0YUNV8mpGt7xsTx92E0OJpExs=;
	b=LXvPmPByvJkKPLZHODThPUuDSsxIUTLPP4NqxWdJ73r1tRAocZmSsu+/BjdtYXcaVGdw0wawW/ejmhkfQ1LNpGoLHW07D+DtBLWkHdPrO6WukAN+5/aToxAuKYY+Htsl/TlYmDkd0hcb9R6CdR+FSEjWXeW3SSzJH0pzlcWX37I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X5X8Ig5_1782281838;
Received: from localhost.localdomain(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0X5X8Ig5_1782281838 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 24 Jun 2026 14:17:27 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuanhe Shu <xiangzao@linux.alibaba.com>
Subject: [PATCH] tracing: Fix NULL pointer dereference in func_set_flag()
Date: Wed, 24 Jun 2026 14:17:15 +0800
Message-Id: <20260624061715.1445655-1-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

func_set_flag() dereferences tr->current_trace_flags before verifying
that the current tracer is actually the function tracer. When the active
tracer has been switched away from "function" (e.g., to "wakeup_rt"),
tr->current_trace_flags can be NULL, leading to a NULL pointer
dereference and kernel crash.

The call chain that triggers this is:

  trace_options_write()
    -> __set_tracer_option()
      -> trace->set_flag()          /* func_set_flag */

In func_set_flag(), the first operation is:

  if (!!set == !!(tr->current_trace_flags->val & bit))

This dereferences tr->current_trace_flags unconditionally. The safety
check that guards against a non-function tracer:

  if (tr->current_trace != &function_trace)
      return 0;

is placed *after* the dereference, which is too late.

This was observed with the following crash dump:

  BUG: unable to handle page fault at 0000000000000000
  RIP: func_set_flag+0xd

  Call Trace:
   __set_tracer_option+0x27
   trace_options_write+0x75
   vfs_write+0x12a
   ksys_write+0x66
   do_syscall_64+0x5b

  RIP: ffffffff914c973d  RSP: ff67ec88b01dfdf0  RFLAGS: 00010202
  RAX: 0000000000000000  RBX: ff3a826e80354580  RCX: 0000000000000001
  RDX: 0000000000000001  RSI: 0000000000000000  RDI: ffffffff93918080

The disassembly confirms the fault:

  func_set_flag+0:   mov 0x1f08(%rdi), %rax  ; RAX = tr->current_trace_flags = NULL
  func_set_flag+13:  mov (%rax), %eax        ; page fault: dereference NULL

At the time of the crash:
  tr->current_trace_flags = 0x0 (NULL)
  tr->current_trace = wakeup_rt_tracer (not function_trace)

The scenario is that a process opens a function tracer option file (such
as "func_stack_trace"), then the current tracer is switched to another
tracer (e.g., "wakeup_rt"), which sets current_trace_flags to NULL. When
the process subsequently writes to the option file, func_set_flag() is
invoked and crashes on the NULL dereference.

Fix this by moving the current_trace check before the
current_trace_flags dereference, so that func_set_flag() returns early
when the function tracer is not active.

Cc: stable@vger.kernel.org
Fixes: 76680d0d2825 ("tracing: Have function tracer define options per instance")
Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
---
 kernel/trace/trace_functions.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index f283391a4dc8..cd37f2013758 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -458,12 +458,12 @@ func_set_flag(struct trace_array *tr, u32 old_flags, u32 bit, int set)
 	ftrace_func_t func;
 	u32 new_flags;
 
-	/* Do nothing if already set. */
-	if (!!set == !!(tr->current_trace_flags->val & bit))
+	/* We can change this flag only when current tracer is function. */
+	if (tr->current_trace != &function_trace)
 		return 0;
 
-	/* We can change this flag only when not running. */
-	if (tr->current_trace != &function_trace)
+	/* Do nothing if already set. */
+	if (!!set == !!(tr->current_trace_flags->val & bit))
 		return 0;
 
 	new_flags = (tr->current_trace_flags->val & ~bit) | (set ? bit : 0);
-- 
2.39.3

