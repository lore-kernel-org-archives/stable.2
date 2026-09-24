Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AF035C1B2
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 12:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790252701; cv=none; b=fGr3fk7V3gOPEwdpoWI6wUlfiOzGKeYyHpdgJMjnW1QxlOMRNQuj8Yp+sTynjlBFZDX2RwxctuF1k8lx2U1ahF6mEnn4hlO9r4FlXKoKFgPUG7cGN9tuQcTAEnrHF159/uECIb1jwDfk9dYaPUeFflTp9svxjMlUyDhc9YIzfO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790252701; c=relaxed/simple;
	bh=kW7cQMfvdkotjmjlfYnmfdotfG/2jbE3uOJWp3G9K9c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:In-Reply-To:
	 Content-Type:References; b=eDJo9Ldfe7JT7piSrfQpX9AaXxhOW+jyz8aSoP2ujGhiu6JSGk9Rys56kxZ4VycpIiqWNJiX1mhn221uV+9VBq5kBlaz3bSsdQZpx0TAmNYfToXntxwfpclpNCm4mPv1EKpkNRWqC2hcrm46va12899vPdKsHeKT4LQEzGOyBHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=XEZJCmrO; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XEZJCmrO"
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260924122455epoutp02ad5bb9c6838707ebfc576cd8b5547b27~YQVdgF6wU0745507455epoutp02k
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 12:24:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260924122455epoutp02ad5bb9c6838707ebfc576cd8b5547b27~YQVdgF6wU0745507455epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1790252695;
	bh=PLyWZNlRh+SqL62fod9ga5J9WPMTRgPT0FNEe3sdVCU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=XEZJCmrOASh2ZCL4ME4nKWYDde9t4eAc6rQFdkcInwTceosWbYGdJZdIRuS+xMzvp
	 fUXlr8+gqoBdKzyNQg+XBJrIP4YPy5xduy+6M6ATTrx1LozJBreSZQE4MXH7sUZmJs
	 Qub2+iFM8KnMXszvZm/nPKDpVlr1tR25S5Kj0T3w=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260924122454epcas5p3149d870e24dc38c88932355141e5ed83~YQVdFTM9-0354403544epcas5p31;
	Thu, 24 Sep 2026 12:24:54 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.87]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4hrChP6VBVz6B9m4; Thu, 24 Sep
	2026 12:24:53 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260924122453epcas5p17ab21847d3a7bd5b9f3dab529b96be49~YQVbb_wHF3269232692epcas5p1J;
	Thu, 24 Sep 2026 12:24:53 +0000 (GMT)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260924122450epsmtip2f734ee1235c75a07729ce8767a01bc6a~YQVZXm5931701617016epsmtip2w;
	Thu, 24 Sep 2026 12:24:50 +0000 (GMT)
Message-ID: <23d3977a-5781-4b7c-b581-077526f8a901@samsung.com>
Date: Thu, 24 Sep 2026 17:54:50 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: dwc3: gadget: Prevent EP resource conflicts
 during StartTransfer
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
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
In-Reply-To: <7f8a7341-3701-4ade-a198-cf86719da931@samsung.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260924122453epcas5p17ab21847d3a7bd5b9f3dab529b96be49
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
	<7f8a7341-3701-4ade-a198-cf86719da931@samsung.com>


