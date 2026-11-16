Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854213;
	b=hpalO7uDBoBAAMJ0FaYKcX4ojNDU8qeOiLjTMlceQ9vHjzgR/8V9tHqg6Ie7D4/msBZy
	 wlzsSirBbgOypQ5COee8To8MTrYYSiPDa5AP9DigXlSG12K80yo38zLtJMyPZaC6zrXn8
	 B35QxEnnx5droURZdEUu8XQO02Mxifp4Rvx9KDqdFcXGxyBrW3OtB6dB2lNc9mp+n8gHu
	 uaopSLleK+giWp5FQZwD7Q1nU0grYiA/4V4QPoItjIW0ricAiwO732OzUP81tkorGnpij
	 qtMZwWtWKNLxQy17JTF/EyqPi848g5L2AtMbDHKFNl9Rf7zcd+otrqQUqsA55y2DjQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854213;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=5vf/mrFyr2K5/oxQ9g09zxEySxJUY4RSC0I96yoXnUc=;
	b=WVvdcGWPzkHO+jBy3vI42ceqvpDMoUqdRjaNWCV7fc2Qdx2GDeOxjTalcbyNCvv8lZYu
	 94hZvuatOD7vZ2PIqjHd/QEsPYHSkln9HZLTXhN/595Po+7SNpGoms9oEzz5zYceY8Ztp
	 fjlYhtDl8MjSAq5hnT+aBu993xKG5jNA7uWnvIrr493gxodDf5HcyUE5YYA6rVYK8+8+5
	 MEvAZJNF1yuUrOGH34Sbi73Q68fSHPCxVCQrHECXkQRg6pD6bLRQF2LbQN7SlA3GisqBi
	 k6p+fTyKGHbK/avFIJ2F9ZPC1yDfuNcI/jgFtOB6o7XMl7g+2tLDEh9cB8gB1eqN10w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KJ+AXqZY;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC61606A323
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 18:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BC61606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=KJ+AXqZY
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8b5c3288e6cso1686953b3a.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794854212; x=1795459012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5vf/mrFyr2K5/oxQ9g09zxEySxJUY4RSC0I96yoXnUc=;
        b=KJ+AXqZYM6QUTky08dH4rGMnNziYxgt+htQil+Bdh2lqFqEpNCuxYnwDXiFwm4GO4M
         dCqLszXCFm0cK5sQ5SxNU+bwOWXqrrkAyYVzpZt9QAkuZv4Its2LO7cFm2AYig9jCh4P
         IRFivHmfGd3878zoM/MK3sdmf+Y/K/cfYRsnmgEwkgtYoZMcaRBRKRzbSx1hSkbLzop1
         IXZaBeau+zZFtZGSq3G+zXfCm2GsvFCt5GROQ0dtp58oW8rQXUs/lAjEBjiFD/cXHI6j
         oKmxdd8gQQQI4dXA1GUgrvfiRJCL0ooA1j0fe6MdQZCHSaL63AGnZfyVpwoPhUbiv60o
         HdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794854212; x=1795459012;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5vf/mrFyr2K5/oxQ9g09zxEySxJUY4RSC0I96yoXnUc=;
        b=0JuzCtDBxkTQq74weM3Qef9N7YGpWsB+4jf2x34qHajcALgsdVww7R3O8B4JLL8cOF
         j7SVgM0dU5LECIGsmAYGLStdLFHVfyhJqYEvEv66MGXurywArt20vjlEHy950xN+4pRm
         W74qLNGCxuz0Z9q+rjiG4BrnFGyU5jHW8wIR5H//tKwxXZbfTgUjb7Em5PXvHBT0Pv1c
         074tcbBDHjvxkLQFOSUqASxMFecTIji/DiwjSzXMhV1Bow0NI3u9QiRq4QGYIPs0g3sp
         wudwGgddkzigW3qtwkuo+bsliIv42mXdr1tFk32qiY6revEYtaYb9MICy8gXECZJAwpN
         OorA==
X-Forwarded-Encrypted: i=1; AL+hErHHCsZuUfXbKxoqZwrLulqG0MaW9dxmth9vcHTZ0Q6XuAkAjGtiPmP5qM+J9b+zjOHVYLzoWrI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0JuywDYAbyQR68P5VkA35IDdIP3xx+1DCx2RCtPbb95MSnDCu
	Polm5rgHUp7fgbYX6Wu82Z5ecvhTi3wlcvD4LhKd4Ca3vgqNz9K5ZjNE2b/MQBbllQ==
X-Gm-Gg: AZFdTZe+iN5i2YQaimBuiUrOra+JwXqMNPl7SRfHYPAi4sw0XV1Exvi+QJLPoWH7leP
	KfjBIAZCt2pWHvBzw3v89zeZWbXJidnkSsLX701QvillowKI5zRtGkG6pwShtQcGPEkQIEamHpF
	DgVnwR/9rut8p4ILHHPFYZGbTXSlOLOq8owaOWOEd8fB2PuOTjI3XhFuJ2AEq/bs1fUcOzdDLgb
	9ZrVwVeGVu5zU2ViVsd9n7mcABUl5LUG1RCO3WhhzRtsv5WZ3mDBvn+xkB0Tk/1pzkOu3030N/I
	qJBC6cJEA0/Gpro3NOFTRUw6ZXXlZP9dmn+eJFfA3QnSGiLf1Edq4AN0wNMyhzjVWkFTl9a8we6
	02EAnrOdJSHdyBWiUEYnvjaDGg301ATTny+TS2LEfLOxKH3zFef+BN62GBZY2yCT6jI1byFVCJl
	+egCPIt9fSl+RziptPnvcRti7Nkfxx/5tdwfn7a9A8iQXJqaJYntHVZjHdVDsY+gX4Yg+JfiRIV
	tJndtPf/Qn8FKBdla3ci20ECqpXYudEiv2DS6b5cLR2T30sXuGxFiNBhJInxd+si44c5wQw/SDW
	OCl5QLhBfv52IZgxIQ/kYyIDEOQ5Bdqw9FCVKHn/6cmhUc286/cWiu/VUIfFiXyWYSigVvEw5ks
	l9hbRJQuqGYc01P/q9ZPjCR8CMMdUl3N5D1cjOm6pSvpaEshh4mDScTa6pDQDtOQZ/1Qdn0b20i
	fBUfazhlRZglcGO4bL7ttcB56f3CWCZKTTZQ==
