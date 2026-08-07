Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B699647607F;
	Fri,  7 Aug 2026 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786107588; cv=none; b=mZ6i3hSDOpLFyPgwankBKBTp6NWxwEOcoKShyuIqCU69O0uqU1V+IGZfWxiBUAxS8dhJ2+DQApjpqf4WSbMVM9uHdmY22+qNg+LFFmvYNNYyuUJCNWAu9u1tOE2MmzpQov4A5ubtwYdQPcWZBGgjnCm2VJ1ZKssgngm7eIN2wLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786107588; c=relaxed/simple;
	bh=yMiK1yh6xy1Np/nBghOM2UqhnZKJlwY+ByNtCjfrCI8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=o/Tkuw3s1xz1/9ejIqnkv0XPip+PoSNZ/fBgafx062lE1rdgtfiRNdpQkK8+sREHikvhJdwE50a+oS+PwKyysw/LSn2BCNUx/rrsxD9b6Um8ni18lRZDh7OzqE2ypvEUDc7/hAcvj7jAK+5twDGiwHCyofpVOel0J6ujgMo7Mnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wt/1R8rw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wt/1R8rw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF291F000E9;
	Fri,  7 Aug 2026 12:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786107582;
	bh=WGWe62w4uZOGlTd+Rt6sdGbT/Nouu499hkPKmGKxmLg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Wt/1R8rwmGTx2f8PYIuCEP4H+iJa5y9BsvjmVm2lUyxYIkXsJ2OOrEl5qLluvQ4FO
	 gR8D6wPxIvholh5dqf9AmiEaTihz/DZ7/bp3LNMdFRqmi/poK/JuGskMzKSHvZz+rH
	 wVEKyeNooy4xgO4DalnL9F977Tkbpw3ASKWDczWH9A4b3a4BcVOrxHmugYRcpbuQzL
	 Xd4CGv3HFgkDILwOJfoJUrtiD31AgyG9Av8qqFdmErTziujfC9Rda8lqxV2iYJvKuq
	 oCdL+JelJ10bP+bqSvX5WpnSA9ps34stkgjh3ky3C1ZnFutjcidlObQMoPtYi2Kww8
	 wb4QUz12MUEOA==
Content-Type: multipart/mixed; boundary="===============4091664156689549777=="
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20bc24b322d3a8ef52eef9b3cd05eef275efabc0be00be3fd6df5a9765bba321@mail.kernel.org>
In-Reply-To: <e827cffd10c37ae7d0b1fca59523acda38db1704.1786099877.git.skb99@linux.ibm.com>
References: <e827cffd10c37ae7d0b1fca59523acda38db1704.1786099877.git.skb99@linux.ibm.com>
Subject: Re: [PATCH v11 3/8] selftests/bpf: Fixing powerpc JIT disassembly failure
From: bot+bpf-ci@kernel.org
To: skb99@linux.ibm.com,bpf@vger.kernel.org,linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com,maddy@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,shuah@kernel.org,linux-kselftest@vger.kernel.org,stable@vger.kernel.org,venkat88@linux.ibm.com,yeswanth@linux.ibm.com,skb99@linux.ibm.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  7 Aug 2026 12:59:41 +0000 (UTC)

--===============4091664156689549777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
> index 3558fe10e28cf..c4aa1d69d3bbf 100644
> --- a/tools/testing/selftests/bpf/jit_disasm_helpers.c
> +++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c

[ ... ]

> @@ -225,9 +227,30 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
>  	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd #2"))
>  		goto out;
>
> +	/*
> +	 * last 8 bytes contains dummy_trampoline address in JIT
> +	 * output on 64-bit and last 4 bytes on 32-bit powerpc,
> +	 * which can't disassemble to a valid instruction.
> +	 */
> +	triple = LLVMGetDefaultTargetTriple();
> +	if (triple) {
> +		if (strstr(triple, "powerpc64") || strstr(triple, "ppc64"))
> +			trunc_len = 8;
> +		else if (strstr(triple, "powerpc") || strstr(triple, "ppc"))
> +			trunc_len = 4;
> +		LLVMDisposeMessage(triple);
> +	}
> +
>  	for (pc = 0, i = 0; i < jited_funcs; ++i) {
> +

This isn't a bug, but are the two new blank lines inside this loop
intentional? Dropping them would keep the diff to just the truncation
logic and match how the loops in disasm_one_func() are laid out.

>  		fprintf(text_out, "func #%d:\n", i);
>  		/*
>  		 * Disabled JIT have zero func_lens, hence underflow
>  		 */
>  		disasm_len = func_lens[i] > trunc_len ?
>  					func_lens[i] - trunc_len : 0;
>  		disasm_one_func(text_out, image + pc, disasm_len);
> +
>  		fprintf(text_out, "\n");
>  		pc += func_lens[i];
>  	}

> selftests/bpf: Fixing powerpc JIT disassembly failure

This isn't a bug, but would the subject read better in the imperative
mood, "selftests/bpf: Fix powerpc JIT disassembly failure", to match
the rest of the series?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31176427801
--===============4091664156689549777==--
