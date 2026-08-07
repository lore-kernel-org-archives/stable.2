Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C8B282F3A
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 16:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786121926; cv=none; b=E54QjG05/23hJ5dAZpjWR63FzdQ9DLvkKPOwo39TCHK95UAQzvQE1sQIUP0FLkCgM1x/vQgidfmk++c8qLot+WF5Fkhhq3zkKWYUzCo5jYpmOaMk86GjmDcLu+9XxEtjItDB8/dRqrazOMN6ypJ8rPCZvpevagOqmX0kE7EUypg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786121926; c=relaxed/simple;
	bh=qUKl9/gUt1i1I63hI1dqK44Vg7DBJZfNPFXOuhNulfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qLRwYbqk/ldEjw7udBjDZEKV1YgfDQ5Zc9hNcOfw8mRxLgtmiPZAwPoHIUR90jryNmJE9zrrJ2CQ6X+BUBnJZHJC+POkP0o9aHAjHlcKCujSLgILNHDoimcWs0OyHaoEukpIi5xia0oj+ud4QjtGPIkQxlnzUKciH/sqtAiQeUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lDXTbxiJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lDXTbxiJ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677Gm1iP1928285;
	Fri, 7 Aug 2026 16:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=P6gEfuXHQWuSsVyuJ8ckiVG/cSshi+IApeubj5nD1
	Z4=; b=lDXTbxiJ1PlVRyUFTtkOY7iobzxUTKZOvFB2IIczPvHlK7LcvbO8w4LZ5
	otjwPceQoFQm3ArDRJ/GxLAQXQY+P9yHilgcspTvd3+BDePaQjzdNrAEnmLmd6e0
	ke1KWCm1dMD1QcSjfS+vxa54dCp3LzIJfIkLPKEDHhNXoQz0/zp31+if6GKNTLiV
	RrS0QNqMB6fZFCz0kegFdPX4cwPe5kFlBMMTT0W3tUKfLfUzBOqWhLiw9dXxwk98
	cGzU51+HIf6XXThZvEFSNKh0LqUi0+lzbR70ZkUPzGu7MAsm/1isn/Of1UhK8J6R
	Z1r38g951+NO5xsgTWTIhXJqqS8xQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy02ct8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 16:58:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677GuI1E010353;
	Fri, 7 Aug 2026 16:58:41 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhrf5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 16:58:41 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677GwewT25559598
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 16:58:40 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A14B58055;
	Fri,  7 Aug 2026 16:58:40 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F2845804B;
	Fri,  7 Aug 2026 16:58:40 +0000 (GMT)
Received: from ltcd41-lp6.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  7 Aug 2026 16:58:40 +0000 (GMT)
Received: (from gcwilson@localhost)
	by ltcd41-lp6.ltc.tadn.ibm.com (8.16.1/8.16.1/Submit) id 677GxCbG038944;
	Fri, 7 Aug 2026 11:59:12 -0500
X-Authentication-Warning: ltcd41-lp6.ltc.tadn.ibm.com: gcwilson set sender to gcwilson@linux.ibm.com using -f
From: George Wilson <gcwilson@linux.ibm.com>
To: "Madhavan Srinivasan" <maddy@linux.ibm.com>
Cc: security@kernel.org, George Wilson <gcwilson@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        R Nageswara Sastry <rnsastry@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH] powerpc/pseries: lparcfg - fix kbuf[] underflow
Date: Fri,  7 Aug 2026 11:59:00 -0500
Message-ID: <20260807165900.38934-1-gcwilson@linux.ibm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G6ws1dk5 c=1 sm=1 tr=0 ts=6a760ec2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=zfkEumqWtOA1HUgqu1EA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEzMSBTYWx0ZWRfX0K+e2iKCO/yx
 q4uO7GcjJ1mubXVKiD9efJe7v9iir1uHVZIjyo8BuEJnngLMupRySY1Mfo+pZ3a/wAZvKLXtqPS
 RdY0OOWCKVz7Rbvbu9grBFMo6RLfXAYJBaFIc0fRacI/QAXAGQ+bIUefv/YTM9eTF2JaVVEjW4W
 SyeuWwxvyKJ9VSwGj+yiC366FvCkpywwJB3eEivC+e25DOe6mrvaShJy9mdPDrVcowJkfHl22s9
 F8gmsJXVtACt4FDHq1543xj9wAdpm0cOqGRlN+MiEavkDR+TUtBIXpLUgSfAmRMkNPHYQajybCx
 rqKaAPPijz9bkPNMxknrvZbpBqXPA51BRhu0H4+44T/kw+eZv4pkiRNSWFRfb/Xbi00iOE8HRlv
 bAAVEZ6E9xEjim0CkHIHFkwK+R6RvVhGIePDCEgQ+htIiOuHYcYTXXoPlBYHIs/XR7Ey0vRQ6KR
 tTawqggFzpVRa2nGkQg==
X-Proofpoint-ORIG-GUID: 9_vaZu4ConGjBODCTdrqubqmR7Rbueso
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEzMSBTYWx0ZWRfX1+aYEMfZIAf7
 74uF3Bt9JjC3z4+guLD1Udg4jAAWmtmTZuaYXJdyi2VsWiQMM4taPbE4gWLVaI2ABHhQGBHz3UI
 wwVZZ9lBTbhg4wUHarDU7OtAC7+09IQ=
X-Proofpoint-GUID: 9_vaZu4ConGjBODCTdrqubqmR7Rbueso
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070131

In lparcfg_write(), a count of 0 results in kbuf[] being indexed at -1.
Check for count == 0 in the existing check for count > sizeof(kbuf) and
return -EINVAL if true.

Fixes: 74422e2b1939 ("powerpc/pseries: Remove VLA from lparcfg_write()")
Acked-by: Nayna Jain <nayna@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
Cc: stable@vger.kernel.org # 4.20
Signed-off-by: George Wilson <gcwilson@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/lparcfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index 8821c378bfff..141bc270623e 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -697,7 +697,7 @@ static ssize_t lparcfg_write(struct file *file, const char __user * buf,
 	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
 		return -EINVAL;
 
-	if (count > sizeof(kbuf))
+	if (count == 0 || count > sizeof(kbuf))
 		return -EINVAL;
 
 	if (copy_from_user(kbuf, buf, count))
-- 
2.47.3

