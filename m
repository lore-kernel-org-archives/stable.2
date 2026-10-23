Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.136.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778879;
	b=ZXc2HAJ3Zat1u6mE7ljGDG2v0VRXj1gR2RPdFA6Lyu5jD+BQ2uvREuqNrTkMaUGTsW4X
	 ZPPg2D6X3DCQz60fh2Tykn+S7FQI+Dkp/VMJFJHeHdVwYtoXZOAOmCoRK2Wp3abJdwBCf
	 dI+O4NZzuHljuwAeyssl9qSBaLcg64fLyjjV61Kdro+wZWCFhvSi3xDreVy6aBLtXSiaV
	 XIt9KXMKniVZwfdS5F2qiD3ebjlL8PvDW2mCGfM2QV9wtcsiV5XjyBKPj69A24x5sed5A
	 W4OY2jcDUxUnK7rs3Cuo54z9i2WwIsSRl7bB8ouygV/AWuDxdajy0yYA1Sv2AboHurA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778879;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TNpTDIHcROMznwYRxDpIWPwGzl98sFXPxpXvozgPziE=;
	b=P1VadUo75PpsMlzwPDIqFLwF1bI2SBNw5+5XIFUyzAMP06JFy2zyX98JWFPZFQl3jVYm
	 a37Rx1V2Qck9k9LOaPRdS1/t7U/MxUWFc0kmfPH2DvOdBA+cyCCP56DAxHwG5EAlV3fFw
	 5blc/TaOeb7lITjBKQw1kNp/OJTMxExjcbFb3uX+6UKf/n6QJo54GotYcqlG+49Uhhqrs
	 qF9fodCbRXOUyl1CQJ4JLxbpTaJ6sI2NbDiCp+2qnhx+24w4X01Zg0D4U3IPdqQ+BwFhe
	 DwWdFB09WWVXEncL6G9/n0K1WYN5FHAfkMSdImJ8g6P89gyK49JxdzG9+fbJbAyiSWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unibo.it;
	spf=pass smtp.mailfrom=cs.unibo.it;
	dkim=pass header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=D18Fpydl;
	arc=none smtp.remote-ip=130.136.161.50
