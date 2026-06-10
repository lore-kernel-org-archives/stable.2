Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAEC376A1B;
	Wed, 10 Jun 2026 06:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781073838; cv=none; b=ICKz3EbtyNUQuTbhASRmUkNhJLV87euAKvTtJL3zStGL1r97fy/0MvOL565Z49b2K3JMJdRl8VMI3i+IxngxteexQgZuLIW7B5Y5Vm4/7G38+Qwx3hfdxwBt09WJmgZMUReLzCLqQG0pp+sIGlootPeDKzb72+a4i4tmvwtybsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781073838; c=relaxed/simple;
	bh=5inMq/XR960HU/BSti4Yji3fGwSGFSYzXWRfVD+iWWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DSsCtZXENyeu2DiMBpw40wmawJQUxxO8oaoKTNF5uGPKVWs85Sgy29Wh/Y5CrF2mndHd65ae+n5jgHdHO8/f9dvaJ9PyPb6Z6D7fLohErmQe3DN/gOOGIl51JnhlT7fwrlwZFsqqlvTglfq6FuTE8hYFK5mJIsAgqLzt0CyMEzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=wixy1yu2; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="wixy1yu2"
Received: from [192.168.0.43] (chfd-03-b2-v4wan-176392-cust229.vm15.cable.virginm.net [82.19.20.230])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 843F4517;
	Wed, 10 Jun 2026 08:43:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1781073805;
	bh=5inMq/XR960HU/BSti4Yji3fGwSGFSYzXWRfVD+iWWw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=wixy1yu2LHIbIvh0JqaVerABA5qPy9J7y858DdSPeSbooUqpGugxNi27tqtIdnC/5
	 ANMblWBq3hPPGqpHI4AKuiWyfXBP3wDG9BbzpczoqWxcK3EmTAHIdM3NmJspfe42ZP
	 KiO4O/yKfuvlsLwXVbu2DCNCueHCNjFL3hgVCVZc=
Message-ID: <56b1e92a-ebdd-4ae1-963a-9e3225863c56@ideasonboard.com>
Date: Wed, 10 Jun 2026 07:43:50 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: mali-c55: fix integer overflow in scaler factor
 calculation
To: David Carlier <devnexen@gmail.com>,
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil+cisco@kernel.org>,
 Nayden Kanchev <nayden.kanchev@arm.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260529024429.6942-1-devnexen@gmail.com>
 <20260529050649.14109-1-devnexen@gmail.com>
Content-Language: en-US
From: Dan Scally <dan.scally@ideasonboard.com>
In-Reply-To: <20260529050649.14109-1-devnexen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David

On 29/05/2026 06:06, David Carlier wrote:
> The scaling factors are computed by multiplying the crop dimension by
> the Q4.20 unit (1 << 20) and dividing by the output dimension. The
> results are stored in u64, but both operands are 32-bit, so the product
> is evaluated in 32-bit arithmetic and only widened afterwards.
> 
> Crop dimensions may be up to 8192. Once a dimension reaches 4096 the
> product overflows 32 bits and wraps (zero at exactly 4096), programming
> a corrupted scaling increment and corrupting the downscaled output.
> 
> Define the fixed-point unit as unsigned long long so the multiplication
> is done in 64-bit arithmetic.
> 
> Fixes: d5f281f3dd29 ("media: mali-c55: Add Mali-C55 ISP driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>

Thanks for spotting this:

Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>

> ---
> v2: Use the BIT_ULL() macro instead of an open-coded (1ULL << 20)
>      (checkpatch).
> ---
>   drivers/media/platform/arm/mali-c55/mali-c55-resizer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/arm/mali-c55/mali-c55-resizer.c b/drivers/media/platform/arm/mali-c55/mali-c55-resizer.c
> index c4f46651dcee..6706939b4a90 100644
> --- a/drivers/media/platform/arm/mali-c55/mali-c55-resizer.c
> +++ b/drivers/media/platform/arm/mali-c55/mali-c55-resizer.c
> @@ -15,7 +15,7 @@
>   #include "mali-c55-registers.h"
>   
>   /* Scaling factor in Q4.20 format. */
> -#define MALI_C55_RSZ_SCALER_FACTOR	(1U << 20)
> +#define MALI_C55_RSZ_SCALER_FACTOR	BIT_ULL(20)
>   
>   #define MALI_C55_RSZ_COEFS_BANKS	8
>   #define MALI_C55_RSZ_COEFS_ENTRIES	64

