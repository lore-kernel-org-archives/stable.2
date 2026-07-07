Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1773EEAD8;
	Tue,  7 Jul 2026 13:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431986; cv=none; b=NipWiD+M0jXON+ov6FERC4+70pU93bP3sHSTJgug830ZjUt07Fo2kK5M2fx5/TzVfMZTHvZPrYjC6MbSFIvZvZ8QawEgHsnwpeNUGkOkGvMGnu0cmdBt+4wNjzYxZH1qvh3gzVQnLxPec9FD4yC1HBYJqMQKRmDOWQdR8zC6H3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431986; c=relaxed/simple;
	bh=tq84YEo3uEFicX8sVU+wKegoxHiFpBmXLpEEQASSvWk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=j6kcjrNq39JJ4cSa9XVwlTvHB5odXH18xM0vHRtC28n/ZnXgOwW8GbnmVuFc45CSSXhvi/TyYThYN275GskepK8tB6x2DJyS8hVTze1WR+SvpsZLB2xkEsPtrms2oIxRDQxhT+72Q7j51krNA09JeEUEf8VGHdrJbGlvCUlB5gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlSVuqmz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlSVuqmz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5FB1F00ACF;
	Tue,  7 Jul 2026 13:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783431981;
	bh=1szJZljH02omY2Ww9SrDCXdxI4Kcz1WoHMgPxBUtJHI=;
	h=Date:From:To:Cc:Subject:References;
	b=jlSVuqmzxXvqx/ru3V8L0g6PhE87Jd7soPv8W5ToC5LtocVGREyr3zM989G2XQHbE
	 2fLbflWx5wXyAQvS49aCqv7NYnwwt7aDwEdV8mDpy893bZFpor3fUFbNyJFJ/CI/rw
	 LzdppwfxtOtxu9Be/6rxcfg2eWNLpiiad1d1Fs+RC2SM0cJN2Dmp+c+oyI27C80WIY
	 n5ZLvs4P1JTnJ4a+1G2ElZ+SuZ10IEaKI7/8g86/VQzE6qNMhbCMyVDzVydlgbzxe7
	 Ij6i6z42qBTpCZfoGrXp9Nkb3iAeeJtDQKRsc83ZP1AQbZ1xLBzw3MVoMS97sI0RuQ
	 8CD2GitIxK7Xg==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wh680-00000000h5a-49lj;
	Tue, 07 Jul 2026 09:46:24 -0400
Message-ID: <20260707134624.833964338@kernel.org>
User-Agent: quilt/0.69
Date: Tue, 07 Jul 2026 09:46:14 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Yuanhe Shu <xiangzao@linux.alibaba.com>
Subject: [for-linus][PATCH 10/13] tracing: Fix NULL pointer dereference in func_set_flag()
References: <20260707134604.275787924@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Yuanhe Shu <xiangzao@linux.alibaba.com>

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
Link: https://patch.msgid.link/20260624061715.1445655-1-xiangzao@linux.alibaba.com
Fixes: 76680d0d2825 ("tracing: Have function tracer define options per instance")
Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
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
2.53.0


