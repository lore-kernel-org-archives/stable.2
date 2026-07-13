Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170FC3E024F
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 11:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783942299; cv=none; b=n4UT8RNJzTsNpGI8gZClyOD6NwPNUbSI15cwb8DwUsjwzOWmR4BX0fV87WZQvyKsaKX6elLbJ4quf7zbt39bV2lVzpOhtP7Qw1p3wYdY2mC+Z0Z/Wwxx58T9qgMHLNdScsKgNWpjvyeTfBEqK5p61Hhs+5B6KFrJDGdy/cEiG8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783942299; c=relaxed/simple;
	bh=Q8Rf6fKvbAhR9WnyK7czzX2GKQj2cyZVMqzE/1DXZF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=On5G4JMG0pPyNZP///3dDBCx1pDwYAtKzf+z4kpPWpnwNVh7yw6yAmWlc3XLbZMAKFPzgKhkHTQVOreyipDdRjwvvk5OsVRXo32Qb+iD4sivQLrv5LGcAi5vt5lOyeL1gPuBxIlDolNDxMtz9laCtjvZB0/gKvl+kYd3v+bI1uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NFZq0nT6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NFZq0nT6"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6g7tj1732367;
	Mon, 13 Jul 2026 11:31:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=291z0i
	My6ACy4umd+5gN9PHfheorz4UXB4xEyqm+dHY=; b=NFZq0nT64XkNedVp2mXpkF
	NNcyBfJkpAtKROEnPirAHadXIX1DXXSxwrXFkYtvQBbsvk4RZ830+dwCLBtJOz/Y
	q0RDoKuHDXOl0nuDOwIC8P+6Mu5Z6AX0skkMYd1PQ6D3NvCg5eYLW468ScZKYG9d
	AfqgwFtB4yIjHBj9s8SOvklEem2t8L65Uvgjxe3UykVGZX9BpN4Nhr6z/eEwRpHy
	6ImeWJg2i5q95ypErjwuQ5vMRG6MUbpfDlVOaXvanfFjizeTi900TskiqCbJNCpJ
	WEoaMMywIRd0dQsKgPEQ3/GRdOmkgBG9zdG8K0DnOU1dRTR6sr22RQaNmnBrfczg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbg12a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:31:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DBJZVd003984;
	Mon, 13 Jul 2026 11:31:22 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cg566c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:31:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DBVIBQ45023666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 11:31:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64F0E20040;
	Mon, 13 Jul 2026 11:31:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDF1520065;
	Mon, 13 Jul 2026 11:31:15 +0000 (GMT)
Received: from [9.123.14.142] (unknown [9.123.14.142])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 11:31:15 +0000 (GMT)
Message-ID: <a5f57d59-a246-4279-946f-2e41d1b438a7@linux.ibm.com>
Date: Mon, 13 Jul 2026 17:00:33 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] powerpc/crash: protect kdump from active watchdogs
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com,
        hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com,
        venkat88@linux.ibm.com, stable@vger.kernel.org
References: <20260713035954.1559605-1-sourabhjain@linux.ibm.com>
 <mrvvv515.ritesh.list@gmail.com>
 <91e04278-aa90-4cbc-aeb4-f4663bf1f058@linux.ibm.com>
 <ldbfv1dl.ritesh.list@gmail.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <ldbfv1dl.ritesh.list@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a54cc8b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=cAh3PJzBWdOWiawSA5MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExNiBTYWx0ZWRfXyFuHFQ31p+z/
 C6EH7EwaVouCanqpcEB3Qk5wqoiLIBcVOp0eZOCMADOp1nKPbZSE5eKSiFH1ruBg8kczUQv1d26
 xXUUC6d/rtdF37wdsogVSxU084yuNZUOo3+cUTEGIuqV2czj23Y8vKWQ9fKIQhaDt29JBbaAb5Y
 dL2kXOjUNKzzkZc0EaNcAww8WE/kClwoBH6q2E5CAveVDekTdFXO+3MK9db49r7ZkefChm33007
 PKFLncTLefcCJtrY1kWbWgYs0UJHs1jwd5X5JHDbuhpFmf/uliEXQeKwHlinUZDAfwwW4ImAo1a
 puP8T32XgY655rZkjQwpZdSam0+PzpgvTTkV/r4LD2xZhI/pdMnmBLIMYn8SbbRSQy1Ae2izqTt
 Vgu/sIUvz6fV0+sI5MJpWVPgLMm+91pZTQZuzAFwFY/JlLJAVfi/ndbuYCp18tnlnD+A+dW5JXd
 F2tsU065dVLDYQxCFQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExNiBTYWx0ZWRfX9zzHD1JtMzDg
 DkX4H0AoeQvdZDu5kDiBefEycNkO12CmnJP91HdcKd4r92PNjndycDQARMUvJzeDltwe64WEfam
 1wHecTJEPnPBPAu12MOEN6dVlwt84cQ=
