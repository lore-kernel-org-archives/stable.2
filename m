Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892363D9025
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 18:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474587; cv=none; b=E+bqzD7Go1aBWgwcRua/DteGn9D0/lPALsnDhvwuwJ6keoTuszYH8g4RgnUjMo4UVYrWONCgrZA/+yf//He3BYmaiN77h2uK3YwlFRmT2ZMjSUjBCiAnG/L7LEquoVuuSM9oXwPw6UFOv9Bf5rRLBRUKXk/svWuwnlpFS7z2Gqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474587; c=relaxed/simple;
	bh=ZI2l81BDYXAEYeaPRyov3FyY87aPSy3JIg+v+lAn2XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=goEHz/PiwU4dM0ZE7g5P2/H8LKos41XbbiDTiO2pw/zSJlBbDp6bYPeZLOVZIjGPuMmTqYeSlbQUH+5ejIK7fbOA3WlK/3QpId6g72FVkf6XBcjBFeNtPlwMqO1gUKXphFEiRpiDvdRUcMpmyKLx4e9bqrD/AThdMIPydeieAPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnsWGkY5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnsWGkY5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6960C1F00A3E;
	Tue, 11 Aug 2026 18:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786474585;
	bh=lG95m8BOfxLPIko0tsrX+vGiecapphH+RM9ucfa04f8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AnsWGkY5hWyFBGFhNUSf9PBQPfKwWLsTtbOlqgeZPR0RMdDg76Apg7/zw/Xk3CVbb
	 r6ovR33QGQQBPc67pSh3zct+48JYni1ynYest+w5hcwiE6x0bA/6sS+gNU8aubi9uU
	 56Gg/imUFMsCh5YqetzTJL5j7JpN9Fa9f+j8LJdvyHT/w3eaE1FClzOdDeBQhhyuJ1
	 8EdtAKdv9VtOk53f6nRq/pcVLWF9HkxaZReyfQf41zcXqHDBdfv+pBihNdk4xTCmIH
	 8pTupqvGbBR5H5BBW8Buqp82Ba8ZRVqpFYShdy5Km3DOTJa5HE/NZxlyc8lfWYOdI0
	 hLpNPLLs5Tyyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] fs: don't block write during exec on pre-content watched files
Date: Tue, 11 Aug 2026 14:56:18 -0400
Message-ID: <20260811185619.3386946-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811185619.3386946-1-sashal@kernel.org>
References: <2026080511-putdown-richly-6ef6@gregkh>
 <20260811185619.3386946-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

[ Upstream commit 0357ef03c94ef835bd44a0658b8edb672a9dbf51 ]

Commit 2a010c412853 ("fs: don't block i_writecount during exec") removed
the legacy behavior of getting ETXTBSY on attempt to open and executable
file for write while it is being executed.

This commit was reverted because an application that depends on this
legacy behavior was broken by the change.

We need to allow HSM writing into executable files while executed to
fill their content on-the-fly.

To that end, disable the ETXTBSY legacy behavior for files that are
watched by pre-content events.

This change is not expected to cause regressions with existing systems
which do not have any pre-content event listeners.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Acked-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20241128142532.465176-1-amir73il@gmail.com
Stable-dep-of: db1856ea9196 ("binfmt_misc: restore write access when removing an entry")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/binfmt_elf.c       |  4 ++--
 fs/binfmt_elf_fdpic.c |  4 ++--
 fs/exec.c             |  8 ++++----
 include/linux/fs.h    | 22 ++++++++++++++++++++++
 kernel/fork.c         | 12 ++++++------
 5 files changed, 36 insertions(+), 14 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 47335a0f4a618..0984ec63f6d78 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1257,7 +1257,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		}
 		reloc_func_desc = interp_load_addr;
 
-		allow_write_access(interpreter);
+		exe_file_allow_write_access(interpreter);
 		fput(interpreter);
 
 		kfree(interp_elf_ex);
@@ -1371,7 +1371,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	kfree(interp_elf_ex);
 	kfree(interp_elf_phdata);
 out_free_file:
-	allow_write_access(interpreter);
+	exe_file_allow_write_access(interpreter);
 	if (interpreter)
 		fput(interpreter);
 out_free_ph:
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index 0a18471adcb20..32b6ddb327dbc 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -398,7 +398,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 			goto error;
 		}
 
-		allow_write_access(interpreter);
+		exe_file_allow_write_access(interpreter);
 		fput(interpreter);
 		interpreter = NULL;
 	}
