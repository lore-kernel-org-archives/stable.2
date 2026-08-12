Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3E540099B
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 12:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786536147; cv=none; b=ieAZYBdvzpZmuWcGa7uaoVhGSIEhjM5egUvtH3gOpDRn+FSKyGaLYWRBoCXi7fHF1AooDamqcrsthxvt9ATwBqnJflQhmwnu18oGHAea4ULz9wZESRuG+9NvV6cY1vKJolgm7LV0CaerVgUM9zuom+xyj5piCpaZ6EWw8XXfwNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786536147; c=relaxed/simple;
	bh=1a09TessPMatYysweUaOzpTzSwdL0Ypy5gk2IJ89Q5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=udgVuvM+uWnO/J48mWscXgyQGXkrGvfVsId8C1auAqYfUbHKKVk8PlhwrjSF86VSvSu+jsweszW0pKufo28SlRtmS3qXL/4a+gcKrNj3z8/+dD6dKe0aJAKx17rJYCLYSgjJWnx8glNIPps/7k4a2J5gBfx8jnWLOZJsGKsRtUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3sEnMh0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3sEnMh0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207031F00A3D;
	Wed, 12 Aug 2026 12:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786536145;
	bh=IomevWr0C0VZUMLUdnQ7jYyU/5OISZamKQxoU5eKr1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D3sEnMh0Fm6Je/q7aXmuUFafqt/xFL8O1ixmQ7+KZSFmxcTFyvfZv2UJ0AS2l83iQ
	 U6frVMnpFJyZEanxwGPonUDYZyyeULJyHHXHaHHdgZgwPbU7FrsyYj5krKkrvLzucD
	 Rpna576++8nEV5JHsZTEd6Q/KwXYjmWFn6zHjEbxbw+zfJEoqRmavoI3GmhEhiQwJ8
	 nUxNCNzyFi35c/dA36rp+EQxxJm5+qYVAiiF2njGp32FXzzSsbvxSQ7zmoRRd1m2rS
	 wT62rjYrovxZBbNN0gmRu53kpBbq1fbwdsXCYPSZt1d0LHvHwGWIg+5/1oitDqdxXP
	 fFvv6ALGMSvmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] fs: don't block write during exec on pre-content watched files
Date: Wed, 12 Aug 2026 08:02:21 -0400
Message-ID: <20260812120222.1989615-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812120222.1989615-1-sashal@kernel.org>
References: <2026080513-stubbed-clear-8ac9@gregkh>
 <20260812120222.1989615-1-sashal@kernel.org>
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
 4 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 11dc833ca2c49..ba1031433165e 100644
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
index a3bf15dafab79..55a11b082ff81 100644
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
index 2979b458b650a..f6b9c243d9025 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -929,7 +929,7 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 	    path_noexec(&file->f_path))
 		goto exit;
 
-	err = deny_write_access(file);
+	err = exe_file_deny_write_access(file);
 	if (err)
 		goto exit;
 
@@ -1485,7 +1485,7 @@ static void free_bprm(struct linux_binprm *bprm)
 		abort_creds(bprm->cred);
 	}
 	if (bprm->file) {
-		allow_write_access(bprm->file);
+		exe_file_allow_write_access(bprm->file);
 		fput(bprm->file);
 	}
 	if (bprm->executable)
@@ -1773,7 +1773,7 @@ static int exec_binprm(struct linux_binprm *bprm)
 		bprm->file = bprm->interpreter;
 		bprm->interpreter = NULL;
 
-		allow_write_access(exec);
+		exe_file_allow_write_access(exec);
 		if (unlikely(bprm->have_execfd)) {
 			if (bprm->executable) {
 				fput(exec);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3134c21d8bab0..5417515c41119 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2987,6 +2987,28 @@ static inline void allow_write_access(struct file *file)
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
-- 
2.53.0

