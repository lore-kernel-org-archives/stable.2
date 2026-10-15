Received: from mta1.migadu.com (out-82.mta1.migadu.com [95.215.58.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A477C1FA272
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792069555; cv=none; b=aqwPcyBMwKkrgaX0B9omy704mC7eaBJhT9pKtPvwlkhCcwpNBvhjhVL/nE2WCodgHDUhbnPt6apFnSgdXRMSWwATdDCw0EShHkUiLa3IYWsLjh6XN4a0HicworzyxBIWnz/w0QuoPyn2SuSfmGe+9yeQtpxrzKHU+jdKlUM8xt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792069555; c=relaxed/simple;
	bh=zfOs8r5Hw3TRC8MJRsJxpQX435syY1SfJsZA5AygjLA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JdBLfZvNUVdL4zVJVGX6MyqCDN+Fls9U/qv4LTPR2Sy//7OpuSX0kvwmGmUHfjAOvsPlwRjW73/Fs6mYoiRghol5I4KDxdmxQvJ0GRFWv68DR6q+eeIKHNBd2ubGsxQClW1fAxybKO+5Dm+jXGoiTXSp42KuzWoXOcdKjfIYqnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZIvwVtt3; arc=none smtp.client-ip=95.215.58.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZIvwVtt3"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zfOs8r5Hw3TRC8MJRsJxpQX435syY1SfJsZA5AygjLA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792069551; v=1; x=1792674351;
 b=ZIvwVtt3U7bY1K4/l2wr8y6bwyFQLtzFMf2em1b/+fbjE0b9DmANvNSmo1eiFHHJheGhOxjG
 41viKTPpAg0sudR+Q0tSlIHKNpd3f27oES44kihhLKpVZSVY1bu8fYpTccn8ZtyDWIBtRuAAxya
 XDG+XfCiNH4gTzDb5Np9na2Q=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 68f3da1f42c82f42;
	Thu, 15 Oct 2026 13:05:51 +0000
X-Mizu-Trace-ID: 68f3da1f42c82f42
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Hao Ge <hao.ge@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v3] tracing: Fix crash in print_graph_function_event()
Date: Thu, 15 Oct 2026 21:06:58 +0800
Message-Id: <20261015130658.221198-1-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Fixes: e29aa918a928 ("tracing: Have function graph tracer define options per instance")
Cc: stable@vger.kernel.org
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
Changes in v3:
- Sasha pointed out the original two-step assignment had a
  transient NULL window. Switched both sites to a single
  if/else if/else.

Changes in v2:
- Rework per Steve's suggestion. v1 could trip the WARN_ON_ONCE() in
  add_tracer() at boot, when an instance was created before the tracer
  registers.

v1 Link: https://lore.kernel.org/all/20260920042139.70736-1-hao.ge@linux.dev/
---
 kernel/trace/trace.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e4a490d3d08c..cbc259557b09 100644
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
2.25.1

