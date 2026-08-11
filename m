Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011042.outbound.protection.outlook.com [40.107.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB3343B3EF
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 17:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786468042; cv=fail; b=qvKcUoDhgJY9XxHOJ6pCk9oO9+i/Yl4s0KRwXKc/hnp9gsACZ000dZ1DU6EMndk0773bCQJFKuiNymV9XObTGJBdJvFrm27A4TedtbpsyjvHDFN7H5MsNji3sHTZmuZApFXIA5PXzTD1llTI5I1UQKJZGvX0MQlbU7lsb4yVjRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786468042; c=relaxed/simple;
	bh=v5JnvZ4F7HEhZtSnoeQw1es/iDbyS8Hngs4KrR0IuWw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ekCqBvdEi+N0LC35i3GNVAnULFhKXwRCHA6t4cfYV6zzno40QGizX693q8XJ1+KrIpbMlClBgRU3GRG3ObPKgopx0Pl8G0mjnbWMpcIIuYAuVryp2C2dUe1QQT5XVH25joZRBQq7ikksv+jMVUEdTsVXh2QMdo94JSIMG7XX+8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1hL9PpTm; arc=fail smtp.client-ip=40.107.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1hL9PpTm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DROT4F6qtYszBQD776jlG7uGGbIQsadXuiLKSVkB9b+Ul8hRTYVN03sw0WccZEGjeCY0cxIcLe7RNV9Q+3goGmCqtdBcqj3q7gmuKZcmFPVE8gvV491MMVDr6MXtaidndsq8xAC5TcB20+xZQDeFiTmhPlHrs4MisiP9+qIOT9RtCsuAdte7UrBvGK0Wk/yXprIRTIuDhHbt5UrLO8UxzRY5t/D8h3ybxFCL+uxlUgDo4uQSYkMOF9UKbHhr8wcGGWIUD3Kb/pkFxTJgH3u9d0EgOKR9ulHbSlR/WKQ9dyEZqcuFtBUB5I1j/27uksTWlSjvuSTUdixeUzLdOJJILg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJU2nIMSPDG11hS4m6MHLkw/lMH7ENo6Ltp3/6LaaVE=;
 b=oAbsSUhbH/eeewhlA2Y4d7vYZwqLCcwz5NaXLtt/jYAiTYI9/urWMV9qeurVq1HLvCT3oI2Rmz9bRkKj3kXGwKXZVKN8Ndr/lhQIutvoG78qWiApOXjL2LAuT9/aYBn9UxDFkkbivk1NSRyvTOp3pF1/N63QH58kJoA17ciD346H5V376xkS5JJyNlZ1r0pFh6j7ZWkqAMxAxI5vdWD69wWv8olmZcFo/99f2LuQRT0gbFzrbkkdWT1vEa4KbVSp3l+/TD7zQi3ULlu+uZ7+Vs7qEeolmIGp+NNpjKc+rczaWIG5z7UgLDgmvBVMW24nXb9SUPiWecPxrPTiX9hSXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJU2nIMSPDG11hS4m6MHLkw/lMH7ENo6Ltp3/6LaaVE=;
 b=1hL9PpTmHyGYUlCF7/QLC6Zm6NVktM5S/WxQp/h4avCU0FKVn1KzKixtAPOCs6/UpyPGNJTRo48Qh4Gxg7TyxdZ0JG4mT+kOzKh0S9HeIGKcKIIKLlA/06GdIzT0G03R82zgXJpH5n0d9RE0S2yXIMF1pAg/w+5KiFRNssUSjuQ=
Received: from CH0PR03CA0019.namprd03.prod.outlook.com (2603:10b6:610:b0::24)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 17:07:14 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::b) by CH0PR03CA0019.outlook.office365.com
 (2603:10b6:610:b0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Tue,
 11 Aug 2026 17:07:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 17:07:14 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 12:07:13 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: <leo.liu@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v3] drm/amdgpu/vcn: fix integer overflow in dec_msg buffer count check
