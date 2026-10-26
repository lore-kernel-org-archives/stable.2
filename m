Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793082972;
	b=emgzGZQCyLVge+7fBSEDCLsRV0gJ3CCRRRbMfRfbEXI1F4KhOhvTrpBkZRt/4iEHuQ6o
	 JWKXAtPqQr6KjXRFmFOjlVw9eqh1wAIb84XDlRWBbLaVulmlgZ5ub42haJ7tewYVxPTkP
	 0+42FrOpr7Lcb7m60GRclM4TY1a41WDigsDsY7lEqf38jwUeTiGMOU9poYETRfH4iV/5k
	 CpBmAqSFAg+ft8DkhdjPjmclVfv0n/F5G6za4QptSmwGHoDaWJ9Fqmjq12OEWfmZ83hzc
	 3gWmTRzChUuM3zUMK7xA0VWWmXcrH0lsyqWKiUHN+XPBPFD4m/5rXD05h0J/LO4+1qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793082972;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 Cc:Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-Sendblock-Type:CMS-TYPE:
	 cpgsPolicy:X-CFilter-Loop:X-CMS-RootMailID:References;
	bh=Tol23jnTVv1LD346tbZ75g/VM/d5Ya+ZiOElfgXLTFI=;
	b=B5iiOOxasc8/tzgICFVK9/I3i2fnLuP+ZXA5E/wr2aTfKVGDdDmPmvprQ1SFw7j4qo4u
	 YvrOfqPcGTpCzO1tG6/ROprR9dH5VEYHFgRbAJ9XMOhGCrt9e3NHywd6onkhv9g6ANTxE
	 SoFlSwE0BT7F6LUGyiWT9rELozzI5pkwgHNCd2sgyAzqBiTOA7W40m5C8WOqvOS7Y4nbo
	 W+xmJoom51lwTT3+LLDL2BvGZTEHeJD0n8LlvTZE7XQqL+2tvO4aX+XUelXaYCmiD19tX
	 CEmzmKImKoo7YyhtJU4ttqpRErLdcyRUg38OtXZpRTt8fzbuMwCmbvbdXn9y2irMCKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b="heX/UPax";
	arc=none smtp.remote-ip=203.254.224.34
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E66606A31D
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 06:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5E66606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=heX/UPax
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20261027063557epoutp043dc1a005a9329c8f77264f10c3442dcd~iT3M5I2R81131411314epoutp04v
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 06:35:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20261027063557epoutp043dc1a005a9329c8f77264f10c3442dcd~iT3M5I2R81131411314epoutp04v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793082957;
	bh=Tol23jnTVv1LD346tbZ75g/VM/d5Ya+ZiOElfgXLTFI=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=heX/UPax00oFkfW//onJgxIBOK+oL3z0XerUfv0x+52A2ZPq7huLYzpn0HzTjU49k
	 OJWPpw38n94FR1ODlB7X4YgvjIaaFJ0sgmmYcW0+EdHlMucM8lNzaRHVW3VaMAhPso
	 n1Zbv8bogex1mT6K02eAotL/6S8yAKmgS06SwKQQ=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20261027063557epcas5p447c28181c68a2a31f37a950d72f66e27~iT3MMsJtc0175401754epcas5p42;
	Tue, 27 Oct 2026 06:35:57 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.92]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4jDLNX3GVVz6B9mH; Tue, 27 Oct
	2026 06:35:56 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20261026110911epcas5p2e68e8b567540241c4bd5d9b2e7d680c1~iD8eepqFV2862828628epcas5p2W;
	Mon, 26 Oct 2026 11:09:11 +0000 (GMT)
Received: from [107.122.5.186] (unknown [107.122.5.186]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261026110909epsmtip1fc76579f7b73cccca887d49baaea2ab6~iD8c1_EWT1650216502epsmtip18;
	Mon, 26 Oct 2026 11:09:09 +0000 (GMT)
Message-ID: <353d7757-2b9c-4375-93d0-62b28bcb438c@samsung.com>
Date: Mon, 26 Oct 2026 16:39:01 +0530
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] usb: dwc3: gadget: Fix No Resource after End
 Transfer
