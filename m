Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011008.outbound.protection.outlook.com [52.101.57.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FAD3B71CB
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 11:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785496668; cv=fail; b=Qh0aVUdlJPZJCwEK6+5jGNZc+sBmaJRxEBb4vUlKtR8Q/JFqU8f/+7KE9OabbOCWSvyNovdncOTfI7W79ljs06tIA/UpQkE4+1hlyMXWy3M4nAqrWpFmDTgTbE5YG25UPK6nRdt9Js8axEZx6UFBusssYge61tiSDWHubXT+vC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785496668; c=relaxed/simple;
	bh=ONQMsmYbGP+BgOgKiDySVe/Uh0KIXOcau3SsycYVB0Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FPvFB74JEOwqCMLeeYzsA+zyo6Zev1IT7oVyXb+WO34FTPiiZOqH8UQvuFGniFns7wM9VtjrhHNh4y962BPWzzq6l1U8xfPuKxBeOJ7qmjHnEKxUhUh8OWFHfqhKhGqkR+vA/yvmTtVQPBR3oA2scmt6C7WyyI4lbg6Ned3ze9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=msSOpPkQ; arc=fail smtp.client-ip=52.101.57.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="msSOpPkQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNqe8KXI79qQ3xLYrtUJ0hkN1Xpy6xbaKyozyq7KocfWkfXVJBRj6x2WiaQnu+juFkhitL3sTQJXV93I3gf8q6VsliJ6hJIMfHDwwljLY57wkdgzzpWqqkJwjXAUnNkIAlorOo+PPscdOJOVvK3P7wG5ckHHq7tZk28Z39al+M/1giM0buh0JQQQ+BNFq+9wqQYbhHLgdTG5qCU5cA3ZHbsAyJST0C4iusaF4hn4dWw4wqELq4ufEqRRsHa76bCfmAteTqtJIislCWsiBjmNlxjaGnc5ILaH5fPuHACYnnL+LfwU4jQdKTixtjpHZLYxFci0+e2i1jLfwc/Xaegpbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUEtzV/LMTQP3vuqUywN+fc+OccvCZM82GtHBlBTKgY=;
 b=KmW8RX92IHM2I5WmLDiAsB2gqhZ/dC4wVD8nyf3IgE+Xjwob9HnFsdvgOfs4URgPIKHdmNO/5tlJjizHuSr031F9IMGRj5BLrUcyBofjozHyrr/x8PSOVx3WTDFE9mRsGBYWeZicsPIFNmD0RUlLwk2A4Dxwtac0zpirrWqFiIpoKHfTxCm5meXzEEqXGUy9+0v5jU5mb4yDUq4+qVv1IjmVft6pNWBMYwUGBhw5K3xARXkqz+9K+HhomUPbdZXgbYlKpSHzrW1Bt/WGpy7MvYWLwrrSjRndktRV5WvHyN9T6CXPBs3c0sxJrm6SHVlm7d2z1c/KOh56OhdCStpF2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUEtzV/LMTQP3vuqUywN+fc+OccvCZM82GtHBlBTKgY=;
 b=msSOpPkQ0nFHP2OByhcIHnrX11JL/zAoQBaGLquhflqa5AO69eOUdomBr2yBDplJm2ZWVduu8wKlNpvzImvcUFeThbFp2zdvmH0GFcqiHNzz4dsyhDgVrmM5v89HFVrWAEmlG80tfREktXBos7jn7LsWenBZMJkQGhKDAEoYs9M=
Received: from PH5P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::17)
 by PH8PR12MB6721.namprd12.prod.outlook.com (2603:10b6:510:1cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 11:17:41 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:510:34a:cafe::7) by PH5P220CA0002.outlook.office365.com
 (2603:10b6:510:34a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 11:17:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 11:17:40 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 06:17:39 -0500
From: Honglei Huang <honghuan@amd.com>
To: <stable@vger.kernel.org>
Subject: [PATCH 6.18.y] drm/gpusvm: publish dpagemap early to avoid device mapping leak on error
Date: Fri, 31 Jul 2026 19:17:28 +0800
Message-ID: <20260731111728.3415703-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026072912-heritage-womb-d38a@gregkh>
References: <2026072912-heritage-womb-d38a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|PH8PR12MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: cb18f119-5a36-442d-ecdd-08deeef555f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|11063799006|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	VrD7aYR8DGhnD7jOtuBXfrBNHplzJNFl68j6zyTP21PT50e+Qro4nYM+E9F2TZDaQiDREbb1KDwfKh5Bjph94quC/6wXLGnR2TZK7H9KLCpZ7y0zEaoc0tvw6gjFncix41hvHN1a3095RTASfA/qDsYM35fQyRu2+H76EYf/5TQXdONHDJhEGHCTTdCwEqsV8LPnYHkEeOYu8L5KlRqOYj3K1QP8dU0lbsJ8Vms0+p4Panmu6PTj1TZlGEMqZ21Mfvk6ipQY87xe06GCPkmXEAfcH40J0vNrIFNRry+/w5Qf9N7GnCG416rNUOzK/XZPIoJV2Io8WHkUXmyIxedmNgfgXqEMUxsFG+UUM4Oox23YPhKTomDkv+0zhrLfbbtuUPuSDDUG2I5ZoQzKF4afs0Gfz5psPbBPNZ+d5ndquwwIr9d9SP7V4JcH0D8eloGONxJuAgD4O2dREskLesC5ZMstHTk05IPkZ43QfeFXIdnDynsNEBSFNwFWPlei9qqn+ElXL6Nh/Wyb/k6sznzrX0i3NuMIMmxJQkNI9G3Gs3V8YI/WtrJSrSlWooYyiqFSgSVUskiZhBQN49oS6E+QcD1/N5oVryccIw+J+0zhJZnKiGPyU5ysEILged8doah0xgB7ZzYADo42xxMk4lwATkwNXmASFccuzQEDmviBSC4=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(11063799006)(10067099003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	znZznxJU8XsaEldyAH6+m7yZDFTjzePdTEVcpyPHP4Bhqoq6QmCXU5VGeyEXfrePp6ecpBuQ2eLLRUj7tcZQslvKM+i8QLfVi8SViNkW1GOaaasluTs6Yek41yY/ZSeFObZXmxOU3vrUu+BtQIIWfz4ubQIwVt1EJcrtrkkTJkvQOGPKy6aCEVyc70EPsejivIAO1bkQR9UYtCSLASHi5krIMpI7gqMX5fo9DOuOkablhauhAdVu9kMi/9N594V8XoRqcPvh9HM0iKVQQa3EOS7y1xzQra+QM7pBJj7O10lrUF4s+/xLA1UuV+cf1jWHOMpRextPvYrnMActQPrg0zMWow11/p49NLEpvSznFpYNQueJOOdZUWlFS4uXIKfhbdE+vHaP4yiqykRcAshaTpJsYQwkvbO5c/nYf676WEQIRMTuViRtRM0rLtPiYleo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 11:17:40.9332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb18f119-5a36-442d-ecdd-08deeef555f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6721

drm_gpusvm_get_pages() only stored the local dpagemap into
svm_pages->dpagemap on the success path. If a later page failed (e.g.
-EOPNOTSUPP when ctx->allow_mixed is false) and jumped to err_unmap,
svm_pages->dpagemap was still NULL, so __drm_gpusvm_unmap_pages() skipped
device_unmap() and leaked the device mappings already created.

Assign svm_pages->dpagemap when the first device page is mapped so the
err_unmap path can device_unmap() those mappings.

This issue was found by Sashiko AI review.

Fixes: f70da6f99d4f ("drm/gpusvm: pull out drm_gpusvm_pages substructure")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Honglei Huang <honghuan@amd.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patch.msgid.link/20260701062800.409248-4-honghuan@amd.com
[ Adjusted for 6.18.y: drop drm_pagemap_get()/drm_pagemap_put() around the
  svm_pages->dpagemap assignment; that reference counting is not present in
  6.18 where the field is not refcounted (unmap path only clears it). ]
(cherry picked from commit 7f708f51e3955bda0d77a0b67ab9bea6c97fea99)
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 4cde5bf4ae..a22beafa01 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1390,6 +1390,14 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 					err = -EAGAIN;
 					goto err_unmap;
 				}
+
+				/*
+				 * Set the dpagemap as soon as the first
+				 * device page is mapped so the err_unmap path
+				 * can device_unmap() the device mappings that
+				 * have already been created.
+				 */
+				svm_pages->dpagemap = dpagemap;
 			}
 			svm_pages->dma_addr[j] =
 				dpagemap->ops->device_map(dpagemap,
@@ -1432,10 +1440,8 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 		flags.has_dma_mapping = true;
 	}
 
-	if (pagemap) {
+	if (pagemap)
 		flags.has_devmem_pages = true;
-		svm_pages->dpagemap = dpagemap;
-	}
 
 	/* WRITE_ONCE pairs with READ_ONCE for opportunistic checks */
 	WRITE_ONCE(svm_pages->flags.__flags, flags.__flags);
-- 
2.34.1

