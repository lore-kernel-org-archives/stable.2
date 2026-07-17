Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E644641CB38
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784296831; cv=none; b=Nd/KchwSC3r/Yyj6lzoAdJH7vZFgMcxgAOaVjuehfHVTQ2B7mqXUOPp29mtDvyQfwlo5++qt+VBTJphC0CFwFdmit+p3vVV/VcSd3GxL2TTpZLmRDjF3PVz2KSonS95swRVtDOo9PRJoa36xCMneCUPjzaG/27o/6llLW13idTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784296831; c=relaxed/simple;
	bh=NQFbNN1hVe33/ysvHGlze5I+zNcy2Gb/5MDvDtGcDX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S1XhpID+sJKKzjPIJ5MjX0tKUJccoRViq8iSZuH5WcYZ7B1VheLtztDJbqH4uNybXsvlqThbQSlKxyAX5JVl/V64wFybY24CNInIY5wMo7J2uPim0MU+jNkGyxg4ErsbzRoww3W2o9GSSCkTTRCg69nIcY6Msi6hpIuau2BCk7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xxfe4UDf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xxfe4UDf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7CE1F00A3E;
	Fri, 17 Jul 2026 14:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784296829;
	bh=b21rSMITZMS+BRzm2MCAGbXYadTg57rn7SfKlvdz3jg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xxfe4UDfgFlzBM4lHt7nzHR9j+D2joZSDaboz6LeMRsznDMmO4d+GCEb+KcjLf19e
	 kvD3JZjaa3fdxyXk0qlfd66Z0bIrt59CctFErZlwCmBe2PaXEg8MEHEw+DHm7X6+s3
	 KwVK2nmiLAeWyP0OhI4C3MEzb+t9hRHkK5ClCR+uQxnHqJPq5He7bvWCvOy4OwD25t
	 ZIb+SrH6Xy3nY8bfay/0niuzWCcgMh4I6oRuO67L9mRtZY86NmrSD7P8zyjAZDk9AC
	 PamImueVM1Mna8RJc2nnlMSn+XawG5NVViD/20pGIKUFiOqQ+HTglVpvYPYoo/+uRo
	 at/yLVEUb9rCg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] proc: protect ptrace_may_access() with exec_update_lock (part 1)
Date: Fri, 17 Jul 2026 10:00:25 -0400
Message-ID: <20260717140025.1717514-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717140025.1717514-1-sashal@kernel.org>
References: <2026071445-sadden-utmost-ad28@gregkh>
 <20260717140025.1717514-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jann Horn <jannh@google.com>

[ Upstream commit 6650527444dadc63d84aa939d14ecba4fadb2f69 ]

Fix the easy cases where procfs currently calls ptrace_may_access() without
exec_update_lock protection, where the fix is to simply add the extra lock
or use mm_access():

 - do_task_stat(): grab exec_update_lock
 - proc_pid_wchan(): grab exec_update_lock
 - proc_map_files_lookup(): use mm_access() instead of get_task_mm()
 - proc_map_files_readdir(): use mm_access() instead of get_task_mm()
 - proc_ns_get_link(): grab exec_update_lock
 - proc_ns_readlink(): grab exec_update_lock

Fixes: f83ce3e6b02d ("proc: avoid information leaks to non-privileged processes")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
Link: https://patch.msgid.link/20260518-procfs-lockfix-part1-v1-1-5c3d20e0ac33@google.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/array.c      |  6 ++++++
 fs/proc/base.c       | 41 ++++++++++++++++++++++-------------------
 fs/proc/namespaces.c | 12 ++++++++++++
 3 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index d5cf316f3eb429..e5001b5fc3f019 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -483,6 +483,11 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	unsigned long flags;
 	int exit_code = task->exit_code;
 	struct signal_struct *sig = task->signal;
+	int ret;
+
+	ret = down_read_killable(&task->signal->exec_update_lock);
+	if (ret)
+		return ret;
 
 	state = *get_task_state(task);
 	vsize = eip = esp = 0;
@@ -658,6 +663,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 		seq_puts(m, " 0");
 
 	seq_putc(m, '\n');
