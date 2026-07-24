Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5A93C2BBA;
	Fri, 24 Jul 2026 23:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784935113; cv=none; b=aF8MYuWRIbPsrMAdbs/o78YMonlRrE24eKu7VHYRU7J49R1zz9+r4bNWbUdhExT6kJGNN1vYMUMWhQsCso830FixHJhv/gYRJ396IhofZUx9wlC9dZJmoKdw6xdYEIGwebmh8Txyo4eE+ElgpNGA38YUB0rU+tLfEqI1DgYhRlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784935113; c=relaxed/simple;
	bh=81EnjqOBGcZ0Bs8bYt5pmiKrJQ91CTx/v1DYPo9Zmao=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Zf83M5nW30Za5ejsXR25BXZxL0wleF6E4qWAPGizzcUQ3nFNaH8HSLeqFsLITwRPdJ3yK8k9YpgBUrlZsSad0cVGurfIYtvm4vKOr40gCjdoLz3cXCbHCNQMyYDBgxLNorPKvDJVr/d/qYejbpdgcDfVveISag2ksGlm3AjcW5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H47wRvWO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H47wRvWO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30FD1F00ACA;
	Fri, 24 Jul 2026 23:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784935110;
	bh=CDst2w1T+OL9OaGT2HgGNFKnrThWQX6AMrH4F2eOtzI=;
	h=Date:From:To:Cc:Subject:References;
	b=H47wRvWOlRfChkZPYkuLGdjNiei8nzfZl/EF3sxefteYulKJHxbTa53JwoT3tsOnl
	 LquzKG4s0akEzddFc1FfaxTJczmgSYEgpf03cB5cofJLx1z18inJglCpdVjD+js1Me
	 HswOYOik/CcyDWQoqoRYic5wqb+iEojEWMzlLRKhzLcQAs7SEtVk3RfDn9bKCR6WWf
	 baGZ+1PIt4TCml2kNOByQpiaQZYOlm1mm9kio0iPzdXnAAkG2nlvfXBgbL8bHySvSO
	 bnXX2wPuOIDvkIzRcPF/tp6DU8I2DkxkrrvfRV8uopExdFHy0hb+LT4vggoCAHhvzy
	 KWDHp+Pi2izDQ==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wnPAO-000000046uS-30Ls;
	Fri, 24 Jul 2026 19:18:56 -0400
Message-ID: <20260724231856.572531317@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 24 Jul 2026 19:18:47 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Breno Leitao <leitao@debian.org>,
 Usama Arif <usama.arif@linux.dev>
Subject: [for-linus][PATCH 7/9] tracing: Fix context switch counter truncation
References: <20260724231840.483353969@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Usama Arif <usama.arif@linux.dev>

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

Cc: stable@vger.kernel.org
Fixes: 64cf7d058a00 ("tracing: Have trace_marker use per-cpu data to read user space")
Link: https://patch.msgid.link/20260717173252.3431565-1-usama.arif@linux.dev
Reported-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Usama Arif <usama.arif@linux.dev>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 18710c190c92..01a5e87af299 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6187,7 +6187,7 @@ char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
 {
 	int cpu = smp_processor_id();
 	char *buffer = per_cpu_ptr(tinfo->tbuf, cpu)->buf;
-	unsigned int cnt;
+	unsigned long long cnt;
 	int trys = 0;
 	int ret;
 
-- 
2.53.0


