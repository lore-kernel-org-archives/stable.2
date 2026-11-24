Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561216;
	b=HmRaPOrM0+LpTPXs3PEGXNd8T9RQIzDsNHluw487Ln55ocwYKJp3dGJ3zxelh4PZCSfs
	 rwvNof58BAZtIztkm1om6JWtM1HOyR5XJj1mjhYS5xt0lTRREvPmIPIlzgmUPZuv+ghI4
	 lNIMJMO0SV5TDEPEzot6vuY0IAMtt71vRC/oP6psh9wOI4SbwmsXY0CCTIP1gZpgMJcVd
	 IDGiaVZFU5znblNwa86gAHJZpVZh7fvB9s8AmIG1IorRn7PwWZVY/WhtrKI6+4xEXyCHv
	 FzXJvVyZUM30UiHpVC5CdjensPZKIvj79wI6E616afJCKzLdzpxbXe4v5THqqI+7xsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561216;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Inv/5JWsEP4k2v6xGmPklM2ArEUXCVNMCujFrTY3N8M=;
	b=k3Ks5jRJmpI+Msj2Lx/5iYRI00YbogoduAboUsg0mRZnt8sluGX5ws19PQlHE9IBUQ+2
	 MJlIsRKGmCErTqfQlBR8Yf7P6O/1uwBn3QhDQ9ekisMdVbU6k4pHkA1koYOYfhYiaBnwB
	 ryDQKG8EZFVbPMqmEJ5/IU4hi1Ya+z7z2zRMGZJYdIROwydquCBf+hx3AOiBCc/0tJ9xm
	 HjlLlA7pmvwVujqAqwBwe8q+ZuGDvXeSgKLWNoY3b+TbAA1tk7TRPAXqIwL1lrGrxnRvi
	 jd8co+YDU9/T62xnJL1q0mXq7EBpe19lF016oSZHpU749n40buOjSTDkj1nsZPTzH0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eQEsgeQl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2D5606A329;
	Tue, 24 Nov 2026 23:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eQEsgeQl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196D11F000CF;
	Tue, 24 Nov 2026 23:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795561216;
	bh=Inv/5JWsEP4k2v6xGmPklM2ArEUXCVNMCujFrTY3N8M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eQEsgeQlOdwurtJVQEblk2buji2Jm+OMq6monolWC6s/2fqcP1WFzzvIzBbprfybF
	 BZbaVwcVpZfRPZ9366EmgON5grVifrWvix+FOvzNMnGwVzVXJevc6M5lE/lARWHVYd
	 ctZq/bxTH1PvbstQDf0+YGzo6O9YojErOnTA3Kwta/W0sr3gcfyW0rt4WEDHMYw8jI
	 V/hiSYb1CYMmJbZU4I9FfbVU9MymXCpv7xyPCWgvluQq7lhU2nxilpkQkz4L1KtMuL
	 cb3T876CnjPNvBZhzBVnSyb3JuJKO9l8lVXuD/0aFJVEPprsiORY0u0HFi5MQbqrSa
	 sciFjGNhlNhEA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Nov 2026 23:58:35 +0100
Subject: [PATCH RFC 12/19] apparmor: revalidate inherited files before
 taking exec_update_lock
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
Message-Id: <20261124-work-exec-update_lock-v1-12-e489035395b8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4840; i=brauner@kernel.org;
 h=from:subject:message-id; bh=uBNxf3lHU7b7V8ajO52LXjgXzg1M50Ep3+2UIaiyZ1U=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSziR1+vjCC800t147wFavdHucENbUZ2qiuKS2y6zxwQ
 p/l0qdfHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZu5Thn76K1E3B/prz63pt
 LCd5lF8wPzVR3Uma+ehm64k/V0z9PYmR4ebvb/e+eR9Yr8fjYfGvsDIiegl7Tw1X25f9bncb9zP
 q8AAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

When an exec changes the profile aa_inherit_files() revalidates the
controlling terminal and the inherited files against the new label.
Everything the new label isn't allowed to use is taken away from the
task. This is done from apparmor_bprm_committing_creds() which runs with
exec_update_lock held for writing.

Taking a file away closes it and so calls its ->flush() method which can
block waiting on the filesystem. So a hung filesystem blocks everyone
who needs the exec_update_lock of that task. And a FUSE server that
looks at the task it serves the flush request for deadlocks:

  exec                                 FUSE server
  begin_new_exec()
    exec_mmap()
      down_write(exec_update_lock)
    security_bprm_committing_creds()
      aa_inherit_files()
        replace_fd()
          filp_close()
            fuse_flush()
                                       do_task_stat()
                                         down_read(exec_update_lock)

