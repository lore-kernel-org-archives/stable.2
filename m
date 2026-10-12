Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3634C2248;
	Mon, 12 Oct 2026 17:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826722; cv=none; b=KSL/dxgzYlIQoMK5dfZT2Z8RlVJUboPkCfN8xETHqPBCtpV2gChrKzNNvc6jgSbymC1zAjkYi2SMSrr1NEqAYW2TUVPaMoRofwK+MiQYuIwGkDvZseP/ijmJSDW6CBIEPQRUHyTTwa0ejJEBaGd7drbIG8fYs3eY3rlPwQWDZbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826722; c=relaxed/simple;
	bh=3BOJUGdvasGKNrJz73unSOIIoXFBdk/4DjIHhQtV3xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nRUwXllhiqfzRz1WASY3azaLl1vU6/QLXYLc28fmKjlG5i87ITPk1KgTS6u8bieaPzgTmLUXbsW34jdvJhakJuXtXWU09FFFaMKFC/+b78jbC3pJUrr64L0pskzBgK2JYJBX3A1vwpycDbM5pfu3je+bHyHMqzxUkzYvka3Sqag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pmilQCrB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WFDwT4H3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pmilQCrB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=WFDwT4H3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pmilQCrB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WFDwT4H3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pmilQCrB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="WFDwT4H3"
Received: from tenko.suse.cz (unknown [IPv6:2a07:de40:b2bf:1b::11d2])
	by smtp-out1.suse.de (Postfix) with ESMTP id 666B921EA0;
	Mon, 12 Oct 2026 17:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791826718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8SZv8+95iAQyqraQGrneJoLymgjYWATeCs9ikvc3cC8=;
	b=pmilQCrBh829bXvFXvrw1ccFYRM1PPZO1rzZCOXKGcUhCa7ifbB1vjTL6jNAjJU4+Cb4qX
	G6XwLH1W92hJ46cIl/PGp6CmZW10o5bQJam0go60KmMbaeIgllVrPaMxrJshEroNk70yQC
	AuJ5wVXLnQnSgQ/mQl0bChxZL7THcXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791826718;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8SZv8+95iAQyqraQGrneJoLymgjYWATeCs9ikvc3cC8=;
	b=WFDwT4H3MBBAC0jVxPYN8WGxnMs4w1GCVreCKK48kfyPw1mT/N0ZwPTIDgk4kqikq16xSR
	plOW3uDL2R6AR3CQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pmilQCrB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WFDwT4H3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791826718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8SZv8+95iAQyqraQGrneJoLymgjYWATeCs9ikvc3cC8=;
	b=pmilQCrBh829bXvFXvrw1ccFYRM1PPZO1rzZCOXKGcUhCa7ifbB1vjTL6jNAjJU4+Cb4qX
	G6XwLH1W92hJ46cIl/PGp6CmZW10o5bQJam0go60KmMbaeIgllVrPaMxrJshEroNk70yQC
	AuJ5wVXLnQnSgQ/mQl0bChxZL7THcXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791826718;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8SZv8+95iAQyqraQGrneJoLymgjYWATeCs9ikvc3cC8=;
	b=WFDwT4H3MBBAC0jVxPYN8WGxnMs4w1GCVreCKK48kfyPw1mT/N0ZwPTIDgk4kqikq16xSR
	plOW3uDL2R6AR3CQ==
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michal Suchanek <msuchanek@suse.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Kees Cook <kees@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
	"Bernhard M. Wiedemann" <bwiedemann@suse.de>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] powerpc: Restore all registers after a traced syscall again
Date: Mon, 12 Oct 2026 19:38:28 +0200
Message-ID: <4c1da7f31a6603455ec452960af529e4d77f5334.1791826411.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.99 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ONCE_RECEIVED(1.20)[];
	HFILTER_HELO_IP_A(1.00)[tenko.suse.cz];
	RDNS_NONE(1.00)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[tenko.suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.986];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DIRECT_TO_MX(0.00)[git-send-email 2.51.0];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.de,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,amacapital.net,chromium.org,arm.com,vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b2bf:1b::11d2:from];
	TAGGED_RCPT(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim]
X-Spam-Score: 3.99
X-Spam-Level: ***
X-Spamd-Bar: +++
X-Rspamd-Queue-Id: 666B921EA0
X-Spam-Flag: NO
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

