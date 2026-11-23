Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795458321;
	b=243zlXRiWJ/npnJe9NEvNSBSWIxEf7/71VKX54BtUb9KvY7ev6MsbHVub8XSvrMDj4yM
	 1GE+hBsB88aFvoVo/kZoveWKpzeegGZqfa/+GE611hl1QjX4X4jIuGp2UCnVnCl8p+ru4
	 HL6VQrQWnMy0PUszw3OjrED1jdZe8KjVWMQELG9To8oeLhhWW/Ugmr1Lqyq+aPAOgUQ3h
	 6ZB64WKzE9Lf2R6XDaqDnOfYz4Y/DDvqSzjXuZ4mC3HmB+EarzFtFNduJeJ8nGcpCAXac
	 mzEr7wvsS1QUpIvLFbTlGvj5m8mxEnjtHERlkuhC95z4vcvOHGrjATGWZWiQirtS69w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795458321;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=Q9M1f4MOumbTQ0WzVzvoqs4QXcgTsmE14YZcpKo2y4o=;
	b=fCGD6kZoon7ldaQ6/hyreVWeeIuBcUXMuUs6wZk2gSXNwcg7HAXaErWgSruokFJjCJ4c
	 DGFurMDi63OZTn9ILEBk5y1B3lleNcshE0hSzYL/7PyOUdZ7FXmL4CzweLxpchW85enug
	 yCh93CaItVhXmZEodL3iFnKc9USVVs9HTlS98Z+5IOFZKVl/LPJftBrds1yxbMwkeq7FU
	 1jdhQcPGFLmLFp+MIgSQs9fvAht2ceN27W1y+g2ySMJslv+pxFo73kG5uXWvczRL3Ci2m
	 2++GSXr+esUMRinPxcH846+wNrZXc8ly+IUfthgESmNli69Gifu1k/PKcDG0aTsUb+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.net;
	spf=pass smtp.mailfrom=gmx.net;
	dkim=pass header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b="Zjr/9fsU";
	arc=none smtp.remote-ip=212.227.15.15
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B406606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 18:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B406606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=Zjr/9fsU
DKIM2-Signature:  i=1; m=1; t=1795458318;
 mf=PHdhaHJlbnN0QGdteC5uZXQ+;
 rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.net;
 s=s31663417:rsa-sha256:G1Bc1kOYrHzIaFRzE4cqXnLV4fYB
   UvhTaWkrE53zU635e18MQqf/Wksq/FhQWVPDzsNcHi/Z5wDsateNpG2DsLbLgVwDp9ppiILWo+J
   G+9txAr+0/liYBjEDsODCFc6EvXn1yi9EG+exWGzKfXp1UBA4Bfd3daxZ8t2/PuOsECvCFevGMg
   LtPPpy/iFEga7kwegkhoK5TeLhOVVqoCTYHNARn5xJ12y6j/LOH4ZHMTNURvyc5lM6gkNzpprUN
   7aQEcr3e10q43YRLLG5bIlGzEWBMh8fRfIu5rXcUVmb3YGBqs5iIB48Gn7GwbxVwQNvzVi9IZmH
   vyxE/rTZpRZwYw==;
Message-Instance:  m=1;
 h=sha256:
   I4Oyd0z7TzBrDr72TIxrhMTOd/IJD4lr0f9i0LzAh4M=:
   Q9M1f4MOumbTQ0WzVzvoqs4QXcgTsmE14YZcpKo2y4o=,
  sha512:
   W6ffUuY4raHM97QPhrJ8eUPnb5uGCkwg725g+3bhEvVJzb026x3b3+DJCe/XVZyZcoFvs5SS6N/GjEeuAJRT+g==:
   7ilgF1oE7QchF1bYeNW4e7/ZZ4RMOhLURgrJ4+COnxAHyFjXIihVAo1XjKRCG1mXL0vq03xtuRneON1lFDIZZg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1795458311; x=1796063111; i=wahrenst@gmx.net;
	bh=Q9M1f4MOumbTQ0WzVzvoqs4QXcgTsmE14YZcpKo2y4o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Zjr/9fsU1t7mxVdTw7w0s3ws6Id/J43wbquSyFz1Vw27HKTVytt1unMwWvBF6g8q
	 u3UCf+w4mgeQlUMDB7ga7OnPF5L5+VvFR7lDG1XoKP1vc7TtlQAwa1mnZtt38ZLOC
	 Inhs/Iid0rhDkqCgQLrrWXQEQ5cOqk+xuecLiwj4jNkV0N7LTqiAp0J1WeIgjDWxC
	 isz7nt68h8/bc0BCkNkdG0/sLUiu8uSIduM+down2iyeALk90oj+sM+OkglfLz5nd
	 X3z7b6EBrU6vEDM7Z8X9SUPlaIl6MfbN7vj/mXYPpDrPdlqEvDtU7GeMrYACU5DD7
	 zl+paC1dL+VjT4aX6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbRfv-1y76P02p7R-00fAyi; Mon, 23
 Nov 2026 19:25:11 +0100
Message-ID: <10f02aec-cb1c-48d4-ac1d-3644a9d1e54a@gmx.net>
Date: Mon, 23 Nov 2026 19:25:10 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pwm: gpio: unregister the chip on driver unbind
From: Stefan Wahren <wahrenst@gmx.net>
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yu Zhang <yuz08559@gmail.com>,
 stable@vger.kernel.org
References: <20261101032646.11397-1-yuz08559@gmail.com>
 <1d732b5f-7966-4abb-b2f5-54e26cbf14dc@gmx.net>
Content-Language: en-US
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <1d732b5f-7966-4abb-b2f5-54e26cbf14dc@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:U6VLW6GPgENX+VnqzhERrNHh45YDmmvp2ReWfwNLlJkvrytMiiF
 aNFHG5vqhj6pj4jGCnL5AF77OiTJU4AW6EOcu5cGEzvIof63lzJRpW36soQY9ZKER7+XLka
 cNixgbuC9tdyo3L/pq1Iq6T/EuzowDGFI3Ld6PP/99jcDVMldBFLUzO3T4s1OsJoceqCBEK
 l+YQiO7D3jk7OG4U4mHuQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sQVKpTEmeG8=;rp1IAEQfqIpfWT2jn8FAUxsNlKC
 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

Hi Uwe,

Am 01.11.26 um 13:55 schrieb Stefan Wahren:
> Am 01.11.26 um 04:26 schrieb Yu Zhang:
>> pwm_gpio_probe() registers the chip with pwmchip_add(), but the driver
>> has neither a remove callback nor a devm action calling
>> pwmchip_remove(). On unbind the devres callbacks release the GPIO
>> descriptor, cancel the hrtimer and drop the reference taken by
>> devm_pwmchip_alloc(), while the chip stays registered: it is still in
>> the pwm_chips idr, its sysfs attributes and character device are still
>> there and chip->operational is still true.
>>
>> The chip can therefore still be reached through sysfs export, the
>> character device, debugfs and pwm_get() from a consumer. Those paths
>> call into chip->ops, which point into unloaded module text once the
>> module is gone, and pwm_gpio_apply() re-arms the cancelled hrtimer and
>> drives a GPIO descriptor the driver no longer owns.
>>
>> Use devm_pwmchip_add() so that the chip is removed before the hrtimer
>> is cancelled and the GPIO is released.
>>
>> Fixes: 7f61257cd6e1 ("pwm: Add GPIO PWM driver")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Yu Zhang <yuz08559@gmail.com>
> Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
any concerns with this patch?
