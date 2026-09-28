Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942DE35677E;
	Mon, 28 Sep 2026 12:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598549; cv=none; b=lhQht/CxvkWCIfmsd0HxSk6bJcoDm7tLhfQwDQ860NKALvIEEwdWU3jkh0OjobujMwvnVdV4i1FhqOJHg313EUZ9t8WBGVbgPcD51zdj8R01qSnjQo8nwGEp9ULwAW/fzi3y93M9m7ib2LvTiWLpMujgWaw3OjiIPp6tISSYnoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598549; c=relaxed/simple;
	bh=KEwxmPZ7N5rTq6IZH6T54Uk7T4wG1pcmiTHyYxo1z4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C0o3OsLtA1zs8q4Bywk980FydZ5w3AE5exE9mvaMYzMT1vDgdfaAiRkkhOws9pU2rrC0Fo1VMLGcPh8HljooyUnQYs/90kMKZosuFn0+vnHeM6O7L0ugWdskL6F1HpQY6GktHaM6uMgMMk+XTviyuR0AIBvEotoZOROmsHoBTHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pLwcHGa8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pLwcHGa8"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBZSfH1046917;
	Mon, 28 Sep 2026 12:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=x2xmMNzKjtCPYjLRdILk4fj7na5N
	c4PfnpP5/QbkxXU=; b=pLwcHGa8k/jjURr76EcHKnXW7lsPkQzN8PeZT+AySMTA
	kD6SQKEM8h7d+Ff423ALAZR+KykEd/we2D/bkalOvLtxlmBgJ3cqU45D31OnKTX3
	dclUcvbPYOhpGN3RRHHq0jdHgkC/2OS7bMLl6B9epXLII5PY6HrzVB+tuiBWQPQv
	8DrkkD3Z1c6p+erWsbTjmNP7I5EEuUmyiHvbrVAtGklJBFxxEi8wcYoyWSxcxTqX
	DqK+sir0BqM09j0Q7nUVdvo+8vmQr+TFQm8/yyLjxWu+FyJo4EBKkVYq9y3Rnt2p
	YTqHvljIPNoORAEmEwnqAsakvJFBHrj/tNNjN6aX2Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j519r6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 12:28:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBHVIk027102;
	Mon, 28 Sep 2026 12:28:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxrrw589k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 12:28:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68SCSl4O47120868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 12:28:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 508B320049;
	Mon, 28 Sep 2026 12:28:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4861B20040;
	Mon, 28 Sep 2026 12:28:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.213.32])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 12:28:43 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, kvm-ppc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gautam Menghani <gautam@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        R Nageswara Sastry <rnsastry@linux.ibm.com>,
        Alexander Graf <agraf@suse.de>, linux-hardening@vger.kernel.org,
        stable@vger.kernel.org, Avi Kivity <avi@redhat.com>
Subject: [RESEND PATCH 0/3] KVM: PPC: Fixes for Book3S HV HPT locking and paired-single decoding
Date: Mon, 28 Sep 2026 17:58:34 +0530
Message-ID: <20260928122837.8782-1-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0OCBTYWx0ZWRfX/qUviAPhjMxs
 2zHX6iVwCFEjO9EA8C5gpj4Er5DJWotViwfK8Lij9npyPeP38xMkr5e0Lt+dgKcSm1i9ScNoVtn
 IoSbFRGwV5B7tt2kLV8LQRLjPQnbXzM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0OCBTYWx0ZWRfX5PosWKNc8wT6
 Gy4qane5wuVQJYMX5aA13wgb6Jwy5GnYIgTawjNlPWr6Fuy0WfRMZn6fGTT0ILl5QRGpDw3KTXn
 VdtRh54ZuFr8CkFUis2tyqYjUk4PmEZLxyTeGGvJDy+Zzt02DDLeWHBCzqd83MUYEEAJ5+Rx+O9
 ItblLj4n5Vdj9Swlr9bWuYBntWcLFqCGoQRGrGFfgGS0RoHDvPPNBxv7gJF/1SVkvjeU6CpxcxH
 6jFa/M5L05XdEk2P85Sdtg9obx5YB7qyevbRZUOt2KLPSIPj4czgo2a0gHGhSeCCWb8lRy1+ITV
 F8fsN1EYvCzoO/VmNpBZ9exuo8HpFfyocegdsbOgD5W84myO2rXCFnIbGI2bG6w+ZM8EhiAKhO9
 UmIrd9wKqW+R01Yk/hGAyHelxHp93GmKlVluX6HIGaXtOcpomCAozqJbF8Dx/xTTn2WlVcAcM04
 Xem5p36M5S2/v/2vA8g==
X-Proofpoint-GUID: iPoNhfLhehG2O0FarOkvm_cy-fX6m4FM
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6aba5d84 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=xeR9sofGuDUk7aJHNYQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: gaLnld1lFRqszw9p9-Y0klYVVHQccNO_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280048

This series addresses a few bug fixes across KVM PPC Book3S HV
locking/synchronization and paired-single instruction decoding:

Patches 1 & 2 fix synchronization and preemption issues introduced in
commit 6165d5dd99db ("KVM: PPC: Book3S HV: add virtual mode handlers for
HPT hcalls and page faults"):

- Patch 1 adds SRCU read lock protection when walking memslots during
  virtual-mode HPT hcalls to prevent use-after-free races with concurrent
  memslot updates.

- Patch 2 adds preempt_disable() around virtual-mode HPTE bit-lock holders
  and raw spinlock usage to prevent CPU stalls and deadlocks on preemption.

Patch 3 fixes paired-single D-form instruction emulation:

- Patch 3 fixes get_d_signext() to correctly extract the full 12-bit D
  displacement field and perform proper two's-complement sign extension.

Testing:
========
All test kernel builds were compiled with CONFIG_DEBUG_ATOMIC_SLEEP=y.
The following scenarios were verified:

1. Power9 PowerNV (L0) in Radix mode:
   - Booted L0 host with kernel containing all 3 patches.
   - Booted KVM guests in both Radix and Hash modes.
   - Ran kernel build workload inside guests — no errors observed.
   - Booted L1 guest with the same kernel — booted and ran cleanly.

2. Power9 PowerNV (L0) in Hash mode:
   - Booted L0 host with kernel containing all 3 patches.
   - Booted KVM guest in Hash mode.
   - Ran kernel build workload inside guest — no errors observed.
   - Booted L1 nested guest with the same kernel — booted and ran cleanly.

3. Power10 LPAR (L1):
   - Booted Power10 LPAR with the patched kernel.
   - Booted KVM guest and ran workloads — no errors observed.

Amit Machhiwal (3):
  KVM: PPC: Book3S HV: Add SRCU protection for virtual-mode HPT hcalls
  KVM: PPC: Book3S HV: Add preempt_disable() around virtual-mode HPTE
    bit-lock users
  KVM: PPC: Fix get_d_signext() 12-bit displacement for paired-single
    D-form

 arch/powerpc/kvm/book3s_hv.c             | 76 +++++++++++++-----------
 arch/powerpc/kvm/book3s_paired_singles.c |  7 +--
 2 files changed, 42 insertions(+), 41 deletions(-)


base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.54.0 (Apple Git-157)

