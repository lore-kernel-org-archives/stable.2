Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D463BB13D;
	Wed,  7 Oct 2026 18:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791397324; cv=none; b=q/QPyAiCUA9ZPh4sl40sTS0ZZ1yaN3fXeQ8UeC/uizsUkS8Ake46st6yiOAenTWfvIzl0OiD4P+WF2Ia6VsVLrJRr112PqNtO00gmAVwKnnmNUlYd4FXhbZraZdYJqtzWutKWSCoF4gSVo6KnMp5GKnrk5u2sGk1CN+c/IGPwpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791397324; c=relaxed/simple;
	bh=yxz1xWZhWytuO3CKDQJ/z72wF59AaWV52nP0Rm224zI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HoBOAWHtE/JEK+dExjdf0lHh6rGFfTq+9GGWfCdAHhZCmPfyWeXMAN5yl8CMKIcB2VV4a+IpscXLPUOBAmcHdB/JqD9bGaNldQY32KGxd0UGvAYkrJtUY7B4CbQwcydbBtlqate7ABNAuc/9TOxJvN7ZAw+khc3jO07QAZ8m1lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=clREpFGb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="clREpFGb"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697F5NX52822901;
	Wed, 7 Oct 2026 18:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=en18buxSWB8tkBM5D
	jdd83iWax4fZB02hX2gH5clJ0o=; b=clREpFGbrbj85tllp15x14X3MOFSd7C3z
	10iIU8WLP79EJIvEpE3eJmh+GaGpf7rPOi2yJ5c78FiloVwPbsctGKmVSt3B0Dqs
	OdGHhSaF/TpEehFmrI+PG+Iqz3saoHvwlqc2p0tRf4M4nSEzYF2XdtH+2kI2I/8h
	AfNLlNvZYzZu7oUSWtS72jIMxhAJWehUSW5CGx9+sgvKKP9da/YIov0xpf6Y0gc7
	eKMnRVEPU2xLu5cfbrf9KWpVIfAh13+qTKgkZWPYwiQkjqm3iCuz/YZkvY1VkPqZ
	Jkgrdkjb4uZBcyxKSlf2Xu4SywxzZyFzZwDAF+ThClmsbLnDkRy9A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5q4vh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 18:21:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697IHVow2307737;
	Wed, 7 Oct 2026 18:21:39 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgyta1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 18:21:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697ILZ9650004458
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 18:21:35 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB3DD2004B;
	Wed,  7 Oct 2026 18:21:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5ADB820040;
	Wed,  7 Oct 2026 18:21:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.25.208])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 18:21:31 +0000 (GMT)
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
Subject: [PATCH v4 2/3] KVM: PPC: Book3S HV: Add preempt_disable() around virtual-mode HPTE bit-lock users
Date: Wed,  7 Oct 2026 23:51:14 +0530
Message-ID: <20261007182116.12479-3-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261007182116.12479-1-amachhiw@linux.ibm.com>
References: <20261007182116.12479-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA3MiBTYWx0ZWRfXylbgpwvZmjTX
 sW+GhgZZuA7wFlkFFEGG5VlrVsMluBnkXOt/rnMx2BlNeALLPR4SZ07kUH/k3O3BDFlb2Wk3HRj
 UY2ZqBJMr/DWZItqCv8Rbcm5zvOMgPo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA3MiBTYWx0ZWRfX8Znf7pd5sDOC
 ozSR3/u6UgB3y2JOND7omhelkAF+eQrZioU6g9bEi18ygyEeDVO3c98m9wglYZlvrEugVYgarL9
 O/yXSUfoc7rxVXynRBTVxedAWfZjfERFpr/P70E10j5Lro8razqk6gOlE/JV6dj7T9bSDmYgGw0
 PYeeCxAY0D57yv206In7C4DSF9UcVrl0gJvgr5lUzBAhGh81xpU/2GPilnzwNYjnaPyBjfHnRJ7
 PswUPCx6BvSm/QgEefD2qzuuZIJsktQZ0skqDAdsPKHb6/Ch3om0zPVxCIMhaOwc+3/BaQoAI4+
 MnylD2okj7N7RHiwYNceMeORIUxsz0vFR9GfEniGbM3LhH20vIPCAb35O+hB9U6btEN/C15xmKN
 OAWT8L8O2WTLxYEhIDIJlf/bPvWgXubrbKtD3J/tqtpkPYbYQXWx5phFgtrPLQGB/esPm7gsDMv
 /rkL8nhttsYysrU4xxg==
