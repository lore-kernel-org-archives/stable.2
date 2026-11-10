Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286915;
	b=3H0bU9Ap4lCdzmztPnOhnSCm2peTiggc100VA/tcRAjsrkObC5FYnY/ebPPP81QsstcO
	 qHkPSaf/lmChz53Eyg7ludEy5CRUX5yX0dOttYjb16vwKShf+NX+UR2kSV/GK9DeRV6MY
	 KS5AuoSlvx2gOvWNAc8S62Vq6ERXvv65svr9Hc6dm0tirAx39KJjfOCYOdkeiT/jAsiiY
	 3eCQpXxQPvFJNTI/dVBqE3O3BoeHyM19hVaK7ULwwvK+Tdr5rezWvEd2g01UnTfWMrfO8
	 BmhuMAyni7tm7G2TFVB/g6t2T/+MXotIxPE4O40k8WTV0vB0iSqK9HoQyrO0UugRhqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286915;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=M3/JB0+LrsUGZ/IBiBiNn7Ss6eEBEdQErTHb/U8td+4=;
	b=gno+ZkmvOM9jfuVom/mSnjtdZKwJvaNgnd1Ca2tLdgDEcZb9A3OOAM1jR5b+XYoXO7fV
	 FPEmNrSvFa7kIJaE2AYR9WVEngdJJOOvCfPBPVFG4gfis3RCZKqpp7GeGMqPaYBQjScSW
	 fJ9Q/cOBhcF/dtwpf7etrpH57ZnPysWkOI49tOuZIuGeQn0ZS7Tumskt87TI845D6uqHs
	 yE5S19CnRWIayFe9GCM2KGldhKdWmhJ1PnQYzd2NhSICT3F9lCfxuPqir0YbC7gp3Ju8s
	 AXqSHs89uxmSAV8BoFT707oywXL09wEEaXCmzoiuSOxbhpatyIivaUzJ7toeXcu1YDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fVyV5UmU;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27DD606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E27DD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fVyV5UmU
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA51Yc8218178;
	Tue, 10 Nov 2026 05:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=M3/JB0
	+LrsUGZ/IBiBiNn7Ss6eEBEdQErTHb/U8td+4=; b=fVyV5UmUPtyvE8K3I4/YwZ
	ENz6yX3TL5c8f6BNR7RSFZ4NJzNvJM4hO2ym6KqJM9CufgSQCwduOEFcJEzNEFnr
	XpDE6NFOZ/hpSwckNQBeUyDtoGdKkb58KoZal30K0Iqjx7muTXQ3fwsuFtKz3mLX
	HqidekoBEEAGv+5VnM359+Aj6c351bWt20r3FtwAvm0UYGCEQ0VLMcrk0SA5TnNE
	R4jCISwGIvP/xSBBCX1+Y3pZztmSuLZc9WJNVd5Pfzuj1iMyatZK9b6Hrmvm2i6A
	ANWKJwcP8MFNsQEPRAqrzBPViyXSPmNtXFLDlIoQMw+KvX8IJsh2q4skIBviJbtw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdg2u7s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 05:01:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA4JwPB1176809;
	Tue, 10 Nov 2026 05:01:12 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfak56bv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 05:01:12 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AA51BhW30474862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 05:01:11 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46F8A58054;
	Tue, 10 Nov 2026 05:01:11 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 311025803F;
	Tue, 10 Nov 2026 05:01:07 +0000 (GMT)
Received: from [9.43.53.138] (unknown [9.43.53.138])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 05:01:06 +0000 (GMT)
Message-ID: <281fc2a2-c86c-4c49-a789-f303c7bdf768@linux.ibm.com>
Date: Tue, 10 Nov 2026 10:31:05 +0530
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
Subject: Re: [PATCH 6.6.y 1/1] powerpc/pseries/iommu: Restore CONFIG_IOMMU_API
 dependency
To: Stephen Brennan <stephen.s.brennan@oracle.com>, stable@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: Sasha Levin <sashal@kernel.org>, Gaurav Batra <gbatra@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        Shivaprasad G Bhat <sbhat@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20261105232402.4033385-1-stephen.s.brennan@oracle.com>
 <20261105232402.4033385-2-stephen.s.brennan@oracle.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <20261105232402.4033385-2-stephen.s.brennan@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af2a52e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=yPCof4ZbAAAA:8 a=Wdeftzvx3mXAQTi7NpkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxOCBTYWx0ZWRfX/LvaT1GDtf00
 q6D5fY3LpJUrJ1Fn++JnwLRuIaCE6gbmeXw6JhQrkPyqWBF2RD/NexQkMRA3AoPkEpiwo0vzpda
 sS5EHQOCuhipgCPl4M64usUDR2RvFYEwOhbvMJOY1kOYz1mt+qn4SGq/2ddAXxXozSnV3FIpyv2
 NImvEEfA+pheSnbbJtH5t7MR8g7V5y8CHKQDgnXFRk33Q8D4yB90x9dwt78G3584Tk9TlUCYllW
 +7v8rQ0VbkFjU5k2MfjOswukqxK3Wo0YpxwCJD1yVbjpvKpzEjpl79zHI4raIGi9fiSNmuD0v3s
 ZqLHAu4QuQKxEq3u0bwA0SMyL1TX/tAPpnv6Nfml0Zl8cfD3/xN5caYWrzeBeTQ691ytu3+OuBj
 c8xIrXuVVjSddTyEqoLaZ36giTLJMEKPKUG/gjNWvTlcYFWexlDIe/gtAFN5TC3sgaHEkh5Tde8
 G/1e5Dn/Lwz0PD6Hlow==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxOCBTYWx0ZWRfXxDNLcwnHz7rG
 rLIAnL7GyTl9oqhevVCc3KRkIN89jPaHquLc3lCU+d/s9tXNbYUTYUDwb38mrzrWjowcRMV9vfO
 K4y1zhOXyxJdcDLGS76KKbHQbbhcKNE=