+	up_read(&task->signal->exec_update_lock);
 	if (mm)
 		mmput(mm);
 	return 0;
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 704cf6a0612ede..130fc49579b732 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -423,18 +423,24 @@ static int proc_pid_wchan(struct seq_file *m, struct pid_namespace *ns,
 {
 	unsigned long wchan;
 	char symname[KSYM_NAME_LEN];
+	int err;
 
+	err = down_read_killable(&task->signal->exec_update_lock);
+	if (err)
+		return err;
 	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
 		goto print0;
 
 	wchan = get_wchan(task);
 	if (wchan && !lookup_symbol_name(wchan, symname)) {
 		seq_puts(m, symname);
+		up_read(&task->signal->exec_update_lock);
 		return 0;
 	}
 
 print0:
 	seq_putc(m, '0');
+	up_read(&task->signal->exec_update_lock);
 	return 0;
 }
 #endif /* CONFIG_KALLSYMS */
@@ -2356,17 +2362,15 @@ static struct dentry *proc_map_files_lookup(struct inode *dir,
 	if (!task)
 		goto out;
 
-	result = ERR_PTR(-EACCES);
-	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
-		goto out_put_task;
-
 	result = ERR_PTR(-ENOENT);
 	if (dname_to_vma_addr(dentry, &vm_start, &vm_end))
 		goto out_put_task;
 
-	mm = get_task_mm(task);
-	if (!mm)
+	mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
+	if (IS_ERR(mm)) {
+		result = ERR_CAST(mm);
 		goto out_put_task;
+	}
 
 	result = ERR_PTR(-EINTR);
 	if (mmap_read_lock_killable(mm))
@@ -2416,23 +2420,22 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 	if (!task)
 		goto out;
 
-	ret = -EACCES;
-	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
-		goto out_put_task;
-
 	ret = 0;
 	if (!dir_emit_dots(file, ctx))
 		goto out_put_task;
 
-	mm = get_task_mm(task);
-	if (!mm)
+	mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
+	if (IS_ERR(mm)) {
+		ret = PTR_ERR(mm);
+		/* if the task has no mm, the directory should just be empty */
+		if (ret == -ESRCH)
+			ret = 0;
 		goto out_put_task;
+	}
 
 	ret = mmap_read_lock_killable(mm);
-	if (ret) {
-		mmput(mm);
-		goto out_put_task;
-	}
+	if (ret)
+		goto out_put_mm;
 
 	nr_files = 0;
 
@@ -2458,8 +2461,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 		if (!p) {
 			ret = -ENOMEM;
 			mmap_read_unlock(mm);
-			mmput(mm);
-			goto out_put_task;
+			goto out_put_mm;
 		}
 
 		p->start = vma->vm_start;
@@ -2467,7 +2469,6 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 		p->mode = vma->vm_file->f_mode;
 	}
 	mmap_read_unlock(mm);
-	mmput(mm);
 
 	for (i = 0; i < nr_files; i++) {
 		char buf[4 * sizeof(long) + 2];	/* max: %lx-%lx\0 */
@@ -2484,6 +2485,8 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 		ctx->pos++;
 	}
 
+out_put_mm:
+	mmput(mm);
 out_put_task:
 	put_task_struct(task);
 out:
diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index 8e159fc78c0a12..3a824f62dfccd6 100644
--- a/fs/proc/namespaces.c
+++ b/fs/proc/namespaces.c
@@ -55,6 +55,10 @@ static const char *proc_ns_get_link(struct dentry *dentry,
 	if (!task)
 		return ERR_PTR(-EACCES);
 
+	error = down_read_killable(&task->signal->exec_update_lock);
+	if (error)
+		goto out_put_task;
+
 	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
 		goto out;
 
@@ -64,6 +68,8 @@ static const char *proc_ns_get_link(struct dentry *dentry,
 
 	error = nd_jump_link(&ns_path);
 out:
+	up_read(&task->signal->exec_update_lock);
+out_put_task:
 	put_task_struct(task);
 	return ERR_PTR(error);
 }
@@ -80,11 +86,17 @@ static int proc_ns_readlink(struct dentry *dentry, char __user *buffer, int bufl
 	if (!task)
 		return res;
 
+	res = down_read_killable(&task->signal->exec_update_lock);
+	if (res)
+		goto out_put_task;
+
 	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)) {
 		res = ns_get_name(name, sizeof(name), task, ns_ops);
 		if (res >= 0)
 			res = readlink_copy(buffer, buflen, name);
 	}
+	up_read(&task->signal->exec_update_lock);
+out_put_task:
 	put_task_struct(task);
 	return res;
 }
-- 
2.53.0

