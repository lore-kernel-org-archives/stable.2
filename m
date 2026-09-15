Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013047.outbound.protection.outlook.com [40.93.201.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6873B6C1C
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 18:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789495340; cv=fail; b=pL74wT2uLTaC/y69Pa9lNoIIAs5BicBlxwuN3B9wjytcq/mtjsTNN+q8yNKBP0M25M6GNcNgMfQnwrb/J6AVNU6rUSOncYoAnP+CYs4SJ9xdWA5EFaoPhy2L/zpl5Ibnb+C0C6+tq+4MzaeQZDSsRwYHNNkj/2ZlMzOvrnk0Dko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789495340; c=relaxed/simple;
	bh=dNxWal+kSPh9F5lvQLYRmWOoHLLMkE/Ay7DpJqCfBiU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gr3jOd6RAVFDnQq5PwO8Yf9oBDrrmE+MN0uzBlbEk8lfrRFMxwWUEguC+oKiG4ogq7tVHLze376UReAI/V5utffbjxToXfi3lBqUVO/lPay8tpg06xs33TW5nvS1zbZM/QZDYRxJoqbDH2ELiwNvvAS8og303B5cwt5HsCQmbyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dM81Lxph; arc=fail smtp.client-ip=40.93.201.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dM81Lxph"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wPtrtX+4GrrdQEMjm12qCYjjEKGYYZ8+0JQpPV2e+sEwFiMB9hN7jsmYZuUWtHjpQdb3WJ45cXI1iGi8NHNt0GfT5YMCM/GhFwIvrHUsaH/7G0xiI6kyQc+8n0l8NtkxKWyT3Chgu4pXmg+gztZdAyK/8BNpc7DzQNxdrzQ0uVGnLhZTUCC7JzJGAr8Zetdbt0yZrYioApjwp47XyXpaC/u+8wkA9uS3yPCuUq3jPQH7NzmchbO29BOGy49x3ZpH2FWwBTGstKwojblbWf4vNzfWcMZ1nqZS64xg/yUkv40kerqjEFvXpmCuVR8eLQ9jAalqNvK39N7HNPK1Lp5i7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HECQPV+7L8WHKXY0rIEL+166Fv5D62wx6PIpJQkIhr8=;
 b=KyiGNCokk4guqnPiALsC0Fh9DKxfEdzhQCKMqTx47f2vvR9NM/EpwdYzpukYUxyhUl9SLfkm3TE3BniGSt/u2pN3WzhRPTintxH0us3W/w1ir7vcAEiy8yihx5yFvGZCZIzSElE51yqYENhDh3rjgpcuKwrF92Sj4axVeiT/ggQn0Avfzzcmvwj9p5wRFpI59mqg1rwPxueKwSoH/tzd4+JWFXjclHcyZmK0MYx9AQRC/NCR6gxThGF25l+2ymsnkFFgwzxtOnm2gLuMpRrd2KBoqDGpZysU5em9SDOPJnx2vSC6Mjt3/IHy7eYc6TaP4pi1+4pQpZmCqwT8SoRLiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HECQPV+7L8WHKXY0rIEL+166Fv5D62wx6PIpJQkIhr8=;
 b=dM81Lxphsvu8FZn/wrZd5AqoG1D23fXAyAQLIUuy2Gr5GSsBieUbCbJeMF7x/qVjKNKvN8hPcnvxal/DNGoEArgNSUxCd7RkJsrZUmrSDq5TU6m4sI4z9JR13XT2lE+Ck8jQc9emw4oEfQvbeq5Dz+ZxefP7L0EVAwXvvkBKl5E=
Received: from BY1P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::14)
 by IA0PR12MB8974.namprd12.prod.outlook.com (2603:10b6:208:488::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Tue, 15 Sep
 2026 18:02:14 +0000
Received: from BY1PEPF0002695A.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::1c) by BY1P220CA0001.outlook.office365.com
 (2603:10b6:a03:59d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Tue,
 15 Sep 2026 18:02:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0002695A.mail.protection.outlook.com (10.167.244.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 18:02:13 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 15 Sep 2026 13:02:12 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH] drm/amdgpu: Skip KFD mapping clear before initialization
Date: Tue, 15 Sep 2026 13:01:49 -0500
Message-ID: <20260915180149.2162871-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695A:EE_|IA0PR12MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: c72dd32c-3143-4cef-2dae-08df13537851
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|13003099007|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	eAQlLJWk4KjtqyIsOo7cIhT8njA0Py+R5NTU6DzYEFP8TJx7kgOsPOIIFm1JCCT56RXIFEpwvpkclmkn81+kh6nP4Qade7drkVCFixpUaCZ75/X7fjzOEoycVKBjMhcKpyaebE0kans7HarNHgRRzU5MJTCDNqNzRHeu7MiGhaLmR/3pA4BCQt5Wqsp//1yzMoq8NpnrJrDQPEfQUHmZoV5K0SZYoC5ULTiEadJTfknJK5+vJ2NejfMBrXvqzBDTcG/i9yrDgI+O7zkOy3oO+M4Ftv5I50rpa+LucTh5jkCTKPGvTnlqY1T+c0Fpj4rcGP7poen61fcEAnfzVop7fFoLWdfBugDLRWrlOIO+94vH7PAKCZM/gjLmUJaOacYov5JmEO4dBAPB6U2vIOxh9O+tYpz7D52O/c/4+D4gPrmBF3iuyzkwlZwHhgjGaJVHpc9lRxiGuSfC1TL7H5OQ1tvetTI2uz3TG0cpOujfSmuZ1V6U8tJNTCPGo5ZAPSHrH+B7/G5jioR+7Gjp9Uv/xT6ILwuNeQL51yhL2rJH2X/jXxo3h3MXkeTPVy1GJEFmVZLz5TTA9H808FPMDGunvcfaiZ6XMF962thDsGontEtLYnTpSzcMz+hoTrrk1eIg7bb1S3Yghs8FE4wZRdSBVA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(13003099007)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sXcEIdVDTRdI8orxf98neAC31ICF34VyQl5JJ1UAxdPW0UHHLTo3eu1mDLfNwwYBXdP1ibzq3IbmZ4oW2tvfQ2cAtI5wpJ+k3Wjljn2khwGA06F5+R1i5yEDibaKBuERF8YIsRrIWKkEsY75V4Ee9MHs+LoWz2lkHLmnZdl5xE0ExxfEZfQfqeibBDigolQfB34yoQOYrhBQBYQ8XddRy1Tu6sbWcO16vMggDSpZ5tqURRQGfv+RmSBYNyjhMAM2zoxLPJltpz+gJfC8OIZPqsmZxc6gVcFYLMZF00477MnNl17XJsfRHgNz1c64Wvo8jrpgbt5X5EqrqXgR640tDju0mPjg9IbW6FveLhtuijyOCwFkOGRbvYvsd+t7rUtrKslJ8ro/nuHjeLqDfPHS+0g9rQ+f9+ziPgiB+ZPcmQT9yffWaMx4dF471AMs9LuE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 18:02:13.0419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c72dd32c-3143-4cef-2dae-08df13537851
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0002695A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8974

amdgpu_amdkfd_clear_kfd_mapping() assumes that a non-NULL kfd_dev
has a fully populated node array. This is not true when KFD device
initialization fails after probe.

For example, kgd2kfd_device_init() sets num_nodes before checking
PCIe atomics support. On a host system without the required atomics,
it returns before allocating nodes[0], but the kfd_dev remains attached
to the amdgpu device. A later GPU reset then dereferences nodes[0]->id.

Require the authoritative KFD initialization flag before walking the
node array, matching the existing KFD reset and teardown paths.

Fixes: 353f7430d1ec ("drm/amdgpu: unmap all user mappings of framebuffer and doorbell before mode1 reset")
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5833
Cc: stable@vger.kernel.org
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 09feb45584bab..17365cd0a997f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -330,7 +330,7 @@ void amdgpu_amdkfd_clear_kfd_mapping(struct amdgpu_device *adev)
 	struct kfd_dev *kfd = adev->kfd.dev;
 	unsigned int i;
 
-	if (!kfd)
+	if (!kfd || !kfd->init_complete)
 		return;
 
 	for (i = 0; i < kfd->num_nodes; i++) {
-- 
2.43.0

