Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0771C51C043;
	Wed, 23 Sep 2026 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167859; cv=none; b=fOBh5BdMGi1XXnf0AMoR9xDaGoQrChP3AbviRuFuNnqrpj4luclMoq6Qh9bNnVWFCkKsdg1UYpJeXVjmw99jGbqyjTM4RMJrZqPmb2Xlkh8TBvAfidP1Epw3aTqitwkGwILiK1Y9hOY4mG3Zj1A7IBkGfgPtekSX7aO2K9NUR2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167859; c=relaxed/simple;
	bh=J7h6ePkszFZDTXHscMpcl3yqnC2BI7k1qn467oolrMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6btkw1N3agcPiy+ivuqlP+qY9Ei3eCanlU7kgWr5qb8ggnTNFRMwHwxmmNPS8340N3SM2KaZWf54SNYuxbdHAYNJj85+yVDTPvI8Q9KKrDXO1QToHErt59l180IjwoFYuzPUtJej8AxofgSaODSjgeU04oCX2WQ/6lr1Tk9Uew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q/ArLNaK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q/ArLNaK"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8ZopM2742362;
	Wed, 23 Sep 2026 12:50:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=sD0MUDyrNbqecS3bMd8lwV/g0Gkcar
	9iVZtrMhjni1A=; b=q/ArLNaKPF1plLDeqNPN1SFiCKlejR9Aa4ffHsLtKxk7yo
	+p1YWrWARHF7cF2M6wnJYf0wv95z9op5adeKB57d+9JBZnTtnl5J1kqbgSqQ4HsO
	qbsWxNuqpQG45qgbtNbrNh49cAwBdVMimnRJpnNuSQMLdasvNa2ZcuqXtjc0/3Gi
	JvZCcZqAN1ZwzumkFsPoDGxNvC0cXefVLiKv3fSlu0goJQZSfPvRNWHum6pCKuLf
	PcalwBKGqPARiEYGdq+CEtP8adTVblhR7Bg/YlbHLeUeVIu7ugLVTS496h6HYdZJ
	OM5pnUdEcf99GvT9jlQIKHiG6OZRwn9iB5hsrieA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1jw51-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 12:50:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68N93E1m007936;
	Wed, 23 Sep 2026 12:50:30 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbt2ruyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 12:50:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68NCoQYd38863156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 12:50:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8448A20043;
	Wed, 23 Sep 2026 12:50:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C80A20040;
	Wed, 23 Sep 2026 12:50:23 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com (unknown [9.39.20.50])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 23 Sep 2026 12:50:23 +0000 (GMT)
Date: Wed, 23 Sep 2026 18:20:20 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        nnmlinux@linux.ibm.com, amachhiw@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Timothy Pearson <tpearson@raptorengineering.com>
Subject: Re: [PATCH v3] KVM: PPC: Book3S HV: Avoid spurious interrupts caused
 by LPCR_MER bit
Message-ID: <arPKuqUghZ91RW0B@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
References: <20260921111043.49825-1-gautam@linux.ibm.com>
 <arN5AY73k0fRh9VQ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arN5AY73k0fRh9VQ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: LhMlBdeaMYchxhb55wNyWpf_iBFgo1yP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1MCBTYWx0ZWRfX3AVpWMoiRHmz
 4QvTg2Lma5IDtpDSRoEmCtPTBO7shOS/cyznUwHLg4eslux5WikrQxnWm79QOqhpV7VhimydG0R
 nhggfMweRpoB04bLquN+L6oIUOKitaAQAyCEtXcBZDbuAPNjfWKYFAx2TlaSuTPNweJ92EcVSpJ
 S8/RdKODqiu7Y0cOG2vKwxZvYCVs1ddzVOQOSVLcOcx7EyYOeUZGi5B+jzPhCyFWRL190jo7npa
 wZowy1h+jGRCtDdAR0LSBmEk1PTNYcOanNdFTnozum7h7Z2sRXrBDJXLK/zuQhkJYv4Q/iBEYIt
 O/kiJCcslUKraZqgzf1sPnM3EWdSD4GkNbQ5Ic1FKGydefho0fPeWJIuwHdmlExowcBA9UJyWn/
 yBXBRLz/ZJ4GhHQn8f2S4uahUeTUJWbo1cUvDHmXgeO1XfMTrfrNIXnoM8CcRePRau2YTcJ1j1o
 uKF6xjMTfJ5Q5ban3fA==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab3cb17 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=198k1PuwjGhzIpgOSn4A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1MCBTYWx0ZWRfX75VlxbIfQOmv
 41g0bl041JF2/Z8Hw93Rs950+qometRzCL/R40yILZEkz2wcK/uk5uO2EVHB2Cro1rmoxqkW20u
 HzGv2Hql/gj+qNcCzu1a4E7y5c9FD2E=
X-Proofpoint-GUID: ElCc1_Sb-Z1OWvJsFysyEsox4F3LOJuk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230050

On Wed, Sep 23, 2026 at 12:31:05PM +0530, Mukesh Kumar Chaurasiya wrote:
> On Mon, Sep 21, 2026 at 04:40:42PM +0530, Gautam Menghani wrote:
> > A huge number of spurious interrupts can be seen immediately after a KVM
> > on PowerNV guest boots up in XIVE mode.
> > 
> > $ cat /proc/interrupts  | grep SPU
> > SPU:     223705     192439     273526     147623   Spurious interrupts
> > 
> > This bug was introduced by commit ecd10702baae5 ("KVM: PPC: Book3S HV:
> > Handle pending exceptions on guest entry with MSR_EE"). The root cause
> > is that once LPCR_MER bit is set, it is supposed to be reset by
> > software. But when a vCPU starts running with LPCR_MER set, the vCPU does
> > not exit back to the host until the decrementer expires or there is an
> > hcall, etc. This is because KVM on PowerNV guests have support for
> > native XIVE, so they are not dependent on host for interrupt emulation.
> > Due to this behaviour, a huge number of spurious interrupts are seen
> > since LPCR_MER continues to be set and LPCR_MER cannot be reset until the
> > vCPU exits to the host.
> > 
> > Fix this behaviour by not using the LPCR_MER bit whenever native XIVE is
> > available (currently in case of KVM on PowerNV only), as the XIVE hardware
> > can present interrupts to the KVM guest vCPU directly. So the LPCR_MER
> > functionality is not required. This reduces the number of spurious
> > interrupts drastically.
> Hey Gautam,
> 
> Thanks for this. Can you also share the numbers after the change.
> 

Sure, here are the numbers seen immediately on boot with this patch
applied:

$ cat /proc/interrupts | grep SPU
SPU:        123        139         99        144   Spurious interrupts

> Regards,
> Mukesh
> [...]
