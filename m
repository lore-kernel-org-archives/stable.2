Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC4D383338
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 04:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784781950; cv=none; b=YW+nEA8eXBqSU0z7H+hfMK8pBM5wk5H617lriSHJgIZDOB0CjWS3nHR7DkC2QzTy64V+OZe81Z26jpm9AH+122JRP18Gvw3OJE1s4g77TNqShjut0X9PIL3wpd5neLxs1TAY7UYfmcjJMoLwKJ/AXHfn8VaEWil+OY/1fol8MUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784781950; c=relaxed/simple;
	bh=HU7rck2hLWu20Ofuaaz0t+kQ4YJHcWo9r8w19P/YwqQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VCZBMJZxJLmLoj53cWhmscD343i/csqaBi1HZ/h0VPoLM0FZ2ylGiwwGJEgIL0hfvCcMi6ZWJNy/fa104YwxTxcI++XF92nxKGzqV0e8S+nKcw7qQNIYW1/lzBXbySEd1yhB0JcomG9TK9Y5pST1KgDpRBmXrU8CJLJXqDsBSB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=TJmJcQFz; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="TJmJcQFz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1784781914; x=1785041114;
	bh=wW/CKYwNeSuhKW06GZTjMezL5yo1gpQGxj+dlS5GDO4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=TJmJcQFzfig88fQdwdXhrD2pWD5RTQe/PystMHu0gbgv5QqStm81WNo43i606ISod
	 RkCdxWY/DPLkbTE19tNcmEjMxP8qLUt+rpef/TwR3XGXrvXE0MkNrPRrHQoJpMYj1D
	 hzeZKpVRfEiu6cOceVBbnWUH93pSKLqr7Vsdd917vWKvxwejxosFKVxZ+XjMuff9ZV
	 5IRe1or+xlP8e3a30gCs/1bT3Np22wUxwNF8frKWeXC38Trvxp+3jZxnHHuEwaKTN1
	 TuPFy4i0XJgUZ2OEshG8OIThQLjaYt1tR+9mJFMHJaRexoUNFbdbwOypWgMtUOw9pq
	 F1K69BGbpEjJQ==
Date: Thu, 23 Jul 2026 04:45:09 +0000
To: Nick Desaulniers <ndesaulniers@google.com>
From: Roman Vivchar <rva333@protonmail.com>
Cc: Akari Tsuyukusa <akkun11.open@gmail.com>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Russell King <linux@armlinux.org.uk>, Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, "moderated list:ARM SUB-ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, "open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>, stable@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>, Ard Biesheuvel <ardb@google.com>
Subject: Re: [PATCH] arm: mediatek: fix secondary CPU boot on Thumb-2 kernels with Clang
Message-ID: <zo4Pc8hOijXVSfn0yb52lWWjOU22jy29zRsEh6SBnxdXnpeGNep29fgUzygelrmDDRCioUAggBOSG1qy_38Ex_Lmb08n7eGCyucd3j_VIbU=@protonmail.com>
In-Reply-To: <CAKwvOdnbPKoTy72EvfpKtT9Ne-r+O0j99KFX8OvjGk8ZxsuEGw@mail.gmail.com>
References: <20260722172443.534251-1-akkun11.open@gmail.com> <CAKwvOdnbPKoTy72EvfpKtT9Ne-r+O0j99KFX8OvjGk8ZxsuEGw@mail.gmail.com>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: c09dfc0e9422886d7f682f6a654403b5b201dbbd
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Nick,

On Thursday, July 23rd, 2026 at 12:03 AM, Nick Desaulniers <ndesaulniers@go=
ogle.com> wrote:

> On Wed, Jul 22, 2026 at 10:25=E2=80=AFAM Akari Tsuyukusa <akkun11.open@gm=
ail.com> wrote:

...

