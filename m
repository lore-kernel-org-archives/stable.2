Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5261833B6DA;
	Sun,  6 Sep 2026 01:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788659151; cv=none; b=MLB97btc5KQwaHGuJFIyBz2RH82ilrwFYlKRAY3u1KtEPyeIcwSH9F2U6Vu8BSNs2BU9sF5MGGfYfQH0VzAgqfKhHnvU7N0nsBbi/X7B0Kug4QRRnia1+OVPpGSSW7QAngEZ2OwJu4TJal7lOymB8R63LDwpxMu4jpA4HDuCqrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788659151; c=relaxed/simple;
	bh=Qhe8iKJL1KONTtWn+bZJUW9hzqDn7ddhvHht6YcFZAQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=fWxPp0vF97HidktO/B8Ri1dnrfwACC4NNyPTmJiEGp1k28001iEbAMc39NHW+drgky7/RsI/FbjaQpzxc+etlgOxE33hExVCQ/8XPfaNclXiaBOIr1OVKW4axL2oQYrohnchC1u426CjxjownNNHuqrHO+O7P8WZTxMsxCp/KAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8OfkdAu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8OfkdAu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE95C1F00AC4;
	Sun,  6 Sep 2026 01:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788659147;
	bh=VE72MNcUzceeZKE8KO67OwSgR318FFvhmYWi2dpqdhY=;
	h=Date:From:To:Cc:Subject:References;
	b=K8OfkdAu+fqwXPGbMkaApPLQU9Cc1a5cWRQESrw6W6GceJgrYgKV+nL2GHyZJcawL
	 VReKoPVUeVcThhI4swVYqn6SGi9C1+hIUUag3O/bHv5kzJ+W+hsV81ZC4iZ8DiGmiD
	 m/s+4xuK6LLAHjVjib8KCGHByOxG+aMcPhNODyxWU0Oa6Ddf9SyGvSglp4dXMwiHLE
	 TGRZuHBq8DzdieKRjwEEvQPr71ZGuS7bjL6t5gA6yc82Nqkbr4V9r025ijEZEd/vU/
	 +LxViO3FZt42oPAHXIEtKzPWkixnbDzOGmAmKk67imsXFcBY5bzf9EXIgXI/+Aqzpl
	 tQFU3CPnOt9Vw==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x31yB-00000006PP9-3eja;
	Sat, 05 Sep 2026 21:46:55 -0400
Message-ID: <20260906014655.737656886@kernel.org>
User-Agent: quilt/0.69
Date: Sat, 05 Sep 2026 21:45:35 -0400
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
References: <20260906014531.720267751@kernel.org>
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


