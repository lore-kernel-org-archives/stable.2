Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF60C4AF169
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823282; cv=none; b=gi6he4SVWnf9PAYk1bmSIEvHFydTmC/WE8iE+B6SqIwwxmITVaUuTgvEDSRdnHBivjTNOvS0/dMRmz6rbLu7ox79xno4mKqg0z+0BkJsOuj3xN9RFT+r2Q4lm8Yax5kXpwTD35sGQuTFADR5vhJepB58EpvPKvrxiQQFFmEFTXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823282; c=relaxed/simple;
	bh=JXNFIM1SAp9oSa2++MP229fWPd7X+YHBPwmbgJCQWX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRRc/YEF+/+ko8EIP4CYf26172d8qTxFftp8Oca38KB5Oje/AAzTlgGmurRDYB3PaC1gkwuL9VxL/RZlGaDITWCDVT8xFCapXdbCxrim4tK4+DFooWEUNPVWXD+XII2bkt18yBI2t3Wy/S1IWMvaR2rt43qARo0ve+W1pZRE4Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nTmDYO71; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nTmDYO71"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CFR06K1947681;
	Mon, 12 Oct 2026 16:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=QN0GF
	mJwiO+jd+ah3lgz4IpzkwWHzz99NI6VCdgj0Vw=; b=nTmDYO717NneQYNC4JUbI
	RTPpePNJNaORRGnloyzSdyVgPFfDhU29yQCy9aCJn0+MnMLRmp8zlGQ1rLqaXcei
	QaXfWyzJ5mO9WnxwaiOsevwc++VzYptKPMRjVCXn5VbNyZuh+djMagFah7umipHa
	2J3c6MmaJwAvd8UWtQ03rEOIF48zns618VlpxSRsA08m/Xajy9rLniZ9kYJghscK
	VqSfafws3lokQn6qkJ2LJ1YRezkU4zB5+44uccgrBOMK4YdczzOsoU/qBDQB3gdv
	etsQSvqSSV2VAvCu2h8dFV+4gDbLX9y27HWnWKqZmcgyuOt7ESaBNur3QJtKTcc8
	Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7dwtak9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 16:41:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 69CGbkdi032702;
	Mon, 12 Oct 2026 16:41:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4h7btnf1p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 16:41:15 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69CGf1wW006762;
	Mon, 12 Oct 2026 16:41:14 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4h7btnf18f-4;
	Mon, 12 Oct 2026 16:41:14 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Ilya Maximets <i.maximets@ovn.org>, Eelco Chaudron <echaudro@redhat.com>,
        Aaron Conole <aconole@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 3/8] openvswitch: vport: fix self-deadlock on release of tunnel ports
Date: Mon, 12 Oct 2026 09:40:52 -0700
Message-ID: <20261012164057.709105-4-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA2NiBTYWx0ZWRfX/uy1kUku5/zj
 P/KZPvA+p+10qS0fW25Tha+0KEqpYdT0yHGl+XKm9CuHWoaKXuv4tmcVpvNVXxUwjkesH12STh/
 eA1BKLWFScaw/6dfOlyQU4IxgW8vpaWynmk7iNe7xiQc4SKDJNLmVa8kp1VJZGlzNe0zOsjRvYa
 W3LPzG2oTjCQVApWeit7w2UKax0fDG10tu4tV8WSIuaQVkuR8bdpcZGcgjQ6tjz2hGxbIFeEGHv
 V+81z5SF4gYGurso+wODPlZdGxiKP6NJ2Nja3RrHKvJvCSjggb/RS+kojZvzjkscth8huO8pqT6
 faiDtoVzBWlyinh9maBQ95kKndjsBVGdZRmj+clcC8wlYGBmLsJka5xBWQUkbyq7j+GCL/zAbEQ
 5EnSbeT3d7oTP3PSMTHbnXcQJMLOseo1Xx6EgeJGavJvW4xbX+ME7dPwHA4zLIWXdoI4P/0oqM9
 BKVy7DZl/7a20VsXszfyeDCacAlUAv9yEUUwIQiY=
X-Authority-Analysis: v=2.4 cv=Kp7YSmWN c=1 sm=1 tr=0 ts=6acd0dac b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=bC-a23v3AAAA:8 a=P8mRVJMrAAAA:8 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=F_uTukMRujDXF5t0YlsA:9
 a=FO4_E8m0qiDe52t0p3_H:22 a=Vc1QvrjMcIoGonisw6Ob:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12107
X-Proofpoint-ORIG-GUID: A6sPfJjLRqizoVVWyRfL5NRasPIXpbNS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA2NiBTYWx0ZWRfX/eeA6X3nyn+g
 qn1RZKr6CtkW9oAl8O9wqqI5FH9FBPBzgUBvQlGgw3ZxruHimd5P+zDjyP1EBwEQBjfIzz2/6AG
 HVyJBMsp9rg7OTAlmd9KCROR/2d2GdP/qNb+t2JpddRCfXac+f2e
X-Proofpoint-GUID: A6sPfJjLRqizoVVWyRfL5NRasPIXpbNS

From: Ilya Maximets <i.maximets@ovn.org>

[ Upstream commit aa69918bd418e700309fdd08509dba324fb24296 ]

vports are used concurrently and protected by RCU, so netdev_put()
must happen after the RCU grace period.  So, either in an RCU call or
after the synchronize_net().  The rtnl_delete_link() must happen under
RTNL and so can't be executed in RCU context.  Calling synchronize_net()
while holding RTNL is not a good idea for performance and system
stability under load in general, so calling netdev_put() in RCU call
is the right solution here.

However,
when the device is deleted, rtnl_unlock() will call netdev_run_todo()
and block until all the references are gone.  In the current code this
means that we never reach the call_rcu() and the vport is never freed
and the reference is never released, causing a self-deadlock on device
removal.

Fix that by moving the rcu_call() before the rtnl_unlock(), so the
scheduled RCU callback will be executed when synchronize_net() is
called from the rtnl_unlock()->netdev_run_todo() while the RTNL itself
is already released.

Fixes: 6931d21f87bc ("openvswitch: defer tunnel netdev_put to RCU release")
Cc: stable@vger.kernel.org
Acked-by: Eelco Chaudron <echaudro@redhat.com>
Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
Acked-by: Aaron Conole <aconole@redhat.com>
Link: https://patch.msgid.link/20260430233848.440994-2-i.maximets@ovn.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
(cherry picked from commit aa69918bd418e700309fdd08509dba324fb24296)
[Harshit: Resolved minor conflicts because 5.15.y has one-argument
rtnl_delete_link() call.]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 net/openvswitch/vport-netdev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-netdev.c
index 7e8fc1e02750..7c31995618d6 100644
--- a/net/openvswitch/vport-netdev.c
+++ b/net/openvswitch/vport-netdev.c
@@ -190,9 +190,13 @@ void ovs_netdev_tunnel_destroy(struct vport *vport)
 	 */
 	if (vport->dev->reg_state == NETREG_REGISTERED)
 		rtnl_delete_link(vport->dev);
-	rtnl_unlock();
 
+	/* We can't put the device reference yet, since it can still be in
+	 * use, but rtnl_unlock()->netdev_run_todo() will block until all
+	 * the references are released, so the RCU call must be before it.
+	 */
 	call_rcu(&vport->rcu, vport_netdev_free);
+	rtnl_unlock();
 }
 EXPORT_SYMBOL_GPL(ovs_netdev_tunnel_destroy);
 
-- 
2.52.0

