Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF9D4A2A7E
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438162; cv=none; b=S9wezMadwwum03odlEjSZtWrxjpooRXl6dChVfzDxXNvOCUSek9tDDHKKayJeMY6j1XddFDkeKv5/LjnGLiBcSRYk8PViy1AE4kp+3L1bjfVoXNYPAJLhgOPbGgWBQAQb5GynwBwp4+oObmCOND073Cu32WCllgOBXeSdlYWU44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438162; c=relaxed/simple;
	bh=CUlccwZJXtJ7NAMnCT3CrAaPRfB8MoRuOMhC03QboTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsNLd/pl46HkQcVPZinsaXXdNQsPGRK2nIRccVykEHpWEFqkiC2pgsBlbe8lx3YP4bhLL6xyv9lJkJaDbNdeXQZ2znFnI6BHf6GKJzm/Whieu+bHp/RCpNxKuzBdyI9pN75FS8wxp0JEuZlIHdmgA0rOHTE9IXN8idweQaNbOHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j70Nq/5v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j70Nq/5v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0481F00A3E;
	Thu,  3 Sep 2026 12:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788438159;
	bh=AE4MlWnAxpGmuou83Kf4ToH9jpp+SLSD3pNQP/q2KM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j70Nq/5vopLuWtZWrILnBNM1XnLDmz+pirNKEDSaU1CiGR2LzBEASKP2K+2ppyHvB
	 BeAuY6Vc+PSkqlQsSymgPIu64+voyvHd5j/sFLXI0wKV4T1ClyGo24/QOxPDtdHBP7
	 Ej1ZepRmxB6HQc3B40QCTbfda1nA3KKSqTLFha7OTsrp3Mvuhy5tLx048lhVZ9ETZd
	 M7m0U9TNEbEw/MoeG+VLJkVwbwuwoNyElTShp3G3AZFQh/SKebW+31fvYfth2XsgNJ
	 o+REgVuWkmLO5Z5k9z6KKJ/bmDSC856DaAzflOItwcf6Rppe1C3JQjqnAyF6k/Kkn8
	 firt9/INphS+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen Linxuan <me@black-desk.cn>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] pidfd: hold exec_update_lock around namespace ioctl
Date: Thu,  3 Sep 2026 08:22:36 -0400
Message-ID: <20260903122236.709194-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903122236.709194-1-sashal@kernel.org>
References: <2026090328-fleshed-scrambler-e1f2@gregkh>
 <20260903122236.709194-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Linxuan <me@black-desk.cn>

[ Upstream commit 9688a46802939da28f00cb40e8129615d5d4af39 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/pidfs.c | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 7282ac3db0795..2e50594e0e877 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -456,6 +456,7 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct task_struct *task __free(put_task) = NULL;
 	struct nsproxy *nsp __free(put_nsproxy) = NULL;
 	struct ns_common *ns_common = NULL;
+	int error;
 
 	if (!pidfs_ioctl_valid(cmd))
 		return -ENOIOCTLCMD;
@@ -479,20 +480,33 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
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
@@ -558,11 +572,16 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		}
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
-- 
2.53.0

