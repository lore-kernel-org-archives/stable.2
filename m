Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3C657F733;
	Wed, 30 Sep 2026 17:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789934; cv=none; b=mh/1JJQxk3cIfwnO6C6zg+nbIeCOAqi00XKB9MYqRMSb+dd26yN/KSrHp1dGEBUnkTjaj9atPFcQcgEUXEIbrgaHypAwlq0S7hGtUqt6Dq/nIrnFWHR1mfRKkm/vZMLXT93VqgeWEA33R95v8Te8kBzzC8KGKHsopkRlSHM1OqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789934; c=relaxed/simple;
	bh=lkuepaZa13J5l4gWNouNE5EwAE/GWbHv2BVXt5TcBms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ClGed3gtGzVK8g6u11+k01Gu50aS3PqWQvG87DAyLJBsEgupuOHjAcUdOEp59bmhf11kcltoKAylpFjRwT0/hUwrIMbs5MxeZT/A8Llys1mnXopuddNvds9NIF6jkDDs27FWP8Ms/Vnn8hzdAS9w2m40txCE9Vg6by6QwXXvObo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ox5+1+kq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ox5+1+kq"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE5Tqv1932767;
	Wed, 30 Sep 2026 17:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2Y2Ubg
	dV+77CAyq+MVK/R24FHgPjixP/AxA2RLOoCjo=; b=Ox5+1+kqc0RV3qK8jFZ+o3
	eO0nk4pb6m8tg2SHN4uaWn6d7BEmJpuh+1lBOep5BNRtQwUtdWBB8Lqpt0ysUN1k
	ZIRDDCAG7Xh2hgZXrso/HzicqsaEWAp4Sqbt51QDFAJaL/v0Z2h7OBH8da2bZ+7x
	HLa4GnNepb2wXwvNQ9UzGVmvGiFAMAwG64auMgO/2PIhfXS8ui2SqkHzXuysPebd
	GwkQNYXyjK8kYJ+pCoxVkA/8u5HVKr6jKFOx12fI8vwTXX8bonIE0uILHZJi5a1w
	b4aAqxE6VkGu16OpaJbQyJT3k61EbZHTPJ32u2NjQAKXP2XFAl0P/bQaYnG9FFYA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fednk0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:38:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE34No3576908;
	Wed, 30 Sep 2026 17:38:33 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0j23mtyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:38:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68UHcUow29032894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 17:38:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E934420040;
	Wed, 30 Sep 2026 17:38:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D42782004E;
	Wed, 30 Sep 2026 17:38:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.22.150])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Sep 2026 17:38:25 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, kvm-ppc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gautam Menghani <gautam@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        R Nageswara Sastry <rnsastry@linux.ibm.com>,
        Alexander Graf <agraf@suse.de>, linux-hardening@vger.kernel.org,
        stable@vger.kernel.org, Avi Kivity <avi@redhat.com>
Subject: [PATCH v2 3/3] KVM: PPC: Fix get_d_signext() 12-bit displacement for paired-single D-form
Date: Wed, 30 Sep 2026 23:07:50 +0530
Message-ID: <20260930173750.56759-4-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260930173750.56759-1-amachhiw@linux.ibm.com>
References: <20260930173750.56759-1-amachhiw@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abd491a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=WFAfMJoNLMmZCboqhGUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA3MCBTYWx0ZWRfX8H9cJz8GU1d4
 qiJ0vXR3rC0E43xFykm+ibysWJLDiu+2hiDEpbZWnLoygUzJCnf1dgEnNPjyI5HsmYsXW0IS/GI
 Q3mcZbhZRXbwriAeNBRp99EE4JSOaOQ=
X-Proofpoint-ORIG-GUID: 18QNavaaiQSB-U-plhb_z8wwmuhRS_ZU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA3MCBTYWx0ZWRfX35aPteMlp+Yb
 Fr8nM6NYTCTLXfxB5Zmx6okE6b/md4HWFi76c3niTYgY52Foa2oS/GQkcsvYtnG711pq6/avZ+x
 WKtTqHBWf1LRreD15vVh4bqYWv61wPTOF0fQ+iJ+MJm5fLScCzXJzwg0F0OLQQjv7cwZG+dGtWX
 vTRwe3yKKRG9M0hDl8H9gNee8rj4g56WW4lspsGXesNZWc7aWVHCk4r0Yw2QDDRy51p2I2QY0/s
 x7NwyhPcvTPeUw5vdQfleNWvYR7xfOPpYOTVLzUZARM0tO/o4wqozYDLucVjilHqqQZ8qLTYgTB
 UFkw44AJH6a4mZNzxHGrdm0Mj1k58PJvSZG3Qd5klvO2DBp6W+cjXMfXlBDQ/A/TyXg0tY0i3xX
 9hW5o8xxqBilLaBKj+Xa61bX6VGQFXivW69xSaKMp0Ggz/3HAx9d1N9Zbr4sy9a7s5kTYC4cCgP
 N+Gp0QPdM3qtOMA3O3w==
X-Proofpoint-GUID: wp34fFiTUNpvu3nLQcyNGzVLNcl--0pk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300070

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
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
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

