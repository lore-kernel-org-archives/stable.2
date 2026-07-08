Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3344437B021
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783521150; cv=none; b=U4UZ+SA4na9GEZzROBfdBnn8WSdWJEvYoRyXU/PswQCCkDxU/qRXUKS6XoSzluAKJKakBnb3KKXksTBNVuEYyP1OpT4R/G6ZCQ8ZwqM5mxATwWQyj83nNRGJjn9WqrIfxJxkPI6ysiFHrKlOVvDevudAQ+WJU03/1WLER9jp+x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783521150; c=relaxed/simple;
	bh=pQrUttJSAzZqd4+9dPhp4xkow1n/EuQGnd/1zwIBjYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKR/utMqtjGuoLjwsqNdsI55WxRo4P5rgYwth7vYeZzLLZBRTGoOp+tIo22UZKg1Q1BmDku9eZJgZ4HOLz7wtKCqoTWqZxk3G+IvF1GQEYBA4wqR06bnvhiECAOOHPkCqQ8BPOfyet4RIbSLvuB9/W5AXPWR4KOs4YW2JzvNdhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=CUc7ZbFC; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="CUc7ZbFC"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7eb1dc6bd53so456701a34.2
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 07:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783521146; x=1784125946; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L59QY/LIozXECDQitmWoZ1ce6y53FVzUgHLAEXFNOTA=;
        b=CUc7ZbFCE9XtyQYOPVu+rLbs1QWKw5kpy72zxRHNdte9zIHUkW3q3uvwx8NSgpIbre
         ry+lOx70ibV26ojhAYvXYuLTvW8FizuQQQBVmRrUtKMS68CSHzTjqM/6exoctjcbiksA
         jRfnpfR3xM0X353Ii+MY4i2+fHCBI502TRN+Pxr2YBL150AXGY3Cmskcs2w61l8UtZ1d
         qrc7W4frnopwt6W+xjrXbREgoO/5aKQTMM347hA/McpWc+U+Bb38cuC8H8GMEd/9mxHU
         H+wFbqCo/2KaIk4loL1TPKakjiHcZtrQQf4C+TLr2a+tbHLsDrQ5CFR1+Ilkzh7aeenA
         p18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783521146; x=1784125946;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L59QY/LIozXECDQitmWoZ1ce6y53FVzUgHLAEXFNOTA=;
        b=YCt5laP5pwtHPITUUHJ/3mJzJGOXq8VE9IRSnf8K2TmmyaRoXCzvujaHXaRUMJt85/
         uh4xHTkK0kSOTO88sj3SkwruJwinlP9mK4/Rlyu2VpTBj9HbQ1EXD3Z1HnYv1Q/QHdYB
         kBQwlkB0Y/GvNBpnO7b5ofVxNJY2fdc3LUrdFG8PveGepK+YeFNA0N6mIu8VLT7WL5y6
         sD4L4qP+XivVVTbJ91qEUJHBFyRLdiG3YBMi85qIkfRr5ya8mQWEXFIbrWnDKvlI/hqp
         qmtJ7rdWtFxMYytx9BDGnj6Hss6hbJru9xm4PXlDVgLQJDcqAmpo5YpRtrxSZPrN5W5f
         AvPw==
X-Forwarded-Encrypted: i=1; AFNElJ+9cl/WMp+d8l/uOuNo1rs5d+wAwzZ0EVaEZIyxuhaZWDCUMRHm/J5+tskrmEXj877EpD+4lIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrqRIihV9kzIU4jG8YALyozI3YomYc2RyM0AO/FoKSofCnyMFp
	Qq1tY5ICSZHdVPfeGLlSdME5mJc7hb42ayhiyJtz91i/zM5xI4+N13tuK2dY+6zADTU=
X-Gm-Gg: AfdE7ckZH++507ZKw776xDmlk7POL6Rq+kC3sgxQz/uYT7lIoj79VMG2IZAHTYRzm2S
	a7L9JX7UxaPiSYWuax/cSGleXU0I4tAvK2Oq5s2HyvEwvt4nngXRkNxeQHCSgUmIqnWGCxbfNeU
	fqfnVLs+6X73XHsl6wqR1bupT69bKgXPniDe9JtGQSDgJ884RMwKJFYqZE4W1dUPCf7UlsKcl1L
	MhV/d3Ud0HBrx6lVvRk09PFioij01xS53Iigt2DXBzxca04wL0qtxdstnH6naffbN3SSCvXDcQ9
	Zn9gbVbEc/JcGGfUFBGoEeEGfEPAHPMpvozSKFhB7oi2+WrXIaf2SNSebQnXzv4upQdWbrMv8pu
	QpwGoT9bQakU9/kEmWTNfPPK1UdhyubiCVW3mHvZVfE80x3ohNsU3bq43u6wR/BEMpw8G/6+hWF
	2IKk0814emrQFwfU4yrW03q3waO+pRGln1hrY+rszd81qenv32ks20XgHfkcCyAgY=
X-Received: by 2002:a05:6830:6f45:b0:7dc:e090:68a with SMTP id 46e09a7af769-7ebcfed3e61mr1718859a34.0.1783521146173;
        Wed, 08 Jul 2026 07:32:26 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:19a8:8ead:9ca9:cb30? ([2600:8803:e7e4:500:19a8:8ead:9ca9:cb30])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb2b79c9sm1900838a34.22.2026.07.08.07.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 07:32:25 -0700 (PDT)
Message-ID: <6d8c6b4b-89b3-431b-a31a-11de654c2901@baylibre.com>
Date: Wed, 8 Jul 2026 09:32:24 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] iio: adc: ad7380: add missing 'select REGMAP' to
 Kconfig
To: Joshua Crofts <joshua.crofts1@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Stefan Popa <stefan.popa@analog.com>, Julien Stephan
 <jstephan@baylibre.com>, Ivan Mikhaylov <fr0st61te@gmail.com>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
 Kim Seer Paller <kimseer.paller@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260708-add-missing-regmap-v1-0-6d424322e3d4@gmail.com>
 <20260708-add-missing-regmap-v1-1-6d424322e3d4@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260708-add-missing-regmap-v1-1-6d424322e3d4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/8/26 12:34 AM, Joshua Crofts wrote:
> The Kconfig entry for the AD7380 is missing a 'select REGMAP'
> parameter, causing build failures.

This one has already been fixed.

https://lore.kernel.org/linux-iio/20260603134955.2f1d5ede@jic23-huawei/

Suggest to use linux-next for development so you get both the fixes-togreg
branch and the regular togreg branch.

> 
> Fixes: b095217c104b ("iio: adc: ad7380: new driver for AD7380 ADCs")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/iio/adc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index d1b198cb8a80..6d1170bc4c7c 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -330,6 +330,7 @@ config AD7380
>  	tristate "Analog Devices AD7380 ADC driver"
>  	depends on SPI_MASTER
>  	select SPI_OFFLOAD
> +	select REGMAP
>  	select IIO_BUFFER
>  	select IIO_BUFFER_DMAENGINE
>  	select IIO_TRIGGER
> 