To: Selvarasu Ganesan <selvarasu.g@samsung.com>, Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Wesley Cheng <quic_wcheng@quicinc.com>,
	Michael Grzeschik <mgr@kernel.org>
Cc: Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Michael Grzeschik
	<m.grzeschik@pengutronix.de>, "alim.akhtar@samsung.com"
	<alim.akhtar@samsung.com>, "thiagu.r@samsung.com" <thiagu.r@samsung.com>,
	"jh0801.jung@samsung.com" <jh0801.jung@samsung.com>
Content-Language: en-US
From: Akash M/Akash M <akash.m5@samsung.com>
In-Reply-To: <355cab30-09b6-4c10-b19f-e8320d371b10@samsung.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261026110911epcas5p2e68e8b567540241c4bd5d9b2e7d680c1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261021003845epcas5p4eece85dfc80cdcd3e138c14d5d32ec6c
References: <CGME20261021003845epcas5p4eece85dfc80cdcd3e138c14d5d32ec6c@epcas5p4.samsung.com>
	<cover.1792542945.git.Thinh.Nguyen@synopsys.com>
	<355cab30-09b6-4c10-b19f-e8320d371b10@samsung.com>


On 10/22/2026 12:35 PM, Selvarasu Ganesan wrote:
> On 10/21/2026 6:07 AM, Thinh Nguyen wrote:
>> The dwc3 driver can issue a Start Transfer command while a previous End
>> Transfer command on the same endpoint has not completed. The controller then
>> rejects it with "No Resource", and the endpoint stays unusable.
>>
>> This happens in two cases:
>>    * On ep disable, the End Transfer command is issued without interrupt and its
>>      completion isn't tracked. A quick re-enable or queue to the endpoint can
>>      race with it.
>>    * A timed out End Transfer is treated as done, and the endpoint resource index
>>      is lost.
>>
>> This series tracks the End Transfer completion on ep disable and on timeout. It
>> also avoids an unneeded no-op Start Transfer on non-stream endpoints, and
>> rejects requests queued to an endpoint that is being disabled. If the End
>> Transfer never completes, the driver recovers through the existing error
>> recovery, and stale endpoint flags are reset on controller start.
>>
>> Thanks to Selvarasu for reporting and debugging the issue.
>>
>> Link: https://lore.kernel.org/linux-usb/20260227121236.963-1-selvarasu.g@samsung.com/
>>
>>
>>
>> Thinh Nguyen (7):
>>     usb: dwc3: gadget: Reject requests to a disabled endpoint
>>     usb: dwc3: gadget: Track a timed out End Transfer
>>     usb: dwc3: gadget: Clear delayed stop on End Transfer completion
>>     usb: dwc3: gadget: Issue no-op Start Transfer only for stream endpoints
>>     usb: dwc3: gadget: Wait for End Transfer completion on ep disable
>>     usb: dwc3: gadget: Reset endpoint flags on controller start
>>     usb: dwc3: gadget: Recover from End Transfer timeout
>>
>>    drivers/usb/dwc3/core.h   |   4 +-
>>    drivers/usb/dwc3/ep0.c    |   2 +-
>>    drivers/usb/dwc3/gadget.c | 160 +++++++++++++++++++++++++-------------
>>    3 files changed, 109 insertions(+), 57 deletions(-)
>>
>>
>> base-commit: bdf12cde30830d46a8ef1ba93986356f1164b4f1
> Hi Thinh,
> Thanks for sharing the patches. We will test and update.
>
> Thanks,
> Selva


Hi Thinh,


We tested the patches on Exynos platforms and observed no issues. Feel 
free to add a "Tested-by: Akash M <akash.m5@samsung.com>"

Thanks,
Akash
