Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC4E443AB9;
	Mon, 12 Oct 2026 08:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791793838; cv=none; b=Wn9xdv4LDDgImX3CDeF/6vCbNnlJCN9Gw4zXUAk/Qrg96Inddy0itovshjWeIZSuZg0HDrYGGJraE0j+tTxyHx46qbTj6RzlrCdTY1890TepNN19vzQq78aMW7z2sIfmqEyy8QxLUssmqZ9II2MHsskmMjLT8db0HMi5DyJmn0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791793838; c=relaxed/simple;
	bh=NIJyOEZO7jifNP6VRtmGmgh8GXelaTNN0C8/JmrW/6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UzAX7BtcnUeTz2dBLv/94eLZteJrhxw97l1ZwqAkcma9UGr1TJ+ihP5QYnSskpmjb+4MbiA52DUWQ0JBY5BJe4LGlEZkwiYbTe8DfjS4JnKfbDGWprIxBjuiqHz2h7LOzhse9CYr5U0IAdpOqZCrGp45yEAGx4dgeCjqWlFfAmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ntE1s9dA; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ntE1s9dA"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C5F2uu3481839;
	Mon, 12 Oct 2026 08:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=16BDxiUcLZ/nXLCJU
	aShAj1tY1axfepy8vCDz+0fufE=; b=ntE1s9dAWs1/ANHr+Fz/9aaG0w4moOvBI
	jkKBBvNulYr74LBqq1YF5s+n2FbUExPxBx/pPsaZiBopem3HkkzZqpKs/q+eKyGm
	xhGthg2npVMEYwV73/3prqVJmGlY3b0H3LLq/3M5z+LY19bVq1EsGG8QhXbfrkXB
	5UaY80WObn/ztrKBRNup8J/stZroMMYm496KAErGZx4L5xmfbqhlvbStk3QUm0S7
	Wz5Ja1OzFGgM9H6tTxKKFVU/sGB3M9LSozcaXe6qMXN8dPPActEWB2VCJioYvk74
	rbfUydCFEU/unXkoTmxi1vusl+9CyTLVaL/Z3fr0L2xA4T0c2ALxw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1vykf7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 08:29:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8K22W935491;
	Mon, 12 Oct 2026 08:29:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h80pjmbqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 08:29:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C8Tgho39911882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 08:29:42 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E23820043;
	Mon, 12 Oct 2026 08:29:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9FC52004E;
	Mon, 12 Oct 2026 08:29:39 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibmuc.com (unknown [9.39.28.91])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 08:29:39 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, sshegde@linux.ibm.com, amachhiw@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v3 2/4] KVM: PPC: Book3S HV: XICS: Update irq_type for cleanup to work
Date: Mon, 12 Oct 2026 13:59:18 +0530
Message-ID: <20261012082922.218799-3-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261012082922.218799-1-gautam@linux.ibm.com>
References: <20261012082922.218799-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzMiBTYWx0ZWRfX7GZpoWYpBoBI
 E6OJVbR467Z6s8JSBbf950/xpVgto58eH7I91QuyRNVCm/O0Y7NyfZN8AKEI35yy5bUdChF0tGN
 lOCFTu6peRoksg4ShOUMfXUV4xAOb00=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzMiBTYWx0ZWRfX+/dR87dkJfLD
 EgICbR6YwQ+RXeo9cVEA6rK6sjkck4fhAgM6V/zBF8V3QurCWBluQ2lbrvA9s4W0ra/B7KID1/I
 JtVMXA+cjtExjFoaDPTsLVRSdQEGh5lKrHAtvUad1zpe8UZLz7A7hmOp+JtxWKPUdCsjYXoL3pu
 KJSIB2vd5BFsZEqnCkepAHORdv73naSeLQscwVfoNjDhgcAezcafKgltjlC/eUbuw5LUPgXy63V
 Mo5IL69FZfO1wMtwJ3bg3UkOONrz3RJqZnuEQ7atojo3FgohuHtbpzY2S9s8f0JSmIYE4f8GBT7
 5ZsNRv3ZoD6IgtF5tPXbffz2BBN0JlAr6mWq/4IkkccNn4RW2HYB6IikuPjYl4oICWX5NTTNhlm
 zi2827P4u3QrUUjjHIrTuyJuaCbkXPj6NrZsSRn6hviLnEsie+EP48DEJ7ooN2JAXkod8zpoJj4
 DEEEMkXaCsLURPv66LQ==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6acc9a7b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=K4naiS_KJ2Bkn_B7trIA:9
X-Proofpoint-ORIG-GUID: a8rC_B3RNAbEBBrPvcoCAuusjStu_4l0
X-Proofpoint-GUID: 8m4nvGw8DuVx4ODZPLNAaEQTlu0AL82v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120032

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
v3:
None

v2:
None

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
2.54.0

