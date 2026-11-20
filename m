Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795204483;
	b=z5hzwkFqX3LFmNrBqarC09VtwSvfHiFayi3O625K18uWZQNs0wBXvvGnyo50Jw1yHPBe
	 tB1GufhvT5dJN7iOuGY/PAh7xjgG9/9Co56nrVtyfbYAGOSCBhz5jyeKtkunbY5ySn12W
	 VBBiKVyhLYsT0rrrvZJX/H8RUNtFMQ90M7MgDlc97Jw+Nv6N8Bn3D+FEsnzik6Y95ga7h
	 x86SYWCCCZNR74tOb0qUM4OsvaZiHbXAE98wK2H5atzrugoc9KDbUrpOSyMJYcGV4TPva
	 JQ6PcQs0p+1LBWPKf8G+3MqPhOW0ueAp8sLfp+w0mhkaTRnn2Is1OJFSibjBQfyB6lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795204483;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:
	 In-Reply-To:References:Subject:Message-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:X-FB-Internal:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version;
	bh=hoxfplFe/TQYjJ5V/KtZzdefBVtuVMq1TspOz2xkKTo=;
	b=fRlZPYFiBzOzqCDvkcf7OMMN0isc6i2Ox3TGawsN/f59mNOvdnGEAp0BGjYkOZaNiS7E
	 ps2Nngqx6aA4j0kLnKU8b7FtimxoANObYxs6vfKHM/gRQ/PysOZnJFZgwMH3MBPHj12z6
	 Wry1uCjSNUHUXat32/vt/0Z4iqApuqlOtvxFZlb40VdbhFaO5RJOoyKpQfd8ixFiQM+9L
	 cJuTbr8i9oU6NRXzILUOdy9TsVR04hPS/L80HBV3GrQtG6jTY1RyPMBVIn4+eKyVhNgjo
	 N1Oi3MrqDTrzBTDedM9sitS2m6Nacp9jm0uRqDEansAtRUrNB8EqUy3gfOkoiiJpkMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=meta.com;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E62606A6F3
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 19:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6E62606A6F3
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AKEfbKI4076606
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 11:54:41 -0800
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4j2bb2p536-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 11:54:40 -0800 (PST)
Received: from twshared80817.17.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 20 Nov 2026 19:54:38 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id B93A42F4934E4;
	Fri, 20 Nov 2026 11:54:24 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <shao.mingyin@zte.com.cn>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn>
References: <202611150127512368BGQ07ZNIRAIwClkam-8u@zte.com.cn>
Subject: Re: (subset) [PATCH 0/5] nvme: validate and decode controller
 supplied values
Message-ID: <179520446475.200156.12946198917113625003.b4-ty@kernel.org>
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
X-Authority-Analysis: v=2.4 cv=KqnYSmWN c=1 sm=1 tr=0 ts=6b00a580 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22
 a=1RTuLK3dAAAA:8 a=VwQbUJbxAAAA:8 a=013bj7QzCcn9ZdgyvDYA:9 a=QEXdDO2ut3YA:10
 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3OSBTYWx0ZWRfXyE1hATPyWlfG
 zctwyRlFmVQrhF35YzkyqulHLT2fWNmlGQZ29Qx8jEWG7Nk7/Qd6q35eUodS7q5SCOLAa2g1phr
 oesy/w17kMyDazyw2mVDjEuNPYEAzNWWrF5mngiz8ml2zKcHF5PcrByrap1Jj36hYbGaqzV/Xbu
 e+M3xVJpg9vaPbk3XwICKa5ABqEY3qoO7rZjxm5Cm4pUINmtuh1nWAOtaG9YxJs3ayizsSz/YJH
 SYiKFWDZSmnUFi7K5OIr6digHu+7Z9P0ZLCfHQhFbL7XDODRoZ/DzKj6zFBheXjMhOooCcL2HhU
 LbAQoI6V1zI0E3oUZOUGWgaDmjCsBu1TYuj7Y0zm00pNE/2wOfLxdCzBsa4yrSnFYoyVXYpof96
 1/vL6hf4mCBpBEePeiWl3pJUlhYN8EAxFNt6aIuyby6KAVshr1hrrs4vetTBaNwsnYhJtMRuIEh
 9OyVMG10JSmi4yDWWEA==
X-Proofpoint-ORIG-GUID: 4pnhnfZ5Ahq1Mj51vQus4-4QOop2EWee
X-Proofpoint-GUID: 4pnhnfZ5Ahq1Mj51vQus4-4QOop2EWee
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3OSBTYWx0ZWRfX35U+HAMfignG
 JnAZKbhAtRp8YnHU8xMCf6dtZdEFj2WVIlGo+GV/C/YAKX5fthcM9TgFplh6m8wyMu65KisnUCu
 +uVqiicIPPjAAb+mIpEQRnd28lyDm84=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01

On Sun, 15 Nov 2026 01:27:51 +0800 (CST), shao.mingyin@zte.com.cn wrote:
> This series adds missing validation and endian decoding for values that
> come from a controller, a backing controller or a user request.
> 
> Patch 1 rejects an invalid ZASL from the controller.  nvme_set_max_append()
> shifts 1 by zasl + 3; a value of 29 or more shifts a 32-bit value by 32 or
> more, and the old code also used a signed int for the shift.
> 
> [...]

Thanks, applied to nvme-7.4.

[3/5] nvmet: validate the LBA format count of a passthrough namespace
      commit: e52b8562e2adb7c3bc77f8899db03f763d9cf49d
[5/5] nvme: bound the reservation report retry loop
      commit: b80093c7d0aabb92343f6b333c8ee36e7870ca67
--
Keith Busch <kbusch@kernel.org>

