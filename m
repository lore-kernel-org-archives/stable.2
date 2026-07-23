Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD4937CD32
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827016; cv=none; b=Jge9Lnu+47dN8cUmZYH0yOAOTnG5xLyP9NOsv2tlbQvlwVLn3tPUDBW2TSWFgQGIVheV8mJBg4If6fug678njLyoIGVXmE2r9Qh7rSxSsipHK68RcKubXH+a6gigZALTcFlBxnRH2lEPMC3LxXQovs7DB564Ook9MXsDwWIfuSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827016; c=relaxed/simple;
	bh=87U2BF7ROJcMGMAeiwhiFsxW9By6AUV2MKfXm6mNaOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UZtjWg85TIFcnTsp8FLflU/WFkN65xudrnMCRgdYV1JrhOKKfXW3M1thzXpiEX+d6ydPddkWOV/nDDmaC8BF9tKGvKkuparjvMvyuzE0borAx8Tw8cscU95Tymp17aW+4jJ3zfj+Jtn7yaPtFRJKNUTdFMlSe8qbXEjIbQx2fZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=daXLjxxw; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="daXLjxxw"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f7872abb6so491111f8f.3
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 10:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1784827013; x=1785431813; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OC6Xay4C+LNUcYvkyvApDsvmE+T9wiOzrVP6RhbK/vU=;
        b=daXLjxxwwFhAeRGwjgfBLmkYZom89ClhHTjPum88oyNhbTPYfp5z+ezIh1Nz38vOLF
         O6PY4jea8ab2pbfGVA/3eKLMeKLv8oq9ITtGPFaP/IIIB6wiUwDX0BSGiOKfBHSz2FxG
         zXYX2Yj0j+0Ow5GRBq8lkiAYlaxkkChgBKWO9yGSCzNvffEJAh4R6kjGrHuC7wOjzRO2
         qp4mOAD+X/ZIp+KXlzwAaniNHTLO/S8xxsqicQggXED8Y+nShN4NxTqz35tnSxEkYxuf
         yr75zSNudxibqn11cW52HaXZ6lUoqJbcGVvcuLPosU76B972lir1criVgdfz0KfpGAuy
         VgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784827013; x=1785431813;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OC6Xay4C+LNUcYvkyvApDsvmE+T9wiOzrVP6RhbK/vU=;
        b=P/P7YO8Rtda9J0w33pBo41ck3Cqxx9NwW7sAV3Q/yGRvmGXjB5Ez/vnmAsUN8zSL0c
         M2rohExQacjYaOdLP3KnFAb7nWlAkeXAuv/AfTyMcRSlMuZnlQU80J335s2H6rHRtXhz
         /lJlepv16Ni2YvSsnbK5Sv1YA08f8YNuJK7BeZv9qOb8OyUDoJ3k1+qWHoSxaD9OPtB4
         OWHqGowotmN/1dptM6MWa1g1XH1WezvfBX0w8agnRNmfPjGnDlxAqUElNAk9MKM9hYNI
         dBwobN82eU2T5ywmEDI1ZaDfsV86ON2doVHjV3+O/0S3X5dJmW5icJQmdiXR+Bd8ip27
         v7dw==
X-Forwarded-Encrypted: i=1; AHgh+RojdwWo/QQHJyWjMzvVczNYE99Ait4b2n1BHq0uNlTGAj5dEKy+WBVfF4PiwMkfU6Q/ehspv44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytcx5gquY3G3dlqFVODTwBRZW0O2q9dXa7gqABF5A2Bd85wn5c
	SACDyztJK/h/BGOEfkdQM5oiz06A0GTVynoeMfQLD87vh+UEZI1LO+ConFkfAtXWx4o=
X-Gm-Gg: AR+sD10FCMReAXKs5eX0CIRlj3YPx21a7hEnTiMeUPoL8tlgT3SBogDYLyo2E0iqWYX
	68U9W7R42Sy7cgd55B9Zjh8Np0FLzgXG5YvfxfDVjqhSqaM4FJE+TjxaDsbUBgQ3aLD78kPwVva
	T8eiwhNJw03wqzw93O+V/tCEvF0QuOcsp47OtwpYntx4Zzqr49uXNVccZlBHvuoix7h4qyNOwPP
	359Vq8/nIIfcFxMrv/m2+kw57YVTVZsBFRZU60KaiApdQ47w3x4+Trc8SF2vmg69j/tNdl2Fs0a
	c4j92CULsLL4+9hzWERty5id+yV+U8xQdTwdrvGI3yxhyYSF3lVM4/RaC+AInjBIXeGQQDzrTQb
	DFLgBiPvDiMIZTZgcslqeY68KoBUXPB6PeHhBnPmynoWO1KW/sfq+5FGEEihuwavD3ObJFSpfh1
	5q/F8qMaxXvzhuKiTAg+UItqiFJLOrhs3/gDEiZgm6F/KYgcKny33oOMsLRRwAT1SzWaPb
X-Received: by 2002:a05:6000:2287:b0:47f:837a:aa1b with SMTP id ffacd0b85a97d-47f8dc8cf8bmr5028600f8f.36.1784827013320;
        Thu, 23 Jul 2026 10:16:53 -0700 (PDT)
Received: from ?IPV6:2a02:2f04:6302:7700:4510:8c44:3b9e:61ae? ([2a02:2f04:6302:7700:4510:8c44:3b9e:61ae])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb5127sm16373400f8f.10.2026.07.23.10.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 10:16:52 -0700 (PDT)
Message-ID: <14727860-74c2-499e-b59c-f1bff48bb855@tuxon.dev>
Date: Thu, 23 Jul 2026 20:16:50 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] PCI: rzg3s: Disable refclk on probe failure
To: Prabhakar <prabhakar.csengg@gmail.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Prabhakar
 <prabhakar.csengg+renesas@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 stable@vger.kernel.org
References: <20260715223019.3002237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260715223019.3002237-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260715223019.3002237-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/16/26 01:30, Prabhakar wrote:
> From: Lad Prabhakar<prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> rzg3s_pcie_host_init_port() enables the PCIe reference clock using
> clk_prepare_enable(), but if rzg3s_pcie_probe() subsequently fails, for
> example because pci_host_probe() returns an error, the probe error path
> only releases the clock handle with clk_put().
> 
> Balance clk_prepare_enable() by calling clk_disable_unprepare() in the
> probe cleanup path before releasing the clock, ensuring the reference
> clock is properly disabled on probe failure.
> 
> Fixes: 7ef502fb35b28 ("PCI: Add Renesas RZ/G3S host controller driver")
> Cc:stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar<prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