Received: from mail.virtlab.unibo.it (mail.virtlab.unibo.it [130.136.161.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172A9606A329;
	Fri, 23 Oct 2026 18:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 172A9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unibo.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cs.unibo.it header.i=@cs.unibo.it header.a=rsa-sha256 header.s=virtlab header.b=D18Fpydl
Received: from eipi10.cs.unibo.it (unknown [94.32.99.206])
	by mail.virtlab.unibo.it (Postfix) with ESMTPA id 36A991C006E;
	Fri, 23 Oct 2026 20:07:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs.unibo.it;
	s=virtlab; t=1792778867;
	bh=BJcbOGmX+Z8yUrS25pNR/1jqBIqhgRSTCtLJy24//Ms=;
	h=From:To:Cc:Subject:Date:From;
	b=D18FpydlX118QA4mJM0TXwv1k8Mj0yQTuwA8SLtqmGrhtmrOK3i7Ru0V2HM8wNUlC
	 Wvvnyyo9/ej6jIJzO5nfEyNhzPkmHWCSq7zQQXzsOOqe1U4obCH28RwxZ36RTQvFCM
	 Tst6gBAS6RaZ0OdjeY+6M2tk9VILFlypxiHlKLic=
From: Renzo Davoli <renzo@cs.unibo.it>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Renzo Davoli <renzo@cs.unibo.it>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	=?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Oleg Nesterov <oleg@redhat.com>,
	"Dmitry V . Levin" <ldv@strace.io>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/1] powerpc/syscall: Return the preset value of skipped syscalls
Date: Fri, 23 Oct 2026 20:07:32 +0200
Message-ID: <20261023180735.853655-1-renzo@cs.unibo.it>
X-Mailer: git-send-email 2.55.0
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

When ptrace or seccomp skip a system call, the return value they set in
regs->gpr[3] gets lost or the tracer is affected, since two recent
changes:

1. Commit 05c033db7e9a ("entry, treewide: Make
   syscall_enter_from_user_mode[_work]() indicate syscall execution")
   made system_call_exception() return syscall_get_error() for a skipped
   system call.  syscall_get_error() is 0 for any non-error value, so a
   success value set by a tracer at a PTRACE_EVENT_SECCOMP stop (e.g.
   with PTRACE_POKEUSER), or by a SECCOMP_RET_USER_NOTIF listener, is
   replaced with 0.

2. Commit 69cb2be898be ("powerpc/syscall: Fix syscall skip handling for
   seccomp and ptrace") made syscall_set_return_value() set
   TIF_SYSCALL_RET with set_thread_flag(), i.e. on current rather than on
   the task passed in.  When the caller is a tracer, as in
   PTRACE_SET_SYSCALL_INFO with op == PTRACE_SYSCALL_INFO_EXIT, the flag
   ends up on the tracer, and the next system call of the tracer is
   silently not executed.  Setting it on the right task would not be
   enough either: at a syscall-exit stop the flag would then skip the
   next system call of the tracee.

TIF_SYSCALL_RET is not needed anymore: after the change described in 1.
the generic entry code tells whether ptrace or seccomp skipped the
system call, and every in-kernel caller of syscall_set_return_value() on
the syscall entry path (SECCOMP_RET_ERRNO, SECCOMP_RET_TRACE without a
tracer, SECCOMP_RET_USER_NOTIF) also makes it return false.  A user
calling syscall(-1) without tracer or seccomp still gets -ENOSYS.

Remove the flag and return regs->gpr[3] for a skipped system call, as
done before the conversion to GENERIC_ENTRY.  The syscall exit path
already converts a negative error value to the "sc" ABI, and
syscall_set_return_value() keeps CR0.SO in sync for positive error
values.

Fixes: 69cb2be898be ("powerpc/syscall: Fix syscall skip handling for seccomp and ptrace")
Fixes: 05c033db7e9a ("entry, treewide: Make syscall_enter_from_user_mode[_work]() indicate syscall execution")
Cc: Michal Suchánek <msuchanek@suse.de>
Cc: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org # v7.3
Assisted-by: claude-opus-5-5
Signed-off-by: Renzo Davoli <renzo@cs.unibo.it>
---
How this was found and tested: QEMU pseries (TCG, -cpu power9), ppc64le
guest config, v7.3-rc6 (7b63ef2d55f2), with a small reproducer
(ppc_skip_repro.c, available on request) which

 - sets the getpid() return value at a syscall-exit stop with
   PTRACE_SET_SYSCALL_INFO, then makes a syscall in the tracer;
 - skips getpid() at a PTRACE_EVENT_SECCOMP stop with PTRACE_POKEUSER
   (r0 = -1, r3/CR0.SO = return value), with both "sc" and "scv 0".

                                             v7.3-rc6      with this patch
  tracer syscall after SET_SYSCALL_INFO      returns 0     correct
  skipped syscall, success value, sc/scv     returns 0     correct
  skipped syscall, error value, sc/scv       correct       correct
  selftests/ptrace set_syscall_info test    FAIL          pass
  selftests/seccomp/seccomp_bpf              11 failures   all pass (*)

  failing in v7.3-rc6: user_notification_{basic,child_pid_ns,
  sibling_pid_ns,fault_recv,addfd,addfd_rlimit,sync,fifo,wait_killable},
  TRACE_syscall.seccomp.syscall_faked, plus the timing-only one below.

(*) user_notification_wait_killable_after_reply (100000 notifications
    with a 1 ms itimer) can hit the 30 s harness timeout under emulation,
    with and without this patch.

Build-tested with W=1: ppc64le guest config, ppc64_defconfig (BE),
pmac32_defconfig.

Changes in v2:
- Rebased on current mainline (734bef548a96), which now contains
  commit 66236558dfac ("powerpc/syscall: Avoid atomic
  test_and_clear_thread_flag on fast path").  That commit folded the
  TIF_SYSCALL_RET check into the skip condition, so the v1 hunk in
  system_call_exception() no longer applied.  The resulting code is the
  same as with v1.
- Link to v1:
  https://lore.kernel.org/lkml/20261018151539.440213-1-renzo@cs.unibo.it

 arch/powerpc/include/asm/syscall.h     |  6 ------
 arch/powerpc/include/asm/thread_info.h |  1 -
 arch/powerpc/kernel/syscall.c          | 13 ++++++++-----
 3 files changed, 8 insertions(+), 12 deletions(-)

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
index 8529827d697f..52ceff4ef41b 100644
--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -18,11 +18,14 @@ notrace long system_call_exception(struct pt_regs *regs, unsigned long r0)
 	long ret;
 	syscall_fn f;
 
-	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0) ||
-			test_thread_flag(TIF_SYSCALL_RET))) {
-		clear_thread_flag(TIF_SYSCALL_RET);
-		return syscall_get_error(current, regs);
-	}
+	/*
+	 * If ptrace or seccomp decided to skip the syscall, regs->gpr[3] holds
+	 * the return value they set (or the unmodified first argument, e.g.
+	 * for PTRACE_SYSEMU). Return it as is, the exit path takes care of
+	 * the error encoding for the "sc" ABI.
+	 */
+	if (unlikely(!syscall_enter_from_user_mode_randomize_stack(regs, &r0)))
+		return regs->gpr[3];
 
 	if (unlikely(r0 >= NR_syscalls)) {
 		if (unlikely(trap_is_unsupported_scv(regs))) {
-- 
2.55.0

