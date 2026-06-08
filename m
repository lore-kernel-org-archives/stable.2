Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5865338CFE8;
	Mon,  8 Jun 2026 20:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949439; cv=none; b=G60/5av3IhE+8fVp5+x2r1QYIptSgtuiZXpNTNeaFyO/zSAWCzutVdAVZL6RC8oLAXCWm6LINIsvv1n8wQRr69G2PMsndnvJQ+UMzIzNlkftjVrsxg8r3rjRBrqzjzFoxNoN75ruu1MbKKTmdJPr8VAtu9OWaw6mZ5ttLHP5V9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949439; c=relaxed/simple;
	bh=WdvzLkxk8MyiMgSQc9Es2xOIw4Dj4CL8OMXLKX2UKHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YFad8JvUwhDXwjUv9ORce9PKa2xhpFfT198PUUTuvteZiNIi79HwwaLcqViBLlVUrYmmlyQI2ceGw0khW/DXaNsknHx8CZUburemE9uDKdHd+AWwbyDTcrP9dSm2rgjmz006KaX3Pp+7FJUKfnDDve1u7bdLyQTpc9Wtb4B9n+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QYSPYV1j; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QYSPYV1j"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658ASRUL3475344;
	Mon, 8 Jun 2026 20:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=N2zRYpqXjA1FsqP58fFXgUbTJQ7nsH5ZeApmyS6E4
	W8=; b=QYSPYV1j+xXJ1qfwFm8hImfSLrfWgtBKdgsIfYri1v3MUW/G6uUxonP5B
	eI105p7XshME/pIsTZ9puyhTLSLVwGpTfJv195NwFwcpmZdj7cN5Wl9XG17WAaW2
	p3Bjb+xFkFwYNl/DPmNS9JdRobD92vvN4yf7zTdYlZWetw36saqUCIso79TahhXs
	N1PWaV79XwFvRxd63JgpE/i2aW19i7FF/nCAHA9rNCG1ePxXD+tGcn5uh65lHZBB
	f6QBVDWvX9ahIFNYPzsoM2ReBsy3msKI3J/qfmzmDnj5bmgsOi+Rn7PcVvGi13hb
	cf9Wu6N+W2XMjxdkqQjz1ExWCXANw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yhs790-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 20:10:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658K4fo5001188;
	Mon, 8 Jun 2026 20:10:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jy6qf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jun 2026 20:10:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 658KABlg16187670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jun 2026 20:10:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C1C9C20040;
	Mon,  8 Jun 2026 20:10:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE2D420043;
	Mon,  8 Jun 2026 20:10:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.208.180])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Jun 2026 20:10:07 +0000 (GMT)
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
Subject: [PATCH v2] KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode
Date: Tue,  9 Jun 2026 01:40:01 +0530
Message-ID: <20260608201001.65760-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE4MiBTYWx0ZWRfX08rontH0jGL1
 nPfxUKgiw/iAevdxbCr1/do/EcWH6mfrtHL2VCp9PIC1Jmjgbse2RlbklaygtnTObhnnidbgqwH
 LaK5clBfh5lLeRrSryaPnEllsxRz+BhFv/7BVigCBBuRNNCgewu+4spyoWT556B14g+iZPAbu2k
 6EiD51FvFYnNteSdwzniT16loObWijbYCnMVTjYEmiAicBPNtUgCAY1mr6KZjFYWu7Vih1gzBZf
 rfJ3kAYYHKjFSCR/oCQzRto/GryUNLPgigCIDkE32pJ4jDConKKGXPxKUT4VunAtT/p8bP2vF1L
 HGmYg7AeZKGjEFoejgljD35oMftiANuW8jhmRCiwAo/XoM/nNB/41QtMaYwoDd9zjput3S597Is
 kMJCx5mgA2/Jo9xkvr0w2kmlBpcFvm9D+js968D/TpLtQxHiUWqwmzdj6k6GJUNGrOFpODRR5tE
 Jsk/HXUvm5s5FFHZUmA==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a2721a8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=9YAIjoFcglyEYsXf--YA:9
X-Proofpoint-ORIG-GUID: 6PiZMTJrvxEG9tkgHTQkZgB_dw4BjJDC
X-Proofpoint-GUID: FplBwTkmv2YHom8WSz4ZVI5no8F0Htj7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_05,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080182

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
detect the mismatch and sets arch_compat to PVR_ARCH_INVALID. This
triggers kvmppc_sanity_check() to mark the vCPU as invalid by setting
vcpu->arch.sane to false. On the next vCPU run, kvmppc_vcpu_run_hv()
checks this flag and returns -EINVAL, preventing the guest from running
with an invalid processor compatibility configuration.

With this, when a Power11 arch_compat is requested on a Power10
compatibility mode host, the guest fails early during boot with:

  error: kvm run failed Invalid argument

This provides a much clearer failure mode compared to the previous
behavior where the guest could boot in Power11 raw mode (if userspace
ignored the error) or fail late during H_GUEST_SET_STATE.

Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Cc: stable@vger.kernel.org # v6.13+
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
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
 arch/powerpc/include/asm/reg.h |  1 +
 arch/powerpc/kvm/book3s_hv.c   | 15 ++++++++++++++-
 arch/powerpc/kvm/powerpc.c     |  3 +++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 3449dd2b577d..7472b9522f71 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1356,6 +1356,7 @@
 #define PVR_ARCH_300	0x0f000005
 #define PVR_ARCH_31	0x0f000006
 #define PVR_ARCH_31_P11	0x0f000007
+#define PVR_ARCH_INVALID	0xffffffff
 
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
index 00302399fc37..7e2d489af642 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -258,6 +258,9 @@ int kvmppc_sanity_check(struct kvm_vcpu *vcpu)
 	if (!vcpu->arch.pvr)
 		goto out;
 
+	if (vcpu->arch.vcore->arch_compat == PVR_ARCH_INVALID)
+		goto out;
+
 	/* PAPR only works with book3s_64 */
 	if ((vcpu->arch.cpu_type != KVM_CPU_3S_64) && vcpu->arch.papr_enabled)
 		goto out;

base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
-- 
2.50.1 (Apple Git-155)

