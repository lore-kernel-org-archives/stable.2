Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93B24A3D52
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 12:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788438161; cv=none; b=UVk990CGsAW5BSS73x+k4aer/zGrIKMSjnq1vWWFyD8/vWC1H/RNeYRtQc+w5UHGyiBXsQwMYwxn743xEFK8gsRi3eHCc+rOniTSjv+iBei4mQFP7HCzYPNf8CzAwcrNXP26o4vH3HsgEnwvtTa4bXDcdOz7Q5OJlJkAkgthvfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788438161; c=relaxed/simple;
	bh=VSCeR1zhpUVJVX8TimnnZQE79xHkj0Hi7Pqc11IvCl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtE4pbbJ+hmOyyQsv+D+H51xUyuwIvfjNEnlTw60C1c1WFQ21fFzNuggTKJ5KjNAkb6Si5aaww/v7tKoxcSzw02qH5MjXyQhWs3wJFfzUEUho78tLVRcfHRYjFhsWIddA+rwnZk78z6dnx4951G6UOyrxmCS/K/tYNa9daz4b5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wiu4XeXu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wiu4XeXu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1751F000E9;
	Thu,  3 Sep 2026 12:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788438158;
	bh=JCzheon1sv0hxLNEu4ePaueyTf+9WJVpTsUv3o7daRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wiu4XeXutRNzNqSXGmaepWQ2gQfQik+vhmQwoDdf3fbPLmyUEfaCPgT7r7ErNoORO
	 2ShQLTnzP5X+WgN5axBnkflSMZo7ElUYi+d2Sf76jLAzCoknnz6FzmgyQftqLYw6Xk
	 PJtyeuH0E7Vii3xGW42kbx280RbMzpK0p3/dLRjkdp9sMGWTbwTBde52zFpfKMWPr+
	 OVJ0/ZKIyCtkMNWejsLkGhF+UOHIlipgoWTaOBHccW/40AUNqrXK0X+o6ngWuJx9XN
	 9+yqHkVRK/DwnL81/Fd3oNOSFzEDvN50kPouAlooWZjx3kTvy0qDEsjNb1N1wqv9+t
	 LsVEOICmqOICg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] pidfs: simplify PIDFD_GET_<type>_NAMESPACE ioctls
Date: Thu,  3 Sep 2026 08:22:35 -0400
Message-ID: <20260903122236.709194-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090328-fleshed-scrambler-e1f2@gregkh>
References: <2026090328-fleshed-scrambler-e1f2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit a71e4f103aed69e7a11ea913312726bb194c76ee ]

We have reworked namespaces sufficiently that all this special-casing
shouldn't be needed anymore

