Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616855;
	b=f/z923/v+0gvv75oN/hn4a9cjrV+H9sQBeAX7yVAj/HtDIZLKWvS8JwvJP89tInpMLwH
	 KlHGb2FnV2xiaGxRQSJRvuDqI2mxBwIcUHlUOSYbFSHCo68Yt3iryVSYiHokEiiEePv0F
	 MwIcEu5VAAmVJlLxMjNLoVusExHxSEAlZ25F7jJXT98bGULv09egn0wk5xQUeMjAjuuAG
	 J2QtMemZJ9Q8Ta4EOONoArST3nl4VckojRfHa6wgXFyg/wyqvj2eZ1MvuGqTlLvWvABpu
	 4NkXPjQFqWRJzjiwqFPCkExiyfFCY4QiY8s9/afBlja3PPyjljp49+lYjVLvPjGFIrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616855;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=QDgDwZRpPcgIl1VpXeHffTamZF8y2bE2/UZPlXLTFj8=;
	b=P5H6i5qcvZyiDYkLrMMAch99ruLSa3vTN7eBg7AJi4ujUc7+P6wzR+oGXYfwnMrpMZoz
	 Hwe+QOhkI3IiVCAp9Yf/9L6m98P48yUtMpAxAOzwX/pOQ/XwU8OJVbdCMIMtaoLIY7cVK
	 JM2U2pK+NAxMmelHGexkL+W0aKKkDkqDaDahdQ2xJb17nH+FmrIaCF46q8NX2Usc9Jt0O
	 tNDMzzRd+N62CECIxgX1mB8xbLvghfY6D/UdDO+9q9fuJeTrAq6qRLxkp98DSnvrCl2dh
	 8x+L5x7WSU48UJAGr92Or9Gps0Zc/H164di9p8vAI0mIEHdS1BDUx4q05GCVnxvkCqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rtGdzWjE;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50012606A32C;
	Mon,  2 Nov 2026 10:54:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50012606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=rtGdzWjE
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29F2cO2432668;
	Mon, 2 Nov 2026 10:53:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QDgDwZ
	RpPcgIl1VpXeHffTamZF8y2bE2/UZPlXLTFj8=; b=rtGdzWjErVSk4VnDqTHEAg
	K5s0f2Bq3vejt8ZxfS5QhxZuCurrSqgdnQjyayCE4V77V2/0ll2M8MaYZdJBjBgb
	/JwVTRjRqX1/97AdlISxxn6CrqvWJRN5fcemDUMA1kMOZyf9xFPfcP2/CcmAqyO1
	9PbK8O+Cmzs7XsPiv735sTySqFewxXDE2bLctXSBn5baifnpSYb9lp4mT7MUVjmM
	FSqhKYk4iZcik9WTqzsJGzwBLE3JiHn1TmK17DHKrM8MgZtfdpugF57qXH5t5L4f
	RnnxFvGZVp+lGlYB70dVqjrwSidUtaJ0rMFvRV4qU88o372IPIoWZ1crm4xX49iQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn5rhg73w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 10:53:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29JxFB762308;
	Mon, 2 Nov 2026 10:53:49 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnv5gnape-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 10:53:49 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A2Arl0C29295296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Nov 2026 10:53:48 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D903858060;
	Mon,  2 Nov 2026 10:53:47 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58C9258058;
	Mon,  2 Nov 2026 10:53:42 +0000 (GMT)
Received: from [9.43.102.230] (unknown [9.43.102.230])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Nov 2026 10:53:42 +0000 (GMT)
Message-ID: <a9d9d5d1-35c0-45e4-afe7-58af3c5789fa@linux.ibm.com>
Date: Mon, 2 Nov 2026 16:23:40 +0530
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] powerpc: Restore all registers after a traced
 syscall again
To: Michal Suchanek <msuchanek@suse.de>, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, Kees Cook <kees@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
        "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>,
        "Bernhard M. Wiedemann" <bwiedemann@suse.de>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <961c058f3f3e03045552186c083a68a0fde3f43f.1791975972.git.msuchanek@suse.de>