On 9/24/2026 5:35 PM, Selvarasu Ganesan wrote:
>
> On 3/7/2026 3:11 AM, Thinh Nguyen wrote:
>> On Fri, Mar 06, 2026, Selvarasu Ganesan wrote:
>>> On 3/3/2026 6:09 AM, Thinh Nguyen wrote:
>>>> On Sat, Feb 28, 2026, Thinh Nguyen wrote:
>>>>> On Fri, Feb 27, 2026, Selvarasu Ganesan wrote:
>>>>>> The below “No resource for ep” warning appears when a StartTransfer
>>>>>> command is issued for bulk or interrupt endpoints in
>>>>>> `dwc3_gadget_ep_enable` while a previous StartTransfer on the same
>>>>>> endpoint is still in progress. The gadget functions drivers can 
>>>>>> invoke
>>>>>> `usb_ep_enable` (which triggers a new StartTransfer command) 
>>>>>> before the
>>>>>> earlier transfer has completed. Because the previous 
>>>>>> StartTransfer is
>>>>>> still active, `dwc3_gadget_ep_disable` can skip the required
>>>>>> `EndTransfer` due to `DWC3_EP_DELAY_STOP`, leading to the endpoint
>>>>>> resources are busy for previous StartTransfer and warning ("No 
>>>>>> resource
>>>>>> for ep") from dwc3 driver.
>>>>>>
>>>>>> Additionally, a race condition exists between 
>>>>>> dwc3_gadget_ep_disable()
>>>>>> and dwc3_gadget_ep_queue() when manipulating dep->flags. When
>>>>>> dwc3_gadget_ep_disable() calls dwc3_gadget_giveback(), the 
>>>>>> dwc->lock is
>>>>>> temporarily released. If dwc3_gadget_ep_queue() runs in that 
>>>>>> window, it
>>>>>> may set the DWC3_EP_TRANSFER_STARTED flag as part of
>>>>>> dwc3_send_gadget_ep_cmd(). When ep_disable resumes, it 
>>>>>> unconditionally
>>>>>> clears all flags except those explicitly masked, potentially 
>>>>>> clearing
>>>>>> DWC3_EP_TRANSFER_STARTED even though a new transfer has started. 
>>>>>> This
>>>>>> leads to "No resource for ep" warnings on subsequent StartTransfer
>>>>>> attempts.
>>>>>>
>>>>>> The underlying framework issue is that usb_ep_disable() is 
>>>>>> expected to
>>>>>> complete pending requests before returning, but is allowed to be 
>>>>>> called
>>>>>> from interrupt context where sleeping to wait for completion is not
>>>>>> possible.
>>>>>>
>>>>>> As temporary workarounds for this framework limitation:
>>>>>>
>>>>>> 1. In __dwc3_gadget_ep_enable(), add a check for the
>>>>>>      DWC3_EP_TRANSFER_STARTED flag before issuing a new 
>>>>>> StartTransfer.
>>>>>>      This prevents a second StartTransfer on an already busy 
>>>>>> endpoint,
>>>>>>      eliminating the resource conflict.
>>>>>>
>>>>>> 2. In __dwc3_gadget_ep_disable(), preserve the 
>>>>>> DWC3_EP_TRANSFER_STARTED
>>>>>>      flag when masking dep->flags if it is actually set, 
>>>>>> preventing the
>>>>>>      race with dwc3_gadget_ep_queue() from corrupting the flag 
>>>>>> state.
>>>>>>
>>>>>> These changes eliminate the "No resource for ep" warnings and 
>>>>>> potential
>>>>>> kernel panics caused by panic_on_warn.
>>>>>>
>>>>>> dwc3 13200000.dwc3: No resource for ep1out
>>>>>> WARNING: CPU: 0 PID: 700 at drivers/usb/dwc3/gadget.c:398 
>>>>>> dwc3_send_gadget_ep_cmd+0x2f8/0x76c
>>>>>> Call trace:
>>>>>> dwc3_send_gadget_ep_cmd+0x2f8/0x76c
>>>>>> __dwc3_gadget_ep_enable+0x490/0x7c0
>>>>>> dwc3_gadget_ep_enable+0x6c/0xe4
>>>>>> usb_ep_enable+0x5c/0x15c
>>>>>> mp_eth_stop+0xd4/0x11c
>>>>>> __dev_close_many+0x160/0x1c8
>>>>>> __dev_change_flags+0xfc/0x220
>>>>>> dev_change_flags+0x24/0x70
>>>>>> devinet_ioctl+0x434/0x524
>>>>>> inet_ioctl+0xa8/0x224
>>>>>> sock_do_ioctl+0x74/0x128
>>>>>> sock_ioctl+0x3bc/0x468
>>>>>> __arm64_sys_ioctl+0xa8/0xe4
>>>>>> invoke_syscall+0x58/0x10c
>>>>>> el0_svc_common+0xa8/0xdc
>>>>>> do_el0_svc+0x1c/0x28
>>>>>> el0_svc+0x38/0x88
>>>>>> el0t_64_sync_handler+0x70/0xbc
>>>>>> el0t_64_sync+0x1a8/0x1ac
>>>>>>
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
>>>>>> ---
>>>>>>
>>>>>> Note: No Fixes tag is added because this is a workaround for the
>>>>>> gadget framework issue where the gadget framework calls 
>>>>>> usb_ep_disable()
>>>>>> in interrupt context without ensuring endpoint flushing completes.
>>>>>> A proper fix requires refactoring the framework to make sure
>>>>>> usb_ep_disable is invoked in process context.
>>>>>>
>>>>>> Changes in v3:
>>>>>>    - Revised the commit message to detail the real gadget 
>>>>>> framework issue
>>>>>>      pointed out by the reviewer.
>>>>>>    - Merged the two fixes for the same ep wringing into one patch.
>>>>>> Link to v2: 
>>>>>> https://protect2.fireeye.com/v1/url?k=5535d0f4-344e7a7d-55345bbb-74fe48600034-c617d7b77912682d&q=1&e=2a6508e6-6363-4d6e-b6ab-ce6c77832c8d&u=https%3A%2F%2Flore.kernel.org%2Flinux-usb%2F20251117155920.643-1-selvarasu.g%40samsung.com%2F
>>>>>>
>>>>>> Changes in v2:
>>>>>> - Removed change-id.
>>>>>> - Updated commit message.
>>>>>> Link to v1: 
>>>>>> https://protect2.fireeye.com/v1/url?k=c8daed0d-a9a14784-c8db6642-74fe48600034-8488506d5854e40d&q=1&e=2a6508e6-6363-4d6e-b6ab-ce6c77832c8d&u=https%3A%2F%2Flore.kernel.org%2Flinux-usb%2F20251117152812.622-1-selvarasu.g%40samsung.com%2F
>>>>>> ---
>>>>>>    drivers/usb/dwc3/gadget.c | 22 ++++++++++++++++++++--
>>>>>>    1 file changed, 20 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>>>> index 0a688904ce8c5..3af1bbfe3d92b 100644
>>>>>> --- a/drivers/usb/dwc3/gadget.c
>>>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>>>> @@ -971,8 +971,9 @@ static int __dwc3_gadget_ep_enable(struct 
>>>>>> dwc3_ep *dep, unsigned int action)
>>>>>>         * Issue StartTransfer here with no-op TRB so we can 
>>>>>> always rely on No
>>>>>>         * Response Update Transfer command.
>>>>>>         */
>>>>>> -    if (usb_endpoint_xfer_bulk(desc) ||
>>>>>> -            usb_endpoint_xfer_int(desc)) {
>>>>>> +    if ((usb_endpoint_xfer_bulk(desc) ||
>>>>>> +            usb_endpoint_xfer_int(desc)) &&
>>>>>> +            !(dep->flags & DWC3_EP_TRANSFER_STARTED)) {
>>>>>>            struct dwc3_gadget_ep_cmd_params params;
>>>>>>            struct dwc3_trb    *trb;
>>>>>>            dma_addr_t trb_dma;
>>>>>> @@ -1096,6 +1097,23 @@ static int __dwc3_gadget_ep_disable(struct 
>>>>>> dwc3_ep *dep)
>>>>>>         */
>>>>>>        if (dep->flags & DWC3_EP_DELAY_STOP)
>>>>>>            mask |= (DWC3_EP_DELAY_STOP | DWC3_EP_TRANSFER_STARTED);
>>>>>> +
>>>>>> +    /*
>>>>>> +     * When dwc3_gadget_ep_disable() calls dwc3_gadget_giveback(),
>>>>>> +     * the dwc->lock is temporarily released. If 
>>>>>> dwc3_gadget_ep_queue()
>>>>>> +     * runs in that window it may set the 
>>>>>> DWC3_EP_TRANSFER_STARTED flag as
>>>>>> +     * part of dwc3_send_gadget_ep_cmd. The original code 
>>>>>> cleared the flag
>>>>>> +     * unconditionally in the mask operation, which could 
>>>>>> overwrite the
>>>>>> +     * concurrent modification.
>>>>>> +     *
>>>>>> +     * As a workaround for the interrupt context constraint 
>>>>>> where we cannot
>>>>>> +     * wait for endpoint flushing, preserve the 
>>>>>> DWC3_EP_TRANSFER_STARTED
>>>>>> +     * flag if it is set, avoiding resource conflicts until the 
>>>>>> framework
>>>>>> +     * is fixed to properly synchronize endpoint lifecycle 
>>>>>> management.
>>>>>> +     */
>>>>>> +    if (dep->flags & DWC3_EP_TRANSFER_STARTED)
>>>>>> +        mask |= DWC3_EP_TRANSFER_STARTED;
>>>>>> +
>>>>>>        dep->flags &= mask;
>>>>>>           /* Clear out the ep descriptors for non-ep0 */
>>>>>> -- 
>>>>>> 2.34.1
>>>>>>
>>>>> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>>>>>
>>>> Oh wait, don't pick this patch up yet.
>>>>
>>>> This will cause a regression for UAS device. When switching 
>>>> alt-setting
>>>> interface for BOT to UASP, the device needs to issue a Start Transfer
>>>> command.
>>>>
>>>> This workaround won't work. Can we fix the usb_ep_disable() interface
>>>> and rework this instead?
>>>>
>>>> BR,
>>>> Thinh
>>> Hi Thinh,
>>>
>>> We’re trying to see how this change could cause a regression for UAS
>>> devices.
>>> Could you explain why the workaround might be a problem for UAS? Are 
>>> you
>>> concerned that it could miss a valid StartTransfer when a previous
>>> transfer finishes later than expected as part of ep_disable?
>> In UAS, the device controller uses the first PRIME to synchronize with
>> the host to determine whether the Start Transfer command can initiate
>> the stream. After configuring an endpoint, if we issue the StartTransfer
>> command too late, then the device controller may not initiate the
>> transfer (sending ERDY), and host will not know when to start the
>> transfer.
>
>
> HI Thinh,
>
> Sorry for the delayed response. We're seeing this issue a lot in 
> Exynos platform, so we want to get it fixed.
>
> Thanks for the explanation about UASP in last comment.
>
> We agree that for UASP, the new StartTransfer sent in ep_enable() is 
> what makes the controller send ERDY for the host's first PRIME. The 
> old patch skipped that StartTransfer that was wrong. If it is skipped 
> and no request is queued right away, the controller never sends ERDY 
> for the first PRIME and the UAS device possible hangs as you mentioned.
>
> The new patch is simpler, we won't skip it and just trigger it once 
> the inflight end transfer is done.
>
> Please see the proposed sequence,
>
>   1. usb_ep_disable() --> EndTransfer deferred due to pending control 
> transfer data/status stages (DWC3_EP_DELAY_STOP), old transfer still 
> active in HW.
>   2. usb_ep_enable() on the same endpoint --> instead of issuing the 
> new StartTransfer, set DWC3_EP_PENDING_START_TRANSFER (New flag) as 
> below,
>
>   /* __dwc3_gadget_ep_enable() */
>   if (dep->flags & (DWC3_EP_DELAY_STOP |
>                     DWC3_EP_END_TRANSFER_PENDING |
>                     DWC3_EP_TRANSFER_STARTED))
>       dep->flags |= DWC3_EP_PENDING_START_TRANSFER;
>   else
>       ret = dwc3_gadget_ep_start_noop_transfer(dep);   /* unchanged 
> path */
>
>   3. Control request finishes --> next SETUP --> existing delayed stop 
> retry in dwc3_ep0_out_start() sends the EndTransfer for all delayed 
> stop endpoints.
>   4. EndTransfer completion and trigger a previously skipped 
> StartTransfer in ep_enable by checking DWC3_EP_PENDING_START_TRANSFER.
>
>   /* dwc3_gadget_endpoint_command_complete() */
>   if (dep->flags & DWC3_EP_PENDING_START_TRANSFER) {
>       dep->flags &= ~DWC3_EP_PENDING_START_TRANSFER;
>       dwc3_gadget_ep_start_noop_transfer(dep);
>   }
>
> So the endpoint gets the same start/stop sequence you described, only 
> sent later, it goes out as soon as the EndTransfer finishes. So this 
> is high possible of happens before the host's first PRIME arrives. 
> ERDY is still sent, no UAS regression.
>
> The below testing log is for the reference. You can see the timestamp 
> where pending start transfer triggered.
>
> [ 3273.597476]  Entry __dwc3_gadget_ep_disable
> [ 3273.597481]  dwc3_remove_requests ep1out skip stop transfer due to 
> DWC3_EP_DELAY_STOP
> [ 3273.597510]  Entry __dwc3_gadget_ep_enable 1045 dep->name =ep1out 
> dep->flags =e009
> [ 3273.597590]  dwc3_gadget_endpoint_command_complete 3857 dep->name 
> =ep1out dep->flags =4009 --> Triggered skipped Start transfer when 
> endpoint command completion is done.
>
>
> Thanks,
> Selva
>

The below patch is for this proposed sequence,


diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index fa0f16ffafef..40fe930a6c2c 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -906,6 +906,72 @@ static int dwc3_gadget_resize_tx_fifos(struct 
dwc3_ep *dep)
         return 0;
  }

+/**
+ * dwc3_gadget_ep_start_noop_transfer - start a no-op transfer on the 
endpoint
+ * @dep: bulk or interrupt endpoint
+ *
+ * Issue StartTransfer here with no-op TRB so we can always rely on No
+ * Response Update Transfer command.
+ *
+ * Caller should take care of locking. The endpoint must be enabled and 
must
+ * not have an active transfer.
+ */
+static int dwc3_gadget_ep_start_noop_transfer(struct dwc3_ep *dep)
+{
+       struct dwc3_gadget_ep_cmd_params params;
+       struct dwc3_trb *trb;
+       struct dwc3             *dwc = dep->dwc;
+       dma_addr_t trb_dma;
+       u32 cmd;
+       int ret;
+
+       memset(&params, 0, sizeof(params));
+       trb = &dep->trb_pool[0];
+       trb_dma = dwc3_trb_dma_offset(dep, trb);
+
+       params.param0 = upper_32_bits(trb_dma);
+       params.param1 = lower_32_bits(trb_dma);
+
+       cmd = DWC3_DEPCMD_STARTTRANSFER;
+
+       ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
+       if (ret < 0)
+               return ret;
+
+       if (dep->stream_capable) {
+               /*
+                * For streams, at start, there maybe a race where the
+                * host primes the endpoint before the function driver
+                * queues a request to initiate a stream. In that case,
+                * the controller will not see the prime to generate the
+                * ERDY and start stream. To workaround this, issue a
+                * no-op TRB as normal, but end it immediately. As a
+                * result, when the function driver queues the request,
+                * the next START_TRANSFER command will cause the
+                * controller to generate an ERDY to initiate the
+                * stream.
+                */
+               dwc3_stop_active_transfer(dep, true, true);
+
+               /*
+                * All stream eps will reinitiate stream on NoStream
+                * rejection until we can determine that the host can
+                * prime after the first transfer.
+                *
+                * However, if the controller is capable of
+                * TXF_FLUSH_BYPASS, then IN direction endpoints will
+                * automatically restart the stream without the driver
+                * initiation.
+                */
+               if (!dep->direction ||
+                   !(dwc->hwparams.hwparams9 &
+                     DWC3_GHWPARAMS9_DEV_TXF_FLUSH_BYPASS))
+                       dep->flags |= DWC3_EP_FORCE_RESTART_STREAM;
+       }
+
+       return 0;
+}
+
  /**
   * __dwc3_gadget_ep_enable - initializes a hw endpoint
   * @dep: endpoint to be initialized
@@ -973,52 +1039,26 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep 
*dep, unsigned int action)
          */
         if (usb_endpoint_xfer_bulk(desc) ||
                         usb_endpoint_xfer_int(desc)) {
-               struct dwc3_gadget_ep_cmd_params params;
-               struct dwc3_trb *trb;
-               dma_addr_t trb_dma;
-               u32 cmd;
-
-               memset(&params, 0, sizeof(params));
-               trb = &dep->trb_pool[0];
-               trb_dma = dwc3_trb_dma_offset(dep, trb);
-
-               params.param0 = upper_32_bits(trb_dma);
-               params.param1 = lower_32_bits(trb_dma);
-
-               cmd = DWC3_DEPCMD_STARTTRANSFER;
-
-               ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
-               if (ret < 0)
-                       return ret;
-
-               if (dep->stream_capable) {
+               if (dep->flags & (DWC3_EP_DELAY_STOP |
+                                 DWC3_EP_END_TRANSFER_PENDING |
+                                 DWC3_EP_TRANSFER_STARTED)) {
                         /*
-                        * For streams, at start, there maybe a race 
where the
-                        * host primes the endpoint before the function 
driver
-                        * queues a request to initiate a stream. In 
that case,
-                        * the controller will not see the prime to 
generate the
-                        * ERDY and start stream. To workaround this, 
issue a
-                        * no-op TRB as normal, but end it immediately. As a
-                        * result, when the function driver queues the 
request,
-                        * the next START_TRANSFER command will cause the
-                        * controller to generate an ERDY to initiate the
-                        * stream.
-                        */
-                       dwc3_stop_active_transfer(dep, true, true);
-
-                       /*
-                        * All stream eps will reinitiate stream on NoStream
-                        * rejection.
-                        *
-                        * However, if the controller is capable of
-                        * TXF_FLUSH_BYPASS, then IN direction endpoints 
will
-                        * automatically restart the stream without the 
driver
-                        * initiation.
+                        * The previous transfer has not been ended in
+                        * hardware yet: the prior usb_ep_disable() left a
+                        * deferred (DWC3_EP_DELAY_STOP) or in-flight
+                        * (DWC3_EP_END_TRANSFER_PENDING) EndTransfer
+                        * command.  Issuing StartTransfer now would be
+                        * rejected with "No resource" because the endpoint
+                        * still has an active transfer.  Defer the no-op
+                        * StartTransfer; it will be replayed from
+                        * dwc3_gadget_endpoint_command_complete() once the
+                        * EndTransfer has completed.
                          */
-                       if (!dep->direction ||
-                           !(dwc->hwparams.hwparams9 &
-  DWC3_GHWPARAMS9_DEV_TXF_FLUSH_BYPASS))
-                               dep->flags |= DWC3_EP_FORCE_RESTART_STREAM;
+                       dep->flags |= DWC3_EP_PENDING_START_TRANSFER;
+               } else {
+                       ret = dwc3_gadget_ep_start_noop_transfer(dep);
+                       if (ret < 0)
+                               return ret;
                 }
         }

@@ -1096,6 +1136,23 @@ static int __dwc3_gadget_ep_disable(struct 
dwc3_ep *dep)
          */
         if (dep->flags & DWC3_EP_DELAY_STOP)
                 mask |= (DWC3_EP_DELAY_STOP | DWC3_EP_TRANSFER_STARTED);
+
+       /*
+        * When dwc3_gadget_ep_disable() calls dwc3_gadget_giveback(),
+        * the dwc->lock is temporarily released. If dwc3_gadget_ep_queue()
+        * runs in that window it may set the DWC3_EP_TRANSFER_STARTED 
flag as
+        * part of dwc3_send_gadget_ep_cmd. The original code cleared 
the flag
+        * unconditionally in the mask operation, which could overwrite the
+        * concurrent modification.
+        *
+        * As a workaround for the interrupt context constraint where we 
cannot
+        * wait for endpoint flushing, preserve the DWC3_EP_TRANSFER_STARTED
+        * flag if it is set, avoiding resource conflicts until the 
framework
+        * is fixed to properly synchronize endpoint lifecycle management.
+        */
+       if (dep->flags & DWC3_EP_TRANSFER_STARTED)
+               mask |= DWC3_EP_TRANSFER_STARTED;
+
         dep->flags &= mask;

         /* Clear out the ep descriptors for non-ep0 */
@@ -3861,6 +3918,22 @@ static void 
dwc3_gadget_endpoint_command_complete(struct dwc3_ep *dep,
                         dwc3_ep0_send_delayed_status(dwc);
         }

+       /*
+        * __dwc3_gadget_ep_enable() deferred the no-op StartTransfer while
+        * this EndTransfer was pending (the endpoint was re-enabled before
+        * the deferred EndTransfer of a prior usb_ep_disable() completed).
+        * Now that the previous transfer has been ended in hardware, issue
+        * the no-op StartTransfer to (re)arm the endpoint, mirroring the
+        * original usb_ep_enable() path.  If requests were queued in the
+        * meantime, the delayed-start kick below issues an UpdateTransfer
+        * with the first request's TRB, exactly like the normal
+        * enable-then-queue sequence.
+        */
+       if (dep->flags & DWC3_EP_PENDING_START_TRANSFER) {
+               dep->flags &= ~DWC3_EP_PENDING_START_TRANSFER;
+               dwc3_gadget_ep_start_noop_transfer(dep);
+       }
+
         if ((dep->flags & DWC3_EP_DELAY_START) &&
             !usb_endpoint_xfer_isoc(dep->endpoint.desc))
                 __dwc3_gadget_kick_transfer(dep);


Thanks,
Selva
>> So we have this workaround that we would have the device Start and Stop
>> the endpoint immediately just to arm the endpoint for UASP transfers. In
>> the newer IPs, this workaround may not be needed.
>>
>>> If we don’t use this temporary fix, the driver can still report “EP
>>> resource busy” when an earlier StartTransfer hasn’t finished
>>> before ep_disable returns. That can happen when a UAS device needs to
>>> start a new transfer during ep_enable while the prior transfer is still
>>> pending.
>>>
>>> The patch simply blocks a second StartTransfer when the same endpoint
>>> already has a transfer in progress to prevent a “EP resource busy” 
>>> issue.
>>>
>>> And it can cause a new StartTransfer to be issued later from ep_queue
>>> while the starttransfer that should have been started during ep_enable
>>> is skipped.
>>>
>> Also, if the gadget driver just uses usb_ep_disable() to handle the
>> teardown instead of proactively dequeuing all the active requests, then
>> the DWC3_EP_TRANSFER_STARTED flag will still be cleared immediately on
>> usb_ep_disable() and we will still run into this issue again.
>>
>> Another workaround is to have the dwc3 driver retry the command after a
>> small delay if there's no resource error report. Only do dev_WARN after
>> a few times of the same failure.
>>
>> Ideally, we should fix the usb_ep_disable() and have the composite
>> framework properly handle the "wait" for completion.
>>
>> BR,
>> Thinh
