Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561213;
	b=dBOnPkJ64HlXleNM1m7Qk54l+vr+lmPIX8Pkf+Aj9RE68gGX3pb0b4Ow6QKM0uh7tc80
	 C7CPrvpEIiz05BRAIXJWFV9HkFbPmI5KXmQOYgw+W7DjHtDXjPZnHVZk2vQGbo2lq4P6o
	 cZ5PgbIGSlFzAmP2uf5hktWyNq2mnyfm4pBR6sGkUuShX+Woo9M8Gx616fci2UafE63YJ
	 qnG9P+jHIdD8ln+Ug77zm/LBZC9t7fDPnW6jlsg06Qjw1Xl/axaBz9b+UcMj8rJ4p5/Gg
	 fpvCfr7ACD6h0apmOY3ug/5t+azzbx5VjDHjUaMpUUPLJdcZaVhhHtLb1GGc4OMC3ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561213;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=kG9Qh13joT/rVCnoPcocJxtcYRE0b9tjEwh3hGBMBRQ=;
	b=JJyYG0Zfy0YYiE2lZhWrmhmOYBsLvv6PjdE6inBLy/A/Ek6lsbRyVGgcUkQ3yRbkzJnp
	 ME4BcALrXWC7CSHlHxwJ7qfR5U1rvgZ/GiakrQE31OES480qJkPAL+TIrA+wNj8RqY1qg
	 m4mX+K1Uf05ijIBxpeFiwfpTgcWApAU3XPCr0UPlxBXHiQawQ+dtkQw2Tv8LJFki9Dq2w
	 MEJRhdIFKo0ZHIYsokrJLZLxqVUnmmDZk6DYvgGPYqqEn/I5Ap4iwIGWsca8xg5c37/gS
	 dSgN7ihqDtvZb/G0JOedDFbJoHej3g4EiNpkCdLPT+k9W7bSvZqge4ea1cb87nkdGLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SSVRCz46;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02917606A336;
	Tue, 24 Nov 2026 23:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SSVRCz46
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149CA1F00AE3;
	Tue, 24 Nov 2026 23:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795561211;
	bh=kG9Qh13joT/rVCnoPcocJxtcYRE0b9tjEwh3hGBMBRQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SSVRCz46ehCh55Kj4DqnxRYUuOiDxe0mjpCZdwE6ZHxs3DLXenc1NI7Cq8lulVJDO
	 i6XAwipYoR4lcEd+4h2gBJ5KS/J8yNW2M/yo4zqHTspksPgKgXy9k3E07WIyG5S59L
	 FWIn8gyYfZKMc8y0pBBaZeeEd6FtVUYEjGp5I2W4LbZYpz7K5RODom8YqpfiyuXwik
	 0ojvkZNBtOUaFSk5wm4RBKo/2gk2QYDvoq41zL4b+eOe5WodKuEUp/B2mf3otFzaNg
	 g/NpyMEP1o6dhODIfOaxkHZqVCSL5X/iwo6yQRUh6wddQsuBJpFvdDikPa5vIere4B
	 rx6X7SrEIjLQQ==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Nov 2026 23:58:34 +0100
Subject: [PATCH RFC 11/19] selinux: revalidate inherited files before
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
Message-Id: <20261124-work-exec-update_lock-v1-11-e489035395b8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4552; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qkAv1M929y64I19wC8Cu8ZECHEnR673EN13elCJRS20=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSziR0q+nvvr9oF1h5306fr+5I0luzUbvljePvsvK9Tp
 JJ/eord6ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIGQ9Ght/sOT0ftvlf9Q4Q
 VNBxjA66dco+PV7jNFfCvL0nfRb/y2D4K9Tz5uv292sPGScXfpxa3leaeDlEZsXBpzfclq7KXzG
 rjAUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

When an exec transitions to a new SID flush_unauthorized_files()
revalidates the controlling terminal and the inherited files against the
new SID. Files the new SID isn't allowed to use are replaced with the
null device. This is done from selinux_bprm_committing_creds() which
runs with exec_update_lock held for writing.

Replacing a file closes the old one and so calls its ->flush() method
which can block waiting on the filesystem. So a hung filesystem blocks
everyone who needs the exec_update_lock of that task. And a FUSE server
that looks at the task it serves the flush request for deadlocks:

  exec                                 FUSE server
  begin_new_exec()
    exec_mmap()
      down_write(exec_update_lock)
    security_bprm_committing_creds()
      flush_unauthorized_files()
        replace_fd()
          filp_close()
            fuse_flush()
                                       do_task_stat()
                                         down_read(exec_update_lock)

With a FUSE server that reads /proc/<pid>/stat of the task that sent the
flush request the exec hangs until the server is killed:

  task:se-target       state:S pid:143
  Call Trace:
   __schedule+0x53e/0x13f0
   schedule+0x36/0x100
   request_wait_answer+0x1a9/0x320
   fuse_chan_send+0x110/0x250
   fuse_flush+0x1af/0x1f0
   filp_flush+0x33/0x90
   filp_close+0x12/0x30
   do_dup2+0xbf/0x1b0
   replace_fd+0x7e/0xd0
   selinux_bprm_committing_creds+0x1a7/0x2d0
   security_bprm_committing_creds+0x1e/0x30
   begin_new_exec+0x6dc/0xf90
   load_elf_binary+0x12a/0x1990
   bprm_execve+0x39d/0x870
   do_execveat_common.isra.0+0x165/0x180
   __x64_sys_execve+0x38/0x50
   do_syscall_64+0x110/0x600
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  task:se-fuse         state:D pid:142
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
 security/selinux/hooks.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 4ec9ec723cacc..71ea94f663772 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2529,6 +2529,20 @@ static inline void flush_unauthorized_files(const struct cred *cred,
 		fput(devnull);
 }
 
+/*
+ * Close files for which the new task SID is not authorized. Called before
+ * exec_update_lock is taken as closing files may block in the filesystem.
+ */
+static void selinux_bprm_revalidate_files(const struct linux_binprm *bprm)
+{
+	const struct cred_security_struct *new_crsec = selinux_cred(bprm->cred);
+
+	if (new_crsec->sid == new_crsec->osid)
+		return;
+
+	flush_unauthorized_files(bprm->cred, current->files);
+}
+
 /*
  * Prepare a process for imminent new credential changes due to exec
  */
@@ -2542,9 +2556,6 @@ static void selinux_bprm_committing_creds(const struct linux_binprm *bprm)
 	if (new_crsec->sid == new_crsec->osid)
 		return;
 
-	/* Close files for which the new task SID is not authorized. */
-	flush_unauthorized_files(bprm->cred, current->files);
-
 	/* Always clear parent death signal on SID transitions. */
 	current->pdeath_signal = 0;
 
@@ -7690,6 +7701,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(netlink_send, selinux_netlink_send),
 
 	LSM_HOOK_INIT(bprm_creds_for_exec, selinux_bprm_creds_for_exec),
+	LSM_HOOK_INIT(bprm_revalidate_files, selinux_bprm_revalidate_files),
 	LSM_HOOK_INIT(bprm_committing_creds, selinux_bprm_committing_creds),
 	LSM_HOOK_INIT(bprm_committed_creds, selinux_bprm_committed_creds),
 

-- 
2.53.0

