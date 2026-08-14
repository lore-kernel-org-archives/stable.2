Received: from mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95234282F13
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786743048; cv=none; b=r6y3qoEq8lElu8hnP4TZhNfA8iew7dkPJJJm2W6Fatn/j47Bp46Z5ym97Ch3ti4piY1urIO2AXlcfnWIUxRvdpCa+tcCfD8Zq/9Ggv0ZQp989vslVmfXR+wht/6a8wwRzfqJOE+nC2qB0al+dI8u7ksr6rXEMBM9wV3Pg0mo6Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786743048; c=relaxed/simple;
	bh=Jr4sThmu2vDjuAEve/xXgEyRXV4dsq0dcWUeP7zsD1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ua2QoaPs6Z8gwaCcum/Tlz4UFRilEVRbpuB61vm0up3B1C/PXDwRJ56g1Ehws7IhnaVU43bXYhHe4h0nPfKqGg8uKuPDb66QwJdlI3Is4G5hd083wG1xivNFb81AnIiJkCOTBirKMrSJEG516ifN/6awtie3F6X8qEBZ4Ev2zYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DLmrrdWB; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DLmrrdWB"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Jr4sThmu2vDjuAEve/xXgEyRXV4dsq0dcWUeP7zsD1A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786743043; v=1; x=1787347843;
 b=DLmrrdWBpDSxbIH5rILAxAGMSz4nwTmvK74GUOJsVxsyGPAYOYT50Uez5u+G/bc1xuicQThQ
 e0mXpC1wWYu1n6dYADUElgISzPHwOjxN7kUjk/HIxRr3HtJamo/HSSMJFgTNxSgUznqO48wwHGF
 puZj/EhgEMh4tkujda9jzVks=
X-Envelope-To: stable@vger.kernel.org
Received: from [IPV6:2a03:83e0:1251:27:9295:e585:8bf6:fa24] (2620:10d:c090:500::6:7be4)
	by smtp.migadu.com with ESMTPS id 59543f0d2f00810e;
	Fri, 14 Aug 2026 21:30:43 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <bb3f851f-5c1f-43f3-94c2-951a0abea409@linux.dev>
Date: Fri, 14 Aug 2026 14:30:35 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 1/2] bpf, x86: Fix per-CPU address resolution into
 an extended register
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, x86@kernel.org,
 stable@vger.kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
References: <20260814203248.3714536-2-vineet.gupta@linux.dev>
 <eba560e6a2352222c0ff0e4a8cc4d0525abe3ac1306d42958455ec2c2494801b@mail.kernel.org>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <eba560e6a2352222c0ff0e4a8cc4d0525abe3ac1306d42958455ec2c2494801b@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/26 2:20 PM, bot+bpf-ci@kernel.org wrote:
>> bpf, x86: Fix per-CPU address resolution into an extended register
>>
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
> Should this include Eduard Zingerman's Reviewed-by tag? In the v2 review
> thread, Eduard provided "Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>"
> and specifically noted "Please don't drop acks."
>
> https://lore.kernel.org/bpf/3338fd93155ac14b3b824ce232ae7be288072608.camel@gmail.com/

Yes I missed it. Will carry it in v3.

>> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> index de7515ea1bea..276d076d2993 100644
>> --- a/arch/x86/net/bpf_jit_comp.c
>> +++ b/arch/x86/net/bpf_jit_comp.c
>> @@ -1887,7 +1887,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
>>   				EMIT_mov(dst_reg, src_reg);
>>   #ifdef CONFIG_SMP
>>   				/* add <dst>, gs:[<off>] */
>> -				EMIT2(0x65, add_1mod(0x48, dst_reg));
>> +				EMIT2(0x65, add_2mod(0x48, 0, dst_reg));
>>   				EMIT3(0x03, add_2reg(0x04, 0, dst_reg), 0x25);
>>   				EMIT((u32)(unsigned long)&this_cpu_off, 4);
>>   #endif
> In the v1 review thread, Eduard requested an inline assembly test with
> __xlated() matcher to verify the JIT generates correct code for per-CPU
> address resolution. A test was apparently added in v2 as patch 2/2
> (tools/testing/selftests/bpf/progs/verifier_percpu_addr.c), but that test is
> not present in this commit.
>
> Given that this bug affects all four extended registers (R5, R7, R8, R9)
> and can cause kernel panics or frame pointer corruption, should the test be
> included here to verify the fix works correctly?
>
> https://lore.kernel.org/bpf/5acb321999d7cc7ebd945c519495a8762501e3cc.camel@gmail.com/

Per BPF convention tests are generally separate patch and it is in 2/2 
of this series.

Thx,
-Vineet

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31839526403