Link: https://patch.msgid.link/20251117-eidesstattlich-apotheke-36d2e644079f@brauner
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 9688a4680293 ("pidfd: hold exec_update_lock around namespace ioctl")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/pidfs.c | 75 ++++++++++++++++++++++++++----------------------------
 1 file changed, 36 insertions(+), 39 deletions(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index 34987fcdd9a87..7282ac3db0795 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -456,7 +456,6 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct task_struct *task __free(put_task) = NULL;
 	struct nsproxy *nsp __free(put_nsproxy) = NULL;
 	struct ns_common *ns_common = NULL;
-	struct pid_namespace *pid_ns;
 
 	if (!pidfs_ioctl_valid(cmd))
 		return -ENOIOCTLCMD;
@@ -498,66 +497,64 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	switch (cmd) {
 	/* Namespaces that hang of nsproxy. */
 	case PIDFD_GET_CGROUP_NAMESPACE:
-		if (IS_ENABLED(CONFIG_CGROUPS)) {
-			get_cgroup_ns(nsp->cgroup_ns);
-			ns_common = to_ns_common(nsp->cgroup_ns);
-		}
+		if (!ns_ref_get(nsp->cgroup_ns))
+			break;
+		ns_common = to_ns_common(nsp->cgroup_ns);
 		break;
 	case PIDFD_GET_IPC_NAMESPACE:
-		if (IS_ENABLED(CONFIG_IPC_NS)) {
-			get_ipc_ns(nsp->ipc_ns);
-			ns_common = to_ns_common(nsp->ipc_ns);
-		}
+		if (!ns_ref_get(nsp->ipc_ns))
+			break;
+		ns_common = to_ns_common(nsp->ipc_ns);
 		break;
 	case PIDFD_GET_MNT_NAMESPACE:
-		get_mnt_ns(nsp->mnt_ns);
+		if (!ns_ref_get(nsp->mnt_ns))
+			break;
 		ns_common = to_ns_common(nsp->mnt_ns);
 		break;
 	case PIDFD_GET_NET_NAMESPACE:
-		if (IS_ENABLED(CONFIG_NET_NS)) {
-			ns_common = to_ns_common(nsp->net_ns);
-			get_net_ns(ns_common);
-		}
+		if (!ns_ref_get(nsp->net_ns))
+			break;
+		ns_common = to_ns_common(nsp->net_ns);
 		break;
 	case PIDFD_GET_PID_FOR_CHILDREN_NAMESPACE:
-		if (IS_ENABLED(CONFIG_PID_NS)) {
-			get_pid_ns(nsp->pid_ns_for_children);
-			ns_common = to_ns_common(nsp->pid_ns_for_children);
-		}
+		if (!ns_ref_get(nsp->pid_ns_for_children))
+			break;
+		ns_common = to_ns_common(nsp->pid_ns_for_children);
 		break;
 	case PIDFD_GET_TIME_NAMESPACE:
-		if (IS_ENABLED(CONFIG_TIME_NS)) {
-			get_time_ns(nsp->time_ns);
-			ns_common = to_ns_common(nsp->time_ns);
-		}
+		if (!ns_ref_get(nsp->time_ns))
+			break;
+		ns_common = to_ns_common(nsp->time_ns);
 		break;
 	case PIDFD_GET_TIME_FOR_CHILDREN_NAMESPACE:
-		if (IS_ENABLED(CONFIG_TIME_NS)) {
-			get_time_ns(nsp->time_ns_for_children);
-			ns_common = to_ns_common(nsp->time_ns_for_children);
-		}
+		if (!ns_ref_get(nsp->time_ns_for_children))
+			break;
+		ns_common = to_ns_common(nsp->time_ns_for_children);
 		break;
 	case PIDFD_GET_UTS_NAMESPACE:
-		if (IS_ENABLED(CONFIG_UTS_NS)) {
-			get_uts_ns(nsp->uts_ns);
-			ns_common = to_ns_common(nsp->uts_ns);
-		}
+		if (!ns_ref_get(nsp->uts_ns))
+			break;
+		ns_common = to_ns_common(nsp->uts_ns);
 		break;
 	/* Namespaces that don't hang of nsproxy. */
 	case PIDFD_GET_USER_NAMESPACE:
-		if (IS_ENABLED(CONFIG_USER_NS)) {
-			rcu_read_lock();
-			ns_common = to_ns_common(get_user_ns(task_cred_xxx(task, user_ns)));
-			rcu_read_unlock();
+		scoped_guard(rcu) {
+			struct user_namespace *user_ns;
+
+			user_ns = task_cred_xxx(task, user_ns);
+			if (!ns_ref_get(user_ns))
+				break;
+			ns_common = to_ns_common(user_ns);
 		}
 		break;
 	case PIDFD_GET_PID_NAMESPACE:
-		if (IS_ENABLED(CONFIG_PID_NS)) {
-			rcu_read_lock();
+		scoped_guard(rcu) {
+			struct pid_namespace *pid_ns;
+
 			pid_ns = task_active_pid_ns(task);
-			if (pid_ns)
-				ns_common = to_ns_common(get_pid_ns(pid_ns));
-			rcu_read_unlock();
+			if (!ns_ref_get(pid_ns))
+				break;
+			ns_common = to_ns_common(pid_ns);
 		}
 		break;
 	default:
-- 
2.53.0

