Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB61449EB2;
	Fri, 24 Jul 2026 23:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784935112; cv=none; b=d1VB5UsRPK7Z2mVffw45ll5rMaMYjZIidHmP6zrLMFd2WxR0xnc6lJ6SgtWYm/xTewteUhP0Mf2sMI8wSS8B3mJC6QYe5zxFdABtXeV0AdRhclXcYYTE3MwcTkxszZbFwZm6z+QJ6eb72tqbjsE7mhOhENDtmqXzYwV6dG5f/po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784935112; c=relaxed/simple;
	bh=EwOc+Z/ERUb+ga5bspF4l2UOMQNyOPNtuMixc2nPWhc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=KDNwCPt18EYzE8ap+E6AsATtQMVIyJcKuHmmp4S2Des6GjS1mXIp79wcuRHIVkuUQH/oVf4qoHvzS9vA3Cdp7r5fQ3yHo0NErwi8ZwRPUwmfKuwf4hm5h7ex0MA7f1r+Zfh4jFoOEppq25Wsg7m5xdu13Ps0kwjGJKY3pYgBt+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRY3nsdv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRY3nsdv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBA41F00AC4;
	Fri, 24 Jul 2026 23:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784935110;
	bh=k/baGZCUSKTzBza5ql3ErF5JEkelRWpPcwn6SCdc9YA=;
	h=Date:From:To:Cc:Subject:References;
	b=jRY3nsdv8UPHHRVBCZrIwv+Qofujgmxzypzm5cJqwjKh/BScUnzlEIkID3pytee+/
	 wPEkqf7L3LVpngS1pD9RuO/uio8bLst+IqGw9RdkE6uo66nBkY9/XkS5JuwI+FR+Wi
	 YuZX6kWlWn5mvX6fe7vXpZY3tZN6WsRrX5XOptFJ4Xn4DCkdPxqNofu7BiY6c+2jJG
	 6ipF/D9TpDGvJUqMBiEbXY1GQblIiyrm9vuijYPtOKY6zXpPbSE3TXuBXc1LA/J7yE
	 a1EcjPqU1bLRxtk32FKDxyaNeXqtoVYpfPwbZwGkvJjW0mdQtgABYX+3ho9vH2I7WN
	 xo1l+1ZPdYpKw==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wnPAO-000000046tS-1fpe;
	Fri, 24 Jul 2026 19:18:56 -0400
Message-ID: <20260724231856.251436050@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 24 Jul 2026 19:18:45 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 5/9] tracing: Fix union collision of module and refcnt for dynamic events
References: <20260724231840.483353969@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

In 'struct trace_event_call', the 'module' pointer and the 'refcnt'
atomic variable share the same memory space in a union. For dynamic
events, the union member is 'refcnt', which acts as an active
reference counter.

When a dynamic event (such as kprobe, uprobe, fprobe, eprobe, or
wprobe) has a non-zero reference count (e.g. due to active event
triggers or perf attachments), its 'call->module' evaluates to a
small non-zero integer instead of NULL.

When filtering or setting events for a specific module (e.g., writing
':mod:<module>' to 'set_event'), the code in
'__ftrace_set_clr_event_nolock()' and 'update_event_fields()' reads
'call->module' directly without checking whether the event is dynamic.
This causes the kernel to treat the small integer (refcnt) as a
'struct module' pointer, leading to a NULL/invalid pointer dereference
(Oops) when dereferencing the module name.

Fix this by ensuring that the 'TRACE_EVENT_FL_DYNAMIC' flag is checked
before treating 'call->module' as a valid pointer in these code paths.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/178425670947.84440.11344393611899824907.stgit@devnote2
Fixes: 4c86bc531e60 ("tracing: Add :mod: command to enabled module events")
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c46e623e7e0d..956692856fa8 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1350,7 +1350,9 @@ __ftrace_set_clr_event_nolock(struct trace_array *tr, const char *match,
 		call = file->event_call;
 
 		/* If a module is specified, skip events that are not that module */
-		if (module && (!call->module || strcmp(module_name(call->module), module)))
+		if (module &&
+		    ((call->flags & TRACE_EVENT_FL_DYNAMIC) ||
+		     !call->module || strcmp(module_name(call->module), module)))
 			continue;
 
 		name = trace_event_name(call);
-- 
2.53.0


