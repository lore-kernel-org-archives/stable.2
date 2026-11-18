Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794999725;
	b=TKOX23ydv9W/dXHyXqAd5mvEUOYZBYBTnVFUg9qOaqms5Ip5rFSSkY4NB+LgsdUeZLbt
	 Tjtx26LhewOKEHyPzSloLP7eeync7ZcmgEKK9a1kimKbeHEYCOe3LQaX0eMtW8ApsmOav
	 FAIW+GCEN2rfI07CkweIxjOz/8qnuo82VMb6pd6P/oiMIBu3lHRuCVgPs/oQZwMgGqJad
	 orm1Dm4g4EYOnGsPj0546I4zLBniylHfJUgbOW+zp9nx0ni9X5bExbjyAALuglCtHw238
	 1BIZTIuk4HhFxA14gcwSSlPMBJdeuuCahySFv/AW8tx/GvokO3JgDmoGWqI6tGOhf2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999725;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=6ffufnkevwO9vAPh1vevODopGUaiiKz9CA2eJcqQaCg=;
	b=sFTtui/3O/73oqOqvpBhcx4JbAtrIlu4KLd2MjnZZsYSrbvNnEI4EFfuE8yXL9FIMlvn
	 41JlSCUF13sT8cS3t+oAmqrz7/Qd1bxUjyhxSz2Wp7VRY4UeNeII6MbLuSktxX7BliW19
	 1CUbPljuJDHQCcCjXCuoLVOO9r0x2XpBjkeCw05FWxLZsL5PAJ2MDziCnpcbDFtkE/gkh
	 SVltbvNmSSHpTMK/YTaeiwGEGbekiHTg0nOuk6RxnrKfvdGfS1mc3JHJMoHpJyiUd7QdH
	 k1nV2FBROeHT+QAX666XfNJ8IHa4ypxsW61GtwObYDOHMNawp67HpnCKpiytNDKCbwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=bKW0qTq0;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BE7606A32C;
	Wed, 18 Nov 2026 11:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7BE7606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=bKW0qTq0
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54F07339;
	Wed, 18 Nov 2026 03:02:00 -0800 (PST)
Received: from [10.0.154.42] (e121487-lin.cambridge.arm.com [10.0.154.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85DD93F632;
	Wed, 18 Nov 2026 03:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794999723; bh=hYNm5P0vnO8U/haSHt1cJzP127qSvrRU04WHL1UF9Po=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bKW0qTq0u56OK8+5FBBAikIOYVawRxzDbtctJrhm5/9bv6soS79Yb1t1oHtma9Ub3
	 vFjlA43eotGjqgbRsdn9vOy+oYbww7mkkd6Nz/f197Fdp5ygYOWqJv0Eb0goONBaT3
	 1U8AN2vNuXZ3HwPhTCDTxYGmT+3GNRvISpI0jXNM=
Message-ID: <f232d0ff-3286-4d85-b9e3-cad8c6bc7178@arm.com>
Date: Wed, 18 Nov 2026 11:01:57 +0000
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
Subject: Re: [PATCH 3/3] arm64: head: set __entry_task along with task setup
To: Ada Couprie Diaz <ada.coupriediaz@arm.com>,
 linux-arm-kernel@lists.infradead.org, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Kiryl Shutsemau <kas@kernel.org>,
 Breno Leitao <leitao@debian.org>, Jinjie Ruan <ruanjinjie@huawei.com>,
 Doug Anderson <dianders@chromium.org>, Linus Walleij <linusw@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Huth <thuth@redhat.com>,
 Dawei Li <dawei.li@linux.dev>, mrigendrachaubey
 <mrigendra.chaubey@gmail.com>, kernel-team@meta.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261117174814.95936-1-ada.coupriediaz@arm.com>
 <20261117174814.95936-4-ada.coupriediaz@arm.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20261117174814.95936-4-ada.coupriediaz@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ada,

On 11/17/26 17:48, Ada Couprie Diaz wrote:
> `__entry_task` is only set after the first `switch_to()`, despite
> a proper task being set up in SP_EL0 as soon as CPUs go through
> `__{primary,secondary}_switched()`.
> 
> As SDEI can interrupt execution at any time, it can interrupt before
> the first `switch_to()` and use a null `__entry_task` to set
> its current task.
> 

TBH I do not know much about SDEI, but don't we need opt-in for
SDEI before we can get any SDEI events? If so, can we really
receive SDEI event before first switch_to()?

Cheers
Vladimir


> Set `__entry_task` as soon as we have a proper task set up in
> `init_cpu_task()` in case we get interrupted before switching threads.
> 
> Remove the second paragraph of the comment on `__entry_task`, as it has
> been incorrect since the introduction of SDEI, and even more so
> with this change.
> 
> Fixes: f5df26961853 ("arm64: kernel: Add arch-specific SDEI entry code and CPU masking")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> ---
>  arch/arm64/kernel/head.S    | 3 +++
>  arch/arm64/kernel/process.c | 3 ---
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index d6ba3c0af811..e53a9c6fec83 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -209,6 +209,9 @@ SYM_CODE_END(preserve_boot_args)
>  	ldr	w\tmp2, [\tsk, #TSK_TI_CPU]
>  	ldr	\tmp1, [\tmp1, \tmp2, lsl #3]
>  	set_this_cpu_offset \tmp1
> +
> +	adr_l	\tmp2, __entry_task
> +	str	\tsk, [\tmp2, \tmp1]
>  	.endm
>  
>  /*
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 42b15b0c069f..c3d194676efc 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -584,9 +584,6 @@ static void ssbs_thread_switch(struct task_struct *next)
>  /*
>   * We store our current task in sp_el0, which is clobbered by userspace. Keep a
>   * shadow copy so that we can restore this upon entry from userspace.
> - *
> - * This is *only* for exception entry from EL0, and is not valid until we
> - * __switch_to() a user task.
>   */
>  DEFINE_PER_CPU(struct task_struct *, __entry_task);
>  
> -- 2.43.0
> 

