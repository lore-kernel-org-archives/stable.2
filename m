Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767B64119FF;
	Wed, 29 Jul 2026 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785341867; cv=none; b=U9Hebm3kn7ign7xEfRNZUBdN9XjnD6gzD7Bh9XB8rTpL9dFsjhCoKTMPOnGS0fGHlNcmM4u5sTJLrhypIYlP1o/7w8jimRXI5mQns1O/EME5F+wnsfneU7UMBIHdMfwfeI7Uyzmb6cieIHfzC0c5wDCmu2+QGH5gMd8+zPXmsIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785341867; c=relaxed/simple;
	bh=G3RZl2OSxlibEsDeZoCvqQ+/UZm9jDQa4PA3Ye2aEcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qgCR+Ke9FqlSbSILXhhbpM4hW/PG5e7TQLbM/6MhmtbXudvaitDCFplEdXZStz5R+wTPM7oN2VnKyte9/UN21+FE5mNKtJ5jE2lqfjcVBBBW5tXqT1onmqd/xXhkW/5CQI51MDSmFE3Ca9+EAHJn7ZK7+BzfrGhCu6RL4Fm82ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bgf6mKPP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bgf6mKPP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16361F00A3A;
	Wed, 29 Jul 2026 16:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785341865;
	bh=28TIH321cMw61hSmqd/7PsxR/thmZzuyGimhZgRpYN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bgf6mKPPrNxh7rDofKDdmK8lvzzDU73vSbGvQdaFZ1SSiEzUWdSgarNfOjdi0Hjb5
	 i98GeUdjPIEo6VkXqM48/KR6NJ9AZ5ToD8gIrw7EBaj5mMEZoh5+5WoML9DDbeZwx9
	 hFIQgnuEDBn4KOfXgblKo3OeopGK8d3deyie6lRw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.6.146
Date: Wed, 29 Jul 2026 18:17:25 +0200
Message-ID: <2026072925-defeat-confident-5e22@gregkh>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026072925-catacomb-spring-bece@gregkh>
References: <2026072925-catacomb-spring-bece@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 935db0304062..bb0b3e5b9056 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 6
-SUBLEVEL = 145
+SUBLEVEL = 146
 EXTRAVERSION =
 NAME = Pinguïn Aangedreven
 
diff --git a/fs/proc/base.c b/fs/proc/base.c
index da5c436ea36f..881c2d4846d7 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -811,19 +811,21 @@ static const struct file_operations proc_single_file_operations = {
 struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode)
 {
 	struct task_struct *task = get_proc_task(inode);
-	struct mm_struct *mm = ERR_PTR(-ESRCH);
+	struct mm_struct *mm;
 
-	if (task) {
-		mm = mm_access(task, mode | PTRACE_MODE_FSCREDS);
-		put_task_struct(task);
+	if (!task)
+		return ERR_PTR(-ESRCH);
 
-		if (!IS_ERR_OR_NULL(mm)) {
-			/* ensure this mm_struct can't be freed */
-			mmgrab(mm);
-			/* but do not pin its memory */
-			mmput(mm);
-		}
-	}
+	mm = mm_access(task, mode | PTRACE_MODE_FSCREDS);
+	put_task_struct(task);
+
+	if (IS_ERR(mm))
+		return mm == ERR_PTR(-ESRCH) ? NULL : mm;
+
+	/* ensure this mm_struct can't be freed */
+	mmgrab(mm);
+	/* but do not pin its memory */
+	mmput(mm);
 
 	return mm;
 }
@@ -2201,7 +2203,7 @@ static int map_files_d_revalidate(struct dentry *dentry, unsigned int flags)
 		goto out_notask;
 
 	mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
-	if (IS_ERR_OR_NULL(mm))
+	if (IS_ERR(mm))
 		goto out;
 
 	if (!dname_to_vma_addr(dentry, &vm_start, &vm_end)) {
diff --git a/kernel/fork.c b/kernel/fork.c
index 724040ac5895..36854aaec482 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1570,8 +1570,9 @@ struct mm_struct *mm_access(struct task_struct *task, unsigned int mode)
 		return ERR_PTR(err);
 
 	mm = get_task_mm(task);
-	if (mm && mm != current->mm &&
-			!ptrace_may_access(task, mode)) {
+	if (!mm) {
+		mm = ERR_PTR(-ESRCH);
+	} else if (mm != current->mm && !ptrace_may_access(task, mode)) {
 		mmput(mm);
 		mm = ERR_PTR(-EACCES);
 	}
diff --git a/mm/madvise.c b/mm/madvise.c
index 73ea053c9003..0c30710bfd85 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1492,8 +1492,8 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 
 	/* Require PTRACE_MODE_READ to avoid leaking ASLR metadata. */
 	mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
-	if (IS_ERR_OR_NULL(mm)) {
-		ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
+	if (IS_ERR(mm)) {
+		ret = PTR_ERR(mm);
 		goto release_task;
 	}
 
diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
index 0523edab03a6..5be8e91aa872 100644
--- a/mm/process_vm_access.c
+++ b/mm/process_vm_access.c
@@ -200,8 +200,8 @@ static ssize_t process_vm_rw_core(pid_t pid, struct iov_iter *iter,
 	}
 
 	mm = mm_access(task, PTRACE_MODE_ATTACH_REALCREDS);
-	if (!mm || IS_ERR(mm)) {
-		rc = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
+	if (IS_ERR(mm)) {
+		rc = PTR_ERR(mm);
 		/*
 		 * Explicitly map EACCES to EPERM as EPERM is a more
 		 * appropriate error code for process_vw_readv/writev
