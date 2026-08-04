Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D4475801
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 08:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785833954; cv=fail; b=DKYpGk2xZWh+nnGaRJWRHv0cYbiad0ynecu9NxRazdvaaEtCg11b32pnDucJ7ajvpt/AX1aWGsjT7fUqVYF157Hwgmdd0MjxzBoYxKFGJglZgBlxUxPShQbgb+td2Ig7fPxa4yBT3TjbEFHfMAEo+QoHBcrflprmjklYYE8XEkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785833954; c=relaxed/simple;
	bh=vzicSzl0um0kQ1cInEBC8fbdZYeX1GnNPHdUcQtgdnk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VeYO5AN/da1bb3xqg3cLIksAFhBdFRKvuzUY9VgDbHAdf8KrFvNPXieNwC7nZiDVjp2FsECI71/HNhgMnTmzFr+ln9Fmr23ADWpeg9YqlmfvqsDyR276s4O6CkBgtDqhYcGT7IG6gOWWmcQ+0bsAcP+fJ2wJuk4xjF4l6EynRvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=JWl/43+S; arc=fail smtp.client-ip=52.101.52.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="JWl/43+S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBv3kTmg9sK8F+P7dswnlB8CHUXsYnqvYUDlA3yryG+1BnDBmA7/czeSBXprByYH1Whs05gXAz2fm2HHDlz7dM01XzwvqD6tjrFRuTg6vbSq8r0ehhEkEzmbR8mB3vHlVlUaCS7O4isIO8oFCQ+H5V4kqmWhkYkfZN71yU++nmGoNrqvrh138WVrr3T9SVU2W82RhbpTLR2u5/pFaN5JgTvuq+ce+L1HsqbDzCVxv9qYUrqpI1nWg7LNj8AZuAY7wvGsSKI+OltA2GehNZy2zuJr9GUMMiH53YLYqysD9y5jcZmBE91gakBs7crXbbf7D5U9/T1n8YH2RQOHyXZWAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUSyxnm9+/zVfjo0GEKgz+lyaGzHwemBc/anBclQVeY=;
 b=mOBXLXYeyzjfFtiFS2//CDypDjggRYMQ6qLwsAySSk2SKLy6sZ/mfvuGmq0l195U7aPTm0q4NBNdooG0U+F5kdolPkm1tWWDDxTCDakU0W2VgKXZ5+iok+rB/1+3sDdLfYZdtbvZ5Gag2VVteiWB8y/8WDQkQgPBOZB9LPWRzIfvfP8cdqs44xR24PaL7+7gT3YqN7rvQvb9xWl15YLmSbw1VFBq9APNNxwVueg50sIrLqHHbNI9EVbgrV4i4Dlu3iufZRTB4tVolHgTrsfQbCNsXfJ8HPO9wa3IzX7ct9fk59gC6uk0D50RKfRnFY7P0pQIigGrloSpTtrRjKR27A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUSyxnm9+/zVfjo0GEKgz+lyaGzHwemBc/anBclQVeY=;
 b=JWl/43+SZ5hgLjrTj1LIpTWn+m4vMSfRC0fhDcrS7rNjeyUPhyOqeedBVoJowkyJ+jqObfVw/3cRjcp0pxOvch4VOCNH6NiXnvCgp6Y/2NbhSXUvIyrCldfbwENCAKaBAN67NpJC/vYutRt5OhUZyriBRBYFhQbMThGhiazrDJs8bvLIBhz/MkygJfxURwpuA43U6p4ZiqZXP3niXO1Lx/IczMzi3MmpGO5ND6yc2Nw55zA9I6IS/c/CFPpBu0t37Nrl7ZcAPms0nE7C+kKPa9lWPggD90M4sxR1XlodtTSX1SB6rUwAbKt1p0KeXr/pSJSBTgaIWKKzdpWavu4GDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by MN6PR03MB7597.namprd03.prod.outlook.com (2603:10b6:208:4f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 08:59:09 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 08:59:08 +0000
From: tze.yee.ng@altera.com
To: stable@vger.kernel.org
Subject: [PATCH v2 5.10.y] firmware: stratix10-svc: fix memory leaks and list corruption bugs
Date: Tue,  4 Aug 2026 01:59:01 -0700
Message-ID: <7ddb7d1021fe8261a7a3d163ee78d345c6ea78fa.1785833566.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <2026072955-cranial-friend-2d3c@gregkh>
References: <2026072955-cranial-friend-2d3c@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0045.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::20) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|MN6PR03MB7597:EE_
X-MS-Office365-Filtering-Correlation-Id: 353e1613-f366-4105-7a32-08def206a2d5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|55112099003|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	sSRf4DzfSNkVDvd6FehZ4RP1PO+0JDVs0t0h6hTSZ7e2Kw4TYSVZvMQUW6aZsQJ33Evp9hiamroEVcLS4OEsIEm6CjlVBomZL4EKQyus+m2roeIkC+oGKeAc6EZgJ8KbgIEjzXDekXiW8b3r+1wJhjV0ysErq4uYdf90Jy6epWZng5ik95v3h4zYQEPDt7hPYfFDbTte3t8qHTOjIttsb4MC2VJc5zM1xuuaUSh2LTYV/VB726eTR7Ho1zREPe0aGzmnr9DTxARtzMRlXg+KfmNk5cUbYCWTkZHthFO7jWLUcAJ9lE8HQtdXR5lfSW3tN7D5OBm0i2vgN81gMLtlWc5Q3oyKDOqDdub5xGgdLeMcwhPCZoZJz05GsQvLNiUsxbl/yIMi048hwt/XPeKjdZduuM5XPjX3kI0Kdfs0Ho1Rqpdob18iBfSok34Ba0mR0bcB8cjdIsrFHFyYhXLzMKC6WPQK8073EhEVq5aHE7h0rAL3jesAAwb/GWw2oNKzY8rMd1C+0KEzwww1B1o3KwhABfsOOWZYWTWoYvy0iYqSuLtmFarN161fuxHng0q6PSVSOytfjm/hgITOwhR+8JsntamluLBlAfo7/jpwsWCd6/G9K39um/yJKpAujhu0JMPvMmyQ0lUim6wD3TDmnIDNC+Ym3Povxq7Cl4Bpj8E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(55112099003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q4sdpTpCIN5CzSnEhmNWX4G+USfrISYYoPumarUQtgHtigELRCyhqzx4f+cU?=
 =?us-ascii?Q?1nLEi5oJiyMdP0FE3G4y3pmACc6jKCrUs9VMT3QPra3295gZXMIy2jVBCqDx?=
 =?us-ascii?Q?OKYpLaKk6U/DuTcVTxcSff6TUd0MdkGVXvj2eAyAeFLL4Nny0VpJjOmTH0Zu?=
 =?us-ascii?Q?NapRq0S8Msd+slmXxMYVRHpvASbKGRZQ0ZqxAwwgvyRlQIwpm9Qngayzxur6?=
 =?us-ascii?Q?OzKLeZYoRo0EbLM4qKw/qpFYoa47aKQAHBy1EYFOe1YUW9/AL0nOua3oydkp?=
 =?us-ascii?Q?vsY+BequCQEkP0e4Kh6xOOKaFuD4QaMwdR2k4WXzqlYxeEqYXqvedyO3wXTq?=
 =?us-ascii?Q?GAbqZwdvv04KUCG5G5CydNN34wOIpXhNPtRVp3AKZPlrGmeU/LvYJLD4tYCS?=
 =?us-ascii?Q?UelLi1HObOL4h6g7jkMrmFSEw3lhldtO9byeCxJ3G+z45mp8dnQml5UJ4NhJ?=
 =?us-ascii?Q?sNbUQ6RSl7lSFICy86Lo9XEXkgkpBPJAtcJ8RT8LtJ+id5u3dft569T9K03P?=
 =?us-ascii?Q?hXEf8pnfTueffsfK8rg9kEIzF9z9OQW2uVipl24LnzA6z1rTyBVQBF/IQVXh?=
 =?us-ascii?Q?uzyXCWHtCFQwEYc6Jz7Y8th7lu5eDxaLh3E+mO4w0dw+zd+wWMTEnbLoRTCb?=
 =?us-ascii?Q?5Dps0Ie5OKIC6YU8frKbHhBL+FVhXT3N25ZoiOQodczWEAbvGZ3n/ewbagKw?=
 =?us-ascii?Q?Arl+9cNKbv1TDWysACg5mYelkaF8gjyXUfkcPugok/9dC9AIqU5nKcWB8zp2?=
 =?us-ascii?Q?sGCJojaHLlMQnlEjfNPXfLy2GQpW/K93t6WOEXqWT8e7g7vw4v2FwGDHjmSp?=
 =?us-ascii?Q?0o+/UZFcJf5K3mxwrsDjzZ63ypiZFCXvAElrAZm6DJB5OPtDhpwMd9YUvGwD?=
 =?us-ascii?Q?As8llxdKvX9bmlVTPMoLBUUSuMDTbHaGhayfxbDZ/j85UeXs3wHycn2Jvv7L?=
 =?us-ascii?Q?wDxHaatVFyc+guoVEgKgkNXQ/+4Rn/tI3V6mE+k2wXXEe+pWOgYH5POXiZJu?=
 =?us-ascii?Q?B6+EXo78YyF7dzfTQJ6wYcgtMscvnku+jIcTrR6+95YvAi3fh1jSDuN0hvnq?=
 =?us-ascii?Q?3qtRQoSHSmsJCol4GrnG9gWqlz08ZE99fbaPU6wPW+gt34rFFwRyUIS7cfxn?=
 =?us-ascii?Q?NGpJmL/bubKFoIkhevlWb1vEch/Z1VAWV1TNLWBNtH0zGuda2nJGZqt2SZUd?=
 =?us-ascii?Q?iYVFE8oM2P50Hpkt2GM4/NJCKmhW4FXVfbjJg8wwHSVOAu/s7Lj/DA9uP4d+?=
 =?us-ascii?Q?nbQMZUtmkaD87SbPYCqp0u7Lv4Ixlld3Re1iG6ctrpoy1Nmq5wE7iEfOsxCY?=
 =?us-ascii?Q?iEFKTfesAcVZ98zEajgIxtlcgoKs999gs1rH9dwVcUA/rfnOVY8i37hx5zMd?=
 =?us-ascii?Q?/hRUqwwe/GaXZVoiB965mfdzDpMxv3Ss+ouHE6Czs8twhqYFFhwByyOC1mC5?=
 =?us-ascii?Q?jUsUSu8rxzk/aDRYqoilH7BqUWhTJOfsAYNnn7xW54TbyH78f1JmPS5/hqOS?=
 =?us-ascii?Q?sC9ecmrOxC/UuHHmfCi2MFfI1gyzwfLfuX+Kv15SyWWvxU8z3lrbX3Ig52IH?=
 =?us-ascii?Q?HT+HYGZJVZOSHjaGg/pP0313+hLCRq//dICgLHi1CysMScV3/eQU/X3j/Gfy?=
 =?us-ascii?Q?HzysdeI5z80FX03ZFHL9I/OPDhihl9ZpGIG0X7nguxB5Vcw5yaPPeLlHNRzY?=
 =?us-ascii?Q?Dx2fV1zH1NfnZzEK2sZH7uOaXvbN3Ly05dBmr60Mqdi7jT/FrZ47LwwuQ7Ib?=
 =?us-ascii?Q?a6LI/zpVYA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353e1613-f366-4105-7a32-08def206a2d5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 08:59:08.8597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxJ0raxhKxsQoG7sgP0q8UGpXxJMKrRDYdjJxdoTiBJwrFignMzyjh32xtwzNGy8Q+e6NCGuqJdYv+aNt9+E0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7597

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
index 6b6a819fcddf..ae6d942ab2d7 100644
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

