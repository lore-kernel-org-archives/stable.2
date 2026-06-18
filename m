Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293771CAA6C;
	Thu, 18 Jun 2026 19:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781811322; cv=none; b=EQlimjpZvvVJvHMH0nS5YOS5SSrSAWFf3ZLcO6fJes6Fo3oekIBnl1ArNfe7tQbeih7i91fJN+n612HsADq/rfhjYqBFU/bNJNbFLDm75JfD3x+bPkHRvOglO3Ln19fJpPOascQwmuHAUiuIl6iDe/fTO4JFvmH9Nda6tDzu2ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781811322; c=relaxed/simple;
	bh=4/UBLJbjm/QFsB7OizJsoc5gC5wP5K1TM71MH+Bf0b0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dwoqXESRRZKdFpZdBgHgOIqtb39s/iXJk6pe+5+6Q1q2UE6egYdxmbhbgNcPiY3tWsh2nl1obn58DnDjYT99qI6fr+UKPne23odOqXMlU1hQpNx4x9kCn7DYjKyQ2YOcjBQVT1gjmQKY+U1pCfbYaR9LX74Nd6CWdyJsHizKlsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=vzUoUQo8; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vzUoUQo8"
Received: from [192.168.0.43] (chfd-03-b2-v4wan-176392-cust229.vm15.cable.virginm.net [82.19.20.230])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 826BB741;
	Thu, 18 Jun 2026 21:34:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1781811283;
	bh=4/UBLJbjm/QFsB7OizJsoc5gC5wP5K1TM71MH+Bf0b0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vzUoUQo8Kianftd/0vqgU0q302Itbz3Y7bSgrX1cBjorA1bh/SiJ3eBAjWB+8hQQo
	 qAplmGQIRsPv0LTAz/G33hpVHfmfC50FX1UEaoeU6URYOEU+4wsxCepADMdruqo8A9
	 LTGv/pjG8xi64YKaqisbGoZF4f0vQOls4QHq5j1U=
Message-ID: <5663f0e9-cde5-4943-9e77-267cd92f8742@ideasonboard.com>
Date: Thu, 18 Jun 2026 20:35:15 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: mali-c55: Fix scaler factor overflow for large
 crop sizes
To: David Carlier <devnexen@gmail.com>,
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260610215649.98274-1-devnexen@gmail.com>
Content-Language: en-US
From: Dan Scally <dan.scally@ideasonboard.com>
In-Reply-To: <20260610215649.98274-1-devnexen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David, sorry this one slipped through the cracks

On 10/06/2026 22:56, David Carlier wrote:
> The horizontal and vertical scaling factors multiply the crop dimensions
> by MALI_C55_RSZ_SCALER_FACTOR, a Q4.20 factor of (1 << 20). Both operands
> are 32-bit, so the multiplication wraps before the result is stored in
> the u64 scale variables. For any crop dimension of 4096 or more (the
> maximum is 8192) the value overflows; an 8192 to 4096 downscale yields a
> TINC of zero, so the scaler never advances and the output is corrupted.
> 
> Cast the crop dimensions to u64 before the multiplication.
> 
> Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>   drivers/media/platform/arm/mali-c55/mali-c55-resizer.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-resizer.c b/drivers/media/platform/arm/mali-c55/mali-c55-resizer.c
> index c4f46651d..0713e7d43 100644
> --- a/drivers/media/platform/arm/mali-c55/mali-c55-resizer.c
> +++ b/drivers/media/platform/arm/mali-c55/mali-c55-resizer.c
> @@ -422,8 +422,8 @@ static int mali_c55_rsz_program_resizer(struct mali_c55_resizer *rsz,
>   	mali_c55_resizer_program_coefficients(rsz);
>   
>   	/* Program the V/H scaling factor in Q4.20 format. */
> -	h_scale = crop->width * MALI_C55_RSZ_SCALER_FACTOR;
> -	v_scale = crop->height * MALI_C55_RSZ_SCALER_FACTOR;
> +	h_scale = (u64)crop->width * MALI_C55_RSZ_SCALER_FACTOR;
> +	v_scale = (u64)crop->height * MALI_C55_RSZ_SCALER_FACTOR;

Might be nicer to define the macro with ULL instead of a cast, what do you think?

Thanks
Dan

>   
>   	do_div(h_scale, scale->width);
>   	do_div(v_scale, scale->height);

