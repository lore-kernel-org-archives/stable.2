Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1F34F4723
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646791; cv=none; b=YmSTxi6J85UJ8x3izUSxK0vW6PFZIK3Kk26rCa7rezLXMLjv4zlaCRazMMJUaOwR4CuB8NH11Oo475eSNsYnvOAuzdCaNbzaK1I4rK77zFXqsgMlLFia/hqoNCODZsQ4Z8LZLEHw/xaaHTT8pfvMwtHir/CgzEnKBsBew5rx/O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646791; c=relaxed/simple;
	bh=dRFlG8fiSREEezDaEkf7iAogeenEFgXIPs9L7BQManU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9WAmQO+faFDXL/ZmDGDdCnBb+uyHdXj206r582AFyQFnCHhgqYGx5FvN3P+mMOVvvmMsGsjVH6950pLdkpMVNp93CB7uewsRH4y1RP2bfNgEttAkjMzPmBwFwYm22ZUMGbx5ImhPcsTQeDX63xPBeV2GJD/LVkvDIk5g3fHC0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=m1lTADYf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="m1lTADYf"
Received: from [192.168.1.9] (unknown [106.222.231.207])
	by linux.microsoft.com (Postfix) with ESMTPSA id 13B1A20B7166;
	Thu, 17 Sep 2026 05:05:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 13B1A20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789646733;
	bh=Ld+nbDFrRsN6Tj4FouA6pLEcv0WnlnaanmIwFDXo7yU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m1lTADYfngI5daQZrl8hc7eS8Yk6GcDZQ121SXmkroo6kLqYGpeptXtRi9vrKEf7F
	 LPT8/dzvoDk2Zqn8ULg8ujU6vVFzwucaGFR8FaOZfNraOi+6Rk+iUOoW9PJWh28n6t
	 oUWEAfupDmoqJ4pftQ7iyz+kU9iQulXHRBluAIWo=
Message-ID: <1bfa2747-7f57-4b96-a005-9f4a92fe35b3@linux.microsoft.com>
Date: Thu, 17 Sep 2026 17:36:14 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y] net: mana: Reserve extra CQ slot for the fence
 completion CQE
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Jakub Kicinski <kuba@kernel.org>
References: <2026091623-upstairs-protrude-105f@gregkh>
 <20260916234249.3300330-1-sashal@kernel.org>
Content-Language: en-US
From: Sahil Chandna <sahilchandna@linux.microsoft.com>
In-Reply-To: <20260916234249.3300330-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17/09/2026 05:12, Sasha Levin wrote:
> From: Sahil Chandna <sahilchandna@linux.microsoft.com>
> 
> [ Upstream commit 80dd7e754b3aa9637a0758ad93fa209f9650ec48 ]
> 
> The RX completion queue is sized to hold exactly one CQE per posted RX WQE.
> MANA_FENCE_RQ makes hardware post an additional CQE_RX_OBJECT_FENCE after
> the packet CQEs. The current sizing reserves no extra slot for it and in
> rare cases, CQ has no guaranteed slot for the fence CQE when it is full of
> packet CQEs. This can lead to dropping the fence completion while the
> driver waits holding RTNL lock throughout the timeout duration.
> Reserve one extra CQE slot for CQE_RX_OBJECT_FENCE. mana_gd_alloc_memory()
> requires queue_size to be a power-of-two and at least MANA_PAGE_SIZE;
> the reservation pushes cq_size past a power-of-two, so round up the CQ size
> in mana_create_rxq().
> 
> Cc: stable@vger.kernel.org
> Fixes: 6cc74443a773 ("net: mana: Add RX fencing")
> Signed-off-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> Link: https://patch.msgid.link/20260901121837.3503240-1-sahilchandna@linux.microsoft.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> [ Replaced MANA_PAGE_ALIGN() with PAGE_ALIGN() to match the older tree. ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   drivers/net/ethernet/microsoft/mana/mana_en.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
> index 4afcb202e3509..2d1e5b83a0769 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -1662,6 +1662,10 @@ static int mana_alloc_rx_wqe(struct mana_port_context *apc,
>   		*cq_size += COMP_ENTRY_SIZE;
>   	}
>   
> +	/* Reserve an extra slot for Fence completion
> +	 * event (CQE_RX_OBJECT_FENCE) in case RX CQ is full.
> +	 */
> +	*cq_size += COMP_ENTRY_SIZE;
>   	return 0;
>   }
>   
> @@ -1715,7 +1719,7 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
>   		goto out;
>   
>   	rq_size = PAGE_ALIGN(rq_size);
> -	cq_size = PAGE_ALIGN(cq_size);
> +	cq_size = PAGE_ALIGN(roundup_pow_of_two(cq_size));
>   
Hi Sasha,
Thanks for fixing this for 6.1 kernel
Regards,
Sahil
>   	/* Create RQ */
>   	memset(&spec, 0, sizeof(spec));

