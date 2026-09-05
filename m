Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B2E32B109;
	Sun,  6 Sep 2026 01:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788659050; cv=none; b=UetoKZAHCmpcpEj17OGfFkKVIwAd7+mLfMLGIEwkXSIgyqkieLug0vadNY4JdTct13y1hp85hIqX3KiAvRlpssrCnD0B0k9o115AA88pUk/Ty08fc3qmiPrkGnb7up69LnFTrzPoXL2Ie8JshpLJ02lX9WS1kTEYSYm0Fa8tWN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788659050; c=relaxed/simple;
	bh=CB3IZDvKjhzxpQfenh3OJm8qxNZ8dN3oksgefFj5X7c=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=LFRte8caNgZJnCfByhZOPCPnoMfEMpbd9QvqV8OAlQAQGPlAeFAw6zCqXKAJw1IfpoTZYznJGJm0rVtJ0XQO3AZVCJodJDJXGRpPERkR19lElFKHiqcaNHhXqLrEH8q9Qx1mSxUU4b3/58AQVNt6iZZ9Tm45NMdz2PlZz6y6s9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cB5BYysB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cB5BYysB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFF61F00A3A;
	Sun,  6 Sep 2026 01:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788659048;
	bh=uD0iVatw9o5KBLCWHhBsA7JNpLY36dD/rxu/pUX9iOA=;
	h=Date:From:To:Cc:Subject:References;
	b=cB5BYysBMML9l3T+XE+qBugLwa2BH+bUrh16v0rJcR+x4rB1TYq5+Vbm81MYCYDlt
	 ib//DQKGj7znTP9Wm4YjMTJbU+f2i4yi8M+uvPKiers4DDdnonjpQu4gL1LA2yJUdn
	 iR3grL9FCs54jSAP+gnuuwPOE7ePJBS95KqxOTM404pdLR1dW4xCILZ7BStMuZI1PF
	 yQ+c4ohKgYxfH0baMQLfgAzsPFgywo/v+KL2hICSxDEtt5bz5GF9sTLZmeQQ6wE36+
	 vL/yliW//GybJEqUYyVi9K0qT1WCi0MWLLL7weh0nDmNUT/hcnNgnNtcdH0ZXRvk/C
	 9Q5rTGkFFTWRQ==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x2whP-00000006J8e-05cb;
	Sat, 05 Sep 2026 16:09:15 -0400
Message-ID: <20260905200914.872879851@kernel.org>
User-Agent: quilt/0.69
Date: Sat, 05 Sep 2026 16:08:28 -0400
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
References: <20260905200827.773347757@kernel.org>
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


