Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163DC6DCE1
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 04:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786249224; cv=none; b=rp8MJTcl8NYagtNPJUPy7svHiPzfYnL3c85Ed1Jmr5bNFQQWuJ4k0ct7aKHUweCZraidmdOVzZzXuCB7NJcF1MY/T9Qg/4Ic52ia6kakEqMfsk9eOZpg7hzgLpfw9dxGe0TcFOvlqeLP0F1EpZj63uQmGLKCAvjVuyxIQTwqI5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786249224; c=relaxed/simple;
	bh=q0hbTID3fEGjxkSBPRQoA+bKvBZ6cHJE+9riq78i7gU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mugbiB2P64YYHsLtBFWxn6oAa2SeWTOSAVoPrmRHra1bmoouy1mre9hnjiNGhcMRyIG4CbNnDWGtxzroEobp1+39y2uVeYN8RVEVRlDTojWbvM8up6SEADC9nuTKxYFys9GKDjq4d/l9d7TYlqY17aAS1a9Like3uBMZXm0ZZhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sb+8WJdp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sb+8WJdp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D24D51F000E9;
	Sun,  9 Aug 2026 04:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786249222;
	bh=f8uKNhopyO9XB4l/Y+9e7urBsjPwf7lRjT5SSODt7CY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sb+8WJdpq8uOymLX5aCx8vWr0fb9y1GZI8awdDt00255K/N4wohQfYWXs4jyRm73P
	 7A/F2+nZiZmMsp755LaEK7Ex/6vgueY7CWBbPsFmXoy0WTLlwj8bNrHtcSKQ+LrW6j
	 LzeFg9KBKvFbCVsVEQg2qKTnxbD2dWDBs30Men0mBqiJG6VQVlqw1pfFa9GCw2qG12
	 wuUwcHQui5QFIC6mz1Y5dOCoebS6rwmXuVL9LpDNu2m/yUK2anl3VEpK+iQ3c0E1RA
	 Hy1uPx+YtQ5Ua0KV5dhOC7i3J59aLtfSM19KEaDn0PLr3jiwJy4PWX0Vb/RjisVQcR
	 0NMTi5t65Fq0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tengda Wu <wutengda@huaweicloud.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ftrace: Add global mutex to serialize trace_parser access
Date: Sun,  9 Aug 2026 00:20:20 -0400
Message-ID: <20260809042020.1093442-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072932-stainable-backspace-b113@gregkh>
References: <2026072932-stainable-backspace-b113@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tengda Wu <wutengda@huaweicloud.com>

[ Upstream commit 7720b63bcef3f54c7fe288774b720a227d54a306 ]

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
[ Replaced `guard(mutex)(&parser_lock)` with explicit `mutex_lock`/`mutex_unlock` pairs because 5.15 builds `-std=gnu89` with `-Werror=declaration-after-statement`. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ftrace.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index e86064b14259a..19d6782a93d29 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1042,6 +1042,12 @@ struct ftrace_ops global_ops = {
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
@@ -4928,6 +4934,8 @@ ftrace_regex_write(struct file *file, const char __user *ubuf,
 	/* iter->hash is a local copy, so we don't need regex_lock */
 
 	parser = &iter->parser;
+
+	mutex_lock(&parser_lock);
 	read = trace_get_user(parser, ubuf, cnt, ppos);
 
 	if (read >= 0 && trace_parser_loaded(parser) &&
@@ -4941,6 +4949,7 @@ ftrace_regex_write(struct file *file, const char __user *ubuf,
 
 	ret = read;
  out:
+	mutex_unlock(&parser_lock);
 	return ret;
 }
 
@@ -5675,12 +5684,14 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
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
 
@@ -5998,10 +6009,12 @@ ftrace_graph_release(struct inode *inode, struct file *file)
 
 		parser = &fgd->parser;
 
+		mutex_lock(&parser_lock);
 		if (trace_parser_loaded((parser))) {
 			ret = ftrace_graph_set_hash(fgd->new_hash,
 						    parser->buffer);
 		}
+		mutex_unlock(&parser_lock);
 
 		trace_parser_put(parser);
 
@@ -6121,6 +6134,7 @@ ftrace_graph_write(struct file *file, const char __user *ubuf,
 
 	parser = &fgd->parser;
 
+	mutex_lock(&parser_lock);
 	read = trace_get_user(parser, ubuf, cnt, ppos);
 
 	if (read >= 0 && trace_parser_loaded(parser) &&
@@ -6134,6 +6148,7 @@ ftrace_graph_write(struct file *file, const char __user *ubuf,
 	if (!ret)
 		ret = read;
 
+	mutex_unlock(&parser_lock);
 	return ret;
 }
 
-- 
2.53.0

