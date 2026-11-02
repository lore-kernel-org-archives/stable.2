Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.165.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614409;
	b=GRoE3yWmu7FFo7bnE1y/RPBWETz28dcPxd8m1PgdgCK+mRsbjXpv+3R6inygoBFdUb5N
	 aOROcBZPz38dpNAwziQHD31uWUQWEyo5WPZ2+Z07Sbeyn/mcCpUQ93onGTr/zDbH0LGWJ
	 GPqFu51/K8x+D4ZNa9/1+SSOyvNMTOK08rqdDypYU4vjvAc4v4Js+L60NexSaTk5iX4Kz
	 OmrUpxNuIhOA9EjMW/dkGs7BkhHMQS0KLyQkUElDSeIpVajNUTi89TuNVyU3KHmVPzgC5
	 KDEGclePZYW+w0giLIjzKku6ySdMmQqeJrlOkCrmQT00d/NqWqD+MgNW6diYA/rKk7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614409;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc;
	bh=uL0wexTpBvvxPFLQS2o/E2x5EBsGxSN2nfZQHwNTq3w=;
	b=DqSW08JUOEg9qY0a/rkiNZMrFsZnvcvjzkLFoRpV0Siaet8Yb5llg89NFLOqg8iwpYX2
	 HdMZYGZti1bBqfJnFykDbHvcuUT6k3E+0S7XCBfxJqtLzRKsxEY6nWYGtA7II9h1FUOpl
	 EozvM+1ziMrTWEepsLN/ZvtDjAd46Exs5zGe7/ADxUUrLVUi1wn9zkVqQ/t08reGfhVyN
	 RlezvdqIpe03iQ/xXKOTLBISlR0RrAZPFyL+t/JC0yvPBF/Cvomu8qxp2WlB3mxxf1Oqs
	 BJBZKGfTeVWhk47dsLDzjersRLDImFdyzTwx9GxphS/E4Zixlhmyt3mJOUIipjC238A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=pCSzic5V;
	arc=none smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA7A606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:13:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CA7A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=pCSzic5V
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1NwMtc3255408;
	Mon, 2 Nov 2026 10:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=uL0we
	xTpBvvxPFLQS2o/E2x5EBsGxSN2nfZQHwNTq3w=; b=pCSzic5VmpjuF71OJC2gE
	deC5MAZ3HA83ZCUMw8XQ3WOqNH5JlEmeZkNbeKTVopRruJim/lj3HE3CQV7/1kM3
	x09awsUMldbP1yyTlUqfm0lJntMnboRcbsL9SfssJ6A8blvT+xd+5+FMC3f92ExH
	132u5W0bAzkDsrYdS0E0Nlpw9+NK1pCz4I6Kw/BOMNB0J5BbQ2g02Kp1XTC7UmEA
	Wv1EEsuHcja4vq/EMbIlnaMVFYs1aZe94Lh6MowKK9Sc5q1jK9yQSdBYj21+1BK0
	dZjE+KnJ9XrzQlNdcyLwB+gR06yWxqcRMVqGO2amsKUzmQxwNCRtVfb+/OX8Doko
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn6x01kxm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 02 Nov 2026 10:13:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29CqX12995745;
	Mon, 2 Nov 2026 10:13:25 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4hpqfja56j-11;
	Mon, 02 Nov 2026 10:13:25 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Duoming Zhou <duoming@zju.edu.cn>, Paolo Abeni <pabeni@redhat.com>,
        Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 10/11] cxgb4: fix use after free bugs caused by circular dependency problem
