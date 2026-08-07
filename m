Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBFD48A8CD
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 13:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786108454; cv=none; b=jBTfH2M2+bCZNn/KwloSDlvBR7vsDzX/JnWJoQ10IzlDNAUmhh6XKoAnjTqjxb+zYgWphEIk6VREbl3kvj88htkJs9seAeBzzQPqMTM+nrfH+db7CruYkXFATZGHpOJTXVE8HsBTy8XbO0Oc3ZKbfgf3CgdYpsvSiLb6OyHSzU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786108454; c=relaxed/simple;
	bh=ZaKkEbJzEY6aooj9Ulk+aZPx/41jE65U26i6DS+cVME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=madGVmsDQW88iXrCRWS4GdQxifK8Aq33CMojTJV2NBw0i68lSE4Y4hDTuHZphwEITnfcVasnDL9jVbQ8LxzVYtlSsa3mye3rnPiHFEDgGyfL7Wc3LfPNANOasKcutKQGDmVFVm6nYEzSAFCYjrhsNwUhaBDS2pa4JLD8N+wkMAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fphs+Cvp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fphs+Cvp"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677Clqp81412160;
	Fri, 7 Aug 2026 13:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4h0HLS
	ywBT0/cUZpjZdhGIKtIqmioJWjQuuourWt8r4=; b=fphs+CvpyT59dGU2OJ8fcC
	4idrmIh8/QMUD31uN9QzfQW+Z3sYDq8T4WXAJuUTDnQ1Qf6Vhpap5sQLlFBNfIB5
	ry+lnddrw8Mj9QAcI/z7dJFNTn68aTuzYS5p+xg+jM8kdy5Bp8iYW5d2fns094wV
	+yUtPkarvzbaz93g2pZb1xX0CyxcEMj5UOcVnci5PuPlO+K9/XdAX1RQ7vSWxS38
	mlFWjLbEAYhJoKrK1TgWezGPPKqVJN0jlvg8dlVqsFEtzkVpBzUQQPtu6k/X62Ua
	LCVunr5mwGI66CP2fvhAXYSFZfcEnwVD0mnczQYe4kw7p13PWlV5iXaeCravVqjw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy02bwm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 13:13:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677DBUMd005710;
	Fri, 7 Aug 2026 13:13:57 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhqqtx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 13:13:57 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677DDHNA27853544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 13:13:17 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6ED7858054;
	Fri,  7 Aug 2026 13:13:55 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 549E15805C;
	Fri,  7 Aug 2026 13:13:54 +0000 (GMT)
Received: from [9.67.5.100] (unknown [9.67.5.100])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 13:13:54 +0000 (GMT)
Message-ID: <691c164c-9118-4209-ab7f-c9d7482a65ec@linux.ibm.com>
Date: Fri, 7 Aug 2026 08:13:53 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] powerpc/pseries/iommu: Add TCEs for 16GB pages when
 RAM is pre-mapped
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, maddy@linux.ibm.com
Cc: ltc-dev@lists.linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com,
        harshpb@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        donettom@linux.ibm.com, stable@vger.kernel.org
References: <20260806205027.86428-1-gbatra@linux.ibm.com>
 <ldailks9.ritesh.list@gmail.com>
Content-Language: en-US
From: Gaurav Batra <gbatra@linux.ibm.com>
In-Reply-To: <ldailks9.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G6ws1dk5 c=1 sm=1 tr=0 ts=6a75da16 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=u_fQUr-NCcxOklD4s3sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEwMCBTYWx0ZWRfXy154Z+mALQKw
 XRgqqCk13Ke3M5//b+1BqVZcPsebzH+KFOmfaxNZXwQwLgLgCdD+h4XU8krlZB5XDTH8vkMcUFA
 PeF3Cjxei1fwMeIWbhbCwF5ugKOKxEAlTpmX0sw2EH1yeIfCmG8ZhG/RGjUVnhF6NXOzljk/ykO
 bGZ36clg5bvNLsF/ix4iCAa1f+vLB5asqtRQBijkcJ9W2PXkk6fYgTYJlAugXqyxDsZ0FUFlzmN
 iKsNXZam/p+FZu07RT7ONno1vHFmy3q7ZQN0v59mSsfT9yOBIeyzfmKM87BxzEki4B0SqNO4s9F
 ZluxiQgRGLfaHU7eA0z3Thm0C/Lticdz+WiBMgv9bEfl0av4+z8hFbydv0QnJziiOU+5iG6eJMW
 vtMWHFeT4Ynt2+BMtT466fAwEv302WqtPK0bVXMuVezJRFCjamc8r3mYWB93DYXtemuUxqTHTvC
 4Sh84Dst4cdygMzWS+Q==
