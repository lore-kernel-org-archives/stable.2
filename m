Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9674737C0EC
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 18:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784311912; cv=none; b=BBxzptXMHkrG6Z9tFdOj41+bh1vCljBuyva+mzmsxoG/aE5AllEkXyWb1rQIBplImDRguJgqp2F5plqRUbe2Ix2DCDieQW0lPgWWPKx8f33PSv2+3Ap1dsLxa5EyyOGDOUo5Y2g3lXx5AiTJiqGAZYAMrA85bVer7o7BCiu01xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784311912; c=relaxed/simple;
	bh=mUUv1wxBgGV/qtG3Vq0SCCXSuUiATpyxjbb9DMGHnqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=arTvps+VDnVjcj7KvXRmTx7asVstlPEGBHdMn964Tav4wKpJxWWJHSBLPtFz/ZgOgfRsmmVBHSoY9d1X0Ro0FeQ9H6kDH0XkWCSuoplmpVRoJnxRT1IXNUSDOJsdGk1w7FRidTu/5nc4GUH6/TwVyh4Zd5XYDB9NAurw6YRTiwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1tGy24M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1tGy24M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59491F000E9;
	Fri, 17 Jul 2026 18:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784311911;
	bh=IlNFNLuwE81Ki3oPFtuEQoUG4k2mS2CynTU+gHDRACU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n1tGy24MAN8MRo+aYlrfrru6RSIrq8cGePo/iQRX+9+H0EwJ1UubxB21lahEQBQ7s
	 E6c1HJfGzlPaluYToZsNzU+0lleD8/PCqjQhOA5xOZ1TTcVxwxPn5EgaNhV6yd1BcT
	 pBZGRiqUy67WOlTAd5+CHsOz1FquUdF3RS6nFb4X8S9NBEt/8UYzMnAzmYljKF3SQZ
	 w3M8uyGUCp7krgxGv0KO320h/79S0Vxg4M0eViaqh8ICXNoOhMp4tkW8jSWXOOk1XT
	 MLserMQdI3ujhk/H1OSAKtVW9WMGEyV5o6ajYdDra4yC6zwI5VwIns2ev0fU6aMrMk
	 zlu6cQWlRhfow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] proc: protect ptrace_may_access() with exec_update_lock (part 1)
Date: Fri, 17 Jul 2026 14:11:49 -0400
Message-ID: <20260717181149.2086640-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071445-ridden-persuader-5fac@gregkh>
References: <2026071445-ridden-persuader-5fac@gregkh>
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
[ converted NULL return from mm_access() to ERR_PTR(-ESRCH) at call sites since 5.15's mm_access() returns NULL when the task has no mm ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/array.c      |  6 ++++++
 fs/proc/base.c       | 41 ++++++++++++++++++++++++-----------------
 fs/proc/namespaces.c | 12 ++++++++++++
 3 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index 6f30b5a3166786..65f4e4df785d61 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -468,6 +468,11 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 	unsigned long flags;
 	struct signal_struct *sig = task->signal;
 	unsigned int seq = 1;
+	int ret;
+
+	ret = down_read_killable(&task->signal->exec_update_lock);
+	if (ret)
+		return ret;
 
 	state = *get_task_state(task);
 	vsize = eip = esp = 0;
@@ -642,6 +647,7 @@ static int do_task_stat(struct seq_file *m, struct pid_namespace *ns,
 		seq_puts(m, " 0");
 
 	seq_putc(m, '\n');
+	up_read(&task->signal->exec_update_lock);
 	if (mm)
 		mmput(mm);
 	return 0;
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 3405005199b613..ddd73fca706530 100644
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
@@ -2357,17 +2363,17 @@ static struct dentry *proc_map_files_lookup(struct inode *dir,
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
+	mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
 	if (!mm)
+		mm = ERR_PTR(-ESRCH);
+	if (IS_ERR(mm)) {
+		result = ERR_CAST(mm);
 		goto out_put_task;
+	}
 
 	result = ERR_PTR(-EINTR);
 	if (mmap_read_lock_killable(mm))
@@ -2416,23 +2422,24 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
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
+	mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
 	if (!mm)
+		mm = ERR_PTR(-ESRCH);
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
 
@@ -2456,8 +2463,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 		if (!p) {
 			ret = -ENOMEM;
 			mmap_read_unlock(mm);
-			mmput(mm);
-			goto out_put_task;
+			goto out_put_mm;
 		}
 
 		p->start = vma->vm_start;
@@ -2465,7 +2471,6 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 		p->mode = vma->vm_file->f_mode;
 	}
 	mmap_read_unlock(mm);
-	mmput(mm);
 
 	for (i = 0; i < nr_files; i++) {
 		char buf[4 * sizeof(long) + 2];	/* max: %lx-%lx\0 */
@@ -2482,6 +2487,8 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
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

