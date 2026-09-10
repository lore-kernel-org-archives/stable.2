Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013029.outbound.protection.outlook.com [40.107.201.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AF438A73B
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 03:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789010059; cv=fail; b=rL1SKJ9epFMs0VrSYVK0q5J860De1xIUpxDXn9RgqDjZ6IQvi+WO6XdL6SivY7vVOpBsORXREeA5JoPNQAPMuKugpsXPHFT7/KI1hph9zEvR/gzY14EFil27j2iZ2rpU4AKz19t4PqahNtomxu96wN4uXL6LbTxSoLoIhop9h/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789010059; c=relaxed/simple;
	bh=aKsJgHvvj6X/mPX721hvn1eERy2Po/WxQwUVohKVb6A=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iEAy3ZzzVu/v0PKZGcGxSPOM1qYs5JIeEjkqpQ0U63FE+R0rmkUpRrdVaLSBPJCxqX956efD+DPOcAbQTwuUPg+0Nnd+XQbQnzUmJ+t6c+hLmP2Z7NCwWm3kzkHl8cXy1DUIPFM5kyj+Cqu4201puuY585exSlW+1s1+byjEf0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=CPmchnZO; arc=fail smtp.client-ip=40.107.201.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="CPmchnZO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4k7dvJDnSwpiVZsoiA7Ym6JVokIUsSNYRLeybcUE8Q4iEmhZ+xZtct+otTtE/AwIGCfEavjdSvo6xeYjrdo9ONMiD33VpRRH4lzmKPj3738dvd6U+ZiLi/ws0fsXz1y5Fjkx3LasnIg/1hODaQtE9zCpkDwGscekVY1VcOorttK6QwUSOqn+BFCl3AzaxjcN/hPeeTnad3/6htIXBvZDwQVvxo53KOeIQDHAIs3xqp6t6gc/cu6tn7Dvc2c0xZJcQs4y0XG2QjK5NABtlUlxN2aoxwGm1pHlsVi6j8Exs8uzDhLSfwW5lTo545Qn4z8CJrILCLTT5bOhsse+VPSzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkuSE1zI5TaII/lvjjLmE3bAcyl0fmmLVXFMoDKDTmk=;
 b=TMycwu10FY6XOJR+tEOouT+PJkpuxOghWpYNL2G3tfmc65fPcZRPD428y8tMBr9pMQr1qKquJrg66QS/e1VzN3SzzAKgiQvCDQWnRTTIJiPdZ40OKoq2uesFbvOAZhfu/OSMyfa5jXZjAiz0RhEnN0XMlWmT60uJ/PoikPFYyvJvFM09RizsSclLbwKRh3OVfyDe16tLoNbMj+iYRFkQZDec2LBKduDv3jIz2ApX84ISOesq9qxgiA3zxDTMaKK3H9xi7eEGFZ1FkxBx7QSHgE+FHCeEbvJhGoy3I/OBYVMmyzC7UiaTNIhmDSEWEFBcZpvMC3WeSJ/epEnRBh2FHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkuSE1zI5TaII/lvjjLmE3bAcyl0fmmLVXFMoDKDTmk=;
 b=CPmchnZOSU1RkZwPX5o8v1nfjuETPTPKtA6nXhU5xxAuNawxWg7fi8g44QoSRKDDWgUZUEJR7hmb3pAvN1PMW5aQr9dSQR1Npef7dZpypJj+ZlqyyHjKc0uhicfIV8AbQnHCxijtm6f2D9lim7IQ3r4rQV+RNEH1FpgRohcaavUumQT82HgpVgmMm5UGAnDm+K1K0V8euDEXZ1cmss4uNqzFAtvzHxyFjKEW3+kRS131I0/Hlp3XXlgCbdawGbCnAMkQOt0TMTJOHZ6Yb1SNIlusoW65LNwvxSeRcxn2JeQYOZWmiZmWCXqpxDvyrYCJz3X6BA5sfU8P06Plrjkqlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by SJ2PR03MB7072.namprd03.prod.outlook.com (2603:10b6:a03:500::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 03:14:10 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 03:14:10 +0000
From: tze.yee.ng@altera.com
To: stable@vger.kernel.org
Subject: [PATCH 5.10.y] firmware: stratix10-svc: Add mutex in stratix10 memory management
Date: Thu, 10 Sep 2026 11:14:06 +0800
Message-ID: <893f8169cc68d614ee36efc9151cc60d0f82872e.1789009964.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0376.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::21) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|SJ2PR03MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: acfa0f0c-d981-4b1b-b3b9-08df0ee9952f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|6133799003|10067099003|11063799006|56012099006|18002099003|55112099003|10063799003;
X-Microsoft-Antispam-Message-Info:
	c7hDQHeyjzXR5BzCnEbeEwDUSsgDHQajRG6XFilZaPjZpGpmgp+JbJHXXQMQLV/LLOJGU2Lt2e6PgE9drhDk6GRTANffn8MPhKezpzUsq4KEmBQYQmzHqQj87xS2UxMK5UZFa2g4e0cyGfS+zs+1BNgZ37RGL27qKfYK4YB+DZ6/I2z4sV2WfNbopiWiU0aPmI/dhs+j9Qo1X3YUlSgc/wOZxW85DvAhZ+kGakMbFPkbyOQw9K2AEL5PM/Q2906Q8pRPpoD0H+dzn8Ed93VZoK+eNUH7oFD/1g2QZf7mn2bYGYoqaX5OuqjlfjJA667wP6gJed3d7no2TSOn9wOWbWqyY8+cyHWZiIGCSV8eb5MfEDNqBVDn6udNKO9lS38abtsopKBPNGF4mTK9skNN0doA7N18SXd56XbT8i70990oUcjAPfqEiclhgq7+lGmpFfQoe1Sgg6MW3gthRus0HkRaAbwcDiRA7WDkcrNNqVVsBv3aS7a5Ls5NhaceRFRtuoNco2eOs2HdMJBh65UtA/W4kdNpBIgUOO8/ITPR2DVmg4K8xnf8TYhErZbplNF7dyH6i3tAuixKGmM4yCRPYQgaHJouUXdqgck1S9kMskxLdXYqZGPIUe3gY3Lfz48vuwvL9Ei0E9PyLcckK4TLjLCi/kvSAWz+3TjniPCWbMs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(55112099003)(10063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8JyNcu6floG7yaBVJggCXLjc5+ewSbC/Aqx/jiqDzoiwFw8jVDlaCpdwQ9IU?=
 =?us-ascii?Q?l7tPtaqTYLRMW3YzTBeb4NcVmomfYIc+MP+r+ziOSvfHTDPcSoDofLDMQFBr?=
 =?us-ascii?Q?kWt3a165oobSNHbM8rohMQGpQ28zUTiNUpfxphxItBc21jzx8d3foEMLsIDc?=
 =?us-ascii?Q?Hv60lfhWqVkKcInQFRnjaYFjUbpyThpEOWPFn8Ixq+EPCHM8SJ39LmnFjFqH?=
 =?us-ascii?Q?ohq/F5NJlVLaEcM+7B3jz/dMBwzbpGqH8aRBLvZQZaQBclztzwLuDVRu5FJ4?=
 =?us-ascii?Q?CQJDBmyXJO5Sv7lXuVHdtukTluMC929BuawNhtPH3/+qLTmeoPfE3yu82VHl?=
 =?us-ascii?Q?FKDEoSMIA2cXyIwnXPWSBPEKrI1dqfC8rNXyg91DhvDdJXWStAS8FmeWZNt6?=
 =?us-ascii?Q?S2ndHQNrjdU0NNpjqnoNz9VM6AdsfZ+dnJIG1ey7iWDcHlv7ofvlGLDiOKNn?=
 =?us-ascii?Q?M+nlmmKrvTdYsBbY7+DwNHwT+pTPgxa58v2Kpm+t5KxnZhOQfV9TISpdBe+V?=
 =?us-ascii?Q?3p7YHmvyWW+Zm1UJirdBWa1dHBI6eHVzB7qkrN89xo1E79T7L9qcW/M9+vlX?=
 =?us-ascii?Q?UkJHvcNnK+jE5meaRRShMU6DTBV4WZemJabm12kR4dCuJ3UBsDJ2xcGxfBzG?=
 =?us-ascii?Q?a9dCXrXdXnh8M6LBkoDsfc4wzIvcn+/l3ayt5lETGZ7K2P3WKnQz2E2RCZGO?=
 =?us-ascii?Q?HSDjSa8iO5wJRj7uSIL2Q3sv2635Xgu63nhKud7GhI5aJVZd0HhSAS87GSxB?=
 =?us-ascii?Q?42+jtK+S5M7DfY474C4YgCpMSMaxhwqwHcdKQoYpKZnVxNMp5lUtA2S4BUub?=
 =?us-ascii?Q?JkUs76pC5D3NfEfgNExqEuGq8lrh3lMmzO7LLy0kFc8yxnUPL3xDLcwdO307?=
 =?us-ascii?Q?7qMtGB1OHHcJQ6rMicSqYB+XefVFqyZsl+G2GeslQBWbyWp7zR5BhksL4nEL?=
 =?us-ascii?Q?bvf6SZKZjyoThajoV7KF/dE7haYAXWyUj5ek0g5yYuT/OFLw2jE7vqouC5YS?=
 =?us-ascii?Q?w/EW68JxnPeOgyxWcqUpal15CjLRlt+Xg9TqQVpwXtf2eRHEGIPI42/NI3Yk?=
 =?us-ascii?Q?kVi9BwGbt4zbyaO39p6PMkkuMdOLuAF1KNEY6yOkCVmdnQzuGFMYwMLFWkEr?=
 =?us-ascii?Q?hxjzlCR9mA/kRqrUbfUSob1xPIVJHIww/kqtA932qN7Ppft20PbQraTygZub?=
 =?us-ascii?Q?G1KvrfnAYaStEJ+IvzlVQOA3wVtuGp7F/DLkbqK5bfBfddDky30F+7maK92q?=
 =?us-ascii?Q?SnE2pkF/T/pmHVwdvW//3CEfF+0Sw7B4VuzJ+Y953SANVhZoqmN0kLVNx43n?=
 =?us-ascii?Q?ETD0bGqjwIV25zE+o4llWHn++ZtYMMYaIY3NNv986DJ1SIr+qNLyy5k6R4Sz?=
 =?us-ascii?Q?TKOHWVwW7sw19tbPR8Hi4yrN4R0j3w6wd/Z8xl4t4Brh2DLyhjzvKiPbND/s?=
 =?us-ascii?Q?YVWWXOWm980tb7FlS6GXxGyFS8OdwOdKAfz0Uw55anNKWTHGS0xhoFJwYyo6?=
 =?us-ascii?Q?xclmuaw6zdgchgnP7ayGcNSIyp1LTlu90GM7sPBv1fsWAQwyFaEVr1kpsTkN?=
 =?us-ascii?Q?wtsRxkIdkZaIJOLjv7BrKyk9P/IBr+r3h+4rHRkuyjhfjrTeaZrDmiW3TRbT?=
 =?us-ascii?Q?icIX6XfnLtaq188FbZj/ZC+tUcrHE1DMujcV3FM1fboi6o3vF8p9QRSZdAI2?=
 =?us-ascii?Q?AOOcPANAHPe1nmnUysKJABUR5RuQ2ptyOJU968cRLChdQHlwGbtPalZMMkI1?=
 =?us-ascii?Q?EBTZYC56Sw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acfa0f0c-d981-4b1b-b3b9-08df0ee9952f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 03:14:10.5407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZiB124II3hywDP7XEIKR2ZUL6cSup7LzVM64KXkApAIrEGdQ0JDTfgMl2KOl6BRk7Docq3iAz7d7CUHbLc9gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7072

From: Mahesh Rao <mahesh.rao@altera.com>

[ Upstream commit 85f96cbbbc67b59652b2c1ec394b8ddc0ddf1b0b ]

Add mutex lock to stratix10_svc_allocate_memory and
stratix10_svc_free_memory for thread safety. This prevents race
conditions and ensures proper synchronization during memory operations.
This is required for parallel communication with the Stratix10 service
channel.

[ 5.10.y lacks <linux/cleanup.h>, so the upstream guard(mutex) is
  open-coded as explicit mutex_lock()/mutex_unlock(). ]

Fixes: 7ca5ce896524f ("firmware: add Intel Stratix10 service layer driver")
Cc: <stable@vger.kernel.org> # v5.10.y
Signed-off-by: Mahesh Rao <mahesh.rao@altera.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
 drivers/firmware/stratix10-svc.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index ae6d942ab2d7..5ba7f76934f7 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2017-2018, Intel Corporation
+ * Copyright (C) 2025, Altera Corporation
  */
 
 #include <linux/completion.h>
@@ -167,6 +168,12 @@ struct stratix10_svc_chan {
 static LIST_HEAD(svc_ctrl);
 static LIST_HEAD(svc_data_mem);
 
+/**
+ * svc_mem_lock protects access to the svc_data_mem list for
+ * concurrent multi-client operations
+ */
+static DEFINE_MUTEX(svc_mem_lock);
+
 /**
  * svc_pa_to_va() - translate physical address to virtual address
  * @addr: to be translated physical address
@@ -179,9 +186,13 @@ static void *svc_pa_to_va(unsigned long addr)
 	struct stratix10_svc_data_mem *pmem;
 
 	pr_debug("claim back P-addr=0x%016x\n", (unsigned int)addr);
+	mutex_lock(&svc_mem_lock);
 	list_for_each_entry(pmem, &svc_data_mem, node)
-		if (pmem->paddr == addr)
+		if (pmem->paddr == addr) {
+			mutex_unlock(&svc_mem_lock);
 			return pmem->vaddr;
+		}
+	mutex_unlock(&svc_mem_lock);
 
 	/* physical address is not found */
 	return NULL;
@@ -844,11 +855,13 @@ int stratix10_svc_send(struct stratix10_svc_chan *chan, void *msg)
 			p_data->flag = ct->flags;
 		}
 	} else {
+		mutex_lock(&svc_mem_lock);
 		list_for_each_entry(p_mem, &svc_data_mem, node)
 			if (p_mem->vaddr == p_msg->payload) {
 				p_data->paddr = p_mem->paddr;
 				break;
 			}
+		mutex_unlock(&svc_mem_lock);
 	}
 
 	p_data->command = p_msg->command;
@@ -915,8 +928,10 @@ void *stratix10_svc_allocate_memory(struct stratix10_svc_chan *chan,
 	if (!pmem)
 		return ERR_PTR(-ENOMEM);
 
+	mutex_lock(&svc_mem_lock);
 	va = gen_pool_alloc(genpool, s);
 	if (!va) {
+		mutex_unlock(&svc_mem_lock);
 		kfree(pmem);
 		return ERR_PTR(-ENOMEM);
 	}
@@ -930,6 +945,7 @@ void *stratix10_svc_allocate_memory(struct stratix10_svc_chan *chan,
 	list_add_tail(&pmem->node, &svc_data_mem);
 	pr_debug("%s: va=%p, pa=0x%016x\n", __func__,
 		 pmem->vaddr, (unsigned int)pmem->paddr);
+	mutex_unlock(&svc_mem_lock);
 
 	return (void *)va;
 }
@@ -946,6 +962,7 @@ void stratix10_svc_free_memory(struct stratix10_svc_chan *chan, void *kaddr)
 {
 	struct stratix10_svc_data_mem *pmem;
 
+	mutex_lock(&svc_mem_lock);
 	list_for_each_entry(pmem, &svc_data_mem, node)
 		if (pmem->vaddr == kaddr) {
 			gen_pool_free(chan->ctrl->genpool,
@@ -953,8 +970,10 @@ void stratix10_svc_free_memory(struct stratix10_svc_chan *chan, void *kaddr)
 			pmem->vaddr = NULL;
 			list_del(&pmem->node);
 			kfree(pmem);
+			mutex_unlock(&svc_mem_lock);
 			return;
 		}
+	mutex_unlock(&svc_mem_lock);
 }
 EXPORT_SYMBOL_GPL(stratix10_svc_free_memory);
 
-- 
2.43.7

