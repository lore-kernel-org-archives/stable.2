Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECF43D3339;
	Thu, 10 Sep 2026 07:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789026809; cv=none; b=OiIbuGgj2kl7WS2pclk+33PBSilxWYjeNAC7ja8R0pHjKp7a6dN4sO/jikNr9KJ0dRHBthRkg11ds9Gd/mt8b/fmHmKDFtDKx3C+k8LtISrzIxgUlOtamOltSdAGs76yTMogVilZHNmDchoAon4PK3oC+GSO8Zk9zleCTA3CD/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789026809; c=relaxed/simple;
	bh=VWliHbAyNsfQkTLue9pckqYn2hIoO3+6LJlxdUoTPaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VkG1FmJa5/lnMZLxVwrVKMdVs7NQwIxkxMgK08YrT+VVJX+w3lw27qvMGjmb93978myq+uQH1nYUxDvwEevgSsZDRacSExvBiuzv18+gkMaP4Vypd44+1B/OBnphECdv49JL4TDsKEfi6zbeoNQ7wT3cVababG/Ep3Vp3u8Qhmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jvB+RFz2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jvB+RFz2"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5Ve8m1973909;
	Thu, 10 Sep 2026 07:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lVQVUZ0Ep4SayKCfM
	+/Hw8LgKHBJ2yc3PzwStLnYwVQ=; b=jvB+RFz2SRvAc0V6TwPLVgAuepaMAqyA9
	ERktgk9TbfyDxPqwqGGSVmLitYFITtq0sHqw4HkkTGQmzEOmpfIoYEWnbQVz8kCw
	/AfNCa2xCfxTYaGYed1Tui2hivnl/oQ260J2OJycgFIDiTNsC3SCFrfBWrVpzhau
	XIyEBWGA/UyWy9FaqY6MZgE4RWzRAFXOoRZtDo71PLrSS0aHzuCvCiMmFD5Eq5o7
	MOVin/JdzLtXP28sUq3O2RNTIAkkyat9dIbY2MfOlzIG2Jlf5zCi7kSJvQ7l7ppD
	NGdskS6ZQ1pDkyVk0WNdPzkCg4AP6fM459Qn4sdOd0mxBcrrzE1iA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8pk4w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 07:53:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 68A7fQgW016952;
	Thu, 10 Sep 2026 07:53:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gkcr33694-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 07:53:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68A7rLap43254190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Sep 2026 07:53:21 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E95582004B;
	Thu, 10 Sep 2026 07:53:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F04B720049;
	Thu, 10 Sep 2026 07:53:17 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.bl1-in.ibm.com (unknown [9.123.14.23])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Sep 2026 07:53:17 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, stefanb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        nayna@linux.ibm.com, rnsastry@linux.ibm.com, ssrish@linux.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH v3 1/2] keys/trusted_keys: return immediately after TPM unseal failure
Date: Thu, 10 Sep 2026 13:22:31 +0530
Message-ID: <20260910075232.178855-2-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910075232.178855-1-ssrish@linux.ibm.com>
References: <20260910075232.178855-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=eM2GH3p1 c=1 sm=1 tr=0 ts=6aa261f5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Gb-tKBqSAOq4cnd-bv4A:9
X-Proofpoint-ORIG-GUID: W4rNDHD9n96vMXGGrJCraWHdre9UZai-
X-Proofpoint-GUID: W4rNDHD9n96vMXGGrJCraWHdre9UZai-
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA4MSBTYWx0ZWRfXwgxHNo5wYSox
 +hHgx3HU9ZZRwLZkYIHLC4iPbq0fYxDlBYdGrca7YFQfMjNMCCzzGkue/2tJMWHR/6I/oBKMQpJ
 GYW5ZFx1aZ0O7yrKDA7xUfhEK+yuvYU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA4MSBTYWx0ZWRfX6tstTj+ScFn+
 Yh+ahFlo8Jc2mgp8DeArRiivwBG/HittagYJODfvPCMNQWV2KoUfiLY94ey+/T0rHP504+YiQm5
 p9bVqi2bs+7mMhdcUQp+oSdR1bPYpalYfuAHAwR1n2J/mv5jA41y/yuFq+Rv+bfvSvtH/Siu9G+
 DpQkYz83h3U2uwcV4UfL7ARkNiCvhXKX2oISkwouelED2ing1nCNb64igsoQN4gUJPeKquBxEtC
 KpvRYRRDuC8HizMzfsnp0+69rRR6p1L+ejkyULTjCbir7PSvUKnguaJIdaBsQ239Jqyj+3oW/hW
 FY7ugul2YrwjIOsD2tLnJaoA/htgssjJXQVk6LXv87od5ZjYbh/79tR7Jj4H++qnolmpR3snNCi
 cKE7dTMILJ0biv68UqnvJyRNzAxGreP9B3+bqk2yGguhEwv7lvxbG7a60Bq9Rw1TjRcDoiMz5LR
 iTtjIv1b0C86Ti8WjNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100081

trusted_tpm_unseal() proceeds to pcrlock() when the TPM unseal operation
fails. If pcrlock() succeeds, its return value overwrites the unseal error,
causing key instantiation to succeed.

Return immediately when unseal fails to preserve the original error.

Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
Cc: stable@vger.kernel.org
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
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

