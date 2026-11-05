Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889863;
	b=gwJMEp65hVVlamRChTTXsbQ/HXiX+diuQmG3Bxdc8DpitAHDzlaUCeI26WCEOFTvoGDM
	 fmV4lX1vmmglQQcDI83B/EZQpZc00GFw16MoN+3olq+zbPmqnkRpkOBECT1bgjnRfCeNh
	 qTJcxAXGi1cqolJLsXVefPr+WmUy0koAavwnowbacl/b5SdM5FOBLE1SPai1TxFiNYfRq
	 ssln0nuAyumKZAogR2tF/Y9/j4LEgKfUjG4mr+xfDdnhLWSIm3GAeLttflVvX3Nmp0ezR
	 ws5OrXTR44NiIt50ibVktif4tSflAacaJ8xfVzi+T4feoH7xu1JaNhuDxGf85SWWRLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889863;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=15CaoeMqGmAOyNmafrq9kSwORnBqUlaquzxQWorG7kw=;
	b=4fvzMz+G7IxvHm7ZP39NQ3xlv4/HwDU/FzlkQQ2D2KqT2xU9hJDwSvj5Uo++OEYdm4AL
	 EbS4yjVqg19Ji7RQrXOffA8uShEeBxY8azC3imV8OiCrHYqfuIyUMpgS5M3gAaZ5NbVYZ
	 wods84hZQXiK6JdZ5jU35n/HkprMD/Aw7hbYISjUz5nNNQtRo7UQnBMhVOUnQIeigj7aq
	 iGAMIltB+p3JJ7kV9lZlLOkqT3Eub6wLF1EdjvPPiYXq7prpZbOIC/aHj4q99JCJO16Gg
	 8RQ6LO4a4NEO+WfOLVhX7wbKGh9/M9bstj6pNHNkGlbRj8sf+4pgNxrmh1oICrPSLYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jNfKmHx7;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C373E606A335;
	Thu,  5 Nov 2026 14:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C373E606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jNfKmHx7
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5AEWjX2060111;
	Thu, 5 Nov 2026 14:44:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=15CaoeMqGmAOyNmaf
	rq9kSwORnBqUlaquzxQWorG7kw=; b=jNfKmHx7xyUMKvDJohcf6S5OTQradJ8Z+
	LlppMd2SGC3vf6x5eoCteRvoISfI2tVuQWptU7xFo9cqBXFaqHrUgguUj2RS0vMl
	jfPzJUW2TNMyS2X52EzO+y+W5QMySntpZFulpioYUDJvYAcpO437C2jDJKASPzdS
	JjMDyPAKCY1rBkBDztIpm8zTxiJ5fYJUuFI7hGR3ygDoknIrLJFNTJpUORjjuqzP
	032cBHHhfjXlhxY9Y1O6Go2EA+bmuUMGYzIkX3DD1lGkmk4+0tbr93nPVMCy+5KY
	W4tShLiezA9peaktVwMhYaWdvu3l7/LuhIyKuJ0sVe0xyaOwspSeA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn6rdjfbg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 14:44:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EZ1pM595052;
	Thu, 5 Nov 2026 14:44:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqsf5h3n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 14:44:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5Ei4Mg48890218
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 14:44:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18D332005A;
	Thu,  5 Nov 2026 14:44:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B62C62004B;
	Thu,  5 Nov 2026 14:43:57 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.70.234])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Nov 2026 14:43:57 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v6 4/9] pseries/plpks: fix double conversion of write and remove flush errors