X-Proofpoint-ORIG-GUID: dA2WKdBqKZfYoOue8dTz5bXGss_IhqHm
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEwMCBTYWx0ZWRfXyLcUS2+CNbAv
 NEApy5zeyeon6tr5sJsFDC/KH0kWcv3pfcDs+P9fBA8voPdAQAOZoqq+qm8FBmevmz1GkTouaos
 nBMhYzriPnvMCXqH1Bol448dcJHsUzA=
X-Proofpoint-GUID: tshLprXFfQ2ni3mZDYySEXEJ6viZXH4o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070100



On 8/6/26 9:35 PM, Ritesh Harjani (IBM) wrote:
> Gaurav Batra <gbatra@linux.ibm.com> writes:
>
>> In powerPC, if Dynamic DMA Window is big enough, RAM is pre-mapped. To
>> determine the size of RAM, a PAPR+ property "ibm,lrdr-capacity" is used.
>> This OF property dictates what is the max size of RAM an LPAR can have,
>> including DR added memory.
>>
>> In PowerPC, 16GB pages can be allocated at machine level and then
>> assigned to LPARs. These 16GB pages are added to LPAR memory at the time
>> of boot. The address range for these 16GB pages is above MAX RAM an LPAR
>> can have (ibm,lrdr-capacity). In the current implementation, these 16GB
>> pages are being excluded from pre-mapped TCEs. A driver can have DMA
>> buffers allocated from 16GB pages. This results in platform to raise an
>> EEH when DMA is attempted on buffers in 16GB memory range.
>>
>> commit 6aa989ab2bd0 ("powerpc/pseries/iommu: memory notifier incorrectly
>> adds TCEs for pmemory")
>>
>> Prior to the above patch, memblock_end_of_DRAM() was being used to
>> determine the MAX memory of an LPAR. This included 16GB pages as well.
>> The issue with using memblock_end_of_DRAM() is that when pmemory is
>> converted to RAM via daxctl command, the DDW engine will incorrectly try
>> to add TCEs for pmemory as well.
>>
>> Below is the address distribution of RAM, 16GB pages and pmemory for an
>> LPAR with max memory of 256GB, memory allocated 64GB, 2 16GB pages and
>> assigned pmemory of 8GB.
>>
>> RANGE                                 SIZE  STATE REMOVABLE     BLOCK
>> 0x0000000000000000-0x0000000fffffffff  64G online       yes     0-255
>> 0x0000004000000000-0x00000047ffffffff  32G online       yes 1024-1151
>>
>> cat /sys/bus/nd/devices/region0/resource
>> 0x40100000000
>> cat /sys/bus/nd/devices/region0/size
>> 8589934592
>>
>> The approach to fix this problem is to revert back the code changes
>> introduced by the above patch and to stash away the MAX memory of an
>> LPAR, including 16GB pages, at the LPAR boot time. This value is then
>> used whenever TCEs are needed to be pre-mapped - enable_DDW() or,
>> iommu_mem_notifier()
>>
>> Fixes: 6aa989ab2bd0 ("powerpc/pseries/iommu: memory notifier incorrectly adds TCEs for pmemory")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gaurav Batra <gbatra@linux.ibm.com>
> Thanks for addressing the review comments.
> BTW - we should really cleanup enable_ddw() function. It has so many
> corner cases and has started to become confusing. But as for this patch
> it looks good to me. So, please feel free to add:
>
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
yes, I have a list of few items that I would like to address. I will 
work on it
>

