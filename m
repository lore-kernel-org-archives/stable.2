Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5D631327F
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788429394; cv=none; b=RWbk+uYzosR3UGIXe4l8M8PZAAh77Vuu8Pd3gRWd3Bh1ly1rkepkFydObOU2AVtGS2O4q8aUiFOcss81Dr1vP+WrDuZR/7qQogHVccD6/O4heC+W7y2Vsp/UJUEToweIqhQpVOxk6ELq6eHOVFWXlqTxd5zqripvUju0n5cMqPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788429394; c=relaxed/simple;
	bh=2yiKJL6znWxeIZrCyrZRpjJvcuQSuHOUegBi8j6SYgU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=s8fVKWbz8ys3VzizYb8FqmHlPYv19I7aegJVRSzUYhVIdhwXhLBHKUjYRewDEWBJivGVn7wa6c24USQP/6dOzuKMkgqpLmI6MGXijM6DkvE0iMSI237BSY8nTDUsExQ8aUmrJG8l5pAdrCY1QIVIrsDK5Y1NO0r6+nnHgVq86ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Er+nrqxx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Er+nrqxx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EC41F000E9;
	Thu,  3 Sep 2026 09:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788429393;
	bh=Ecook38XgRcEGLKoPMbHMYM5kUJ3kPcuw3t8Qrix0/Q=;
	h=Subject:To:Cc:From:Date;
	b=Er+nrqxx74p6HJpQwHHC3GsZlIqxZSV1ulUrxiWOPlBGNxiKbbFqYMUMFS4UUIlSB
	 rnsKAn2N36e+8aqTocARWRYuHAHf/29Mn3imTWfrZCYiEaC3SWjxhF0pBDFvHxvux4
	 zRHgQoP3zHboe5Gi/rFjC7qHuY2RYkd5hwFizsWo=
Subject: FAILED: patch "[PATCH] pidfd: hold exec_update_lock around namespace ioctl" failed to apply to 6.18-stable tree
To: me@black-desk.cn,brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 11:56:28 +0200
Message-ID: <2026090328-fleshed-scrambler-e1f2@gregkh>
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
git cherry-pick -x 9688a46802939da28f00cb40e8129615d5d4af39
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090328-fleshed-scrambler-e1f2@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9688a46802939da28f00cb40e8129615d5d4af39 Mon Sep 17 00:00:00 2001
From: Chen Linxuan <me@black-desk.cn>
Date: Fri, 31 Jul 2026 22:50:08 +0800
Subject: [PATCH] pidfd: hold exec_update_lock around namespace ioctl

The PIDFD_GET_*_NAMESPACE ioctls in pidfd_ioctl() perform a filesystem
credentials ptrace access check before handing out a namespace file
descriptor.  The accompanying comment states that the code "mirrors nsfs
behavior", but, unlike the corresponding procfs paths, it does so without
holding the target task's exec_update_lock.

proc_ns_get_link() and proc_ns_readlink() both take exec_update_lock for
reading around the ptrace check and the namespace lookup, so that the
credentials used for the access decision match those of the task when its
namespace is read.  Without it, a caller can pass the check against the
target's old credentials and then read the namespace after the target has
execve()'d a setuid binary and committed new credentials -- accessing
namespace information it should have been denied.

Hold exec_update_lock for reading around the ptrace check and the
namespace lookup so that pidfd truly mirrors nsfs behavior, as the comment
already claims.  open_namespace() itself runs outside the lock: once a
namespace reference is obtained it carries its own refcount and is opened
with the caller's own credentials, so a concurrent execve() on the target
can no longer affect the outcome.

Fixes: 5b08bd408534 ("pidfs: allow retrieval of namespace file descriptors")
Cc: stable@vger.kernel.org
Signed-off-by: Chen Linxuan <me@black-desk.cn>
Link: https://patch.msgid.link/20260731-pidfd-exec-update-lock-v1-1-b388f2f3a8b0@black-desk.cn
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/pidfs.c b/fs/pidfs.c
index aaa609ddab04..7fc3c1f5a578 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -531,6 +531,7 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct task_struct *task __free(put_task) = NULL;
 	struct nsproxy *nsp __free(put_nsproxy) = NULL;
 	struct ns_common *ns_common = NULL;
+	int error;
 
 	if (!pidfs_ioctl_valid(cmd))
 		return -ENOIOCTLCMD;
@@ -554,20 +555,33 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	if (arg)
 		return -EINVAL;
 
+	/*
+	 * We're trying to open a file descriptor to the namespace so perform a
+	 * filesystem cred ptrace check. Hold @task's exec_update_lock for the
+	 * duration of the ptrace check and the namespace lookup so that the
+	 * credentials used for the access decision match those of @task at the
+	 * time its namespace is read, preventing a concurrent execve() from
+	 * swapping the task's credentials in between the check and the use. We
+	 * mirror nsfs behavior.
+	 */
+	error = down_read_killable(&task->signal->exec_update_lock);
+	if (error)
+		return error;
+
+	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)) {
+		error = -EACCES;
+		goto out_unlock;
+	}
+
 	scoped_guard(task_lock, task) {
 		nsp = task->nsproxy;
 		if (nsp)
 			get_nsproxy(nsp);
 	}
-	if (!nsp)
-		return -ESRCH; /* just pretend it didn't exist */
-
-	/*
-	 * We're trying to open a file descriptor to the namespace so perform a
-	 * filesystem cred ptrace check. Also, we mirror nsfs behavior.
-	 */
-	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
-		return -EACCES;
+	if (!nsp) {
+		error = -ESRCH; /* just pretend it didn't exist */
+		goto out_unlock;
+	}
 
 	switch (cmd) {
 	/* Namespaces that hang of nsproxy. */
@@ -649,11 +663,16 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 #endif
 		break;
 	default:
-		return -ENOIOCTLCMD;
+		error = -ENOIOCTLCMD;
 	}
 
-	if (!ns_common)
-		return -EOPNOTSUPP;
+	if (!error && !ns_common)
+		error = -EOPNOTSUPP;
+
+out_unlock:
+	up_read(&task->signal->exec_update_lock);
+	if (error)
+		return error;
 
 	/* open_namespace() unconditionally consumes the reference */
 	return open_namespace(ns_common);

