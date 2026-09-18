Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAAB632;
	Fri, 18 Sep 2026 08:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789720964; cv=none; b=IVMbY1N9dzmkU1K3JMHpmNlfJBkTKCwFxHlDgAtU4lLDEpGlOrbudao8cyBxXy4zm0J2FCvLtCNt7twc/j4zpLc98/HzEBPQGjsZ+nS0fvjQLG9F7D6sEm9EFLRju7nGJF9VRAqYRY9oh7V0NX3sbm0BI1EW3KtlE0Bb0Uk57U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789720964; c=relaxed/simple;
	bh=PzldztNMS5Cjgu3kblAv99hJJzzoSjGJ8ayBAiYY3I8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sm2ud4BIFPOdBENbwPd+ana+rqAYymL535Wwp87nx46a0bE84P6QwbIi3TzKxLYZZgqlMI2xISh1UL616EjJzKavlNGav3Y82t0qb1qmt0YDYWVZ54rXiT4yHmC+86KdrnrcLXVAAvibtLSYckFFUmtPMQvsAb9/+onhD++RcfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=WJXSZjZQ; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="WJXSZjZQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=7+g8+UxJXbBTwX2N40/dzce93+bWOJpHxoj4kNEwGWQ=;
	b=WJXSZjZQzxzO2WgIdscOrxkCYknvi3aF6qRYuiZt4MsL+/VuWUnKEWD/O5Q7z5
	mUuj6ATRg+1lk/hBMV5EuKHBa11aQQuBwpd2i+slidDkf/Wmzu5oL5Visd85IEaO
	e4Rj5Q8NqWMzJvmdAb0EW2wBOzrH7eYQx2XoywR3yuG3M=
Message-ID: <514b0d85-c6b6-4e31-af41-5df45319e770@126.com>
Date: Fri, 18 Sep 2026 16:41:16 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: request the MDIO reset GPIO only once
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>, stable@vger.kernel.org
References: <20260917125457.1353718-1-xiaolinkui@126.com>
 <ff811e9f-4d4b-4b26-a0b5-84cb2eb52618@bootlin.com>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <ff811e9f-4d4b-4b26-a0b5-84cb2eb52618@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3V80s+axqJuOTBg--.3829S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ury5WF45tr48GFy7tr4fKrg_yoW8AryUpr
	4rXF45JF98A3yxtrWDXw4kuF9YyrnIyF4DGr1I9w4Ikwn8Xr4ftrWxtr15Xay2kryqk3ya
	gr4xua4DuFyvyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UcBMNUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlA5PJmqs+S6tCQAA3G

Hi Maxime,

Thanks for the review.

On 2026/9/18 00:10, Maxime Chevallier wrote:
> Hello,
> 
>> @@ -389,11 +389,21 @@ int stmmac_mdio_reset(struct mii_bus *bus)
>>   		struct gpio_desc *reset_gpio;
>>   		u32 delays[3] = { 0, 0, 0 };
>>   
>> -		reset_gpio = devm_gpiod_get_optional(priv->device,
>> -						     "snps,reset",
>> -						     GPIOD_OUT_LOW);
>> -		if (IS_ERR(reset_gpio))
>> -			return PTR_ERR(reset_gpio);
>> +		/* Request the reset line only once and reuse the descriptor
>> +		 * afterwards. A second request of the very same line makes
>> +		 * gpiolib fail with -EBUSY, which devm_gpiod_get_optional()
>> +		 * passes through because it only filters out -ENOENT. The
>> +		 * reset would then abort early and leave the PHY un-reset.
>> +		 */
>> +		if (!priv->mdio_reset_gpio) {
>> +			priv->mdio_reset_gpio =
>> +				devm_gpiod_get_optional(priv->device,
>> +							"snps,reset",
>> +							GPIOD_OUT_LOW);
>> +			if (IS_ERR(priv->mdio_reset_gpio))
>> +				return PTR_ERR(priv->mdio_reset_gpio);
>> +		}
>> +		reset_gpio = priv->mdio_reset_gpio;
> 
> The problem is real, but this isn't the correct approach to solve that.
> 
> Instead of requesting the reset gpio on-the-fly at reset time (good example
> of when not to use devm_xxx) , let's request the gpio at probe time.
> 
> I suggest you move the devm_gpiod_get_optional() in stmmac_mdio_register(),
> which is called at probe time. Here, it makes sense to use devm_xxx.
> 

You're right, requesting the GPIO in the reset callback is the wrong
place for devm_xxx.

I'll send a v2 that moves the devm_gpiod_get_optional() call to
stmmac_mdio_register(), which runs at probe time. stmmac_mdio_reset()
will then just use the descriptor stored in stmmac_priv.

Thanks,
Linkui

> Thanks :)
> 
> Maxime
> 

