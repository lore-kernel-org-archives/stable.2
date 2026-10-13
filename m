Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29014FECC6
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896440; cv=none; b=DeIehzMJsU7Zmf6kqhH0zXVlFUrw2+hI9EDBHJFylFmEqXBw/hJGNZfD61aBfUiaBt8PU5nEEDLmSs8GMtWUbkSPrrJnZznbF93aaTT5Wa1DnC5oUsO/RjNz+CxyyYvMVSztrvPoa7m3jZ5H0QHBg+A+qTosjqS0zP7rSQ9ZuII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896440; c=relaxed/simple;
	bh=CDEZnZFYpuffzPq3yVbIulrNbfblS4pwlFeEeefac3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=t+SFYXDh/CyArMtUGf1po7vfKNvGlah7pCJvJfyOlOoDWA2b64LZQ727ey6uxdchIXuCruO0a4BeJg6ZZRGKEbyVJMo4Fixsf3pZWcs9MZB9p2HGYZg2PPE0b1vwsH211L/UH9zmVDrWfatIsrpulWJ9NsKloqmaIUd0cHT2f1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=FrnXINfp; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FrnXINfp"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20261013130034epoutp03763a241c5e19c776b8a65f7b1a100482~eGFBHY22e1299212992epoutp03P
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 13:00:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20261013130034epoutp03763a241c5e19c776b8a65f7b1a100482~eGFBHY22e1299212992epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1791896434;
	bh=CDEZnZFYpuffzPq3yVbIulrNbfblS4pwlFeEeefac3s=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=FrnXINfpsmzFR60SEEZ+Ifmg51zWVer0rh+6K11bq9DZ89iJWBt1p+jVQ+Wivj/iK
	 hWNftO2X9lrBfGeDB1mXucnzR5DQiaAMmiRczjJWr33juaHgjoGcT3Hxukme03jeDc
	 9DfGapZIT1y6d0dMEnAgDCQIxfBrBZNCNk5JFYVg=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20261013130034epcas5p21afebfcd95e6f4718230475486d5b6e3~eGFApo0__1130811308epcas5p2X;
	Tue, 13 Oct 2026 13:00:34 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.94]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4j3vZn2G3sz6B9m9; Tue, 13 Oct
	2026 13:00:33 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20261013130032epcas5p4f27978a49d4f5f169affa17d28ce8049~eGE-W2lUN0272202722epcas5p4K;
	Tue, 13 Oct 2026 13:00:32 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20261013130031epsmtip13f0de6001ef3f2850768a03770582e27~eGE96Cykg1973519735epsmtip18;
	Tue, 13 Oct 2026 13:00:31 +0000 (GMT)
Message-ID: <8102549a-d440-4d37-8b0f-531a001e230e@samsung.com>
Date: Tue, 13 Oct 2026 18:30:30 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] nvme: bound FDP config log reads to the received
 buffer
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>, Keith Busch
	<kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Nitesh Shetty <nj.shetty@samsung.com>, Hannes Reinecke <hare@suse.de>,
	gliuxen@gmail.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20261013102812.3020500-1-yhlee@isslab.korea.ac.kr>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261013130032epcas5p4f27978a49d4f5f169affa17d28ce8049
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261013102825epcas5p38d2293e8e6c86a9142f6d24ba9fd371e
References: <CGME20261013102825epcas5p38d2293e8e6c86a9142f6d24ba9fd371e@epcas5p3.samsung.com>
	<20261013102812.3020500-1-yhlee@isslab.korea.ac.kr>

On 10/13/2026 3:58 PM, Yehyeong Lee wrote:
> A malicious or buggy controller triggers this during namespace scan with a
> short FDP Configurations log:

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
