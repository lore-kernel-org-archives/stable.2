Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603174;
	b=Kplhxc65Ajyiz9K35PcLyPouJlzP1OtcyQjrnECSs0bO8oobn6VGrgNA1UvqKvJP4H0n
	 ohbnLoAgWQ4F7bDoz7cTMu2ctxtuJe/5W2YAbSOgB154dY4LBE5lW0ZHaicr4b0JcHK4D
	 ep9xIYihdC4uf4QQExSnIqxB50uBMZq9T72mYg/e++JkRMqysfqDAqmleshtTxuTV2nc3
	 pQD3rijGoW2lUkLfXvNrQsGoikrKMFhMPof2WWh6G6nWJsNLAt6qY1mTguNB4gGUwYGZp
	 5yAvCfHMhKEgfJ3GvTT+IyHZGlmCP5nkbJHGDCX+RZLetYNLngqc8NcFZVgWi8zES4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603174;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sl6atouphjspkLKYKDaJuCSFRJD+hMxRsC7Oku5xdnI=;
	b=1thJFQm8fpoIEgWvnsTgSH5enXhLHugakuZPvgJZuh3j2oGKKJLeLZ5NuM2h1ZTzTsi0
	 2LX32qYM7wT8HzxNx0FXn8uDdbR51PV00LS21dwOuLB0HvRC3YY1hBe/BXaFBXj7tt0hi
	 jjubhjM7e0k8zVoZk+irdRz5+Vivf612/YjxRrYhUjs6lN4/i1oeNe7NERalv//eoAlIx
	 WGS4a27V1tZl5KndMsRknHHGSqgtFGzEcdlRS70/Gf/pzOQRL/BWDKDlJjfDIh4eGu87D
	 PBx1oe93QOANOJMQxR1b5YSpTF8376rCAVoobg9i7QEzVDtECOV/KL31f1vrzkRXW+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=H6LzZarT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DAD606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=H6LzZarT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EEE21F000C4;
	Wed, 25 Nov 2026 10:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603174;
	bh=sl6atouphjspkLKYKDaJuCSFRJD+hMxRsC7Oku5xdnI=;
	h=Subject:To:Cc:From:Date;
	b=H6LzZarTsaaq0fCWtBcnnmt9CINPEjwJlT2d8UQZKEQzn0tyIddy81UNIo5ujN65A
	 3u+fmx6Jw4J/vC/UUOMjTTN9T7BQSHc4K/Ms6lWnzsP+CsMZWMbVuFEJ3/miZGsF8c
	 cgjbM2INC0+9DRl7CJCMdMQcXKnIOZHFP9Ixo+UA=
Subject: FAILED: patch "[PATCH] tracing/probes: Enable newly appended probe when target event" failed to apply to 6.1-stable tree
To: mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:29:11 +0100
Message-ID: <2026112511-upchuck-striking-2706@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 72d3a5cb0cd7335553549aaffecc683e3ecc0c43
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112511-upchuck-striking-2706@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 72d3a5cb0cd7335553549aaffecc683e3ecc0c43 Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Fri, 13 Nov 2026 17:28:18 +0900
Subject: [PATCH] tracing/probes: Enable newly appended probe when target event
 is enabled

Unlike kprobe events, fprobe and uprobe events only register their
underlying probes when the trace event is enabled. When a new probe is
appended to an existing multiprobe fprobe or uprobe event that is
already enabled, the appended probe is linked into the event's probe
list without being registered.

As a result, the newly appended probe never fires until the event is
disabled and re-enabled. Moreover, disabling an fprobe event calls
unregister_fprobe() on the unregistered fprobe, and opening or closing a
perf event on an enabled uprobe event dereferences a NULL tu->uprobe in
uprobe_apply().

Register and enable the newly appended fprobe or uprobe immediately when
the target event is already enabled.

Link: https://lore.kernel.org/all/179455849798.403392.135678786198324285.stgit@devnote2/

