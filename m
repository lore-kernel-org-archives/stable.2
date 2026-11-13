Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581606;
	b=hZsKtfSYbwXFMtWmkJhEVeFqQ62HEvgw+znGXqNEuqTxxDO9GF4W1Or3krjrhgcrFT0e
	 o9XgnKGCmh09LPD/I8vHUuN/xvYYP3d+Gu7/w7/XCKEGlLkXO7vlxgst8q2lKuqhkyU0E
	 z7I7uWJR/Uod0AMzeCaNLLI5MXdvwIicwIQKIj+whSlj1p2pXUJx0MkohCP96bA1DV2k3
	 GZrJDR6Mgm/g9IN3bDWQEmOHo6+OGkruH/V7n6zHggHvFjvBvftVvGltA42DmpKm14tS6
	 l3m0fh8J25H0SQ/98L/hJOn1wQnmXtEun4D1kQY4+XdeVb+5Fa7WIZoo+NRrW0Rg0wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581606;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jlcDsdtlo0slK+vvqG3ptpM7GvIadzb1KxPdJ/tncg8=;
	b=uCOjpMj4C02cckUgs+eTnIV7DCpbA88lvVnGeeLXVB/6I99/9fwG6I/weeefwqMJlGTr
	 buc7RLwW+l6FEDUFGtNGDDLdojFi8e6QgsS5FWjn55n2skBS99199rwHGwCC+ceAlmRzO
	 uxMmz8BREnSw5FcDRtFz5D3eHWjCJjXd/z+EIPrG3kFionC5Qd51k7brc8ZqcW4fDRVUc
	 IJbUeS2hbSrnW/1r2YYFCi4q0Lepnl54DszS2n1ynOGg9jabjN0W2etfKopTQF+rEcNgZ
	 N4KFESgo27EZW7YoFWPQyJST3RJ6xuN5Ssg8ZAIb5bmt09SKWxGe3ANvdmZXgkyxKSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DmfxAftj;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FB4606A32D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99FB4606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DmfxAftj
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c169ae1cb26so258786866b.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 06:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794581604; x=1795186404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jlcDsdtlo0slK+vvqG3ptpM7GvIadzb1KxPdJ/tncg8=;
        b=DmfxAftjg1G0HivU6QqMf8e3eweoMRPo6IiUtQMJu/JvFCTg0GlhPfANGtdLM8gmEa
         1Y1gOpfeCPNuBctz9TkVqjg1s7+TCCWsLwdPWVjek06VvFD1Lf+6kzdYcUkrntp4MuHA
         AGFejj4ke0Zks+9TOi9ApExlrHD/laF5/i/ip2747yxLyNmkORTjO75MxKLXse4hJG06
         QCED55IhlT9Kvd5FH8qzEKLoFp9Xjij/OyG/q2H6itc4x6clZ3/iCq8/RNAJh5AtSRfh
         SFmVoZllL7g2CMBG/inRBBpDTnOYdEWwI5HwRqfj1vItt9THSKKrmICGkPie2coiD2A7
         76AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794581604; x=1795186404;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jlcDsdtlo0slK+vvqG3ptpM7GvIadzb1KxPdJ/tncg8=;
        b=bVWObdDXpyklQxdTR3CAcy5vl80ZTFPnIicR8CyZZDaOdX8rWRamSRhxEz+wHl/eEM
         VNauHDp+icTCz3dTgwKJXWAOVjzcK5JcgifagLNKdfimTFAVV0PYPgRqU1b+5NeD6X8h
         lcfIr7evWFtzlI4+BYG63U7TSkJl2AkA5/R8hIWB5Yq1ILFmjmXSulsB30DRI5Bu/5Gf
         YPrUTFpQW37BN4jjACUolA/QUo8a6qbYffEw4sgROU1BgdTm9sinsI+J28uEMnYL0hVk
         ObN0nXYM/835cxZHElOBo9Enr2RZUgVtUOpocRn0AIipgG5cQaRogEqxnOLhhrH622Ei
         HQog==
