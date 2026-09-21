Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FAC1DA23;
	Mon, 21 Sep 2026 01:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789954870; cv=none; b=GwDQAZc4XIAQL3W1JBi/J9PG3pSwPdDx1u6phuCnNcbp5xb4J2xh7CpZHOWDaJPHUBedW5bv+YKD0Hnoj2NPcY8rzLPMWEaWTntUsESS3MpCB5rG3WxKTEmTJDzTx/XGUYM3n1/1EMng8lR2ZEDc/2inzTvn4YMnUFpw6oGfStM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789954870; c=relaxed/simple;
	bh=jDiIl7/7Df+HkWggMaCl/X8Znth27zy0ovp3DM5dvSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k5vdQB+9KqqvUfK0GGU2zDHHv/NT55spWhygPhmjqAzwa1AHIYn+Nfzz068SKQK/0dDkO+Faz2Vy7D82DVmhv7lvmAeeo8N5480IsjfpSpArKaVnuJR3UE6L5Eg8THCc6zf6xFqOSoeWe/O/kjcXQqPAmDP1zUtfe+bhHMsIyaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=cjkE9x5t; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="cjkE9x5t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=HBB22xTvlIdnnUpDmcGb9WM9KBxzgtzh1eAOBEppS6s=;
	b=cjkE9x5tD8Olglh0wr6jrDc8SleOEYplfrtufXlmxLuRCPL2flZtr56UuzY4K4
	XBgNIOkZbYBqKgXEMWdvO55dllBcG3Sc7A1bWe9eGQHsBw9ER2b2Bi4qep+RVXjp
	f3Yvoj8qb5KYf7wX1+maqszaESRl9N40ufvFqgk7WPHlA=
Message-ID: <d7ad3298-9d06-4498-9d39-dc7f43eb0efd@126.com>
Date: Mon, 21 Sep 2026 09:39:45 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: stmmac: request the MDIO reset GPIO only once
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>, stable@vger.kernel.org
References: <20260920054703.1897755-1-xiaolinkui@126.com>
 <aq-UJEFIq2aHfEee@lore-desk>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <aq-UJEFIq2aHfEee@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3P+vhirBqrK9QBw--.58600S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxKr15uFyxur4DKrWUXFyrJFb_yoWxGr1Up3
	y5Zay5ArWkJr4Iqws7Xw4UZF9YkFW3tr4UCw1F9rWSyan8KrWSvr1Sqry5ZFy2krWUWFya
	vr18uFnruF4qyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U4Vb9UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlAKheGqwiuJbYwAA3F

Hi Lorenzo,

