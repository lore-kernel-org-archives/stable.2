Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945533BB9FE
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791381469; cv=none; b=LpEKZIgj8dN2qYCGqKnHJXgAKNS6nES/LNj1+w9Hv7sO/UryeF4NWsnaWPz0sNywUzlWY3j2JYwhBtyijgSCTlctJPBEnoI6363QxRnHCCmPLSEkoYObXSI6GE/gUlXVhCqxxXQz7dr/2nvkYshjHnTc2olNgo0LMvUB/YMxIiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791381469; c=relaxed/simple;
	bh=NBIhSgWSoUAwIPurglDickEA9DHZEmDKgc0/ANXPiuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Dj0RXyKidyHr5uO82e61loVHuo3/jM2TChDKMGwgwA10iKPPcZqLJI3XYivZV50cjGfo/g8ki0jqEANjrwvB1RmvMa/hfS+FqdjQ8X03e+5LeiPIemt3ueApbekwYpMz4G71sPrmoZ70IMdMv9FuRdW+nL0lOZDbQcvYWIoE/Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=iyDxmXmi; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="iyDxmXmi"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20261007135737epoutp02d3520ac7f1095d40c162a0506f931b92~cQ-G8pDFJ2483224832epoutp02F
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 13:57:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20261007135737epoutp02d3520ac7f1095d40c162a0506f931b92~cQ-G8pDFJ2483224832epoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1791381457;
	bh=Isi9n5im6N5wqAo19+CkrzUw37JuEy1/evswgkCZxsA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=iyDxmXmi7UsQu+j8l2Jhv3OWmAkMxj8qL98yvnHpvO3Xho4ECFqwgZqJZqAm1DohL
	 +42PiB5b2kVQkM5cl/7a+QL/Z0vRhH/kTLX1hANDdtV6TEe3ICfMsGTNqClYGwx8FB
	 6fkf8iMDlXuiIasTJm8FhIWWpnRKDTPb7mNNTG5U=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20261007135736epcas5p31a2323ae3c1de9dd58dce1023111c851~cQ-F_dec62561025610epcas5p3o;
	Wed,  7 Oct 2026 13:57:36 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.89]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4j0F7M487Pz3hhT4; Wed,  7 Oct
	2026 13:57:35 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20261007135735epcas5p392f3807302c26ad1a933f3f052f62535~cQ-E2phOm0439404394epcas5p30;
	Wed,  7 Oct 2026 13:57:35 +0000 (GMT)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261007135732epsmtip2f852ab14ae28b5f89fe3f69d014f0082~cQ-C0GG-00907909079epsmtip2Y;
	Wed,  7 Oct 2026 13:57:32 +0000 (GMT)
Message-ID: <ff5d6900-374b-44d8-967f-0af16ae53437@samsung.com>
Date: Wed, 7 Oct 2026 19:27:25 +0530
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
In-Reply-To: <asWmW1jmzedIV5SP@vbox>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261007135735epcas5p392f3807302c26ad1a933f3f052f62535
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261007020654epcas5p1d6f8d2d6f5215abcec7d6c6f90b8b8c6
References: <20260227121236.963-1-selvarasu.g@samsung.com>
	<20260228002711.e442cuxwld4s2f66@synopsys.com>
	<20260303003955.5lbb6xdrg7tp3zzi@synopsys.com>
	<08273adc-d8cf-48b3-ba45-853d363af0e6@samsung.com>
	<20260306214123.3jnlzd2tmtwggch2@synopsys.com>
	<7f8a7341-3701-4ade-a198-cf86719da931@samsung.com> <arsnMM-GvuXwBKCX@vbox>
	<5d7501ea-4579-44a5-9a7e-91ef1f10b2bb@samsung.com> <asBhDmy-3DymDKQH@vbox>
	<3fdda532-8181-48e9-b58d-cad7289408e7@samsung.com>
	<CGME20261007020654epcas5p1d6f8d2d6f5215abcec7d6c6f90b8b8c6@epcas5p1.samsung.com>
	<asWmW1jmzedIV5SP@vbox>


On 10/7/2026 7:36 AM, Thinh Nguyen wrote:
> On Tue, Oct 06, 2026, Selvarasu Ganesan wrote:
>>>    	/* Clear out the ep descriptors for non-ep0 */
>>> @@ -1792,9 +1815,9 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
>>>    
>>>    	dep->resource_index = 0;
>>>    
>>> -	if (!interrupt)
>>> +	if (!interrupt || ret)
>>
>> Hi Thinh,
>>
>> Thanks for your code changes. The given code changes look good to me and
>> are working as expected.
>>
>> There is one more concern about an uncovered endpoint resource failure
>> in some corner cases where END TRANSFER timeout is observed (ret = -110).
>>
>> The sequence is explained below,
>>
>> Step 1:
>>    __dwc3_gadget_ep_set_halt(dep, value=0)
>>     ->dwc3_stop_active_transfer(dep, true, true)
> Looks like you still do ForceRM=true. Can you apply this patch:
>
>    b58e6200450d ("usb: dwc3: clear forceRM when issuing EndTransfer")

