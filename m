Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.165.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614890;
	b=FRRMwlAjIIHqoDdjYd2mHbgFSOu9daPFRJsNCm7tuddrzbKAkXGw+oAQTria2W8y2b79
	 IzB2aTCLRrzi9x6uJ9XxO+lg6I6S1Y+TLbAScaM7/7nmsQVpHrqUFXjO8ujdFHCGiBqs/
	 wb3uKYWlVHTCR5789wSSkwtjMPauZ0atY8rvXY9m8hEJXyH24+IIlqQYKAx8GPJKMLoX1
	 NXNoIv8cOcXgFq+3y7pkcuAO6V6dZjASkvGgpT6seRu8BoLM5EfsjNvQKXpA4KYeFLu8P
	 tpjYrkDcC8A8cHt00DdjllwcAvO7t6Qcr0oesEsaYC0Qa04lwg9ZiVXy+rLRnzGV5qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614890;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID;
	bh=goWLNSALxjSzlw+a2Ox8+Vws0NhwmzE0CGmjidG66sA=;
	b=Rh49vZ0tLyjq4+t/S02T0w3ksOkrIz5nurVK2MhyXwpQpvTFRyiIyB/A1l//stsa6K5M
	 n5D3lAhqzRpJqUK5d1cTWw2JHL3v1IpA7MDL608r3wkpSvfz5akS87jEGQ1OL7lGINxI8
	 ldxDmjtPD7nPW+xInePo0kfBzGi95R7BpuVCFSlL9LJhVzcf8SLGuM7Nr6C275ePwDmxT
	 Zq80eVON+nL/b3C0C5WOzvPBhKsDksINY1GlkmrYhTF7hgtlgAE6p6r7g8qeElzGRNKt+
	 PO5qjiioGF/GbeTO2dkKVTE5Tsb2JRPYF6ItXCbfFhNKcbHnIMEec4ox6GSnF7utMbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=TFoAGxtA;
	arc=none smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C191606A32E
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:21:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C191606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=TFoAGxtA
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A24DrvK2275888;
	Mon, 2 Nov 2026 10:21:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=goWLN
	SALxjSzlw+a2Ox8+Vws0NhwmzE0CGmjidG66sA=; b=TFoAGxtAQwabrHHfsDpjC
	SsWP8O3fTaMYu+K+C8s9lB9l2BpCRWVnP0uLvP2NhvJ7uARLc2upWSgBUB+QrS7T
	drAYePOkSzgdySAUVjLoYZI91rbsExkCK8Pz+IOwPfk4z2M+cxbZNbK6mOF8wUxv
	KwZeqmtQk3nrPD0VBIw/iH539ksEmVZQS9FYk00fueqY7hUVJRKEkFlhOeXUPF4S
	/k6LZWt89wRjMLVIsoGsYoyuEQ7F56+8KnghXFqX3+d9+oQ8dcCe0cLtQv+hhiF8
	cosy7fgI9UEgXWSQFRRyVbDOBNrs4qY7GQxpbl5/JMlLc1njgUjoKEnET6Afc+ZK
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn78a9mgq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 02 Nov 2026 10:21:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29CucV1424148;
	Mon, 2 Nov 2026 10:21:10 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4hpqhua27a-2;
	Mon, 02 Nov 2026 10:21:09 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Yang Yang <n05ec@lzu.edu.cn>, Yifan Wu <yifanwucs@gmail.com>,
        Juefei Pu <tomapufckgml@gmail.com>, Yuan Tan <tanyuan98@outlook.com>,
        Xin Liu <bird@lzu.edu.cn>, Ilya Maximets <i.maximets@ovn.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.10.y 1/9] openvswitch: defer tunnel netdev_put to RCU release
Date: Mon,  2 Nov 2026 02:20:56 -0800
Message-ID: <20261102102104.1558500-2-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102102104.1558500-1-harshit.m.mogalapalli@oracle.com>
References: <20261102102104.1558500-1-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2610300000 definitions=main-2611020040
X-Proofpoint-GUID: 4I-J34g-JWxOswP9cav6z1cmVbmIgTcZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX1DR1gcJEVMcg
 sjIUbE2yCgXIddr7TuffJBYMx8G88ChAW4nUjKfsZgPoOCuLGVYKFw8xjioMtlR2IhsaSb0CqKv
 Y1uO27b0ECUpkhNT0TSmh/7HKl7jA6dcqyQzijeBoTMnjzQPQbK6
