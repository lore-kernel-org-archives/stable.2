Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C7B4D7D58
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 20:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789591034; cv=none; b=YKYNVLWbxkMoTbEhu3RVXP7xoF8dPuojnFIxMKIrEjEZpGAtRQqdRRk1pwFW5VnBHWsmrNCd2WabxpPEXpv4VXDLmpsaw5d3q9EVtTdvqRZhySSDX4AWWy9gm1E+gmQ0EQZYyg8rGV1Guf7zrEyifDCL+fM2Rgm9Px30nXYtbmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789591034; c=relaxed/simple;
	bh=+EIonXCPs1ndoURXnRpbo3tyGsSvEQVCRM9WqH1xijk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThBCMSLNlJR6P4CVO+gf0271XkC+dga42rw/aeyvQJgXp9p5cBBOr5d+tKTgKzuwctpRdxancyZBABlQGcWGH0VzYSNsnCwhbKMzthISaoV+NL7viGVV9dJ0J59rs2EglAy0IeL7f+E1Cj8geILq/AgF28p72DrO+my/jbF8IH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hleuSJvQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hleuSJvQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83811F00893;
	Wed, 16 Sep 2026 20:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789591019;
	bh=PdYBpBPfr3ocKTw1kcOGsdbOkQyrvTSphL5SbUDJNOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hleuSJvQKS1gY9xeDuW3zhBxAOHYGbirLu+UsskVMdBpokG5RcF5Mu/ujUmweigVa
	 PgGK7biUV4oo0XyvIG2XMU77w7eCgDD7wcEqbAxWKMkLmkotK5DhApjXHOUtjP6tiO
	 KP25ERVRoZtHG/rDXj/HiiiBU/fjP7KMg3L89bIzRSWv9xsf7RK+US7X8Za1rBERpJ
	 itfthK1tbRHBsTG9W+JOABup4K4yiPckgydOqtp0JkjG3j+lDeXfem6QeFBjaahpzy
	 PxvEQdrlC5gHRxlDqeW8dfPDrDhBnAfOEbFgCMDMZT1cESlAsbE254Owldk6UiLlqg
	 NV4EGlj/zormw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] ns: rename to exit_nsproxy_namespaces()
Date: Wed, 16 Sep 2026 16:36:55 -0400
Message-ID: <20260916203656.2689289-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916203656.2689289-1-sashal@kernel.org>
References: <2026091657-curry-myself-be92@gregkh>
 <20260916203656.2689289-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 4b06b70c8244b442d58ae0fb59870cf31fdb422e ]

The current naming is very misleading as this really isn't exiting all
of the task's namespaces. It is only exiting the namespaces that hang of
off nsproxy. Reflect that in the name.

Link: https://patch.msgid.link/20251029-work-namespace-nstree-listns-v4-10-2e6f823ebdc0@kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: cdd812d0683d ("exit: hold a reference to thread_pid across proc_flush_pid")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/nsproxy.h | 2 +-
 kernel/cgroup/cgroup.c  | 6 +++---
 kernel/exit.c           | 2 +-
 kernel/fork.c           | 2 +-
 kernel/nsproxy.c        | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
index bd118a187dec1..538ba8dba1840 100644
--- a/include/linux/nsproxy.h
+++ b/include/linux/nsproxy.h
@@ -93,7 +93,7 @@ static inline struct cred *nsset_cred(struct nsset *set)
  */
 
 int copy_namespaces(u64 flags, struct task_struct *tsk);
-void exit_task_namespaces(struct task_struct *tsk);
+void exit_nsproxy_namespaces(struct task_struct *tsk);
 void switch_task_namespaces(struct task_struct *tsk, struct nsproxy *new);
 int exec_task_namespaces(void);
 void free_nsproxy(struct nsproxy *ns);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index b2bb2368d93dd..5ae4c27e3b3d3 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1522,9 +1522,9 @@ static struct cgroup *current_cgns_cgroup_dfl(void)
 	} else {
 		/*
 		 * NOTE: This function may be called from bpf_cgroup_from_id()
-		 * on a task which has already passed exit_task_namespaces() and
-		 * nsproxy == NULL. Fall back to cgrp_dfl_root which will make all
-		 * cgroups visible for lookups.
+		 * on a task which has already passed exit_nsproxy_namespaces()
+		 * and nsproxy == NULL. Fall back to cgrp_dfl_root which will
+		 * make all cgroups visible for lookups.
 		 */
 		return &cgrp_dfl_root.cgrp;
 	}
diff --git a/kernel/exit.c b/kernel/exit.c
index a32bc65569a50..b22ede84c0ec9 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -973,7 +973,7 @@ void __noreturn do_exit(long code)
 	exit_fs(tsk);
 	if (group_dead)
 		disassociate_ctty(1);
-	exit_task_namespaces(tsk);
+	exit_nsproxy_namespaces(tsk);
 	exit_task_work(tsk);
 	exit_thread(tsk);
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 91f1512a1d312..295cf8cf719ea 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2455,7 +2455,7 @@ __latent_entropy struct task_struct *copy_process(
 	if (p->io_context)
 		exit_io_context(p);
 bad_fork_cleanup_namespaces:
-	exit_task_namespaces(p);
+	exit_nsproxy_namespaces(p);
 bad_fork_cleanup_mm:
 	if (p->mm) {
 		mm_clear_owner(p->mm, p);
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index 19aa64ab08c83..6ce76a0278ab4 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -241,7 +241,7 @@ void switch_task_namespaces(struct task_struct *p, struct nsproxy *new)
 		put_nsproxy(ns);
 }
 
-void exit_task_namespaces(struct task_struct *p)
+void exit_nsproxy_namespaces(struct task_struct *p)
 {
 	switch_task_namespaces(p, NULL);
 }
-- 
2.53.0

