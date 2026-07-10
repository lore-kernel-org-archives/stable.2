Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADF4233956;
	Fri, 10 Jul 2026 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783695811; cv=none; b=UKN3f8BIA6bgoelaiOZsWe2XufuaML42g4wBPmbfB8EvvQ+AN7wK9Tmn0VaC8zYBkpzohjVsV/LoQ+rG1qY+u5cXtIZ2WBO9Smxj3+mlJtePd16vKPqJSLJY7XE/vvtDsawU+UZwIhqL711A+up9kxvOK+KuOzBMX+TsfmXnfn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783695811; c=relaxed/simple;
	bh=l8l11gd2o2m2tmWzraimkJfQCtvVbCoyfbSqkQShl6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ppmbZYG62BOPuY00UKmBzG6UaCFceYI43ZzZB6crjsnbA/iq8iG2xCUfOkyyLOT2fDvsB6Q6v0VAgADc8df8UBWlqJAds0uLD8pB8LcTfywIda9hgmqO6vqah2npr67XSQ8Regte452YU3MCK89Zkd8SQin0ZiGwC98Iw0gYlkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0MUBmg9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0MUBmg9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7321F000E9;
	Fri, 10 Jul 2026 15:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783695809;
	bh=kPG8T3HOosCZc5JiG8p/fXxbdHlmDjHJk7Z9rApOlkE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=I0MUBmg9RlOcTSxIzPMcYmesLFB0ien3k8/cG7B7GYG+c0+l3U4K8NQVdpqhAdgC3
	 /3eXkL98y9RUsl3owrkmpM0P0ssNwqTFEAn+gg2FqeN9XR4DyP/UYuBrjYlHXHOXD8
	 yMHg5ZfrXfhRoHmFUCR5PiEyTbetjWvgB8x6czzpa2scuU/dPWJZcmc8g1fVxvqKAo
	 EuZ//Rx9FyAE0tMA7ugXpC8aMGgm3uOHghoUOJaWfd0frNptPUeL7YD402T6MNhzqy
	 /EEruckK+VnIAPFwgZzjMO0Il0lLJD2W1gglZMJrxWJLstQ934Ugw81Z63+JtIyRba
	 yCHNvgei8XQRA==
Message-ID: <f693b112-3473-424d-be33-d18310825004@kernel.org>
Date: Fri, 10 Jul 2026 10:03:28 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EDAC/altera: Use parent device for devres in
 altr_portb_setup()
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, dbgh9129@gmail.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260617164303.585555-1-dinguyen@kernel.org>
 <20260617221834.GAajMdOocCPq39b-s0@fat_crate.local>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20260617221834.GAajMdOocCPq39b-s0@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/17/26 17:18, Borislav Petkov wrote:
> On Wed, Jun 17, 2026 at 11:43:03AM -0500, Dinh Nguyen wrote:
>> Anchor the devres group and the devm-managed IRQ requests in
>> altr_portb_setup() to the actual parent device (device->edac->dev)
>> instead of the embedded struct device inside the copied per-port
>> altr_edac_device_dev. This keeps devres_open_group(),
>> devm_request_irq(), devres_remove_group() and devres_release_group()
>> all referring to the same long-lived device so the group and the
>> resources allocated inside it are torn down together.
>>
>> Fixes: 911049845d70 ("EDAC, altera: Add Arria10 SD-MMC EDAC support")
>> Cc: stable@vger.kernel.org
>> Closes: https://sashiko.dev/#/patchset/20260503212558.2811480-1-dbgh9129%40gmail.com
>> Assisted-by: Claude:claude-opus-4-7
>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>> ---
>>   drivers/edac/altera_edac.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> How urgent is this? Can it wait until the merge window is over?
> 

Can you please pick this up for v7.2?

Thanks,

Dinh
