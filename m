Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E624F41F7D9
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 09:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330835; cv=none; b=fEHOei9IyE4hqIw9JMxz1FNsDBD5PRchPbyTSQJ87vD1tx1NSSwgV1nX6vrH10qFDQPjN4DdVH7qmu+1shr16bRf4vDMX4iHAnCh1tbOYITCirU9NyTh/x3AY5eA988phY6Vb9aUKONooyZoWPuy70TjIaqQ3ILvNDQSt5/CWlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330835; c=relaxed/simple;
	bh=bT3CXXjpBLJzDNhTOK6bD5YGi+CDKuvE6ekqMXG/ACI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U0QOc8URGg2Q4VVpwd1FHczUTQTtBmBJAO7++dUV+DO4sXkHAGwxrnZTmFzeDOaMTW7ihc7+UW5UT8J7t1uCuFxpAhYUdaTNLHgEIL8c99Msib7owDbd/Oo6BNDZIEFeqL1mnt2ftiIbglcP/g5N1MVq6+NaM7fHSE7e/ataRog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AVMO8v0n; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AVMO8v0n"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6669ILEt3151297
	for <stable@vger.kernel.org>; Mon, 6 Jul 2026 09:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=qmJem5JAZNi4ogHXTFcP4ii5SJmpfdY/czikIEk2+
	+Q=; b=AVMO8v0npmpGdX+GUGqwCSXO7dhnoRpZzbcjTogRenFqT/WZq+YgqJs8I
	1Tujbuk25Kjq2ydUNUW4SwGSCdXZandaGBW+cHhG9kqMEzRUbPmq4DYwzqWMoWvs
	WxO7LM7KmfZGxgnEuWHyVZYClkUvPPwRaX+JrwtzgybQsjr/5jBg3m4RhKbjH4Cy
	0bKqUaPSY8+/kRdL2RsGyffULfluBSDGykjya59UGK2mhbbkVyh+Tcnpse6lX4D9
	EgdNHzM6zxRc5qNmml63Byt+HKTX3DFRAMQEkNTtYXrBE06Yh50r/mUYZWZCOwjW
	xHOSXGb80pRQLL8/x/Tc9bb9q7h3w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdhcyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 06 Jul 2026 09:40:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6669Ydug030257
	for <stable@vger.kernel.org>; Mon, 6 Jul 2026 09:40:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6xvne5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 06 Jul 2026 09:40:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6669eOUN16384432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 09:40:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93C9E20040;
	Mon,  6 Jul 2026 09:40:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63FE22004B;
	Mon,  6 Jul 2026 09:40:24 +0000 (GMT)
Received: from t83lp68.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 09:40:24 +0000 (GMT)
From: Hidayath Khan <hidayath@linux.ibm.com>
To: aswin@linux.ibm.com, wintera@linux.ibm.com, pasic@linux.ibm.com,
        nagamani@linux.ibm.com
Cc: wenjia@linux.ibm.com, gbayer@linux.ibm.com,
        linux390-list@tuxmaker.boeblingen.de.ibm.com, mjambigi@linux.ibm.com,
        sidraya@linux.ibm.com, hidayath@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH net] net/af_iucv: fix NULL deref in afiucv_hs_callback_syn()
Date: Mon,  6 Jul 2026 11:40:19 +0200
Message-ID: <20260706094019.6600-1-hidayath@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4b780e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=UNGD-gTXSZoCYQNaG48A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA5NCBTYWx0ZWRfX1STuqcWeXiZn
 UNprMtZk8RsAq2D1i/VxVaVMMjPSRg9jqwh3AvJ9dDvIU6787swdoa9dq1gweXIx8sNhBxdelc7
 p8baSJDmTsbJdrZOIWth/k3XE41kkGNd7d2HlAEbyN+vPiMex5GCLYjs5LNcs9cg585jgj5RJyd
 0CffBg5BC0Dy1sk7ksXmTqoRxy6ePDMmNalpYPdjhhm5e6Fk/+jb0JOF7tMyj5kQSyHsaLN24l9
 wfJntZXJqTE4TtBOopQP3T9vXfa5h962RmzbGxg8pd/eEI+2fxPJIWbTQ7Jm2dIzlZrDqN8zB14
 WTwImAHZ2RK8RjKy5JAX7IuppwNIAK4G6IDaZd38Ff79Q7aogJRXkLaGMBd6CZY2EwnUIzMQ7mm
 Hoc07YCaZQsYBtFyqVHpEBRnN8Q7hVBdCZs3Y4Xib09NyB1UHU2LSPszshT1RHe3C3PuhgPh2sP
 sSMHU9Nux7WV1heM0UQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA5NCBTYWx0ZWRfXybB/rXMZ64iL
 IWBz3ZEqyorTeESoniMusUr6ddm06K1S2KFszhnHtxfBGNyA1pw5wQAnGhCHJu8PLNzg/HNRs45
 SJ3nA7MTrhGV2ArRfleJJOc/XUJ5c+M=
X-Proofpoint-GUID: ZsGGz6Kc7tKUBkkOtp9TI4yIxheVNw9a
X-Proofpoint-ORIG-GUID: ZsGGz6Kc7tKUBkkOtp9TI4yIxheVNw9a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060094

afiucv_hs_callback_syn() allocates the child socket with GFP_ATOMIC,
which can fail and return NULL. The connection-refused branch is
entered when the listen state check fails, the accept backlog is
full, or nsk is NULL - and unconditionally calls iucv_sock_kill(nsk).
When entered due to allocation failure, iucv_sock_kill() dereferences
the NULL pointer at the sock_flag(sk, SOCK_ZAPPED) check, causing a
NULL pointer dereference in softirq context.

Only kill the child socket if it was actually allocated.

Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
Cc: stable@vger.kernel.org
Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
---
 net/iucv/af_iucv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 890d9df5ae36..a471fbe178e8 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1875,7 +1875,8 @@ static int afiucv_hs_callback_syn(struct sock *sk, struct sk_buff *skb)
 		afiucv_swap_src_dest(skb);
 		trans_hdr->flags = AF_IUCV_FLAG_SYN | AF_IUCV_FLAG_FIN;
 		err = dev_queue_xmit(skb);
-		iucv_sock_kill(nsk);
+		if (nsk)
+			iucv_sock_kill(nsk);
 		bh_unlock_sock(sk);
 		goto out;
 	}
-- 
2.52.0

