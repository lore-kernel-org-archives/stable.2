Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196477;
	b=l81hPz/QbNrvYiVEr50jGx2K6wuPqQH0t8hdIXiXGSkm07vD0J0Gbwyld8lH4omHhuY3
	 n+01vxOu4XKcvdIAyjdPJDJz3wF0fm9EeTVshu/K9DfnbVpys3j/Jx/oEUcLRt5d6WiBu
	 Njnl67uPqq4jaadEDxmjoCrb5YTDYuRamakWAc46LEiP+GQWQQhw0RQ9DyXjBd/oPbShg
	 afZAy7ShcByTLHs0UvFIP7S4ViCCzwXkk5fi6FvWyIHYmtA2iYtI/7ERKJu21nSyXU8DO
	 LAM6htcxh8QpwGzRaOACVYVygJWCYALsNqSJlvkyWg3c6urcXBoqKrYWWs00lMJiWDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196477;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=tNHeeDCQvfwWa1QOMbRxkHx7Vhy2KBbZP/oe2wh3pok=;
	b=iIB9mUQOnr6YWZNbFHTQtd3KHOCjPW/bE2Nz1Y6AMs6C0p1g/nKXEM+d/Gqgo1Gr2+P8
	 7VhP2Uy9lQ4kqmjGibHplWrn6MazPEi2wFhrY7g7NfI8Wqrsn45ADjZ2yJaPUBCLq9b7I
	 w1XtoNnklkrLqaLkl+mumFc/6u+zxCEBTs8u6CjfX7miCXFv+ZQxiKvqiDpPDH1umJDND
	 /H6EVMSDsHNhTpKKZqcxJy7FNNhU9FIfgJeIBoozpvAUB+OzMmwQ549n8UG/rRwLQRPkY
	 zj3WjLGLHj/i/JI3iedALsENJBZc3eEE/+Qsz/N2jaEhOOZ7/HOWaPWRNS3sAoC1cGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gdw5OeY+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9D260A382E;
	Fri, 20 Nov 2026 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gdw5OeY+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C1C1F01565;
	Fri, 20 Nov 2026 17:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795196477;
	bh=tNHeeDCQvfwWa1QOMbRxkHx7Vhy2KBbZP/oe2wh3pok=;
	h=Date:From:To:Cc:Subject:References;
	b=Gdw5OeY+7zqq4/GojE2VO1oF2EnwwnYEW511w+djO4tLOGSWyZS7WoLPdsTt+4fYC
	 TG9yL9Uty2iicNg8JOEZOURotK70CFQa6FNvrvsY9tUlgMS7xW/8XVvb0qcTliKG9q
	 NdN/pcLmRWSkqwPH1lX1GgvuDLdY8yVvLMzIpBYJEv8rno2k8Da5JzeNOzC62K7b4N
	 Do7BgQYfz7GSscmfLM6xH9aClqthUvxtgXI/sP21Usy0QtKLsFpRwUUxmAk05FQRv4
	 xGejEjO1iUkMSpfhCaMoYkEIlN0zg9qFwu49jBqvTtpxmiPQl2DQAfsU16SGIj6uqY
	 7a9S1srAuwhvw==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xUSbs-00000004aKt-22qH;
	Fri, 20 Nov 2026 12:41:16 -0500
Message-ID: <20261120174116.322091512@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 20 Nov 2026 12:39:04 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
Subject: [for-linus][PATCH 12/32] tracing: Free tracer resources on instance creation failure
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

From: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>

Creating a tracefs instance can allocate private tracer nodes, copied
flags and option arrays before trace_array_create_dir() returns. If a
later allocation fails, trace_array_create_systems() frees the trace_array
without releasing those private allocations. The failed instance is never
registered, so normal removal cannot reclaim them.

Free the tracer nodes and option arrays when trace_array_create_dir()
fails, then continue through the existing trace_array cleanup. Share the
option array cleanup with normal instance removal. Earlier failures still
use out_free_tr because the tracer list is not yet initialized there.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261029173127.387835-1-pocj8ur4in@gmail.com
Fixes: 428add559b69 ("tracing: Have tracer option be instance specific")
Signed-off-by: Baek Kyu, Kim <pocj8ur4in@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 527b16690acb..b11ec4d3cfb8 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1456,6 +1456,13 @@ static void free_tracers(struct trace_array *tr)
 	}
 }
 
+static void free_tracer_options(struct trace_array *tr)
+{
+	for (int i = 0; i < tr->nr_topts; i++)
+		kfree(tr->topts[i].topts);
+	kfree(tr->topts);
+}
+
 /**
  * register_tracer - register a tracer with the ftrace system.
  * @type: the plugin for the tracer
@@ -8763,7 +8770,7 @@ trace_array_create_systems(const char *name, const char *systems,
 	if (trace_instance_dir) {
 		ret = trace_array_create_dir(tr);
 		if (ret)
-			goto out_free_tr;
+			goto out_free_tracers;
 	} else
 		__trace_early_add_events(tr);
 
@@ -8773,6 +8780,9 @@ trace_array_create_systems(const char *name, const char *systems,
 
 	return tr;
 
+ out_free_tracers:
+	free_tracers(tr);
+	free_tracer_options(tr);
  out_free_tr:
 	ftrace_free_ftrace_ops(tr);
 	free_trace_buffers(tr);
@@ -8926,10 +8936,7 @@ static int __remove_instance(struct trace_array *tr)
 	if (tr->flags & TRACE_ARRAY_FL_VMALLOC)
 		vfree((void *)tr->range_addr_start);
 
-	for (i = 0; i < tr->nr_topts; i++) {
-		kfree(tr->topts[i].topts);
-	}
-	kfree(tr->topts);
+	free_tracer_options(tr);
 
 	free_cpumask_var(tr->pipe_cpumask);
 	free_cpumask_var(tr->tracing_cpumask);
-- 
2.53.0
