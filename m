Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012027.outbound.protection.outlook.com [52.101.43.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF7D442FBA
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 11:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785842227; cv=fail; b=YnFe17LaiLO5U+PMec1URkMCEGWkDuEp1HQkkNxAMqnS4QUX3+OXfLTPuj/gw+In81fdc28UrryxCMRFclmQaY5b/GLtQkXXrm4Ygr+tkbQIFXezXJ2zn1SBB1O+1vL71/uXiiiZWtoprRiCwxjSrKkWYx0BkOVL2cWMf7IePEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785842227; c=relaxed/simple;
	bh=CQVVxzLfe8jQ2ZtfpAsR3N26/rpvWauFDPkNegaCUSI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tRdXY9FYrRUn+kgJ+ThRb/yQY2zxhKLEHS8442lWrxPYRLSaGvprn521MZOsNEx/ZW+XqEtFVlCDejTjYN6l0cnyCGYgGSkrwL5WGc8BbvN0nIJ61Sto7gzZC2J8OaWTlkJpIpFmsYpiWA7UANfE+fdynr5ajPfVLQqmg7d/NSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=E9cGXECK; arc=fail smtp.client-ip=52.101.43.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="E9cGXECK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ns6bV3pJZu4EGJjwQzmNOQ1n4w8ShMBd53ohH4CLqgeycFOynHPz3L8Zqd70xm3/ydlTctXjsxWBn8MD2CPZPMhPyYohGmOqji/jZTgpjxrVZ3a3iQGmhJPZ+PqjVGza/gCOowUu9DIYIEt8vMpQ8hfNLARiwcgnI6rHrHl2hpTTm45vEufT6Me2Q8JyJXkIIWTERry2XDXH9MW5xCDnzBUTZPeF5QM1hlYc4dSAfQnatpQmFODcWsUkTX/Sr4auEh3Rdad+T6/HFN4B74nOupSbb+iFadldQ2xbOYO8MbW1RhGJGEVVBtIx4YbqW9fDubmcZNintifsl6ZnIk/w5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d0ICMzrhNo8+PEJ902uwXvb/6s+DpgNcpT//t/eF2XQ=;
 b=IYOhyiH37753S/Vh9ymQKdhObkGu56cNModMjcgyYIE8QhiyUVHMbVX6cJn4rayNG3hxhcqBsIf3qyRiGcJMe9doj126vTcJL/S1bdJsEUMifH07nSfEcxiWrxMu7cC0lAMlnozjAo5l+ulk/HPMF2AmaTmjqPL9NG3rJsSg3PSbfSwEPqzHUFwIiitTgLy7fZ2t3ijcpqT3FNcxojw/8VTRVu1GYuGZoCSIlKWmfa3KzB14yqonvRl6X2+w9y6k0fbZK7AXdckHLdwBD+Bb/8sbwiKnvq1eSPn148QgCYnLcMoXb9nwE1kPXl26rFnLbMB+liDtIG9Nz4On3p3GhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0ICMzrhNo8+PEJ902uwXvb/6s+DpgNcpT//t/eF2XQ=;
 b=E9cGXECKxbc7/SMg7cLfYA2p9sBhNjvyaMVrDn0NWXOmkODA7s+s/MM2JNr9t0YbnOaImh76AYpl4YvO7WtNJE8fZZhG2HS6zbKZw9Oh5jl3Kdq/zdfsQjRKnKhLQc+RDFAqXM+p6z+BwpBgL+NQjghCF9zsRu5ScNFubs0Z4pykpReh6YlEZgRWEnEZNDuLvfxPmY+qdOaikb/zZebwD5Um8CsR/HrwcH8/9M5MYuTKJs25Pffb4UYK9bHXb85P4dwRE5i5GcwBVW1vqT0/3QNaEJaB46bUl7LBap1I6+GUTLO3a1mo1z5FJGVKSB54pQcHXSP2zVk66x/g9FfIig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SJ0PR03MB6501.namprd03.prod.outlook.com (2603:10b6:a03:386::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 11:17:04 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 11:17:04 +0000
From: tze.yee.ng@altera.com
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y v2] firmware: stratix10-svc: fix memory leaks and list corruption bugs
Date: Tue,  4 Aug 2026 04:17:00 -0700
Message-ID: <3136c976de3cf030e1d9d96b38fb68fde3e0e5cf.1785842041.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <2026072955-anatomist-verdict-df3a@gregkh>
References: <2026072955-anatomist-verdict-df3a@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::19) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SJ0PR03MB6501:EE_
X-MS-Office365-Filtering-Correlation-Id: 41afd927-0884-4dc6-4a45-08def219e8ea
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|56012099006|10067099003|11063799006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info:
	G+TRASwt0NQw/UCdUCSGsyl0MffxtSEVj2Yfia3hLAmu9VlObs1FnDWFcEbqzAHWkmXzgljwkdK92IuAeVQ/u/s+x+Tx/fT9Qq+7F2whpWOM6R+F3S/H0IP1Fouc6qT4aGgMfO/9PWZ89d7ngnhfEvi3vd+V3LuRVI5Tzv/CtmmsRqPfWudfvwVZRCnvAy3v/iMNqyufMXz12WfXWv0VlxSSTF0wWvueC3KuxNraBmsge/+OwlOnIW8nsLmel+/AuppC+LAi5qQXjpVf+D2fNt/Ee+srXJDTi2UTSSJ9ZodcU/Ob6Eg9kuT08zb8COCqn1ZZWY5LBcA2/ivFR02aFvuwK9A2yWpYi6Pu/m2A5zYjIOA7YGh/qlwuvTqJzaJuCW2LunPHlOuKtLaA7A980PCiCylKQ12oxKImqfH2KjcSjFQrQzLoFlBqpiQ7KklQZbwQ5tcq+tJWcuBCM0mo2IubH+S7xHvKezLyaOylVZ7RgeZG49nqAVftVuwGYRv3/mXP7gSiiTX5mNK+OBfKyYy/0SeLj1wKwJ6Iup/6tgdCg/QWP+fDBl36dkBebzVdvcR20L0APDGt8eCaUJTCQXncYyZqWQSKraKHJV4K2R6O4KMdy23WNggeNTyTLO3AzhJHDZmI9F1eys3rL2uat29MirhNqakB5so2DMcxcy0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JGxOEMnHP2m8P8RNPm30tU3/WxDBQD2vjA+sDV4W+beWOMy7NDDo9BqEqAoI?=
 =?us-ascii?Q?K73HOJcUD3VGPPzLbnp1VHKIARmnmW24RDovw0IB+3wzEOjdGU8UavV9BM+4?=
 =?us-ascii?Q?f77obblU4WXED67agvme9wk4UjVX0cWdjOepipubArYtpSdYbycf0cd0cLL8?=
 =?us-ascii?Q?nM9MedEgKqgoxzhK2CXMoru/hNOhGWFmo4nUuggQJMoUqgCzYYIR4/WECvz7?=
 =?us-ascii?Q?ieSxI2kNR1ZMj4qHgxmRadlT9K1RU56gOmk5Bk9Tfb/67Flcs4GdoLFGus0q?=
 =?us-ascii?Q?xj0T/0x4551EaaV2NxtEsvhoEdxpBoZ4rXb/TLsTyXsRXp8clTwyumJV94m5?=
 =?us-ascii?Q?cYOGdyeaX6mPSJfibhbQcZvKcihZzTv+vp9dqp5Mw23qlsDLsRfMS7oxKepE?=
 =?us-ascii?Q?p2rywZpfCtxTxWsmgnmXWsSqh/7h6yykJoQovd5TdnPGrDNLXsg1innlU8+o?=
 =?us-ascii?Q?76qqH4u1dCUChryQFGULwh5bY0zSuv24hNoMFga3kaGzBUky9RT/ignhJ1+e?=
 =?us-ascii?Q?c+L2quDWmv095/yff+HyWHsrN3Q3cTO8GjQ3ocl5CBL7dNlm9GFHJEbuWs/v?=
 =?us-ascii?Q?kDfEaPOROM61ZTlFHwIVwG9SOXZyaDUFaD2+oOGN1O4m8WG2boGxkJLGqs/Q?=
 =?us-ascii?Q?MMEMdkpiersLKvImVkOEB94TXdtfarEYULptXXDbWdIDo+iSRuwN/p3FDf20?=
 =?us-ascii?Q?rxcMXGXxxgUYtXyr/J6Hk8ADZ857G+GAU4dBx8WeJD23HlIdu3aNdi/7Ql//?=
 =?us-ascii?Q?yG1x4zbPU3b788aA4iX/NEp4lsWlwYAMBU84CpZgqQCJK6x5/uN9Nf330qYN?=
 =?us-ascii?Q?reAOZFs4F6ad8NdDw9+gzSlhZHHoXFlQLAhA71VQtK3mMDraakJJ9CZkltPK?=
 =?us-ascii?Q?a7JbKz1fDDS+xynUbqmc0cQlNas1Or8XsvY/JzkIZhIr8vlN+8zRuRDYXObX?=
 =?us-ascii?Q?7Gfj61DA5j9GIB2TzWr57MJeLDKb8vf/PLPOlGhqiBniXE6SqhV94mcriNOA?=
 =?us-ascii?Q?0GUP0I50XWxLrc0w6iY8yKcZYmNceZ9Gg7QNsGR4g70cHGimZhs0HhzdYtXb?=
 =?us-ascii?Q?kHm5J2TwXX7k+LyFmEcynB3f2BEdFJ1nBahaJWQxV/GcFutk9fNp1qYfuq3z?=
 =?us-ascii?Q?PgcLDqBqtmzxZidxyzncAHk7S027oqfthFsxXbGiASAn4drnFMc+wOVX9/za?=
 =?us-ascii?Q?ESbuASS6grhjBhjIwARJQuuk4JzZVGcQSrXJ3eoD/0h2oKGzCOsx6tq3bVgU?=
 =?us-ascii?Q?Bf65Uw2UaHxJ/WXxJdHNr5Cpq0POI6YQiC691lfiG6saezAA84YLQvErGTC9?=
 =?us-ascii?Q?+PcT/OYrmLNP1z4wvejttEs3l9EzxDg7y4adXCeWKPyDr4IerMMcxYPtwDii?=
 =?us-ascii?Q?sfFDYtCgE8WfNxCrcOVpMO93dR/oZhup4eijG+2/fG/mhpJSe1SA4gp/Z+5g?=
 =?us-ascii?Q?2qhavQ0E45BOOeESTMmaVR2UAW1ZLzCn+ObCLLcqQZepeHhQBuK2Ao4YTHcN?=
 =?us-ascii?Q?vWVCw7ObC5sZ4tLLDJ6wr/jS6z3+4cV1de49wXUzwZTNgrZi/9XiO9iId1e5?=
 =?us-ascii?Q?l+hGpeGG9hEo51eNUhUVuRi67y1Vvd5gc1s1/CvMMsfPRVzUkmRAXJWskweN?=
 =?us-ascii?Q?rWkk6di5NljQ1bNyiF1KS4/NqFsH7Wj96++HucGBcHsAa/KwnAzJonUKNDRQ?=
 =?us-ascii?Q?T2gWaqEf+qKcSJ+1Xfytw255rNvzu8O0k5GO41Hlwvb7VI0RFd3xYSted03G?=
 =?us-ascii?Q?Ea36L+h0zQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41afd927-0884-4dc6-4a45-08def219e8ea
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 11:17:04.0169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7W5S0cGdVBA5mJV24Fgzsx8vdUBh1SbUUGpK1awBrH7s9YnWMzsbBQAJtGHlQNGYsQ8EmcHFaQqSghl2o1YlRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6501

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
Changes in v2:
- Replaced kzalloc_obj() with kzalloc(sizeof(*pmem), GFP_KERNEL).
- Dropped the stray guard(mutex)(&svc_mem_lock) which is added
  accidentally when rebase.
---
 drivers/firmware/stratix10-svc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index 993ef210169c..c5ddd20fe4b7 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -911,13 +911,15 @@ void *stratix10_svc_allocate_memory(struct stratix10_svc_chan *chan,
 	struct gen_pool *genpool = chan->ctrl->genpool;
 	size_t s = roundup(size, 1 << genpool->min_alloc_order);
 
-	pmem = devm_kzalloc(chan->ctrl->dev, sizeof(*pmem), GFP_KERNEL);
+	pmem = kzalloc(sizeof(*pmem), GFP_KERNEL);
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
@@ -950,10 +952,9 @@ void stratix10_svc_free_memory(struct stratix10_svc_chan *chan, void *kaddr)
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

