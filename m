Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD13D335066;
	Fri, 14 Aug 2026 22:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786747167; cv=none; b=Pm7Gcq3Tkkg0YkRFMlMNmEbzsluyqDKL8AlShpKKrf48+lX9uDBEGboe3lbjdDkL20iocL4RBuml+yfXv6vmHyfC8pPiXriLBApm/SAccYMvxskJ1/Kumiub+ibQf69lbqtma3jqhDcnpQHWbhrj3PQNAJmAnW0KjxRbQz6GwWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786747167; c=relaxed/simple;
	bh=76SNzyY38GOsNKmkWsfVpDZfa9cdPESD4Uc2V7NMthU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=l0Hnank4/wUSyf0Jgf8T+xDnEK8Il/PTHRblFFI0hXTb2ynNZhVuTrfIo98o9CbvXvwPHQnIyJD1l2ol3QO0mPV6Vo1STgE4VUOX+el9TsHqjPvGoHzVt9X5G9lTWcqn1Ez9wfz6ZA+VKPNdpeQQ/MDX93FQeR+SbqdSU2/JcRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRxlX8kj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRxlX8kj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BDE1F000E9;
	Fri, 14 Aug 2026 22:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786747165;
	bh=DOTNd6p8SlrZsb5048GqhLcptFwNiD5Hv1ZYRf4mH8M=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=jRxlX8kjxZhThbYvx7BQpsX12oaDAYVlK6z/xtJcTvLINNwTslMhhYjAdqBJC3JtH
	 U2dmDRIesM2ygi1ipFzhNhbH/do3UoIG/47Z8ZjExkFjVgeGqida/vE2nY8RCRVTAB
	 BEWIaxbwX6+yE0ZHgSsaWPIcTs4pYiJWKJI26rvuqXqvLf2v1w388b1YvuUdWuWc/N
	 W5a6w6XFyK/aMiOOXEwuHPeev5/vRBSNkUbgtjpAzTcrgek/WlDkoRkIiHxUxRiCq5
	 7lcYlZ8AFIH6WNoMv48uqYUBthJMxfXXVrwOtjfp88G0utIYbW92h6gn4xvn+Dgnx7
	 9KkiQv9Iaxpig==
Content-Type: multipart/mixed; boundary="===============7034129261370145602=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <67663b343f4aa2719eee273f10ca74a469fa1ab5e8772933083f51b62284a59a@mail.kernel.org>
In-Reply-To: <20260814220254.3797467-3-vineet.gupta@linux.dev>
References: <20260814220254.3797467-3-vineet.gupta@linux.dev>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Check per-CPU address resolution per register
From: bot+bpf-ci@kernel.org
To: vineet.gupta@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,x86@kernel.org,stable@vger.kernel.org,vineet.gupta@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 14 Aug 2026 22:39:24 +0000 (UTC)

--===============7034129261370145602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit fe4e8b7aecfff8c04bc3c2f472f9243928effc6e
> Author: Vineet Gupta <vineet.gupta@linux.dev>
> Date:   Fri Aug 14 15:02:54 2026 -0700
>
>     selftests/bpf: Check per-CPU address resolution per register
>
>     An ld_imm64 of a per-CPU map value is followed by a mov_percpu_addr that
>     reuses the same register, so which register the address lands in decides
>     how the JIT encodes the add. Getting the REX prefix wrong there is
>     invisible to a functional test unless the address happens to land in an
>     extended register, which is why this went unnoticed.

Does this mechanism actually exist in the tree?

There is no verifier or JIT path that follows an ld_imm64 of a per-CPU map
value with a mov_percpu_addr on the same register. BPF_MOV64_PERCPU_REG has
exactly four call sites:

  kernel/bpf/arraymap.c:288   *insn++ = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
  kernel/bpf/hashtab.c:2429   *insn++ = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
  kernel/bpf/fixups.c:2115    insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
  kernel/bpf/fixups.c:2136    insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);

All four use BPF_REG_0 as both source and destination. BPF_REG_0 maps to
RAX, so is_ereg() is always false and the REX.R encoding path is
unreachable from any loadable program.

