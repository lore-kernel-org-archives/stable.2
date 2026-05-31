Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371BC2E266C;
	Sun, 31 May 2026 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780246204; cv=none; b=lZZNVGuCUQHquCRie37ZG7MOdADDVkZ9njV1+lpmoEZ5P9rChRMeoK3ZOvjJmGLUIDHbd9TFPZLLM4T+kqk8O42IxayyJEeZYxxewYHeiy4YhAbYpsB+oBRVSlshKigYHkMp3kJJYBMvILJ0oZDd97TSrc9Efxg7OuSvzcCkRdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780246204; c=relaxed/simple;
	bh=/j3eTcaTBsxONaxz1mjr32IJt6/kzEq5mpGPtP5+9jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QPuEwcno1kPDFyUzJ+/bwJ72TBEugTBUgRwhVoJn3aAGe0BzvMMPp/6W0Z1uRfY9TmUP05xsp165gJnFBq814HAXuxqHyW8B0sR04GTcBeRoZS2qeKREvbiNhlO0FhVjBZV2uySCIBQ0SKosU6MTjwxYBdjPfpXyHa7fpNu01OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BVEG2tv6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BVEG2tv6"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64V3ZINO1958209;
	Sun, 31 May 2026 16:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=aRBtfR
	cSCltfV0b9S147uOdgpOLUfw0Ef6VL4jNe3/0=; b=BVEG2tv6TQ+gxyaAxQxOO2
	B9rXVbuXbdoZnnyDApMr6wVKNk72p0xGPwmvaJWXFQgGojwPx4wOzy/3wchvzjUI
	dlDdZfpoNp1LNYK4QaedDeRxJesbOFtYBuSCNHajOK9PEj1BDbIAOcN29LPlCICw
	xd0+aN+BNNjj6FAaNBIKdz0NVQMR5adpTlCkLCNIAogLG/BXhft7h14LDEhz1WVk
	uDibHyQ94WxPJiZJhqIlVON5Zd8/xMchG0HvLHpdLnz64yB8gkzE0cuIUZx6nVSS
	NFt5bGJPjCezRV/PCRfJI+wiKfKfjNGJ48ohLqclAzPpgkdvhnqo/Zekf7V5CAWg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm4n66n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 16:49:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64VGdDHP007583;
	Sun, 31 May 2026 16:49:43 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakvjhhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 16:49:43 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64VGnBKt65077522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 May 2026 16:49:11 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63C3C5805A;
	Sun, 31 May 2026 16:49:41 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 360E85803F;
	Sun, 31 May 2026 16:49:37 +0000 (GMT)
Received: from [9.39.20.217] (unknown [9.39.20.217])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 31 May 2026 16:49:36 +0000 (GMT)
Message-ID: <47846f02-ba17-4a45-9bbc-550ba15ffd87@linux.ibm.com>
Date: Sun, 31 May 2026 22:19:35 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] powerpc/pseries/Kconfig: Enable CONFIG_VPA_PMU to be
 used with KVM
Content-Language: en-GB
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        atrajeev@linux.ibm.com, stable@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
References: <20260529141032.69559-1-gautam@linux.ibm.com>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <20260529141032.69559-1-gautam@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: zip5Ccdsfba4La2oXPnXLA6sUQTy0vaU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMxMDE3OSBTYWx0ZWRfX91iEnZPcStZZ
 K7quh3mxA+HNOa0ZZFK11rWkqVx945xXATstvva+hgNZsp+xdddxvE98pgFtdPP/br5uEu7+LJr
 JR1/1hsCN5fcweBfMWwFm1f8/71HrWGUKL2eO/3Y4DZDAjSHRkNrq3tBYDJ72IJ1olMhTZQa//2
 ixiltEGUVl1Cy3Z0G1nivBmUWVKcT5eaDmQpeGLtuwyaLz/hggxkuwQKiXckw4g2Fd2yDgNCe7K
 beOOeIqizrNakt6X3vGpDAq5v8OQ2YgItvQ+JuV0ulr5sQxCVPiXQSkqNypy5DIj9MOkCnU5vhe
 lJKta/LvU3YluuHGgqyB2hyWzO344wxfv+tNcGLMLor8+HH5hB2iztvOCuCou+QzqCJX8CRPiS3
 vcwPDVgqgz3VBWuKc05UAXl86fN4v50ZgzqRAk1ChdT6DPckkIw0p/6ec1GGtf3O71Kd4KN3hXY
 LawZyWZDve3e6D1mxyA==
X-Proofpoint-ORIG-GUID: TJcW2ykqpNivEPAdUj-reQV25Dwq28FS
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a1c66a8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=VnNF1IyMAAAA:8 a=_A65o6AHPVp_Dz6V974A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-31_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605310179



On 29/05/26 7:40 pm, Gautam Menghani wrote:
> Currently, CONFIG_VPA_PMU is not enabled any of the configs, and

Not sure what is meant by "any of the configs" , distros ?
We could just say "not enabled by default" ..

> consequently cannot be used for KVM guests at all.

.. consequently cannot be used for KVM guests unless explicitly enabled 
on host kernel (which is currently ignored by distro configs)?

> 
> Mark CONFIG_VPA_PMU as "default m" to ensure it is available when KVM is
> being used.

I think title could have been rephrased to focus on "default m" enablement.

> 
> Fixes: 176cda0619b6c ("powerpc/perf: Add perf interface to expose vpa counters")
> Cc: stable@vger.kernel.org # v6.13+
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
> v2 -> v3:
> 1. Make CONFIG_VPA_PMU as default m so that it can separately disabled
> (Sean)


This indeed is more appropriate way for enablement, thanks Sean!

regards,
Harsh

> 
> v1 -> v2:
> 1. Rebased on latest master
> 
>   arch/powerpc/platforms/pseries/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
> index f7052b131a4c..74910ce3a541 100644
> --- a/arch/powerpc/platforms/pseries/Kconfig
> +++ b/arch/powerpc/platforms/pseries/Kconfig
> @@ -154,6 +154,7 @@ config HV_PERF_CTRS
>   config VPA_PMU
>   	tristate "VPA PMU events"
>   	depends on KVM_BOOK3S_64_HV && HV_PERF_CTRS
> +	default m
>   	help
>   	  Enable access to the VPA PMU counters via perf. This enables
>   	  code that support measurement for KVM on PowerVM(KoP) feature.

