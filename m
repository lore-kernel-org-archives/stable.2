Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509D9394785
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 07:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790665496; cv=none; b=opoLbYOuiu41erQ4nuyPGpfQuSnnqxOxRz6KQPPeBJcREIXSKSEq/a9sHCHIXw/7R/MJAlXN9+9GbSRhcDNG9oDMajqmzrFTQTSEguLeXUUCy9CH+zbOMNS+P4saA6lTmoOCN6tScqfMSr2eW6dgeRReqsbzhQ1FL4iqdZ6rMaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790665496; c=relaxed/simple;
	bh=auR4FlAXn/xvrxBV2oQIOKHpmv+OP3vwAWUbDjNlYfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=bXdPNP9e35T9esVazpSHCK+RQUjfEimT5wl12WYwQsjUs17mw9N9hKZ58tcoCJT2xcTrYfNvdptFaW/KBenNE64ogwc29ulg9JUVxEQHDElD2v1EoTow9igOHhkiIJ/Pn7BhtCQCdlIVD3s+qmziNEYvKPvm0qYq1Nypwnysghs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=kRn6Rq8J; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kRn6Rq8J"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260929070451epoutp0402c3d2d5b373330f82c377eadd373f22~ZuMbbyMjO0728407284epoutp04z
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 07:04:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260929070451epoutp0402c3d2d5b373330f82c377eadd373f22~ZuMbbyMjO0728407284epoutp04z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1790665491;
	bh=FjIhieDjYZodqOSE1Ty33Faspz5K1iiZS8MApjx11h8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=kRn6Rq8Jj48F/2LYyXxpK4vjpr0kuyScHDQpYcHnkuFTSB464jqor8LwKstAQfFu9
	 dEmE8SfBAsvu4n/c4mTcEQqDt8JvWtpEolq/eaatVzDFGacUzU4UY6wZl3wTaZJIpd
	 5urBP13ujIHG4YZe4KCZ748Y4Xnk+/5aYK2WT3/c=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260929070450epcas5p2f095e9c2dd0da98e8f84d7381c9f7de2~ZuMa491c52805328053epcas5p2U;
	Tue, 29 Sep 2026 07:04:50 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.93]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4hv8Ln5B8gz3hhT4; Tue, 29 Sep
	2026 07:04:49 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260929070449epcas5p396bb5866052a71e8ee8b1dd5cded1add~ZuMZthAq31186011860epcas5p3Y;
	Tue, 29 Sep 2026 07:04:49 +0000 (GMT)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260929070447epsmtip1156823d524177d52680eb70a22adddeb~ZuMXqYfSS0795207952epsmtip1w;
	Tue, 29 Sep 2026 07:04:46 +0000 (GMT)
Message-ID: <5d7501ea-4579-44a5-9a7e-91ef1f10b2bb@samsung.com>
Date: Tue, 29 Sep 2026 12:34:45 +0530
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
In-Reply-To: <arsnMM-GvuXwBKCX@vbox>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260929070449epcas5p396bb5866052a71e8ee8b1dd5cded1add
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


