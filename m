Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792567135;
	b=Eqi23KI6k9q9uYYgnafvsFzYdAKVqAGogOyGScbVG/FNsfSE8OH6rm9l085muMJ/glAO
	 HhjgFuGfodkjjzc2iGmHlMKyiMHRuRIy4D9ZuTHf/tAXC35QHWaq8WtWai2h/N+IVyu3M
	 hTsyHimxwZPeRRPzmhXhDDk3bEhw4sEYzOWF81PrHxrpNnoPrligBfZ93T8n0S8iSOMiA
	 1ZgfsxteNezywmek68B+k3Gz1x3b9b883aNLrDYWX0ApRVlaUaLSF2bYI4qywrq3CxkRg
	 BoG/8SVSHNvyqFUKy70Yeo02cpFweJXP9yY5YfOpRxPZYXZu/Iio3eckK+op0wkLYAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792567135;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OkzJOC3U9s+7WzyFCx87rKjdb44EwEf0x4LnQn1JlY0=;
	b=AK9WOxtXaihKh5+t4cPO2MiYBXjAe6YpLV88vBApF8Sc/Doc5q7FQHyjSapspIzb4eFn
	 8+1mvqebBntZtAGefvxW1Z9AJf2SJCa2+Hf9xBSFTRhVuUOVNSsOq75K4VqmwgJ84vGTI
	 yuieZ4ErYr5/vOJbe0VQQw1xYjxAR222IH7psfuMfk0thvDp81ujw6RY/kVoFGT0e1o8e
	 +n1pwj/OMRscKTbTarE70g/1e6+SRe0Svcqgt1bMFbf9zjfpY4FmaAMXbtR0HvoY9Nd5x
	 O3cg2VHmB6TK+pyVjqE1OcFEI7iuZM1TNmIjsgD9KXVOv28HZZ9wCNKTpHHhIrwcbCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ehajmxh7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50031606A319;
	Wed, 21 Oct 2026 07:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ehajmxh7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B582F1F000C9;
	Wed, 21 Oct 2026 07:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792567134;
	bh=OkzJOC3U9s+7WzyFCx87rKjdb44EwEf0x4LnQn1JlY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ehajmxh7dEMIk+Vp7En/Q731+aAMX1/6iwTRm58fxd/wTgf1uT5aYUfPGDmITFLec
	 uN9PfOOGFAh0wiymSXg52YPiAfeZKnDAg6ni9N7T9XSVGcQ5JEWykp0Edp/+Yxv1R0
	 D0GbhCMrjbw2vxZklfoBe6OdkraVndwYAKdFDC/NIzOQarfgRXt56zJm9YklMRq+JQ
	 4HGsTjybj5xpV3xq8U77fM9T/iymKerPf3bmN1EoCMdKoCFE4gFQh/WqjZqKZZ0YFR
	 75fS94vhdy0vVNZXu6q+BrUGwSjqGPeXZEIP43YuEOqBMQQJxx9LbNC9gmK120JVnl
	 IHont/63NJKpA==
Date: Wed, 21 Oct 2026 00:18:53 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Jinank Jain <jinankjain@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Tianyu Lan <tiala@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] mshv: Don't free overlay pages after a failed unmap
Message-ID: <20261021071853.GF851443@liuwe-devbox-debian-v2.local>
References: <20261012042851.389128-1-oss.patchbox@gmail.com>
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
In-Reply-To: <20261012042851.389128-1-oss.patchbox@gmail.com>

On Mon, Oct 12, 2026 at 12:28:35AM -0400, Yuho Choi wrote:
[...]
> 
>  drivers/hv/mshv_root_hv_call.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
> index cb55d4d4be2e5..9614cee4dad39 100644
> --- a/drivers/hv/mshv_root_hv_call.c
> +++ b/drivers/hv/mshv_root_hv_call.c
> @@ -651,8 +651,18 @@ int hv_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
>  {
>  	int ret = hv_call_unmap_vp_state_page(partition_id, vp_index, type, input_vtl);
>  
> -	if (mshv_use_overlay_gpfn() && state_page)
> -		__free_page(state_page);
> +	if (mshv_use_overlay_gpfn() && state_page) {
> +		/*
> +		 * If the unmap failed, the hypervisor may still be using the
> +		 * page as an overlay. Leak it rather than handing it back to
> +		 * the page allocator.
> +		 */
> +		if (ret)
> +			pr_err("%s: failed to unmap partition %llu vp %u state page type %u, leaking page: %d\n",
> +			       __func__, partition_id, vp_index, type, ret);
> +		else
> +			__free_page(state_page);
> +	}
>  
>  	return ret;
>  }
> @@ -1003,7 +1013,12 @@ int hv_unmap_stats_page(enum hv_stats_object_type type,
>  
>  	ret = hv_call_unmap_stats_page(type, identity);
>  
> -	if (mshv_use_overlay_gpfn() && page_addr)
> +	/*
> +	 * If the unmap failed, the hypervisor may still be updating the
> +	 * overlay page. Leak it rather than handing it back to the page
> +	 * allocator.
> +	 */
> +	if (mshv_use_overlay_gpfn() && page_addr && !ret)
>  		__free_page(virt_to_page(page_addr));

I would like to get an error or a warning here, too. Can you send v2?

Thanks,
Wei



>  
>  	return ret;
> -- 
> 2.43.0
