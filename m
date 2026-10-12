Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC6621ABBB
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 03:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791775899; cv=none; b=CAIX7QnBZz4MAv52Tk5C0KUgIcP4R9YlCWCYcViXtgFDbImNLPv1BrqVHidX5gYpPEQrU0hvV0hagXRV4Dqoak6CBkXSIY1wTWDqeCKh6Qyn6euedHBmM0xyoFK8krcwnmCl9Rl93NSfBxNBFkQ8Wm5jbB2pZq7X9AUSQwBKdi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791775899; c=relaxed/simple;
	bh=vWQJx0fXjARqCOD1TMHvOpINKLFvISh1ySNXFYcal+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3vioHjnxKiCwWumrj4Wp2I5Q1TXzyqL5PtgL/povrrrDiqNPyaNTb4C1ByXmCMQ5tHwl4FCo87o0smmdFs38j7C3RW4Qb0xk77GXea5gRdeN+e7NTDIuqySVG9HFD/NQXWlk7tPh2jIBU/h/HqvZhCOjOH3hc9yFqK96oZRClA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Nq8qzAvm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Nq8qzAvm"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C2FBeX2914388;
	Mon, 12 Oct 2026 03:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VqZgLT
	/p0HvP2whlNv0dK2wQEJYb90iYnCq/iDafbcQ=; b=Nq8qzAvmxNE7ygP0kok9jH
	Nli1z5ti7PmdoVtMYdyQ803fu63ao+DjoWVrM2nv/oS2fsU8fBiM5eze4eA01H1I
	B07MeEaHYKhU2dPWf1vuO2B1pysKcC6Ri1KqR9+rJkA0UV7DBeLv4xoXErD+Ca5E
	IkLkxtKIfBzTKeit/HXdAlBCc11fXtzfAdxf0ToIBxind0GrTJOFsFKehr98xdL/
	HaiNBWOjf04KjqxkPtNtFZ4lK2faWtQ7oWiV5Yk7KJAv1A7G1Ii/SMJHivuAXYt4
	k/SCPt8rdno/pnvUkBSwb0GkTBy3jAMOkA5PsYr10ajyUfZGWbWorvJ7R8ZJq6eg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhpqhe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 03:31:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C1o18Z550890;
	Mon, 12 Oct 2026 03:31:30 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h7yppkpkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 03:31:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C3VRrN41877926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 03:31:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED1D62004B;
	Mon, 12 Oct 2026 03:31:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E031220040;
	Mon, 12 Oct 2026 03:31:24 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.8.83])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 03:31:24 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Gaurav Batra <gbatra@linux.ibm.com>
Cc: sbhat@linux.ibm.com, ritesh.list@gmail.com, harshpb@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, donettom@linux.ibm.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v5] powerpc/pseries/iommu: Add TCEs for 16GB pages when RAM is pre-mapped
Date: Mon, 12 Oct 2026 09:01:23 +0530
Message-ID: <179177344616.763259.7668514275381836849.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260806205027.86428-1-gbatra@linux.ibm.com>
References: <20260806205027.86428-1-gbatra@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxMiBTYWx0ZWRfX/yqNh2KnRfB3
 UQITprzL9cQjtlrFgdlhvHtmnCfY+slpU5fhpJtCgE8KTz3C+5rurBBtycwx09MMzopDrB08b3P
 zs3VsBKFkW4B16SWWxuzp4Oodkt2mDHmo0xLWwez6Be2g6RhY2TpX8Wa2gB+IH4GopvpA0cvcXi
 LtYGnuWsAuCwVeDu4OIAmPo39s/E2hPUlWavYqzzhOPA1VKr1Y9vAF/Cr1x4unQVukXvZvH6+Lb
 OuOEo25Dg1XRDCOHoc31dG0FICXvdAEPvzzFQbyLtCV7FlKc6S5ycOYrrFaPjDXHoO7WYr/lHP2
 5jj/RFPoE42WLYapUe48NR4TthRx8eqh1+EHlNl22twI88yKbccAw/ERET4mqz+oMSITu6ToznL
 hmAN6aD2aqkCdytt0I8vEevUYuDr5bzkYcDyntXFxjqSa4FtnjODF5ZOaUKQUBpkQ/S8703e3bg
 QJl1H6/yiU8YpnFKBFQ==
X-Proofpoint-GUID: xiEe8FS_HU9aHpc8zEUy9EzFC7FuhwJP
X-Proofpoint-ORIG-GUID: NsDL-Sa-V4fsSBUe9dSIK3MKTKC6BBqP
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxMiBTYWx0ZWRfXwIxN6vc/87Kf
 grtSXEyzrPrxqhRbOBpZbFZoaS/G8S61Mp2J8XCTJalRpmlWN6gfGpqhk/ObYNgUtpnCCzLedRU
 g2dsY+kDMLMKhMCe1uhqYmHXf66Mmys=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6acc5493 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=6idpN5dNp59oT6l_L2AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120012

On Thu, 06 Aug 2026 15:50:27 -0500, Gaurav Batra wrote:
> In powerPC, if Dynamic DMA Window is big enough, RAM is pre-mapped. To
> determine the size of RAM, a PAPR+ property "ibm,lrdr-capacity" is used.
> This OF property dictates what is the max size of RAM an LPAR can have,
> including DR added memory.
> 
> In PowerPC, 16GB pages can be allocated at machine level and then
> assigned to LPARs. These 16GB pages are added to LPAR memory at the time
> of boot. The address range for these 16GB pages is above MAX RAM an LPAR
> can have (ibm,lrdr-capacity). In the current implementation, these 16GB
> pages are being excluded from pre-mapped TCEs. A driver can have DMA
> buffers allocated from 16GB pages. This results in platform to raise an
> EEH when DMA is attempted on buffers in 16GB memory range.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/pseries/iommu: Add TCEs for 16GB pages when RAM is pre-mapped
      https://git.kernel.org/powerpc/c/0b8b0c17a8998709ecb2852d56442ea981102941

cheers
