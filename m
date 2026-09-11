Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F3B4AA03B;
	Fri, 11 Sep 2026 18:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150588; cv=none; b=VUAs1DMEXYbCgEynD2Nq3NeyQMV36gHIm3zGiflehnI/MnvIwoaBlm5HPXRukDsyrWi/nPjQWkxgl93p+bltMTPx3kz7EaQFQRnoGhbpCNJzN3MH4O4uG786s3mfBYyYfr7ReAqCQ4EHpON1CKrIAXfxr07XZkP0XbFH+a25YZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150588; c=relaxed/simple;
	bh=anlAKepp4fSdNG7SD2sOTuQwCceYwsBCXVYke80uHEM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=BqU+PpUaRFgZqmPK0nNaWA3IrELmww0tLh4stFZ4KMNz+Sa2ZLBnbmCIcV0sNWcYdRgUQ+8pkYd1K7gTjsONWoo6ts3BFsnC1Ut0C2/hQWBHZe9+ja392aVGiD1OOmWyF1UtGoMqiHp3ppsMPMWo6XrdUleirqLDHuAgUA594Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiSt0zlN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiSt0zlN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C151F008BD;
	Fri, 11 Sep 2026 18:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789150570;
	bh=Hx32kxBwKawH5WJ5tu/bUMoedLuSmLDuz6rlCV8xvSU=;
	h=Date:From:To:Cc:Subject:References;
	b=SiSt0zlNAIZ9hbj8i+vYvV9qX00CcDE20nLVxX9nLSgnwM2jJZBWfdjmKhmKEclcp
	 CC27C5TkMauKCrWufGcEXYNnQHfTLBCgi0+W4MrcUiBLID+cxTSKzR/Do1Ps8S87X/
	 zjBn2JQ20VRS/OLGE4hgnCq2L14TFFXyQ0uAh0Ze6kw2iLKMVF+npBiXcFAcQuWiVK
	 2VM6hlS14E7RW6GJOTPSv2Uol5kgWOEDTJZL02D4snL33nZdrLakYEPofHc85d6xIF
	 peegb+fWS5pCoYf1VTY9Iw5rrpofIOy9ktJ9Ql1/C4nICQKGK4o5QHcIVwpjbed9VY
	 kgMXzJFxb7Xwg==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x55oa-00000009558-0rl4;
	Fri, 11 Sep 2026 14:17:32 -0400
Message-ID: <20260911181732.007790558@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 11 Sep 2026 14:16:55 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 sashiko-bot@kernel.org
Subject: [for-linus][PATCH 19/20] tracing: Take trace_array reference when opening a tracer options
 file
References: <20260911181636.485043797@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When a tracer option file is opened, it is passed a descriptor that points
to an element on the trace_array's topts array. This element has
information to find the trace array and other information. It uses this
element to take a reference of the trace_array so that the trace_array
does not get removed while this file is opened.

Unfortunately, there's a race condition where the element itself could be
freed by the removal of the instance the trace_array represents causing a
use-after-free as this element that is used to find the trace_array to
increment its reference counter is also freed when the instance is
removed.

To solve this, add a trace_array_tracer_options_get() helper function that
will take the address of the element that is passed to the open function
by the inode->i_private pointer and search all the trace_arrays under a
lock to find the one that the element's address is in the range of the
trace_arrays topts array elements. When a match happens, that trace_array's
reference would be increased.

Note, there's a race where if an admin was deleting and creating trace
instances at the same time and the memory of the old trace_array's array
matched the memory of the new trace_array that it could in theory open the
option from the wrong trace array. But we do not care because it would be
stupid to perform that kind of action. As long as the only thing that can
happen is that the option from the wrong trace array is used and doesn't
crash the kernel it will only make the user confused. But if they are
doing something stupid like this, they are already confused, so no harm
done.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260910221209.62dad8d3@robin
Fixes: 7e2cfbd2d3c86 ("tracing: Have option files inc the trace array ref count")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/linux-trace-kernel/20260902121918.5a9e9d1b@gandalf.local.home/
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 46 +++++++++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace.h |  1 +
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8658cad53cb5..e4a490d3d08c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7717,12 +7717,55 @@ trace_options_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	return cnt;
 }
 
+static bool tr_option_match(struct trace_array *tr, void *topt)
+{
+	for (int i = 0; i < tr->nr_topts; i++) {
+		struct trace_options *tr_topts = &tr->topts[i];
+
+		if (topt >= (void *)&tr_topts->topts[0] &&
+		    topt < (void *)&tr_topts->topts[tr_topts->nr_topts])
+			return true;
+	}
+	return false;
+}
+
+/*
+ * The topt is the address of a trace_array->topts[] element that holds the
+ * the tracer options descriptor. But since the trace_array reference has not
+ * been taken yet, it cannot be dereferenced as it could have been freed by
+ * a rmdir of the instance the trace_array represents.
+ *
+ * Search the list of trace_arrays and compare the topt to the address of
+ * the entire trace_array topts array for each trace_array in the list.
+ * If one is matched, then take the reference and return it. If not, the
+ * trace_array no longer exits.
+ */
+static int trace_array_tracer_options_get(void *topt)
+{
+	struct trace_array *tr;
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
+	if (tracing_disabled)
+		return -ENODEV;
+
+	guard(mutex)(&trace_types_lock);
+	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		if (tr_option_match(tr, topt))
+			return __trace_array_get(tr);
+	}
+	return -ENODEV;
+}
+
 static int tracing_open_options(struct inode *inode, struct file *filp)
 {
 	struct trace_option_dentry *topt = inode->i_private;
 	int ret;
 
-	ret = tracing_check_open_get_tr(topt->tr);
+	ret = trace_array_tracer_options_get(topt);
 	if (ret)
 		return ret;
 
@@ -7984,6 +8027,7 @@ create_trace_option_files(struct trace_array *tr, struct tracer *tracer,
 	tr->topts = tr_topts;
 	tr->topts[tr->nr_topts].tracer = tracer;
 	tr->topts[tr->nr_topts].topts = topts;
+	tr->topts[tr->nr_topts].nr_topts = cnt;
 	tr->nr_topts++;
 
 	for (cnt = 0; opts[cnt].name; cnt++) {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 5e76f94e7a80..bd3c8f80300f 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -227,6 +227,7 @@ struct array_buffer {
 struct trace_options {
 	struct tracer			*tracer;
 	struct trace_option_dentry	*topts;
+	int				nr_topts;
 };
 
 struct trace_pid_list *trace_pid_list_alloc(void);
-- 
2.53.0