With a FUSE server that reads /proc/<pid>/stat of the task that sent the
flush request the exec hangs until the server is killed:

  task:aa-target       state:S pid:98
  Call Trace:
   __schedule+0x53e/0x13f0
   schedule+0x36/0x100
   request_wait_answer+0x1a9/0x320
   fuse_chan_send+0x110/0x250
   fuse_flush+0x1af/0x1f0
   filp_flush+0x33/0x90
   filp_close+0x12/0x30
   aa_inherit_files+0x191/0x2a0
   apparmor_bprm_committing_creds+0x61/0x90
   security_bprm_committing_creds+0x19/0x30
   begin_new_exec+0x6dc/0xf90
   load_elf_binary+0x12a/0x1990
   bprm_execve+0x39d/0x870
   do_execveat_common.isra.0+0x165/0x180
   __x64_sys_execve+0x38/0x50
   do_syscall_64+0x110/0x600
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  task:aa-fuse         state:D pid:97
  Call Trace:
   __schedule+0x53e/0x13f0
   schedule+0x36/0x100
   schedule_preempt_disabled+0x11/0x20
   rwsem_down_read_slowpath+0x186/0x5f0
   down_read_killable+0x78/0x1b0
   do_task_stat+0x87/0x10c0
   proc_single_show+0x67/0xe0
   seq_read_iter+0x11c/0x480
   seq_read+0x127/0x1c0
   vfs_read+0xd8/0x4a0
   ksys_read+0x7c/0x110
   do_syscall_64+0x110/0x600
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

The flush is a forced request so the exec can't even be killed while it
waits for the reply.

This is the same problem that commit e780259b54e6 ("exec:
do_close_on_exec() before taking exec_update_lock") fixed for
close-on-exec files.

Fix this by moving the revalidation into the new bprm_revalidate_files
hook which is called before exec_update_lock is taken.

Fixes: 6650527444da ("proc: protect ptrace_may_access() with exec_update_lock (part 1)")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 security/apparmor/lsm.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index eaebc3c60c5af..e40619b0f4ba9 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -951,10 +951,13 @@ static int apparmor_setprocattr(const char *name, void *value,
 }
 
 /**
- * apparmor_bprm_committing_creds - do task cleanup on committing new creds
+ * apparmor_bprm_revalidate_files - revalidate inherited files on exec
  * @bprm: binprm for the exec  (NOT NULL)
+ *
+ * Called before exec_update_lock is taken as closing files may block in
+ * the filesystem.
  */
-static void apparmor_bprm_committing_creds(const struct linux_binprm *bprm)
+static void apparmor_bprm_revalidate_files(const struct linux_binprm *bprm)
 {
 	struct aa_label *label = aa_current_raw_label();
 	struct aa_label *new_label = cred_label(bprm->cred);
@@ -965,6 +968,21 @@ static void apparmor_bprm_committing_creds(const struct linux_binprm *bprm)
 		return;
 
 	aa_inherit_files(bprm->cred, current->files);
+}
+
+/**
+ * apparmor_bprm_committing_creds - do task cleanup on committing new creds
+ * @bprm: binprm for the exec  (NOT NULL)
+ */
+static void apparmor_bprm_committing_creds(const struct linux_binprm *bprm)
+{
+	struct aa_label *label = aa_current_raw_label();
+	struct aa_label *new_label = cred_label(bprm->cred);
+
+	/* bail out if unconfined or not changing profile */
+	if ((new_label->proxy == label->proxy) ||
+	    (unconfined(new_label)))
+		return;
 
 	current->pdeath_signal = 0;
 
@@ -1860,6 +1878,7 @@ static struct security_hook_list apparmor_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(cred_transfer, apparmor_cred_transfer),
 
 	LSM_HOOK_INIT(bprm_creds_for_exec, apparmor_bprm_creds_for_exec),
+	LSM_HOOK_INIT(bprm_revalidate_files, apparmor_bprm_revalidate_files),
 	LSM_HOOK_INIT(bprm_committing_creds, apparmor_bprm_committing_creds),
 	LSM_HOOK_INIT(bprm_committed_creds, apparmor_bprm_committed_creds),
 

-- 
2.53.0

