Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BF33B9D8B
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 06:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792045992; cv=none; b=tEVej8SBA9GbDzW0U6lJrRO6UYeSGHCB/+p3fwm8rjEjmP6tuhsLyES+FqJKdj5L0r/wA8T/X/3Osz/H4H7BkKEjuOuSysP0MGrcvxmfy/FDYdnET+re+xcS2MO4I74TZp167aVjWD+Rjb/eNQ7VDHRpQR8yeBJAreXUHaQ3Xm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792045992; c=relaxed/simple;
	bh=tjl+jzVoREIALSRf+bGmpu7hA4tUZSqq8wnX4TqXkes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbGOwlMBblZXaiHstfJnwP14+2A94o3oWSsm1oZ6pLaj/H2fiQwZckqrTT0aqTF8J01EHcgTQJ9PF9+D/kxgwA8P+wTnssrAuE1a0XVZNCjiSEZfVfPxcb9yy3WZOCsl2Jf7e46yQU8X1jzaT2LqrWjARw/p0V2/5y3IxXf20L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqt0MbL6; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqt0MbL6"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-887beafb714so2496727b3a.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 23:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792045988; x=1792650788; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hShrhkKhE7cqzWAVYxt1KlRI8LNhnsqtVeQ5CSO7Esw=;
        b=hqt0MbL6/oogbrwREwEgP5xQtsPmXHfbc6BLXbi+vilD+GHcRYNkqMjU03+nB869mM
         KuCVF4sgYWcvCoc/TNP2/70DsmjFY0RgqmqdOc1QlVGslTrLUpD5kvVqm/RTITGdSMtK
         vcT/Ik2N/m4GpiZ9/StP8aKPFwq+YavDfWHuzU+lzwMxrgIbMdX5wwP/uolwBmO0v43E
         +fzNhkJlXPnhFawSWCZRdtkUIuKO0IRh2I9Q7TR3OWw1xRm7ZbxdCvhn+XS+Z2imAh2o
         7iwJwwFjWnZJxOHEGaJsIhAfwQTBCqlqMmmupcBYklAdrO954mE1FH2K1rEW7eblXwMz
         nlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792045988; x=1792650788;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hShrhkKhE7cqzWAVYxt1KlRI8LNhnsqtVeQ5CSO7Esw=;
        b=SrAWcq/boPdaKoGKsEG/pDo7N1tJEy8w1i5h28vRwKTjLfrW8bub43zGpRRLNbnDYr
         TjqIJm2XDTyUiwDRdWa3CPeUrWWaa2MHdQPPGw7QyyWVwDOzkbGj5DhO9p9Xi5nVnPZb
         S3Hvcm5DejOoH4J43ClzPF3OkS7tVv/GfNWKndZVaiCSiFbRz6xxApVIP0j30/01H/D3
         LJaftWbnA2EzrRCbXBy1Lkq0HH+EmqCwH3ia3A3apVSdQRScSNm+y9Kj4x75ZKp65i1u
         XCTJh/X3Y9reyHDKj8Bbl3eCoCcw5tp4fe3XtcDMvuDMvkdRoCM0VrsDzvxzM6IuWNNw
         QkEg==
X-Forwarded-Encrypted: i=1; AKwUvByxvaAWPBGw67VuKu3cojQHy4x+uU/9fcfTn4NFEUIlH8TxqOG2tghMgSPtf7AysClIjBm4+oM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0QvIvNcE1MSp7wEuNk2LrqjbI8fiMGGP3ok/aYhKdrfZY6dG/
	7Xs0LmFHEucy35EeNAMBl3iLiKlMAftCAQ0GpxenNtDowr5SThcfG+sr
