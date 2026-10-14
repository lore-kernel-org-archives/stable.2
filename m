Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF3B38655A;
	Wed, 14 Oct 2026 18:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792003979; cv=none; b=FQowq+V0qvArQKcULXWx7ta1b+jXJncr/rei0Tuj6EDRcT7fhOJ6k7T3syV1N5d3VN3Opz7kUQWiFhumepGSWg3FrUEX0KSmm/Gm7T3IdCwwmWbLfWXDxcfcOHZlgco5Sdd0xtMmijOW63hu0YPg+iQEE2RLr+v0X7StC/xEu3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792003979; c=relaxed/simple;
	bh=NtXXmUFh4yEcf5lZeCGSfPecnP0mif1ljL2uiN80xfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ESss654t7Z3T+9j1flw+uhyHaH572TZ4CKxraBuq7sReeC92hKDwOOI5dxvOCO5Hxsg2gBwD0+S08XDJ8cuod5Qv3lECLf9a7NXV6OS9XEm8gp6NiFAJ1FmTik9CluUz8z+9gzPXZWi88T/DI3cvAhJcToNPEYi95fTDXHliqO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YEaKUVGw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YEaKUVGw"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EEiGuL695126;
	Wed, 14 Oct 2026 18:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=f8KsDhg9pm4bCQDb3ubPaEk/2DRbxsFtwc6KrYfMi
	3Y=; b=YEaKUVGwcffdWAbPunpGiF7HEz0HVD3TRk7oQVmFvhAWYXX5cvMozD96/
	MYW0nKcZs0Xsg++/0INRrxsSbP1uNnP9363m6bEPejaf46qm/9W4eEz+IGkkZ4qe
	gcBpLN8HhiiIy3mUTtWZj5sXMdnpfE4NzYpL23VNGw3Sk9GTVaVynvrP2cP68A98
	QDJQvqqRIBJ5xw1mDVep5pdVIAIuDCIPh6M8uqL/LRMAnHEn571fqfi5eWzgu54Y
	u5j+fRgCgPcl7AeJD8u12jYJ8RS95pSGHQaHMF+3OoY/+e8NEqyMemT+KoWSXVHN
	i+7Wax51N3Q9e1LDn9WNE7BezW7Rw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhp79y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 18:52:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69EIl1rE669873;
	Wed, 14 Oct 2026 18:52:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h9ypq3mth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 18:52:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69EIqTqI14615038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Oct 2026 18:52:29 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C80320049;
	Wed, 14 Oct 2026 18:52:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1E5120040;
	Wed, 14 Oct 2026 18:52:24 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.30.160])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Oct 2026 18:52:24 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Alexander Graf <agraf@suse.de>, Avi Kivity <avi@redhat.com>,
        kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        R Nageswara Sastry <rnsastry@linux.ibm.com>,
        linux-hardening@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] KVM: PPC: Book3S HV: Disable preemption around host-side HPT lock users
Date: Thu, 15 Oct 2026 00:22:15 +0530
Message-ID: <20261014185215.71832-1-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3NCBTYWx0ZWRfX/rpnX+F4eBgz
 z5lT9nz+ksuhkq+gv7WXD/aY8F6rDEs3tC2JlhC50cpDtahxXaHau+6KRBVUy+J7PQMr9H4Et2c
 iUjtanx5svSKKQYiN1EwPQH4mzVfnvE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3NCBTYWx0ZWRfX5VGGHo4MHb1W
 fuXPLSrUIbAtR+aIjkopl2hLro0/nkvlAg9dCNrwH0d3kKO4kZa3UwVBFr66rrV7khFhOjZfn/i
 pW+3OtrbA1hHs3ugAXRYpGzxcdi/g8uEGGsL76MXsrW4ti88VaDNlu8Jz6mlFi9wfbK5nhUG45O
 jY2N4+SdIIuQvvfFn1F/9eXE5Z9vVIcWUdAT/r1JnQv4bAkN9Y4B91pjJiCkRbddnq2E8FaSA/c
 rRhhHJqyW4ox2S5EL1cs/WOfb4/bTG+PnFQMQZ9VvE/HbonjM0GA8/vdBBN7+NZRCoOX7DQbxqw
 Lt5qAqzhlmej1jJlz4pjgDiVT+vRJTOMZJnSSuQKEMC1zBLA4v2kUpsJohjajEyNfa3OTDfZJP/
 ImzfWRXl0fFgVcygUmoA79Mws67JNo+DH3KkfD8szQlyWsbYLzNXs9GYCK+MEZM+JmqOQjvgmG9
 DHDVfsoSrcnFyg6slQg==
