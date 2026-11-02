Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.177.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613793;
	b=3QL7c9BQ104v33/ksNyRm+EPVxFTksoyt6jKQgxa9oZgyrFoHSMfeBbmnD6T9m2ATAP8
	 /Eh5vESK4JVj/1pVyUA3j3XfKrTikAbk3ih+HzUFE9QGrNUIRE7Hn37/E32ZKpnxYzT+r
	 YfRXFuhlHzDfh7TMK97aw6N0GqQU01ye8HvhUFMWqdPpL3bzTorWwSX4WJXz4kO+7Lxka
	 3Psk+z0GTaDSGiq2RyFEMp8mvBQVmbklxv6v8ncfZVCxlNLC0UHUM7TLtDuDyoedvR8zv
	 7Hfon0Yvlx29G7NgOsIp+NKkdSLMPt9NVTGeI1xiDZ9N5X4bNUmdtAeLKSP/srC6H3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613793;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID;
	bh=uL0wexTpBvvxPFLQS2o/E2x5EBsGxSN2nfZQHwNTq3w=;
	b=o7ZnMenN6afBLJy5wqxXJ7gswmG+GvVSwuirKTegDSpi5kWoBUIli/gZoC1AcVareBC1
	 WFNWXFu3xbxSumghfccRy8EL0pkNVnpe+opL0NXCRaKjrxuRqBjgEUR1O574y8vImKk9J
	 1qfI30ZBLQMCKs3DiJgWUTBobQ0r2D3k9FNPNKC5gKdN2ajLQxQoN5T2mk7ahkfWW0DaY
	 fMF76Fj5TB05ysYYKaLA5auirTTMm7MA4NGaAozYhllPJAAhegA9VPkVkc+4bhaLiUG7z
	 ueYq8rZeUdjCzSmbTK9HhXYYjvIlGprRmSOIO+RNeH5B5jYnLVRJ1J+CBlGq0XKpioQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=GBJq0gnX;
	arc=none smtp.remote-ip=205.220.177.32
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F7B60A2609
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67F7B60A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=GBJq0gnX
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A22ip644136644;
	Mon, 2 Nov 2026 10:03:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=uL0we
	xTpBvvxPFLQS2o/E2x5EBsGxSN2nfZQHwNTq3w=; b=GBJq0gnXvQU+lhlAMWJzE
	bMdvAoKIaPo2t8rtUnbJ1PVA5xu8piSihzQTdZCQ0j2SBiq5MEMcLMARAosnunTR
	HBsE8qq40+FDRTQ84h4Pi2KC2U6ZXucWIjAUJ0VdSjvSleqXCyl/V0paJO2Wj3CR
	M60Ar55q4BP5REbiFkhHC5cKHvWGvKhE2jxaIsM4wPPQhPF7AbCgVuYh6ZHE5yIr
	NpdGqonkYfStHDSWZgL8U/XNzo4hbnDMiOvJxW/6DDJiDe2SZRuqQxf/1yDuVGJN
	8arzSBNHVpBPy97zI5sn9tco0qrymziLul2hxMYbPVSgpNhF/z/Wmx7kW27CSJZy
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn6r9skr9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 02 Nov 2026 10:03:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29CqmH2995724;
	Mon, 2 Nov 2026 10:03:09 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4hpqfj9v9n-2;
	Mon, 02 Nov 2026 10:03:08 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Duoming Zhou <duoming@zju.edu.cn>, Paolo Abeni <pabeni@redhat.com>,
        Harshvardhan Jha <harshvardhan.j.jha@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.1.y 2/2] cxgb4: fix use after free bugs caused by circular dependency problem
Date: Mon,  2 Nov 2026 02:03:00 -0800
Message-ID: <20261102100300.1546414-2-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102100300.1546414-1-harshit.m.mogalapalli@oracle.com>
References: <20261102100300.1546414-1-harshit.m.mogalapalli@oracle.com>
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
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020039
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzOSBTYWx0ZWRfX2QqnZa7TS7cZ
 Liejx6DTozS3khtaKPZAolJ2Ek7VLPZvMTxnGh+PztTwery7x+ROp/Ryqvqn9z/g2047RSYYNIo
 46riaVzOTvSnFQdyOoaTNdbhr9N1KZhb4eg92iPPY9BJ6nhbystf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzOSBTYWx0ZWRfX297ZMeRXmLku
 edIICr+juzJGRkwgAWUjvTEClosTgieW7/i2Kd0J55fy0VKngEUQ6ioYNPeoYdnVonML/fGDQXT
 R0AnMQdCAXGOOQ0YTUQfOrblc8PC2QfFxwuhMCzyRhb1VjSEGHlYHirTK4x5okaQKVzq8JfFbWI
 Jcedm9zIgIGfmB1Wo/8/mmxWDHfSZwtJNj9qRAKr3k5+xPIxKx+daYWvE8yw7FysQYXbQ9+tbUg
 9i6ieWj/+F/ANSdwiMYOU26Z26eq3nxFJK8eUfEO7X9GppymE4CeSTok37pL4ZAoLBzB2TyZvDT
 pc6KXYaC8I0rdSwhqrj/fMk9tlKKlDbYwweJnbXTfQMXY1e6YiGstyjN15gX0TSxmJ20qQLLpg1
 J5lBM9psjuEMrhWkqb79rC0bSe/KOezTxJGZCOdH7x54Q5YdsikyOv4gkYsuDCooV8nSaeWkTDO
 NjvrtsqFbYYY2NpiXZQ==
X-Proofpoint-GUID: Sunafrfqi1QXqCqJj6mdlsZPYktxgw5T
X-Authority-Analysis: v=2.4 cv=EdZd0/mC c=1 sm=1 tr=0 ts=6ae85fdd b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=-nKc8X9TPv6IDXWQXpEA:9 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-ORIG-GUID: Sunafrfqi1QXqCqJj6mdlsZPYktxgw5T

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

