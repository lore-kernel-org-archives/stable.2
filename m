Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795017831;
	b=W7ExT2BjqnzUXdU5T9zLPdTx1BTBTTaOQVRPAdeCNbYeAwYzHi861TIopM9uE2XsiH8V
	 T3IXvRrvlph1G8lzW/vmWxmNy3+p01BEngm1Qa2mGXJirk5TGLbzfKi5slM5jMatGFOS+
	 RgWHGEcE2V2b6ivW1F0ScPKePVlQV8Hv/z7QfghHCyGZCfgaVhSDh/XA3f0Xh8TgeG3y5
	 DLdEEriG+a5hDylTxzGbfl58VpqyRTk6SUz5eCQG3cQ65cIyfNnNwS4M2bp+yh9gnkjZA
	 NekyksnhLAbi3PdsDJMeP4vJe+3g1vyumeTPZw7EBf/JgA3+ISY6mI7Faj0skb+nTqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795017831;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:
	 In-Reply-To:References:Subject:Message-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:X-FB-Internal:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version;
	bh=jsJeHMkPdNev+Xkq1iaFXCxN4ARySNZFCQlN5OjLmNo=;
	b=rSAht5VDnXFQ+z/GBW+llxAS97ghMdhxpFL/qILcus7Bn0Zf2ih4JoREo6xAlm222yDp
	 4xqhm6ZOfh/Iz9LOvp37GOYy10LSkdc+flB/GQeHLZ0uWA5fLbt4IfV5hdbhZSrgq/Lol
	 7tLmKkhbaYkZkkPBK5lSCfKxfMSXMHNx22guUoTXc6nirlw4FyuUW2qw1RHJLpueLlyHY
	 SL2/TRTu31rclvLB73VlU+UIZeUAEvCq9fARGaNCvLlUtmZi33Il6G8c0dP9rzv804V7K
	 6AisBfmx7FUHcr6hDdLlQ/ZTsV66iOOBnZPwH2A4rdHMiFdsIA9CW8qS5OkIEY9i++Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=meta.com;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D996C606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 16:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D996C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIE4vKr3908299
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 08:03:49 -0800
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j0yu7xb2n-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 08:03:49 -0800 (PST)
Received: from twshared18199.01.snb2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Wed, 18 Nov 2026 16:03:48 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id 673312F281A21;
	Wed, 18 Nov 2026 08:03:36 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <linux-nvme@lists.infradead.org>, Ankit Gupta <ankit6791@gmail.com>
CC: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
        <stable@vger.kernel.org>
In-Reply-To: <20261117011230.10288-1-ankit6791@gmail.com>
References: <20261117011230.10288-1-ankit6791@gmail.com>
Subject: Re: [PATCH v2] nvme: limit Write Zeroes to 65536 logical blocks
Message-ID: <179501781641.1620426.13226357559228704463.b4-ty@kernel.org>
Date: Wed, 18 Nov 2026 08:03:36 -0800
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA2MyBTYWx0ZWRfX5YI8LRX6Dixe
 Qy5ALBKKLnmPKYUYrC0OWl0Hr6fEPMroS0ly2soJ9hiIytZpzLfYj9OrN3gnOi97AWcKVR1sOMm
 1GRvmSh8/EK+9rtS/rnKySP7wFTr078=
X-Authority-Analysis: v=2.4 cv=OcANnRTY c=1 sm=1 tr=0 ts=6afdcc65 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=wpfVPzegXHpEFt3DAXn9:22
 a=VwQbUJbxAAAA:8 a=qFBJAfofNFoZCmylNHQA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
X-Proofpoint-ORIG-GUID: vqVRS3lQM92pPZuCJ1ecWY8wJn205Him
X-Proofpoint-GUID: vqVRS3lQM92pPZuCJ1ecWY8wJn205Him
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA2MyBTYWx0ZWRfX36CwNzNXaFjk
 OnzJ75ldcK1j3n7b7kQS6TUs7xDJR8B7b1A62ruO1TZkOnQmcIhSLMrkOPSMFHwfHB3zSVJW14H
 u/zDChw9GpOHQptXSGotHvXvJXS82HW8XX5FFtqom3WVcXKtsQXN+CZ3enKLVc1WejbDuZy9HgA
 GUWq6HpLNTtjoa0Njb7HdPE6PUjDGeSEND/g0wmyb4hSd117Sajyy3ibdXd12rZ4aQ+DsRbVy90
 5cE+c/VVve4DIP4tT8wPc8hhejejgqE2amWWX41O/WecNrC6ZRhNZqLLumwBpuBRxFZOzYcxwBl
 4bpRw7faIUgQlOt7tjMd09AoxcboU9TEbEPF+VGO6L3nPIGhWzKrvzqhnNxnR52vOHUMeWbaya3
 ujxXlTmfqzCjlfZeSGRXFgsYkclZ4wjFJKgCBD7kRXO3+MO9daM7yX0ukZ52v61/+fxU8Pt7ygn
 RTxzySy6BU4hdaEdldg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01

On Mon, 16 Nov 2026 17:10:49 -0800, Ankit Gupta wrote:
> With nvme-tcp connected to nvmet-tcp at default settings, the target
> reports MDTS 0 and WZSL 0. A 33 MiB Write Zeroes request on a
> 512-byte-LBA namespace then completes successfully after zeroing only
> the first 1 MiB.
> 
> The native Write Zeroes command encodes the number of logical blocks
> in a zero-based 16-bit field. The namespace queue can advertise a
> larger limit, either through the MDTS fallback or through WZSL. In
> that case the host truncates the count when building the command and
> reports success after zeroing only part of the requested range.
> 
> [...]

Thanks, applied to nvme-7.4.

[1/1] nvme: limit Write Zeroes to 65536 logical blocks
      commit: 49a768272ae1445714efc6ab2b23f9de1398d61e
--
Keith Busch <kbusch@kernel.org>