X-Proofpoint-GUID: TszBwE9Du7r1MBKo5ous7wCMznM-Nhtj
X-Proofpoint-ORIG-GUID: 0sTTQFQhQnOTCU6_dAKMvWgGtR1Dx9Pf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100018


On 11/6/26 4:54 AM, Stephen Brennan wrote:
> In stable v6.6.161 there is a build error with ppc64 when
> CONFIG_IOMMU_API is not enabled:
>
>      arch/powerpc/platforms/pseries/iommu.c: In function 'iommu_take_ownership':
>      arch/powerpc/platforms/pseries/iommu.c:69:25: error: 'struct iommu_table_ops' has no member named 'xchg_no_kill'
>         69 |         if (!tbl->it_ops->xchg_no_kill)
>      	  |                         ^~
>        AS      arch/powerpc/lib/copy_mc_64.o
>      arch/powerpc/platforms/pseries/iommu.c: At top level:
>      arch/powerpc/platforms/pseries/iommu.c:1787:37: error: 'spapr_tce_table_group_ops' defined but not used [-Werror=unused-variable]
>       1787 | static struct iommu_table_group_ops spapr_tce_table_group_ops = {
>      	  |                                     ^~~~~~~~~~~~~~~~~~~~~~~~~
>      cc1: all warnings being treated as errors
>
> This is due to stable v6.6.161 commit 1e9dfe15404d ("powerpc/iommu: Move
> pSeries specific functions to pseries/iommu.c"). It was included as a
> stable-dep-of commit 8f70caad82e9 ("powerpc/pseries/iommu: IOMMU
> incorrectly marks MMIO range in DDW").
>
> It was backported without its associated fix: commit af199e6ca29c
> ("powerpc/pseries/iommu: Define spapr_tce_table_group_ops only with
> CONFIG_IOMMU_API").
>
> The code was supposed to only build under CONFIG_IOMMU_API, but the new
> location doesn't have this condition. Unfortunately, the fixing commit
> comes after a fairly large refactor, and doesn't apply on v6.16.161.
> Instead, apply the ifdefs where they would belong prior to the refactor.
Looks fine to me
Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> ---
>   arch/powerpc/platforms/pseries/iommu.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 6a45e3e86f79b..a79927e870a87 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -54,6 +54,7 @@ enum {
>   	DDW_EXT_QUERY_OUT_SIZE = 2
>   };
>   
> +#ifdef CONFIG_IOMMU_API
>   static int iommu_take_ownership(struct iommu_table *tbl)
>   {
>   	unsigned long flags, i, sz = (tbl->it_size + 7) >> 3;
> @@ -104,6 +105,7 @@ static void iommu_release_ownership(struct iommu_table *tbl)
>   		spin_unlock(&tbl->pools[i].lock);
>   	spin_unlock_irqrestore(&tbl->large_pool.lock, flags);
>   }
> +#endif
>   
>   static struct iommu_table *iommu_pseries_alloc_table(int node)
>   {
> @@ -118,7 +120,9 @@ static struct iommu_table *iommu_pseries_alloc_table(int node)
>   	return tbl;
>   }
>   
> +#ifdef CONFIG_IOMMU_API
>   static struct iommu_table_group_ops spapr_tce_table_group_ops;
> +#endif
>   
>   static struct iommu_table_group *iommu_pseries_alloc_group(int node)
>   {
> @@ -1702,6 +1706,7 @@ static bool iommu_bypass_supported_pSeriesLP(struct pci_dev *pdev, u64 dma_mask)
>   	return false;
>   }
>   
> +#ifdef CONFIG_IOMMU_API
>   /*
>    * A simple iommu_table_group_ops which only allows reusing the existing
>    * iommu_table. This handles VFIO for POWER7 or the nested KVM.
> @@ -1792,6 +1797,7 @@ static struct iommu_table_group_ops spapr_tce_table_group_ops = {
>   	.take_ownership = spapr_tce_take_ownership,
>   	.release_ownership = spapr_tce_release_ownership,
>   };
> +#endif
>   
>   static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
>   		void *data)
