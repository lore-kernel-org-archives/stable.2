Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793775856;
	b=NpjsXnshVFrLGCc+13vm8Vq34HAdBjkZeJDJ9XUUatx55eRjqvYO9wPsrE08yc58FQhz
	 spj3qxthxZp/VhzjosThiGgKFFj/Q48SkxmDvvjYCxh8ArC3RiF4TMK9EZeOt1/gC0X90
	 v0HiXptcz4Mc2mkVI8CajFX3QyoCFt0MjfN/gvv+xSv5EIE+mQpq5Q6qQOJKnvYu2zaNP
	 IxpQlnHYgHfIjkJsL+Xdq3HSM5ajLwazSAsXidJUvLmRC2poRj79Uhv5ZkynwzuGOwB43
	 1kbEP8gGwH0Sw91nwanm5N0eb/UZh+ke7TtbmpAtJ1vAeUT/s0snGIbX+eUh+Fd6NXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793775856;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=zgYAfbdg4gkU+laTuhVm1gWIbI8SOd67gBl+57GmbVk=;
	b=hFFDdWM0U9UwGWZmW469Cw/wiPO+rkVoUAlVnr/s1z9zUvf+bJyIv1DLBzf4D8f6/YL2
	 4IjcKuDMzc08Y2yKWSqMigoF14+6xgOkkcWPfShrrB6hIhv/kfGvcLutaDn01GDcUL8IW
	 huQs5o4CoKcKvOFhldG1r3wE2bdnuyO/+IX/4FpReMDmmcxcEk2qG7UGzM3Z/ZRwvCP4E
	 KC0R/d19G1UgJQuBPsCtKZ5cNzQrq4GMq14lUJuA72z4PgSdFtvtczmTZMGENarBEXvyJ
	 GHROqbBw63lqu2gCyyyEkZHq97rA6kmfaLWYtZKr7ZTVDGBAXngshi9yFe2z2394rYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bbApma9Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D9E606A31B;
	Wed,  4 Nov 2026 07:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bbApma9Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A4F1F000C1;
	Wed,  4 Nov 2026 07:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793775855;
	bh=zgYAfbdg4gkU+laTuhVm1gWIbI8SOd67gBl+57GmbVk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bbApma9YpJHwV5I/a2M4mbwCUN66LE1RDMiX6oB+kfNrxDoDV/Ga621XVPmA/lIAM
	 7j+4lNL1LpDqQQ+L+c4T38oRBflcc4lh+Z/pmsS8n92Ap894r8FLNU6sjEKS6tNE1t
	 1hlWOrYY/W73iRq2ymwt57inL7I/DA2IEl6FYRhl1d8BMULWoGvGhRYYsYMN8cRAFg
	 aSg96HdQvvGuzLyukQcAh6hfXMRAqDAzb7xe3emSHYmQiF6tN4fF7TsTU3epROUxKZ
	 uI27AKE2ecn8kyoz7rRgb13myYoYy5F3pztmAHQas80mDOvGXj9Wc9GB1G7fOq+vVg
	 cismcWWMfXT6A==
Message-ID: <bf838fa6-a175-4514-a496-c6ec9b03ac7c@kernel.org>
Date: Wed, 4 Nov 2026 08:04:10 +0100
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
Subject: Re: [PATCH] powerpc/code-patching: Flush the patch area TLB entry
 locally
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Hari Bathini <hbathini@linux.ibm.com>, stable@vger.kernel.org,
 Josef Schlehofer <pepe.schlehofer@gmail.com>
References: <b7916dadd8ef56d417d0cbf69fa9ef2a447a5a3e.1793674111.git.ritesh.list@gmail.com>
 <44406eef-0035-4d6f-a2b0-3647d7c1ea2e@kernel.org>
 <wlqu5lej.ritesh.list@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <wlqu5lej.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 03/11/2026 à 10:12, Ritesh Harjani a écrit :
