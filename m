Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5617634027B
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 15:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791993034; cv=fail; b=I9wCu3bYAOI2qkaHVIbI22jiqxWZxAxHPUIX+UidSq5Py7OpqOrd1oee5CgIjxawnkZI75c/pBakjkUHLF8DB74+EpJS6UYRcsS6Boyk1Jm8O/yi2H2kQ0nWKRctqXU5XMuh9LTO4C7XZjUMp3+Tlj86YURt40NPhmcp/B+qrqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791993034; c=relaxed/simple;
	bh=bcLePT/FbSIemB/CGgTXQPWOqis1FF0LDMbQTm7Q+Ic=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lwb0H2sgeXD6UsaKbvjlRE/ZoTjY+ie6DDbksapAxwoQzZDlKSuQMMladbLs+Oedzr/Hcx/L/gcaGv7WVUSwLAgk/2CZH+RZjCLDafBJoMFa27DIRRFaVVtU0cj+q2Q6yrLkIMSeN1iTVWlXRtjNAkhzjv91btvZ4RLZY73VKjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jd5mD1r2; arc=fail smtp.client-ip=40.107.208.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jd5mD1r2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gEwFg6P5GMWoi9oXZ1BTjo+GBUES6KmPBH34GvC8fe0sKVzsZT6NUO21Sm7/x+a8irpr18gZa/vNFGhKM34wLrHHLrh/4GeaTPaJLjmg6fUGRDcfRlXv2tIDb8XRflSn0DlYTpbv+iexWyxUySEY0Rn4cWMK87PGjOd6JpmocM5Ab5A901oBFkyhwNYlchGuAnugboifAorCGOV+a0cxKoVCNScMuRDFpC2yvgMxYislWtkUVVTDPuqtVgj/i+JE5zniWv6R+Y51bUQiKz3ML3dLGSCiINS3uJGtqBC7IampozxpL8l5h5z7waZgseHgpkvgSkqtjJS9gC/m87kC0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rojchCHyqtT53GKazdFyrwGMdZzo+2skk95g3V6KBGM=;
 b=MnU+u1mQ+4vMk42XtBaZMuSue4u9P2glP3q2HZ+/F+NfzHRmC60vdDekLksrDyf1evR6zE8bE3gbWoUbKIQNAkGOXKbXK9TzQ44mx9O6MLbOLULhlDsedjqkpIUfw2lwZrQSJe+zIjP+1AezfyTdjPAEEr58zPU9DyWCa8Ok5WsnHUr4MUhc4QWY8JdMd7ouAx7vjIhTECgslf+7XE4sQhrTBgnQLHGo/45JQZSARr5fPMc6VZ2VRaEKUWZLmBeAFYKOR2k9vPkHP4iFoM768B69Z8ogHsOqywx7q2zT5kmSo999Qs0EewXvi4nT8gNmprQj2z6TavpzqfqNMZNO4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rojchCHyqtT53GKazdFyrwGMdZzo+2skk95g3V6KBGM=;
 b=jd5mD1r20366qtjMan/s3uyxGnkcQJrY7Q69UvVMqXFMQq1JdSFhBzao/AiBmow4EspmmQCK7qPdBfKlxpEkjwdnP6LG1hBtR8NjjVSpyTALFfPOj0kfaHYOyJZ7JqPoEjPLgf/dW6C33c6ldl2ok9rPSAZd7CO7wI/GL1TB5iE=
