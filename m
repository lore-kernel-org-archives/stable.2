Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEE93BB669;
	Mon, 28 Sep 2026 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598560; cv=none; b=jOqdS2B67m4n3Sem06oZmpMAjfGhi8RyTJ3aezn0D5MT8qB6h8IGKhM9BB1AnklvOvgVrVVKsxn3XV4zy2oAuefzTp4gqwmpbLmcn4HMuPPCkNc5+eVI9HL3lyb2/eYTQnYKFlij9NCKC+fnoJkW2k494mY+0YGqjUG5Xnzip4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598560; c=relaxed/simple;
	bh=GvP7G2PSnXIoSImaFHhXEd072q2Cp+mwExuu4yGceO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MynWm2bdUSOX9Gp/+AMMnfnZct56Wmv1jOQbkpZSrfruwI9vAae+m3WkJAbG/51QasLNX/oRmmfahUHrm8J6lbR2+GeXcx5EJhR2vKLiTRzQpyId0J/7TjaLiafQuoPUNOvqPAbJyQ4VYOG10zAlPx+Z9G5UgDKwTumxo/YOrIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=StxNDFMR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="StxNDFMR"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBZJ1o1019057;
	Mon, 28 Sep 2026 12:29:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=daJyeZajojOGLh8il
	E00SNT0arUWx6DSIzy/uQ+v/6g=; b=StxNDFMRBwv13qgkM88qhuEMWXK17L/AF
	tOSkslniAeNeXGYiuM7zhrZ5KEy21B/5nr3IIboAg1RY/kR1LJ3n0osiT4AgLVoD
	2iycbT9PBhg0O7pu4bm4y+lUjvWiLBwrwuuSt56U0DKq133uXuVAi7aCMKtoFBjt
	SPAK/FBJK/ewATUj4kgxLL1NOJc71jezLlXPeIYTx5lzeJn58IZvd8OXwi5ame5o
	p13PoXx8iY4yLuKWD+JV3YpWnpiqF4kvmvp+7BJH4VAYA4+kOb8Gib66RcS6w9Lf
	cGGSEs0pYNi9ck06+JRqRzuXa4koI0GDiYviMqLCyN4HAsIHJC3ww==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s51796-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 12:29:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBHZVY027152;
	Mon, 28 Sep 2026 12:29:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxrrw58a4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 12:29:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68SCSxMg50725148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 12:28:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 097E920049;
	Mon, 28 Sep 2026 12:28:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDAD120040;
	Mon, 28 Sep 2026 12:28:54 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.213.32])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 12:28:54 +0000 (GMT)
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
Subject: [RESEND PATCH 2/3] KVM: PPC: Book3S HV: Add preempt_disable() around virtual-mode HPTE bit-lock users
Date: Mon, 28 Sep 2026 17:58:36 +0530
Message-ID: <20260928122837.8782-3-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260928122837.8782-1-amachhiw@linux.ibm.com>
References: <20260928122837.8782-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0OCBTYWx0ZWRfX8orC67y5LIzZ
 MbkLLDkW8iKH61KD84M4h6qjsOx/DJjdHd6cqFyffYViw6+A/y1Oa3V9MTIMZtAGeNcB/CPHu1/
 eJqzvflTGSL9d6b6DhZXlBMNn1UiwzE=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6aba5d90 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=u-HXxruZ6MoSruA0XqgA:9