> "Christophe Leroy (CS GROUP)" <chleroy@kernel.org> writes:
> 
>> Le 03/11/2026 à 03:54, Ritesh Harjani (IBM) a écrit :
>>> patching functions like patch_mem() and patch_instructions(), maps the
>>> target page at the per-cpu text_poke_area, write it, clear the PTE and
>>> then flushes the tlb using flush_tlb_kernel_range(), with interrupts
>>> disabled. flush_tlb_kernel_range() on SMP nohash (e500) does an IPI
>>> based TLB invalidation i.e -
>>>
>>> 	smp_call_function(do_flush_tlb_mm_ipi, NULL, 1);
>>>
>>> ...which will wait for other CPUs but with interrupts off. This can be
>>> caught by lockdep with the following warning:
>>>
>>>     WARNING: kernel/smp.c:917 at smp_call_function_many_cond+0x430/0x818, CPU#1: swapper/0/1
>>>     CPU: 1 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.3.0-rc1-leds-v4 #1 PREEMPT
>>>     Hardware name: Turris 1.1 e500v2 0x80211051 Freescale P2020
>>>     Call Trace:
>>>     [c1915bc0] [c001be04] flush_tlb_kernel_range+0x2c/0x74
>>>     [c1915bd0] [c001ce2c] patch_instructions+0x1b0/0x318
>>>     [c1915c20] [c003113c] bpf_arch_text_copy+0x5c/0xb4
>>>     [c1915c40] [c01c3398] bpf_jit_binary_pack_finalize+0x28/0x8c
>>>     [c1915c60] [c0031770] bpf_int_jit_compile+0x5dc/0x758
>>>     ...
>>>     [c1915dd0] [c102e114] ptp_classifier_init+0x30/0x4c
>>>     [c1915df0] [c102d3a8] sock_init+0xc8/0xe4
>>>     ...
>>>     hardirqs last disabled at (3076): [<c001ceb4>] patch_instructions+0x238/0x318
>>>
>>> Josef confirmed that this was causing a hang (deadlock):
>>>       I think this is why the CZ.NIC Turris 1.1 hangs early in boot with
>>>       CONFIG_JUMP_LABEL=y. On 6.18.44 it hung in 19 of 19 boots and booted
>>>       fine 9 of 9 times with jump labels off. The hang comes while static
>>>       keys are patched and modules are loaded, nothing is printed and the
>>>       watchdog resets the board. OpenWrt keeps jump labels off on these
>>>       boards for now.
>>>
>>> ...which is possible if both cpus are doing similar operations with interrupts
>>> off and doing TLB invalidation using IPI.
>>>
>>> Broadcast TLB invalidation is not needed here since text_poke_area is
>>> a per-cpu area. It is mapped and unmapped with interrupts disabled by
>>> it's own cpu. The only reason I think, if we would need a broadcast tlb
>>> invalidate is, when we want to prevent a stray or malicious write to
>>> this cpu text_poke_area by another CPU. This generally gets solved with
>>> temporary-mm path like how Radix and even x86 implements. However, booke
>>> doesn't implement that, so for now let's ensure we use local tlb
>>> flushing for correctness.
>>
>> This problem was already discussed one year ago, see
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2FPA3P192MB2865C07D634E3B775D003C7F8CD7A%40PA3P192MB2865.EURP192.PROD.OUTLOOK.COM%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C94ba9bffb5d647f9790208df398f6ccb%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639292960305489629%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=RgVxRJOlFSWgNsFSKwLDRinx3kaF4LpSiCaTey8xtic%3D&reserved=0
>>
>> See response from Arnd, a stop_machine() should be done for completeness.
>>
> 
> I will have to take sometime to go over what ARM does here with
> stop_machine(). However, either ways I think, we still need this fix,
> since otherwise P2020 boards gets hung during boot. Thoughts?

That's right, it must be fixed. The global TLB flush must likely be 
changed to a local TLB flush, but that's not enough to get a safe system.

