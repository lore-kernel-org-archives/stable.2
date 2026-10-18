Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06364403E89;
	Sun, 18 Oct 2026 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792343399; cv=none; b=TNx7MhUbgS1uKVd5cHIcwqEIrJM37d0WA7O8wmkh94dKTdPPblZgM6gKV3UkIkfXYOz3dNQ2aHoS2UP0JcMlqYyS/iR6ZUY1td+pP2yBebpl/MpO1TTqHEd2bNijyiFJtJDngBkRbEi41jN0wVHl+fm5TNG0Z0vOfLuBMrQjKUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792343399; c=relaxed/simple;
	bh=3BML9Diq2iDrub7cVCUHA7zANQIQ6dIa5AeZEvig3qM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqXVb9gI1jr8CxoWDQ2ud5M61SrJkV3+mrQre2yyJrxqvu37qAjH9fwFqc28wrhc4cUa7j6QJFSEtCwuNvB0EQBBmpZf2sJf8RYr8fPWZURFCnWZsSAlRXc0aXfsgdS1WVkqSmSB9lHFJ3tdgJVvyRLmWdc6LLBtdKaaQD8t1O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ncQePMUR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ncQePMUR"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69IFF3si1295584;
	Sun, 18 Oct 2026 17:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jOSTDu/LPV2hnD8er
	mLoXOjRDsEmLDyWj3fpyB7Btwc=; b=ncQePMURka/Kh+eEy3BK2xjbM8NC4HBj1
	Z0ajk+Zx0MwMaxo+d4H88YYRy/4VHr6CsQG77wZeUOuLufm1z4yvCMlbAMv5PKpJ
	ZLdCRkX/w5yn/jAupu7dnb8w0iEBFAwn6Ybp8yg/xqiY6wQ3PPMlLkNuxJA2GjCi
	S8Of8Kl80PzZOBFsAKjbBWcHtIOc+jdlmlz/IYCCGAdcHWzOgHtBybQqF1thFKiY
	KTtWB2bo/8x0rFGl6lcHcdgxcP/xy9FpGi4UYRWYCy1I3jCwOobwpnUjioPRfWN2
	EicFOUl9eQxWu/hJoHNeD6LEHYU3qG3ZBAel8LJmHKI/HfZHONs2g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0r7ep1g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 18 Oct 2026 17:09:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69IFYm0S2728115;
	Sun, 18 Oct 2026 17:09:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hckqva9pg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Oct 2026 17:09:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69IH9dag39911888
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 18 Oct 2026 17:09:39 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 194C220043;
	Sun, 18 Oct 2026 17:09:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29C2420040;
	Sun, 18 Oct 2026 17:09:31 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.125.165])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 18 Oct 2026 17:09:30 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v5 4/9] keys/trusted_keys: propagate wrapping key generation errors
Date: Sun, 18 Oct 2026 22:38:39 +0530
Message-ID: <20261018170844.491252-5-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018170844.491252-1-ssrish@linux.ibm.com>
References: <20261018170844.491252-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA2NiBTYWx0ZWRfX8q9CNpFAV8ur
 yj2/smJ/tEDcEg5HKvs+RZEcJkk4aUnZP/IOk3W2qvI8QejYWN3Yiz6HCceqWir5e0SR6aEyIS4
 6zqzy/M81Wp4L9J8PjeTBa1VuJkqVpI=
X-Authority-Analysis: v=2.4 cv=PrUG/AM3 c=1 sm=1 tr=0 ts=6ad4fd58 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=sFUY0Dm8-Bub5huaTLsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA2NiBTYWx0ZWRfX8DZFHfxOZ2Ds
 sZYXlQyKR84DSYsLJGv3g81DzuWlkW3rdMkARehrvn0n0qSqoVsdtF9flx7tL0b9p6DGuTiHB01
 IfrdHcxOBDxkv37RmMZmnanO/pwv/xrUviDndilS43PxC8Gl7UJdvyBk8HSvF+cP3nEQn/14bBG
 bZUsGe9JOPXJSoYt9RpDOEEsX1oJIxhUAnqRh5VrcUPw6OZTgXn+m2ch0D2sCorBw6lLOKzjgTk
 LMibFxd43NAQC4mEEMZguvFnXiNIGnv8aMzScp0VgRsO3piierSP3ZgPP/56jtsStpIzQlQB2Ux
 T01ajRExcfw45WXp5Jk4IE7sAXtXHbMf5DxnqnHOsfq72GbeaMANLAspnbjlE7YDhgVh68+NiiR
 s5EE/Cz+z/QeKK2eq2awEFtgg0JOwHg6VQrDLh/mhcueuMDCnPC2/fwIfUsEeuScF9+He8AVanW
 VfwqzZWhIj1m+JTvKBg==
X-Proofpoint-GUID: u2lyCvo9vtmdwdoUSzGznFb6o1M3bcpb
X-Proofpoint-ORIG-GUID: 7ZUgzm6nJCh0fEGHvSCApWjhJzYHoV4l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610180066

plpks_gen_wrapping_key() returns a negative errno when default wrapping key
generation fails. However, trusted_pkwm_init() returns -EINVAL for all such
failures, discarding the original error.

Propagate the error returned by plpks_gen_wrapping_key() unchanged.

Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted source")
Cc: stable@vger.kernel.org # 7.0
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
---
 security/keys/trusted-keys/trusted_pkwm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/trusted-keys/trusted_pkwm.c b/security/keys/trusted-keys/trusted_pkwm.c
index b6b5697426a8..633a7674d065 100644
--- a/security/keys/trusted-keys/trusted_pkwm.c
+++ b/security/keys/trusted-keys/trusted_pkwm.c
@@ -170,7 +170,7 @@ static int trusted_pkwm_init(void)
 	ret = plpks_gen_wrapping_key();
 	if (ret) {
 		pr_err("Failed to generate default wrapping key\n");
-		return -EINVAL;
+		return ret;
 	}
 
 	return register_key_type(&key_type_trusted);
-- 
2.52.0

