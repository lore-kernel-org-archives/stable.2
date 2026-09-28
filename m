Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7742B4AAC65;
	Mon, 28 Sep 2026 11:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595460; cv=none; b=Kq6E4QzumCrr3UnEO/qqmpuxQXG6r0DptBQfcZMeK1JqVE2v9llzkZ4ophTVO6Y7shL7ppDb4OagYy32f6Z9e259xaPykCmwlvHviyTF40wBryREqs3EMBy1AvInke2ZsvIwVGLm6l5YljKftBArIoOtk7lIv6I8eRL5ze5vqAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595460; c=relaxed/simple;
	bh=+0wbYyylv2W4FDEGmwWMhUk9rw0i2g9ChKu77yaMt9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MtjdyVUvSbQkkbeLTyk97wudoLz+RZ8blyAvKXOVt2ftxrhXrEF9nLxXpFckb6L1OFDAsCJ+1aeJa+zVZOJFWLECvOVDpGiSvRe7tDNbHMNbKaFwCeI+dxIijuomaR5RNrY1i7MAAk2ydf57rnacv3zwvsqBSmyR0/PlMjtvEl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D1ekfnnU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D1ekfnnU"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBZUtI3374963;
	Mon, 28 Sep 2026 11:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=owG7PdSKZiKgNxplioX22//h+Uij
	uj+ymNAWo5x5JvU=; b=D1ekfnnUi+GkkiEURWZsxtlG4aeZ8xZQLHUQ5ojtwW3A
	TmPmf2NWU5t1bLxNl38DiDzNSS28wb75o4Nm4DScY1VkZ4suuMW32KxsOVpeb/il
	hISuYH4tnoWIjs85+8/zW0rJY+ec3BlL3KpLNgAnZg9VkoeW3mDD4pdckRLoMx+p
	Jrjwh8CEaZrRlVXXumN8GNh41gQk9/eoRZ+0Dgpn4eln0F+Ss2HGiNwE0VQYNc4u
	0hbaJPM0J3TmWtiUEsykRBdDeoRAia+Qu7Imq0+QLpYoCzkImV1Tp2glZYuqQiK8
	Zf0XsDsfkcAONJll5lXdJ8brRMojxFjvcox048uvkA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qr0yy5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 11:37:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68SBHVQJ057241;
	Mon, 28 Sep 2026 11:37:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxu2y4rsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 11:37:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68SBbIS545416850
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 11:37:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95A9A2004E;
	Mon, 28 Sep 2026 11:37:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E2772004B;
	Mon, 28 Sep 2026 11:37:14 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.213.32])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 11:37:14 +0000 (GMT)
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
Subject: [PATCH 1/3] KVM: PPC: Book3S HV: Add SRCU protection for virtual-mode HPT hcalls
Date: Mon, 28 Sep 2026 17:07:01 +0530
Message-ID: <20260928113704.48912-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA0NiBTYWx0ZWRfX2ZuAdkI5Ussw
 LRCIBD3UqcTIaz2FA3M4OkX1tJh7W9teybSIPXr5h+iGDBNZTMVZmQkA3taJbjQ3/Wb5gmM+dwg
 GY/eidcPBCV5pqJaWBvassE74mdblkYY6WyJZBzqv8xDdYa+p3rPVsYW68Kn5Mu5bm6qVx6RUwe
 LDW5Gyy89bfv632cZLYyXjrzfjMlbJsFmuc865277aWnlcVDmbGiqamSSJ7/Oal5QkZS44tXLZv
 dJgrxj5sFBPIOXeBO9QrmH0IebbG4rgzZa0luNCEBRfflfuiXoKMAHGT8cE+ge+Ay5I8HbxK1ly
 rM8dyaSiyAE2+D5RMU5mQh2lJpgxNe9RWK4DwensoMXPi5XL32RDwpgb3iEriU1kxcbSWpmlrNn
 nnRdjiHBYWVPbtpCAS5MCVguFZ3l7eLGljPoNeObwgowNQiiWP0Ikr6oh+Q2y+mOCjnezacwDPN
 9U1Qc0+vzbAb5LI32pA==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6aba5173 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=DgxhUou5BkHipWTGidQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: EzQiaEYNpTDL5GYT4jphrLfaa_tpmb1h
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA0NiBTYWx0ZWRfX+yC0UJb1l+QX
 8nvjN9+ELBH3xiJK3llmn5/l8R7nL8u18YxS47DgtRKjS19rwnm8wK7z7IYZ1z9nUMVnuHZD2pU
 NMBjE6sNWsQWX+cq7cdjR/gYnPmTcXU=
X-Proofpoint-GUID: 431P1MB3VSeFlb-OZeLTUlNfY4df4jFw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1011 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280046

The virtual-mode HPT hcall handlers (H_ENTER, H_REMOVE, H_BULK_REMOVE,
H_CLEAR_REF, H_CLEAR_MOD) call into book3s_hv_rm_mmu.c, which accesses
memslots via kvm_memslots_raw().  kvm_memslots_raw() uses
rcu_dereference_raw_check() to bypass SRCU lockdep annotation checking.
This is safe in real mode because the entire guest entry/exit is wrapped
in srcu_read_lock/unlock inside kvmppc_run_core() and
kvmhv_run_single_vcpu().

