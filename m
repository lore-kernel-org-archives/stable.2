Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA7C4D9909
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449263; cv=none; b=JsUXShg10fft35wrMCw2ePuUS2qDrRQxWetn6Pe5GC1zVKs5PmyhxAAICOrLccmj2DcM0/ICeVhGreIOI2Z5mYlzG2M5M4wT3Hoydm1/lDdhix5fTEDYas+2q5na4awQKBCMaYFftc7l8AX99Xo8078o0XbxDM2Ex4JfDMDXQWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449263; c=relaxed/simple;
	bh=albs2Vm7Pr7nJ3FY1wcK9kJMYnXetIpRhoAQLNFDxks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hpqPDlb1k9j4/23qhG+Ln7ztEdMWChv3a7ScDHRxej3CL0P3gfKvzjuw+dyo4ayGIKI1l+NxkeOdV9vBAm4X9MBd6LTF4UcREBufptLlS3kyoymskBYAbRlHaR6gotcQiRRG7T3JRfdAajl0LRoUulNgSjGIn7pVJnFdSC55hZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBuIxtQC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBuIxtQC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A101F000E9;
	Thu,  3 Sep 2026 15:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788449262;
	bh=4bQee8T/6zNRwSAdIlJPcNvcg3ZNVA2Mijvng6BArn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WBuIxtQCDOZTKKtayHTqBN0gEUJEzXFzle5542VrNvXuuzzDVEAnAHaVjwoVMcQpG
	 ygfpKz8xXaApRsqK9R37zajGBE/TZvekEFVYdYmwxes+PvmGC22ilTFR5hv1FVL+GE
	 QMsIGzi2bOt+aKih53DBM4+YG+jR9V7YikTF6wwN4y5Aa/ohbx3uwOeItuwj7guVDA
	 5Y4h+NHHYcq30ZTFoaUWWhi9Ls21XfBvcgjzpsqXrX+SnmO/2xj7Z1DLI+yDwg4JUm
	 E166e0E9Zg53CliNWVbnazRQTtfg5Dro2jU9AseGJwpCKzw5G+dxB32hXdsE3tyT5J
	 azbdBcMSVxJ6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] nscommon: simplify initialization
Date: Thu,  3 Sep 2026 11:27:39 -0400
Message-ID: <20260903152740.890893-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090328-espresso-reveler-1a6b@gregkh>
References: <2026090328-espresso-reveler-1a6b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 5612ff3ec588be09f11a9424db6d1186bcdeb3fa ]

There's a lot of information that namespace implementers don't need to
know about at all. Encapsulate this all in the initialization helper.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>

[ sashal: Reduced backport -- upstream 5612ff3ec588b touches 10 file(s), this
  backport carries 1. Not backported here:
  fs/namespace.c
  include/linux/ns_common.h
  ipc/namespace.c
  kernel/cgroup/namespace.c
  kernel/nscommon.c
  kernel/pid_namespace.c
  kernel/time/namespace.c
  kernel/user_namespace.c
  ... and 2 more
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 9688a4680293 ("pidfd: hold exec_update_lock around namespace ioctl")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/pidfs.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 5a8d8eb8df23b..1c54efeaa265a 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -115,21 +115,27 @@ static __poll_t pidfd_poll(struct file *file, struct poll_table_struct *pts)
 	return poll_flags;
 }
 
+#define pidfs_ioctl_valid(cmd) \
+	(_IOC_TYPE(cmd) == PIDFS_IOCTL_MAGIC && _IOC_DIR(cmd) == _IOC_NONE && \
+	 _IOC_NR(cmd) >= _IOC_NR(PIDFD_GET_CGROUP_NAMESPACE) && \
+	 _IOC_NR(cmd) <= _IOC_NR(PIDFD_GET_UTS_NAMESPACE))
+
 static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct task_struct *task __free(put_task) = NULL;
 	struct nsproxy *nsp __free(put_nsproxy) = NULL;
-	struct pid *pid = pidfd_pid(file);
 	struct ns_common *ns_common = NULL;
-	struct pid_namespace *pid_ns;
 
-	if (arg)
-		return -EINVAL;
+	if (!pidfs_ioctl_valid(cmd))
+		return -ENOIOCTLCMD;
 
-	task = get_pid_task(pid, PIDTYPE_PID);
+	task = get_pid_task(pidfd_pid(file), PIDTYPE_PID);
 	if (!task)
 		return -ESRCH;
 
+	if (arg)
+		return -EINVAL;
+
 	scoped_guard(task_lock, task) {
 		nsp = task->nsproxy;
 		if (nsp)
@@ -202,13 +208,17 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		}
 		break;
 	case PIDFD_GET_PID_NAMESPACE:
-		if (IS_ENABLED(CONFIG_PID_NS)) {
+#ifdef CONFIG_PID_NS
+		{
+			struct pid_namespace *pid_ns;
+
 			rcu_read_lock();
 			pid_ns = task_active_pid_ns(task);
 			if (pid_ns)
 				ns_common = to_ns_common(get_pid_ns(pid_ns));
 			rcu_read_unlock();
 		}
+#endif
 		break;
 	default:
 		return -ENOIOCTLCMD;
-- 
2.53.0

