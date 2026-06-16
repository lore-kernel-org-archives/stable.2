Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF91C47798F;
	Tue, 16 Jun 2026 16:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627685; cv=none; b=bc4ZzXaMNgZzNdUSrVTObI40QgN+54IqQn770M9yxO1AJiuKH91fCejyeG9iLHBOf6OxZY99T0kgUERdgtwIKa6QWxZgm26DkvPnuhoanyiSKxi6AKoOSxHjCHGasNRlZDA8IiepbaUmYY217juNlphSwWvglxkmjmW3PgJbxO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627685; c=relaxed/simple;
	bh=jQ0ih8TZ5EYAUWS//mGtk9LnX44uIvic6hLnFcSGVtQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DYqYfVXmc8tBUCpGE3DKeX4Y75mCOn3oyPAxsFt9mtZ2gtlddqw+6s4y9TskqHWrFZkkUOCZP+lSrYMyemowxYJVlG+oFoGF0VlR7e8lex2s3pJJqEvHcNoFTEGr8YLqlkOO3DQwqvn/s7y31j0G0GyYIL+xZcZNhyAbomeZBNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XFEn8GFm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XFEn8GFm"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GFmNra2118503;
	Tue, 16 Jun 2026 16:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=3PiVWjmfkKsBIeMIls/WZUka3rjlPW0gyvadFQtvd
	0I=; b=XFEn8GFmcpFnb+BLlKYkHg1g4SK+e+FjO22rxO2pBTUuH0iGo6Uz3lxg/
	u6pKn4V/sanrCe7+5fxxg1SiqhngQRxO/hSte91VXiIy5VUIAzOXvGisz23hajNL
	HGoU09Di2pU4XWNhUHDnPs7Z4K8h7oq3crnzpdV0QpOd5kr6/TPkMxCCYnATq33V
	rcG1O7Lhc4kU0KzNx23NZWqZbRU7Rx97zdg/7Puyo0Vw2ySPYGmbaxEXQTQ0a55f
	/DUjudJWlLRQhH720MVQ3k808OBxL+EpKDy/C0Gmtvc8D1rua84PHAlOcfEUJcZO
	on2lEyKUCcGyZIESo1qpkMW4v++Hg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1h86xmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 16:34:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GGJfW1009103;
	Tue, 16 Jun 2026 16:34:20 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esk1h49kb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 16:34:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GGYGpa62914894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 16:34:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C590620043;
	Tue, 16 Jun 2026 16:34:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C760420040;
	Tue, 16 Jun 2026 16:34:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.31.150])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 16:34:12 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Gautam Menghani <gautam@linux.ibm.com>,
        Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode
Date: Tue, 16 Jun 2026 22:04:05 +0530
Message-ID: <20260616163405.96962-1-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE2NyBTYWx0ZWRfX9cNhnHOqh7as
 QhkJVNQTKDfW9r963Q1udV+w6U+JeLEtlm0CgoVBWdJxziD1DHh53UpMeqYkm5nveLdOFuLY1cx
 hnewYp3QC8ZXRDh9vALMgREKT81+Sg0=
X-Proofpoint-ORIG-GUID: FIihs5FllMLPCxPalCaX9-QVcCx5oX0s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE2NyBTYWx0ZWRfXyGMQC+TSHqmi
 PfF8mJx78RvW8YYiPihhV2kW/5THFX/wCF4CYnMBEA+cOHErw3nQTr2vfF/6nZqzUig4gvA6lee
 mEMUmVzahWG8YDI+W6UdVe+wMd9+mlY/9aJrJqgA4vUV7454oI1cz0japiYecPBeawyc0q3bCDH
 mUuf0u2mMCRWgNMWxXYCVuJ8LcySa22JE4S9ButssO3nZd3N0rlTuhJo33F6CBmsPsD+KkEaNfh
 k6FUEOYTlPwbQDlKGtDAbwVxjMyK1ROOPnr/lDX2rHJ382WMY97DZ385Uw/G+Mj4WuPhSOEXEm6
 3syEeUrJN27jYxblFCj3fv9GhRZ6yb4NpwQKhQ6M9o9YUXiywk6LL2daxmqK3sCpTBbgKun0l46
 5t31QSf9AeAmaXGowbZgKpT4ddt7Qcfnr0JOSi6ya4W0eM2AG3Uuh7hMoqhJOXJ6QxJaq1fkHMX
 Exaa6uexu9mtDCB/E0w==
