Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699225;
	b=enMeIoekTzyNAUZpkmISCNn+Aj/tF+JiEfK2Q9YkylpZK74fZEzhVqkHL5pJvgdC18YT
	 TDJPvS49lDpZaeRRX4pPq5hsI0E38uq7IHEzfGpb8LcxdG/1w9lLj2uyUGaPeepHEx666
	 kKZYXGB1H0v0TaeekQcHKMBCkpGFNlIO9pDIcmJVg6QwIF8SujxZAG8D4pwkPlHojmdIZ
	 u5rBZo8QK6UGyOHNAc7en+dTdyXq5v+731TQOlUSS34YTpAibcrS6WyKY3FOoQnk80m2g
	 zsMIyVb+a0RmdVcQcJmYqexHcbjdCWMH7SwSFkyISaQfh4fYJqtsi+rPRXUh7ErpZ6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699225;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type:Content-Transfer-Encoding;
	bh=0JBGFPPLquwWwHmBGhL2h+y4hpkquMXF6f4Dd0IfIRA=;
	b=Yb4cdcNdOlJqJOwgDh0cQuSyduXlnm/CXLZbYTqU6C3g2l+aiVhviNavgYcWRNTSB7rF
	 6Z1i4ZZxMhoKPGPHSiIXkjkrtVgcoxvQfmNljoCZnQ4DXgDqGs8pJMNpnEulhnOGM7szh
	 idy3nFdwbUcySUsVlrRbWPSgmG/GnQ/lhBHd6+R0UFq7mJtYivEqUsp77eRr8u/I4dqHt
	 6VWPJfzz/dJnZN4l5E9VLT/lgiggH0UjI4Q8MAawpoevdhG/CVY9RNkkPBr4N6SY4nQKz
	 wMtUQSdvbSMsK4wAtLEMiokNPUwra+D2kZ4TGm1vwJCDIShtiXX8WkSFMSKHcQbsh3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b6L2Aj81;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98BB606EEAA
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 09:47:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B98BB606EEAA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b6L2Aj81
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso6650914eec.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 01:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793699224; x=1794304024; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0JBGFPPLquwWwHmBGhL2h+y4hpkquMXF6f4Dd0IfIRA=;
        b=b6L2Aj81JYNG0j3AYXRQzcnSaKwkxDIPpZxq6zx2Lea4S+scn7qFA+MO7PX1lJjgBl
         iLcwKu5NaQ1YRFeeeCDeZCO4XYNqR1YpyHTaOFsB/LHL4/8O06i8SlUdCm7gDiT6K97c
         5PibD1eiTY0cWmYG+8tl1tWXPqzVpAKvE1J6JchBcLJaubQJaOyZecNijGvACPoHtP3R
         kL7j5n5p7VR+EcuNGoD3eF7DjhF3TANIdoEjARIv6V8DcmRVJ9s6rzZAW4uUVWXEgrpj
         Ay0yt0HPo0YmxKMSZDT44J5GdlDsdPJowlZJd98SzWPH/mPx9f1VKDLUnBt/XPp/gP8U
         Grrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793699224; x=1794304024;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0JBGFPPLquwWwHmBGhL2h+y4hpkquMXF6f4Dd0IfIRA=;
        b=EccUgO0UvL6uVbnBlGZjOlhQTtRAYnZd1VHe0A3XHteJz6aJovx6gBCXhgrRFXNDqY
         nXNCRYrdIms9azUnyYIiE1kj5hTqg0EtSe8bt8vYE0Dw42ujxOerBuvcLEtWvR2MOKxE
         Ao8/3JctTgt9fqnUnif/L2tH459AyvdSV3IUoqePBEF1N71D0lFcffsAThQXDs6vPJUG
         IZYTaUdixQmiSdtnlNZDA071n7Z9VMzR5x4FWuYOBoOSjTah6+7lSlZ50jg8BiRAg4eK
         +9zAUepRoOtahJ5UFdDpuGyLE4TRACEiucrVDHz+Lx5H4W8nqGCozoL8fpHrKMj3KkZY
         8GUw==
X-Forwarded-Encrypted: i=1; AKwUvBy4B157vNq8eMBtHkmm4e02IaoxZAOGeYEYKKPaH98UNWLO4cXNKZNkXuRXzqbjLz0axxx5s90=@vger.kernel.org
X-Gm-Message-State: APuU4Z87xXXgKMVM/RjQ4haX4CxQAtpb3P1Bv7M9YsRYzqg/0khNIVVe
	EGoPPwwlfwr5y5OuYKYuR6rLOq5jPnPFl3LVQlIU8DRWGi5pMKSEppIk
