Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40DE346A10;
	Thu, 27 Aug 2026 21:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787866137; cv=none; b=Qq8wE9zI6c4VDWnpr0Ohp45JAQ32CokRuAaA0jIq9tsWXXi8IM85kk0AFreE/CpDdJptXEkopAyINQC5Ytyuy1Tgk1L5wTwd3y/blEBji2HGeVH5pfld6yMBvV64nW/Lxtdm/Bmx56jfSXS99I3T8Bxme9EJVGzYtLYQadfSNtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787866137; c=relaxed/simple;
	bh=kmAi9SBLrfBtep1iU91ks7O2k9RfxJ6eRNDdv0oTQjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eb3afutgJYDsIfmmyDMIl7a/0UPr7o0FJvJVmEa4UYDjMio6NOJXek2IXfcpmQiUmLt+1qwif3S9bbTML8lzjazuoKOm9kmOS91w14zaKKAg5jSPhram6KNWMAiNz3AlXj1QqakpVCNHzsOCpEncP41M+WDzKuOPbtge6kCC7AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=LdqFMIPg; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="LdqFMIPg"
Received: from [IPV6:2601:646:8081:8d71:3f7f:7d26:39c2:b9e0] ([IPv6:2601:646:8081:8d71:3f7f:7d26:39c2:b9e0])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 67RLQAam1697445
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 27 Aug 2026 14:26:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 67RLQAam1697445
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026072801; t=1787865972;
	bh=7WJk4Br9+7iVByXsepRH9Cfq6FIiLe5JpuE54pSF3cE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LdqFMIPgWSZgApassNdQU/pmQxMLVDSCqpAj4frBjQDej9foEkhr6MSYDc3VVIm21
	 QCsMsrqBxMqq4mm+tFPSXX0a76JCFt2JPlfE7gNJiga5KoH/m1GlVuywoibl658c/E
	 WMpIAgs+yprGkNvImIdno5KQZ8DI+TUC5PxMd5M3amJYen3Bo0UtiMem63DViMEBS7
	 cFP2cvgtppT81gOcN8FMLj/nlDLl40QgTPovIKGGK/2w5bLUSVmzHaYB+xe2BU2qrh
	 as+II1kuYoYieyeKi7MOkhytB8QkbygG2k/Jb/dl+F4x/Yt+Gu6Qr/KX1Pp9LV0tYa
	 8NgLkf+CULKJQ==
Message-ID: <2efff83b-6c33-4453-9eb6-5cbda8f6380e@zytor.com>
Date: Thu, 27 Aug 2026 14:26:05 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/fred: Fix stack depot filtering of FRED event
 stacks
To: Yuanhe Shu <xiangzao@linux.alibaba.com>, tglx@kernel.org, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org
Cc: xin@zytor.com, luto@kernel.org, jpoimboe@kernel.org, peterz@infradead.org,
        rostedt@goodmis.org, akpm@linux-foundation.org, rdunlap@infradead.org,
        elver@google.com, andreyknvl@gmail.com, glider@google.com,
        gor@linux.ibm.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260827150022.1618235-1-xiangzao@linux.alibaba.com>
 <20260827150022.1618235-3-xiangzao@linux.alibaba.com>
Content-Language: en-US, sv-SE
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20260827150022.1618235-3-xiangzao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This all makes sense to me.

I would in fact like to see the IDT-only code isolated so it can be poisoned
if not used. The FRED code probably should be as well, although it is also
used by KVM -- and potentially by other auxiliary users in the future -- so it
might not make as much sense there.

	-hpa