X-Forwarded-Encrypted: i=1; AL+hErE1BN97CtFAY8A2p4E84RHf6VQgx5ycINtpmc+9d5p6Xfmh9Eta0GStCTKVnVZH9+6uDgmjs9M=@vger.kernel.org
X-Gm-Message-State: APuU4Z9KFZi25OKURGI7PEVgcH4b6Cx8sAk9Ew71z3n+bMcaKCJ4vcTB
	OfPJaqk8zDdmJh6CrIw4pnL/X6pE1kTVFXYQwIXvSsYFDd2LNsBA2vja
X-Gm-Gg: AYBFou0Aei9MStYHfe+TjPfdKIG6YiaINluCHVBaDN3q1MoUPGZOst+Iuz31AfSlHHL
	bxkna9HPKY8Bkqp26pK4EygES+Y9sTG5t4M7FdETNUSrksiNNsME88ktxFzMk7B129nOkfHlDqG
	d+5uP7l83QM3bQT9SYhjygoXjHpkr2unmozCB2erjWy0eIBLLcQyNKc89V6m3ZrtQL13xICgB3F
	jbFlZiVzrvy/M7AEj4zupOp+/f4DECDDZvEfBdJtY3D/6MOH/vaipXOWeg+EgZKFXKhyf8n5klI
	zpxZpkutj1N+1E4er/0OxvyieHZIhFBT5Hq5tfHbbgAunxXPG4XoRjvoVx/CSjIvfNVawAAffLT
	UAtsK/R6kCaKqgSxc4lyFm7JCQmC/m0wOWqkoGzo08pZhJtEErC5TCm5lhxkniW6p4B0GeVrbpK
	2MqBQAfVO68h8sLkRScKa1/tskXMQwDZsKFTG+UeXPRfLXpDdAuzahSBHcFu4MB1B90fERzO5ob
	5EPd+hGa+Xi6UkGHfVc8wpJeGG/jMRGoMAy9YSgciDYtNIpj2QijA5VnOyP80/CIWsUYopwHrPZ
	EszAM0sIAgMeTsap
X-Received: by 2002:a17:906:9c89:b0:c2d:c6e7:9e9a with SMTP id a640c23a62f3a-c509634a669mr257870466b.11.1794581603715;
        Fri, 13 Nov 2026 06:53:23 -0800 (PST)
