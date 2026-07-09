Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FF731A7EA
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 10:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783592842; cv=none; b=O22up9c6PY74z+Vsk0FJPGiHaFQgUtyx/G4AA6lw/8Kti6YQZbBn9Buybzaw1zVXGXsdHwU4k3vFYp+uzTjUKm1ZxxhozXWNPDGFtK5JAbUAp48eJj3Uy3n/LOUqR7Ogk6DVNnAuygcE88zlFSEgktCPUaRH81810ACRjUbu+ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783592842; c=relaxed/simple;
	bh=L2WCr6taxGkTOVHzUf3RYCQ2nUSH6l8pW3+moY7GGhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gckS4v2oXc4F3jy/pd4L4UTm0BjGXiNXwOGXZDCNCMWxhCOqRkGa/VfCsQsJlEHyztRDo8Wrr4qZOpEzvaIbDHVtmcmFi5ufKwnP/qJA+aibyA+k0WN/E9qpSqOveK07jgznZ9yLNNA9MMkQUgInlB4HvKpQ3Gdtr6UHUHRy8eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XMmKUPyL; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMmKUPyL"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6a168dc590cso1195017eaf.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 03:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783592839; x=1784197639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yTHA/HAGmx+6vLyILbr+Ji6px3cTIRCKaDC8NslzL3E=;
        b=XMmKUPyL5cepxfvC1sytDE50rvwWz0WpmOPoZt0EQZc5uHqin6aH5olO9ekZzFKeZm
         kKgr3UHr2zIC+oTZNiGV+UbfvmI+yEfvz1JesK5Gn4j3wHGVvb5Hik3UxL8/P+tSd5hB
         5/Mhz6p0ZL6KMb1d0A6aDLqF7SnxQgD67P8eD8b6BMrqWZm3w1r3fZIaLPLlu1+WnHHJ
         QKnZuSfJrduak1B8fs5asfugeS7eOFsK0bqAtjLMiL+AOG4wHLY6KjoeS7c5+BJpBMLa
         khwlcdMeDphFSyhbQKNi57VpPi8A/FamsuhqKZW0Yg+D+dWjNmqlY/Jfx4DmWXfL8D36
         Y85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783592839; x=1784197639;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yTHA/HAGmx+6vLyILbr+Ji6px3cTIRCKaDC8NslzL3E=;
        b=gS2fsWHQD1JyE4TgjL8m4YzoeXn8ypZyXEZVYgqwzDwMvmuyGTVcC+Cmqf3UMhuYtV
         46LMQy6A7Bh8dr8GAMgFwC8AGzfbUyKdnvIn7avv7sTT8gICrzjsWwh+kvJCrG9zMFNk
         HKlXZOPd456gNxEkLwQNVn3qwQ23YA+c3otCVuDtuSYaT3ZCFG4dL7Y+Hl+vISzrgLLd
         lFlSg8wWjsBbNNOzs1z1bCJW7f3XgEeQST3yzkx5QIn8tdLgq6KmrtAZNjNSKvDX4jx8
         TMdkUhEWBSNtXgSFm9aQDuTgXwWM1/kapdiFupNsZW2VuTxGcwS/ARoQvDbG9poOmMoH
         z/5g==
X-Forwarded-Encrypted: i=1; AFNElJ+SeviDCjFrsz7eBiODMZHjnlJ91cTxwO5r0pQ8tSjR1QNar5eosiFhVhoa1zCVrNXLCgwxREI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9jxktiwTLIk5UuH5N/RzaJ7ANmxIS6DEh3taikOLqKxpbh36P
	vdQl0oGleAi8BY4/RGI3NYbzYZ9+t1MuhN2sT+QOLRpTUU5zeF6vl+L5
X-Gm-Gg: AfdE7ckNJQi+NN0rEjlRC4V2kW1aDv37u3V7elPCQBruuiGLOLjjEevXrCWQA4hpF4S
	ygggrZYMqYUo+Qn/1sU0ZK/vvyMk/VgR9lkNLU9mxg1qBwYWTYCmbZEHrfNGNfLzk4xeNxm6+x6
	sLCQ+beCgRa7V4nMG+WZedN+J6X300LdKtixbowHyH5yH6ZcEiKK5nWL4dez80Hz+wFfPXDLwbm
	ggR02ttjFSWBi/jixDh2Sc+oOYYaUvIr7y8J837z+PjEcFa1XYX/QP5GJXHf/dS0ZN2wJTcGE2/
	8ceLKBOdefZ8SZlIaF3aaSBJMtgoyCzp3RJ4JUWMwx3cnb4UqLJjziGN7MoHK7vVajWCWITRe7f
	38mySRNSqm6XvfBaJxeePmoqcC2q7czjIigdd7trF4KkRBLoT7X3t5CuPQnhGNaiaEWIFv3RGx6
	0dzXfVNOmKE4zkYk8=
X-Received: by 2002:a05:6820:189a:b0:6a3:15c3:e60d with SMTP id 006d021491bc7-6a36da65eaamr5053920eaf.71.1783592839034;
        Thu, 09 Jul 2026 03:27:19 -0700 (PDT)
Received: from localhost ([74.80.182.70])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a37b58f98csm1338565eaf.13.2026.07.09.03.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 03:27:17 -0700 (PDT)
Date: Thu, 9 Jul 2026 13:27:11 +0300
From: Dan Carpenter <error27@gmail.com>
To: christian.taedcke@weidmueller.com
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	christian.taedcke-oss@weidmueller.com, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] dmaengine: nbpfaxi: Fix setting channel irqs in probe()
Message-ID: <ak93fxRvw9UvxJLJ@stanley.mountain>
References: <20260702-upstreaming-nbpfaxi-v1-v1-1-fd8ea8830cea@weidmueller.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702-upstreaming-nbpfaxi-v1-v1-1-fd8ea8830cea@weidmueller.com>

On Thu, Jul 02, 2026 at 03:43:29PM +0200, Christian Taedcke via B4 Relay wrote:
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
>  drivers/dma/nbpfaxi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
> index 05d7321629cc..74ff7bd979e2 100644
> --- a/drivers/dma/nbpfaxi.c
> +++ b/drivers/dma/nbpfaxi.c
> @@ -1374,7 +1374,7 @@ static int nbpf_probe(struct platform_device *pdev)
>  		if (irqs == num_channels + 1) {
>  			struct nbpf_channel *chan;
>  
> -			for (i = 0, chan = nbpf->chan; i < num_channels;
> +			for (i = 0, chan = nbpf->chan; i < irqs;
>  			     i++, chan++) {
>  				/* Skip the error IRQ */
>  				if (irqbuf[i] == eirq)
> 
> ---

Ah.  Thanks.  I feel like it would make sense to change the other
condition as well to:

-                       for (i = 0, chan = nbpf->chan; i < num_channels;
+                       for (i = 0, chan = nbpf->chan; i < irqs;
                             i++, chan++) {
                                /* Skip the error IRQ */
                                if (irqbuf[i] == eirq)
                                        i++;
-                               if (i >= ARRAY_SIZE(irqbuf))
+                               if (i >= num_channels)
                                        return -EINVAL;
                                chan->irq = irqbuf[i];

If we don't find the error IRQ then it would be possible to go out of
bounds of the chan->irq.  It's not likely to happen in real life but it
sort of makes the code make more sense?

regards,
dan carpenter
