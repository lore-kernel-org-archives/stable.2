Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561205;
	b=4mxotfQ5cQmHH4GCFveErEYSgSS0wFD6/iY/dcNpyd7bOsGcchcv/WL7WKajl86Mxn7R
	 E3Gg7HRwJi21xvW/5NvY12NOdXyg2zihOjJIqjNVEL6sLpZE/dqF7AfcWhryJkYP6S4JO
	 atXFKbfy/e4Gdd4TCR//aNt8AMCTRTPXolis9cYiIKxFK8PbVRr025l+zOJmeqjU6Nnkw
	 eqrJVb7D6nr5BmkPh6JL1wOXMv+0R3rnnJk3deoV6VB2s7HZjJ7PIbWDHh+S2Q01cpnsj
	 BHgnPPl/+eWAe/mEveyK/YV5EU9aJYqTDHhkaH/4NAftM/krzzl4h1WZDiG91F7A2MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561205;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=F5doYQdvM7x6zP0318TAtNMatVTO+WEyVEwtQ807FWs=;
	b=O2iehlRclt2s0KE/RnvZsfaEGIeExQ5Fv/q5YrjwP1oB1i2EqN1kMRerY+jDXLpYMQhL
	 uZrcrmu4nGAKIFcmdqR//ju+Qyner0gePnqjNuODI5GoIX5VEFhYnmVXn59LPODGSjF05
	 3c9s9GBQGhgDhevigQrWwHJglSNQZZeonCHRw2MVbgv5ZZpOW/5epabPnw04dMkM0tmnr
	 B40EnRN0jSaUeB+weuyaMkvlsQ1c9dkgHFstsGek4NJ7s0z8pRIFXDytUBJ5b/mn9akVS
	 iAqFLOQ/26dA4pfq7zlohv7osNmmeRP2q+buovAWcwqGWV88/35PeYWHfHDhQha40vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fgRqWS/R";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E798606A332;
	Tue, 24 Nov 2026 23:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fgRqWS/R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAAF1F000D1;
	Tue, 24 Nov 2026 23:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795561204;
	bh=F5doYQdvM7x6zP0318TAtNMatVTO+WEyVEwtQ807FWs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fgRqWS/RyLrns3jN+wA/5OmKRdxgLSO3trncjc81KZ5ov18DCGO98Gs9axvycn2XS
	 4Y0ol1aKXkDKgt3J/KhdMPy31sSwTsXcl33oag/r/+GdA8f5Jix+7JIupGapnlv4Ce
	 cAYkQJ73iqp+0kXuQTnM27EDLHd6zSoM+touSDWMc/UE3zmt/baERD5l6gqdET8/ur
	 ZsccUsFE81VBgHVfU7ohhhVHne4JCKo4jxS4gp/n0pQBf6ew3qbf1sg2M/EmK4WhS2
	 ZJ82d9RVuRfe51EeazEm6ep9EubANzsp4a43lSQJvVushzvGFleTUvRRyvCQOyP5DX
	 VfvKGq2XH6mdw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Nov 2026 23:58:32 +0100
Subject: [PATCH RFC 09/19] lsm: add security_bprm_revalidate_files()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-work-exec-update_lock-v1-9-e489035395b8@kernel.org>
References: <20261124-work-exec-update_lock-v1-0-e489035395b8@kernel.org>
In-Reply-To: <20261124-work-exec-update_lock-v1-0-e489035395b8@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-fsdevel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, 
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
 selinux@vger.kernel.org, Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
 linux-security-module@vger.kernel.org, apparmor@lists.ubuntu.com, 
 David Hildenbrand <david@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=6414; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WEDmOf8hqdpHNRkJ7SSWpynxC2G5RY7nFMnrQtHIpLs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSziR249U4yTquddcPpvToOl4PWfgg9WeSbt7to5T2rf
 W+izM6s7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjINX5Gho6qqM/Xz/XM7lJZ
 03p/ZbXLnNe+/Px8hk/PbLOROTPBToGRYUFB6aMn0vt49zC0aqSf+MVkJbJy98dmrfXPLq2rM3X
 2YwcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

SELinux and AppArmor revalidate the controlling terminal and the
inherited files during exec when the security context changes. Files
the new credentials aren't allowed to use are replaced with the null
device or closed and a controlling terminal they aren't allowed to use
is dropped. Currently, they do this from the bprm_committing_creds hook
which begin_new_exec() calls with exec_update_lock held.

