Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F3A3DAAAB;
	Sun, 18 Oct 2026 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792343372; cv=none; b=aT76DsPxZhwIjUfDX+kN87OFHKZupzrIZspedh7P1pqkfDPGv8hSeNEtEN/A5r+3AtQQGZrxCOwg7nDp9PXNJdfOKHqKkN/Cimgtd0pkhTXZOPWg6yG+vuGskplPrmxwJI6YdQGlWsW3Q+fzdhUkYYV5wj56LV3/xti2J5j7I7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792343372; c=relaxed/simple;
	bh=Z05sb3Nd53Khkf3RVSbd7u60rrrVIPx0BeDT4RF+Zck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEIofHGgJ5uWS7uX+AKysGax15jyp0zHlazYyg0vPQR9r/KEUVKLx0zkPnhvR5O3XLCYMnSl8VaGTiQ8yZc6MKANYXQWGof8PvAwfjtjswAe1iMnYYPOFJxhLctFReOJpcuwagmOgeMrSAKlKNtcY84Pz6VJU0es654W+6TFrpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hTnukrw+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hTnukrw+"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69IFECDl1409404;
	Sun, 18 Oct 2026 17:09:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KTLDFca2RUZggMNob
	4Mpw36J0eNj2WkttT/RfqgV0xo=; b=hTnukrw+KgL0XWdIWuRmLjhfj1OLNTDNF
	XzzM0q8nTH5yl6CZqCLghCbFB9eElwWYq0xQIlglSKKPxQzW/ljMejl8BwW/1KAK
	zu8KGFgRzByixRbn/w1FITHA1LgalBnkkYUN0ZPnI2zycJoOIeKoORO2gOIVdmnb
	wp+At2Ah98yYQZwP8H7Jpinvwqi3UaCvS6EY2aLjngjcS+Tt37NoUgA/IDBY5b6y
	w7ZP3RBxW0D3jywZdjduQ20XWMTFo443n3jU6KXLOH+s2viSWOIVYH9aqZ6uTsOD
	iLSWf6a3gMEVN3ObPTSvkyNvTHXIgY3Bu4HMFGE4D2TPzkVqjMdHA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0h56qjf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 18 Oct 2026 17:09:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69IFK3RM2693457;
	Sun, 18 Oct 2026 17:09:13 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hcmbjt6be-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 Oct 2026 17:09:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69IH992P45613390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 18 Oct 2026 17:09:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CCAC20043;
	Sun, 18 Oct 2026 17:09:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4960C20040;
	Sun, 18 Oct 2026 17:08:59 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.125.165])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 18 Oct 2026 17:08:58 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v5 1/9] pseries/plpks: fix double conversion of write and remove flush errors
Date: Sun, 18 Oct 2026 22:38:36 +0530
Message-ID: <20261018170844.491252-2-ssrish@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE4MDA2NiBTYWx0ZWRfX1ICl1GETBOcL
 mlkHvp5QrJhB7fM4z0kaEa5Q0j9A15v2LKQLi9E6ZoOd0omTxUVJ/wsB+IHfYCEPWQYwTCz7YQS
 09YnYjsmZ8+WJeEI8BMO+SwbK5KPpIk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE4MDA2NiBTYWx0ZWRfX59n1QNTmLhNF
 JPgNIEjkOgKQ/meBq+d5uAt4xuMq2QEnaw2usd8GDa7t0+ffJCOqyHhsY6tRRtJqZ/zndwH/0U5
 kBwyQwp4sfcPjn6cGzDlZYwqrVMNTgwUOl/QzGs0CZV4zvkJs94+dUQXNOcCJGEbxwYH3UOEvJj
 09nFKzlO59rmFeX/HvDkNCYO/wX5MeXPXbM3+Mz9hceeoffMvyLUvOiTFDyTiVdvz98Yx4uKKZF
 TmRA6Ci5Mey4bt79tl7qduawNM7qkkUTpGyB7F0iu9Kf/GJ5dcWqwZ5aGPROh9b+DUIybTIw+lc
 +MfeM9Qu0TtxikQrehq/ndE5SMfrwUdWeeIf6HFLaXdHkrtvX9MuUDuoo1jrZQ6fVucY+Onyuzb
 VqhbZ8tTiw87EU0Wp1OMzLXPEfy2dhl57tXBaAflhZ7M1nHe6wppGDgytsyR9gaeW7LgkSw8ZIe
 yeFk0gZVJ/B8wFXuFTA==
X-Proofpoint-ORIG-GUID: 43JaOMQxntEzcb3VBdoanacDKjdIGUDs
X-Proofpoint-GUID: Pug3YLiLMGcY3fJCLotz8WYQBkPmvEar
X-Authority-Analysis: v=2.4 cv=KujYSmWN c=1 sm=1 tr=0 ts=6ad4fd3b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=TJ-IsHwomnPjbSOrev0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-18_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610180066

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
 arch/powerpc/platforms/pseries/plpks.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index 240cd5632446..c86960f102dc 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -750,8 +750,9 @@ int plpks_write_var(struct plpks_var var)
 
 	if (!rc)
 		rc = plpks_confirm_object_flushed(label, auth);
+	else
+		rc = pseries_status_to_err(rc);
 
-	rc = pseries_status_to_err(rc);
 	kfree(label);
 out:
 	kfree_sensitive(auth);
@@ -808,8 +809,9 @@ int plpks_remove_var(char *component, u8 varos, struct plpks_var_name vname)
 
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

