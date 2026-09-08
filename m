Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012050.outbound.protection.outlook.com [40.93.195.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB0854CF5B
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875694; cv=fail; b=pBTyV0kL5nd/AXT+9q7r+iFqPzm7LKcvZ5hdYH84lXs/a8biUEh4FNT9PCzqWmDahpqHx9YZHUlxIqQI6hIVevkS6saWzeyeioH1j3+MIC9PIEu9sR4KXXHLBRTOqQzT+vivNuFtzdMUUzz38fbOi1NrR55e+WWqZRHLllNd3+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875694; c=relaxed/simple;
	bh=UUzvo39PwxBdTpG7mNDF/DS8GesXcWhsv0W/R06rpOg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nTui0t494hGA2Qg5IGfiEPaYChGiB6Kl4dLFnJDHeUIqSAy0abeKuWsH+muqU5tWdxZeNhJffy/3ftJoV7ajpFTfHF/wm0OGC/CK93BT7cKHXVAaVYOn/P6pXcRGyxhGZv+Q8ZijvyrVN6js9yqYkCnGUtgWExRHajODkwd+Vt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MfELvl5U; arc=fail smtp.client-ip=40.93.195.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MfELvl5U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EqV1xJy7HMbaaC3oXmzp/PdaszWyXyskcA1B8ylG6FT5gGSEgckXqhl84C/dQ3VqYbvQfTIQ3BYdksPeA4tGMGg6QWvMqvlUjKd2lNO8AxqXT1LwIVk2myQlAZeUBpRsCfgpDuRfBeE5o9YpTlxj/MtVGzA8o6PwAcvzNFnCeB2f8NQYSdK9bDKpLt94tWuZl2eP1a9kIq25tWh8GInM/Ll7sIe7XzXBE+550h5UlLMBIGtbB7pYVti//qki8JYn760HkBgcotI0agXpbN6RU8NawZA0jBFaNZCD7wGAqcfMtAGyPAi8clPyruoidFWiLUuVN3E5wFsKef+IHyD0ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v11dZ+FCAhY855ie8D1wxCKrerc+K5z5CnGYVaFtbyc=;
 b=YFTuHOUeSQMZ5H6M83FlolkuvL6O3yLSt9m0eBgohQ1qN/Vi2u1/yOKQkv/YYV5P/cd2qgUQkXyegqWMMKP+bWBnBzDl5i+Jzxsy2CjyH4VmmT60vb4JK/w1W/z4TnstjazDDmr2Z6lMJ0LLM9ejTPSnLjUMuWBXnzwUFqSac017O7591MdiPVJq/BxIxztrYAeCLSeJCOpbn4A/sUu+/n95YbpbBpiS3ko9YMWtipvJ5hZx/EflX6CUiF9DMQTIbrZT1bwIR7ozY9nKeYUoKJnpP4WU7jvq5UZqR7+glvUhucscJgyDv6tMBtIif+0wfHbNInUQf8ms1HWQQRfOQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v11dZ+FCAhY855ie8D1wxCKrerc+K5z5CnGYVaFtbyc=;
 b=MfELvl5UkM7QMj5DLwD9HLoXtt69khOlLqOyS4Q9HgM2lt6jTZlZMik7VAwDSnENUq+QCzNxGFWozX/AVVs4THzcWs0epIJclDxdnYO/qNlLW0+GIVmnfWrlmYiO/c8hamdTaijXfvJKD4jKpnTEVexNzkvYVrMvy3W+3/2dJz0=
Received: from PH0PR07CA0024.namprd07.prod.outlook.com (2603:10b6:510:5::29)
 by DS0PR12MB9275.namprd12.prod.outlook.com (2603:10b6:8:1be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 13:54:27 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:510:5:cafe::76) by PH0PR07CA0024.outlook.office365.com
 (2603:10b6:510:5::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 13:54:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 13:54:25 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 08:54:25 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 08:54:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <stable@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<sashal@kernel.org>, <superm1@kernel.org>
CC: Mario Limonciello <mario.limonciello@amd.com>, Lijo Lazar
	<Lijo.Lazar@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Alex Deucher
	<alexander.deucher@amd.com>
Subject: [PATCH] drm/amd: Drop calls to restore power limit and clock from smu_resume()
Date: Tue, 8 Sep 2026 09:54:07 -0400
Message-ID: <20260908135407.1640233-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|DS0PR12MB9275:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b02549-2a14-4902-490a-08df0db0b1db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|13003099007|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	DIl0RxhYX/3FOMZmBkt1DaRN+otfLgYpbeY5FdK5Wglt/vPnOfIigbpM3NLg+f9q7PTI8qZaFRXS958aCZ9lq6LhzPo2ReyUFC8uLoDPrL70aLn8NVn6+sjsSEBkf9j1m5jeMbgPUMDI02vHvtkVdTpukzhmsx/Am92Lf4hDqrwJdiE0Ahgky304BsphTm28tuxgMnnSbWWRp8Zl0kSg85+Ug8epiwDL2ZaVNGHhBH8Od0fevj+XuuDwtA+NDQu14ifAVkME9KfSIqsaiXeq8TMatEa9Q53x2fMt0Nxb1iwMaxtyOx1sIbtEF8q5bdn9xvc/UstvUw3v7AEzm3NZB/CCbInPAjlE7gBslme8iAUMf5y8r9Z6zt9xSsUvaDhXlCD9SDgI2LYxfZ/Zy/OzZ/ioO2OGm5JKFiq7w+wl01ymzXl7MkZX0FsZneH+S6ejp5b1mbAfKHZDSDH7BQz0bRqez3dmPdMp2e/ZqO1YcJWqRSxiqk8SoubMvif8hJ+IoeQk407ckBe8YymCiN68xhlT9BqMZzmxS+qxWDNy9s5kbT/xDDoM7lRDCTnJKd1oIjE5VKtSMnCm7t2F2C0daYj3St2EUCPaMv96o79tK3fxSERsxE2PjFKN3wqusXkz3t00WwODtAMImJiYIv8/QA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(13003099007)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5jJgNtiyNKqOGnu49xHeuNej85ZgUcuwCY8ntRl/SPAm5lSrgJpGA3ASrjlOHoxD6+P4JJKSUcy50x294Xm6CrLRowMryIaw3WtUML7zqlZNtFLbHv7+9VkSj78bwZlEYEy9AxEczHfYbJdBGcivt/cSISjMq96B3JDOvTRvKNhUqCCswmy/kq/oLV8so+deusr8pfaaTB/lBg+61G7Q5H9GuOkfc1X3FH+XkbBCdNNgHDEthKOziUdPg1xRXPl25MsohXafg0Xwe/KfcexFdviFpacDCvfUa7xS6PIB9ApJwS1BDnGfE9oOqlGV5jttY0oHd+u3kEjXm7Z46OIjqaO0Gc4EXSPD2fnB1JE76u0/hwlaHLaTDdJfA7jc4zFV/LsB3lQofLu3d5rDTPvygeUc/DGjbQybQ8qnl8qUSQnmd92EtKvESWP5rSBIPgLF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 13:54:25.8364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b02549-2a14-4902-490a-08df0db0b1db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9275

From: Mario Limonciello <mario.limonciello@amd.com>

User requested power limits and clock settings are already restored as
part of smu_restore_dpm_user_profile(). It's unnecessary to call the
same restore as part of smu_resume().

Revert the following commits to drop that extra restore:
commit ed4efe426a49 ("drm/amd: Restore cached power limit during resume")
commit 796ff8a7e01b ("drm/amd: Restore cached manual clock settings during resume")
commit f9b80514a722 ("drm/amd: Only restore cached manual clock settings in restore if OD enabled")

Suggested-by: Lijo Lazar <Lijo.Lazar@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 4b6ec94fdae2407d9b8e69e3ec5f879e72ad667e)
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5634
Cc: stable@vger.kernel.org # 6.18.x
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 53d071eddbf4..8473eaac1e7f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -2234,7 +2234,6 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
 	int ret;
 	struct amdgpu_device *adev = ip_block->adev;
 	struct smu_context *smu = adev->powerplay.pp_handle;
-	struct smu_dpm_context *smu_dpm_ctx = &(smu->smu_dpm);
 
 	if (amdgpu_sriov_multi_vf_mode(adev))
 		return 0;
@@ -2266,18 +2265,6 @@ static int smu_resume(struct amdgpu_ip_block *ip_block)
 
 	adev->pm.dpm_enabled = true;
 
-	if (smu->current_power_limit) {
-		ret = smu_set_power_limit(smu, smu->current_power_limit);
-		if (ret && ret != -EOPNOTSUPP)
-			return ret;
-	}
-
-	if (smu_dpm_ctx->dpm_level == AMD_DPM_FORCED_LEVEL_MANUAL && smu->od_enabled) {
-		ret = smu_od_edit_dpm_table(smu, PP_OD_COMMIT_DPM_TABLE, NULL, 0);
-		if (ret)
-			return ret;
-	}
-
 	dev_info(adev->dev, "SMU is resumed successfully!\n");
 
 	return 0;
-- 
2.55.0

