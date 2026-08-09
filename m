Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8DC1531E8
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 13:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786283665; cv=none; b=QKfq0QKsy5WHVHXeiNfx63lWOuQ1YHX1ePjfiTl1J+Un9ZvorROWmrCKK7hxc9/P5Cm06RZ34ZRt2pXzD3MuB/rxPKeQkBixZgT248xPUemX3mHWcUZXZ/UmrzngjdCa7Y4bMiGoaBx0hs2kz5LLQvifqF24wnI4/IEEQd0Dgow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786283665; c=relaxed/simple;
	bh=JpnV7KGHYkNNaFdQwLJoEkdkAP2lWT0xkCeveY50d2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyycvdNZD4v0NaAe8Ta5d2Zg1OuDp8cVSNLrvVHWv7odIXmQ3Hjo6ffxCj5v6FSUz6WdgB5wRY5iamvxecxWrgAsepZDn157MruCy8HSjl/KT8KylnxFygw0thqOsZAXcNfjF6lRgsDyXXvijt5Y0Eu3cJyd2jsHsBo8f0WwBq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAhufoYB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAhufoYB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DC11F000E9;
	Sun,  9 Aug 2026 13:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786283663;
	bh=B719tlJqGIJoLI4+YQor7fdi4CyM+ISp79aKD5q+3nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FAhufoYBOuvyRkrsibWFAdhYloM5sP/AMc80f5TxN89Dmh/dn0egWIzhkX3eNb8dg
	 rmZNGhiM0JHEJsHIQfOUNJYvB9vC3d8CA5/7jcrxCOcCwaga/kOjknM/PJdY2yHoxT
	 z0rTy7zI9aih2K0q241jjcIiCOtYAAmnc0k1kKO4SD6FQBPGOGLKe/yrqrC6aDPdhm
	 gG59Uyc2u/NWJ10jOQKPOefn+a1mbWcHxzMTsnAMzHOk3lxMfw0mo0krl6NSZlsvCf
	 fqSPHHdRHAlV7QxF9JUStJOCqsnsFKgvBDLKs2C1tCz6PTKS4NXhm206bnVroVSgBR
	 zyOCDI6I/vbpw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tengda Wu <wutengda@huaweicloud.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ftrace: Add global mutex to serialize trace_parser access
Date: Sun,  9 Aug 2026 09:54:19 -0400
Message-ID: <20260809135419.1506594-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072933-reprint-squad-0d54@gregkh>
References: <2026072933-reprint-squad-0d54@gregkh>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ftrace.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index e62bbeb94faf1..e4f10591b71c4 100644
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
  * Used by the stack undwinder to know about dynamic ftrace trampolines.
  */
@@ -4934,6 +4940,8 @@ ftrace_regex_write(struct file *file, const char __user *ubuf,
 	/* iter->hash is a local copy, so we don't need regex_lock */
 
 	parser = &iter->parser;
+
+	mutex_lock(&parser_lock);
 	read = trace_get_user(parser, ubuf, cnt, ppos);
 
 	if (read >= 0 && trace_parser_loaded(parser) &&
@@ -4947,6 +4955,7 @@ ftrace_regex_write(struct file *file, const char __user *ubuf,
 
 	ret = read;
  out:
+	mutex_unlock(&parser_lock);
 	return ret;
 }
 
@@ -5682,12 +5691,14 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
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
 
@@ -6005,10 +6016,12 @@ ftrace_graph_release(struct inode *inode, struct file *file)
 
 		parser = &fgd->parser;
 
+		mutex_lock(&parser_lock);
 		if (trace_parser_loaded((parser))) {
 			ret = ftrace_graph_set_hash(fgd->new_hash,
 						    parser->buffer);
 		}
+		mutex_unlock(&parser_lock);
 
 		trace_parser_put(parser);
 
@@ -6127,6 +6140,7 @@ ftrace_graph_write(struct file *file, const char __user *ubuf,
 
 	parser = &fgd->parser;
 
+	mutex_lock(&parser_lock);
 	read = trace_get_user(parser, ubuf, cnt, ppos);
 
 	if (read >= 0 && trace_parser_loaded(parser) &&
@@ -6139,6 +6153,7 @@ ftrace_graph_write(struct file *file, const char __user *ubuf,
 
 	if (!ret)
 		ret = read;
+	mutex_unlock(&parser_lock);
 
 	return ret;
 }
-- 
2.53.0

