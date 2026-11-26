Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795655993;
	b=XTnC8clCFPR7WFAmf/76jKXbH32oej8JVXG0L/R3GDUAya0zLY1ikXS6eqBIOkFFozyB
	 +CAaYLBjKFvbqEckzJ/bqbiuWZ2Srp/VDXWr1J/WzuBHA4cEmB1VicIievm/TQnGJjV/m
	 ga5D33vQgcC5pIEw/YN5Q+EMnD1nt9HAVu401wwLZu8i5UPPPnsbtGA9wttDufgQDmADH
	 kXBE7ilzyUCf8ni/uL6EmwpLym53C7ARrRfseK9BeocNAyfOI7tEZ2XiXhFGmCkcc57GE
	 PitR1GHrio1Qj17Q35o79EikIj4QjzqwXT9sPkOtGIJjFMJTWnRxuAEOzSGXqG6orSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795655993;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ryUXjzMtazy3gSaZGHa2Eq3V/fW4l8VdcGVzhCJFDqE=;
	b=NkKBXwuG4b6CqdzpqLmxuaeSZZ6qdhG01qv8ulUYAn8cq/VVFL9XKBntamB48R/ofTO9
	 LlQNPtgRQ5mPOzUM/H+2Ab+O4IeDm59ZO7IHZxKwOw1IIcnG9TrpiWtuYl+lXuITsQtQX
	 krTHmZ2zyiYtSA6QOzCI26D3kxFw4EhlYqE0av2SAZvOfmj/n+vl2nmX0Qc1R9oGgUxcP
	 csOBP86ATV957bzjxh3PyiBZx8t0cNq3nW00ezgWlyFK18EiTDJZuyAHfSPaMwyHlUAB0
	 eRG6Jt66TJes7clUd3cwx6HmDe3j5cQMUyzgTkH0Z1O0D2n29K/BNjQACnEeqmoy30w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="h/YHGl88";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A34606A31E;
	Thu, 26 Nov 2026 01:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5A34606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=h/YHGl88
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APJYmaG2231504;
	Thu, 26 Nov 2026 01:19:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ryUXjz
	Mtazy3gSaZGHa2Eq3V/fW4l8VdcGVzhCJFDqE=; b=h/YHGl88fdNjiCdKZon8er
	lltC7iNg+AA9G/iZU4u3jCmuQkRhqvSr24HOAZymtOaIRy0zUSm95U5l7jLspmMT
	kd4XkHSiXrnNfFjxemEpPJ3B0JxrIzrCf9LK/OI0ma8U0Kuph+gnnV/1ZepkZi1L
	MTyo8juDIehL29Qojbf9dUE/ZxB8GDtNxS2iF8ah+PzbLStmGYhyBXFuiaqb6qRe
	4JrcUqbwZTA7rbwUtYGDheVKCrZdu4PmHOeWoa2lu04Ilx1v7NCZYjSqGX6YwM4q
	fVuGDY0bNMA39FpvYKl+W62eeJ0FsiQ+KE3Pg17Nr9xpLBF+1ooPf3xOTGUsemdA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g1ep0h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 01:19:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AQ117kS2309448;
	Thu, 26 Nov 2026 01:19:12 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3q4hgp3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Nov 2026 01:19:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AQ1JARZ49545536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Nov 2026 01:19:10 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B607020043;
	Thu, 26 Nov 2026 01:19:10 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FC7820040;
	Thu, 26 Nov 2026 01:19:10 +0000 (GMT)
Received: from li-ce58cfcc-320b-11b2-a85c-85e19b5285e0 (unknown [9.111.45.88])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu, 26 Nov 2026 01:19:10 +0000 (GMT)
Date: Thu, 26 Nov 2026 02:19:08 +0100
From: Halil Pasic <pasic@linux.ibm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Shukai Ni <shukai.ni@kuleuven.be>,
        "Edgecombe, Rick P"
 <rick.p.edgecombe@intel.com>,
        "m.szyprowski@samsung.com"
 <m.szyprowski@samsung.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will@kernel.org" <will@kernel.org>,
        "jo.vanbulck@cs.kuleuven.be"
 <jo.vanbulck@cs.kuleuven.be>,
        "Reshetova, Elena"
 <elena.reshetova@intel.com>,
        "kas@kernel.org" <kas@kernel.org>,
        "carlos.bilbao@kernel.org" <carlos.bilbao@kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Halil Pasic
 <pasic@linux.ibm.com>
Subject: Re: [PATCH] swiotlb: clear read bounce buffers on confidential
 guests
Message-ID: <20261126021908.59b2105f.pasic@linux.ibm.com>
In-Reply-To: <d5dfd9a2-4ac6-415c-b719-699b264fa39d@arm.com>
References: <20261123205302.1034348-1-shukai.ni@kuleuven.be>
	<3a70a26adccc47b1bae3a22e4907174271703a10.camel@intel.com>
	<9bc0d7ed-0799-45dc-8d74-25ed66851a20@kuleuven.be>
	<d5dfd9a2-4ac6-415c-b719-699b264fa39d@arm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9Mkjofwp1NYMaNx3EXnPvCxxnD1XHfSD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAwMyBTYWx0ZWRfX39cwUofRUkXl
 xOeO5KVFjVaTJ8IL1+iann34pCzPRPiouNlVld8JakG3OB7F6krFYKioHKXKJmvnsZergf3o1US
 W2G3GXd5ePgroY0/jLWR7cHDHeoG7hE=
