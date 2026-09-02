Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ACF4AEBE4;
	Wed,  2 Sep 2026 21:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788384342; cv=none; b=HYd4ULxs346yr5BPtLUUfTjgU2ETxnEdBI0Fhz9cBANNRbsvr5yQGheyTvuk+gvxOhbyEjd1SeoWkNqUNLy/L6rm1bWFu+48shKKsPlpfoYj3gaFUWGjjrMxvKqwo6rbp1ZSKtpRBumpz5d1ROOQCoieByyqSJxh7RBq33Q9KOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788384342; c=relaxed/simple;
	bh=X56F6/Rw/OC7cVqwl8APBTeGZERd8XZX5CpXU9160IY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=DhHQYpZF9Vusdvwy/y0L6EBsrDblqELJsU5a4rnR5sitRWCsusQoXe1C2DYq76B/j3UnqcPpWULlalmnCHJtP7zcOyqy12FHCmBTGCHArCzMl+Ho94rRUzo5lqXBQaReC+PGXE/1hpY5H2Bs6wqhZHzE9SmAbUUNARDohwf85P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L02hJBDg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L02hJBDg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648D11F00A3F;
	Wed,  2 Sep 2026 21:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788384336;
	bh=YPWAPuL82q8pso9D+jtuK/10ik3eUpR2CT7apuaRUKQ=;
	h=Date:From:To:Cc:Subject:References;
	b=L02hJBDgU2rj7eqaXG2Y8OIsUC+b9Kne9Ei7FwqHkL2koruHcCuml15QyETIy1NhE
	 rVyXcgmpNKAnqXjUCgQ2OdXsioccEaUmtgI85h5NgY1YJolUS4kbZSBI9UYNiX/s2I
	 klX0jplyQ7RhCweZmG2di7akcHkvlJTQ35iy8PzdrQF35YaoD3ffF+4iDSbc+8EfJC
	 9reWNu1pxAbe+Eic+vvjuBmHJoC8+7aJguemkt2F052pFnBBcFDJYtgJIrN0WTE4Q0
	 0ekep5JObiCcKOBwd5a4SRhwrIJTcxTrZj7avGShNyeRheUphAaC4aF2EiZi9IRxH+
	 xQjIzNSRCRoEQ==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x1sTe-0000000ECeu-0swp;
	Wed, 02 Sep 2026 17:26:38 -0400
Message-ID: <20260902212638.065669192@kernel.org>
User-Agent: quilt/0.69
Date: Wed, 02 Sep 2026 17:26:11 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 sashiko-bot@kernel.org
Subject: [PATCH 2/2] tracing: Take trace_array reference when opening a tracer options
 file
References: <20260902212609.542937225@kernel.org>
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
trace_arrays topts array. When a match happens, that trace_array's
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
Fixes: 7e2cfbd2d3c86 ("tracing: Have option files inc the trace array ref count")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/linux-trace-kernel/20260902121918.5a9e9d1b@gandalf.local.home/
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f26244253a8b..03080fcf7f04 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7728,12 +7728,44 @@ trace_options_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	return cnt;
 }
 
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
+		if (topt >= (void *)&tr->topts[0] &&
+		    topt < (void *)&tr->topts[tr->nr_topts])
+			return __trace_array_get(tr);
+	}
+	return -ENODEV;
+}
+
 static int tracing_open_options(struct inode *inode, struct file *filp)
 {
 	struct trace_options *topt = inode->i_private;
 	int ret;
 
-	ret = tracing_check_open_get_tr(topt->tr);
+	ret = trace_array_tracer_options_get(topt);
 	if (ret)
 		return ret;
 
-- 
2.53.0


