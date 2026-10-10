Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012021.outbound.protection.outlook.com [52.101.43.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19A013DDA4;
	Sat, 10 Oct 2026 02:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791598156; cv=fail; b=m0tfQ5DGwC+shtLesYM0dGGhTPTmr7EobzZy2is5OFR+iJf5n48b2xqCl2BWy/KjAOSxrI0a+CDtiNBIGbfC/o+YkP2K4RfDdJGQAPYRNbZSv7ncx/IYZusqGTIFxvyz/kZLuArATRmjNUtd/MgV4aav3niJcWjF7smWrkfw3uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791598156; c=relaxed/simple;
	bh=PDNbeh2PztUdI61y6SGpKbdCCFxiGcL7IoZThsUiyDM=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=iPbomIMqrXAhooRcf1gHMFO8e7P6r0O9nOcyxmPxvneqcRAfbfVjW3kR8flDzfKskrIBSnLnGasXe1MhZTaY1TZL3/55LvDga4/wF+x4A83dHEnHYGr9GTrpuuuz4gZe02Gsfi/+98i7uErL6K/Y4eD+GQoNc41xn4qk2Och3bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=acQAKfxK; arc=fail smtp.client-ip=52.101.43.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="acQAKfxK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqjWXQ6QhFXblCzA/97rzeGmzPRorTk4p02KVg1NeSSN+bxbyW53q0cyG1KvACUb0E/X1YBPXkIZrBC2VXv557OFwa+cTouyNSQopRGCiGJP3xepXY/fEr4IEIax7PjOfoZ7b5ku/JdbagXGqGbNzGMJGB7teIz4NaixbGvg6wcWeAB0wy7OB2nL935F51yzimvL0YRqFvKuqSFdrXTjf3sBAo0TTLMaL22RbpTotzg4FU4AVLMyugi5QJs+6i8ADCopY5AkIJXLQD3SmiSVMDbg+Cku9DbzHywq7Db6c4mU4rJ1v1mGjwPGu3i5XWSMdzQdYvT3N8hUNm23zrcy7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1JtqIIhFvlwYd1Rktcz+I4LepWNe3g9EDOhrtpPY7mo=;
 b=tebZUMjI/TnuRanVncKGWsRwEytrD0xrRq3d72osk3Tbt3WOpHVOU2dNZ4KsFspnncJaYRJN41TxXHRHjMv71JwAiXib6Iu1N65D1OTN0MbOgKzHsKPZNzNQQ+tc6lMSYIigGLz7WdSiXnA4LKnszq2bwPw1ZeHEiZ6EVlFsljubJdLrKWlOCmrA9HxUr1qkmZoARZH5i02YMFBT2hIDrtymUrc5XSph29fX3s40cFkrNcBcGAtVHaIrgP3Vfsoe3i+Ms0eXFm/QwXiGbKSvPMkyMw65ryoTQkLrnq7UB7WSYj62LThM5DC7gDLWubTQYCEjEERqMaTXnQ84F0lYLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1JtqIIhFvlwYd1Rktcz+I4LepWNe3g9EDOhrtpPY7mo=;
 b=acQAKfxKZDugdrlUF2q+sWKV1+WbCJOsfWaztHaEAdx5Q2EjXtVQnWqHrxKPDBUM60HbwDFxGayKXUNnI1HpxSv1ZcO8lrywBfcSbRjRx/06XP7ggIvHo8trZ15imI2eaTojNYJTlrVOJfs1F3YI291MJ8MjnsQ5NMD7OL+ncdAG3JlGJzs1MotlrbsWzdbPmBKwOICNAjcD3QWyGCdrV7Ek1/I/6cAzGMaCnrOjN7t0PpjZRRJJH4fAYISse1d/4tPdFBXA3tnufoIbGv2/R5ItoEUSmaaFIeobFF7R6Yg8xCVuTVis2CszObuig3schejE1FzlcMJmyxlawDJUEw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by FT1PR12MB222952.namprd12.prod.outlook.com (2603:10b6:170:d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Sat, 10 Oct
 2026 02:09:10 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0472.016; Sat, 10 Oct 2026
 02:09:10 +0000
From: Zi Yan <ziy@nvidia.com>
Date: Fri, 09 Oct 2026 22:08:18 -0400
Subject: [PATCH] mm/rmap: don't discard lazyfree THPs at PMD level
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-lazyfree-stable-fix-v1-1-70997958ef8d@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMUQqDMBCE4avIPnchCUWxVyl9SMxot4gtWRWre
 HfT+vgNzL+RIgmUbsVGCbOovIcMeymoefqhA0vMJmdcaY2puffrt00A6+hDD25l4bKqrAvOXOs
 YKT8/CXn+V++P0zqFF5rxl6J9PwCDvdK3dwAAAA==
X-Change-ID: 20261009-lazyfree-stable-fix-67712b2049dd
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
 Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
 Kyle Zeng <kylebot@openai.com>
Cc: stable@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: YQBPR0101CA0180.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:f::23) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|FT1PR12MB222952:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc73243-a3bd-407d-4095-08df267378f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|11063799006|921020|261009223027099003|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/VPuMoe4fKHwqZHh0a7QI/LM/tF866Sl2OeceBgDtrG3qfm+p8HqiRK8W4EhjoWOpDqfq5RO9xTf5j/72CoIgSTvm6hp9A7Dd1riL86xnxXJl9adIJOuuuZfySE/zHvbRYL50/5rgKOMXvVPx5lmzsGAv5tOPLi9EKh25zzNgnt4hfw8mAek9+AvsF1ScAvjiyUD5aglAn8Kotj6smqmvf16MXwE9Ybq8UtDTdPOzeP4VZYI6VUy/OTz/y7ZLKhm9Hp7t8b1rFQcAVP4SZbLNdAP44XrACITwLNg1Au+Yj+4b7RVj8ncNotA99syGVFdnBzhZn9Owzb1YD5y2w8J2HhQSozqNF1YqpXoT0aWMufvKm/HDjhGngZFwJIRiGZ0UQOx4R8dQXZeKt7Ebn32y0etbEnlkuvp2VkEUtMatlmgUK4BfKn57dsu/XuRtAHydEuwUl9tRX6AOBfZl4YyjmH/P+Gaa+XCuCPqvMd+3eG4UO3mKgnsKHiBSJ4aMVLr/v27RbERNGPiHeRVreKV82zusk4IMtSTR830CuCegL1zFkndnE+cHfakMoFSaB1Vwi4pJcBGhylOxsNPHPkkFqAccqiFefz8X5ig6yVnko/U8I+LbN8+IICeTDHtLyTmHnjGYFDuRgbx3CpHbqqNwpcyb/nxD5PgiJHlwilcvYdzfai1uE0Q7PSuWPZoN1wMzmg4edk0HYMd8oQTWXKoGw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(11063799006)(921020)(261009223027099003)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEQ3RE5xano0NEl4WXNPVFlxRW1GNzJRK0FWT1lpaGdIOGVLbkRIOXllKzJW?=
 =?utf-8?B?TGNCK3JlZHA3VG5KaUYvKzF5MHNUelpKQmNPZGp4enJ2emlLNXpRYlFaZjdK?=
 =?utf-8?B?ZzRyYXJKZ3Yzb2pIYkJ4R1hSUXNMSHVVdytRM3JMeFR1MmdzcEdJR1hvczNS?=
 =?utf-8?B?ZzdBWFhmSHFIYXNnWUMzRUMvZ3RBMS9VbHJGTnlSRnlaTEt2ZnRUSTdJVENI?=
 =?utf-8?B?aDNOb3d5dS8rUm1sOEZLT3pCb3ZpWTlqVDFIdjhCNStXTWY2L3RPcktjcEM5?=
 =?utf-8?B?L2gwNGEzbjd4d3hjeVozUVdxTEZ5aU9PdnhLdGwyNmVEWGhxQ2o0YU5IaVV3?=
 =?utf-8?B?Q2YyUnFOQ2NWS2RTbFd2SWoyT1dpY0dHeEsxYkI0Q1ZGOUdGdVl6Uk9XQmd2?=
 =?utf-8?B?REJGald5TXpKTHQxRyttWk1qQjF0eXdsdHFTQUlOQXJmek1wcHJqN0pJVDN6?=
 =?utf-8?B?YUlNb1NwbUdUM0I4K3ZWYTdLSDRIemMxT0dwZWxUeGxZZnZFbXZHYzJ3Z1p6?=
 =?utf-8?B?di91U2JoUXpqQk5yMmszTDZNakk3RFVhQllxNDVNcXpJMzkzZVU0ZUttNUZj?=
 =?utf-8?B?Q0g5dG5HWi9VR3g4L29KZTMxVXZmK3plcXpVYTBqVWw2V0JYTDN6QUZKOWh1?=
 =?utf-8?B?c3Q5dVJuSWxSc25MRmY2Zkt4bzlxeDZKS0FPQ1NDNUIvSE9ueGxqZk92ZGRD?=
 =?utf-8?B?M2x4YzJQY0ZidlMwTVBQTGZzRERrVnZ6WStKZmlHcnhmMWU5RmpUR2xhVDhZ?=
 =?utf-8?B?eFpJWUZkZzlMWEVFUlNFaG5zTmdod2FuYVdReDhsNzloMWZpYVM4R2JKOGxq?=
 =?utf-8?B?T0NqRzA4QlI2MXZueW9HZWFEVVJ0b3hXcTRMU2pJRlRoS1pZUjViTGF4U0ly?=
 =?utf-8?B?RVlrWldrcllLTTd0UlVxc1VDZVIrQ2l1aUF5NGNxWHEwVmJ2SXB3aDJwbWtE?=
 =?utf-8?B?aUZ3cjNQRFBuZE9YZTNHU3VXL3R3TEFoYXoveDFZekZ5ZFJSVG90cGt6RTlH?=
 =?utf-8?B?Vk4xV05tajFGcUtmQUZMR3FTb3U2ckVZcWY4UG5Kb3BFNVZPMmtsdHZrZytp?=
 =?utf-8?B?djE0Z0RjVCt4MVFaZWxreTJiMDd6VHlnUERlaDVJMHo0NSt3c2loZDQ0WmZk?=
 =?utf-8?B?YUhsTzdzVnMrV2RWVEY0Vy9WQ0xkRyt4MU12OWtxOHorWEoxZ1B6ZUZTaE51?=
 =?utf-8?B?K2lMdmJUeXVQSE9DRnVWNlAwZDRYUkhYVFBHZXVYSG1TT0VPZnJUZ0xkSkxn?=
 =?utf-8?B?MTRHVExHejZkK3ZwQ2NKNlQ2MHVLVWIyNEZYR3g2MWZvMkNINFpqTjFRakZG?=
 =?utf-8?B?OEh6Z1lyaTJBYnFGdmpIUVQvL05zNmY2NWZGSTRNYmViUU10aTVCZ1pRKzdP?=
 =?utf-8?B?cVl5dkJLYmFhVWIwcDRCeU9aajY1S2lKODZNYU1ob3pxZ21XTmVvS2x0czI1?=
 =?utf-8?B?dmxydkFrTmw0MUhGM2s0Z2tZYXVnUnVBMTgrVWdLMEpYajNWUUx1czRYelM3?=
 =?utf-8?B?MHNpems1c1VDTGJyV1B3THI5TDBiRUJSZE82ZFdoMi9ESXRKa0dYazV3WlhV?=
 =?utf-8?B?STFuZTBERFM3UU1FbjQ5Skg5dnloMzFLZU1OK2ZMV1B2c2ovS25zWjgyZ2ZN?=
 =?utf-8?B?ODhNb1MwMnRIME1tc1JJZG1iMmxsWFlJV1hxem9zaVVqWnEwTURudXVudUx5?=
 =?utf-8?B?YTVhWjlkY1R2bHg4SlNlTGxOQnIwZmRoNVZrbUVYK1Z3Nnlzd2RkUkxmYnBW?=
 =?utf-8?B?bEdra3FlanJINnZxVzRzT2lNSEpkL0FsYkQySVdqam8yNzdEVk00ZlZSVlkr?=
 =?utf-8?B?TVZMbkNBQ3A5czNWVWZ2YXRJNWpaM1NieHRVbWVLM2hKMHgrN2lhdDd5ZzlO?=
 =?utf-8?B?OUlDQ2I4VWJ2SlVRUHNka0FCakdwRkZyWXYvQkdMYnNBNkRlZ2ptTXhiMnZ5?=
 =?utf-8?B?cFRTUGZtbFBtUmlqTDJRSlp0TGZ5UjAvU3pnUGtLTUNKVkZUU0o3ai9VZVRw?=
 =?utf-8?B?UitXYVdTQll5SURvaTNOWFZmNGY1Y2VWQndTcmcrY2VMZG82RGtwUFVic0xl?=
 =?utf-8?B?MVR3SE1waEhNYjE0TFpFaExUTEtSb01MODZ5aS9yMFRwSXFjMGpHM0J0RS9l?=
 =?utf-8?B?azBmcG9HQ2pnQkNVM0h4SDlFUlhoZUNUVFU4dTQ3cHR0VXBOdG8yRER6VlZH?=
 =?utf-8?B?V3lidWFaTzBXeWhmVEVwelUzdVdIWlBQSEcycGozS05teWJmV2M1dDJ4dmNz?=
 =?utf-8?B?Vm9PN1lUNXlWSkpvbjN5YzY2WGo1SmVVRXZHdHhqQVorRndxU1BCQTFrWWNp?=
 =?utf-8?Q?iAa8m9ZvQH9cWnhWZz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc73243-a3bd-407d-4095-08df267378f0
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 02:09:10.4240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tmC7xF5kGiebkjNT0lUcZxir418w+TSoioOY+XeWJYzkXiyT38xLtRdtecdm5eex
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FT1PR12MB222952

__discard_anon_folio_pmd_locked() clears a lazyfree THP PMD before it knows
whether the folio can be discarded, and restores it if the folio was
redirtied or has extra references. A concurrent munmap() or
MREMAP_DONTUNMAP skips the temporary none PMD and unlinks the VMA from its
anon_vma, so the folio stays mapped after the anon_vma is freed and a later
rmap walk uses the freed anon_vma.

Using an invalidated PMD instead of a cleared one requires additional arch
code fixes. Instead, disable the PMD level discard of lazyfree THPs, as
before commit 735ecdfaf4e8 ("mm/vmscan: avoid split lazyfree THP during
shrink_folio_list()").

Fixes: 735ecdfaf4e8 ("mm/vmscan: avoid split lazyfree THP during shrink_folio_list()")
Reported-by: Kyle Zeng <kylebot@openai.com>
Closes: https://lore.kernel.org/r/20261009165214.40212-2-kylebot@openai.com
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
The proposed fix[1] requires additional arch code fixes[2]. Disable it
first for stable fix. The function will be re-enabled along with arch code
fixes.

Link: https://lore.kernel.org/all/20261009165214.40212-2-kylebot@openai.com/ [1]
Link: https://lore.kernel.org/all/DM0II2QHWWS1.2RXEJXC8S0101@nvidia.com/ [2]
---
 mm/rmap.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 805db93fe0428..1131b76bbbc28 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2275,17 +2275,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		}
 
 		if (!pvmw.pte) {
-			if (folio_test_lazyfree(folio)) {
-				if (unmap_huge_pmd_locked(vma, pvmw.address, pvmw.pmd, folio))
-					goto walk_done;
-				/*
-				 * unmap_huge_pmd_locked has either already marked
-				 * the folio as swap-backed or decided to retain it
-				 * due to GUP or speculative references.
-				 */
-				goto walk_abort;
-			}
-
 			if (flags & TTU_SPLIT_HUGE_PMD) {
 				/*
 				 * We temporarily have to drop the PTL and

---
base-commit: 8b38ed9ab5b09c8ba168cbcc49524e9b380ee5c4
change-id: 20261009-lazyfree-stable-fix-67712b2049dd

Best regards,
--  
Yan, Zi

