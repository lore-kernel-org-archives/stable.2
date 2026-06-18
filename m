Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AF738F92D;
	Thu, 18 Jun 2026 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771266; cv=none; b=CMJqFeG7nH+0iCpiPSWxKUj7P9zXdI0bfkN70qti8Mi7jvuS7MP41lCTz2Hs8YvPwd/5VJJqvFDx7NOYZms/ELNDqjJq2WtmFICkxSbYNyCjx32nmR7a+KABnt0szxvQyJQo9sMiT5Aq0w8XXMt35TetO33Tr+3wjex+N3RDCv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771266; c=relaxed/simple;
	bh=aS0apVPUMbKYFtz5HWk1NqXptXEWB6A9d3RlUBNvAn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FXNQyIpaA9rin2/xVnJAoP0MhlckmwhA4oxoov6ZrkcQh+GlQ/BBifAH7vw2ok3+10PuJOKSnNltltL1+T0805eRw5w96bualHKfmhmdS1fgZShrB2kJghVBwIKctT0R6Y6Dx9loAN/y508WcylPDxPbC8DvMU3WGrIAA4hJLEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGItt6b3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGItt6b3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF91A1F00A3A;
	Thu, 18 Jun 2026 08:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781771265;
	bh=df2P3LLdIKFcPNMZ6yyraPQDNBfXCa18dbEbECBPaP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dGItt6b3EWpzDA0Z3vvErqdIdZgYPl7taI1f4vdMj+hQDkadCmsGWM7+olyROffTR
	 OmsRCdibeFfVgjdeUE28fQhWAugUcSWW54THgMDplI5f/P7/T5L8ibpzqMj/llblYS
	 sObi1DS1lb5fo+WNjuaxjEpV/6aNqEv1ZvSAjU9WAlQSBVEgnWf1H82clrBuf5J4Wi
	 kjJqIaHUvlJfWzRw3TOwxsdNltfnB19pjEdqo54F4iNTzvjqB2Uz6qDsUb5o0AXWYc
	 YLBlDErbqMiSYmIySBhj0iilkucIgKv73yM7URei2okB20k1f5XF3oQFE84awPPIU1
	 vqc2PJC8RFsWg==
Message-ID: <3a2e32b9-d725-4bd6-bdb7-0081962cd3fc@kernel.org>
Date: Thu, 18 Jun 2026 03:27:43 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] EDAC/altera: Use parent device for devres in
 altr_portb_setup()
To: Borislav Petkov <bp@alien8.de>
Cc: tony.luck@intel.com, dbgh9129@gmail.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260617164303.585555-1-dinguyen@kernel.org>
 <20260617221834.GAajMdOocCPq39b-s0@fat_crate.local>
Content-Language: en-US
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20260617221834.GAajMdOocCPq39b-s0@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/17/26 07:18, Borislav Petkov wrote:
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

Not urgent at all. It can wait until v7.2-rc1.

Thanks,
Dinh
