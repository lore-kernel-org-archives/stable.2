Received: from mta0.migadu.com (out-199.mta0.migadu.com [91.218.175.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B43B371876
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 19:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786736741; cv=none; b=J4S79pBl8oCSbiZ2z4JudVVuRZ1SDU+8qf37dwE7dzARLyIYgSkZdn/YVczk0ZtTIzKcXj2qBfBGZZaYOf9SID6kJckSuJpyy9lha560fThkv777HjSeNu2KtfrDuCAquoelVOM3Q49twYNDQ3bKMSIoYY8pcDIerp44XcK1tuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786736741; c=relaxed/simple;
	bh=z/5tEtgvQR9hXXiwAEKkzI1rrztFMfgGs/20AWZjAAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uhqhaflzTZQrTzAzub3/sbJKXadqOBS6QdBnsaNol8v6hi0V2LPd/8kFPw/oR3xljZL1Jif3fDVIv96Pwb2fwrdXmRbZsycAvHiwp3I965EQ1mpHbfkwa1czYfbe6Q2yeQojtvh5MDYkxUC30O2/xhYVbjzG24Ekhtm0V6z2kho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GE3aAu43; arc=none smtp.client-ip=91.218.175.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GE3aAu43"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=z/5tEtgvQR9hXXiwAEKkzI1rrztFMfgGs/20AWZjAAA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786736737; v=1; x=1787341537;
 b=GE3aAu43WPz1BfZ/3AhYVt21ovzh4b+dg+hWDRf4qPlWVl+o6kacKvrK/fqcHjH+RU6O2Rkv
 k29BY2a0tLoG2hyijh6SKyp6eRtP2l4PH1TCeqTWpRaqwTCwGtwAaulTxu/HmGgrWw1cqvLNUIX
 UhZ6yL7HPoGkqwH1gXBudywc=
X-Envelope-To: stable@vger.kernel.org
Received: from [IPV6:2a03:83e0:1251:27:9295:e585:8bf6:fa24] (2620:10d:c090:500::6:7be4)
	by smtp.migadu.com with ESMTPS id 988c269271074e7b;
	Fri, 14 Aug 2026 19:45:27 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <a3d7bef2-4168-4804-b92d-cdc1d0184584@linux.dev>
Date: Fri, 14 Aug 2026 12:45:24 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf, x86: Fix per-CPU address resolution into an extended
 register
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, x86@kernel.org,
 stable@vger.kernel.org
References: <20260814165557.3405518-1-vineet.gupta@linux.dev>
 <5acb321999d7cc7ebd945c519495a8762501e3cc.camel@gmail.com>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <5acb321999d7cc7ebd945c519495a8762501e3cc.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/26 12:13 PM, Eduard Zingerman wrote:
> On Fri, 2026-08-14 at 09:55 -0700, Vineet Gupta wrote:
>> The destination of the per-CPU address MOV is encoded in ModRM.reg,
>> which is extended by REX.R, but the REX prefix is built with
>> add_1mod(), which sets REX.B. REX.B extends ModRM.rm and SIB.base, and
>> this instruction addresses memory as disp32 with no base, so the bit
>> has no effect at all and the high register bit is simply lost.
>>
>> Every is_ereg() destination therefore resolves to the wrong register,
>> picking whichever one shares the low three bits:
>>
>>    R5 -> RAX    R7 -> RBP    R8 -> RSI    R9 -> RDI
>>
>> With BPF_REG_5, whose reg2hex is 0, the emitted
>>
>>    65 49 03 04 25 <off>	add %gs:<off>,%rax
>>
>> adds the per-CPU offset to RAX rather than R8. The destination keeps
>> the unadjusted address and RAX is clobbered, so the program goes on to
>> dereference a pointer that was never made per-CPU:
>>
>>    BUG: unable to handle page fault for address: 0000607e386a8894
>>    RIP: bpf_prog_707837aafd2aa9ae_update_percpu_data+0x93/0xc9
>>    Call Trace:
>>     __bpf_prog_test_run_raw_tp+0x2dc/0x7d0
>>     __flush_smp_call_function_queue+0x1e9/0xc80
>>    Kernel panic - not syncing: Fatal exception in interrupt
>>
>> R5 is the mildest of the four, aliasing a scratch register and faulting
>> at the store. R7 aliases RBP and would corrupt the frame pointer, R8
>> and R9 alias the argument registers.
>>
>> Use add_2mod() so the register goes through REX.R, matching how
>> add_2reg() places it in ModRM.reg and how emit_priv_frame_ptr()
>> hardcodes 0x4c for the same instruction with R9. Encodings for the
>> non-extended registers are unchanged.
>>
>> Problem showed up when trying to resurrect BPF_GCC CI (selftests built
>> with BPF_GCC).
>>
>> This has gone unnoticed because clang reloads the address into R1
>> before each per-CPU access, so the destination is never an extended
>> register. GCC keeps several per-CPU addresses live at once, and
>> test_progs-bpf_gcc panics the kernel in global_percpu_data/init, where
>> the address of a .percpu variable ends up in R5.
>>
>> Fixes: 7bdbf7446305 ("bpf: add special internal-only MOV instruction to resolve per-CPU addrs")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
>> ---
>>   arch/x86/net/bpf_jit_comp.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index d920772af7d5..1a9fb530adc3 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -1935,7 +1935,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>>   				EMIT_mov(dst_reg, src_reg);
>>   #ifdef CONFIG_SMP
>>   				/* add <dst>, gs:[<off>] */
>> -				EMIT2(0x65, add_1mod(0x48, dst_reg));
>> +				EMIT2(0x65, add_2mod(0x48, 0, dst_reg));
> Ok, so the argument is that because there is a SIB byte in this
> instruction, and the instruction itself is `REX.W + 03 /r | ADD r64, r/m64`,
> operand #1 ModRM:reg, operand #2 ModRM:r/m, the encoding should adjust
> REX.R to extend operand #1, not REX.B as it does now.
>
> I think this is correct. Could you please respin adding an inline
> assembly test with __xlated() matcher, to verify that jit operates
> correctly?

xlated or jited ?

> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

Thanks for the quick review !

-Vineet
