Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795431003;
	b=Mc1qHi75xqIUj2Qp3XWvCc36YoghumYSLLLsDoMqXBe2rWrJA+v6256wq/uXcf8fAu4E
	 8NwNmzgIbKNHkOyCgFOUosZ4yOhuWwpibGoq3j9RC3nud+b7pOGq14I2Grv6q0rAwy3PP
	 S/5PgkQwMLUbSgFA8O+cQW+frYTrajL5c4qcX2igmQ7V+YK+sr0V0xBqySL0M0INZJxJF
	 IuaEzknvhTcpDmd9qrS0UBI8yKKaeOrr4bG9LQRNjfVrmn2OQYjzFzuLnbvIfmGjlvPE9
	 DpL6AYuKzMvh9MlP4fsoIZHE6mR90DefD+btC7wy7NuSGlaWl+DmpM2BBW1LhxAUAWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795431003;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=HONgwvcLnwdQ2wr7NdDYe7XePSqL8bRXwzbHmI19pt4=;
	b=yJEjCwnnr5292ugHb0+KcaY894pICECQPMtLf547WJioQDpcPOxr9ewV07W3pRs8PkMd
	 RL+apkZREFLvWOurewQL5gruwbWUdyh38g7Eo73vrub/NLTwhR2OLjUQsvllbvpcZh9Nr
	 qEq2imm7nb0lmzPSTcYI1y0HCf2WCsHUekV9QAv2Ny5P3iNXT3LlhKYCmz/kYZ4QnNuqr
	 EqnFVs29gSa7qC5njtyDkCYnrg6G4T2Eeily/btKoEDAGEI1xn00czl2K9Wn9BqVo9NIS
	 OD6Tepjfqc91SqfcvAC9c6aOwwnTZwrPQoTi285QzEHyCDRBYW14YpfxgkcCCmJcCWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=h+WxKwoB;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6758606A31A;
	Mon, 23 Nov 2026 10:50:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6758606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=h+WxKwoB
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32286143D;
	Mon, 23 Nov 2026 02:49:59 -0800 (PST)
Received: from [10.57.91.245] (unknown [10.57.91.245])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B8093F632;
	Mon, 23 Nov 2026 02:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795431002; bh=88wKm6a3kg+rRCdOpXoIcUGAgG5m2xf6YFDPEexucGk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h+WxKwoB8MqOR3y6DbBUX+gVZWSCUCEStlY/uJ4F5pyUZHSJkTOnOl5qaT+iImAQz
	 SibvFVG+nLxs2gyjgFTTpoSjEGXdKvhdtuB+LekSEzw6CMbTE4PCvbAGjhbsDR7iw6
	 1uPYGOcS1CkKqQFZ+hRzzeAZi6Hd+4PL/Q7rEBEs=
Message-ID: <85385aae-af06-4742-a39b-5a95e3e73a7e@arm.com>
Date: Mon, 23 Nov 2026 10:49:58 +0000
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
Subject: Re: [PATCH v1] arm64: Mitigate Spectre v1 in the BPF interpreter
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, stable@vger.kernel.org
References: <20261117172341.3152407-1-ryan.roberts@arm.com>
 <DMYSI3BOQWOC.2P2FZB0H872DR@gmail.com> <awAay4FFj1_wQtaL@arm.com>
 <DN07ZMOAD4GP.37PG3XUPBG4CM@gmail.com>
 <a6cda8a2-992f-41f9-a814-ee78363c3a69@arm.com>
 <DN2ALO12MI1Z.3HI553HDMO2FL@gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
Content-Language: en-GB
In-Reply-To: <DN2ALO12MI1Z.3HI553HDMO2FL@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/11/2026 04:07, Alexei Starovoitov wrote:
> On Sun, Nov 22, 2026 at 12:58 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>> I view this patch as a fix to arm64, not as a fix to BPF. I haven't changed any
>> BPF code - I've only removed an out of date comment in BPF code, which assumed
>> the code path was for Spectre v4 only. But that's not true since Commit
>> dff883d9e93a ("bpf, arm64, powerpc: Change nospec to include v1 barrier").
> 
> Fair enough, but the arm64 part of that comment is stale.
> The verifier relies on nospec for v1 since
> commit d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1").
> 
>> arm64 was previously nop'ing barrier_nospec() despite seemingly needing it in
>> the same situation as x86. I think this is orthogonal to whether or not the BPF
>> interpreter permits speculation attacks in other places?
> 
> Not quite. In the interpreter the barrier sits behind an indirect branch:
> 
>   goto *jumptable[insn->code];
> 
> arm64 has no retpoline, and the prog can train this branch.
> With a wrong target the CPU skips ST_NOSPEC and runs the next insn.
> So the interpreter is still not safe.
> Yet you're arguing that you're making bpf interpreter a viable option
> on arm64. That's just not fair to users.

I'm not saying that at all. I wasn't aware that it previously considered unviable.

I noticed this particular issue while doing manual code inspection while working
on something else. I sent the patch to close what I perceived to be a bug to try
to be a good citizen.

> Say it in the commit log that you're fixing one tiny issue and leaving
> giant security hole in place.
> With that I'm no longer nacking it.

Happy to fix up the commit log as you suggest.

> 
>> Looking at bpf-next, it is still possible to deselect BPF_JIT when building. If
>> this is such a security issue, shouldn't we disallow that on arm64, or at the
>> every least make it an EXPERT option?
> 
> Yeah. Good point. Let's disallow it on arm64 and x86-64.
> 
> I'm thinking to push something like this
> 
> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> index d705d7b..8b8688d 100644
> --- a/kernel/bpf/Kconfig
> +++ b/kernel/bpf/Kconfig
> @@ -26,8 +26,8 @@ config HAVE_EBPF_JIT_KASAN
>  config ARCH_WANT_DEFAULT_BPF_JIT
>  	bool
>  
> -# Used by archs to tell that kernels that were compiled with BPF JIT support
> -# have no BPF interpreter.
> +# Used by archs to tell that kernels with the bpf() system call have the
> +# BPF JIT compiler and no BPF interpreter.
>  config ARCH_WANT_BPF_JIT_ALWAYS_ON
>  	bool
>  
> @@ -36,6 +36,7 @@ menu "BPF subsystem"
>  config BPF_SYSCALL
>  	bool "Enable bpf() system call"
>  	select BPF
> +	select BPF_JIT if ARCH_WANT_BPF_JIT_ALWAYS_ON
>  	select IRQ_WORK
>  	select NEED_TASKS_RCU
>  	select TASKS_TRACE_RCU

Seems reasonable as long as we're sure that there are no users that rely on the
interpreter on arm64 for some reason?

Would you propose that this is something that should be backported? If so, I'll
drop this patch. Otherwise, I'll send a v2 with a more cautious commit log.

Thanks,
Ryan

