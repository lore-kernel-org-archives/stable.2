Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F3252F294;
	Wed, 30 Sep 2026 17:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789926; cv=none; b=hSiat2EeH7lsnRfYg0inHBtS28sVJbehFbs3DUN4ymr8HdsghtqOGAECrzlrUWEi9GYhDSbIqlL46D2+7hcpojpt28HjgH8hKpGwJnMIpeK1m9dLaLJ1rk06j2ajiaaSN4nOuSwkuOls5Z9U94cOWyK8j3hX19Sqm/pGBKkONlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789926; c=relaxed/simple;
	bh=OAKkHFp1kQnEWZu2uh7np29DANFtgqqWtSiHQoGH/0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEtpO6J68Sn263SAPXJAjLfeAqK+g085Z8Eu9NX73qNZwtoxRIWxxKugApK77FUCSKuD6F9Wnk1VCdKSnnFrwC3cgBiHyT0t3yyXCA30xS45yZ6oF1kYqDjA4YwDwWXRyCz+tzEgx1WDLpTyWUHzNZ5CHhglDmcwfqm/U1zV9LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SxdQXQ+6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SxdQXQ+6"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE5VdL2986280;
	Wed, 30 Sep 2026 17:38:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nEzg2jd6RuXkUQyzJ
	FK96fLJits+zpgTCIBXNIAHffE=; b=SxdQXQ+6qH3iJCggvfPL2E3MmNiqcZ9DN
	Z+L4oPNZbA4tJ7WEjeNYZPmqjcBvNQVG192cmT5oMU21JezylF8hYjP0VEs6Ddot
	USB6Q26PiccHGEzH3chUFg0HSeaPezDGOBpTUBT1Ew4WP/yaQpJG3E68jItb8kBf
	1eO5KclsIguBOYP4rS4e1JusZg6FpEDTAA5gRQ2PICLn2bPOBvX/vMA6sDw+b44M
	i+FPEyL8KRwOYtoS2qAd4duMjELdF3FU3xlSb7blLhcQ+JIexlDrPFo8+lBfqyY4
	QbtYMuCvWG4lSCJfQ8T9yVtYDM0R3RGGJx1QVlfWc+6eAZ4SLJo0A==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fkdxpn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:38:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68UHXlm03541454;
	Wed, 30 Sep 2026 17:38:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0hfpd071-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:38:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68UHcNx029032886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 17:38:23 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6FD32004D;
	Wed, 30 Sep 2026 17:38:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B57AF20040;
	Wed, 30 Sep 2026 17:38:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.22.150])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Sep 2026 17:38:19 +0000 (GMT)
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
Subject: [PATCH v2 2/3] KVM: PPC: Book3S HV: Add preempt_disable() around virtual-mode HPTE bit-lock users
Date: Wed, 30 Sep 2026 23:07:49 +0530
Message-ID: <20260930173750.56759-3-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260930173750.56759-1-amachhiw@linux.ibm.com>
References: <20260930173750.56759-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ukeUoTHfBZXM5eXrhSXxPu5zuYQSeLAV
X-Proofpoint-GUID: P5mExd7rpMHmozzPuaNZnA6UexQVc5rE
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3MCBTYWx0ZWRfXwp8NW8YfWSiC
 8i95mWxfYLoa7zEM5uNEYJxd4ZwVVvNq8prSYjXJ4VZ/fOBHVi/UV7wAGBcJt4+PzKVp4hiqwOy
 14Vq5+vbHw8TmZOxaQnGkVE9bsbmIeU=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abd4915 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=7ra5lxVqLeyULECxJZQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3MCBTYWx0ZWRfXzhAyprID4Vsp
 ipRc0W7EAnW4hE+fpqXvdVdoRkAkVc7xVTWN+a3kPOnBkD8WWeXBL1RTIVsHreB00yln0SLwNWP
 m6wc2ta41wV0D55rOPPGe8snfS+EpJOdJ1qf+y+KrmM+IXdgQmWwlIpURDSb5sSFJ2lnvQhpZqB
 9YzR09MlXv3xv4ALkaU6aLjwistzdhhpNQgtV5e/23FkmvONcarxWTF5/P9OgG3YuGmuQJ1Fc/V
 Hbt2nuKLXfNUbaaCE9Q+QEnTXvYSHTrdZS0xLA8A1hSu4DQeBKfWtm9LLvsuHEwE/2L9Rc7supp
 XmJleoMBN7tR9b7aIlqrN7HIcDji1tOok7B52B+cLldhAkTgp+JOsSjadMh8ilT9dxuX+cGW3Z1
 NuHK/FE23uAvgQa41GuXU1JEU8cUGL9eUXRRBj5ZT5U98buXtH399AbTGcTGnrvk/mh8+9J47tH
 bSNWnW6+6R3AupnzZ9w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300070

