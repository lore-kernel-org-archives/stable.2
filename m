Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB54E43F8D1
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040663; cv=none; b=LW85vM9bzJGz8rpHguHA+Ug8lfFf+fQDSTZbZBjTEKJWaOc1lf62Ut1l84LDN+tD0xMqIb1zYFjMxfzwQ1czYyZIGVoIKNRIbfNfqOmrlBc3bsS7TALCsL0ywKQKn7qt3H0UY7AtXJVPuqGHGZTp7jL4A8WYTRA+YKr36TbZsI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040663; c=relaxed/simple;
	bh=aUHgbO1uoQdUIX+Ebk2jelxYSK0enL+qpnea6lZuASA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=q7lKy3wyKUQDcOc/wM03GMSp8qgNFuYVMqRuyQXWIkCFXMLwVIcxoJhuJw6zBGU68AknpnzR4YFUuAyAd0ElH07CSkyMqf8wOWcRLTxBIo6cLWrmBniHjzzE5DAuGPEShoFL7fTJQkdK4OAbnUTx2vtD7HAmeUoWRL6mg2sbeQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vg1TpGEf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vg1TpGEf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4203E1F00A3A;
	Tue, 14 Jul 2026 14:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784040651;
	bh=Jhdj0A6Ku6npyMQhcZFvrNv+nGwStS27s7v7tjQat4Y=;
	h=Subject:To:Cc:From:Date;
	b=Vg1TpGEfR4akxZAV2uauPDByvOBaI+HJIhk5hUiLyIrgXZVRaZS1rH5hSh0hGSlFj
	 tzovGk1B2YzO2To+OD9JieEczHKZ/K4a/wWQpYMDkzlQEILqm0MO3y/c3ykGNa8whm
	 t+8S5+F+A7UOPeGItSGkHlcgUinu0lIbF/mfIwRc=
Subject: FAILED: patch "[PATCH] proc: protect ptrace_may_access() with exec_update_lock (FD" failed to apply to 5.10-stable tree
To: jannh@google.com,brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 16:49:47 +0200
Message-ID: <2026071447-magnesium-aghast-e41f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 6255da28d4bb5349fe18e84cb043ccd394eba75d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071447-magnesium-aghast-e41f@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6255da28d4bb5349fe18e84cb043ccd394eba75d Mon Sep 17 00:00:00 2001
From: Jann Horn <jannh@google.com>
Date: Mon, 18 May 2026 18:35:16 +0200
Subject: [PATCH] proc: protect ptrace_may_access() with exec_update_lock (FD
 links)

proc_pid_get_link() and proc_pid_readlink() currently look up the task from
the pid once, then do the ptrace access check on that task, then look up
the task from the pid a second time to do the actual access.
That's racy in several ways.

To fix it, pass the task to the ->proc_get_link() handler, and instead of
proc_fd_access_allowed(), introduce a new helper call_proc_get_link() that
looks up and locks the task, does the access check, and calls
->proc_get_link().

Fixes: 778c1144771f ("[PATCH] proc: Use sane permission checks on the /proc/<pid>/fd/ symlinks")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
Link: https://patch.msgid.link/20260518-procfs-lockfix-part1-v1-2-5c3d20e0ac33@google.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/proc/base.c b/fs/proc/base.c
index cc99d953a0a3..5042f14d24f3 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -218,33 +218,24 @@ static int get_task_root(struct task_struct *task, struct path *root)
 	return result;
 }
 
-static int proc_cwd_link(struct dentry *dentry, struct path *path)
+static int proc_cwd_link(struct dentry *dentry, struct path *path,
+			 struct task_struct *task)
 {
-	struct task_struct *task = get_proc_task(d_inode(dentry));
 	int result = -ENOENT;
 
-	if (task) {
-		task_lock(task);
-		if (task->fs) {
-			get_fs_pwd(task->fs, path);
-			result = 0;
-		}
-		task_unlock(task);
-		put_task_struct(task);
+	task_lock(task);
+	if (task->fs) {
+		get_fs_pwd(task->fs, path);
+		result = 0;
 	}
+	task_unlock(task);
 	return result;
 }
 
-static int proc_root_link(struct dentry *dentry, struct path *path)
+static int proc_root_link(struct dentry *dentry, struct path *path,
+			  struct task_struct *task)
 {
-	struct task_struct *task = get_proc_task(d_inode(dentry));
-	int result = -ENOENT;
-
-	if (task) {
-		result = get_task_root(task, path);
-		put_task_struct(task);
-	}
-	return result;
+	return get_task_root(task, path);
 }
 
 /*
@@ -710,23 +701,6 @@ static int proc_pid_syscall(struct seq_file *m, struct pid_namespace *ns,
 /*                       Here the fs part begins                        */
 /************************************************************************/
 
-/* permission checks */
-static bool proc_fd_access_allowed(struct inode *inode)
-{
-	struct task_struct *task;
-	bool allowed = false;
-	/* Allow access to a task's file descriptors if it is us or we
-	 * may use ptrace attach to the process and find out that
-	 * information.
-	 */
-	task = get_proc_task(inode);
-	if (task) {
-		allowed = ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS);
-		put_task_struct(task);
-	}
-	return allowed;
-}
-
 int proc_nochmod_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		 struct iattr *attr)
 {
@@ -1783,16 +1757,12 @@ static const struct file_operations proc_pid_set_comm_operations = {
 	.release	= single_release,
 };
 
-static int proc_exe_link(struct dentry *dentry, struct path *exe_path)
+static int proc_exe_link(struct dentry *dentry, struct path *exe_path,
+			 struct task_struct *task)
 {
-	struct task_struct *task;
 	struct file *exe_file;
 
-	task = get_proc_task(d_inode(dentry));
-	if (!task)
-		return -ENOENT;
 	exe_file = get_task_exe_file(task);
-	put_task_struct(task);
 	if (exe_file) {
 		*exe_path = exe_file->f_path;
 		path_get(&exe_file->f_path);
@@ -1802,26 +1772,42 @@ static int proc_exe_link(struct dentry *dentry, struct path *exe_path)
 		return -ENOENT;
 }
 
+static int call_proc_get_link(struct dentry *dentry, struct inode *inode, struct path *path_out)
+{
+	struct task_struct *task;
+	int ret;
+
+	task = get_proc_task(inode);
+	if (!task)
+		return -ENOENT;
+	ret = down_read_killable(&task->signal->exec_update_lock);
+	if (ret)
+		goto out_put_task;
+	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)) {
+		ret = -EACCES;
+		goto out;
+	}
+	ret = PROC_I(inode)->op.proc_get_link(dentry, path_out, task);
+
+out:
+	up_read(&task->signal->exec_update_lock);
+out_put_task:
+	put_task_struct(task);
+	return ret;
+}
+
 static const char *proc_pid_get_link(struct dentry *dentry,
 				     struct inode *inode,
 				     struct delayed_call *done)
 {
 	struct path path;
-	int error = -EACCES;
+	int error;
 
 	if (!dentry)
 		return ERR_PTR(-ECHILD);
-
-	/* Are we allowed to snoop on the tasks file descriptors? */
-	if (!proc_fd_access_allowed(inode))
-		goto out;
-
-	error = PROC_I(inode)->op.proc_get_link(dentry, &path);
-	if (error)
-		goto out;
-
-	error = nd_jump_link(&path);
-out:
+	error = call_proc_get_link(dentry, inode, &path);
+	if (!error)
+		error = nd_jump_link(&path);
 	return ERR_PTR(error);
 }
 
