Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2824B7141
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823309; cv=none; b=otQ7TRE08xztjPAMx15E3iw54uI0JMqFcsTRlVpoxzDIHiyEf380ef2PsUYBRvjU/Q1P1r2l2NPsLr64i38J3ij9Lcdiel6//OXeqOm1dfLliySkw/TpeTZX2L47SBIi8+e9NpWgZUxd9CBpMAJiDTl3Pcb126RNemUNhhjqjGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823309; c=relaxed/simple;
	bh=kOISselWdgSyj1OVBIZFVSOXgOeqY5z4/Vg8YqeKVFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JdbPtTNLDRmrlIaZOD4u10K7ZVqj7He+DOfVR87zXV+xpxDkpe7rNUHkaYewS20MZ4fzRrP1ixOGwws3xQLKZNwOMxWlhhUfhJiEplHlRndzgwifHYCKG6ScUcy8vT89zmNKGQ+tcjuV8r2Fuv2skYZsmhdo9MQQw2Fy8uT3SLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dbIA2BXz; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dbIA2BXz"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFQvKu353387;
	Mon, 12 Oct 2026 16:41:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=8YjCt
	6FIdCa4j/ROSy/IraSO52DVHyYB9gvI0KwMPa0=; b=dbIA2BXzpQRsXr/vQwKnm
	p2/0wo3VyKTqbdXsDVYkDtYFghyAJwQyym52uFiMZI7N1Ryp9/biMPiH2Hzmy1sw
	Rf/5bmF/GP9Hf/rSSSUtwXbL5/qkJc9yHG38T8qAUhPCYzuRLNLtGPdh0a+p6B4I
	sNuv+2AqSucy9MCK6qxfyEpsFJhb0H8TU9FSYhk1JbTeHAZ0O1rYie62tXtc1y7s
	qfDXZeaxkaTDM9x0U5nUUes5BPGsPE/a/FTLVofi/kPmdIA5kn9tb5fN5TOazsU0
	nJnpN/9Jx+r5hx1TOob1+WOC8Sj2HtwU7zRNEyS9t/49jJhMhmnznpR15Yf9fbMq
	Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7df7tkyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 16:41:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69CGbhnU032677;
	Mon, 12 Oct 2026 16:41:17 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btnf1rn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 16:41:17 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CGf1wY006762;
	Mon, 12 Oct 2026 16:41:16 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4h7btnf18f-5;
	Mon, 12 Oct 2026 16:41:16 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
        Yiming Qian <yimingqian591@gmail.com>, Florian Westphal <fw@strlen.de>,
        Dai Ngo <dai.ngo@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 4/8] netfilter: nf_tables: release flowtable after rcu grace period on error
Date: Mon, 12 Oct 2026 09:40:53 -0700
Message-ID: <20261012164057.709105-5-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261012164057.709105-1-harshit.m.mogalapalli@oracle.com>
References: <20261012164057.709105-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2610020000 definitions=main-2610120066
X-Authority-Analysis: v=2.4 cv=N+a8hG9B c=1 sm=1 tr=0 ts=6acd0dae b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=3HDBlxybAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=D2IQ2QobBSBXazy8eKcA:9 a=laEoCiVfU_Unz3mSdgXN:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2NiBTYWx0ZWRfX78kpfw+JEDiM
 2uOb9LIW8NLW5fboU030nYXq4D+TOrSf3ka2H2Tb1mroNiz1VVdlFvwm8j8n+3eENgELvuATV2V
 C+3pqpdJPuCLZyfICdcd/alkIz3GQf9mV9ktx+K2QxIqrgJCfQFi0f8jO4mgdfHQATfJCAXOo6r
 /FPq6RVkqjQ4bC06NmsK3T5iSs+5pgTPH2a9qVOGw0sv2Z6olk98zq0atc0oIepsJKnw9v4OhrZ
 h04a6vDezi6DSX/GF9JoiPb1rOktz1kAyB1InK/evDaV5WXao7iN87TH++EqQrjDJ4evM1vyuAs
 I6BZEQXSqkfflnjCL3Uk0W/BdKZaCqQHtEoceo2spnytn4CAWCgjVK3vbWFt+fknfUTHOeLhc5W
 2SbygMicv1HVdjO5kB2SUHK6h3blBWJMk7NNbnYKsboamifE7W9je1oC6GRfHe8YJtoER9HAKtO
 Up7oSNJtudmFEHN0AXNKK6bFkdCLYzQR3IUdweVE=
X-Proofpoint-ORIG-GUID: lsxM7Q_nkhWaZCsmnqTkQUi1sVFXTuD6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2NiBTYWx0ZWRfX7/ZvzEMjdMbQ
 dqEaagM8VfpYllQ+ZXWLVQem6DbuLkk71OyMDcsGda6khnPOBDF0E9tNusO4rW/DkUEAa4cyFsW
 3/cA3Flt6uG9gzJTk9CQMjHg9KPZO9VKs2s/JVkxPFMlXVORi31z
X-Proofpoint-GUID: lsxM7Q_nkhWaZCsmnqTkQUi1sVFXTuD6

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit d73f4b53aaaea4c95f245e491aa5eeb8a21874ce ]

Call synchronize_rcu() after unregistering the hooks from error path,
since a hook that already refers to this flowtable can be already
registered, exposing this flowtable to packet path and nfnetlink_hook
control plane.

This error path is rare, it should only happen by reaching the maximum
number hooks or by failing to set up to hardware offload, just call
synchronize_rcu().

There is a check for already used device hooks by different flowtable
that could result in EEXIST at this late stage. The hook parser can be
updated to perform this check earlier to this error path really becomes
rarely exercised.

Uncovered by KASAN reported as use-after-free from nfnetlink_hook path
when dumping hooks.

Fixes: 3b49e2e94e6e ("netfilter: nf_tables: add flow table netlink frontend")
Reported-by: Yiming Qian <yimingqian591@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>

(cherry picked from commit d73f4b53aaaea4c95f245e491aa5eeb8a21874ce)
The cherry-pick did not apply cleanly and required manual conflict
resolution because the nftables code differs between the 5.15.y and
Linux 6.12.y branches.

Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 net/netfilter/nf_tables_api.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index b5273255b738..92cea279bac1 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8112,6 +8112,7 @@ static int nf_tables_newflowtable(struct sk_buff *skb,
 					       &flowtable->hook_list,
 					       flowtable);
 	if (err < 0) {
+		synchronize_rcu();
 		nft_flowtable_hooks_destroy(&flowtable->hook_list);
 		goto err4;
 	}
-- 
2.52.0

