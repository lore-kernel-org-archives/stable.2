Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545AC199E89
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 04:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783916967; cv=none; b=VAE7gzS9jpI1+IL2cm9Oui5ZAml1WkrYMO0gC4XfcVxqZAAhkGM/1/C8AlqYZ8c1dzQl14RMrk+VoAfppKNaoFJuknXOWnIPaDF7Hyy+9BcXYXyU2ayGJSuTbfs73qrcCDSW4qXKoOqiOcbhiRIl2Jjl6P2UglT/9mVP1Nacuo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783916967; c=relaxed/simple;
	bh=mLED0hJmg4ASORYh5XvXo3UWaYwNFjnuctfoZ+ZG7JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mTjFJpj8HdzMdNOk/wvEd3aKr7IOUMm/rlp470ru2MDawophXj/iwh30loYVrpF2lxlSwz/T9GPSbmmAXwW2ByhSgmu3kcaC2Lwm2rYdi3gYfqenJALBf95P8ewihJnkSE6cnrinTyjzy/i/5HRmnTLibPUN1Z1e7shk8KklL1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dxTULM+L; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dxTULM+L"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D3C4SQ1284114;
	Mon, 13 Jul 2026 04:29:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gzB7Qq
	83W0yurf5d0T9ewLmRHCVVnYYeLNCTLvL7itM=; b=dxTULM+LIah4Maiz++XkMS
	QaJ6Rd8Mxkmkw0TV0nYChHYvF+6MZf28OhMGYGTlb4BQDbhYFnrAY//cXMwIHLyV
	X9c19WMemFIPi4RESy+o0SByqSLLsrW6eQUcoXHOXbFmvZRHeusoA07mlL3vGr7n
	gbv7pzRTt14gSV72hTFCCWKpKeZmsrwjHwPGJEJ5YMovOudL6gXHAj9yKWpcU8Bp
	5bBoHSaI3M/fCcMnWbACuI9t38slqEH9h0D54QY3HLhlWVSLNMBzXqYSo+zMCbQF
	1JnQyoArr+LmEcQttT9wTq0EowVojW+Pg5XGaDu1aqZat86t6Z06H2BaGCLtRa7A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fber86kxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 04:29:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66D4K0GB001183;
	Mon, 13 Jul 2026 04:29:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hvv4w8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 04:29:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66D4TBqx32899572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 04:29:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6051F20040;
	Mon, 13 Jul 2026 04:29:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2177820049;
	Mon, 13 Jul 2026 04:29:09 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 04:29:08 +0000 (GMT)
Message-ID: <adaccc07-7ae6-4733-b29c-ca81547ed504@linux.ibm.com>
Date: Mon, 13 Jul 2026 09:59:08 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] powerpc/pseries: Move H_WATCHDOG definitions to a
 common header
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com,
        hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com,
        venkat88@linux.ibm.com, stable@vger.kernel.org
References: <20260713035954.1559605-1-sourabhjain@linux.ibm.com>
 <20260713035954.1559605-2-sourabhjain@linux.ibm.com>
 <se5nv7wu.ritesh.list@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <se5nv7wu.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDAzOSBTYWx0ZWRfXxeYZ3fbzjK3G
 btrQ0XpIt+DrWimtLaQ5bcN9iIv8ShrnefZXDIW66dk4IuE9aJuy63d35H70DU77Hj1K9dI7EMR
 5csSeK9VCvlyy5QummkIojFtcRPxCyZKbUZ4BijwKjcTaTZgXN8A4f8O8bfyR2WK1PWRo1sOtB2
 Y0FWgkbYtL11Y0LWJcXR2gOjciIezgnT8eDYgarGtDH4vfASeLyt+4VJOk3r9aS0PBIKzCbBfze
 lSzaWoo5Txk2nxQ2e9qajSuutEqG6hco+tPTs9r2dJ5RmTDcgGS1POQSihiP+IiWSi5+uQhWyx/
 ZyJ+1rGqzJL0RVgwfmcVcLXJbaWw1dkuSuJtiyVXGcEX79G01+CRexdfL6pODD6LYPHrNKJeptq
 grNWdT/Dvz/FKc+8d6hoUiegNUQhSQUuvYjOQN7k+Q+JjU2h1jEc/BAOHy9mTkreqYP+5vq6Jxg
 zz5ymRZ7wFnEpF1cltw==
X-Proofpoint-ORIG-GUID: KmurF7AQJxTT1siSrSkPNullBKf1MT1t
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDAzOSBTYWx0ZWRfX/e9nWWRdLST1
 pLf6r3xi0Ij3ILx7ZIzqnyfi210jCS4eGGt3eUrf3XReGhwcRnwFus8AD5uxXPrswjrEtSa/fnB
 YtQc5dt7ZCHjJyCvkLDS6/OC7JoVjdU=