We have this fix in our dwc3 driver code. but still observing EP end 
transfer timeout.


>
>>       ->END(e.g, ep2out, resource_index=7) issued, but timeout occurs
>>        -> resource_index cleared to 0
>>     ->dwc3_send_clear_stall_ep_cmd(dep)
>>       -> failed to clear STALL on ep2out
>>
>>
>> Step 2:
>> __dwc3_gadget_ep_set_halt(dep, value=0) ->Re triggered clear stall for
>> same EP
>>    -> dwc3_stop_active_transfer(dep, true, true)
>>      -> END(ep2out, resource_index=0) issued (wrong resource!)
>>        -> Command succeeds, DWC3_EP_TRANSFER_STARTED cleared in
>> completion handler
>>
>> Step 3:
>> usb_ep_queue()
>>    -> dwc3_gadget_ep_queue()
>>      -> __dwc3_gadget_kick_transfer()
>>        -> starting = !(dep->flags & DWC3_EP_TRANSFER_STARTED)  -> starting=0
>>          -> Issues STARTTRANSFER (because DWC3_EP_TRANSFER_STARTED is not
>> set)
>>            -> Hardware rejects with NO_RESOURCE (resource 7 still held)
>>
>>
>> Could you please give your suggestions on this issue case?
>>
> Thanks for testing. Can you check whether the End Transfer command ever
> completes with the endpoint completion event after the -ETIMEDOUT error?


No, the endpoint completion event is not seen after the -ETIMEDOUT error.

The proposed fix works well for the __dwc3_gadget_ep_set_halt sequence, 
where DWC3_EP_END_TRANSFER_PENDING must be set to prevent dwc3_ep_queue 
from starting a new transfer during a EP transfer timeout.

But, this is unnecessary for __dwc3_gadget_ep_disable. Since there's no 
way to clear the pending flag if the interrupt is missed and no 
dwc3_ep_queue calls occur until the EP is re-enabled, preserving 
DWC3_EP_END_TRANSFER_PENDING here provides no benefit.
So, the below changes is not necessary in ep disable,

@@ -1096,6 +1110,15 @@ static int __dwc3_gadget_ep_disable(struct 
dwc3_ep *dep)  	 */
  	if (dep->flags & DWC3_EP_DELAY_STOP)
  		mask |= (DWC3_EP_DELAY_STOP | DWC3_EP_TRANSFER_STARTED);
+ + /* + * The End Transfer command is still in progress. Do not clear 
the + * flags, so that the ep is only rearmed once the command 
completes. + */ + if (dep->flags & DWC3_EP_END_TRANSFER_PENDING) + mask 
|= (DWC3_EP_END_TRANSFER_PENDING | + DWC3_EP_TRANSFER_STARTED); +

Instead, keep our suggestion changes that prevent the manipulation of 
dep->flags due to the race condition between dwc3_gadget_ep_disable() 
and dwc3_gadget_ep_queue(), since this race observing in long run rndis 
test.

+ + /* + * When dwc3_gadget_ep_disable() calls dwc3_gadget_giveback(), + 
* the dwc->lock is temporarily released. If dwc3_gadget_ep_queue() + * 
runs in that window it may set the DWC3_EP_TRANSFER_STARTED flag as + * 
part of dwc3_send_gadget_ep_cmd. The original code cleared the flag + * 
unconditionally in the mask operation, which could overwrite the + * 
concurrent modification. + * + * As a workaround for the interrupt 
context constraint where we cannot + * wait for endpoint flushing, 
preserve the DWC3_EP_TRANSFER_STARTED + * flag if it is set, avoiding 
resource conflicts until the framework + * is fixed to properly 
synchronize endpoint lifecycle management. + */ + if (dep->flags & 
DWC3_EP_TRANSFER_STARTED) + mask |= DWC3_EP_TRANSFER_STARTED; +


Thanks,
Selva
> Try with the below.
>
> Thanks,
> Thinh
>
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 1f973e546219..bac0328423cd 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1819,7 +1819,11 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
>   
>   	dep->resource_index = 0;
>   
> -	if (!interrupt || ret)
> +	if (!interrupt || (ret && ret != -ETIMEDOUT))
>   		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
>   	else
>   		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
> @@ -3895,6 +3899,8 @@ static void dwc3_gadget_endpoint_command_complete(struct dwc3_ep *dep,
>   	if (dep->stream_capable)
>   		dep->flags |= DWC3_EP_IGNORE_NEXT_NOSTREAM;
>   
> +	dep->flags &= ~DWC3_EP_DELAY_STOP;
>   	dep->flags &= ~DWC3_EP_END_TRANSFER_PENDING;
>   	dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
>   	dwc3_gadget_ep_cleanup_cancelled_requests(dep);