X-Proofpoint-GUID: C7-rivORfCE_a47V-oulqYAVOzzDM0CZ
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6acfcf72 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=bIpB81lF2ro1xIxEYW0A:9
X-Proofpoint-ORIG-GUID: EHiEmg6MJkJBDjBwUsu5bPi_G4yvROIy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140074

A previous change ("KVM: PPC: Book3S HV: Add preempt_disable() around
virtual-mode HPTE bit-lock users") at [1] added preempt_disable() around
guest vCPU HPT hcalls and page fault handlers executed in virtual mode.
This ensures vCPU threads cannot be preempted while holding
HPTE_V_HVLOCK or the reverse-map lock.

However, several host-side virtual-mode paths in book3s_64_mmu_hv.c also
acquire HPTE_V_HVLOCK and lock_rmap() in process context with preemption
enabled.  Specifically, kvm_unmap_rmapp() and kvm_age_rmapp() take both
locks during MMU notifier callbacks and memslot flushes, while
resize_hpt_rehash_hpte() acquires HPTE_V_HVLOCK during HPT resizing.  If
a host thread is preempted while holding either bit-lock, any guest vCPU
thread scheduled on the same CPU spinning for the same lock with
preemption disabled will never yield, resulting in a permanent CPU hang.

Fix this by disabling preemption across these host-side critical
sections.

For kvm_unmap_rmapp() and kvm_age_rmapp(), place preempt_disable()
before lock_rmap() so that both the rmap chain lock and the subsequent
HPTE_V_HVLOCK bit-lock are held under a single non-preemptible window.
To preserve the ABBA lock ordering between the two locks, re-enable
preemption after dropping the rmap lock on any retry or early-exit path
before spinning on cpu_relax(), allowing the lock holder to be
scheduled.

For kvm_htab_write(), the HPT migration restore path, replace the direct
calls to kvmppc_do_h_remove() with kvmppc_virtmode_do_h_remove(), a thin
wrapper that brackets kvmppc_do_h_remove() with preempt_disable() and
preempt_enable(), mirroring the existing kvmppc_virtmode_do_h_enter()
helper.

For resize_hpt_rehash_hpte(), place preempt_disable() before the
try_lock_hpte() spin loop and preempt_enable() after unlock_hpte() at
the function exit.

[1] https://git.kernel.org/powerpc/c/abbbe5ff83e7c9ed3a4d61b73011f1df7bf87907

Fixes: 6165d5dd99db ("KVM: PPC: Book3S HV: add virtual mode handlers for HPT hcalls and page faults")
Cc: stable@vger.kernel.org # v5.14+
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changes in this version:
- Separated host-side fixes in book3s_64_mmu_hv.c into a standalone patch
  (guest-side paths were merged from v1 resend).
- Previous discussion: https://lore.kernel.org/all/20261007182116.12479-3-amachhiw@linux.ibm.com/

 arch/powerpc/kvm/book3s_64_mmu_hv.c | 33 +++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 2ccb3d138f46..8d85ce3440ae 100644
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
+ * Virtual-mode H_REMOVE. kvmppc_do_h_remove() is also called from real mode,
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

base-commit: 129f5d395fd66b6587a5ac156b232cca060d6512
-- 
2.54.0 (Apple Git-157)

