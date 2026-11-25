Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795614218;
	b=b5Hi5UUHziyrpFS2JGP1v1sOIAa+SWlLoYYm5SA1uv2hAQd9tfxMjZTSxN6wNmvg1bAu
	 +lUI8AxmWY3ggLdX+1rhADQ3RAwbvoQQMkIN4+pIRnVmqWANd+WKiIdHRosuHpG/vHX3w
	 vNJGqVJktj8zrkOFW2l1UF+r1YvznhMJH4Eq7VxK6MffyJWQkW9w6I5dlgP33scKHUbA5
	 1tvX+xe0YsiaVWKJLkdqJ+w8DCyy0piSatxnyOuuEsMxqcVeDpcOQU0O0Q0ZclmcKjVcZ
	 T3T4JYQH9AAQ1avgyiAf0kPM32b7j2W5l3+5CXSLc/1QeWQ/9bHsNqWdNNT0Mc+T1kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795614218;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=6oSqEig9AGJMHosVHhZtxiJ/44MaDSzvmhq9hylVy0c=;
	b=e9czj+kkgMeVy0Bp5I3Ij8AxZtwi+bgc66RursTj7FkhxlGwNUAvPNKgvwBdvIXiha9r
	 ToZ5CBeXJDShNGgnA52CwgyMU0/Dwp5BjRPKlOiJ47faF/sS4zVLmcj1vgljdfGDWxZEy
	 Qo5MtAy0zwzMiMCyrPhpji3a5cc0nmuB43pGiwZXxDrfbcs+Vwyu06JIADRfMpMOwBjXt
	 1i/5qkXbIpqlJtcgFUDxdtLRnmuYqqF7Zn/N1vb3ooOEX99VOys7x67PuBNEDsT7zJpCg
	 2Tjj0d9e+ZHMGt16ArK9DQ8BXKaYdAn9MTL4pFVaKeDm/AkoSSFQUdcQDdQ05Jo8x1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qsDd4yKf;
	arc=none smtp.remote-ip=91.218.175.74
Received: from mta0.migadu.com (out-74.mta0.migadu.com [91.218.175.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9B3606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 13:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E9B3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=qsDd4yKf
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=foQQFJFpoZ/mRTc9jcIQPOk2Q+YJFlQywuFZ/jX/M3s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795614215; v=1; x=1796219015;
 b=qsDd4yKflerJfRTzSgFIEnG/W4leBezwwvNc47UTxYRP5tOy9/Fr6craIa3bZIWZRWkxt5i3
 aDbbp6XNthN94uGLJ5EHgFJymUp8WtwE63TaTRDetvLcKY6nexmtvsTVZd6LRuWP7ByL+vxZA1X
 DmbiQCHIqhWLUG7ymP7BBKpw=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f9dfb553bd12c55c;
	Wed, 25 Nov 2026 13:43:35 +0000
X-Mizu-Trace-ID: f9dfb553bd12c55c
X-Migadu-Flow: FLOW_OUT
Message-ID: <809f91e2-638d-4e54-9b60-e66098d173e0@linux.dev>
Date: Wed, 25 Nov 2026 21:43:29 +0800
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
Subject: Re: Please backport 7a0855e73757 ("bpf: Disallow interpreter fallback
 for BPF_ADDR_PERCPU insn") to 6.18.y and 6.12.y
To: Guillaume Laporte <glapt.pro@outlook.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Vincent Thiberville <vincent@harfanglab.fr>
Cc: "yangtiezhu@loongson.cn" <yangtiezhu@loongson.cn>,
 Alexei Starovoitov <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux@roblab.la" <linux@roblab.la>
References: <BESPR02MB12296D62B1B3F33BA21C4F24AF1432@BESPR02MB12296.eurprd02.prod.outlook.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <BESPR02MB12296D62B1B3F33BA21C4F24AF1432@BESPR02MB12296.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/11/25 16:56, Guillaume Laporte wrote:
> Dear maintainers,
> 
> Could you please consider backporting the following commits to 6.18.y
> and 6.12.y:
> 
>   9a6df65d5c6a ("bpf: Introduce jit_required flag and remove bpf_prog_has_kfunc_call()")
>   f1c27922576e ("bpf: Reject programs with inlined helpers if JIT is not available")
>   7a0855e73757 ("bpf: Disallow interpreter fallback for BPF_ADDR_PERCPU insn")

34746b5a84ec ("bpf: Disallow interpreter fallback for arena-related insns")

This commit will also be backported.

> 
> All three were backported to 7.2.6, but not to the 6.18.y and 6.12.y
> trees, which seem to be the only affected longterm trees: if I'm not
> mistaken, the issue was introduced in 6.10 by 7bdbf7446305 ("bpf: add
> special internal-only MOV instruction to resolve per-CPU addrs").
> 

[...]

> 
> Unfortunately, the commits do not apply cleanly to these trees, as
> they modify kernel/bpf/fixups.c, which only exists since 7.1. Leon,
> thank you for fixing this upstream. In July you mentioned that the fix
> should be backported to 6.12 along with Tiezhu's jit_required series
> [2]. Would you have time to prepare the backports for 6.18.y and
> 6.12.y? We would be glad to test them with the reproducer and report
> back.

No worries. I will backport the aforementioned commits in near future,
will cc Vincent and you.

Thanks,
Leon

> 
> Thank you for your help,
> 
> Guillaume Laporte
> 
> [1] https://lore.kernel.org/bpf/MR1P264MB331494502C9D13D8A9EAFB99B7E82@MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM/
> [2] https://lore.kernel.org/bpf/b76ade17-44cb-4e60-97fc-41ba55258691@linux.dev/

