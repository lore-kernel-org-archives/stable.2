Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804BA35F164
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 04:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791434276; cv=none; b=jgpYh6Jpw241mgRPZepi35xp7kiTP9MGjunQyzpsHvXsouwZO4YShX2NJh7j1u1w3SbYOOCuizuf6TsX1//9o3y9IBd4+p8VxFPvwUdnFYURcdndr/O4TanLoiEcSjF5DPjlSSPn3WJlz+joPXb6SNbm9DQJafBwRBxodnNoAx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791434276; c=relaxed/simple;
	bh=weNrrQav3Omgfq0Qboj6ToKOI/kTX3MRt6OBS5VAWRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=kNEaE5oL+/Os0fbhRqEcj99qiPJJz0M2Okw9Xt2mrPKS0XiyQgKA77WNncrGky5DI9ca1rch9adoqKdTMHkDpqhRmxnVT/rsAzGUKo/ZeJjLoFXoPOwVRIz+HF1YBh8bprrdokrZzsDVxeL3dWWQAKk1svlcE1FXyDCLagAbkZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jjT/Y7Su; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jjT/Y7Su"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20261008043751epoutp042f256ad8a04ce3dfae02821a3d3fa826~cc-qKjj3l1302013020epoutp04W
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 04:37:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20261008043751epoutp042f256ad8a04ce3dfae02821a3d3fa826~cc-qKjj3l1302013020epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1791434271;
	bh=CoRXBFa57LuN2z8UOryR16SfCaWjD5KTrh3/Tzeky90=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=jjT/Y7Su7BlLdX7e1El5ztQl7II6k2HID8ISJmeV+krSX1clksHyxwElkpR7oXTo6
	 gzu58gPrg/y9C0hVY5ysFGY1I5ASbsAPW+Rmc0WGDMjuqNxDgbKRolARujiLgXtXWO
	 hUs67Eqyu4RlkksfnItG/2dr4XwAJxIb4KSKy1Z0=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20261008043751epcas5p2ac16c92b0274860fa8bdf6566cd995f0~cc-pwhj5d3214432144epcas5p2V;
	Thu,  8 Oct 2026 04:37:51 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.91]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4j0cg23T9Gz6B9mK; Thu,  8 Oct
	2026 04:37:50 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20261008043749epcas5p304a7d5351b9a8a2b9fa6baa4d2d2eb35~cc-ohn4Bg1330013300epcas5p3U;
	Thu,  8 Oct 2026 04:37:49 +0000 (GMT)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261008043747epsmtip2d3eee15d74435f4ec6dcf6daa8c0708f~cc-meeDs31553615536epsmtip2k;
	Thu,  8 Oct 2026 04:37:47 +0000 (GMT)
Message-ID: <bc43e3f5-ba0c-4f91-b765-ee35021bf089@samsung.com>
Date: Thu, 8 Oct 2026 10:07:46 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: dwc3: gadget: Prevent EP resource conflicts
 during StartTransfer
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jh0801.jung@samsung.com" <jh0801.jung@samsung.com>, "dh10.jung@samsung.com"
	<dh10.jung@samsung.com>, "akash.m5@samsung.com" <akash.m5@samsung.com>,
	"hongpooh.kim@samsung.com" <hongpooh.kim@samsung.com>,
	"eomji.oh@samsung.com" <eomji.oh@samsung.com>, "h10.kim@samsung.com"
	<h10.kim@samsung.com>, "shijie.cai@samsung.com" <shijie.cai@samsung.com>,
	"alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
	"muhammed.ali@samsung.com" <muhammed.ali@samsung.com>,
	"thiagu.r@samsung.com" <thiagu.r@samsung.com>, "pritam.sutar@samsung.com"
	<pritam.sutar@samsung.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <asbJfaj5OIhHBunD@vbox>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261008043749epcas5p304a7d5351b9a8a2b9fa6baa4d2d2eb35
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261007020654epcas5p1d6f8d2d6f5215abcec7d6c6f90b8b8c6
References: <20260306214123.3jnlzd2tmtwggch2@synopsys.com>
	<7f8a7341-3701-4ade-a198-cf86719da931@samsung.com> <arsnMM-GvuXwBKCX@vbox>
	<5d7501ea-4579-44a5-9a7e-91ef1f10b2bb@samsung.com> <asBhDmy-3DymDKQH@vbox>
	<3fdda532-8181-48e9-b58d-cad7289408e7@samsung.com>
	<CGME20261007020654epcas5p1d6f8d2d6f5215abcec7d6c6f90b8b8c6@epcas5p1.samsung.com>
	<asWmW1jmzedIV5SP@vbox> <ff5d6900-374b-44d8-967f-0af16ae53437@samsung.com>
	<98f16da0-5e24-4dd1-8f9f-79a1a5e7656c@samsung.com> <asbJfaj5OIhHBunD@vbox>


