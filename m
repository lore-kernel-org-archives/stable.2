Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B954032A3FF;
	Tue, 15 Sep 2026 06:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789452151; cv=none; b=B/Xfgz4lrXY4c2i3+743bMFR1isWKpkEetcwCjYPorrOHE7s4SDyt8ziLtiXJrFhpNn6TkJmUBYCpXYIafzrVnpf1I/FJ/lhL+ioM+7tnjbItdFLXO5Jo7lmSGrHXvmK/FQ5pd+N9rjIYwgOaBo+VZ8Nk5FVD07LPRDid2NQ4/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789452151; c=relaxed/simple;
	bh=XNDN6CTrFSyQkMpuLSBO/YGZbpnRm5vaYrIIANgBIB8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NU9Cw3lbVl8qD+E46ptQGnBgUsTjEj2MXPW7Tmi4StA0UUcn6WOYXgUJ0OrGCpspStOwoLkHGPCsO5dtICv6kpmCnlh9Wo7fkCU3MHS1KD0FmPRAxpGZVJSbVhPlutiNNirEE2QhwpSkkSNQ8yh59ZTbtU03rAv5FdyCbIangdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TIfw93Og; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TIfw93Og"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68F336jE1985171;
	Tue, 15 Sep 2026 06:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=mziOuLU5QUlqRbZk8liGvjNsgooRmkv6TWHGFoQQp
	hI=; b=TIfw93Og6YYne8l7IDqE7kw55lsucvoeFw8gTPBBFUM4ocFgYwQ3ebYrZ
	jYmCeqF+EcDLik4oFQ7puxogyctil+hWIuKoqBy4IE5U7i15Vj8n97XA4k0bealK
	dJeeXui/1eCUPMWw5A4G8iIW7L4kmp/bPI6gtKPQVMC96/hJqFsduk+4iWJucgpP
	4BU4b6NhiPNFNRAhSDXhL0qzrnQoM974B3Ik2kWw/jf0GuqyEVVrtMDJxq7AXDSA
	Qm72z+HG7nE4k3diPjzyVLTR16CijSHfjQVC0OU94x/nCovnGRQaVo2+e/Q0daA3
	U71yInMMXB7reZ5kvjE+hc/AyH0kg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdq5g9t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 06:02:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68F2o5K5038291;
	Tue, 15 Sep 2026 06:02:10 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpw6d0kxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 06:02:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68F624Ee27984216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Sep 2026 06:02:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32B6820063;
	Tue, 15 Sep 2026 06:02:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D4D22004E;
	Tue, 15 Sep 2026 06:02:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.211.50])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Sep 2026 06:02:01 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, tpearson@raptorengineering.com
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] KVM: PPC: Book3S HV: Avoid triggering an extra interrupt for a vCPU
Date: Tue, 15 Sep 2026 11:31:44 +0530
Message-ID: <20260915060146.33410-1-gautam@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDA4NCBTYWx0ZWRfX0acX0efXlAsu
 +JaT+lHKBJjogZ3Y7r1HO38NOHG7b6FUzwFCpocx8U5SJE+RzEzBKxh7Zeglkw9Np9wQ6sgSDcB
 d/mQO0CADpBoBdC4V0UbZoruzrTw5sO5NvkCP+Rji7I0oyFMxUryylvxFCWLjUHwZpdnUq3mrZx
 6Q9/B2Emh5lEyEi93c1KeW0BaVSXVT1eFU9PP1YG1rp8oAbjWosmqBKepNz4TLas92U6GYxO6f1
 zn4vh7X37Tg9H/Tfc9VzS8iWo6V4c2JpxMc8yK4eiwKsXBghvHDG4gL4BNoRz+edwm4jp0uYjc9
 zpxSo77+8vopYPgGYbthFgV+QSjnPBf7Io6aEeRzNFq7ZEBm4oqvfxHkr9O3whhz75xMdcT5giT
 6t3bJjQlN8K70RH2ZRouBN6ey+kyi0b4e4AIeLE+O8VPfjedbUAmY6RGFVb/++xfjG7A+XKEpXY
 AFp6nnsvIgQ/67Wjijg==
X-Proofpoint-GUID: QdeIj7NOxwXPuVuKMv7ub2LUkOHF5Bcw
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aa8df63 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=yKAn6K1XAAAA:8 a=_AprYWD3AAAA:8
 a=VnNF1IyMAAAA:8 a=5FuGBl7mYZk6O4wW2tAA:9 a=6M1ixcW_PCWoKiWyFx5v:22
 a=fKH2wJO7VO9AkD4yHysb:22
X-Proofpoint-ORIG-GUID: 0fp-fovddLNaImCsMbjhFhUGmi-vyLHa
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDA4NCBTYWx0ZWRfX2TO8MGs/akRk
 MW/zPBbiPPmQt1PH/FtDOZTdWgxS//X3Qm20wjqx+obD0tvirSOyfI4Cbw2XNinaqH+dgLYUUUY
 ZjiBDGrgJ5A6mhc8LnjYJCszR00Hvjw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_01,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150084

A huge number of spurious interrupts can be seen immediately after a KVM
on PowerNV guest boots up in XIVE mode.

$ cat /proc/interrupts  | grep SPU
SPU:     223705     192439     273526     147623   Spurious interrupts

This bug was introduced by commit ecd10702baae5 ("KVM: PPC: Book3S HV:
Handle pending exceptions on guest entry with MSR_EE"). The root cause
is that when there is an interrupt pending for a vCPU
(xive_interrupt_pending() returns true) and MSR_EE is disabled for the
vCPU, LPCR_MER ends up getting set for the VCPU. When the vCPU starts
running, the XIVE hardware presents the pending interrupt to the vCPU
(since the KVM guest has native XIVE support) and then a second spurious
interrupt gets presented to the vCPU due to the LPCR_MER bit being set.

Fix this behaviour by not queuing up any extra interrupts with LPCR_MER
if there is an interrupt already pending in the case of KVM on PowerNV.
This reduces the number of spurious interrupts drastically.

Fixes: ecd10702baae5 ("KVM: PPC: Book3S HV: Handle pending exceptions on guest entry with MSR_EE")
Cc: stable@vger.kernel.org #6.8+
Reported-by: Timothy Pearson <tpearson@raptorengineering.com>
Closes: https://lore.kernel.org/linuxppc-dev/582904882.11159.1786719390349.JavaMail.zimbra@raptorengineeringinc.com
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 7667563fb9ff..fda3767ebc9e 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4937,9 +4937,8 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
 
 	if (!nested) {
 		kvmppc_core_prepare_to_enter(vcpu);
-		if (test_bit(BOOK3S_IRQPRIO_EXTERNAL,
-			     &vcpu->arch.pending_exceptions) ||
-		    xive_interrupt_pending(vcpu)) {
+		if (!xive_interrupt_pending(vcpu) && test_bit(BOOK3S_IRQPRIO_EXTERNAL,
+							      &vcpu->arch.pending_exceptions)) {
 			/*
 			 * For nested HV, don't synthesize but always pass MER,
 			 * the L0 will be able to optimise that more
-- 
2.55.0

