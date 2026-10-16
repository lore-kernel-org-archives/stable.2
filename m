Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9A64DDB5D;
	Fri, 16 Oct 2026 13:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157567; cv=none; b=MuguDngkLf//YbhD3M3mWcaFWJ+OTWRDzsIcNMZ67ky7nlhPQvvRSrK179MVVl/nY9wufJUzUS0MVAHbW2UMFCXoVEGJ81+d1ogCyEvwfLvAaCUZLccMuIBjUrm8SgiIc+QSpsGZAjHqlysrw4nL96uLp/+s1QzbQJo6+t9hlEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157567; c=relaxed/simple;
	bh=IX6H8arMlYubY/lS89ufiC7y/RqcLUMFhlz3ioSxX8Q=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Y/HYPTWCcGOANI16n1nldc3iNt25suBfF93xXLKZ3nReBU4gMteWBji7JCtvh5RahKCojHwvwRGUDxw01/jpXDDJf0HBHh8Ds8DpksxqPLzxUj16f98W18pAcfsTQp6czT/XZ1CV6i4JWTtur9ZhlS5cgJXZNiIliuC0dbESb3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpvecSfy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpvecSfy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893091F000C6;
	Fri, 16 Oct 2026 13:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792157565;
	bh=D5xTKdNA3CQIHjqgOAUhRXvpc0K+S7w4M//wDUxIodY=;
	h=Date:From:To:Cc:Subject:References;
	b=cpvecSfyAn20+W23rc0NSNYxTcvp3PyyStXuM7bPRfVxzcDxvrDgTRHU+3dtNp+6w
	 SyzV40EA8XleH7hbO7bSdGgbxnvqN9jKhs4f9e8UDOi6K0071pU8fKp5EFF6gdJie0
	 bYLfNmIWHr8W80moeblPMRSRQ37WNSdhRIzsiHHCkZghDXQ8oRB9eOcucsvTPn7QtA
	 xn3oRtRToyMSLdROyw8psNpsW55XvMmR6971JqHsqmglxyIjP1/NiiuvJGbuhtlrw2
	 3JDHmyDk/EojDw8Pv5CMNaP2SnALsafVoJfqVnhMxXIcvGKNmfCRseMSGRHhQuZTi1
	 z7AvxL34hcLPA==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xHi3A-00000000WUS-3PQB;
	Fri, 16 Oct 2026 09:32:44 -0400
Message-ID: <20261016133244.620040185@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 16 Oct 2026 09:32:19 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Hao Ge <hao.ge@linux.dev>
Subject: [for-linus][PATCH 1/3] tracing: Fix crash in print_graph_function_event()
References: <20261016133218.800011513@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Hao Ge <hao.ge@linux.dev>

tracing_set_tracer() assigns the flags of the newly selected tracer
with:

	tr->current_trace_flags = t->flags ? : t->tracer->flags;

If the new tracer defines neither static flags nor default flags, like
hwlat, irqsoff or wakeup, add_tracer() has no per instance flags copy
for it, and both operands are NULL, so tr->current_trace_flags ends up
being NULL as well.

The ring buffer is not cleared when switching tracers: it is reset
inside tracer_init(), after current_trace_flags was already assigned.
If the buffer still holds function_graph entries of the previous
tracer, printing one of them dereferences the NULL pointer. This was
hit by cat trace during an ftrace stress test:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  #PF: supervisor read access in kernel mode
  RIP: 0010:print_graph_function_event+0xe/0x20
  Call Trace:
   s_show+0x4d/0x110
   seq_read_iter+0x2d4/0x490
   seq_read+0x130/0x170
   vfs_read+0xb5/0x370
   ksys_read+0x6d/0xe0
   do_syscall_64+0xbc/0x450

The snapshot buffer is not reset at all, so this can be reproduced
without a race:

  echo function_graph > /sys/kernel/tracing/current_tracer
  echo 1 > /sys/kernel/tracing/snapshot
  echo hwlat > /sys/kernel/tracing/current_tracer
  cat /sys/kernel/tracing/snapshot

Rather than teaching every user of tr->current_trace_flags about this
corner case, make sure it is never NULL: when the newly selected
tracer has no flags at all, tracing_set_tracer() falls back to a
static empty no_tracer_flags. run_tracer_selftest() can hit the same
case, so the same fallback is added there too. The existing users
already handle opts == NULL, so these tracers keep behaving as before.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261015130658.221198-1-hao.ge@linux.dev
Fixes: e29aa918a928 ("tracing: Have function graph tracer define options per instance")
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Hao Ge <hao.ge@linux.dev>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 3b22e70c6016..97a058623f94 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -99,6 +99,12 @@ struct tracers {
 	struct tracer_flags	*flags;
 };
 
+/*
+ * Tracers that do not define their own flags use these empty flags,
+ * as tr->current_trace_flags must never be NULL.
+ */
+static struct tracer_flags no_tracer_flags;
+
 /*
  * To prevent the comm cache from being overwritten when no
  * tracing is active, only save the comm when a trace event
@@ -1318,7 +1324,12 @@ static int run_tracer_selftest(struct tracer *type)
 	tracing_reset_online_cpus(&tr->array_buffer);
 
 	tr->current_trace = type;
-	tr->current_trace_flags = type->flags ? : type->default_flags;
+	if (type->flags)
+		tr->current_trace_flags = type->flags;
+	else if (type->default_flags)
+		tr->current_trace_flags = type->default_flags;
+	else
+		tr->current_trace_flags = &no_tracer_flags;
 
 #ifdef CONFIG_TRACER_MAX_TRACE
 	if (tracer_uses_snapshot(type)) {
@@ -5089,7 +5100,12 @@ int tracing_set_tracer(struct trace_array *tr, const char *buf)
 			return ret;
 	}
 
-	tr->current_trace_flags = t->flags ? : t->tracer->flags;
+	if (t->flags)
+		tr->current_trace_flags = t->flags;
+	else if (t->tracer->flags)
+		tr->current_trace_flags = t->tracer->flags;
+	else
+		tr->current_trace_flags = &no_tracer_flags;
 
 	if (trace->init) {
 		ret = tracer_init(trace, tr);
-- 
2.53.0
