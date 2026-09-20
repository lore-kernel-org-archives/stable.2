Received: from mta0.migadu.com (out-140.mta0.migadu.com [91.218.175.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F67F1F94F
	for <stable@vger.kernel.org>; Sun, 20 Sep 2026 04:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789878055; cv=none; b=ihMybV88mGf3AWVlfQ6yyHLyfVBgrmO1mZpI8oat79kVnwM5GN2i6PQpXivobdyzJ8/+ei3yOcexui8kB0f0VKHl+fzLCG7YNS+sM9jSdo/SpZHq7s5CvQpzJ+EurWYQPQMfet1auEIiYrAmJgbj3awRgR6bADIMY8ErvY7U+TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789878055; c=relaxed/simple;
	bh=i3fx8YLMM25rGFTkB/3MYE/SKkwCBHP2NgBwbXTXgc4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aFLui1rvfuZ0zYFizlyJyr+iFWlhD7BjLb8B9KIzrJJ5Dn8VilE2LXMRqVt69cSdpM4Vahr0DLSKC2/yNM0zKRyshPXCHyYqG0e6F+fhawwRqVi4TEtfHbdYhVv85W+PARGGQGnXhc3p/kKTsZIR9V35MTz2oX1zVnMFIljeJS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XX4Z0raJ; arc=none smtp.client-ip=91.218.175.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XX4Z0raJ"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=i3fx8YLMM25rGFTkB/3MYE/SKkwCBHP2NgBwbXTXgc4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789878051; v=1; x=1790482851;
 b=XX4Z0raJnBR5tTovOnOLRc6GH8am+962N6sA5Dop8weDpvh4uzRsOlEKxVJVfpeOeOE3lNE1
 bs31NXyjYP/U25tO8omBGkvLKaICnX5T90JQVoNke2MZDOmXV4raeFz8Z2jFizL+7rrEWPvf4su
 8/MuWbwu+TKKadNxbGkP/ue8=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2345de5eea115e61;
	Sun, 20 Sep 2026 04:20:41 +0000
X-Mizu-Trace-ID: 2345de5eea115e61
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Hao Ge <hao.ge@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH] tracing: Fix crash in print_graph_function_event()
Date: Sun, 20 Sep 2026 12:21:39 +0800
Message-Id: <20260920042139.70736-1-hao.ge@linux.dev>
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
corner case, make sure every tracer has a set of flags:
register_tracer() assigns the empty no_tracer_flags to tracers that
define none. The existing users already handle opts == NULL, so these
tracers keep behaving as before.

Fixes: e29aa918a928 ("tracing: Have function graph tracer define options per instance")
Cc: stable@vger.kernel.org
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 kernel/trace/trace.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e4a490d3d08c..1bd757b65be4 100644
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
@@ -1485,9 +1491,11 @@ int __init register_tracer(struct tracer *type)
 		}
 	}
 
-	/* store the tracer for __set_tracer_option */
+	/* All tracers must have flags, use the empty flags if none are defined */
 	if (type->flags)
 		type->flags->trace = type;
+	else if (!type->default_flags)
+		type->default_flags = &no_tracer_flags;
 
 	ret = do_run_tracer_selftest(type);
 	if (ret < 0)
@@ -8096,9 +8104,6 @@ static int add_tracer(struct trace_array *tr, struct tracer *tracer)
 
 	flags = tracer->flags;
 	if (!flags) {
-		if (!tracer->default_flags)
-			return 0;
-
 		/*
 		 * If the tracer defines default flags, it means the flags are
 		 * per trace instance.
-- 
2.25.1

