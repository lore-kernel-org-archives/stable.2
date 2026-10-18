Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7342E3D45C1;
	Sun, 18 Oct 2026 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792343412; cv=none; b=SNORlKjjRNDAtD0EK1YPiGQ5b85fffJR6L9j0ET749zY5DlF0d/1pWvtJU3ElioL/1zxrSIFHFjfM0Wtz+H91nRxJDhm3vJL2cPV5GB91GvVL19Xf4QJjMh074rhGlMuHPLI9Jebv/Gy/4n/c8t+EV8E25njvIB7NY0Ck/0MScQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792343412; c=relaxed/simple;
	bh=XPD58GlAsFfZbWJkx8VtHr4vkQnqDpIPJIA4qCcwo/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrLAMYo6Cnkod6f40diIEBeFtNIBZOIoV6hta5kQemvdp7urL+BGnj8vYADAWaHE95w7qBJLpbUZcVuoR8UWzuj1DAFefHo0VloFKB9PTc4XbOtO6GXjga/thuXu0Jdasozt/f5IH577mUPBKaiD+NPu1Owx/ijFykDRXqq728c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A6FmOQcY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A6FmOQcY"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69IFF3jJ1211885;
	Sun, 18 Oct 2026 17:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AkubgfKKCqmlBjsLO
	Pi74HWrQsSj7O0vEuZUA4HCxyg=; b=A6FmOQcYly34hnyT2CNoKpyM/6yuus58g
	w+/zdzhVd8bxHkOulqprSnqZDdvRocRMLrs4aSWO4mOmxaCXOu/IpS0jyT1NF5ZG
	GNMNmEYINMxSINy5qulHXmL2FJ0PEKPEAjOkwS4D7ZFVr2TQKopxPUKMmebSA/s6
	8ImMfFRYq8/0HcXD0JPL+QW5n4q3nBlB/eS4wKAUzCY26XZ+Thby51qOF/CHCWXw
	W6B/Qa6A64UWQQ5JoOtPIWeq8vWc0X0uIbVqnhA4DFYEvEComPNKZlTm0IRKqr5M
	3cD8oqgZBnq9gRWcmlWWU2COwNoZ4NJpElv85kxKmNlrwRZtVjYtg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hbxehpfuu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 18 Oct 2026 17:09:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69IFJun82693219;
	Sun, 18 Oct 2026 17:09:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hcmbjt6dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Oct 2026 17:09:55 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69IH9q5t14614906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 18 Oct 2026 17:09:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 016CD20043;
	Sun, 18 Oct 2026 17:09:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 684B120040;
	Sun, 18 Oct 2026 17:09:41 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.125.165])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 18 Oct 2026 17:09:40 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v5 5/9] keys/trusted_keys: fix PKWM output buffer cleanup
Date: Sun, 18 Oct 2026 22:38:40 +0530
Message-ID: <20261018170844.491252-6-ssrish@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA2NiBTYWx0ZWRfX0odOGAP3T/tP
 uKscYaRKkkZ5ogC50/IJ4tnMSNEz8sPN2OsB7uV3KdcuWEqBv47hDcJhOpnx/lrLgzBd6vsNFbo
 FYBsUzm2IV8frlmD/FGFyiQmPiVTtOl/l6EHqhxy2Zg5ZWNbpvf5SjO7ihhFbceHtprzOvc3etD
 jrxh5q0x+s+rk+k6map447vi0oAs6DBvg7iAoucvz5Bnb/EOTKV3tH6NF5zY4g3E3E2QdES1iSy
 ZDxRvkf/rQwdp0FSwdNYzzUq3G3Dw1maTr72qM9y0KfTlzbxWrP4qSKESIDz7hSXfPyqVjMPY74
 nWxb8csLC4p4ncTYW1ghqkboEqLwem+FjJENh6hrPohj8j72XpUuIp8YI41tAA2YPT+pmkWJ6zJ
 8Xce1fkRFvpHhpi89VsvHESzFvFBV/MANIti/Dt50CPKAnKhVM96ESLAT9tGxHRhy9Xxz/w/8VY
 HbNTKCpMzAQ0lEaVs9Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA2NiBTYWx0ZWRfX3YlJ6fNo4Y0J
 Wuv2uOYBZTX8DEpTxjO0WvNWg/ctaQxu363duHmSl/B1faZxavQ61u+IuLDtsQosIR+x6/bbzei
 G2RvdOuqzGnl194NulOm0f6USkP1NG4=
X-Proofpoint-GUID: axJnESSH2s39coSJyT42-d4LDngFsKH2
X-Proofpoint-ORIG-GUID: H9nP0TTcpqaer5e7LTmqYmIg8Bfqj097
X-Authority-Analysis: v=2.4 cv=OZQNnRTY c=1 sm=1 tr=0 ts=6ad4fd65 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=0K-bQ7w7VnYq07X3RDEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610180066

The PKWM seal and unseal paths unconditionally free their output buffers,
but the PLPKS helpers can return without initializing those pointers.

Initialize the output buffer pointers to NULL to make cleanup safe on early
failure paths.

Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted source")
Cc: stable@vger.kernel.org # 7.0
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
---
 security/keys/trusted-keys/trusted_pkwm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_pkwm.c b/security/keys/trusted-keys/trusted_pkwm.c
index 633a7674d065..7345f233eb74 100644
--- a/security/keys/trusted-keys/trusted_pkwm.c
+++ b/security/keys/trusted-keys/trusted_pkwm.c
@@ -82,7 +82,7 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
 {
 	struct trusted_key_options *options = NULL;
 	struct trusted_pkwm_options *pkwm = NULL;
-	u8 *input_buf, *output_buf;
+	u8 *input_buf, *output_buf = NULL;
 	u64 output_len, input_len;
 	int rc;
 
@@ -129,7 +129,7 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
 
 static int trusted_pkwm_unseal(struct trusted_key_payload *p, char *datablob)
 {
-	u8 *input_buf, *output_buf;
+	u8 *input_buf, *output_buf = NULL;
 	u64 input_len, output_len;
 	int rc;
 
-- 
2.52.0

