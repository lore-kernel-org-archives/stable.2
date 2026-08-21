Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308123F410A;
	Fri, 21 Aug 2026 05:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787288510; cv=none; b=PvI4rD/8e4B707mTYlDYTNQNTHdTvMgZT8HKe3y87rA2aIYS7CH2/4IESUrHy8STGixajSw+BhtNqp5PFOoqM1nZK2aeFhuUP7dI6BDC2A8L1S6IWXHAtNdoydJ3aXasdGk+Z4yRxYGOJwCEtmopB87H0yF3gjK04MqQrtMfY/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787288510; c=relaxed/simple;
	bh=al37GYkNzcfxG7FaDQkiKDYwvNmVdsNmgqz/IzqbceM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ljkZIsd12/qPVNuFbjuRobtBEH2BRl6H0pLGTkpzerSfC121T+vhJ+8QgEnSBJ3eHFFqMrMpkIQYCLzcd0URd1IRP/23Hz6OS4L53O8ExEwaY718icJeDXF389x/EHxQAAiq+gDWzknOOsZCr1jX2kaOrRd8H4RIl2NjnGpVA2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=iBvClYjp; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="iBvClYjp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1787288507;
	bh=4tnMYh+oI21IpYUCuMyfeXfmy4KBHYlUuR2YrMcvJMM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iBvClYjpqzt6x0Q/1JnDtQLtEV62/jDDgl4S+xJRYIvbGX/3P6vwFQHoHI6C6z5G2
	 d0a4PgBDqKgH+sgRjpdq2msGk0rU7SjoO6IgH6fCX33gl2NYNpZNlCHf0MQW+Dlv+5
	 s3j8g97+BIaH1+VbTgNU18kSUTnQXFl8nsxdfQiE=
Received: from [0.0.0.0] (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com [IPv6:2607:8700:5500:e873::1001])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1))
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 5107865BE5;
	Fri, 21 Aug 2026 01:01:44 -0400 (EDT)
Message-ID: <285743d2-6b4b-44e5-a0e2-b43a5e3cda29@xry111.site>
Date: Fri, 21 Aug 2026 13:01:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] cpufreq: loongson3: Replace IOCSR read/write with
 MMIO ones
To: Huacai Chen <chenhuacai@loongson.cn>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xuerui Wang <kernel@xen0n.name>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org,
 jeffbai@aosc.io
References: <20260818123921.3600606-1-chenhuacai@loongson.cn>
 <20260818123921.3600606-6-chenhuacai@loongson.cn>
Content-Language: en-US
From: Xi Ruoyao <xry111@xry111.site>
In-Reply-To: <20260818123921.3600606-6-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/8/18 20:39, Huacai Chen 写道:
> Our server productions (e.g. Loongson-3D6000/3E6000) can have multiple
> nodes in one package and SMC mailboxes are also per-node. However, IOCSR
> read/write can only perform on the current node, while sometimes we want
> to perform on other nodes (e.g. when switch governor, the get and target
> callbacks are not run on target core). So replace IOCSR read/write with
> MMIO ones.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   drivers/cpufreq/loongson3_cpufreq.c | 31 ++++++++++++++++++++++-------
>   1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cpufreq/loongson3_cpufreq.c b/drivers/cpufreq/loongson3_cpufreq.c
> index c75c0e30e881..e5062cd62390 100644
> --- a/drivers/cpufreq/loongson3_cpufreq.c
> +++ b/drivers/cpufreq/loongson3_cpufreq.c
> @@ -164,6 +164,12 @@ union smc_message {
>   
>   #define FREQ_MAX_LEVEL			16
>   
> +#define MMIO_SMCMBX(node) \
> +	((void __iomem *)(IO_BASE | (u64)(node) << NODE_ADDRSPACE_SHIFT | LOONGSON_REG_BASE | LOONGARCH_IOCSR_SMCMBX))

NODE_ADDRSPACE_SHIFT is defined in numa.h so that file needs to be 
included, to avoid a build failure when NUMA is disabled (if NUMA is 
enabled, numa.h happens to be pulled in via some other headers).

Also I'd suggest to use nid_to_addrbase(node) instead of hard coding the 
shift for better readability.

With the changes:

Tested-by: Xi Ruoyao <xry111@xry111.site> # on XA61200
