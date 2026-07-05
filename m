Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8893603E8
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 07:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783236839; cv=none; b=UKgZObsst4KE7/rtloqGzZ8D0saPrJMnaaq0H7U6hhyDevD5idSA85rj800I/hgKd18sz1qZIzpdpJtBMr4BfUnsmriG7y9CMr9Hng39P+Drk1RQ5/EvitX6E3Vumq7ni78ZYYXZkPSt8sgG3W1Y2F2GNNODm02rdCxZR7Tnqc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783236839; c=relaxed/simple;
	bh=BAniLIxe5VehWiTjpLRK/YUK2Homp3nMMIKdtX834tM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mAxC3C/6pjs32b+nuGcKDTGAwc+cXQ9D5CTims0/5znlsNvHK7un6TP5VNuq2TJBrOEu7T728QOjIzK9K3gYDoplUMrxK8yJQB18s1VW42u7YgBFEuHzFduknu9ZJu++kW4zA9ht+j68UT42a8hp15flM1J2BF/R+wD8OM/9VLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoTeBQH7; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoTeBQH7"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493c5220cb7so14250315e9.3
        for <stable@vger.kernel.org>; Sun, 05 Jul 2026 00:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783236837; x=1783841637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3EHEPZ3m60Kw/+tCMTS/4omv9ZRDOvhv32Eg+BM9Bww=;
        b=UoTeBQH7DIh/BWnvZRCncgg3Ro4B0hBr//7SL2VK2MMaUBTmJwlt939Rvqk6pQ0AGR
         QhqfbVsYjtQvkiYo/8+9A1Aq5BxJmeBQiv/CIv7QKhNKbaa8sXqZWmvnoQYAjyaQ6aOS
         cgmAE7ORwwEWluNKWPJbWEjBkjN/TiB2qRw6IBvK/RRe3QFWhXSaqNFWKZ9KCO20ovpH
         0Iv5NRwQ8fApDPdoCepkpZxPy1DQ6yupZcYQ2DLGIOKVF17+oE/JprMPzTjXhVilWS6T
         R1KwqIJNMASFAu2gCl53GiP5zFYnmmmBS8BLYsngL9aPG/TvT8pgqaLZdUq+wN6wjs2U
         zBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783236837; x=1783841637;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3EHEPZ3m60Kw/+tCMTS/4omv9ZRDOvhv32Eg+BM9Bww=;
        b=T94x4vHkegtaxeAtKr2KuDH7IYDiHDTYVrDHoHvjPVHAiWxe41MNlwD7m1sfC8zssk
         BcHFuxxgAgeV6sw9rtGwBv9nXqctL2SwsIKavm+e1C0Fba0O9SUsZAoUlPDbpkFSbRqD
         sL5i9n9y88yTwc4Iazg2lrLIefT+OqF8R1r5wav+iyfL7sDbHxfvfsDSnm8a9u51c5nW
         a4fe1aJVcOchzrfRRxLojuNHETt4PCJzj3qDzof7s5GL2MQI6nWBj9bVbx7zJlWn71UI
         naf/1zWkEOpQ51vqBgCkFJALGJL4ASqUZ4mhKKugzGYm9+30F9lfLwzuICu5GRphWSFx
         D3DQ==
X-Forwarded-Encrypted: i=1; AFNElJ9dSm+x9EU4L967BOp/rvQIUu+NYBJyBnjix1t24dLRyGuSk8sCFtHqZzpiErXj2/7SbDhPm3A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBdAdaC+39LQKwTICzggD6NLbwz/IG6BSjGMOMCw2nsSkcT4VL
	3ySWyEYt8azbMEWZO5CDgm5VMlwzAWBPDLTPj6YsCQsi4iFTCb06n1pS
