Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279204446EE;
	Wed,  2 Sep 2026 23:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390305; cv=none; b=Rlq3hzDAGnqY/8w9Z/MYF0acDzqPnKIPxyjIHbOONMtGGv4ZXKbgi8BtghSvug1Iz2gxzhWz1nZReQqcF+ktpM96gAzrN8XOILKufK7SjiKXge03i3Mj+oXuUaGMEXCsF6zjHrd6n3WEJtnfMQAwNpHb6wwZM6gn3aD4mGly0W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390305; c=relaxed/simple;
	bh=INCveELf4SeONdd+Iwy6XwTvuoHRcwzhM2gnIE4HCPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HjyDc3mr7+CNXzAN/6NiIoohdfFogowkC0O94DoLqKVVlIZA7bDfpwSblt3rKCF4zrbjL1FcK7qCQFJzLfnL9uduWBE4YheR1GqkX9ef0TTvYjNz0IwvKdP36tJekS+KStHvOPxPtw+b7xiI0gP169jE0p4/a/AwSEth0VhJ7AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZP8UNAB9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZP8UNAB9"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682KVhV23367416;
	Wed, 2 Sep 2026 23:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0x/o3Zc6QpdTEblJG
	ynKrh31t8tvBf2/GZHnUyMzS1w=; b=ZP8UNAB9Z/KSZS0JcMlMvG4TAFzd7971t
	h5Z7tG3PyNNJT6PWXx0bDaRl1yAxiQP0yYWswihcmrbhOLbW/vOfDTSs3+SjTCyA
	/rqRAsVibouzvXCyuMfGWbkLBp1ngZNiGvoSFa2sCsTv+mmL6dz5reEEQo6YhMEq
	9H368K94aJkq3rZWS1JSaOd+TcRtxpHuqTKbvRXFJMtctlVOWMksOrvsGc6RKcLL
	SakuKaIwkoIxMVMQL8v0UXbz3RfFbaCiQG7BgmS1REXetWerwjOz3a1nqVEyYXsu
	KSWMa0bpl0sf5+HF2wct4G+NZIqTOmUiGNkTIbIqsV74nJDtVSt9A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rj0pg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 23:04:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682MuIjK011899;
	Wed, 2 Sep 2026 23:04:46 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjan9r8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 23:04:46 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 682N4gTw39518636
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 23:04:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A2DE20043;
	Wed,  2 Sep 2026 23:04:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9D1820040;
	Wed,  2 Sep 2026 23:04:37 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.98.186])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 23:04:37 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, stefanb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        nayna@linux.ibm.com, rnsastry@linux.ibm.com, ssrish@linux.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH v2 1/2] keys/trusted_keys: return immediately after TPM unseal failure
Date: Thu,  3 Sep 2026 04:33:04 +0530
Message-ID: <20260902230305.118931-2-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902230305.118931-1-ssrish@linux.ibm.com>
References: <20260902230305.118931-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a98ab8f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Gb-tKBqSAOq4cnd-bv4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDIwNCBTYWx0ZWRfX3F+h9PdSedCi
 U9/o1OnJNjvqq1BKuAQHhzb5Wu9JvsmsWOee944iVuITivMr+5uig0x2xPExRi6YLJPfCksWsHW
 s8d+8dA1YnYsMJwAOfQyThUGLr07f0+QcyVJ7rJEVfOaocc7qbrY45Lw0mAsBPNLBtsKfOep25r
 agr9nbrJoE0AdGdM5RFOD/2xdYEFm288XsFK89cAuYrJ2qlCWe0b5Rt0BGFwGojELsdXoR95wcS
 nkvC1VeL195Z9o0xi+gIoGDobRzS2dv4A/IJ8e4hJ+q7clHJcu6mPwbTYgeTzDkv1jmGfMxR7+D
 sJarvTIsUx5HjSs4bQpDhuyxfDqX3EQ+Hx34F0Ict5JYN917KMKPE4PaIYsh1TlGRhp2FDzxera
 DKQirs+Gq4nr/XzN/3nKyUKKFb0mK4nH/kO87Zc3nbdtkBK4fxWnlRmPAQMGJCLZBrSXRpcykif
 xL5AXrX0JUhM97HDlrw==
X-Proofpoint-GUID: KVYVSDNQZa6v4MBnJejYDIAov2lvoGQL
X-Proofpoint-ORIG-GUID: KVYVSDNQZa6v4MBnJejYDIAov2lvoGQL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDIwNCBTYWx0ZWRfX43CEAV9R1yU7
 EiW0y/h8ZOgyXQ4jU2RC/pfAnXRlzzd4K5DfFVAUROcStmILbW6+5jQHiyOogCf6E45TapywuGN
 zjGOc6ebbZOaqdBlVZrhWroXFgkl0Cw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1011
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020204

trusted_tpm_unseal() proceeds to pcrlock() when the TPM unseal operation
fails. If pcrlock() succeeds, its return value overwrites the unseal error,
causing key instantiation to succeed.

Return immediately when unseal fails to preserve the original error.

Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
Cc: stable@vger.kernel.org
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
---
 security/keys/trusted-keys/trusted_tpm1.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index bf0bf7f36970..9cdfeea800a3 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -923,8 +923,10 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
 		ret = tpm2_unseal_trusted(chip, p, options);
 	else
 		ret = key_unseal(p, options);
-	if (ret < 0)
+	if (ret < 0) {
 		pr_info("key_unseal failed (%d)\n", ret);
+		goto out;
+	}
 
 	if (options->pcrlock) {
 		ret = pcrlock(options->pcrlock);
-- 
2.53.0

