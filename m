Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=67.231.153.30
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795204495;
	b=K7mhskbu/9PjvjThxurXsBY5PBYXCg65NuEoSmjdP8/4aijLf06Hi7WOg5Etrc9SlaLw
	 yda7vvkvD2kHq3TdttsGTyIG8obdzYQ/2WdQDXlX7gG1fGGfG5WpWRBy26qTfjPY5Dset
	 uHboXPyQEuC3P4HSSzxxnqTgmCp2cz0w2vgNW/0FuINzZJe24YoyvDfoSo5kt3D0ASR6o
	 eMQ05O9xnvlNdzPiL8m4LIMHjelUDeTZmdfJ3DMAUv7+W+678lSfhl0SlAASKtqSdX6Ch
	 JkPjI/owuTe5bhTLacfSXBLfCgOlCP4DpzjtQOCQF0nzCrqR+ynvGprV5DCcyWgiNwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795204495;
	h=DMARC-Filter:Received:Received:Received:Received:From:To:CC:
	 In-Reply-To:References:Subject:Message-ID:Date:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Mailer:X-FB-Internal:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version;
	bh=jf0k2jZ5GT4jqtEGuqrJuKzcyXCpPc0FQ7ztUI+mW1o=;
	b=CCWYY41oku2uFyIynX6MR3TbTYYs/Mqlq2EX+eo/P0Nu0zHiZ6ZFagLFC8NK/mXjfKRX
	 fOUVQCQkNozHuOKwNx+qLcMkpPkFq15vBrVMOm5QNwtmyxL8f6AF02X6tBuFYJ56rWAKX
	 lDYRA9jvF8vhMq3v+dFeqv2xSSQyQGHOC8Oj9qCWQxWsEt0F2lgV9X2YxFNCrQsRO2gAV
	 PrFcVXsxSeEYgPnRI1edELuwY8aSQ30wt/a0Oe6uhFNGbdc7DU6ZzTtXMmTJAEdFf4TAO
	 gN1Oqk8J6jybJczdfEjXQTQZGMQP6VH9jZlLK6UmIyrzb6k1Tf8NdP9P1tVQZpDPUFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=meta.com;
	arc=none smtp.remote-ip=67.231.153.30
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98755606A6D8
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 19:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98755606A6D8
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0528006.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AKHISXa1244279
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 11:54:52 -0800
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4j2tg8194d-11
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 11:54:52 -0800 (PST)
Received: from twshared98463.15.frc2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.56; Fri, 20 Nov 2026 19:54:40 +0000
Received: from devbig197.nha3.facebook.com (localhost [IPv6:::1])
	by devbig197.nha3.facebook.com (Postfix) with ESMTP id B6B8F2F4934E3;
	Fri, 20 Nov 2026 11:54:24 -0800 (PST)
From: Keith Busch <kbusch@kernel.org>
To: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <shao.mingyin@zte.com.cn>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
In-Reply-To: <20261115012806699yIujDZo6TywlxuhhSIktO@zte.com.cn>
References: <20261115012806699yIujDZo6TywlxuhhSIktO@zte.com.cn>
Subject: Re: [PATCH] nvmet: fix the CSTS state iteration in debugfs
Message-ID: <179520446474.200156.8716970202832870904.b4-ty@kernel.org>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3OSBTYWx0ZWRfX+9T3s3wdG+8A
 4CFSx2uQYEqE2TwCzJYscH3YFLFPYZOMNHj3TnECADwc4LttYn+tZC2FBBjn9pR3cRJRwHid0YT
 NTXcMj6/ee2Ar0mwKA8+HGt4U1ChrYs=
X-Proofpoint-GUID: R6IXEXf7oyxRfjgFFsXLZqVcUaGeHgls
X-Proofpoint-ORIG-GUID: R6IXEXf7oyxRfjgFFsXLZqVcUaGeHgls
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3OSBTYWx0ZWRfX4xC+zILb19Jc
 isrCksEweAohXaESrB/rpkIG8YuXm0BFWP8oBhMxSF0wCju93X1rTGCN/B7vrrsHUVrNeoInuKr
 D83oKJz2VovKHBcMA6wy6u9Y3YMmYk2dPD7Qtn7o7lJfxpvjKCv61EEBJyq+g2mPaUMcu4xz0ct
 lhWF6YhVXeAek+2w0c3Qt700yeDA22JOhouzB6MBVZHHypk4fI9Icxq7BH3dfO3Q9ZN6iP1RP/E
 3rr9Vfcb0BR3RWy+P6lUh1q1jellB2OtAmv5sKo2U/TX1BvSyHdqfBRXrnSXXZ8vaIg7htqCIzr
 VlwiCMfI2WEERbw6uQWQ9d7jo9bOdOYHEC5Rf8gSO4iHvMrETEXQGmpzxtsDS/8/ZZSS1C8n2Fq
 PpeE+x+ARLqVBMi6d7/o+Yx7/Ddv01E3fZAO8fR4PrR9H1pKSJfBZHRoaOm8Yd7hpulDiPJ5RpQ
 WPLxD093z4opKwrzWcA==
X-Authority-Analysis: v=2.4 cv=YewodARf c=1 sm=1 tr=0 ts=6b00a58c cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=kkcUborcUVj0H7zxAXTl:22
 a=1RTuLK3dAAAA:8 a=VwQbUJbxAAAA:8 a=n7hJ2mYiLs74TmPVfwwA:9 a=QEXdDO2ut3YA:10
 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01

On Sun, 15 Nov 2026 01:28:06 +0800 (CST), shao.mingyin@zte.com.cn wrote:
> nvmet_ctrl_state_show() uses the size of a sparse name array as a
> bit count.  Its last index is NVME_CSTS_PP (BIT(5)), so the loop has
> 33 iterations and evaluates BIT(32).  This exceeds the width of an
> unsigned long on 32-bit systems.  With GCC on x86 this can make a
> normal ready status print "ready|ready".
> 
> Iterate over the 32 bits of csts instead.  Check the name array bounds
> before indexing it and print unknown bits as unsigned values.  The
> out-of-bounds lookup requires a reserved status bit; the current target
> code does not set those bits.
> 
> [...]

Thanks, applied to nvme-7.4.

[1/1] nvmet: fix the CSTS state iteration in debugfs
      commit: fedfd360c2f6e00d7c566ee5ed52e2ee46c99b8d
--
Keith Busch <kbusch@kernel.org>