X-Proofpoint-GUID: 7fOmBDx9kIIBr8fJ3SchTiSBabVwO3P8
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac68db5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=_8QwL2uVTp0K3HJSAJcA:9
X-Proofpoint-ORIG-GUID: JvCe07sVOH2QSvs9Wc6UZ2DQ6ZBO_KJP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070072

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
caller boundary.  kvm_htab_write(), the HPT migration restore path, also
called kvmppc_do_h_remove() directly with preemption enabled from two
sites: once in the n_valid loop to evict any occupied slot before
inserting a new HPTE, and once in the n_invalid loop to evict any
occupied slot that the restore marks as invalid.  This was inconsistent:
the insert in the same function already used the guarded
kvmppc_virtmode_do_h_enter() helper.

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
two kvmppc_hpte_hv_fault() call sites in kvmppc_handle_exit_hv() and
around the kvmppc_pseries_do_hpt_hcall() invocation in
kvmppc_pseries_do_hcall().

For kvm_htab_write(), introduce kvmppc_virtmode_do_h_remove(), a thin
wrapper that brackets kvmppc_do_h_remove() with preempt_disable()/
preempt_enable(), mirroring the existing kvmppc_virtmode_do_h_enter()
pattern.  The wrapper retains the full flags and avpn parameters so that
future virtual-mode callers can use the H_AVPN and H_ANDCOND conditional
guards if needed.  Note that kvmppc_do_h_remove() spins on both
HPTE_V_HVLOCK and lock_rmap() (via remove_revmap_chain()); preemption
must be disabled across both bit-locks.

For kvm_unmap_rmapp() and kvm_age_rmapp(), place preempt_disable() before
lock_rmap() so that both the rmap chain lock and the subsequent
HPTE_V_HVLOCK bit-lock are held under a single non-preemptible window.
There is an ABBA ordering constraint between the two locks: the rmap chain
lock must be dropped before spinning on the HPTE bit-lock (documented in
the comment above the try_lock_hpte() call in kvm_unmap_rmapp()).  To
preserve this, preempt_enable() is called after unlock_rmap() on the
failed try_lock_hpte() retry path and on any early-exit path, before the
cpu_relax() spin, so the HPTE lock owner can be scheduled.

For kvm_test_clear_dirty_npages(), remove the per-iteration
preempt_disable()/preempt_enable() pairs: this function has a single call
site, kvmppc_hv_get_dirty_log_hpt(), which already holds preempt_disable()
across the entire loop, making the inner guards redundant.

For resize_hpt_rehash_hpte(), place preempt_disable() before the
unconditional try_lock_hpte() spin loop and preempt_enable() after
unlock_hpte() at the single exit point.  This function is called from
kvm_vm_ioctl_resize_hpt_commit(), which first quiesces all vCPUs by
clearing kvm->arch.mmu_ready and calling on_each_cpu() to flush any vCPU
currently running in guest mode back to host.  With all vCPUs out of the
guest, no vCPU thread can hold HPTE_V_HVLOCK; any remaining lock holder
(an MMU notifier callback or dirty-log walker) runs on a separate CPU
and is not preempted, so the spin always makes forward progress.

Fixes: 6165d5dd99db ("KVM: PPC: Book3S HV: add virtual mode handlers for HPT hcalls and page faults")
Cc: stable@vger.kernel.org # v5.14+
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changes in v4:
- Introduced kvmppc_virtmode_do_h_remove(), a thin wrapper bracketing
  kvmppc_do_h_remove() with preempt_disable()/preempt_enable(), mirroring
  kvmppc_virtmode_do_h_enter().  Replaced both raw kvmppc_do_h_remove() call
  sites in kvm_htab_write() with the new wrapper.
- Updated commit message to document the kvm_htab_write() fix.
- Dropped Reviewed-by from Shrikanth as the patch was materially extended.

 arch/powerpc/kvm/book3s_64_mmu_hv.c | 33 +++++++++++++++++++++++++++--
 arch/powerpc/kvm/book3s_hv.c        | 10 +++++++++
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 2ccb3d138f46..e8f73c8f9780 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -47,6 +47,9 @@
 static long kvmppc_virtmode_do_h_enter(struct kvm *kvm, unsigned long flags,
 				long pte_index, unsigned long pteh,
 				unsigned long ptel, unsigned long *pte_idx_ret);
