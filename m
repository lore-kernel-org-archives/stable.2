Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777597;
	b=y7KPGBWe8yTb9M59eOybt6JwsoyQBrk3kd/+VC9zO7v8JhkDq5NFlbZJFdy+ui0u/ABN
	 cj1FSETi0XRzQ456KAfxjbU1mdSBW2gGMAIcRKaVN8ckVrKlLTwsYk1s18qhe3rCdHn27
	 vaKQtJ/dgl6rv4F7A2MGxfQLmT6yfgjaUlB3Yhn7/fPI1uNx7NQ5C6akQ1e5PP7sF4HLn
	 cSVuqo/5cka37p6T6n1XYC7S+9d947aEVDmKEa5f6kJKQSm40RScoRjxRiCwb8Ylg02aS
	 Fu0WAn3NJCO6St/rNEOMNIYlR31Yj8OXQVY36PFgHbfxAfw900lj2pjWDulVIvNe0hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777597;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xlzj9+7VUiD0rDPjj9xsdhl6VeuEJi64iOeLJzH8Fak=;
	b=Fu4hSHRDPDLCAyJR/A/UqEPXWj3dWmzSXDFIjGni6xdn8qomCBuZZZtFWGqA0GbeG/+l
	 05evXSocQMf0mgl+2k/KaOTm0BNUCoV1usr5qhv3QkKF5mYXey5jpEmxVrl1GyxkhWRBy
	 P/Zu1c7Q3FiiSwp0Lw0WGgRyEezpZklpkC3kiniSXqq09NbEHUJTaFYLuZky1LseB2X0i
	 3U7f1wCDusP2nTGJ8kTOGFpko9Vo+wA0mvSXgMIe7CkCXhjAT1ADliVEnZM5qpT7ZB7ZU
	 43c6LD3kXlgVZs2uxL8G7vXEUAGDE+HMknYsYfO8SgFUZLyYzp2xu3CtUt5did7oKfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=YxiS9C1Q;
	arc=none smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39106606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 17:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39106606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=YxiS9C1Q
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6faddda49e7so982564eaf.3
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 10:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1792777595; x=1793382395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xlzj9+7VUiD0rDPjj9xsdhl6VeuEJi64iOeLJzH8Fak=;
        b=YxiS9C1QOQiQj62KnEdVaa4HjaEBExW5bp5Ol+/YPk+f2I+3STcUEaRI1aixJFSIVQ
         foZtdo93KcXjp+UKIWW7nmoC0ZCH4CyhqCW+I/QewtnJZBg1/bONh7uFQO3PyIDaFftP
         Cul9W/M1VUsKfdYKyQllyYvirVbrAe3fb5DeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792777595; x=1793382395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xlzj9+7VUiD0rDPjj9xsdhl6VeuEJi64iOeLJzH8Fak=;
        b=aW+Serv+rVy7dbx8UU4jxLl+fWM8xfLItPf1VP1iYWS6tFx4LSKx/uFq1rOFiojPu3
         geFuqyHsqNwrNKSIG8qCa4IKOU/IRpyFkPZd26CEvvglvDqFZdRY+jsg0JXgT1fRwSTG
         CHBjjcEccmyecfvnWd03wBE7znxJ9IW6QBFeVXMgGx1dId3+lKX3VxonPS3w6dRzCyfG
         GF/ULxgB4XhHuS60cKKMFNrrOgmb2H+n7EGEDC/lUCkIa08mwF7JPI3gVrUNXW+FXGMP
         UYr5cU57hl2GXQb/J5oAbTleyQq/BXQH6XjhpEW1W+h8SPBAsympexhvtbzUQdV+DFe1
         tPzw==
X-Forwarded-Encrypted: i=1; AKwUvBwWpokwycNR6JMSE9zSPDr/3GS7jIjILIN76ppeE/uMn0MJnKFtWO/FhpJ/CA3t1lypZ4Bc064=@vger.kernel.org
X-Gm-Message-State: AFq9FYI64Y/xIPlPzqPVFNbdEb5SDiNznUV8ywTei39fsd3KNvRoyBpB
	NnvqHFA+oX+E7wfHj19knLc+0iXFg+d1C/B+Dq/+q5rn/CM6VFlEVZfv3yn0X0cuBIY=
X-Gm-Gg: AYBFou3XeroJMJmPVKk6M0GTtQCkkyThU9hULC8qO0ZayPYdTrL+BxXkQbOW/JG+QhW
	UCATqB+8jTxORfr0VsiL6M7+wsaPmKaAFSprJMjoKMzXaU4kn/erfmQ4g+7sbnlOUg6rMIPwbtJ
	WyDqwmQHJDk5vRjyYeE2IpwDk2BGq3PPZsiJxOKDTkRwVoSg56HxF4q/m6YGlYqIKaV1S6htgYH
	e0cwA1MYW1hnbEDel0fh0eTKw5E3sCsBank03DiTb6sRxcuNLSyrbRLg9gkW2BX28YE8znZ2DJ+
	doYWAesTHll+0g6IfXDPTyE7cZuhoCfoVejhNZBJVNcYat/cFlWTKTzXksLYYJeU9acN3us7g6B
	tns4Y5RDCBtBHVqY1OTjh4XjbZVgoix/pvVjFSKk2e5kPg87Xh4VBDO617XdL0ajRyH8ZB8d9uT
	FrVLiB7JbBT/A1HVtBKV3qeI1+RBRYI9KXMHslGoG0piyHcmsyAdDbZ/CuPZQWZvB4I5lGi2YG2
	bAm/VqHU+SmgaZ8W261d606WEcziiR3Gav9s4L8nBqhxDccqVc9wVm6nbFaRat3SZ6y30yGgbGb
	6HR7KQatkxuOxV9xQSh/tlXG6aW50O4Jp6aN1E8oiGnmNPRERfoFPuC9ow==
X-Received: by 2002:a05:6820:2215:b0:70b:980e:454 with SMTP id 006d021491bc7-70b980e054bmr960802eaf.6.1792777595042;
        Fri, 23 Oct 2026 10:46:35 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.5])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70b9aec6172sm565349eaf.11.2026.10.23.10.46.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 10:46:34 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH] tracing: Reject incomplete event filter expressions
Date: Fri, 23 Oct 2026 10:46:20 -0700
Message-ID: <20261023174620.91969-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Assisted-by: Codex:gpt-6-astra
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 kernel/trace/trace_events_filter.c            |  6 +++++
 .../test.d/filter/event-filter-incomplete.tc  | 24 +++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/filter/event-filter-incomplete.tc

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 2b46ca536045..405651be9c93 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -596,6 +596,12 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
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

base-commit: fd179f8a05be3ccae366b9b96e176b51fbe54aab