On 10/8/2026 5:29 AM, Thinh Nguyen wrote:
> On Wed, Oct 07, 2026, Selvarasu Ganesan wrote:
>> Sorry for the format issue. The updated answers as below,
>>
>> No, the endpoint completion event is not seen after the -ETIMEDOUT error.
>>
>> The proposed fix works well for the __dwc3_gadget_ep_set_halt sequence,
>> where DWC3_EP_END_TRANSFER_PENDING must be set to prevent dwc3_ep_queue
>> from starting a new transfer during a EP transfer timeout.
>>
>> But, this is unnecessary for __dwc3_gadget_ep_disable. Since there's no
>> way to clear the pending flag if the interrupt is missed and no
>> dwc3_ep_queue calls occur until the EP is re-enabled, preserving
>> DWC3_EP_END_TRANSFER_PENDING here provides no benefit.
>>
>> So, the below changes is not necessary in ep disable,
>>
> We still need to keep DWC3_EP_END_TRANSFER_PENDING in ep_disable. That's
> for the normal case where the End Transfer completes after ep_disable
> returns, which is the original issue. If the command never completes,
> the endpoint resource is stuck regardless. Clearing the flag only lead
> to a NO_RESOURCE error later.

Agreed.

>
> As for the dwc3_gadget_ep_queue() race during giveback, keeping
> DWC3_EP_TRANSFER_STARTED isn't right. We should reject the queue when
> the endpoint is disabled. This should be a separate patch:

Agreed.

>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index ee837235630a..eb6666b7bb98 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1084,6 +1084,8 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
>   	reg &= ~DWC3_DALEPENA_EP(dep->number);
>   	dwc3_writel(dwc, DWC3_DALEPENA, reg);
>   
> +	dep->flags &= ~DWC3_EP_ENABLED;
> +
>   	dwc3_remove_requests(dwc, dep, -ESHUTDOWN);
>   
>   	dep->stream_capable = false;
> @@ -1990,7 +1992,8 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
>   {
>   	struct dwc3		*dwc = dep->dwc;
>   
> -	if (!dep->endpoint.desc || !dwc->pullups_connected || !dwc->connected) {
> +	if (!(dep->flags & DWC3_EP_ENABLED) || !dep->endpoint.desc ||
> +	    !dwc->pullups_connected || !dwc->connected) {
>   		dev_dbg(dwc->dev, "%s: can't queue to disabled endpoint\n",
>   				dep->name);
>   		return -ESHUTDOWN;
>
Thanks for suggestion. We will test this patch to confirm no resource 
issue in race condition.

> The End Transfer command not completing is also a separate issue. I
> asked you to check whether the command would eventually complete with
> the additional code, and it appears it doesn't.
  We have confirmed that the completion event is never seen, once the 
timeout occurs for end transfer. It appears the command is indeed 
hanging in the hardware, as you suspected.

>
> Can you provide some more info on your setup:
>   * IP and version
>   * connected speed
>   * endpoint direction (is it always OUT?)
>   * Is there any active transfer
>   * tracepoints
* IP and version : 0xc120:   0x33313130
* connected speed : HS mode
* endpoint direction (is it always OUT?) : Yes its always OUT
* Is there any active transfer : No, There is evidences from the log to 
say there is a active transfer.
* tracepoints: There is no dwc3 traces for this issue as of now due to 
its low reproduction rate in the customer's setup.


Thanks,
Selva
> Thanks,
> Thinh
