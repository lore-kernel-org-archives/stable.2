Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011068.outbound.protection.outlook.com [40.107.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033C836EA8B
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 02:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785378973; cv=fail; b=aAIVdIxsm/aZu4ZbJAMrt2s1301ZVliAXRgQiH8WlUPnypabfr3Xi1cOBYG6AD+z5nafiwQ7VeX+KrzVfu+oeQvTTQkRHpzfUZbpUzFIzb4O+FoOuY5ycuUFfynwMFUMCux05VPMahdpQ8OTiwzMhZU3MccZKIk30yddCxZX4bE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785378973; c=relaxed/simple;
	bh=CXtsiTyAVG/2Qv7HsFxutpkgOKh8CSRSmur+hPoRw2A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zo3eat5Xm7gWDBA78SMhk62cxbAPR9DvBWDgc+2mxaayLiNAQBOjMa+e7MmDOmwjRXQ3AMRc5Qpon98991aIFTqCMvKfv8Zq+dz44ppg97krOz1EQas4Yi7uj05bCH9EJPVTGxDeQuDNyUcv0hp87Cq3YODHbKjVy1seNiVxUGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=qSMyzAWK; arc=fail smtp.client-ip=40.107.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="qSMyzAWK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RwiGL1tptnDdvxefiNB18ItMLRAfh8fPXOa6990DAmf7J8QI9vQMvqxZr+ZgRUdNQ/PG0Yk58kyhyedaMJL/GSbKO8Uig3zTjAGD5DngOsFtFRs4ByYrvxniUY3+x5x3JigQs6saTI3hYrWtvmbp7Nb0hjr7+3IKGY8osVU22ya+KDF0Jmxjv/3ga+H3jN+3yDoe8t9hd9gvaaBlikZBensoOvhpPCwFY4lYc5jnsszWDm3aw2sGCKItNCCzenKUlyBauCmloNdyWkGEiq0tPBOF1Fui9rpN+VKula3PzWxEQdj0XBivHmfO3glVRp47J8SYtBvNnOJ1PClCRRheEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uQlTZrdD255Bi9jjYjAOHsPh3JPAnICbcbLzwG9t/RE=;
 b=Q9G3qH/FZyj9f4BAK9u1Q2XmIVneB59zpWbvysix8tCzoy2Y7iQWQmoMMRnfgq0R6vvwXCHH/rxCG+nt0OTte34l47VeJIcU1xA96jsqbHOtQk/3R5hAxnW71lppas/W6iHePjWDn2TgSrHNhzJM8udsb5MP2xbOUmclSGLASTuiyy9QoHSZiCNalVaicv+vWT1rnEOjYaH4DvLNH2mV/EhqtiI60zMGMIi2Nf/wH0F1o9WwwqB0N4DB78V5SLdJeHnPcSdcAeCBfSKj5njZI/oj86ntzzjhSp2zYqpXGdfaWylUG60NLcsJEYOApeshWbApiK596QsYbaxBmm69bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uQlTZrdD255Bi9jjYjAOHsPh3JPAnICbcbLzwG9t/RE=;
 b=qSMyzAWKSONCDzMfoG94xXC/uimeOTBgTiiIyVgTR8VLUBTVMLulExBmpAGkNzDTHDKL+2eW8xcme3FoQXdatc7YsUgAQigr9obqN1Syy9a4AXp0pLX3inWToDYU9HkaK9XUMgjR7Dvb0to4NNzavDXuQIAy3kkFb++KZJ35OymtmK17euSmA9/GmJeEWzKDYYuo14TVkiPkhnaID4iv9JXGPR702lqFEd3TgHc0mPZ5H6U6dRiXFfMKBBaimRALnyJr9AcL2oirA4HYOl514xKk0Z4JSPIW6C2McaXSGlSFLm4j30pKr6vbxvYTwNzPRRyHsgPhR8tLIqXZKExD2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by MW5PR03MB6879.namprd03.prod.outlook.com (2603:10b6:303:1c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 02:36:07 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 02:36:07 +0000
From: tze.yee.ng@altera.com
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y] firmware: stratix10-svc: fix memory leaks and list corruption bugs
Date: Wed, 29 Jul 2026 19:36:04 -0700
Message-ID: <20260730023604.14996-1-tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <2026072955-anatomist-verdict-df3a@gregkh>
References: <2026072955-anatomist-verdict-df3a@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0138.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::23) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|MW5PR03MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c228bf4-a5a0-4ec2-f8d0-08deede34ec9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|11063799006|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7PpjUtRgKySFb5jvT+lLKVTqecO3PDzA7lhatiFI2mstyA930Lqgzswxh1YaBcAjuFqNOZ+QC9QvE1eApZJ8wLWylRsPsLvexauxsZlvulEv3fT17nPHsl7Tw+y5Hx3+RYU7YsHNVLK3cD7qbc5YIyS4G22pL521o0SpF+QVkzxiaF+vJQLaBdTXLgh4U6VQfKeltJzZp1CyZooZCNdzQkogjHCYzrilheguKewigdqlwh0GLBTvVcHVl/zXE8Zs6+tTTuNubYXDmSrjCq720P2MpCupRQKlkA4feKlrpRgq2Z2dUJEMQtbg+5CReAfktwzaoXdKPKtTrXB5BAQWbR9wCTsvQ4ZA2N/zH1/JGXP3TBcp6F/yqVyRK/Zi5YTCpQilmnB4cA0I81rv7KQUu9ZjupJQelNVadCUcCze8nyGSgYrKdglv9MzqwTxrZuftajLraRrhL2X1iMv/PfFdlq0fs2J+lMtihOy4aVYqNZSgvF89bpB+qCJOB1jKPAHCGx9Sf0iEDi28xY/HwQsK6X4vxAnCSJTkeF3XcjvclKvf3qLgROU+dfCqYJlXtzty6R9X9kOrF9xKF0AWBhB0IiI4OVmvlQct6Uu0YYcQ2LSQuaRHTO66gTIUx0W54gk7X3Dd8Smc5+9ndJUwqfpFs2IMx1MUJ2UyvJKg3fDaUs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?53+mtWIDM8afOFKl7hlft5wALR+e8wELI/+L4KUWRdgwboQ6weWv9T2smCIV?=
 =?us-ascii?Q?8h9IVECABNEThjDMOHuLJ5DoKP0fDxc2uG07+P7WFn9D9FyKXdReX+AujTrs?=
 =?us-ascii?Q?M8+WaNPZrmTrlgce+JLM0dqcW54b0Q1i8yGzVqrvWufutBSlwnPvI4EnpIMC?=
 =?us-ascii?Q?VcK7ODDCk/4Q4672ZN14Tp2HbA5zdGPslXiKYrINfm9zfUoYaQbg944obt+6?=
 =?us-ascii?Q?dOtVd0/xBuu/SElwTlV3jpovLdzFbSTEmnvGR/nFCvYLDgSuTGIEWqQEFSaT?=
 =?us-ascii?Q?piwQaUUNvS4xKZUfYTa1bBhIdtbcsCho+rnQnH6lT2tHVNg2T07ek/DCEi9O?=
 =?us-ascii?Q?tueJrHq/cILlGuPM7JaF/8YJQ1CuoFZwVKK7sXt56/nmvWhfSDfr/uB319oO?=
 =?us-ascii?Q?Ik5r9yVge8kHGYQ129UAxfstqttJDBHULZ68d+TtSGTes13ixBH6o9+ueMzI?=
 =?us-ascii?Q?MQjBLPP3jI+7iVwII0Ykjuy+xR7m7Bh4EFXx4dNvY51fs3pi9NBKryCvPq2+?=
 =?us-ascii?Q?eCZA56Nt2tPoVyaqa0vx4xXfOj3rUxC2HXPRL1DxrTb5AEuxh+tzAHrTnU14?=
 =?us-ascii?Q?TsgFMzmhUqdNYFpXsu0gG9GReJ/B0xK62GRN4jUqllWtaIS6nakj0avA/OtT?=
 =?us-ascii?Q?ppkWMkYJF11HQA9Fk4Y/f/Gx1h2erFjk1PBV/NVAbnNjiLMP1kk6QmuZdAVu?=
 =?us-ascii?Q?JM81u6r9XTDPrUpv/74dLgE246UwE7Wo9Rppfn1ED2Lyf2HsQYpRwykGBVvd?=
 =?us-ascii?Q?B+yHOYYswPZG7bYL/HbN26WZ5Orywe9CPllWUY+X8ZvRQG2nu13g61b2pvsQ?=
 =?us-ascii?Q?OMTImWP2Nki2h5yaU1bDcO9F/uuJArrzHDxBrBdlJihDvVK3hELLgmPls0x4?=
 =?us-ascii?Q?hGiR4PQ9N8T+Q/uoWSyxXFpsLq1PAwmk0OOVaymNb4jpDbIZpwnqZuZy0X1O?=
 =?us-ascii?Q?E7DrZmAcLY3qRzJjwjujfc63mxFhuDfPBMj7awtbaV5w9rYDQP8WmKI1NZHF?=
 =?us-ascii?Q?USEwELcq5527AFls4nM17wdtmsNhDI9ffs99E+tziDmga/FTPxnXLg3hRzwj?=
 =?us-ascii?Q?WsIWt4/p8S2sjQpbU2r8HqjLmKfAKUMCcE/TW3uwoZJ67FSogrrzv8zkLO4U?=
 =?us-ascii?Q?Fagrn4RcaEkF7x8ZhmZBG/DLma8tUOSzUfHCUr152GYVemcrpB+h7dDmPdoE?=
 =?us-ascii?Q?oEuktZxwsVJWSac57PS/o6A0+mr5JPcSJ8XEAWiRopoXeLGgkWy7+X3vefSb?=
 =?us-ascii?Q?sw2WdRq7APGXFPSqeIhhIZMKvXAn+FQkHaSicVtpbgVQoToWAX7WkzmioZB1?=
 =?us-ascii?Q?8DFgh9zbWmIrakkYQ5wnbqSJpjC3bR2ys6UfE3GWj0X6lS4Ow2AOuioqD5jU?=
 =?us-ascii?Q?WOwK0k2fNXJbcLrJTmmLx6zyz5BZRZeor/JDQIiSrD+SSBGiAEiMr4HpmNBK?=
 =?us-ascii?Q?MieMjGaIJTEiJYSSiL3pn68U9YXArgmpVSK0E8f+MlvySLIy0ACzlr/b0k0h?=
 =?us-ascii?Q?TPg3NEmQ9exbi3gesufWc1jxoVwPyRBSU04J9VOJEuDDgl0m21Ep2yBedEej?=
 =?us-ascii?Q?3VX185+xOolrpP37ttu8RYX4CiV68f8khKBzJwo72GO2OkTK5ogneS39ukx7?=
 =?us-ascii?Q?mqqRtxyogrtYt+totmY2KPlp8f54oTmkIQKl+30ACUtXTqhaVrSQz6c2wpnz?=
 =?us-ascii?Q?HX1E0KZXsU4a25i0FWv/1bRrAY5IrIn+AkzD5VgHjmV0/kAR+9ojQddyqB9f?=
 =?us-ascii?Q?rhxXIvLPxg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c228bf4-a5a0-4ec2-f8d0-08deede34ec9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 02:36:07.0659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wv0ufkGgxiKAiZjdJdxVJvWwtHCcTuOpqssm7NMhB5pspFyYNJ/OYTbxQkZIaWrZm203BYOAXASYE41IPjCicw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6879

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
index 993ef210169c..ac9c6fcfe504 100644
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

