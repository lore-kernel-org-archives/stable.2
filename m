Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010018.outbound.protection.outlook.com [52.101.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1939438475
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011907; cv=fail; b=adMlViYVf3KPgi41WJ83Sq8x40nSq1ir8E/n7C+vxEyTrB+Ms298H1K3WpfAeiQF7h3em3xvzYGiDL4Pujvd7z2eNh30cgFKLZrEfH5hS83dyRP33onxJt1BKFmS9rPT9ge5qJNrNEPoT/yQ/b0ynQR2c/IU2QuzY2XVYh3grVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011907; c=relaxed/simple;
	bh=ai2GO8erxhNP73tVY2AYpy0Wa/fUYBn3JwrUxrQgSsY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FeChg1r/IAGxed/83j+iIg6C6o7N+Qr5SCvdaGVihJZTa0z9095Rq3wXW0RbZ6BMo72d0p3l7AvETk0rTGN66R+slZoZUA8Z56LR6GW3vM7ZV5LjIanzSp27pd8wfIQdj75TI3ixzjk0vtguGf3QgOrO68pK5xq6+ssbIq2OstQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=bSarkqM3; arc=fail smtp.client-ip=52.101.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="bSarkqM3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+7E/6wyeCccWIMHQhNv8DFwqpJwrPUl+7MONXNtjc4o3icUorRPcF513AlZzW4uMpT7+fZYNSxab6e+CLwoK80Ue1x+1eag3/iWG+nUNLMKd4Xx16byECW52Nf9G5DejhC7wg5vwvSNenuG0IvFHhzrbjuxzi8QkW2e3FV+09FTHkVfBpBRPodRHBNARPA1n1zUzekp8GKHDcbzaBShQ/Y91+jY4kK9G/p6ojJvFkUHRhoMiF5zrJSn3KxGNsbzyiP3qRLSN5Kx5AYdQmFxkhje9PV8S5nJJVpBWpaJlJsYSz+uGbKuloH4FNZCxRwYzmpT2ZwkVwIynLOusgfqRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hu4raOUjfGwoIrMPYYDPzGbsbw/RXEAmkZM5/Jl94I=;
 b=Xi//w1e3ZFt9bRGd6Vi6oEOpwBpsCnlyQEknmq/8wYqICTkkSzvS8A2IyqGm/DsP5czeAfbKtfAPd3cPZz2np/ueFk4PHgI1WND/sG2AZNj0PHfQwKs1as2RwmP09UqRCs34gAwOGdLmhm21W3qImZXqdLnDFzXHeUcBjlJbkN92ic2HHABs/rfrAKBdeRB0qxbm0jJd3wIdemW44AiUqIQTi1z34/6bkCGYbxdDjSKNnFs8Z5tVsxVo1ZtXw+KeARPw5EIckLwBFdyUL5CnOe4ZU2Wf72/P2XuFCU+Ck/5YbTDl87CkfZpIr7cYyZILnnWhtjmv1/6RtAqw7sWjfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hu4raOUjfGwoIrMPYYDPzGbsbw/RXEAmkZM5/Jl94I=;
 b=bSarkqM3LnNbv5TyRnFmvXddoH086u2AUri4HWC5BjrtRtEgFBcJbWi/DWBh6X7Upgfvf5p5ujvDnAS2rWSBcQ/Ego6AyyC0cEZhsk46qqzlNu8vlvsX3eid4V35QlRVl4hMT5ce8zo7Zd9Nv04xUrLcf3Yh73zIdxx6oneSbxd/w5nx9XOYK453wEzqxGZqmB4bK3wWhg6y0GkKi6vGluspXPbuMY+WbH4GVjI6xVAXL0gmKjIw6YnV4VcB1pRFJuEvyY4djECfua+OR7S/GKgONCGBelvFdaqetPvCSpBmRm1CUcOYqVO8z/si2bZgTzZJHN3+t428jHkA/JdmvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SA3PR03MB7319.namprd03.prod.outlook.com (2603:10b6:806:394::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 10:25:03 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 10:25:01 +0000
From: tze.yee.ng@altera.com
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6] firmware: stratix10-svc: fix memory leaks and list corruption bugs
Date: Thu,  6 Aug 2026 03:24:58 -0700
Message-ID: <0aa42c4df344a1300c13638c023d37983687b21e.1786011787.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0232.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::27) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SA3PR03MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ec7b696-bdb2-469b-698c-08def3a4f88f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|11063799006|10067099003|56012099006|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	2BIe5Snyv2JSFPGX/EFnjUvbJlcjE9nb6KFTrbCJarOszSiW7NcvLy87jtNW3HPlKqDnCPTICtGK73V6nh/fZdAfkZ1XnJTflecT/SbMZteIh36c7V0vcujJunAO8nhpHu1LuxZ0pDaAsCinA1tVei4vTqIo9EFmK/G0TvM1BZKCyIOs9E7mjJlY/VDIq3zgM/tVlFU7oGI1RzHpK8sU28ILm1lkSl1XKcYcgoldY5v5umQBut6HGOqPPcQmZSVh434b73qThgfksLqj+FjVzFQSUjgCkwKzdXhfo1w7n/LiHiLzK0jG1bfLW7ZEzeyp0+vk90RG6yMiCvRxaG+89ia+tqzJEJeVdwykW9Z2fobEwCKji/yu4Gn/zRJDg8PV7Sv7rq3AcnGrezyqSMm27VLvE6FhxYtKFef/mpYtlv7aU0tjPR0wZQ/H2GBHQhHcBYkni79h81lqk1pelFRR+qky5XXhTk9oQvJbDRX9RVY4gCnP5mU5h3ci6slrZDvcgE5z9LDi3EALB3rgnOl0oH1x7KmbZHskEw/3wfJw0aIOV4lCIeNwFNdkdcY9Av84eHR62flk+Uo/IGBN+2mtNtIKC8cjGv9G3wgNzT9iiUR6XdGV5XYXRo9j1mfpA6/+6ieCTUHe1GVGeBRhR3vCw7dxutlwagRvr8HzefLT1MY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(11063799006)(10067099003)(56012099006)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MU3VBnyWqbH+akyoGkU0m+bkrLNhrh11pWaFK56PfCADuAAnCz3rSgRGd2kC?=
 =?us-ascii?Q?hLV5lVXuoWjO/NFgQAAUvZYJvA7xCb4ZACt8mxpN2SjuqqOe54OQIaFlXc3Z?=
 =?us-ascii?Q?b/pYArOxuHCExvTTE44Hzd1DqlcEyfft7infa7fSFE9yTEdC6njJmrcSfeu4?=
 =?us-ascii?Q?CH4G3YoBYtjsdcsgdkCHMYkktvnv3NlHslT2pLtiIt7+nrhLtWnYaK0B0yTB?=
 =?us-ascii?Q?g14O2bnDDwcmW1CsuNAoutyaJ0quh+eVNwIMU+2nbCg20AaHSzAEOF/aq08T?=
 =?us-ascii?Q?WsxHFISOdnnUPvslVaLEo50ILJmMg2yKM4CH+vfVz3wXQGf6Oy9E/9F22g1P?=
 =?us-ascii?Q?jgvURVUOonGsHaFdUucQJzGaFjty4q5J9IcBwPGi5hxhsezlQ2HNW1SC4lJp?=
 =?us-ascii?Q?8/ygfiouoKPMzeXiTzmXdp2FQmUAaxcaTPb6FWA3O6G0y6e4EVT4cX+/mL4F?=
 =?us-ascii?Q?CVcu+1+NRbkycF0UwrM/52gzQ4p2uCZcOVUnxOVL27d3hgUe7lXi3/mhxLab?=
 =?us-ascii?Q?SNJT8zJFqsV/NXHlqay5hZTock8y1DdMK/KNasp66tOxR2SE/xKCFaciPRWA?=
 =?us-ascii?Q?0HCoGBvGrabvRUu5wZu3fKv6Lu+fXgUmvrNmEj1bqQ8dw7QOfowOlPh0mTW3?=
 =?us-ascii?Q?KlkY8Y8tRFko1kLt7p2NCoQkCwfM3rhHRuWK7rahjIs9TSwLVRPUBgJAbirP?=
 =?us-ascii?Q?xbqJaqUA8WJfDa5i45lKVr8QmgwLdn3UkPGtvWCBqiL6Dwm1GzjzpYvD1t00?=
 =?us-ascii?Q?2Ia8RVqbSmJP9cNU1EwTGzo5NLYpMRTuqOF87OCdNaLcev4/2Vs3WTCWzMD6?=
 =?us-ascii?Q?tluoFAtIaN+CwpjoHyARauqYfzKo1Q8HhfarpwUghhL5yc+ae9v4R8gMPdKu?=
 =?us-ascii?Q?FoKp4foxAYJkJ08QBqGqukOx9sqY4Bx/L8dAIR6yp2TbMonobEmk6a6XaAHC?=
 =?us-ascii?Q?7gkX+f4D2OPfT+fHdzyWgz9zfqpQJUyOgVqeGl37MpOOPliejraOTRQtDp+N?=
 =?us-ascii?Q?UyNdNALzkw9HrK6CJpCbm+nv/2TsAbyPPdBzL0fvjinciEx11mQruoa512gN?=
 =?us-ascii?Q?poXSXMGG5NhuEg/+aB6E8WrBHjGjb9Q3Wmc11tLJv40XYfkQCzPdwWhXdqvj?=
 =?us-ascii?Q?wjuHoHcOpjpLN4+b+eGrf+OidFIr85rzUTLKi0m06N9R4YtXEbzEb2rq4Xl/?=
 =?us-ascii?Q?nqVN49vu4ZdlPk7zTldhvmp9GSXx1Z+H7V8zM9UmcxpuHD+cvtFR5/Jb+g5y?=
 =?us-ascii?Q?sfGM4iNJ8eDggY3LdHy14tk7jYjaW9XxV9luv4H9AzdDpmRTxisLL3TjVkP9?=
 =?us-ascii?Q?HFSIDesmaqzEX5hPdI+QE1Otuf+cNMJKq0/1eM61lftq0o5tVdhvpnl/AWc0?=
 =?us-ascii?Q?OPtdsKxTDDMHdliXtSkPumwZzW6G2e3gmfkP0AN6Qr/FaVq3O4qEefEhiex2?=
 =?us-ascii?Q?tgawTZFLUvtELfVo37FEseUuuyH2sfL1hDedCG9JivcRxJ80YEoIKHLwI/7R?=
 =?us-ascii?Q?wEobM31OQqruu9sxpUC+ShmkRCERios5D13WpaOeSD5Wk7esQHrLaaO4nTQz?=
 =?us-ascii?Q?e/l9y6oKIor/U9spNX0d9IuAIADQqcMG1qtZYsFWbwIACRX0SFlXmd+9QRhC?=
 =?us-ascii?Q?UX0P/FbEG7Z6lAGp2iNvII750Tox7bGzpH1MKHO8FWsDa5WEtVwainLu3nIK?=
 =?us-ascii?Q?okc2/glLfjVrvo9Kb8jhWaqedAQrcW18I1Gq31tuR8bsPowLhyi/eaLs1J6k?=
 =?us-ascii?Q?kpWrEAMMQg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec7b696-bdb2-469b-698c-08def3a4f88f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 10:25:00.9641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tgGqxyeWK18F86gIKd3eJhxV+86w0Jbkgl4PaG7SUBiMOHETu5AlBKrzstgIaQSbfN4O/Ows/TV4tay4cfCw+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7319

