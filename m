Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794846099;
	b=zeMkO4lcSr2wkQl975RruxRAQ8XCYfP5GUb0Vm/nszOWhHVhMRFSuq1p1I79GA0tTYrw
	 e0DOacNhLxiwv3iXXffkyGW5QvJ/u9EBH0dfP2Me1VuUnwf+I6CDz8122mGCzwEKt6GeX
	 stw95qda6zvM3wip2OY48pBDGap5xbI5v3IsBhbUxUl6jWmpvpB0pBpBXZPcQHvmeAq7K
	 dnJufZ+RbZotK6DVD7f6EpRlCNDBMGaNH09Eo6ISI0pQZYp+8U7n+qH8fBt/2UDAIqjBl
	 Cgov0gzYXddPE+VJ5xRGRoNu4PqcPIq/me4oVB+PIqlMBktfXEOQyCasU4zqAPnXZuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794846099;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:
	 In-Reply-To:References:Subject:Message-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:X-FB-Internal:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=nvFyqL3Y0/F0u1N6y6kg8ykuU4M2/XUEp7+RfXlmBzs=;
	b=ni4BvCgM98eIu+Zildhw9whJXVXh8CBBSORUt4IB2teOkrjG57hmqkoLvE3r+OEf2Uub
	 76VBP7EE3aI+fu4bb3ABPGUiEw+ZdPWa31TIGNLoPT+iMfDNOKswadR1j1zrU+cWIbqfX
	 GylluRqizAeqNfbud/5urEfZ5hrYJbL2BvtAMVLazKeWw/vYkXrSn+OuBOLc6WoW+PAP+
	 AtINOWs/9IzlyfUXG1Lxv4MzLSwK/bkj+F0dzmFzEx4IHZ+A7vVQf9e4y34CAbZbrGyR9
	 zsIoodf5ypBMVxeSIDBbxbmcln9Vt8hjDDZZHSyjc97AumhTdRRwD6t4a0ajJoG3tCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=meta.com;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AD8606A33F
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 16:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0AD8606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGGIfB22660633
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 08:21:38 -0800
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4hya99p6gj-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 08:21:37 -0800 (PST)
Received: from twshared77744.15.frc2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Mon, 16 Nov 2026 16:21:21 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id A7B112F08A7BA;
	Mon, 16 Nov 2026 08:18:29 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <shao.mingyin@zte.com.cn>
CC: <justin.tee@broadcom.com>, <nareshgottumukkala83@gmail.com>,
        <paul.ely@broadcom.com>, <kch@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <20261114020245882Mvd6t10TkCZuRWpYFR3m5@zte.com.cn>
References: <20261114020245882Mvd6t10TkCZuRWpYFR3m5@zte.com.cn>
Subject: Re: [PATCH v2 0/6] nvme: fix transport request and queue error
 handling
Message-ID: <179484590968.648177.5424785032446332753.b4-ty@kernel.org>
Date: Mon, 16 Nov 2026 08:18:29 -0800
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfX/M60C5aciKpz
 /xuqoEJxMBCTpuvYSk9X4b9Hm11Hnw04WOBzxpMf1OTniAQfC0vH8HRTAOoi8adj5gAlPJKoR5E
 PHHubZpJxAGw0ML/4wbjOsoNjCi2wfU=
X-Proofpoint-ORIG-GUID: 5PGTooDP8dxo29FRsBruF4NtdTj11GK1
X-Authority-Analysis: v=2.4 cv=ZuN4uN7G c=1 sm=1 tr=0 ts=6afb2d91 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22
 a=1RTuLK3dAAAA:8 a=VwQbUJbxAAAA:8 a=0v5wFFy9qJCc6wKa7McA:9 a=QEXdDO2ut3YA:10
 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-GUID: 5PGTooDP8dxo29FRsBruF4NtdTj11GK1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2NCBTYWx0ZWRfX5+WzM0dTZkyg
 ukHcs/wS8/dVuLXHNWN8/OtzmAtYhGkAnUX/uJ2458gvUAxo/aAHG35W9tvC1vNT7sP9/VbAAFz
 TsnQgbKkmKL5IdWRk4phmaEnoW4JFekSd/Vw9zrEjU0/mFi1jIGb1eWrYibsBp47hcsEkEcfjcS
 QEPYPlHNVvngywuUlurAMrCH4nVcE1PQnY0BviNY5Ym/Gx4e+SjVwZfVnYjNEJnwiFqpIlLBNoX
 Pn+1Uu3WQEYhjRmW/mOH4nW+Vw9l3FVG5OxwaQV0GmkOI8SlwI0Le2hQql3WIzFLznAf3FoZfRo
 Sv/xgohgWr9ab4eu8BwLRnTVlAwRObSeOHnmkr/TaHwBxuAHcpc7CzaFrf6zG8u2B1FREaCOYix
 omdApyrC/0QPNm+8HK2K7jAATYY778GwmZ7gI3+5m20UzIetHBlsBMZMmZbwzhbgb54QoipgSx9
 hKnrexPe3n5JvGaohMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01

On Sat, 14 Nov 2026 02:02:45 +0800 (CST), shao.mingyin@zte.com.cn wrote:
> The six patches fix independent error paths in the NVMe transports.
> 
> Patch 1 releases the target request in nvme-loop when SG setup fails.
> nvmet_req_init() has already taken the queue, namespace and reservation
> references, and blk-mq retries the same request, so each failure leaked a
> set of references.
> 
> [...]

Thanks, applied to nvme-7.4.

[1/6] nvme-loop: release the target request when SG setup fails
      commit: f2937481c28033e10e8a29b8742a767e73c696df
[2/6] nvmet-tcp: only wait for in-capsule data for inline SGLs
      commit: 9dac3b1aa2a99e126a5504b7f5bc781c8b2771e0
[3/6] nvme-tcp: require the R2T offset to match the data sent
      commit: 347d50d92e25d4b9c50c5f5c1d8b727b9c88d12c
[4/6] nvmet-fcloop: free the LS request when delivery fails
      commit: 8c1f99419b6cc51892e259497c8e10a5d079621a
[5/6] nvmet-fc: reject duplicate queue IDs on Create Connection
      commit: 153eac284ebf68be74993643e9b2fe2f9b2b1d88
[6/6] nvmet: roll back queue bindings on connection failure
      commit: 3f82752e089283eb8204b9d2ebd8246077031173
--
Keith Busch <kbusch@kernel.org>

