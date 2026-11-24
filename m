Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795532355;
	b=5j8wQsHpKqMcOu60K5s8aQBt0lRrXvURLT1FEdqku2xyGFznmOEMJxbZEjQUNNquaQXT
	 UST9Zpss4igON0k1jr3wwcO/uwLIdZmIWt5uErqIawX4tVWfY7sJU9/lWLfrYvj3tIln3
	 +lRCFMnqTeyKTHRfuzxL3h8lK0gmH3mSRZXvVm4MLLnYyH46ZM9AH+7lkB5+jt7B3BD39
	 ItgiNplOIs/6KLTgBv6caUgTEFZWAcaBu4CkiFHkzOE9A+4+56+BUCP7ASEp2SqsXU7Ft
	 Fe9IWwKXJMK2I5AOTZsOTp5av6UUUGttd/I/TaElJEC5834vwR9XHtSZMgwsZGm/ibw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795532355;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VFchZvlympmTz/noYpvrfzJ9j/gfqfwJm/2HvOovNSY=;
	b=gVUUWK7cCL09G5yWTWLhdoM6l6aAPyQF2KCHkdV3eOnoP05patHaiot6qsJwoC0EDKRD
	 HyPRVOMnFHyNE79fhuZmJLDXH3/CN413tr0d8v0KCEIQrZtKibcIosToKX3nSgEDkFTms
	 ce4FkgGH7zWrUjLbPYO2N+kzUwxuR1CsOqwTiX/LmE6MH/ZOFuemOiCz4dUQSmOskOW8P
	 a887bnREB8UbdOosfdYzFCvoZ7J4D3Nw/xSWPop6FpueeGbSk4vg5j0FgoOI220WPmzyC
	 Qha9gFN3nBrdWRKO0SREcgOStySjxakiwZtw8ek4oQgG0k5IdHi8bCXHNv92bbuCsYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XcOFJGSL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D21606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=XcOFJGSL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8961F000C0;
	Tue, 24 Nov 2026 14:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795532354;
	bh=VFchZvlympmTz/noYpvrfzJ9j/gfqfwJm/2HvOovNSY=;
	h=Subject:To:Cc:From:Date;
	b=XcOFJGSLEfyUZovCTORkfP2dpj8GhRfh2lzQ5wMXfYll5g4H4OC31QBzUxGzso184
	 OS80L2cWN2lNlXxjIfWygOmdW9kKI7IfJlaNPa852IgaHx9fQx7ihwItgp08ruycE2
	 H5wzPWYIL1jwqYaXh5m0ZTSBgZxPbpujtwvZQjOc=
Subject: FAILED: patch "[PATCH] tracing/eprobe: Install the trigger for every instance that" failed to apply to 5.15-stable tree
To: devnexen@gmail.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 15:59:27 +0100
Message-ID: <2026112427-vastly-starter-c2ec@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x be94710b1f6ba1bea33e73129c110af80e999b2d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112427-vastly-starter-c2ec@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From be94710b1f6ba1bea33e73129c110af80e999b2d Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Sat, 7 Nov 2026 10:12:32 +0000
Subject: [PATCH] tracing/eprobe: Install the trigger for every instance that
 enables the eprobe

The eprobe trigger lives in the instance of the enabling file, but it is
only added when the eprobe is first enabled and only removed when the
last file goes away. A second instance then records nothing, and the
first instance's trigger is left behind once the eprobe is disabled
there, so the eprobe can be deleted while that trigger still uses it.

Add and remove the trigger for each file. The file is never NULL here,
so warn if it is and drop the dead perf paths.

Link: https://lore.kernel.org/all/20261107101233.151434-1-devnexen@gmail.com/

Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 998e6390937a..474be2f5ccd9 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -644,37 +644,32 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 {
 	struct trace_probe *tp;
 	struct trace_eprobe *ep;
-	bool enabled;
 	int ret = 0;
 	int cnt = 0;
 
+	if (WARN_ON_ONCE(!file))
+		return -EINVAL;
+
 	tp = trace_probe_primary_from_call(call);
 	if (WARN_ON_ONCE(!tp))
 		return -ENODEV;
-	enabled = trace_probe_is_enabled(tp);
 
 	/* This also changes "enabled" state */
-	if (file) {
-		ret = trace_probe_add_file(tp, file);
-		if (ret)
-			return ret;
-	} else
-		trace_probe_set_flag(tp, TP_FLAG_PROFILE);
-
-	if (enabled)
-		return 0;
+	ret = trace_probe_add_file(tp, file);
+	if (ret)
+		return ret;
 
+	/* The trigger lives in the instance of the file, add it for each file */
 	for_each_trace_eprobe_tp(ep, tp) {
 		ret = enable_eprobe(ep, file);
 		if (ret)
 			break;
-		enabled = true;
 		cnt++;
 	}
 
 	if (ret) {
 		/* Failed to enable one of them. Roll back all */
-		if (enabled) {
+		if (cnt) {
 			/*
 			 * It's a bug if one failed for something other than memory
 			 * not being available but another eprobe succeeded.
@@ -687,10 +682,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 					break;
 			}
 		}
-		if (file)
-			trace_probe_remove_file(tp, file);
-		else
-			trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
+		trace_probe_remove_file(tp, file);
 	}
 
 	return ret;
@@ -702,33 +694,21 @@ static int disable_trace_eprobe(struct trace_event_call *call,
 	struct trace_probe *tp;
 	struct trace_eprobe *ep;
 
+	if (WARN_ON_ONCE(!file))
+		return -EINVAL;
+
 	tp = trace_probe_primary_from_call(call);
 	if (WARN_ON_ONCE(!tp))
 		return -ENODEV;
 
-	if (file) {
-		if (!trace_probe_get_file_link(tp, file))
-			return -ENOENT;
-		if (!trace_probe_has_single_file(tp))
-			goto out;
-		trace_probe_clear_flag(tp, TP_FLAG_TRACE);
-	} else
-		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
+	if (!trace_probe_get_file_link(tp, file))
+		return -ENOENT;
 
-	if (!trace_probe_is_enabled(tp)) {
-		for_each_trace_eprobe_tp(ep, tp)
-			disable_eprobe(ep, file->tr);
-	}
+	for_each_trace_eprobe_tp(ep, tp)
+		disable_eprobe(ep, file->tr);
 
- out:
-	if (file)
-		/*
-		 * Synchronization is done in below function. For perf event,
-		 * file == NULL and perf_trace_event_unreg() calls
-		 * tracepoint_synchronize_unregister() to ensure synchronize
-		 * event. We don't need to care about it.
-		 */
-		trace_probe_remove_file(tp, file);
+	/* Synchronization is done in below function. */
+	trace_probe_remove_file(tp, file);
 
 	return 0;
 }