X-Gm-Gg: AfdE7cmGwmAC19xUv0L+hetk3YbKSuLziFeHwuGhxNAdsaBonCjlPb6D743Q17SgIg6
	hItrB/T8xkSirih08noaurOBeXbKNDnNddGC0F4oElOXwcJTTAHEKkOaGU/DXoc5sTWLRDhkeA9
	5AlOd2VBwNvDTShK8FDNWJwgArFSwx3Trp8S6HHfQjtaAgs+ZEEBgB/etQLfa74Xrg5Z/JFRnWo
	KnCq92rt+/Jl81uotWzRrHFmqy6QIu5OBpRNSMU45m9QCJ4jg22fXjGrrjL9/BAJTIev5Sw4oBs
	UWt20dOlJcr9bKOOQXw4VTJK/Kc75qRCxs5NSDJ5FZesbg0aBVr/YgHAwoKvDG1lOtgfkoVCxl3
	cXG/jPpIHOcyoGzO78U2SMih2FDsMVR4V4RCryvj9sLVku0JQAVadGkEWDXDPO85qGPD+Eb6bxb
	NLl/UqHeaKi/AEimiPBfEsjxcwidGgCLMBAkdG4tX57ZQRnfj54f516LNqLgErBw6ektTaA/WW4
	yMImFgLj+5svanat85LMkJM9110UPBouBcQVQM4NZ1EEmREbew=
X-Received: by 2002:a05:600c:3551:b0:493:bc4b:b8c with SMTP id 5b1f17b1804b1-493d11faf3amr67535995e9.38.1783236836820;
        Sun, 05 Jul 2026 00:33:56 -0700 (PDT)
Received: from [192.168.0.173] (108.228-30-62.static.virginmediabusiness.co.uk. [62.30.228.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493cce1a844sm174893715e9.15.2026.07.05.00.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 00:33:55 -0700 (PDT)
Message-ID: <8cba0a18-6cd7-48a9-9beb-83218148de6a@gmail.com>
Date: Sun, 5 Jul 2026 08:33:54 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: accel: bmc150: free irq before teardown
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, stable@vger.kernel.org
References: <20260705042731.388592-1-mlbnkm1@gmail.com>
 <akn_hlxkSDRG389t@ashevche-desk.local>
Content-Language: en-GB
From: Melbin K Mathew <mlbnkm1@gmail.com>
In-Reply-To: <akn_hlxkSDRG389t@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for the review.

I double checked the remove path.  The remaining hardware accesses after
freeing the IRQ are synchronous regmap accesses and do not rely on the 
IRQ being enabled.

In particular, iio_device_unregister() may disable the buffer path, 
which can call into the buffer predisable path and synchronously disable 
the FIFO interrupt, flush the FIFO and update the FIFO mode.  Later 
remove explicitly puts the device into deep suspend via 
bmc150_accel_set_mode().  These paths do not wait for an interrupt or 
use the threaded IRQ handler for completion.

The IRQ handler itself is only used for asynchronous trigger polling,
FIFO/event handling and interrupt latch acknowledgement, so freeing it 
before the rest of teardown should not remove anything that the remove 
path depends on.

On 05/07/2026 07:53, Andy Shevchenko wrote:
> On Sun, Jul 05, 2026 at 06:27:31AM +0200, Melbin K Mathew wrote:
>> bmc150_accel_core_probe() requests the interrupt with
>> devm_request_threaded_irq().  The managed IRQ is released only after the
>> driver remove callback has returned unless it is freed explicitly.
>>
>> bmc150_accel_core_remove() currently unregisters the IIO device and
>> triggers, cleans up the triggered buffer, suspends the chip and disables
>> the regulators while the IRQ action is still registered.  A late
>> interrupt can therefore run the hard or threaded handler while the IIO
>> trigger state is being torn down or after the device has been put into
>> deep suspend.
>>
>> Free the IRQ at the start of remove so that no handler is running while
>> the rest of the driver state and hardware resources are dismantled.
> 
> In general this is correct fix, but have you checked the rest of remove if it
> has any communication with HW and if that communication relies on IRQ to be on?
> 
> (*yes, this is very unlikely, but please double check as rarely we have some HW
>   that might need that, and in such a case the fix might be different)
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

