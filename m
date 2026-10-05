Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A703E41378D;
	Mon,  5 Oct 2026 08:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791189962; cv=none; b=EoXMpSP1v6+LzHCWY4IVY9tGe09lzNRpvWj3ULoFEw5Aj1dYhD/iwBBSKqToCV1cKafFdlZrufGkgls28EtxXvBWRfngGJHRRYUcIq+gWXoyzHPxqkHeq4Rhr1VGWMVkeeYoVEW/n7OggJeeKFdeEdAPMUZ04H2TrIB1xRi98Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791189962; c=relaxed/simple;
	bh=u0Gla2oo2wEOG7DjkZ0ogsT+adc1scmQq2flnciXlos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gUujohf6njrQ8X9fcPwaeLDhmSuG/9nfB5zO8B7rlIQQG47xA5f1WUmJfk1M7249ps6S+M/Le0Ut0FbcIOIH+TIxnobk43Ua4JmWw9JWVMN/Agqrhbf3JJ/5jTYw/hpp7fCU6cDLh/mYAbgpQ3n9p5JqxqJhrRpn5fJBj9jnKHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ePORUGvG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ePORUGvG"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69515uMJ2066458;
	Mon, 5 Oct 2026 08:45:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=tByF+zsuU0L7yHEjIhvPWbDwXmPqdAw2pMNjnhYDb
	8Y=; b=ePORUGvGePKH/2U/ZoV+ppr7bnZYWbgaku9QEhz/h6mLfyZz+BeHO896F
	vu8C4y4dzOM7epR0KZSCDMu8fzEFp/fxBl2DEhcx1NzDfQjRiKm/Muq9yhpdjO6A
	hNGGlInHn90/6LPmCmDrfuP7YvnpiKPC7c2Qsv6Fw91na+UN9pVaDynO4R2SU+W3
	MEY6F2uJtKW/TBPeonnyAb5IkyZuZLFRoRV7zMczrZYWJVoBOx0IOJxrbCNDK27t
	UbkZqx/eWyq5hXDCVYsGiBaiveXRS6vFOD0LkC1xcugsEWQCr31lAaNXvETu1KhN
	DeEPqMVaogKH/XgeLfR/45kT55Yaw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4frphm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 08:45:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6956dOxQ2163644;
	Mon, 5 Oct 2026 08:45:45 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvmrs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 08:45:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6958jfZa52035852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 08:45:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F19FF2004B;
	Mon,  5 Oct 2026 08:45:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BF2720040;
	Mon,  5 Oct 2026 08:45:37 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibmuc.com (unknown [9.124.213.142])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 08:45:36 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        nnmlinux@linux.ibm.com, amachhiw@linux.ibm.com, harshpb@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Timothy Pearson <tpearson@raptorengineering.com>
Subject: [PATCH v4] KVM: PPC: Book3S HV: Avoid spurious interrupts caused by LPCR_MER bit
Date: Mon,  5 Oct 2026 14:15:33 +0530
Message-ID: <20261005084534.1588611-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac363b9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=yKAn6K1XAAAA:8 a=_AprYWD3AAAA:8
 a=VnNF1IyMAAAA:8 a=lIyXSIJ_195hEhgqkI0A:9 a=6M1ixcW_PCWoKiWyFx5v:22
 a=fKH2wJO7VO9AkD4yHysb:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAzNCBTYWx0ZWRfXyW0tgeAJbB1W
 U9wN3fNAD9Q/41vbHh3wPw1n/aAF4KONK2oxesaD3ZZ/bbijfSN5bBIA/Q9tBD1R+KW/bWW/r7V
 7aBvFYmE87iHQN8kXmgQ4iRO0UDdP+B1aECAOFjqWTfEUHN37vFnQSRQM1qxn3tCRHUQWsnnbV3
 evTawAL1eUYWyuuVoTGznylfWvrDWGHN0+MhTtM0x0o0jv0rHjKfS1TaQkx8q5P2z8/hHpJKGLF
 PSin9I581Oo47jZCbLJd7F5RtyfcI9nx4YX18mSGpZ6h0ybJPwcGpQeIjl3ki1W80Y5/prDtj64
 cMHl0+FxzT50UEsSUfAqoa5iW9GkmcmeukcG/dsucOWDYZGCRe0Z3mR296zD0qVerG8mKhy1xeD
 IOg3Isgi3kPQk7V4GZzwqREqNk7b00u3u3IXn7hRav5MlLxRkR7prVg0Cf+mYJBfne+RLA6b3hd
 NGrEN4dEwkGeJ0MZR1g==