Date: Thu,  5 Nov 2026 20:13:15 +0530
Message-ID: <20261105144320.357260-5-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105144320.357260-1-ssrish@linux.ibm.com>
References: <20261105144320.357260-1-ssrish@linux.ibm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: q32pR6ebaqElRkCM-zBnJX1LRa1dtz2T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1OCBTYWx0ZWRfX7Rrr3ZbC82VM
 DLlZpFTeJXcCkexpEdKjaJSfS3hGTN1eLZakZCXeMIPBGOXvA2gZ6hdxKiICayD+jVGm24zGlLR
 LK73FtOnSzXi0ysUI0rMNb0FejmX2oYr4X59R2RHyKrWPpcnjiOhVFAhPtAONIOxvKtfAaT5SxA
 tcsNGbffeL+gopzviu0M5r3QuoW51QtEuMB63ByKPq+BosvcTAFibnrLcL4ugZ9fNMGXystLOx4
 HrP+206zRaB7C9ts6xfsjGfYCYp7iR4p3R06/2xXmu4htgXSBmou+LzaBaDWf9AYqxq4vj7Y1WR
 u21s7u1oQHNczBlEVZFs7T9p/Ie43SVzrFYNEb4aMaO3hXwjXdTRJwJh3qJz9LZn9fqdJM4sm61
 f651ikMP2wBuNQVLNQCo65chKJGToU061UWmBzZTEGIVpk69vM91cqVTvJuAY6Btbx9Mgdma65E
 6f50oMaWNddSq53pdWw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1OCBTYWx0ZWRfXw9vh14N4HLds
 c2XJstv4/viq+as9YsDP7BMWuP/TrSgaoiHuc47e62FSkdwLjRpTthlEhLxwVB/MNRzllTdKwCv
 R16BMkmSnfej+kxCHZyY5TRcxY2dSZk=
X-Authority-Analysis: v=2.4 cv=QK391QLL c=1 sm=1 tr=0 ts=6aec9639 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=sSQUMTUHIeIGjBFKCPwA:9
X-Proofpoint-ORIG-GUID: ai6wXCz0H5obqWT2qy-DueF-_kdKyhoD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050058

plpks_confirm_object_flushed() returns zero or a negative Linux errno.
However, plpks_write_var() and plpks_remove_var() pass this return value
through pseries_status_to_err(), which treats it as a raw hypervisor status
and converts it again.

Convert only errors returned by the write and remove HCALLs, and propagate
errors from plpks_confirm_object_flushed() unchanged.

Fixes: 2454a7af0f2a ("powerpc/pseries: define driver for Platform KeyStore")
Cc: stable@vger.kernel.org # 6.0
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/plpks.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index 240cd5632446..110251914b51 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -714,6 +714,7 @@ int plpks_signed_update_var(struct plpks_var *var, u64 flags)
  * -ENOMEM	if unable to store the requested object in the space available
  * -EBUSY	if unable to handle the request
  * -EEXIST	if the object label already exists
+ * -ETIMEDOUT	if the object was not flushed to storage in time
  *
  * Returns: On success 0 is returned, a negative errno if not.
  */
@@ -750,8 +751,9 @@ int plpks_write_var(struct plpks_var var)
 
 	if (!rc)
 		rc = plpks_confirm_object_flushed(label, auth);
+	else
+		rc = pseries_status_to_err(rc);
 
-	rc = pseries_status_to_err(rc);
 	kfree(label);
 out:
 	kfree_sensitive(auth);
@@ -780,6 +782,7 @@ int plpks_write_var(struct plpks_var var)
  * -EPERM	if access is denied
  * -ENOENT	if the requested object was not found
  * -EBUSY	if unable to handle the request
+ * -ETIMEDOUT	if the object was not flushed to storage in time
  *
  * Returns: On success 0 is returned, a negative errno if not.
  */
@@ -808,8 +811,9 @@ int plpks_remove_var(char *component, u8 varos, struct plpks_var_name vname)
 
 	if (!rc)
 		rc = plpks_confirm_object_flushed(label, auth);
+	else
+		rc = pseries_status_to_err(rc);
 
-	rc = pseries_status_to_err(rc);
 	kfree(label);
 out:
 	kfree_sensitive(auth);
-- 
2.52.0

