Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA93F3C197F
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 11:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784287113; cv=none; b=cpBI9df7gFTPDysXvUANO5uqMin8qKDYXpigVOdUHqUXSeRDdbBJwZEhhxYZJQ7bmsiofDPEnvHXuumkvhJ3jkOFGzN64JNPiEmcJL8CvQQsIj5hOVIWfwuPkKE4U7wkn2YW8w34oBVO/UztsqubhQ9y5/0m2dNFDgWgfqmcjD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784287113; c=relaxed/simple;
	bh=AnMKKEFoIGnWCsPuEQNhpQj5z5SUT8/nI8b6MWryVaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XzlHz7GmBmGHTzCkSL9reel8ErKHA02datV4XWZoK1XIVG4VWDsJFIoURb6dFPVoMkDuryj/Dn0P8KINPAcNdpJzrN/YrOLigr014LjjxoMBcNdXv38YCwlefStSzV4tHM5BJWUELjA2dnOiIsySqc5KAZu+W97tQ+b0/fASz7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F9odfoni; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F9odfoni"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8161F00A3D;
	Fri, 17 Jul 2026 11:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784287107;
	bh=8WiAaJhkpR8mdfZhs0n/p1DlS+8hLOSnOeZ2xFOFgPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F9odfoniniR1pAieMhJqENj2c1xv5m6ZksVJrdw1HUnZqwvKh8Dxl1CFYeEM6u2R5
	 Aaznb3zciS9qGbbdnN8SX6IZgp/MiO7fy9C3gHdZogKwNO3TDq5qL/7Hz5uo16qcCf
	 jLXpZapkaInIm/DaG4Rta2jnTS1FCGay4vI0TYqin8h9LWnSbvvj2J2HKmFFa+Kacx
	 iOPmO7v0eNYw0CxvP44NC/s8g8BYh5sIZh9RGK2c+TGq2IgQBLRkkVT/0+Zb1Ha5W3
	 2tzIljm7EdNWgwNqa6JUYtsW87dcJ1wKzxoFFNiw1HnNvfBeqtCe/kAu9iieBejZSC
	 6KO5srrVsALbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Tyler Hicks (Microsoft)" <code@tyhicks.com>,
	"Kevin Parsons (Microsoft)" <parsonskev@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Jann Horn <jannh@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Hardik Garg <hargar@linux.microsoft.com>,
	Allen Pais <apais@linux.microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] proc: Move fdinfo PTRACE_MODE_READ check into the inode .permission operation
Date: Fri, 17 Jul 2026 07:18:20 -0400
Message-ID: <20260717111823.1573608-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717111823.1573608-1-sashal@kernel.org>
References: <2026071447-aviator-cresting-b224@gregkh>
 <20260717111823.1573608-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Tyler Hicks (Microsoft)" <code@tyhicks.com>

[ Upstream commit 0a960ba49869ebe8ff859d000351504dd6b93b68 ]

The following commits loosened the permissions of /proc/<PID>/fdinfo/
directory, as well as the files within it, from 0500 to 0555 while also
introducing a PTRACE_MODE_READ check between the current task and
<PID>'s task:

 - commit 7bc3fa0172a4 ("procfs: allow reading fdinfo with PTRACE_MODE_READ")
 - commit 1927e498aee1 ("procfs: prevent unprivileged processes accessing fdinfo dir")

Before those changes, inode based system calls like inotify_add_watch(2)
would fail when the current task didn't have sufficient read permissions:

 [...]
 lstat("/proc/1/task/1/fdinfo", {st_mode=S_IFDIR|0500, st_size=0, ...}) = 0
 inotify_add_watch(64, "/proc/1/task/1/fdinfo",
		   IN_MODIFY|IN_ATTRIB|IN_MOVED_FROM|IN_MOVED_TO|IN_CREATE|IN_DELETE|
		   IN_ONLYDIR|IN_DONT_FOLLOW|IN_EXCL_UNLINK) = -1 EACCES (Permission denied)
 [...]

This matches the documented behavior in the inotify_add_watch(2) man
page:

 ERRORS
       EACCES Read access to the given file is not permitted.

