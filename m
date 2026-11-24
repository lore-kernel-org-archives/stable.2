Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795509997;
	b=VTfR7hDls0qpiphfTBCew77zpS4LfNFMQXdMmVch6fAVXjKirb9Em2YRAxzuk/6DwMhc
	 NjonHxzoqT8IuaSP06EN0JlU2RvVBjcL/A2+8gFSc4EWy0QzfDNwIR5Xi5RfFSkj0gufp
	 fCGb36Wnm4YvnlEpDTTZfniUF3KFmsMBd6SVIlzwVYC2T3hpSOmkSgXcEGnkWfWfmvi1F
	 nj3n8vS1siOiOoJFCy4ru/GJdyegVDW9su2H45rrn31WxSn+u0WSQTz+K8Ir8hJEKEAo9
	 qNv3m04n6n3//xJDF9S0JzQgwRBJP91GLeIrMAiJUVXlOf1uwPZIIvivJLRIqjcpsqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795509997;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=gB0t6lsEAvPLKP9TexVyZaTQIG5MDeT3iJA9FNr8QoU=;
	b=YoTUKiYHMBja3i0ZCXgpwlTa/qLky+wQVs+eEuRrQp83gTjtvHu9JUTCkrcAXMb7ssXZ
	 JdlGAp80r1kaWOKyS0MIW/1XqSHdCEZ9hxmSjdA+VxRXASUSz4zlzl0oz8nWMQXlsu7uR
	 94OBC/qikCJ0TTEcIFvpCkHNxprMx07FPp1LmqZnZzhRXTL3rGJ/vYJ63V9A61i9qdJ5s
	 vV5juAjn5LQ1f7JOplmTYyriVSDPjuzfDZJvHkXXcHxdODjkhu/xnJ1nrs43riYin1M0I
	 fMfiHy9RUujUHebEP/T1PU9zYTHKNyULJ09AOWNxI6JCZvJh4Mknaqpx02CZXt6S8tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=luuUbUMx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96235606A31E;
	Tue, 24 Nov 2026 08:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=luuUbUMx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98101F000C6;
	Tue, 24 Nov 2026 08:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795509997;
	bh=gB0t6lsEAvPLKP9TexVyZaTQIG5MDeT3iJA9FNr8QoU=;
	h=From:Date:Subject:To:Cc;
	b=luuUbUMxrkhNLvzR/ykSVOJC0ShGEA8Tnjhh9MfUuaBnKFEnkl7Dp/FDDOjre+mjQ
	 Uu497cKyKMvHJ8hnvog5pv4/bEXilrV4uHJiB69mVnbqOjSGHtmKOO+0rDhQis//ga
	 N7Aavq45Mrt77U3fPddWXtqsb4sxP9sXnwM2Uc7kulWLHaC29lv2Y5QKZ5rwho3lK7
	 nZFonkMJ2Szzdyu+D4FuzXZbsTptt+KhZX2l/arvF18REdm6q5oF2V6DZvRBqQOy5/
	 LaT9OUOG3lhwvZ3X6+/u9Q+bEAjXGiWS31xqQ17KIWcYo1uz4Flt0fR4huFIxDe/PY
	 yLxrG3zdfn8fg==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Nov 2026 09:46:22 +0100
Subject: [PATCH] x86/shstk: don't warn when the shadow stack is freed twice
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
Message-Id: <20261124-work-x86-shstk_free-v1-1-fc456c538e70@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/0XMQQ7CIBCF4as0s3ZIoQ0pXsUYAzgVbEINU7VJ0
 7sLunD5T958GzDlSAzHZoNMr8hxTiXkoQEfbLoRxmtpUK3SUqoO33OecB00cuBluoyZCDujnB5
 Mr1vTQ/l8ZBrj+lVP51/z093JL5WqC2eZ0GWbfKinioqCij8q6gT2/QMnZelVogAAAA==
X-Change-ID: 20261123-work-x86-shstk_free-392b68946094
To: Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=2811; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dvX2CcTQ7JihDgSkIo829jeueQbOyQefB2Hl7suGYzo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSz+r3g1F4uqdvn/2Tls91PzCa//tzi1yigGehteuaxh
 6mX0uGujlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkslWBk6Dm/8dyGlBcy0xb/
 79ojUKfNvIDBqC5G3Lqp+YPDUcnGfEaGrsIHS4zXzzHKLEw56OEn0V3x4te66oy1WziErju8ftz
 FDAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

exec frees the shadow stack of the old image when it releases the old
mm in mm_exit_exec_release(). That happens right before it takes
exec_update_lock and before it switches to the new mm. If the exec fails
after that the task exits with the old mm and exit_mm() calls
mm_exit_exec_release() a second time. shstk_free() notices that the
shadow stack is gone already as shstk->size is zero and warns:

  WARNING: arch/x86/kernel/shstk.c:472 at shstk_free+0x7d/0x90, CPU#7: shstk-exec/120
  RIP: 0010:shstk_free+0x7d/0x90
  Call Trace:
   mm_exit_exec_release+0x21/0x110
   do_exit+0x1e8/0xc30
   do_group_exit+0x2e/0xd0
   get_signal+0xd11/0xd20
   arch_do_signal_or_restart+0x72/0x2b0
   exit_to_user_mode_loop+0xd8/0x560
   do_syscall_64+0x412/0x600
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

All it takes is a SIGKILL while the task waits for exec_update_lock or
for the mmap lock of the old mm. Both are taken killable. And a task
that sleeps in a page fault while it holds the exec_update_lock of the
exec'ing task for reading, e.g., in readlink() of /proc/<pid>/ns/mnt,
makes that wait as long as it likes.

Nothing is unmapped twice as shstk_free() returns in that case. So just
don't warn about it.

Fixes: 509ff51ee652 ("x86/shstk: Add warning for shadow stack double unmap")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
This removes a warning that a task with a user shadow stack triggers
when its exec is killed while it waits for a lock. I have a reproducer.
---
Hey,

This also fell out of my exec massage. I was unsure whether it should go
to sec or on the list but it's just a WARN() that we need to drop. I
have a reproducer if that's needed.

Thanks!
Christian
---
 arch/x86/kernel/shstk.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index eb690ba90180c..df5576d8d7d2b 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -465,11 +465,12 @@ void shstk_free(struct task_struct *tsk)
 
 	/*
 	 * shstk->base is NULL for CLONE_VFORK child tasks, and so is
-	 * normal. But size = 0 on a shstk->base is not normal and
-	 * indicated an attempt to free the thread shadow stack twice.
-	 * Warn about it.
+	 * normal. size = 0 on a shstk->base means that the thread
+	 * shadow stack has been freed already. That happens when an
+	 * exec fails after it released the old mm as the task then
+	 * exits with the old mm and gets here a second time.
 	 */
-	if (WARN_ON(!shstk->size))
+	if (!shstk->size)
 		return;
 
 	unmap_shadow_stack(shstk->base, shstk->size);

---
base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
change-id: 20261123-work-x86-shstk_free-392b68946094

