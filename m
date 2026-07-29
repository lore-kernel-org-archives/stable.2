Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A6D46D2A5;
	Wed, 29 Jul 2026 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785341875; cv=none; b=KwBP9DxHaX1fxEROws3QTdL4dEQZM0uUNwoVQdJGxLSrNwdXUvmts6fkqVIKbhV+FCWt4NinArw+kSQiLP74J4m/VBKICGxiJOyonaVA0PxTJEpEJ3bevClqop0jHRm47jvZhhfN1b5Izi5T486TFw2kfooiYUavxX4DF+UvoiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785341875; c=relaxed/simple;
	bh=Cc90W3NDBI7kxZQcqK+aERNO5ag6dlPFZO17YI6QVgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gPkmXTi8G7TuYpb01oxh77hP9Dx9K/KKc/g4D/OJW7Q2wSG5u4p0t1tG4JbShhcZJP42eAM90YoUmuCXmelnb7HIUXT87eCxXoU18qg1STuNSB2LjGwjdTfWuAHK0PtCji8j2DLHiLYFV1LJL5gYCYOQzlCPkFDPt27a1ZOaF9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u2aYdB2x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u2aYdB2x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054151F00A3E;
	Wed, 29 Jul 2026 16:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785341873;
	bh=WN1t8ep0Dzu98/HgNDrR7H80XZMO7nis1crfCVm8XBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=u2aYdB2xaTgYy69A7PsCmU/VZ5Y6X5+fygUHtcR1wEDV9pUHQ8BBykumOObYUJpsC
	 7tU+pxLsEH/e/1sFE6vJZR7qhBdgYnX/4eumpufJuE8fC5AQJz7boRIpEQSxDaMIBD
	 oqiz+pbLD6G17bdBCfuUTvkEtFiU2DihHgQREtkM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.99
Date: Wed, 29 Jul 2026 18:17:31 +0200
Message-ID: <2026072931-crowd-cling-5fd3@gregkh>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026072931-buddhist-lethargy-769b@gregkh>
References: <2026072931-buddhist-lethargy-769b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 671079b33674..a5fb7f21c310 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 98
+SUBLEVEL = 99
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 9f0322368497..427fb5abb07c 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -817,19 +817,21 @@ static const struct file_operations proc_single_file_operations = {
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
@@ -2199,7 +2201,7 @@ static int map_files_d_revalidate(struct dentry *dentry, unsigned int flags)
 		goto out_notask;
 
 	mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
-	if (IS_ERR_OR_NULL(mm))
+	if (IS_ERR(mm))
 		goto out;
 
 	if (!dname_to_vma_addr(dentry, &vm_start, &vm_end)) {
diff --git a/kernel/fork.c b/kernel/fork.c
index 6191f1f8bde8..2b7577edffa2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1580,8 +1580,9 @@ struct mm_struct *mm_access(struct task_struct *task, unsigned int mode)
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
index 4a3b609a33e6..d2b315993a1c 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1521,8 +1521,8 @@ SYSCALL_DEFINE5(process_madvise, int, pidfd, const struct iovec __user *, vec,
 
 	/* Require PTRACE_MODE_READ to avoid leaking ASLR metadata. */
 	mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
-	if (IS_ERR_OR_NULL(mm)) {
-		ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
+	if (IS_ERR(mm)) {
+		ret = PTR_ERR(mm);
 		goto release_task;
 	}
 
diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
index b308e96cd05a..656d3e88755b 100644
--- a/mm/process_vm_access.c
+++ b/mm/process_vm_access.c
@@ -201,8 +201,8 @@ static ssize_t process_vm_rw_core(pid_t pid, struct iov_iter *iter,
 	}
 
 	mm = mm_access(task, PTRACE_MODE_ATTACH_REALCREDS);
-	if (!mm || IS_ERR(mm)) {
-		rc = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
+	if (IS_ERR(mm)) {
+		rc = PTR_ERR(mm);
 		/*
 		 * Explicitly map EACCES to EPERM as EPERM is a more
 		 * appropriate error code for process_vw_readv/writev
