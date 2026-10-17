Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ED83BB9F7;
	Sat, 17 Oct 2026 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792262421; cv=none; b=ib1sXEuowl73+PIBwoebmdyuZ4Bm0vrzzuubHx+cQp2kttCZV8wwSywY+xRWcHlJV6zovRmz/pmfgDhiupqseilO+HsR57oLfzKDaQGqbIqleM4nnHMDrhmiEGD3QK0GQZtAvBS08K1ckWKNc6vjkMe89g8gUrjBfnN85Qpam1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792262421; c=relaxed/simple;
	bh=qdFrkCm+W8+77xsYDAo/ZIHQjh9pP40LMYpbfpAPYkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3v8izloyIV69OlsBXQYGb6gCU6XGhoADlUKuopWIblw+vy2Oco4Y8mPsVwFvaB9/Cpd9FJQCnxW2W0BNWFTUFe43o/SxyuNcMvD0APTF7gDxNpyzvUH0qVVFgZ968wl4902aWawvdH4d2gUZU6q/82VFaEZ0kOA7PZvaF0pDM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SZdqIuon; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SZdqIuon"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69HGEEqE1130574;
	Sat, 17 Oct 2026 18:40:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UwAOYK3hKGE7aM5Bs
	WRTnOVXm1lEw2FQ6v2Xm9ujK0o=; b=SZdqIuon6HODyMDnGlWi/QB1d9Gu0gsin
	f4Ax4ZRa6+fNtHjOdsErxkaswaHUQEfWhW8b3gjtd1fz7cOtcGUHfIs6YR0i7r4S
	dFGgru40Etfj2SF8xUmRi4YMCpG0b4uj5W1OwjS0YlJr1Yn+l8RVdjXpRsq3He8v
	WfiwcIefeh2zeowxjv6yx5Ye5nya7gckwwAG57ObhGTUQfTi2veO2z9oeHNC/AsC
	eLjmaZZbDH8X/4pQnEV95ORVhFvnHoIPdt5Hh8cZVE/vkXO+bKpjHCw/AmNGvNCA
	mFBQQ98JilFx0/CSmiChqmclGvn8FVaGDMz8T3jOYoKEdrGCg9kig==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0ptarwc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 18:40:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69HGJsl91277474;
	Sat, 17 Oct 2026 18:40:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hb2398uk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 18:40:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69HIe2Cc53543194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Oct 2026 18:40:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6834520040;
	Sat, 17 Oct 2026 18:40:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DAE120043;
	Sat, 17 Oct 2026 18:39:55 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.66.83])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 17 Oct 2026 18:39:54 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v4 6/9] keys/trusted_keys: clear sensitive PKWM buffers
Date: Sun, 18 Oct 2026 00:08:50 +0530
Message-ID: <20261017183853.596052-7-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017183853.596052-1-ssrish@linux.ibm.com>
References: <20261017183853.596052-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDA3MiBTYWx0ZWRfX1OOLBYrI1q1x
 Ar9RUzFkCdiZfpeuMcmA6jIN3H/4VN4wSxRD9kV68V8vlM/ghdB52be+nsx2bugx0UB8hqKRu2f
 ebXWe5MlRmThmHx8otbE3dNWLMCY9PTp9r3GoHzgvvzPLPjW6P2y/R71965db4Ncy1QYcqouiUQ
 BbkIrk2H1X3Rv+L93Ap9NMAhvygW/fmWZdAErvjgpd+HBRmw6Bjcrog9AYZVRM5+1p2Ri0ScO2V
 HmjCcoQt8vcAfHzR0Uq2CLATP+6juR40I/DN5PLdIAgBjKOgXtzg5Rt9yrv9jDqMJ9/8fu/NvaC
 4Eg3fofvkQWAXG3Ci8nay7LL4GmQb5djXwy8wa/Zcy0mLwI+5M4yEQ7E3ATB1FBMC4RVfb32Q1O
 pkOhp9VP34HNKDloS6pZyxeSG4HCZgfhGTZIc6LFm0vigCL3kO18A6vl+mOy9VYfajP3JI0yzut
 VSEMgbNCrOU49FQV/2A==
X-Authority-Analysis: v=2.4 cv=WNvqzXsR c=1 sm=1 tr=0 ts=6ad3c107 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=0K-bQ7w7VnYq07X3RDEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDA3MiBTYWx0ZWRfX3AGDdLUW/gQp
 IRU9UrK8pVFH06QD1xb+rNR3L30k+tQNTzx205f54BvbZHTFBZ17e0b07YPcWYPEnv54l99Uyjl
 wRO1W4PUbKN0NzSkNOUjsNR34Tc3qkE=
X-Proofpoint-GUID: -WqvN467Mm_wVM8-V8jb7FnuSHVpAkDo
X-Proofpoint-ORIG-GUID: KbSIVg9a_suh3cqkMcVjCVSFT4NrGGvM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170072

The input buffer to PKWM seal and the output buffer from PKWM unseal
contain plaintext trusted-key payload data. Freeing these buffers with
kfree(), without wiping the contents, can leave sensitive key material
in memory.

Use kfree_sensitive() to wipe the sensitive key material when freeing
these buffers.

Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted source")
Cc: stable@vger.kernel.org # 7.0
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Reviewed-by: Nayna Jain <nayna@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/trusted-keys/trusted_pkwm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_pkwm.c b/security/keys/trusted-keys/trusted_pkwm.c
index 7345f233eb74..b5c3d17be475 100644
--- a/security/keys/trusted-keys/trusted_pkwm.c
+++ b/security/keys/trusted-keys/trusted_pkwm.c
@@ -118,7 +118,7 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
 		pr_err("Wrapping of payload key failed: %d\n", rc);
 	}
 
-	kfree(input_buf);
+	kfree_sensitive(input_buf);
 	kfree(output_buf);
 
 out:
@@ -153,7 +153,7 @@ static int trusted_pkwm_unseal(struct trusted_key_payload *p, char *datablob)
 	}
 
 	kfree(input_buf);
-	kfree(output_buf);
+	kfree_sensitive(output_buf);
 
 	return rc;
 }
-- 
2.52.0

