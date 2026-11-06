Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983311;
	b=XxSl+St1XQBod86KDE14QgZDx1vsAnFBciqoB+FeZ7tDwxqLi5j2sKmryRNiGlocv2zS
	 I8P1CnIgvQ8PXzHNcIkUQecUdtmWzwG5h5rx/e8gL7oOyIwiecKMQBGxznyvuiLSyXTBx
	 6wCXyNP+0F9/hFo4jZ/cePrgG0dHzErTwth3Wc6VZe4zmZvqQQIgsUyH23cwbIxOc/ImX
	 dUcN+Al9x/eym9riwx0Fwvvh1yK65IdNyXSt/9zZSkmDO5x+VwvufY/pLADjYrcPDzkyd
	 uZoKgtxjCoC4DWnKU2TGads/wOYYOb2qAiJZW/8/3Rsn+1rywt/gTKy/XRl6mEgIOGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983311;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:
	 In-Reply-To:References:Subject:Message-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:X-FB-Internal:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=Qi4tRF3VXUVHtFMLZxctH/E7kZ4hP3nNCWedSjBpTnI=;
	b=F03j8cvJEpvrG717ykrDqmfYZQ5038iNtFGF/M2suHNNwraTFFFv/aYWDansJFpMb99s
	 wG+q7og3wc2QfsisjaZ/JwNqavdW/uT08RuubxVR0Mh4UZ6AbOMOqnRxVboBeVcVKHE+O
	 yCLQZP35BIBMWiVMygHMYxWNO24Bfgdneh9H3Oyw42A2EnxyFuFSj2oamvjLvKh8r5bHU
	 YVxqxzF2BP4aVnkCYqS7LCxpWg8D8K6asbjKxgEnOBYD2opP7m4EU6cbECxWhsk2CF4pN
	 KDo1xvZf6pdoqj+Q2N43zOF1yiHl79VCVxzK2tUa5PSMCOaVOOQ5GemLGriFw9GebkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=meta.com;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E4C606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 16:41:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94E4C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6GXAvl3808105
	for <stable@vger.kernel.org>; Fri, 6 Nov 2026 08:41:49 -0800
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hs3rb549y-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 06 Nov 2026 08:41:49 -0800 (PST)
Received: from twshared16865.02.snb2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 6 Nov 2026 16:41:48 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id 1111B2E8C8119;
	Fri,  6 Nov 2026 08:41:35 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        Yaohan Li
	<shunsheng1218@gmail.com>
CC: <mkp@kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <20261105114149.970315-1-shunsheng1218@gmail.com>
References: <20261105114149.970315-1-shunsheng1218@gmail.com>
Subject: Re: [PATCH v2] nvme: stop asynchronous event work before ANA
 teardown
Message-ID: <179398329505.3869217.16360449942486789550.b4-ty@kernel.org>
Date: Fri, 6 Nov 2026 08:41:35 -0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-FB-Internal: Safe
X-Proofpoint-GUID: rHVEDV4Q6WnAJh1XYk4djq_7HwTgtu-j
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2NSBTYWx0ZWRfX7raHfHOJzyou
 EGHy1t/rLILqBcUVffSuFVIP94YTSO538tMl5EOrQlAFMeV+8sDW5RtRBl3BIWcYEVo6NqIBNJc
 KytUS+b8atc+x/mkGwpQveUka9Hel/U=
X-Proofpoint-ORIG-GUID: rHVEDV4Q6WnAJh1XYk4djq_7HwTgtu-j
X-Authority-Analysis: v=2.4 cv=TLPQ2Fla c=1 sm=1 tr=0 ts=6aee034d cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=4h92JMTCafKA-fb_NiOh:22
 a=VwQbUJbxAAAA:8 a=NhGQEf4IzQLqQlViRykA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2NSBTYWx0ZWRfX6B8f8GFM/XdI
 /5GitOlPgA0/1HL46UQP2PuEwbOVQ6nQUDoO8RkjHG8eHzsGvg7pGLHpFpG8NMip6EH+8JyQ/QD
 6dHash89UfcRIEZDmQezm/4OGXHilQKZkRKVpXLkrxdzTDJpQ9PB7OzGJjTNReKjSvKo15UEmDU
 35qHnyW8iveO/yzS4AFluzP8YUKekOKGJ58SczCRRLP7GKkPrwD9BHLF+Bky8an+UIVyLI3ul+C
 f4TL+Uj0BQiHoARMoessZMygCR3FI2m4DLoqirowS5Z1CCwzeveki7HAo4S9/qIvl5Hb1rBjty2
 fiXXoj0zZdTdNuRkexDMul9GJRmqJlP0e+pJRUA3GS0YtIU9NTpHJwsTEdixBVoS948kTdhhZZl
 HgOkXq+M7ZF56hvMJT2D7NFK9ewlLgsO76IG4BhV+00xLPYHo6kqpdL50c4t9VTZUORgmTyAbe1
 ypp/xhbjMcg+UB8/gmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01

On Thu, 5 Nov 2026 19:41:49 +0800, Yaohan Li wrote:
> NVMe ANA work has several producers, including ANA AER completion,
> namespace scanning and failover processing.
> 
> An AER completion can queue ana_work for an ANA notice and can
> separately queue async_event_work, which sends the AEN uevent and
> submits the next asynchronous event request.  These work items access
> controller-owned state during asynchronous processing.
> 
> [...]

Thanks, applied to nvme-7.4.

[1/1] nvme: stop asynchronous event work before ANA teardown
      commit: 9b657c565984f28976b1e471e3ce2f81cc269238
--
Keith Busch <kbusch@kernel.org>

