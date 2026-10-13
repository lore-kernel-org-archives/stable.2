Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C0940D587;
	Tue, 13 Oct 2026 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899524; cv=none; b=iVB2AXI5tqJS+gWBmHFRS93oLLsZCzvpKni1Vw9aYUelCOp5MiUCdtnNo0Kq7f1TCU9Lif5PFR4e/To0Pp8YXwrvq8woYpjoingp1P1MRld8cYEVJE4OFQVT3ubM54PNmjEk8vBq0o5rnwUAb0EPaPF9RTkpBNe0BSQKzsnKodM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899524; c=relaxed/simple;
	bh=sbiaRiPfalDqc5BV9Pt2OIUaAepwMni/S2d4GPAzfQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BGfjtb9w3gJEUxBpPr7yHv1vxI8+KinVBAzswBXx1VmqRA1INEa6WSsIBznwHeBOFomoHd4NVoIOTw1eGmIuswJqwhIhIhCUvUH8sGaMN6EP+Jf1Udd6cZSt0R//4G5xKEgQlGTwJ9ZMy/+fLuatOJgqUsvXnm5eyIJV1BdWe/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T/FnqOjv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T/FnqOjv"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DDPQxp726064;
	Tue, 13 Oct 2026 13:51:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=U5xnG/
	NtUMReCXQao0FA4/KlTc/AyPWVukE5Q54M1JI=; b=T/FnqOjvF2uAVYBdaxooLh
	4R5TqNLjkVX3lLquQ8cl00tPJ3/w+KJYmde4xz5pXKS40jkxJXC2fDFcxanTSCl1
	7YUrQl4nQI0ptlKN0Ff2jdXRfssA5ETAAKXWK7kfI0XxZb5yON/CHEuvdX6BPa/l
	cGo1FtQRvSeGgx8zeT8nG/vsa0w+Xu44o+64ehPXOSDCNRy7wRh7vxAeeITWf1kE
	nLXL1mENB80vch1n27Hkz+u5mXeBBGj+BwIF3fvw+v1Lj9ltkyk4u++F5/w6mH7N
	MQxLrc0qiQ6AraMkrjdCRsrIFQZymmaJ3d9MymTG5XLpXPsASRnJUIuU2Qbv257Q
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv0e1vs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 13:51:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DCUBcL1440163;
	Tue, 13 Oct 2026 13:51:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wg1xq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 13:51:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DDpcoI56230270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 13:51:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1D5C2005A;
	Tue, 13 Oct 2026 13:51:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44F1820040;
	Tue, 13 Oct 2026 13:51:33 +0000 (GMT)
Received: from [9.39.27.235] (unknown [9.39.27.235])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 13:51:33 +0000 (GMT)
Message-ID: <33d572db-8e3b-4f2c-aee6-380c6c935bdb@linux.ibm.com>
Date: Tue, 13 Oct 2026 19:21:32 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] powerpc: Restore all registers after a traced syscall
 again
To: Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org,
        Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "Bernhard M. Wiedemann" <bwiedemann@suse.de>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <4c1da7f31a6603455ec452960af529e4d77f5334.1791826411.git.msuchanek@suse.de>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <4c1da7f31a6603455ec452960af529e4d77f5334.1791826411.git.msuchanek@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1NCBTYWx0ZWRfX3Kq0dg8RA49p
 tG2J/dlRvjuqqs2BBpZGaFatzC+XHipAy6ElziYJmELOHyWwK02M8D3eGdYMLjMZ66kMdS2swBu
 YlE7OYC7+lbIzBWGDno6uquWhqvgyqYf6vYMCK3Mhyq1lgwtF+SF4JF5t8hPJ7/Io+5ULhtCXL4
 VR1up8HoBTRDzrElMe8HVbPXVyn4GXgCT2/ZO229cIkEtx5rSzRi8QuaK+SmJXcZbfgUiDUbLGx
 aaaVcp6k6V2FT5mPXnKOhAXPxyLBSBag6Ed7Tsx36/grCD4oZpdCEtRbNzP+jHPxYOzW4d+lozr
 RKt/GbRX8WUBQglITgRvZyDeBhMdQZb9gE6GS1q1rvceWayDoXdH1yLlZ/HozCItfSTMPA6hilV
 xjqIUW3+o+OcjCnioHLA+mEP6b3IuVrFPUchi0UxRCXDyJN4C1PYZUiMFa+9WE5rHO6vaVXtyag
 xVfwyxxNgdrM76z5Otg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1NCBTYWx0ZWRfX0WpvdizbK3T4
 Z8CaPS0fRG3uxhVyPjOpke5TQWzz5b6gjxpVOBwPLxOdR1XftL3yZ7dDMqEcWb7yoL87CbKT7T4
 w4I2B8aH6YW6h1iqP2h+bdXWr5y9EOU=