X-Authority-Analysis: v=2.4 cv=Mo3HeGae c=1 sm=1 tr=0 ts=6ae86417 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=bC-a23v3AAAA:8 a=pGLkceISAAAA:8 a=UqCG9HQmAAAA:8
 a=P8mRVJMrAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=jblBUo_FO_tpK-iYEVAA:9
 a=FO4_E8m0qiDe52t0p3_H:22 a=Vc1QvrjMcIoGonisw6Ob:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13537
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX9NTZbH1fdvaa
 i+tVQ+oSJYEcbrJT+XZ96/d5FfOxbIOsN0rjuTrjmQkBtzxGr5XVDf91a3he/CYrXF2jggVfFmr
 HgSdP2wq5aG5X1wSlEm6lj3Azd0AvfNpt/nP3HE3kuC1r5lABnjIT3x9k7jQ1ngRHHQ1LuAAdD5
 pxCe5nWCKiiogj4J16EfRsKvGLC7ZhSAajDJGYPCD9VHWSg2a2T7uvmqus5QtI0GpVGkL6upHrB
 RcHTIFTgUn3ajSOn0WJDUpWmye2gJwFsLdZuyAvL+7tG7otEZedYADLH3Lv1UX7JHBh5p+22Xtc
 J9Cx9DC/028VQ5hYUniaEFj5uxn7buwbYVNKGsfn8SjoAfsjeSXu6TK4yy7KdXlQYY8C9iMkREL
 o/ubRuUNYT55wBNWwxwd8NAZkA7eqO+Xv0UNrRn2lRIIBm9D+XGITKZENzfrDb7Yy5sQLL4XWjC
 KQC4okThlpos03OS9rLNotbmdVq7VeIQqJi+Tsf4=
X-Proofpoint-ORIG-GUID: 4I-J34g-JWxOswP9cav6z1cmVbmIgTcZ

From: Yang Yang <n05ec@lzu.edu.cn>

[ Upstream commit 6931d21f87bc6d657f145798fad0bf077b82486c ]

ovs_netdev_tunnel_destroy() may run after NETDEV_UNREGISTER already
detached the device. Dropping the netdev reference in destroy can race
with concurrent readers that still observe vport->dev.

Do not release vport->dev in ovs_netdev_tunnel_destroy(). Instead, let
vport_netdev_free() drop the reference from the RCU callback, matching
the non-tunnel destroy path and avoiding additional synchronization
under RTNL.

Fixes: a9020fde67a6 ("openvswitch: Move tunnel destroy function to oppenvswitch module.")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Tested-by: Ao Zhou <n05ec@lzu.edu.cn>
Co-developed-by: Yuan Tan <tanyuan98@outlook.com>
Signed-off-by: Yuan Tan <tanyuan98@outlook.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Yang Yang <n05ec@lzu.edu.cn>
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
Link: https://patch.msgid.link/20260319074241.3405262-1-n05ec@lzu.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit 6931d21f87bc6d657f145798fad0bf077b82486c)
[Harshit: Adapt the lifetime fix to dev_put() and one-argument rtnl_delete_link().]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 net/openvswitch/vport-netdev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-netdev.c
index 70cc8854b8d5..8cbf787d1fcb 100644
--- a/net/openvswitch/vport-netdev.c
+++ b/net/openvswitch/vport-netdev.c
@@ -191,8 +191,6 @@ void ovs_netdev_tunnel_destroy(struct vport *vport)
 	 */
 	if (vport->dev->reg_state == NETREG_REGISTERED)
 		rtnl_delete_link(vport->dev);
-	dev_put(vport->dev);
-	vport->dev = NULL;
 	rtnl_unlock();
 
 	call_rcu(&vport->rcu, vport_netdev_free);
-- 
2.55.0