> There's definitely some difference between clang and GAS here.
> https://github.com/llvm/llvm-project/issues/211376
>
> I wonder if perhaps a better machine-agnostic assembler-agnostic
> assembler-version-agnostic patch would be something like:
>
> ```
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index f22c50d4bd41..687ee7063a73 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -383,6 +383,7 @@ ENDPROC(__create_page_tables)
>  ENTRY(secondary_startup_arm)
>   THUMB(        badr    r9, 1f          )       @ Kernel is entered in AR=
M.
>   THUMB(        bx      r9              )       @ If this is a Thumb-2 ke=
rnel,
> +ENDPROC(secondary_startup_arm)
>   THUMB(        .thumb                  )       @ switch to Thumb now.
>   THUMB(1:                      )
>  ENTRY(secondary_startup)
> @@ -429,7 +430,6 @@ ARM_BE8(eor r4, r4, r5)                     @
> without using a temp reg.
>                                                 @ (return control reg)
>         ret     r12
>  ENDPROC(secondary_startup)
> -ENDPROC(secondary_startup_arm)
>
>  ENTRY(__secondary_switched)
>  #if defined(CONFIG_VMAP_STACK) && !defined(CONFIG_ARM_LPAE)
>
> ```

I'd like to join conversation because Thumb2 kernel with LLVM seems to
be quite buggy.

I can confirm the proposed fix works for clang, if you're going to send
this patch, feel free to add

Tested-by: Roman Vivchar <rva333@protonmail.com> # mt6572

Leftover from IOMMU debugging shows there's another bug with ftrace.
This probably needs separate thread though...

[    0.193285] Starting tracer 'function_graph'
[    0.210474] ------------[ cut here ]------------
[    0.211120] WARNING: kernel/trace/fgraph.c:761 at ftrace_return_to_handl=
er+0x1c5/0x228, CPU#0: swapper/0/1
[    0.212437] Bad frame pointer: expected c6229ee0, received c132b33b
[    0.212437]   from func iommu_init return to c13011cd
[    0.213962] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G     U       =
       7.2.0-rc4-next-20260721-00134-g49e0d56c7cde-dirty #939 VOLUNTARY
[    0.213980] Tainted: [U]=3DUSER
[    0.213984] Hardware name: Mediatek Cortex-A7 (Device Tree)
[    0.213991] Call trace:
[    0.214000]  unwind_backtrace from show_stack+0x19/0x1a
[    0.214024]  show_stack from dump_stack_lvl+0x37/0x40
[    0.214044]  dump_stack_lvl from __warn+0xbb/0x1f0
[    0.214061]  __warn from warn_slowpath_fmt+0xd1/0x11e
[    0.214078]  warn_slowpath_fmt from ftrace_return_to_handler+0x1c5/0x228
[    0.214099]  ftrace_return_to_handler from return_to_handler+0x17/0x24
[    0.214121] ---[ end trace 0000000000000000 ]---
[    0.222449] ------------[ cut here ]------------
[    0.223075] WARNING: kernel/trace/fgraph.c:826 at ftrace_return_to_handl=
er+0x1e5/0x228, CPU#0: swapper/0/1
[    0.224385] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G     U  W    =
       7.2.0-rc4-next-20260721-00134-g49e0d56c7cde-dirty #939 VOLUNTARY
