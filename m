Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792803035;
	b=evI0CUSFRpEeMBKc5nSiTm6pI+vkcItBDXAxK9EmVmDa+DFuX44UQ8pWdYzDJCGa4lvW
	 hKTtqfbxNzv+FSG/FvYa4RFTC0KwqgmmnMC2s6D8kGJUwrLXpVEgusiEdDQMLUJvUX2ci
	 z6JH/yAdcMfA0wGbIwGXvCx+e4Sjt/panO3D2JeTU8uu5DGonUpGUElg1CfMI975y9VBB
	 uT+BJyuXny8b2mT4YLit/3vy/uvOIsZW+O1fsTMOJKhrnz6xQepJi5vS2SMKnIvohpKh8
	 NbQ34BFm/gWYoO56o+0NmFeQbMInwtRHKJh0gtJwTIsLfbXapmLfdC5p9qT3OLGglTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792803035;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=dkcxwk0nTIfjOeGkBRylFasllyV4GAtda1cDQcr8HAY=;
	b=JyRg+wDcox7QiCpe2LY4wb5ulPX+rbKROALysW4xk5ZyB+PGhSuKXmpQXZiQLYIROhto
	 TL5ZEdDUWmRmMmh5wuckTkfdFk79YK7+aLIq9rdbemTvpHqQC7gs0ijusbylgImn2cfMJ
	 D45uu9g8EKmtN1+ascCT1BCxOan3FfKHq/XvSk4axI6YLfkZCgHlLuT78Y/cTzb3vo7Js
	 d6utwDWc8y+KfWHHjV4DuxQveBrVd2NDM93lsCbhKHkQxU/6Mj9NkfAfcZjAa941LuVs1
	 TTmN5B62DM9kNhT1DOo9dRbazzNcz7/1LrH+uK0E0JHj34XBY+qhI4zXp7UAVvqradg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XKUELp47;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49214606A31E;
	Sat, 24 Oct 2026 00:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XKUELp47
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260B61F031E0;
	Sat, 24 Oct 2026 00:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792803035;
	bh=dkcxwk0nTIfjOeGkBRylFasllyV4GAtda1cDQcr8HAY=;
	h=Date:From:To:Cc:Subject:References;
	b=XKUELp47VhPpdEmv2c+BichvCuBocdvkFunDn8v6u5R2g8u0x4lkrOwAfcY3+bvqX
	 X5cK0EzPtpK4vPcXjiA+1SqBwvpqWkhFA8wXownMkG3O5KF2lc49iiS0tCFtvJV/OO
	 SPOBiCJO6GbOrZly/2BAor8kmkXGi0aJ32d1qZHpA4sYM+RbCZboxE3QyaEFBdEJZw
	 jDADxxeiNntMIYxq1LXDRYiSloTuNtFSjwbLkjTldAADsOqrXiqtuTm5TOtXouONPj
	 i8nF99tyhZX+JxQDCEHerPdQs7y3r7rNenWmOuVUnCwujOK163ZLK73WumThzFbeX8
	 ZD+iPKhswvaZg==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xKPxy-00000004gN8-1vBC;
	Fri, 23 Oct 2026 20:50:34 -0400
Message-ID: <20261024005034.265881641@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 23 Oct 2026 20:50:15 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 "JongHyuk Kim(MalHyuk)" <malhyuk97@gmail.com>,
 Kyle Zeng <kylebot@openai.com>
Subject: [for-next][PATCH 3/3] tracing: Reject incomplete event filter expressions
References: <20261024005012.676772644@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Kyle Zeng <kylebot@openai.com>

A non-empty expression normally finishes in predicate_parse()'s inner
loop, which resolves the pending logical operators before jumping to
finalization. If the input ends after an operator, possibly followed by
unary '!' tokens, the outer loop instead falls through with unresolved
operator state.

For example, "common_pid == 1 || common_pid == 2 &&" leaves
prog[0].target equal to -1. The second pass then reads prog[-1] before
the forward-jump check can reject it. Depending on adjacent slab
contents, it can also copy an out-of-bounds word into a branch target
that passes the forward-only check. A self-targeted perf tracepoint
counting event can reach this path through PERF_EVENT_IOC_SET_FILTER.

Reject the outer-loop fallthrough when a predicate has already been
parsed. This ensures that non-empty expressions only reach finalization
after the inner loop has resolved their operators. Keep the existing
no-filter error for input that has no predicates. Add a regression test
for trailing logical operators and unary negations.

Fixes: 80765597bc587 ("tracing: Rewrite filter logic to be simpler and faster")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261023174620.91969-1-kylebot@openai.com
Assisted-by: Codex:gpt-6-astra
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Tested-by: JongHyuk Kim(MalHyuk) <malhyuk97@gmail.com>
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c            |  6 +++++
 .../test.d/filter/event-filter-incomplete.tc  | 24 +++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/filter/event-filter-incomplete.tc

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index b3b13700abce..5e74d2dae40a 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -598,6 +598,12 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 			top--;					/* #12 */
 		}
 	}
+	/* Only the inner loop can complete a non-empty expression. */
+	if (N) {
+		ret = -EINVAL;
+		parse_error(pe, FILT_ERR_INVALID_FILTER, ptr - str);
+		goto out_free;
+	}
  out:
 	if (top != op_stack) {
 		/* Too many '(' */
diff --git a/tools/testing/selftests/ftrace/test.d/filter/event-filter-incomplete.tc b/tools/testing/selftests/ftrace/test.d/filter/event-filter-incomplete.tc
new file mode 100644
index 000000000000..cc6df762845f
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/filter/event-filter-incomplete.tc
@@ -0,0 +1,24 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event filter - reject incomplete logical expressions
+# requires: events/sched/sched_switch/filter
+# flags: instance
+
+filter=events/sched/sched_switch/filter
+
+for base in \
+    'common_pid == 1' \
+    'common_pid == 1 || common_pid == 2' \
+    'common_pid == 1 && common_pid == 2' \
+    '!(common_pid == 1 || common_pid == 2)'
+do
+    printf '%s' "$base" > "$filter"
+    for tail in '&&' '||' '&& !' '|| !' '&& !! ' '|| !! '; do
+        if printf '%s' "$base $tail" > "$filter" 2>/dev/null; then
+            echo "Accepted incomplete filter: $base $tail"
+            exit_fail
+        fi
+    done
+done
+
+echo 0 > "$filter"
-- 
2.53.0
