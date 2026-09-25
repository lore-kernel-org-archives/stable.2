Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274B914A619;
	Fri, 25 Sep 2026 19:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790365782; cv=none; b=sReJbBGLbnaI0kAQioLBq+OXGFSx0bMFpj4ij6uzQvOCjbAVwdymPD4KVmBicPEs74hhtnxmC9DEXO83MDgRU/xudjXOpYaooREoSG2I0P+T1t7AqCPzWxhIbNUSlte14zT0f4xvxuASEzQtLSPHTuQkkFm2P7D7S/vUSCUMdeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790365782; c=relaxed/simple;
	bh=OeAELIPpoIcYl37HGsKbVc1oTw8j9omwf8i9gJxSLZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TTxBiGS7vWtY2m7xYsYM1uirJwbR+N+vOaiEY2D8QVqcNINlEZLqN1VzP4+kmvaL4CdJEsybgLi9/ZFUupgUY3DbWty5BvY1E3PuvZTlW0mMV75OWRIePIiOmRlxdgRvr7hzp07VywZzQWoG2rNnwJnULbKhJF5GSJKtYm4B5bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Za1AL/VN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Za1AL/VN"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PJ5Xk91742650;
	Fri, 25 Sep 2026 19:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kmg9QD
	fVrT7oFXnGmZSBz2FbpQntr+8Y+71s+SGxuFY=; b=Za1AL/VN0hIIrfYBrslaJz
	xzLRFpkEET1MZ1VJNbLus+X2AgwRneLZirYNwCC3cWZ73Lf4Y5r6JsUcqlYfbbPv
	ayIzfTEojB2oaPYNwtgkLEipdj5IRDsDTNkzYKln8tQs35pmjtoGzzLK7yPivZjU
	ZgsorrSkl4T2VDAL4W9Wkx6vbpelXAkPBzpcaw+NFrpihQTXaI1X9VpXL3kY5rv5
	f7TkZZKHVtOaPYSgCarVk0WA30po4IWC8s2WqUVE1vwkh+pfrD7jnZ3ZlvKGBkyf
	jxwD+pNP5qxCMqB5VQdT9SgwLbWBQsGgTK+dlmE5BijEZgPy/ZHZ9Cu/aIYIpAuw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske201k3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 19:48:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PIm4As177231;
	Fri, 25 Sep 2026 19:48:59 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe23uhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 19:48:59 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PJmvW760162518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 19:48:57 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2CDB58061;
	Fri, 25 Sep 2026 19:48:56 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3BB6558060;
	Fri, 25 Sep 2026 19:48:55 +0000 (GMT)
Received: from [9.67.6.174] (unknown [9.67.6.174])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 19:48:55 +0000 (GMT)
Message-ID: <b2116532-c9d2-46d9-85e1-28d829e1b1f2@linux.ibm.com>
Date: Fri, 25 Sep 2026 12:48:54 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] ibmveth: h_free logical LAN on open-fail after
 register
To: Dave Marquardt <davemarq@linux.ibm.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        horms@kernel.org, edumazet@google.com, pabeni@redhat.com,
        andrew+netdev@lunn.ch, nnac123@linux.ibm.com, maddy@linux.ibm.com,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        bjking1@linux.ibm.com, shaik.abdulla1@ibm.com, stable@vger.kernel.org
References: <cover.1790357373.git.mmc@linux.ibm.com>
 <7a56fbfb9e0674f011f4e310fbd7dfd8e67c30aa.1790357373.git.mmc@linux.ibm.com>
 <87jyo917gv.fsf@linux.ibm.com>
Content-Language: en-US
From: mingming cao <mmc@linux.ibm.com>
In-Reply-To: <87jyo917gv.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: IeXlzJrSAT8A-whkqGvaKP0QPCx4hwPW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3OCBTYWx0ZWRfX381l0T5CeJan
 2/dxjwsnUBvbTrYeiihpBji3jegGUUSQwcJUIfHgQ8Y3mtq3nA/igfbyb4uqnZE+B7QuZqDRW5C
 z0kGAOKM6JvJPdZkmM/Lc82K14aQqJNtGSdPnuNR0028EJWcJLXRMHdfUXXtptO5JBBFocIGRRE
 27OMGKLDgSa0hBkp4DJi/jlp462R23MVuI41pM6tpnUXLNzwTXu4L0sLTQzaYrnl+361UKpYhm6
 A5nGw/jloC2i3DI2bjzTY6gLofqYZc+sHF+M2pTg7Cst2Fnz7Umw+6NUTpZCXh2sr0+KdCaBt/g
 sRkxoyA2FSwwaaorUdWRPnm/pgTPB5ANVQwn667WQqZyIKLUGrHEHL7S5tUdwc9M3sp+O2Ix8yh
 Eg+aGIp+IiC4haQaYjed50uxo4oitlaFMUSH1sRiVtOeEdZHMDn3+oo2+JDOnycQTJJ0pr37hN7
 RzZJuuDrJVZQTU4PRQA==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab6d02c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=EHH5yf83OD32F1cNOm0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3OCBTYWx0ZWRfX24hw9Zw+J1Rr
 nzwmB2Z92Tg1U2xYtEAqyYKbQqW32izwO/03uBSRHQm+5yEaG0paliwasWKg884MLokXBV5l1Xp
 0BAl/cf+T6DGaC8aqsms3TJxi/8KF2Q=
X-Proofpoint-GUID: dDBiNZv85xfs6zXg3VbT4qbMhfKE6JDo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250078


On 9/25/26 12:01 PM, Dave Marquardt wrote:
> This code change is good. But I noticed another thing that's a pretty
> minor bug of useless code just after this:
>
> 	rc = -ENOMEM;
>
> rc isn't used in that code path after it is set. Is there some reason I
> do not understand to have this here?

Yeah, that |rc = -ENOMEM| at line 728 is dead — set right before |return 
0| and never read again. Pre-existing junk. |d43732| set it for the 
bounce alloc that used to run next. |d6832| moved the TX LTB earlier and 
dropped the bounce, but left the line. After |request_irq| succeeds we 
replenish, start TX, and return 0.

It's harmless (not user-visible) — I prefer leaving it out of this Fixes 
and letting the MQ series clean it up naturally when it rewrites that 
whole open() path. But fine to respin a new version if desired.

Thanks for the review.

Mingming

