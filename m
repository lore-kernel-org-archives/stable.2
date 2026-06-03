Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714522DA759;
	Wed,  3 Jun 2026 14:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780496175; cv=none; b=QmWj5QcRFwzoOhtPpRhS3TvrdyMbrTnQWQUysJkU/+Kogmj9XXR/hCqI9s7oHq09qmkWYHmtLJJSzbVzz7bQYCU6cnmkdR2fJpSAIIBujDRPOr5go9IoPHQyEuaM7VG3fxWhr9UsvLPDW+ZREX8gDy5SHZYpXtsqxhPd8XexI+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780496175; c=relaxed/simple;
	bh=HlOo9yuJ7W1DgckPTdmqfNteUtA2KwlYM8ZEcapsuds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u85+coJelmtfiG9kMAl8OEGxH0eKjvjFV829Eatt9g6VIJw/exhYmsQ4g/c06KqmbcLFdz2EJeqEp5CKiYJCmYRQ2m89UGkYTP2JB6By39Sx0e/cw1rDPB9hIdQg+bcO7D74dZs94KB26f6wSRioB4cVAzfel5AbyKYHCodhevg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OXpNl8Af; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OXpNl8Af"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6535a1lH3708001;
	Wed, 3 Jun 2026 14:15:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=F1bCpJrGMayffkxKESwEy89wGfZqbjQXhYCNeMH4m
	8o=; b=OXpNl8AfgIC3enEhRAken53IjjrZeTsl6nU3J8a51jqnZy5JMOYLvvvoW
	RNebtLzciiPcllR5c5sJOFu5Leoamnnet3cvpYQMW5f2QPK7BnZqJ0o8ea9Z1qB8
	t5ZXKCZvuSXnGGztEMtoNuAidE8Zim1688SFlp5a/zP/wcE7zSbZN8q9G16q4XoN
	uuXn7RM0WabkTKWDK62pGNZbiTvoGaIr0P5dsnSDskHBzNgWKN0LsX2rfExDE7pX
	l+a+L5QSG80nPKNwpm2HzPirHmgJox2mxuXjk8G4Jew0lRFmpadCFy3ujThHczYM
	6Z98MUfcekfFhVUF+mymqAIEuBHuw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efpaeat3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 14:15:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653E977k028270;
	Wed, 3 Jun 2026 14:15:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhge0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 14:15:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 653EFlsd31064404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 14:15:47 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C27C72004D;
	Wed,  3 Jun 2026 14:15:47 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD56B20040;
	Wed,  3 Jun 2026 14:15:44 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.24.49])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 14:15:44 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        kvm@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode
Date: Wed,  3 Jun 2026 19:45:39 +0530
Message-ID: <20260603141539.47620-1-amachhiw@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Zt3d7d7G c=1 sm=1 tr=0 ts=6a203718 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=9nGdcix9NZkGgJ1vRr8A:9
X-Proofpoint-GUID: KByeJRv7OplG_laWcGHPeUMbQA1popcP
X-Proofpoint-ORIG-GUID: 32BC2DOvRklg3hef9YvCfmhZHLxjtdYO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEzNiBTYWx0ZWRfX9/ReuZZWpXFM
 pRk589GcemCfXWOuYftpujfWFrw/PUy1ShP6BBfPoH7rLnW9Shzp6yZuzXR2Dmm8p6U9Iu5e3RO
 cQlhYB98XQgjnmBxHWcsaK1sY1RybOQmLyDHOiZCjnfia72EvPG0dHv9A/pFFj3N5bxNQsLCltS
 T8A6AlnTbg4EycAdSY5o2IWqswfBjUmVTAWywq9VTPoU2qTOsSwiV5hqCbp0ngazYyqWtObmDVg
 K8FnPLqbLnBEZHBXdsBbf4huht16pmdznyqXV6EbyyS0qozlg5INKmUNZERh4VqZPMQ3K6zUsD/
 UMvxxbnQN+4F0uP4RIy+8ekXx1kKkVev7DOLogMfRWGntqu7YYB4bnQ0W26YqXsmKbF5yhmPzt3
 WlNnQN1C++IsBcbMZr8yTNyovJ2jkKRno13uJLQMrqf0aR7tWetztr3NcqX8xJfSsiEZ+fWeucK
 DuA7vbMNXt7lwPqRrlA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030136

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

This situation should be detected earlier. Rejecting unsupported
'arch_compat' values in 'kvmppc_set_arch_compat()' avoids issuing an
invalid H_GUEST_SET_STATE hcall and provides a clearer failure mode.

Add a check to reject Power11 'arch_compat' requests when the host is
running in Power10 compatibility mode, returning -EINVAL early instead
of deferring the failure to the hypervisor.

Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
Cc: <stable@vger.kernel.org> # v6.13+
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changelog:

* Moved this patch out of the v3 series [1] as discussed here [2]
* Addressed below review comments from Ritesh:
  - Based the PVR validation on cpu features
  - Fixed hcall name typo
  - Stable backport

[1] https://lore.kernel.org/all/20260522152744.55251-1-amachhiw@linux.ibm.com/
[2] https://lore.kernel.org/all/20260522152744.55251-2-amachhiw@linux.ibm.com/
---
 arch/powerpc/kvm/book3s_hv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 61dbeea317f3..e16dbb199366 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -446,7 +446,17 @@ static int kvmppc_set_arch_compat(struct kvm_vcpu *vcpu, u32 arch_compat)
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
+			if (!cpu_has_feature(CPU_FTR_P11_PVR))
+				return -EINVAL;
 			guest_pcr_bit = PCR_ARCH_31;
 			break;
 		default:

base-commit: ba3e43a9e601636f5edb54e259a74f96ca3b8fd8
-- 
2.50.1 (Apple Git-155)