From: Tze Yee Ng <tze.yee.ng@altera.com>

Fix a memory leak when gen_pool_alloc() fails by freeing pmem on the error
path. Switch pmem allocation from devm_kzalloc() to kzalloc() with
explicit kfree() in the free path to match its list-managed lifetime.
Remove the erroneous list_del(&svc_data_mem) which corrupted the list head
on failed lookups.

Fixes: 7ca5ce896524 ("firmware: add Intel Stratix10 service layer driver")
Cc: stable@vger.kernel.org#5.0+
Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
(cherry picked from commit 9119ceb76e987c2ec2b549ea100e3268ce3a1c7c)
---
 drivers/firmware/stratix10-svc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 2f263d1a6bd1..f723869c5b2d 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1083,14 +1083,16 @@ void *stratix10_svc_allocate_memory(struct stratix10_svc_chan *chan,
 	struct gen_pool *genpool = chan->ctrl->genpool;
 	size_t s = roundup(size, 1 << genpool->min_alloc_order);
 
-	pmem = devm_kzalloc(chan->ctrl->dev, sizeof(*pmem), GFP_KERNEL);
+	pmem = kzalloc(sizeof(*pmem), GFP_KERNEL);
 	if (!pmem)
 		return ERR_PTR(-ENOMEM);
 
 	guard(mutex)(&svc_mem_lock);
 	va = gen_pool_alloc(genpool, s);
-	if (!va)
+	if (!va) {
+		kfree(pmem);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	memset((void *)va, 0, s);
 	pa = gen_pool_virt_to_phys(genpool, va);
@@ -1116,6 +1118,7 @@ EXPORT_SYMBOL_GPL(stratix10_svc_allocate_memory);
 void stratix10_svc_free_memory(struct stratix10_svc_chan *chan, void *kaddr)
 {
 	struct stratix10_svc_data_mem *pmem;
+
 	guard(mutex)(&svc_mem_lock);
 
 	list_for_each_entry(pmem, &svc_data_mem, node)
@@ -1124,10 +1127,9 @@ void stratix10_svc_free_memory(struct stratix10_svc_chan *chan, void *kaddr)
 				       (unsigned long)kaddr, pmem->size);
 			pmem->vaddr = NULL;
 			list_del(&pmem->node);
+			kfree(pmem);
 			return;
 		}
-
-	list_del(&svc_data_mem);
 }
 EXPORT_SYMBOL_GPL(stratix10_svc_free_memory);
 
-- 
2.43.7

