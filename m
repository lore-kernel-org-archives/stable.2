Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27773AAF5A
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823937; cv=none; b=LY/HfFB0cDn2ZDMdJ54ZrKhAiVYWEAiRaTq0FfvdpdVQiwt4Fa56aPw/pv9UcDSk0zGgS71iUJLR92lwxtu6hHk+e3964untaTOxhSZL9o9sOIIMikETbnyNx9l39rcDLI34xtorQ9iZKYZCXsaY/ES/Wh+jPWAGcd0kWOzY8q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823937; c=relaxed/simple;
	bh=IGwn36wt1Vvnr1YLDK16Ncy1SrwH9wO8dchDop0hdgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=W5pRTrdtIGgaGx55k1tWFGjoVS6HawaYTcpxnIYZ6LCjtH/46f2A32gc/cEEAz0FUbaXB5Z8DVijKLj/PCaT3LxlNbqXCu/oBJ1DmdBfFgdN6dYm98ov3HmmMOWFLq6SoT7E31fMg9Ma5r2SPPNqpiG/gEMeQQvpq78PnjJAU4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=jnt3JyZI; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jnt3JyZI"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20261012165211epoutp03b1281340f909bbccc1463307d2d9f3a0~d1l9IVDnD1518415184epoutp03V
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:52:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20261012165211epoutp03b1281340f909bbccc1463307d2d9f3a0~d1l9IVDnD1518415184epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1791823931;
	bh=1mEWCnFmOg5Enh/UqTziVDsffFD/trliWbhIh2JCps0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=jnt3JyZIcZngCZh2uAym8FsLcjrmqQdDFDmDMTBeiEQi1tool1dG70WNuRtN5/awD
	 UkmBUjQWMTEN62FWPOvx6Pbg1ME6ja1XH3VWsDbDKDWIdHTses1cXeGt2lU2J+paO0
	 /m9h/9xRpj8ReBOCnqyEHktRA+0em31F/ZSvNScI=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20261012165211epcas5p339cc6e2e574f66765f8171ddc7a827d3~d1l8xdykP0975309753epcas5p3I;
	Mon, 12 Oct 2026 16:52:11 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.92]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4j3NmV2vWbz6B9m5; Mon, 12 Oct
	2026 16:52:10 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20261012165209epcas5p2b0cbbe6cbba6eec6aa244860fdbefca3~d1l7hwmQ82036820368epcas5p2M;
	Mon, 12 Oct 2026 16:52:09 +0000 (GMT)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261012165207epsmtip1fe1c1db3d0c258e28bd266cd36e27287~d1l5gPrtz2367123671epsmtip1y;
	Mon, 12 Oct 2026 16:52:07 +0000 (GMT)
Message-ID: <0a2bc277-3977-46cd-9759-ba273b5c2c4d@samsung.com>
Date: Mon, 12 Oct 2026 22:22:06 +0530
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
In-Reply-To: <asglyrMYkopr3EOz@vbox>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261012165209epcas5p2b0cbbe6cbba6eec6aa244860fdbefca3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261007020654epcas5p1d6f8d2d6f5215abcec7d6c6f90b8b8c6
References: <arsnMM-GvuXwBKCX@vbox>
	<5d7501ea-4579-44a5-9a7e-91ef1f10b2bb@samsung.com> <asBhDmy-3DymDKQH@vbox>
	<3fdda532-8181-48e9-b58d-cad7289408e7@samsung.com>
	<CGME20261007020654epcas5p1d6f8d2d6f5215abcec7d6c6f90b8b8c6@epcas5p1.samsung.com>
	<asWmW1jmzedIV5SP@vbox> <ff5d6900-374b-44d8-967f-0af16ae53437@samsung.com>
	<98f16da0-5e24-4dd1-8f9f-79a1a5e7656c@samsung.com> <asbJfaj5OIhHBunD@vbox>
	<bc43e3f5-ba0c-4f91-b765-ee35021bf089@samsung.com> <asglyrMYkopr3EOz@vbox>


On 10/9/2026 5:57 AM, Thinh Nguyen wrote:
> On Thu, Oct 08, 2026, Selvarasu Ganesan wrote:
>>> The End Transfer command not completing is also a separate issue. I
>>> asked you to check whether the command would eventually complete with
>>> the additional code, and it appears it doesn't.
>>    We have confirmed that the completion event is never seen, once the
>> timeout occurs for end transfer. It appears the command is indeed
>> hanging in the hardware, as you suspected.
>>
>>> Can you provide some more info on your setup:
>>>    * IP and version
>>>    * connected speed
>>>    * endpoint direction (is it always OUT?)
>>>    * Is there any active transfer
>>>    * tracepoints
>
>> * IP and version : 0xc120:   0x33313130
> and version (0xc1a0)?


VER_NUMBER = 0x3231302a
VER_TYPE = 0x67612a2a
>
>> * connected speed : HS mode
>> * endpoint direction (is it always OUT?) : Yes its always OUT
>> * Is there any active transfer : No, There is evidences from the log to
>> say there is a active transfer.
> The host may have sent data that would not appear in the log until
> completion. Are there any active transfer on other endpoints?


