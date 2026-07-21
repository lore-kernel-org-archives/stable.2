Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA38445ADC;
	Tue, 21 Jul 2026 08:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621728; cv=none; b=YWFrpwObjV2ATadJNAoeEa1BT6L7gmy7/kJY2o2hH9e7ioV6TD6fNxZXt4Lqy1MX3xdxNWxbULg8PX6JLUznpPQAHssnsxB3YQAKEmTRDeQU95cJF+bNH4SIahwgrhI112MPyAqgc/XNYWI8WOjWcprNP83GiCf1VEYSi2THvEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621728; c=relaxed/simple;
	bh=2Iz6BGPe0gdkZ0kS3LoKVu1JLJUXAZyzwwGntlEqJmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TeDLB7kwbEa07iFmAz5/v9hCdML1v/t42kj1NwzsfKPo4vA/DhTx6HlE7ywWzmCUMCCr/DRzkCoTfDeAG9KNGZO15U44hCeUNI3IAE1UiMFKWhmnIa5jXQay4HsjwYugQs6wPYqeDPFiZLw1vpehYer0nlNSQnFxuohY/FQxj0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cfXP7iat; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cfXP7iat"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNCqwS3553300;
	Tue, 21 Jul 2026 08:15:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5maZlO
	bb71SVft1hqg+S1xtcX9ZieXBCZ37lv8ju+FY=; b=cfXP7iatEbrop2c/y8aG9Z
	H1zoVOo9Xq+ivIHhYEIIjhMn0hxylxNMUJl/yI4Oid1ryHO9301WS0HxOTsSUTOc
	244RdE/2vIFLlvVtGa75jbheRGeDXAmsdQu6Q0zajwCYNKtRSxojrNVotPRDt/7X
	5coT3VoDAzS6dXeSPoIiXavqzLkL2NkJ3LjCgXOLzctAeTOa1ZcetRkhQDEGLbpc
	VQejL6nyP+i9Whx1S5PzxcYujJXrXWvAReleBRgvfvT5z3Ncxm6SN95T5BGH1t3P
	JZLbM0QkPtl8OHW0ynuTX8omE35gMkUYFGar2C6NJ3DOw9T6oK0f9S5S35dMDegA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7abbju1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 08:15:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66L84aGd013933;
	Tue, 21 Jul 2026 08:15:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgy948k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 08:15:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66L8Exh952494652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 08:15:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCCF82004D;
	Tue, 21 Jul 2026 08:14:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08FAB20040;
	Tue, 21 Jul 2026 08:14:57 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.5.176])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Jul 2026 08:14:56 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Gautam Menghani <gautam@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/dt_cpu_ftrs: Set CPU_FTR_P11_PVR for Power11 and later processors
Date: Tue, 21 Jul 2026 13:44:55 +0530
Message-ID: <178462153941.1974055.9212884139202871921.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260614173437.26352-1-amachhiw@linux.ibm.com>
References: <20260614173437.26352-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA4NSBTYWx0ZWRfXwh8HdkC0ZDGO
 4G15U5xJWwBIOX6LjTL7JIZncbNv9BIgd+bdl7SyiW/KCFFDyzxSbBlvuIFyMvtSj5tZ85Do/Hm
 rwPPcV1D0IDGwASYzOErUko7IGE6UIGZQRNjBk4r6H9uv1IzSEeC6SICEXlzW6VdDvw4RdN+bfq
 mcEzq8Uid1nqRl8/lum9UloffhpVRE8UJ0G/arPLWjAsB8JAcSjZBRtBtPcIR+LU7pCaJBvuAu1
 rnktnnloO45F/GgULhLWQ2laHi5BIEvgL/pFuovSBJ1T3ZlZOZJyYTIyopD2VoOsZUeeKcatwzX
 KDIhPI0d7AMo7+LRNWJCFJHcuF7NXvvFlVuhG/h/rTGLwbD1C1Rmyx/jZXR9pM2YTcp09ncqoip
 pcdkcZeA2fWm4jxZN3ZgZ777GR0mUqcC2qlPb7wMbg/F45Wllv5CXSCclgOGCyF2Rg2C1lzRfiU
 E3/rMUYVY5lLvM2fhEA==
X-Authority-Analysis: v=2.4 cv=F7ZnsKhN c=1 sm=1 tr=0 ts=6a5f2a89 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=IyTs_d-QMcr_bO2y0b0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Bf2sdHPbYs-etfcCoaB5-GyV-jVoAK9x
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA4NSBTYWx0ZWRfX+hIdVZhp25MW
 BoQCE+DkXCH17F6XRs1wJi3+fkf1+bSVsGesn43mXSfyY2cA8cgbBsYCRnU6pw4wwpsrDbpnVR2
 pqczLLlJNYR5oGIsMURqJ74IANsiRgM=
X-Proofpoint-GUID: snN9Jx8g2HDPkLrM-Bn4ukFDxyn103s1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210085

On Sun, 14 Jun 2026 23:04:37 +0530, Amit Machhiwal wrote:
> When using device tree CPU features (dt-cpu-ftrs), the kernel bypasses
> the traditional cputable-based CPU identification and instead derives
> CPU features from the device tree's "ibm,powerpc-cpu-features" node
> provided by firmware.
> 
> However, CPU_FTR_P11_PVR is a kernel-internal feature flag used to
> identify Power11 and later processors, and is not represented in the
> device tree's ISA feature set. While ISA v3.1 support (indicated by
> CPU_FTR_ARCH_31) is present on both Power10 and Power11, the
> CPU_FTR_P11_PVR flag is specifically needed by code that must
> distinguish between Power10 and Power11 processors.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/dt_cpu_ftrs: Set CPU_FTR_P11_PVR for Power11 and later processors
      https://git.kernel.org/powerpc/c/e4de1b9cb3b5c981e4fe9bca253a7fb9161f5acd

cheers
