Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795715012;
	b=j7eSavmpleLW/hxnK9g2LcYw2FnKgIzN2AL2tqRW24amPim6nsh7V+4sPJQAxLNxmnO2
	 TDpVxbt+89bbDS3yt3Wrnu7Gweeg0DGTTB6LX4CH7fPe3fEp92cnpzttKAbqTK/3mjY+w
	 qWX95wFCn1jDncCHMFJYAwEKOa0O5In4giBeLtOzKuulr3jZIbVwcvAbyLpyO/AmvDHIM
	 8mdK09/Lp1TyhzeRM1dMTyCwIRzy4FjpxA4aVZjFsrr2bpBd0XWyEvMuxeh1Sosgyx7mP
	 xsAbLkIBD240sBXsk7sG+BHeHrNKAGS+MANz2OLVX72dbfjsZs7wjX/IjGMa7XYZZuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795715012;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=OSNcRORAEp8c/GzbLbRzoraEBpV6hWxv+lNz+5vcV7U=;
	b=ZNV8iz5DkVpHQYPCKgKVB6ejCT5pvY8HwvJVzs+uOch2j7kuZ4r1+JF48Uk/mD80ZbbH
	 ESLhZE2WbfbAC3O7mwD74t+2twaDsJwKfSJR7HVaw+BrIzpX3xKfZxzjAmWvLfDh/JKGo
	 oMvkiyf9Ybgr6WRyv4Y93n8Ek/ZHTdoFrs6vx0I6xkgK3zS3wUsacGB1befW41rnackf6
	 tgLRWLWVKnk3r3YMTENctj4ludy+NhUr9F3csXL/MSyD6yfL56npW2gbE2aNdGPa6ymBV
	 1+GUMJiyCVKNT+PJaRaCs2CaiTMSXPoaYNsIxZ63vWA6ZVoZHAu4TmvV4OVWgUtm0eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=srzNOVLA;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC680606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 17:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC680606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=srzNOVLA
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 46A964E41787;
	Thu, 26 Nov 2026 17:43:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0371F60558;
	Thu, 26 Nov 2026 17:43:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 76E1811E6919C;
	Thu, 26 Nov 2026 18:43:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795715005; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=OSNcRORAEp8c/GzbLbRzoraEBpV6hWxv+lNz+5vcV7U=;
	b=srzNOVLAeT8rAnrjofljDdJDQuervMIYU8rIncNmnxpIvle5154eREFn4dDWh8Kve1TCyf
	q4zzE17tS1VxdUvE7Aar+TDbvPL3wBBV4lP6MQMg/flBD57o3tPhk0wKPMZkN4HT/cRp97
	LGDU9goiLV8WhHzbEZiO+fHFF/fij3VVAhEHJ76YdH054TaccfTq72wiR3RrozorzsRbuN
	bE2ST1i/7/X4dh85B+/YPRMYUuJpt8D5OTfplIwSN/YyrA3g+Z2F5ltEdruhsaTeNziXlk
	jBH4NHJzKXS3tHWcna493Op/thA09rgi4dltScEkzpbKZJpA23I9QHMgvAvkqg==
Message-ID: <42cbe8ff-cfe9-4720-8d5f-685e7ff1c560@bootlin.com>
Date: Thu, 26 Nov 2026 18:43:20 +0100
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
Subject: Re: [PATCH v3 4/5] pinctrl: upboard: fix I2C pinmux-select set CPLD
 GPIO OUT not function mode
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Gary Wang <is0124@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Daniele Cleri <danielecleri@aaeon.eu>, JunYingLai <junyinglai@aaeon.com.tw>,
 Louis Chen <louischen@aaeon.com.tw>, BillyChou <BillyChou@aaeon.com.tw>,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261126-upboard-pinctrl-add-intc1057-intc105e-support-v3-0-81d35c9ba246@gmail.com>
 <20261126-upboard-pinctrl-add-intc1057-intc105e-support-v3-4-81d35c9ba246@gmail.com>
 <awhPbIZjDazImfBf@ashevche-desk.local> <awhQ0mvdzSw9NaVM@ashevche-desk.local>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <awhQ0mvdzSw9NaVM@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 11/26/26 4:31 PM, Andy Shevchenko wrote:
> On Thu, Nov 26, 2026 at 05:25:37PM +0200, Andy Shevchenko wrote:
>> On Thu, Nov 26, 2026 at 11:09:47PM +0800, Gary Wang wrote:
>>> The CPLD I2C pin mode setting through pinmux-select is not correct.
>>> Should be set UPBOARD_PIN_MODE_FUNCTION on AANT0F04 devices.
>>>
>>> Set UPBOARD_PIN_MODE_FUNCTION to 1 to prevent a NULL pointer
>>> dereference error on .modes[i] for any pin group using this setting.
> 
> Hmm... bit how the modes[i] can be messed up here? 0 is integer
> and NULL is void *...
> 
> Can you provide a compiler warning or traceback of broken kernel with this?
> 

I guess the problem is here [1]. It should triggers a NULL pointer error
when you select the I2C0/1 functions.

His patch fixes 2 issues:
- The first one is the wrong pin mode for I2C0/1 functions
(UPBOARD_PIN_MODE_FUNCTION instead of UPBOARD_PIN_MODE_GPIO_OUT) which
makes the second one visible.
- The second one is having UPBOARD_PIN_MODE_FUNCTION=0 because of [1].

[1]
https://elixir.bootlin.com/linux/v7.4-rc1/source/drivers/pinctrl/pinctrl-upboard.c#L713

Best Regards,
Thomas