From: Bernhard M. Wiedemann <bwiedemann@suse.de>

syscall_exit_prepare() asks the exit assembly to reload all GPRs, CTR
and XER from pt_regs only if the thread flags contain any of the flags
in _TIF_SYSCALL_DOTRACE. With the new entry code based GENERIC_ENTRY the
flags are no longer set.

This breaks tracers that modify a stopped syscall, for example ones that
re-execute the syscall instruction by moving the NIP back by 4 at the
syscall-exit stop with the syscall number put back into r0: the sc then
runs with r0 = 0, which is __NR_restart_syscall. dettrace fails like
this with "No filter rule for system call: restart_syscall". A tracer
that writes r4 at the syscall-exit stop of an sc sees the tracee
continue with r4 = 0 instead; with a 7.1 kernel both work.

Check the equivalent syscall_work bits instead, and drop the now unused
_TIF_SYSCALL_DOTRACE.

Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
Cc: stable@vger.kernel.org # 7.2.x: c7585b8e99ad: powerpc: Don't drop _TIF_RESTOREALL on syscall restart
Cc: stable@vger.kernel.org # 7.2.x
Assisted-by: LLM
Signed-off-by: Bernhard M. Wiedemann <bwiedemann@suse.de>
[ms: reword commit message]
Signed-off-by: Michal Suchánek <msuchanek@suse.de>
---
A backport also needs commit c7585b8e99ad ("powerpc: Don't drop
_TIF_RESTOREALL on syscall restart"), without which the flag can still
be lost.

It has been pointed out that the newly defined
PPC_SYSCALL_WORK_RESTOREALL is almost the same as SYSCALL_WORK_ENTER and
the existing define might be used instead. However, it is not clear if
this is expected or if this is merely coincidence, and not guaranteed.

Testing: a small tracer (pokes r4 at the syscall-exit stop of an sc,
and replays a syscall by moving NIP back with a new r0) shows both
writes lost on a ppc64le and both working on 7.1.8.
------------[ cut here ]------------
// SPDX-License-Identifier: GPL-2.0
/*
 * Does a register a tracer writes at the syscall-exit stop of an "sc"
 * reach the tracee? Checks r4, and a replay: NIP moved back onto the sc
 * with r0 set to another syscall number.
 * Build: gcc -O2 -o ppc-exitregs ppc-exitregs.c (powerpc64 only)
 */

/* word offsets in struct pt_regs, arch/powerpc/include/uapi/asm/ptrace.h */

static long do_sc(long nr, long *r4io)
{
	register long r0 __asm__("r0") = nr;
	register long r3 __asm__("r3") = 0;
	register long r4 __asm__("r4") = *r4io;

	__asm__ volatile("sc"
			 : "+r"(r0), "+r"(r3), "+r"(r4)
			 :
			 : "r5", "r6", "r7", "r8", "r9", "r10", "r11", "r12",
			   "cr0", "ctr", "xer", "memory");
	*r4io = r4;
	return r3;
}

static long peek(pid_t pid, int w)
{
	errno = 0;
	long v = ptrace(PTRACE_PEEKUSER, pid, (void *)(w * sizeof(long)), 0);
	if (errno) {
		perror("PEEKUSER");
		exit(2);
	}
	return v;
}

static void poke(pid_t pid, int w, long v)
{
	if (ptrace(PTRACE_POKEUSER, pid, (void *)(w * sizeof(long)), (void *)v)) {
		perror("POKEUSER");
		exit(2);
	}
}

/* Resume to the next syscall stop, which must be one. */
static void next_stop(pid_t pid)
{
	int st;

	ptrace(PTRACE_SYSCALL, pid, 0, 0);
	if (waitpid(pid, &st, 0) != pid || !WIFSTOPPED(st) ||
	    WSTOPSIG(st) != (SIGTRAP | 0x80)) {
		fprintf(stderr, "unexpected wait status %#x\n", st);
		exit(2);
	}
}

int main(void)
{
	pid_t pid = fork();
	int st, fail = 0;

	if (pid == 0) {
		long r4 = 0x1111, r4a, ret;

		ptrace(PTRACE_TRACEME, 0, 0, 0);
		raise(SIGSTOP);
		do_sc(__NR_getpid, &r4);
		r4a = r4;
		ret = do_sc(__NR_getpid, &r4);
		/* bit 0: the tracer's r4 was lost; bit 1: the replay of
		 * the second getpid as getppid returned something else */
		_exit((r4a != 0x2222) | (ret != getppid()) << 1);
	}

	waitpid(pid, &st, 0);
	ptrace(PTRACE_SETOPTIONS, pid, 0, (void *)PTRACE_O_TRACESYSGOOD);

	/* 1: write r4 at the exit stop of getpid */
	next_stop(pid);				/* entry */
	next_stop(pid);				/* exit */
	poke(pid, W_R4, 0x2222);
	next_stop(pid);				/* entry of the second getpid */

	/* 2: replay the second getpid as getppid */
	next_stop(pid);				/* exit */
	poke(pid, W_NIP, peek(pid, W_NIP) - 4);
	poke(pid, W_R0, __NR_getppid);
	next_stop(pid);				/* entry of the replay */
	long nr = peek(pid, W_R0);
	printf("replayed syscall arrives as nr %ld (%s)\n", nr,
	       nr == __NR_getppid ? "getppid, OK" :
	       nr == __NR_restart_syscall ? "restart_syscall, BUG" : "?");
	if (nr != __NR_getppid) {
		fail = 1;
		poke(pid, W_R0, __NR_getppid);	/* entry writes do work */
	}
	next_stop(pid);				/* exit */
	ptrace(PTRACE_CONT, pid, 0, 0);
	waitpid(pid, &st, 0);
	if (!WIFEXITED(st)) {
		printf("child did not exit normally: %#x\n", st);
		return 2;
	}
	printf("r4 written at the exit stop: %s\n",
	       WEXITSTATUS(st) & 1 ? "lost, BUG" : "kept, OK");
	printf("replay result: %s\n",
	       WEXITSTATUS(st) & 2 ? "wrong" : "getppid(), OK");
	return fail || WEXITSTATUS(st);
}
---
 arch/powerpc/include/asm/thread_info.h |  3 ---
 arch/powerpc/kernel/interrupt.c        | 16 ++++++++++++++--
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 1e069a2e7ce87..0e8dc71c8d3fe 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -142,9 +142,6 @@ void arch_setup_new_exec(void);
 #define _TIF_SYSCALL_TRACEPOINT	(1<<TIF_SYSCALL_TRACEPOINT)
 #define _TIF_EMULATE_STACK_STORE	(1<<TIF_EMULATE_STACK_STORE)
 #define _TIF_SYSCALL_EMU	(1<<TIF_SYSCALL_EMU)
-#define _TIF_SYSCALL_DOTRACE	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
-				 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT | \
-				 _TIF_SYSCALL_EMU)
 
 #define _TIF_USER_WORK_MASK	(_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
 				 _TIF_NEED_RESCHED_LAZY | _TIF_NOTIFY_RESUME | \
diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 55f9c0c9922ac..524c51104e4c9 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -75,6 +75,18 @@ static notrace __always_inline bool prep_irq_for_enabled_exit(bool restartable)
 	return true;
 }
 
+/*
+ * Syscall work after which the exit must reload all registers from
+ * pt_regs: a tracer may have changed any of them at a syscall or seccomp
+ * stop, or under PTRACE_SYSEMU. Audit and the tracepoint are included to
+ * keep the pre-GENERIC_ENTRY behaviour.
+ */
+#define PPC_SYSCALL_WORK_RESTOREALL	(SYSCALL_WORK_SECCOMP |		\
+					 SYSCALL_WORK_SYSCALL_TRACEPOINT | \
+					 SYSCALL_WORK_SYSCALL_TRACE |	\
+					 SYSCALL_WORK_SYSCALL_EMU |	\
+					 SYSCALL_WORK_SYSCALL_AUDIT)
+
 /*
  * This should be called after a syscall returns, with r3 the return value
  * from the syscall. If this function returns non-zero, the system call
@@ -117,9 +129,9 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 		regs->gpr[3] = r3;
 	}
 
-	if (unlikely(ti_flags & _TIF_SYSCALL_DOTRACE)) {
+	if (unlikely(READ_ONCE(current_thread_info()->syscall_work) &
+		     PPC_SYSCALL_WORK_RESTOREALL))
 		ret |= _TIF_RESTOREALL;
-	}
 
 	syscall_exit_to_user_mode(regs);
 
-- 
2.51.0

