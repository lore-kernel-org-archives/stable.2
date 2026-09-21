Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010021.outbound.protection.outlook.com [52.101.193.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F036A4E1C74;
	Mon, 21 Sep 2026 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790010271; cv=fail; b=STwjZm+c+ePFaPXl9qGQuq8Pb5Oi8y0NaNh7362/tLUTGvOCM1GyVMKnGtwvJKLUC3z2/ez+vMpPJUAT1PM/e9Bx5EWLQy7p7xH+vnaRSQtNZk40bKf7NZ4TbOtjJwgJq0SzUiTW0I/s6+LWOwy0o4E1UQo9OtYZ6xsYXzO+5D4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790010271; c=relaxed/simple;
	bh=+u8UcEgTkgYCiTqqqGVs7bN0CuIB87LAhRqXmAPD5T8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MgZLzJ/N9kPdaPgnsat6gpayemOqNUwSAz2XL8QlUAGR7lUHCEBoJcF7UD3zumwitO/wuh6+qUrKcxjRv4R+otCRpnI/vfcgzzcHnFVb56muhlB4ksRGzH5GVpyjo48lR++hkYT3EqZyHpgFeTL0VydCgYddfgtK3Rx91cDe3OU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TDMmfHuQ; arc=fail smtp.client-ip=52.101.193.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TDMmfHuQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bRUa7UcU77nSTDeONF9GDpE23l3kLYsQfRlW1dY35nfNpvl1W1a2zM3LE92IJCOqcBF8miiNiJ5BhQ4MF/w0TJPxLUGQ24Cxx5B5JyucGXqX8YPqMnfzuiFSRvwwbV47bNKpB1ufYh+szWRzv/dXSaSrb/YoQH0YlkYspLu0030FdUIqd9323Vk8nQQSREd91Cj2fek3sthCUgA/6i+8OD0oq6ZYoeQJ6YkiLeuBkcDoTW+YS1I8NDMmA/zY4R3K/q6/hD0wJ48JT0VaBfkTfoIGNn8WTOVTrBwOLH059Kwi1LCBzsYh88NH4eX7QPzqHW7dHQbzSsk5JS1wwlyAPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9JHZjZBpQ+ufRHGqm4IZgKASICpZ3cp3vvmvlGUEQ8=;
 b=u179wcDFiaxstyGFhkyWG8yCH/mFHZzn7N/nGqzxiYr5Vq0VM/oylmq2nsvYdySfQMI4san/KfXT1Vr2ajDBcizPsePeONhQ8tg8uQMMooDx2ZfCsGxpX430ZiDtwWlluO5iFoR6deddjQE1LWIi0IrVrxC+2rs4zIEUlO4301Tb+VHBfVQ0PhOsUWOjRyfs7ys7agydZD2iMOY3FdvKfw0FiOUqV0BkU0fT28hC1sZbJ++4YsCoRze6r2SbFHgXNr4SHu/CJzYzYSZ3WwLg2p6WgA5dFm+g+5gX8OriO9mFCIgg4CcR9lykLWik4C0DwYbg9tKtlNxbGdakr6KYaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9JHZjZBpQ+ufRHGqm4IZgKASICpZ3cp3vvmvlGUEQ8=;
 b=TDMmfHuQA9Vp5Pgij+4+Z/k8M9+eUSPGzkvEWiD5/2VOoupB4VyUJF1rD1xzjCBn9TyhqrFMvmXeqAj9ffT9vPALuLv5pjtg0WMviQtIPWX52U8mzZIUqdnb6JkLiEn5nZzeDFNqwvd2NNnFphuZIb3JwPICWEymkv3u8OanWEE=
Received: from PH8P221CA0007.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::25)
 by LVUPR12MB999185.namprd12.prod.outlook.com (2603:10b6:408:3a3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 17:04:27 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:510:2d8:cafe::63) by PH8P221CA0007.outlook.office365.com
 (2603:10b6:510:2d8::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 17:04:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 17:04:27 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 21 Sep 2026 12:04:25 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: Hans de Goede <hansg@kernel.org>, =?UTF-8?q?Ilpo=20J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
CC: "open list:AMD HETERO CORE HARDWARE FEEDBACK DRIVER"
	<platform-driver-x86@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH 1/3] platform/x86/amd: hfi: Fix a use-after-free when unloading the driver
