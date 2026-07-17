Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBA0388E7C
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 17:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784309595; cv=none; b=SckLMwgpV6/ZX2F+2NSn7IBz6SBI2bBYcnwO7dbftz5unyVmU6Vk5OnerKGp+ymmcpfNNRk3lAQk5eYdsmlAK/mqTUp5RNXxD40fXtGi7g3ifkOb33pAv/6J8eR1q7/z1KHNVhaRyH/TfKeyW+1X2d+C2fO3pj08ivSZMxB2N2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784309595; c=relaxed/simple;
	bh=76KHIUPx9GCfNmaVdnsDKiBK1kR39PFNUqTbo2lrbSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U6jWsQYVwysee2BktZqUFegSGZTB0FGI30ByY+D+n4GDuOGEWSQIwQVNkB4RqG5AwXtwNL67R6JlykoLLfr998f9QZykQQTaFVTUijBNnjRiUQCyYwHUcqNU0LsFRkeorhOSS9MoSfKi1AnwQJRp6Ftr5Gr7Azrqo2lRpb1sWcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nYtWaUOl; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nYtWaUOl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784309582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jfVNmz4n0x/JwWN2HD4U6AXAQsD3HYnYjroMMw5DfXU=;
	b=nYtWaUOlS8XBlZJdR3bTiUP6sW5pMWFVvxli6DityuypieucVrP6pE90zFpJ6XRKWGEUMD
	Zazyib6KRzHY5WyHSi+g0w4/Y59p1vll+Ljs26R+ETzhaCPDJqk6ozI312zTnhGoVWR/0W
	t2VBXrkdrzytBJcgl6+nC0xNnxAh/IA=
From: Usama Arif <usama.arif@linux.dev>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	leitao@debian.org
Cc: Usama Arif <usama.arif@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH] tracing: Fix context switch counter truncation
Date: Fri, 17 Jul 2026 10:32:52 -0700
Message-ID: <20260717173252.3431565-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

trace_user_fault_read() samples nr_context_switches_cpu() before enabling
preemption and retries the user copy if the counter changes. The helper
returns unsigned long long because rq->nr_switches is u64, but the saved
value is unsigned int.

Once a CPU has performed 2^32 context switches, assigning the counter to
cnt discards its upper bits. The comparison after the copy promotes cnt
back to unsigned long long, but the lost bits remain zero, so it reports a
change even when the task was never scheduled out. Every retry then fails
the same way until the 100-try guard warns and the user copy is abandoned.

This affects long-running systems and workloads with high context-switch
rates. A CPU switching 1,000 times per second takes about 50 days.

Store the sampled count in unsigned long long so the full value is
preserved.

Fixes: 64cf7d058a00 ("tracing: Have trace_marker use per-cpu data to read user space")
Cc: stable@vger.kernel.org
Reported-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 1146b83b711a..412a8daf2162 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6188,7 +6188,7 @@ char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
 {
 	int cpu = smp_processor_id();
 	char *buffer = per_cpu_ptr(tinfo->tbuf, cpu)->buf;
-	unsigned int cnt;
+	unsigned long long cnt;
 	int trys = 0;
 	int ret;
 
-- 
2.53.0-Meta

