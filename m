Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCD143BDC3
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789588854; cv=none; b=CxQe7d07+ay4rwTmXFTs7zXOo591YVPq6JDj+F5e4038RSkQhvOpqzBliSmIDRedKPKx6h8TWFs4b88LIrBWMvq+2xPrNkIF4qf/8UH3szBSKzti/VYVKa1IaX7NmHa4JvcvhJygEjQTyqVhARQEZcvESvSqXT6Z93rIFi46vxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789588854; c=relaxed/simple;
	bh=+3vT6d5n1R+EC7OCjKidjlFJ6DLSmr3Nt9th9RpPgdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHcBvk3P6q50xtthWybulItwW9exiy/Ab60ybnHkJ5nd9rucLMGBDMEeOG6xQtsFJrWzAjyphTZGhjAYweCX9aTTFUxCxMrswY6DMmn4QaMDOXpf95ySolUIEhikXM0aQXDZ6lIxE+sYWhHv46w1MLkCAFYFpvjC+cs8xH87Vfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZfQjq7K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZfQjq7K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0466A1F00893;
	Wed, 16 Sep 2026 20:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789588835;
	bh=iTPTXZOlwAxokkjXfmVI4/Xkm77oLjwitAwMYLHzaSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EZfQjq7Kdi7f9zkJwiSQncPYQQ5F9+4GetSfLUQBmks1ykHrsTdi7hsJCVFnT/EaU
	 V2mJ3iGcTsRJaERrNj9ssiKnG0w/v+76YWG/S8WX6H0GDb7jZP/4BIlzVvOtk9wAMg
	 AA99S+sFw4Q54GIFnuWN9OTSs9KBazic66+jn5N/7HmU/GhSTiex+KkKsP3TZzjROe
	 iIoeLePNcR76GrMi/X+MPhuvpFDWL+MRLK3A9vDPs99c/B10stNX67LGqxtY2X8DkC
	 Er1Dv3fclhJidjgE+cD4cKvJBJjD5YW1waxwWvQqVwN/9De5VuUfoc3z7mXtsjAZ08
	 6plQjyAk3Pwag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	sashiko-bot@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] tracing: Take trace_array reference when opening a tracer options file
Date: Wed, 16 Sep 2026 16:00:32 -0400
Message-ID: <20260916200032.2459175-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916200032.2459175-1-sashal@kernel.org>
References: <2026091636-refined-everyone-e63c@gregkh>
 <20260916200032.2459175-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit ed0aff60f83a9bdc2f6556376ac79c96b3ce7e80 ]

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
[ replaced guard(mutex) and __trace_array_get() with explicit locking and tr->ref++, using GNU89-compatible declarations. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.c | 53 +++++++++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace.h |  1 +
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ee72583c64c96..f735688520f7f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8865,12 +8865,62 @@ trace_options_write(struct file *filp, const char __user *ubuf, size_t cnt,
 	return cnt;
 }
 
+static bool tr_option_match(struct trace_array *tr, void *topt)
+{
+	int i;
+
+	for (i = 0; i < tr->nr_topts; i++) {
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
+	ret = -ENODEV;
+	mutex_lock(&trace_types_lock);
+	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
+		if (tr_option_match(tr, topt)) {
+			tr->ref++;
+			ret = 0;
+			break;
+		}
+	}
+	mutex_unlock(&trace_types_lock);
+	return ret;
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
 
@@ -9093,6 +9143,7 @@ create_trace_option_files(struct trace_array *tr, struct tracer *tracer)
 	tr->topts = tr_topts;
 	tr->topts[tr->nr_topts].tracer = tracer;
 	tr->topts[tr->nr_topts].topts = topts;
+	tr->topts[tr->nr_topts].nr_topts = cnt;
 	tr->nr_topts++;
 
 	for (cnt = 0; opts[cnt].name; cnt++) {
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index a632965446b8e..306455f2c034b 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -203,6 +203,7 @@ struct array_buffer {
 struct trace_options {
 	struct tracer			*tracer;
 	struct trace_option_dentry	*topts;
+	int				nr_topts;
 };
 
 struct trace_pid_list *trace_pid_list_alloc(void);
-- 
2.53.0