X-Proofpoint-ORIG-GUID: K9jRIhetC1kOBNm8_0bWouxjChTyPUAv
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6ace376f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=A6yvPGAzM_-C_JAlvVIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: XLHQLAgsj-KrxklxXyxzI2AQPlNOT-9o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1011
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130054

Hi Michal,

On 10/12/26 11:08 PM, Michal Suchanek wrote:
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
> It has been pointed out that the newly defined
> PPC_SYSCALL_WORK_RESTOREALL is almost the same as SYSCALL_WORK_ENTER and
> the existing define might be used instead. However, it is not clear if
> this is expected or if this is merely coincidence, and not guaranteed.
> 

They seems to semantically different. So for now, we can keep it separate.

> Testing: a small tracer (pokes r4 at the syscall-exit stop of an sc,
> and replays a syscall by moving NIP back with a new r0) shows both
> writes lost on a ppc64le and both working on 7.1.8.
> ------------[ cut here ]------------
> // SPDX-License-Identifier: GPL-2.0
> /*
>   * Does a register a tracer writes at the syscall-exit stop of an "sc"
>   * reach the tracee? Checks r4, and a replay: NIP moved back onto the sc
>   * with r0 set to another syscall number.
>   * Build: gcc -O2 -o ppc-exitregs ppc-exitregs.c (powerpc64 only)
>   */
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
>   arch/powerpc/include/asm/thread_info.h |  3 ---
>   arch/powerpc/kernel/interrupt.c        | 16 ++++++++++++++--
>   2 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
> index 1e069a2e7ce87..0e8dc71c8d3fe 100644
> --- a/arch/powerpc/include/asm/thread_info.h
> +++ b/arch/powerpc/include/asm/thread_info.h
> @@ -142,9 +142,6 @@ void arch_setup_new_exec(void);
>   #define _TIF_SYSCALL_TRACEPOINT	(1<<TIF_SYSCALL_TRACEPOINT)
>   #define _TIF_EMULATE_STACK_STORE	(1<<TIF_EMULATE_STACK_STORE)
>   #define _TIF_SYSCALL_EMU	(1<<TIF_SYSCALL_EMU)
> -#define _TIF_SYSCALL_DOTRACE	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
> -				 _TIF_SECCOMP | _TIF_SYSCALL_TRACEPOINT | \
> -				 _TIF_SYSCALL_EMU)
>   
>   #define _TIF_USER_WORK_MASK	(_TIF_SIGPENDING | _TIF_NEED_RESCHED | \
>   				 _TIF_NEED_RESCHED_LAZY | _TIF_NOTIFY_RESUME | \
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
> index 55f9c0c9922ac..524c51104e4c9 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -75,6 +75,18 @@ static notrace __always_inline bool prep_irq_for_enabled_exit(bool restartable)
>   	return true;
>   }
>   
> +/*
> + * Syscall work after which the exit must reload all registers from
> + * pt_regs: a tracer may have changed any of them at a syscall or seccomp
> + * stop, or under PTRACE_SYSEMU. Audit and the tracepoint are included to
> + * keep the pre-GENERIC_ENTRY behaviour.
> + */
> +#define PPC_SYSCALL_WORK_RESTOREALL	(SYSCALL_WORK_SECCOMP |		\
> +					 SYSCALL_WORK_SYSCALL_TRACEPOINT | \
> +					 SYSCALL_WORK_SYSCALL_TRACE |	\
> +					 SYSCALL_WORK_SYSCALL_EMU |	\
> +					 SYSCALL_WORK_SYSCALL_AUDIT)
> +

nit: Apart from mukesh's comment,
can we keep the name as SYSCALL_WORK_RESTOREALL instead? It is already in PPC folder.

>   /*
>    * This should be called after a syscall returns, with r3 the return value
>    * from the syscall. If this function returns non-zero, the system call
> @@ -117,9 +129,9 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
>   		regs->gpr[3] = r3;
>   	}
>   
> -	if (unlikely(ti_flags & _TIF_SYSCALL_DOTRACE)) {
> +	if (unlikely(READ_ONCE(current_thread_info()->syscall_work) &
> +		     PPC_SYSCALL_WORK_RESTOREALL))
>   		ret |= _TIF_RESTOREALL;
> -	}
>   
>   	syscall_exit_to_user_mode(regs);
>   