@@ -471,7 +471,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 
 error:
 	if (interpreter) {
-		allow_write_access(interpreter);
+		exe_file_allow_write_access(interpreter);
 		fput(interpreter);
 	}
 	kfree(interpreter_name);
diff --git a/fs/exec.c b/fs/exec.c
index 20e165d48d3bf..8d9775e15cd2c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -912,7 +912,7 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 	    path_noexec(&file->f_path))
 		return ERR_PTR(-EACCES);
 
-	err = deny_write_access(file);
+	err = exe_file_deny_write_access(file);
 	if (err)
 		return ERR_PTR(err);
 
@@ -927,7 +927,7 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
  * Returns ERR_PTR on failure or allocated struct file on success.
  *
  * As this is a wrapper for the internal do_open_execat(), callers
- * must call allow_write_access() before fput() on release. Also see
+ * must call exe_file_allow_write_access() before fput() on release. Also see
  * do_close_execat().
  */
 struct file *open_exec(const char *name)
@@ -1501,7 +1501,7 @@ static void do_close_execat(struct file *file)
 {
 	if (!file)
 		return;
-	allow_write_access(file);
+	exe_file_allow_write_access(file);
 	fput(file);
 }
 
@@ -1835,7 +1835,7 @@ static int exec_binprm(struct linux_binprm *bprm)
 		bprm->file = bprm->interpreter;
 		bprm->interpreter = NULL;
 
-		allow_write_access(exec);
+		exe_file_allow_write_access(exec);
 		if (unlikely(bprm->have_execfd)) {
 			if (bprm->executable) {
 				fput(exec);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index faa55abdef0a5..d6eb2281a065c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3085,6 +3085,28 @@ static inline void allow_write_access(struct file *file)
 	if (file)
 		atomic_inc(&file_inode(file)->i_writecount);
 }
+
+/*
+ * Do not prevent write to executable file when watched by pre-content events.
+ *
+ * Note that FMODE_FSNOTIFY_HSM mode is set depending on pre-content watches at
+ * the time of file open and remains constant for entire lifetime of the file,
+ * so if pre-content watches are added post execution or removed before the end
+ * of the execution, it will not cause i_writecount reference leak.
+ */
+static inline int exe_file_deny_write_access(struct file *exe_file)
+{
+	if (unlikely(FMODE_FSNOTIFY_HSM(exe_file->f_mode)))
+		return 0;
+	return deny_write_access(exe_file);
+}
+static inline void exe_file_allow_write_access(struct file *exe_file)
+{
+	if (unlikely(!exe_file || FMODE_FSNOTIFY_HSM(exe_file->f_mode)))
+		return;
+	allow_write_access(exe_file);
+}
+
 static inline bool inode_is_open_for_write(const struct inode *inode)
 {
 	return atomic_read(&inode->i_writecount) > 0;
diff --git a/kernel/fork.c b/kernel/fork.c
index 2b7577edffa2d..c0ecb097aa1d2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -627,8 +627,8 @@ static void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm)
 	 * We depend on the oldmm having properly denied write access to the
 	 * exe_file already.
 	 */
-	if (exe_file && deny_write_access(exe_file))
-		pr_warn_once("deny_write_access() failed in %s\n", __func__);
+	if (exe_file && exe_file_deny_write_access(exe_file))
+		pr_warn_once("exe_file_deny_write_access() failed in %s\n", __func__);
 }
 
 #ifdef CONFIG_MMU
@@ -1439,13 +1439,13 @@ int set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 		 * We expect the caller (i.e., sys_execve) to already denied
 		 * write access, so this is unlikely to fail.
 		 */
-		if (unlikely(deny_write_access(new_exe_file)))
+		if (unlikely(exe_file_deny_write_access(new_exe_file)))
 			return -EACCES;
 		get_file(new_exe_file);
 	}
 	rcu_assign_pointer(mm->exe_file, new_exe_file);
 	if (old_exe_file) {
-		allow_write_access(old_exe_file);
+		exe_file_allow_write_access(old_exe_file);
 		fput(old_exe_file);
 	}
 	return 0;
@@ -1486,7 +1486,7 @@ int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 			return ret;
 	}
 
-	ret = deny_write_access(new_exe_file);
+	ret = exe_file_deny_write_access(new_exe_file);
 	if (ret)
 		return -EACCES;
 	get_file(new_exe_file);
@@ -1498,7 +1498,7 @@ int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 	mmap_write_unlock(mm);
 
 	if (old_exe_file) {
-		allow_write_access(old_exe_file);
+		exe_file_allow_write_access(old_exe_file);
 		fput(old_exe_file);
 	}
 	return 0;
-- 
2.53.0