X-Authority-Analysis: v=2.4 cv=U9uiy+ru c=1 sm=1 tr=0 ts=6a317b0e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=dl9XnktawrrMqxjOnboA:9
X-Proofpoint-GUID: 7dT-KaVCJgpJP0gU7MjyAq95-Ynhr3UV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160167

On IBM POWER systems, newer processor generations can operate in
compatibility modes corresponding to earlier generations. This becomes
relevant for nested virtualization, where nested KVM guests may need to
run with a specific processor compatibility level.

Currently, when running a nested KVM guest (L2) inside a Power11 pSeries
logical partition (L1) booted in Power10 compatibility mode, the guest
fails to boot while setting 'arch_compat'. This happens because the CPU
class is derived from the hardware PVR (via mfspr()), which reflects the
physical processor generation (Power11), rather than the effective
compatibility mode (Power10).

As a result, userspace may request a Power11 arch_compat for the L2
guest. However, the L1 partition, running in Power10 compatibility, has
only negotiated support up to Power10 with the Power Hypervisor (L0).
When H_GUEST_SET_STATE is invoked with a Power11 Logical PVR, the
hypervisor rejects the request, leading to a late guest boot failure:

  KVM-NESTEDv2: couldn't set guest wide elements
  [..KVM reg dump..]

This situation should be detected earlier and rejected by KVM. Without
proper validation, if userspace ignores the error, the guest may continue
to boot in Power11 raw mode on a Power10 compatibility host, which should
not be allowed.

Introduce a validation mechanism that detects unsupported arch_compat
values early in the guest initialization path. When an unsupported
arch_compat is requested (e.g., Power11 on a Power10 compatibility mode
host), kvmppc_set_arch_compat() uses cpu_has_feature(CPU_FTR_P11_PVR) to
detect the mismatch and sets arch_compat to PVR_ARCH_INVALID (0xffffffff).
This sentinel value is architecturally safe: PAPR specifies that valid
logical PVR values must have 0x0f as the first byte, ensuring 0xffffffff
lies permanently outside the specification-defined range. Setting this
value triggers kvmppc_sanity_check() to mark the vCPU as invalid by
setting vcpu->arch.sane to false. On the next vCPU run, kvmppc_vcpu_run_hv()
checks this flag and returns -EINVAL, preventing the guest from running
with an invalid processor compatibility configuration.

With this, when a Power11 arch_compat is requested on a Power10
compatibility mode host, the guest fails early during boot with:

  error: kvm run failed Invalid argument

This provides a much clearer failure mode compared to the previous
behavior where the guest could boot in Power11 raw mode (if userspace
ignored the error) or fail late during H_GUEST_SET_STATE.

Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Acked-by: Gautam Menghani <gautam@linux.ibm.com>
Cc: stable@vger.kernel.org # v6.13+
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Testing: Both Anushree and I have tested the below scenarios:
1. P11 guest on P11 host - Works
2. P10 compat guest on P11 host - Works
3. P11 guest on compat-P10 host - Correctly fails with "Invalid argument"
4. P10 guest on compat-P10 host - Works

Changes in v4:
* Added documentation for PVR_ARCH_INVALID explaining why 0xffffffff is
  architecturally safe to use as a sentinel value (PAPR constraint on
  first byte being 0x0f) [Ritesh]
* Updated commit message
* v3: https://lore.kernel.org/all/20260609053327.61563-1-amachhiw@linux.ibm.com/

Changes in v3:
* Fixed null pointer dereference in kvmppc_sanity_check(): added check for
  vcpu->arch.vcore before accessing arch_compat, as vcore is NULL for Book3S
  PR and BookE guests (only Book3S HV uses vcore) [Reported by Sashiko AI]
* Added Reviewed-by tag from Vaibhav
* v2: https://lore.kernel.org/all/20260608201001.65760-1-amachhiw@linux.ibm.com/

