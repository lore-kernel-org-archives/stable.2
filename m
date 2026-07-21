Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE67445AF1;
	Tue, 21 Jul 2026 08:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784621743; cv=none; b=bpAYMB2jFyyKQxjf1CIJzgZl948Gw2NS+OMWVuSoz1D4H0WfKrud3Cm7GZo5uKdS7amL6+XdJqOogt7ZVWcWtBiTc/XPSBnWgPihXlEn2Q6PIKhFxnHqE/E4oXk9GebwQi4zfAxvFta/Q94PYDZyn7PU8di0V+Axnu8ZPcxXkPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784621743; c=relaxed/simple;
	bh=S/OUquhqjFMKzn4ql3z48BKGvwmNlzBxUI6ocULSMMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bTLVHjQrwkgNW0op9R9ZOJD8tTy5NvafWUwS1TGDfTgOQovwGAqL9eDZh9d30Km+4jErYJXeETV18T5TdFRhWjKDmL4L1qzq2JKdy5lWYsdvx+Dd05xOdIUZPDZ5l0pFKKsmH1Egxyp5KSENn0wRxPROGdbM8AqQI33HDbsq1r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D34tSwcL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D34tSwcL"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNCpqP1675641;
	Tue, 21 Jul 2026 08:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2JgPrN
	utar/imfqnkLIre+0C0eBmg5o+qQyR+gJKdOw=; b=D34tSwcLyUYyfuVe9YU2Yx
	NXc7GUq8XqMWbcz4DqCIgI9pqH3lgMTRVMSzrDRTszsZWPETu28aq2EgU61jqrGN
	tjw7A/h8xFlC+vA3otvwLy8b7lUh0UYP1kPg3gYK6D7jLwRoPnRVdFis/tR41VJj
	2x4hPk12rv1kAxre6bCTv0yiOZgfI2nMHmrgqfMVnJoVUIWadm0jEsGOTxDq6Phg
	T/7UTC5XgTgqLu6JA40QdnRimIfCkLYc0FyXXb/Gx4E6ttoP8ysO2WxMyD8t/cQg
	Swg5a15oe5rDE3CiDENBXooJW3ymXyylBo97GkhtiCHb6TFkN+LYTCjythZduSmw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77abjde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 08:15:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66L84cFv013951;
	Tue, 21 Jul 2026 08:15:13 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgy949m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 08:15:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66L8F9Xp29098246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 08:15:09 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA76A20040;
	Tue, 21 Jul 2026 08:15:09 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CB9520043;
	Tue, 21 Jul 2026 08:15:07 +0000 (GMT)
Received: from Linuxdev.bl1-in.ibm.com (unknown [9.123.5.176])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Jul 2026 08:15:07 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
        Gautam Menghani <gautam@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
        Amit Machhiwal <amachhiw@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v5] powerpc/pseries/Kconfig: Enable CONFIG_VPA_PMU to be used with KVM
Date: Tue, 21 Jul 2026 13:45:06 +0530
Message-ID: <178462153931.1974055.6909734950502953277.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260615091120.84169-1-gautam@linux.ibm.com>
References: <20260615091120.84169-1-gautam@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: lOyiRZfWXEW1fDNuk55oN-0owJ5qntFB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA4NSBTYWx0ZWRfX0rIKSSAXdZNw
 U0gRnpKWjBtxjxklcp59HZAmaPX/G/wSDhKtoNPf3bmfsprUBGAj3kGQ9sjAInWAFe+T0r0VnCw
 3ojsjMhNrZxOj2zNuyKnvFGNvkirfV4=
X-Proofpoint-GUID: CQsigfg91z_dWHaLAEejibuIv2NWmUn6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA4NSBTYWx0ZWRfX31As21Q5rR2Q
 PpsGB4pi01S2d6zFNs1yzfECqnb60GLG+pDiP6vCKdcmQdJFA3teOkxWrCZSyeV38zJdBpM6b8T
 NeOToTT5y+ZG6TwMSkxB2V3vKQn6B9Q4IZ6EcT5n/czLGOdlEgAD9xGe39uFIZHraNYuaaSlM2B
 YgicnFDceiUVsaCdXfK1CetSEqdwYj5MzasjHCadyf9d4stpANp0nv7tktYHsQzUI4VuEAvtCwP
 upLSON/+S358XtCvK0Mu/7HlhbpKAVZTQ/uWqDNJ4LXRD+6f0mWPF2l5kl4iSH8cNFnCMvtcXe4
 DIQMRClTe/68tqZS22UTYsIjpWciiiLh/7l+kt9ydpuO+5BKUOyh/NBx/I6Uo6obcoIOGpXxUqV
 L/Qz99UNwNOY3eg6+9cDiSfiBjxFThcE2n2R3mUX+LSWUzU43F8ai7QtWKk7iVTnwaJSSPt5eBB
 GKkAUcyZrpUf5Q3hPTg==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a5f2a92 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=QaScOLqAlooG59okbtUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210085

On Mon, 15 Jun 2026 14:41:19 +0530, Gautam Menghani wrote:
> Currently, CONFIG_VPA_PMU is not enabled by default, and consequently
> cannot be used for KVM guests at all, unless explicitly enabled on
> host kernel.
> 
> Mark CONFIG_VPA_PMU as "default m" to ensure it is available when KVM is
> being used.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/pseries/Kconfig: Enable CONFIG_VPA_PMU to be used with KVM
      https://git.kernel.org/powerpc/c/fe179677b6dcb4b658586038a811f87265e97777

cheers
