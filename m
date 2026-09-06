Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D706933A6EB;
	Sun,  6 Sep 2026 01:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788659150; cv=none; b=YF1K7mZBtTthScpysgd8MnOF1UjsXTrE+DG/UlyoTcX2IQdXb7MJJ6bW//OCKnUWZlmlN/fbonaLgj/WzaIXS0xdvhSe5lwJAO9rv/eSGPdLerJHCkPvCsykd4ebzgBMRCzSG+0OaPBBvrbx4l+KynzhGFbrTZsymG0Ltzl88Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788659150; c=relaxed/simple;
	bh=CB3IZDvKjhzxpQfenh3OJm8qxNZ8dN3oksgefFj5X7c=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=MvR4se7jVHy2NgsjJXqx70QTySgWzi9tea9sJlekLHW/8qglLLcZrYkmTU2x3sCE11v61giiW7VjqYVsjyTEulqPeF+2414MtA8NgXtFJa0LFh62lYknvMuZuOGWWOyp3j3eOr4pP9S6jqYPOYydE6ZhSn++KvMUVb0M1e+Owng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBBDJga5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBBDJga5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767161F00A3E;
	Sun,  6 Sep 2026 01:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788659146;
	bh=uD0iVatw9o5KBLCWHhBsA7JNpLY36dD/rxu/pUX9iOA=;
	h=Date:From:To:Cc:Subject:References;
	b=hBBDJga5jjJqyMEIiEgsPDP0zt4VpelSQC/T7UVGG5jMcSxmO5f6vHlgKgPkgyXsN
	 zz3NRS5Pn+UwZXCatfPY51/ZsxUTmnvXRQ20ervwBkXbSagxjuezwpcNqEyPuoZqlz
	 YEFuUneVe6UyDfLcVwzlK9G1OBw5k3aQnZE16pQ8szTdHQvIs0c6tsg1LAL5FzI7mH
	 FfV1XWRTpOMV+kifqg3K+Or5DM3dKTtgu187Nus0WzWOxEDa3A8NqeWdtrgT1gT9cZ
	 lLcLA07xajfozeOxeAJgfxcxJFzPQAHYdlI3mt0ZLVnXB0zB18DaVPAlCdtYKsWziC
	 IZFmu3Jj5crtA==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x31yB-00000006PNh-1Zlv;
	Sat, 05 Sep 2026 21:46:55 -0400
Message-ID: <20260906014655.222422380@kernel.org>
User-Agent: quilt/0.69
Date: Sat, 05 Sep 2026 21:45:32 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 stable@vger.kernel.org,
 Farhad Alemi <farhad.alemi@berkeley.edu>,
 Aaron Tomlin <atomlin@atomlin.com>
Subject: [for-linus][PATCH 01/12] tracing: Have show_event_filters/triggers files take trace array ref
References: <20260906014531.720267751@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The newly added files show_event_filters and show_event_triggers that show
all filters or triggers that are set within the trace array do not take a
reference for the trace array it is showing. Without taking a reference,
the trace_array may be freed via "rmdir" while a task is reading one of
theses files. Those files iterate all the events within an instance
(trace_array) and nothing prevents that instance from being freed while
its data is being read. This causes a use-after-free crash.

Have the open of both those files take the trace_array reference via the
trace_array_get() that prevents the trace_array from being freed while the
files are opened.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260828094153.17b95037@gandalf.local.home
Fixes: 729757b96a662 ("tracing: Add show_event_filters to expose active event filters")
Fixes: 6a80838814eea ("tracing: Add show_event_triggers to expose active event triggers")
Reported-by: Farhad Alemi <farhad.alemi@berkeley.edu>
Closes: https://lore.kernel.org/all/CA+0ovCjerKZJLwXScM9bF2ga2rLi4_XOpUfK41NDbENpeu98jA@mail.gmail.com/
Reviewed-by: Aaron Tomlin <atomlin@atomlin.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 1d39eaf6a0f7..9dbc2441763b 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2736,14 +2736,14 @@ static const struct file_operations ftrace_show_event_filters_fops = {
 	.open = ftrace_event_show_filters_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
-	.release = seq_release,
+	.release = ftrace_event_release,
 };
 
 static const struct file_operations ftrace_show_event_triggers_fops = {
 	.open = ftrace_event_show_triggers_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
-	.release = seq_release,
+	.release = ftrace_event_release,
 };
 
 static const struct file_operations ftrace_set_event_pid_fops = {
@@ -2908,7 +2908,17 @@ ftrace_event_set_open(struct inode *inode, struct file *file)
 static int
 ftrace_event_show_filters_open(struct inode *inode, struct file *file)
 {
-	return ftrace_event_open(inode, file, &show_show_event_filters_seq_ops);
+	struct trace_array *tr = inode->i_private;
+	int ret;
+
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
+
+	ret = ftrace_event_open(inode, file, &show_show_event_filters_seq_ops);
+	if (ret < 0)
+		trace_array_put(tr);
+	return ret;
 }
 
 /**
@@ -2922,7 +2932,17 @@ ftrace_event_show_filters_open(struct inode *inode, struct file *file)
 static int
 ftrace_event_show_triggers_open(struct inode *inode, struct file *file)
 {
-	return ftrace_event_open(inode, file, &show_show_event_triggers_seq_ops);
+	struct trace_array *tr = inode->i_private;
+	int ret;
+
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
+
+	ret = ftrace_event_open(inode, file, &show_show_event_triggers_seq_ops);
+	if (ret < 0)
+		trace_array_put(tr);
+	return ret;
 }
 
 static int
-- 
2.53.0


