Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118302;
	b=XgJjL1zEVxAeRJycgQrA6Mb4wjrzJHF4QPVJKw4jYpGsAWvwEMbmhUvQWi1ezPilA01R
	 z6Uy0coy0omCqDutXmRIWb2/RF+9h9NlVg4YI7WROEqpJ4cZtzAUxqVxCTZZXcST2CuY6
	 Rky2sdv43QBURuyKX5gTZ5H+n1q2KFEJZ1qk1cbZcIW4xmaDAN1rx3LJnnqNeav1RAOQm
	 P5uFp750u+++APc7lHzQMCQeVFl9/A/dLCIltiMdfD1W4zfRKA2vZh2ZMp2bualmkro9z
	 6XvfQnwFOvxwlRrC98SLFWYGwH24LOk3X/tm30xnKX9JiD5q0nClQ0jK9kAZharSGng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118302;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YFn9N296AUPt1TT/Th8lkz66Ww2cz2FSkX+aWjJetro=;
	b=TxIcI6j0Rg8+m5AJVYuDJ70ap7Wa3R6O4kkDDVOhEsLt91eB3EjCsqzX1ldHZugbqP95
	 z3RzBVBs2zFCEl1UYVcYZn81JeUAtCSR/eC9KSQ+gu6NsXkTXLXNeYTvLmmc8slw/TSBR
	 9eERP7p5sQAq3mvR1WT7v+UMMyOssUyCWijzyHHEK5mOv34YpbaBjtBKJAIcuIRJNnFrn
	 wB5zzobUOwoCnoNIirTdCRaaXOzusZCUK0QkcqqYLp8WwmAYYg1bP9HgkKDmL59XqP/1w
	 lf9NWTZ3fLeax7gTx3UoMr5vlaNQ0iBOxJUB5Nt5CST0BB/DUVCkmcqdOzVqzHktb1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AhYSZEsk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BC5606A31B;
	Tue, 27 Oct 2026 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AhYSZEsk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0711F01825;
	Tue, 27 Oct 2026 16:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793118301;
	bh=YFn9N296AUPt1TT/Th8lkz66Ww2cz2FSkX+aWjJetro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AhYSZEskka/PikmfkvDAdES9PNgnFTXqk/mZRYci9ZDyns0UI2E82mD61H4xfSOU9
	 Sit+3fO12w+ICptraCT9A9x++YMyJfFQSSAgDBH7ZDCPvLNsythGYm6qEr26/g66Xf
	 hBtc9gWHFF3a8JOxXmeQvZF1yxhuJlNBCb99dfCG7I29V+TWHoJmHfsdP+Htgn60Cb
	 cp5+EmRPVzl0ObgXSUw1eTzAauKFtD7chDPGkTkcFkqASmUGziVmwh+BQjaOYq0c0g
	 oPniQDXXCWMBoL+HVJlw7JWnkzz3DGL1JjA6JSBK+GpzD+sODMkQmHZp7UsVbtPWFU
	 xsC9Lx+TnNbBQ==
Date: Tue, 27 Oct 2026 16:24:57 +0000
From: Lee Jones <lee@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: John Stultz <john.stultz@linaro.org>, mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mfd: hi655x-pmic: fix IRQ action memory leak on removal
Message-ID: <20261027162457.GJ2195460@google.com>
References: <20261027024609.117371-1-lgs201920130244@gmail.com>
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
In-Reply-To: <20261027024609.117371-1-lgs201920130244@gmail.com>

On Tue, 27 Oct 2026, Guangshuo Li wrote:

> hi655x_pmic_remove() currently removes the regmap IRQ chip before
> removing the MFD child devices. regmap_del_irq_chip() disposes the
> child IRQ mappings and removes their IRQ descriptors.
> 
> The hi65xx-powerkey child registers interrupt handlers using
> devm_request_any_context_irq(). During child device removal, the
> device-managed cleanup calls free_irq(), but the corresponding IRQ
> descriptors are no longer available. As a result, the allocated
> struct irqaction objects referenced by irq_desc->action are not
> freed, causing a memory leak.
> 
> Remove the MFD child devices first, allowing their device-managed
> IRQ handlers to be released while the IRQ mappings are still valid.
> Then remove the regmap IRQ chip and its IRQ domain.
> 
> This issue was found by our static analysis tool under development.
> 
> Fixes: eb10245fb37e ("mfd: hi655x-pmic: Add powerkey device to hi655x PMIC driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/mfd/hi655x-pmic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/hi655x-pmic.c b/drivers/mfd/hi655x-pmic.c
> index 5cb392892c19..3a7ccc9d30b7 100644
> --- a/drivers/mfd/hi655x-pmic.c
> +++ b/drivers/mfd/hi655x-pmic.c
> @@ -147,8 +147,8 @@ static void hi655x_pmic_remove(struct platform_device *pdev)
>  {
>  	struct hi655x_pmic *pmic = platform_get_drvdata(pdev);
>  
> -	regmap_del_irq_chip(gpiod_to_irq(pmic->gpio), pmic->irq_data);
>  	mfd_remove_devices(&pdev->dev);
> +	regmap_del_irq_chip(gpiod_to_irq(pmic->gpio), pmic->irq_data);

What about devm_regmap_add_irq_chip() and devm_mfd_*()?

>  }
>  
>  static const struct of_device_id hi655x_pmic_match[] = {
> -- 
> 2.43.0
> 

-- 
Lee Jones
