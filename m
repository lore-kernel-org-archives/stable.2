Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04748298CAF
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 17:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786383124; cv=none; b=MUKzIgN6xKFmzJ8wui2bM2s5tJMJEiHv92ymcyEOAQPB0udpLXx+VskpakUMnKNZEFIaH3Ou4WwWKliHEiWbxNtJUSe5WAiJw2gGzm4iqLzzRJXcxnH1ih/J0uWoSJjivYmufMK09VeTzD+bed46YGfcsH2ahm9WMevjUsKcn40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786383124; c=relaxed/simple;
	bh=kMW7ZX9wgVy/j++hFOCusKB9PrxQmqAbys6v+1rlm/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=iNJ90f5xKJ6Ja1a/eyhisaFjBtIcRJgC8osByqQQ7Cja1EkILQ98jeMqCs80GGekT3w4L4jYEZyo5XQOi7JKkuoq71M4ZeowFUn51NC2Pxw+4IAoyoNeiEZ7/hzIlBL1WUG+ypn47AZqKzCdZVIasRzqnqaj3ny5HZZF9tHSuFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cQZ98i0f; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cQZ98i0f"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AGW7A62155535;
	Mon, 10 Aug 2026 17:32:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CN9V+W
	lP8NeAI/KTCaMXu4L7medWONDqi3zXnMbC1c4=; b=cQZ98i0fvhSe4nHo8Wqubm
	2eLhr8QsNAthCaHNEsR62WlO7WoNZ2+jH4QMW+ybF/jqeZVjPmKFaZ9IC035Hc45
	LGRgfYNOZEwyqS5j43W0Ib7+6nxnUySQCxIvymAQorOgvVb/Aj5cQp4SOprVqZdP
	Ij8ewqQRqC2hK5dwpgvVeKU+8U0irnXLgm3lp94EqDrJqG+oEyJsZQf4DFJWO2/c
	Z2MKNClxvI4kPC3UIZJe8Ij5L6kXEscO+M+T/FnGLMyYyyUrpR3m7/Lii7qvDRfu
	oqX4R2UhD5ylbPW2xRtwaG0IIYNbSKYN/IjUl2te+5iEtn4M2VaLkMWXTieN6TUA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9had0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 17:32:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AHQI2Q024708;
	Mon, 10 Aug 2026 17:31:59 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g5n92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 17:31:59 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AHVxDI40239428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 17:31:59 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE6DC58059;
	Mon, 10 Aug 2026 17:31:58 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BEAD58063;
	Mon, 10 Aug 2026 17:31:58 +0000 (GMT)
Received: from [9.61.246.243] (unknown [9.61.246.243])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 17:31:58 +0000 (GMT)
Message-ID: <bf43fdcf-c6e1-4e45-b40a-e79fce3f43d5@linux.ibm.com>
Date: Mon, 10 Aug 2026 10:31:57 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH stable 6.12 0/3] s390 KVM PCI backports for 6.12
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        gregkh@linuxfoundation.org
References: <20260807174551.2359-1-alifm@linux.ibm.com>
 <20260808221923.stable-0003-sashal@kernel.org>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260808221923.stable-0003-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE1MCBTYWx0ZWRfX47G6N2EKcPAs
 UrDaHrdvT0whFhjRevi8wyi38fz4iLSIHaviXj8fbF0fi1TyAGO5RQYWadp/FEFTNdNmTgdDeEL
 QAFL4LveCevN1jNvco8dXulw6Pyd6OhOdJvWK1RVUKU6Ww7bbRBuHs5wzvQfnrNFxUbu072ftee
 9MNbD3tngqIQp7SlagsOB2ik4V298w25BV0/zMeB/pMufBNqqNgf66dNy5TBOWX2i2A6wCeKAI4
 bCt2uN3n/pG0G/O5fjrreYMQVudJs773WiwwwuBOFGmCuC1R8ldF1rP2+qS9dr/16CZ//Mutarc
 ZiTPomOk49A5yt/gYu5CT0BX/Q7S47Z5KAIUp8YCL6t1ku0iXBcSt2cLuepmtetdIFeweY7LeTN
 QVxAy4NJgLos+rCZD2CdOdRZfK+vIZrbfhp3ZkVNZdKsK7Aq63lWAARpNEWRZf+DISYwMhY7lYl
 mXWuSLdBXzMmjZErqhQ==
X-Proofpoint-ORIG-GUID: JpljSkA4atz-olJ6zwytcrOcuXzD6pVw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE1MCBTYWx0ZWRfX803L/10okivX
 WAeXmO2XPdl1iwudoDPd8TThJaf5ioKDU3RvQ43LDlKBYGPJ7wJftamQDAgkjUdVqLiBa/XNmQj
 ClwZWXK5BGObXYmjKsmPMNSV17o6470=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7a0b10 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=NQ9i5REQnapBJRyTy90A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: JpljSkA4atz-olJ6zwytcrOcuXzD6pVw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_04,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100150


On 8/8/2026 8:25 PM, Sasha Levin wrote:
> On Fri, Aug 07, 2026 at 10:45:47AM -0700, Farhan Ali wrote:
>> This patchset backports the failed commits to stable-6.12. I have resolved
>> the merge conflicts and tested them on s390.
> Thanks for the quick respin, but this doesn't seem to apply to the current 6.12
> tree?

Thanks Sasha, yeah I see these doesn't apply on the most recent 6.12 
tree as it we have merged in some other patches (which were originally 
part of the fixes series) that touches this file. So due to the order in 
which they were merged, made these ones failed to apply. Will send a new 
revision, so these also apply cleanly. I think it might be the same case 
for 6.6 series as well.

Thanks

Farhan


