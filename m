Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21AD44211F
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785423897; cv=none; b=fVr7yIaKgV3vAzXTc7pyNS3CY+L2deTDENf3vBz4CpQhvZ0aukw1Av9Gc7ey7NgjeVjU6gpfwFgXoBgNqqxruvFq+uz6FcfbH8huHS1lPxPFfyVak57mbXSUV8cyHFEZ6UKYRtiWMeXxkJlPBVusEXETd9E8lYvkpQxdORtCDQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785423897; c=relaxed/simple;
	bh=l9GKUxKdOGLl997Z4ceudW7mPtJe4JfdjMvSi3Qz3pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nw4rHJ6pAB8LxMZlZZUex5H4h+5D9cqhQmZv0yA0B6Tqj4KQHGUaJsD7w3piwhXzsuthQJXZ25VPhEL7KzMDU6K2AdStNqmOGpaXe7OzfOnM/j+43sOpDv9V0yU1sWeSjhZCSQoIA0xhG/oWPwQD6eQjsp6jBoT7dlWt6cczQrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cx2pFC/X; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cx2pFC/X"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785423892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tXP3sLnFW2SJsbuz9cs4gqLjv3d7L92yQ0oDBHkkR9s=;
	b=cx2pFC/XKbg6FG7I014UOGNrlasGWHzlDcEXyW4lmFnIed6W2aaZcE1eWSB/t82ss4H4fu
	NkX3VqjzPBktWOMmdanWkV+/pfbLchf34NI0O2m6PxV3G2smG6cxGdssDIKjkTg02N4AhV
	jmCjHydEqgZfHFw/vOC4V/LOGfF6PSc=
From: Leon Hwang <leon.hwang@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] ftrace: Protect direct_functions in ftrace_find_rec_direct
Date: Thu, 30 Jul 2026 23:04:08 +0800
Message-ID: <20260730150411.88667-2-leon.hwang@linux.dev>
In-Reply-To: <20260730150411.88667-1-leon.hwang@linux.dev>
References: <20260730150411.88667-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Fix accessing the __rcu pointer direct_functions with RCU protection.

Cc: stable@vger.kernel.org
Fixes: d05cb470663a ("ftrace: Fix modification of direct_function hash while in use")
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/trace/ftrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 6c47a94f5924..c5d1d0d42ccc 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2645,7 +2645,8 @@ unsigned long ftrace_find_rec_direct(unsigned long ip)
 {
 	struct ftrace_func_entry *entry;
 
-	entry = __ftrace_lookup_ip(direct_functions, ip);
+	guard(preempt_notrace)();
+	entry = __ftrace_lookup_ip(rcu_dereference_sched(direct_functions), ip);
 	if (!entry)
 		return 0;
 
-- 
2.55.0

