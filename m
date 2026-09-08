Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35602560AA1
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873248; cv=none; b=hywU2NubkNy5pkpU2X426QPVfsZV5ntmgiXrj8MBSvMQvTHC8b/SPTBA1PLe+bfPKq/62F4G8CS5jV2mAP3RroYWZ5e1Mz+65tvogHGb1HPU37xY7UqLlgzSRkZYFVHhxgOW4+WTJXLdlX8G3w1FC6n/2OwothWQSBkimKoaJwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873248; c=relaxed/simple;
	bh=jumHvqbWr759b+ctm+OYmevpjf14QjqsY977UhHvPLI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=s256DK0YG1x14G0ZFeBD5hfDKnlHDvguW5y3QtfntcsTnj6ekJ3wKIdcMF+8eFHtbpk5nMleTuWLWxzpob4DbqQYRC0IglHk2HgXXSij6RJnDdSJznRB52EzV/ZMAuq4OQucWsu0t7e44DejEPInb+kqEfxhu1bRc86kg4OVPdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s3yJCMwi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s3yJCMwi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221EF1F00A3D;
	Tue,  8 Sep 2026 13:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788873239;
	bh=9nf95ejDv7GXLBb48KFEn/+p6gQL1+jEqjUgQLF9de4=;
	h=Subject:To:Cc:From:Date;
	b=s3yJCMwijOwU1ppJNZqQVVhOKhdykaJdJAE2ct2d8SAvNZElWnw3R6dxfKCpN3ZfF
	 s7wkUWDM964WEf5tRyvSABzf/ACZDU41rtLmpFgVFnoGvALOceNZlpp8jK2Ha5o3JR
	 L7n9qtgq/NZ4lacHJksCrsZP896cUBuzk6AEcNSw=
Subject: FAILED: patch "[PATCH] tracing: Take trace_array reference when opening options file" failed to apply to 6.18-stable tree
To: rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:56:31 +0200
Message-ID: <2026090831-flashback-racing-7323@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x f2951ebd15c36a1ea4820a7f0cbb0b5f1c028b73
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090831-flashback-racing-7323@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f2951ebd15c36a1ea4820a7f0cbb0b5f1c028b73 Mon Sep 17 00:00:00 2001
From: Steven Rostedt <rostedt@goodmis.org>
Date: Wed, 2 Sep 2026 12:19:18 -0400
Subject: [PATCH] tracing: Take trace_array reference when opening options file

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

