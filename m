Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5AF49BD96;
	Fri, 25 Sep 2026 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340967; cv=none; b=UZO5/1af82gmG9siSya/yhrsnRFkg0UV73It6R6k8TdBx+ENo9kw/8aMkphygMBt4ATFVGi2fwr3gdgKjJWrqCyonxH4Qa9wceQufhVR73QsyTo/lWmaejDLssey7uhZpja2F4yCGFpMz1NBiwYNelm//Wc6+5YzYKyWt163Xts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340967; c=relaxed/simple;
	bh=M5ab6c+p8U71b/A4WXpDIxiZbFTTgzocIpJjVcjRFgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffrFIl8zAKOcpBWYfGsMwszCpMD7RimatdxhPMx8J0upG6LcOWcHjnSMsd5Jk8eRf1wvh7HbKPEibtDpmEKhXN/vr7JXiHNioEfIy7N1K9wmTXbJpp2dl4aZLU/bZFz2lbILNJ1GdVUGMoUc3nZMQez6hsxkkXa7yQVj6HSamrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=K0x/Cwmo; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="K0x/Cwmo"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OLNAMk1261706;
	Fri, 25 Sep 2026 12:55:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=1Uydq
	wKWdiCfTSeBY06yakwPq3SOJpnWGQ1hziRUXVk=; b=K0x/CwmoSftU9fidqxDci
	rk1mY0scaOQerIGqKMMjHpO6rvt7YA7W3Mj5iKgWnEbavZnxKiCAVhyuHsSjZFFM
	NZHKE0Cff3NLurjh3PKLnlmQP7ZMjTViCvibWs0LDhmwuQnp3E/hL/QJjnae65wW
	B/f/DiUWlNcl9IYoga5CC4Z5/nInBrKcRypBIWLUyvqW/HosDEhX4k2Pm9Ytl1Ep
	K/9ff5qc148dxLviASOSmDyc30VerCCwaIZ5oF/yX1hwIPVvD3ed5DHMJ7fa4bNw
	15gt7IIRW/PUy+YJbSNxUuVrYf5cG3JfBwAOVZao2ZpdjYc5ZmBnkyNt5ttHZm+b
	A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk2199f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 12:55:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68PCo3rE039769;
	Fri, 25 Sep 2026 12:55:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gtegq8x8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 12:55:52 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68PCtntV014933;
	Fri, 25 Sep 2026 12:55:51 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4gtegq8x79-2;
	Fri, 25 Sep 2026 12:55:51 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, error27@gmail.com,
        harshit.m.mogalapalli@oracle.com, stable@vger.kernel.org
Subject: [PATCH 2/2] mtd: virt-concat: unlink discarded items before freeing
Date: Fri, 25 Sep 2026 05:55:45 -0700
Message-ID: <20260925125546.1020149-2-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260925125546.1020149-1-harshit.m.mogalapalli@oracle.com>
References: <20260925125546.1020149-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2609040000 definitions=main-2609250051
X-Authority-Analysis: v=2.4 cv=APP6TA4N c=1 sm=1 tr=0 ts=6ab66f58 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=GlL9jMAypNo6eQQohVQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1MSBTYWx0ZWRfXzRAtcy7fcCPI
 3w8WshuymCnLQADbUxKKYsEf38K5527ZSZwW/dZ5+iT7E3yMYcFvGt95AdaFv7igms8LMLWjwqp
 Y+Y7edfEmcs4KKzOh3M7xsynu2G72ae2CsClEodTHU7tUZX9WDsH
X-Proofpoint-ORIG-GUID: LOYQb3nmMcBUNgkhVwv0P70Z_AfKoK6g
X-Proofpoint-GUID: LOYQb3nmMcBUNgkhVwv0P70Z_AfKoK6g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1MSBTYWx0ZWRfX2+o5E+9E+jHh
 stxA2QFxcCK2upO+CNnTnT+8GdCFd3YNhO/2M46cNP3umEnnCDpR0c5zWMZjoOYyI3JDis89/W9
 e515ngkptScxACM9R8cAlPmjsbNtIxnKnFppDj9OLjXqXXnRVBuS/49PCP7uiSX/jhee4M7BYS8
 cgdLOqrMnDHBLxdfcG+pCV7NhQ0KPhtqMDwjA41U2scfZKK4K5CHBXe6VoDqlmHFrIlI3Xj1At+
 mIW6CY3xZB0iwzb5xagfWISndRJ+xou+ogwqjkFK5+3k4qYBE0K7Ws1B62g7Bq2EtWPcogQltyd
 F73AeT8QDz58nIIPp3ByHuafSzl5YnRO3BJMdTIw4BlidM2GyINZa7LvQ3YH5xnnbr+2814CHcN
 Pqupo88O/q6qC7PT2K0Jfsu1Tnwlju5ifNgyFD/FWx/vGYVfoD3nx8fXE5XKSuvZbzfSLo4P/SS
 iyS52QoOkOwdG+A+LYQ==

mtd_virt_concat_destroy_items() frees each item without removing it
from concat_node_list. list_for_each_entry_safe() protects the
current traversal, but concat_node_list still points to the freed
items afterward.

The function also unwinds errors from mtd_virt_concat_node_create().

A later initialization can traverse a freed item in
mtd_is_part_concat(), causing a use-after-free.

Unlink each item before freeing it.

Fixes: 43db6366fc2d ("mtd: Add driver for concatenating devices")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6, smatch
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
Was writing a Smatch check for list APIs and found this. Only compile
tested.
---
 drivers/mtd/mtd_virt_concat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/mtd_virt_concat.c b/drivers/mtd/mtd_virt_concat.c
index 1443f0e4c7cb..40b300021dda 100644
--- a/drivers/mtd/mtd_virt_concat.c
+++ b/drivers/mtd/mtd_virt_concat.c
@@ -202,6 +202,7 @@ void mtd_virt_concat_destroy_items(void)
 	int i;
 
 	list_for_each_entry_safe(item, temp, &concat_node_list, head) {
+		list_del(&item->head);
 		for (i = 0; i < item->count; i++)
 			of_node_put(item->nodes[i]);
 
-- 
2.52.0

