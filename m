Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAC946D56B;
	Thu, 10 Sep 2026 11:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789041267; cv=none; b=OW9wpqKeUZ6uU5+d9vqbga+Pfr4tUyFhaMjtFEoQPN8M0VgTWTKLN8JVUnwWJrkZ8GrsdUJhHN33gOOJSx+TX3fhLdxazXEiAz4oIWFkDpilbBl3IQPBv0je27Zeva2AlbKvH37ZoKTzr5yVksWCz0H99V0DjCFs8ICqTgcqRvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789041267; c=relaxed/simple;
	bh=Y+uakgmLTw/Dr6l7dxl0NA2ApiRxgkY7tsxnZpgnLH4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JeJh5pMY267+uBkFDutto/gxhgeZYgLMUPHCn5UHHnjz+LunthS2bQqtrHJ5ZFHnjm6sjHIQHju3iveb+80anvllAFjOzQH6gEgzKokZJ4oPazOvl82yQY1hBZOyvuJkoUlkG3PIBtL7VTwauZ2uLdB7cQwWSfEaqE2SgUAs1T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rb3RoQMQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rb3RoQMQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00AF1F000FF;
	Thu, 10 Sep 2026 11:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789041266;
	bh=242XIWZSUu69mtRg9ItrK23A7w0eKQWAiDhlvEiRp9A=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=Rb3RoQMQ/1hurXRmrj/1KGTRO1KGl1qo/db6tk5xmRdoL9iuVfRpkvP6MnEtyMa3n
	 FytlXmK6RHJfZ79xt4CdAcxQDYKTjg9ACGW9kSULGb7WtXpkNlT0yEsEFvemS45GYO
	 FcWRbwNyRpjOGCIHZyozY4f1BFGnZvJhFXGk5vGlIE+8/yaYCF1EvtiYobB+7Lnalu
	 8Ki/FDS7d+VF8wyNk/AjkEsSp9g/Mz0c3gHLz7voeahdhHjmRW/P6F0zFTYjmP+vdC
	 /AnxWMCEs/r5Ld3RB5WuBlO0U0MkGYYJ+bMbsPnDP9ES4enW6HIqF3aOlOJcKzyV2d
	 Qb2AT0Dh55kSA==
Message-ID: <77440bae-7381-451f-861d-1399bac4d925@kernel.org>
Date: Thu, 10 Sep 2026 13:54:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH] media: microchip: isc: Initialize DMA lock before
 requesting IRQ
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, ehristev@kernel.org
Cc: mchehab@kernel.org, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, jianhao.xu@seu.edu.cn
References: <20260830023228.2054498-1-runyu.xiao@seu.edu.cn>
Content-Language: en-US, nl
In-Reply-To: <20260830023228.2054498-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/08/2026 04:32, Runyu Xiao wrote:
> The ISC interrupt can run before asynchronous subdevice completion, but the DMA queue lock was initialized from isc_async_complete().  Initialize it in each SoC probe before requesting the auto-enabled IRQ and remove the late initialization from the asynchronous completion path.

Line is much too long.

> 
> Fixes: 91b4e487b0c6 ("media: microchip: add ISC driver as Microchip ISC")
> 

Spurious empty lines.

> Cc: stable@vger.kernel.org
> 
> Assisted-by: Codex:GPT-5
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  drivers/media/platform/microchip/microchip-isc-base.c    | 1 -
>  drivers/media/platform/microchip/microchip-sama5d2-isc.c | 2 ++
>  drivers/media/platform/microchip/microchip-sama7g5-isc.c | 2 ++
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
> index a7cdc743f..a2534d8eb 100644
> --- a/drivers/media/platform/microchip/microchip-isc-base.c
> +++ b/drivers/media/platform/microchip/microchip-isc-base.c
> @@ -1792,7 +1792,6 @@ static int isc_async_complete(struct v4l2_async_notifier *notifier)
>  
>  	/* Init video dma queues */
>  	INIT_LIST_HEAD(&isc->dma_queue);
> -	spin_lock_init(&isc->dma_queue_lock);
>  	spin_lock_init(&isc->awb_lock);
>  
>  	ret = isc_set_default_fmt(isc);
> diff --git a/drivers/media/platform/microchip/microchip-sama5d2-isc.c b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
> index 66d3d7891..f0f7ca47f 100644
> --- a/drivers/media/platform/microchip/microchip-sama5d2-isc.c
> +++ b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
> @@ -432,6 +432,8 @@ static int microchip_isc_probe(struct platform_device *pdev)
>  	if (irq < 0)
>  		return irq;
>  
> +	spin_lock_init(&isc->dma_queue_lock);

It's dubious to just init dma_queue_lock here but not INIT_LIST_HEAD(&isc->dma_queue);

I think Eugen needs to look at this as well to see if this is actually a valid
issue at all.

In any case, this patch doesn't look right to me.

Regards,

	Hans

> +
>  	ret = devm_request_irq(dev, irq, microchip_isc_interrupt, 0,
>  			       "microchip-sama5d2-isc", isc);
>  	if (ret < 0) {
> diff --git a/drivers/media/platform/microchip/microchip-sama7g5-isc.c b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
> index 7383341ec..b1aa3fe55 100644
> --- a/drivers/media/platform/microchip/microchip-sama7g5-isc.c
> +++ b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
> @@ -421,6 +421,8 @@ static int microchip_xisc_probe(struct platform_device *pdev)
>  	if (irq < 0)
>  		return irq;
>  
> +	spin_lock_init(&isc->dma_queue_lock);
> +
>  	ret = devm_request_irq(dev, irq, microchip_isc_interrupt, 0,
>  			       "microchip-sama7g5-xisc", isc);
>  	if (ret < 0) {

