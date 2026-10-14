Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB62282F1D
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791974284; cv=none; b=QlqPhlZX50dra04q0gqFgDjWmAn4pj16GrIG1U0y8bwSYhWoVDYv+W3sWmOg2G0VSauIGKxM6j/8tsQiOLSFGpU5ouBBk4UNFy/zKhG+blNWOgUBO7MvkkgT8hFkRrCaPG8glunwfSnJUSqpi73ScL1ctiB36JYs2bVdy5nLADg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791974284; c=relaxed/simple;
	bh=Oi1iJJy/wZFo6YtPMtG25HC0jZZG39GT5ePp6+VE8X8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=CJihlvl00jnsF0wMNuJDUacI2+ilaiuu1dfoNvOPiOrgkzHwUPRqntxg/MtBWDs0qKBrldYmDTfP61QoyMSDavLHdGxpYfvhyUyG1xZi97+58WJmD7djI2nvXDHEZ8k/EBvmG4BvOVEpf3nzoVr1lRKNY3HaMIVGfcWda3nxr4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=eH2YmlMy; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eH2YmlMy"
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20261014103755epoutp014a87efbda0e40708315df2396a58cccf~eXxv0Mn0R3258432584epoutp010
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 10:37:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20261014103755epoutp014a87efbda0e40708315df2396a58cccf~eXxv0Mn0R3258432584epoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1791974275;
	bh=Oi1iJJy/wZFo6YtPMtG25HC0jZZG39GT5ePp6+VE8X8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=eH2YmlMyp8sTioqvvoSDnAA5h6FZ7V41ySvOKzLCI3Yo/5PzPAZbHkPZW+f41WLa4
	 gnWpKgwTiV7YDq6I9ZD92QkrEYAyow0Hi/uV6OQoiAMjxLd6C83QPiBn4JEhWWI6YW
	 cpP7vi7pudXwRM41LS5KmqDZHLpndEeD3SuS0y24=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20261014103754epcas5p17759f988e65b8fb98c5d3dabe4b36b05~eXxvIxKti0931609316epcas5p1C;
	Wed, 14 Oct 2026 10:37:54 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.92]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4j4SMj6tSSz3hhT3; Wed, 14 Oct
	2026 10:37:53 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20261014103753epcas5p29ae76c8fbf4f9486878d98f380630b2e~eXxt6CkAq2032420324epcas5p2r;
	Wed, 14 Oct 2026 10:37:53 +0000 (GMT)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261014103751epsmtip227ffdc939b21bbb6ff6f8bc054260cea~eXxrv1Pev0552405524epsmtip2N;
	Wed, 14 Oct 2026 10:37:50 +0000 (GMT)
Message-ID: <01675986-ace4-4392-a3ed-ff1d7bdac535@samsung.com>
Date: Wed, 14 Oct 2026 16:07:49 +0530
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
In-Reply-To: <as7ZHFpqLz623QQt@vbox>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261014103753epcas5p29ae76c8fbf4f9486878d98f380630b2e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261007020654epcas5p1d6f8d2d6f5215abcec7d6c6f90b8b8c6
References: <CGME20261007020654epcas5p1d6f8d2d6f5215abcec7d6c6f90b8b8c6@epcas5p1.samsung.com>
	<asWmW1jmzedIV5SP@vbox> <ff5d6900-374b-44d8-967f-0af16ae53437@samsung.com>
	<98f16da0-5e24-4dd1-8f9f-79a1a5e7656c@samsung.com> <asbJfaj5OIhHBunD@vbox>
	<bc43e3f5-ba0c-4f91-b765-ee35021bf089@samsung.com> <asglyrMYkopr3EOz@vbox>
	<0a2bc277-3977-46cd-9759-ba273b5c2c4d@samsung.com> <as2N1JlPnpKBYcsb@vbox>
	<a8021139-a675-4875-b437-7e837d5433b1@samsung.com> <as7ZHFpqLz623QQt@vbox>


On 10/14/2026 6:57 AM, Thinh Nguyen wrote:
> On Tue, Oct 13, 2026, Selvarasu Ganesan wrote:
>> I mean 'not recover here' is the failure to clear the
>> DWC3_EP_END_TRANSFER_PENDING flag upon cable reconnection, caused by a
>> missing command completion from the prior connection.
> Right. Resetting the endpoint flags on controller restart will cover
> that.
>
>> Sure we can use dwc3_schedule_err_recovery(), and thanks for the suggestion.
>>
> I can prepare the fix patches based on our discussion. It would be great
> if you can test them.

Sure, Thanks for your support.


Thanks,
Selva
>
> Thanks,
> Thinh
