Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F5F30216D
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 15:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301995; cv=none; b=MI6smMU8vfZWKeASWHrGcDWSrJkYYBbcTf988D7II7tUonrq66J3i2HS9sqlMeRn1Szgqaek+lpIiDn6wxVzDaqwlk23r7IfvRA0AYT8RebFn2DEUGcSJD2y9qIHGFTNa4wz3AxpFNuHAa8hy8iUbylDqdAwkCJhsJNNn0AOKH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301995; c=relaxed/simple;
	bh=TKXL1KKlZy/vs7WUB3d0NOMAqKrX5d28c3nPaNKQa5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=EqgiCktZv4jdDkGGEjlb7NNDsToeDxvSIJXMI7olfWyvZ+wNlfXQW3zKOHMeG8K7KFiuharDZ80t9oTIm7MukzDqEFVV2+bdyt/ZOmPer5PU8CuHp35mjxidi+i5IPywm4bj6ESsScoBtknkzvARyJ9URBfabCtuEpA9IQj/Gbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=sjeuFv0E; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="sjeuFv0E"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20261006155309epoutp03b17fbadb1e480c1ec4634b0502f50086~b_6tG38Bf0392403924epoutp03M
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 15:53:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20261006155309epoutp03b17fbadb1e480c1ec4634b0502f50086~b_6tG38Bf0392403924epoutp03M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1791301989;
	bh=cWpwiQKFt9T4w1nz9IlVhwVPFH2caGI6wA8qdmucH+g=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=sjeuFv0Eobvtv2EdI6CKggde42kuMjwkNJpO6ZZA4vNWEXqgEOuvNFOAIBBNDJcx/
	 9y8pG4oNhdroX7RNjyG6otWYhkkj/XCKXpM0iRhd2hK6LfjLxOAcvWkMrLgIHUaVj0
	 Slg9p/BbJOZaB+mw63teFnlS5EO7d+lGcVhikOo8=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20261006155309epcas5p249b6bcbec225be6c94f20f897f198711~b_6shQpUM1581115811epcas5p2k;
	Tue,  6 Oct 2026 15:53:09 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.88]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4hzgl83V4hz6B9m4; Tue,  6 Oct
	2026 15:53:08 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20261006155308epcas5p4ad8cd2f46e281b6ca01a8b3b67f74674~b_6rb5L5s1238812388epcas5p4X;
	Tue,  6 Oct 2026 15:53:08 +0000 (GMT)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261006155305epsmtip1e3cea5da13c53133e91e468981266b82~b_6pYziFH0581905819epsmtip1M;
	Tue,  6 Oct 2026 15:53:05 +0000 (GMT)
Message-ID: <3fdda532-8181-48e9-b58d-cad7289408e7@samsung.com>
Date: Tue, 6 Oct 2026 21:22:55 +0530
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
In-Reply-To: <asBhDmy-3DymDKQH@vbox>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261006155308epcas5p4ad8cd2f46e281b6ca01a8b3b67f74674
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260227121338epcas5p4baebb406db37f07223545b2f85751bf2
References: <CGME20260227121338epcas5p4baebb406db37f07223545b2f85751bf2@epcas5p4.samsung.com>
	<20260227121236.963-1-selvarasu.g@samsung.com>
	<20260228002711.e442cuxwld4s2f66@synopsys.com>
	<20260303003955.5lbb6xdrg7tp3zzi@synopsys.com>
	<08273adc-d8cf-48b3-ba45-853d363af0e6@samsung.com>
	<20260306214123.3jnlzd2tmtwggch2@synopsys.com>
	<7f8a7341-3701-4ade-a198-cf86719da931@samsung.com> <arsnMM-GvuXwBKCX@vbox>
	<5d7501ea-4579-44a5-9a7e-91ef1f10b2bb@samsung.com> <asBhDmy-3DymDKQH@vbox>


