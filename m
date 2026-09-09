Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC0B566C73;
	Wed,  9 Sep 2026 14:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788964566; cv=none; b=MrSQJ5k5PA68ge1ZsAS/q5cmuKdOkrAk61mS8dXKzFDXM7QhChJEmLiD9hgkQuVad6xj3mx8Hol+Y6aZLwqyiywXDrxUnxNht1bjdrWzZADAvMz9qrQLlwRcoBmMCB1bhCe0t/iQEhfMKFahh2UBuEsAV0mSnsa1VZlPXklY4pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788964566; c=relaxed/simple;
	bh=KQsUz0Q48iI4QqBuwniL5ZKJ1EiPmWHH/qogE948XLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eE+OqHToBTFr9KqvYiRirQAKQItCNq/bdgsIYepT4OQwwu9wckS8q2qTDk9I/Bp554uoXhYcA1xpO2VMckPf7tF2ZtNI6pZTeztlZGdLY7pPRuc9WDYylqpuhFnfYjdFj9KfwSbAc73gxeOKToyn/B4zCgy2hsSOYf4uiJ3wmRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nawkzZRp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nawkzZRp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C4C1F00A3A;
	Wed,  9 Sep 2026 14:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788964565;
	bh=8SbYVSCe/btcutH19VdtAjOgi/PS9+UH2+WikgQoAl0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nawkzZRpFu1Yhjt7CKjvrpZZ3OvlIMzFjKnIVfkfJ1E4wU81COokXtmvrtCDZ8lnq
	 v5ULK+YrQnHiqgwxnnb9mBHFEt+McOnua2XlKIDpCr0kCxz75dsDzjNH70eI8ZtV4U
	 ErmO37HRQzuSrEaYfH8I/Aq0Z+5enqN3UWpOC+zV26DnqkcPtkFMirLuff2LeObKap
	 PyCCahkMrJo7gB9hd55PtDDispBLQ6sgr1RpHrfBvrAuxDh1r3vLEJhx+c7Ba3CBlw
	 4QbUXvsZR+3MQjDi3+8UEyd4NCIHPIID78RKRYCR4GuMLJ+KLMd9NHrIWDrVB4gLfE
	 ajCLMcgYPNnVg==
Message-ID: <f5636589-1d1b-4b64-9e82-cf4b249ebef8@kernel.org>
Date: Wed, 9 Sep 2026 09:36:03 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCHv4 3/4] EDAC/altera: Fix code leak on dci allocation
 failure
Content-Language: en-US
To: Rounak Das <rounakdas2025@gmail.com>
Cc: bp@alien8.de, tony.luck@intel.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260909131253.2158486-1-dinguyen@kernel.org>
 <20260909131253.2158486-4-dinguyen@kernel.org>
 <CAPYTKoOmFpCzw5EydwxRdq3LhKP6p+osY=gxvy+KOZWQsXu-qg@mail.gmail.com>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <CAPYTKoOmFpCzw5EydwxRdq3LhKP6p+osY=gxvy+KOZWQsXu-qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/9/26 09:33, Rounak Das wrote:
> Hi Dinh,
> 
>>          if (!devres_open_group(device->edac->dev, altr_portb_setup, GFP_KERNEL))
>> +               edac_device_free_ctl_info(dci);
>>                  return -ENOMEM;
>> +       }
> 
> This file will not compile since the braces are wrong, there is no starting {.
> 
> Also, another thing that I noticed is that 2/4's Fixes tag is missing
> its closing
> quote after "probe()".

Argh..Thank you for catching that!

> 
> I will rebase and resend my of_node_put fix once this series lands.
> 
Dinh