Content-Language: en-US
From: samir <samir@linux.ibm.com>
In-Reply-To: <961c058f3f3e03045552186c083a68a0fde3f43f.1791975972.git.msuchanek@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: iavYIBXUShm_Sxf5jcQ9QxUuIQlXkw5A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MiBTYWx0ZWRfXzL6giz5W5ILH
 aP1knsrmRIQKiyJR1eWuuK6fMPL8WyCsVHL5Q9mWC1KAGggnCUcQlSZUGUO0LlVLTocGkCKgjia
 RtMkUDAk9EDsH8ekPs/e5Q1ASVWD9Qg=
X-Authority-Analysis: v=2.4 cv=LokHWXdc c=1 sm=1 tr=0 ts=6ae86bbe cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=49ibadiY4wVRzWEyoZAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MiBTYWx0ZWRfX8BoJQTwukymP
 NpqpnZ4FBkMQt47VlM+0u+lwBq0KC2VN+sPq9eeAaEp+pn2usHV2BoCBUQ8IrAzUPLyTeOe8d0f
 zdUGb+D7hEND5nIKd67S2Klbi9UK7fcZjbZI3oKg9aUyW517HXzuW3h93C9sT+mH9F73FKpCIv4
 TJ6S2TRMHF+zfEmQ6wNTGQ7fxV8AB/QAjm3cuR++KKHGqjt1wI9S9/nfLig06evvizxIf4ytFzW
 f/ADyl2lJowcPw/aQMDHzRHeitEH63baxkdpTLCWYNTEF1kbGZ1MprvTJfi07p2fDNCylXwm25+
 0SEWINXR3GQodYFsBhIa7mCxP1szWu6sL5ftjyUKO6iohfuLvChzU0kL2LU5+/t+FrCe670KlAW
 u98/ZhADCxPNCRynJXFy0ylD73N6j4+vAfRW0q/sOEykVH//j+rR/9OFicOkGYJTbVR/843o1+u
 0aRJ5Zsu4LobQezdQiw==
X-Proofpoint-GUID: 0h9FKnfKeJqgqpYCyDdI2iSJrtbHlH1K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020042

Hi Michal,

On 14/10/26 4:36 pm, Michal Suchanek wrote:
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
>   arch/powerpc/include/asm/thread_info.h | 15 ++++++++++++---
>   arch/powerpc/kernel/interrupt.c        |  3 +--
>   2 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
> index 1e069a2e7ce87..31a7a157bc902 100644
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
> @@ -153,6 +150,18 @@ void arch_setup_new_exec(void);
>   
>   #define _TIF_PERSYSCALL_MASK	(_TIF_RESTOREALL|_TIF_NOERROR)
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
>   /* Bits in local_flags */
>   /* Don't move TLF_NAPPING without adjusting the code in entry_32.S */
>   #define TLF_NAPPING		0	/* idle thread enabled NAP mode */
> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
> index 55f9c0c9922ac..d6a7b6d2b4bd2 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -117,9 +117,8 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
>   		regs->gpr[3] = r3;
>   	}
>   
> -	if (unlikely(ti_flags & _TIF_SYSCALL_DOTRACE)) {
> +	if (unlikely(READ_ONCE(current_thread_info()->syscall_work) & SYSCALL_WORK_RESTOREALL))
>   		ret |= _TIF_RESTOREALL;
> -	}
>   
>   	syscall_exit_to_user_mode(regs);
>   

I have verified these patches along with the following patch on a 
ppc64le system and observed no issues during testing.
Patch: 
https://lore.kernel.org/lkml/20261023180735.853655-1-renzo@cs.unibo.it/

Test Environment:
Architecture: ppc64le
CPU: 10 cores (80 logical CPUs)
LPAR Mode: Dedicated
Memory: 100 GB


As part of the verification, I ran the LTP syscall tests and Linux 
kernel selftests, particularly the ptrace and seccomp tests.
Tests passed successfully, and no kernel call traces or system crashes 
were observed during testing.

Thanks,
Samir
