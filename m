Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792593880;
	b=oSQtaudHy0SlpflG6+XXXYR1Y6L4WidTW1SaIigoITOb/kHGDzY0MfE67Pt7eJMjyh9/
	 RrKqELLew7QxaAehUTVh4Y0uhK21XHglIqrS2MayPQ5rKI6AAganhgD4/A0YUiG1QsCAG
	 aKkV9nLP36SstzFywJiJ43KZ9uN/39x3WF3zDCII3fCR+552kER80t9sVGv1ee2nJP4KM
	 uue+cx/D1ELARLDLBhaJai71VIaFDgPMiNCWGYDzRIxe+836EBU3I64iGz2qfghFNLnPo
	 D80DEtbrhugU6XLqH8qrcqiHrN5kX+2bpjbhm69gU1NNUCSU53UZLB3YhKPxUJqAN9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792593880;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=syyhi1+ax/TQYAsGAEG1CumYX9OayiIOI9vtj00MuXw=;
	b=nEUU2YqzXMpMNopyUngL5sqD3Y5ox6f8AyyvomQU9991xznpNKTYNm7yHeeVbnVTP2aw
	 kiBDjQlN8tCO16cSEsLnSUJer4qAbjjV3XI2l1uipzshFqB40w0/kP3pMAJeQ0YG9d37U
	 Pb3IDU0yk+2zLmDWZc0wJfn2PJqt/8nt41qvmcr6INUaC+3ViHq8xfeJrd2iBiMsp7bfc
	 TQYvNFIgdlUVHWbbugTO1FAYdujLAcRqwVE2HuU+MfYEx5OvYJsl1PRPZBGE0E7p2so8U
	 ZGV7qWvYY37cZY6wcoZw0sq3bRgNjKZovRkErW7kY3zgHysmOSjeFRKKQz80Qiw5n+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=e7ATFswl;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD80606A31A;
	Wed, 21 Oct 2026 14:44:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BD80606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=e7ATFswl
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LEEQ3U1323497;
	Wed, 21 Oct 2026 14:44:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=syyhi1
	+ax/TQYAsGAEG1CumYX9OayiIOI9vtj00MuXw=; b=e7ATFswlmkh62UWofw7qVe
	ACzPJfQG3dpSFS1SeJUSDO9DBqig1H4DaNi3m+htQct3LOfHRqPxO9+etmUOvlNi
	LxcWMIMLxc0fJwRa3sckGpNCe015tE4Iq9NKQetQrQUpNqhASoTvDNGXo4Q7K/r4
	/6w4lHhWuNXCx5NY+Z1MFbReKyu09r7A8OI/mD9d1vS45aYLcRWT224WX5i+wcaE
	WS0uT7A1G+9MtgNxGotPnUEKIFs6tsu7SJTkA/J3SFuN/dzKpKuxRKYEhLz6h5YA
	XDVCWNtNPj1LpbmSpSmgWnpgQ4jKjHuRhIq8o7k/3Z95IJ9rZ669A7MQE6a4Eiow
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5aseqr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 21 Oct 2026 14:44:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69LEJulZ3256687;
	Wed, 21 Oct 2026 14:44:22 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4he8vhwan9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Oct 2026 14:44:22 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69LEiMWU27067106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Oct 2026 14:44:22 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE3085805C;
	Wed, 21 Oct 2026 14:44:21 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12C6B58054;
	Wed, 21 Oct 2026 14:44:21 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Oct 2026 14:44:20 +0000 (GMT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Wed, 21 Oct 2026 09:44:20 -0500
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
In-Reply-To: <20261021112705.19fd90b8.michal.pecio@gmail.com>
References: <20261001222527.11742-1-wenxiong@linux.ibm.com>
 <20261002102931.3cb06009.michal.pecio@gmail.com>
 <561d22493c3d078b26f547dd8f6f6f46@linux.ibm.com>
 <20261002161828.365ff859.michal.pecio@gmail.com>
 <55a53022d1c6f671a3ed549d8cf7cd1a@linux.ibm.com>
 <20261006125546.10471489.michal.pecio@gmail.com>
 <64515dfd9a6cd8c3f5665e72a6bf6b81@linux.ibm.com>
 <20261015103307.3ba25345.michal.pecio@gmail.com>
 <5510281a5d91bbd435d9920431a3fa75@linux.ibm.com>
 <20261021112705.19fd90b8.michal.pecio@gmail.com>
Message-ID: <1850c5305615a1f4edfe213bcb599ff0@linux.ibm.com>
X-Sender: wenxiong@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=X63Hu2Te c=1 sm=1 tr=0 ts=6ad8cfc9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=pd6ufl1saiTN1nF8DmoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 6zcPtHNd21OoG4LYnPDNSnb5ibuR74Mz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1OCBTYWx0ZWRfXzwW7RDJUVsfH
 k6o2h09U2C4GCrQ+6eJPNNHkL3cbapTr1EP9MDfbhfVSPwtVjMlqfuFRGvbluUwf3Q5qmyYLPXr
 +bxqzL5SMof3PD3/Th8oaxLOsfw74Hhc5dJEynEkTnunk5vQwF7seom3GBX2NPh/JxG0OvuIbk9
 +m9+H1TPYoHNO5qqSVU0ND/YfpApw4sy/oETFtJwQmxEu5ewz8nfkqNi3DWARwelyapTJ9do9VL
 rJaU3wJRgG6ykYj9ByDXQsoT9RmffhNtex8TI2VZms/IF6Hu6wnDPZ7a90pYtdHXZ0oBQQtJ9ZL
 cWEtF61rHfX48suejoTBSp80A53Hv3CltL4GwLGyapv/vLBZIYVQG6AwudUSC56TykoLZC6vx+M
 TMkOlmXP6V2ulW7t2czdeSLsTTGwYhv15rucc+jUFR+MMB8wl3MUtB4E90Mslm/VLgF3B1ozYzf
 bzwHqQP9H/wN07L2nCQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1OCBTYWx0ZWRfX2/7dJM3IsNTq
 IN4q73Ac7IW8+Wjpk/VgvbB9hm4GeYhkKDqR4b/kc75ePzzKNCAqicYDcZ/hPXLoiz4iaXbYNeD
 Q3Mcl+Qc1aDSCdgs5RUBPSH/9w9r5AM=
X-Proofpoint-GUID: VUQu6htEU7C8aBND_1K9JO5kzsYUMAQU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 spamscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210058


> In such case your suggestion to PCI reset may be the simplest way out.
> It seems we could either call it always on TI chips, or automatically
> as a fallback when xhci_shutdown() fails to halt the xHC.
> 
> Mathias, any preferences?
> 
(1)my V2: call it always on TI chips in quirks path in 
xhci_pci_shutdown.

(2)Maybe try: call it on TI chips in quirks path in xhci_shutdown when 
failing to halt the xHCI.

Mathias, if you think V2 isn’t good enough, I can regenerate the above 
(2)option as V3.

Thanks,
Wendy




