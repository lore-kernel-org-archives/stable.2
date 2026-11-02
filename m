Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.165.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614878;
	b=Q2FvOveZrurJZ4Z5irDd7abravaupFOTZD9nBjipi5+mxyTq+PZDOEz/xvgZWyX9EH/w
	 5P1y1GTCoLzoZ8wBIv8hHJq3WetXO/vK/VDe9uOppnhaEI9xhqOl0/Z9nOwW9Niy/zT0+
	 g5+Y1ogw1qOSmE0g2eEeQWtBGBfCPgGMxa3s0LgX8rqt40oCo94iOfWzsqsD4iq210PMD
	 bWBykhgYOnEPcyhrEABv4EaEK543cm8Xbrc5iwo5ZhhUim143v8E/jF65dE2qNPyNSoDN
	 yhvFYzOsXsH7Tn6S6SeA7B6G5cStzZTGTSIgy1AoIzk9+H59yOBbJH/YYiNNcX1koIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614878;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID;
	bh=Ca6UhdxBXXsmuOGarHCYEzlC24hodI9suLqRzAiNVXs=;
	b=w/ldpu+40vHMDCQRvutB06fHANJbW3v5qhD6eF0kVwXnA0Fy0JtEJY9QouuP9ioIZRXu
	 B6edIutOP3ilegtLacbHMZwrDioMO6i9KV+JwI6G4AxKxP+zQKlNn9SDq9wYoFdO13nk5
	 pBF8XqQwYbd/5eB6tTLtgHLV9z0IXuTTJ8VxX6hLYCMilHZD3VkcwUgx+XDqOWeTawbqP
	 8b/xZzYOipeHswW+6qp5uDrgWWXeoQxLdMZrBOnpJXJr6l0Ja6UQaiGXwZIdmuz/Dw9DO
	 fGJRlfwMBcVecAneggI1Vilr8myIinXcdzVEGgS/IDEXZhQAU5qabz2MPTRiYj5ipGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=RwLtvo4w;
	arc=none smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AB0606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3AB0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=RwLtvo4w
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1Le11d1635647;
	Mon, 2 Nov 2026 10:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Ca6Uh
	dxBXXsmuOGarHCYEzlC24hodI9suLqRzAiNVXs=; b=RwLtvo4wsMabL5vQDgEuh
	gA9iWh+e0Cw6RDp/L74dSutT1cb3mzwtN+19ifQDn80NySQvYiqGwwS4j1QvnUOt
	wmW0VQj/EKHL+avEpElOCpffjUtME8i/YtRUPBq+T1jix3QtO2810HBZjsAVgSqG
	ADrc+d5xMOGXtct1i2/i8oBWpOdPwpxvldEUFBrrJhz1mzFU03YMAw27OEp8aEBH
	4S23zchQGOUwpai9vM86K8pfDFdRL01gi20ZEbDBO4+hF3KpV6xQOESVAFkvErEz
	XXBsyUFdQ5cMyolHSq7jnKUsGrE5FkiVzhTqVHoIxYGX8j9mmjki66AYFCa2G7ru
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn78a9mgt-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 02 Nov 2026 10:21:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29Cujc1424149;
	Mon, 2 Nov 2026 10:21:12 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4hpqhua27a-3;
	Mon, 02 Nov 2026 10:21:11 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Ilya Maximets <i.maximets@ovn.org>, Eelco Chaudron <echaudro@redhat.com>,
        Aaron Conole <aconole@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.10.y 2/9] openvswitch: vport: fix self-deadlock on release of tunnel ports
Date: Mon,  2 Nov 2026 02:20:57 -0800
Message-ID: <20261102102104.1558500-3-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-GUID: ggp7BrXeH2NwHq8NWOdgmHsccxOQ3siy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX3VjnvKt1nYTa
 xzPp00+s8ecPRKiFlBu+GtOagcWuma0GX27eOf1LysPQF8e7P3xqzezG1x82ISgarE76X6weLhJ
 xxNdIx6WSYu7wzqRjgdKDhSQrBwaLATQF0TOCGsqis/0vAPX3yrN
X-Authority-Analysis: v=2.4 cv=Mo3HeGae c=1 sm=1 tr=0 ts=6ae86419 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=bC-a23v3AAAA:8 a=P8mRVJMrAAAA:8 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=F_uTukMRujDXF5t0YlsA:9
 a=FO4_E8m0qiDe52t0p3_H:22 a=Vc1QvrjMcIoGonisw6Ob:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13537
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX0l+53zGFptSg
 KxROBUmUCjYFDzcHpO/wV2ec6PC5ANIxFRMfvyULqH6CqTJt9lV+YaqnnxlPn6Cnrvuh00iFJV2
 j3XZQLY53LHds6pdw1KDPkeMcIpMAJQuaCBZlBEgloAGjol65Wo9tDPsgZdj49Tb1/u9o6cWGsH
 aEvD0QjNBze8iGggwhwa98NKRM5MpjDSbTmVYnkdfLCkZ2thISyHps1UalVZzenoN3ZDcHPKvor
 YuTI7FsyYY1yGzg4ORbSotyu8pjMugOGunzS3JYmatKx+kbo2AXGZmBnBubPbNL1YGsjoTuaNd0
 4krtSOSx1QZr3O84W0QTzapPWkK+1+dmexsN2ZNkKu8jITqNXGc6qMk4JOPo4CDPoIPZ0DkSNWf
 a/l7krOtSFGGBomm8Pyv3iGiwWnciGT6dWkN3caMz2YVTydyR7VzCvgqyajBCyu41+w8HP1fkvz
 SZBxplF+VGboybhcKf8Yg1kYebXQYjS+L6NNgmb0=
X-Proofpoint-ORIG-GUID: ggp7BrXeH2NwHq8NWOdgmHsccxOQ3siy

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
[Harshit: Resolved minor conflicts because 5.10.y has one-argument
rtnl_delete_link() call.]
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 net/openvswitch/vport-netdev.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-netdev.c
index 8cbf787d1fcb..ab8e4ebedd33 100644
--- a/net/openvswitch/vport-netdev.c
+++ b/net/openvswitch/vport-netdev.c
@@ -191,9 +191,13 @@ void ovs_netdev_tunnel_destroy(struct vport *vport)
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
2.55.0

