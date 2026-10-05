Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780274825A6;
	Mon,  5 Oct 2026 13:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791205322; cv=none; b=tBQS/exaky6rxhcP/fmCnq5oPNDPeb9ccJH6thFRZhdHcs+bR5TNiWYiLCGOGCFHgEI7fCFQV1tdm2iSKNkZCBU7O37govfC1USPz1x2M7NdQdJ3HWPFF54n8MGbpiU7ENKvBZPM9XvPJc0Ms0kxo71Ee4RP4zgWNhljUI1Yx1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791205322; c=relaxed/simple;
	bh=PEfclM08b1zG+LIZYqwi45jy7ltIjnLMA8KScVpRM2I=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=U+khZGWDm0UjLa6B2MIAOBzkLYxGHdFpvL5PwBv40qQO0P2ECg4IJ9KJ1auB42IScEeV+9sJYRuniaQ0IoQE1HKBp51h9bX/jRwQfmvTncI0YVLhk7Mn/k7WOzdty5qUT43OADajVyxJj/iNJlmlCHDqJKELdtkgt+E4mc63OSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F6bnPT7u; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F6bnPT7u"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695CZW683033406;
	Mon, 5 Oct 2026 13:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oJouw2
	oanfB0Txj+EnkAMRh8tAgbVSMmj2vvWLdaNPY=; b=F6bnPT7uU1zOUWKKmS8sul
	6P6A5Cf69eC0mUGePu4y5Dly4tvSITJOzrb0l3UlA9M4s5BqY4qlNY2hVcVTuphq
	ttnhqRTcaTGa5/Q7O01hGXPLBxw1ZLexsIpZq1wUMHDeM2ub9jF3EBJXF/3YgUP3
	yxdVo/7aWGeuvMRle8ycNTFKvzGsBfyoFmH3M/IHWH2YqMd0a8sgt7m84h3uVWv3
	uIRls86eqhthmMwdZbNhTSBf9A10pYjYYfBX0jXCtQlaMF0u6ziu1Qd7k1Y7svX6
	ha2dFqms9JsOg+dlnFl7tLB2KKRyBHmDzheub+MFkpyvHK75iORl52g24d1Sr7Fg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scraa63-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 13:01:49 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695CI0xP2900996;
	Mon, 5 Oct 2026 13:01:48 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3c1pnp8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 13:01:48 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695D12Fd28902010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 13:01:02 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56B78580D6;
	Mon,  5 Oct 2026 13:01:47 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA21A580D5;
	Mon,  5 Oct 2026 13:01:46 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 13:01:46 +0000 (GMT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 05 Oct 2026 08:01:46 -0500
From: Wen Xiong <wenxiong@linux.ibm.com>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, wenxiong@us.ibm.com,
        Brian King
 <brking@linux.vnet.ibm.com>,
        Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] xhci: Reset controller on xhci shutdown
In-Reply-To: <20261002161828.365ff859.michal.pecio@gmail.com>
References: <20261001222527.11742-1-wenxiong@linux.ibm.com>
 <20261002102931.3cb06009.michal.pecio@gmail.com>
 <561d22493c3d078b26f547dd8f6f6f46@linux.ibm.com>
 <20261002161828.365ff859.michal.pecio@gmail.com>
Message-ID: <55a53022d1c6f671a3ed549d8cf7cd1a@linux.ibm.com>
X-Sender: wenxiong@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA0OSBTYWx0ZWRfX1tXmirYR7I4t
 UYw0r6SZvyzVYn+x/z6FJLCCtwt7Z/aU7xrwcqr0s+ZKsfkdFWeXo3UVQy2cAC3sZ+kth0QaBON
 dxA1Q4fs1AC4jZPRd+zEWQ4f6QLUQWA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA0OSBTYWx0ZWRfX7NjAnqooqyf/
 PnthM5pDD+bjS2OZhRdXVi2HdicuSHWsRvxovCLiuoVnAOeppwIP0NpoOFqqTAPHNYzd3WDWRVe
 4xLKBgHjSwGtEw9THRycB60/Dgc1bhigxFtaQoaUz4NOl1KoZLTdHT8s7LfL7C7dbLicZQY3JB0
 YGW9xqEuEVYVVdcBn4ERIFns8v8Wl4Dprvcqv3lK8+RNSli+DmBLsJ77cpaJlXVP59gCQjoOK9l
 jIzC2Sk1MEgeEp1yrFFs3omDHAukFq9mzWhWdTjoVr4b613ypyP/qc00TN69N4nuPcGr186eF3Z
 AGSOR6HC0HvZYbsmZNmwrOBHxm4LCmYzmF6Wa39LVDslnMKwjtPKGG0neVjSjqwJdifVxmVcv9q
 S45wsixOHo0cr9Mr6Mx2/Yh9donZhjal3SIIOYjsaItiF90Lun59ZhjDQv8YKKN89mvIKamsz5k
 qStwqVGgZ5wEZN10MPg==
X-Proofpoint-GUID: qB5FYUq3kcV7K2Bq1UXQ8RneMuaMVY8x
X-Proofpoint-ORIG-GUID: 7C1sBvpswXOygugWKc_MlpUDsIiY_gwf
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac39fbd cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=rxDuA9JTOIXHxVn7PaYA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050049


> Sure, but what does it mean exactly?
> Not even showing up in lspci output?

When executing "kexec -e", saw the error:
xhci_hcd 0005:01:00.0: Host halt failed. -110

USB device is still showed up in lspci but lsusb didn't show any
USB devices.
  #lspci|grep USB
0005:01:00.0 USB controller: Texas Instruments TUSB73x0 SuperSpeed USB 
3.0 xHCI Host Controller (rev 02)
[root@localhost ~]# lsusb

looks we saw a frozen USB subsystem during suspend/shutdown.

> Is this our problem and not PCI subsystem's?
> Are we sure it's not a bug elsewhere?
> 
> (Last time somebody reported issues with kexec,
> it turned out to be an obscure Intel IOMMU bug).
