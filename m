Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793537759;
	b=ANlmng/pOv73VqeK4ty5EBHhMkHL1sg/SebAc7eShJIT2sOilK3fgZlUKBxeL1u8GsEf
	 /ZutFLYyAdYYbj5KMYqYgOWbpSKnT3iTCSkvcMnaq0LxReNFpoGUF/dbl544AsqBo3ria
	 4PURNjwo8jTUnrcjjznPoNtDX99Q9dBmIlFcsDHTRUrDCUOCmWJUIFWvCrzS+IlqcOaxr
	 sF0Uobcn4kPF6u4vuvVckw9CpdQGq13cNTMqrsNe3OWJllJT3I+sT/v48qfSHj0eqBEHN
	 9xbbxSpZKGXErj57Q9YCfq7O+UjIZD4faKDrviShT9YSbMX64gF24Ie28stlMe8OrGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793537759;
	h=DMARC-Filter:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=u6AIEOdhPCbMXGLISQDDFPVBlGxG6xpD6K46qYPoXBs=;
	b=CIgRBaj2T3M8xUS7oNJ2g7Rlq21Y9Ar+xCEHImgwgf68SbCIXhucwV+BA7/GZLQ2OQTT
	 oGG0bFToeldWH0c+ilwShsyLcUYXy/BKSLfD+W9Mrx6EKft/TogKolxTs59txNBGcNHhm
	 DGADOHoMtuPtRafjZoh+nHQFL8A7O0vtumzELp6DWAB6kY8g5uuwBM4BkrRFSwpIqYd1U
	 lGK75Y3+vlXjvLF17yXCXb/htiicdyjht1P7L+vekkV4yrYcLrYjiB7Zm5a33tuhBlTWi
	 yBo90IRHa8chF1bm/CMuKtKfhbGtjL6AaYMarKYQxwX5GR1peiUphU5W1szDGHC40Ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.net;
	spf=pass smtp.mailfrom=gmx.net;
	dkim=pass header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b="On0/M4KD";
	arc=none smtp.remote-ip=212.227.17.22
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0EB606A324;
	Sun,  1 Nov 2026 12:55:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D0EB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmx.net header.i=wahrenst@gmx.net header.a=rsa-sha256 header.s=s31663417 header.b=On0/M4KD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1793537751; x=1794142551; i=wahrenst@gmx.net;
	bh=u6AIEOdhPCbMXGLISQDDFPVBlGxG6xpD6K46qYPoXBs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=On0/M4KDE9hZrnIqjS9p5uG4LrNLsbAhekYBEhKrXF41wXhau4yUqjf9dBeknlsN
	 rG9XJ/IcKyHEUl6DtTrhzzOrJBq6KtSeYHLsM/869oKgaHjD5P/s7uPBz++9ph8Fq
	 nUsnGOHY+47l3ahwBA7rHrfagiUwTC/0f16Py6DjhpcCZbC1alrOGq5qKko3QCWUT
	 kAeWFk4SIiPsS6JLM67vUc03FRZOLupFx+2HCeHXzCtUjA+BdToD++v8n/L1AHtTv
	 JKmR9/mrLUF0UV0k8rR2Ln0fQ5vOzdXcv76qOqtb0nXOvzPLF18O7zmo7lQxM3nIL
	 dds9AZw12xYyeFG5Uw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1fmq-1wQHgV2MZc-00r2gy; Sun, 01
 Nov 2026 13:55:51 +0100
Message-ID: <1d732b5f-7966-4abb-b2f5-54e26cbf14dc@gmx.net>
Date: Sun, 1 Nov 2026 13:55:50 +0100
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
To: Yu Zhang <yuz08559@gmail.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-pwm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261101032646.11397-1-yuz08559@gmail.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20261101032646.11397-1-yuz08559@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:asdXOyx+1D2WBPylllCpwleWrtxnaB2J1KgdOPMgg0k9WWLM5iF
 7xdRzyjL854O60Yvq5XVTMJXLROWk7BnD2hoRxWJ6ACdPSjVFHO0LR0joVTM6i9hfBjYHJJ
 yEckK7lwf7CQZFmUjdQWIzTCk3mowfwbnkOldWOVqUAYBzBGdG5B2LYTcWiqVjOQLFepWf1
 qYRfVuAY3zF9pX1j/ofFg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5n/yeHH5B5Q=;A/fVAT1Lc9AQqj6iGoWq61vYLQM
 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

Am 01.11.26 um 04:26 schrieb Yu Zhang:
> pwm_gpio_probe() registers the chip with pwmchip_add(), but the driver
> has neither a remove callback nor a devm action calling
> pwmchip_remove(). On unbind the devres callbacks release the GPIO
> descriptor, cancel the hrtimer and drop the reference taken by
> devm_pwmchip_alloc(), while the chip stays registered: it is still in
> the pwm_chips idr, its sysfs attributes and character device are still
> there and chip->operational is still true.
>
> The chip can therefore still be reached through sysfs export, the
> character device, debugfs and pwm_get() from a consumer. Those paths
> call into chip->ops, which point into unloaded module text once the
> module is gone, and pwm_gpio_apply() re-arms the cancelled hrtimer and
> drives a GPIO descriptor the driver no longer owns.
>
> Use devm_pwmchip_add() so that the chip is removed before the hrtimer
> is cancelled and the GPIO is released.
>
> Fixes: 7f61257cd6e1 ("pwm: Add GPIO PWM driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yu Zhang <yuz08559@gmail.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
