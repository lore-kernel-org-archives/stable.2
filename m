Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3A0442120;
	Tue, 21 Jul 2026 08:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621747; cv=none; b=X8FnWIzJNDKGqk/tU5ncByAfO9Cb/oGx4/580RyGz2TU1J099+UM8BPYoCDChjd510hIPQPQF/E4+slB5N+fS2HJdfcEyyXjgch2AcdZX4W66f8doSLBNeekBPulKHhUTETtM4rFpWh5NasOheHaAOKkMvk8wgdPYp9pcsC88tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621747; c=relaxed/simple;
	bh=cZjRsWxjLoUUzQFnqx1SLLjLr3jrT4FcQ5krdPMyndg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hPLQs/la0lcaxraltNsln7fZKqjtkGwmJzlVs7wtCioWE2F8NWi7DvJAC/k5gutmT/bwSv7SlFCE/g703g8l5OOR9K9yVamxOaekjQDh4t+yxOzkLMsK5fVA8A/blvXmQ8WSIXk4g8Qd7pNRRttbTIFaFf5ZGZayz0WWatrB3LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TCmHIqAS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TCmHIqAS"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNDZ1r3560230;
	Tue, 21 Jul 2026 08:15:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=F70kyB
	ctfVYKO4Lf5A5/F90+zjATHA6JYsGkkxtvG5k=; b=TCmHIqASwV7TTgRkV8w5qw
	RpRNqVfkHeJsCCy8ZAcVxxf6ipJ6xKO+tQAO6BkIr9Mc5IK363cVvMA8I+QTj5MD
	MXAtnrdHDbC2RNdwCVAIcOwDgBGYgny0mKQHKis6VOxHuu8nMmw3r072+dhiaA0N
	XvlnQtJ1b4pCn7FTcg6+rF8JZ7u9ihGXUwTeKhUxES8I+vLhge0IWiT+jD8jKuz/
	vKYvcIy6To3hbTR3DgqJsFNMP+FAo7fNOr+JSshMC6+BGlmsYElwib77RTAuMAH3
	L+1s6u6MiSdpirp8/GvwBXo5r74pOgIpEevHKM8meIpZ79AbQOQCthiA9orl/s9Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ah36x5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 08:15:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66L84dbg013964;
	Tue, 21 Jul 2026 08:15:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgy94am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 08:15:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66L8FN6s24183084
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 08:15:23 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88A4920040;
	Tue, 21 Jul 2026 08:15:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 319C920043;
	Tue, 21 Jul 2026 08:15:21 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.5.176])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Jul 2026 08:15:20 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Kees Cook <kees@kernel.org>,
        "Pratik R. Sampat" <psampat@linux.ibm.com>,
        Thorsten Blum <thorsten.blum@linux.dev>
Cc: stable@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/pseries: fix memory leak on krealloc failure in papr_init
Date: Tue, 21 Jul 2026 13:45:20 +0530
Message-ID: <178462153940.1974055.8113813222024917054.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260614142356.658212-2-thorsten.blum@linux.dev>
References: <20260614142356.658212-2-thorsten.blum@linux.dev>
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
X-Proofpoint-ORIG-GUID: rrEshY317-BZh5KwPmuNcttFlUxINT1B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA4NSBTYWx0ZWRfX7gUHnNFy1aJC
 VpMp1uO4o41CeU7huqd0OKq6b6Q6Q2cOTpFyR/bPQpDyoNDrImgprYvyrn9n0mTgqbsb/UicGq0
 vSbEghnXOlPXSvcyupeGJODHL+t2aTZYfUZ7tOpyv8RM1rCfizLc6hC1FCAUShXLV+AXLUcYSNL
 DCD/DGR/dYQ6LbM4cE5Zzi0CiOSA8H5PLI07SiAmvNaAWaI9FAOIdDuJfIwUD8Sq9AOaRxPTDe+
 OGrhu3Z/DuL8XKzR2A0xBFrqof+4mC0UK7XTpCw6kdD8YEN6XIAXYUnyc1SdMS/nqlFayZ7Czqt
 xmoRrQdoEb80sXVUCMv2X4tagzXq1Flryi9YbAHZyKhc0Ym5jiqvjRcwHhZCA79i1t1d9H8xWaX
 XS8HKlumOwzOsxQ+2Nj1iS1zB/arPFI5JX5mncv/qBc68K40LNUMV3oVPx5tFKxcwIywqZhqQiH
 rLqPNidmf2xajCNJh9A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA4NSBTYWx0ZWRfXzC9uLrVhI+NT
 6PGWz3h/9HGWLNzTyztmRX1RFYLgJWUCpAeoxQxdlBEo4+IZj96yJJhEYQh33CQxkkC+s6Y2y+R
 ZdoiOltRcseeOJ41hcWJpWzWxio7hVc=
X-Proofpoint-GUID: DSQnKxNtjYMrz4O3uPWlw_biJFDRwg7c
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a5f2a9f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=CC3r_jQr0_LCWo4q_HgA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210085

On Sun, 14 Jun 2026 16:23:56 +0200, Thorsten Blum wrote:
> When krealloc() fails, free the original esi_buf before returning to
> avoid a memory leak.
> 
> 

Applied to powerpc/fixes.

[1/1] powerpc/pseries: fix memory leak on krealloc failure in papr_init
      https://git.kernel.org/powerpc/c/bd83c98b988d2c560531084e296dbfb530aff829

cheers