X-Gm-Gg: AYBFou2gUKkvm8OuxBHqf63YFY0+JJINGpy77cBCBT4Xxb2xPE97LXFM4wgxz8aU7fx
	kFhFoxQHPodC0Fa1buUgZ63iT3kF3amGXYPOE6FXHyhIKLwkV2zevncuJv3BrCjdbtFxUh9Sqrq
	66GvEnTs8hSZsVF5YzHxyK+94b80mzepdhYmlD46MNtc7v3SZY+9OgNQAv6JGQ2aOyi+kVtPlsi
	Luv/7vhrVM1u2LYJIOWmdkzs9M0HebaRKr6+vybLpK5NSbr53KfBoHk496wU8PTJRkmHxo1nIrO
	Rdkua6OlAiYgI61LLo6XLcQGYGXz05VNp6oHqbp3bRRNfGXQxMaR5R8cZvliimQ9GXlVJf459yo
	9cOph+XV6YIi1Uvx+mq7nPJXSGLY/CC5dIqBnL0b9Vp9qezOJP2dTORtMa+DBxaWY0hzIB1ggcS
	cQGMbETZJUNLiy0hP1VNt/yfiNMh+pg5JIdK+rqtXjbHFwX94caExsHiQrf8vOwgZ4SGEmQaocK
	cQpglroV4SPsd8hiqbsRtqTnKy0psVWTSp2HgnVYrRTmu0LsdxfbcQXjm6w0icJQNuRqW3W/Mq+
	fpxToz8NKkIoPOEB+gTV/3zoWMU=
X-Received: by 2002:a05:7301:6405:b0:366:83dd:4704 with SMTP id 5a478bee46e88-36a423dc7f8mr19544762eec.17.1793699223769;
        Tue, 03 Nov 2026 01:47:03 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af4e6sm38668145eec.4.2026.11.03.01.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 01:47:02 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Hari Bathini <hbathini@linux.ibm.com>, stable@vger.kernel.org, Josef Schlehofer <pepe.schlehofer@gmail.com>
Subject: Re: [PATCH] powerpc/code-patching: Flush the patch area TLB entry locally
In-Reply-To: <44406eef-0035-4d6f-a2b0-3647d7c1ea2e@kernel.org>
Date: Tue, 03 Nov 2026 14:42:04 +0530
Message-ID: <wlqu5lej.ritesh.list@gmail.com>
References: <b7916dadd8ef56d417d0cbf69fa9ef2a447a5a3e.1793674111.git.ritesh.list@gmail.com> <44406eef-0035-4d6f-a2b0-3647d7c1ea2e@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> writes:

> Le 03/11/2026 à 03:54, Ritesh Harjani (IBM) a écrit :
>> patching functions like patch_mem() and patch_instructions(), maps the
>> target page at the per-cpu text_poke_area, write it, clear the PTE and
>> then flushes the tlb using flush_tlb_kernel_range(), with interrupts
>> disabled. flush_tlb_kernel_range() on SMP nohash (e500) does an IPI
>> based TLB invalidation i.e -
>> 
>> 	smp_call_function(do_flush_tlb_mm_ipi, NULL, 1);
>> 
>> ...which will wait for other CPUs but with interrupts off. This can be
>> caught by lockdep with the following warning:
>> 
>>    WARNING: kernel/smp.c:917 at smp_call_function_many_cond+0x430/0x818, CPU#1: swapper/0/1
>>    CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.3.0-rc1-leds-v4 #1 PREEMPT
>>    Hardware name: Turris 1.1 e500v2 0x80211051 Freescale P2020
>>    Call Trace:
>>    [c1915bc0] [c001be04] flush_tlb_kernel_range+0x2c/0x74
>>    [c1915bd0] [c001ce2c] patch_instructions+0x1b0/0x318
>>    [c1915c20] [c003113c] bpf_arch_text_copy+0x5c/0xb4
>>    [c1915c40] [c01c3398] bpf_jit_binary_pack_finalize+0x28/0x8c
>>    [c1915c60] [c0031770] bpf_int_jit_compile+0x5dc/0x758
>>    ...
>>    [c1915dd0] [c102e114] ptp_classifier_init+0x30/0x4c
>>    [c1915df0] [c102d3a8] sock_init+0xc8/0xe4
>>    ...
>>    hardirqs last disabled at (3076): [<c001ceb4>] patch_instructions+0x238/0x318
>> 
>> Josef confirmed that this was causing a hang (deadlock):
>>      I think this is why the CZ.NIC Turris 1.1 hangs early in boot with
>>      CONFIG_JUMP_LABEL=y. On 6.18.44 it hung in 19 of 19 boots and booted
>>      fine 9 of 9 times with jump labels off. The hang comes while static
>>      keys are patched and modules are loaded, nothing is printed and the
>>      watchdog resets the board. OpenWrt keeps jump labels off on these
>>      boards for now.
>> 
>> ...which is possible if both cpus are doing similar operations with interrupts
>> off and doing TLB invalidation using IPI.
>> 
>> Broadcast TLB invalidation is not needed here since text_poke_area is
>> a per-cpu area. It is mapped and unmapped with interrupts disabled by
>> it's own cpu. The only reason I think, if we would need a broadcast tlb
>> invalidate is, when we want to prevent a stray or malicious write to
>> this cpu text_poke_area by another CPU. This generally gets solved with
>> temporary-mm path like how Radix and even x86 implements. However, booke
>> doesn't implement that, so for now let's ensure we use local tlb
>> flushing for correctness.
>
> This problem was already discussed one year ago, see 
> https://lore.kernel.org/all/PA3P192MB2865C07D634E3B775D003C7F8CD7A@PA3P192MB2865.EURP192.PROD.OUTLOOK.COM/
>
> See response from Arnd, a stop_machine() should be done for completeness.
>

