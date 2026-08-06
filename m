Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7057C3F7AAA
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011495; cv=fail; b=RC8TRDZe9y9jNdolTCvoR2m1nTaLPFwciW7zf0/kxYDf1cdpxTpG3ihXgfC4f0lkC7riMrsu2rvudpYMkQoX6j0t5kw6QtUgyI1oeTKQ02bKd51NiGgQdOWf0OmUG6GH7Ja7SieP0KScM6ohnwF1yeAtBbzKXeIBrdA2ykJaAqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011495; c=relaxed/simple;
	bh=uuM6MGb319t3KuCokwfYxlIPnGovAfQANitLc8I6rfE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ftlaNP1Z75/OX64YMGN8oqyu77S4htluE/pxW6CyMvK1QVPTqtU37kik6YV2H8fBFKqxt7Ga0xXySNkZfMe7Rtv3WJOs6zLKWbkQDR16pM4R5rNVXS3/B9jlIw8ITtbnx51f2aiLU37I+XTpBIS4jy5FQuk9Kg1j8mXri2rMhU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=PG3WnIEH; arc=fail smtp.client-ip=52.101.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="PG3WnIEH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOL44JBXhP8Y8V1v+1C5ey/w3n7kcakDkNBcW4+EwfR3RVgQfXZIkVI6xUL8Tu/SE9tsBleBHAeCqE3tNml6VBhKqkpVfvHXBVwRkEZeiV4cLI2GI4MsHZRoWwjv+MziUq9j/XpPpelbjI45t2RDUfoixpT0oF/9KbOed+ROqPlCeHYgFT6d/3NdxcoEbi4tl5mU/nqIDy4wM4YkNSSW9w6VJtgBEGMIaFGQBf5dtJVEk0actJNQg8b0F+teD70/GxfxP7glxnI1kquN8T5BtRHgeP7vL/m3ScsShcYyW8UkFosInurQAFAgcUtaR96meUDyVvFPXIn7Y+FZhMHEAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMHFr/9QWNh0RQp0gPz/rpfowDTXGhfgLcZ++JwMlBw=;
 b=kJwpWrcJeWXHJiFd6dmveplK2H6Tj2gxwMhT1KJv8hFaJDg7wj0owsyz4ttHBw1iYCASDt2w8HT5uB7awnGP5s/M9bLoxI7rDDbkFTuNANm/id8HoEFLPHBANMC9SoHa6PQPpsLs+nMtKaUG4JSJchFA7QF73ysXEsJnPKYNioOcz+KhYO3AkVmx4YAwZEb8Zr9Y20w01FyxJCGI3BUugCs17IY3cX1UwfKzRLWFLfplzQdvFvHz2DHUXP7SpidFph8TJqPaSfiqzSFkZyln/Z/pkGifQnLZ7h5Uv4PgZguIdcBwhAZheDO7okfDS0VNb3Vtcj8BssTZCAWXI9iABw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMHFr/9QWNh0RQp0gPz/rpfowDTXGhfgLcZ++JwMlBw=;
 b=PG3WnIEHbmvlc/Ap9qeeTRd2dDrpVScHyErU+qFhcy7z82J/s14t0usC1zvrKTBx6II36H6CLT8LXOSm1hp6EfeZx85EWg5Y3CKNmPgxsEwqTl+y/JfjiNLsCiHz6a6fcbA2lt26dkWAsF4Gd0Yo5k4p+f6Shf46IrX/JDgCKJsakXwoMvUCN3NxrN8EEl7opNIcGZeaC8qaFnhkS4QKbdN2/ZAq/n+PiY7vzHXWkhHWCJK8yABH8Iw6i4p3qlWAi9qkHOrBhIfcumtuXLO0WM8Po1UNB0BdvX24KhU6OIZduVpSUz91Tt9rYchXkzmWoh7HcGz/v5UGxYh6LJYo9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by PH7PR03MB7195.namprd03.prod.outlook.com (2603:10b6:510:244::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Thu, 6 Aug
 2026 10:18:11 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 10:18:10 +0000
From: tze.yee.ng@altera.com
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] firmware: stratix10-svc: fix memory leaks and list corruption bugs
Date: Thu,  6 Aug 2026 03:18:07 -0700
Message-ID: <d8815b4e8e836313ab8af55d7f897fce5e83e894.1786011370.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::34) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|PH7PR03MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: 0be599ff-c7c4-4e8b-7ca3-08def3a40404
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|55112099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	g7ZTN05qFosa2dkfj4encL1/uIqPnxkRQwKGqLcMxAMdct6DIsscF9J5MTH7TUXhMqrXVGr5HoSa8ocieGG2qpnbeytVYFeFgQ7sl77nfavkozefM9Un1LFITOVKBnu3oRdebRBatW2zUZrP4JJL4DdbrPyaS+PWIEmDnpwFJEcCV6m+qlO1qKdnAmvsqapeFSNFTCQWuXr2qqLke/zitg4Cub+tBWl+Aw709K+nKTyX5UiTz6yyYGXj0AD6hRXv3HNwJilkaeOs2pVNIFaWLCNuXBkWYhylBqsUUiJhPAUTzjyoL2+qb1ZZ9VilUY1W6zLxuibQ3WVW3fse18wAh6M7P7DTaFAmPQcM+nOZDlc5Z1p3qdf2Q14i8lqqTXH8gYB5z9kxt3IgX92/YQFA2kQjfbt2292U9Iz3j7FuKu0TlAw88h6C87i6Z9f7XjfQvU57zGBYgNARdAcxDTCaK1ujOothaZzplcIMmpHZs0fNKoW2gCFb3kJjm0OPHzV3j3JN3ht47djVG3DrUwInkDAIWBlTRfsyzlTYu3hvJ/kkVF5LAdbCyffC7RtMIWtbbK04K0lffpkFbbBFeZ4sNR9Cax6U2G5MAUMO6DIeK3DvagHxxV7ffRm2gV75xsM1K0ghbV/EEW6zmaL0kzoki+trDuZSmaSf7ltEyBHk3Lc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(55112099003)(18002099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RS1VfuEfVuo6kccHINqJnHNpBMmNw9aw8PlO0QsX0rrd7Spva2onHOm8SErK?=
 =?us-ascii?Q?Ig66HBQg9yX3e/aNFkuQdSutaNF81yHfDOnSpJwaq5Ay3BL2OKL5yyeS5Rqx?=
 =?us-ascii?Q?Kp5UKfXSWagIz+mgrC5NHiUbcFQJOONtn7Db9UKGzIhXPRc/EszCIYgnmw/c?=
 =?us-ascii?Q?QCaoAluVXapsKk9ADbcCD5CrR7servFEBSeLvkkN1R68xl05kSBC+MUO6tz4?=
 =?us-ascii?Q?vYkMy4rZxnQCi/3Tn+kuZvErxfxSKhrrcS0T3s53ONonVfjjiCu0yBukAKXB?=
 =?us-ascii?Q?zc/PgnLfZ/D8ziqX7n5qgGxZU/kyKdtyijPt+7Fbv7LZUgvRqHd/PRhEVz0t?=
 =?us-ascii?Q?3NJS8kp2xZvZZILTPDBVZWcBZc/E2zRgLjTvcEeZYY5l3lvEnqcm12iIeBqw?=
 =?us-ascii?Q?l4jE7PqnvEPp5rK8SISKoAdu0yUqiQeZCnvxF+RZNECkJdrPBzwDhwtt6HqR?=
 =?us-ascii?Q?0lWhHCSdxu4vjiKbbxrZEq/uiSSStm8B5jhvhRMWnxJl071DFKduUE/04OM0?=
 =?us-ascii?Q?RIlqtx1atKoQSUYzdcYp8tn5JESypUmYITV1WPkLeI87+7s1aKvu3TAuACu9?=
 =?us-ascii?Q?2I0HQEdpk+RyiGEG5ITX3QO7JjxR27MDrGHEEeHVGiF5Is5NXFqAolUS4JXO?=
 =?us-ascii?Q?FwgWNYEsk0XjDg+jm6356Ogp+qK/R0dUeOfXAD3Jmua0yQD1MB/EVgmy5Dxs?=
 =?us-ascii?Q?iSsxmKajxmLFPk+v63Dv+Hr3yIABcw4oWhRh+YW0NKkjSJ2TD3Uv83B5TfwC?=
 =?us-ascii?Q?uxsupGXT9Wbq+TwbBJZj1z1HSML1PEnXmE6myaobsF2uj+qngsDyZPt/6Jph?=
 =?us-ascii?Q?ijk5yNq68/ynsm3PcVF1KlPwMGx6qOH6R7qWFHkroA1MlR2v0NrDJCz2bFce?=
 =?us-ascii?Q?WjAJbRvlmkf12Z3/MkuqgEh/QjyepG94WfeYBP7kHdmSLdIJ2eH+qocX9STC?=
 =?us-ascii?Q?/j+rXzUvykGjB2GRYui/oomlcg9GbI2kVydsBinz4V3LRM/Vq+D1ZtECoNPm?=
 =?us-ascii?Q?QlxMncbEXpVMKdGNGRLrg8UEHScwWgw/fMeQNsPz5o+Bfw4zWhPK/X0w9sII?=
 =?us-ascii?Q?05ULqhFRbKnnOv9GBlMI7xgfL+5X93QeDD9kXh25UfLlgSaal7QBoBuKVPw9?=
 =?us-ascii?Q?SZZDz1C8cBQDfmuJ8FTNfnlEkFqH0q2/n1AAvuPMCEnn7IpR1V1UqHNTBvK/?=
 =?us-ascii?Q?SumrKBM3nJMqe0ytJhioWcFP6jOZfNfuuXWPwc4CqKapNJziVI/S+GoEPRb5?=
 =?us-ascii?Q?lYaMsZ54TMMkGWMm3inIDhNeB98RZqlvm5YAvsFjaEWEtbXUuUP9EVMXqAcj?=
 =?us-ascii?Q?WGQXoBI/nIYYyFhefkXJFA41HYk8QyhCjjTNiJmPrzQcvkOnxeCGpr2ElnbZ?=
 =?us-ascii?Q?qPWDFQxrM8+RcBwZaJ1/KQpmtFSairoN0Xek0EsATQdaJLmWbaStU8KoodL6?=
 =?us-ascii?Q?/nOJLHyL+6j8Y+lIP8gOGmPmmozG+QnNmizqyQi6ox6UO19XmXcKfZORl2Y9?=
 =?us-ascii?Q?gQdIX4otYt5YrSiOEm5y826JK62lzoq2TeWiODZstwYMY+MxSwHD3i9V2FmL?=
 =?us-ascii?Q?5fYoXjoPyd75wX6fpT6MY93IWpZrpgqBrdoaQeS3U3hMLNj2n2qeISnUGp+Y?=
 =?us-ascii?Q?8U+3QWHnj6sIimdFCgVwcUZ4K2UC5KXGyXhVfgDlTKpf1+NQa+R51S6ox6Gf?=
 =?us-ascii?Q?CtReKhQ42bw1X/+q9zSaMt4gb64f8G6EqtiEO2+GZEQaCs0abN0WTDFOJsA/?=
 =?us-ascii?Q?A4AKDkVeMg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be599ff-c7c4-4e8b-7ca3-08def3a40404
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 10:18:10.3154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9bHkOlKx7JAo01O/LUWRvuWRgeo3O97uH5JoFRmk8ndd4W2QYYMydAu68Y2m9nYVebACtudTUw0o3Gi6l1Zhlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7195

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
index b25d793805ce..c4a709f2bbc7 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1065,14 +1065,16 @@ void *stratix10_svc_allocate_memory(struct stratix10_svc_chan *chan,
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
@@ -1098,6 +1100,7 @@ EXPORT_SYMBOL_GPL(stratix10_svc_allocate_memory);
 void stratix10_svc_free_memory(struct stratix10_svc_chan *chan, void *kaddr)
 {
 	struct stratix10_svc_data_mem *pmem;
+
 	guard(mutex)(&svc_mem_lock);
 
 	list_for_each_entry(pmem, &svc_data_mem, node)
@@ -1106,10 +1109,9 @@ void stratix10_svc_free_memory(struct stratix10_svc_chan *chan, void *kaddr)
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

