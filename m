Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D933449A3C6;
	Wed,  7 Oct 2026 09:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791364479; cv=none; b=OUk+1fObTqPQ33EV0x8OVvJvFa5o7nCiUyh0oN0J1PBhPn2lY5E2b4SQhymd0Yn+NCeWQfDJmcEmZdDHRPR4PT8yss5mG6I08zlaqLOPrMa6D5pD4kM4ZvSFK5w8bDrEQ+jrOf9+OOZ6sGy1ERtAgVqm5m5sGw7S9uH7PQPcHhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791364479; c=relaxed/simple;
	bh=DW1mnaaHPrHpXBHjiY39nxmMlu4p8RseZKLYOaTIDmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JI4z9fCu6frBNO0rPvjUfcBr+IMg0fGGw+sRh8976XyxMtjBe9vFeF09tpHXJWyb5eB7Vmxec6DxiUurihsZ88S9fsY5uq9MWaGGEkR4J3JSxDRlhskdLehUgO5VaD2D0nlS3FqUXb7vtn51i+kdBnPCUJn6vZyPC2MyWxU8cYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=SRBtTWNQ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="SRBtTWNQ"
Received: from [192.168.0.43] (chfd-03-b2-v4wan-176392-cust229.vm15.cable.virginm.net [82.19.20.230])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 94F2115B2;
	Wed,  7 Oct 2026 11:09:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1791364190;
	bh=DW1mnaaHPrHpXBHjiY39nxmMlu4p8RseZKLYOaTIDmE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SRBtTWNQK+mbHOgYbCGkx/+R8rO9gSLWH8SbPiKVemNRsSB6760TL5CwWFKSzvyOJ
	 jyKR6AByV90Ne+r4yVJMimu68Y7ucxYud9SsqGcP3KajwwZZMih8DVjnp3KbYw5HWS
	 sj9Nf5+owDnfIm/WyKDFeDX43D/Zg7vp3HZwaPto=
Message-ID: <a44bdd3f-c28d-4f45-9c1c-174f5d979617@ideasonboard.com>
Date: Wed, 7 Oct 2026 10:11:44 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: mali-c55: Disable colour space conversion for RGB
 outputs
To: David Carlier <devnexen@gmail.com>, linux-media@vger.kernel.org
Cc: jacopo.mondi@ideasonboard.com, mchehab@kernel.org,
 hverkuil+cisco@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261006234242.11934-1-devnexen@gmail.com>
Content-Language: en-US
From: Dan Scally <dan.scally@ideasonboard.com>
In-Reply-To: <20261006234242.11934-1-devnexen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Morning David, thanks for the patch

On 07/10/2026 00:42, David Carlier wrote:
> The colour space conversion block is only programmed for YUV formats,
> and its configuration is kept across streaming sessions. An RGB stream
> started after a YUV one thus still converts its output to YUV.
> 
> Clear the conversion configuration for non-YUV formats.
> 
> Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>   drivers/media/platform/arm/mali-c55/mali-c55-capture.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-capture.c b/drivers/media/platform/arm/mali-c55/mali-c55-capture.c
> index ff01553026fb..2425a069a939 100644
> --- a/drivers/media/platform/arm/mali-c55/mali-c55-capture.c
> +++ b/drivers/media/platform/arm/mali-c55/mali-c55-capture.c
> @@ -577,6 +577,10 @@ static void mali_c55_cap_dev_format_configure(struct mali_c55_cap_dev *cap_dev)
>   				MALI_C55_REG_CS_CONV_CONFIG,
>   				MALI_C55_CS_CONV_FILTER_MASK,
>   				MALI_C55_CS_CONV_FILTER_ENABLE);
> +	} else {
> +		/* Don't inherit the conversion set up by a previous YUV stream. */
> +		mali_c55_cap_dev_write(cap_dev, MALI_C55_REG_CS_CONV_CONFIG,
> +				       0);

Makes sense to me:

Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>

>   	}
>   }
>   