On 2026-08-27 08:00, Yuanhe Shu wrote:
> With FRED, events are delivered to asm_fred_entrypoint_user and
> asm_fred_entrypoint_kernel in .noinstr.text, not to the IDT stubs, which
> are the only code covered by __irqentry_text_start..__irqentry_text_end.
> in_irqentry_text() therefore never recognizes the event entry point and
> filter_irq_stacks() does not truncate FRED event stacks: every trace
> saved from interrupt or exception context by stack depot users such as
> KASAN alloc/free tracking or SLUB object tracking combines the event path
> with the arbitrarily interrupted context.  The number of unique stacks
> grows with the product of both and the depot is exhausted.
> 
> Observed on a dual-socket FRED-capable system with KASAN (generic,
> inline) and SLUB object tracking enabled, on both sockets roughly 80
> minutes after boot, once the depot had reached its maximum of 8192 pools
> (128 MiB):
> 
>   Stack depot reached limit capacity
>   WARNING: CPU: 286 PID: 128614 at lib/stackdepot.c:271 depot_alloc_stack+0x158/0x170
> 
> The traces had the expected shape: an interrupt side trace ran through
> asm_fred_entrypoint_kernel into the frames of the task it had
> interrupted.  New traces are dropped (handle 0) from then on and the
> depot never shrinks, so tracking stays dead until reboot.  (Splat from a
> 6.6 based kernel; filter_irq_stacks() and the FRED entry layout are
> unchanged in mainline.)
> 
> The entry points cannot be brought inside that range.  x86 has no
> .irqentry.text: commit f0178fc01fe4 ("x86/entry: Unbreak
> __irqentry_text_start/end magic") dropped it from the linker script and
> emits the markers as labels around the sequentially laid out IDT stubs
> instead, exactly because the entry rework had moved that code into
> .noinstr.text and broken the function graph tracer and
> filter_irq_stacks(); __irq_entry has been __invalid_section since.
> Those labels live inside entry_64.S and wrap the IDT stubs which
> asm/idtentry.h emits into .entry.text, so the linker cannot place
> another translation unit between them, and the FRED entry points cannot
> join that block without leaving .noinstr.text.  Architectures which do
> have the section fixed the same symptom locally, e.g.
> commit f6794950f0e5 ("arm64: set __exception_irq_entry with __irq_entry
> as a default") and commit 45c9f2b856a0 ("s390/entry: Mark IRQ entries
> to fix stack depot warnings").
> 
> Every FRED event leaves a return address in the FRED entry text: the
> return address of the call to fred_entry_from_user/kernel, or a frame of
> asm_fred_entry_from_kvm(), which the core entry code uses to forward VMX
> interrupts and NMIs acknowledged as part of the VM-Exit; see
> commit 0701c9e17bd9 ("x86/kvm/vmx: Move IRQ/NMI dispatch from KVM
> into x86 core").  So bracket it with __fred_entry_text_start/end, the
> same way the IDT stubs are bracketed, and report that range from
> arch_in_irqentry_text().  Verified on that system with the fix
> backported: traces from FRED event context now end at
> asm_fred_entrypoint_kernel (/sys/kernel/debug/slab/*/alloc_traces) and
> the pool count levels off a few minutes after boot instead of climbing
> to the limit.
> 
> Truncating synchronous exception stacks only restores parity with the IDT
> range, which has always covered the exception stubs too.  Syscalls enter
> through asm_fred_entrypoint_user as well, but there the entry frame is
> already the last trace entry, so filter_irq_stacks() returns the full
> trace unchanged.  The function graph tracer uses the same markers and has
> the same gap; it can be converted separately.
> 
> This is not limited to FRED hardware: with CONFIG_X86_FRED=y the KVM
> forwarding path above runs the FRED dispatch code even when the kernel
> itself uses the IDT, so KVM host stacks take the same untruncated path
> on non-FRED systems, albeit from a mostly fixed vcpu_run chain.
> 
> Fixes: 14619d912b65 ("x86/fred: FRED entry/exit and dispatch code")
> Cc: stable@vger.kernel.org # v6.9+
> Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
> ---
> Build tested with CONFIG_X86_FRED=y and CONFIG_X86_KERNEL_IBT=y, with
> and without CONFIG_KVM_INTEL: __fred_entry_text_start lands on the
> 4K-aligned asm_fred_entrypoint_user and the new range stays inside
> .noinstr.text.
> 
> Note for stable: depends on patch 1/2.
> 
>  arch/x86/Kconfig                |  1 +
>  arch/x86/entry/entry_64_fred.S  | 14 ++++++++++++++
>  arch/x86/include/asm/sections.h |  1 +
>  arch/x86/kernel/stacktrace.c    | 13 +++++++++++++
>  4 files changed, 29 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 15fd9ec5ecac..78b8eb4a925f 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -555,6 +555,7 @@ config X86_CPU_RESCTRL_INTEL_AET
>  config X86_FRED
>  	bool "Flexible Return and Event Delivery"
>  	depends on X86_64
> +	select ARCH_HAS_IN_IRQENTRY_TEXT
>  	help
>  	  When enabled, use Flexible Return and Event Delivery
>  	  instead of the legacy SYSCALL/SYSENTER/IDT architecture for
> diff --git a/arch/x86/entry/entry_64_fred.S b/arch/x86/entry/entry_64_fred.S
> index b98f8945dfff..620def9039a3 100644
> --- a/arch/x86/entry/entry_64_fred.S
> +++ b/arch/x86/entry/entry_64_fred.S
> @@ -36,6 +36,17 @@
>   */
>  	.align 4096
>  
> +/*
> + * Bounds of the FRED event entry text.  Every event delivered by FRED
> + * enters here, including events which the core entry code forwards
> + * through asm_fred_entry_from_kvm().  This is the FRED counterpart of
> + * __irqentry_text_start..__irqentry_text_end and lets
> + * in_irqentry_text() find the event entry point of a stack, see
> + * arch_in_irqentry_text().
> + */
> +	.globl __fred_entry_text_start
> +__fred_entry_text_start:
> +
>  SYM_CODE_START_NOALIGN(asm_fred_entrypoint_user)
>  	FRED_ENTER
>  	call	fred_entry_from_user
> @@ -150,3 +161,6 @@ SYM_FUNC_START(asm_fred_entry_from_kvm)
>  
>  SYM_FUNC_END(asm_fred_entry_from_kvm)
>  #endif
> +
> +	.globl __fred_entry_text_end
> +__fred_entry_text_end:
> diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
> index 30e8ee7006f9..1b52239fcefd 100644
> --- a/arch/x86/include/asm/sections.h
> +++ b/arch/x86/include/asm/sections.h
> @@ -5,6 +5,7 @@
>  #include <asm-generic/sections.h>
>  #include <asm/extable.h>
>  
> +extern char __fred_entry_text_start[], __fred_entry_text_end[];
>  extern char __relocate_kernel_start[], __relocate_kernel_end[];
>  extern char __brk_base[], __brk_limit[];
>  extern char __end_rodata_aligned[];
> diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
> index ee117fcf46ed..4af7e52d9d97 100644
> --- a/arch/x86/kernel/stacktrace.c
> +++ b/arch/x86/kernel/stacktrace.c
> @@ -9,6 +9,7 @@
>  #include <linux/stacktrace.h>
>  #include <linux/export.h>
>  #include <linux/uaccess.h>
> +#include <asm/sections.h>
>  #include <asm/stacktrace.h>
>  #include <asm/unwind.h>
>  
> @@ -128,3 +129,15 @@ void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
>  	}
>  }
>  
> +#ifdef CONFIG_X86_FRED
> +bool arch_in_irqentry_text(unsigned long addr)
> +{
> +	/*
> +	 * FRED delivers events to entry points in .noinstr.text, which
> +	 * __irqentry_text_start..__irqentry_text_end does not cover.  See
> +	 * __fred_entry_text_start in entry_64_fred.S.
> +	 */
> +	return addr >= (unsigned long)__fred_entry_text_start &&
> +	       addr < (unsigned long)__fred_entry_text_end;
> +}
> +#endif