Yes, we can see active transfer on other endpoints.

>
>> * tracepoints: There is no dwc3 traces for this issue as of now due to
>> its low reproduction rate in the customer's setup.
>>
> I think you may need to file a case with our support team and provide
> additional debug info such as scan dump to investigate this further.


Sure We will file a case,
I agree that the ENDTRANSFER timeout may be a controller level issue 
that we can debug separately.  But, there is also a software bug here. 
Let see the in the below error case, "dep->resource_index" is reset to 
"0" unconditionally, even when the first ENDTRANSFER times out. A 
subsequent ENDTRANSFER with resource index "0" may succeed and 
incorrectly clear the pending and transfer started flags, making the 
driver assume the previous transfer has completed. Since the original 
transfer was never properly terminated, the endpoint may not recover, 
resulting in a no-resources error on the next STARTTRANSFER.

Therefore, we need to fix this software state tracking issue 
independently of the controller timeout.

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
     -> Command succeeds, DWC3_EP_TRANSFER_STARTED cleared in completion 
handler

Step 3:
usb_ep_queue()
-> dwc3_gadget_ep_queue()
  -> __dwc3_gadget_kick_transfer()
   -> starting = !(dep->flags & DWC3_EP_TRANSFER_STARTED) -> starting=0
    -> Issues STARTTRANSFER (because DWC3_EP_TRANSFER_STARTED is not set)
      -> Hardware rejects with NO_RESOURCE (resource 7 still held)


We are fine with the following suggestions fix to prevent resource issue 
in timeout case,

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 1f973e546219..bac0328423cd 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1819,7 +1819,11 @@ static int __dwc3_stop_active_transfer(struct 
dwc3_ep *dep, bool force, bool int

      dep->resource_index = 0;

-    if (!interrupt || ret)
+    if (!interrupt || (ret && ret != -ETIMEDOUT))
          dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
      else
          dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
@@ -3895,6 +3899,8 @@ static void 
dwc3_gadget_endpoint_command_complete(struct dwc3_ep *dep,
      if (dep->stream_capable)
          dep->flags |= DWC3_EP_IGNORE_NEXT_NOSTREAM;

+    dep->flags &= ~DWC3_EP_DELAY_STOP;
      dep->flags &= ~DWC3_EP_END_TRANSFER_PENDING;
      dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
      dwc3_gadget_ep_cleanup_cancelled_requests(dep);


But regarding below changes in ep_disable that you suggested, is this 
really required? It seems this could cause a bug during an endtransfer 
timeout, if command completion never happens, the PENDING flag won't be 
cleared, making recovery impossible.

@@ -1096,6 +1110,15 @@ static int __dwc3_gadget_ep_disable(struct 
dwc3_ep *dep)
       */
      if (dep->flags & DWC3_EP_DELAY_STOP)
          mask |= (DWC3_EP_DELAY_STOP | DWC3_EP_TRANSFER_STARTED);
+
+    /*
+     * The End Transfer command is still in progress.  Do not clear the
+     * flags, so that the ep is only rearmed once the command completes.
+     */
+    if (dep->flags & DWC3_EP_END_TRANSFER_PENDING)
+        mask |= (DWC3_EP_END_TRANSFER_PENDING |
+             DWC3_EP_TRANSFER_STARTED);


As you mentioned Clearing the flag (DWC3_EP_END_TRANSFER_PENDING) in 
ep_disble only lead to a NO_RESOURCE error later. Yes i agree, but this 
can prevent by below new suggestion change, so above changes (do not 
clear DWC3_EP_END_TRANSFER_PENDING in ep_disable) is not required.

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c index 
ee837235630a..eb6666b7bb98 100644 --- a/drivers/usb/dwc3/gadget.c +++ 
b/drivers/usb/dwc3/gadget.c @@ -1084,6 +1084,8 @@ static int 
__dwc3_gadget_ep_disable(struct dwc3_ep *dep) reg &= 
~DWC3_DALEPENA_EP(dep->number); dwc3_writel(dwc, DWC3_DALEPENA, reg); + 
dep->flags &= ~DWC3_EP_ENABLED; + dwc3_remove_requests(dwc, dep, 
-ESHUTDOWN); dep->stream_capable = false; @@ -1990,7 +1992,8 @@ static 
int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request 
*req) { struct dwc3 *dwc = dep->dwc; - if (!dep->endpoint.desc || 
!dwc->pullups_connected || !dwc->connected) { + if (!(dep->flags & 
DWC3_EP_ENABLED) || !dep->endpoint.desc || + !dwc->pullups_connected || 
!dwc->connected) { dev_dbg(dwc->dev, "%s: can't queue to disabled 
endpoint\n", dep->name); return -ESHUTDOWN;

Thanks,
Selva


>
> Thanks,
> Thinh
