Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011036.outbound.protection.outlook.com [52.101.52.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F13F31A572
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782233311; cv=fail; b=UTeGq2JU7yUnu8iWFajbTIIdHizWFyhIXIPTe+aGG8sI//CsMOq/iHUUGxFdBUuXbxkCVXE4RFa8rHLsswA7Si0WRLnnEArQOqL6m+CgQyGMGnx2S1lV1mZJ/d6tJmwcEFYT2uittqQsMq+ym4EiGEIaaehu95Hm3ZJgk6/F9iI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782233311; c=relaxed/simple;
	bh=UwoeC9hL0tr3xiotuDM9x3HIcxGELXEzVnVXqcM+RF8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dk6x8HlFdq8/2ODQE0jSSw/PZIYrT9jp+87D0yZari9hVU7TAAxVFnEBp5heybKb/f+g4Gyyty0BgrEopvRs3Pw21Ps7fgCkJ9vWXPIAXuCtxkUabv+QLfkJ0H5CKnPsVswVekI/ltJHqouJiPDeDbx4a2vXaJ4gRBHaAoRYQ04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DrjWdJdn; arc=fail smtp.client-ip=52.101.52.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DrjWdJdn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HpHGXkBpymFhvhoSEPYiNDVbHl5eM/nsifGF1U+jyC95mZE+CqMfwKCs/5SRSNnmWi9FCEx19mwJz+FivmNaZ0DkZoSy5mM0HPUHUvDtvEBvE+6aFhvtFbh8wKbKLk4o4jLLwtKr6n5iHtqe12jxBc0H0U/cpF9sfRTtYYtqs24QFJr1Rkb//mTXq4oCxhuYt07CIR5JqSHrbkVpnhaLFtlFBQiJ1e+pGg4WwDslMznVKOuyqsDJErpa3onso3DFaPsCaoqxifnn7vx8z4WfjkmYQwCioomwYyplrfW193RryOKh+SY5rxdOeFU+PKn+1708IB1DX20XvJcZNVor2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XgEAEcpZV7HPog/ER+MmoCPvyM4sJ8w732ybNx6EXE=;
 b=lmBpu63OK4MeJW+9yg8OpbToD8a9TxLtU8AOzg7Fy8dRASciiSaDML8jqveW+MRvrLdUjvPPdT4E6voRI7zl+mVTIV2HH/bUuKCyCcNx7s8Ey34RN42aqPX8OF3E2ieWASsY1flsxwzKH9OlZ027SlOuSKlvcc07q7OKw9VzggMJzLUxDu1UiwnBkfvwTpJi72VvAoL+2RzgXSScwPkzuPbNQNwemr118cGhwy2N1mEYeQxlO2m1Xao4yq8I8U4NyWgrf16oeM0ZkJjT3zD4hWvKyTPx2zUIbUbLZZUnSGiKTTFpispPKqqZHXWKE04w/wJDRjayFYh6iGjLRGYzOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XgEAEcpZV7HPog/ER+MmoCPvyM4sJ8w732ybNx6EXE=;
 b=DrjWdJdnsz8EL/ClBO8yg34Wrp/ZoKb4LHp+VNormT7c9Imd2M50p2nK0GLBePDhJwwq2CGpoN/gCfJglW21mzxoDENKCyvAPno9x/JLvi9LclXoI0/Xm50oae6BHZhGRFXY7Z5+PZCN2hOEMLKTQD3Nr1GUQahpvKaB549vLls=
Received: from DS7P222CA0012.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::15) by
 SA3PR12MB7858.namprd12.prod.outlook.com (2603:10b6:806:306::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 16:48:27 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:8:2e:cafe::1f) by DS7P222CA0012.outlook.office365.com
 (2603:10b6:8:2e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 16:48:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 16:48:26 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 11:48:23 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 11:48:23 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 11:48:22 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <dri-devel@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v3 10/11] drm/amd/display: Set COLOR_SPACE_SRGB when fixed matrix colorop is bypassed