X-Received: by 2002:a17:90a:e550:b0:3b3:a4ef:dcce with SMTP id 98e67ed59e1d1-3b3a4efdd63mr901353a91.24.1794854211639;
        Mon, 16 Nov 2026 10:36:51 -0800 (PST)
Received: from google.com ([2a00:79e0:2e87:6:9050:473d:cdf:7c63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3ac606d8csm345808a91.16.2026.11.16.10.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:36:50 -0800 (PST)
Date: Mon, 16 Nov 2026 10:36:45 -0800
From: Nick Desaulniers <ndesaulniers@google.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	stable@vger.kernel.org
Subject: Re: [PATCH] sched/topology: Avoid unsequenced accesses to jiffies in
 sd_init()
Message-ID: <avtMzjJxIpFWkW-L@google.com>
References: <20261114-topology-wunsequenced-v1-1-686a36fe61f5@kernel.org>
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
In-Reply-To: <20261114-topology-wunsequenced-v1-1-686a36fe61f5@kernel.org>

On Sat, Nov 14, 2026 at 09:19:52PM -0700, Nathan Chancellor wrote:
> After a recent improvement in clang to warn on unsequenced accesses to
> volatile variables [1], an instance appears in sd_init(), which can
> break the build with CONFIG_WERROR=y / W=e:
> 
>   In file included from kernel/sched/build_utility.c:86:
>   kernel/sched/topology.c:2008:29: error: unsequenced accesses to volatile qualified 'jiffies' [-Werror,-Wunsequenced]
>    1998 |                 .last_balance           = jiffies,
>         |                                           ~~~~~~~
>    1999 |                 .balance_interval       = sd_weight,
>    2000 |
>    2001 |                 /* 50% success rate */
>    2002 |                 .newidle_call           = 512,
>    2003 |                 .newidle_success        = 256,
>    2004 |                 .newidle_ratio          = 512,
>    2005 |                 .newidle_stamp          = now,
>    2006 |
>    2007 |                 .max_newidle_lb_cost    = 0,
>    2008 |                 .last_decay_max_lb_cost = jiffies,
>         |                                           ^
> 
> Per C11 5.1.2.3.2, accessing a volatile object is a side effect. Per C11
> 6.5.2, unsequenced side effects on the same scalar object are undefined
> behavior. Per C11 6.7.9.23, the evaluation of the initialization list
> expressions in a designated initializer is indeterminately sequenced
> relative to each other, meaning any side effects in the initialization
> list are unsequenced.
> 
> Move the initialization of these fields outside the designated
> initializer to place sequence points between the accesses to jiffies,
> clearing up the warning.
> 
> Cc: stable@vger.kernel.org
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2190
> Fixes: 2b4cfe64dee0 ("sched/numa: Initialize newidle balance stats in sd_numa_init()")
> Link: https://github.com/llvm/llvm-project/commit/955715460eaf9188c241c74750637fc82dfcc423 [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  kernel/sched/topology.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 99878da03bce..f5975079f453 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1994,7 +1994,6 @@ sd_init(struct sched_domain_topology_level *tl,
>  					| sd_flags
>  					,
>  
> -		.last_balance		= jiffies,
>  		.balance_interval	= sd_weight,
>  
>  		/* 50% success rate */
> @@ -2004,10 +2003,11 @@ sd_init(struct sched_domain_topology_level *tl,
>  		.newidle_stamp		= now,
>  
>  		.max_newidle_lb_cost	= 0,
> -		.last_decay_max_lb_cost	= jiffies,
>  		.child			= child,
>  		.name			= tl->name,
>  	};
> +	sd->last_balance = jiffies;
> +	sd->last_decay_max_lb_cost = jiffies;

This pattern is going to wind up with two volatile (expensive) accesses,
(with potentially different values) rather than one access and the same
value by accessing `jiffies` once then storing the result in a temporary
local (before the designated initializer), then using that to initialize
the two fields in the designated initializer.

Example: https://godbolt.org/z/h8bvvKK6j

>  
>  	WARN_ONCE((sd->flags & (SD_SHARE_CPUCAPACITY | SD_ASYM_CPUCAPACITY)) ==
>  		  (SD_SHARE_CPUCAPACITY | SD_ASYM_CPUCAPACITY),
> 
> ---
> base-commit: d7e670601af6c564ccf6d3b2ddf70ee4f41a6d1c
> base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> change-id: 20261114-topology-wunsequenced-18f1d3b9167c
> 
> Best regards,
> --  
> Cheers,
> Nathan
> 
