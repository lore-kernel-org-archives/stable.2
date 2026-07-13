Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB9F25B0B8
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 13:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949934; cv=none; b=q/JQOzqTxxPN/HD3bar2lPRdiiAOfIyV2q6uNGVhqqIc9W1QhRlYSc3Z/Yg6JthbqPmxTDIY1WcrQSM8rT0tICIG3V8q+6RrT07k/ZM9X6w/Xp8LykUiPfv37SwfwbxXRhW2uu7QE3kHp9S4Tl1Fwk1+GV0ZJVhqfAEhTve4eZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949934; c=relaxed/simple;
	bh=VNJ+aQGkfU0BlfZtvrfPEZeQ86VyfkR7rVu407KYYqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHorF9r2+TRUO33GzZRw/k5X0ZQz+EahSKkk/8dYVznOlazI6NR8GX/CH+lWa55qzqBHjgT8jsD/oQnOZjYRTEXpmcuxz2X1ME3nh9nqpL9k2BlrYruMgQtRCqxt5Pbmm8HtuvHp8qc/3w0Zn9mms6hq/dYhSoGeyPgKE9pttpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=osqxt6al; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="osqxt6al"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCDH4j2437906;
	Mon, 13 Jul 2026 13:38:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QDT6Nx
	UXtQ0d7xpPP4Zq7vIAgPv2bMd/AWmrj8RSsp0=; b=osqxt6al24b5Ab5z3NPTRc
	sQUUDJIpfcrYtMYlCXYdx6gBifAx0jP9f3UEn7c7Mk+Tt8NK4mrCrsn8NUVjSgWA
	+GScONzIT7Ta0DRYcC34/XDLdff4CvNgRg5p+OPWFDtfcJwFTKtczOnmpfINuvl7
	qiQZzerr8e1PzWIOf1on5oG+NshlNOJ+1BINMXl1sxbGcvLR1HaaxOXMpxWCO0T7
	Jaxec/QAySgbvbWlrg4KZmqheQ2mGAq3eueRNB6BGb7RKSZwlBdniLnYb9O37OdF
	A49xN6BrypyhHJWHy+YgkitdNvOaj9OQzp+VbQPhwfIhzY9m2cGp/EtIg7PYKIQg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepx8v75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 13:38:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DDYlq8024929;
	Mon, 13 Jul 2026 13:38:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uxwjud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 13:38:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DDcaLe30736916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 13:38:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B212420043;
	Mon, 13 Jul 2026 13:38:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D16C820040;
	Mon, 13 Jul 2026 13:38:33 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 13:38:33 +0000 (GMT)
Message-ID: <eaf57ed1-216c-4ccf-9418-d3ac3e32f078@linux.ibm.com>
Date: Mon, 13 Jul 2026 19:07:51 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] powerpc/crash: stop watchdogs before booting kdump
 kernel
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com,
        hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com,
        venkat88@linux.ibm.com, stable@vger.kernel.org,
        Mahesh Kumar G <mahe657@linux.ibm.com>
References: <20260713035954.1559605-1-sourabhjain@linux.ibm.com>
 <20260713035954.1559605-4-sourabhjain@linux.ibm.com>
 <o6gbv5jl.ritesh.list@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <o6gbv5jl.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: cwabT_ne3oPpz8luNwdtUvsIYdM6W-bT
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEzOCBTYWx0ZWRfX3gaKfNxfCtpE
 hKki+iv+VDoZPT7LSnfYQ+ch4liiXbB+k3SxuMspwTbG4SqzZgxrAH5vtqakxzEfG4yJwLxtqm2
 +JHLm1HJ/4r3QDTnlxQ7UfItDsy4L+M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEzOCBTYWx0ZWRfXwITQfhe7hiGP
 CKcdJuOP4h+FVNPU+M2Kjs+nffiRVKRK/cO3M7kTpdaWTXmml9YNnsMusJ1iLDlUKAma3Yr4vFW
 izEKwnoUE1+PwRdDpDR6k/NionnitXOU7EZslMME4VAZM3gMfn98arEcFymY2ABagYqdF2Z6bJo
 OfN41XlcCKUrN42KkFcE2bmt2akGlOVDgqCJUcj7fkNjxlplClL7XkTd7RX0xQDWxcYi5FsfJoM
 Aq6aWff3FJDrjwbYF4qWvo0oKpAOptmyqBtT/7AB6qvrqQladuJn1IZwhv290TwAwo0F7LnrOjv
 y7nu6yZGrgSLPROwxM8ALEMIn2Gq9A/NbsffLUltDLMulP09jM83B5YzjZVKM0pXIzsXg6/tLK4
 aUl+UEOFHTyTp5Acx4BtgNkw/ZNAbzQOXTRGkR57M0vzQ1gBTIvBbHKpJq85CeBzgODbQA/j3Vz
 JCSidm851+98zKdP41g==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a54ea62 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=D1YSW_bcgk-0_7OrHpMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: XlhPyuiRcGrhvbLG99jKz4skMF3Aw6eA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130138



