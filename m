Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4FD48382E;
	Fri, 25 Sep 2026 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790340966; cv=none; b=e0J0EG0CDDI3FDrAnofUyCnNYlOsg+SIqP6T+9QPXQe/4LeczNRw4ol6QkPFMNJlbWv5fUqA0qSKm6WqLnFD9PjXzHldEPRLLcHcqDWKRCd/It23NmQzURtd7qoAPe4P1tP54RZcFnf2rZJg/tP5Ey00DRJtHCSZ1XrYPXx6Ujc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790340966; c=relaxed/simple;
	bh=D096dryHKrWj3LBepXAlWMyewApQY5jzztYlMxINOnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XFBljUbfS+BBIaUhyCDCTgC+vqklPFJAPTfpibFjtBUouje26rgI1XCpvxzTYEGqlnx2e8ZgYPuEWx52K4jkWrppV4XwWO21P9b5uqyau9ZqXrcZHxzFS2ytxQdxe2QkJYup6zKvXqA9Ogs4jImTlIqZyMZnjIgRBwpv2EU7K/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GGyrdl0f; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GGyrdl0f"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OLMmIA1513496;
	Fri, 25 Sep 2026 12:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=mUg5BDojxXm0bkgUyXGo25cg/QJGZ
	Pwsw9qxyTyKxI0=; b=GGyrdl0fLi8eBX+apkslI+PMm/sGujIfUSNHu4y5Me3Lt
	kPrPPt57Zwm3JpZRBJh1vp8zMdIme1ILgZLYvEBJWgCo0z+Dj/ilEESb3msrVR8Z
	tjhhNYH2BI9tCZZT4es1mKdAi5Y76hT9S6DuS6vJQCrS1KE+MnWQ+DSmym1Y12Sg
	/fR0VQEDh6kxFmHQVK2PhXLslNVtgk9dwMatZz6nRr1eqtzc1yyjJKIgjQY5wKJq
	LNb93KAD9FJAZkDfZYhU7uapKvj0b8iSMRBN8zSRpn2j82sOKbFuQPOQ86ePSecM
	uFMQt2Mdf9HS5KrjKdluJdAgfY/SnhaZT2XaKt5pQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4gsk2d98bp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 12:55:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 68PCo1L3039573;
	Fri, 25 Sep 2026 12:55:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gtegq8x7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 12:55:49 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 68PCtntT014933;
	Fri, 25 Sep 2026 12:55:49 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4gtegq8x79-1;
	Fri, 25 Sep 2026 12:55:49 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, error27@gmail.com,
        harshit.m.mogalapalli@oracle.com, stable@vger.kernel.org
Subject: [PATCH 1/2] mtd: virt-concat: unlink concat node before freeing it
Date: Fri, 25 Sep 2026 05:55:44 -0700
Message-ID: <20260925125546.1020149-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.52.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA1MSBTYWx0ZWRfX3yqLDIWnizZF
 EYIfwhFc0+HB8X7VD+v4+2Q0wh5D5Ht4tyBk+DaLLBYZZHQ0qQyueS/EFYOQWXhh3hwLOCVXMnd
 BNcMUdctElbZLWfHPUceELO9RVGth24xQYJfxxuTyGfv2ziOgT2OBTkwh1xYGKvfJFRfKD3P0o7
 IRGWZVOTI8Yz3SqOsPMqiGImZEBbweofr3GDVbSOBn7Xth2ef+BTRj5Yh3Sb36dMjC9e8W8RMj3
 I5IZMRSiIc4/rBBxBpeXIYCJ/2X77jwuDJ0lOGyjUKT4MQS1CNiA83+R9wwpik4C53cDQiizs13
 uULYgHcesMLeOt/NHJBMTakjH+BbW+FUKJhCDanuf85YJhw2/27gk3EQu71HmRhPzoPkztczOjy
 YstZbfjvRa0JVAC5wjY0ZrRiE7mx5HtHKW7LEdDP+z3D4hoKXdkAgCm3FC93jrS9OcMpJeIMBpG
 +MJYqbmElvq6RGQK5ZA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA1MSBTYWx0ZWRfX84TUhippg9QL
 RIu4lL2Xw2BwHAVxl9SSnacY3rNt6l4Ltbz7MFIJnfNjmIw7TLYMgBQivq/S8GNXVtY8H7ScNy9
 6axXp4fNm2X8iFc7qCTEJmAHP0a+V1zLdSQbEvLXyhZFQdxwX/vs
X-Proofpoint-ORIG-GUID: LaPCtExoA6xX3mkGIaMqK18F9FP7nmBu
X-Authority-Analysis: v=2.4 cv=f+Ddl+yM c=1 sm=1 tr=0 ts=6ab66f56 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=sl9Z5FRMRRGf1EUxCFUA:9
X-Proofpoint-GUID: LaPCtExoA6xX3mkGIaMqK18F9FP7nmBu

mtd_virt_concat_create_item() links each new mtd_virt_concat_node to
concat_node_list. mtd_virt_concat_destroy() later frees the node after
destroying its concatenated MTD device, but fails to unlink it. A later
list traversal dereferences the freed node, causing a use-after-free.

Remove the node from concat_node_list before freeing it.

Fixes: 43db6366fc2d ("mtd: Add driver for concatenating devices")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6, smatch
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
Was performing static analysis with smatch and found this.
---
 drivers/mtd/mtd_virt_concat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/mtd_virt_concat.c b/drivers/mtd/mtd_virt_concat.c
index 25cf33fe1ec1..1443f0e4c7cb 100644
--- a/drivers/mtd/mtd_virt_concat.c
+++ b/drivers/mtd/mtd_virt_concat.c
@@ -130,6 +130,7 @@ int mtd_virt_concat_destroy(struct mtd_info *mtd)
 			mtd_concat_destroy(&concat->mtd);
 		}
 
+		list_del(&item->head);
 		for (idx = 0; idx < item->count; idx++)
 			of_node_put(item->nodes[idx]);
 
-- 
2.52.0

