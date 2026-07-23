Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010013.outbound.protection.outlook.com [52.101.193.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3315B27FD49
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 13:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814377; cv=fail; b=ZXekhkJj49QJniXjFozykkOI2hxCNaoEr/+S+xdThhpD/kOUeNpcaXOGqQr1cnXi71rV7N4LJ9cLscJ+AaeRwfN7ELEGRrtSr57tztRjilvKABlMiSW0C5J6UrzQqiem3YuTzKfPvY6Uu5XMTvBNAvBNe6AOUEOmLNbW5hMXSl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814377; c=relaxed/simple;
	bh=gpuv15sYj9mVInC+2GQEpZ7N3jVPMJes579Z39oVir8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uf8irIErNhlxN1ESmZgE5qVC4KTuEUGXnbXcyGUCq0DRyjiR3w/dG3D4E0tcwMRxb2omM9iDOquMySBqKZbBPPp1DW9rAYuRdeBSQASQn5/2wtIfNWNpWyWxRfJW2pPfEoi8l7QL+n8aMDSA73jF6KT3/5iOADC4ylt7yFMNph4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rol0fOkq; arc=fail smtp.client-ip=52.101.193.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rol0fOkq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cw4oFz+KSGu7bKouSWi35jiIeTlq6F02uUAZy40OMWrYYHOaD4oOQRsSDH8NVE+VgVaWbIoBgqGlabaIA6hKHRKGml8SiW+oBG5AAZY1otFIU/a/Uo4jQ+Mlyl/92Yixh0ue28Gxl+P9Oxo7PtfzagwtYM98yUjfVFA4OQGrnbR13gomtMNMd+RyTxJIh0jHcYwp9d7dwtbwXNAfAG396q8xPQPPoBA0q9WLid5umjgQoAByXGv8aCPz4UC1U9DqXD9AWDf/Y5R6Nld9UdBaK/la7tmKR7OzQ6u4StVH6eco1dpRzZYlKqwIzEz0+CzRON5qCdB9aZYO7s6tVrTiew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/+awQc3TDN3+1goZQXiFonB5co4HP4iE5njQVaCpR0=;
 b=n9JcNKZpinpo46sUxtcy7YDEZZy9+UdYC39KjVNtTHSgF+v5lXm8keVMUdrjs3hwE0PbIpUvdDehaJFQN77T7yY9js4Z7Spj1FoSwCAeyUIUnl0+CBHx2OzVfattGpMremjjIob0pZt6/FoWpefbz+6vDOUtgghIgxYpuETq70qIuIUh6alNib9PDftjAJREgO+yhHCJXI6yK122VK+AzlRH86dbDc7+zOAWzB/9r9QEgexaISl4vRx7kP22Y/8wzl2dgcgdNSPFY/Tz4e05DgrcSx397+5EQyTKaZBB0xxKicIqLj80TjG3HCbjbOB1UhiDNUa8eDFsySZYnfHZkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/+awQc3TDN3+1goZQXiFonB5co4HP4iE5njQVaCpR0=;
 b=Rol0fOkqa/5fn6RuLFKq3QiYG/shn8PY8EKcaSXVi22bsMbRE7CdwedMoZg2JjSu2QJ5hrAG+U2RqiVhLuHv9TwhS23hB37wI2rMgoCCLy+otvRF47cNyjtbZsGc08nMiWKgK3SwDSVELSGC1vRFXKBs8lVJYTz9ESMLguJOIh0=
Received: from SA0PR11CA0003.namprd11.prod.outlook.com (2603:10b6:806:d3::8)
 by MN2PR12MB4392.namprd12.prod.outlook.com (2603:10b6:208:264::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 13:46:10 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:806:d3:cafe::17) by SA0PR11CA0003.outlook.office365.com
 (2603:10b6:806:d3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Thu,
 23 Jul 2026 13:46:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 13:46:08 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 08:46:08 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 08:46:08 -0500
Received: from flamewok (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server id 15.2.2562.41 via Frontend Transport; Thu, 23
 Jul 2026 08:46:07 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <mario.limonciello@amd.com>,
	<alexander.deucher@amd.com>, Leo Li <sunpeng.li@amd.com>,
	<stable@vger.kernel.org>, Lu Yao <yaolu@kylinos.cn>
Subject: [PATCH] drm/amd/display: Fix missing DCE check in dm_gpureset_toggle_interrupts()
Date: Thu, 23 Jul 2026 09:44:50 -0400
Message-ID: <20260723134450.13838-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.54.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|MN2PR12MB4392:EE_
X-MS-Office365-Filtering-Correlation-Id: e2fed173-4e00-491b-cc22-08dee8c0c013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Bc/P3aHjSciaSQrYtScAVxeOweZBBfywRivvmRKqikFzuCHDgpNVcP0hGUCgMaiV2+XGUaA5LZkENWQsUb2T99rN/Q0Kac6c0Evc85qH+9Gpk4bo+I60IXBZfywSAdnKvgEKACHipQp+aCIZP15AItsvnjJxwgrOyeaX7RR6TbZE3SzwQF03P8LcA6GE27PVe5YZcO10tNtIpL00xjhjZKnOvv38nwT/FIVzVyPsQEf9bjji+s3IRkn2Ls9f50QZxd4tr5xs4PQ/iSyER7unA9mRaJSdj18JSaNxcHACtT95N7IET9O7zjWbcuIUlx1neMBJ1Nb6D+JhbU8hUlmD2jTPmHAhIy91rJGWLbyfoBX6SUiqTbWNl2686GT4RZos3HSyzGno9S5zJNdAY1QGMTUmiK9WA8iGNVSADuOT3Xoll2eRsZ5hsv9O3d8CEzolkc+nRLsESy8wNaF0sYCnIINBjj7T37G+itba2T+kSsjNkM6h/plpojX2ScfqRdqS001QZhW1eTIWdNBlaQaGKoSUmv5h7M3zpzXizWmUeyRUcD47jB7W6+2/ZF9UrcpcaJson4emL2r4esGGKWgSx2fSbyAo2/V9YWiOwbxrXcKR8znAjGhJvlVyqmVkBjgnOdWw/aGOeWUV2PLq040WXHfbnrfZ04jtGqUpJk5NFEm02hvxaKZv1A3w2Ujxyjz1DpqSAMr4dQAgVATOq098dQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2yReuAJ+nWkqnZN7/rMFZHQWD9DyArrds+lfGr6YPoywgkcqHfh2hUOd80KWVAM6xC/AmwLrjVvz2PX6aZD94moIssMmXqk8x5O/kv33gL6Pmn/SwFH2Rd8ZleWKsPACXG8nzZzMeO45WFmx1asQSBaWRBCEP/Q6xCAqSWQ2SPy4mCT+xuU2MXShOsIyO3YaU8uXZ3KicywjnSSQpCBfeBOA/eEUPfcFfc3g0U+QI22Aj3nfHJjZ7vtrmG5OVaDMID667uP3d6lbAWlWFB0JmqtBkROr3Hz7DaJLGRi0QtsYUL+Qh2wRyZZyOy0H+Rzwugn/RZYpSKHAfj3uLLONHTozzH+NZmtNlP9/++Fb/nKlebdCGrdLPxif9YsEUO8jJcvSVoKGU8zHUQ0eMX7RKtXoyBIO/FljkPJrNapF9jxlsyJlm04pEKJdAmCJXOu4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 13:46:08.6420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2fed173-4e00-491b-cc22-08dee8c0c013
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4392

From: Leo Li <sunpeng.li@amd.com>

This line was lost when cping from amd-staging-drm-next to drm-fixes.
So add it back.

Cc: stable@vger.kernel.org
Fixes: 8382cd234981 ("drm/amd/display: consolidate DCN vblank/flip handling onto vupdate_no_lock")
Reported-by: Lu Yao <yaolu@kylinos.cn>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9c564cd5edeea..eaf19ec843e87 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3324,7 +3324,8 @@ static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
 		acrtc = get_crtc_by_otg_inst(
 				adev, state->stream_status[i].primary_otg_inst);
 
-		if (acrtc && state->stream_status[i].plane_count != 0) {
+		if (acrtc && state->stream_status[i].plane_count != 0 &&
+		    amdgpu_ip_version(adev, DCE_HWIP, 0) == 0) {
 			irq_source = IRQ_TYPE_PFLIP + acrtc->otg_inst;
 			rc = dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EBUSY;
 			if (rc)
-- 
2.54.0

