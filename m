Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.145.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795204492;
	b=PIlE2GGdql1AbwHR5k7vEbI9fQL3KZfbji+E0HRwoYbbAu4nx4P797/6x4mZ6aKwK1OS
	 GMIFoui8zRTcjgUNg/1P+jcTeZ1mwd7Cb+KmrmyAQLPE95mlznK9A6LDjzjjlxKg9ofEZ
	 AfpfVr3JO9Dw7JIMW3ekcMVobWebGf9LJ05/9x5xMTclGplCf3p2YaLskNHQ61YXF+phC
	 Rhlkw38tjOtSN/ea9nz6b5+cu2NTShB02qkjHTyy8r5aQ5k02YxpBdbY70acL0BMNPSrL
	 zeGUhsDzdQp8gtfOZWcvk6Cyx4FL13DfSlNSUeu8bsOTHH/aq9zDskDq211JdWlpUgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795204492;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:
	 In-Reply-To:References:Subject:Message-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:X-FB-Internal:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version;
	bh=U9gRtsTUMVPtmFehDHVSwkvtxQ+EsTSo46abZRFq+Ic=;
	b=XBoEiIzwKPueGvNNaTo35EFaMm+Sw/DofQIRE/xPCKGcW7amdPA4cgmdrNkSGZesI8xI
	 dmbQxv4uA6CuP+Lnm/FitnwnQcMLV29nJ0mP9Z2NHM6SaHvpSGkcP4L1Oq/i6DBYr5aUO
	 v+bE0iJorXqHfjbm4EIuSoBm1XN0doyew/Cadlye5nJjaE9GZicXUYNeUYgRqZtyzcjag
	 PJtIJQyqYtoX9J3ARTKOcpGZZ6PLjlHS5P3mXclTLtKVV4nm/mbFJd7ozlc1h9zgpsiYN
	 ZpTcajOB8w+uccgLmTY/X8uG5ABKfMF1N8X/6Wev0feke7wMvlZZhsTCCAqmx8WrjTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=meta.com;
	arc=none smtp.remote-ip=67.231.145.42
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A8E606A32A
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 19:54:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18A8E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKHAdaA2337671
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 11:54:50 -0800
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j2tcjsamx-18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 11:54:50 -0800 (PST)
Received: from twshared24494.03.snb2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 20 Nov 2026 19:54:40 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id 797982F4934DE;
	Fri, 20 Nov 2026 11:54:24 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <shao.mingyin@zte.com.cn>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <justin.tee@broadcom.com>, <nareshgottumukkala83@gmail.com>,
        <paul.ely@broadcom.com>
In-Reply-To: <20261115012809000VXL8NL9lZ4gQEKv-NNqUP@zte.com.cn>
References: <20261115012809000VXL8NL9lZ4gQEKv-NNqUP@zte.com.cn>
Subject: Re: [PATCH] nvme-fc: initialize I/O queues added during reconnect
Message-ID: <179520446449.200156.4138844829580902457.b4-ty@kernel.org>
Date: Fri, 20 Nov 2026 11:54:24 -0800
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
X-Proofpoint-GUID: kRd8-RRHtUKuHIYvLD_9mjCKknbaXRvj
X-Proofpoint-ORIG-GUID: kRd8-RRHtUKuHIYvLD_9mjCKknbaXRvj
X-Authority-Analysis: v=2.4 cv=JYcpPkKV c=1 sm=1 tr=0 ts=6b00a58a cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22
 a=1RTuLK3dAAAA:8 a=VwQbUJbxAAAA:8 a=eF1Gjh7KCRU0b0vJ23oA:9 a=QEXdDO2ut3YA:10
 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3OSBTYWx0ZWRfXyB74s2y0CJvO
 xRArjHf79s3xE2tmmFe37nGRGAuUhAQI0Px9lDqK6BFXSELTAomTiw7b2gs6M9RkjwJaAxx6rD7
 WFKrXrO3NB2sAH7yAzPyiy+2HU1pRuoE30OrhTA1bkbFR2Q+ZVIK7TdEBABHMuaccpzpvEM1T67
 05zW7PWzcblUY+xwHMjb0FG2MNbddIx6FPpZaw4lv8dKBU+KFgiWtDL9c4bHo0EvUbB9yIc8Ej5
 Iy4DdOpU1eOODBm1SG093CFJ3yU4B4isXyXNTzJGajZrxT4Z5GQTmp7fMgLvprp6Sd84E89Fhfu
 8GaXL8FRZuNJ889nUPwKQUZEmc0cqLq9oM60Wx15R9fuksEoI1Gx0rZN0e+g/5W/cfTOfUsOusU
 15gWOHXMML2c94HErGyKQIAxdTdR/tjyEeWKNpJ8RJgr4lsbLoScLmboDFddydUzGFcFqYl/c92
 1a8s/v9gMkiyIp4L3VA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3OSBTYWx0ZWRfX1cbVoWzP/qs7
 iDyuRn17gOuwibpN4ummbiRWFJg0t9zFUFUMZd2NDLqFmsPXRBf/ReZlHVMY3HnTDY48IK4rJrh
 O81jsgsHT5RfOCrEEmH4nQmmy4ADk5U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01

On Sun, 15 Nov 2026 01:28:09 +0800 (CST), shao.mingyin@zte.com.cn wrote:
> nvme_fc_alloc_ctrl() initializes only the admin queue and leaves the
> other nvme_fc_queue entries zeroed.  The initial connect path calls
> nvme_fc_init_io_queues() before creating the tag set, but reconnects go
> through nvme_fc_recreate_io_queues(), which does not initialize the
> queues it adds when the controller grants more I/O queues than the
> previous connection.
> 
> [...]

Thanks, applied to nvme-7.4.

[1/1] nvme-fc: initialize I/O queues added during reconnect
      commit: 828408399e142ab52298317f478646dd61071aac
--
Keith Busch <kbusch@kernel.org>

