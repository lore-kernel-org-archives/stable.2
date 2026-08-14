Received: from mta1.migadu.com (out-65.mta1.migadu.com [95.215.58.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F8E3E3C74
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 23:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786751711; cv=none; b=AynkFSGRj1t2A+AnECWxLkkN+ArvoUCw/agXTwEz+/+vc4uKSCpGaq9LBkA8pxZEPhnPz56Fl7qOluv1Unr7rHyH1JWp+OKIbi/TpJvQ4nBiIu0R5P3G6Z77j8HPXWq015l3CLGG8Iv6OMw3XLzJnu1tZNQcahfnN2ivqfcT7jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786751711; c=relaxed/simple;
	bh=RMN5UefWE03kCQbDYhAuTCIAqJYIWwwHF4nusHD7CFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t/MqqbXzPAifHfgtVZig2hRWRJWzVtvn8Lc1LNuewybz2ZDBU9BrxjylSbesA3RCJdBT4gr3k91ThZmNnHrXytOghczDOy8jN7fnww6fFoiMcbPfX/r0LCdDDRaGNaAA2E7FR+3L4z2UyozfFT1Ay8jUAhRgLSpfufnsKULGKv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QNWmLGwm; arc=none smtp.client-ip=95.215.58.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QNWmLGwm"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RMN5UefWE03kCQbDYhAuTCIAqJYIWwwHF4nusHD7CFQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786751708; v=1; x=1787356508;
 b=QNWmLGwmYUJFSHBTi+G3wcunFWovhJnpG9zZzF4bZx5wlKrUZe0Q+qgo2RjIun05RXEDczJ/
 1K1eQe6118hfSEcnsA/+RSZmkCdK850pNqMDY0QnPCpgFLx3L77iOo8+0lxti6aNuI0jLEWnBJ+
 ZOduXhLFNqVABVAWsDmsGUJI=
X-Envelope-To: stable@vger.kernel.org
Received: from [IPV6:2a03:83e0:1251:27:9295:e585:8bf6:fa24] (2620:10d:c090:500::6:7be4)
	by smtp.migadu.com with ESMTPS id 39cf3d840af50284;
	Fri, 14 Aug 2026 23:55:08 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <fc9da1e4-714a-4a2a-974b-fe495a3d8afe@linux.dev>
Date: Fri, 14 Aug 2026 16:55:00 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Check per-CPU address
 resolution per register
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, x86@kernel.org,
 stable@vger.kernel.org, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
References: <20260814220254.3797467-3-vineet.gupta@linux.dev>
 <67663b343f4aa2719eee273f10ca74a469fa1ab5e8772933083f51b62284a59a@mail.kernel.org>
Content-Language: en-US
From: Vineet Gupta <vineet.gupta@linux.dev>
In-Reply-To: <67663b343f4aa2719eee273f10ca74a469fa1ab5e8772933083f51b62284a59a@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/14/26 3:39 PM, bot+bpf-ci@kernel.org wrote:
>> commit fe4e8b7aecfff8c04bc3c2f472f9243928effc6e
>> Author: Vineet Gupta <vineet.gupta@linux.dev>
>> Date:   Fri Aug 14 15:02:54 2026 -0700
>>
>>      selftests/bpf: Check per-CPU address resolution per register
>>
>>      An ld_imm64 of a per-CPU map value is followed by a mov_percpu_addr that
>>      reuses the same register, so which register the address lands in decides
>>      how the JIT encodes the add. Getting the REX prefix wrong there is
>>      invisible to a functional test unless the address happens to land in an
>>      extended register, which is why this went unnoticed.
> Does this mechanism actually exist in the tree?

Indeed these changes are introduced in bpf-next not on *bpf* which the 
patches were targeting - noob mistake on my part.

I'll respin v4 targeting bpf-next and drop stable etc.

Thx,
-Vineet

>
> There is no verifier or JIT path that follows an ld_imm64 of a per-CPU map
> value with a mov_percpu_addr on the same register. BPF_MOV64_PERCPU_REG has
> exactly four call sites:
>
>    kernel/bpf/arraymap.c:288   *insn++ = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
>    kernel/bpf/hashtab.c:2429   *insn++ = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
>    kernel/bpf/fixups.c:2115    insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
>    kernel/bpf/fixups.c:2136    insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
>
> All four use BPF_REG_0 as both source and destination. BPF_REG_0 maps to
> RAX, so is_ereg() is always false and the REX.R encoding path is
> unreachable from any loadable program.
>
> An ld_imm64 of a percpu ksym goes through check_pseudo_btf_id() in the
> verifier, which only sets aux->btf_var.reg_type = PTR_TO_BTF_ID |
> MEM_PERCPU. No mov_percpu_addr insn is inserted after it. The per-CPU
> base is added later by bpf_per_cpu_ptr() or bpf_this_cpu_ptr() kfuncs,
> which return in R0.
>
>> diff --git a/tools/testing/selftests/bpf/progs/verifier_percpu_addr.c b/tools/testing/selftests/bpf/progs/verifier_percpu_addr.c
>> new file mode 100644
>> index 000000000000..967f4e6e3a49
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/verifier_percpu_addr.c
>> @@ -0,0 +1,72 @@
> [ ... ]
>
>> +SEC("raw_tp")
>> +__description("per-CPU address resolution")
>> +__success
>> +__arch_x86_64
>> +__jited("	movabsq	$0x{{.*}}, %rax")
>> +__jited("	addq	%gs:{{.*}}, %rax")
>> +__jited("	movabsq	$0x{{.*}}, %rdi")
>> +__jited("	addq	%gs:{{.*}}, %rdi")
>> +__jited("	movabsq	$0x{{.*}}, %rsi")
>> +__jited("	addq	%gs:{{.*}}, %rsi")
>> +__jited("	movabsq	$0x{{.*}}, %rdx")
>> +__jited("	addq	%gs:{{.*}}, %rdx")
>> +__jited("	movabsq	$0x{{.*}}, %rcx")
>> +__jited("	addq	%gs:{{.*}}, %rcx")
>> +__jited("	movabsq	$0x{{.*}}, %r8")
>> +__jited("	addq	%gs:{{.*}}, %r8")
>> +__jited("	movabsq	$0x{{.*}}, %rbx")
>> +__jited("	addq	%gs:{{.*}}, %rbx")
>> +__jited("	movabsq	$0x{{.*}}, %r13")
>> +__jited("	addq	%gs:{{.*}}, %r13")
>> +__jited("	movabsq	$0x{{.*}}, %r14")
>> +__jited("	addq	%gs:{{.*}}, %r14")
>> +__jited("	movabsq	$0x{{.*}}, %r15")
>> +__jited("	addq	%gs:{{.*}}, %r15")
>> +__naked void percpu_addr(void)
>> +{
>> +	asm volatile ("					\
>> +	r0 = %[percpu_data] ll;				\
>> +	r1 = %[percpu_data] ll;				\
>> +	r2 = %[percpu_data] ll;				\
>> +	r3 = %[percpu_data] ll;				\
>> +	r4 = %[percpu_data] ll;				\
>> +	r5 = %[percpu_data] ll;				\
>> +	r6 = %[percpu_data] ll;				\
>> +	r7 = %[percpu_data] ll;				\
>> +	r8 = %[percpu_data] ll;				\
>> +	r9 = %[percpu_data] ll;				\
>> +	r0 = 0;						\
>> +	exit;						\
>> +"	:
>> +	: __imm_addr(percpu_data)
>> +	: __clobber_all);
>> +}
> Can these 'addq %gs:..., %<reg>' assertions ever match?
>
> A bare sequence of ten ld_imm64s produces ten 'movabsq' lines and zero
> 'addq %gs:' lines. The verifier does not insert a mov_percpu_addr insn
> after an ld_imm64 of a percpu ksym. The per-CPU base is added by the
> bpf_per_cpu_ptr() or bpf_this_cpu_ptr() kfuncs, which return in R0.
>
> So the JIT output would be ten consecutive 'movabsq' instructions with no
> 'addq' between them. The test expects alternating 'movabsq' and 'addq'
> lines, and consecutive __jited tags must match consecutive disassembly
> lines unless a '...' tag is inserted.
>
> Even if a mov_percpu_addr could be generated, all four call sites hardcode
> BPF_REG_0, so only the %rax form would ever be reachable.
>
> This means the test cannot cover the REX.R fix in acdf39f8be46 ("bpf, x86:
> Fix per-CPU address resolution into an extended register").
>
> Should there be a Link: or Fixes: tag referencing acdf39f8be46, and does
> the commit message need to explain what new path makes the destination
> register reachable?
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31845422431

