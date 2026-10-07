Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9930B3EAC8B;
	Wed,  7 Oct 2026 18:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791397601; cv=none; b=eXlrtr5arGuA3XIx5wmucxKngfENngrTr/gGXQdBCQtClojLSygRS49N4DNw2acUWuvrdTOka/o7A+ePMP8IlfGTMfcYT9bmtq7aox3i54mhv5WY5hWp2ehJzG+0necIcOrw88GRq0zenJYHVRAPWRCPCPs2UPXNpV4MiPZd5i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791397601; c=relaxed/simple;
	bh=MZ4R4/Gg6tc4hQwXGLhZjIc/1e5xCYfDLf8Zvrg1zVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jPLK05s3xqwApahnGOtasDZesym4725Stxq1FqLOppIW4/HPVmvMnbhjHFLlnkqp2C+82miGHu25SR9N/XS7MEDScguO8ba8Ea6TLujqLD37bYIGjhky7H3C3oO0uTTgR3gVvngwpwPOZyjBs0NJ8zXgpI7Ku1OzrHcsjA6EeKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mS7yXQJL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mS7yXQJL"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697F5ffw2823381;
	Wed, 7 Oct 2026 18:26:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WlqfKw
	DhkkKsMTCjnrCGzLKyHRxHSTeOyuF+x9N6HZw=; b=mS7yXQJLEMSlvbMYB8SapY
	LFrAorSbfrhx1wMI+W8og+BYI4pHfTpn1ZmXLmqXFi3cgROWjDxz3bdtbOr4Nn0n
	fdMaX4wokYAw2IXQOE0anqYKzm8MrOw+YZkFhKwU07dQ893ylVJggkNO40Mo+bp2
	34cY+Q/C30zZmmc+EcBBTq6bfmSLtgCvMVPBzMeods7HO29KL7b1b2IiIcqEm8gS
	y5NhOzXRNPMktNmlHtmSwkXcZ8z2d4M2MBajOOx/PnnDoQjRnpsIQxnfqaTWKC/I
	zP7jOZkpJ+b+FNunVivAfPElWsLdVvowOZFrCaj/BLpUtka+Bdtlw/vfoBiBUr6w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5q5yn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 18:26:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697IHVfv2307730;
	Wed, 7 Oct 2026 18:26:20 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgyu4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 18:26:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697IQGT940829236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 18:26:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 813AB2004B;
	Wed,  7 Oct 2026 18:26:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C38FF20040;
	Wed,  7 Oct 2026 18:26:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.25.208])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 18:26:11 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Alexander Graf <agraf@suse.de>, Avi Kivity <avi@redhat.com>,
        kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        R Nageswara Sastry <rnsastry@linux.ibm.com>,
        linux-hardening@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v4 3/3] KVM: PPC: Fix get_d_signext() 12-bit displacement for paired-single D-form
Date: Wed,  7 Oct 2026 23:56:06 +0530
Message-ID: <20261007182608.17188-1-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261007182116.12479-1-amachhiw@linux.ibm.com>
References: <20261007182116.12479-1-amachhiw@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA3MiBTYWx0ZWRfX0AS9zhI7wiqi
 8Le4L56pnXG8lQbytFUgz9esQviG2XLYiinpRJXYfLRGT1SZ43e8lCGZewbendjpidGeo3xyklM
 wDRYS7R1sm5FtWQE7AmydkI1d6OZCVw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA3MiBTYWx0ZWRfX4n6uOreidGdF
 kA7REJSJrykf4XQo0yY5nvLSxvPbxZQT0tWfgN58GwgU05m1J8qMmRn9wifAM73//u6nXCCBzZd
 gvDLuGdK0Q8DLi8ahnzZsssdV14WXt1FMk2rSfAxirlrA8YK/9r6NbQbaHFgvWb+uAJ6nsfpe8r
 nBNw+HBK/k5cKOFa2CN2wScIGPaI8yhbgCiGc4psh67pvsGx6sIlGweIXLs1wcxN/g0zu0tWF+p
 0VesYNzhB3NHvCMN1fC/+gLxQdeJeDJWy6iDasVJOOFyPFX+g1CbQUHWUAF9Gh9zbM7gysvrV/7
 mjtt14WOoPMkobOpdYlTY00L08C8hAaD0StVpmqw7tFCydp7gnx1C9HA5hwNSL024XKgQ6VnzJ9
 9Yw1sv5JLTxoLE0tM8l+8a/DD82xBmUMpFcRjNdZUOHUWAZ/WJU2wLZs0UdmU/F04e4J5mJZRvI
 vilrztvk+JR6e+Bji4A==
X-Proofpoint-GUID: jxjboHntsCQBwiRxXf8AbkSQTrbe5Rbt
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac68ece cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=WFAfMJoNLMmZCboqhGUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _6Tjx2towODCH0F-BxDnaow6-tPq5d-e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070072

get_d_signext() has two compounding bugs since its introduction in 2010:

1. The extraction mask 0x8FF silently drops bits 8-10 of the 12-bit D
   field (PPC ISA bits 21-23), corrupting any displacement that has any
   of those bits set.

2. The sign-magnitude idiom "-(d & 0x7ff)" is wrong for two's-complement:
   for D=0xFFC (encoding of -4) it returns -252 instead of -4.

Together these errors produce a wrong effective address for psq_l, psq_lu,
psq_st, and psq_stu whenever the displacement is negative or is a positive
value >= 0x100 with bits 8-10 set — essentially any real-world paired-
single stack-relative access.

The D field occupies the bottom 12 bits of the instruction word (confirmed
by the adjacent W and I extractions via inst_get_field(inst,16,16) and
inst_get_field(inst,17,19)). Replace the open-coded logic with the standard
sign_extend32(inst & 0xfff, 11), which correctly performs two's-complement
sign extension from 12 bits to 32 bits.

Fixes: 831317b605e7 ("KVM: PPC: Implement Paired Single emulation")
Cc: stable@vger.kernel.org
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changes in v4:
- No changes since v3.

 arch/powerpc/kvm/book3s_paired_singles.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_paired_singles.c b/arch/powerpc/kvm/book3s_paired_singles.c
index bc39c76c9d9f..532f96293de0 100644
--- a/arch/powerpc/kvm/book3s_paired_singles.c
+++ b/arch/powerpc/kvm/book3s_paired_singles.c
@@ -479,12 +479,7 @@ static bool kvmppc_inst_is_paired_single(struct kvm_vcpu *vcpu, u32 inst)
 
 static int get_d_signext(u32 inst)
 {
-	int d = inst & 0x8ff;
-
-	if (d & 0x800)
-		return -(d & 0x7ff);
-
-	return (d & 0x7ff);
+	return sign_extend32(inst & 0xfff, 11);
 }
 
 static int kvmppc_ps_three_in(struct kvm_vcpu *vcpu, bool rc,
-- 
2.54.0 (Apple Git-157)