X-Proofpoint-GUID: ssYpujtXTr3xZVKrx3l4RHk6LBXWie9s
X-Proofpoint-ORIG-GUID: W23ZGQdjt_C1_vFOMLjSPerJtRideBdi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0OCBTYWx0ZWRfX8vCeEXCAWkQk
 /CB3AUshbHRqmOKK1pv2ohPN47VtqXRpGjejRIy/nlSm2xTLaSSBLB2nYohCfjSgNIo9xuC1N8e
 huqQmkvEhBx4Y5EHlSiKfPnL67bZEcui77ZF4an7QRLI2O7tgQARwEufsS1RdwaALu0QsZbpKmQ
 4UogiKva+Qv2JAsClFHnGAVHlT9ynl7zgmD30h5A8rcKr9w6hzoz1svaP1MKL4nA1B48cVmouDe
 1PPrdKcm0X53wCpJTduLYRiZyRvyGDTXCTIXQqjRxKnv/UJmSTUTlpB13FD++LMfStcBl6RaKqy
 PMMm+o5ZRwY/PCsmq7I1zQXennHohdA4uunhnsx3FZ/vuh9EHx/x1+ocev9wnCezNGcHrtiqj0O
 6RpzpT4jUF398dpgJcQW5gWQfM0ZVOWculo6KFZI5yFfyosXMcN08BxN+Yu4eKYp8XkBCzGDqNC
 ldFfnEvQImVTcJ8CIrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280048

kvmppc_hv_find_lock_hpte() requires virtual-mode callers to run with
preemption disabled, because it can return with HPTE_V_HVLOCK still held
until the caller later unlocks the HPTE.  Existing virtual-mode callers
in book3s_64_mmu_hv.c already follow that rule.

Two virtual-mode call paths do not:

1. kvmppc_handle_exit_hv() calls kvmppc_hpte_hv_fault() for hash-mode
   data-side and instruction-side faults after guest exit, with
   preemption already enabled.  kvmppc_hpte_hv_fault() calls
   kvmppc_hv_find_lock_hpte() directly.

2. kvmppc_pseries_do_hcall() executes virtual-mode handlers for HPT
   hcalls via kvmppc_pseries_do_hpt_hcall() with preemption enabled.
   The handlers for H_ENTER, H_REMOVE, H_READ, H_CLEAR_MOD, H_CLEAR_REF,
   H_PROTECT, and H_BULK_REMOVE spin on try_lock_hpte() or lock_rmap(),
   and H_ENTER also reaches kvmppc_do_h_enter(), which uses
   arch_spin_lock() on kvm->mmu_lock.  That raw lock choice is
   intentional because kvmppc_do_h_enter() is also used by real-mode
   callers, so the correct fix is to establish the proper preemption
   context at the virtual-mode caller boundary.

If a vCPU thread is preempted while holding HPTE_V_HVLOCK, any other
thread on the same CPU trying to acquire the same bit-lock can spin
indefinitely.  The same applies to lock_rmap() users and to the H_ENTER
path while holding the raw mmu_lock.

Fix this by adding preempt_disable()/preempt_enable() pairs around the
two kvmppc_hpte_hv_fault() call sites in kvmppc_handle_exit_hv(), and
around the kvmppc_pseries_do_hpt_hcall() invocation in
kvmppc_pseries_do_hcall().  Targeting only the HPT hcall helper avoids
wrapping non-HPT hcalls (such as H_RTAS, H_CONFER, H_REGISTER_VPA) that
perform page faults, blocking memory allocations, or context switches.

Fixes: 6165d5dd99db ("KVM: PPC: Book3S HV: add virtual mode handlers for HPT hcalls and page faults")
Cc: stable@vger.kernel.org # v5.14+
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index aa51968e206a..52f72f30baf0 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1212,9 +1212,11 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
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
@@ -1834,8 +1836,10 @@ static int kvmppc_handle_exit_hv(struct kvm_vcpu *vcpu,
 		else
 			vsid = vcpu->arch.fault_gpa;
 
+		preempt_disable();
 		err = kvmppc_hpte_hv_fault(vcpu, vcpu->arch.fault_dar,
 				vsid, vcpu->arch.fault_dsisr, true);
+		preempt_enable();
 		if (err == 0) {
 			r = RESUME_GUEST;
 		} else if (err == -1 || err == -2) {
@@ -1881,8 +1885,10 @@ static int kvmppc_handle_exit_hv(struct kvm_vcpu *vcpu,
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

