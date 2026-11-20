Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196481;
	b=rGlX/JX8DQPtK2ZOT//XJXI2lJlS/RZo5Qg/N5IfvOCdKiTEapD7SwJgvwpc7LvFOGWs
	 h94U9Wu8VbzE6MqQMcHktqBE51MvBFWDC/g4Q5avZGuyLyr/uSA0bdekHlENuenw+Qy4g
	 y3BLEiGmQabTcQ9Q8iCfyhr+WaU1crvaq/V7IkZCm559/B8Sp6vqZWUZHL0V4gLY8463S
	 sUwXRv3hO+N8eo2cLmwxwPCcZO3ZDhu/WYLZGpcsLPUD61yhJsXTbWKJO55igp/7hApLr
	 HVpWjjYyNyvNCcDzOgQXzAPuQunGVcjKcWB7CL8jpRx0YOGwEnSTmFgWOdidwOHjS8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196481;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=N9laip+Ao5zU8jIB2KsUSYIkpaQFvL52SksdG+UFSh0=;
	b=ilvdNzmZ2qCcsh3HJ6SCv3SLwjdMmfJ4EwwtPCUmQv6LoFy5qfVpLMko13YHjdxH0tF/
	 Du9BwtCY/3N7HY9Ph6hRYx3zEbcHAeP4RAY8nG/b5N38t7jo9zP9RUvsJuBIugCTR6i8E
	 tMkuSjOwt2u/VbmRnd5e+xYcv4m4B1qcw5sQwHCKPNCIEmeER+6FYznjLmXSwiBwHG09Y
	 Ypw2hFEz2nhlDlZLrfr2ehJXJB4Qm3QTTN+f8+3HgmExBWk20L1U67Q2Gdgv5NT4Kde2x
	 VOMMnvGg88Z7vtxCkyTA5Fzh7n1t1tOhhEMTyTfVjfeZOvsQlCpOnVD24q9MdHBhoTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FaETTOFW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B4B606C2CC;
	Fri, 20 Nov 2026 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FaETTOFW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D691F02833;
	Fri, 20 Nov 2026 17:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795196480;
	bh=N9laip+Ao5zU8jIB2KsUSYIkpaQFvL52SksdG+UFSh0=;
	h=Date:From:To:Cc:Subject:References;
	b=FaETTOFW2uAd5eJ/6n/hzgDoVwkZ4eetIUd0Abp9Wbq+0BqfIj8+uk17MWIM4sQWD
	 EWni50H253NXHh7f4Juljx9Q9sV+0fdsNpfC+Gk/40dk6C9psCKMJM20wANXQ0mDHU
	 A3oFe+aD4VS/TSvN/IVXpWatZO1F7u51wXNs1FqkfbvTSuEPANYfUyDKFeUzfzfF9G
	 9piUl26uFR0680Lv2oDMR3qZslSv8mrpW75afuxOvuPYQypcTARpdtoX8wAubQX5Qq
	 O3C6FYHcqy++o00aGycldmlImAjRwqDJ97EtbBji7dQyKvjv3AMxcIaCEhi1rcNgDA
	 2eVJJdfRly0xA==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xUSbv-00000004aVf-4Ap6;
	Fri, 20 Nov 2026 12:41:19 -0500
Message-ID: <20261120174119.832303884@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 20 Nov 2026 12:39:23 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 31/32] tracing: Add notrace to event functions that hook to ftrace
References: <20261120173852.687189370@kernel.org>
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

From: Steven Rostedt <rostedt@goodmis.org>

A few functions in trace_events.c are used to hook to the ftrace function
hooks. Before CONFIG_FUNCTION_SELF_TRACING was added, these functions were not
marked for tracing because the entire directory was set to "notrace". But
now that certain files can be traced by ftrace when the
CONFIG_FUNCTION_SELF_TRACING config is set, individual functions that use ftrace
must be annotated with "notrace" otherwise they can trigger a triple fault
when called.

Annotate the trace_events.c functions that are attached to ftrace with
"notrace.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261119124319.3a8bfe50@gandalf.local.home
Fixes: f93a7d0caccd6 ("ftrace: Allow tracing of some of the tracing code")
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c9d31c9f3fca..7f89160aeff3 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -4317,7 +4317,7 @@ static void update_event_probe(struct event_probe_data *data)
 		set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &data->file->flags);
 }
 
-static void
+static void notrace
 event_enable_probe(unsigned long ip, unsigned long parent_ip,
 		   struct trace_array *tr, struct ftrace_probe_ops *ops,
 		   void *data)
@@ -4334,7 +4334,7 @@ event_enable_probe(unsigned long ip, unsigned long parent_ip,
 	update_event_probe(edata);
 }
 
-static void
+static void notrace
 event_enable_count_probe(unsigned long ip, unsigned long parent_ip,
 			 struct trace_array *tr, struct ftrace_probe_ops *ops,
 			 void *data)
@@ -5205,7 +5205,7 @@ static DEFINE_PER_CPU(atomic_t, ftrace_test_event_disable);
 
 static struct trace_event_file event_trace_file __initdata;
 
-static void __init
+static void notrace __init
 function_test_events_call(unsigned long ip, unsigned long parent_ip,
 			  struct ftrace_ops *op, struct ftrace_regs *regs)
 {
-- 
2.53.0