An ld_imm64 of a percpu ksym goes through check_pseudo_btf_id() in the
verifier, which only sets aux->btf_var.reg_type = PTR_TO_BTF_ID |
MEM_PERCPU. No mov_percpu_addr insn is inserted after it. The per-CPU
base is added later by bpf_per_cpu_ptr() or bpf_this_cpu_ptr() kfuncs,
which return in R0.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_percpu_addr.c b/tools/testing/selftests/bpf/progs/verifier_percpu_addr.c
> new file mode 100644
> index 000000000000..967f4e6e3a49
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_percpu_addr.c
> @@ -0,0 +1,72 @@

[ ... ]

> +SEC("raw_tp")
> +__description("per-CPU address resolution")
> +__success
> +__arch_x86_64
> +__jited("	movabsq	$0x{{.*}}, %rax")
> +__jited("	addq	%gs:{{.*}}, %rax")
> +__jited("	movabsq	$0x{{.*}}, %rdi")
> +__jited("	addq	%gs:{{.*}}, %rdi")
> +__jited("	movabsq	$0x{{.*}}, %rsi")
> +__jited("	addq	%gs:{{.*}}, %rsi")
> +__jited("	movabsq	$0x{{.*}}, %rdx")
> +__jited("	addq	%gs:{{.*}}, %rdx")
> +__jited("	movabsq	$0x{{.*}}, %rcx")
> +__jited("	addq	%gs:{{.*}}, %rcx")
> +__jited("	movabsq	$0x{{.*}}, %r8")
> +__jited("	addq	%gs:{{.*}}, %r8")
> +__jited("	movabsq	$0x{{.*}}, %rbx")
> +__jited("	addq	%gs:{{.*}}, %rbx")
> +__jited("	movabsq	$0x{{.*}}, %r13")
> +__jited("	addq	%gs:{{.*}}, %r13")
> +__jited("	movabsq	$0x{{.*}}, %r14")
> +__jited("	addq	%gs:{{.*}}, %r14")
> +__jited("	movabsq	$0x{{.*}}, %r15")
> +__jited("	addq	%gs:{{.*}}, %r15")
> +__naked void percpu_addr(void)
> +{
> +	asm volatile ("					\
> +	r0 = %[percpu_data] ll;				\
> +	r1 = %[percpu_data] ll;				\
> +	r2 = %[percpu_data] ll;				\
> +	r3 = %[percpu_data] ll;				\
> +	r4 = %[percpu_data] ll;				\
> +	r5 = %[percpu_data] ll;				\
> +	r6 = %[percpu_data] ll;				\
> +	r7 = %[percpu_data] ll;				\
> +	r8 = %[percpu_data] ll;				\
> +	r9 = %[percpu_data] ll;				\
> +	r0 = 0;						\
> +	exit;						\
> +"	:
> +	: __imm_addr(percpu_data)
> +	: __clobber_all);
> +}

Can these 'addq %gs:..., %<reg>' assertions ever match?

A bare sequence of ten ld_imm64s produces ten 'movabsq' lines and zero
'addq %gs:' lines. The verifier does not insert a mov_percpu_addr insn
after an ld_imm64 of a percpu ksym. The per-CPU base is added by the
bpf_per_cpu_ptr() or bpf_this_cpu_ptr() kfuncs, which return in R0.

So the JIT output would be ten consecutive 'movabsq' instructions with no
'addq' between them. The test expects alternating 'movabsq' and 'addq'
lines, and consecutive __jited tags must match consecutive disassembly
lines unless a '...' tag is inserted.

Even if a mov_percpu_addr could be generated, all four call sites hardcode
BPF_REG_0, so only the %rax form would ever be reachable.

This means the test cannot cover the REX.R fix in acdf39f8be46 ("bpf, x86:
Fix per-CPU address resolution into an extended register").

Should there be a Link: or Fixes: tag referencing acdf39f8be46, and does
the commit message need to explain what new path makes the destination
register reachable?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31845422431
--===============7034129261370145602==--
