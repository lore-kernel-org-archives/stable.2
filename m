Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DC43F3283;
	Thu,  1 Oct 2026 10:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790848962; cv=none; b=fXLJEcZp6YU1004Tq46jFMT9ZXTsI6l3zDDkicgh0DMT5NAIrBj0sEO9EMSeRSlHfRb2JsDbVSF1JecxvkTuRLFfOalLe0Y0rLgqYLMIjxHaJK9r4+3CelWYZ+96USpyT5AyF/rbNMWcnz10Lp8oEyH735nhkQWTZjWHPPNocAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790848962; c=relaxed/simple;
	bh=nvuDpB5+ZqcqKSuBTkfwMDB5UO498LH7XUK+dWY3/9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E4J8hEK7iMEamXCCv9g6ge3QefSe4yIO3eDWC+nOeF22C6n0GrW1YJG6W7vHqMkYCD61OUu5nJ2bO8wlXKWYUBuqhsYDJm1yY9dFrg/N5JavEB591V5+e3EEZMce//Xw98bweWyD7Wu4TV4uGC/JzByRl1x2/yPwOb/AdcJdFv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Oejnek4d; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Oejnek4d"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175oCn1086744;
	Thu, 1 Oct 2026 10:02:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/YT/tU+P0v7NuYhFz
	TYxAmBRlRHqq56+MTFPiv5nxa4=; b=Oejnek4dM10fzEj3ZhuCZQDEb6UP8YJaM
	LJngo9YzI02wVqrtw9MzreCqYUbtWJ9oh33UXn8S1HAyburmMQ2nloEOETfHzluS
	cRVi4bWmXQwxV71MjUOlqEAuXx8JFeIP9TytmFWtYVRUTiElmd/LCXOb5c7x8Sd0
	AJASw5KQyCVtm4N1pTINBiMA8xVeW009zNZo5gRUY8yKUyvTCNHYzgEwfjFcMCuE
	Ol/7nLu7VgO2nuWCXtVLpj0jXfCpOgMsBa4Uwn7KsSySwZTmHLuNGIrYiP+dB7gs
	WIN41C3Z4cz0U1SvnGv1Na/H/5yuHxrHSOEYjGi2SsYQr1WISXs5A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s5jeh5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:02:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172g2t561279;
	Thu, 1 Oct 2026 10:02:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0g8e8fnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:02:30 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691A2RmS13369610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:02:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E75BE2004F;
	Thu,  1 Oct 2026 10:02:26 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75C632005A;
	Thu,  1 Oct 2026 10:02:24 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.bl1-in.ibm.com (unknown [9.123.6.5])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:02:24 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        amachhiw@linux.ibm.com, harshpb@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 2/3] KVM: PPC: Book3S HV: XICS: Update irq_type for cleanup to work
Date: Thu,  1 Oct 2026 15:32:05 +0530
Message-ID: <20261001100208.1271628-3-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001100208.1271628-1-gautam@linux.ibm.com>
References: <20261001100208.1271628-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAzOCBTYWx0ZWRfX6WowgeNzCBj2
 FB55JSfY8A7ETUHmpLH19V/kGTNLfg4yrBB7yG4eG0fTv5Nh1rCjM3GfGC7AFUmfDMT8ty38qJE
 StFem0zsfewB0eR1CtDyVH4bvHc+DAk=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6abe2fb7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=K4naiS_KJ2Bkn_B7trIA:9
X-Proofpoint-GUID: 0mBnnRLlWJf4egnTm5z9jLsM-hOtJRuf
X-Proofpoint-ORIG-GUID: x-AdxS8Cai3UKRJcIwVyjEAnIseVzCoE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAzOCBTYWx0ZWRfX+LtER4GSru/6
 vCVt9x6QOiRcJhLEn2cPwCFUy0uMnEeQmtfRZFj/diMmt0CPKitiBAd57LFmdb0ewMmO4Y96BNT
 ndDpkKmTIAonr5HID0fRqoRAOKcOo7e9SkB/DmsP6wUzF4dLGd70IKOLsGnENOEJPyoSSvEBy9I
 iB3nxbJTepKPA2IKMY6BekwGq2O12UNXumOA/LP1eRExRaqH5ToEUiLI0LMBfWxNhdZb5WMpTn1
 XFFEQspgdcBej0n92KJQUUuPHxECjwTrhr5Pma/Bi8cZ4pLdM7zB8CcL15jDLgX0M0mo1fQFjFK
 B8cw55vmLkUUCu0zr/XYSa1KyI7WVSiEQ8ouTSDM0gDXQCMqCM1L/nniuvXYR2zB1OL6AqrmCdk
 44Ssr2yXb0etl8XWKSh+GmOByVXzheeUudAdTxONtPASfO2Ig3eYcYo9cqmKek+x45EjN6jdqNX
 AQSiRoS2mHC3j3FlgYA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010038

In kvmppc_xive_connect_vcpu(), if any failures are encountered, the
control flow jumps to the 'bail' label where kvmppc_xive_cleanup_vcpu()
is called. This cleanup function exits prematurely since
vcpu->arch.irq_type is set to KVMPPC_IRQ_DEFAULT at this point. This ends
up resulting in wasted memory.

Fix this by setting irq_type to KVMPPC_IRQ_XICS before vcpu configuration
starts. This makes XICS initialization symmetrical to XIVE
initialization done in kvmppc_xive_native_connect_vcpu().

Fixes: 5af50993850a ("KVM: PPC: Book3S HV: Native usage of the XIVE interrupt controller")
Cc: stable@vger.kernel.org # 4.12+
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_xive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index 1d67237783b7..67219044fb8c 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -1937,6 +1937,7 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
 	xc->vp_id = vp_id;
 	xc->mfrr = 0xff;
 	xc->valid = true;
+	vcpu->arch.irq_type = KVMPPC_IRQ_XICS;
 
 	r = xive_native_get_vp_info(xc->vp_id, &xc->vp_cam, &xc->vp_chip_id);
 	if (r)
@@ -2025,7 +2026,6 @@ int kvmppc_xive_connect_vcpu(struct kvm_device *dev,
 		return r;
 	}
 
-	vcpu->arch.irq_type = KVMPPC_IRQ_XICS;
 	return 0;
 }
 
-- 
2.52.0