X-Proofpoint-GUID: 9Mkjofwp1NYMaNx3EXnPvCxxnD1XHfSD
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6b078911 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=7CQSdrXTAAAA:8
 a=sBmwBxJFO0rdLi8qyDgA:9 a=CjuIK1q_8ugA:10 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAwMyBTYWx0ZWRfXwriPCmfZW0+B
 N02ShTb3puZ1T4i49KD+8L22l1GsKBDyVGH6GWQDb3MB2LdAW1RTGCVFogJk7W57QuPbweEUVin
 1NwUMsmYmT+MqWjwyi363UzFMVt3JUDQ+Xcm7Y8JR3gYNhsyo/lF1LWQU7dDtvbNiUA8k+3QjIS
 oaQXodDp3Yzw97npDZxr2s3MfXqTB9+c07E0ZE5VQ7HDTwkN9aZFW1qEGg+kpFwHcj7e16DF99P
 pQk5uczqkuw06CDiycL+KmdRxFBDW8ZJpRJzjSmWa9RFRb5o0R1uXOInchs5babExEgplkL8rjm
 FpmHo+42+O4V5S5c8ayaIuxcvY4j85bRCuoWky/W/jrmGqjpcZwZ0VfdO99Exc7VqN48u4rvoRu
 YapdSKfXY1/7ErIw9zx9OAPLxR4CBIen0fhqunNBRoLWVPv+S1FMtIZleIyqUWbnfEGHAuCTJv7
 tWdDlAxlKjf+oDu7bLA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_05,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260003

On Tue, 24 Nov 2026 16:13:52 +0000
Robin Murphy <robin.murphy@arm.com> wrote:

> > Thanks for looking at this, and we had very similar thoughts when 
> > writing the patch. Our impression was that in many cases the driver
> > doesn't own the buffer (page cache, dm-crypt, O_DIRECT), so fixing it
> > there seemed hard, which is why we tried swiotlb instead. But we may be
> > missing something.
> >   
> >> It seems like the fixes commit was arguing that copying the contents 
> >> to the
> >> swiotlb buffer was more transparent. So this patch kind of goes back 
> >> against
> >> that argument. That seems to be another point that the drivers should 
> >> be fixed.
> >> If this is essentially more of a potentially behavior altering kernel 
> >> hardening,
> >> then I wonder about putting it behind some kind of hardening config like
> >> CONFIG_INIT_ON_ALLOC_DEFAULT_ON.  
> > 
> > As far as we can tell, keeping the old contents for DMA_FROM_DEVICE
> > was never really promised. Before ddbd89deb7d3, swiotlb
> > didn't do it. That commit was mainly about not returning stale bounce
> > data to the caller, which zeroing should still prevent.  
> 
> SWIOTLB is an implementation detail of the DMA API. If some future CoCo 
> environment happens to be able to share a buffer in-place with less 
> overhead than bouncing then it will be free to do so, and drivers which 
> do not sanitise DMA_FROM_DEVICE or DMA_BIDIRECTIONAL buffers will 
> continue to leak data...
> 
> Note in particular the case of DMA_BIDIRECTIONAL, which means the caller 
> expects the buffer to either be written and read, or read and written, 
> or read, or written, or any or all of the above. How is the DMA layer 
> going to know whether the initial buffer contents are meaningful and 
> must be preserved, or stale and potentially leaking something?
> 
> Also how is the DMA layer to know if a driver is intentionally making 
> DMA_TO_DEVICE mappings of random (or targeted) kernel memory for the 
> sole purpose of malicious sharing? If people want to use device drivers 
> in CoCo environments then the onus being on auditing and hardening the 
> individual drivers themselves doesn't seem too unreasonable.

I'm 100% with Robin on this one! Reusing a buffer is not a problem
in itself. Exposing private data is. And the only clean way I see is
prevent that from happening is to not DMA map buffers containing private
stuff. Not even as DMA_FROM_DEVICE. The blamed patch is about
propagating the sanitation done on the original buffer to the swiotlb
buffer to which the access is granted to the untrusted host.

I wonder what type of reuse are we talking about here? If the
buffer contains data from an old co-co IO might be acceptable,
as the assumption there is that co-co IO has to be cryptographically
protected anyway (from the non-trusted host).

Another thought: My understanding is that an actual IOMMU may or may not
support "write only".  I think, the swiotlb is not the right place to
address this. But if we allow for IOMMUs may not supporting "write only"
DMA API in general may be. The thing is, if the conceptual IOMMU actually
guarantees that write only is indeed write only and then there is no
harm per se in not sanitizing as, we can be sure that there is not leak
with respect to the conceptual device at least. If however the
conceptual IOMMU is not capable of doing so, then one could argue
that this constitutes a leak even without co-co. And for non-trusted
devices and co-co (i.e. with swtiotlb) the conceptual IOMMU would
never be able to guarantee "write only": because even if the IOMMU of the
platform does, the host can still access the shared buffer, so
we have a leak (an we would consider the host a par of the conceptual
device as it is effectively capable of doing conceptual DMA). I admit
something like this still feels a little hacky, but I hope worth
discussing nevertheless.

Regards,
Halil