Received: from PH0PR07CA0023.namprd07.prod.outlook.com (2603:10b6:510:5::28)
 by DM4PR12MB6541.namprd12.prod.outlook.com (2603:10b6:8:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 15:50:30 +0000
Received: from CY7PEPF000000F3.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::99) by PH0PR07CA0023.outlook.office365.com
 (2603:10b6:510:5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 15:50:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY7PEPF000000F3.mail.protection.outlook.com (10.167.247.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 15:50:28 +0000
Received: from Harpoon.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 10:50:21 -0500
From: Felix Kuehling <felix.kuehling@amd.com>
To: <bsdhenrymartin@gmail.com>, <amd-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: [PATCH v4] drm/amdkfd: fix doorbell allocation race creating duplicate allocations
Date: Wed, 14 Oct 2026 11:49:58 -0400
Message-ID: <20261014154959.540809-1-felix.kuehling@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F3:EE_|DM4PR12MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: e1d37d18-6035-4326-ba52-08df2a0adf10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|22082099003|10067099003|18002099003|56012099006|261009223027099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	18UBJ2vq0tOMyafYhVf/9ATGZvdMH9HV2QUZYrfKqoGyi3pmmcxoZIH33VlGhftl7UzJuA8elamrirM3JwThmP+oiyxxMDc4Vl2pkBgWLlxAfX7EOo+CCJ/Y32Fo8KyWAImrDVBGW7isaEK4T/rpyA+P6JM5Q+uvJC6LuKqy5iJJ1bGgtoe4iUf4BOV35tINBW3n7m9lwesG+izIF0YIj+k6SUxKUHv0u8e5PqkmzB8uMTM7Pk2OApTwj7FgfEZwaQorpR3jxteiTkQ5E5gE4bcLbt99MpntWf8RYftnT/FrkPOlCR9A9PQd+Py55ZT0nag3826Ow+vliFfohVVX6R7W/gaxs+fNkE7ausCAYJYSVc9QENw3tPqS5vNrVPCqviiv2Z/Ad5zi3OX6ZtL8aNGjkbajl46pkMjrcknwmIAHHKvagOe+ZdMSssZHjBF32pNHvDFFu60vwuiJKCaEnLFvX6J7axzHnQDT8WClX2Gveax6MCw3i/X5XP+0eRAZKYTpufmtxUM8bWcdKmrQuWOyXyENVRnRN54Y6C4C7aarHz7lbKL84E3xH8vVoJkfcJfu+4K5o4sUEwQC/UF9TR5hB8qJzO2oBphcChrNh0HEPuG2ybpKYG6Uyaf+CS0ahfLBWgqwYZj/KrLM3/Orz82m0rorW/4C91AJyo4OB0y6OFSoguLrv4rs/C3/Owb93IzNNrJablg/NpJ6u7MM7Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(22082099003)(10067099003)(18002099003)(56012099006)(261009223027099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CG/l+PENQHkPuQMXARaD21fCcBFCXR7y3S2jiuv6HrSeH+HJVvPysfifVIh07mEbsALtKiuAWWRO0QX/Oc+OscA6f8AMq6mGHtCzYigkKlwj8creaWStiabcZ28lu0RJYBwWt0oWVI7YtGSP1od7bvISw1O9DVXYfZFJTHvWnbsV0CSe+2tprMavOGljmTfog9FFYNHa+EOuPFTSwJV3U44SBuZfALu+7vwD8hPCC3t6pO8i1uDuaauTRUfBvOUNKlQh6fZCj2LRg/K+ISYDBEOYSEMSMZPPXa+JglINGrxCUItB+uZT+/5JR7eUR/p1sJEVCSPLefgaBiPfVfYE0iYZTJPO285Ku9aKd/J+lSHwigmdoghqM0MsMgHtsQDaEovAMI8PtZia8Dhi8c4Glh7koIcWZWmhYoDjdpednZqU1PEscRlUSl/1dYCD0kZu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 15:50:28.9467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d37d18-6035-4326-ba52-08df2a0adf10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY7PEPF000000F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6541

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
v4 (Felix Kuehling):
- Removed unlocked checks around other kfd_alloc_process_doorbells calls

Cc: stable@vger.kernel.org
Fixes: 16f0013157bf ("drm/amdkfd: Allocate doorbells only when needed")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c  | 18 +++++++-----------
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c | 23 +++++++++++++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h     |  3 +++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c  |  2 ++
 4 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index b3ebbee76088f..85fc450d79d73 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -427,12 +427,10 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 		}
 	}
 
-	if (!pdd->qpd.proc_doorbells) {
-		err = kfd_alloc_process_doorbells(dev->kfd, pdd);
-		if (err) {
-			pr_debug("failed to allocate process doorbells\n");
-			goto err_bind_process;
-		}
+	err = kfd_alloc_process_doorbells(dev->kfd, pdd);
+	if (err) {
+		pr_debug("failed to allocate process doorbells\n");
+		goto err_bind_process;
 	}
 
 	err = kfd_queue_acquire_buffers(pdd, &q_properties);
@@ -2455,11 +2453,9 @@ static int criu_restore_devices(struct kfd_process *p,
 			goto exit;
 		}
 
-		if (!pdd->qpd.proc_doorbells) {
-			ret = kfd_alloc_process_doorbells(dev->kfd, pdd);
-			if (ret)
-				goto exit;
-		}
+		ret = kfd_alloc_process_doorbells(dev->kfd, pdd);
+		if (ret)
+			goto exit;
 	}
 
 	/*
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

