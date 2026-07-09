Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BD03F9A0F
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783593540; cv=none; b=mh3Nfd047WHG4EfxiFMmprY39Jr32WDOWOb/BNV4pEUwAcvFjlaINSH+cZ/0mdZVL6NPLr1Q/LF3lyWTUzOp2epfuy00Ars9Vxj/QyTp9zxpdOmn6wtXuUt+U5uBXGfIgBs2aGIa6N+PhkXLfj0I1x7/UyWQnmy87tzqeSuibqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783593540; c=relaxed/simple;
	bh=DOuG5gjS8VtY9hgxIHCg3ZQCp1FjR2d9Tt/GATMdNpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFAK86LJUksGLw3Aopy2LtcVXPo7nO7HtuasB9O0ysds3/P3ZwUWzZcFHhnJqXAXxctPRB8XJWiTKpWwRDtNvfCTQzHCRjEKmHmCY6/sSFdH9DLBknldSofKcDM9kR6BFgJh79bv/6fxjYdbgoJqTXZace27BEctWCeTFQsJ0fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ArqUx5zo; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ArqUx5zo"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-495c49f8eccso1197105b6e.3
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 03:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783593538; x=1784198338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AVlcql+y5AX7/oXVhdB5xhu8xk1LBRNpNhGhNJlFcnw=;
        b=ArqUx5zoktzFib6Sm+jNLDx87X+YYHieMXRt2xthrY4wjf4Q6MC4+Klfa3JD60vOKv
         VosYDfIGPob40aV6OFeQGTVvHXgHSkaM3o5wYc0z/JyD/ZphdYSUuZ4Mz3HTnn8tMqj6
         VKiMUg7ozvX8fuUg6ebvfGlXXRy4TsaQklzbA709I2Zqa8lRF3YEMQjZI+mnlbs9yX0k
         1Wfz5TcIKnI9vofHWnLFE7SEs60jsnH5ayGbmrFYdZlHhbqkMAyucc1deNZLW1/xCDPL
         0tGleX3lJPmN5yGmu24/YD68BHI0xbJ+aX3GLikM96xfkdIyjXwgrtAdTwH6hYOTM3Nt
         ICYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783593538; x=1784198338;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AVlcql+y5AX7/oXVhdB5xhu8xk1LBRNpNhGhNJlFcnw=;
        b=j0nOW5/RVA1+f2CZ5jju36FJ7z69+E7eOHoMMBkNdA0ToQ8MyVtxd8D3ronvjKUtWa
         3V635wo6iJS/X67EhpmjNTIrPqUjqCcUgzMkNUm2ZY8xG/LsfT0jaQvcgaAyUbKLmR+1
         b1BPf/CpN1p3NvmUJTsQ3GO1P5f17nmT1WEE9QIKHJw7QirWQU3Ipt3yMmnPlRI2Ay1M
         cBzLChUsKyniQE+Nv77E5uoiJXj0WG8USZc7hi6jzh2O1fJeVgirCOWdHvydqC4+0YDY
         2HomhIpyLS3gnxviTo661bbRYCjGPxLd+zwKrlsnL/aBADssB5RUVM7j2LrJnyjt33OF
         Z1Lg==
X-Forwarded-Encrypted: i=1; AFNElJ99uVlKXHRWS/2bstg5YJYBZ2VKq7VxK2uLUUONPxMhDYlfnbGNQvlNK4i9KljjP7HliHb0xXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE+56aztZKBdlMSVVaAJ0KKSu5VJ7gXh0LxBEjLcW3Uv40Juv0
	uwG5tp7ktyASI3Knw8eHxhwnkn/M5pAwp9WCAQ2bQbOZhMyrlrKsrwwT
X-Gm-Gg: AfdE7cnNQiS5dQ3lQ9TWK5M8cTFnUnyjxcBArf/20jierGiQXGppOjJ/s2ehup95lCJ
	CIlOen8s/mXzIEuBA2oX5NcjZRfmXvKyv9agcdxBzij/YZ36tyUf6dEJNSZCDIq0GMJduzcBp6k
	eGdvfaXRFWExGOpgAadZWfzQCq5pz3KSEP/BhM1JBRJ0VL19JDasC3qYg5PbNKqPpkCEereq1r7
	Q5CPJLdnivZOSzPps76F0njm6JCyLr1atffQKFd1udHuNt4xo7NMwyFmpZUih16GbnrDypx6Xw+
	VoSiNpzE//UvE+m+SrUKB4HR9eQ3T8fTn1XJk2nWxXj3Gpde0ylf9dirECXfFHmsowmBek3Uljm
	BMcd/XTlq8eUhN2huoSHd38d5kRSKN7+KuQPgEIqvBxJ2iavgBz2PUuKky0S5HU6DgFrIqyZwEJ
	wFdmOo
