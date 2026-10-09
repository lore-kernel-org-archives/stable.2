Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708394DAFBC;
	Fri,  9 Oct 2026 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791549078; cv=none; b=cFhRZZR4NxSkFN9QvtS+cvX3w2cpNASBLfellp9ScS88J0laMAQ6dDkUGWXRAM9POAuBz8ikY+jpoRHHe/Y/rhQ0kC5EUtGUaRDYiHTPsXGDMQSIe/RRl/tMnWER6cWoeSPI0G30SNcfkcT8xSHdZfhl6dG58svbD7VRLJzmkNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791549078; c=relaxed/simple;
	bh=mtxuYs175fAXFs+j9z6FsZ9pLtOKVyKcT4Y+ObQ/3lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uaXjQTCeMbY/1PKZy1wp6Nal5qnpfIQhtB4k5f9xTnGQkGuzJNif23ANk4tB/1hbbwaE/BdQ1nvH/tHwSH8BL0GgHA5v0R8fZ7fHJtVO1R9Q+nW6mJizYpI+u7iugUAChtYYwFCsgCD/+EeEm8BdwkKoet6911iIhUhM/BKW8A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dLDcPBoz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dLDcPBoz"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998Zgoh2007687;
	Fri, 9 Oct 2026 12:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1hX8ga0ViJV2/qnvv
	aA2Kjjl9IWZJSF/p4ilJc1uNJo=; b=dLDcPBozF9rGiG3A+1J9vUZKfP1KuvM6N
	5AwUcO89rPOYp1IUUAjATJH+1vMXrpprsnGh/B/TkZ2dHyMOvNbeYDkQ3c58eCT6
	sAtkKr804a/9netgVnyJZuu1ek/spdtHSb3l43f4VtItED2Ksh0AO9ZyF3VfYtQz
	Cm99AalL9hSY5NSpoh7pFFGRGoWkI/L8783hMWMF0w9/Vkg8qHP4KZMgRjV2QGJM
	Zn3A7DzVF4wXU4ffOLm35sN7j2s8rk39hOkvD9MV3ZEW1fWU9VEMKCGy7YtaERWR
	+jlA9hdxgPV7K5f+cp2VxCsJwj+GCI9Zox+jKwfxF3tdsSbe/Yomg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjwanmp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 12:30:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6998I7ha578963;
	Fri, 9 Oct 2026 12:30:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h6v76rweg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 12:30:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699CUtBL33030410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 12:30:55 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1FF52004D;
	Fri,  9 Oct 2026 12:30:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D61F20043;
	Fri,  9 Oct 2026 12:30:52 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibmuc.com (unknown [9.39.27.243])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 12:30:51 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        amachhiw@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 2/4] KVM: PPC: Book3S HV: XICS: Update irq_type for cleanup to work
Date: Fri,  9 Oct 2026 18:00:31 +0530
Message-ID: <20261009123035.157770-3-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009123035.157770-1-gautam@linux.ibm.com>
References: <20261009123035.157770-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: yyiZba2Pjz8_UdvbKwKGudqW0CGNXg8e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0OCBTYWx0ZWRfX4KO09OCGoc5+
 k+YGYuvtLZHNbZ9aZn8UzsilS+u0M3qBQl6VJn3gdTxWjF9d8yXSwd7LorYDu4kuH+8KOOovfwt
 L9QlfWX5e5k+hB7XEEdhe1MpBJyCHUYczoece6uMPDr6ZlAgHQfG4npP7hYJP4IlAAWG2yYL1sR
 sdO3PvHbo1fKc5usqPi0o2/UyFi8Kt82ajIDHXtPwgTMuUT3VwZvDMtwls6Qd2EYEEmHlXKnKYa
 Uh8BIEcB0KInUW75s/2nylLzWzEDJsxlRUfDMdRn5VROe6EhFr4voNvYOw/AUa2d1IsirKcGN/c
 ybwoZ2OT0AI3I2sHrEca+ry0om1jSIsG7hlgM6hGSJZR+9Z7J81nVMymplu/Iw7/BAxR08yXQ7V
 Ov+NG2rLIvnByzrxixBFqcp2NYXrKQRnJ+Pjc35Aj3Tm95XQZsCYSHmoSlFfhja0JmwT2ACbGVo
 saVsDakWeXf9cG3e4vQ==
X-Authority-Analysis: v=2.4 cv=cIt1IVeN c=1 sm=1 tr=0 ts=6ac8de84 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=K4naiS_KJ2Bkn_B7trIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0OCBTYWx0ZWRfXzDqquoNAyvU0
 eZklcawWDRb/mokLdmZbvPLHWdvikzZWgrw4VXjyp26nYW9H7VxZ03MuJFJT5v4ruK3T+hXJn2K
 HIAldRUVZ/7S2PR413vuewCjmChbwyY=
X-Proofpoint-ORIG-GUID: htSSMOGoCEATf3WUTaK8RW6yWlwBlJdj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090048

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
2.55.0

