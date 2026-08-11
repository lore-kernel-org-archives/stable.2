Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4D942CAE9
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 10:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786442762; cv=none; b=Nvp93D7tx727XzqprxWjLMQAA4zsRazsO7t6+dnjDs6Z3J7MK1jWcMKxbEJfvn9gXm/HWtQ2O0D3rM8+5hoMOgSu/VyezEqG29YXPIPKX+oTgV7FHEa4VaM228fvCk8fZpJmmaPbHw9s7spEqjhWwyYLpv+T79qWIibN6c8yaao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786442762; c=relaxed/simple;
	bh=5EFFhRqqKGCmLtFkk6nwPE5SfONW2zlZ18VqIKQ7ONs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KG3QVLxpfsmOTjANOD3vXm8eV0hTfBoXWFyDgDZarrfpRD0rNGFmJXnXrCS47T9yUYYYkShuljUO6SIylDFUduXCBA/cujNfWnwo6hh35+UymD657EtjmFDNaXobBXLrb4mYHT45mZ8PxEcZRs2tXX7BBFPzIslrzuvtsr28S5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=crMTFFiX; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="crMTFFiX"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4994c49f588so7846855e9.0
        for <stable@vger.kernel.org>; Tue, 11 Aug 2026 03:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786442757; x=1787047557; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5EFFhRqqKGCmLtFkk6nwPE5SfONW2zlZ18VqIKQ7ONs=;
        b=crMTFFiXgiOWKJs8qE9Py7moZFq44ghzN0II39p5glz02Bs59wt6sVL7O1aRKJH6VQ
         d2KycMCLfC8z90PI9380XajVIKhcwVv/QYhOL7JqqMgZVyPHKFqc5CI+XyX5cFhLjcv2
         FQNLZJHaEalu4SPoyfKWeZe4/IM4ZQiFlSnhJgcFxHr1aRtXadErmdNYPmxvGxBRlohn
         C3ryus33SEEG5ss+Ba/QJPEpUMviezI+joPHag1iDlH0jxSjh2Fea1IOQSq5i3oMmA8g
         f4UEJ3ZNyEq63XRMFLrZaXU+EOkMyTQhc9Gd1d8Oj3uNisI1Jg60XiL/H9bYq4QRWWQy
         tTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786442757; x=1787047557;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5EFFhRqqKGCmLtFkk6nwPE5SfONW2zlZ18VqIKQ7ONs=;
        b=ecFJW3EcZYg0xr1lK3PRZBQ8tHf4TN20FM+qhYqj1lWxjxp7HQenJDCCJIZNa4kWFh
         o+RiPqD1843Msz/xbZwv4FmbR8DJNM7Oaj6h3IxrgRSVEFP7+Mnezflx/LkFEU+WgGlF
         TvVL8zpYvRZgUYQmBly2DCHeP0a29/Lj4GBqUjilfAgssS+jGwDwbFSg/8ipjNlSJvdF
         4JPZUOQTV3PQkTuw4MkTkwPiOlUwqokgWkoBkVXVPMe596dvm9r6Y2cs0N55Mp4tmVqJ
         i5X6i0tJ7X8HugsS0AFMkf8DEeZd+6KrclYbryqK0paRoKmgDKe3qWL4YgXUTExOskcS
         pf0w==
X-Forwarded-Encrypted: i=1; AHgh+RrU5OOzMx9oX4kjrnaM5gxJ5oVd3Ip/iGyhBe/LpMt/Tlr2wk/0XNQNMevcQSxj02gY7kdIPaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfE1HlZ+gHXG2MQpsWnqv/wJrtJfRW4GsefhPUVwMjfP9A4Ix4
	XgKguPw3s+n1IiwpvvtbGxrfZYKHlUrJYHdJFrsU7nHhXeuNz15t26/rfSdFvrzA5Cs=
X-Gm-Gg: AR+sD10aqsfP1IHtFo1B5cHGtDRqf8hY4Fdl7X7aoxSZ9fzkQJ3IN76JbkLxmw2MbNq
	jQhkhACL7IzCHggRtyJr1sIlcvlxhaH5KvjvQAPqQReIWllv2wk98HAQdY3UaLeXEwpYvBRjKRK
	k4DdyqFlsv9F03TSp9BRj/zV2wShetqT6bnMpuBtAP1h1nuD00JbYW6nctNzdpwv/U4B2A776rW
	AOpvub48lWoRoBMIyaKuZ5TGh4okyWe8qOP7lD3qDM0dVnM0b6Ch1B7gjch0prkduEB0V9Ss6gQ
	FKqcgiofFLrBCvg2185743D+76X5ZkcJJTLYjwf/CVx5zXmirWWznJ7Uw6uGOSyz2MykTmX1oD1
	n2NMvK3c3gmesSE4POJfJdNSndH4q0V4D/ninRuUD5LTK/5Jgw+XMYiMzRsP5NlC2YgYup+2LWv
	0N8/oD/fHLDPro32EZe2p4AkPvamYOrZURQ0680Q1iM4gemloBW3Qy+DVIU1IM3MqX8qcXNZ8=
X-Received: by 2002:a05:600c:34c5:b0:495:5d6d:9cc1 with SMTP id 5b1f17b1804b1-49978e3f150mr26185875e9.0.1786442756530;
        Tue, 11 Aug 2026 03:05:56 -0700 (PDT)
Received: from [192.168.0.252] ([79.115.156.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49977df9489sm59242995e9.1.2026.08.11.03.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 03:05:56 -0700 (PDT)
Message-ID: <6e208a8b-da11-4ba1-adfc-f1e80c891310@linaro.org>
Date: Tue, 11 Aug 2026 13:05:52 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: scope the exclusive RWW lock
To: Michael Walle <mwalle@kernel.org>, Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: pratyush@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
 vigneshr@ti.com, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, stable@vger.kernel.org
References: <20260809084223.3596259-1-runyu.xiao@seu.edu.cn>
 <DKL4CBQNKCO2.3NAZ6S25Q60XN@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <DKL4CBQNKCO2.3NAZ6S25Q60XN@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/10/26 11:25 AM, Michael Walle wrote:
> Tudor, do
> you know why you've omitted the guard() in spi_nor_rww_start_exclusive()?

because using guard changes the behavior of the code.
