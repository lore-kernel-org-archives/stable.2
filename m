Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793820588;
	b=Umn+aJhoBHiM1BnOGoE9RRt3f1/3wZVAlTQG2rs8rzCEeXrPGH1A49kzs3PGGFVxDvaE
	 VywwCH7LoeReQVuUCnk+6sNgmVPJA907bryFn5/JhEmSZC0eMrpokF49njw1eqwENDmbE
	 8+xFr0cc92S+Q/Kj8gM0167Tse+79jnofE0EvxS2PtRJY8yZgO2OZl0KODQK0sBir0o8x
	 TirzHrobxhuTg2WAk2hOI5tsk6rV4fbj1OzW5by+UIYa4TQk+YEkmF2kHprjTjQoSON7f
	 AbilVNozsXVrrR3cTtW07zpyMchMREnPw8wuBo7nshGPcMR8YcGwj7zXcAgC6+Ax1Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793820588;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Last-TLS-Session-Version;
	bh=yWX9HzorOqGIhuw+UhmBUEbF43oZfzZ1Cb6+mPXskkk=;
	b=hJaH/DuB8+3B4uGU0mZD7LBZiHA+oLE+qQcLYB6HVrP6aCabyduvsRRc1uoJ8OXrBsmw
	 PE48EQQ1vKxsyUImPUfxnYfykJiuPGDn9jVcP1K+0IloGB8zQqoyBrxKlyYHZoAv6fL9c
	 CvPAZB+4oHXreAtq/WhQFZSEeXPzPdTTk5FOYjnXXex/6IERrXQsiVFNDK6xRhuC/6WZZ
	 Fpp/iIu6b4LzzMeMKYLgUDiB0gWIDw5Q3h6RpVZNYhUJLWcIEETV20RrOSI6sDHJE/rlc
	 KTIp88AcgzYRqJkpGSBGwN9HK6xcB2HAulw04dNsk+Q8xorpULpVN+ow2KAPw4c20nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=BSj8IZT7;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D506076362;
	Wed,  4 Nov 2026 19:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63D506076362
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=BSj8IZT7
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 6E64DC8F46B;
	Wed,  4 Nov 2026 19:30:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3180160770;
	Wed,  4 Nov 2026 19:29:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F1B4410329206;
	Wed,  4 Nov 2026 20:29:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793820582; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=yWX9HzorOqGIhuw+UhmBUEbF43oZfzZ1Cb6+mPXskkk=;
	b=BSj8IZT7vEM8sPwRrBbpYMSNZS4utcQHBp7d60z3/cZn1wUBZnl2jwSztI087/32KR6k+R
	84GtoqcAny7uqt+Hzfi7lMiU+JieyMXUFHcDqS9JUm1ESOLCZl6YqoVlngEFoPZiC0+Z6q
	LskGLvs7rRGF3z04Gw7Bud5lUEdBYeEQ5sAKKTLPNY21osBMUJtfzi5vU5AgXOnlCnEqcF
	KJaO0pr/lzp6lh66c160vcYixvk+TC1ikWwkwXeMKVKbmAVovJzyW+tqXS88s/uT6VkH09
	B+orPWf9BVprThZH/+OjxxslO2GyC7dH55CL5pSRSRcwFy0msbA535tHIvyn2w==
Date: Wed, 4 Nov 2026 20:29:35 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Srinivas Kandagatla <srini@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Mark Brown <broonie@kernel.org>, Andy Gross <andy.gross@linaro.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	stable@vger.kernel.org, Wentao Liang <vulab@iscas.ac.cn>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2] memory: atmel-ebi: Disable SMC clock on probe failure
Message-ID: <20261104192935108e0e12@mail.local>
References: <20261101190733.121473-3-krzysztof.kozlowski@oss.qualcomm.com>
 <20261104185308b845fb6d@mail.local>
 <c4eb1d41-8b61-4aca-abad-22cb61a4415e@kernel.org>
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
In-Reply-To: <c4eb1d41-8b61-4aca-abad-22cb61a4415e@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On 04/11/2026 19:59:45+0100, Krzysztof Kozlowski wrote:
> On 04/11/2026 19:53, Alexandre Belloni wrote:
> > Hi,
> > 
> > On 01/11/2026 20:07:34+0100, Krzysztof Kozlowski wrote:
> >> Unprepare and drop the SMC clock reference, if probe fails to avoid
> >> resource leakage e.g. during probe deferral.
> >>
> >> There is no remove() callback, presumably on purpose so only error paths
> >> are handled.
> >>
> >> Cc: <stable@vger.kernel.org>
> >> Fixes: 87108dc78eb8 ("memory: atmel-ebi: Enable the SMC clock if specified")
> >> Reported-by: Wentao Liang <vulab@iscas.ac.cn>
> >> Closes: https://lore.kernel.org/all/20260917101623.2146392-1-vulab@iscas.ac.cn/
> >> Reported-by: Sashiko <sashiko-bot@kernel.org>
> >> Closes: https://sashiko.dev/#/bug/linux-8e236c81-01b2-4274-a213-11c3f31acfc2
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> >>
> >> ---
> >>
> >> I independently developed the patch and then checked the queue with
> >> pending work of iscas. That one has issues and other complains from me,
> >> so only credits for the report.
> >>
> >> Changes in v2:
> >> 1. Handle of_platform_populate() error.
> >> ---
> >>  drivers/memory/atmel-ebi.c | 27 ++++++++++++++++++++-------
> >>  1 file changed, 20 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
> >> index 1e8e8aba2542..7dc2f7add1b1 100644
> >> --- a/drivers/memory/atmel-ebi.c
> >> +++ b/drivers/memory/atmel-ebi.c
> >> @@ -562,7 +562,7 @@ static int atmel_ebi_probe(struct platform_device *pdev)
> >>  	}
> >>  	ret = clk_prepare_enable(ebi->smc.clk);
> >>  	if (ret)
> >> -		return ret;
> >> +		goto err_put_clk;
> >>  
> > 
> > Couldn't we simply devm_clk_get_enabled() ?
> It is not this device's clock. Is there devm_clk_get_enabled() variant
> which takes from other node?

Right! Not that I know of.

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>


> 
> Best regards,
> Krzysztof

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
