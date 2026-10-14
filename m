Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010013.outbound.protection.outlook.com [52.101.85.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A8A559CA2
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791992137; cv=fail; b=HWCf8PIgFCKhuGj7T42Es85WjQ0LBTHLhaUBFTjw4lfrawFZ7kFXueF7T888xtxRxMxTpaPzprdzaswFHy4MP7nBXtFn2vfQn1Pe9n4HhAQlAIKIOkllV373DSltbVGOrp9rFzVp+MA0I3NWFOD0UODyJmqZ1x1cgvIgucVQdAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791992137; c=relaxed/simple;
	bh=4+FC4DAbD0y3SCCA32lsFHYfUVQcFuq1mNXyWnhcoAc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oTbJlG+BkrMk2EaOP1EPvA+RDuEw9OyRaQKyRRTLKUL/98paUzhdz+Uoht7rV63Uie0iSc0djna3Jm0V+O/cb9V6EZbZOBQ6h9VyijaxMjZi6SPOVZfkkI1a8r1plH6g5ryOip9RCXXyMQUo47hAHfKdxHqSqhdwuNnbVAi/3y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TAsCu2Vo; arc=fail smtp.client-ip=52.101.85.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TAsCu2Vo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOjO3Su6qvYMOukJkwpHaDSasBO3NLxRrsxidKUBo9uHz+ZygSwLaz5evSeiUyX2riapp5/A4CoGhSkkjlIVlwF/xF2laXgIUozlLfln00Ts93kfl49/PzB5pSRgr/wNzsqGto20QnMBy2NBv/bVf2Qy949Esupf/buMU7eaW6gECi5I17H15OYJatnakdv75HTtj/rxbFn37JmIKvGxKG0WJdjv8UWwf9TjVubuC/pnJACMossaIhJI8K7q4cu6EtznRwJZjsgcdzmaOqCDkPgo+SufOpXQoI3YXBLRvmh9UuaZqZLM6d68Yf8RI+uX4r//rTwRUDyy7zBZ8lCUYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R7gM1qFAh36nyYXA0eD4GvmQzUlh4Zilzr9eYDGXOgQ=;
 b=L7wE/7kM2GL+2cGma0GXA/cDXSRSakjwSZrWS9+Kjm2xh4q5BoiOEq4/EpkO6+T6FaDqrAJW56ffYZM35HUzyJxUrBmCnr3QOkwEvM1mk8nyHHTWok0xAQvrFtxkQ2H5nQa6Ff8vfO/lYSvbHyV3CyDROJoiiME2H8YuieoO4/6r9Fqr0azD0Hj0NaBQscrPmu24QjHS4x+Vbj5tJ8Jpx6lRCm77wBIqlx7eec4ncB9uPVSGg+XjNwVNqVJ+wuMqdoJ++gy7B+xCutcNIMpR/eAdo3CP0s+WmvDRezFumccOLcv90/2w0AsO3BsUs8X7GW9eG8EUPclE6C8aJBy5/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7gM1qFAh36nyYXA0eD4GvmQzUlh4Zilzr9eYDGXOgQ=;
 b=TAsCu2VoP240ldUTEdQ/ja0zvaYSMfHuXJXMvEAwx4nHBixU9kD8m2TuVWFU/LTagmwqbG3psSsOuTqgegV5d5I0qC9EmERNeLYfcRb2Rev0DVpYWw7fdRi9DuxivmKqFHEkXrYDMDk7Jp592ZkNsR1NG0d+TuZYIBhxX+wuqII=
Received: from CH5P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::18)
 by PH9PR12MB011960.namprd12.prod.outlook.com (2603:10b6:510:418::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Wed, 14 Oct
 2026 15:33:24 +0000
Received: from BL02EPF0002992B.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::6c) by CH5P223CA0007.outlook.office365.com
 (2603:10b6:610:1f3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 14 Oct 2026 15:33:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992B.mail.protection.outlook.com (10.167.249.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 15:33:23 +0000
Received: from Harpoon.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 10:33:13 -0500
From: Felix Kuehling <felix.kuehling@amd.com>
To: <bsdhenrymartin@gmail.com>, <amd-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: [PATCH v3] drm/amdkfd: fix doorbell allocation race creating duplicate allocations
Date: Wed, 14 Oct 2026 11:32:46 -0400
Message-ID: <20261014153246.538155-1-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261010030230.1764682-1-bsdhenrymartin@gmail.com>
References: <20261010030230.1764682-1-bsdhenrymartin@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992B:EE_|PH9PR12MB011960:EE_
X-MS-Office365-Filtering-Correlation-Id: 18662f6e-b508-4d51-dbb3-08df2a087bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EZRewuaeFR6aqIwY3Sry7nXsjoMwNeULP2DNxgKHMlOwN6/hf6ENLRfXGTrwVd00xAZj5QpyrugMgtN5Qnad/7YHd8ma/S4g3ApBvCQ63XhoMuRfSFTMdWdSTLz7SBpt2rANA5MiFc6Hk7s6+4+0qXZ49IiXwZjeMJSbChVVBeccoM8rL1YTyXIF8Y1EbCXkgWNw4crw1AO5BKX/eh8hpkjIO6SHGJILTFrp3BibavScj47JbND7OUEhURcpzYnL+GYZChJ9UhYrN9fc5qkRA4R4LZYZK8cmvVAZHYNBjZwXM8bm+Aoeg0J3Gsf/g0t997Xveu5hV0X6UA+DFQk9i0vXAaG2j44ktiFvi1C7Ku+03n4LXJF/3+j3E30zY1ANyIM45O/7OIxzWB6a/G1VekC1p6a5sjczoOljnywrx/y4XL1fyknKk/f0tbrmjW+a7i07BD4O/kTvMijnjsB4n7UI1i40lRDn1ChdJKDjt4wvJvkUe/1CXt5JduHVbjJdMcDk8xJMzTZj0LjmNeFZiJZlJNf82dvmbqnJ2dkCl1zxVuS8KUuFUm4UTUqcfMqQbfrJhMnhXtnzklJHEC31ik/WQC2eVKA/cF3rpnfVX1kgM0SA4SkzdFjpX+OsxCP5c1oFL8fgP/pRZ2KkN+usqR1HvgvHsCcY1iX0HueuHq5yZ6JAGBkEwSJPdv8nR1HmXxOpoLd1sffibDWeT9TKQw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EqSt0kZoaZfDpLWavd6uWOWMUIk5257EjIMHFW//zf0tMPD6e7G07+GlZfAerMooVvO0+jf6N7acWBOC+nDzX1DBRpYt5K6S6ZtAAmJeI/FuT83ZQDQ4pnDwRKElE7UK0blfdPCdFjR8xaY8v2Bjey2CS/CAfLkozj4+Lkz3FehScd2C/y33zatwF2JGaWABLFVK639isHbu3BxJYbj+Tb2KX6u1D1+8HOnfnVAFKUFWI4bDzWyt+lt7+f6IuI4LJWrn1LU3IfMqS5gcslm+rZk/524oMaaTkd2QbpKBZxQq2QsV5IGGo7extqv00Q3ZXrzeH//HotNN5kORUUjVPtW2N+oFCT403JGUqKxBibJCHAafkf7pWa5S+wBipI83qJ4YB8tk1o4iQ0kMUZG/xvGwu+9Ro/jujZl0K8j4SiD6+8UlRzmMpJvh1xJ6B2iq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 15:33:23.3390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18662f6e-b508-4d51-dbb3-08df2a087bba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH9PR12MB011960

From: Henry Martin <bsdhenrymartin@gmail.com>

The check-and-allocate sequence on pdd->qpd.proc_doorbells is
lockless at every call site of kfd_alloc_process_doorbells():
kfd_get_process_doorbells() (mmap of /dev/kfd),
kfd_ioctl_create_queue() and the CRIU restore path each test the
pointer under different locking (or none), so two racing threads can
both observe NULL and each allocate a doorbell BO and bitmap,
orphaning one allocation and handing the two mappings different
backing pages.

Move the serialization into kfd_alloc_process_doorbells() itself,
using a new per-process-device mutex so all three call sites are
covered regardless of their own locking.  The device-global
kfd->doorbell_mutex is not suitable here: it is acquired under
dqm->lock on the kernel-doorbell path (start_cpsch() -> pm_init() ->
kq_initialize() -> kfd_get_kernel_doorbell()), so holding it across
the sleeping allocations above would create a lock-ordering
inversion with dqm->lock via TTM eviction, and it would also
serialize doorbell setup of unrelated processes behind a
device-wide lock for per-process state.

This issue was discovered by Tencent CodeBuddy Security.

v3 (Felix Kuehling):
- Removed unlocked check in kfd_get_process_doorbell flagged as
  problematic by Sashiko Bot. Fall back to the locked check inside
  kfd_alloc_process_doorbells
- Added missing mutex_destroy

Cc: stable@vger.kernel.org
Fixes: 16f0013157bf ("drm/amdkfd: Allocate doorbells only when needed")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 23 +++++++++++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c  |  2 ++
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
index fdcf7f2d1b5b4..6af268a031f22 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -239,11 +239,9 @@ phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd)
 	struct amdgpu_device *adev = pdd->dev->adev;
 	uint32_t first_db_index;
 
-	if (!pdd->qpd.proc_doorbells) {
-		if (kfd_alloc_process_doorbells(pdd->dev->kfd, pdd))
-			/* phys_addr_t 0 is error */
-			return 0;
-	}
+	if (kfd_alloc_process_doorbells(pdd->dev->kfd, pdd))
+		/* phys_addr_t 0 is error */
+		return 0;
 
 	first_db_index = amdgpu_doorbell_index_on_bar(adev,
 						      pdd->qpd.proc_doorbells,
@@ -257,12 +255,21 @@ int kfd_alloc_process_doorbells(struct kfd_dev *kfd, struct kfd_process_device *
 	int r;
 	struct qcm_process_device *qpd = &pdd->qpd;
 
+	mutex_lock(&pdd->doorbell_mutex);
+
+	/* Another thread may have won the check-and-allocate race */
+	if (qpd->proc_doorbells) {
+		mutex_unlock(&pdd->doorbell_mutex);
+		return 0;
+	}
+
 	/* Allocate bitmap for dynamic doorbell allocation */
 	qpd->doorbell_bitmap = bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
 					     GFP_KERNEL);
 	if (!qpd->doorbell_bitmap) {
 		DRM_ERROR("Failed to allocate process doorbell bitmap\n");
-		return -ENOMEM;
+		r = -ENOMEM;
+		goto unlock;
 	}
 
 	r = init_doorbell_bitmap(&pdd->qpd, kfd);
@@ -284,11 +291,15 @@ int kfd_alloc_process_doorbells(struct kfd_dev *kfd, struct kfd_process_device *
 		DRM_ERROR("Failed to allocate process doorbells\n");
 		goto err;
 	}
+
+	mutex_unlock(&pdd->doorbell_mutex);
 	return 0;
 
 err:
 	bitmap_free(qpd->doorbell_bitmap);
 	qpd->doorbell_bitmap = NULL;
+unlock:
+	mutex_unlock(&pdd->doorbell_mutex);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 7a365fca68e4f..42ed0d42c0064 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -784,6 +784,9 @@ struct kfd_process_device {
 	/* per-process-per device QCM data structure */
 	struct qcm_process_device qpd;
 
+	/* Serializes process doorbell allocation for this device */
+	struct mutex doorbell_mutex;
+
 	/*Apertures*/
 	uint64_t lds_base;
 	uint64_t lds_limit;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index e742ef206abd6..f092029f23257 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1231,6 +1231,7 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 		}
 
 		atomic_dec(&pdd->dev->kfd->kfd_processes_count);
+		mutex_destroy(&pdd->doorbell_mutex);
 
 		kfree(pdd);
 		p->pdds[i] = NULL;
@@ -1800,6 +1801,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
 	pdd->dev = dev;
 	INIT_LIST_HEAD(&pdd->qpd.queues_list);
 	INIT_LIST_HEAD(&pdd->qpd.priv_queue_list);
+	mutex_init(&pdd->doorbell_mutex);
 	pdd->qpd.dqm = dev->dqm;
 	pdd->qpd.pqm = &p->pqm;
 	pdd->qpd.evicted = 0;
-- 
2.43.0

