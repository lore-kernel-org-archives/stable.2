Received: from ixit.cz (ixit.cz [84.42.129.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805183DB655;
	Sat, 26 Sep 2026 09:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.42.129.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790416509; cv=none; b=euh54/+Q5dF79um4bMioDTYR5cGIUnkjmdfoFshbIv25oWe4g8tIMBv1KtmOTxhgwwbxePvGnNuikEyyoMSAs/qNeEcoKP2it1QCLbqVtzsoAbB5vD/ekioDl5LDsXGZnbU6AYYGrvSLunXX/+sCgWCTBGTvWRcxgvrojSJD+Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790416509; c=relaxed/simple;
	bh=d3yPoZPNCzeh+K127bR9RSO6Nj48iTjKgG7zkSD1icM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1q0V/UMyevc2clsL/dDfYdvg4dru3xdoGUlTA8K23CSQmQVht+sRljxhYjUaweoHAOVXsQ0ZPyi34u8aRWA1/EsPMnB7oTn7cOfAS/5tJbCJFeJUmXPdi1X5Dyb/6zAu7xs5MxEEA7CF3cnBVPcnLqXRtwssslMQ11GiQ8F/QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=sHRtMZAA; arc=none smtp.client-ip=84.42.129.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ixit.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b="sHRtMZAA"
Received: from [IPV6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e] (unknown [IPv6:2a02:830a:f787:8f00:d622:eaa3:3dd6:8f5e])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id D5D9C5340CEE;
	Sat, 26 Sep 2026 11:55:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1790416504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=32rpdRY1d+z3I43eDHyo/Txi1c6izkB8dW4wsRXOcy4=;
	b=sHRtMZAAldTESvErMIFIB/BeSlgtma36U9wm1GorQc/UZg7tqznuPif/K+9E798gsxA+V4
	Ib2lA1n86HZDSv3rNI9YM/+TKmXPOVWUiiY7zFT/TmhVtJkm9/1XWt7m75Cm6c6lwqeBWB
	fEUTlc9ZvifG2qaaStCoQi85zjRZxRk=
Message-ID: <187c9ec1-03fe-40a8-8c97-415b1a7aac23@ixit.cz>
Date: Sat, 26 Sep 2026 11:55:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: s6sy761 - fix resume ordering and restore sensing
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andi Shyti <andi@etezian.org>, Rob Herring <robh@kernel.org>,
 Marco Mattiolo <marco.mattiolo@hotmail.it>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260923-s6sy761-suspend-v1-1-6fff96e71cb0@ixit.cz>
 <ardMSVsG1RlOOkNp@google.com>
Content-Language: en-US, cs-CZ
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <ardMSVsG1RlOOkNp@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/09/2026 06:40, Dmitry Torokhov wrote:
> Hi David,
> 
> On Wed, Sep 23, 2026 at 03:27:06PM +0200, David Heidelberg via B4 Relay wrote:
>> From: David Heidelberg <david@ixit.cz>
>>
>> System suspend powers the controller off and resume powers it back on,
>> but the resume path enables the interrupt before s6sy761_power_on()
>> checks the boot. The firmware raises its boot-complete event on the
>> interrupt line, the threaded handler consumes it, s6sy761_power_on()
>> then reads an empty event and resume fails with -ENODEV, skipping the
>> touch function setup:
>>
>>    s6sy761 2-0048: PM: dpm_run_callback(): s6sy761_resume [s6sy761] returns -19
>>
>> Power the chip on first and only then unmask the interrupt. Once resume
>> completes the boot handshake the chip comes back with sensing off, as
>> at probe where input_open() turns it on, so the touchscreen stays dead
>> after resume. Send SENSE_ON again when the input device is open.
>>
>> Tested on a Pixel 3 XL over several s2idle cycles: resume succeeds and
>> the touch function and sense status match the pre-suspend state.
>>
>> Assisted-by: LLM
>> Cc: stable@vger.kernel.org
>> Fixes: 0145a7141e59 ("Input: add support for the Samsung S6SY761 touchscreen")
>> Signed-off-by: David Heidelberg <david@ixit.cz>
>> ---
>>   drivers/input/touchscreen/s6sy761.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/input/touchscreen/s6sy761.c b/drivers/input/touchscreen/s6sy761.c
>> index 0f24a9b730635..c52c45a7d1029 100644
>> --- a/drivers/input/touchscreen/s6sy761.c
>> +++ b/drivers/input/touchscreen/s6sy761.c
>> @@ -495,20 +495,29 @@ static int s6sy761_suspend(struct device *dev)
>>   	s6sy761_power_off(sdata);
>>   
>>   	return 0;
>>   }
>>   
>>   static int s6sy761_resume(struct device *dev)
>>   {
>>   	struct s6sy761_data *sdata = dev_get_drvdata(dev);
>> +	int err;
>>   
>> +	err = s6sy761_power_on(sdata);
>>   	enable_irq(sdata->client->irq);
> 
> Why are we enabling the interrupt even if power on failed?

originally I moved the enable_irq after condition, but LLM kept convincing me 
it's wrong:

enable_irq() still runs when power-on fails. That is correct, because the next 
suspend or unbind calls disable_irq() again through s6sy761_power_off(), and the 
two calls must stay paired.

In case of failure the power_off will be run anyway, thus it make sense to me.

> 
>> +	if (err)
>> +		return err;
>>   
>> -	return s6sy761_power_on(sdata);
>> +	guard(mutex)(&sdata->input->mutex);
>> +
>> +	if (!input_device_enabled(sdata->input))
>> +		return 0;
>> +
>> +	return i2c_smbus_write_byte(sdata->client, S6SY761_SENSE_ON);
> 
> Explicit return err/return 0 please - there are multiple failure points
> in this function.

Sure, I'll send next version making the explicit return.

David

> 
> Thanks.
> 

