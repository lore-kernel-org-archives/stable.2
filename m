Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E793A41A502
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528262; cv=none; b=ol1NSGTLvjYpENa/H0eRAw4rkZfCG4aBrbFzFT6EyxWSkM0sbhjKO0Uiwmc1jekeicKjCc4Gs8xVNM16cR9f70PaFX/oxUaNmyQfMV0a/KlyoiiRy49fwHFc8NfYrrpUHKpW9gUVzWucUARN66EYaK9ptYh0LmAqbdZdWANowNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528262; c=relaxed/simple;
	bh=GyE1sQ5Zyydl3WJwjNkoGlVvpE5UBJT7CfCteQJ4OJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CB/aFC/J32E8uVdnAfFrKY+fJsjt0EX47dlrAEyFhBCGBFU9kgGim+L90I+X2nsXXM8GJ2OZE6y6mkQSdkkIRivodmkvZxQ5asjKBYGRAHM0bgd5ixWCk456dtfpEUfNFHs7r7P6Rc8syNN+0wNFNuzX2bZ9mO3jR3SOpKP7uTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cEpc1GwM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cEpc1GwM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E92B1F00A3D;
	Wed, 12 Aug 2026 09:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786528260;
	bh=4XjUF8tojY4kzldcdcct9y3Gb4BQQeTjpKhujvHDyPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cEpc1GwM8bnNYRgLDwECiehz3hLvGyIX6LvHcji4mFM68cTHmy612wCsiL+eh1hfq
	 cRchZF8OnpEKsJ6o9ibcwAy02ueZG9f79WhxOlbrFvJuKrI57jzOJUAcqD8kPRnpv0
	 Y/e3/OnLLJVBo22qLszNGEwCzQmk3IjdqxqJR5kL7EK4LuihMvC3W+5wBZDsF143jw
	 kNI/tQOGmOqDLOJg6b7HP2lQ+vY2gMwNYLisCi5ddi+xs10MOiJxBiAXNvgJUacFYP
	 4WRxNNy9hUaLY57/C2C9XzC2LLFMUiqgovzFtW8FfI74Z7tR4il1WLHnzFYb1LbVO/
	 MKS0Cww1afCDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] fs: don't block write during exec on pre-content watched files
Date: Wed, 12 Aug 2026 05:50:56 -0400
Message-ID: <20260812095057.1573629-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812095057.1573629-1-sashal@kernel.org>
References: <2026080512-motto-postwar-7c00@gregkh>
 <20260812095057.1573629-1-sashal@kernel.org>
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
 fs/exec.c             |  6 +++---
 include/linux/fs.h    | 22 ++++++++++++++++++++++
 kernel/fork.c         | 12 ++++++------
 5 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 30379c33ad20c..aa9f6365566e6 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1243,7 +1243,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		}
 		reloc_func_desc = interp_load_addr;
 
-		allow_write_access(interpreter);
+		exe_file_allow_write_access(interpreter);
 		fput(interpreter);
 
 		kfree(interp_elf_ex);
@@ -1332,7 +1332,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	kfree(interp_elf_ex);
 	kfree(interp_elf_phdata);
 out_free_file:
-	allow_write_access(interpreter);
+	exe_file_allow_write_access(interpreter);
 	if (interpreter)
 		fput(interpreter);
 out_free_ph:
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index a7084a720b28c..98f254c79f251 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -394,7 +394,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 			goto error;
 		}
 
-		allow_write_access(interpreter);
+		exe_file_allow_write_access(interpreter);
 		fput(interpreter);
 		interpreter = NULL;
 	}
@@ -467,7 +467,7 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 
 error:
 	if (interpreter) {
-		allow_write_access(interpreter);
+		exe_file_allow_write_access(interpreter);
 		fput(interpreter);
 	}
 	kfree(interpreter_name);
diff --git a/fs/exec.c b/fs/exec.c
index 4d5defc2966bd..6b6f71129ee99 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -929,7 +929,7 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 	    path_noexec(&file->f_path))
 		goto exit;
 
-	err = deny_write_access(file);
+	err = exe_file_deny_write_access(file);
 	if (err)
 		goto exit;
 
@@ -1499,7 +1499,7 @@ static void free_bprm(struct linux_binprm *bprm)
 		abort_creds(bprm->cred);
 	}
 	if (bprm->file) {
-		allow_write_access(bprm->file);
+		exe_file_allow_write_access(bprm->file);
 		fput(bprm->file);
 	}
 	if (bprm->executable)
@@ -1790,7 +1790,7 @@ static int exec_binprm(struct linux_binprm *bprm)
 		bprm->file = bprm->interpreter;
 		bprm->interpreter = NULL;
 
-		allow_write_access(exec);
+		exe_file_allow_write_access(exec);
 		if (unlikely(bprm->have_execfd)) {
 			if (bprm->executable) {
 				fput(exec);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3df19401beb61..684a010829e00 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3138,6 +3138,28 @@ static inline void allow_write_access(struct file *file)
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
index f55be5303dc7a..d1557e5a4c1df 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -487,8 +487,8 @@ static void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm)
 	 * We depend on the oldmm having properly denied write access to the
 	 * exe_file already.
 	 */
-	if (exe_file && deny_write_access(exe_file))
-		pr_warn_once("deny_write_access() failed in %s\n", __func__);
+	if (exe_file && exe_file_deny_write_access(exe_file))
+		pr_warn_once("exe_file_deny_write_access() failed in %s\n", __func__);
 }
 
 #ifdef CONFIG_MMU
@@ -1196,13 +1196,13 @@ int set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
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
@@ -1241,7 +1241,7 @@ int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 	}
 
 	/* set the new file, lockless */
-	ret = deny_write_access(new_exe_file);
+	ret = exe_file_deny_write_access(new_exe_file);
 	if (ret)
 		return -EACCES;
 	get_file(new_exe_file);
@@ -1253,7 +1253,7 @@ int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 		 * write access while someone might open the file writable.
 		 */
 		mmap_read_lock(mm);
-		allow_write_access(old_exe_file);
+		exe_file_allow_write_access(old_exe_file);
 		fput(old_exe_file);
 		mmap_read_unlock(mm);
 	}
-- 
2.53.0

