Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.254.224.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792652740;
	b=znM6sP+/xe65tKY96vhoh3O1yQu7wIf4xpdnMqRauB8RptcJ9W9FBprczT0IdbeSL1L8
	 foz5orfz0+lh/Tj5wxhpSuccwWJc4pX8OIf46+H5M5JBJcCChZBnaSxbKEFXnztisDWgd
	 PBwnuZUJ9VaLvEVK7p3gJUs/Krjkl9NKtk3fIC+N1DvYi4s3cCghYnrN4sn6gUcJbHf+C
	 aM6x+m2PSru7HiFdCw31sgS2nV25cy86sCVLuh+yJZ2sD2KjILWEPOGlxLIgWU+5SeZWo
	 Jr+I+O/0RcXP88ONoee+zymn3MsDJ76ykUYPsoCeG0oHXJchyXorbhIVLj8Y6VsyxNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792652740;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 Cc:Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:CMS-TYPE:cpgsPolicy:
	 X-CFilter-Loop:X-CMS-RootMailID:References;
	bh=FnsyXkE6qZWdhi+SOjtufAJe8QR4ECiG48kWTzP8QP8=;
	b=ssLJb5IXHDZ1IPxn2g2evJJxc5ZgVBwwRaeyfSlECNHHxqj+WrHHnA23O2OmDSRYWzXz
	 xEoCea0oVUobtya9Xa77/JN15vReyJtc7QOZChXN1FLYpBAZwzdsIq5xjuGKzT7IqN7ap
	 0JIjce0Uk+OMq4a7DCBLqVpOEUwUd91yYbqLJiLKRobwGjxcfmTdVdbIGhq3oTxPfIgun
	 ZjUkyvNOtvnPViqUEWI37A2V4jpOTZiSJOqP6KTJETRAamoIt8XG9VwIhq+KFzcTCLu9o
	 5LgQzAoeV+0T7Ie7RnbaztkWEX55F9sx/rmDIs739O9xyXqOMcyia9bfDhn24gBn+Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b="MylqP/Ha";
	arc=none smtp.remote-ip=203.254.224.33
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CC2606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 07:05:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21CC2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=MylqP/Ha
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20261022070530epoutp0381b20f372a5a060df5542816b173cacf~gyCkt5nJe2296022960epoutp03c
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 07:05:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20261022070530epoutp0381b20f372a5a060df5542816b173cacf~gyCkt5nJe2296022960epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1792652730;
	bh=FnsyXkE6qZWdhi+SOjtufAJe8QR4ECiG48kWTzP8QP8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=MylqP/HaIaSqbpZjJkHXlK8hVxKoN4PuBOuEXwELwqlHUY9Zcz253FHpMShrKy5yI
	 ZoIlJyNL81g60f1gD0aFzVAiDgp0ko4lIk1Yt2nknUizryIDa37nVuUoyRlWViueI8
	 AcSCDhiUh89yXyAelQ2V/KqJ5QaG9N6LFneuZFNs=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20261022070530epcas5p36c71aa81c8e2bd54dec17b0d855b652d~gyCkKKXLc3149931499epcas5p3y;
	Thu, 22 Oct 2026 07:05:30 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.89]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4j9HGx3DXVz3hhT7; Thu, 22 Oct
	2026 07:05:29 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20261022070528epcas5p48aedce9e342b06c3069371a7d890254c~gyCi5c0AN1455314553epcas5p4l;
	Thu, 22 Oct 2026 07:05:28 +0000 (GMT)
Received: from [107.122.5.126] (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261022070527epsmtip1537cea88a3dcd0af90790251e43d2cfd~gyChZoR-v1876418764epsmtip1j;
	Thu, 22 Oct 2026 07:05:27 +0000 (GMT)
Message-ID: <355cab30-09b6-4c10-b19f-e8320d371b10@samsung.com>
Date: Thu, 22 Oct 2026 12:35:26 +0530
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
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Wesley Cheng <quic_wcheng@quicinc.com>,
	Michael Grzeschik <mgr@kernel.org>
Cc: Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, Michael Grzeschik
	<m.grzeschik@pengutronix.de>, "alim.akhtar@samsung.com"
	<alim.akhtar@samsung.com>, "thiagu.r@samsung.com" <thiagu.r@samsung.com>,
	"jh0801.jung@samsung.com" <jh0801.jung@samsung.com>
Content-Language: en-US
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
In-Reply-To: <cover.1792542945.git.Thinh.Nguyen@synopsys.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261022070528epcas5p48aedce9e342b06c3069371a7d890254c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261021003845epcas5p4eece85dfc80cdcd3e138c14d5d32ec6c
References: <CGME20261021003845epcas5p4eece85dfc80cdcd3e138c14d5d32ec6c@epcas5p4.samsung.com>
	<cover.1792542945.git.Thinh.Nguyen@synopsys.com>


On 10/21/2026 6:07 AM, Thinh Nguyen wrote:
> The dwc3 driver can issue a Start Transfer command while a previous End
> Transfer command on the same endpoint has not completed. The controller then
> rejects it with "No Resource", and the endpoint stays unusable.
>
> This happens in two cases:
>   * On ep disable, the End Transfer command is issued without interrupt and its
>     completion isn't tracked. A quick re-enable or queue to the endpoint can
>     race with it.
>   * A timed out End Transfer is treated as done, and the endpoint resource index
>     is lost.
>
> This series tracks the End Transfer completion on ep disable and on timeout. It
> also avoids an unneeded no-op Start Transfer on non-stream endpoints, and
> rejects requests queued to an endpoint that is being disabled. If the End
> Transfer never completes, the driver recovers through the existing error
> recovery, and stale endpoint flags are reset on controller start.
>
> Thanks to Selvarasu for reporting and debugging the issue.
>
> Link: https://lore.kernel.org/linux-usb/20260227121236.963-1-selvarasu.g@samsung.com/
>
>
>
> Thinh Nguyen (7):
>    usb: dwc3: gadget: Reject requests to a disabled endpoint
>    usb: dwc3: gadget: Track a timed out End Transfer
>    usb: dwc3: gadget: Clear delayed stop on End Transfer completion
>    usb: dwc3: gadget: Issue no-op Start Transfer only for stream endpoints
>    usb: dwc3: gadget: Wait for End Transfer completion on ep disable
>    usb: dwc3: gadget: Reset endpoint flags on controller start
>    usb: dwc3: gadget: Recover from End Transfer timeout
>
>   drivers/usb/dwc3/core.h   |   4 +-
>   drivers/usb/dwc3/ep0.c    |   2 +-
>   drivers/usb/dwc3/gadget.c | 160 +++++++++++++++++++++++++-------------
>   3 files changed, 109 insertions(+), 57 deletions(-)
>
>
> base-commit: bdf12cde30830d46a8ef1ba93986356f1164b4f1
Hi Thinh,
Thanks for sharing the patches. We will test and update.

Thanks,
Selva