X-Proofpoint-GUID: _PZjgv9L4aNgazMl2up8czkfMaDjhM5E
X-Proofpoint-ORIG-GUID: PPgngfPFwrgjRoyDo8bWOkTtV5oBRJuR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAzNCBTYWx0ZWRfXyn2IfvUeOZpb
 g83unCnOkNzTJ+K//Rs459LBgLs9e6iw8RoKi34Hwd/YAVdMWLH/RLY8jxw/zVFO8a5pVhKHj5P
 4oS3oSRoNOeIHrnHVDlnbvX/E5XISVs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050034

A huge number of spurious interrupts can be seen immediately after a KVM
on PowerNV guest boots up in XIVE mode.

$ cat /proc/interrupts  | grep SPU
SPU:     223705     192439     273526     147623   Spurious interrupts

This bug was introduced by commit ecd10702baae5 ("KVM: PPC: Book3S HV:
Handle pending exceptions on guest entry with MSR_EE"). The root cause
is that once LPCR_MER bit is set, it is supposed to be reset by
software. But when a vCPU starts running with LPCR_MER set, the vCPU does
not exit back to the host until the decrementer expires or there is an
hcall, etc. This is because KVM on PowerNV guests have support for
native XIVE, so they are not dependent on host for interrupt emulation.
Due to this behaviour, a huge number of spurious interrupts are seen
since LPCR_MER continues to be set and LPCR_MER cannot be reset until the
vCPU exits to the host.

Fix this behaviour by not using the LPCR_MER bit whenever native XIVE is
available (currently in case of KVM on PowerNV only), as the XIVE hardware
can present interrupts to the KVM guest vCPU directly. So the LPCR_MER
functionality is not required. This reduces the number of spurious
interrupts drastically.

Fixes: ecd10702baae5 ("KVM: PPC: Book3S HV: Handle pending exceptions on guest entry with MSR_EE")
Cc: stable@vger.kernel.org # 6.8+
Reported-by: Timothy Pearson <tpearson@raptorengineering.com>
Closes: https://lore.kernel.org/linuxppc-dev/582904882.11159.1786719390349.JavaMail.zimbra@raptorengineeringinc.com
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v4:
1. If interrupt mode is changed to XICS during guest reboot, MER should
be used. (Amit)

v3:
1. Continue the use of LPCR_MER when kernel-irqchip=off (Sashiko)

v2:
1. Handle the case where xive_interrupt_pending() is true and also the
external exception bit is set. (Narayana)

 arch/powerpc/include/asm/kvm_ppc.h | 7 +++++++
 arch/powerpc/kvm/book3s_hv.c       | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 169ea6a7fbad..9178406dc365 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -747,6 +747,11 @@ static inline int kvmppc_xive_enabled(struct kvm_vcpu *vcpu)
 	return vcpu->arch.irq_type == KVMPPC_IRQ_XIVE;
 }
 
+static inline bool kvmppc_xive_native_enabled(struct kvm_vcpu *vcpu)
+{
+	return kvmppc_xive_enabled(vcpu) && vcpu->kvm->arch.xive_devices.native;
+}
+
 extern int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
 					   struct kvm_vcpu *vcpu, u32 cpu);
 extern void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu);
@@ -782,6 +787,8 @@ static inline bool kvmppc_xive_rearm_escalation(struct kvm_vcpu *vcpu) { return
 
 static inline int kvmppc_xive_enabled(struct kvm_vcpu *vcpu)
 	{ return 0; }
+static inline bool kvmppc_xive_native_enabled(struct kvm_vcpu *vcpu) { return false; }
+
 static inline int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
 			  struct kvm_vcpu *vcpu, u32 cpu) { return -EBUSY; }
 static inline void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu) { }
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index dbac3573b2c8..dec89c014c52 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4980,7 +4980,7 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
 			if (!kvmhv_on_pseries() && (__kvmppc_get_msr_hv(vcpu) & MSR_EE))
 				kvmppc_inject_interrupt_hv(vcpu,
 							   BOOK3S_INTERRUPT_EXTERNAL, 0);
-			else
+			else if (!kvmppc_xive_native_enabled(vcpu))
 				lpcr |= LPCR_MER;
 		} else {
 			/*
-- 
2.52.0