Fixes: 41af3cf587f4 ("tracing/uprobe: Add multi-probe per uprobe event support")
Fixes: 2db832ec9090 ("tracing: fprobe-events: Register fprobe-events only when it is enabled")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 77f2228d44ba..9ab0871a6461 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -933,7 +933,10 @@ static int append_trace_fprobe_event(struct trace_fprobe *tf, struct trace_fprob
 	if (ret)
 		return ret;
 
-	ret = trace_fprobe_verify_target(tf);
+	if (trace_probe_is_enabled(&tf->tp))
+		ret = __register_trace_fprobe(tf);
+	else
+		ret = trace_fprobe_verify_target(tf);
 	if (ret)
 		trace_probe_unlink(&tf->tp);
 	else
@@ -1520,13 +1523,8 @@ static int disable_trace_fprobe(struct trace_event_call *call,
 		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
 
 	if (!trace_probe_is_enabled(tp)) {
-		list_for_each_entry(tf, trace_probe_probe_list(tp), tp.list) {
-			unregister_fprobe(&tf->fp);
-			if (tf->tuser) {
-				tracepoint_user_put(tf->tuser);
-				tf->tuser = NULL;
-			}
-		}
+		list_for_each_entry(tf, trace_probe_probe_list(tp), tp.list)
+			__unregister_trace_fprobe(tf);
 	}
 
  out:
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 146da04b93a8..14ac52aebe34 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -447,6 +447,28 @@ static bool trace_uprobe_has_same_uprobe(struct trace_uprobe *orig,
 	return false;
 }
 
+typedef bool (*filter_func_t)(struct uprobe_consumer *self, struct mm_struct *mm);
+
+#ifdef CONFIG_PERF_EVENTS
+static bool uprobe_perf_filter(struct uprobe_consumer *uc, struct mm_struct *mm);
+#else
+#define uprobe_perf_filter NULL
+#endif
+
+static int trace_uprobe_enable(struct trace_uprobe *tu, filter_func_t filter)
+{
+	struct inode *inode = d_real_inode(tu->path.dentry);
+	struct uprobe *uprobe;
+
+	tu->consumer.filter = filter;
+	uprobe = uprobe_register(inode, tu->offset, tu->ref_ctr_offset, &tu->consumer);
+	if (IS_ERR(uprobe))
+		return PTR_ERR(uprobe);
+
+	tu->uprobe = uprobe;
+	return 0;
+}
+
 static int append_trace_uprobe(struct trace_uprobe *tu, struct trace_uprobe *to)
 {
 	int ret;
@@ -466,10 +488,22 @@ static int append_trace_uprobe(struct trace_uprobe *tu, struct trace_uprobe *to)
 
 	/* Append to existing event */
 	ret = trace_probe_append(&tu->tp, &to->tp);
-	if (!ret)
-		dyn_event_add(&tu->devent, trace_probe_event_call(&tu->tp));
+	if (ret)
+		return ret;
 
-	return ret;
+	if (trace_probe_is_enabled(&tu->tp)) {
+		ret = trace_uprobe_enable(tu,
+			trace_probe_test_flag(&tu->tp, TP_FLAG_PROFILE) ?
+			uprobe_perf_filter : NULL);
+		if (ret) {
+			trace_probe_unlink(&tu->tp);
+			return ret;
+		}
+	}
+
+	dyn_event_add(&tu->devent, trace_probe_event_call(&tu->tp));
+
+	return 0;
 }
 
 /*
@@ -1105,22 +1139,6 @@ print_uprobe_event(struct trace_iterator *iter, int flags, struct trace_event *e
 	return trace_handle_return(s);
 }
 
-typedef bool (*filter_func_t)(struct uprobe_consumer *self, struct mm_struct *mm);
-
-static int trace_uprobe_enable(struct trace_uprobe *tu, filter_func_t filter)
-{
-	struct inode *inode = d_real_inode(tu->path.dentry);
-	struct uprobe *uprobe;
-
-	tu->consumer.filter = filter;
-	uprobe = uprobe_register(inode, tu->offset, tu->ref_ctr_offset, &tu->consumer);
-	if (IS_ERR(uprobe))
-		return PTR_ERR(uprobe);
-
-	tu->uprobe = uprobe;
-	return 0;
-}
-
 static void __probe_event_disable(struct trace_probe *tp)
 {
 	struct trace_uprobe *tu;