However, since commit 6165d5dd99db ("KVM: PPC: Book3S HV: add virtual
mode handlers for HPT hcalls and page faults"), these same handlers are
also executed in virtual mode via kvmppc_pseries_do_hcall(), which runs
after SRCU has already been released on guest exit.

A concurrent KVM_SET_USER_MEMORY_REGION deletion or move can therefore
call synchronize_srcu_expedited() — which does not wait for this thread —
and then kfree(slot) and vfree(slot->arch.rmap) while the hcall handler
still holds a raw pointer to the memslot.  lock_rmap() then writes to
freed vmalloc memory, leading to use-after-free and memory corruption.
Because kvm_memslots_raw() suppresses lockdep checks, this race is
entirely silent.

Fix this by factoring out the 7 HPT hcall handlers (H_REMOVE, H_ENTER,
H_READ, H_CLEAR_MOD, H_CLEAR_REF, H_PROTECT, H_BULK_REMOVE) into a
helper function, kvmppc_pseries_do_hpt_hcall(), and wrapping its call
site in srcu_read_lock(&kvm->srcu) / srcu_read_unlock(&kvm->srcu, idx).
Targeting only the HPT hcalls avoids wrapping non-HPT hcalls that sleep
(such as H_CONFER, H_REGISTER_VPA, H_PAGE_INIT) or handlers that already
acquire SRCU internally (such as H_RTAS).

Fixes: 6165d5dd99db ("KVM: PPC: Book3S HV: add virtual mode handlers for HPT hcalls and page faults")
Cc: stable@vger.kernel.org # v5.14+
Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c | 70 ++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index dbac3573b2c8..aa51968e206a 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1159,6 +1159,38 @@ static long kvmppc_h_rpt_invalidate(struct kvm_vcpu *vcpu,
 	return H_SUCCESS;
 }
 
+static long kvmppc_pseries_do_hpt_hcall(struct kvm_vcpu *vcpu, unsigned long req)
+{
+	switch (req) {
+	case H_REMOVE:
+		return kvmppc_h_remove(vcpu, kvmppc_get_gpr(vcpu, 4),
+				       kvmppc_get_gpr(vcpu, 5),
+				       kvmppc_get_gpr(vcpu, 6));
+	case H_ENTER:
+		return kvmppc_h_enter(vcpu, kvmppc_get_gpr(vcpu, 4),
+				      kvmppc_get_gpr(vcpu, 5),
+				      kvmppc_get_gpr(vcpu, 6),
+				      kvmppc_get_gpr(vcpu, 7));
+	case H_READ:
+		return kvmppc_h_read(vcpu, kvmppc_get_gpr(vcpu, 4),
+				     kvmppc_get_gpr(vcpu, 5));
+	case H_CLEAR_MOD:
+		return kvmppc_h_clear_mod(vcpu, kvmppc_get_gpr(vcpu, 4),
+					  kvmppc_get_gpr(vcpu, 5));
+	case H_CLEAR_REF:
+		return kvmppc_h_clear_ref(vcpu, kvmppc_get_gpr(vcpu, 4),
+					  kvmppc_get_gpr(vcpu, 5));
+	case H_PROTECT:
+		return kvmppc_h_protect(vcpu, kvmppc_get_gpr(vcpu, 4),
+					kvmppc_get_gpr(vcpu, 5),
+					kvmppc_get_gpr(vcpu, 6));
+	case H_BULK_REMOVE:
+		return kvmppc_h_bulk_remove(vcpu);
+	}
+
+	return H_FUNCTION;
+}
+
 int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
@@ -1174,47 +1206,15 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 
 	switch (req) {
 	case H_REMOVE:
-		ret = kvmppc_h_remove(vcpu, kvmppc_get_gpr(vcpu, 4),
-					kvmppc_get_gpr(vcpu, 5),
-					kvmppc_get_gpr(vcpu, 6));
-		if (ret == H_TOO_HARD)
-			return RESUME_HOST;
-		break;
 	case H_ENTER:
-		ret = kvmppc_h_enter(vcpu, kvmppc_get_gpr(vcpu, 4),
-					kvmppc_get_gpr(vcpu, 5),
-					kvmppc_get_gpr(vcpu, 6),
-					kvmppc_get_gpr(vcpu, 7));
-		if (ret == H_TOO_HARD)
-			return RESUME_HOST;
-		break;
 	case H_READ:
-		ret = kvmppc_h_read(vcpu, kvmppc_get_gpr(vcpu, 4),
-					kvmppc_get_gpr(vcpu, 5));
-		if (ret == H_TOO_HARD)
-			return RESUME_HOST;
-		break;
 	case H_CLEAR_MOD:
-		ret = kvmppc_h_clear_mod(vcpu, kvmppc_get_gpr(vcpu, 4),
-					kvmppc_get_gpr(vcpu, 5));
-		if (ret == H_TOO_HARD)
-			return RESUME_HOST;
-		break;
 	case H_CLEAR_REF:
-		ret = kvmppc_h_clear_ref(vcpu, kvmppc_get_gpr(vcpu, 4),
-					kvmppc_get_gpr(vcpu, 5));
-		if (ret == H_TOO_HARD)
-			return RESUME_HOST;
-		break;
 	case H_PROTECT:
-		ret = kvmppc_h_protect(vcpu, kvmppc_get_gpr(vcpu, 4),
-					kvmppc_get_gpr(vcpu, 5),
-					kvmppc_get_gpr(vcpu, 6));
-		if (ret == H_TOO_HARD)
-			return RESUME_HOST;
-		break;
 	case H_BULK_REMOVE:
-		ret = kvmppc_h_bulk_remove(vcpu);
+		idx = srcu_read_lock(&kvm->srcu);
+		ret = kvmppc_pseries_do_hpt_hcall(vcpu, req);
+		srcu_read_unlock(&kvm->srcu, idx);
 		if (ret == H_TOO_HARD)
 			return RESUME_HOST;
 		break;
-- 
2.54.0 (Apple Git-157)

