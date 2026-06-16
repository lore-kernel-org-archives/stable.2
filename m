Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FAD3EEAE3;
	Tue, 16 Jun 2026 06:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781591909; cv=none; b=BmGu4IE2b1UUBEi57+wWr1PApOvvynKASccK6ccBd/BICzACmjo9GVUho+15L22JQE+8U+pKByF19k2ForK4vsA0JZa+dkH6GMc9LkdWCN1rXmiigkk2csceC1y/AHFd2CmlyI3NWxbLsu/NzL0btzYiutVv36cVTPtMRpZ3Y94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781591909; c=relaxed/simple;
	bh=wLBgSpPc3wx4mihAMqgHkOwfB0qsVuWb54qDMl7qdqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3a3nMF0TWVYBQAD8HEkvjPUz2Apc1xYeczRorPJO4C221iIBYhi4zjS/bpPzgLRtzHgKv7l17azKe3MYiDOuICzMPVux0CQyz99mXqS48ES13QJzlGzX7fgqqOOAY86dC+ZICIRo9+oneIcNbOFQnKyx2+cWU0ts5AXhBMhdck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hJyq7AH3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hJyq7AH3"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65G6IEj9507681;
	Tue, 16 Jun 2026 06:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/QdSIc
	q6Bz9cXxEkVZQM87mA7iZJ+jF2gZbZe3HL7Io=; b=hJyq7AH3EEcqTeqmQCXPFi
	P9ApmUaPtmX8MgPCe1//vYlzmSMxbJw/uWpm83635tICxY0vE+neijeJ8fKCBgxN
	pK/uJdAPt8NHLAIkBgCjw8e+wUPgfVNbv11sFlpUVglR7AvRGrWoDr6yUsfoyYQw
	4F8H33VGOW78ev6iyalrtEvTqmFbBkKHVtndjyhzigVhj5Q2beupJdUwKtRC42DA
	hqUnOjD5xbRzV3euKkwc233x7doxThsYJSQObiC0Rx/K7ufHRFHPWybjcSZwVNzu
	1xjO5tY0llMS5GQ/pEYOSUo9jz7pLuUg+oaJff4HZc5Mi6Xxxejrtk8PmZgaIatw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es23nm6fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 06:38:10 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65G6YaNB032043;
	Tue, 16 Jun 2026 06:38:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eshww26js-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 06:38:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65G6c5WG30409094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 06:38:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77CFC20043;
	Tue, 16 Jun 2026 06:38:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3AFA220040;
	Tue, 16 Jun 2026 06:38:03 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 16 Jun 2026 06:38:03 +0000 (GMT)
Date: Tue, 16 Jun 2026 12:08:21 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Gautam Menghani <gautam@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/dt_cpu_ftrs: Set CPU_FTR_P11_PVR for Power11 and
 later processors
Message-ID: <20260616115521.79ad9699-39-amachhiw@linux.ibm.com>
Mail-Followup-To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, 
	Gautam Menghani <gautam@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260614173437.26352-1-amachhiw@linux.ibm.com>
 <56dfa6bf-1eb0-4e27-974b-03f963c5eed1@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56dfa6bf-1eb0-4e27-974b-03f963c5eed1@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a30ef53 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=8nJEP1OIZ-IA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=a82qm-gZ-efHhUihHKcA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDA2MCBTYWx0ZWRfX/XoDiPjm6zHZ
 hVJedRVpr17l/m+2D0Uju/lIxRTa4SdIoA14wlM7ZjYlkdxeHF0jyvzgsabmcFV0+Hq0Up52vbA
 dGR5dowujt5ARnMjO1yEkzLh172esSh2eqbZcUzPGuBKRTVaX4/3XknBqddtAIghboJoPnBkFC7
 eVt+7S2wa2sJ7IFtexvykTAP49Kh+rg0s7W5ZG12QQBltzGLLPv/2QStfz4Ojnb4nQJ8emfUnb7
 m3HYg1A4eAV5b/aJBzij97LYs0GxCU6ATknfoovmZ8cccA+J3HUYCAJHiBXiDKVAV6PTfbIYvxn
 Ibk7ET//PkWGjlBiVOF0rucwA8qTM6TDPRCQyLIb4he3VaKg7ic89nEekxd4P7nR5Gg7dppjtqx
 J39g7bFFwYIi1NUWqaICvdax8N9w2ki/60ghUZzUcNJeu2WJ6xiCGObrE6IzA1A8CRSDTnsK0os
 pcBn6T2rwePuIqyKhBQ==
X-Proofpoint-GUID: 7eamVPgNIYN9kh4QzNk_iYIhmnWnCo2g
X-Proofpoint-ORIG-GUID: ST6LHGXcw3rMrmNV3S_8iCfr06j3L7m_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDA2MCBTYWx0ZWRfX0y9FYKc+vWL9
 Y0CIhvaZdo+MpvSi7E5UCmBTwAPNjCRAOsWhDMwtA5EdlqRSIPVtXrxwXl+1dFKKLJdR+IK2/G3
 WEhnT+TIyzL5+czn2gXrq+QN4J9JjMQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_02,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160060

