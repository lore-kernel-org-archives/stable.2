Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011059.outbound.protection.outlook.com [40.93.194.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9446D331ED7;
	Mon, 21 Sep 2026 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790010295; cv=fail; b=I1WwD5TZVHrfKqqLiWBv26qpP0Mr7eMXmkSWKuHGocdYJm1Flhse/iMTI0iSFfeXD21hheftD7/5RUwwhqOSmijnmvQYQDnPpviGmF62T5c84hL4qyg2srnGP392fHDzFpBQynwsQzOtLRh8oxTVcwk8t5B598CJrWFr6xJRodQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790010295; c=relaxed/simple;
	bh=IPJFY1knDcIv8S2+fDd0cLbPqhZ7w7ykpzBzXkLU53s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eQsHMkUm9dpH3ln2TXqpyW6bWnWyjIMLCeyclcRufEvdN06lWWxW8/9cBHLS5RiEIum2wrIHrzWDjGcMzttGGO4YcSEJkBpKc9vQyCUNrY5A1YZ54e55Oo9PqDZmidBky1/Yf0BtQ1yNH5V0hp6jhk0hrZH7bmiesIWX2UsV0sY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U9YBq/rH; arc=fail smtp.client-ip=40.93.194.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U9YBq/rH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hnlPmBvkfbRhYDTptCnMbeh0nqX4H6B9mXFKPDODRi9MAxgq3vYKCV4YwwOzLbiAhyDdaDY3RuHxrGwiZvGsBGqgmRliA/HNzyJgFJ8rqVHgbx2VU+3YvXrh38rdlEO/EHX9guiBpj4raR5mFobmIjhYkx3JHqP7dGANM/zqyecO9btK/maAxw7J4KEbj10xNPRBTb9nPrHkUvFZU6pLLYtQh+uczqYz3He/nJ034piLrRrv83P4et6J0RIrGDUxsMC+sX0egKG+Gs6ACoa5vKH0nX82ikDbxtaNW6TnVkh30waam0N5eresZIvykIfEXbfjT0o55R4OnHgrfGphIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bg6LqkzEEc8RmB4SljDTqIQW8c7y5MlVlegAMDEntJs=;
 b=I7LCJnR0KhFLd9xbQF7Vb82KWhfpKdSTRtyfnUDG/POTH5LDtMcdK+8feuCM1O9EvFzbEEOoYqOhiKq8bf6y5nsT0SvBohkFMJ33KrOmzLCOEwZZsnI3p21YKQX4BNlPLKpkMiGdSZ6iVFPjWiaV9fN/33/LMUuUE+qvXauN2SysJU5r6ETdZMnE+AhmmJStxuJvQS6sNMnFxjwoWlQGgCfccbnUMy5wTU04jyXCOvWu9yRGS3qQv0JSNdFVNhWqbwJxjwvRMcKMFG37D2HaKeT8e6H6N+nQTRPPK7te2U7oJ6mRQeAFA1wOZ8TeumAxCkMtccLYnGTd56ca8r66OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bg6LqkzEEc8RmB4SljDTqIQW8c7y5MlVlegAMDEntJs=;
 b=U9YBq/rHBjWhkPrLjGRg4liQjl0xVOM8cfBWcZs8RFAlAVnoUC3v9eRW9X+40DLH8eTH1+nyUnYK4Jdurix5z+J/6c/oL6jAqZGW6CkGuxeOthgL3eEczMY2dktpXlZsLUKIGSlehekofuYKOXW8eRJ+4CcqE9BtVp+ZFZ54zgk=
Received: from PH8P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::12)
 by SA3PR12MB9090.namprd12.prod.outlook.com (2603:10b6:806:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 17:04:29 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:510:2d8:cafe::93) by PH8P221CA0009.outlook.office365.com
 (2603:10b6:510:2d8::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 17:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 17:04:28 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 21 Sep 2026 12:04:26 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Hans de Goede <hansg@kernel.org>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: "open list:AMD HETERO CORE HARDWARE FEEDBACK DRIVER"
	<platform-driver-x86@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 2/3] platform/x86/amd: hfi: Fix out-of-bounds reads when parsing ranking data