+static void kvmppc_virtmode_do_h_remove(struct kvm *kvm, unsigned long flags,
+				unsigned long pte_index, unsigned long avpn,
+				unsigned long *hpret);
 
 struct kvm_resize_hpt {
 	/* These fields read-only after init */
@@ -308,6 +311,22 @@ static long kvmppc_virtmode_do_h_enter(struct kvm *kvm, unsigned long flags,
 
 }
 
+/*
+ * Virtual-mode H_REMOVE.  kvmppc_do_h_remove() is also called from real mode,
+ * where preempt_disable() is not usable, so the guard stays here. The function
+ * spins on HPTE_V_HVLOCK and then lock_rmap() (via remove_revmap_chain());
+ * preemption must be disabled across both bit-locks so that spinning callers
+ * holding preempt_disable() can make forward progress.
+ */
+static void kvmppc_virtmode_do_h_remove(struct kvm *kvm, unsigned long flags,
+				unsigned long pte_index, unsigned long avpn,
+				unsigned long *hpret)
+{
+	preempt_disable();
+	kvmppc_do_h_remove(kvm, flags, pte_index, avpn, hpret);
+	preempt_enable();
+}
+
 static struct kvmppc_slb *kvmppc_mmu_book3s_hv_find_slbe(struct kvm_vcpu *vcpu,
 							 gva_t eaddr)
 {
@@ -810,9 +829,11 @@ static void kvm_unmap_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
 
 	rmapp = &memslot->arch.rmap[gfn - memslot->base_gfn];
 	for (;;) {
+		preempt_disable();
 		lock_rmap(rmapp);
 		if (!(*rmapp & KVMPPC_RMAP_PRESENT)) {
 			unlock_rmap(rmapp);
+			preempt_enable();
 			break;
 		}
 
@@ -826,6 +847,7 @@ static void kvm_unmap_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
 		if (!try_lock_hpte(hptep, HPTE_V_HVLOCK)) {
 			/* unlock rmap before spinning on the HPTE lock */
 			unlock_rmap(rmapp);
+			preempt_enable();
 			while (be64_to_cpu(hptep[0]) & HPTE_V_HVLOCK)
 				cpu_relax();
 			continue;
@@ -834,6 +856,7 @@ static void kvm_unmap_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
 		kvmppc_unmap_hpte(kvm, i, memslot, rmapp, gfn);
 		unlock_rmap(rmapp);
 		__unlock_hpte(hptep, be64_to_cpu(hptep[0]));
+		preempt_enable();
 	}
 }
 
@@ -890,6 +913,7 @@ static bool kvm_age_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
 
 	rmapp = &memslot->arch.rmap[gfn - memslot->base_gfn];
  retry:
+	preempt_disable();
 	lock_rmap(rmapp);
 	if (*rmapp & KVMPPC_RMAP_REFERENCED) {
 		*rmapp &= ~KVMPPC_RMAP_REFERENCED;
@@ -897,6 +921,7 @@ static bool kvm_age_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	}
 	if (!(*rmapp & KVMPPC_RMAP_PRESENT)) {
 		unlock_rmap(rmapp);
+		preempt_enable();
 		return ret;
 	}
 
@@ -912,6 +937,7 @@ static bool kvm_age_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
 		if (!try_lock_hpte(hptep, HPTE_V_HVLOCK)) {
 			/* unlock rmap before spinning on the HPTE lock */
 			unlock_rmap(rmapp);
+			preempt_enable();
 			while (be64_to_cpu(hptep[0]) & HPTE_V_HVLOCK)
 				cpu_relax();
 			goto retry;
@@ -931,6 +957,7 @@ static bool kvm_age_rmapp(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	} while ((i = j) != head);
 
 	unlock_rmap(rmapp);
+	preempt_enable();
 	return ret;
 }
 
@@ -1219,6 +1246,7 @@ static unsigned long resize_hpt_rehash_hpte(struct kvm_resize_hpt *resize,
 	if (!(vpte & HPTE_V_VALID) && !(vpte & HPTE_V_ABSENT))
 		return 0; /* nothing to do */
 
+	preempt_disable();
 	while (!try_lock_hpte(hptep, HPTE_V_HVLOCK))
 		cpu_relax();
 
@@ -1346,6 +1374,7 @@ static unsigned long resize_hpt_rehash_hpte(struct kvm_resize_hpt *resize,
 
 out:
 	unlock_hpte(hptep, vpte);
+	preempt_enable();
 	return ret;
 }
 
@@ -1868,7 +1897,7 @@ static ssize_t kvm_htab_write(struct file *file, const char __user *buf,
 			nb += HPTE_SIZE;
 
 			if (be64_to_cpu(hptp[0]) & (HPTE_V_VALID | HPTE_V_ABSENT))
-				kvmppc_do_h_remove(kvm, 0, i, 0, tmp);
+				kvmppc_virtmode_do_h_remove(kvm, 0, i, 0, tmp);
 			err = -EIO;
 			ret = kvmppc_virtmode_do_h_enter(kvm, H_EXACT, i, v, r,
 							 tmp);
@@ -1897,7 +1926,7 @@ static ssize_t kvm_htab_write(struct file *file, const char __user *buf,
 
 		for (j = 0; j < hdr.n_invalid; ++j) {
 			if (be64_to_cpu(hptp[0]) & (HPTE_V_VALID | HPTE_V_ABSENT))
-				kvmppc_do_h_remove(kvm, 0, i, 0, tmp);
+				kvmppc_virtmode_do_h_remove(kvm, 0, i, 0, tmp);
 			++i;
 			hptp += 2;
 		}
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 46dd550115a4..56083b415a29 100644
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

