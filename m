Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795108899;
	b=5f5OG82mj9jGeHPXbzFY1sxjkzJ5X/Bt5u2B+H5/3Rpps82aGF6Re2xOVBghzP2vEb6k
	 Oi8kNXwN5PAgPKcealgM/tkK1daHLwiQWnZGChM290/d0CbzWuhsPBkfY56Z4r8PT9fKQ
	 1I+EEpL/lohJLSbULf7a6mRp7N9CDvfVoV1ohiM/z5KcVLbgblXLfqG/eccE+rNDnA5Dk
	 uQ6wiZVTj4vzgGxGurkf0WI/i/2eb/79hZeh23ulEKWcr/QlXgNkwsQMETfgsnkwsdzPy
	 sZZeByIHeScb7Cjd52+3/ARX5ni9ucb5HuaIfOvysMs5PQnXsWJzcxHvXuLQynwf0Mw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108899;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=PQ8lb09By7IMwhlDoq1OIOXFDfAWkqGAsKuPB8hve+o=;
	b=jJDm8sZLrs2JzyzsBsCUfpjGm9It8Vcl4uRiDBb1ukWD9jiaJa2fNihYHJgVGIdeBruk
	 jjydsgk3MLblNc5qFRTSBLbog2ED8KuSZm0aaJcmxCWe/JPk2w5BMAQCnIHV0koLDj9tm
	 iwhodpjjZAdq4iVktI4uDYQjM1VV3SIHTZ9e5kAgDdL3JZbUT0vzq5Jyvfw33aK3TZK6e
	 FWZztiHowR3kQd+hJVQFkg+Wz7N2qD2JdM/ro1x3jbUk+UrRtaMLgazwZ40JMC3kaP4jV
	 OmBRKiC5sABlKO6TwW2G1FHrniyUIBa4LCjQdIHY8FbST4sRc6orFjTCOEbGVWPoJwA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xBps1yQz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.63
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012063.outbound.protection.outlook.com [40.93.195.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D0D606A332
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 17:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85D0D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xBps1yQz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NvkcT+oVd0evi//e+aSsORCcIgWgDAoPwju8yCjKxKx3RZ7Aht5T+Jj7AF+DMuVHuyuZjgmMJNHhtXxE7npUo8A9LKFWriCHPB6Yqfx1pXMsHv3rY9EV885Upe7exxRsFLuNaFSkAxS6BBsJ+kYPMquzTmzJw5LvqlUCbSLDdzBLPc6koZrxIb87ZK2fAOf7rf1eyxwoI2NYcCGOue76zOW0w1BLX9yNjXcI8xcLe20IXfwJpC85cIhrOACQmv0FPmvVRXLzjBFnDpSHVq0FMoDBAnQsqMMICSy7gm1PG7KAnSkVglpgH22133tk2K2RE5X3grThfZaC0SG9SeitPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQ8lb09By7IMwhlDoq1OIOXFDfAWkqGAsKuPB8hve+o=;
 b=Yd9uaeO3QY8C7ji4TUmBZwx7O5A8royn+ElTGL8OfWkoGghg8GXCcfOL/ZlOceG6vO2Vljqt9kFWGzVkda0n+ncroXSaW7puMZl9OU542xixNP4wCXiRU3pj+Xivfs3Sfv0eWHrt6H4lDfH4E2t3K8D63Esiq+I8vYRjiFNDuLHWNISE2b5/kdIpiRtPfLxblYJw2MQqR3XE34KBLP6BjkNnzaQPtMY2llfNRfIFZc5SGEhu6z2GwJn3OPDQlarvoIKozRYnW+yroqBPJu0sJANp0akDwlkGavUXR/TKiKgToXLABOpGdZ+Dscxp8EWUzy9IcP9JX5Q9myLrisN1tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQ8lb09By7IMwhlDoq1OIOXFDfAWkqGAsKuPB8hve+o=;
 b=xBps1yQzsIoego+jHP2eSVPzUffjYkWSbvnRV2pu3ck4fMEXW0WWwMn17IwZXNYgx6k7AbH7i2vwLDw+ojXfNsG7mjRN44eoyiVH03HlBhtePZd04luI0jTpZtsKhZQCETkCnVKI6uL8qyvLWtd9w0ytcfZhGm5sZEsJigRWZbw=
Received: from BN9PR03CA0266.namprd03.prod.outlook.com (2603:10b6:408:ff::31)
 by MN0PR12MB6126.namprd12.prod.outlook.com (2603:10b6:208:3c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 17:21:35 +0000
Received: from BL4PEPF000003EF.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::40) by BN9PR03CA0266.outlook.office365.com
 (2603:10b6:408:ff::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Thu,
 19 Nov 2026 17:21:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL4PEPF000003EF.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 17:21:35 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 11:21:33 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Thu, 19 Nov 2026 11:21:32 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<sashal@kernel.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
	<felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdkfd: Dequeue user queues when process mm released
Date: Thu, 19 Nov 2026 12:21:18 -0500
Message-ID: <20261119172118.3738253-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PEPF000003EF:EE_|MN0PR12MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d3d1efa-2f06-4f87-5345-08df46619047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|261009223327099003|18002099003|261009223027099003|261009221227099003|261009221727099003|261009220027099003|261021121427099003|261021123027099003|261022105027099003|56012099006|261026140227099003|261102123227099003|261028144727099003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	URo4hKNevhpgDuUWvFVh2vHTCVpvQP/7Q1esRcBiwJAaOAcjpZ74RiKvpznxRlIR4eA8g45cscfqr2rNc3dqTpmTEZNlpFsPvkZmAbTR5OoAFUdEVd/jCwrMzcYbdmHPTQTVP4z7OCPvUPpZ7YpAG+kNK5GRhuD/fKUTDZJfWizzkwR38ngWstbc6R4DbTGfVBIB9vdUjM48e9zPPZcdo+vrkWDa6r+i8DqMj1RVyBZDRx7g1F1lAsvTRj94fMR8L4TbpIqP9GWaaSbQbYHcdZQ1L9iwzRUb6lRoeaOxmAEve577JLwYbtqzODpO9yPCWUhV50OU4Ov/BJ3bMB/hGajHS5wrhnLApSyyhqLbcsPACRRxN5zczF0jQDAfKqcXLiKp/Xab3qIXOH2DybWQMFYO8lz2xqEL5FYfjsM2Io6GDjaYCQUvPZVaRIs7dhA/CytyY00tKx21//q+vgheBE1oOGWVT0aruupV04ygKSd2cfGIhGjNV5ZesZayHaX8Jl3M+i2oDyUr+KaPrF8tG+ZoHthDr4kAlJLttb81DDQS4QDsKHjlDu7bnmJxP9U4Irh5hU9xplxPBx1Yr37AmxIZn9hcXBBJSSU5WWkVOWiuz2O692MPE0iGkyafj+1w4o4t6rIhOhoJw9ELirLYp60I9VkFT3BWwAWFup0I33n9m/o+s+jWpzclNnL9hVTiX2TLRtqgcOpf/OhCf956dg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(261009223327099003)(18002099003)(261009223027099003)(261009221227099003)(261009221727099003)(261009220027099003)(261021121427099003)(261021123027099003)(261022105027099003)(56012099006)(261026140227099003)(261102123227099003)(261028144727099003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	blt3lX0EcXfwIBpg2EDFNTzpkfUo8YpbMEpElyGqV+sucjBCssHgaCCBbNCu+a79iV6xi9lq4oBf/0IlENdaj2oUvDqCSFZGflpsekORXV6SrWEoISWnd6+cgw5/5E6lcL1lV6YdiarvlGlZkydBP7CdX+lnFwMZfvf+hr92YBnz5ckwcafQ6r4SKBKq9vvnL5HohmZhxah4cYTIea0YOxZCY/KQvBgWNcIXtA1CrbVjOU3W1qRlf9sQ/KnvzdFDqA+fUbzSQSc3iTHNHV2a9a5VOT3emSdUL7NGCe7Y9RQcG3DCxZhTMj8WSOb3OxOwyLjAo6Vt4Uho5FrF5mBguUDQ8yYzrreOdKlEeK/1PsCd/o410DVq0egIcvVq+HXsaiIX/6/VDxfJCm1Yd/5P0I85Xot8Iuk21JrV72MLI+8amnPCxg6Y7c1Vk9mANDS0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 17:21:35.5823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d3d1efa-2f06-4f87-5345-08df46619047
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL4PEPF000003EF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6126

From: Philip Yang <Philip.Yang@amd.com>

Move dequeue user queues and destroy user queues from
kfd_process_wq_release to mmu notifier release callback, to ensure no
system memory access from GPU because the process memory is going to
free from CPU after mmu release notifier callback returns.

Destroy queue releases the svm prange queue_refcount, this also removes
fake flase positive warning message "Freeing queue vital buffer" message
if application crash or killed.

Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 22d9e071e5028815accf26956ed0b9634a4c0b8d)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 1c591953cc80..d387733e39d1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1163,9 +1163,6 @@ static void kfd_process_wq_release(struct work_struct *work)
 					     release_work);
 	struct dma_fence *ef;
 
-	kfd_process_dequeue_from_all_devices(p);
-	pqm_uninit(&p->pqm);
-
 	/*
 	 * If GPU in reset, user queues may still running, wait for reset complete.
 	 */
@@ -1227,6 +1224,14 @@ static void kfd_process_notifier_release_internal(struct kfd_process *p)
 	cancel_delayed_work_sync(&p->eviction_work);
 	cancel_delayed_work_sync(&p->restore_work);
 
+	/*
+	 * Dequeue and destroy user queues, it is not safe for GPU to access
+	 * system memory after mmu release notifier callback returns because
+	 * exit_mmap free process memory afterwards.
+	 */
+	kfd_process_dequeue_from_all_devices(p);
+	pqm_uninit(&p->pqm);
+
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
 
-- 
2.56.1