[    0.224401] Tainted: [U]=3DUSER, [W]=3DWARN
[    0.224405] Hardware name: Mediatek Cortex-A7 (Device Tree)
[    0.224411] Call trace:
[    0.224417]  unwind_backtrace from show_stack+0x19/0x1a
[    0.224435]  show_stack from dump_stack_lvl+0x37/0x40
[    0.224452]  dump_stack_lvl from __warn+0xbb/0x1f0
[    0.224469]  __warn from warn_slowpath_fmt+0x83/0x11e
[    0.224485]  warn_slowpath_fmt from ftrace_return_to_handler+0x1e5/0x228
[    0.224505]  ftrace_return_to_handler from return_to_handler+0x17/0x24
[    0.224526] ---[ end trace 0000000000000000 ]---
[    0.232957] 8<--- cut here ---
[    0.233378] Unable to handle kernel NULL pointer dereference at virtual =
address 00000000 when read
[    0.234580] [00000000] *pgd=3D00000000
[    0.235082] Internal error: Oops: 5 [#1] SMP THUMB2
[    0.235748] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G     U  W    =
       7.2.0-rc4-next-20260721-00134-g49e0d56c7cde-dirty #939 VOLUNTARY
[    0.237485] Tainted: [U]=3DUSER, [W]=3DWARN
[    0.238006] Hardware name: Mediatek Cortex-A7 (Device Tree)
[    0.238756] PC is at vsnprintf+0x32/0x34e
[    0.239309] LR is at vscnprintf+0x11/0x18
[    0.239859] pc : [<c0bedbe6>]    lr : [<c0beec7f>]    psr: 800000b3
[    0.240703] sp : c6229e48  ip : 00000000  fp : 00000000
[    0.241409] r10: c6229ed4  r9 : 00000000  r8 : c30ecc24
[    0.242116] r7 : c6229eb8  r6 : c30ed024  r5 : c6250000  r4 : 00000400
[    0.242995] r3 : c6229ed4  r2 : 00000000  r1 : 00000400  r0 : c30ecc24
[    0.243875] Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA Thumb  Segm=
ent none
[    0.244874] Control: 50c5387d  Table: 8000406a  DAC: 00000051
[    0.245649] Register r0 information: non-slab/vmalloc memory
[    0.246422] Register r1 information: non-paged memory
[    0.247111] Register r2 information: NULL pointer
[    0.247753] Register r3 information: non-slab/vmalloc memory
[    0.248522] Register r4 information: non-paged memory
[    0.249210] Register r5 information: slab task_struct start c6250000 poi=
nter offset 0 size 2432
[    0.250412] Register r6 information: non-slab/vmalloc memory
[    0.251181] Register r7 information: non-slab/vmalloc memory
[    0.251949] Register r8 information: non-slab/vmalloc memory
[    0.252717] Register r9 information: NULL pointer
[    0.253360] Register r10 information: non-slab/vmalloc memory
[    0.254140] Register r11 information: NULL pointer
[    0.254794] Register r12 information: NULL pointer
[    0.255447] Process swapper/0 (pid: 1, stack limit =3D 0x(ptrval))
[    0.256259] Stack: (0xc6229e48 to 0xc622a000)
[    0.256857] 9e40:                   c132b340 c13011cd 00000400 00000008 =
c938c2cc 00000000
[    0.257961] 9e60: 00000000 00000000 429c4c89 00000400 c6250000 c30ecc24 =
c6229eb8 c2f0c8a4
[    0.259065] 9e80: 00000000 c6229ed4 c2f0c8a0 c0beec7f 00000000 c0101f63 =
00000000 c6250000
[    0.260168] 9ea0: 00000000 c132b33b 00000000 00000000 c1390844 c61d6800 =
c6229ecc c0101e45
[    0.261271] 9ec0: c6229ed4 c6229ee8 c61d6800 c6229f48 c0101e23 c3128eec =
00000000 00000000
[    0.262374] 9ee0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    0.263476] 9f00: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    0.264579] 9f20: 00000000 00000000 429c4c89 00000000 00000000 00000000 =
00000000 c139088c
[    0.265683] 9f40: c1390844 c61d6800 c6229f70 c1301953 00000001 00000001 =
00000000 c13019e1
[    0.266786] 9f60: 00000000 c61d6800 00000001 c11e8fd0 c6229f88 c13018a1 =
00000000 c618cc00
[    0.267890] 9f80: c0bf5ee9 00000000 c6229f98 c1301725 00000000 00000000 =
c6229fa8 c0bf5f07
[    0.268993] 9fa0: 00000000 00000000 00000000 c0100151 00000000 00000000 =
00000000 00000000
[    0.270096] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 =
00000000 00000000
[    0.271198] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 =
00000000 00000000
[    0.272296] Call trace:
[    0.272306]  vsnprintf from vscnprintf+0x11/0x18
[    0.273284]  vscnprintf from vpanic+0x11f/0x442
[    0.273911]  vpanic from vpanic+0x1/0x442
[    0.274472] Code: f04f 36ff 43c1 9102 (f89b) 1000
[    0.275129] ---[ end trace 0000000000000000 ]---
[    0.275755] note: swapper/0[1] exited with irqs disabled
[    0.276557] Kernel panic - not syncing: Attempted to kill init! exitcode=
=3D0x0000000b
[    0.277644] ---[ end Kernel panic - not syncing: Attempted to kill init!=
 exitcode=3D0x0000000b ]---

