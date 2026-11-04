Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793789149;
	b=SAw137rxUVNEHLSi6ucf/+1veOUm9989lVJrxH7UY7ElDe439G4/UM8bAerl80XyQ+0Y
	 hqEmWCQ4/m710HAlJoK0hLtB82cYbeontCaJ14x8YkF+EPIxIQJo/lyw0B+m5qMd7APwL
	 iSl5fdy0aCwFHToL1Lf3c4WPWWfKSsbVIm2VOZjQkqsi/MNL8KdY05pMBgk6S8iWpsd+m
	 mSON6lA06qabG7Bsh3J0WcO7gaBf7ktJhaQKY+86fy1ouveYcu/H9bUkFI5v9zm2cETUh
	 4jAbh+TAVr0MRrfn/Ddrjrsk1ARacAdSpc+qKxjuU1sIdM74GsvMl81NEgeqrVujiCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type:Content-Transfer-Encoding;
	bh=eGsTHa5mor1nX7TStszR2xPlHSsRUUzxzbdUmuS4IU4=;
	b=LVl8VoSyyam+TVyB0IQxBKTN2qICaWk05J20lePSJ/5iI6CDaIDvji5XitIWiYTxYVsn
	 szWWrKYwqekv8185jkpkiIfpRNiA4tKcRnM4XgFQ/wUv4jm175wTflkhBZJCx62aCvno9
	 z0SUwhiwY+P9RiP12OJsJwMvPh4osO+VEmcImTX7v4bWpbwazeXTcBBXszxM79wuQT2Xs
	 nlWdMhUjKrHf6PkNXvMn0I1U7jeIQr52kyydK09BdeNPC6ya/fp78bJzbzNGynP0n92Y7
	 U+5XiQLpfC4WQLKebo+BoldGREWvaxUqwk/4IZOqoRSmvDNU7e8/oerHclF7fK9bHGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="T7wF+/1B";
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFB1606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 10:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DFB1606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T7wF+/1B
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36661f953e4so681668eec.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 02:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793789148; x=1794393948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eGsTHa5mor1nX7TStszR2xPlHSsRUUzxzbdUmuS4IU4=;
        b=T7wF+/1B+eIvp6LDihwSY6DXdarZ4T2M6eBrLuR1jc8SFYCJjjvN5vVHWxhM8zP38A
         gDEsvAxScDyofSNzBhL1mH+o4CyVh9PYydqzz6czL12iElZMS8WESHRZ/vS5iulrvodV
         +AQm59oeYFOqi4gccRUWReu7u9Q99JVee0E+LTNwyg4/ae3zikSZEpa8O6BT5FJUM3FR
         DTFoLfbey7MUv7he0ANWvTEnjy1q/e63koh8mNluNuA97ddRn2wmx2v69241RIQE290P
         7kGeunqXNt5+o290XdAWOnK39D+diCkIcMBYWjhjdwQ2ovMnKL0iebPCEK9mjmPmdK70
         YmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793789148; x=1794393948;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eGsTHa5mor1nX7TStszR2xPlHSsRUUzxzbdUmuS4IU4=;
        b=oYF2yPSJjxMDlWmLBWh0Yw1D1LI6DVBeOtkWX4gdAzX5nETz07gdBRHcG2rNlJmrrl
         d5RFDvgvfTfFwpC/URSF+yHaaPw7NubvTTRYRBF1QZ1sN1xcrn+N0h10sAErJ4g1ked4
         RAL1vmalO8ZMnb4n75092pkdRjKiMjdncwzgndaun5wVM2HCB95725gQj+0dLBXJnCkV
         D0WfENujU5jK0Vj1Ywf1DNvlh3SXiyigvscktvyDzTUxs1BCtMN1Pa+xw6CC2GcCX+xI
         P/sxJbJwhLAphTDndiNeDDpWM2d/oSBVyCv73ZFcjw8ivHqmSBTwjIItbT+4U86ldqvS
         uuNg==
