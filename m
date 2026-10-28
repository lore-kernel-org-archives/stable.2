Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202083;
	b=E3MHKsphPPQLMikB9yeiHZxWbs2KsFhcsU4MIY0tb2ryD0bVRx9MKdb5EIv9wPT20ISe
	 j9mweuVnZ5ngKoti40+clsJtiHQ9RYjSAPKXiT5lEn8MKxJm/ZPda+DSfgDihn3ddKRZI
	 tpAgmizff/BA5+25CiGOlzLbWdF4pVkh9lTIAyKzq4pkEgxbrd4qsvG53XrEZEda+7USg
	 WZZg0bmWrfe5NR6z5Ie1OriFNZ25TN+uvpfltUoozSWrRlfIjqrt7XCUaabnM7f5zol09
	 ZR642Lz0JIxO704qE5NBAng/COhRZhaKw9gsKR4yeLJPZ1Y3KkpTMVOzpCSqvXLLoRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202083;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=VB9My0XZkmNfDNzvXuQrlmV8tJuxQWBfRh6GF92ZzrY=;
	b=yqi0wwfWt5AGnes0J5k2qrNLgpTzbIGN1nLsVb4NMv6/mtxoU2/KJvN94dWLGfbkEtja
	 3cw5T5q9HCZCurSfUsIhn+0rjl9f4e7DO6fcRztD0TmZx4Zv9AqZRuFou0xwBloHpiZnD
	 BL7cX5Qqw6T0bdbBXFf1uyViNLICcB2dMy2K3zL4jyOJSXzlhqO3F/WiiVHeVdHK7gZhN
	 Tt8OZZDiNDhkxw/QvB5XDfM/YRRjap4x0ooXDj0GMKHewW2bjlGhlqFgu+pYHMWA0v/0j
	 JZ50kDqcBnYeKE0hixmIeHSESx+xVjloN1TmlBvHkqq5EYFn9MD+BapRvKW1p+t3rew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EGl1QNCI;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAA7606A331;
	Wed, 28 Oct 2026 15:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FAA7606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EGl1QNCI
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFEKGJ1787895;
	Wed, 28 Oct 2026 15:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VB9My0
	XZkmNfDNzvXuQrlmV8tJuxQWBfRh6GF92ZzrY=; b=EGl1QNCIwloqOBqp3+1VOA
	fR+YkZZguOPETAcx9xciv6Fabc8FoLw9XERzCAbNvbgYWpGlcVogxBcmmsm6/2Sx
	JMBNxk9PqFbrPLo/w1QLOrVkj8LvndNezlgfEIElEj8uWcgLoRwYjsmFeSn+4sv4
	0X8WuOlIKDelYXV7JKFl8+hpeY4WF8rTMxbqRM9o3PaX5ziDl5xpZxGJWr9SvuhU
	Q38jQVmAn4kYLjq5ob5PdNiKIX26hI2e1cGSLXfBsxErcwW3x9+OVNT2XVPeWdoe
	MM2D8OohTzXvpAExHuUH5hCOGGntny/NIbDUT2zytRpGUDMMMeXLRWEABCl6V5ng
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgm645jud-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 15:41:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69SFYn5C1760082;
	Wed, 28 Oct 2026 15:41:19 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hk55pawev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 15:41:19 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SFfI6T27198096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 15:41:18 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 775055805A;
	Wed, 28 Oct 2026 15:41:18 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 081C558052;
	Wed, 28 Oct 2026 15:41:18 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 15:41:17 +0000 (GMT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 28 Oct 2026 10:41:17 -0500
From: Wen Xiong <wenxiong@linux.ibm.com>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: mathias.nyman@intel.com, Bjorn Helgaas <bhelgaas@google.com>,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        wenxiong@us.ibm.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH V3] xhci: Reset TI USB controller on xhci shutdown
In-Reply-To: <20261028103616.29110069.michal.pecio@gmail.com>
References: <20261021160608.8229-1-wenxiong@linux.ibm.com>
 <20261028103616.29110069.michal.pecio@gmail.com>
Message-ID: <eae289a8f872d508c1b3c411f69aec74@linux.ibm.com>
X-Sender: wenxiong@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA2MCBTYWx0ZWRfX0ShXA69wQOg8
 FV1S5dfzBclqB9+l2pkU20vWiyfNnz8Lh8rOOSf4LVN0PUnJolnKo9hEXJicYQpb5kJ0uMgKyu2
 HLEBac4RfXmQadqY1eYxZgTS9o10EGg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA2MCBTYWx0ZWRfX2bb8SOfT0/O0
 yvQwpSfpMZgoKD85yhcdF8Ib8yKlWMKVpk0J5y5G9aqlvFKGmu0Lwf2kxqtT8IapRcDyHHiD/Fn
 EaM4MVXQOVQBKhcKhIYUVz49SMAJgcnv5Nbt8O9M325VMLUam8qEJdYQ/xjQq+wuo7VzinGxjYd
 gup1WSuC8dLwvWuDlqhci585M6IQYsrMhiiZkRhFULhUnGti9TH0KKJ/6XgGbn7c+jY84Eg+bJU
 xLuShpjXQZKYblKHa4tF6lfYnzPMUjPJ4WOMnEPhcOPSWYdsVNNtFOC4smDvp7tHbehtU6GxMXD
 5oWaVOJdCdiE9mRhPmUwVOKa8Tuw1fBIdoPAewqt1ANPIyDlYoKVxz3Vtfy1cGdGPScTVfCe++9
 RadJ6F4XjQD6XMJLsIGtCUgEOff8my+aK+WyBippum+KGriB0ZU2vZ0GCNFauDwwbNVc+VigDsV
 iqZrtWTjBkMvHWesJPA==
X-Proofpoint-ORIG-GUID: yOhEpvqXZ0XVoGy1c12pZJvwX0fFm7nR
X-Authority-Analysis: v=2.4 cv=Uu32pOwB c=1 sm=1 tr=0 ts=6ae217a0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=JRXGqj2KNVXaf7dXr9oA:9
 a=CjuIK1q_8ugA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: PH3qXawjFdyzvCVyMJwwcFhNzBXOGo-o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280060


> 
> I tried to make this code a bit more "proper", by moving the
> pci_reset_function_locked() call to xhci-pci.c from xhci.c.
> 
> I found that when I actually run this, I get a warning from PCI:
> 
>   unlocked secondary bus reset via: __pci_reset_function_locked
> 

Thanks for your reviewing!
Can we do?
if device is TI/0x8241 device, we just reset it in xhci-pci.c.
We don't need to bother other USB devices.

Thanks,
Wendy
> Bjorn, any tips what would be a proper way to whack a malfunctioning
> PCI device with a heavy hammer to ensure it will work after kexec?
> Seems we have pci_reset_function(), which locks the parent bridge for
> us, but it also preserves some "state". Do we want that?
> 
> I'm also starting to wonder if we shouldn't do this reset after kexec,
> to cover for kdump. Or maybe both, because shutdown() is supposed to
> quiesce the chip and keep it from doing DMA, and we have no idea what
> such chip is doing (if anything) when it refuses to halt.
> 
> Thanks,
> Michal
> 
>> [...]
>> +	/*
>> +	 * TI xHCI controllers fail to initialize in a kexec
>> +	 * kernel without a PCI function reset
>> +	 */
>> +	if (err && (xhci->quirks & XHCI_RESET_ON_SHUTDOWN))
>> +		pci_reset_function_locked(to_pci_dev(hcd->self.sysdev));
>> [...]
