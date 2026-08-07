Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F45392C34
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786121875; cv=none; b=AcSVXExIRWMAr4K/0BTqQ2qfjj+zkEaRJmxTS9CgEYEus4ZoZ2CxzWcS7vXd80FV4N78Apf3W01te7csFFKtm1snWEInATAGOAnD0d5U7LiU700tx72VRmCNfuupXqdzMYS3fpfBveaoCvuyy/bi55JjD8IibesDput3nzlOKY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786121875; c=relaxed/simple;
	bh=BwNym7S379Vdi8jIvSKLykzyD9Z2UKmbgrjHI0zl40U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qLYUpg25ZY9fLGOsrTYrHoWLvI+uvvM6rYSyvTQU/9ti6jdLvMXlKIIHlaAHBmnI28YlAZtiNUzRFra7/NEv4nKY7K7DbwmIt5iPLScK1w4LmZ0f0ZqalGJtJzbIekjrhTDVogjlaw4WMoqWgkNZcemK0uW4Z+D/KPZMKD5Ga9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a4nntxlf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a4nntxlf"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677GmAT91929310;
	Fri, 7 Aug 2026 16:57:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=HEehugBrKXC+nPPwRbkxanoKLWwW7pNizAB21fVAm
	pk=; b=a4nntxlf0YShKsg2VvV2G+KkkTeCr0bTQEGbwMefzEt3w3YfhiDieE/Xi
	dMjesuJdaLj8YjRqjn4DNxMAtSUs+B6zxaDGnmWc+amWpJnsP+5UR1VM2m/3A0Yt
	JTPnkyDDSRV8BWCnyJfVIkFqT0rW/qgGVo6GuIwpeYTHjVjaqXze9+l29U2MZksP
	b1WmZNkLMEK3WClnx/quRkPJCQ1R6FRx7wxgYS7v8lF7vv1DqLwDfeQ4TuDNdhmz
	OcEu/9Fvw1XKq1Th5WWcJBintkOvFC5XKVzdJ8Vi19ebvxEBiePzlB3mVoP6kRw/
	nK+jAh+BA2tGJBj0sUE06uQzX3p4A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy02ct54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 16:57:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677GuSLa002884;
	Fri, 7 Aug 2026 16:57:47 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugwgmfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 16:57:47 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677Gvj9R38797914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 16:57:46 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D8C6A5805C;
	Fri,  7 Aug 2026 16:57:45 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACDA15805A;
	Fri,  7 Aug 2026 16:57:45 +0000 (GMT)
Received: from ltcd41-lp6.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  7 Aug 2026 16:57:45 +0000 (GMT)
Received: (from gcwilson@localhost)
	by ltcd41-lp6.ltc.tadn.ibm.com (8.16.1/8.16.1/Submit) id 677GwHjd038779;
	Fri, 7 Aug 2026 11:58:17 -0500
X-Authentication-Warning: ltcd41-lp6.ltc.tadn.ibm.com: gcwilson set sender to gcwilson@linux.ibm.com using -f
From: George Wilson <gcwilson@linux.ibm.com>
To: "Madhavan Srinivasan" <maddy@linux.ibm.com>
Cc: security@kernel.org, George Wilson <gcwilson@linux.ibm.com>,
        Haren Myneni <haren@linux.ibm.com>, Nayna Jain <nayna@linux.ibm.com>,
        R Nageswara Sastry <rnsastry@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH] powerpc/pseries: papr-phy-attest - validate cmd.length, plug mem leak
Date: Fri,  7 Aug 2026 11:56:21 -0500
Message-ID: <20260807165621.38765-1-gcwilson@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G6ws1dk5 c=1 sm=1 tr=0 ts=6a760e8b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=JnY3h8uHB8_D2nh96v8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEzMSBTYWx0ZWRfX/bNP1kwl7s/k
 CmWz6jLZh8uqDU0OxhlccYXNQ86CkNoGGrEIB92x+tbZw184e0PM2Y2kfTe61cdAQR5xhMf2eXg
 T5Hj+4zDtfLaDA8jly1BJuFYve19L0JvC7n6pSLSYueJVRE5c6gSHDFOY47m2tMEei+fjsTEh/b
 AI0zxtIg6ULi76u1aUAz7r6u848pm+l1Qh3XAS2qNPu2Ua0FeB/vs2ivGmUfabLCsK9qFTrVhC1
 k8qJ8Yn1DcyEoDDQJOkRe4pOk1td1y3dyxF4Puv2ZlZl0IIme9UMqqk/lkrijzxjvRbAkK7/cjq
 7oFf7mfjlnn5JMF+HD11j8XUonvzBuUFz4WDwxNKdWUW6x4beqm04hTafA3nY2K2okYIX66m88I
 6fC4Ay11XqBaqNQiEgbiAf7z510jvU759+D/z/2BubULZKbL2x69AufKCEXSXoe+hsd0TcJtwK1
 tigiRw9QfLtozXYYt1Q==
X-Proofpoint-ORIG-GUID: dJeiuhSbeocZ5-xUBxzxzxfLfjssBKwv
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEzMSBTYWx0ZWRfX0hewgxFSGpso
 TFOSQ+3AnHJtDNTKiiyWsM8pfFEl7n8e543xdJDyHx5lA72LrP3Ahfvf7H+HTFvJdQypzsBk+vx
 JDTvn2ul7p9TxhmUzkkRsgdJvJ2GALQ=
X-Proofpoint-GUID: dJeiuhSbeocZ5-xUBxzxzxfLfjssBKwv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070131

In papr_phy_attest_create_handle(), the params->cmd.length is not
validated before use, which can result in a buffer overlow.  Check it and
return -EINVAL if it is either 0 or exceeds sizeof(params->cmd).

Also, params is freed on the success path but not error. Free it on
errors after memory allocation.  And free it on negative fd.

Fixes: 86900ab620a4 ("powerpc/pseries: Add a char driver for physical-attestation RTAS")
Acked-by: Haren Myneni <haren@linux.ibm.com>
Acked-by: Nayna Jain <nayna@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
Cc: stable@vger.kernel.org # 6.16
Signed-off-by: George Wilson <gcwilson@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/papr-phy-attest.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/papr-phy-attest.c b/arch/powerpc/platforms/pseries/papr-phy-attest.c
index 20a0e1581302..350ba26e5962 100644
--- a/arch/powerpc/platforms/pseries/papr-phy-attest.c
+++ b/arch/powerpc/platforms/pseries/papr-phy-attest.c
@@ -230,10 +230,17 @@ static long papr_phy_attest_create_handle(struct papr_phy_attest_io_block __user
 		return -ENOMEM;
 
 	if (copy_from_user(&params->cmd, ulc,
-			sizeof(struct papr_phy_attest_io_block)))
+			sizeof(struct papr_phy_attest_io_block))) {
+		kfree(params);
 		return -EFAULT;
+	}
 
 	params->cmd_len = be32_to_cpu(params->cmd.length);
+	if (params->cmd_len == 0 || params->cmd_len > sizeof(params->cmd)) {
+		kfree(params);
+		return -EINVAL;
+	}
+
 	seq = (struct papr_rtas_sequence) {
 		.begin = phy_attest_sequence_begin,
 		.end = phy_attest_sequence_end,
@@ -246,6 +253,9 @@ static long papr_phy_attest_create_handle(struct papr_phy_attest_io_block __user
 			&papr_phy_attest_handle_ops,
 			"[papr-physical-attestation]");
 
+	if (fd < 0)
+		kfree(params);
+
 	return fd;
 }
 
-- 
2.47.3