kvmppc_hv_find_lock_hpte() requires virtual-mode callers to run with
preemption disabled, because it can return with HPTE_V_HVLOCK still held
until the caller later unlocks the HPTE.  Existing virtual-mode callers
in book3s_64_mmu_hv.c already follow that rule, but several paths do
not.

kvmppc_handle_exit_hv() calls kvmppc_hpte_hv_fault() for hash-mode
data-side and instruction-side faults after guest exit with preemption
enabled.  kvmppc_pseries_do_hcall() executes virtual-mode HPT hcall
handlers via kvmppc_pseries_do_hpt_hcall() with preemption enabled; the
handlers for H_ENTER, H_REMOVE, H_READ, H_CLEAR_MOD, H_CLEAR_REF,
H_PROTECT, and H_BULK_REMOVE all spin on try_lock_hpte() or lock_rmap().
H_ENTER also reaches kvmppc_do_h_enter(), which uses arch_spin_lock() on
kvm->mmu_lock.  That raw lock choice is intentional because
kvmppc_do_h_enter() is also called from real-mode paths, so the correct
fix is to establish the proper preemption context at the virtual-mode
caller boundary.

On the host side, kvm_unmap_rmapp(), kvm_age_rmapp(),
kvm_test_clear_dirty_npages(), and resize_hpt_rehash_hpte() also acquire
HPTE_V_HVLOCK via try_lock_hpte() in process context with preemption
enabled, serving MMU notifier callbacks, dirty-log harvesting, and HPT
resize respectively.

If any of these threads is preempted while holding HPTE_V_HVLOCK, any
other thread on the same CPU spinning on the same bit-lock can never
make progress, as the lock owner cannot be rescheduled to release it.
This is particularly acute when the spinning thread has preemption
disabled: it will never yield, causing a permanent CPU hang.

Fix this by adding preempt_disable()/preempt_enable() pairs around the
two kvmppc_hpte_hv_fault() call sites in kvmppc_handle_exit_hv(), around
the kvmppc_pseries_do_hpt_hcall() invocation in kvmppc_pseries_do_hcall(),
and around the try_lock_hpte() hold windows in kvm_unmap_rmapp(),
kvm_age_rmapp(), kvm_test_clear_dirty_npages(), and resize_hpt_rehash_hpte().
On failed lock acquisition the guard is released before the cpu_relax()
spin so the lock owner can be scheduled.

Fixes: 6165d5dd99db ("KVM: PPC: Book3S HV: add virtual mode handlers for HPT hcalls and page faults")
Cc: stable@vger.kernel.org # v5.14+
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changes in v2:
- Extended preempt_disable()/preempt_enable() to also cover four
  host-side virtual-mode HPTE bit-lock users in book3s_64_mmu_hv.c.
- Added warning comment above kvmppc_pseries_do_hpt_hcall().
- Dropped Reviewed-by as the patch was materially extended.

 arch/powerpc/kvm/book3s_64_mmu_hv.c | 12 ++++++++++++
 arch/powerpc/kvm/book3s_hv.c        | 10 ++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 2ccb3d138f46..59da958e09cb 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -823,7 +823,9 @@ static void kvm_unmap_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
 		 */
 		i = *rmapp & KVMPPC_RMAP_INDEX;
 		hptep = (__be64 *) (kvm->arch.hpt.virt + (i << 4));
+		preempt_disable();
 		if (!try_lock_hpte(hptep, HPTE_V_HVLOCK)) {
+			preempt_enable();
 			/* unlock rmap before spinning on the HPTE lock */
 			unlock_rmap(rmapp);
 			while (be64_to_cpu(hptep[0]) & HPTE_V_HVLOCK)
@@ -834,6 +836,7 @@ static void kvm_unmap_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
 		kvmppc_unmap_hpte(kvm, i, memslot, rmapp, gfn);
 		unlock_rmap(rmapp);
 		__unlock_hpte(hptep, be64_to_cpu(hptep[0]));
+		preempt_enable();
 	}
 }
 
@@ -909,7 +912,9 @@ static bool kvm_age_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
 		if (!(be64_to_cpu(hptep[1]) & HPTE_R_R))
 			continue;
 