X-Gm-Gg: AYBFou3FE8/Qid+oJ3q79Opq95SnTL9ACb77Q/3JB6upOcp1eSAfvVcRsYgw35fCDh8
	mgZe0JI5Nm9OrxDDMAUjPLaQQTaHgUdUySY88Fs/SP+81vX9JRmZIo1pXHZNZ396zSGKPBXcnvp
	g+WVjvJaIxrUYRJVjp/SnA29F/VFWFbLTcyebX0B/J2VtwOlDvnRRIXOlRABsQJHGdwJ6yPtdRN
	t8fUAfGmhdfVtiBzttxAJ5f4IFGVCmiFkSEaKPRlrs9122nTe9fDhRU89nMttj+rjxvgjIJcsmx
	n0BNNtwxHz2Ia4YaaFyELnIJOe4qBnapisrpQJb4LnLqJ/SWXZULa8DDiSW86pSevWd2uLq0o9A
	U+p/ltXtKYSrCRcDttLiOAbo26k9rPxkVXtuSp0CRPC5w+33koAW+PuEQDO1NPmHN21hn+3lZW0
	I1frDtUxG9PpRlUIBTZfYRkB+SeDc0XbRK/lCz2q4gHUDeUpCpvPTg0oo9HFF2ekG1b9W4tpZP4
	GFJ+t19hHuzydAGHLCqESIxztSef6vbaIAdG/fmRZ0gB8a3Rcqv7w==
X-Received: by 2002:a05:6a00:1798:b0:893:12e5:c07c with SMTP id d2e1a72fcca58-897c6d1e604mr15127064b3a.27.1792045988486;
        Wed, 14 Oct 2026 23:33:08 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89d7f51ff63sm1855103b3a.5.2026.10.14.23.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 23:33:07 -0700 (PDT)
Date: Thu, 15 Oct 2026 12:02:59 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Michal Suchanek <msuchanek@suse.de>
Cc: linuxppc-dev@lists.ozlabs.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
	Will Drewry <wad@chromium.org>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>, "Bernhard M. Wiedemann" <bwiedemann@suse.de>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] powerpc: Restore all registers after a traced
 syscall again
Message-ID: <atBzk84t0QT5_ote@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <961c058f3f3e03045552186c083a68a0fde3f43f.1791975972.git.msuchanek@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <961c058f3f3e03045552186c083a68a0fde3f43f.1791975972.git.msuchanek@suse.de>