Date: Mon, 21 Sep 2026 12:04:10 -0500
Message-ID: <20260921170411.1149960-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921170411.1149960-1-mario.limonciello@amd.com>
References: <20260921170411.1149960-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|SA3PR12MB9090:EE_
X-MS-Office365-Filtering-Correlation-Id: 85c8eb26-58c8-4f03-486f-08df18026581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	E/UFUusPxie62BzWFpEzuoSJe4mv81MHmZx0EgG3N7eayWXude78owDTNnRKavTyD5BghNuVMQC5sfjWxY3UZJe3cOZbJMqJYItix/nkRA+ia8NBAWMwdTk0bB7wUlAd6thbJQMtHpP7/ESmAeiF3PEp8fZKmxWZqGIiwOilL8ssjQ9ERP3H/b6v4EfeE6Rn64r8QZ2BTAKSnGqcHEc/V90c+wLcnNDXC0cs0EI+ZZWbxcrQJjnvJNz0DMsqDIRiajbKpz/2aRmSXYlYvFvUmikyiIMA4LGqwlNFEDY26BA1ES9CAu8Dniu/V+iDOYiK6y/jxmfF+xCl7+8fBQBJ0g+Z0lW7ln8HA483evLp3sNuwIZkCI9jiFoU2tYYNU3EVVlLKbDyBbtmn9ZSJ+T2Phe+ALI2sGmdjgQC1bZFZYBl4YG1/B1oDI8B/Zl7n7sMOKKIw4A41QMydf54gvg5iGsuM48xinyVXEo2+nSxhouI0MhwjGK2MDN6mr2w2/FFKff4u2p3I6tQQjZ1vZTASKxK1J08G/CUgpodlz6fAq4AL4yCfAZo8iTwscUbSS+iDXxYUKjf42GW+ip8cbvJ1Iw8oVw5i7S5pmhoIBeVaF1Qxcdbfr34fDTDSMyPuRwz924Z+gRE+aWAQo2PA3GjP0BMGKRwaAsu8QnSs39X48Tmdkavhe0sd0bqhmajVKyHH+obLJMXvBHttTa52P4AHg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vb33keZxwvoMcSoYa7aT8PC3ShUdJYPMoyuikJMPXH3huE4cN6kVsvz9SH1pST+FAHwZP6bcrpo4RKN3qDtd4b+mFGU1lG42i3i1wtnMtsgGVRZEdWVUmWXjOhhUmEvUFIk9vnuJKh72KlyTMhA2LaEnHXUIBD6iA5NoWjz9FkmZzCQ7Zd5xc5IzjdQKrrLg+iOxcbpRIUnSLiuQCrZducmoDhPTSqZBuiIXH5jkvZ1Xl7RKl/19CYtp0gUP1ioenUYJOLFasCxPCFyZTaSCAYI/zmCZmAyr+MZ9osr4xvKgT2P4OjaUjLnRGEN7oBuTW0SRxhqI70gH8gKhatRXVnF+Zv05riXXkPC973jw6CCzURqsAKjkNJGv3U4yAgnnJsli+a7wIPEK6Nkgzv7a8kK4t9XVWGvQCnLrWZ5rQBIlc+zmeFeAtrTIFyNWyfuz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 17:04:28.1244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85c8eb26-58c8-4f03-486f-08df18026581
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9090

amd_hfi_fill_metadata() parses CPU core ranking data out of the
firmware-provided PCC shared memory but trusts two values it should not:

 - n_bitmaps is used to bound the outer loop that reads the APIC ID
   bitmaps from table_data[], but it is never validated against the size
   of the shared memory region (pcct_ext->length).  A firmware-supplied
   count larger than the region reads past the end of table_data.

 - When resolving the base of the ranking data for a processor, the
   pointer is shifted by an extra "i * nr_class" term, where i is the
   current bitmap index.  The per-processor offset is already applied
   through apic_index, which uses the running count of active processors
   (apic_start).  The extra shift compounds for every logical processor
   beyond the first bitmap (APIC ID >= 32), reading out of bounds.

Both result in out-of-bounds reads that can corrupt the ranking metrics,
oops, or otherwise destabilise the system.

Reject an n_bitmaps value that would not fit within the shared memory
region, and drop the bogus "i * nr_class" term so the ranking data is
addressed only through its correct per-processor offset.

Cc: stable@vger.kernel.org
Fixes: d4e95ea7a78e ("platform/x86: hfi: Parse CPU core ranking data from shared memory")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/hfi/hfi.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index e1c776b71f3e6..6d1d3b6c28a97 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/mailbox_client.h>
 #include <linux/mutex.h>
+#include <linux/overflow.h>
 #include <linux/percpu-defs.h>
 #include <linux/platform_device.h>
 #include <linux/smp.h>
@@ -168,6 +169,21 @@ static int amd_hfi_fill_metadata(struct amd_hfi_data *amd_hfi_data)
 		return -EINVAL;
 	}
 
+	/*
+	 * The bitmaps enumerating the APIC IDs occupy the first n_bitmaps
+	 * words of table_data.  Reject a firmware-provided count that would
+	 * push those reads past the end of the shared memory region.
+	 */
+	if (struct_size(amd_hfi_data->shmem, table_data, amd_hfi_data->shmem->n_bitmaps) >
+	    pcct_ext->length) {
+		dev_err(amd_hfi_data->dev, "invalid number of bitmaps: %u\n",
+			amd_hfi_data->shmem->n_bitmaps);
+		return -EINVAL;
+	}
+
+	/* The ranking data for each processor follows the bitmaps */
+	u32 *table = amd_hfi_data->shmem->table_data + amd_hfi_data->shmem->n_bitmaps;
+
 	for (unsigned int i = 0; i < amd_hfi_data->shmem->n_bitmaps; i++) {
 		u32 bitmap = amd_hfi_data->shmem->table_data[i];
 
@@ -192,10 +208,6 @@ static int amd_hfi_fill_metadata(struct amd_hfi_data *amd_hfi_data)
 			info = per_cpu_ptr(&amd_hfi_cpuinfo, cpu_index);
 			apic_index = apic_start * info->nr_class * 2;
 			for (unsigned int k = 0; k < info->nr_class; k++) {
-				u32 *table = amd_hfi_data->shmem->table_data +
-					     amd_hfi_data->shmem->n_bitmaps +
-					     i * info->nr_class;
-
 				info->amd_hfi_classes[k].eff = table[apic_index + 2 * k];
 				info->amd_hfi_classes[k].perf = table[apic_index + 2 * k + 1];
 			}
-- 
2.55.0

