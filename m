Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B43145C715;
	Wed, 29 Jul 2026 16:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785341861; cv=none; b=jn4lypwt2u81ke5k3ogbcmDW4fxDZV9/G4eM86T6Jla8Qb5u6EDdEVo0OwIryyRGUDW0TKeIXWhHcivdkOxHw+8b/4Vp9Hbn36eT8Wp5i7FNHIFL7g7eWfaUT3+AuEFoOIjm2DWSziM2w9qiAw5UhnN7OLW2OUg4HgjGQ/2574M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785341861; c=relaxed/simple;
	bh=28kamy+/+Mun3PbAbiAKPRTIuqyCfqf5H5/8Xz5CPVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPPcRdqqEinlXcv1d8NEtpSQuHIIv6tjEa6uY7t4cg/QijcliTu4nOr/zn3l9ODKNv8Hgwb3IRZyUtUcsIxEm6JKrvW69b+LcAnNGcwzx7VYCmuFKegv+seGRNakC4dOEGh3QVf/Zx7K9bnqDa8xCZ3WI6eZ/f0Hsc4wIk3O/FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c+ragyYH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c+ragyYH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A95B1F00A3A;
	Wed, 29 Jul 2026 16:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785341859;
	bh=MAZsIN+4RAhJ10ZrNc/4FdTBUIvZnvMpTG2x2Aj0Itg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c+ragyYH0KgaUEI6pWScfZCfXUTAC+2DN9uNofY1m1q6A3sryQazkDeSz75E57aax
	 lhPDfhJh1NsqQ9I+sw70YgdGIfY3pn2hrQQDKeMxL38c0xpl2oumqWToeEhjmM/GFQ
	 ssYkJ/RgpxZts46nIfAnJRqmQEKXNJ6ApuKDHteU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.1.179
Date: Wed, 29 Jul 2026 18:17:19 +0200
Message-ID: <2026072919-oppressor-decorator-41e6@gregkh>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026072919-yin-grudging-7b3e@gregkh>
References: <2026072919-yin-grudging-7b3e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index c9d035993706..75a0332a42df 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 1
-SUBLEVEL = 178
+SUBLEVEL = 179
 EXTRAVERSION =
 NAME = Curry Ramen
 
diff --git a/fs/proc/base.c b/fs/proc/base.c
index b89e6fbf2326..6f24023b64f3 100644
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
index db2a9016f636..63f56a292f75 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1418,8 +1418,9 @@ struct mm_struct *mm_access(struct task_struct *task, unsigned int mode)
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
index 06c5adcaec59..a3a3a423e951 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1485,8 +1485,8 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 
 	/* Require PTRACE_MODE_READ to avoid leaking ASLR metadata. */
 	mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
-	if (IS_ERR_OR_NULL(mm)) {
-		ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
+	if (IS_ERR(mm)) {
+		ret = PTR_ERR(mm);
 		goto release_task;
 	}
 
diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
index 78dfaf9e8990..025cba94e63f 100644
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