Hi Christophe,

Thanks for reviewing this patch. Please find my response inline.

On 2026/06/16 07:39 AM, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 14/06/2026 à 19:34, Amit Machhiwal a écrit :
> > When using device tree CPU features (dt-cpu-ftrs), the kernel bypasses
> > the traditional cputable-based CPU identification and instead derives
> > CPU features from the device tree's "ibm,powerpc-cpu-features" node
> > provided by firmware.
> > 
> > However, CPU_FTR_P11_PVR is a kernel-internal feature flag used to
> > identify Power11 and later processors, and is not represented in the
> > device tree's ISA feature set. While ISA v3.1 support (indicated by
> > CPU_FTR_ARCH_31) is present on both Power10 and Power11, the
> > CPU_FTR_P11_PVR flag is specifically needed by code that must
> > distinguish between Power10 and Power11 processors.
> > 
> > Without this flag set, code that checks for Power11 using
> > cpu_has_feature(CPU_FTR_P11_PVR) will incorrectly return false on
> > Power11+ systems using dt-cpu-ftrs, leading to incorrect behavior.
> > 
> > This issue manifests specifically in powernv environments (bare-metal
> > or QEMU TCG with powernv machine type), where skiboot/OPAL firmware
> > provides the "ibm,powerpc-cpu-features" node, causing the kernel to
> > use dt-cpu-ftrs. The issue does not affect pseries guests, where SLOF
> > firmware does not provide this node, causing the kernel to fall back
> > to the traditional cputable path (identify_cpu) which correctly sets
> > CPU_FTR_P11_PVR during PVR-based CPU identification.
> > 
> > In powernv TCG guests, the missing flag causes KVM code to trigger
> > warnings when attempting to create KVM guests, as cpu_features shows
> > 0x000c00eb8f4fb187 (missing bit 53) instead of the correct
> > 0x002c00eb8f4fb187 (with bit 53 set).
> > 
> > Fix this by setting CPU_FTR_P11_PVR for all processors with
> > PVR >= PVR_POWER11 when ISA v3.1 support is detected in
> > cpufeatures_setup_start(). This approach ensures forward
> > compatibility with future processor generations.
> > 
> > Fixes: 96e266e3bcd6 ("KVM: PPC: Book3S HV: Add Power11 capability support for Nested PAPR guests")
> > Cc: stable@vger.kernel.org # v6.13+
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> > Related: https://lore.kernel.org/all/20260609053327.61563-1-amachhiw@linux.ibm.com/
> > ---
> > 
> >   arch/powerpc/kernel/dt_cpu_ftrs.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
> > index 3af6c06af02f..e5853daa6a48 100644
> > --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
> > +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
> > @@ -704,6 +704,15 @@ static void __init cpufeatures_setup_start(u32 isa)
> >   	if (isa >= ISA_V3_1) {
> >   		cur_cpu_spec->cpu_features |= CPU_FTR_ARCH_31;
> >   		cur_cpu_spec->cpu_user_features2 |= PPC_FEATURE2_ARCH_3_1;
> > +
> > +		/*
> > +		 * CPU_FTR_P11_PVR is a kernel-internal flag to identify
> > +		 * Power11 and later processors. While ISA v3.1 is supported
> > +		 * by Power10+, this flag specifically indicates Power11+
> > +		 * for code that needs to distinguish between P10 and P11.
> > +		 */
> > +		if (PVR_VER(mfspr(SPRN_PVR)) >= PVR_POWER11)
> 
> Are we sure this test will always be correct ?
> 
> For instance PVR_PA6T is higher than PVR_POWER11 allthough it is not ISA 3.1
> 
> Wouldn't is be cleaner and safer to just do:
> 
> 	PVR_VER(mfspr(SPRN_PVR)) == PVR_POWER11

You're absolutely right to point out the PVR ordering concern. But PA6T
cannot actually reach this path because we're already gated by:

  if (isa >= ISA_V3_1)

and PA6T does not implement ISA v3.1.

My rationale for using `>= PVR_POWER11` is that `CPU_FTR_P11_PVR` is
intended to be included for Power11 and later processors, not just
Power11 itself, as it identifies a CPU feature. Using `== PVR_POWER11`
would mean we'd need to revisit this code for every future generation.

This approach is consistent with existing kernel code. For example, in
arch/powerpc/perf/hv-gpci.c:

  /* sysinfo interface files are only available for power10 and above platforms */
  if (PVR_VER(mfspr(SPRN_PVR)) >= PVR_POWER10)
      add_sysinfo_interface_files();

Also, I couldn't find any current users of `PVR_PA6T` or `PVR_BE` in the
kernel tree, so there doesn't appear to be a present-day ISA v3.1+
example where the comparison would misidentify a processor.

Please let me know your further thoughts on this.

Thanks,
Amit

> 
> > +			cur_cpu_spec->cpu_features |= CPU_FTR_P11_PVR;
> >   	}
> >   }
> > 
> > base-commit: 424280953322cf66314f3ba5e2d1ef345f21c770
> 