Closing a file calls into the filesystem's ->flush() method and that may
block for a long time. For the same reason commit e780259b54e6 ("exec:
do_close_on_exec() before taking exec_update_lock") moved the closing of
close-on-exec files in front of exec_update_lock.

Add a new hook that is called right after the close-on-exec files have
been closed. At that point we're past the point of no return, all other
threads are gone and the file descriptor table isn't shared anymore. So
nobody but the task itself can install new files or acquire a new
controlling terminal until the new credentials are committed. And
nothing between the new hook and the bprm_committing_creds hook touches
the file descriptor table.

The hook has no users yet. SELinux and AppArmor are switched over
separately. Note that bpf lsm programs can attach to it like to any
other LSM hook.

Fixes: 6650527444da ("proc: protect ptrace_may_access() with exec_update_lock (part 1)")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/exec.c                     |  3 +++
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  5 +++++
 security/security.c           | 27 ++++++++++++++++++++++++---
 4 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 87b78fce609de..855437c352137 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1203,6 +1203,9 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 */
 	close_cloexec_files(me->files);
 
+	/* Let LSMs revoke inherited files the new creds may not use. */
+	security_bprm_revalidate_files(bprm);
+
 	/*
 	 * Must be called _before_ exec_mmap() as bprm->mm is
 	 * not visible until then. Doing it here also ensures
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 87d9d06710cb2..c1bb7501d530d 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -52,6 +52,7 @@ LSM_HOOK(int, 0, vm_enough_memory, struct mm_struct *mm, long pages)
 LSM_HOOK(int, 0, bprm_creds_for_exec, struct linux_binprm *bprm)
 LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_binprm *bprm, const struct file *file)
 LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
+LSM_HOOK(void, LSM_RET_VOID, bprm_revalidate_files, const struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, const struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, const struct linux_binprm *bprm)
 LSM_HOOK(int, 0, fs_context_submount, struct fs_context *fc, struct super_block *reference)
diff --git a/include/linux/security.h b/include/linux/security.h
index 40831fab54709..e1a85b2f7005e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -360,6 +360,7 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages);
 int security_bprm_creds_for_exec(struct linux_binprm *bprm);
 int security_bprm_creds_from_file(struct linux_binprm *bprm, const struct file *file);
 int security_bprm_check(struct linux_binprm *bprm);
+void security_bprm_revalidate_files(const struct linux_binprm *bprm);
 void security_bprm_committing_creds(const struct linux_binprm *bprm);
 void security_bprm_committed_creds(const struct linux_binprm *bprm);
 int security_fs_context_submount(struct fs_context *fc, struct super_block *reference);
@@ -753,6 +754,10 @@ static inline int security_bprm_check(struct linux_binprm *bprm)
 	return 0;
 }
 
+static inline void security_bprm_revalidate_files(const struct linux_binprm *bprm)
+{
+}
+
 static inline void security_bprm_committing_creds(const struct linux_binprm *bprm)
 {
 }
diff --git a/security/security.c b/security/security.c
index 4727b8347fc4e..f340880ce77ff 100644
--- a/security/security.c
+++ b/security/security.c
@@ -834,6 +834,25 @@ int security_bprm_check(struct linux_binprm *bprm)
 	return call_int_hook(bprm_check_security, bprm);
 }
 
+/**
+ * security_bprm_revalidate_files() - Revalidate open files during exec()
+ * @bprm: binary program information
+ *
+ * Revalidate access to the controlling tty and the open file descriptors of a
+ * process being transformed by an execve operation, based on the old
+ * credentials pointed to by @current->cred and the information set in
+ * @bprm->cred by the bprm_creds_for_exec hook.  Files to which access will no
+ * longer be granted may be closed or replaced.  @bprm points to the
+ * linux_binprm structure.  This is called after the point of no return, once
+ * the file descriptor table has been unshared and close-on-exec files have been
+ * closed, but before exec_update_lock is taken, as closing a file may block in
+ * the filesystem.
+ */
+void security_bprm_revalidate_files(const struct linux_binprm *bprm)
+{
+	call_void_hook(bprm_revalidate_files, bprm);
+}
+
 /**
  * security_bprm_committing_creds() - Install creds for a process during exec()
  * @bprm: binary program information
@@ -842,9 +861,11 @@ int security_bprm_check(struct linux_binprm *bprm)
  * transformed by an execve operation, based on the old credentials pointed to
  * by @current->cred and the information set in @bprm->cred by the
  * bprm_creds_for_exec hook.  @bprm points to the linux_binprm structure.  This
- * hook is a good place to perform state changes on the process such as closing
- * open file descriptors to which access will no longer be granted when the
- * attributes are changed.  This is called immediately before commit_creds().
+ * hook is a good place to perform state changes on the process such as
+ * resetting resource limits.  It is called with exec_update_lock held so it
+ * should not block on a filesystem.  In particular, it must not close files.
+ * Use the bprm_revalidate_files hook for that.  This is called immediately
+ * before commit_creds().
  */
 void security_bprm_committing_creds(const struct linux_binprm *bprm)
 {

-- 
2.53.0

