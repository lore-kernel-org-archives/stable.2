Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349EC3D88F5;
	Tue,  6 Oct 2026 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791289485; cv=none; b=tY/o6KQVl64+WoVTJDpVXCFGsvbJF3mA/aUo0IWgUXtc3heIXX/cWbFUEN8qWLv+F8bPNVjnMu/nXN1tGoKMCTtw1x3khARHxtoZToyoBnPrABDonqaAXVd+yVq2EHReIazHA335LXUyQ8EiLsDOFnux3ZDIlQDbl9fOBET0/XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791289485; c=relaxed/simple;
	bh=B1NfG8Pffpg63TdiooG4exsohH6Byj/eXiQ6W/idYws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZdyXUw6WL9eyqkZj8MADWtshHSqEZ/JVFPc7u+LNTdAKcgixwdw0dX/QxOUAFdhWQMK15ZFgkOsFQuy2RqDKHxCSQV2omZRnCv9PGb3wxxtGE6Ju0UMDhkaU8PCy8LexcZEaqIQzllkgDemK4G5oinX3L/q6S3qs11srzwEZI1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UhUXFsDY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UhUXFsDY"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696BZOKM3680401;
	Tue, 6 Oct 2026 12:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5PT3Fw
	A4ChHnjEa+xr3xDXd780D+F0Ni80fRcedI2C0=; b=UhUXFsDYde8ek6HEYgA4Zb
	GzWLmABI0q632R2THsR05quzJHyH76yZ4isc5anVWm977SusZIAw5fHOgvyG7Khi
	/R429PeP8DZfuE8nbMH17Bfq1IVgkl8V/mlg5+mgr03n0tCo126S8VNSWLHZVCCE
	WBpjWODMhaLyMoHZW52m+LCT8tCR7yfsa22z+X/cpdd5OM5pqBxEshMUBeYbocyL
	En5LYCJCeBmGqXX2esM8Eeudz4WPvWv0Y0y6Bg6MBEWyTsapgzkUX4PMtjWCpy8I
	lDd3E/asYXhXrTRNLLA8tRAmsz3F3lqFbWQX8QhXQkCMLIfjKACcws9sATE0FJLQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74qxam-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 12:24:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696BlYc8220923;
	Tue, 6 Oct 2026 12:24:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvswth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 12:24:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696COLGu33751434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 12:24:21 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 003CB20049;
	Tue,  6 Oct 2026 12:24:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0B5D2004E;
	Tue,  6 Oct 2026 12:24:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.214.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 12:24:16 +0000 (GMT)
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
Subject: [PATCH v3 1/3] KVM: PPC: Book3S HV: Add SRCU protection for virtual-mode HPT hcalls
Date: Tue,  6 Oct 2026 17:54:02 +0530
Message-ID: <20261006122404.99358-2-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261006122404.99358-1-amachhiw@linux.ibm.com>
References: <20261006122404.99358-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: k8WOVPfA5xheGFaXzDeNLaEB0-QKNVfJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0OCBTYWx0ZWRfX1/DBIdkGjeVg
 IsLYM5429tYGzrVSU7QuMgA1WJj4aDWdQVq8VrlcYWmj4M6xM59+eLcGDl1NVNT+K/Pdl4qJ598
 WI6OYjXHaANPeTYtp3eyPDJGaeevdZg=
X-Proofpoint-GUID: YS7lRBXP9QfbUTEx3ds-N1kFZzeHC5ZM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0OCBTYWx0ZWRfX2oOECLersc6n
 8QAG6YQfZa1fKVWlVpzgEPRVJ7BqVfpTuOpR+QsB/Rd5LoOHpdf3/Z3dqXy31viQTM+FkrN02Y7
 pd8pbKCu2GRn1RtwW8bhB6RptG+8PMKqfBnylTav6AZPWukLzT9Wmm1MyksUlfdInwHwAXVL+Pj
 oRfamXWkOtKeKe6oJ8ynoAV30EDmZpx2Jmerp6R9ZsnB2+JI6cZGmY5mzZkYh5PoyjVa07Ldlc9
 EbMh0HOZKmt4X8ri4gV5QUYF4BKx5KyzG9gWuMJ5dm8DmBkNKvULGoBxIqnYjNv60NDtrBU3aAL
 Mqtmysv0Bp0+vHp4fu4V25BhVA8+A5w3uq4Am0KdGBG6OQfnTbBf6VNSD8iNfZ7tGL/4DV+ZSp9
 dRtI0Uv1GWw8TsVp6PcGAHQumHWyKoK78O3dMaLjHkTWlpJePqcVaVtqPsvc09B0nckeJnwcyVu
 IFMgV8J8qJRasrjgJxA==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac4e87c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=DgxhUou5BkHipWTGidQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060048

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
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c | 70 ++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index de05d721edc4..46dd550115a4 100644
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

