Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521C752BE3E;
	Wed, 30 Sep 2026 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789924; cv=none; b=ewPHmUIH0CuAhiA+ISt7f+MM/CiY8ifc+HT9mX9Vfln9uI7d+FUmPvsmMe4mdEx8zD3WkV0BreqjIrhHUPyW/DWct2zD3h7idWGXr458qhuzsVibklgnVodr1wYklJFA/x5wWW14NVQ32cvs8sO48aGVynqpdSBfKKcP2POcAjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789924; c=relaxed/simple;
	bh=v28171voK6ITDVbjCW9+8XZ002sbdQquEKk2lhMsh2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AKjtXxuYLWkm4Lb4gounpvZXhGWF6zXjRVM9T8fab5oZxMjYLDVnRZjOi49Wj8rV8eJO+325+3ZdTb629zVdINzHmR4sYE3op6kqy4jh7x5iNPuVNvvHAUubKp7Sq5NHMHd7LuZdEN8jNZFwSpUZ8g2fgKe6nyHxx3nKg/AIMU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CusY6HCP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CusY6HCP"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE5VdK2986280;
	Wed, 30 Sep 2026 17:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=t0wlvl0FQ8sNawM9GeK+EIM7O/ri
	c7+D+cGE/yCo4Y4=; b=CusY6HCPxYZmZ2DfRT4KFa/LvJKkKLM7yH7qkT7e8tok
	kySTM8jW/Q3ln0QwK/eeD4idv0RYg6aenFhJoL/QThHan6bxa6P0iZRb6RZavsrb
	6B1vES4x90CUOEdcnXp5Gs608AEvX1al1yRlZrEnr7Asdz5gvwzIG1IZdCUQpNPG
	E46r7ZNYPqbQVArA6aSoeMzE/0tf/+ydb94Wx1G/5UFDHA5TDhpMTMfQQRjG84Cg
	V4sIq6Nd07KUD7k5IPtw5rPr7foc/hp7p+zMJKjjtDjni3L59BChTx0xz02RTazH
	7+eygEB5NCqwUheg3pQdBOYz0qadYRs3dV/W6n/eLQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fkdxnu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:38:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE34W33576911;
	Wed, 30 Sep 2026 17:38:16 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0j23mtxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:38:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68UHcDIm51904852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 17:38:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2859B2004E;
	Wed, 30 Sep 2026 17:38:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B49D2004B;
	Wed, 30 Sep 2026 17:38:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.22.150])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Sep 2026 17:38:08 +0000 (GMT)
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
Subject: [PATCH v2 0/3] KVM: PPC: Fixes for Book3S HV HPT locking and paired-single decoding
Date: Wed, 30 Sep 2026 23:07:47 +0530
Message-ID: <20260930173750.56759-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: SeGuGoVlhZM0TlKSw8-iLKK7Dy4JUz8n
X-Proofpoint-GUID: YESN-aB4JFFsTx0xJnLMF-GUMWB44y5K
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3MCBTYWx0ZWRfXwuzjQc7pwhAT
 cjFYIB80mL729d5l3tVCNgHIhVaZjnLgXyKhEMM9h5NXkAdBwCRvoZKrO5bjoFpThlelksQudsH
 nDDdAusBdjKLP6bSNl8Y6VPuihJ/FPM=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abd490a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=r1Rob55TE6mfzCDdm84A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3MCBTYWx0ZWRfX0y3XiOxxR0H2
 8IVWtUYcYji8RXPWXY7KQ87cwaY24kQclpW2SmkQb/h9L+3Q8zYYGaWKs2QRS3Fm3chknCiT6hE
 PV9KIj0B8lXr3crEKPanrOc8/BqoZvM7FsbFCwPulSah6h6GMHkmLhEgQS6wDFIioIP/Y8GNco6
 nrhu45Gaok9dDSfHESyqFvxBOsw+/vg+MKcC2Cp1fvEsDQno7PMBKGMyzETXuEX22+bO36M/5iE
 /Hq9Z5I4JMhK/rul9CRxSm3QnnykqnYg/D7AKJczA6+lRku5JwvS50yBgxbsILX08btxrylkEJ1
 56IVnAmIZKqy97tOTEJ8CcNhmIYjZhFSqIsPqE9r2s4EnJVGyBl4FS4NhRmMrToXiGVso5I507U
 zsT57gLN79YkeavhDuJ5GRyvl/S76i8UZjMndJsKKgVCsU9dggvnYbToqEg3IdzFQZPpS/80FMi
 pcs9xLGO5WEOrHPoHLQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300070

This series addresses bug fixes across KVM PPC Book3S HV
locking/synchronization and paired-single instruction decoding.

Patches 1 & 2 fix synchronization and preemption issues introduced in
commit 6165d5dd99db ("KVM: PPC: Book3S HV: add virtual mode handlers for
HPT hcalls and page faults"):

- Patch 1 adds SRCU read lock protection when walking memslots during
  virtual-mode HPT hcalls to prevent use-after-free races with concurrent
  memslot updates.

- Patch 2 adds preempt_disable() around all virtual-mode HPTE bit-lock
  holders — both the guest vCPU paths (kvmppc_hpte_hv_fault() and
  kvmppc_pseries_do_hpt_hcall()) and the host-side paths
  (kvm_unmap_rmapp(), kvm_age_rmapp(), kvm_test_clear_dirty_npages(),
  resize_hpt_rehash_hpte()) — to prevent CPU stalls and deadlocks on
  preemption.

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

Changes in v2:
==============
- v1: https://lore.kernel.org/all/20260928122837.8782-1-amachhiw@linux.ibm.com/
- Patch 2: Extended preempt_disable()/preempt_enable() coverage to also wrap
  the HPTE bit-lock hold windows in four host-side virtual-mode functions:
  kvm_unmap_rmapp(), kvm_age_rmapp(), kvm_test_clear_dirty_npages(), and
  resize_hpt_rehash_hpte(). These were identified as vulnerable by Sashiko AI
  review and confirmed correct by audit.
- Dropped Reviewed-by from Ritesh as the patch was materially extended.
- Patch 2: Added warning comment above kvmppc_pseries_do_hpt_hcall()
  documenting the preemption requirement.

Amit Machhiwal (3):
  KVM: PPC: Book3S HV: Add SRCU protection for virtual-mode HPT hcalls
  KVM: PPC: Book3S HV: Add preempt_disable() around virtual-mode HPTE
    bit-lock users
  KVM: PPC: Fix get_d_signext() 12-bit displacement for paired-single
    D-form

 arch/powerpc/kvm/book3s_64_mmu_hv.c      | 12 ++++
 arch/powerpc/kvm/book3s_hv.c             | 80 +++++++++++++-----------
 arch/powerpc/kvm/book3s_paired_singles.c |  7 +--
 3 files changed, 58 insertions(+), 41 deletions(-)


base-commit: 551c722f40809618230001baccf219193e22fc5a
-- 
2.54.0 (Apple Git-157)

