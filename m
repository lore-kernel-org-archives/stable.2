Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41591389DEC;
	Tue, 29 Sep 2026 07:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790666203; cv=pass; b=k5HdPnIKnGawwbL+dE5QRqp7jIex++KKCmKUg41+ibCGouSth+MhzsB8T082koYroPNz2KKoWbnWMtcmnfApXzTayDjKLynKrbaCI7AiRQ9lrUqxeSGgOhvWUdXYGw5XovrR0nj9E2Sz7S+f2HyfytHvuccO0Ps8yBv8zw3Yr1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790666203; c=relaxed/simple;
	bh=696ijxOXQfhBgBvDoMokAePa1R6tyLjNu1OEPOnd1xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sYjqFITmnosss5p6bxu4hETJtokOGCxjXHm1wpmVGIqS0eWaSUcT0Al5bMDrsyX/PhSxshphDib9VnZv6H7+DxqOnKO1CizvmzWJP4ehLBwnb9XmeC+JKkFujHDoyw1EWQbGzsBXAJeE1mKrWDr1zGtzLYZ9cE7i/u82s5KwUX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=ZHw0xdkY; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="ZHw0xdkY"
Received: from [0.0.0.0] (ptz.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::77])
	(Authenticated sender: spu@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E1FB5201548;
	Tue, 29 Sep 2026 09:16:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790666191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g8yFIMfXcamOSTdytiUcdogK/QABhn5sWuK0oBzBWh8=;
	b=ZHw0xdkYy/CgZdHMayUgrCk0soMlwyhaMORQtte2UHNbGN0o201RQsAvUvvJO0B/tASX+K
	/e0QmBTAs0E8LKSyAfA4hd2UAsZXpkivVzKhxGuDX4TfgNMICqDkuMmn48zqRWQX3qvPF6
	DfeWkjOBdLoVRw0n213tpVu59oBTgSu9LjsbEOUJxM9A+RyJ3odHCwW9Gcewpwi3es0t3O
	tlfG1smpcr8FKjykCeJJ52sDjjmZdksnikADGoc1+fSMbkdYRyrhl+OErnc/xq3XdEMsv9
	EuR0AYN9PxHH5HcwEeYN9/lPQXY4kV6tWJ5AiUqFE+JQXlWhzHB9qmvqDc6Ong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790666191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g8yFIMfXcamOSTdytiUcdogK/QABhn5sWuK0oBzBWh8=;
	b=M+JKN1oGvusBH3GBbsSTZwkM4KbQFzknN49NdMhTKlqHKiBQJY4k1juzDjamtQAQ8oPB42
	5aA3ZEb0Ez2mG5RFTyZ0Ban7gPtS1dziE/z1uAc8TrABDztC45SrHuOrk5YQdx0N+1ulIB
	aneZeVJR0b2X2p8GxboV2RsfyDY54tyrxLg5IZLD4VJcttFfbTNBVyHSejK05VXBxle0yV
	kC+bU5sSk0PUkd1z+uVJNKKYqf2NRx9dvHoqNBD2Wo2WGfFQLoWyRHB9HYqPEb9ZvSLq91
	KqdkhQXcWNrik2OuYExfRRGTSyEEY9qCD8rp3VoIJS+NVKJ8JZy7QuZwQGkWSQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790666191; a=rsa-sha256;
	cv=none;
	b=Ii8cJJuTLEYqiYxjCnvVvpCmlwjg6YT9uF6cvpIcfUkAdlNqZJR+/9KjwdoBQfHNHDdTNI
	r2tpE0lmVSyfwqqWL/5BTsriQOQoQ1DzcdcWbvE6cPVSeraHe9aHfx0ZTpEXUjF2dgs+1C
	1WfW308uJJtKuPmNtHwWlkisDqE9GgAYL2XzaKda1BL5QBRk+wQR1Ld1rYLhku1NzY83bH
	zeLUvWs8BWlZ11bkzJy4O77PE5UbzMj1vTM71AzOJ5cqjIi5tQqKjaROg/B84Wv5OWu5PK
	6tO8nZdpMj/J6UK6/C9ZK+LR1SrUrHEmZKnj/A3uvNtxQlDLkheGUayXk4BftA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=spu@pengutronix.de smtp.mailfrom=s.pueschel@pengutronix.de
Message-ID: <b3b26ca0-c362-47ff-837f-989fb8f9cc12@pengutronix.de>
Date: Tue, 29 Sep 2026 09:16:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: rockchip: rga: quiesce IRQ before releasing m2m
 state
To: Nicolas Dufresne <nicolas@ndufresne.ca>, Fan Wu <fanwu01@zju.edu.cn>,
 jacob-chen@iotwrt.com, ezequiel@vanguardiasur.com.ar
Cc: mchehab@kernel.org, heiko@sntech.de, linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260704084659.612221-1-fanwu01@zju.edu.cn>
 <c5bb16dec180576cb7e68221880b5e36b7cb689b.camel@ndufresne.ca>
Content-Language: en-US
From: =?UTF-8?Q?Sven_P=C3=BCschel?= <s.pueschel@pengutronix.de>
In-Reply-To: <c5bb16dec180576cb7e68221880b5e36b7cb689b.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 9/28/26 22:18, Nicolas Dufresne wrote:
> Hi,
>
> Le samedi 04 juillet 2026 à 08:46 +0000, Fan Wu a écrit :
>> rga_remove() releases the m2m state before the IRQ is freed. The IRQ is
>> devm-managed and is only released once rga_remove() returns, so rga_isr()
>> can still run while the m2m device state is being torn down.
>>
>> Store the IRQ number in struct rockchip_rga, unregister the video device
>> first, and free the IRQ before releasing the m2m state so the handler
>> cannot run against the freed state.
>>
>> Fixes: f7e7b48e6d79 ("[media] rockchip/rga: v4l2 m2m support")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> Again, I don't know if this is a real issue, but seems fair.

thanks for forwarding. Also stumbled upon the ordering in the remove 
function but kept it, as it looked akward if it mismatched the probe 
cleanup order (which comes from the fact that the video device is 
allocated, then the m2m device and after that the video device is 
registered). Is it possible to init the m2m device first and then 
allocate and register the video_device, thus keeping the same teardown 
order (i'd then adjust this in my multi-core series)? Or is there some 
logic behind this probe ordering?

Btw. the irq variable will probably be dropped with my 
mulit-core/component-devices patchset, as I then have a separate core 
struct and can check if my core has been already bound to something (and 
otherwise ignore IRQs). See [1][2]


Sincerely
     Sven


[1] 
https://lore.kernel.org/linux-media/20260916-spu-rga3multicore-v2-13-23aa2cb74e61@pengutronix.de/

[2] 
https://lore.kernel.org/linux-media/20260916-spu-rga3multicore-v2-14-23aa2cb74e61@pengutronix.de/


> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>
> Picked, ty
>
>> ---
>> Changes in v2:
>> - Rebased onto media-committers/fixes (Linux 7.2-rc1) so the Media CI
>>    valid-ancestor check passes. The rga driver was rewritten upstream
>>    (rga3 support, external IOMMU, clk_bulk, cmdbuf moved to rga_ctx), so
>>    this is a re-port rather than a pure rebase: the resource freed during
>>    removal is now rga->m2m_dev.
>> ---
>>   drivers/media/platform/rockchip/rga/rga.c | 4 +++-
>>   drivers/media/platform/rockchip/rga/rga.h | 1 +
>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/media/platform/rockchip/rga/rga.c b/drivers/media/platform/rockchip/rga/rga.c
>> index b3cb6bf8eb86..fbc99462dce2 100644
>> --- a/drivers/media/platform/rockchip/rga/rga.c
>> +++ b/drivers/media/platform/rockchip/rga/rga.c
>> @@ -797,6 +797,7 @@ static int rga_probe(struct platform_device *pdev)
>>   		ret = irq;
>>   		goto err_put_clk;
>>   	}
>> +	rga->irq = irq;
>>   
>>   	ret = devm_request_irq(rga->dev, irq, rga_isr,
>>   			       rga_has_internal_iommu(rga) ? 0 : IRQF_SHARED,
>> @@ -876,8 +877,9 @@ static void rga_remove(struct platform_device *pdev)
>>   
>>   	v4l2_info(&rga->v4l2_dev, "Removing\n");
>>   
>> -	v4l2_m2m_release(rga->m2m_dev);
>>   	video_unregister_device(rga->vfd);
>> +	devm_free_irq(rga->dev, rga->irq, rga);
>> +	v4l2_m2m_release(rga->m2m_dev);
>>   	v4l2_device_unregister(&rga->v4l2_dev);
>>   
>>   	pm_runtime_disable(rga->dev);
>> diff --git a/drivers/media/platform/rockchip/rga/rga.h b/drivers/media/platform/rockchip/rga/rga.h
>> index bd431534d0d3..7bcdf36c11b4 100644
>> --- a/drivers/media/platform/rockchip/rga/rga.h
>> +++ b/drivers/media/platform/rockchip/rga/rga.h
>> @@ -73,6 +73,7 @@ struct rockchip_rga {
>>   	struct device *dev;
>>   	struct regmap *grf;
>>   	void __iomem *regs;
>> +	int irq;
>>   	struct clk_bulk_data *clks;
>>   	int num_clks;
>>   	struct rockchip_rga_version version;
