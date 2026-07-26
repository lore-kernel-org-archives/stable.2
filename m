Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CE62FE060;
	Sun, 26 Jul 2026 02:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785033328; cv=none; b=IUwDXP+Il0EpJh0OqIrIk+dA8RxQmeji2rZeGDb0mZTZGUC1WyS5KE2g7ZB91sAnEdf/bYRBcETsZB+I2h95BhEsc0dgrxQvVhK1L5aq3wyS+9CuyXs0pQrrxqvU5Ox9wq4CFyUn3AYCHlBp+o4gLM2QQ73KEiLDkvhLRFmAvHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785033328; c=relaxed/simple;
	bh=oIWYAMmidZD0kZfCH1zRLgzBmOXtRY6/SBmJcHwF1ek=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=to5+eagSljEmCvVozeORWRvFmUIzBp8gHGvhtdv3BWr0EC1rDj/cQqMQBCfaqiA+BB82VtwI/Y+d/CZR8SknNozt5VZQjq0M9yRpJRGHT3hVM30WJlmF/JWjYsQWnihrRJ99yp1QKsmQlFSyUKParO+MRcUnyJtTloWM5u6eb8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DShIAFSO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DShIAFSO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1571F00A3A;
	Sun, 26 Jul 2026 02:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785033326;
	bh=OXewOGcQUe5+gxv+NpJ/NWc5pXQs7GBqbEhTQK2cbBY=;
	h=Date:From:To:Cc:Subject:References;
	b=DShIAFSONz1S3SLqbhPeVZci1RG3RGP1VtZdPAV3+TGdcX4/WhoWVSRUDa2vt+RHO
	 fiFZ7EiH1m85CSagr+54N2AZJdagcG3xT37LdZz8Jt81AmgB+qHjPkxiw5dCtX9IDY
	 W55RSbip9bhaINMtXPuAxklL/LAzowy+xzrjeW5ub7hHUlkQ2b3wVMkT5k04/50qb2
	 I7hylza9GBbYqIQrDEqzqwokWBPiHggfcG/f3PsaU9I+fNzxF+4HLaOo4+VbgOrtIe
	 2v3wheBYM/udQZJ+3KWQhvoM8veNFHoN+QtH5IhtHkv/0yh6fX7bPTAsw7ZuLazjoF
	 VqZ/0cH87QcQQ==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wnoiY-00000004bzt-4C4T;
	Sat, 25 Jul 2026 22:35:55 -0400
Message-ID: <20260726023554.847812168@kernel.org>
User-Agent: quilt/0.69
Date: Sat, 25 Jul 2026 22:35:43 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Tengda Wu <wutengda@huaweicloud.com>
Subject: [for-linus][PATCH 1/2] ftrace: Add global mutex to serialize trace_parser access
References: <20260726023542.092577615@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tengda Wu <wutengda@huaweicloud.com>

In ftrace, the trace_parser structure is allocated and initialized when
a trace file is opened, and is subsequently used across write and release
handlers to parse user input.

The affected handler paths and their specific functions are:
  - Open paths: ftrace_regex_open(), ftrace_graph_open()
  - Write paths: ftrace_regex_write(), ftrace_graph_write()
  - Release paths: ftrace_regex_release(), ftrace_graph_release()

If userspace opens a trace file descriptor and shares it across multiple
threads, concurrent write calls will race on the parser's internal state,
specifically the 'idx', 'cont', and 'buffer' fields, leading to corrupted
input or undefined behavior.

Fix this by adding a global mutex, parser_lock, to serialize all access
to trace_parser across write and release paths, preventing concurrent
corruption of parser state.

Fixes: e704eff3ff51 ("ftrace: Have set_graph_function handle multiple functions in one write")
Fixes: 689fd8b65d66 ("tracing: trace parser support for function and graph")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260725024721.1983675-1-wutengda@huaweicloud.com
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f93e34dd2328..6c47a94f5924 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1097,6 +1097,12 @@ struct ftrace_ops global_ops = {
 					  FTRACE_OPS_FL_PID,
 };
 
+/*
+ * parser_lock - Protects trace_parser state against concurrent operations.
+ * Held across trace_get_user() and subsequent buffer parsing to prevent races.
+ */
+static DEFINE_MUTEX(parser_lock);
+
 /*
  * Used by the stack unwinder to know about dynamic ftrace trampolines.
  */
@@ -5842,6 +5848,8 @@ ftrace_regex_write(struct file *file, const char __user *ubuf,
 	/* iter->hash is a local copy, so we don't need regex_lock */
 
 	parser = &iter->parser;
+
+	guard(mutex)(&parser_lock);
 	read = trace_get_user(parser, ubuf, cnt, ppos);
 
 	if (read >= 0 && trace_parser_loaded(parser) &&
@@ -6984,12 +6992,14 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
 		iter = file->private_data;
 
 	parser = &iter->parser;
+	mutex_lock(&parser_lock);
 	if (trace_parser_loaded(parser)) {
 		int enable = !(iter->flags & FTRACE_ITER_NOTRACE);
 
 		ftrace_process_regex(iter, parser->buffer,
 				     parser->idx, enable);
 	}
+	mutex_unlock(&parser_lock);
 
 	trace_parser_put(parser);
 
@@ -7321,10 +7331,12 @@ ftrace_graph_release(struct inode *inode, struct file *file)
 
 		parser = &fgd->parser;
 
+		mutex_lock(&parser_lock);
 		if (trace_parser_loaded((parser))) {
 			ret = ftrace_graph_set_hash(fgd->new_hash,
 						    parser->buffer);
 		}
+		mutex_unlock(&parser_lock);
 
 		trace_parser_put(parser);
 
@@ -7437,6 +7449,7 @@ ftrace_graph_write(struct file *file, const char __user *ubuf,
 
 	parser = &fgd->parser;
 
+	guard(mutex)(&parser_lock);
 	read = trace_get_user(parser, ubuf, cnt, ppos);
 
 	if (read >= 0 && trace_parser_loaded(parser) &&
-- 
2.53.0