On Wed, Oct 14, 2026 at 01:06:51PM +0200, Michal Suchanek wrote:
> From: Bernhard M. Wiedemann <bwiedemann@suse.de>
> 
> syscall_exit_prepare() asks the exit assembly to reload all GPRs, CTR
> and XER from pt_regs only if the thread flags contain any of the flags
> in _TIF_SYSCALL_DOTRACE. With the new entry code based GENERIC_ENTRY the
> flags are no longer set.
> 
> This breaks tracers that modify a stopped syscall, for example ones that
> re-execute the syscall instruction by moving the NIP back by 4 at the
> syscall-exit stop with the syscall number put back into r0: the sc then
> runs with r0 = 0, which is __NR_restart_syscall. dettrace fails like
> this with "No filter rule for system call: restart_syscall". A tracer
> that writes r4 at the syscall-exit stop of an sc sees the tracee
> continue with r4 = 0 instead; with a 7.1 kernel both work.
> 
> Check the equivalent syscall_work bits instead, and drop the now unused
> _TIF_SYSCALL_DOTRACE.
> 
> Fixes: bee25f97ad24 ("powerpc: Enable GENERIC_ENTRY feature")
> Cc: stable@vger.kernel.org # 7.2.x: c7585b8e99ad: powerpc: Don't drop _TIF_RESTOREALL on syscall restart
> Cc: stable@vger.kernel.org # 7.2.x
> Assisted-by: LLM
> Signed-off-by: Bernhard M. Wiedemann <bwiedemann@suse.de>
> [ms: reword commit message]
> Signed-off-by: Michal Suchánek <msuchanek@suse.de>
> ---
> A backport also needs commit c7585b8e99ad ("powerpc: Don't drop
> _TIF_RESTOREALL on syscall restart"), without which the flag can still
> be lost.
> 
> v2: rename PPC_SYSCALL_WORK_RESTOREALL to SYSCALL_WORK_RESTOREALL and
> move it from interrupt.c to thread_info.h
> 
> v1: https://lore.kernel.org/linuxppc-dev/4c1da7f31a6603455ec452960af529e4d77f5334.1791826411.git.msuchanek@suse.de/
> 
> Testing: a small tracer (pokes r4 at the syscall-exit stop of an sc,
> and replays a syscall by moving NIP back with a new r0) shows both
> writes lost on a ppc64le and both working on 7.1.8.
> ------------[ cut here ]------------
> // SPDX-License-Identifier: GPL-2.0
> /*
>  * Does a register a tracer writes at the syscall-exit stop of an "sc"
>  * reach the tracee? Checks r4, and a replay: NIP moved back onto the sc
>  * with r0 set to another syscall number.
>  * Build: gcc -O2 -o ppc-exitregs ppc-exitregs.c (powerpc64 only)
>  */
> 
> /* word offsets in struct pt_regs, arch/powerpc/include/uapi/asm/ptrace.h */
> 
> static long do_sc(long nr, long *r4io)
> {
> 	register long r0 __asm__("r0") = nr;
> 	register long r3 __asm__("r3") = 0;
> 	register long r4 __asm__("r4") = *r4io;
> 
> 	__asm__ volatile("sc"
> 			 : "+r"(r0), "+r"(r3), "+r"(r4)
> 			 :
> 			 : "r5", "r6", "r7", "r8", "r9", "r10", "r11", "r12",
> 			   "cr0", "ctr", "xer", "memory");
> 	*r4io = r4;
> 	return r3;
> }
> 
> static long peek(pid_t pid, int w)
> {
> 	errno = 0;
> 	long v = ptrace(PTRACE_PEEKUSER, pid, (void *)(w * sizeof(long)), 0);
> 	if (errno) {
> 		perror("PEEKUSER");
> 		exit(2);
> 	}
> 	return v;
> }
> 
> static void poke(pid_t pid, int w, long v)
> {
> 	if (ptrace(PTRACE_POKEUSER, pid, (void *)(w * sizeof(long)), (void *)v)) {
> 		perror("POKEUSER");
> 		exit(2);
> 	}
> }
> 
> /* Resume to the next syscall stop, which must be one. */
> static void next_stop(pid_t pid)
> {
> 	int st;
> 
> 	ptrace(PTRACE_SYSCALL, pid, 0, 0);
> 	if (waitpid(pid, &st, 0) != pid || !WIFSTOPPED(st) ||
> 	    WSTOPSIG(st) != (SIGTRAP | 0x80)) {
> 		fprintf(stderr, "unexpected wait status %#x\n", st);
> 		exit(2);
> 	}
> }
> 
> int main(void)
> {
> 	pid_t pid = fork();
> 	int st, fail = 0;
> 
> 	if (pid == 0) {
> 		long r4 = 0x1111, r4a, ret;
> 
> 		ptrace(PTRACE_TRACEME, 0, 0, 0);
> 		raise(SIGSTOP);
> 		do_sc(__NR_getpid, &r4);
> 		r4a = r4;
> 		ret = do_sc(__NR_getpid, &r4);
> 		/* bit 0: the tracer's r4 was lost; bit 1: the replay of
> 		 * the second getpid as getppid returned something else */
> 		_exit((r4a != 0x2222) | (ret != getppid()) << 1);
> 	}
> 
> 	waitpid(pid, &st, 0);
> 	ptrace(PTRACE_SETOPTIONS, pid, 0, (void *)PTRACE_O_TRACESYSGOOD);
> 
> 	/* 1: write r4 at the exit stop of getpid */
> 	next_stop(pid);				/* entry */
> 	next_stop(pid);				/* exit */
> 	poke(pid, W_R4, 0x2222);
> 	next_stop(pid);				/* entry of the second getpid */
> 
> 	/* 2: replay the second getpid as getppid */
> 	next_stop(pid);				/* exit */
> 	poke(pid, W_NIP, peek(pid, W_NIP) - 4);
> 	poke(pid, W_R0, __NR_getppid);
> 	next_stop(pid);				/* entry of the replay */
> 	long nr = peek(pid, W_R0);
> 	printf("replayed syscall arrives as nr %ld (%s)\n", nr,
> 	       nr == __NR_getppid ? "getppid, OK" :
> 	       nr == __NR_restart_syscall ? "restart_syscall, BUG" : "?");
> 	if (nr != __NR_getppid) {
> 		fail = 1;
> 		poke(pid, W_R0, __NR_getppid);	/* entry writes do work */
> 	}
> 	next_stop(pid);				/* exit */
> 	ptrace(PTRACE_CONT, pid, 0, 0);
> 	waitpid(pid, &st, 0);
> 	if (!WIFEXITED(st)) {
> 		printf("child did not exit normally: %#x\n", st);
> 		return 2;
> 	}
> 	printf("r4 written at the exit stop: %s\n",
> 	       WEXITSTATUS(st) & 1 ? "lost, BUG" : "kept, OK");
> 	printf("replay result: %s\n",
> 	       WEXITSTATUS(st) & 2 ? "wrong" : "getppid(), OK");
> 	return fail || WEXITSTATUS(st);
> }
> ---
>  arch/powerpc/include/asm/thread_info.h | 15 ++++++++++++---
>  arch/powerpc/kernel/interrupt.c        |  3 +--
>  2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
> index 1e069a2e7ce87..31a7a157bc902 100644
> --- a/arch/powerpc/include/asm/thread_info.h
> +++ b/arch/powerpc/include/asm/thread_info.h
> @@ -142,9 +142,6 @@ void arch_setup_new_exec(void);
>  #define _TIF_SYSCALL_TRACEPOINT	(1<<TIF_SYSCALL_TRACEPOINT)
>  #define _TIF_EMULATE_STACK_STORE	(1<<TIF_EMULATE_STACK_STORE)
>  #define _TIF_SYSCALL_EMU	(1<<TIF_SYSCALL_EMU)
> -#define _TIF_SYSCALL_DOTRACE	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
> -				 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT | \
> -				 _TIF_SYSCALL_EMU)
>  
>  #define _TIF_USER_WORK_MASK	(_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
>  				 _TIF_NEED_RESCHED_LAZY | _TIF_NOTIFY_RESUME | \
> @@ -153,6 +150,18 @@ void arch_setup_new_exec(void);
>  
>  #define _TIF_PERSYSCALL_MASK	(_TIF_RESTOREALL|_TIF_NOERROR)
>  
> +/*
> + * Syscall work after which the exit must reload all registers from
> + * pt_regs: a tracer may have changed any of them at a syscall or seccomp
> + * stop, or under PTRACE_SYSEMU. Audit and the tracepoint are included to
> + * keep the pre-GENERIC_ENTRY behaviour.
> + */
> +#define SYSCALL_WORK_RESTOREALL (SYSCALL_WORK_SECCOMP |			\
> +				 SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
> +				 SYSCALL_WORK_SYSCALL_TRACE |		\
> +				 SYSCALL_WORK_SYSCALL_EMU |		\
> +				 SYSCALL_WORK_SYSCALL_AUDIT)
> +
>  /* Bits in local_flags */
>  /* Don't move TLF_NAPPING without adjusting the code in entry_32.S */
>  #define TLF_NAPPING		0	/* idle thread enabled NAP mode */
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
> index 55f9c0c9922ac..d6a7b6d2b4bd2 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -117,9 +117,8 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
>  		regs->gpr[3] = r3;
>  	}
>  
> -	if (unlikely(ti_flags & _TIF_SYSCALL_DOTRACE)) {
> +	if (unlikely(READ_ONCE(current_thread_info()->syscall_work) & SYSCALL_WORK_RESTOREALL))
>  		ret |= _TIF_RESTOREALL;
> -	}
>  
>  	syscall_exit_to_user_mode(regs);
>  
> -- 
> 2.51.0
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
