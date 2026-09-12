Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D83E372EF0;
	Sat, 12 Sep 2026 06:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789194624; cv=none; b=Zkc/9h3WUy2CalnBHN19YiyzdkJRKGZPK5jF1rbBuLXquXdHoGEfz/Ys7d8suyKI3FbokFS1cyPukSlKyxxAm1N/qGkfAhnWDDvN6uth0onABci8zV6J910z9v16HP7zvSWx4XHPo5vlO7GO91cyglFSOH0/bc6WCAxoVRp1RZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789194624; c=relaxed/simple;
	bh=VWliHbAyNsfQkTLue9pckqYn2hIoO3+6LJlxdUoTPaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pl61y9MZwFv3W4R85MQpNIQ3w6lq/MEHWWmkmdaoRQNBGzVjwVQSB/v6JCum2iTf/JOLLk485fRnvMYZ1SrPLhWxCXOgGu4EgJXci8hPtHCrz1fTQt5apfwECIbuhtwil8pQluTFcQaKl1Ys6XK6GoPY/zBsVrweV8YhJt0/JUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OgqGdeMF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OgqGdeMF"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68C4Y2oP2614431;
	Sat, 12 Sep 2026 06:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lVQVUZ0Ep4SayKCfM
	+/Hw8LgKHBJ2yc3PzwStLnYwVQ=; b=OgqGdeMFPjyvHmKwsmRtXs0EBxTOrcBWo
	rdbaBO1of2GUJtwxOZdlvkxaYNU85fzBf8Y2tFVm4yHaPcEpY1WUsM5uDGVddex2
	pelTMwLXEK/206laV3PerOsLwP6LAMc9KVdkjDN6fKsDwv/CIlOKvlYZQ1HruTOV
	CiXvFmMZtiD99MalXKMMLj3TUofEUQV866unV0rSOsamEwPMSvBbt3ICQ7cDNuCF
	B4hHLbpT8acWxZb6sw4OCxU4O32nZq0FQmRzzjF0RRxqrltRqOFngP4Pz+7HaSGr
	UFOJUK8dpq0+byPIjO2SGZFg+dbtrvyueYrzsEG15WXU8rhyVYx0A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5dgnjq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 12 Sep 2026 06:30:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68C4Z8RL2786998;
	Sat, 12 Sep 2026 06:30:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvtfj7em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Sep 2026 06:30:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68C6UF6345809964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Sep 2026 06:30:15 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F5782004B;
	Sat, 12 Sep 2026 06:30:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C274620040;
	Sat, 12 Sep 2026 06:30:09 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.123.78])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 12 Sep 2026 06:30:09 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, stefanb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        nayna@linux.ibm.com, rnsastry@linux.ibm.com, ssrish@linux.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH v9 1/2] keys/trusted_keys: return immediately after TPM unseal failure
Date: Sat, 12 Sep 2026 11:59:49 +0530
Message-ID: <20260912062950.279104-2-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912062950.279104-1-ssrish@linux.ibm.com>
References: <20260912062950.279104-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDA4NCBTYWx0ZWRfX2Kerm9f7Hiqs
 hg1DPj9GmPlCmJJU+EhOj8dY27h74oca6B4sUaR+6s2YGTjsO7P61hS5wNpdx//XmZ/Dh1owCQU
 CWptxC76U7WLKaVuFAQgswaNnmbbkyhXxeFJzuO4cPXvpKvan4swJ/sT6/NzgPcsUNxYBszHlZw
 xCchDB+Gj2go04VGVtpAgDEYo4uomzqAtJn2iUCDrYFYkFj3K/7BUanVKD0VnKfpHgEpXi5p02o
 N4X2Qx2GXtmOZpFXXfNgmgSjLiyHOYIpmsdme+UqPD9RS3h6b4hJSVhjjZuFdN31NU/17moeXW5
 7v5QAq9RUQNLA298B2zw3G4rbj8xt+MhnGc8njUm4kv7yhwWntEKkNFQGpGqq8pma8aZ0YMSu77
 9mR7oGTooa60KClhPa6HYYTgs7NYGjEB3PvaNz7qGAUB0QvUIP9N9rPeDgJYHl4KwZIDpXtKiSE
 DBhob0Ti9Q77p+xIReg==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aa4f17b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Gb-tKBqSAOq4cnd-bv4A:9
X-Proofpoint-ORIG-GUID: v7k1jPmYfv3oHHOkgmA7XbiUSgcHLQ3z
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDA4NCBTYWx0ZWRfXz7DHrA7Z4qI+
 zFXQwePFg8nuW/wk7e78z8dxvXV9K1gFGhObBLRIx7mzaAQzFb+XO1tm1anh4RXs4f3he+K8Qf3
 ycBduW7FxKsd2LQdeglv3vo+IpPGdWE=
X-Proofpoint-GUID: v7k1jPmYfv3oHHOkgmA7XbiUSgcHLQ3z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_02,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609120084

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