> 
> 
>>>
>>> Fixes: 49e3d8ea6248 ("powerpc/fsl_booke: Enable STRICT_KERNEL_RWX")
>>> Cc: stable@vger.kernel.org
>>> Reported-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
>>> Closes: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F20261026195644.16384-1-pepe.schlehofer%40gmail.com%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C94ba9bffb5d647f9790208df398f6ccb%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639292960305519321%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=A50lEHBZBaX70jGTu38GylmnQvlxVzLalMVXYj2kti0%3D&reserved=0
>>> Tested-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
>>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>> ---
>>>    arch/powerpc/lib/code-patching.c | 21 +++++++++++++++++++--
>>>    1 file changed, 19 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
>>> index 44ff9f684bef..6351342fa5c3 100644
>>> --- a/arch/powerpc/lib/code-patching.c
>>> +++ b/arch/powerpc/lib/code-patching.c
>>> @@ -276,6 +276,23 @@ static int __do_patch_mem_mm(void *addr, unsigned long val, bool is_dword)
>>>    	return err;
>>>    }
>>>
>>> +/*
>>> + * The patch area is per-CPU and only used by its own CPU, with IRQs
>>> + * disabled, so only the local TLB can hold an entry for it.
>>> + *
>>> + * On nohash SMP, flush_tlb_kernel_range() IPIs the other CPUs and waits, which
>>> + * must not be done with IRQs disabled (see smp_call_function_many_cond()), so
>>> + * flush just the local kernel (PID 0) entry.
>>> + * Book3S keeps flush_tlb_kernel_range() which doesn't IPI here.
>>> + */
>>> +static void flush_patch_area(unsigned long addr)
>>> +{
>>> +	if (IS_ENABLED(CONFIG_PPC_BOOK3S))
>>
>> CONFIG_PPC_BOOK3S not consistant with commit message. Are you adressing
>> a problem on e500 only ? on all not book3s ? What about book3s/32 ? What
>> about 8xx ? Even for book3s/64, is it correct at all when
>> mm_patch_enabled() returns false ?
>>
> 
> No we are addressing the problem on all NOHASH platforms. IIUC, all
> !BOOK3S are "nohash". Although some of them maybe UP, so it doesn't
> matter whether a flush_tlb_kernel_range() is called or
> local_flush_tlb_page() - it wouldn't matter. And on others which are SMP
> but do not have STRICT_KERNEL_RWX enabled, they will anyway not go
> through this path - but if they ever do - then we should ensure they too
> do a local_flush_tlb_range() to avoid the same deadlock.
> 
> However, I think, maybe we could use CONFIG_PPC_MMU_NOHASH instead of using
> CONFIG_PPC_BOOK3S, thoughts?

Well they are equivalent, so it doesn't solve the issue I think:

config PPC_MMU_NOHASH
	def_bool y
	depends on !PPC_BOOK3S

What about book3s/64 in hash mode ? What about book3s/32 ? None of them 
implement temporary_mm, so are they covered ?

Christophe

> 
> 
> -ritesh
> 
>>> +		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>>> +	else
>>> +		local_flush_tlb_page(NULL, addr);
>>> +}
>>> +
>>>    static int __do_patch_mem(void *addr, unsigned long val, bool is_dword)
>>>    {
>>>    	int err;
>>> @@ -296,7 +313,7 @@ static int __do_patch_mem(void *addr, unsigned long val, bool is_dword)
>>>    	err = __patch_mem(addr, val, patch_addr, is_dword);
>>>
>>>    	pte_clear(&init_mm, text_poke_addr, pte);
>>> -	flush_tlb_kernel_range(text_poke_addr, text_poke_addr + PAGE_SIZE);
>>> +	flush_patch_area(text_poke_addr);
>>>
>>>    	return err;
>>>    }
>>> @@ -488,7 +505,7 @@ static int __do_patch_instructions(u32 *addr, u32 *code, size_t len, bool repeat
>>>    	err = __patch_instructions(patch_addr, code, len, repeat_instr);
>>>
>>>    	pte_clear(&init_mm, text_poke_addr, pte);
>>> -	flush_tlb_kernel_range(text_poke_addr, text_poke_addr + PAGE_SIZE);
>>> +	flush_patch_area(text_poke_addr);
>>>
>>>    	return err;
>>>    }
>>> --
>>> 2.39.5
>>>

