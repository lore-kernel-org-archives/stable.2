Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7813EC6BF
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786991312; cv=none; b=Qx8ofQt7aGqLE11Cczqx+7YnTqlOVSJqmk7uvw0TrL+01wghJmYDr6MSNAUepwqin/53U4MxKtXUNP4BlIfq/w42y+BQO6GftW0hjZaSAdbxJPN0+pDW1bpc2BQh/wiPFjFnqt9mqxe3Ss2nC233A2bFU9WirPna1n6jtMCvW6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786991312; c=relaxed/simple;
	bh=5EG8njxr+CeURbJ05o57ajpnWIvGsmM/lOVACOGo2JA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Whx9y/8F23SlWCg+awYjHUxzQno+XCdcQkUdKxQma3OE5rp8K+VlJrPg3qqXqXJ34styvfkwfmwGaLIpI0xKM/Afr+0HcHK3oR4lnTBrJceCMYfKNPRdj8DKSeAIDhmw27hxdKNCv+eJ74JA2mEA/PeoMTir01DH8sNJe+eIeC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M7BItaAA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M7BItaAA"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HFfghc1805998;
	Mon, 17 Aug 2026 18:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EvoCnV
	VZrXb+hd1Av7gT6at0ZVFeSRiGXwhQ9lpndWE=; b=M7BItaAAQdVLcR5aU3CATj
	vqCp2urM60bf7UZtffqjK5okDdfq4+pg/KzUIgEvD7Y4BlD8p6euMriv2yIdxmCg
	Pd3yU60MN8SVsZgSlXau8wjfwxFI5Zl2sgG8DvH+gNtU0Nb34GAOmE2fG0O0zUfj
	IP2RdivcdkVKQ7a+uMeX4wlGgQ2+qrXxGWcCYPCaWOTv4NSJJPe7jh5RTkZWDL9q
	Z7hs/lrZqiMwsqgP8EBQ9OWeuDc1ipD1tk3shBp7TDkq4tFxOdIUi5N2IT/0wTS1
	ZhOt6mxiCPjj1FCld9fJhMAhWJg6lTf3XPaaiuiKLIRcgysqjBQ4gSi92qYt269Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4ksq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 18:28:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HIBU7V003151;
	Mon, 17 Aug 2026 18:28:27 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32epycq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 18:28:27 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67HISQgM20054610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 18:28:26 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FD8D58059;
	Mon, 17 Aug 2026 18:28:26 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E10D558053;
	Mon, 17 Aug 2026 18:28:25 +0000 (GMT)
Received: from [9.61.242.71] (unknown [9.61.242.71])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 18:28:25 +0000 (GMT)
Message-ID: <16b91460-a975-4f9f-b47c-a56dbe1cb319@linux.ibm.com>
Date: Mon, 17 Aug 2026 11:28:22 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 stable 6.1 0/8] s390 KVM PCI backports for 6.1
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        gregkh@linuxfoundation.org
References: <20260812221323.3645-1-alifm@linux.ibm.com>
 <20260814193000.8@kernel.org>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260814193000.8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HeqSyfS29Eo6tQlSlCoeGO3lKkwhhHzH
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a8352cb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=CJ_nNy1GpN8eVH1GC_kA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDEzOCBTYWx0ZWRfX2Q3OnDUI3pAs
 Qutx/8fZfe87vOuYg/xLlLM0pXAHHnk4dDCTwdldaquSKOtJ6gTZv/X/65kHiBZjQkLxjV/uqbw
 18C3kBlI1lK1HARufG9xyp6rvXP/mfo=
X-Proofpoint-ORIG-GUID: HeqSyfS29Eo6tQlSlCoeGO3lKkwhhHzH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDEzOCBTYWx0ZWRfX+3CNfjPU4XEk
 DaOEu4GAFUMIY1qX25qJEP5d2Il0uj0kLiYjoN9NDl42s/FH2xMicewJRsBS7WzxM4uc+89+o+W
 ueGiDjkknsHqWAIAeXyaceDB5agQzIolXPqpvgFri1QSMn961+yoH955/qyAZzpSkYlhofVRgLw
 2unXkAXXkNMhLMFCrkwGqEywZpIHPY+DdrJz3XnNEeP7RQiPizHGWUWJQU7KToTafSdixqey2ww
 SVq6wENabbOEZSTLOqh6N5+bxEPLKEbKWRtYXbkrrzQx9Nz5pnTgRnMWlt8a4cI0Z6dpZmS2VIq
 t73DJ91WDnozL37fQIF8G0JorFXOLgSLV89vO/1P2ENaTfDpv5BOMOpAygYiq9hqwYfzvB3B9mr
 GvNyeDnBWs5oCa0UePUaWd5l/63uHpARHegAbVDwc3UqBidnTdkfzDMrhPC5peDa327TtO5pxEn
 TGZt9knVrIiHclH3Yjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170138


On 8/14/2026 7:33 PM, Sasha Levin wrote:
>> This patchset backports the s390 KVM PCI fixes to stable-6.1. The patchset
>> includes one dependency patch (patch 1) from Jason Gunthorpe, to export
>> free_uid(). This is needed to resolve a compilation error. I have resolved
>> all other merge conflicts and tested them on s390.
> This one is based on released 6.1.y, but the 6.1 queue already carries 2/8,
> 5/8 and 7/8. With 5/8 queued the free_aisb: label sits ahead of unlock:, so
> 4/8 no longer applies at all and a 3-way merge can't recover it either. And
> taking 3/8 without 4/8 would open a fresh unbounded mm_struct/user_struct
> leak, so a partial series isn't an option.
>
> Could you rebase onto the 6.1 queue - drop 2/8, 5/8 and 7/8, and re-resolve
> 4/8 over the free_aisb: block that is already there?

Yup, will send out a new revision dropping the patches already merged to 
6.1-rc1. Didn't realize 2,5, and 7 were already applied.

Thanks

Farhan

