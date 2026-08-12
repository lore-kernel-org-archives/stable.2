Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2013F41B8CE
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528375; cv=none; b=qCYY+G2L6LV3z1W0wyy41Qqmyh4M4KgWXtGZrokMj4TaQN25TxxKyLVuDytePFz1ZnhjZ1V2J7Sksgb5e8G/IdeUrqFG8xY0LD2+BypVYDkojmUk/w/G9a2eQNTcKdz0jrZZeO3ligVtQKCpCVKh/ogf9KNFoGpPoDtPt/p8bmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528375; c=relaxed/simple;
	bh=T1EhCmFEcSjEqBNeyrrPjG7fW+eojEjbUy7M7mg603k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+7mskDpNSOlHm/Fp/mlIQ3bVxBnSkKplFyrlx9dIMeB0xTP0ZUPC5h7gVRU4v+zmVc7+7/cl6xuz7j0stDOvxnos5br16AxXuN5rV9/rmjxQQ/V4lsi1gDrsHs+6frJxXx4qfrQDO1j8Lbi4SViPQo7TXmCciE9o/lkmzNj3ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o3XQtkEB; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o3XQtkEB"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f71156e1aso319245f8f.3
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 02:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786528372; x=1787133172; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3cTk/lAwXPpqDHGidQ3rLoRd93BhVrEFxxCVH5bApmU=;
        b=o3XQtkEBqPJZFDEJJ/YYKsXBqJNya+8dXPjWulha9R13+CvqFA+JrZ2J9dg2NALp9f
         fZxoXAQtjvL0AwTW8MBTkMUEjrY736oJWDLatBHrkBpmSRtj4vyslOWPHWj5tcvUYb4q
         FeqHol2QAv1jpmdwBas0Buxs/xhJbSsp2kjXGLT8KjFS4Oqb4gNDZxvAojQtL/+ccUz0
         RiurhwO7AxwcW0ovGVXDp/XEG8s+4gNSO1S8XwF0zDaTPUheuuSOhY2V3LfPf7Ii/h0o
         CFRh3Wy5v7dogCBTiQZoUFm2PubnCpd+Abeg61l/gelup1whzehZ/VvgYPxAOkNZ7aK+
         OVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786528372; x=1787133172;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3cTk/lAwXPpqDHGidQ3rLoRd93BhVrEFxxCVH5bApmU=;
        b=K9yTWffzndXPA9BUFXw/12JI15rd8n/17ltArzWSMkcAvuuWGCcdKFdL/qKoN264v3
         AJJaky4eZjm0eIf5i4DOvCLp/7V0/j7uNTB9NRm4PjLQ83TAqaKKM1xmhyCL0fEKv0y7
         67gDmDfaFjvCPFizYIu0KOOq6fqLVIgjt8E/MCGPAf7rL69oe6ZoJiAGOJaQ0UEaHvSE
         KrBMqN6FB0Unwp58IYOiRn4YCNQRTFrWNs+60pSOb1yEGpxA+PRphB3G8ndllLdh5n8z
         CZD6CY0u1J5F4fxlmKOImksnPhzvaOne4Op1ik8/7ccVzmhUol7rRcnLUh7yktsXSRYc
         uOCg==
X-Forwarded-Encrypted: i=1; AHgh+RqmVpsf+RMk4mR6KLtXUriDhcK6TVRndOTuAs3nlDkDMNJ5J1PIBNVfzIl5CouyXzM378dJW1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrwFP+lCGGN1AFfcF+oCRbJb4PqHVYGmQF/u4GnIyH+VY06gqx
	B4FY55B+cPoo8NFLeYdqAvv7E//wxCCHsi+/tUEi/KWATy2T5A2Rg0YfqAi4TASDf1Q=
