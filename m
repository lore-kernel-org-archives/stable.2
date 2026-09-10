Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F8C489FBF
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044805; cv=none; b=S/cdw9uGnWM0p2Jm9j3F3vBp6WcpZNzdV3fyfpaync62tX4g7ScQy4KVbDEqGMNm/xL3FAq/FEWmEXPgO/WTPCO6Y/mz8vs212f8ba6P1D2hYiRLzSpPWdofoDcUzHWXvjAaUQg+lhXN7we/acYFb0DuW3KxLUxonUMiZ+QOnDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044805; c=relaxed/simple;
	bh=F8/Y5D8rP+/z6lyqAdAr42alqJfRKuNTfSh5E6VW1wo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auNrjfMSk6XUhYFIOIrcTNI2aMBaz2Lo47Mvr5GNgfn+a/7se4zj5IdVAv11Uvu7jPY2h05hJWshPHZIxovDAqYBx0HE8TlZhenLfYCB7DGfAWl4KV7QCNpVF+DXVINA3rjA6zuIfvGX2/tVM9HmnPUC+Hj8FAvTh6y+NHToTPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkVrogmE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkVrogmE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33AE41F0089A;
	Thu, 10 Sep 2026 12:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789044803;
	bh=fYxv3KWUBM6G9+MgIO9kG24Yv8BDS6SpSB9/gYHE4TM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dkVrogmEMhjsHyfPBNV2HbvSJaHkpAwVftRS8L3q8uJbFsXTYTyGFY6Vg1/z89gQ6
	 7a1iiUGxXWf9Zhl9fXVnA/avR2+WGoLMiuNFyaEX6nFyYB/KmQqOiJr6WikxkoRDYh
	 aBAJwa/xEdWoW09AJnfq6er0gAHlOK8BzJCRdgpLN07cqpHYSy9Qp2OJywf2TxvUFL
	 PdqtulDvYGZWOtphr5q4oyohBdTSjma44VRZtHXLiOuegOd+vynrBbwGfemJTKBqEZ
	 IOcWuzjtbJCvXUJ0GaGYNp+KYtg2tEWtHweNuot94IPwmwPytgX1rIyk05p2KXbS+e
	 k7Gn51QruolXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	sashiko-bot@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] tracing: Take trace_array reference when opening options file
Date: Thu, 10 Sep 2026 08:53:19 -0400
Message-ID: <20260910125319.187851-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910125319.187851-1-sashal@kernel.org>
References: <2026090831-flashback-racing-7323@gregkh>
 <20260910125319.187851-1-sashal@kernel.org>
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
[ replaced the unavailable __trace_array_get(tr) call with tr->ref++ and return 0. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.c | 69 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 65 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 063e88fbe3856..8c8a2aad3e49b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9393,11 +9393,72 @@ trace_options_core_write(struct file *filp, const char __user *ubuf, size_t cnt,
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
+		    tr_index < (void *)&tr->trace_flags_index[TRACE_FLAGS_MAX_SIZE]) {
+			tr->ref++;
+			return 0;
+		}
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

