Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.136.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793348299;
	b=EiA5i0GDgkTjM4H5ObncvhjPwJzoJatvapQWh8SJqkZdFBKM5yzpdCAoR4A/0DUq1JKC
	 TvEC27xkzVdMQ33lAGgKBFvnz7bNNmcztIf/f3x8cEreuT3iXgkQK922O2iW3hwcw8PhD
	 +igJxUbEEhQNjCRhupNbcaVGnRqGbmtjOqvPp18DLEP7qZlvHSEDUDZrx2QbD5Z3/vZ6E
	 Gnf+wBjvsAHMVm+yR8YLmcrtOi/wkZmd113kWZottTVgtxPgtJb3eJblgSZGRSdpZ6ms6
	 7LUH3fIt2RSJ/h/Bopmw2jWlu4jv6+/DspBSYYTogX1TTsx+RLnylwrMrNf8HvgGpJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348299;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8PFBa0453peGS7/Cs9P1PeciAx/a1xuZsr6ALPAf46o=;
	b=qm+YCxzjO/H21m34F29wKWq4FPpGtTYyM91tNs1+LA7emriP1+qe86Jodej9Hg2hsGLt
	 Wml+iaNJRvrszext4JOjSPVqha1FgWXQSlnM8S3ZMPrMr1A955nxk6xjQkJIqSpYsd8Hc
	 2KUQKk+QdNFXh2UXgZBVFoQKQsZ5NzbWomZu5BKoDGPCjzu5jVow9w4JVCpOrglwOqpOm
	 T5Zdj7tEZVpZaRO1Z0WRJZuR7N3Z4hIGVWMQir0l1muJERGogbNSQ94NA3s8ckIrmOSXo
	 WdVXU+Mwg2b6cFYF6mT+jPQdDgAtZrx0ZVwqDwhA7Ht1e7z5TY7BQRdtK/3dFHGe8hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unibo.it;
	spf=pass smtp.mailfrom=cs.unibo.it;
	dkim=pass header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=d9i1lyjV;
	arc=none smtp.remote-ip=130.136.161.50
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [130.136.161.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FFB606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 08:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50FFB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=d9i1lyjV
Received: from eipi10.cs.unibo.it (unknown [94.32.99.206])
	by mail.virtlab.unibo.it (Postfix) with ESMTPA id 17E421C025B;
	Fri, 30 Oct 2026 09:18:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1793348297;
	bh=ZygyKgWUKW+0GU3E/KOJede2S8o2FlDkM5rxc9dDDbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d9i1lyjV6sMu9BwEMaUUZHnieCBnjo/nNOEHjI24zDVFyRwIMMliibmQTivyuhNpI
	 F7ap3GZJJW9Hy05aQelkwHpzaqVEPMLzoJNNPGXRPEOX7ql2fBbxYX9Zkqnth4M8Kh
	 hOMApdUQQgT66XgjSH0KJhDDkrKp/bHEjGf/pT98=
From: Renzo Davoli <renzo@cs.unibo.it>
To: 
Cc: Renzo Davoli <renzo@cs.unibo.it>,
	stable@vger.kernel.org,
	=?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>
Subject: [PATCH v3 1/2] powerpc/syscall: Remove TIF_SYSCALL_RET
Date: Fri, 30 Oct 2026 09:17:54 +0100
Message-ID: <20261030081757.1065832-2-renzo@cs.unibo.it>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030081757.1065832-1-renzo@cs.unibo.it>
References: <20261030081757.1065832-1-renzo@cs.unibo.it>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 69cb2be898be ("powerpc/syscall: Fix syscall skip handling for
seccomp and ptrace") added TIF_SYSCALL_RET, set by
syscall_set_return_value(), so that system_call_exception() skips a
system call whose return value has already been set.

The flag is set with set_thread_flag(), i.e. on current rather than on
the task passed to syscall_set_return_value().  When the caller is a
tracer, as with PTRACE_SET_SYSCALL_INFO and op ==
PTRACE_SYSCALL_INFO_EXIT, the flag ends up on the tracer, and the next
system call of the tracer is silently not executed.  Setting it on the
right task would not be enough either: at a syscall-exit stop the flag
would then skip the next system call of the tracee.

The flag is not needed anymore.  Commit 05c033db7e9a ("entry, treewide:
Make syscall_enter_from_user_mode[_work]() indicate syscall execution")
made syscall_enter_from_user_mode_randomize_stack() return false when
ptrace or seccomp skip the system call, and every in-kernel caller of
syscall_set_return_value() on the syscall entry path (SECCOMP_RET_ERRNO,
SECCOMP_RET_TRACE without a tracer, SECCOMP_RET_USER_NOTIF) also makes
it return false.  A system call with an invalid number, including
syscall(-1), still gets -ENOSYS.

Remove the flag.

Fixes: 69cb2be898be ("powerpc/syscall: Fix syscall skip handling for seccomp and ptrace")
Cc: stable@vger.kernel.org # v7.3
Suggested-by: Michal Suchánek <msuchanek@suse.de>
Assisted-by: claude-opus-5-5
Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>
---
 arch/powerpc/include/asm/syscall.h     | 6 ------
 arch/powerpc/include/asm/thread_info.h | 1 -
 arch/powerpc/kernel/syscall.c          | 4 +---
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
index 32be22b995cc..4b3c52ed6e9d 100644
--- a/arch/powerpc/include/asm/syscall.h
+++ b/arch/powerpc/include/asm/syscall.h
@@ -98,12 +98,6 @@ static inline void syscall_set_return_value(struct task_struct *task,
 			regs->gpr[3] = val;
 		}
 	}
-	/*
-	 * Mark that a return value has been explicitly set by seccomp or
-	 * ptrace so that system_call_exception() can skip the syscall
-	 * unconditionally, even when the user requested syscall(-1).
-	 */
-	set_thread_flag(TIF_SYSCALL_RET);
 }
 
 static inline void syscall_get_arguments(struct task_struct *task,
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 1e069a2e7ce8..0487e94d3416 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -120,7 +120,6 @@ void arch_setup_new_exec(void);
 #endif
 #define TIF_POLLING_NRFLAG	19	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 #define TIF_32BIT		20	/* 32 bit binary */
-#define TIF_SYSCALL_RET		21	/* syscall error value set */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
index 8529827d697f..f7412556a9e8 100644
--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -18,9 +18,7 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
 	long ret;
 	syscall_fn f;
 
-	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0) ||
-			test_thread_flag(TIF_SYSCALL_RET))) {
-		clear_thread_flag(TIF_SYSCALL_RET);
+	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0))) {
 		return syscall_get_error(current, regs);
 	}
 
-- 
2.55.0