Date: Tue, 11 Aug 2026 13:06:53 -0400
Message-ID: <20260811170653.2092673-1-David.Wu3@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|SA0PR12MB4415:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad8eed3-4bfa-4f95-e902-08def7cafd94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	3ZGPVJbFamqrjyMHDVD9FyBZTaFrTYXrZ/kl/EvzpSN1rMdA0O3OVraxhsSvRkyId1Fip7grT60Kc1QBCy6KgHB6oIh8iXa69j+h/psPFwHReHy40Z2hxHu/M0H6CXkSuBm5FhI1bhlQ43r/s8ICxTwbos5+GkkxJkU9qdHZjspL9EGO6DXsks0QX9prUXddqMcivkK2BUmjxcMR7F7FVLYLzfp/viLjqi+LDt7BEtn17UbvopzvydbykiTugIPxXVTzHa8bOTTxtqYHPeTQcdVB9Q7effReWaSHwtZii6HUc7nqJICXZb1C+00GQ087oFZklhsflQad1CCnu0nm20lNVtAZuVWCJZwDo6VmMwEXTCUmHT6WcW30/cypsS5Th1YFIXQTmLSkfy52wmUaOYfaJhgP0Hx5Zd5kvEsM7wDLDGhdmOIfYMtNqauOPv++Z6J3CyamQa5KEum/IeI/vOr+Q7x7iibgm2P51uYv4959e12dRbNJcMsXxUTQAcLoCaIZbIC7npwQjJ1B0qpG6bw+n0Pau7cTYBZGxblo+svIWB0A6uIwfLTp0xhdTIJU3E95CIYkHtj8iyPG6V3efOiNFGdU+Hvswgw99CQdsB2ybMHUbi7Pa7ri/VS9qPVFbKhYRZ3Pv4d5JMQd3aQAASRc0SfK7WVDLw3M3p4FEU3RMww1vHW9exKkxBEi0NJj
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lfX2Y6cXjbzb17OHTRFPisw7m5EU0RpouIXrXFEDgqw2nOk0tct5It5xAeuQQ1vTZroVIZEZ/lrfWCWFcz7VKsZHXaKS2Ks245dokBK5nmS+9D+R64lrnS+15Q1T0JQpnJbx7cWoydzdM3OhZ7IxAb7UPuYqySgLa8VB77DaO2Vf/kQOPSwBHXUlsQ/cbePW9G30Ck8btQrMojHrehfkt/Ugwh1Js9zw2w/EfmYEqIq2PEYwAJ1zehaTr8GdatqhdwfFhviH0t2NEyeOjsgExvuuPcZecV6bCOrhvjDr1d2ei0wJv3Mb6nxFYyp9ENC3hiewnSPtunYftfSgiTr5gmOTyUBXNOuWUP8CxQhIK0Ou0z55wJM38gPLzuVmFhqEaj69cIEwm2ejcKTGZKKDjIYgVhl9pbOLNKFhWxCz+jVaF4BRRMWboVQ2oqNciETp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 17:07:14.2481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad8eed3-4bfa-4f95-e902-08def7cafd94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415

if supplied msg[2] in the header is too large, 4 times
of this unsigned 32 bit value will overflow and the test could pass.

v3: Using two-helper form is heavier than needed.
    Since len_dw is a plain u32, a division-based test is
    overflow-free by construction.

Fixes: b193019860d6 ("drm/amdgpu/vcn3: Prevent OOB reads when parsing dec msg")
Fixes: 0a78f2bac142 ("drm/amdgpu/vcn4: Prevent OOB reads when parsing dec msg")

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 81bba3ec2a93..686f5f758cb1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1964,8 +1964,12 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	len_dw = msg[1] / 4;
 	num_buffers = msg[2];
 
-	/* Verify that all indices fit within the claimed length. Each index is 4 DWORDs */
-	if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
+	/* Verify that all indices fit within the claimed length.
+	 * There are 6 dwords in the header before the first buffer.
+	 * Each buffer has 4 dwords. Extra dwords will be ignored
+	 * at the end of the last buffer.
+	 */
+	if (len_dw < 6 || num_buffers > (len_dw - 6) / 4) {
 		DRM_ERROR("VCN message has too many buffers!\n");
 		r = -EINVAL;
 		goto out;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 0cce78b205a8..6f0a51c436db 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1880,8 +1880,12 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 	len_dw = msg[1] / 4;
 	num_buffers = msg[2];
 
-	/* Verify that all indices fit within the claimed length. Each index is 4 DWORDs */
-	if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
+	/* Verify that all indices fit within the claimed length.
+	 * There are 6 dwords in the header before the first buffer.
+	 * Each buffer has 4 dwords. Extra dwords will be ignored
+	 * at the end of the last buffer.
+	 */
+	if (len_dw < 6 || num_buffers > (len_dw - 6) / 4) {
 		DRM_ERROR("VCN message has too many buffers!\n");
 		r = -EINVAL;
 		goto out;
-- 
2.43.0

