Received: from ixit.cz (ixit.cz [84.42.129.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644BD40BCB8;
	Fri, 25 Sep 2026 20:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.42.129.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367661; cv=none; b=bxASarUXhVB2QHJ0IrRDWtR8kZQsLcDzIxpkgE5ScG5X7lHDagwFLqh9xWN+gpOiu3029NSXvV0JbLkoE2KZn5hilkPi7m8t4wwflLUP/4p1muZP0FC4qooC5rdt6HH7DZr/OVviogDFuxf6hEphZ3IgkrroG2h0L+D1oOKoBEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367661; c=relaxed/simple;
	bh=tAQBxFgeNXRYWDnVw3qPWSdDudkU5b4E58qID2FP0sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+/Aa+jpCJ4xs/Zzc9njZqAAZWDAH3Yi+jC/sK5xY/JF5vErb1ujf1+X6RLLbtRpr3OZMn71HV9NVxHbJSjC1zgl6QRoCdNpnViM2EaU/PUtY6H3LTcx+2+KJfigjLELXCoyVqubi6Er6OS+yg6nerPARG49NrQjUFs3u2jzEBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=rSfzWamQ; arc=none smtp.client-ip=84.42.129.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="rSfzWamQ"
Received: from [IPV6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e] (unknown [IPv6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id C6B1B5340215;
	Fri, 25 Sep 2026 22:20:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1790367656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PgOgOgX/53l72xX/VCoPzjEGh8tHz10dY4VffJmYMnQ=;
	b=rSfzWamQPk8r0LfhDfHY11UnKlZihsBnF7ExdfD+7jEEapvq3lZgcCaLZcSdCpR6JO5DwU
	E4HgGUGOCGvi/1QBYn0JUkWIEVRCAcQkbnKy571y5aK1CowtpM1z6puja4rIqxiAMi/nve
	LzVML0cPLkjTRTjgDAiOYAfzu4CrS+0=
Message-ID: <b684b88b-55a6-41a9-a4da-3bca33550164@ixit.cz>
Date: Fri, 25 Sep 2026 22:20:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/4] Input: stmfts - wait for controller ready after
 reset
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Petr Hodina <petr.hodina@protonmail.com>, linux-input@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260907-stmfts5-v7-0-4a53381cd038@ixit.cz>
 <20260907-stmfts5-v7-1-4a53381cd038@ixit.cz> <arbJrK9zfoO1dGzy@google.com>
Content-Language: en-US, cs-CZ
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <arbJrK9zfoO1dGzy@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/09/2026 21:27, Dmitry Torokhov wrote:
> Hi David,
> 
> On Mon, Sep 07, 2026 at 12:50:19PM +0200, David Heidelberg via B4 Relay wrote:
>>   
>> -static void stmfts_reset(struct stmfts_data *sdata)
>> +static int stmfts_reset(struct stmfts_data *sdata)
>>   {
>>   	gpiod_set_value_cansleep(sdata->reset_gpio, 1);
>>   	msleep(20);
>>   
>> +	reinit_completion(&sdata->cmd_done);
>>   	gpiod_set_value_cansleep(sdata->reset_gpio, 0);
>> -	msleep(50);
>> +	enable_irq(sdata->client->irq);
>> +
>> +	if (!wait_for_completion_timeout(&sdata->cmd_done,
>> +					 msecs_to_jiffies(STMFTS_RESET_TIMEOUT_MS)))
>> +		return -ETIMEDOUT;
>> +
>> +	return 0;
>>   }
>>   
>>   static int stmfts_configure(struct stmfts_data *sdata)
>>   {
>>   	int err;
>>   
>>   	err = stmfts_command(sdata, STMFTS_SYSTEM_RESET);
>>   	if (err)
>> @@ -593,42 +602,47 @@ static int stmfts_power_on(struct stmfts_data *sdata)
>>   		return err;
>>   
>>   	/*
>>   	 * The datasheet does not specify the power on time, but considering
>>   	 * that the reset time is < 10ms, I sleep 20ms to be sure
>>   	 */
>>   	msleep(20);
>>   
>> -	if (sdata->reset_gpio)
>> -		stmfts_reset(sdata);
>> +	if (sdata->reset_gpio) {
>> +		err = stmfts_reset(sdata);
>> +		if (err) {
>> +			dev_err(&sdata->client->dev,
>> +				"controller not ready after reset: %d\n", err);
>> +			goto err_disable_irq;
>> +		}
>> +	} else {
>> +		enable_irq(sdata->client->irq);
>> +		msleep(50);
>> +	}
>>   
>>   	err = stmfts_read_system_info(sdata);
>>   	if (err)
>> -		goto err_disable_regulators;
>> -
>> -	enable_irq(sdata->client->irq);
>> -
>> -	msleep(50);
>> +		goto err_disable_irq;
> 
> 
> I think the logic is becoming quite convoluted here, and factored out
> stmfts_reset() does not help. How about we make it look like this:
> 
> static int stmfts_power_on(struct stmfts_data *sdata)
> {
> 	int err;
> 
> 	if (sdata->reset_gpio) {
> 		gpiod_set_value_cansleep(sdata->reset_gpio, 1);
> 		/* a short delay before powering up */
> 		usleep_range(1000, 1500);
> 	}
> 
> 	err = regulator_bulk_enable(ARRAY_SIZE(stmfts_supplies),
> 				    sdata->supplies);
> 	if (err)
> 		return err;
> 
> 	if (sdata->reset_gpio) {
> 		reinit_completion(&sdata->cmd_done);
> 
> 		/*
> 		 * The datasheet does not specify the power on time, but
> 		 * considering that the reset time is < 10ms, sleep for 20ms
> 		 * to be sure before releasing reset line.
> 		 */
> 		msleep(20);
> 		gpiod_set_value_cansleep(sdata->reset_gpio, 0);
> 
> 		enable_irq(sdata->client->irq);
> 
> 		if (!wait_for_completion_timeout(&sdata->cmd_done,
> 						 msecs_to_jiffies(STMFTS_RESET_TIMEOUT_MS))) {
> 			dev_err(&sdata->client->dev, "controller not ready after reset");
> 			err = -ETIMEDOUT;
> 			goto err_disable_irq;
> 		}
> 	} else {
> 		/*
> 		 * We do not know the real controller state (was it powered
> 		 * off or reset). Let's hope that this is enough time to
> 		 * initialize.
> 		 */
> 		msleep(70);
> 
> 		enable_irq(sdata->client->irq);
> 	}
> 
> 	err = sdata->ops->configure(sdata);
> 	if (err)
> 		goto err_disable_irq;
> 
> 	/*
> 	 * At this point no one is using the touchscreen
> 	 * and I don't really care about the return value
> 	 */
> 	(void)i2c_smbus_write_byte(sdata->client, STMFTS_SLEEP_IN);
> 
> 	return 0;
> 
> err_disable_irq:
> 	disable_irq(sdata->client->irq);
> 
> 	regulator_bulk_disable(ARRAY_SIZE(stmfts_supplies), sdata->supplies);
> 	return err;
> }

Thanks, it seems to be better (thou would be nicer if we didn't have two 
branches, but... what we can do).

I added you as Co-developed-by :)

David

> 
> 
> Thanks.
> 