X-Forwarded-Encrypted: i=1; AKwUvBwY1Qj8yW1i44Ulv3qaH8OCzt/nUe2iU7jo7X0JSlcSrGHms+dtW4bQktt+0cSp2zj5jOtOOgk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9yA7ntpJrBnCHvF0Ljb/lwDmh5/3kYayVb9JDvvBrrxUmmQj7K
	8sk9caxtjHSnA1uwVL/1UqGQBKi8SxUZUp5H01BEVoXbpdd/j1KvWI6+
X-Gm-Gg: AYBFou3E+ozjbacOXERgxW1OM31c/42M8f0HDbgeb3S7mCLPHiV2UJEtTIDps9ry1qV
	0BLj/kLqk2bynVgBlSjd+v4P6LTZmKLaj01FQnFxXGfG+5yGaJTdSmIuMp6kJyFkkhue28otHKy
	33r8gOZgJLBavtIulL37yp2+LzXFRxW17yZsMp2jvTyKUk1OYdr/ZbYjw3u36CvKukz5r+F16Iw
	JOEcWfp9F5wEWPcAxKYpG6oE5AwiIYX0pSAONDzM6S63dLc3W0nhPHHlDgdKGz3MyylI79rvU7C
	Y/j1bbkDM33j3kAvLh9fCDf3unIHjIwd+sMnazhdWfGPh4wU5ps5W6M6FBmV8u1G0PqGHFgLrqt
	5qHWbAYqj8S0mnQK98RIN+RFGHY+7kD1YF44Py9wkfYfh2+ln7UadbjZoB3bpu2aY+5MOJDjPsg
	qwGDTRkgryaJf5Uu4JZ/kMnyqQy7bNWb3dCuzfDtKDvwzdH050us6vuRvyJAPiabdWlG5kh16MS
	LWm5YCHyB6Lx+8fzAEmWczPo6JfCcG/SxrRqvTpDotx68PP76jNczexm3R8OtkthH7x5oF9J3ML
	MvnkKLafNIuy4lp+yGAS3UmcDrs=
X-Received: by 2002:a05:693c:4009:b0:33b:c24c:d31c with SMTP id 5a478bee46e88-36a42331666mr23336378eec.7.1793789147820;
        Wed, 04 Nov 2026 02:45:47 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca362f38asm7670687eec.0.2026.11.04.02.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 02:45:46 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Hari Bathini <hbathini@linux.ibm.com>, stable@vger.kernel.org, Josef Schlehofer <pepe.schlehofer@gmail.com>
Subject: Re: [PATCH] powerpc/code-patching: Flush the patch area TLB entry locally
In-Reply-To: <bf838fa6-a175-4514-a496-c6ec9b03ac7c@kernel.org>
Date: Wed, 04 Nov 2026 16:07:08 +0530
Message-ID: <qzh06fxn.ritesh.list@gmail.com>
References: <b7916dadd8ef56d417d0cbf69fa9ef2a447a5a3e.1793674111.git.ritesh.list@gmail.com> <44406eef-0035-4d6f-a2b0-3647d7c1ea2e@kernel.org> <wlqu5lej.ritesh.list@gmail.com> <bf838fa6-a175-4514-a496-c6ec9b03ac7c@kernel.org>
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

