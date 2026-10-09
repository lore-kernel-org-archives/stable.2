Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F4B49B454
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542076; cv=fail; b=toN21L4Tt5M82Q61JPq38tqMVJ+fq0YVywbO7wlQygcLtfU9g94suGLwU22yxfGVWkNgyb6oqlcX/z/6aCgZTF8pmTUgy9N+dAXpNzZI4KNd2EKxyuSwDQH6DNNjbKnph5YP/peU64/hcfQHxxxmhVy8WyoRSsKgVzWs/rSGupI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542076; c=relaxed/simple;
	bh=MckuvQvJzOTeGRvvmQ+FxJNhFqL2JSndx1HnTpBkMiQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iiyuhqqI7lgyb5dOWSavWeMc/7XSQ3bglfxlU6g5esprcP/hyXQT7vOl6QPY7WfG7LygGMn7GopbuB+Dp54WwAl6EzZPiz483m2QH4/CoEynWUaVKN4cERImnqefsl1ipQRG9yy/42dt1AQ4y8l4UPV41EUrgNXzOFXsmYB4XHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3SAa51cN; arc=fail smtp.client-ip=52.101.52.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3SAa51cN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WlG5L2/GFiN8PIAwTeXYafmTDNAMy0SzHQC3/I1DrogArFGZbJRvh0lGZ1y2JFBLmtKTnTMJKiW8AHo/mqARoam9xXbvMWuzbbH+0lU+pubdDS6mUxvTJM4FfwoORgsvdGtCW/u3m7jszEmYww9+2qraZafjCrcLKronjSQn1Vn1F7H19p/cVWZ7dob8YvetDwqU/cU8C7rQyurYxyagPlym+5so+hCWSItg1ZU94bb61vwT7xpCTMQABWUF07os54vaZqNAI9BmTqupEMXZun5QUO5Pacp/6jEAV/uw2U/p+d+23RDhlFel9Ev6ujCjLNQ4gxOBF7TnZgZCnKl+Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1r1FLfCQKFfs6DmnFGHuERcE5sgz0UtSgOBgcbwCUo=;
 b=phZD44Rf08nCdBcTzRCScpBsW3U/5tQJsSrn/9PxyOkJiHV0FVc7P32UsN37DHO41eXwNnlDYDMSdIAH6LRUFLmCl8gyGfpkn8m9tg1rwZDcdpsj6mb+tCxDkpn482zPKzf5t86L+dUoWDPFekBgZVrRNcMhd6tYlNBJIhEeRBitQKsGeslfAN42Ufw5fXvfa9ZR/xAldvP0B7uWGxyWemazULr8SoZ/TLnxQMh8yHRyWBMxcWKa5XHV08Z2sziCtiNwB1eONCBH/jM7u20iV7FHItPdc/tk2GuQEatr1e1nDFhKS0MtOmjIsvWEdRgeP3wuEewyL9fA+SnbLKTKZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1r1FLfCQKFfs6DmnFGHuERcE5sgz0UtSgOBgcbwCUo=;
 b=3SAa51cNkhVf+KFVllqNCcDA0dxAxkDRSNgvwW518/PWBypCfMEZtgDtP+67mrFl2KkYWLCWWRUsjtnWfEBDyjohmBKcqdisjp1XT1VySxBqdwP0ntuVfX3K1Xe5vTnF5iPBSfvCwkPfzWqYafW7uJ1IyTiEbEshm/YXiofvAZk=
Received: from SJ0PR03CA0162.namprd03.prod.outlook.com (2603:10b6:a03:338::17)
 by MN6PR12MB8471.namprd12.prod.outlook.com (2603:10b6:208:473::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 10:34:28 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:a03:338:cafe::7) by SJ0PR03CA0162.outlook.office365.com
 (2603:10b6:a03:338::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 10:34:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 9 Oct 2026 10:34:28 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 9 Oct
 2026 05:34:23 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 9 Oct 2026 05:34:15 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
	<natalie.vock@gmx.de>, <Arunpravin.PaneerSelvam@amd.com>,
	<stable@vger.kernel.org>, Jesse Zhang <Jesse.Zhang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH v2] drm/ttm: return an error when kmapping a BO without pages
