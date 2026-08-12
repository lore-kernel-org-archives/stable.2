Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCB0403AE0
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525923; cv=none; b=LsXiyVfFypdEX0K8an9PX0QND5dfVQ1Zl8A9du52IBY5WV6zzgEDEsb9qAS8cJg9kT++8PC3AvwPMDz6NQSIV2PCecN/AZ0N/7x+j4P7jn98DQcZYD1XWWDYb4ozTOyxBMZA5Wndt35+b+8ZBAn+Mjb2P+nrY4DfT+VaA9NmFMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525923; c=relaxed/simple;
	bh=8Xw3cdUroiIQ+pdhjNCOESaKWHE95IsmTA2Tk5TOtXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZSxMKBRXy1qFuNNHYTv+rWvWgncB9hAbHep8FsMukGnFXMT0cmrn4xo2+K1sxlzVMXMZLtvVMJpxPVe71HRWe8/lF2ZvSiREC90l6eFCE16lUNGZDF4QjmCfc+VprpvVJH1gjyvr0Kxf9xmW3PPFIFmG/eYJzcepHSwvplL0Eq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyCo9peG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyCo9peG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD751F00ACF;
	Wed, 12 Aug 2026 09:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786525921;
	bh=qwlwY4SGK2wYalmIJDt0sctBCmrHeBwXmIbRRvdvk0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nyCo9peGHnMqylRGczjNY325y9AaOwMi6eeT2AFV7bUY71QGFKK6ToodoZZkEV6Uk
	 aF/+Vde/4WWzCBnaZWZuQ9MQoZ4LmgaF0lQl2beXmo2Kn1eKfhdSannO/Uw38AwhNV
	 nT1+1ZwGXmJlCqHiGI8ela60huWXxhUcPuEFMV5s1V1GVthW2ctMuhLaVdTeipF78r
	 YhVv8NUx0xVeMqbKQaFtQNT7QGsbB3dSPzXX1IuazOx1XXPm2M12w8oRxUhXixb7Yh
	 lejymYV7gc+YMlwWQcta3RcEWb8Bh1YxI9mJziNfgsqhuFLojB6S90wUXu2De6Q2sd
	 8mYYDknzn1fCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] fs: don't block write during exec on pre-content watched files
Date: Wed, 12 Aug 2026 05:11:57 -0400
Message-ID: <20260812091158.1359537-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812091158.1359537-1-sashal@kernel.org>
References: <2026080512-populace-barterer-83d7@gregkh>
 <20260812091158.1359537-1-sashal@kernel.org>
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
index 2fa739f2f7bb8..300d372057837 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1288,7 +1288,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		}
 		reloc_func_desc = interp_load_addr;
 
-		allow_write_access(interpreter);
+		exe_file_allow_write_access(interpreter);
 		fput(interpreter);
 
 		kfree(interp_elf_ex);
@@ -1397,7 +1397,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	kfree(interp_elf_ex);
 	kfree(interp_elf_phdata);
 out_free_file:
-	allow_write_access(interpreter);
+	exe_file_allow_write_access(interpreter);
 	if (interpreter)
 		fput(interpreter);
 out_free_ph:
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index b2d3b6e43bb56..c5528cad47d44 100644
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
index a4d21a67723d7..5ad7121f0cd4e 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -937,7 +937,7 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 	    path_noexec(&file->f_path))
 		goto exit;
 
-	err = deny_write_access(file);
+	err = exe_file_deny_write_access(file);
 	if (err)
 		goto exit;
 
@@ -1520,7 +1520,7 @@ static void free_bprm(struct linux_binprm *bprm)
 		abort_creds(bprm->cred);
 	}
 	if (bprm->file) {
-		allow_write_access(bprm->file);
+		exe_file_allow_write_access(bprm->file);
 		fput(bprm->file);
 	}
 	if (bprm->executable)
@@ -1812,7 +1812,7 @@ static int exec_binprm(struct linux_binprm *bprm)
 		bprm->file = bprm->interpreter;
 		bprm->interpreter = NULL;
 
-		allow_write_access(exec);
+		exe_file_allow_write_access(exec);
 		if (unlikely(bprm->have_execfd)) {
 			if (bprm->executable) {
 				fput(exec);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c1bd804b86153..d4b0e4630e08e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3110,6 +3110,28 @@ static inline void allow_write_access(struct file *file)
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
index 63f56a292f756..ce2aae5734fee 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -576,8 +576,8 @@ static void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm)
 	 * We depend on the oldmm having properly denied write access to the
 	 * exe_file already.
 	 */
-	if (exe_file && deny_write_access(exe_file))
-		pr_warn_once("deny_write_access() failed in %s\n", __func__);
+	if (exe_file && exe_file_deny_write_access(exe_file))
+		pr_warn_once("exe_file_deny_write_access() failed in %s\n", __func__);
 }
 
 #ifdef CONFIG_MMU
@@ -1275,13 +1275,13 @@ int set_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
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
@@ -1323,7 +1323,7 @@ int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
 	}
 
 	/* set the new file, lockless */
-	ret = deny_write_access(new_exe_file);
+	ret = exe_file_deny_write_access(new_exe_file);
 	if (ret)
 		return -EACCES;
 	get_file(new_exe_file);
@@ -1335,7 +1335,7 @@ int replace_mm_exe_file(struct mm_struct *mm, struct file *new_exe_file)
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