Date: Tue, 23 Jun 2026 12:48:11 -0400
Message-ID: <20260623164812.81110-11-harry.wentland@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623164812.81110-1-harry.wentland@amd.com>
References: <20260623164812.81110-1-harry.wentland@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|SA3PR12MB7858:EE_
X-MS-Office365-Filtering-Correlation-Id: bfabb8a8-4db3-4263-2d88-08ded1473f35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|23010399003|82310400026|22082099003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	WxF5P0dmDCE1zubUIWvx2Q0uwpK+gHh7KHVWaQ+6JuGhXX6oe+BmzAeK/sOGX6ZXIHYB35MbBEhHZKZWX0i9FMuiPQdZG0Z4YktMC5vL8zCggHUS44ebK85Ce8ZSa0j2tgmmckw7Tg49uv5nGyYRKt53s6hiDUXDajpWPrfIFhNohapYAA8MyYxZJl92fE3SILFL6rtJZSRQjQSKRX0Y/chRd+H4dRwl12OSE3AiHZEOE6ssGavi4Gzia9yg1iVR6yJNF5J1EPYZ5HCc8z8CtSVaAocl2+oCCALnUUco5wATExNJ5wGf4y/oGQ9ARcW5yH7Z2Qbik8hS4nmsWtDxxIfA8943rAg1RDmVDxOaLh0JOD9sHRo0IxGcnUeGsL+iD331e/JV/DcDkfj/3DYuqeFqgE81ERYqrqgExF13Q3IfCXpwzBKARHK1zNg3hONtfRuSYVT9quJ9MXITf9P3+VdeximW4xsUx21zfqmuSrNxHaeeJOqsNuCEaCySnoVM4oi5EW5KyLDc30Ogq0GNj9rK46oSME48/Tz4EHtsgcVd0cD/R1f3HmD2UTRbfNen8KluC6ehsWC4RwsrvbbmdvCW3KQHTyWDdXEol8hFZo9LSSbp3bcYrCBZhafZ1RleCB3MSOjCwNbPcU9ZfnwUTX7woq+sZSu6MANSAOfdWgDUpGPETTzXny3WPXRCaAsae5pW5GlxVmhb8y3I0zfwuQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(23010399003)(82310400026)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3SSamgjgKOC7DDlqCir1NYcGznIu90KDEHgDShLGoZtF/mLsrGjVcnnKXqHYT5hIwNXpDZfAnicNLeVRwe0cLyCYX+svMlD1v4nUgXttelvpFB7shh4bEwvVMy5wiHzbpKnpRLbaJHe8hpf9T2BBUXz4xsE+dTqFukjjG0DKMsHYl7RalA2K+CsWQKzD0cVaTSEoYND8XJygC3rwjLazJdE1d2+iGHU8pDG2So5YLUizUuxftlQJ5HSTFW4J3mMd3NcWJcvIWI6hjxZret22WJmrPiZCIwicH43LEGZgPZD0yIaJ+EkfUaXz5LO+Ku/WU7BMfRdDK6r+77wJjhSwaDAZQK4K+a36vR3MLcAsUzUzf7CYGtosMv8WuxJ7N4asu7VooZzIc0yr/r8I/U+Lhtrd/IYyj/CBNoTxbyAzJ91pDI6O9dZB0co9Dh3a7Dh1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 16:48:26.6018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfabb8a8-4db3-4263-2d88-08ded1473f35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7858

When the fixed matrix colorop is bypassed, the color_space was set to
COLOR_SPACE_UNKNOWN (0). In DC's DPP setup (dpp1_cnv_setup), the logic
'input_color_space ? input_color_space : color_space' treats 0 as
'not provided', causing it to fall back to the format-based default of
COLOR_SPACE_YCBCR709 for YUV framebuffers. This results in an implicit
YUV-to-RGB conversion via ICSC even when a color pipeline is active and
the fixed matrix is bypassed.

Fix this by setting COLOR_SPACE_SRGB (1) instead. This is non-zero, so
it overrides the format default. The SRGB entry in dpp_input_csc_matrix
is an identity matrix, so ICSC performs no actual conversion, which is
the correct behavior when the fixed matrix colorop is bypassed.

Cc: stable@vger.kernel.org
Fixes: 93d922f4833b ("drm/amd/display: Implement fixed matrix colorop color space mapping")
Assisted-by: Copilot:claude-opus-4.6
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
index 561ee9a2e749..984bbfcf23f0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
@@ -1534,7 +1534,7 @@ __set_dm_plane_colorop_fixed_matrix(struct drm_plane_state *plane_state,
 		return -EINVAL;
 
 	if (colorop_state->bypass) {
-		dc_plane_state->color_space = COLOR_SPACE_UNKNOWN;
+		dc_plane_state->color_space = COLOR_SPACE_SRGB;
 		return 0;
 	}
 
-- 
2.54.0

