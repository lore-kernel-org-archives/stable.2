Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB9D4ADD92;
	Fri, 11 Sep 2026 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150575; cv=none; b=iiDYafn+XTSAYtv5ZGINO0UlAn3kdegLuE+TK0QMjS95lJAz683u3XA+xRdCH1a+hsI6xu2Y+Sfr+hYmkQud9Uc2a1rUK0wJh5+h2rGUt3JMpjyMHPhJUctNL48Oauha5/cXOvcM3zOcbc0ma+Ep/ggLxKZ4pjR3NFiutcffHfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150575; c=relaxed/simple;
	bh=pu7x1XTrqqwnrBHe1bktobDFHaD4drtP5XdJGehu0ZY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=CcbXzpqygPvHa4hVuQNebPYHYjhouH2bYyM27//hqhFZ6P12tHqKFLMgsGSVMrrlhFW0S4Ppe8B7mtILiw2BRmjL+FdQA3iRLRHb313KKcvP83Tij1YxSmG+KBFj+6ewApSu36O2j61Pl2healdxo5u9s4qDTkWyaH/L4JWRrrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMV1Rlgf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMV1Rlgf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D04C1F0089B;
	Fri, 11 Sep 2026 18:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789150567;
	bh=yKOQItjO/28zKn73DW1wyeZAtLYzsp22WZJIlvBneeQ=;
	h=Date:From:To:Cc:Subject:References;
	b=DMV1RlgfnQQQDqFszgGmcoMAxYifI06AwEMC4xfXYGp0PKNO3xv2/Wj/Wcqh/q0/T
	 i7mt7RPx0phpsiv6xDIjX5agGpxGQOzNIYqhnraaHYGAZxCwYb1Lw5OYZAJPmd4MRx
	 QgLDNQ9QMzI3hqHroXa01WQZEMJj3ZlT/Ql02U1L9WLnOaVXABtdZ4RqOVN5Dpj14M
	 iJiB6nvJGU6hZF6zDDyhWTNqCfRipVj3NAN09PjF3pEGzRMwRBe5zgMYGAU1S8ld4I
	 aYboM/5Iy14x6fR7dTHK+duxe0MLuwhODjBWO0sea4dJvbNOBQDd3ATRqsNrFeCyA4
	 aT/oYVUvdnY6A==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x55oX-000000094wf-0lon;
	Fri, 11 Sep 2026 14:17:29 -0400
Message-ID: <20260911181728.983943214@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 11 Sep 2026 14:16:40 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: [for-linus][PATCH 04/20] function_graph: Use the saved entrys size when reprinting it
References: <20260911181636.485043797@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

When a graph entry does not fit in the trace_seq, print_graph_entry()
saves it in the iterator's fgraph_data and reprints it on the next read.
The entry has already been consumed from the ring buffer by then, so the
copy is all that is left of it.

The copy is sized with iter->ent_size, which no longer describes the
saved entry but whatever entry the iterator has moved on to. The
argument count is derived from the same field, so a 72 byte entry saved
and then reprinted ahead of a 48 byte return entry loses its arguments.

Record the size next to the failure flag, so that the two are always set
together, and restore it before reprinting.

Cc: stable@vger.kernel.org
Fixes: ff5c9c576e75 ("ftrace: Add support for function argument to graph tracer")
Link: https://patch.msgid.link/20260906034406.1335316-1-donggeunyoo.kernel@gmail.com
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_functions_graph.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index ff7cb1a76b95..c5befd0c5b9a 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -52,6 +52,7 @@ struct fgraph_data {
 	};
 	struct ftrace_graph_ret_entry	ret;
 	int				failed;
+	int				ent_size;
 	int				cpu;
 };
 
@@ -1274,6 +1275,7 @@ print_graph_entry(struct ftrace_graph_ent_entry *field, struct trace_seq *s,
 		if (s->full) {
 			data->failed = 1;
 			data->cpu = cpu;
+			data->ent_size = iter->ent_size;
 		} else
 			data->failed = 0;
 	}
@@ -1457,6 +1459,7 @@ print_graph_function_flags(struct trace_iterator *iter, u32 flags)
 	if (data && data->failed) {
 		field = &data->ent.ent;
 		iter->cpu = data->cpu;
+		iter->ent_size = data->ent_size;
 		ret = print_graph_entry(field, s, iter, flags);
 		if (ret == TRACE_TYPE_HANDLED && iter->cpu != cpu) {
 			per_cpu_ptr(data->cpu_data, iter->cpu)->ignore = 1;
-- 
2.53.0