X-Received: by 2002:a05:6808:6c82:b0:497:8b9:bdc7 with SMTP id 5614622812f47-4a202d93e5dmr5395525b6e.15.1783593537569;
        Thu, 09 Jul 2026 03:38:57 -0700 (PDT)
Received: from localhost ([74.80.182.70])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1b02e5abbsm3510973b6e.15.2026.07.09.03.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 03:38:56 -0700 (PDT)
Date: Thu, 9 Jul 2026 13:38:50 +0300
From: Dan Carpenter <error27@gmail.com>
To: christian.taedcke@weidmueller.com
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	christian.taedcke-oss@weidmueller.com, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] dmaengine: nbpfaxi: Fix setting channel irqs in
 probe()
Message-ID: <ak96OkpYvJrK1Vbt@stanley.mountain>
References: <20260703-upstreaming-nbpfaxi-v1-v3-1-24f7f9aa102f@weidmueller.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703-upstreaming-nbpfaxi-v1-v3-1-24f7f9aa102f@weidmueller.com>

On Fri, Jul 03, 2026 at 09:56:12AM +0200, Christian Taedcke via B4 Relay wrote:
> From: Christian Taedcke <christian.taedcke@weidmueller.com>
> 
> When one irq is used for errors and each channel gets a dedicated irq,
> the total number of irqs is num_channels + 1. If the error irq is not
> the last entry in irqbuf[] but an earlier one, the loop assigning
> per-channel irqs terminates one iteration too early and the last
> channel is left without an irq.
> 
> Iterate over all collected irqs instead of num_channels so the
> error-irq skip does not shorten the effective channel count.
> 
> Fixes: 188c6ba1dd92 ("dmaengine: nbpfaxi: Fix memory corruption in probe()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Taedcke <christian.taedcke@weidmueller.com>
> ---
> Changes in v3:
> - Guard against out-of-bound writes to chan in case of an invalid eirq.
> - Link to v2: https://patch.msgid.link/20260702-upstreaming-nbpfaxi-v1-v2-1-e6d6b178a278@weidmueller.com
> 
> Changes in v2:
> - Advance chan only when assigning a real irq to fix out-of-bounds
>   memory access.
> - Remove now redundant ARRAY_SIZE(irqbuf) check.
> - Link to v1: https://patch.msgid.link/20260702-upstreaming-nbpfaxi-v1-v1-1-fd8ea8830cea@weidmueller.com
> 
> To: christian.taedcke-oss@weidmueller.com
> To: Vinod Koul <vkoul@kernel.org>
> To: Frank Li <Frank.Li@kernel.org>
> To: Dan Carpenter <error27@gmail.com>
> Cc: dmaengine@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/dma/nbpfaxi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
> index 05d7321629cc..b1f06f0bd0d5 100644
> --- a/drivers/dma/nbpfaxi.c
> +++ b/drivers/dma/nbpfaxi.c
> @@ -1374,14 +1374,14 @@ static int nbpf_probe(struct platform_device *pdev)
>  		if (irqs == num_channels + 1) {
>  			struct nbpf_channel *chan;
>  
> -			for (i = 0, chan = nbpf->chan; i < num_channels;
> -			     i++, chan++) {
> +			for (i = 0, chan = nbpf->chan; i < irqs; i++) {
>  				/* Skip the error IRQ */
>  				if (irqbuf[i] == eirq)
> -					i++;
> -				if (i >= ARRAY_SIZE(irqbuf))
> +					continue;
> +				if (chan >= nbpf->chan + num_channels)

Prefer my check, but sure...

It's pretty annoying that sashiko bot doesn't CC the CC list.

regards,
dan carpenter

>  					return -EINVAL;
>  				chan->irq = irqbuf[i];
> +				chan++;
>  			}
>  		} else {
>  			/* 2 IRQs and more than one channel */