X-Authority-Analysis: v=2.4 cv=TpzWQjXh c=1 sm=1 tr=0 ts=6a54699d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=pGLkceISAAAA:8 a=q2OaD_7NxbxaO4DEed8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: niqcrZRxeZdZ4yWFxIGV_wGD9IBOd4RY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130039



On 13/07/26 09:48, Ritesh Harjani (IBM) wrote:
> Sourabh Jain <sourabhjain@linux.ibm.com> writes:
>
>> The H_WATCHDOG input and output definitions are currently local to the
>> pseries watchdog driver. The next patch in this series also needs these
>> definitions to issue H_WATCHDOG hypercalls outside the watchdog driver.
>>
>> Move the H_WATCHDOG definitions to a new common header,
>> asm/papr-watchdog.h, so they can be shared without duplicating the
>> PAPR watchdog definitions.
>>
>> No functional changes.
>>
>> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>> ---
>>   arch/powerpc/include/asm/papr-watchdog.h | 58 ++++++++++++++++++++++++
>>   drivers/watchdog/pseries-wdt.c           | 53 +---------------------
>>   2 files changed, 59 insertions(+), 52 deletions(-)
>>   create mode 100644 arch/powerpc/include/asm/papr-watchdog.h
>>
>> diff --git a/arch/powerpc/include/asm/papr-watchdog.h b/arch/powerpc/include/asm/papr-watchdog.h
>> new file mode 100644
>> index 000000000000..fb3a511aa861
>> --- /dev/null
>> +++ b/arch/powerpc/include/asm/papr-watchdog.h
>> @@ -0,0 +1,58 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +
>> +#ifndef _ASM_POWERPC_CRASHDUMP_PPC64_H
>> +#define _ASM_POWERPC_CRASHDUMP_PPC64_H
> should be _ASM_POWERPC_PAPR_WATCHDOG_H

oops my bad. I will fix it in v3.


>
>> +
>> +/*
>> + * H_WATCHDOG Input
>> + *
>> + * R4: "flags":
>> + *
>> + *         Bits 48-55: "operation"
>> + */
>> +#define PSERIES_WDTF_OP_START	0x100UL		/* start timer */
>> +#define PSERIES_WDTF_OP_STOP	0x200UL		/* stop timer */
>> +#define PSERIES_WDTF_OP_QUERY	0x300UL		/* query timer capabilities */
>> +
>> +/*
>> + *         Bits 56-63: "timeoutAction" (for "Start Watchdog" only)
>> + */
>> +#define PSERIES_WDTF_ACTION_HARD_POWEROFF	0x1UL	/* poweroff */
>> +#define PSERIES_WDTF_ACTION_HARD_RESTART	0x2UL	/* restart */
>> +#define PSERIES_WDTF_ACTION_DUMP_RESTART	0x3UL	/* dump + restart */
>> +
>> +/*
>> + * H_WATCHDOG Output
>> + *
>> + * R3: Return code
>> + *
>> + *     H_SUCCESS    The operation completed.
>> + *
>> + *     H_BUSY	    The hypervisor is too busy; retry the operation.
>> + *
>> + *     H_PARAMETER  The given "flags" are somehow invalid.  Either the
>> + *                  "operation" or "timeoutAction" is invalid, or a
>> + *                  reserved bit is set.
>> + *
>> + *     H_P2         The given "watchdogNumber" is zero or exceeds the
>> + *                  supported maximum value.
>> + *
>> + *     H_P3         The given "timeoutInMs" is below the supported
>> + *                  minimum value.
>> + *
>> + *     H_NOOP       The given "watchdogNumber" is already stopped.
>> + *
>> + *     H_HARDWARE   The operation failed for ineffable reasons.
>> + *
>> + *     H_FUNCTION   The H_WATCHDOG hypercall is not supported by this
>> + *                  hypervisor.
>> + *
>> + * R4:
>> + *
>> + * - For the "Query Watchdog Capabilities" operation, a 64-bit
>> + *   structure:
>> + */
>> +#define PSERIES_WDTQ_MIN_TIMEOUT(cap)	(((cap) >> 48) & 0xffff)
>> +#define PSERIES_WDTQ_MAX_NUMBER(cap)	(((cap) >> 32) & 0xffff)
>> +
>> +#endif /* _ASM_POWERPC_CRASHDUMP_PPC64_H */
> ditto