Command line: ftrace=3Dfunction_graph ftrace_filter=3D*iommu* trace_buf_siz=
e=3D40M trace_options=3Dfuncgraph-retval

Config:
$ grep -E "trac|thumb" .config -i
CONFIG_CONTEXT_TRACKING=3Dy
CONFIG_CONTEXT_TRACKING_IDLE=3Dy
CONFIG_TASKS_TRACE_RCU=3Dy
CONFIG_TRACEPOINTS=3Dy
CONFIG_STACKTRACE_SUPPORT=3Dy
CONFIG_CPU_THUMB_CAPABLE=3Dy
CONFIG_ARM_THUMB=3Dy
CONFIG_ARM_THUMBEE=3Dy
CONFIG_THUMB2_KERNEL=3Dy
CONFIG_CMDLINE=3D"..."
CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
CONFIG_HAVE_ARCH_TRACEHOOK=3Dy
CONFIG_HAVE_CONTEXT_TRACKING_USER=3Dy
# CONFIG_IDLE_PAGE_TRACKING is not set
# CONFIG_DMA_FENCE_TRACE is not set
CONFIG_MOUSE_PS2_TRACKPOINT=3Dy
CONFIG_TRACE_GPU_MEM=3Dy
# HW tracing support
# end of HW tracing support
CONFIG_PSTORE_FTRACE=3Dy
# CONFIG_PROC_MEM_FORCE_PTRACE is not set
CONFIG_XZ_DEC_ARMTHUMB=3Dy
# CONFIG_STACKTRACE_BUILD_ID is not set
# CONFIG_NET_DEV_REFCNT_TRACKER is not set
# CONFIG_NET_NS_REFCNT_TRACKER is not set
CONFIG_STACKTRACE=3Dy
CONFIG_RCU_TRACE=3Dy
CONFIG_NOP_TRACER=3Dy
CONFIG_HAVE_FUNCTION_TRACER=3Dy
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy
CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=3Dy
CONFIG_HAVE_EXTRA_IPI_TRACEPOINTS=3Dy
CONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy
CONFIG_TRACE_CLOCK=3Dy
CONFIG_EVENT_TRACING=3Dy
CONFIG_CONTEXT_SWITCH_TRACER=3Dy
CONFIG_TRACING=3Dy
CONFIG_GENERIC_TRACER=3Dy
CONFIG_TRACING_SUPPORT=3Dy
CONFIG_FTRACE=3Dy
CONFIG_TRACEFS_AUTOMOUNT_DEPRECATED=3Dy
CONFIG_BOOTTIME_TRACING=3Dy
CONFIG_FUNCTION_TRACER=3Dy
CONFIG_FUNCTION_GRAPH_TRACER=3Dy
CONFIG_DYNAMIC_FTRACE=3Dy
CONFIG_DYNAMIC_FTRACE_WITH_REGS=3Dy
CONFIG_FUNCTION_SELF_TRACING=3Dy
# CONFIG_STACK_TRACER is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_HWLAT_TRACER is not set
# CONFIG_OSNOISE_TRACER is not set
# CONFIG_TIMERLAT_TRACER is not set
# CONFIG_FTRACE_SYSCALLS is not set
# CONFIG_TRACER_SNAPSHOT is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_FTRACE_MCOUNT_USE_RECORDMCOUNT=3Dy
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
CONFIG_FTRACE_RECORD_RECURSION=3Dy
CONFIG_FTRACE_RECORD_RECURSION_SIZE=3D128
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_TRACE_REMOTE_TEST is not set
# CONFIG_BACKTRACE_VERBOSE is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set

Clang:
ClangBuiltLinux clang version 22.1.5 (https://github.com/llvm/llvm-project.=
git 5ea218a153f4d2f815b8244eab3e4b4ba5e00e6c)

Best regards,
Roman