Date: Mon,  2 Nov 2026 02:12:38 -0800
Message-ID: <20261102101239.1557688-11-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102101239.1557688-1-harshit.m.mogalapalli@oracle.com>
References: <20261102101239.1557688-1-harshit.m.mogalapalli@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020040
X-Proofpoint-GUID: tvUuC7tu03oMijcVNv8DxdStcF9-3yGH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX1gQmWWsd4WtT
 jc8G6AKQPThBKvPF5SYsz0gam41EsG2wN8xQgzPfV94yityoTHzOElphJDtECHtvHiWn2Rrrq25
 qCVgIqp6FTAlUR9NBeEzY6ReIzPWB1qQdPw8ruGmw+upE9gFK/HA
X-Proofpoint-ORIG-GUID: tvUuC7tu03oMijcVNv8DxdStcF9-3yGH
X-Authority-Analysis: v=2.4 cv=J6g/fwnS c=1 sm=1 tr=0 ts=6ae86245 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=-nKc8X9TPv6IDXWQXpEA:9 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX+CFmqiP0wYqO
 dAwgWjUYT3DlCehrOu27U9Ako6KALABCtZbLMDK4b+5gT9UK+RmOATxcCZnxkLE5LTrE9TO18J5
 krtneQtgFJuh736Lz0uSjymsI+vCQBJ2cfLfvbFBeKksq1x2WaVkcz6i12+8pCpPGx2utllVA65
 AFzI+ylIqwGaLIQdjq3yF9aB26DbfJGb6cNph7tHEezTogQlyiBsI3+3Atbedvh4PAOoafVNv6m
 v0vWNacvdviAmi702T5v0X2WNa2vDzXjmQ3oSEqWonoZ+ig2jnPz036+N8oci4U4QMCZmMNjDtK
 4/Kj8WBdM5JxYJnmxVJy0vikwucDVkp3YZS7KMkWX587pNgN8WNs0+n10E13X9SAnGkP/GVF1+c
 evkJa5zdCQAeeQeo7ttggTpiasBYCCfCVev/+Lmh6hAKbCIO8MPya2uhvHCzzoEaGYaQCYPBu3M
 q9DCuEmRx1+C0QCcjPQ==

From: Duoming Zhou <duoming@zju.edu.cn>

[ Upstream commit e50b9b9e8610d47b7c22529443e45a16b1ea3a15 ]

The flower_stats_timer can schedule flower_stats_work and
flower_stats_work can also arm the flower_stats_timer. The
process is shown below:

----------- timer schedules work ------------
ch_flower_stats_cb() //timer handler
  schedule_work(&adap->flower_stats_work);

----------- work arms timer ------------
ch_flower_stats_handler() //workqueue callback function
  mod_timer(&adap->flower_stats_timer, ...);

When the cxgb4 device is detaching, the timer and workqueue
could still be rearmed. The process is shown below:

  (cleanup routine)           | (timer and workqueue routine)
remove_one()                  |
  free_some_resources()       | ch_flower_stats_cb() //timer
    cxgb4_cleanup_tc_flower() |   schedule_work()
      del_timer_sync()        |
                              | ch_flower_stats_handler() //workqueue
                              |   mod_timer()
      cancel_work_sync()      |
  kfree(adapter) //FREE       | ch_flower_stats_cb() //timer
                              |   adap->flower_stats_work //USE

This patch changes del_timer_sync() to timer_shutdown_sync(),
which could prevent rearming of the timer from the workqueue.

Fixes: e0f911c81e93 ("cxgb4: fetch stats for offloaded tc flower flows")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Link: https://lore.kernel.org/r/20230415081227.7463-1-duoming@zju.edu.cn
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
index dd9be229819a..d3541159487d 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_flower.c
@@ -1135,7 +1135,7 @@ void cxgb4_cleanup_tc_flower(struct adapter *adap)
 		return;
 
 	if (adap->flower_stats_timer.function)
-		del_timer_sync(&adap->flower_stats_timer);
+		timer_shutdown_sync(&adap->flower_stats_timer);
 	cancel_work_sync(&adap->flower_stats_work);
 	rhashtable_destroy(&adap->flower_tbl);
 	adap->tc_flower_initialized = false;
-- 
2.55.0