+		preempt_disable();
 		if (!try_lock_hpte(hptep, HPTE_V_HVLOCK)) {
+			preempt_enable();
 			/* unlock rmap before spinning on the HPTE lock */
 			unlock_rmap(rmapp);
 			while (be64_to_cpu(hptep[0]) & HPTE_V_HVLOCK)
@@ -928,6 +933,7 @@ static bool kvm_age_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
 			ret = true;
 		}
 		__unlock_hpte(hptep, be64_to_cpu(hptep[0]));
+		preempt_enable();
 	} while ((i = j) != head);
 
 	unlock_rmap(rmapp);
@@ -1043,7 +1049,9 @@ static int kvm_test_clear_dirty_npages(struct kvm *kvm, unsigned long *rmapp)
 		    (!hpte_is_writable(hptep1) || vcpus_running(kvm)))
 			continue;
 
+		preempt_disable();
 		if (!try_lock_hpte(hptep, HPTE_V_HVLOCK)) {
+			preempt_enable();
 			/* unlock rmap before spinning on the HPTE lock */
 			unlock_rmap(rmapp);
 			while (hptep[0] & cpu_to_be64(HPTE_V_HVLOCK))
@@ -1054,6 +1062,7 @@ static int kvm_test_clear_dirty_npages(struct kvm *kvm, unsigned long *rmapp)
 		/* Now check and modify the HPTE */
 		if (!(hptep[0] & cpu_to_be64(HPTE_V_VALID))) {
 			__unlock_hpte(hptep, be64_to_cpu(hptep[0]));
+			preempt_enable();
 			continue;
 		}
 
@@ -1077,6 +1086,7 @@ static int kvm_test_clear_dirty_npages(struct kvm *kvm, unsigned long *rmapp)
 		v &= ~HPTE_V_ABSENT;
 		v |= HPTE_V_VALID;
 		__unlock_hpte(hptep, v);
+		preempt_enable();
 	} while ((i = j) != head);
 
 	unlock_rmap(rmapp);
@@ -1219,6 +1229,7 @@ static unsigned long resize_hpt_rehash_hpte(struct kvm_resize_hpt *resize,
 	if (!(vpte & HPTE_V_VALID) && !(vpte & HPTE_V_ABSENT))
 		return 0; /* nothing to do */
 
+	preempt_disable();
 	while (!try_lock_hpte(hptep, HPTE_V_HVLOCK))
 		cpu_relax();
 
@@ -1346,6 +1357,7 @@ static unsigned long resize_hpt_rehash_hpte(struct kvm_resize_hpt *resize,
 
 out:
 	unlock_hpte(hptep, vpte);
+	preempt_enable();
 	return ret;
 }
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index aa51968e206a..0b7743bb89d9 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1159,6 +1159,10 @@ static long kvmppc_h_rpt_invalidate(struct kvm_vcpu *vcpu,
 	return H_SUCCESS;
 }
 
+/*
+ * Must be called with preemption disabled. The HPT hcall handlers spin
+ * on HPTE bit-locks and cannot make any blocking/sleeping calls.
+ */
 static long kvmppc_pseries_do_hpt_hcall(struct kvm_vcpu *vcpu, unsigned long req)
 {
 	switch (req) {
@@ -1212,9 +1216,11 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 	case H_CLEAR_REF:
 	case H_PROTECT:
 	case H_BULK_REMOVE:
+		preempt_disable();
 		idx = srcu_read_lock(&kvm->srcu);
 		ret = kvmppc_pseries_do_hpt_hcall(vcpu, req);
 		srcu_read_unlock(&kvm->srcu, idx);
+		preempt_enable();
 		if (ret == H_TOO_HARD)
 			return RESUME_HOST;
 		break;
@@ -1834,8 +1840,10 @@ static int kvmppc_handle_exit_hv(struct kvm_vcpu *vcpu,
 		else
 			vsid = vcpu->arch.fault_gpa;
 
+		preempt_disable();
 		err = kvmppc_hpte_hv_fault(vcpu, vcpu->arch.fault_dar,
 				vsid, vcpu->arch.fault_dsisr, true);
+		preempt_enable();
 		if (err == 0) {
 			r = RESUME_GUEST;
 		} else if (err == -1 || err == -2) {
@@ -1881,8 +1889,10 @@ static int kvmppc_handle_exit_hv(struct kvm_vcpu *vcpu,
 		else
 			vsid = vcpu->arch.fault_gpa;
 
+		preempt_disable();
 		err = kvmppc_hpte_hv_fault(vcpu, vcpu->arch.fault_dar,
 				vsid, vcpu->arch.fault_dsisr, false);
+		preempt_enable();
 		if (err == 0) {
 			r = RESUME_GUEST;
 		} else if (err == -1) {
-- 
2.54.0 (Apple Git-157)

