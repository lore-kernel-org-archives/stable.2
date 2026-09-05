Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503433515D0;
	Sun,  6 Sep 2026 01:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788659059; cv=none; b=dqITl2USeFcfG3cPGXE4Hc5x+IgmK7rkLm4aPrOZ7ZKoFD2BEywrEKICh5MdNs1mhj9ou2uCAEp8O9OLvXms9UJj81ynGT3D+Qmd+yaFhtDS37AT4NMskKGrQ67qNsBPwqxAzOXJbCGqJKDTH1DY2KxlXg/nxWnWjXsxxca4VD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788659059; c=relaxed/simple;
	bh=Qhe8iKJL1KONTtWn+bZJUW9hzqDn7ddhvHht6YcFZAQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=GXHPEJzuuENr6s1wLsvt/plMo08VtLMz3ZU2vTVCXcASBQMWGnEfCrhuB53pbdD/X1URaThbtakUrk08ESkd1MUTYEn/kiaZwiBP/3YS8fAceJaalWOu4sDLBUnI69BqX17XTuHItanYSQ9K4iwbc0Zz+SUEWfckTCHc46EL23g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5j8UW2G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5j8UW2G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D691F00A3E;
	Sun,  6 Sep 2026 01:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788659056;
	bh=VE72MNcUzceeZKE8KO67OwSgR318FFvhmYWi2dpqdhY=;
	h=Date:From:To:Cc:Subject:References;
	b=h5j8UW2GGKcWc1hhwPqWz327UcUt8iaZtJKwIkxFtQEfIqveyyfufsS30f58GKYHg
	 kLhyvtAav6MX3ir1HNUQtKCHDpQ63d1uNNMGtRNadNw4TurR8VzVOUteYoz/+1+pGA
	 bq9MzzJ8K/Qen7OARfsRXrCikN4ZkU7RDSnjN77lp25n+LYG3Decb8tbyypy+xrpaj
	 J4VnFqF4DX46X3kPtkFbjjQQtHifGyzN58J+qwl3pDpuNJDhE47w7dVzmmJ5Hhv0g6
	 rxRw17ahZ8NLI22n65+z4pvOp7CjZjq4ZIs4VEw0GfwPTWyEfwlePBgSJCHbQvCbX2
	 Toy2PREtME8oA==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x2whP-00000006JAB-2F06;
	Sat, 05 Sep 2026 16:09:15 -0400
Message-ID: <20260905200915.374076181@kernel.org>
User-Agent: quilt/0.69
Date: Sat, 05 Sep 2026 16:08:31 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 stable@vger.kernel.org,
 sashiko-bot@kernel.org
Subject: [for-linus][PATCH 04/12] tracing: Take trace_array reference when opening options file
References: <20260905200827.773347757@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The options files do not take the trace_array reference for the options
they represent. This could cause a use-after-free kernel crash if one of
these files is opened by one task and another task removes the instance
that the option is for. Because it doesn't take a reference upon opening,
it will not stop the removal which will free the options descriptor that
is being used.

As the options are somewhat dynamic in their creation at boot up, each
file represents a flag in the trace_array. The trace_array has an array of
indexes to represent each of these flags that is stored in the
trace_flags_index array. The address of the index array element is used to
pass to the inode->i_private pointer. Then that element is read which
holds the index (which represents the flag) and then the index is used to
calculate the trace_array descriptor from its trace_flags_index array.

One issue is that the index element can not be referenced until the
trace_array's reference is taken. To handle this, create a new helper
function called: trace_array_options_get() that will iterate all the
existing trace_arrays in the ftrace_trace_arrays list (under the
trace_types_lock), and compare the passed in address of the index element
with the entire array of the trace_array's trace_flags_index array.
If it matches, then up the corresponding trace_array's reference and
return.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260902121918.5a9e9d1b@gandalf.local.home
Fixes: 577b785f55168 ("tracing: add tracer dependent options to options directory")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/linux-trace-kernel/20260828135858.2AC501F000E9@smtp.kernel.org/
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 67 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a946e0183fd1..722d0ba2d233 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7842,11 +7842,70 @@ trace_options_core_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	return cnt;
 }
 
+/*
+ * The tr_index is the address of a trace_array->trace_flags_index[]
+ * element that holds the index of the trace flag. But since the
+ * trace_array reference has not been taken yet, it cannot be referenced
+ * as it could have been freed by a rmdir of the instance the trace_array
+ * represents.
+ *
+ * Search the list of trace_arrays and compare the tr_index to the
+ * address of the entire trace_array trace_flags_index array for each
+ * trace_array in the list. If one is matched, then take the reference
+ * and return it. If not, the trace_array no longer exits.
+ */
+static int trace_array_options_get(void *tr_index)
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
+		if (tr_index >= (void *)&tr->trace_flags_index[0] &&
+		    tr_index < (void *)&tr->trace_flags_index[TRACE_FLAGS_MAX_SIZE])
+			return __trace_array_get(tr);
+	}
+	return -ENODEV;
+}
+
+static int trace_options_open(struct inode *inode, struct file *filp)
+{
+	void *tr_index = inode->i_private;
+
+	if (trace_array_options_get(tr_index) < 0)
+		return -ENODEV;
+
+	filp->private_data = tr_index;
+
+	return 0;
+}
+
+static int trace_options_release(struct inode *inode, struct file *filp)
+{
+	void *tr_index = filp->private_data;
+	struct trace_array *tr;
+	unsigned int index;
+
+	get_tr_index(tr_index, &tr, &index);
+
+	trace_array_put(tr);
+
+	return 0;
+}
+
 static const struct file_operations trace_options_core_fops = {
-	.open = tracing_open_generic,
-	.read = trace_options_core_read,
-	.write = trace_options_core_write,
-	.llseek = generic_file_llseek,
+	.open		= trace_options_open,
+	.read		= trace_options_core_read,
+	.write		= trace_options_core_write,
+	.llseek		= generic_file_llseek,
+	.release	= trace_options_release,
 };
 
 struct dentry *trace_create_file(const char *name,
-- 
2.53.0


