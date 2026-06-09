Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F0025B081;
	Tue,  9 Jun 2026 05:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780983240; cv=none; b=Gk9YT8IxAxyc6/g9y+MobZH24VBOVoA1kcIRYr7wB2GGzau9vyuueZuMahO0hwz43BiS5pHIYVnOUI31fuiSr4QfQO6x+dqawVd+2DcWWB20UB1OnYPwE7OW/g2SFblf3mjtChGNkJLpIjMIqIsGqXOC7d88he8rfpS2IvFQWDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780983240; c=relaxed/simple;
	bh=cg2qcq9ozKbtncl4Hx7zEsDOg7nXuzn0Xq9h9tmNMjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MuVmMI7ViW3szCFHZKWb0mQbkxf+VUV3bkTGFvcvOXvLmd0aZRYY15G97TDm4Kji5b1spyFaTARI81xOvl8fbLHYppYhciROXJDrxkKVu74h0lp0xM3KVNX/HQ/ekobcfRxlBXu/JZk/gFPc3VUcxTpy54fbnNDrq24j7mdR5Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WTkXIqXO; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WTkXIqXO"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658FcVTs139779;
	Tue, 9 Jun 2026 05:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=h4U6Sbjjrq8q50+0voNxs+9I89BkWMApufobEZSOs
	eY=; b=WTkXIqXOIp7vGG6m/VRV2E7KyK2ZxccWIAIahwQMYxuANJ6DStL71NXEI
	oKu4RZHfM6rMB5yqE1iIAtjgohz+ZXjfWJYQbH5momnnxLm1yErkGLPJTN1JwFvG
	6q6QK+qZmFk/0GrD5kK+a2oU/SDDvNt0v121Kce7DsQRtHdHE70kYI8k46dC7/BZ
	rzl96jyGcsBenuNqEads5X0OVIMGWLppbqnUJRCdo2Uqj11FB0cQ3aLlYATdZWXj
	JzOeQoKAO7aMnQUxFHvswQHmTBQuAOSjXUhMwYMaUe2wM4ZxYghAnbSzbiNDsDpi
	dIGP2n1B65cvf0Ob4Kkw056fnvULQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb23tkqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 05:33:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6595JdiT018444;
	Tue, 9 Jun 2026 05:33:43 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvq0qqe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 05:33:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6595Xd9s51314964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 05:33:40 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8EDE2004E;
	Tue,  9 Jun 2026 05:33:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF83320040;
	Tue,  9 Jun 2026 05:33:35 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.212.145])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 05:33:35 +0000 (GMT)
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
Subject: [PATCH v3] KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode
Date: Tue,  9 Jun 2026 11:03:27 +0530
Message-ID: <20260609053327.61563-1-amachhiw@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a27a5b8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Drpfxw2PEthCErt8fbUA:9
X-Proofpoint-ORIG-GUID: FnS8ySaMDMFt4SGTpO6-l0R7p3Stm2C_
X-Proofpoint-GUID: h726DytJXdfuSgLf2XerRB22UhvfLa7Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA0NCBTYWx0ZWRfX1cmhVe4ZcRB7
 raGOFDuChSgX1bKihF9baVdt7LYEu/XCljX1h1+/AgngB+ytLEtPLOGYC03P1X3p+cX4GzZUg3K
 Aiauuel3HHZwB+6MTzgWB7nNBpXigI9rgtviG6AK+9/dk2gLsF3Wzji9rfQdl2ZvQnEQtDjrlmn
 ePnwqXneggzHoRW6owVRVa4K8N84iz304zOt3E95EyQf6vJ05ule15k5R0QUFRfoJ/tyzgZgkgL
 472hPmQwC8wYtoYbHIuUJu4XPZ0jVvuUC1L7w2L4tdiiyC9NOKWaKspUafJvP87pxdMZkXSWESq
 dI4obv8JXk9qoze0JRzb9ocGEzb5kkbDhUOKNRtpsm2BpzcBlhCWRbJ0IZ1TPVnt7WCQlc2K5Rb
 IDpLyOSiIo3OUAX7GtTYRx5BtH3lX9F7W+3hCFHw0YmlUJnKCpuRvGMqmcojohhsc16cFQBE3A/
 gyfOK+OtLpVUMuah8pA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090044

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
Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Cc: stable@vger.kernel.org # v6.13+
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changes in v3:
* Fixed null pointer dereference in kvmppc_sanity_check(): added check for
  vcpu->arch.vcore before accessing arch_compat, as vcore is NULL for Book3S
  PR and BookE guests (only Book3S HV uses vcore) [Reported by Sashiko AI]
* Added Reviewed-by tag from Vaibhav

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
 arch/powerpc/kvm/powerpc.c     |  4 ++++
 3 files changed, 19 insertions(+), 1 deletion(-)

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

base-commit: 2d3090a8aeb596a26935db0955d46c9a5db5c6ce
-- 
2.50.1 (Apple Git-155)

