Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013043.outbound.protection.outlook.com [40.93.201.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEF737F739
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 03:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785381407; cv=fail; b=q2PYFk4j30EC0IuXBP72wrhV+91n4DSDDShBYD0zFmznCnF7bzgMsKDKsUHg5ZMzEZKi2AtxmxotmET0lCT8fJ9QdDVvuTp9m1V2DivprId6kjyQ+LUQaemSrFVa1qq1+yjmPPE30VnWwQDZiZxRSyvvECCKV6GKfFqcWuNDNe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785381407; c=relaxed/simple;
	bh=HxlDxDQUT24rqOl6UrBJvd+xp1+eTib11MtvbtZfLds=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VU6rCPdyFQgMiFxBw2jp6DFH/CUqKx5lT0kzzy6FgC3zzm87mTm57RslcLPd6J8MIuV9o2TDDt7iuhCQ2sTNHCcT1cATEsuh2oPJjVuW8LR2z4p6iVg9w4Cx9Qw6IfTtOgtdF72WiMUWrjGOndVqmGGJEfOtJcF/jUXPLzeFiaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=t+ShauHZ; arc=fail smtp.client-ip=40.93.201.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="t+ShauHZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Olfc1GgGgHZA3zmGevYvlP6mDvQbTZDiE9Ls1BCoSbCoDx4OunTp5W6DsNhyIwaHYSvxC6vN5qTIoI7OQFH/Biz/kdoV9V27axlvG7qW9kQOPZ48cp6wjgaxwnOBkWKaxT4XD6A7+DdoKIRH9+FI3spzpHdlb//Bd+0PdnRQw5ry12KtW1ib+ALVTJ7yDUiMOLxI40ROdbUaDzv8V9PqmZvmLA11DRj8OifjZNeMkn8SRLY3FvMVYzbxCJyTfoeWNcI5m7R4OIrtJjmuqcZpegSUwFosgoXjB3e8qEx/RHWrtJ7HKLvamOkAQoZ44HFzhSdIGsqfHCVmqfXXUQq5Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOBVx55dsqpvvCj/prt9qlYI+RhTAFDEk04fPWkoZfM=;
 b=V/kDreoUIiWazIw3xA4wUgOmYVhgwl7hYNxMx/V+dpaP9pZXxhwsrgXtlR9Fl1RD40kug+wEwx+mIk1ftKZe1pgZ1fPHsVev/kgCFwQ4q79flZboqhA8/q2cO33FKtwuA0O+Azz5fJdudkOBFXx0Fqjdb7I3jlygmZP5NwOWjwoyRHdt8k3jiytgxcJNl9KAWum6PRgCTdvhIBuFw14MiF/Vxtm5FYdC3miRAPz2JAE5wMJNc0/vmZuCBPomE67E3t2QVTf9ByWAbuaMWL1d00CoxXwiamlh0kW6BIzmj3DRX5mPS6fq8sq9S0zh/IxXeimbg3+wC20f7Kh4y3F03Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOBVx55dsqpvvCj/prt9qlYI+RhTAFDEk04fPWkoZfM=;
 b=t+ShauHZdswUzqw56yf3f4oJLU+6q+vsJ4JqCjIAf5F0qQYtXrcbI1lUXtt6lLetXwmIS0sNboKqjIqjGnyGdj5yhuSvz8q+1+nv1F3I58/OWKjvv8TYJ7s1JyRPGeYeeDsa9Pl9eQpBagZ9zhVhxrsfqQ7zZ9U8D1+mSjAx12WpMosfE0SWB7dSJTAJ0+4LedOGAF4zP6k38uRCgiGHWJe5OD4wXh1/vHLihwS1aQqsElybjZQ5EyUM4LYaERXbBsZDiR2AHYnOaXsNF346EHCY3yxIA9HFbVB+HqRg66Utf8mYgISmDUIf41MUI/Lt8ZtEakg+ryStaSZkn5irvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by PH0PR03MB5703.namprd03.prod.outlook.com (2603:10b6:510:30::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 03:16:42 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 03:16:42 +0000
From: tze.yee.ng@altera.com
To: stable@vger.kernel.org
Subject: [PATCH 5.10.y] firmware: stratix10-svc: fix memory leaks and list corruption bugs
Date: Wed, 29 Jul 2026 20:16:39 -0700
Message-ID: <20260730031639.11452-1-tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <2026072955-cranial-friend-2d3c@gregkh>
References: <2026072955-cranial-friend-2d3c@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::24) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|PH0PR03MB5703:EE_
X-MS-Office365-Filtering-Correlation-Id: bd9b65c1-c1cc-4b93-b3b8-08deede8fa73
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|11063799006|22082099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+6HeN3GyohSqWTMCUditCVmjd+YB6Jn0qYJckmNpIGA2QlmIlfQov1IAJ90r+pxpM3FA6kMjZ28znPzG8r6gkFKn1ks9X+0/KiIHjvPh7LL3IrCjhMCpZ3MgYtdH4WQAw+aX325N1ByARBVlGSYUA5sPuOaZ61YsF0wfIEn1TzPgn9xSJOhcXQTSU6vph7Z0PpR1oeTPxh/qFzNTorpi1au084XTStTZ+7C4kpUATgkibAYN/tUeOj0drzfHKTOhRldlZ5d0SwScMAwVByEwUIo/TxkmbPhhB/esmEzdoSuMIbTH32EKPp2xIvLYISBkEB4MwHGeF0GkxNjGA1vaOLvWpmda4L6T3oWclt9fkQFHrjKTIrxKG2gbYdHnLqJygP0hb8e18p85/xS7JiOK4zMtmfgkL6XHgrBz6mxcIjAM+LlwBjGk86E4PcE7u80bRoYCCWJG0roeROItDdrSRmHJIvai9p57Y2HphCzdTIg7IOM9B8yYnDMVv+7fQz1Str/A3YsO/VxoyHsz51lKtZtMPLnPfJQcbyCVyaTzfZI6sy0Ukudi9PcDTjkczSlE7ZcIfItEv82ZWcYiMuZ4YFyVYL9Mx6hKmh01dHwp/M0j3zhx2PJ8BDrssHY4Pd8rpdLDUXuSpdkRQtst8Jf85Iv7ERhrzRTzR9FgM6+k/Ls=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(22082099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ROMRwwcGMtlQ2SecbWOvZ9JalWIyPKi72DrKbXu0JmL0Mi06sTrBgmmJ3X9P?=
 =?us-ascii?Q?Fr6U9Oks7TSBc9r0WtU42z7hmEILW6Ibz9mjM7xgqlk1IsyLg2yKxknyfbs0?=
 =?us-ascii?Q?8cIBPZ72OYYL8AE6AFidGjO0uwAgnf2MC54MXWMuKyc1pmgDC+7UOcGFqom8?=
 =?us-ascii?Q?KcsWMsyOtvAaKvEbCVnDPcPQtWW1/1V8iOIZM2KuwZBzzLmnZwKjHU1EIvTm?=
 =?us-ascii?Q?vvfNqsniOM1kjrRjJDdFsrbZSBKXHPt+WTLc2m2cS2m1zrzHV7/vc2xsDA1k?=
 =?us-ascii?Q?dVeCMTov7rr1CLt6slNB9JM3vQdBMMh8qv0DHu2wXuSnM6LO4fxt4Rd/ZzLF?=
 =?us-ascii?Q?ESlIabyTN3vMMcn5LNzr8iJBTy3QRq9rTdrXcYhLWzl0qinEPlLwjpHfQ1q1?=
 =?us-ascii?Q?xreRwnH+wABeENaIW9VpVVpdbDt8ceCahEst5FBm0flXFqqCgVvGmf5IWIfK?=
 =?us-ascii?Q?19QlxKc6eGR3w9/auAh6HpER7DQtVDXYkIWnAR8nhg/J0ihVjF6BVF1F3hJn?=
 =?us-ascii?Q?biABXMmgcz4uMns8KAJ+/FA9O/7QGWqut14iOaRAifIuZFLn5g6Yk8021j5k?=
 =?us-ascii?Q?sUG+Wk+DGS08BLzrHdcmDJJZQEGvUXumsjggH+Pd4hV11YKh1cBhrq74Wvb6?=
 =?us-ascii?Q?+FDq3Kih0zisNlJurqIzaqTkzWq+xl7cT9GFI9YAPCaHCfOd3kf5BqDt0tCi?=
 =?us-ascii?Q?azX6ZUX1ZpiUx/KtznNr0+2ekanSw6juNWVPiRB3+c0gkUDePjKC6ws+NwsM?=
 =?us-ascii?Q?5OwR7xUv7YTet7AnoeLjhsXHEFnhkUyTIa+nnbsu7I46jGvM//Q8QRqbjsDG?=
 =?us-ascii?Q?7BXTFlSZV3msHVFsNr+XSxlX4bqZ0mlG0jlLyL7FVbZqq+uO/BRNOjX+LGUC?=
 =?us-ascii?Q?jeMOkkSL9JhLCyVrCZS0eUA0RwHg7FvEuEXn9+QShicUs/8/muxeiE5okYJ+?=
 =?us-ascii?Q?4gngm5a52EGbK55+8/Dw9JrlfSrip18LPdQ7ASQpKmn4zv2idUOQ1cZtoU9s?=
 =?us-ascii?Q?AgaXLaIqkjqwwFtKcS9hKAVINkimoqpzaYz4ywmW5nHefyhP+7U9gsa6eeki?=
 =?us-ascii?Q?Ah3N6BgQmqj0N8mprRz2ydlEJnhVCsYqjRwGhKgfn05qX5Nr7C/RkE5+K5mQ?=
 =?us-ascii?Q?ly+Zmd9T56iFO5v5MG9/3Qy3aBxFC+M7Q7slz8Bmxxz5iQMl3dWKFyfv8RDp?=
 =?us-ascii?Q?yn5kk0dnfXRsy9hOtl2M4U9zTCW70BxAzzocwR9znenFBPH3Fu/d1Izo+JKp?=
 =?us-ascii?Q?BBM/v9IiLI6cSX/XG/tHWbXM3aUiZxHPgI5SBpeARTcbh2/Jv44+2hUny/9s?=
 =?us-ascii?Q?U46+JTYrk0ptHnF3yRHxsHV3KMJN6AsU17GlQQTygjnYEyzGj+VxwvyqOABk?=
 =?us-ascii?Q?m6dWbbIKlAXDBk5zEoY3KmIBf+6Dg0JQtuPhqZdYXYuiCUyGSIEiDqTiWf68?=
 =?us-ascii?Q?D9XqP3VUQnjXYgquLXB7ji/V8qrHQ14N6AsFwg6EbmicdXMh9IQPXWBeRv5W?=
 =?us-ascii?Q?u4k1fzz14/BRkoM/Ac9mx8N429ub6I5Rmp+Fr5AjKSNhzWQC6GsYUhgYKXLD?=
 =?us-ascii?Q?Tl8kKF+BxrGsFg6rc0vXxswfIIVfOM9ZKkKo0O22fG89bMbSJAv6jRe9qoVV?=
 =?us-ascii?Q?p6gPG9lZ6H0lzDcHyklddzPZBJOxd2mAcIuvLJ32qR9Og//nlojWApn0KFEh?=
 =?us-ascii?Q?qPe6/8GuXA0u516Q2DSdhBtxTzjAB04lOIeHQvoe165ZipTPP/dsGZrd/VN/?=
 =?us-ascii?Q?ViE/wFtkAg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9b65c1-c1cc-4b93-b3b8-08deede8fa73
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 03:16:42.6773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: edg5VQWfyZchmLepQAS/iOT2cVcl7S7DBHoM4Htj/ZhBfLc4Y4F2rpIQkH8m/cA4IjsTCktQqg4xHwyKQDFrtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5703

From: Tze Yee Ng <tze.yee.ng@altera.com>

Fix a memory leak when gen_pool_alloc() fails by freeing pmem on the error
path. Switch pmem allocation from devm_kzalloc() to kzalloc() with
explicit kfree() in the free path to match its list-managed lifetime.
Remove the erroneous list_del(&svc_data_mem) which corrupted the list head
on failed lookups.

Fixes: 7ca5ce896524 ("firmware: add Intel Stratix10 service layer driver")
Cc: stable@vger.kernel.org # 5.0+
Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
(cherry picked from commit 9119ceb76e987c2ec2b549ea100e3268ce3a1c7c)
---
 drivers/firmware/stratix10-svc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 6b6a819fcddf..271cff7b9f03 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -911,13 +911,15 @@ void *stratix10_svc_allocate_memory(struct stratix10_svc_chan *chan,
 	struct gen_pool *genpool = chan->ctrl->genpool;
 	size_t s = roundup(size, 1 << genpool->min_alloc_order);
 
-	pmem = devm_kzalloc(chan->ctrl->dev, sizeof(*pmem), GFP_KERNEL);
+	pmem = kzalloc_obj(*pmem);
 	if (!pmem)
 		return ERR_PTR(-ENOMEM);
 
 	va = gen_pool_alloc(genpool, s);
-	if (!va)
+	if (!va) {
+		kfree(pmem);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	memset((void *)va, 0, s);
 	pa = gen_pool_virt_to_phys(genpool, va);
@@ -944,16 +946,17 @@ void stratix10_svc_free_memory(struct stratix10_svc_chan *chan, void *kaddr)
 {
 	struct stratix10_svc_data_mem *pmem;
 
+	guard(mutex)(&svc_mem_lock);
+
 	list_for_each_entry(pmem, &svc_data_mem, node)
 		if (pmem->vaddr == kaddr) {
 			gen_pool_free(chan->ctrl->genpool,
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

