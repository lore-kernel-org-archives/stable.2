Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561174;
	b=x1s2qhaMg2cuJLmU6mhE6+69SU4vqUeCncvB76bWPQ6DO3YA3qP/XLJJth8oEtbMxmxK
	 NR6XbXLQxkoHiMvLSQZ0byOWIwuXtXCOWKbQKVpUJBr5ZVpvqW3vo7IA9koer0uyqXNPr
	 n9azpT+4sm4jNKxnZwzPHLSrYn1a8BJ5FFwhTUL+1870nmPynhrYRJ1teKJhQPSvmY5ur
	 9BxfYrMh55Dr6Dh1Uek+jvHDKHGn9Fnro71TVT3CsDc9r8bXWXSM4xYOfOYhTYrp2W1HU
	 g6e9HgCWWrMuJbNhf2tA43+EycYLapkbMpwb2BThGVsRkSED95cnySA/vZ14RVyLOPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561174;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Ap7gSe/kuNeWblDe+ZfPxsux2kFQeqvhMXOEp+llOPs=;
	b=U4kPW4alwCXfZDQyxYWTsuinBXk/LawRS6fgcYGnj0fsAbhOfqKFMWt2jWlFHCAwt5IG
	 YwDqq+IBSWJvV7rdHh7WVYxXRI5p3h6hl6Ptoa/qeGlTmZUVNBLgxtXTKgnyEh+lGo7m+
	 CxMBeRyDiEv3DbmYnLkqnqdyu1nzRT/Ps46N2RGLaVVguRH9m4nPc4W69WDNaTMy46k+I
	 4chMlAq430iK+fpJk1s8fntNcJ5kGJjNdApj5l6XLfjxT7KSBsuPaaa59PsWSpwd6OEIZ
	 Ii7JCP3Wky7nJ+U2KGhXRb1IGiENTfAzaVYI6V4WkFzt8zcw6b/D8WzY7jI6qi9KZDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LM514mES;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262AF606A323;
	Tue, 24 Nov 2026 22:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LM514mES
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1245F1F000CF;
	Tue, 24 Nov 2026 22:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795561174;
	bh=Ap7gSe/kuNeWblDe+ZfPxsux2kFQeqvhMXOEp+llOPs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LM514mESwwt6WU10mCghINlN5okJv1Fb2bAXW+OkNtX+LBAJNrQeDTtw4fFARY+eU
	 Vm9Rpqo+5ipsesZC93l8C6m6f8S9wKRHx7FroRQPEdAcaWs1HScN7GTkIXaCWVKwm9
	 tsMjYFHzmig78IX5VyZuxHaCllmSJu3ysTB7kpkyj9GVHCR3HxmtDNS9Jot4UZ2Fi+
	 BgHfdp/CUnXllRhT8F2a9csbix1k2nMEOGDLtA7HJqJlDnOBys87ZBdV+JNrq9d3lT
	 LZb4S7Zlcq9EmjUIlwqGORUysPd84a/mSy3/qzI09h92rl3C9OeE2sspA/7SiJnrpC
	 D5MJY8lnoH68A==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Nov 2026 23:58:24 +0100
Subject: [PATCH RFC 01/19] proc: copy namespace link after dropping
 exec_update_lock
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
Message-Id: <20261124-work-exec-update_lock-v1-1-e489035395b8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2802; i=brauner@kernel.org;
 h=from:subject:message-id; bh=lGDUzty6NPq+z3GYcxQr0PrIQZY6uMG00NxetEmFkDY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSziW2TOKQonVvLlloyv95ovkQhFzfH5uo67VkRq5PMH
 uecVvbpKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmEjzTkaGT/sFNvGf+FNq3Mnc
 xWbE9Fj6S0NauUpDVLRM/e60QJ8aRoZ9Ua/YeALSd97rPe/jKOKwm6nw5hvrGVyMPFnLGjyF85g A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

proc_ns_readlink() copies the name of the namespace to userspace under
exec_update_lock. If that faults the lock is held for as long as the
fault takes. With a buffer in a mapping of a file on a FUSE filesystem
or in a range registered with userfaultfd it's the caller who decides
how long that is:

  locks held by ns-reader/230:
   #0: (&sig->exec_update_lock){++++}-{4:4}, at: proc_ns_readlink+0x180/0x340

In the meantime an exec of the task waits for exec_update_lock past the
point of no return. And everyone else who needs the exec_update_lock of
the task queues up behind the exec. So a read of /proc/<pid>/stat hangs
as well:

  task:exec-task       state:D pid:229
  Call Trace:
   __schedule+0x1691/0x4b00
   schedule+0xe0/0x2e0
   schedule_preempt_disabled+0x11/0x20
   rwsem_down_write_slowpath+0x472/0x1820
   down_write_killable+0x1ba/0x240
   begin_new_exec+0xa4b/0x2df0
   load_elf_binary+0x340/0x4af0
   bprm_execve+0x772/0x1400
   do_execveat_common.isra.0+0x3d9/0x540
   __x64_sys_execve+0x8c/0xc0
   do_syscall_64+0x110/0x600
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  task:stat-reader     state:D pid:231
  Call Trace:
   __schedule+0x1691/0x4b00
   schedule+0xe0/0x2e0
   schedule_preempt_disabled+0x11/0x20
   rwsem_down_read_slowpath+0x5cc/0x10c0
   down_read_killable+0xf1/0x5f0
   do_task_stat+0x13b/0x2870
   proc_single_show+0x110/0x1d0
   seq_read_iter+0x2e4/0x1280
   seq_read+0x29b/0x550
   vfs_read+0x171/0xb20
   ksys_read+0x111/0x250
   do_syscall_64+0x110/0x600
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

All it takes is being allowed to read the namespace links of the task.

The name is formatted into a buffer on the stack anyway. So drop the
lock before it's copied out.

Fixes: 6650527444da ("proc: protect ptrace_may_access() with exec_update_lock (part 1)")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/namespaces.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index ea6ec61a0430b..4c91ccbed21ef 100644
--- a/fs/proc/namespaces.c
+++ b/fs/proc/namespaces.c
@@ -92,12 +92,11 @@ static int proc_ns_readlink(struct dentry *dentry, char __user *buffer, int bufl
 		goto out_put_task;
 
 	res = -EACCES;
-	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)) {
+	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
 		res = ns_get_name(name, sizeof(name), task, ns_ops);
-		if (res >= 0)
-			res = readlink_copy(buffer, buflen, name, strlen(name));
-	}
 	up_read(&task->signal->exec_update_lock);
+	if (res >= 0)
+		res = readlink_copy(buffer, buflen, name, strlen(name));
 out_put_task:
 	put_task_struct(task);
 	return res;

-- 
2.53.0

