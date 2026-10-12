Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFF94B1297
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823303; cv=none; b=hCYT8PYztlmrtuPqvhYUkQf53HpL9LzTNBT2e7QkRxrKLlBaO0/lTzazoJiWuo6KOqxLNBu3eYHx9w9l8tQKBFx0WWKgfa66B1C9/SMGkqE1uaFJfSa3+RnDabQNYDq6b3xlSF9aoaITTNV/1E8NobHvT7WppWrRNHQy4mcmD0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823303; c=relaxed/simple;
	bh=wh2DKY7j0P7CH0WbHiVhgtIH52ea1a9sBJ+VG21/o1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qDOR/8BMurk+bw19XIBY7P+7TaPBLX/pogO6qMrcc7NXmUR46NKwmGCKFVvskIheqlLM5bbbl5AAw6dQMr0h3BkWvJk27sHxSAE+3x3/weoSJA01WnEystWwaDlY6/Sc96BnzjJ7eP/dG8FcWy1MPn2pXmUXocfL2BvMTyJtbOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oaNA19Eb; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oaNA19Eb"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFQvKt353387;
	Mon, 12 Oct 2026 16:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=9tsny
	ryVI7SvTw308K66zWsy7Lf8Yk+HE+Vqzry975I=; b=oaNA19Ebg/UsNMZpMWy+1
	XrVo4yDMVj/MTU9XUnpfRkHtAn/kPCeE69+BHJ+3OYdAC2M7I7iEaKiG+0/XB7Rj
	0VEagIFFzysSntV6l/PE2COnIqnYHAgXqcPBwI83nGBIeHYp5OGURI5I7GC+h0We
	5BHc3jHh6pHEyndn+Usa0cmjkZm8VZbzpsGNV8MNXU/F6/xM9dSBwGpPGCd6ydjY
	bqkAoeHp4y1gYrplAiJvLMmpAjwV+dom21Ow3a4UkF1CRKkI5eVPJUvIdXhDTGAH
	qp59gyFZ5sNEUWpblSestTurrXNZT7qrsT5HWgygsYIWPSHqU6b5Ini2Kc5DS56C
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7df7tkyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 16:41:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69CGbost032833;
	Mon, 12 Oct 2026 16:41:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btnf1m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 16:41:12 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CGf1wU006762;
	Mon, 12 Oct 2026 16:41:12 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4h7btnf18f-3;
	Mon, 12 Oct 2026 16:41:12 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Yang Yang <n05ec@lzu.edu.cn>, Yifan Wu <yifanwucs@gmail.com>,
        Juefei Pu <tomapufckgml@gmail.com>, Yuan Tan <tanyuan98@outlook.com>,
        Xin Liu <bird@lzu.edu.cn>, Ilya Maximets <i.maximets@ovn.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 2/8] openvswitch: defer tunnel netdev_put to RCU release
Date: Mon, 12 Oct 2026 09:40:51 -0700
Message-ID: <20261012164057.709105-3-harshit.m.mogalapalli@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=N+a8hG9B c=1 sm=1 tr=0 ts=6acd0daa b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=bC-a23v3AAAA:8 a=pGLkceISAAAA:8 a=UqCG9HQmAAAA:8
 a=P8mRVJMrAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=jblBUo_FO_tpK-iYEVAA:9
 a=FO4_E8m0qiDe52t0p3_H:22 a=Vc1QvrjMcIoGonisw6Ob:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2NiBTYWx0ZWRfX43wj8pFWXU0f
 WEUJ5mXvNxgQvfPUGzEMt78Ylof6eZ5ZoRS4510QjxC7W+JpUIvRS5qXm5/tlrooJzmkoh/EOn2
 j+sSx96vjW0pwdCTmlMZcYi/nWQIN8ATjDLNwONBQ2ljb/7jwp9G0xfsKcwZEI+1cNZ8l1XdY7C
 Dld2t0gJQgXSsGFD0NgrasmuKn7AxhR4uLXsjfbmjSn+N8yQ7S30a0EIwAwr5LDEzCFMNdspJIe
 PyTY7MN//BdcHqOP8+X/bTDExyHcBbTqDTzUTIBLyvQPYQuujWpRdBIvEEnqX+pjvSjXyDTWk8l
 cOKI6TRVHhktql4FPYJThaPCtiZmgDwhA+v1LPWm8Sjp5XMScwJFT8mydpNk4NrEe+R8cvqTQCT
 O+NAa2BEXk6d2q8ZvWclGapvioq75SM+ZyC4nidMu/QXoZAU9SKXCFQA61vNp9rHBtIdkdtfy8g
 V2Etz5ASkcYdFN3f5cMRpaWkkRoegSE654K9Fzqk=
X-Proofpoint-ORIG-GUID: IsC8EnXGbsbMd_4H-td1rMlGD-co9Kh8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2NiBTYWx0ZWRfX6jI8TJNjR8Y8
 Ae4S/BZRmyti/KeL8Ib1b66rGTeCQ2UeCn7GLAQElYt3fGUoV4F0yLlYFjx2uWuYc2HngJyagDQ
 yk54ivD8XzfwfhtwV36suB4tJqsFp3D5IvK7vcaDESD5WcOMXjSm
X-Proofpoint-GUID: IsC8EnXGbsbMd_4H-td1rMlGD-co9Kh8

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
index 10e30a85d5c5..7e8fc1e02750 100644
--- a/net/openvswitch/vport-netdev.c
+++ b/net/openvswitch/vport-netdev.c
@@ -190,8 +190,6 @@ void ovs_netdev_tunnel_destroy(struct vport *vport)
 	 */
 	if (vport->dev->reg_state == NETREG_REGISTERED)
 		rtnl_delete_link(vport->dev);
-	dev_put(vport->dev);
-	vport->dev = NULL;
 	rtnl_unlock();
 
 	call_rcu(&vport->rcu, vport_netdev_free);
-- 
2.52.0