Received: from krava ([173.38.220.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b58b66sm111032166b.50.2026.11.13.06.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 06:53:23 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 13 Nov 2026 15:53:20 +0100
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	HyeongJun An <sammiee5311@gmail.com>,
	Christian Simon <simon@swine.de>, stable@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next 2/2] bpf: Disable private stacks for untagged
 kprobe programs
Message-ID: <avckYL7KMRk96XQP@krava>
References: <20261106164043.546879-1-jolsa@kernel.org>
 <20261106164043.546879-3-jolsa@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106164043.546879-3-jolsa@kernel.org>

On Fri, Nov 06, 2026 at 05:40:43PM +0100, Jiri Olsa wrote:
> Uprobe programs can be preempted and re-entered on the same CPU. Since
> the private stack is shared per program and CPU, another invocation can
> overwrite the preempted invocation's stack.
> 
> Programs without a multi or session attach type may be standard kprobes
> or uprobes. Disable private stacks for them, and retain private stacks
> only for kprobe multi and session programs, which have attach types that
> identify them as kprobes.
> 
> Update verifier tests that rely on private stacks to use kprobe.multi,
> and add coverage that untagged kprobe and uprobe programs do not use
> private stacks.
> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

hi,
I did not realize before, but I think this should be added to stable

Fixes: a76ab5731e32 ("bpf: Find eligible subprogs for private stack support")
Cc: stable@vger.kernel.org

jirka


> ---
>  kernel/bpf/verifier.c                         |  9 +++++
>  .../bpf/progs/verifier_large_stack.c          |  2 +-
>  .../bpf/progs/verifier_private_stack.c        | 38 ++++++++++++++++++-
>  3 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b7329d164771..1b58a1796a2e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5749,6 +5749,15 @@ static enum priv_stack_mode bpf_enable_priv_stack(struct bpf_prog *prog)
>  	 */
>  	switch (prog->type) {
>  	case BPF_PROG_TYPE_KPROBE:
> +		/*
> +		 * Uprobes are preemptible and lack recursion protection. Classic
> +		 * kprobe and uprobe progs have no expected attach type, so enable
> +		 * private stacks only for kprobe.multi and kprobe.session progs.
> +		 */
> +		if (prog->expected_attach_type != BPF_TRACE_KPROBE_MULTI &&
> +		    prog->expected_attach_type != BPF_TRACE_KPROBE_SESSION)
> +			return NO_PRIV_STACK;
> +		fallthrough;
>  	case BPF_PROG_TYPE_TRACEPOINT:
>  	case BPF_PROG_TYPE_PERF_EVENT:
>  	case BPF_PROG_TYPE_RAW_TRACEPOINT:
> diff --git a/tools/testing/selftests/bpf/progs/verifier_large_stack.c b/tools/testing/selftests/bpf/progs/verifier_large_stack.c
> index 7e4f5e3463a2..cbabb41d973c 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_large_stack.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_large_stack.c
> @@ -243,7 +243,7 @@ static void priv_stack_frame_2048(void)
>  "	::: __clobber_all);
>  }
>  
> -SEC("kprobe")
> +SEC("kprobe.multi")
>  __description("private stack: two frames of 2048 bytes")
>  __load_if_large_stack()
>  __arch_x86_64
> diff --git a/tools/testing/selftests/bpf/progs/verifier_private_stack.c b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
> index aa15361bcca5..0ce07bf6b566 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_private_stack.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_private_stack.c
> @@ -22,7 +22,7 @@ struct {
>  	__type(value, struct elem);
>  } array SEC(".maps");
>  
> -SEC("kprobe")
> +SEC("kprobe.multi")
>  __description("Private stack, single prog")
>  __success
>  __arch_x86_64
> @@ -110,6 +110,40 @@ int no_private_stack_stack_args(void)
>  }
>  #endif
>  
> +SEC("kprobe")
> +__description("No private stack, untagged kprobe")
> +__success
> +__arch_x86_64
> +__jited("	subq	$0x100, %rsp")
> +__arch_arm64
> +__jited("	sub	sp, sp, #0x100")
> +__naked void no_private_stack_kprobe(void)
> +{
> +	asm volatile ("			\
> +	r1 = 42;			\
> +	*(u64 *)(r10 - 256) = r1;	\
> +	r0 = 0;				\
> +	exit;				\
> +"	::: __clobber_all);
> +}
> +
> +SEC("uprobe")
> +__description("No private stack, uprobe")
> +__success
> +__arch_x86_64
> +__jited("	subq	$0x100, %rsp")
> +__arch_arm64
> +__jited("	sub	sp, sp, #0x100")
> +__naked void no_private_stack_uprobe(void)
> +{
> +	asm volatile ("			\
> +	r1 = 42;			\
> +	*(u64 *)(r10 - 256) = r1;	\
> +	r0 = 0;				\
> +	exit;				\
> +"	::: __clobber_all);
> +}
> +
>  __used
>  __naked static void cumulative_stack_depth_subprog(void)
>  {
> @@ -123,7 +157,7 @@ __naked static void cumulative_stack_depth_subprog(void)
>  	: __clobber_all);
>  }
>  
> -SEC("kprobe")
> +SEC("kprobe.multi")
>  __description("Private stack, subtree > MAX_BPF_STACK")
>  __success
>  __log_level(4) __msg("stack depth max 512")
> -- 
> 2.43.0
> 
