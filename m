Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5805848097B
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040679; cv=none; b=tAyxjvMa+6Q6yRkUYSDEgwjqpp25v1C4ChZNAJsSw2IDxTzx3oDhDqM1gMC/NMK+NZVyXNQn0zcWqZH3gcGBkmhoYkS7LZzMX78vUOFk5O39ntee42gccjlQhjRAabYd3cUquQtz91gCvICr0+9xkH3QjVmYwQH8/UMACNybp1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040679; c=relaxed/simple;
	bh=rQ0Z5MRIFluxXUXmB8TOWt9fh7EJix+lH5MdtPSpGbY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fsPIx/rc93RzF7kZ+imjrNQj9+Tt14rWUUpT3hGxiWzs4Om90vCAG/zFNscc5pST2/ZKHr+/VkTuEj4WhDNrJUhwr6IMm/+XetYIzORo2aS3SOLqAuTnp18W+MYvQk7ABSSlYPtUudAFgR/vD8Wxbvq6xfjAUu6MXB8D+f/GoVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ze0o3udb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ze0o3udb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C498F1F00A3A;
	Tue, 14 Jul 2026 14:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784040670;
	bh=R1RxxZq96a6aRQjCPoatO85BHG66o760j5B1czBYjQ0=;
	h=Subject:To:Cc:From:Date;
	b=Ze0o3udbEz5WQ/L8qRqnRsv9mwu+czfu93echix7Rn35MQl9KpLRZfqD3th+KXcQN
	 LM+jb0wK+hzZOpOLJxRs0vfl/AOqnmu8Ijq8MFSkaLTCth0AjaJIGqDBpkpp78hSq3
	 Nxefz1/dSWLMDOeJ/rFP7zBzu+m8tg/SuQFM0/kk=
Subject: FAILED: patch "[PATCH] proc: protect ptrace_may_access() with exec_update_lock (part" failed to apply to 6.6-stable tree
To: jannh@google.com,brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:50:45 +0200
Message-ID: <2026071445-halved-nullify-54b3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 6650527444dadc63d84aa939d14ecba4fadb2f69
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071445-halved-nullify-54b3@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6650527444dadc63d84aa939d14ecba4fadb2f69 Mon Sep 17 00:00:00 2001
From: Jann Horn <jannh@google.com>
Date: Mon, 18 May 2026 18:35:15 +0200
Subject: [PATCH] proc: protect ptrace_may_access() with exec_update_lock (part
 1)

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

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 90fb0c6b5f99..479ea8cb4ef4 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -482,6 +482,11 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
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
@@ -657,6 +662,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 		seq_puts(m, " 0");
 
 	seq_putc(m, '\n');
+	up_read(&task->signal->exec_update_lock);
 	if (mm)
 		mmput(mm);
 	return 0;
diff --git a/fs/proc/base.c b/fs/proc/base.c
index d9acfa89c894..cc99d953a0a3 100644
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
@@ -2360,17 +2366,15 @@ static struct dentry *proc_map_files_lookup(struct inode *dir,
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
@@ -2420,24 +2424,23 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
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
-		goto out_put_task;
-
-	ret = mmap_read_lock_killable(mm);
-	if (ret) {
-		mmput(mm);
+	mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
+	if (IS_ERR(mm)) {
+		ret = PTR_ERR(mm);
+		/* if the task has no mm, the directory should just be empty */
+		if (ret == -ESRCH)
+			ret = 0;
 		goto out_put_task;
 	}
 
+	ret = mmap_read_lock_killable(mm);
+	if (ret)
+		goto out_put_mm;
+
 	nr_files = 0;
 
 	/*
@@ -2462,8 +2465,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 		if (!p) {
 			ret = -ENOMEM;
 			mmap_read_unlock(mm);
-			mmput(mm);
-			goto out_put_task;
+			goto out_put_mm;
 		}
 
 		p->start = vma->vm_start;
@@ -2471,7 +2473,6 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 		p->mode = vma->vm_file->f_mode;
 	}
 	mmap_read_unlock(mm);
-	mmput(mm);
 
 	for (i = 0; i < nr_files; i++) {
 		char buf[4 * sizeof(long) + 2];	/* max: %lx-%lx\0 */
@@ -2488,6 +2489,8 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 		ctx->pos++;
 	}
 
+out_put_mm:
+	mmput(mm);
 out_put_task:
 	put_task_struct(task);
 out:
diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index 39f4169f669f..2f46f1396744 100644
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
 			res = readlink_copy(buffer, buflen, name, strlen(name));
 	}
+	up_read(&task->signal->exec_update_lock);
+out_put_task:
 	put_task_struct(task);
 	return res;
 }

