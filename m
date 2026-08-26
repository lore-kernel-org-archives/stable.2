Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B6A3A1A54
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 18:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787770291; cv=fail; b=L0O2zcHXX/YkBOa5tCKnbktre+039/tG+n2WYF5qdJeJEKXZIdtJDCVSdwPm/6v6M/Nuam+FTUkx6av44sShVxWpe1uZl/iCdDUKdEMqpE0HE28YHn8WkUQvjMI6Gf53ZI1pSO9TkDNppzNjOpPmheFpVSKHsyg3QlwTg2fo2wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787770291; c=relaxed/simple;
	bh=5jdPRN/BWQd4aHHXBpUNBdTOdz70F0JFLJqWtDWdsXQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lrAhTP5oB8zFDcajqDeIQjrhJMSqQq+VGvMWd9+F9jVz/IEOvCuEfTXSFzyxQvFJ68ePS5CuPVMg+ezXUxNp2O1v1WUlB4lDQ443dPNRY2rkkt9evJykLuBM6n8rJlDQpM4evuaIA8vBlM/ghJiapjKunr5b18eEUzUCTuHSwVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RdN0LjZD; arc=fail smtp.client-ip=40.107.208.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RdN0LjZD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BnWpmZNtzxF8kOpxV6Tz7dqk3oox69o9XgJlDxvbwASWCjfveAw7+a879JBj54M9fBeJA9A95d+dV25dyArrBC2azuFnqcD/ETT80/74B6tk5HqOP3FdlUmeZ4tK9dy9AyLc8vF1UJ2XOeIzZFnhKjmCTfRxoSYwS2Yu/LILY11ylZgqKlU/bEL28x22AZ+N6qBZI2o2k4ajSASZOt4sA6D1rbq7GVhDr7aUS4A3Is4KnSY8C2kBsfJlZHYopHC5+EswZ6l77cdvcO0hEfCtWTF19sr0xTrQGos7N8w0Cc9RLAGQrzB6npyUCcFXQUgXJ/KfKfWomRyczC8Sj4iClQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0J54MxgkcTjQnRkrJGc4ICHndl1BGgKM1wih9zdzZQ=;
 b=dq66m7U1eDZ+bWiiqxgiPNNi9AxIeex0y4yym2mSyneojDLbC4eTlcUH23zwy0I6uCt6hK8B/AcMTC+qLAsAU0iIzYNXXrAu0ks6+xlsN4a1MBLh4iB/XW8koGkhDcad2WMzg7lvQNjc5Y0DaHAc3s7W2pii2Xjg46e0wK8dohUdDuEzsQzQ6pvJr9GPsH9icPw7puWEPiyKZIG01tmpCsWNpZKNTLkok3t6OHqMmmbAkCC9s7zcJWobRdFkzJrBr26It2VxzcOvBl9Ssmtu+fdaNA2O5azKGlIDDROsiJ5rWsZLVhRPPZrjJoiK6caWBF7OzEZb3GdoiYwHXGuJlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0J54MxgkcTjQnRkrJGc4ICHndl1BGgKM1wih9zdzZQ=;
 b=RdN0LjZDaGI6InKB1uDmoPO1P8T34nezNrpxPhRiaKz/PmG6w4TWgYQmxDPkiE7Vwn5Og/0uXwZdhzf33DqQe/CojJs/NXVlmUaG+iuRcR1QaXesbPzhAaBIfiqjCQP3lsEPkDxoIRNDte5EJZrnwRqO1gltbvWOihHGEuAIskc=
