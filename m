Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481213B4EBB
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 09:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786439372; cv=none; b=CmI4PICqW9xrIcExIcuSJjQoAlHM18j+CO3QblF/AtXtZHS+5vtkYie/Bs6XrjhLzJYxVHsFcNMOIxZaAQ10aG6FT2TFdo+q6pxbR7szzWV9eO2C3kLucW3zBimBrqRPHTumxtJEHZO7q+exdzK0yHQDrTfZH8yzvg8bp53Dl+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786439372; c=relaxed/simple;
	bh=YqmG8H7CfD1hiY+k9bBSfE6HrHVEEC9plMQPob7mcrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WjeXibX2qic56Z2mKiDQpEnmSTvNxt/oDO4O0eKFAXGl9jAzQ1SXLkb714vttKM7F6zaknKpdIrEoBvWon4qLX1rbq6oD+DYZbCUipaoENrza8jbWI7QeGKZI995Xyy8ZGAEcacXdD2jGuI9Ft5xgby2Q70ywiE/1kFCQqn1lF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uD96FLga; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uD96FLga"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c2074710751so385501866b.1
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 02:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786439369; x=1787044169; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ssftIM8A+D87TFbIP+gopuh1ddb3SONJgnk2ZqVY5uQ=;
        b=uD96FLgaJIuLykaA6i6lo42lVKQgUAd66XS0OSt7hwZ9Ot8phqec++aQG28IAqzvlr
         xgf0O43zOJwf21jyvYheE32rF18Pk+DPNcewfmuOT+UHLmTjItGJKihPJAMm1c9deT2T
         ffSu9jpjhMLJvFlcoLdzA26GdptC3nmiWerw4MTiHV6A8/wD/AXuddbIV59CevSvF3PJ
         txKKq9TDftNTiYL7/PhSz+d4QgVatG96YZOLdyu8+W3QcjDJEO4ZCTf2SuNKuyqwHL0n
         jBm7LCgyVeCXrn2mSLmypTreRdt31HotCmVStnahKtBdj7X0P6yFBfdSPrD17IfWBJAc
         FOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786439369; x=1787044169;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ssftIM8A+D87TFbIP+gopuh1ddb3SONJgnk2ZqVY5uQ=;
        b=kWDZAyE31weFixGDAx5YsB2pW8dErc4JSWbA7kxrAKX/Jv6k04OOmMtiGMmwOJTAyY
         l6gUU3YTd6UmTP5SU/xVVnA6bdxKbK5Se117QxyqHo1ilq0yYhVgcMSOcASvG64XmPZ/
         BDMdHY4osv3HqUVn7qmR8iaLuKO5q2NNJ/HgytWpYiGj+o5Xf6gRy5FW7GvJzKJ3TGk3
         JxAwRwUEYZIrujcDesvfAs67imUHJSTP7eQaVF6o1dJQ6Oc99l/nXPqLBTgP9QOwbmj0
         9G7ebBkXcpuT0gqEzyu7eFoaCd8m08IupRtLoUtzEmtO6Ail0bp4uG0cNEeEdtOW/LEg
         5HHg==
X-Forwarded-Encrypted: i=1; AHgh+RpS683Rl12+Hc+D+R8VGUvR82fwwldUI2ZpNkK6b9vjBW6RdUJ69FZ5hNFeDDzUyj9qj/UckNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/xLqM0bImu5c/q03+57t9UFRrHAoHjAXCUDW9ZcMdybhqpFFK
	K9mEAvUUJ5cPDFtfO/16+lZhuoW14brrZYfP4MkSZ5lIE1UqrYxk+tZHIofQMWUbgGU=
X-Gm-Gg: AR+sD10gE6PuQYEZCHa7EQWl/rwEjCDhCbHp9DtYbh2ZjMcSFW4gXBNiCPSQzY9vZa/
	gDQI4c6yAs6AkOySPi6ug/HS+3+cnFhh11sSkrqLzAJYAfsFbeKz0mu8dfwBta48ZaiSER0Do1d
	71ECWT9y1df1jLW/Tmc8Xj0eggh3ifbQmTN3LIseroVs1FwZdbSDkJlnK/LPc+YS+d4Frc66lk6
	jJF4rHw+TdXlDW2duQi2j70xEoXi5AV+LB6ogC3E058T1xzshf+RE2YvOk7nfo9gtrHxJN1avt2
	q9rkxYCo94lHJ3TgDjnrUIo3TMRQ4vIzAc+ln96G090/e9neyGYJznp9wHrekl65vPj9AbfZszo
	vwV6YfFbb1AxKEcykXOG62A+f+/WbChePSOYh/bGPn4XSxyzYMnCyaIUC6RS2KNVJn6ehOgXFRR
	71su7WCzPD5zA/0/+LHxuf7sWLFI1tZyAHAeyOqkQeS2Jkv5jsTVm1SyiybSQg9Bfl2A==
X-Received: by 2002:a17:907:80a:b0:c12:7f25:cc59 with SMTP id a640c23a62f3a-c20e626b06emr89292166b.16.1786439369582;
        Tue, 11 Aug 2026 02:09:29 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c20e438d78bsm29708766b.58.2026.08.11.02.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 02:09:28 -0700 (PDT)
Message-ID: <f044b945-ea38-4f66-a00b-eac5d81c8d7d@linaro.org>
Date: Tue, 11 Aug 2026 10:09:27 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y] spi: spi-fsl-dspi: Avoid setup_accel logic for DMA
 transfers
To: Mehmet Fide <mehmet.fide@gmail.com>, stable@vger.kernel.org,
 Larisa Grigore <larisa.grigore@nxp.com>, Vladimir Oltean <olteanv@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260810141437.2805389-1-mehmet.fide@gmail.com>
 <20260811084018.3566861-1-mehmet.fide@gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260811084018.3566861-1-mehmet.fide@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/08/2026 09:40, Mehmet Fide wrote:
> Some measurements on the hardware, in case they help decide this one.
> 
> I ran the transfers that fail on 6.12 against 6.18.44, which carries
> cac7e5054115, on the same board (Colibri VF50, vf610, DSPI in DMA mode) with
> MOSI and MISO shorted at the connector, using spidev_test:
> 
>    3, 5, 7, 9, 11 and 13 byte transfers: every byte comes back, in order.
>    Even lengths and a single byte: fine as well.
>    SPI_LSB_FIRST at 2, 3, 5, 8 and 13 bytes: bytes come back unchanged.
> 
> Without the commit, the same odd length transfers lose the tail of the buffer,
> because the accel path packs into 16 bit frames and computes the word count as
> len / 2, and SPI_LSB_FIRST comes back byte swapped, because the accel helpers
> byte swap through cpu_to_be16() on top of the hardware LSBFE bit. That is what
> we have been carrying a local equivalent for.
> 
> So the commit is what makes those transfers correct on this hardware, not just
> a saving of pointless repacking.
> 
> Thanks,
> Mehmet

It's possible that this was originally done as a fix but I interpreted 
it as a refactor. As part of upstreaming this I broke down and added 
commit messages to changes from NXPs board support branch. It does make 
sense that this change was added after seeing the bug, rather than just 
a clean up. But it could also be a coincidence.

James

