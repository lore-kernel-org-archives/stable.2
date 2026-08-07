Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0626279DCC
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114314; cv=none; b=iNUbc9DRsxGJ0Mn/hI5LJMPMbqWIN0qVG0O/DG9e+KGq7ioiIgVAIKEMpsQi3F4QJrcprwoGNuHCVPzGjUQPje3cv0IxLv2Ru1ful1fd4HZmIiVPrxdM6O4KHZLM9RR7GE25JLxo9t4ox2KPusOlNj6jB3bD7e2HOBfSstk63S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114314; c=relaxed/simple;
	bh=Vu1niVkAb/tP7yX7Dw8ld/tDn/peA0OtLVyLggiMe/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rrpum7/gfsFk79lXnhNpsFgtB+POBWDh/3kZKIPuQor0qTJbAg/4R8KZ4Cpvv/SXnRFXAeNP3vXqetduMetczZTgFegNfbxDtbRL9+i/m+VdmLUI8jdOFiUv+BArBrln0bfKQKAxYwxTMcaBKDVzQnvMUHMRYdpREn7KJRNQy5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F/dJHbdB; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F/dJHbdB"
Message-ID: <66bb2d66-63ea-4331-b835-4a559ea47fe3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786114300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HYvtrqXx39XVqSk0LmbQ/GNju/lK5lnK9ZNLx4En+u8=;
	b=F/dJHbdBxsJyrCjAljYcj1pCiCzxjDIy/oTAlxe1lnuJT/GrVGCrAIxaZlueAp2wT67aTG
	c5cASVQOGQOAFwZcizotQMh5WrbWyVI81s5bykLeXjWcVvk0WMWpsezgsZuVnR5zj0hiuP
	lRU5Dq40oTUF9jCCMn8VDHU1+++mmA0=
Date: Fri, 7 Aug 2026 15:51:26 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3 2/2] net: ravb: serialize PTP clock teardown
To: luoxuanqiang <xuanqiang.luo@linux.dev>,
 linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
 niklas.soderlund@ragnatech.se, kuba@kernel.org
Cc: paul@pbarker.dev, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, richardcochran@gmail.com,
 masaru.nagai.vx@renesas.com, sergei.shtylyov@cogentembedded.com,
 luoxuanqiang@kylinos.cn, stable@vger.kernel.org
References: <20260806095126.57803-1-xuanqiang.luo@linux.dev>
 <20260806095126.57803-3-xuanqiang.luo@linux.dev>
 <cdc07462-5997-44f5-8659-5e7862f418ac@linux.dev>
 <dbc8c1a5-e2f3-4e14-864d-ce8f939039e0@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <dbc8c1a5-e2f3-4e14-864d-ce8f939039e0@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 07/08/2026 11:14, luoxuanqiang wrote:
> Hi Vadim,
> 
> 在 2026/8/7 06:34, Vadim Fedorenko 写道:
>> On 06/08/2026 10:51, xuanqiang.luo@linux.dev wrote:
>>> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
>>>
>>> ravb_get_ts_info() can run without RTNL while ravb_ptp_stop() 
>>> unregisters
>>> the PHC. The PTP interrupt handler can race with the same teardown, 
>>> so both
>>> paths may access the clock while it is being freed.
>>>
>>> Protect the clock pointer with priv->lock, clear it before unregistering
>>> the PHC, and unregister the detached clock outside the lock.
>>
>> I think adding spinlock here is a bit of overkill. For
>> ravb_get_ts_info() you can simply extend struct ravb_ptp to store clock
>> index on init and reset it to -1 on ptp stop.
>>
> Thanks! That is a good suggestion.
> 
> I will do this in the next version.
> 
>> For interrupt race I think ravb_ptp_stop() can be split into disable
>> interrupt function (like ravb_ptp_disable()) and actual clock free. In
>> this case ravb_ptp_disable() can be run before synchronize_irq() with
>> ptp_clock_unregister() afterwards in teardown callbacks, like it's
>> already done for ring allocations.
>>
> I see the approach you described. I assume you are referring to the
> handling in ravb_set_ringparam().
> 
> One detail I would like to clarify is which IRQs need to be synchronized.
> When err_mgmt_irqs is set, ravb_multi_interrupt() is registered for dia,
> err_a and mgmt_a, while only dia is stored in ndev->irq. Each handler
> checks ISS and may call ravb_ptp_interrupt().
> 
> Is there a hardware routing guarantee that gPTP interrupts are only
> delivered through dia, making synchronize_irq(ndev->irq) sufficient?
> Otherwise, it seems that the driver needs to retain the err_a and mgmt_a
> IRQ numbers and synchronize all three before unregistering the clock.

I don't have access to the datasheet, so I cannot be sure, but from the 
quick look at the handler, there are 3 types of interrupt-handling
functions, and 3 different interrupt vectors...

But it's still better to ask people who have access to datasheet, and
implement things in correct way rather than throwing spinlocks in the
code.

btw, do you have a HW to reproduce the issue and check the fix?

> 
> The additional users of priv->lock would not be on particularly hot
> paths, but avoiding them still seems preferable if draining the
> interrupts fully closes the lifetime race. I would just like to confirm
> the required IRQ scope first. Tracking and synchronizing all three IRQs
> would also make the change larger, so the interrupt teardown patch may
> no longer be suitable for Cc: stable.
> 
> In any case, thanks for the suggestion.
> 
> Thanks,
> Xuanqiang
> 