Received: from SA9P221CA0015.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::20)
 by CY5PR12MB6323.namprd12.prod.outlook.com (2603:10b6:930:20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Wed, 26 Aug
 2026 18:51:19 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::5f) by SA9P221CA0015.outlook.office365.com
 (2603:10b6:806:25::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Wed,
 26 Aug 2026 18:51:19 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 18:51:18 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 26 Aug 2026 13:51:18 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, <stable@vger.kernel.org>,
	<gloveless@jqluv.com>
Subject: [PATCH] drm/amdgpu: restrict BAR0 fallback read to SR-IOV VFs only
Date: Wed, 26 Aug 2026 13:51:02 -0500
Message-ID: <20260826185102.2269511-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.55.0
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|CY5PR12MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: ce292eb9-767b-4717-91bb-08df03a303ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	i//c8q6v8MRCI1Q3uaoiNr7oZr5y3JQtDvPGloXbhe+6CR6Ysi0diPt9KVx+DR3Sx2wFQU+n3vYEUN7OZ2yUWsVt7Y3h34dhq9VorHM3Tn++49J7ryfdRUY+N1kub1Kw+FkDVXXK3Wl4fEatw6YU034foADJkziWlyC8my38+4NsOOhsjvY5T39rjEtiC/D0cR5g0ohmSCcDFkXpzOeLqyn5zYIiMhk3AHxIHjqpYqSgBKaHAeBQgMxmeBjgzrovudJXu/uTKMFSJACvFrqc+QvQXtge3nmfbctJe462gtpcDewnV1vGk1ICqvT+bMmLIwwldqSjQD7NOzg/EWX1LXhXviw0S0zbtPwepoldhDAOKmr6Dnxlb4LLyDvEQH7h2RaxJkHru3/kEqpNiWGHl+FbjogRNd/VtpXXSiurin09tsa39iQhdSzSQEH7CQcT2/f2+62bjW5rm9vngNl2mvOA1rxbaFE98yv3Pa67ZZCi6TjeVxInodq3zy+mYz26e/fjb6ieU522yIq43cBxdMm9iW/WXZjLBU3MzsnGk0sWSHAKLTZSAVf12T6iftojO8KFFEPNDRgbrLvJP7p8wTopNkrY/odS13mMtU71EuWSiQtWSP7iO2pKZgwbr/68zYjYyVf4mslW3XSm+lBb059n1AdpmmKcr+BDSePIo9z9zZKnhHgzUzADPKWeUs8jTQHnAln7u2n1xs1ysaC+uw==
X-Forefront-Antispam-Report:
	CIP:149.199.90.133;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:unknown-90-133.xilinx.com;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1/0AWCJDHFpKN7O2GIYIadhZ/mxUjT5byHLaygBDBcFAW1w46UxoRSxitfzANcDNXzQUqi7ohasaEhZ2TgM56zI7q+QDFZZMpHaTyPjm66BOP1jOfTecq5rioZPzuTqTYRJ7nNzFwtlrtQogLJoB6BXQNw1Z+ndAufDyLVJJvaQ6m7zq/xVDE5VrEx+B1nDkGwW1uxGCuSJhRuTzmySuki7baY2j2jjc2sIhEWszfRzCD0LemKSKE2ECkqZHyCuFlKW1w23YRP7TZEt6mqF92ZDzUm2CQPU9q8EpHMS3h/MhZnvmI53XsLwZLiCgjOuWBt0jxuSEFvrlwnFq/xnxUX5SJt8fFkKA2E2e6dTMKPZ1trbTPUzDWBEXuYOn9Bj2ctXoabxDL1gTUBROrCXC+FeEitVMyXmgmnS+Boh7Y30fKptbO3jt1Tz444ZBfnQS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 18:51:18.9342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce292eb9-767b-4717-91bb-08df03a303ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[149.199.90.133];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6323

The BAR0 fallback read path was introduced as a workaround for SR-IOV VFs
where the VRAM aperture is not available during early init. Restrict this
workaround to only SR-IOV VFs where it's needed.

Cc: stable@vger.kernel.org
Reported-by: gloveless@jqluv.com
Fixes: ea8ac194077d ("drm/amdgpu: reduce early full GPU access during SR-IOV init")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 3603f7109703c..251c4aea013fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -765,6 +765,9 @@ static int amdgpu_device_read_fb_via_bar0(struct amdgpu_device *adev,
 	if (!buf || !size)
 		return -EINVAL;
 
+	if (!amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
 	flags = pci_resource_flags(adev->pdev, 0);
 	if ((flags & IORESOURCE_UNSET) || !(flags & IORESOURCE_MEM))
 		return -EINVAL;
-- 
2.43.0