> Le 03/11/2026 à 10:12, Ritesh Harjani a écrit :
>> "Christophe Leroy (CS GROUP)" <chleroy@kernel.org> writes:
>> 
>>> Le 03/11/2026 à 03:54, Ritesh Harjani (IBM) a écrit :
>>>> patching functions like patch_mem() and patch_instructions(), maps the
>>>> target page at the per-cpu text_poke_area, write it, clear the PTE and
>>>> then flushes the tlb using flush_tlb_kernel_range(), with interrupts
>>>> disabled. flush_tlb_kernel_range() on SMP nohash (e500) does an IPI
>>>> based TLB invalidation i.e -
>>>>
>>>> 	smp_call_function(do_flush_tlb_mm_ipi, NULL, 1);
>>>>
>>>> ...which will wait for other CPUs but with interrupts off. This can be
>>>> caught by lockdep with the following warning:
>>>>
>>>>     WARNING: kernel/smp.c:917 at smp_call_function_many_cond+0x430/0x818, CPU#1: swapper/0/1
>>>>     CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.3.0-rc1-leds-v4 #1 PREEMPT
>>>>     Hardware name: Turris 1.1 e500v2 0x80211051 Freescale P2020
>>>>     Call Trace:
>>>>     [c1915bc0] [c001be04] flush_tlb_kernel_range+0x2c/0x74
>>>>     [c1915bd0] [c001ce2c] patch_instructions+0x1b0/0x318
>>>>     [c1915c20] [c003113c] bpf_arch_text_copy+0x5c/0xb4
>>>>     [c1915c40] [c01c3398] bpf_jit_binary_pack_finalize+0x28/0x8c
>>>>     [c1915c60] [c0031770] bpf_int_jit_compile+0x5dc/0x758
>>>>     ...
>>>>     [c1915dd0] [c102e114] ptp_classifier_init+0x30/0x4c
>>>>     [c1915df0] [c102d3a8] sock_init+0xc8/0xe4
>>>>     ...
>>>>     hardirqs last disabled at (3076): [<c001ceb4>] patch_instructions+0x238/0x318
>>>>
>>>> Josef confirmed that this was causing a hang (deadlock):
>>>>       I think this is why the CZ.NIC Turris 1.1 hangs early in boot with
>>>>       CONFIG_JUMP_LABEL=y. On 6.18.44 it hung in 19 of 19 boots and booted
>>>>       fine 9 of 9 times with jump labels off. The hang comes while static
>>>>       keys are patched and modules are loaded, nothing is printed and the
>>>>       watchdog resets the board. OpenWrt keeps jump labels off on these
>>>>       boards for now.
>>>>
>>>> ...which is possible if both cpus are doing similar operations with interrupts
>>>> off and doing TLB invalidation using IPI.
>>>>
>>>> Broadcast TLB invalidation is not needed here since text_poke_area is
>>>> a per-cpu area. It is mapped and unmapped with interrupts disabled by
>>>> it's own cpu. The only reason I think, if we would need a broadcast tlb
>>>> invalidate is, when we want to prevent a stray or malicious write to
>>>> this cpu text_poke_area by another CPU. This generally gets solved with
>>>> temporary-mm path like how Radix and even x86 implements. However, booke
>>>> doesn't implement that, so for now let's ensure we use local tlb
>>>> flushing for correctness.
>>>
>>> This problem was already discussed one year ago, see
>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2FPA3P192MB2865C07D634E3B775D003C7F8CD7A%40PA3P192MB2865.EURP192.PROD.OUTLOOK.COM%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C94ba9bffb5d647f9790208df398f6ccb%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639292960305489629%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=RgVxRJOlFSWgNsFSKwLDRinx3kaF4LpSiCaTey8xtic%3D&reserved=0
>>>
>>> See response from Arnd, a stop_machine() should be done for completeness.
>>>
>> 
>> I will have to take sometime to go over what ARM does here with
>> stop_machine(). However, either ways I think, we still need this fix,
>> since otherwise P2020 boards gets hung during boot. Thoughts?
>
> That's right, it must be fixed. The global TLB flush must likely be 
> changed to a local TLB flush, but that's not enough to get a safe system.
>

Ok then, will spend sometime looking at how other archs handles this.

Although IIUC - even with TLB invalidation using IPI there is a window
where the remote cpu could use a stale tlb. But the window is too small,
however, with only local tlb invalidate, if in case the remote cpu has a
stale TLB, it will never get flushed.