On 9/29/2026 8:38 AM, Thinh Nguyen wrote:
> On Thu, Sep 24, 2026, Selvarasu Ganesan wrote:
>> On 3/7/2026 3:11 AM, Thinh Nguyen wrote:
>>> On Fri, Mar 06, 2026, Selvarasu Ganesan wrote:
>>>> On 3/3/2026 6:09 AM, Thinh Nguyen wrote:
>>>>> On Sat, Feb 28, 2026, Thinh Nguyen wrote:
>>>>>> On Fri, Feb 27, 2026, Selvarasu Ganesan wrote:
>>>>>>> The below “No resource for ep” warning appears when a StartTransfer
>>>>>>> command is issued for bulk or interrupt endpoints in
>>>>>>> `dwc3_gadget_ep_enable` while a previous StartTransfer on the same
>>>>>>> endpoint is still in progress. The gadget functions drivers can invoke
>>>>>>> `usb_ep_enable` (which triggers a new StartTransfer command) before the
>>>>>>> earlier transfer has completed. Because the previous StartTransfer is
>>>>>>> still active, `dwc3_gadget_ep_disable` can skip the required
>>>>>>> `EndTransfer` due to `DWC3_EP_DELAY_STOP`, leading to the endpoint
>>>>>>> resources are busy for previous StartTransfer and warning ("No resource
>>>>>>> for ep") from dwc3 driver.
>>>>>>>
>>>>>>> Additionally, a race condition exists between dwc3_gadget_ep_disable()
>>>>>>> and dwc3_gadget_ep_queue() when manipulating dep->flags. When
>>>>>>> dwc3_gadget_ep_disable() calls dwc3_gadget_giveback(), the dwc->lock is
>>>>>>> temporarily released. If dwc3_gadget_ep_queue() runs in that window, it
>>>>>>> may set the DWC3_EP_TRANSFER_STARTED flag as part of
>>>>>>> dwc3_send_gadget_ep_cmd(). When ep_disable resumes, it unconditionally
>>>>>>> clears all flags except those explicitly masked, potentially clearing
>>>>>>> DWC3_EP_TRANSFER_STARTED even though a new transfer has started. This
>>>>>>> leads to "No resource for ep" warnings on subsequent StartTransfer
>>>>>>> attempts.
>>>>>>>
>>>>>>> The underlying framework issue is that usb_ep_disable() is expected to
>>>>>>> complete pending requests before returning, but is allowed to be called
>>>>>>> from interrupt context where sleeping to wait for completion is not
>>>>>>> possible.
>>>>>>>
>>>>>>> As temporary workarounds for this framework limitation:
>>>>>>>
>>>>>>> 1. In __dwc3_gadget_ep_enable(), add a check for the
>>>>>>>       DWC3_EP_TRANSFER_STARTED flag before issuing a new StartTransfer.
>>>>>>>       This prevents a second StartTransfer on an already busy endpoint,
>>>>>>>       eliminating the resource conflict.
>>>>>>>
>>>>>>> 2. In __dwc3_gadget_ep_disable(), preserve the DWC3_EP_TRANSFER_STARTED
>>>>>>>       flag when masking dep->flags if it is actually set, preventing the
>>>>>>>       race with dwc3_gadget_ep_queue() from corrupting the flag state.
>>>>>>>
>>>>>>> These changes eliminate the "No resource for ep" warnings and potential
>>>>>>> kernel panics caused by panic_on_warn.
>>>>>>>
>>>>>>> dwc3 13200000.dwc3: No resource for ep1out
>>>>>>> WARNING: CPU: 0 PID: 700 at drivers/usb/dwc3/gadget.c:398 dwc3_send_gadget_ep_cmd+0x2f8/0x76c
>>>>>>> Call trace:
>>>>>>> dwc3_send_gadget_ep_cmd+0x2f8/0x76c
>>>>>>> __dwc3_gadget_ep_enable+0x490/0x7c0
>>>>>>> dwc3_gadget_ep_enable+0x6c/0xe4
>>>>>>> usb_ep_enable+0x5c/0x15c
>>>>>>> mp_eth_stop+0xd4/0x11c
>>>>>>> __dev_close_many+0x160/0x1c8
>>>>>>> __dev_change_flags+0xfc/0x220
>>>>>>> dev_change_flags+0x24/0x70
>>>>>>> devinet_ioctl+0x434/0x524
>>>>>>> inet_ioctl+0xa8/0x224
>>>>>>> sock_do_ioctl+0x74/0x128
>>>>>>> sock_ioctl+0x3bc/0x468
>>>>>>> __arm64_sys_ioctl+0xa8/0xe4
>>>>>>> invoke_syscall+0x58/0x10c
>>>>>>> el0_svc_common+0xa8/0xdc
>>>>>>> do_el0_svc+0x1c/0x28
>>>>>>> el0_svc+0x38/0x88
>>>>>>> el0t_64_sync_handler+0x70/0xbc
>>>>>>> el0t_64_sync+0x1a8/0x1ac
>>>>>>>
>>>>>>> Cc: stable@vger.kernel.org
>>>>>>> Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
>>>>>>> ---
>>>>>>>
>>>>>>> Note: No Fixes tag is added because this is a workaround for the
>>>>>>> gadget framework issue where the gadget framework calls usb_ep_disable()
>>>>>>> in interrupt context without ensuring endpoint flushing completes.
>>>>>>> A proper fix requires refactoring the framework to make sure
>>>>>>> usb_ep_disable is invoked in process context.
>>>>>>>
>>>>>>> Changes in v3:
>>>>>>>     - Revised the commit message to detail the real gadget framework issue
>>>>>>>       pointed out by the reviewer.
>>>>>>>     - Merged the two fixes for the same ep wringing into one patch.
>>>>>>> Link to v2: https://protect2.fireeye.com/v1/url?k=dd1a51eb-82a25949-dd1bdaa4-000babff88b5-867f0f86789e003a&q=1&e=b9b4dadf-c903-42b6-bd70-3d09d4ad7c04&u=https%3A%2F%2Flore.kernel.org%2Flinux-usb%2F20251117155920.643-1-selvarasu.g%40samsung.com%2F
>>>>>>>
>>>>>>> Changes in v2:
>>>>>>> - Removed change-id.
>>>>>>> - Updated commit message.
>>>>>>> Link to v1: https://protect2.fireeye.com/v1/url?k=a7e00d4e-f85805ec-a7e18601-000babff88b5-fe0fb8c41d582e73&q=1&e=b9b4dadf-c903-42b6-bd70-3d09d4ad7c04&u=https%3A%2F%2Flore.kernel.org%2Flinux-usb%2F20251117152812.622-1-selvarasu.g%40samsung.com%2F
>>>>>>> ---
>>>>>>>     drivers/usb/dwc3/gadget.c | 22 ++++++++++++++++++++--
>>>>>>>     1 file changed, 20 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>>>>>>> index 0a688904ce8c5..3af1bbfe3d92b 100644
>>>>>>> --- a/drivers/usb/dwc3/gadget.c
>>>>>>> +++ b/drivers/usb/dwc3/gadget.c
>>>>>>> @@ -971,8 +971,9 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
>>>>>>>     	 * Issue StartTransfer here with no-op TRB so we can always rely on No
>>>>>>>     	 * Response Update Transfer command.
>>>>>>>     	 */
>>>>>>> -	if (usb_endpoint_xfer_bulk(desc) ||
>>>>>>> -			usb_endpoint_xfer_int(desc)) {
>>>>>>> +	if ((usb_endpoint_xfer_bulk(desc) ||
>>>>>>> +			usb_endpoint_xfer_int(desc)) &&
>>>>>>> +			!(dep->flags & DWC3_EP_TRANSFER_STARTED)) {
>>>>>>>     		struct dwc3_gadget_ep_cmd_params params;
>>>>>>>     		struct dwc3_trb	*trb;
>>>>>>>     		dma_addr_t trb_dma;
>>>>>>> @@ -1096,6 +1097,23 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
>>>>>>>     	 */
>>>>>>>     	if (dep->flags & DWC3_EP_DELAY_STOP)
>>>>>>>     		mask |= (DWC3_EP_DELAY_STOP | DWC3_EP_TRANSFER_STARTED);
>>>>>>> +
>>>>>>> +	/*
>>>>>>> +	 * When dwc3_gadget_ep_disable() calls dwc3_gadget_giveback(),
>>>>>>> +	 * the dwc->lock is temporarily released. If dwc3_gadget_ep_queue()
>>>>>>> +	 * runs in that window it may set the DWC3_EP_TRANSFER_STARTED flag as
>>>>>>> +	 * part of dwc3_send_gadget_ep_cmd. The original code cleared the flag
>>>>>>> +	 * unconditionally in the mask operation, which could overwrite the
>>>>>>> +	 * concurrent modification.
>>>>>>> +	 *
>>>>>>> +	 * As a workaround for the interrupt context constraint where we cannot
>>>>>>> +	 * wait for endpoint flushing, preserve the DWC3_EP_TRANSFER_STARTED
>>>>>>> +	 * flag if it is set, avoiding resource conflicts until the framework
>>>>>>> +	 * is fixed to properly synchronize endpoint lifecycle management.
>>>>>>> +	 */
>>>>>>> +	if (dep->flags & DWC3_EP_TRANSFER_STARTED)
>>>>>>> +		mask |= DWC3_EP_TRANSFER_STARTED;
>>>>>>> +
>>>>>>>     	dep->flags &= mask;
>>>>>>>     
>>>>>>>     	/* Clear out the ep descriptors for non-ep0 */
>>>>>>> -- 
>>>>>>> 2.34.1
>>>>>>>
>>>>>> Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>>>>>>
>>>>> Oh wait, don't pick this patch up yet.
>>>>>
>>>>> This will cause a regression for UAS device. When switching alt-setting
>>>>> interface for BOT to UASP, the device needs to issue a Start Transfer
>>>>> command.
>>>>>
>>>>> This workaround won't work. Can we fix the usb_ep_disable() interface
>>>>> and rework this instead?
>>>>>
>>>>> BR,
>>>>> Thinh
>>>> Hi Thinh,
>>>>
>>>> We’re trying to see how this change could cause a regression for UAS
>>>> devices.
>>>> Could you explain why the workaround might be a problem for UAS? Are you
>>>> concerned that it could miss a valid StartTransfer when a previous
>>>> transfer finishes later than expected as part of ep_disable?
>>> In UAS, the device controller uses the first PRIME to synchronize with
>>> the host to determine whether the Start Transfer command can initiate
>>> the stream. After configuring an endpoint, if we issue the StartTransfer
>>> command too late, then the device controller may not initiate the
>>> transfer (sending ERDY), and host will not know when to start the
>>> transfer.
>>
>> HI Thinh,
>>
>> Sorry for the delayed response. We're seeing this issue a lot in Exynos
>> platform, so we want to get it fixed.
>>
>> Thanks for the explanation about UASP in last comment.
>>
>> We agree that for UASP, the new StartTransfer sent in ep_enable() is
>> what makes the controller send ERDY for the host's first PRIME. The old
>> patch skipped that StartTransfer that was wrong. If it is skipped and no
>> request is queued right away, the controller never sends ERDY for the
>> first PRIME and the UAS device possible hangs as you mentioned.
>>
>> The new patch is simpler, we won't skip it and just trigger it once the
>> inflight end transfer is done.
>>
>> Please see the proposed sequence,
>>
>>     1. usb_ep_disable() --> EndTransfer deferred due to pending control
>> transfer data/status stages (DWC3_EP_DELAY_STOP), old transfer still
>> active in HW.
>>     2. usb_ep_enable() on the same endpoint --> instead of issuing the
>> new StartTransfer, set DWC3_EP_PENDING_START_TRANSFER (New flag) as below,
>>
>>     /* __dwc3_gadget_ep_enable() */
>>     if (dep->flags & (DWC3_EP_DELAY_STOP |
>>                       DWC3_EP_END_TRANSFER_PENDING |
>>                       DWC3_EP_TRANSFER_STARTED))
>>         dep->flags |= DWC3_EP_PENDING_START_TRANSFER;
>>     else
>>         ret = dwc3_gadget_ep_start_noop_transfer(dep);   /* unchanged path */
>>
>>     3. Control request finishes --> next SETUP --> existing delayed stop
>> retry in dwc3_ep0_out_start() sends the EndTransfer for all delayed stop
>> endpoints.
>>     4. EndTransfer completion and trigger a previously skipped
>> StartTransfer in ep_enable by checking DWC3_EP_PENDING_START_TRANSFER.
>>
>>     /* dwc3_gadget_endpoint_command_complete() */
>>     if (dep->flags & DWC3_EP_PENDING_START_TRANSFER) {
>>         dep->flags &= ~DWC3_EP_PENDING_START_TRANSFER;
>>         dwc3_gadget_ep_start_noop_transfer(dep);
>>     }
>>
>> So the endpoint gets the same start/stop sequence you described, only
>> sent later, it goes out as soon as the EndTransfer finishes. So this is
>> high possible of happens before the host's first PRIME arrives. ERDY is
>> still sent, no UAS regression.
>>
>> The below testing log is for the reference. You can see the timestamp
>> where pending start transfer triggered.
>>
>> [ 3273.597476]  Entry __dwc3_gadget_ep_disable
>> [ 3273.597481]  dwc3_remove_requests ep1out skip stop transfer due to
>> DWC3_EP_DELAY_STOP
>> [ 3273.597510]  Entry __dwc3_gadget_ep_enable 1045 dep->name =ep1out
>> dep->flags =e009
>> [ 3273.597590]  dwc3_gadget_endpoint_command_complete 3857 dep->name
>> =ep1out dep->flags =4009 --> Triggered skipped Start transfer when
>> endpoint command completion is done.
>>
> Hi Selvarasu,
>
> I just wanted to point out that dwc3_gadget_ep_start_noop_transfer()
> should only be needed for stream endpoints. I'll take a closer look at
> the rest of the changes later this week.
Hi Thinh,

Thanks for you feedback.

Agreed, The dwc3_gadget_ep_start_noop_transfer() should only be needed 
for stream endpoints.

Thanks,
Selva
>
> Regarding the original comment about avoiding the wait for command
> completion due to the No Response Update Transfer command does not
> provide any meaningful performance benefit since it only applies to the
> initial Start Transfer command.
>
> Thanks,
> Thinh
