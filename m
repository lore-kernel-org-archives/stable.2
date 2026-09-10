Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59DF36728D
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 03:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789011198; cv=fail; b=RpBN28DMqao0GPRIGK5d5t3QGVgF/Jz1jeBRx15zNmcpGUYPJWrgywlNpH3SDXayK8vGzNbAkTT3pFB7K5DHHowCfg75/kPXi/2B1VaLBvXSXpZT2asCXhg/JT+eE3YF0V9piDycJ7MuB1Eg+ZM6zybsycxcnc86t1f+HhxYVF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789011198; c=relaxed/simple;
	bh=HO0C7K26o6U23gAKqZJJfxSkPYhVccF1SnPUOEeHhZI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DaswcUR9TahHUDSEUYP5hUTBLWLOl2NeR5rbAtDDnvOBe5kj2ZkaZNbYanYW5oLSj62I+cIFFzdeKUGU9EJogfFmWezY6QuqG/w7+EnxD7W/l27in36vJXXsbIGLohGJ5O4NKbxPC3b4GNyGwU472l0EmZKRmGgqW+FtkhLYBI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=DuxY7CFc; arc=fail smtp.client-ip=52.101.85.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="DuxY7CFc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4WOTSKB4oI15PyDSvzMlRzdUUvyrZPuNLHuQ6oOYEEsNAqqqdMOnX0Zfcb3MRWT6zND72ZnLnMp2Eu4vl4wZs6v7nB4vuKlzHYvDM8tKC+OBFmE65fjlE7s75LmEUzxaMRPuG80nHpRw+RVHSDtgjFxhDqyCrarDbp38IJOKBAS8EWH/6pvWCgxlZE6157/URDiUATOkubr7gfm3d8UnqwbyItxUNuv7foCBhkW+n1peONga8rEdfPdawtIbdVP4GvGBefOOSfoWjmc9bSwMQNditldOhscbsheNDAPGg2AudLQ2xFcwj4MDorDpEuVTQEi3+PF6FM+cf/Ua8mj9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3Fpa4buMi+FBFm5NYEgU47tXHlkrV0nnr7o14pzVwU=;
 b=xiemu/jxtIUkGA9tsYjeI/JRmeNkt4mQETRBG8FN5yqKFtgIciXs4Aor7A/Cc0fwQU5sowg+LOzcRzCl4e6xTBMQoRsYs+WgkjPBjMV9vP//rFn1rRBbBJqzdF/P7zo9IW6gb/caaVLZATPUxmtoN70btIk9oR4Pp3hejIO1GDRMKLQXhSCC54LCTE+VsEevXCEuO+g8ii2YTKhifmjE5IA8lEkNhiDqtLQIBGlQSBk13GQ1X0LA2jCsLK8rGxMxv/k6XhS3DSGuGioq2swv4Pu5ej0Gj4qSjUinS3mP81/fZKnWffDq9+TTwHjt0xr+ApTTMnXR+oDlHdgypNklWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3Fpa4buMi+FBFm5NYEgU47tXHlkrV0nnr7o14pzVwU=;
 b=DuxY7CFcsjR6V5sTICnfJ0cl3vD3FBk/ykIHkGGngwCqPvmF5tzbfKs3OLADEsZ4q7ah9KYUDx9kC2i2OWXg8dIUrsHrZ6zTQRo2QI9yQybVlWnuXNvnB0Y6wvJeuwvgNmh7RkvXbDutbJVFiPyah6kilRvLp3LZRQBc49lCnJt4RjmLRj8AzcN/Z6Fssfgu0TzxGBarWUMwWriY9if+TNYXdm2e412v/aDGiVpY66Oml3re0EEue6r12+AcFin0ZIn2I9VukT4H1c7nzoTGFqLK+akH0nEQKvUbRM+8/MwGc0fKvkn7tmPyXvNUTyrr3q+EA61JGuWzby1l6DKF4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by PH0PR03MB989386.namprd03.prod.outlook.com (2603:10b6:510:11c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 03:33:13 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%5]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 03:33:13 +0000