Changes in v2:
* Fixed issue where v1 allowed guest to boot in Power11 raw mode when
  userspace ignored the error, by adding validation in kvmppc_sanity_check()
  to ensure early failure during vCPU run [Found the issue after posting v1,
  also reported by Gautam.]
* Introduced PVR_ARCH_INVALID constant for marking invalid arch_compat
* Dropped all Reviewed-by and Tested-by tags due to code changes; requesting
  fresh reviews
* v1: https://lore.kernel.org/all/20260603141539.47620-1-amachhiw@linux.ibm.com/

Changes in v1:
* Moved this patch out of the v3 series [1] as discussed here [2]
* Addressed below review comments from Ritesh:
  - Based the PVR validation on cpu features
  - Fixed hcall name typo
  - Stable backport

[1] https://lore.kernel.org/all/20260522152744.55251-1-amachhiw@linux.ibm.com/
[2] https://lore.kernel.org/all/20260522152744.55251-2-amachhiw@linux.ibm.com/
---
 arch/powerpc/include/asm/reg.h | 12 ++++++++++++
 arch/powerpc/kvm/book3s_hv.c   | 15 ++++++++++++++-
 arch/powerpc/kvm/powerpc.c     |  4 ++++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 3449dd2b577d..b9ab9df1e2bc 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1357,6 +1357,18 @@
 #define PVR_ARCH_31	0x0f000006
 #define PVR_ARCH_31_P11	0x0f000007
 
+/*
+ * Kernel-internal sentinel for invalid processor compatibility modes.
+ * PAPR specifies that the first byte of a valid logical PVR value is
+ * 0x0f. So 0xffffffff lies permanently outside the PAPR-defined range
+ * and is safe to repurpose. KVM stores it in vcpu->arch.arch_compat
+ * when userspace requests an unsupported compatibility mode (e.g.,
+ * Power11 PVR on a Power11 host booted in Power10 compat).
+ * kvmppc_sanity_check() detects this and prevents the vCPU from
+ * running with an unsupported arch_compat.
+ */
+#define PVR_ARCH_INVALID	0xffffffff
+
 /* Macros for setting and retrieving special purpose registers */
 #ifndef __ASSEMBLER__
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 61dbeea317f3..f9380ef65750 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -446,7 +446,19 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
 			guest_pcr_bit = PCR_ARCH_300;
 			break;
 		case PVR_ARCH_31:
+			guest_pcr_bit = PCR_ARCH_31;
+			break;
 		case PVR_ARCH_31_P11:
+			/*
+			 * Need to check this for ISA 3.1, as Power10 and
+			 * Power11 share the same PCR. For any subsequent ISA
+			 * versions, this will be taken care of by the guest vs
+			 * host PCR comparison below.
+			 */
+			if (!cpu_has_feature(CPU_FTR_P11_PVR)) {
+				arch_compat = PVR_ARCH_INVALID;
+				goto out;
+			}
 			guest_pcr_bit = PCR_ARCH_31;
 			break;
 		default:
@@ -469,6 +481,7 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
 			return -EINVAL;
 	}
 
+out:
 	spin_lock(&vc->lock);
 	vc->arch_compat = arch_compat;
 	kvmhv_nestedv2_mark_dirty(vcpu, KVMPPC_GSID_LOGICAL_PVR);
@@ -479,7 +492,7 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
 	vc->pcr = (host_pcr_bit - guest_pcr_bit) | PCR_MASK;
 	spin_unlock(&vc->lock);
 
-	return 0;
+	return kvmppc_sanity_check(vcpu);
 }
 
 static void kvmppc_dump_regs(struct kvm_vcpu *vcpu)
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 00302399fc37..98de68379b18 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -258,6 +258,10 @@ int kvmppc_sanity_check(struct kvm_vcpu *vcpu)
 	if (!vcpu->arch.pvr)
 		goto out;
 
+	if (vcpu->arch.vcore &&
+		vcpu->arch.vcore->arch_compat == PVR_ARCH_INVALID)
+		goto out;
+
 	/* PAPR only works with book3s_64 */
 	if ((vcpu->arch.cpu_type != KVM_CPU_3S_64) && vcpu->arch.papr_enabled)
 		goto out;

base-commit: 6b5a2b7d9bc156e505f09e698d85d6a1547c1206
-- 
2.50.1 (Apple Git-155)