After those changes, inotify_add_watch(2) started succeeding despite the
current task not having PTRACE_MODE_READ privileges on the target task:

 [...]
 lstat("/proc/1/task/1/fdinfo", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
 inotify_add_watch(64, "/proc/1/task/1/fdinfo",
		   IN_MODIFY|IN_ATTRIB|IN_MOVED_FROM|IN_MOVED_TO|IN_CREATE|IN_DELETE|
		   IN_ONLYDIR|IN_DONT_FOLLOW|IN_EXCL_UNLINK) = 1757
 openat(AT_FDCWD, "/proc/1/task/1/fdinfo",
	O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DIRECTORY) = -1 EACCES (Permission denied)
 [...]

This change in behavior broke .NET prior to v7. See the github link
below for the v7 commit that inadvertently/quietly (?) fixed .NET after
the kernel changes mentioned above.

Return to the old behavior by moving the PTRACE_MODE_READ check out of
the file .open operation and into the inode .permission operation:

 [...]
 lstat("/proc/1/task/1/fdinfo", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
 inotify_add_watch(64, "/proc/1/task/1/fdinfo",
		   IN_MODIFY|IN_ATTRIB|IN_MOVED_FROM|IN_MOVED_TO|IN_CREATE|IN_DELETE|
		   IN_ONLYDIR|IN_DONT_FOLLOW|IN_EXCL_UNLINK) = -1 EACCES (Permission denied)
 [...]

Reported-by: Kevin Parsons (Microsoft) <parsonskev@gmail.com>
Link: https://github.com/dotnet/runtime/commit/89e5469ac591b82d38510fe7de98346cce74ad4f
Link: https://stackoverflow.com/questions/75379065/start-self-contained-net6-build-exe-as-service-on-raspbian-system-unauthorizeda
Fixes: 7bc3fa0172a4 ("procfs: allow reading fdinfo with PTRACE_MODE_READ")
Cc: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
Cc: Christian König <christian.koenig@amd.com>
Cc: Jann Horn <jannh@google.com>
Cc: Kalesh Singh <kaleshsingh@google.com>
Cc: Hardik Garg <hargar@linux.microsoft.com>
Cc: Allen Pais <apais@linux.microsoft.com>
Signed-off-by: Tyler Hicks (Microsoft) <code@tyhicks.com>
Link: https://lore.kernel.org/r/20240501005646.745089-1-code@tyhicks.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 6255da28d4bb ("proc: protect ptrace_may_access() with exec_update_lock (FD links)")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/proc/fd.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 913bef0d2a36c4..1cb1f0dbe59e06 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -72,7 +72,18 @@ static int seq_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int proc_fdinfo_access_allowed(struct inode *inode)
+static int seq_fdinfo_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, seq_show, inode);
+}
+
+/**
+ * Shared /proc/pid/fdinfo and /proc/pid/fdinfo/fd permission helper to ensure
+ * that the current task has PTRACE_MODE_READ in addition to the normal
+ * POSIX-like checks.
+ */
+static int proc_fdinfo_permission(struct mnt_idmap *idmap, struct inode *inode,
+				  int mask)
 {
 	bool allowed = false;
 	struct task_struct *task = get_proc_task(inode);
@@ -86,18 +97,13 @@ static int proc_fdinfo_access_allowed(struct inode *inode)
 	if (!allowed)
 		return -EACCES;
 
-	return 0;
+	return generic_permission(idmap, inode, mask);
 }
 
-static int seq_fdinfo_open(struct inode *inode, struct file *file)
-{
-	int ret = proc_fdinfo_access_allowed(inode);
-
-	if (ret)
-		return ret;
-
-	return single_open(file, seq_show, inode);
-}
+static const struct inode_operations proc_fdinfo_file_inode_operations = {
+	.permission	= proc_fdinfo_permission,
+	.setattr	= proc_setattr,
+};
 
 static const struct file_operations proc_fdinfo_file_operations = {
 	.open		= seq_fdinfo_open,
@@ -339,6 +345,8 @@ static struct dentry *proc_fdinfo_instantiate(struct dentry *dentry,
 	ei = PROC_I(inode);
 	ei->fd = data->fd;
 
+	inode->i_op = &proc_fdinfo_file_inode_operations;
+
 	inode->i_fop = &proc_fdinfo_file_operations;
 	tid_fd_update_inode(task, inode, 0);
 
@@ -358,23 +366,13 @@ static int proc_readfdinfo(struct file *file, struct dir_context *ctx)
 				  proc_fdinfo_instantiate);
 }
 
-static int proc_open_fdinfo(struct inode *inode, struct file *file)
-{
-	int ret = proc_fdinfo_access_allowed(inode);
-
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
 const struct inode_operations proc_fdinfo_inode_operations = {
 	.lookup		= proc_lookupfdinfo,
+	.permission	= proc_fdinfo_permission,
 	.setattr	= proc_setattr,
 };
 
 const struct file_operations proc_fdinfo_operations = {
-	.open		= proc_open_fdinfo,
 	.read		= generic_read_dir,
 	.iterate_shared	= proc_readfdinfo,
 	.llseek		= generic_file_llseek,
-- 
2.53.0

