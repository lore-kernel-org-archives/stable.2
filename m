Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10443B5850;
	Tue,  6 Oct 2026 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791289485; cv=none; b=XH6av6sWZWg6aA1EsFMNxd9Kv+NtIBpsTJFH0mmyJZMeT3d/TBTsp+Awq5T0lo2TirHmOKaxQOc/0jobjQYD4cYyEJd1yNXZ6EksX5bLKG1PGQ0pzj48w3PaBqwpXNKYXNEufOG1K9wSPSRynzbmKJgguIkzzW2U8L4GJLNcilU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791289485; c=relaxed/simple;
	bh=JMtXyub75LHZzq5CenikW83L6TMi58/yCremmTq73tc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C578M33xDSvZ1hshss2Icugf8ZynfHSahOTR9htYNOUG5JY1F6/l1fuxbg9BRKtktvksBYWtPYRVLrPEfROKmeJAL9C+/QFkyMWTw74dZNoK+7nbxqCyVcEE0zc2uqpmJbJmfJAnxeufWb/w9O5lsWqTM3d5mgsOHWXkfcYBrYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=r6BpvhNV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="r6BpvhNV"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696BZYqU2400147;
	Tue, 6 Oct 2026 12:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=C+zoc7oGbtC3fEjZzjfOVnYalrPV
	zXXdmo8kUzPqF00=; b=r6BpvhNVBWKEj78vbom2svpfGZ8JM+eDMcsI98A9oIBY
	8oK1McjGjjqbb8OOkglw/jnGPK+MMRQIdyynB+wcnusbBFhGHxPndMEeS3J73GS7
	pDoIFmZpU0f+o/aOIGiyefC9CW9XCBp9lPKnaGuwVTUAvYjflwC5rbsS3tq3TRIF
	djqvc75h9Hd9acenSMjFKyn9TSYThwIdH2nE7gECEIjFej65/oaAf0nUFRgUE23W
	Xz/Oje+dLweS79fMS44rNgp+9HOBFMFnJ3m2RHxPTpftl3EUaNFqIZxbZryK9AXV
	/KsA7l1KOQDUYUMieJwjBRU1blaXVlSgiZN0BaZ+bA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4fy3ek-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 12:24:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696BWVl4242255;
	Tue, 6 Oct 2026 12:24:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3eqy9ka2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 12:24:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696COFcs37814758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 12:24:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 141672004E;
	Tue,  6 Oct 2026 12:24:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A62AF2004B;
	Tue,  6 Oct 2026 12:24:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.214.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 12:24:10 +0000 (GMT)
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
Subject: [PATCH v3 0/3] KVM: PPC: Fixes for Book3S HV HPT locking and paired-single decoding
Date: Tue,  6 Oct 2026 17:54:01 +0530
Message-ID: <20261006122404.99358-1-amachhiw@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac4e874 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=oqY91GN2WXtsPlI78dAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0OCBTYWx0ZWRfX/t3z9SrS9xyT
 /apWL4UfNmfUAk79bcKhw1Yk+Uzdmn33pM3kthOXiqPnlRay219u8JadMGZdg29zpD2cQ2gk6LJ
 sB7FnvJN1yPlCuMnM2BcGdJJFZQretUIkpTf/ic3DuBQHtcLJItIVEo2wpQJn1OZqF0+CvcCZnn
 YdFhoMqgrrPhHAi3ACMUj3Sm5cLIL9Ws91zYxpXXOsfOI+O8WgVtiJ7jYqELr5CHlt6U99whJ0d
 Vyj6pDKSkMkNTXqGN9Qqk1zzyxneuogaSSsyU6Nmc/zvY3hfQaq7XrqWWfH7w8yLPUTW353ROXf
 7179rd9syqKgE1LCagVpuXo3zuPbneSp5UKxLJ23UdEAG40VYyIQjP61RpEu0Tm33JI0LgRHt8+
 1frsFpbagxxhMC60rls59zF4+iCu8uEVMd7o0pHEeItYYZfi4BtPohnVdnrofq4kEdv8+ipyfCz
 Wh6xsAnElnvEYAFw+9A==
X-Proofpoint-GUID: FPMorKzIomUgpvXsPoTvw-NSE_KvZ-y1
X-Proofpoint-ORIG-GUID: j0MJPDwhh1d3XkqVnIY_GHm7BWHwGdky
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0OCBTYWx0ZWRfX7li4L611Mr8/
 9ZoZSuFaEqfShWWGHOZcNY1f28oVV9AcU11lkcvfJWacj9YKpojA4QPKUJvyvo0FDf1D8WXsl3t
 v3Li7wuQ4R/69ottU1h0MMJs3554dMs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060048

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
  (kvm_unmap_rmapp(), kvm_age_rmapp(), resize_hpt_rehash_hpte()) — to
  prevent CPU stalls and deadlocks on preemption.

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

Changes in v3:
==============
- v2: https://lore.kernel.org/all/20260930173750.56759-1-amachhiw@linux.ibm.com/
- Patch 2:
  - Fixed preemption window in kvm_unmap_rmapp() and kvm_age_rmapp(): moved
    preempt_disable() before lock_rmap() so both the rmap lock and the HPTE
    bit-lock are held under a single non-preemptible section, and added
    preempt_enable() on all early exits and retry paths before cpu_relax().
  - Cleaned up kvm_test_clear_dirty_npages(): removed redundant per-iteration
    preempt_disable()/preempt_enable() pairs since the caller
    kvmppc_hv_get_dirty_log_hpt() already holds preempt_disable() across the
    entire loop.
  - Reworded commit message to clearly detail the per-function locking design
    and rationale.
  - Picked up Reviewed-by tag from Shrikanth Hegde.
- Patch 3:
  - Picked up Reviewed-by tag from Shrikanth Hegde.

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

 arch/powerpc/kvm/book3s_64_mmu_hv.c      | 10 +++
 arch/powerpc/kvm/book3s_hv.c             | 80 +++++++++++++-----------
 arch/powerpc/kvm/book3s_paired_singles.c |  7 +--
 3 files changed, 56 insertions(+), 41 deletions(-)


base-commit: 2c3418fffa9d037b2038a6db48be63f9e2291806
-- 
2.54.0 (Apple Git-157)