On 13/07/26 10:40, Ritesh Harjani (IBM) wrote:
> Sourabh Jain <sourabhjain@linux.ibm.com> writes:
>
>> On pseries LPAR systems, watchdog timers configured from userspace can
>> remain active after a kernel panic. When a panic triggers kdump, the
>> crashing kernel jumps directly to the kdump kernel without stopping
>> active watchdogs. As a result, the watchdogs remain active after the
>> kdump kernel starts.
>>
>> If dump capture takes longer than the watchdog timeout, PHYP resets the
>> LPAR before the dump is fully captured, causing dump capture to fail.
>>
>> Fix this by issuing the `H_WATCHDOG` hcall during the crash shutdown
>> sequence to stop all active watchdogs before booting the kdump kernel.
>>
>> Fixes: 69472ffa6575 ("watchdog/pseries-wdt: initial support for H_WATCHDOG-based watchdog timers")
>> Reported-by: Mahesh Kumar G <mahe657@linux.ibm.com>
>> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>   arch/powerpc/include/asm/papr-watchdog.h |  2 ++
>>   arch/powerpc/platforms/pseries/setup.c   | 18 ++++++++++++++++++
>>   2 files changed, 20 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/papr-watchdog.h b/arch/powerpc/include/asm/papr-watchdog.h
>> index fb3a511aa861..84bbe1ddd56f 100644
>> --- a/arch/powerpc/include/asm/papr-watchdog.h
>> +++ b/arch/powerpc/include/asm/papr-watchdog.h
>> @@ -55,4 +55,6 @@
>>   #define PSERIES_WDTQ_MIN_TIMEOUT(cap)	(((cap) >> 48) & 0xffff)
>>   #define PSERIES_WDTQ_MAX_NUMBER(cap)	(((cap) >> 32) & 0xffff)
>>   
>> +#define PSERIES_WDT_NUM_ALL	((unsigned long)-1)
>> +
> minor nit:
>
> This should be defined at the end of the H_WATCHDOG Input section.
> /*
>   * H_WATCHDOG Input
>   *
>
> <...>
>
> Something like this maybe?
>
> /*
>   * R5: "watchdogNumber":

Makes sense. Since this is the third argument to the hypercall,
R5 is the correct register to use in the comment.

>   *       PAPR says use -1 (all ones) to stop all watchdogs.
>   */
> #define PSERIES_WDT_NUM_ALL	((unsigned long)-1)
>
> /*
>   * H_WATCHDOG Output
>   *
>   * R3: Return code
>   *
>   <...>
>
>>   #endif /* _ASM_POWERPC_CRASHDUMP_PPC64_H */
>> diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
>> index bbb2813f8ede..2e40a9dba637 100644
>> --- a/arch/powerpc/platforms/pseries/setup.c
>> +++ b/arch/powerpc/platforms/pseries/setup.c
>> @@ -77,6 +77,7 @@
>>   #include <asm/dtl.h>
>>   #include <asm/hvconsole.h>
>>   #include <asm/setup.h>
>> +#include <asm/papr-watchdog.h>
>>   
>>   #include "pseries.h"
>>   
>> @@ -185,6 +186,18 @@ static void __init fwnmi_init(void)
>>   #endif
>>   }
>>   
>> +#ifdef CONFIG_CRASH_DUMP
>> +static void pseries_crash_stop_watchdogs(void)
>> +{
>> +	long rc;
>> +
>> +	rc = plpar_hcall_norets_notrace(H_WATCHDOG, PSERIES_WDTF_OP_STOP,
>> +					PSERIES_WDT_NUM_ALL);
>> +	if (rc != H_SUCCESS && rc != H_NOOP)
>> +		pr_warn("Could not stop watchdogs before kdump rc=%ld\n", rc);
>> +}
>> +#endif /* CONFIG_CRASH_DUMP */
>> +
>>   /*
>>    * Affix a device for the first timer to the platform bus if
>>    * we have firmware support for the H_WATCHDOG hypercall.
>> @@ -203,6 +216,11 @@ static __init int pseries_wdt_init(void)
>>   		return PTR_ERR(pseries_wdt_dev);
>>   	}
>>   
>> +#ifdef CONFIG_CRASH_DUMP
>> +	if (crash_shutdown_register(pseries_crash_stop_watchdogs))
>> +		pr_warn("Could not register watchdog crash shutdown handler\n");
>> +#endif
>> +
> minor nit:
> I don't think we need any of the #ifdef. All definitions used inside
> pseries_crash_stop_watchdogs are already available and
> crash_shutdown_register() already exists for !CONFIG_CRASH_DUMP, so we
> may as well drop all of the ifdefs.

Yes, the #ifdef is not really needed  because crash_shutdown_register() is
always available.

I removed the #ifdef blocks and built the kernel both with and without
CONFIG_CRASH_DUMP. The kernel built successfully in both cases.

>
>
> Otherwise LGTM, so feel free to add:
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Thanks for the review.

- Sourabh Jain