>> 
>> 
>>>>
>>>> Fixes: 49e3d8ea6248 ("powerpc/fsl_booke: Enable STRICT_KERNEL_RWX")
>>>> Cc: stable@vger.kernel.org
>>>> Reported-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
>>>> Closes: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F20261026195644.16384-1-pepe.schlehofer%40gmail.com%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C94ba9bffb5d647f9790208df398f6ccb%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639292960305519321%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=A50lEHBZBaX70jGTu38GylmnQvlxVzLalMVXYj2kti0%3D&reserved=0
>>>> Tested-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
>>>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>>> ---
>>>>    arch/powerpc/lib/code-patching.c | 21 +++++++++++++++++++--
>>>>    1 file changed, 19 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
>>>> index 44ff9f684bef..6351342fa5c3 100644
>>>> --- a/arch/powerpc/lib/code-patching.c
>>>> +++ b/arch/powerpc/lib/code-patching.c
>>>> @@ -276,6 +276,23 @@ static int __do_patch_mem_mm(void *addr, unsigned long val, bool is_dword)
>>>>    	return err;
>>>>    }
>>>>
>>>> +/*
>>>> + * The patch area is per-CPU and only used by its own CPU, with IRQs
>>>> + * disabled, so only the local TLB can hold an entry for it.
>>>> + *
>>>> + * On nohash SMP, flush_tlb_kernel_range() IPIs the other CPUs and waits, which
>>>> + * must not be done with IRQs disabled (see smp_call_function_many_cond()), so
>>>> + * flush just the local kernel (PID 0) entry.
>>>> + * Book3S keeps flush_tlb_kernel_range() which doesn't IPI here.
>>>> + */
>>>> +static void flush_patch_area(unsigned long addr)
>>>> +{
>>>> +	if (IS_ENABLED(CONFIG_PPC_BOOK3S))
>>>
>>> CONFIG_PPC_BOOK3S not consistant with commit message. Are you adressing
>>> a problem on e500 only ? on all not book3s ? What about book3s/32 ? What
>>> about 8xx ? Even for book3s/64, is it correct at all when
>>> mm_patch_enabled() returns false ?
>>>
>> 
>> No we are addressing the problem on all NOHASH platforms. IIUC, all
>> !BOOK3S are "nohash". Although some of them maybe UP, so it doesn't
>> matter whether a flush_tlb_kernel_range() is called or
>> local_flush_tlb_page() - it wouldn't matter. And on others which are SMP
>> but do not have STRICT_KERNEL_RWX enabled, they will anyway not go
>> through this path - but if they ever do - then we should ensure they too
>> do a local_flush_tlb_range() to avoid the same deadlock.
>> 
>> However, I think, maybe we could use CONFIG_PPC_MMU_NOHASH instead of using
>> CONFIG_PPC_BOOK3S, thoughts?
>
> Well they are equivalent, so it doesn't solve the issue I think:
>
> config PPC_MMU_NOHASH
> 	def_bool y
> 	depends on !PPC_BOOK3S
>
> What about book3s/64 in hash mode ? What about book3s/32 ? None of them 
> implement temporary_mm, so are they covered ?
>

They both use TLBIE (global/broadcast TLB invalidation). With that we
don't need to use IPI for TLB invalidation.

> Christophe
>

Thanks for the review comments. Let me check on the stop_machine() or
other alternative to fix the security gap as well. At the moment, I have
my hands full with couple of other things, but hopefully I can come back
on this once they are somewhat taken care of.

-ritesh

>> 
>> 
>> -ritesh
>> 
>>>> +		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>>>> +	else
>>>> +		local_flush_tlb_page(NULL, addr);
>>>> +}
>>>> +
>>>>    static int __do_patch_mem(void *addr, unsigned long val, bool is_dword)
>>>>    {
>>>>    	int err;
>>>> @@ -296,7 +313,7 @@ static int __do_patch_mem(void *addr, unsigned long val, bool is_dword)
>>>>    	err = __patch_mem(addr, val, patch_addr, is_dword);
>>>>
>>>>    	pte_clear(&init_mm, text_poke_addr, pte);
>>>> -	flush_tlb_kernel_range(text_poke_addr, text_poke_addr + PAGE_SIZE);
>>>> +	flush_patch_area(text_poke_addr);
>>>>
>>>>    	return err;
>>>>    }
>>>> @@ -488,7 +505,7 @@ static int __do_patch_instructions(u32 *addr, u32 *code, size_t len, bool repeat
>>>>    	err = __patch_instructions(patch_addr, code, len, repeat_instr);
>>>>
>>>>    	pte_clear(&init_mm, text_poke_addr, pte);
>>>> -	flush_tlb_kernel_range(text_poke_addr, text_poke_addr + PAGE_SIZE);
>>>> +	flush_patch_area(text_poke_addr);
>>>>
>>>>    	return err;
>>>>    }
>>>> --
>>>> 2.39.5
>>>>
