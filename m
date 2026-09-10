Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF2837F8BC
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789047944; cv=none; b=nLKsp+tgUV/wpbu6I5AoPMBaug+SwsflcvfmMqhgQUG4tn3ECZpN1NZFpFlwwveNklg+C0oBa3ERPzU/aSOYu96CR1XIAwMtOeF25tm3Jkhynkf4W+qfSU323o0Xqa5x8m5cDI+ToowwEFhPHmgEUfJewnNczMq2kzlyaST60jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789047944; c=relaxed/simple;
	bh=63//UyuDii5we7Jw4WwheE7M5PspDdBaOnsajN6UWc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhNA7Mjzph1Vd0IOhc8bPpNkSRsg3+bJwVnThYoYwTeAy2dh18apcA//0XabIzzsc/APXcvRFmYUfiS60vWULCdLI8rMXGj5Q3J+ByFkBG2/ttJqdvLDugWEgsZMUm3kynlyX+y//J1XMyhpA//pWWzKncqUDSc+fFMFSu6A5W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEqDj9SO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEqDj9SO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15F081F00898;
	Thu, 10 Sep 2026 13:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789047942;
	bh=yc0owOT+44I1cuHCD8jtC/q0oKyI7sPX3hNtV/bI1x8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cEqDj9SOWB//IbFULGYk9098PEc+pZDFZrclkrbontwAGDbil8yUTlM7z9wPHYhdn
	 K7LDTQFKy161m+v7eUEgEUbJXybCo4uFtEvyvposCNKkA8osVM6+Zl6CieMVl9jr7Z
	 io3ZzkyPrUSWghHjYOnc8oX6x/Hmmz1UWijyN4z8eh2ATPoGpiHv1PEIfzG784rCGn
	 GmHTMkJ3gOLAzlKxbD5vqzRKDBMOzpLIYoUCLmXUAPkG1KCcxnE2UlenvBaQjGAf5D
	 c5/WvNoer2GBWIlHYDltVzf3MRm216CZqNTnhOYa8cxcD9L87Bq9POLwVDMQtyB+DK
	 SD150iTpBZoiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	sashiko-bot@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] tracing: Take trace_array reference when opening options file
Date: Thu, 10 Sep 2026 09:45:39 -0400
Message-ID: <20260910134539.386642-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910134539.386642-1-sashal@kernel.org>
References: <2026090833-darn-control-392b@gregkh>
 <20260910134539.386642-1-sashal@kernel.org>
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
[ replaced unavailable __trace_array_get(tr) with tr->ref++ and return 0. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.c | 69 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 65 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8b536db426ce5..194c954942008 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9023,11 +9023,72 @@ trace_options_core_write(struct file *filp, const char __user *ubuf, size_t cnt,
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

