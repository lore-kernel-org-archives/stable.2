Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792498812;
	b=DeCj+/tgp3Hm8odS/vHWSv3+sEpuN1xgYMS/9YTw7voFPYyeLd0l8/r2RFE77iBh6N4H
	 WIW5A7mNGRj5qMU7ShzkXHhJm+O8sblN+zSAXxFHU/9coMNSGPvq9dW0pozlHBlanq+7q
	 fMidijqPKM2dopMnhCZ1BMiAF8qwtGn+lpGNijkrFUt9nAhFptkSXEc+IwZTJTUuuUBMw
	 nv0hJsRzBgvdZ0VAS5CGmxgaSNaN7H0M2eSIHE9W4im17NTkuwLb958IsOp/tkP5Lms3C
	 cPgjolVga5qjbHsOVX0HK1j87Sk7xMF97wd5TO8v2uJXW/zCWqt6oYWVSTtrjZ0pU+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792498812;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=jUdPUXgNaj3Cp0RL8qgLl9uXKgsmy6m5HypnnGpwoGM=;
	b=TrK95s65UEfvipQsDatwAdExrXYPtch1w+ZYpt6FlNh2h0ZxdMQcugyR0Um5WcN3nDuY
	 ML3XWbyulWCORzVmFwSkPwib2hLgAefIXX6BKuLFj1koeOKkzkwO6yXHNd6X9qzR4jBCs
	 UPVEdiVgzWjNCLKmR5ip0S+j1A+EYKjeT64AJlxsYzKlKDepQ3XjthktOh8B/EMLg4vvD
	 +9Of+lTS4NgFMbv34uXNsZFC+pAedONPv8W8S9yEQt8jRgHszvDCKhFpSoNw6bC/zkjMl
	 GMNzsyNwIWQlTD3e6Ru8IFyoGuZmYzbDXK4HFIJ2X3itAY8OpWJBgkkIz8Dy5S8AU0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oqRoKq7d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D00B606A33E;
	Tue, 20 Oct 2026 12:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oqRoKq7d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F0C1F000C9;
	Tue, 20 Oct 2026 12:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792498812;
	bh=jUdPUXgNaj3Cp0RL8qgLl9uXKgsmy6m5HypnnGpwoGM=;
	h=Date:From:To:Cc:Subject:References;
	b=oqRoKq7drguhftX+AF6mEHiBDzIMBCoQJvnKvXJXgJPDmWs7nhh99FkEGr0Zp5cr4
	 wkSPtgrQ/wTDNzrGl1N/uWd1iOu51SUI+c0hHJCYI+oOcm98fhOOteLoz4f0GShbIR
	 qNxOtpKQm6N3W69/ANa29Eu3AHkDoSsAiHN4BCPa0WkYYIurHrKDu+Yn3Fmydti1uG
	 ms2LBA4RcOSRf9L/y4LcYihQgsnUl1big9w9Qycb+tfW07VeYFw7j6WPrk7SPiAwcv
	 MtXjem76GG6M1CLweamxzGgTnAYRU7wXkdbZH2+5J8VrOWLfgc5Z0FM0oZJ861UCbq
	 lxM+2dfStQvQQ==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xJ8p9-00000001y2p-0x9C;
	Tue, 20 Oct 2026 08:20:11 -0400
Message-ID: <20261020122011.033386537@kernel.org>
User-Agent: quilt/0.69
Date: Tue, 20 Oct 2026 08:19:59 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 David Carlier <devnexen@gmail.com>
Subject: [for-next][PATCH 3/6] tracing: Hold trace_types_lock when resetting last boot data from
 readers
References: <20261020121956.600452831@kernel.org>
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

From: David Carlier <devnexen@gmail.com>

update_last_data_if_empty() is called from tracing_open() with O_TRUNC,
tracing_read_pipe() and tracing_buffers_read() without trace_types_lock.
Two readers can both pass the LAST_BOOT test and free module_delta
twice, and a module notifier can update module_delta while it is being
freed.

Take trace_types_lock in those paths and keep the callers that already
hold it on an unlocked variant.

Cc: stable@vger.kernel.org
Fixes: 32dc0042528d ("tracing: Reset last-boot buffers when reading out all cpu buffers")
Link: https://patch.msgid.link/20261016061638.214847-2-devnexen@gmail.com
Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 96005a930b25..08614af8fad1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3603,6 +3603,7 @@ static int tracing_single_release_tr(struct inode *inode, struct file *file)
 	return single_release(inode, file);
 }
 
+static bool __update_last_data_if_empty(struct trace_array *tr);
 static bool update_last_data_if_empty(struct trace_array *tr);
 
 static int tracing_open(struct inode *inode, struct file *file)
@@ -4697,7 +4698,7 @@ tracing_set_trace_read(struct file *filp, char __user *ubuf,
 int tracer_init(struct tracer *t, struct trace_array *tr)
 {
 	tracing_reset_online_cpus(&tr->array_buffer);
-	update_last_data_if_empty(tr);
+	__update_last_data_if_empty(tr);
 	return t->init(tr);
 }
 
@@ -5371,8 +5372,10 @@ static int tracing_wait_pipe(struct file *filp)
 	return 1;
 }
 
-static bool update_last_data_if_empty(struct trace_array *tr)
+static bool __update_last_data_if_empty(struct trace_array *tr)
 {
+	lockdep_assert_held(&trace_types_lock);
+
 	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
 		return false;
 
@@ -5387,6 +5390,16 @@ static bool update_last_data_if_empty(struct trace_array *tr)
 	return true;
 }
 
+static bool update_last_data_if_empty(struct trace_array *tr)
+{
+	/* Avoid the lock on the read path unless this is a last boot buffer */
+	if (!(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
+		return false;
+
+	guard(mutex)(&trace_types_lock);
+	return __update_last_data_if_empty(tr);
+}
+
 /*
  * Consumer reader.
  */
@@ -6476,7 +6489,7 @@ int tracing_set_clock(struct trace_array *tr, const char *clockstr)
 		ring_buffer_set_clock(tr->snapshot_buffer.buffer, trace_clocks[i].func);
 	tracing_reset_online_cpus(&tr->snapshot_buffer);
 #endif
-	update_last_data_if_empty(tr);
+	__update_last_data_if_empty(tr);
 
 	if (tr->scratch && !(tr->flags & TRACE_ARRAY_FL_LAST_BOOT)) {
 		struct trace_scratch *tscratch = tr->scratch;
-- 
2.53.0