From: tze.yee.ng@altera.com
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y] firmware: stratix10-svc: Add mutex in stratix10 memory management
Date: Wed,  9 Sep 2026 20:33:10 -0700
Message-ID: <dc0e2d1f4c4f722f5528197c4835f64442561397.1789011103.git.tze.yee.ng@altera.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::6) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|PH0PR03MB989386:EE_
X-MS-Office365-Filtering-Correlation-Id: c3d54987-b981-4b73-8927-08df0eec3e52
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|11063799006|56012099006|55112099003|18002099003|10067099003|10063799003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Gf58vnpUXFoJZ82qbTiG87rR4OXS1FOkySZzevLHC6HPOz6u0FLFwROZ2kWG6YmDVkmq1ctqqyx1Rg2DXKKVinxfDCZ97qGFXk6KWqSGGQnPFFyEVlENiYonmbqDDJSXFYMsIcmKjzRXi+mtsdSpz/KBAIdX2IUnSKP6ojP3xFouQmJ7sj3UihqomjEDpiS9tlKFMiLOXdENOprDQhN36BVZowomTTyRnlhXKRIqtA0dVXEv1ZcNExnJDQXCrVAXh6+XMvSuzPhIO0M1D5859FhqF/RYVnkJh8URJ8TdbCSJqVZ3AOWs1lUwkp4ST6lozRi4itWFWPKcuc/ysqoFi1vS5IYRPe61uJtgDrembN8IFJQJZufyLtS0K7AuaXyffeIeCQC8wKh/JNjgkdxBcWaIJq2zCzbXDO+EIq0RO94XNjXL96z3TRw+l7x6tPKeyYedhuvvXJa50AqZs74JzBWgsAnWox7SmVDO3E4zkz6pTrjLbmz52WO2O2UYMlGGt1B2Gsxu4+GC24XuL7bIrNeyti22CBjOMLU5JyJdtGYvZA4iiQdfhw4wdYemOH8CkEDAXFtvgKV17xctAGiLRG7PuXRPiApefJ/LwEKMWv5FQMryyLlLCDxjWH2FFGzKsfZKZuA48fkuEfjv2UlqTSNl7Swn9AZIusKYrEOvuco=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5950.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(11063799006)(56012099006)(55112099003)(18002099003)(10067099003)(10063799003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QIQjs2bf129Nqpg4oN2xiqemzUbT9ujFu63M5y4v5t/jaKeSsoOZ4tkNMRlp?=
 =?us-ascii?Q?r6i+VkVyU6DZVuDPJXIOMQscgYHSveqQ0vZHSvCtYbcxsgFbFVK4SMea3Vva?=
 =?us-ascii?Q?1dCoGaWOQJcQMsbxDW7+v7ICx9K3adR1DU3mrEH+KjfI6mfLz+1i/4IchyXf?=
 =?us-ascii?Q?nqVQP1TyZFCENWfzc26LgAmUc1djFKTRX4GLNcabQv3PmWbQutFWQ6mReB2/?=
 =?us-ascii?Q?JV+WSQZ/jfJ6bmEENpzmE6yP/XyxO/pbQ6rGQE49jRy5FMxraXsW0T+lAwSQ?=
 =?us-ascii?Q?SM3NZdioB5pMSDkIQ3QrD5V+S+leYxY88OZtVIHMzbaruhS62Ez7X7vlqOpI?=
 =?us-ascii?Q?ti9N66/qu14RYr79OcQVbUtPr25xoD7fPKc5Ph1hECnh92ospzk0/mXW4IPl?=
 =?us-ascii?Q?1fsdjfEm9oCpTkIIZ0OGkkuYsKfJzjonlmu5oH8n+xwI6oirXSOdbsgOevGo?=
 =?us-ascii?Q?gShUfGs7l7JphFih/2Ue3oHyD7cGn6C5L9f1d8Dpft58qUdryviyDYsUddnJ?=
 =?us-ascii?Q?QOzXbePgQLiH04qjnHg3mSVy+hH1Glk9CEeqYzXKOYeW7sMCmPp4YFl9fn3D?=
 =?us-ascii?Q?xznkIcujnGsAOlODQg8Rpufu/AP/RvDk83bT27rcI7A5EZ1t4qiBtInyCuS1?=
 =?us-ascii?Q?3axllwJEW8YJDjMiOEy4fI5BexFO2r2His7nCtru/qX0LoekfYYR24Rp6TZ7?=
 =?us-ascii?Q?r7iseqMuWTQQjYrvYTmpeDYj1snMTKGAF0REe/QBcN0gM40p2oc6c8Dyg8Br?=
 =?us-ascii?Q?o32+fMV/NfehY4XSfc4OYfXnWr0kAI3o3M3rYiKNfRsbKw7nckQC8RxBi0/f?=
 =?us-ascii?Q?P0BG94UXOv+NG69ysWpO2Pz4a6sKlKXdvLeI2GfLMqGB5frffP8PK4z2mzWJ?=
 =?us-ascii?Q?WSIRMCzvr2MbwpE8PfT4GlrOFWQhxo1A3VDFFfxqde+V0jg3b/ct5/QPeHo/?=
 =?us-ascii?Q?+pr6YpFwTowu9ewm7hUQinApLdhGiES8a8HuHbCo7WNZEJ+xadDw2TL1RkQB?=
 =?us-ascii?Q?UBxhnRHs9xW/jyClgLaiE3nVfykaJBVBDGtXPmA9ZFXEp9BLZj0lkdmJUA+U?=
 =?us-ascii?Q?pbctgVHGEH9f6vKISaT4rRDtfUAkcZAm/bl8c79OTTqTNxuGfzpz8NN4Yw27?=
 =?us-ascii?Q?1OeEATj2zhb5h7JHw41yG0bAz8Ff/RwH8QT1gbThkQl+GyUl10npkxAyyS2D?=
 =?us-ascii?Q?UtRgvCgPbWNncOVR0ACeDVdY8R/qZurL7uX06GEhMGVCUbo8RYD7Rw70HbG1?=
 =?us-ascii?Q?PSc7GOlobJ4zUi6wKH3AEqrDLSC7/KbGgH0XsWOJ40X5KZXQGU+/jj1np+G+?=
 =?us-ascii?Q?WnzxN9dsgObgdaj2ipi4PZt6+GkocRBpasKZF948snBrIUSwopn5aEAWTEiC?=
 =?us-ascii?Q?9jemsPg7SFBSqEQaZuXO8xQK8ZCfP32eGHx9Xq0KkS1a1ZhJ+PpCOECp8RR/?=
 =?us-ascii?Q?fR4TeOLY8LNKtadPpMhIEN3Mns7nTDUfU/hS9JpHpGhrVn6IigicjCLK25v5?=
 =?us-ascii?Q?xT2pLB1RDpWy8CJ+ygycNJka8OtR3K+XaBEIWeXkVwDVaDZId7Hd2zfAqimr?=
 =?us-ascii?Q?SPYqSanptwqf1JLfSVN1NckBOC/HLxxyN2y2mcOa2fuqet+80sGlSsLAtyOO?=
 =?us-ascii?Q?VfkrpiyHr0BuRvGnhR5QeYHXxcCJwIWwOGJK6Kcwf/uW5cYy1HtRoLlr3MQ9?=
 =?us-ascii?Q?cZhQPhpwp5peKBYvgQjY4yiH247NW3LLesoefqIISjEJPW9F6J1s7jztDBVu?=
 =?us-ascii?Q?pjTv162zbg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d54987-b981-4b73-8927-08df0eec3e52
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 03:33:13.1582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z3uqME8yNdMTTX3/4VqwYoo03LUCbCS0k0uB7L7qhJVg1wRO6Z9vp3S0KDOKpChkjidPDo9KTjngl2FziFz5Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB989386

From: Mahesh Rao <mahesh.rao@altera.com>

[ Upstream commit 85f96cbbbc67b59652b2c1ec394b8ddc0ddf1b0b ]

Add mutex lock to stratix10_svc_allocate_memory and
stratix10_svc_free_memory for thread safety. This prevents race
conditions and ensures proper synchronization during memory operations.
This is required for parallel communication with the Stratix10 service
channel.

[ 5.15.y lacks <linux/cleanup.h>, so the upstream guard(mutex) is
  open-coded as explicit mutex_lock()/mutex_unlock(). ]

Fixes: 7ca5ce896524f ("firmware: add Intel Stratix10 service layer driver")
Cc: <stable@vger.kernel.org> # v5.15.y
Signed-off-by: Mahesh Rao <mahesh.rao@altera.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
---
 drivers/firmware/stratix10-svc.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index c5ddd20fe4b75..c0027a6bf4718 100644
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

