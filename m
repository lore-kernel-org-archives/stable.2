Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975521;
	b=lG7o0oLU4IQ9sXjpMPAY+4lZAvxRIkUn4Y0s6RuYDcbQI2UulfL0aakiFOWnS5YWLQwq
	 ZRuelqCuoFpEGGCVeqU+VfusN+XaCUhrnLxTDJ3XCdChE11NXqlsFQMgOHQAYomgYfqla
	 nGmARYkWcTgXMEe5NIMkB+DmWLsqkJD7BjmGrLEk8FGKffNVhAoFFz7G5LAhj7p2lZknE
	 dwbGEGqBtcamGB20dUnlyX+afCYNtnSkGGSRFcy3olo6+dFv1bKXxSmA8roTMedeSwXr6
	 bdzuf03KYhvj7f96wBHVqH5Yxr9WnLPK6YtANTGqGimM/HIoQ5FSO5JD7ily/pTZxkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975521;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=mdIhThb+jl2JUlwhVMSBEXIMeVhHxJqzGZP7A7mVG/c=;
	b=R9IkIhoKqKYuplrHvfMPHJVoXO2Xl1ZAgyRBHI/zesBEWpheKJWj2pDRGuV6pnnIJbZY
	 GBHRghCS3z2nFgDyp4TUWo/3cUPRflxFkCxE1Klf4Ue0aPvmIvjoMRjBBh2AxT9pHc2ew
	 dOZqci48lE11Fjf15+RmayVqIG+E+QWSM5pX2L5aCXXJNne0WZ3fKuHm3eJY4wcrmHaTo
	 6nkYSXAilwrkFFQVd25kAS+DL9gZfDyQNWVglBfF5vMNhhnvIyZlCrAZUqdmzJ+VONJyx
	 EEYfE7qumoZIs1JTFmAR31CggQXUD6O22ST2HNqstZRCT3cstCbJyXlNMGm72LnEXsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=iNqYcSUl;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69841606A330;
	Fri,  6 Nov 2026 14:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69841606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=iNqYcSUl
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 617FA1476;
	Fri,  6 Nov 2026 06:31:56 -0800 (PST)
Received: from [10.2.197.99] (ewhatever.cambridge.arm.com [10.2.197.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDE213F673;
	Fri,  6 Nov 2026 06:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793975519; bh=6klzQevvhvEQ74bOoMK8uucvxb17Dyoq6PMUlG5MA7U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iNqYcSUlgmf6qh5LNrg7ArXmgondI0M65+F4fe78P2DyEalQDtv9Gi3fhXBkZg0cb
	 dqNSg9+xwH1Sr8r1X55GmuynHigaZAjurOD3VXobCpwLFsyJC6Z2JtVfMgH7yyX0v2
	 Ho/6cay2Z+BgJV1/Age2QHTrw8AEC9lQOLQM0cWI=
Message-ID: <1312ec44-bc4a-427c-876e-1405e8c46e0f@arm.com>
Date: Fri, 6 Nov 2026 14:31:56 +0000
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
Subject: Re: [PATCH 1/3] irqchip/gic-v3-its: Zero ITS pages before sharing
 them with the host
To: Fuad Tabba <fuad.tabba@linux.dev>, maz@kernel.org, tglx@kernel.org
Cc: radu@rendec.net, lpieralisi@kernel.org, steven.price@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 will@kernel.org, tabba@google.com, stable@vger.kernel.org
References: <20261106120221.347309-1-fuad.tabba@linux.dev>
 <20261106120221.347309-2-fuad.tabba@linux.dev>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20261106120221.347309-2-fuad.tabba@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Fuad

On 06/11/2026 12:02, Fuad Tabba wrote:
> In a pKVM protected guest, the ITS driver shares every page it
> allocates for the GIC with the host, through set_memory_decrypted() in
> its_alloc_pages_node(). its_allocate_prop_table() is the only caller
> that doesn't pass __GFP_ZERO. It fills the table after the call
> returns, so until then the host can read the page's previous contents,
> at least 64KiB of guest memory.
> 
> Zero every page in its_alloc_pages_node() before it is shared. Every
> caller except the property table already passes __GFP_ZERO.
> 
> Fixes: b08e2f42e86b5 ("irqchip/gic-v3-its: Share ITS tables with a non-trusted hypervisor")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>

The patch, as such looks good to me and fixes the problem on pKVM.

We hit a similar problem with CCA, but not from a security perspective,
but a functionality perspective (crashing the Realm VM). There was a
patch proposed here [0]. The general consensus was to fix this for
all "shared allocations" and Aneesh has (had different attempts at this, 
but the latest) series is here [1]. Do you think something like this
would be preferred than fixing every caller like this ?

[0] https://lore.kernel.org/all/20260820150034.88729-2-steven.price@arm.com
[1] 
https://lore.kernel.org/all/20261104164555.3555725-1-aneesh.kumar@kernel.org

Cheers
SUzuki

> ---
>   drivers/irqchip/irq-gic-v3-its.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 282e4bafb084f..de1f1b1f26623 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -218,7 +218,8 @@ static struct page *its_alloc_pages_node(int node, gfp_t gfp,
>   	struct page *page;
>   	int ret = 0;
>   
> -	page = alloc_pages_node(node, gfp | gfp_flags_quirk, order);
> +	/* Zeroed, as set_memory_decrypted() may share the page with the host */
> +	page = alloc_pages_node(node, gfp | gfp_flags_quirk | __GFP_ZERO, order);
>   
>   	if (!page)
>   		return NULL;