On 10/3/2026 7:29 AM, Thinh Nguyen wrote:
> On Tue, Sep 29, 2026, Selvarasu Ganesan wrote:
>> On 9/29/2026 8:38 AM, Thinh Nguyen wrote:
>>> On Thu, Sep 24, 2026, Selvarasu Ganesan wrote:
>>>> HI Thinh,
>>>>
>>>> Sorry for the delayed response. We're seeing this issue a lot in Exynos
>>>> platform, so we want to get it fixed.
>>>>
>>>> Thanks for the explanation about UASP in last comment.
>>>>
>>>> We agree that for UASP, the new StartTransfer sent in ep_enable() is
>>>> what makes the controller send ERDY for the host's first PRIME. The old
>>>> patch skipped that StartTransfer that was wrong. If it is skipped and no
>>>> request is queued right away, the controller never sends ERDY for the
>>>> first PRIME and the UAS device possible hangs as you mentioned.
>>>>
>>>> The new patch is simpler, we won't skip it and just trigger it once the
>>>> inflight end transfer is done.
>>>>
>>>> Please see the proposed sequence,
>>>>
>>>>      1. usb_ep_disable() --> EndTransfer deferred due to pending control
>>>> transfer data/status stages (DWC3_EP_DELAY_STOP), old transfer still
>>>> active in HW.
>>>>      2. usb_ep_enable() on the same endpoint --> instead of issuing the
>>>> new StartTransfer, set DWC3_EP_PENDING_START_TRANSFER (New flag) as below,
>>>>
>>>>      /* __dwc3_gadget_ep_enable() */
>>>>      if (dep->flags & (DWC3_EP_DELAY_STOP |
>>>>                        DWC3_EP_END_TRANSFER_PENDING |
>>>>                        DWC3_EP_TRANSFER_STARTED))
>>>>          dep->flags |= DWC3_EP_PENDING_START_TRANSFER;
>>>>      else
>>>>          ret = dwc3_gadget_ep_start_noop_transfer(dep);   /* unchanged path */
>>>>
>>>>      3. Control request finishes --> next SETUP --> existing delayed stop
>>>> retry in dwc3_ep0_out_start() sends the EndTransfer for all delayed stop
>>>> endpoints.
>>>>      4. EndTransfer completion and trigger a previously skipped
>>>> StartTransfer in ep_enable by checking DWC3_EP_PENDING_START_TRANSFER.
>>>>
>>>>      /* dwc3_gadget_endpoint_command_complete() */
>>>>      if (dep->flags & DWC3_EP_PENDING_START_TRANSFER) {
>>>>          dep->flags &= ~DWC3_EP_PENDING_START_TRANSFER;
>>>>          dwc3_gadget_ep_start_noop_transfer(dep);
>>>>      }
>>>>
>>>> So the endpoint gets the same start/stop sequence you described, only
>>>> sent later, it goes out as soon as the EndTransfer finishes. So this is
>>>> high possible of happens before the host's first PRIME arrives. ERDY is
>>>> still sent, no UAS regression.
>>>>
>>>> The below testing log is for the reference. You can see the timestamp
>>>> where pending start transfer triggered.
>>>>
>>>> [ 3273.597476]  Entry __dwc3_gadget_ep_disable
>>>> [ 3273.597481]  dwc3_remove_requests ep1out skip stop transfer due to
>>>> DWC3_EP_DELAY_STOP
>>>> [ 3273.597510]  Entry __dwc3_gadget_ep_enable 1045 dep->name =ep1out
>>>> dep->flags =e009
>>>> [ 3273.597590]  dwc3_gadget_endpoint_command_complete 3857 dep->name
>>>> =ep1out dep->flags =4009 --> Triggered skipped Start transfer when
>>>> endpoint command completion is done.
>>>>
>>> Hi Selvarasu,
>>>
>>> I just wanted to point out that dwc3_gadget_ep_start_noop_transfer()
>>> should only be needed for stream endpoints. I'll take a closer look at
>>> the rest of the changes later this week.
>> Hi Thinh,
>>
>> Thanks for you feedback.
>>
>> Agreed, The dwc3_gadget_ep_start_noop_transfer() should only be needed
>> for stream endpoints.
>>
> Hi,
>
> Can you try the below instead.
>
> Thanks,
> Thinh
>
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index 608daeb7ef10..093627a6a409 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -770,6 +770,7 @@ struct dwc3_ep {
>   #define DWC3_EP_TXFIFO_RESIZED		BIT(12)
>   #define DWC3_EP_DELAY_STOP             BIT(13)
>   #define DWC3_EP_RESOURCE_ALLOCATED	BIT(14)
> +#define DWC3_EP_PENDING_NOOP_START	BIT(15)
>   
>   	/* This last one is specific to EP0 */
>   #define DWC3_EP0_DIR_IN			BIT(31)
> @@ -1676,7 +1677,8 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
>   int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned int cmd,
>   		u32 param);
>   void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc);
> -void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status);
> +void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status,
> +			  bool interrupt);
>   #else
>   static inline int dwc3_gadget_init(struct dwc3 *dwc)
>   { return 0; }
> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
> index 310b5ffb236a..ff80c3a0c983 100644
> --- a/drivers/usb/dwc3/ep0.c
> +++ b/drivers/usb/dwc3/ep0.c
> @@ -306,7 +306,7 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
>   		if (dwc->connected)
>   			dwc3_stop_active_transfer(dwc3_ep, false, true);
>   		else
> -			dwc3_remove_requests(dwc, dwc3_ep, -ESHUTDOWN);
> +			dwc3_remove_requests(dwc, dwc3_ep, -ESHUTDOWN, false);
>   	}
>   }
>   
> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index f245e66cd13d..4381a9f60f60 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -906,6 +906,54 @@ static int dwc3_gadget_resize_tx_fifos(struct dwc3_ep *dep)
>   	return 0;
>   }
>   
> +static int dwc3_gadget_ep_start_noop_transfer(struct dwc3_ep *dep)
> +{
> +	struct dwc3_gadget_ep_cmd_params params;
> +	struct dwc3		*dwc = dep->dwc;
> +	struct dwc3_trb		*trb;
> +	dma_addr_t		trb_dma;
> +	u32			cmd;
> +	int			ret;
> +
> +	memset(&params, 0, sizeof(params));
> +	trb = &dep->trb_pool[0];
> +	trb_dma = dwc3_trb_dma_offset(dep, trb);
> +
> +	params.param0 = upper_32_bits(trb_dma);
> +	params.param1 = lower_32_bits(trb_dma);
> +
> +	cmd = DWC3_DEPCMD_STARTTRANSFER;
> +
> +	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * For streams, at start, there maybe a race where the host primes the
> +	 * endpoint before the function driver queues a request to initiate a
> +	 * stream. In that case, the controller will not see the prime to
> +	 * generate the ERDY and start stream. To workaround this, issue a
> +	 * no-op TRB as normal, but end it immediately. As a result, when the
> +	 * function driver queues the request, the next START_TRANSFER command
> +	 * will cause the controller to generate an ERDY to initiate the
> +	 * stream.
> +	 */
> +	dwc3_stop_active_transfer(dep, false, true);
> +
> +	/*
> +	 * All stream eps will reinitiate stream on NoStream rejection.
> +	 *
> +	 * However, if the controller is capable of TXF_FLUSH_BYPASS, then IN
> +	 * direction endpoints will automatically restart the stream without
> +	 * the driver initiation.
> +	 */
> +	if (!dep->direction ||
> +	    !(dwc->hwparams.hwparams9 & DWC3_GHWPARAMS9_DEV_TXF_FLUSH_BYPASS))
> +		dep->flags |= DWC3_EP_FORCE_RESTART_STREAM;
> +
> +	return 0;
> +}
> +
>   /**
>    * __dwc3_gadget_ep_enable - initializes a hw endpoint
>    * @dep: endpoint to be initialized
> @@ -971,54 +1019,15 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
>   	 * Issue StartTransfer here with no-op TRB so we can always rely on No
>   	 * Response Update Transfer command.
>   	 */
> -	if (usb_endpoint_xfer_bulk(desc) ||
> -			usb_endpoint_xfer_int(desc)) {
> -		struct dwc3_gadget_ep_cmd_params params;
> -		struct dwc3_trb	*trb;
> -		dma_addr_t trb_dma;
> -		u32 cmd;
> -
> -		memset(&params, 0, sizeof(params));
> -		trb = &dep->trb_pool[0];
> -		trb_dma = dwc3_trb_dma_offset(dep, trb);
> -
> -		params.param0 = upper_32_bits(trb_dma);
> -		params.param1 = lower_32_bits(trb_dma);
> -
> -		cmd = DWC3_DEPCMD_STARTTRANSFER;
> -
> -		ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
> -		if (ret < 0)
> -			return ret;
> -
> -		if (dep->stream_capable) {
> -			/*
> -			 * For streams, at start, there maybe a race where the
> -			 * host primes the endpoint before the function driver
> -			 * queues a request to initiate a stream. In that case,
> -			 * the controller will not see the prime to generate the
> -			 * ERDY and start stream. To workaround this, issue a
> -			 * no-op TRB as normal, but end it immediately. As a
> -			 * result, when the function driver queues the request,
> -			 * the next START_TRANSFER command will cause the
> -			 * controller to generate an ERDY to initiate the
> -			 * stream.
> -			 */
> -			dwc3_stop_active_transfer(dep, false, true);
> -
> -			/*
> -			 * All stream eps will reinitiate stream on NoStream
> -			 * rejection.
> -			 *
> -			 * However, if the controller is capable of
> -			 * TXF_FLUSH_BYPASS, then IN direction endpoints will
> -			 * automatically restart the stream without the driver
> -			 * initiation.
> -			 */
> -			if (!dep->direction ||
> -			    !(dwc->hwparams.hwparams9 &
> -			      DWC3_GHWPARAMS9_DEV_TXF_FLUSH_BYPASS))
> -				dep->flags |= DWC3_EP_FORCE_RESTART_STREAM;
> +	if (dep->stream_capable) {
> +		/* Defer if a previous transfer is still being retired */
> +		if (dep->flags & (DWC3_EP_END_TRANSFER_PENDING |
> +				  DWC3_EP_DELAY_STOP)) {
> +			dep->flags |= DWC3_EP_PENDING_NOOP_START;
> +		} else {
> +			ret = dwc3_gadget_ep_start_noop_transfer(dep);
> +			if (ret < 0)
> +				return ret;
>   		}
>   	}
>   
> @@ -1028,16 +1037,21 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
>   	return 0;
>   }
>   
> -void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status)
> +void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status,
> +			  bool interrupt)
>   {
>   	struct dwc3_request		*req;
>   
> -	dwc3_stop_active_transfer(dep, false, false);
> +	dwc3_stop_active_transfer(dep, false, interrupt);
>   
>   	/* If endxfer is delayed, avoid unmapping requests */
>   	if (dep->flags & DWC3_EP_DELAY_STOP)
>   		return;
>   
> +	/* Give the controller time to stop accessing the request buffers */
> +	if (dep->flags & DWC3_EP_END_TRANSFER_PENDING)
> +		mdelay(1);
> +
>   	/* - giveback all requests to gadget driver */
>   	while (!list_empty(&dep->started_list)) {
>   		req = next_request(&dep->started_list);
> @@ -1084,7 +1098,7 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
>   	reg &= ~DWC3_DALEPENA_EP(dep->number);
>   	dwc3_writel(dwc, DWC3_DALEPENA, reg);
>   
> -	dwc3_remove_requests(dwc, dep, -ESHUTDOWN);
> +	dwc3_remove_requests(dwc, dep, -ESHUTDOWN, true);
>   
>   	dep->stream_capable = false;
>   	dep->type = 0;
> @@ -1096,6 +1110,15 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
>   	 */
>   	if (dep->flags & DWC3_EP_DELAY_STOP)
>   		mask |= (DWC3_EP_DELAY_STOP | DWC3_EP_TRANSFER_STARTED);
> +
> +	/*
> +	 * The End Transfer command is still in progress.  Do not clear the
> +	 * flags, so that the ep is only rearmed once the command completes.
> +	 */
> +	if (dep->flags & DWC3_EP_END_TRANSFER_PENDING)
> +		mask |= (DWC3_EP_END_TRANSFER_PENDING |
> +			 DWC3_EP_TRANSFER_STARTED);
> +
>   	dep->flags &= mask;
>   
>   	/* Clear out the ep descriptors for non-ep0 */
> @@ -1792,9 +1815,9 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
>   
>   	dep->resource_index = 0;
>   
> -	if (!interrupt)
> +	if (!interrupt || ret)


Hi Thinh,

Thanks for your code changes. The given code changes look good to me and 
are working as expected.

There is one more concern about an uncovered endpoint resource failure 
in some corner cases where END TRANSFER timeout is observed (ret = -110).

The sequence is explained below,

Step 1:
  __dwc3_gadget_ep_set_halt(dep, value=0)
   ->dwc3_stop_active_transfer(dep, true, true)
     ->END(e.g, ep2out, resource_index=7) issued, but timeout occurs
      -> resource_index cleared to 0
   ->dwc3_send_clear_stall_ep_cmd(dep)
     -> failed to clear STALL on ep2out


Step 2:
__dwc3_gadget_ep_set_halt(dep, value=0) ->Re triggered clear stall for 
same EP
  -> dwc3_stop_active_transfer(dep, true, true)
    -> END(ep2out, resource_index=0) issued (wrong resource!)
      -> Command succeeds, DWC3_EP_TRANSFER_STARTED cleared in 
completion handler

Step 3:
usb_ep_queue()
  -> dwc3_gadget_ep_queue()
    -> __dwc3_gadget_kick_transfer()
      -> starting = !(dep->flags & DWC3_EP_TRANSFER_STARTED)  -> starting=0
        -> Issues STARTTRANSFER (because DWC3_EP_TRANSFER_STARTED is not 
set)
          -> Hardware rejects with NO_RESOURCE (resource 7 still held)


Could you please give your suggestions on this issue case?

Thanks,

Selva

>   		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
> -	else if (!ret)
> +	else
>   		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
>   
>   	dep->flags &= ~DWC3_EP_DELAY_STOP;
> @@ -2523,7 +2546,7 @@ static void dwc3_stop_active_transfers(struct dwc3 *dwc)
>   		if (!dep)
>   			continue;
>   
> -		dwc3_remove_requests(dwc, dep, -ESHUTDOWN);
> +		dwc3_remove_requests(dwc, dep, -ESHUTDOWN, false);
>   	}
>   }
>   
> @@ -3867,7 +3890,16 @@ static void dwc3_gadget_endpoint_command_complete(struct dwc3_ep *dep,
>   			dwc3_ep0_send_delayed_status(dwc);
>   	}
>   
> -	if ((dep->flags & DWC3_EP_DELAY_START) &&
> +	if (dep->flags & DWC3_EP_PENDING_NOOP_START) {
> +		dep->flags &= ~DWC3_EP_PENDING_NOOP_START;
> +
> +		/* A delayed kick will arm the stream with a real TRB instead */
> +		if (!(dep->flags & DWC3_EP_DELAY_START) &&
> +		    (dep->flags & DWC3_EP_ENABLED) && dep->endpoint.desc)
> +			dwc3_gadget_ep_start_noop_transfer(dep);
> +	}
> +
> +	if ((dep->flags & DWC3_EP_DELAY_START) && dep->endpoint.desc &&
>   	    !usb_endpoint_xfer_isoc(dep->endpoint.desc))
>   		__dwc3_gadget_kick_transfer(dep);
>   