I will have to take sometime to go over what ARM does here with
stop_machine(). However, either ways I think, we still need this fix,
since otherwise P2020 boards gets hung during boot. Thoughts?


>> 
>> Fixes: 49e3d8ea6248 ("powerpc/fsl_booke: Enable STRICT_KERNEL_RWX")
>> Cc: stable@vger.kernel.org
>> Reported-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
>> Closes: https://lore.kernel.org/all/20261026195644.16384-1-pepe.schlehofer@gmail.com/
>> Tested-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>   arch/powerpc/lib/code-patching.c | 21 +++++++++++++++++++--
>>   1 file changed, 19 insertions(+), 2 deletions(-)
>> 
>> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
>> index 44ff9f684bef..6351342fa5c3 100644
>> --- a/arch/powerpc/lib/code-patching.c
>> +++ b/arch/powerpc/lib/code-patching.c
>> @@ -276,6 +276,23 @@ static int __do_patch_mem_mm(void *addr, unsigned long val, bool is_dword)
>>   	return err;
>>   }
>> 
>> +/*
>> + * The patch area is per-CPU and only used by its own CPU, with IRQs
>> + * disabled, so only the local TLB can hold an entry for it.
>> + *
>> + * On nohash SMP, flush_tlb_kernel_range() IPIs the other CPUs and waits, which
>> + * must not be done with IRQs disabled (see smp_call_function_many_cond()), so
>> + * flush just the local kernel (PID 0) entry.
>> + * Book3S keeps flush_tlb_kernel_range() which doesn't IPI here.
>> + */
>> +static void flush_patch_area(unsigned long addr)
>> +{
>> +	if (IS_ENABLED(CONFIG_PPC_BOOK3S))
>
> CONFIG_PPC_BOOK3S not consistant with commit message. Are you adressing 
> a problem on e500 only ? on all not book3s ? What about book3s/32 ? What 
> about 8xx ? Even for book3s/64, is it correct at all when 
> mm_patch_enabled() returns false ?
>

No we are addressing the problem on all NOHASH platforms. IIUC, all
!BOOK3S are "nohash". Although some of them maybe UP, so it doesn't
matter whether a flush_tlb_kernel_range() is called or
local_flush_tlb_page() - it wouldn't matter. And on others which are SMP
but do not have STRICT_KERNEL_RWX enabled, they will anyway not go
through this path - but if they ever do - then we should ensure they too
do a local_flush_tlb_range() to avoid the same deadlock.

However, I think, maybe we could use CONFIG_PPC_MMU_NOHASH instead of using
CONFIG_PPC_BOOK3S, thoughts?


-ritesh

>> +		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>> +	else
>> +		local_flush_tlb_page(NULL, addr);
>> +}
>> +
>>   static int __do_patch_mem(void *addr, unsigned long val, bool is_dword)
>>   {
>>   	int err;
>> @@ -296,7 +313,7 @@ static int __do_patch_mem(void *addr, unsigned long val, bool is_dword)
>>   	err = __patch_mem(addr, val, patch_addr, is_dword);
>> 
>>   	pte_clear(&init_mm, text_poke_addr, pte);
>> -	flush_tlb_kernel_range(text_poke_addr, text_poke_addr + PAGE_SIZE);
>> +	flush_patch_area(text_poke_addr);
>> 
>>   	return err;
>>   }
>> @@ -488,7 +505,7 @@ static int __do_patch_instructions(u32 *addr, u32 *code, size_t len, bool repeat
>>   	err = __patch_instructions(patch_addr, code, len, repeat_instr);
>> 
>>   	pte_clear(&init_mm, text_poke_addr, pte);
>> -	flush_tlb_kernel_range(text_poke_addr, text_poke_addr + PAGE_SIZE);
>> +	flush_patch_area(text_poke_addr);
>> 
>>   	return err;
>>   }
>> --
>> 2.39.5
>> 
