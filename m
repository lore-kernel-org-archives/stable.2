Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039144AE104;
	Mon, 28 Sep 2026 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595477; cv=none; b=UtdTUjlaKKjv9Hn0yVb3hMJRrDTT0p+UA6y8xMPAZudAK28lzB5DUhYjr52QkAkE6BhTX4Rcgs6S+J56r0ikIrM0VwLRRkW/XKWIpqkRz2LpiDHR/9eXwqV8MPE7qMOq5SBhVGqudf7azPFESMeXgryjx/vIdx8chRgR1O879pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595477; c=relaxed/simple;
	bh=KEwxmPZ7N5rTq6IZH6T54Uk7T4wG1pcmiTHyYxo1z4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o9Zk5ijzE7LT8NniO7y69Pjz9edLFE5S9BlU7TtkWsYd5gsLP1QHtIOm8eZHaJh6GY4nKpnlUv9rVSoXPUVxV9D0JPRNloh+MB1KtTxR3VMy4PA267GtxaPUSwbaklgrlcd68amgi3F4by3mxuD5TTedUHSpc4NZBwj2IXLcpnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vq6RXwxQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vq6RXwxQ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBZUJs3374975;
	Mon, 28 Sep 2026 11:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=x2xmMN
	zKjtCPYjLRdILk4fj7na5Nc4PfnpP5/QbkxXU=; b=Vq6RXwxQTXDF0jlc6x/wfV
	QdFHRNhVsnu3Ot5fCNhVh9z5nKKFvXe/vU/J0RvR+oC3seUpNLtCkvOOg/vQ1XoY
	l25vwg2fiGgTdjYhSsVr459PgvRlCqF87dUc6LrFsYMEz0qiX1/799ufnuHJq3sL
	z+I2KhqHEGuBsdOp1UHeg34MXlrdTaoObQVHq4uhh7Ut5yCfyBzN/Z9PCinGdG9M
	kzPbe9yge/ht+t3IbA4f4/7ybk3PACVjIEzb5s+9qPgt0aVKQZ6g09ayUwa0cpu1
	zzSpBO/xmMS7V4OCmnp2ZO13UgNmcGx/N9IfhgAq5y2VJvP36+kWYeUIUFzOyS8Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qr100q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 11:37:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBHXJ2027121;
	Mon, 28 Sep 2026 11:37:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxrrw53d2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 11:37:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68SBbbrJ16318858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 11:37:38 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D44E920049;
	Mon, 28 Sep 2026 11:37:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D46DD20040;
	Mon, 28 Sep 2026 11:37:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.213.32])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 11:37:33 +0000 (GMT)
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
        stable@vger.kernel.org
Subject: [PATCH 0/3] KVM: PPC: Fixes for Book3S HV HPT locking and paired-single decoding
Date: Mon, 28 Sep 2026 17:07:04 +0530
Message-ID: <20260928113704.48912-4-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928113704.48912-1-amachhiw@linux.ibm.com>
References: <20260928113704.48912-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0NiBTYWx0ZWRfX2KqGQRu10d33
 QuPNTXevaHOMB2qvFXarQKWjrt3TGDfNy/oatGXl3kVFhx8kgjAOMSLcukXdcGJCSNBLAVWnCsT
 2hXpfU3t4CLrnejfXNQhZ/EvvD3xSMR+OoOQzwMotK0F/rJ+8golb7Z2hprghlIXoqQj/7PQvE2
 0QqxhhCATzaEMqyA2gQ/gUzhIjjW9X9F6xKLVELxK3TEHjV/oRUHUgoju/qahoolVWiPbdZXwsZ
 W9m7BJD87hJNsSx+RLhH4OEz9t79+V6Pv+t4q5gYuYd4SAFFv7NUGYXjwZQtybf5fIlZb7xKEsj
 OvgKLPLnxq4eLIzZeuGlrEpiQzpsmgqw3K6CP4N1sJSxYvcDL4AZJ0k3bykow++RP9kXo+2+C+a
 ms/YjLyhvZuRqSS8vJtAKZg6YPvnddb/ebJfuCctE8uPKubyFHMPfQjxldrrt4RLQGe8Z7L1FeW
 1NDXqgZ4DPcZY23S7GA==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6aba5187 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=xeR9sofGuDUk7aJHNYQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: W32aKltjmGa0iWijbYmfOgQdZ1UPMOGk
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0NiBTYWx0ZWRfX/V8dIlANS5ZT
 Ofev2tRfE8afJgHlwC2zbD4KHcPmUnSRVgGxblZTZawHw0T/NjY9qiG9g23+bXBRum1id8RZqU8
 Z73ezwd+MJoVT1qWjr2m7TtFE/JgutQ=
X-Proofpoint-GUID: Y9IwlEn_FYjkWH6Vax9gHXAJRs4FJEFx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280046

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