X-Gm-Gg: AR+sD117ATa4YquyIKa1Utr6uXfC1C2/rse9P8iZTC+IH6oESfb0SuC4jpKaY4VEOU3
	Zs/jdwVtg/C17gXl7Y204VB+CgaA2q1/jf8NCYRsfDaqglc39Rm4sqXUsitSNOYDVBe1/xScLFi
	EShgkM9VgJCujXo1jPqLgcUMZQ3L+/E8BbpNyQbQmmxUXMWZL6MPrP0aGqqRRgAsW7eYAJGPTTi
	0LelWr0zOHGBB3aA1/15INs9LWDPXkYmHUDTFx1X03yvf35+L+hDYihP/o0j8E1rrzQG0fFqDRs
	B/SJgBAlOFXc6XLB2TsQJh7HJC1iEFHk55SYdlGibHcOPT00REq7EkDhwIjPOhnGMQOkaBGI3+2
	7bCvZeFlpTcC/aJw4U8Yuipz9iac8VJPQ4P203/wAPWIzgHYi9zpr4Z2hWRw4XxHEaUl4eAwD4b
	ocVThzhNaDRBSIqLJzg8L133t20/qaSC0kNa2cDWzXAUrShua945PqeFB3tBfvq4fYFm8pjg==
X-Received: by 2002:a05:6000:470b:b0:481:5657:5299 with SMTP id ffacd0b85a97d-481565752a7mr1318883f8f.0.1786528372417;
        Wed, 12 Aug 2026 02:52:52 -0700 (PDT)
Received: from [192.168.0.252] ([79.115.63.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150b78648sm6399552f8f.0.2026.08.12.02.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 02:52:52 -0700 (PDT)
Message-ID: <e0d2710a-2a67-40e0-aacb-5d18742cea76@linaro.org>
Date: Wed, 12 Aug 2026 12:52:48 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: Unprepare legacy controllers upon RWW wait
 interruption
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260811-perso-rww-fixes-v1-1-5866a70e5d1c@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20260811-perso-rww-fixes-v1-1-5866a70e5d1c@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/11/26 6:56 PM, Miquel Raynal wrote:
> All the parallel locking helpers (spi_nor_prep_and_lock(),
> spi_nor_prep_and_lock_pe() and spi_nor_prep_and_lock_rd()) call
> spi_nor_prep() then wait with a killable sleep. If the sleep gets
> killed, we leave the controller in its prepared state.
> 
> Call ->unprepare() in these cases.


We don't even care about SPI NOR controllers. I stopped adding/accepting
new support for them few years ago, so that we encourage people to update
the drivers to use SPI MEM.

The alternative is to drop prep unprep entirely.

Anyway, all good, regardless the path chosen:

Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> 
> Fixes: 74df43b3f626 ("mtd: spi-nor: Enhance locking to support reads while writes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/spi-nor/core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 8bc117b46e02..250e996284f9 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -1346,6 +1346,9 @@ int spi_nor_prep_and_lock(struct spi_nor *nor)
>  		ret = wait_event_killable(nor->rww.wait,
>  					  spi_nor_rww_start_exclusive(nor));
>  
> +	if (ret)
> +		spi_nor_unprep(nor);
> +
>  	return ret;
>  }
>  
> @@ -1417,6 +1420,9 @@ static int spi_nor_prep_and_lock_pe(struct spi_nor *nor, loff_t start, size_t le
>  		ret = wait_event_killable(nor->rww.wait,
>  					  spi_nor_rww_start_pe(nor, start, len));
>  
> +	if (ret)
> +		spi_nor_unprep(nor);
> +
>  	return ret;
>  }
>  
> @@ -1490,6 +1496,9 @@ static int spi_nor_prep_and_lock_rd(struct spi_nor *nor, loff_t start, size_t le
>  		ret = wait_event_killable(nor->rww.wait,
>  					  spi_nor_rww_start_rd(nor, start, len));
>  
> +	if (ret)
> +		spi_nor_unprep(nor);
> +
>  	return ret;
>  }
>  
> 
> ---
> base-commit: db5f6418501f9795a96026b764d747179a231b2b
> change-id: 20260811-perso-rww-fixes-016cdd229647
> 
> Best regards,

