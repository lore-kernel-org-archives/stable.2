Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820424FC35E;
	Wed, 30 Sep 2026 13:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775461; cv=none; b=L537CljJIPd6Nmwe/IaLaMyg1jVGMjDv3Cydmfm7O7ShydCYkJu+KOFjkYl8A1jKKF0Emup5GYh/Lu2VcrFO7D+LLMwAFkDg5Y1/mErztumWp7AbrhhlgRR7qQq4Wlv27TRyV/kdsqXnv/aGnP+KZOIhoqDhDQJMLquDUjZOAw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775461; c=relaxed/simple;
	bh=zlzB9ZxMupeywswUrXtebUKbcoIFtT/AWMqoIyrffMg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oyzZYMkD0sOQ5TfSURrQuGdI5dXu9E2nKF1tpZ3jfXxLej7yBuFfBDU0TiC6xz9Dd0yeQE+5QT9jhsdx81b7b3PsHhiNqCEmjR0Z6mMc0MvRyDAq4rdQAvc6o6jNEVlPgMyQlIzSU8qdp5R/Sb/k/0+Xp3TXgQNtnXKHsknOJ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itHCfg7Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itHCfg7Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792371F000FF;
	Wed, 30 Sep 2026 13:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790775448;
	bh=YgnrYF/r12cfEcieDzIy2DjQVqRHIKIEg5GVjZLOGsg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=itHCfg7ZEtaJlbsoQD0HpDA7shWjfhI1FyRHvTBe4TzDHB52zGsWjr6fgAl90D7DD
	 a75DQ/5UrHCmadawrQ/nyeqoEGjftqx+B5SB/3CoLqOo2I7plYhpcoj+bQXXWD+9qq
	 auuyKPFXeT5QpzHX/Fy+jRiNMR9QYxfzVPItpaREjgjc3Dz8/8Gubm/jX+oa94SzMV
	 K0hCjmZi9O6/7tlwGznM0avBZN9QkEeqzOkuO69vqauFgRcYWy97abqNcfa0FnxqD1
	 8ujASKGp/lmqOVo79apQKeNfug7RsDWDrYNSAq+ww3RzoogEHzNtEzxgaXzXRqmtwJ
	 wWdfRq3TH0lGg==
Date: Wed, 30 Sep 2026 22:37:24 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: Naveen N Rao <naveen@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, Ingo Molnar <mingo@elte.hu>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] kprobes: Skip disarmed probes when checking optkprobe
 overlap
Message-Id: <20260930223724.87336536b2fe72f3732a9534@kernel.org>
In-Reply-To: <20260930053618.104498-1-leon.hwang@linux.dev>
References: <20260930053618.104498-1-leon.hwang@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 13:36:18 +0800
Leon Hwang <leon.hwang@linux.dev> wrote:

> On x86, an optkprobe at A replaces five bytes with a jump. If a disabled
> probe B is at A+2, get_optimized_kprobe() stops at B when arming a new
> probe C at A+4. It leaves A optimized:
> 
>               A    A+1  A+2  A+3  A+4
>   A's jump  | e9 | d0 | d1 | d2 | d3 |
>   after C   | e9 | d0 | d1 | d2 | cc |
> 
> The INT3 for C overwrites the last byte of A's jump displacement, so
> execution can jump to the wrong address. B can have prepared optinsns
> while disarmed, but has no jump to unoptimize.

Oops, good catch! get_optimized_kprobe() only checks the first disabled
one and do not unoptimize the A.

> 
> Continue past disarmed and unprepared probes to find the active optimized
> probe before arming a probe in its jump.

Yeah, this looks good to me. Let me send via probes/fixes.

Thank you!!

> 
> Fixes: afd66255b9a4 ("kprobes: Introduce kprobes jump optimization")
> Cc: stable@vger.kernel.org
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  kernel/kprobes.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 6337da5cab9e..e6f6e18fa1b5 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -495,14 +495,16 @@ static bool kprobe_queued(struct kprobe *p)
>  static struct kprobe *get_optimized_kprobe(kprobe_opcode_t *addr)
>  {
>  	int i;
> -	struct kprobe *p = NULL;
> +	struct kprobe *p;
>  	struct optimized_kprobe *op;
>  
>  	/* Don't check i == 0, since that is a breakpoint case. */
> -	for (i = 1; !p && i < MAX_OPTIMIZED_LENGTH / sizeof(kprobe_opcode_t); i++)
> +	for (i = 1; i < MAX_OPTIMIZED_LENGTH / sizeof(kprobe_opcode_t); i++) {
>  		p = get_kprobe(addr - i);
> +		/* A disabled probe can have prepared, but inactive, optinsns. */
> +		if (!p || !kprobe_optready(p) || kprobe_disarmed(p))
> +			continue;
>  
> -	if (p && kprobe_optready(p)) {
>  		op = container_of(p, struct optimized_kprobe, kp);
>  		if (arch_within_optimized_kprobe(op, addr))
>  			return p;
> -- 
> 2.55.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