Date: Fri, 9 Oct 2026 18:33:39 +0800
Message-ID: <20261009103419.4122940-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|MN6PR12MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: 7404d0b2-f6ef-435d-27cb-08df25f0e56b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|11063799006|56012099006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	jzbG8ntD3o/5ZrMVS9YBiF0WTtsI3Z2R6dtDeYYV2yktnkJd7KkHj330g8Sa99W5yaOMzG1oBIReTGdbVsVyH/JzdzjqrEsEKgbzMHg3s7kQbEp8NWjJ6wkEicScNTMMkDZgEd8u60K2fIX3uMc+xl+iuQBagteqValgy2qq0rWzFeNNwYsJcCFe2Bss6+E3NW6cVYViouj4Ww7afuAEFbow7sE6gBk9eA5PQnBxDiCTF9fVhGKexvUCyS3eebryiBgS8oPfesCo1a6RptVPHmjbfjX0EKMKecAzsBAyLWpG3w/6mRVL5/2lq0dlvjtMd3iCWQN8CfITE+ZfncSXqGz5ahR5aougN3kQeMVZ7xN4sbrwq6jwHIc7ym0HQh3QF1wneX7zKrIHdHs59kaMMw6/0gDqy9OabCEKGXVKc6tvjVcuZt9UKDv8IYVb/8n+h5jINietXQESEDQfXpdgHhJxbkPYyVOPwIvFxMpNMpwC89qRCyEaJDvdy0oi51Q6rd142tNgmgZY75kqt3DnyQnvK1c3cFkCcy3j+LY26LLSoVdIzbrWmlpGAUxl86oFfgeWsGYJRSCUPXvbzE9jUgAmn0kytAoTMoF4QTHcI5JTJmP6tUckx8G/lBDr2+h0liISgFwn7V37fp4h/hwH1wP3u9j6NkhhMtBT9yiOxMnjNcSRQtxozzFXo7y2D5nE9uScBlbdE6Cgr5QIj8EvMg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(11063799006)(56012099006)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1a9K8X9D75UjRqB0BiAuMdSuGTmTH8A+Ps7oORGTmdR3bd7ATDcCykRaNTi8IgJYKNeqrWliGBnFkWe44qZq4ko6PRma0j5qBtfx53UXwFY69pW4SrAR8kC4klYs6T5S3tI2PqrQxBpEzxQaGYRznUTiWsqAKut0HcRBVJGUQMZ0FZ2fAmTgpFMjrfh/eWPq+A73Fmf3KyWXbzvFj+jAx63pbFL+T82nq0w1XC2IXzQelxb76i6QOt6ObfuCTzSC2Dqzl3+EXbz2vK7ZxF4vq0JMwdlN5HtNE/ZnwpK4p+Iat+9T6CR/NZpG4spMpVJVtkrnAlYf6oQfV/cKDcr7gFSLSTtUGMbEvx4Q37uDBBYRGIrSAL607pNb3FNxzzOh9aPJ4C7EtyaRmkM6QAw958vCSZPcGqoumMVHDJC7LUtUTjNsgEaiOggjW7UPyIhw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 10:34:28.0310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7404d0b2-f6ef-435d-27cb-08df25f0e56b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8471

ttm_tt objects for imported sg tables (ttm_bo_type_sg, set up by
ttm_sg_tt_init() with TTM_TT_FLAG_EXTERNAL) only have DMA addresses and
no pages array. ttm_bo_kmap() and ttm_bo_vmap() still dereference
ttm->pages for them, so a driver that tries to CPU map such a BO oopses
instead of getting an error:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  RIP: 0010:ttm_bo_kmap+0x26c/0x300 [ttm]
  Call Trace:
   amdgpu_bo_kmap+0x89/0xb0 [amdgpu]
   amdgpu_userq_fence_read_wptr+0x116/0x170 [amdgpu]
   amdgpu_userq_signal_ioctl+0x3fe/0xbb0 [amdgpu]

Return -EINVAL in that case, like ttm_bo_kmap_try_from_panic() already
checks for a missing pages array.

Fixes: 75a57669cbc8 ("drm/ttm: add ttm_sg_tt_init")
Cc: stable@vger.kernel.org
Suggested-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo_util.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index 3e3c201a0222..83142bfa3bc1 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -356,6 +356,10 @@ static int ttm_bo_kmap_ttm(struct ttm_buffer_object *bo,
 	if (ret)
 		return ret;
 
+	/* Imported sg tables only come with DMA addresses, no pages to map. */
+	if (!ttm->pages)
+		return -EINVAL;
+
 	if (num_pages == 1 && ttm->caching == ttm_cached &&
 	    !(man->use_tt && (ttm->page_flags & TTM_TT_FLAG_DECRYPTED))) {
 		/*
@@ -419,7 +423,7 @@ EXPORT_SYMBOL(ttm_bo_kmap_try_from_panic);
  *
  * Returns
  * -ENOMEM: Out of memory.
- * -EINVAL: Invalid range.
+ * -EINVAL: Invalid range or the BO has no pages to map.
  */
 int ttm_bo_kmap(struct ttm_buffer_object *bo,
 		unsigned long start_page, unsigned long num_pages,
@@ -493,7 +497,7 @@ EXPORT_SYMBOL(ttm_bo_kunmap);
  *
  * Returns
  * -ENOMEM: Out of memory.
- * -EINVAL: Invalid range.
+ * -EINVAL: Invalid range or the BO has no pages to map.
  */
 int ttm_bo_vmap(struct ttm_buffer_object *bo, struct iosys_map *map)
 {
@@ -537,6 +541,9 @@ int ttm_bo_vmap(struct ttm_buffer_object *bo, struct iosys_map *map)
 		if (ret)
 			return ret;
 
+		if (!ttm->pages)
+			return -EINVAL;
+
 		/*
 		 * We need to use vmap to get the desired page protection
 		 * or to make the buffer object look contiguous.
-- 
2.50.1