@@ -1855,17 +1841,11 @@ static int proc_pid_readlink(struct dentry * dentry, char __user * buffer, int b
 	struct inode *inode = d_inode(dentry);
 	struct path path;
 
-	/* Are we allowed to snoop on the tasks file descriptors? */
-	if (!proc_fd_access_allowed(inode))
-		goto out;
-
-	error = PROC_I(inode)->op.proc_get_link(dentry, &path);
-	if (error)
-		goto out;
-
-	error = do_proc_readlink(&path, buffer, buflen);
-	path_put(&path);
-out:
+	error = call_proc_get_link(dentry, inode, &path);
+	if (!error) {
+		error = do_proc_readlink(&path, buffer, buflen);
+		path_put(&path);
+	}
 	return error;
 }
 
@@ -2256,21 +2236,16 @@ static const struct dentry_operations tid_map_files_dentry_operations = {
 	.d_delete	= pid_delete_dentry,
 };
 
-static int map_files_get_link(struct dentry *dentry, struct path *path)
+static int map_files_get_link(struct dentry *dentry, struct path *path,
+			      struct task_struct *task)
 {
 	unsigned long vm_start, vm_end;
 	struct vm_area_struct *vma;
-	struct task_struct *task;
 	struct mm_struct *mm;
 	int rc;
 
 	rc = -ENOENT;
-	task = get_proc_task(d_inode(dentry));
-	if (!task)
-		goto out;
-
 	mm = get_task_mm(task);
-	put_task_struct(task);
 	if (!mm)
 		goto out;
 
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 05c7513e77c7..0f9a1556f2a3 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -171,24 +171,19 @@ static const struct dentry_operations tid_fd_dentry_operations = {
 	.d_delete	= pid_delete_dentry,
 };
 
-static int proc_fd_link(struct dentry *dentry, struct path *path)
+static int proc_fd_link(struct dentry *dentry, struct path *path,
+			struct task_struct *task)
 {
-	struct task_struct *task;
 	int ret = -ENOENT;
+	unsigned int fd = proc_fd(d_inode(dentry));
+	struct file *fd_file;
 
-	task = get_proc_task(d_inode(dentry));
-	if (task) {
-		unsigned int fd = proc_fd(d_inode(dentry));
-		struct file *fd_file;
-
-		fd_file = fget_task(task, fd);
-		if (fd_file) {
-			*path = fd_file->f_path;
-			path_get(&fd_file->f_path);
-			ret = 0;
-			fput(fd_file);
-		}
-		put_task_struct(task);
+	fd_file = fget_task(task, fd);
+	if (fd_file) {
+		*path = fd_file->f_path;
+		path_get(&fd_file->f_path);
+		ret = 0;
+		fput(fd_file);
 	}
 
 	return ret;
diff --git a/fs/proc/internal.h b/fs/proc/internal.h
index 1edbabbdbc5d..b232e1098117 100644
--- a/fs/proc/internal.h
+++ b/fs/proc/internal.h
@@ -110,7 +110,7 @@ extern struct kmem_cache *proc_dir_entry_cache;
 void pde_free(struct proc_dir_entry *pde);
 
 union proc_op {
-	int (*proc_get_link)(struct dentry *, struct path *);
+	int (*proc_get_link)(struct dentry *, struct path *, struct task_struct *);
 	int (*proc_show)(struct seq_file *m,
 		struct pid_namespace *ns, struct pid *pid,
 		struct task_struct *task);

