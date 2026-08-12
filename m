Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5A822ACFA
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 00:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493391; cv=none; b=Xjw5JiMAwnXW4dXEtVeik3szjMdPaVYCCR6ZQDb1OMAKafVx1G/LSxAcOW2C2VyD8icUv/FhcZmTd8Q8BYOApQGqivc9gBMZlQZfjmOlUK0WCSxZlbb3zY5UQmAsg0CW/iydVzmvV/RZlE7vsW7ag5RGSfC5j5Hsui7BxCfVVOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493391; c=relaxed/simple;
	bh=RXodXjOuvPxRPPb09XiMQsIDW6NVOB/4eG0I1da/6H4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPqYMlOeSuak9YtVSEB3QZSGyi/q8J6+7Gsxl+UORmNMfR5AR5cL9um+Npa8A1mg8ewXwC/JIyo2Jkc6GKTkqo5v1VEkBHOwJHLA8//rUbrYFTWjgugzNxLlsj+oAuCGOS+rfDzN5lqgNCI7Q4vnxPh5vsn+fQPHGQNXyB7ATMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXbUzOCf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXbUzOCf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE5A1F00A3D;
	Wed, 12 Aug 2026 00:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786493390;
	bh=S6mXTXJlMrew1U4xBIHt2NKPxe6X+B0kioQ0mIpsjFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZXbUzOCfAFsaleUSoCkbkotqhLshhWfTfgZfmAPmo5JgmIQSFAuoThHK7QJmwzODw
	 +C//aJk3OeQyCzjlXOSBEHtQpk5SsJLFuvpIHBmPFYBZQ6JMcXkl+KVaJ48scoIFqE
	 NpdsVJ+mXs/LkbQ74kk5Qhu3XEGlwPrjvq+2oESwN1r3gdOQG0ctz2XszlP1qKGXY4
	 nhojro+EFvgvc78+GVa53KzL4k/NnunpFR0GJ+flP7ozvPzBmccu0JU1kauVSoYP7t
	 ncroUOu5eThHZTyiiHVnQNqdCynrKou1gkKdDbPiRHHqFjJa3uw3PQrn4MG1/+iGTj
	 4fTHS6MhQv6Hg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] fs: don't block write during exec on pre-content watched files
Date: Tue, 11 Aug 2026 20:09:46 -0400
Message-ID: <20260812000947.4159385-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080511-errant-musky-ca70@gregkh>
References: <2026080511-errant-musky-ca70@gregkh>
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
 include/linux/fs.h    | 12 ++++++++++++
 kernel/fork.c         | 12 ++++++------
 5 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index e4348dd76658e..0fbf5474b8fe1 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1287,7 +1287,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		}
 		reloc_func_desc = interp_load_addr;
 
-		allow_write_access(interpreter);
+		exe_file_allow_write_access(interpreter);
 		fput(interpreter);
 
 		kfree(interp_elf_ex);
@@ -1396,7 +1396,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	kfree(interp_elf_ex);
 	kfree(interp_elf_phdata);
 out_free_file:
-	allow_write_access(interpreter);
+	exe_file_allow_write_access(interpreter);
 	if (interpreter)
 		fput(interpreter);
 out_free_ph:
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index d872ccb5f4b2d..70b8a987de223 100644
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
index 9d3e2eda9d55e..359158943746b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -935,7 +935,7 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 	    path_noexec(&file->f_path))
 		goto exit;
 
-	err = deny_write_access(file);
+	err = exe_file_deny_write_access(file);
 	if (err)
 		goto exit;
 
@@ -1521,7 +1521,7 @@ static void free_bprm(struct linux_binprm *bprm)
 		abort_creds(bprm->cred);
 	}
 	if (bprm->file) {
-		allow_write_access(bprm->file);
+		exe_file_allow_write_access(bprm->file);
 		fput(bprm->file);
 	}
 	if (bprm->executable)
@@ -1824,7 +1824,7 @@ static int exec_binprm(struct linux_binprm *bprm)
 		bprm->file = bprm->interpreter;
 		bprm->interpreter = NULL;
 
-		allow_write_access(exec);
+		exe_file_allow_write_access(exec);
 		if (unlikely(bprm->have_execfd)) {
 			if (bprm->executable) {
 				fput(exec);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e6b2e2749e379..12ea9af49a89a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2824,6 +2824,18 @@ static inline void allow_write_access(struct file *file)
 	if (file)
 		atomic_inc(&file_inode(file)->i_writecount);
 }
+
+static inline int exe_file_deny_write_access(struct file *exe_file)
+{
+	return deny_write_access(exe_file);
+}
+static inline void exe_file_allow_write_access(struct file *exe_file)
+{
+	if (unlikely(!exe_file))
+		return;
+	allow_write_access(exe_file);
+}
+
 static inline bool inode_is_open_for_write(const struct inode *inode)
 {
 	return atomic_read(&inode->i_writecount) > 0;
diff --git a/kernel/fork.c b/kernel/fork.c
index 36854aaec482d..73e8a6b430a05 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -640,8 +640,8 @@ static void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm)
 	 * We depend on the oldmm having properly denied write access to the
 	 * exe_file already.
 	 */
-	if (exe_file && deny_write_access(exe_file))
-		pr_warn_once("deny_write_access() failed in %s\n", __func__);
+	if (exe_file && exe_file_deny_write_access(exe_file))
+		pr_warn_once("exe_file_deny_write_access() failed in %s\n", __func__);
 }
 
 #ifdef CONFIG_MMU
@@ -1431,13 +1431,13 @@ int set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
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
@@ -1476,7 +1476,7 @@ int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 			return ret;
 	}
 
-	ret = deny_write_access(new_exe_file);
+	ret = exe_file_deny_write_access(new_exe_file);
 	if (ret)
 		return -EACCES;
 	get_file(new_exe_file);
@@ -1488,7 +1488,7 @@ int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 	mmap_write_unlock(mm);
 
 	if (old_exe_file) {
-		allow_write_access(old_exe_file);
+		exe_file_allow_write_access(old_exe_file);
 		fput(old_exe_file);
 	}
 	return 0;
-- 
2.53.0

