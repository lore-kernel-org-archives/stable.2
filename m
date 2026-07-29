Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892FF453A44
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 14:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785335867; cv=none; b=nHTVCAjk6laB8l5YVSfNy7UGH3/rTs/RS/MJ2LdJXNSFIQzIq2MVo3EHwqCL64lj5JzXyZvezJHD1mww/eGQ1pDkfjJa+xtwbZRAgSaGP08NnqEa0Tc2yZT0X/gjWXJXhuYu1O6z0aPHDlELAaKyrkQjJVgyXl2vlLPtXCBKd3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785335867; c=relaxed/simple;
	bh=nfzFjMYBnHrYabB//qjKPcoY6Mgx8RQ0TYIeuU0fcIw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TpK6U/ckBxd28rFEuCebV+PV0RTeHSRSr9aTwPo/8TKJ3gh7XEPp8xmT52Q3B0duDQJxQbrWc6pS5eDI16d0F9NEH0jnQzq75MUvTEZapKBmcfxyxCMSw5KJFkygkbtI0Vow5gxiwQidZ7ZDgPYa9Bls/s3yIP3PpDi9wYciylU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fERze2SL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fERze2SL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8261F000E9;
	Wed, 29 Jul 2026 14:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785335866;
	bh=9R/y+IUNVSRRDb/2HiFhqt/HUWswKt2t5F+m7yLXQWI=;
	h=Subject:To:Cc:From:Date;
	b=fERze2SLDPLOuHb5jntxyZANCqFtMU555xK8dylYjRpXcZqoLmraQUxv1QvPIojEP
	 J+Yrzziuk53Dbn7SyHQ7ElVXDbGqrUM0dOFKDQA6yCmZO+93oI8eTcj6618jlpMwga
	 LijlpXY3L5PkEP/R2pWLsTKkHm/VTr5o2Bwl+/lU=
Subject: FAILED: patch "[PATCH] ftrace: Add global mutex to serialize trace_parser access" failed to apply to 5.15-stable tree
To: wutengda@huaweicloud.com,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 16:37:32 +0200
Message-ID: <2026072932-stainable-backspace-b113@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7720b63bcef3f54c7fe288774b720a227d54a306
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072932-stainable-backspace-b113@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7720b63bcef3f54c7fe288774b720a227d54a306 Mon Sep 17 00:00:00 2001
From: Tengda Wu <wutengda@huaweicloud.com>
Date: Sat, 25 Jul 2026 02:47:21 +0000
Subject: [PATCH] ftrace: Add global mutex to serialize trace_parser access

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