On 2026/9/20 16:07, Lorenzo Bianconi wrote:
>> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>>
>> stmmac_mdio_reset() calls devm_gpiod_get_optional() every time it runs.
>> A GPIO line can only be requested once, so from the second call on
>> gpiod_request_commit() returns -EBUSY. devm_gpiod_get_optional() only
>> turns -ENOENT into NULL, hence the error is passed straight back and
>> stmmac_mdio_reset() bails out before pulsing "snps,reset" and before
>> running the STE101P MDC workaround.
>>
>> The first call, made by of_mdiobus_register(), succeeds, so the failure
>> is only visible later on: every resume that does not use WoL goes
>> through stmmac_resume() -> stmmac_mdio_reset(), and that caller ignores
>> the return value, so the PHY silently stays un-reset.
>>
>> The descriptor used to be requested exactly once: stmmac_mdio_reset()
>> resolved "snps,reset-gpio" itself and cached the GPIO number in
>> stmmac_mdio_bus_data::reset_gpio, and commit ae26c1c6cb9b ("stmmac: fix
>> PHY reset during resume") relies on that cache to reuse the line on
>> every call. commit 7c86f20d15b7 ("net: stmmac: use GPIO descriptors in
>> stmmac_mdio_reset") replaced it with a devm_gpiod_get_optional() that
>> caches nothing, so the request is repeated on every call and fails from
>> the second one on.
>>
>> Request the GPIO in stmmac_mdio_register(), at probe time, and keep the
>> descriptor in struct stmmac_priv. This is where devm-gpiod is meant to be
>> used: the line is acquired with the device and released with it, and any
>> failure to acquire it is reported during probe instead of being ignored
>> by stmmac_resume(). stmmac_mdio_reset() then only pulses the cached line.
>>
>> The request is still gated on mdio_bus_data->needs_reset, which is the
>> condition that installs the reset callback, and on the device using DT,
>> as the reset itself is.
>>
>> Fixes: 7c86f20d15b7 ("net: stmmac: use GPIO descriptors in stmmac_mdio_reset")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
>> ---
>> Changes in v2:
>> - Do not request the GPIO from stmmac_mdio_reset(); request it once in
>>    stmmac_mdio_register() at probe time instead. (Maxime Chevallier)
>>
>>   drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 ++
>>   .../net/ethernet/stmicro/stmmac/stmmac_mdio.c | 19 ++++++++++---------
>>   2 files changed, 12 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
>> index 7582fca63741..986fb43db45f 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
>> @@ -25,6 +25,7 @@
>>   #include <net/xdp.h>
>>   #include <uapi/linux/bpf.h>
>>   
>> +struct gpio_desc;
>>   struct stmmac_pcs;
>>   
>>   struct stmmac_resources {
>> @@ -287,6 +288,7 @@ struct stmmac_priv {
>>   
>>   	unsigned int pause_time;
>>   	struct mii_bus *mii;
>> +	struct gpio_desc *mdio_reset_gpio;
>>   
>>   	struct stmmac_pcs *integrated_pcs;
>>   
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
>> index afe98ff5bdcb..346f93f86abe 100644
>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_mdio.c
>> @@ -386,15 +386,8 @@ int stmmac_mdio_reset(struct mii_bus *bus)
>>   
>>   #ifdef CONFIG_OF
>>   	if (priv->device->of_node) {
>> -		struct gpio_desc *reset_gpio;
>>   		u32 delays[3] = { 0, 0, 0 };
>>   
>> -		reset_gpio = devm_gpiod_get_optional(priv->device,
>> -						     "snps,reset",
>> -						     GPIOD_OUT_LOW);
>> -		if (IS_ERR(reset_gpio))
>> -			return PTR_ERR(reset_gpio);
>> -
>>   		device_property_read_u32_array(priv->device,
>>   					       "snps,reset-delays-us",
>>   					       delays, ARRAY_SIZE(delays));
> 
> nit: what about moving even these properties to stmmac_mdio_register()? It
> seems a bit odd to have half of the parsing in stmmac_mdio_register() and
> half in stmmac_mdio_reset(). What do you think?

Agreed, and thanks for pointing it out.

v3 reads "snps,reset-delays-us" in stmmac_mdio_register() as well and keeps
the three values in struct stmmac_priv, next to the descriptor, so the whole
reset description - the line and its timings - is parsed once, at probe 
time.
stmmac_mdio_reset() then only waits and pulses the cached line.

With the parsing gone, the callback doesn't need its CONFIG_OF/of_node guard
either, so I dropped that too: stmmac_mdio_reset() no longer looks at the
device tree at all. Where the description is absent, the cached descriptor
is NULL and the delays are all zero, so the pulse is a no-op - exactly what
the of_node check used to make of it. The request and the delays stay gated
on mdio_bus_data->needs_reset and on the device using DT, in
stmmac_mdio_register().

Nothing else changes: struct stmmac_priv is zeroed when it is allocated, so
a missing or short "snps,reset-delays-us" still gives the same all-zero
delays the local initialiser did.

Thanks,
Linkui
> 
> Regards,
> Lorenzo
> 
>> @@ -402,11 +395,11 @@ int stmmac_mdio_reset(struct mii_bus *bus)
>>   		if (delays[0])
>>   			msleep(DIV_ROUND_UP(delays[0], 1000));
>>   
>> -		gpiod_set_value_cansleep(reset_gpio, 1);
>> +		gpiod_set_value_cansleep(priv->mdio_reset_gpio, 1);
>>   		if (delays[1])
>>   			msleep(DIV_ROUND_UP(delays[1], 1000));
>>   
>> -		gpiod_set_value_cansleep(reset_gpio, 0);
>> +		gpiod_set_value_cansleep(priv->mdio_reset_gpio, 0);
>>   		if (delays[2])
>>   			msleep(DIV_ROUND_UP(delays[2], 1000));
>>   	}
>> @@ -608,6 +601,14 @@ int stmmac_mdio_register(struct net_device *ndev)
>>   	if (!mdio_bus_data)
>>   		return 0;
>>   
>> +	if (mdio_bus_data->needs_reset && dev_of_node(priv->device)) {
>> +		priv->mdio_reset_gpio =
>> +			devm_gpiod_get_optional(priv->device, "snps,reset",
>> +						GPIOD_OUT_LOW);
>> +		if (IS_ERR(priv->mdio_reset_gpio))
>> +			return PTR_ERR(priv->mdio_reset_gpio);
>> +	}
>> +
>>   	stmmac_mdio_bus_config(priv);
>>   
>>   	new_bus = mdiobus_alloc();
>> -- 
>> 2.25.1
>>
>>

