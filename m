Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A0A2E7367;
	Tue, 16 Jun 2026 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781620296; cv=none; b=sOt+uvavQVgapbjQAGatk93mlGN+1u18AwcIjY/rueUQbFFECA+N9DP9bcDstETZaa6o35h0XiB53R/xtOPz6c115x2P7rUwO5GUhaFYafcfiLf+iYh58/FwJcAVfzm3+wgezE3BfwfdkEP47+IvmH5EM1jyMkaz0lSA0hW5jvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781620296; c=relaxed/simple;
	bh=S22LKOa2QssFN6e4vQn3hkibTDSKIiIgf0agqlJ4J2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IDEZOfd/vm0es9sDDC/J9BzOp7j9IjlQ7s93Psm21N+wgLl2CZAbIHyLoYhJhyy0Z1ZhqQC5Dxt57jV4rTSYAplTy8APIB07abvPIMO2SAf7ljZDmlWijahzjXWs35N1qAQ3rdsV9MbsdrHvVYahb5+S0p6MvDAiFwnNPm83V14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Xqfx3tyd; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Xqfx3tyd"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GEIGMo1763950;
	Tue, 16 Jun 2026 14:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=yfsJLx3AzxPAjmyYxa3xQtCxnzMfmYeeWDoqcIhkI
	XI=; b=Xqfx3tyd5fMnOYuJQD5vIayi63W27dhKKT2i3L+S3sdqMccrWEBlUh5rG
	RpQwCR/iWsPwQ9Y4bOiXNEFhPnjy/bLt5r54u6ImiLxjDMg4Pl92k37Cr0D8Q9ic
	mI0Msny1aa6QFqT6FF7QVqiIWHN4V4E3YpnAuvupuoIWW3yqG2zizKxngIqnDPIX
	HK/xUA+aQf6p2woWLqxDDtKmJAJ4zJT+1DQPlyNmjTOez0CUhnHKnuvo+uMyNYfi
	S4nwv4CHZWipFTBbPbJue18ZwHu0Mm4oWe+CLfFU9xEWtU4hBmibkNEt164sweJC
	mtu+Zmf0y+sLuXfvCfqbrKXozaLzw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es23np57g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 14:31:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GEJaSW010401;
	Tue, 16 Jun 2026 14:31:24 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4esm7y3hss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 14:31:24 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GEVNYP8716872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 14:31:23 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 564B55804E;
	Tue, 16 Jun 2026 14:31:23 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B034258054;
	Tue, 16 Jun 2026 14:31:22 +0000 (GMT)
Received: from ltcrain119-lp2.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 14:31:22 +0000 (GMT)
From: wenxiong@linux.ibm.com
To: linux-block@vger.kernel.org, axboe@kernel.dk
Cc: tom.leiming@gmail.com, yukuai@fygo.io, stable@vger.kernel.org,
        wenxiong@us.ibm.com, Wen Xiong <wenxiong@linux.ibm.com>
Subject: [PATCH V2]block: Remove redundant plug in __submit_bio()
Date: Tue, 16 Jun 2026 10:31:21 -0400
Message-ID: <20260616143121.878021-1-wenxiong@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a315e3d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=msvfNpiPRe6fYSCHkfsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE0NSBTYWx0ZWRfXxZrP8twHDWqs
 rb2r8fuDMaVlJfh0J5VF7rZK49AyHmvckzM1fQd/YB6uw9M5mr1Zsw4jdtYDaCA4Sc+7yB8oCOw
 kMwrty57c+6Svg42KDMQnIP42+CNWZZ9RhO3uXzhwUe6JnEv44J59LCnx3YaN2cCAtx4vshwWeC
 NHm7u6fx6LavbQtrQn63FwYazluerWC6UTcK2ag5bq3mI3RL78PYEKObloCYNgZibUP0BXpMxRl
 G/yOGDFiTO8yCt5s+9vNhL0BbnGsWNXyzGU8GPOlWtYhbmUGmZY33mj4I/b03nC4OTuGVkjUULl
 93EMhDXWpWRSfKYeSYi8szcd4qh+tduplnwgX1xruHBTz1dCIDVHrc+RLlDoafnoelbRFRgSm5d
 BCK0HLASDyL3cV8zeg6KvgKSDCxnXu1whoMM/8zS3TkOP0XRH24Io/TJTk9vjlilxJJJ/FWcIv/
 LUwEe3jppAcdaUtP6aQ==
X-Proofpoint-GUID: E07H0UIdpciIf_-pTdZFLG60Kx3ydEgU
X-Proofpoint-ORIG-GUID: pSHATEIRlJweh0kssYPhpwLo7BVsL4Xi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE0NSBTYWx0ZWRfX0Td7Mq5zNqjg
 l3r1TmI8BgQhVb4OlRaXFukSlFkvg++DyYvdrh4qwynEuG6NJ476j+GjsmdY/osYqn1MvxBi90D
 tDSPcNHWCcHiRF6mvbCS4XGDnxVDnbw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1011 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160145

From: Wen Xiong <wenxiong@linux.ibm.com>

The patch removes the automatic plug/unplug operations from __submit_bio()
that were added to cache nsecs time when no explicit plug is used.

The plug mechanism is most effective when batching multiple I/O
operations together. Creating a plug for every bio submission
provides minimal benefit while adding function call overhead and
stack usage for every I/O operation.

Below is performance comparison with the latest upstream kernel.

Iotype  qd nj  rmix  mpstat busy  mpstat busy without plug
Randrw  1  20  100       53%                 24%
Randrw  1  40  100       70%                 24%
Randrw  1  20  70        40%                 24%
Randrw  1  40  70        60%                 26%
Randrw  1  20  0         14%                 6%
Randrw  1  40  0         20%                 7%

Fixes: 060406c61c7c ("block: add plug while submitting IO")
Signed-off-by: Wen Xiong <wenxiong@linux.ibm.com>
Reviewed-by: Ming Lei <tom.leiming@gmail.com>
---
 block/blk-core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 73a41df98c9a..365641266c9e 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -669,11 +669,6 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
 
 static void __submit_bio(struct bio *bio)
 {
-	/* If plug is not used, add new plug here to cache nsecs time. */
-	struct blk_plug plug;
-
-	blk_start_plug(&plug);
-
 	if (!bdev_test_flag(bio->bi_bdev, BD_HAS_SUBMIT_BIO)) {
 		blk_mq_submit_bio(bio);
 	} else if (likely(bio_queue_enter(bio) == 0)) {
@@ -686,8 +681,6 @@ static void __submit_bio(struct bio *bio)
 			disk->fops->submit_bio(bio);
 		blk_queue_exit(disk->queue);
 	}
-
-	blk_finish_plug(&plug);
 }
 
 /*
-- 
2.52.0