Date: Mon, 21 Sep 2026 12:04:09 -0500
Message-ID: <20260921170411.1149960-2-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|LVUPR12MB999185:EE_
X-MS-Office365-Filtering-Correlation-Id: 78c5cbc0-0794-4e7f-0177-08df1802651a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	I3qtmDbG68tGH1JISmIJ92UoUbt8zSQkSOIqnPMW8YHx8kz+SnbtNpEM+w/qI//3sqMxEyA7e/imxvP991ya6SmJNPpxet75iRHQyNhzWWwIyves+mfeA80xDXf4rKpR/7XPFky+aYQaybu+K+xdBxk8z7jEuhg8C35theQk10vFXstZY88jHxXh3uH9VQk9j3DkB6RdAHH41rncHGxKfWBxvu6fx6yRWy+u5Vx2Lodo0kf6Ied2tsI3rmEwW6UhnfyPSrJhX7u3NR16BzGrO/hZUl2ANtmjUTBzmP4byPuG+lsLqP+z9EIHpUs6F4bc39sw+4SkWDWATftvKPpoQiJsvSr2EbbF3lNAfI364KRBo1oT4y+dwEhy8FleFEmdyPq1aUDkrqO6hVGYa9jniAEwDecDLUYdBVl9rvx/KAsMzGASSpuZC0C20zwzUlaPath8s0kCK4mo9c6TX+X/hfXrEAB99fRw4/rt+FGpRdE8yrdE/tIxfWAVEnHcf6pbSDyOtDDV3pblVWA5OvJ67uAsC6FYICXV3EH3No8rRgqmpHQhtvSh6ncSgzaxO5j9IFH2sifuTUrC+CcQ32fOCLqOKpNBgWEfQNe9KJS+sCZVcZHyaxjpWybta1015Vas1JCCOIplZT4KtZ3AyM/aey0QLWj/hEiPrftpbX+oW0M9Y/R7d+DwVQThkaxckwzk
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pgtg8gPEZ44sq6FbkMYPB8ziM+rWawHrPavg2D3GQAsZ0kkt9wblBA1ybgrIaJ3JJoWqZyJkpLXLdWkT5v6hv1zrVjAb38NUxUKqyZBPkbUF4tcGI0SVJ24a25Twf2Ggv7ugM3N5rD/TF9PeXzhdU7bxr8rspTCHJMjmowN3u5r/3PS5fPVtzTzv3nQJM1CuQQyWg5RkJnLAV1sH2jfgGpkHP7OPNMUgQXWpBnSC8qlsBE11zNf9etJVdCrHcyIjwYLlQvXxttH7T4OKU9zyIbumwGf8AIExlRsbEH8G5HRQATnhAB3h3CWD499WidQcrrQSMp5wz6hY4nUihYsWM1OJAY1XsYl1YBUUrwF2CbSIASTyGWcmSOf9xrTL4FXhydPhibQYTZQ+Onhbxx9+7NvMdWOltjd66OjKMNYBhS364tYcLeHh+BpLGE2ig/h8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 17:04:27.4451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c5cbc0-0794-4e7f-0177-08df1802651a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999185

amd_hfi_probe() registers CPU hotplug callbacks with
cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, ...) and schedules the static
sched_amd_hfi_itmt_work work item, but amd_hfi_remove() tears down
neither.  The dynamically assigned hotplug state returned by
cpuhp_setup_state() is discarded, so cpuhp_remove_state() can never be
called, and the pending work is never cancelled.

After the module is unloaded and its memory is freed, any subsequent CPU
hotplug event or execution of the scheduled work dereferences the stale
callback and work function pointers, resulting in a use-after-free and
kernel panic.

Store the hotplug state returned by cpuhp_setup_state() and, on removal,
call cpuhp_remove_state() to unregister the callbacks and
cancel_work_sync() to flush the scheduled work before the module memory
goes away.

Cc: stable@vger.kernel.org
Fixes: bb20421c05fc ("platform/x86: hfi: Add online and offline callback support")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/hfi/hfi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index e0ebcb0c4acde..e1c776b71f3e6 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -76,6 +76,8 @@ struct amd_hfi_data {
 	struct amd_shmem_info	*shmem;
 
 	struct dentry *dbgfs_dir;
+
+	int cpuhp_state;
 };
 
 /**
@@ -244,6 +246,8 @@ static void amd_hfi_remove(struct platform_device *pdev)
 {
 	struct amd_hfi_data *dev = platform_get_drvdata(pdev);
 
+	cpuhp_remove_state(dev->cpuhp_state);
+	cancel_work_sync(&sched_amd_hfi_itmt_work);
 	debugfs_remove_recursive(dev->dbgfs_dir);
 }
 
@@ -494,6 +498,7 @@ static int amd_hfi_probe(struct platform_device *pdev)
 				amd_hfi_online, amd_hfi_offline);
 	if (ret < 0)
 		return ret;
+	amd_hfi_data->cpuhp_state = ret;
 
 	schedule_work(&sched_amd_hfi_itmt_work);
 
-- 
2.55.0

