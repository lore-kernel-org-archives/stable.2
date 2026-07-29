Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493303F4128;
	Wed, 29 Jul 2026 23:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785369333; cv=none; b=S81rL+GQcPX93dUGdnjd/1jziwqr5eMszmhd6COhdt2tGX1DHWjAfHgsb3mEvO+TsSsFLWelRZ9FcCVFaTISK7VOyb19YirdRqeMMeCSCPkQB78hjf7H6flbhOCsGZeQk86rKkGrytJQbCVOgHWOLOuoWoiDGWHxCmi3qz49j7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785369333; c=relaxed/simple;
	bh=1K/yFf8OfOB2rTNREVIOaRb3O5ohYzvmgE1OITnB8/s=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=G4OHcCFZFesX4tOkfR0uBBs2/zbm59/cMFsJDza7ZY0KV2M+p3coNCGNeOGHkZQGoKsfYkGZ2xWFWRMAyjdXkfhfebowT+LLi1urjKKOCtjKYImcpSwAC034jH6Qi9ZYuHJWaYHLQIt+pLTDqbquzlikX154cmdAEWwqwWEYgqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lc9M9dXy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lc9M9dXy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA741F00A3F;
	Wed, 29 Jul 2026 23:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785369332;
	bh=bO74R1ReXte6cxi92h8Rpsnbge6jM5VP3xm1gfelReg=;
	h=Date:From:To:Cc:Subject:References;
	b=Lc9M9dXyYq3uUcwzGybUB5aXMzN6PZ95pkf/1f6PEIcgD95DFztzd057aYocDYWhY
	 RDD53AFRcNuKqDamdPeMcH/ULN4/onouPV21nC+0JKaJFsQz6HqCbevdXZOhd+5b+s
	 E2/4+grHnJFKkZkK0vvcMrCbwEH9NWopwHt/1FFYLJZuz4gC6xpm/lfNYU0GKcHK1r
	 9mwcZY/EDPqTMwGahOVzPDPoMNnHX5Sv3gV/kDZSCQuuPNPJcgnpIJHmwdx1jMLyas
	 TUaZUGhll0JEJjaphOUlunG8HdfRLXvJ6Svh3x4PAbNWbAYaGhAFmArqncbo/ApVOw
	 PuNq3hHEseExg==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wpE88-00000007HZY-3YqV;
	Wed, 29 Jul 2026 19:56:08 -0400
Message-ID: <20260729235608.703242921@kernel.org>
User-Agent: quilt/0.69
Date: Wed, 29 Jul 2026 19:55:54 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 3/5] tracing: Check return value of __register_event() in
 trace_module_add_events()
References: <20260729235551.356165691@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

trace_module_add_events() ignores the return value of __register_event()
and unconditionally calls __add_event_to_tracers() for each event.

If __register_event() fails (for example, if event_init() fails), the
trace_event_call is not added to ftrace_events list, but
__add_event_to_tracers() still creates a trace_event_file pointing to it.
If module loading subsequently fails and module memory is freed, tracing
state retains a stale trace_event_call pointer in trace_event_file,
leading to a use-after-free when tracefs or tracing subsystem operations
are later executed.

Fix this by checking the return value of __register_event() and only
calling __add_event_to_tracers() if event registration succeeded.

Fixes: ae63b31e4d0e ("tracing: Separate out trace events from global variables")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/178528487878.124250.14170824576025743236.stgit@devnote2
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 956692856fa8..c01b10b99f67 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3933,8 +3933,8 @@ static void trace_module_add_events(struct module *mod)
 	end = mod->trace_events + mod->num_trace_events;
 
 	for_each_event(call, start, end) {
-		__register_event(*call, mod);
-		__add_event_to_tracers(*call);
+		if (!__register_event(*call, mod))
+			__add_event_to_tracers(*call);
 	}
 
 	update_cache_events(mod);
-- 
2.53.0


