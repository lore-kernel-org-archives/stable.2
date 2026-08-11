Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5173E2770
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 18:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474793; cv=none; b=KtMmIOW9rCsYOSpoBcrtidZaiw6AOxmRUPMxpAnzcJj+fLHlmioJDnpbgAjOnPY8BPvuxrlXb2r908px9pO+KPUygPsZygaxloDYYC8o2ot6zeUBX1klp9n+G2w66yMlNYsT9ZH7H58BEdFprGPTT90q3/WAI9uWnECUOBHZlgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474793; c=relaxed/simple;
	bh=T+gHEV00Gllmj5JnGI7Qi7oVyBbhUnj9hg7HeoQ9mck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YpFrzGzamvB9xwsCBsPRCZe8A6tG/Rk2Kv6CphUGz5rbnHfHr8eDDCtt/YAy2tjdE7BjlCN1SdbvN8ir8xWA6EUCDCgZTCFQk3h2RJZogckoWTBVJP8APg5E+hzoiMWtvygnBuhGkieHTuur4NmGpPfUXZqgfFmDKmkIghbu9X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=meWHuiT/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="meWHuiT/"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGVa903260708;
	Tue, 11 Aug 2026 18:59:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Jg+s4w
	wL9Z/fE/XigULxmCKSwMA0I0c9ncBWmOlZuys=; b=meWHuiT/j3J9hX922pqfM7
	reklj3mbl0l7ECuAGVGMx1HISQEW9PNzDURXJL+T42W4kLfK3V2LgxHuAzNX0Lq/
	XTTLEQtzMwPN/jUdPoOAxFcF0+AcqVpmwfONu96oeqIrRkJiSmwqXc6nlou14Vdn
	UpGUGZcx4qMgb8RMV3EBiQShR2x7AzObpG6sLjMK7hJstc86r8GP4JnwL+D6Zzp2
	V4z/Mhpi9Ny6kT+PUJUWNMeTbVv47v9PZr8r2Fd/UBw4REd5b/0aiBXkv+n+Njt2
	Iz5vSL+VFteAbDzVzi1AgfOE8oP6CiSs0KMW12h6yggdlSQOef+nqpX5XzRChxcg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjyxk3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 18:59:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BIuKZZ011682;
	Tue, 11 Aug 2026 18:59:46 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w2f9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 18:59:46 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BIxkso14025256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 18:59:46 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F166C58052;
	Tue, 11 Aug 2026 18:59:45 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F33D5805A;
	Tue, 11 Aug 2026 18:59:45 +0000 (GMT)
Received: from [9.61.240.229] (unknown [9.61.240.229])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 18:59:45 +0000 (GMT)
Message-ID: <dd24992f-c226-487a-8587-bc824c1a4707@linux.ibm.com>
Date: Tue, 11 Aug 2026 11:59:44 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 stable 6.12 0/3] s390 KVM PCI backports for 6.12
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        gregkh@linuxfoundation.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260810182128.5458-1-alifm@linux.ibm.com>
 <20260811184500.stable-0008-sashal@kernel.org>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260811184500.stable-0008-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX6WDcaRJm9OIg
 e/2O4cX+zC6TNDQuXjsuVicjK+8nFvbBn8XOHlPxGdkd3K/00PkkAJVFJPWkLEOKOHf44JroPBf
 eIi04P6xl8yg2V85mbAiQstGqrqXGPnBTCe2IbXqdO6/LpTJRGUaKyNEPuZ1XBZzhr0nYI3UmQ8
 K2Iq5lKeOYwLGnpa02tj9KyQo8IKNwLy5V8jgXHNOHzxyCWS4Ls94TJvhYxEHgv6heZTi51JFKu
 P7OzP3Wyovedb/c/09ZstehN6zGTjSeCixPgul4urrC9d+/Ve+Mzsq9EWqB/dYShAuI341GDvtf
 gnBswjC9yyyRZs4IG3tE8iAkEuBa0kH/wmo0foT0CVvD70mzKB13cC1s4oVV2Z04OhG6Z04hr6i
 tnTl4Oj5LUjF5HMBZXIqQAmpfXZ9mpje/er8PfxPpFcythYFKdoVzeRpTRYeHiufTT6cvo2PIjF
 mOV4MspeVJsPEsOZUlQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfXxmY6DmWp2/cx
 luan/hYKXpmgHhJ3oyAVo01yURrgc9SIP7YHlpLBu0+ZiEvumVnPdNppY1Ab5ZiNTg4Iunvapll
 EK5r5LjfEkNKyLDt+sfNqQ0oFf4iAXY=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7b7123 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=CzoABr1io2YOvvHH3BMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: iMzUUmpkRyU1jqKbK6DUDuTDhOtcruLY
X-Proofpoint-ORIG-GUID: iMzUUmpkRyU1jqKbK6DUDuTDhOtcruLY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110155


On 8/11/2026 11:55 AM, Sasha Levin wrote:
>> This patchset backports the failed commits to stable-6.12. I have resolved
>> the merge conflicts and tested them on s390.
> Thanks for the respin - this one does apply, and 3/3 now falls through
> into free_aisb: the way mainline does, so both of my objections to v1
> are addressed.
>
> One thing left in 1/3: the conflict resolution keeps 6.12's existing
> in-loop
>
> 	cur_pages = atomic_long_read(&user->locked_vm);
>
> in account_mem() as well as adding the pre-loop read. It is harmless,
> but it is the only line where 6.12 would then differ from mainline and
> from 6.18/7.1. Could you drop the in-loop read and resend? The same
> artifact is in the 6.6 and 6.1 submissions.
>
> While you are respinning: 0cfe660559e8 ("KVM: s390: pci: Fix aisb
> calculation") is missing from 6.18, 6.12, 6.6 and 6.1 - only 7.1 has it.
> kvm_zpci_set_airq() on these trees still computes the AISB address as
> aift->sbv->vector + (zdev->aisb / 64) * 8, which goes out of bounds past
> 64 forwarded devices. Could you or Matthew include it in the resend?

Yeah, I can send that as part of the re-spin. Will send out updates for 
all the relevant backports.

Thanks

Farhan


