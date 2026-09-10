Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A61D559CA4
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 19:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067342; cv=none; b=L4blJkNihDpzrYFIJ504E2bNrTQZmqXfUICnE7eGnkl3mQQPk5kUu0yNA8VcDK28JHZreGLnt4mfk28Nn9XNmnWySrGlG6jiRx4SSiIJYxbAH/X38Nm3VpJfiyL0xkiaEFe4QhadkPe4zOnt6dtpp+FEDe0Bmljk/WA762d5u1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067342; c=relaxed/simple;
	bh=6/kP8SNDb5hzedKyKQdZCa4R09OuTnwUmUAT8FIYQcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r58x/kcaPRxs5SPYFYr2Zy+R1XQnwc0OmSUg5lr756QbEosKtqfjk9re1XZGADAOg4ePBpZlWUoKDBU+Kpi8CbuciEmy1V0bRk4tlGHAnq2aFP0AfAGE0kgv0OlgwZgueVGYhEkp0Ytck581voJk77j9G6HwPAbzuIqVd/A2awQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWGIcZba; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWGIcZba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08A731F000FF;
	Thu, 10 Sep 2026 19:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067340;
	bh=4p/k77il6MM5KQ5m3qi5BmXHpa1ehx3txCx4r/nYG2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TWGIcZba9hnyu2KADegPCH1lCHRiQmss4UmUQCCzy76SlorH3wMwmtbPdvOQMsHVG
	 k5V6D6DAFSroxfSjGD0nXOUCf6iReMCyFqfEBcV1s7dCh7/V13Ew9ShZdFsk4n3Ows
	 m7T1ESZK5FM6K24+1nkoyW9U0JAheJYsrK+HOtpJvlZ/i24N9Z33ipzLgauDHoUdW6
	 2zRurFZ5dsDQscBpT+LeTehshvq1dqUQxFeHP2jTEI++1ffX708nsEGPgUOl/5hKCC
	 oK+2htTcpJT+OgJ5v1lLcunLWFbr9Tcs04on1PrgRcKVZzpTLJBiUZftjLDpBt6Mf3
	 teR8IInH4R75g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	sashiko-bot@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] tracing: Take trace_array reference when opening options file
Date: Thu, 10 Sep 2026 15:08:58 -0400
Message-ID: <20260910190858.1454709-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090834-vacancy-idealness-f15e@gregkh>
References: <2026090834-vacancy-idealness-f15e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit f2951ebd15c36a1ea4820a7f0cbb0b5f1c028b73 ]

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
[ adapted reference acquisition to use tr->ref++ with explicit mutex_lock()/mutex_unlock(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.c | 72 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 68 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ed32d3c4f0e76..533963aadd041 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8502,11 +8502,75 @@ trace_options_core_write(struct file *filp, const char __user *ubuf, size_t cnt,
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
+	ret = -ENODEV;
+	mutex_lock(&trace_types_lock);
+	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		if (tr_index >= (void *)&tr->trace_flags_index[0] &&
+		    tr_index < (void *)&tr->trace_flags_index[TRACE_FLAGS_MAX_SIZE]) {
+			tr->ref++;
+			ret = 0;
+			break;
+		}
+	}
+	mutex_unlock(&trace_types_lock);
+	return ret;
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