X-Proofpoint-GUID: QUZmTu88xlQjl44bX-V08oYhYM9Ha9lb
X-Proofpoint-ORIG-GUID: OtDU0bq9Lo8498ENEvjsZ6iwpt4n7laq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130116



On 13/07/26 12:10, Ritesh Harjani (IBM) wrote:
> Sourabh Jain <sourabhjain@linux.ibm.com> writes:
>
>> On 13/07/26 10:51, Ritesh Harjani (IBM) wrote:
>>> Sourabh Jain <sourabhjain@linux.ibm.com> writes:
>>>
>>>> Changelog:
>>>> ==========
>>>>
>>>> v2:
>>>>    - Move H_WATCHDOG definitions to a common header for shared use
>>>>      across pseries code. 1/3
>>>>    - Added a new patch to handle pseries watchdog device registration
>>>>      failure. 2/3
>>>>    - Stop active watchdogs in crash hanlder. 3/3 Ritesh
>>>>    - Add suggested-by tag 1/3 & 3/3
>>> Reviewed the changes and mostly looks good with some minor nits added to
>>> the individual patches.
>>>
>>> Small request -
>>> Could you please also update test results with v3 in your changelog
>>> (since you mentioned we are able to reproduce the issue easily with your
>>> test code).
>> I tested this fix with the program I shared in cover letter. The watchdog
>> was successfully stopped even when H_WATCHDOG is called form crash
>> handler.  I will share my test details in v3 cover letter also.
>>
>>>
>>> aah one other thing I just noticed since you are ccing stable and you
>>> added a Fixes tag in patch-3.
>>> Patch-3 alone cannot be easily backported now due to patch-1 and
>>> patch-2. There must be a way to define the dependencies if you are
>>> looking for backporting the fix patch to stable tree, please check that
>>> and follow that accordingly in v3.
>> I thought about that as well, but since they are part of the same patch
>> series,
>> I assumed they would be picked together. However, I don't think that
>> will work
>> in all cases.
>>
>> I checked the older commits and noticed that a backport note was added.
>> I think
>> we can do the same for the fix patch. I'll add a note indicating that the
>> following patches should be backported first:
>>
>> powerpc/pseries: Move H_WATCHDOG definitions to a common header
>> powerpc/pseries: Handle and log pseries-wdt registration failures
>>
>> Since these patches are not upstream yet, I'll refer to them by their
>> commit titles.
>>
>> Does that look good to you?
>>
> Documentation/process/stable-kernel-rules.rst
>    Note that for a patch series, you do not have to list as prerequisites the
>    patches present in the series itself. For example, if you have the following
>    patch series::
>
>      patch1
>      patch2
>
>    where patch2 depends on patch1, you do not have to list patch1 as
>    prerequisite of patch2 if you have already marked patch1 for stable
>    inclusion.
>
>
> In that case, I think, we should mark all 3 patches for stable inclusion.
>
>    patch 1/3   Cc: stable@vger.kernel.org
>    patch 2/3   Cc: stable@vger.kernel.org
>    patch 3/3   Cc: stable@vger.kernel.org
>                Fixes: 69472ffa6575 ("watchdog/pseries-wdt: initial support for H_WATCHDOG-based watchdog timers"

Okay, for stable tree inclusion, CCing is enough.

Thanks
Sourabh Jain

