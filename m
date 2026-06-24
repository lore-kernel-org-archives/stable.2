Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011028.outbound.protection.outlook.com [40.93.194.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6993DD86C
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 18:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782324565; cv=fail; b=k7qJmqFKeVSTSGgSmJOyesYmnuuRTBOa92xunyVDx6IPJzqR5+F/YgcmFL7X4YJgn0BAs30tuTQphoRxdz2YO/8P5jUaL1NF+O9xSrujtiZZG6zOuRbPpR7gr7NSg22NB//Zo2mCrAm1JyMe9gYKliHi7KkJP3nbpYP7NIueMM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782324565; c=relaxed/simple;
	bh=hiIozE0x4/uwODqfJJ+Wd3uPhuyvrSjHgp9jRV2XUss=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T+/8oHvyGTesAY6hDEeLc+4tRMXl26jQjlh77qU5GeAU2Y/YDkuPn6GnU/YudGcXadW+cviYKJAOzuLZy0h81HR6amZsztB/MiLFoljD5+ZFy85MzaExN7o7n4T5ccX5ELg8hXuZHNBH6HcXIH+bdWy4LvTMr27GnYO+s606JCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UamCy9Kg; arc=fail smtp.client-ip=40.93.194.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UamCy9Kg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xT1wXViXW1pxwF+Yq7xqRwilmrx8Qv66fq4509SBtJ9m+YpRmcLW+/PlZjSBS1GuN2M85rJkuv3AOBqsf9Ok10qJo2e3rxjM7hO6TgRf+kvDr3UARcoxxGMvkN45iw+JROXp9Y15f40Hh6+PDUxyl9mMe3etQ6k+QwQcWbtn7fJbdevgh88iRrk9/1GokCp+9rV2bbAkpDB9smFaESjm4axZ0rerJHomi974OGVhKR9O4sEzeEM4CV9F/6ZU9ot9uM/eRFn3+XuIHONQZ2+U1YPNYwA3nTRgegqZ3fWMRDBzaid1vXyHN/a/mcftUBYogE94SeXncZJB9OyT+DL4zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ymjtYebezcBgulBBLqCY26C6GPF2a6yHbEmIiPQnxY=;
 b=c2aQWRMozAMMMZyDFFF74oVcLOLUkNiHC2tgiyH+rpWpmWMm3bwdLVE6VFLQqxgwHeOlqTeTqKMMqWCC7N1SL111EiIIF8cRNvEvT3iQQReoJ81XZzcdeWGy+eJt2gcTXYNVt2P7RFFzkjBd3r87x+l3do7CtajQ7G2OxoPIhf258eN1E4c2tSCjMJimLfDhVIcHmHw4Jvw5ITKmBn4U8X9vQL7Bfnb9oE7EcFk0AlwUMVth27vj0haUqRWrM+ogslqqlLTqXuycHkdzULltDMW2gvlUyPCthbQe8R9vbfdnvBiQAiBciNBiUBNTFC3iBkTue4uaLByeXLMKHtf96w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ymjtYebezcBgulBBLqCY26C6GPF2a6yHbEmIiPQnxY=;
 b=UamCy9KgPUIS5KmrtkVg/YhgzZlgMPxKRpMiHY4BHxoJ+SJ98+Pl5VG2bqqHVvSOnYm5Raigqa6hQaYH/cWI3ljimoilUv0Xb7GZUKbrB4Bz9WXflpJJKYZAOD8zGuF9uXR4ef8aeZrW8nF4GDrrX3k87KHgqfV4l7CN86YZQFw=
Received: from SJ0PR03CA0011.namprd03.prod.outlook.com (2603:10b6:a03:33a::16)
 by CH2PR12MB4072.namprd12.prod.outlook.com (2603:10b6:610:7e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Wed, 24 Jun
 2026 18:09:21 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::5f) by SJ0PR03CA0011.outlook.office365.com
 (2603:10b6:a03:33a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Wed,
 24 Jun 2026 18:09:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 18:09:20 +0000
Received: from MKMGEORZHAN02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 13:09:18 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
	Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
	<Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
	<alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
	<Chen-Yu.Chen@amd.com>, <stable@vger.kernel.org>, George Zhang
	<george.zhang@amd.com>
Subject: [PATCH 11/28] drm/amd/display: fix malformed link_settings debugfs output
Date: Wed, 24 Jun 2026 14:03:09 -0400
Message-ID: <20260624180829.4775-12-george.zhang@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624180829.4775-1-george.zhang@amd.com>
References: <20260624180829.4775-1-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|CH2PR12MB4072:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b83ced3-ca3c-42dd-8a0e-08ded21bb704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|6133799003|18002099003|22082099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	o5vsfTgZ06INaW9nKTBmqSgF2uHmKGOec8qyiuShU+svocHSjC4gjEEkAgcXHiBFySOZTZBY6Enqb1oxKAh+3P6QVQYYdYxZgB9M9CscVaAezgqLS/q+JIeI67sxKv11YNlgjlwjUCPQvCOaU/X0Iu7YtpyeZCXZ2opZQg+/5tuY/zoc18WmXx5N3hqOmx9Qp3GEYUIJbv2CUjZNng7jW8Oz1y306TvavhVXSKl5nBC2P/Fy5OfakHXsprbKx8pQ7dXN/y3SNJzkQL51mhuR0e1KTg+9O4RPd9MNFQWjXPH0hDNt9rOACgbHjb8ncDQvbZqEZXFWZtg5hkKlSyamPqVIqUV+efREu3dgYi85luZvzIAutIUMuaWIafRux5C+UWooZ9qEUMEvEKytwOs1CaAP7EG4kBqNrk9my31HtGLQKJjRr6jeazTkKaxS7cZKQGM2XdXANx0+Hv90Ks1J1RPyYmxueHpdz4XL5LUcpi+CH+7bv+uaSE3Q7meFXttAohKRJs2ajIShvjYbZHDbf7q36KOfowsorD+ba/1M38InFddKTf3zNOtZQeuyGIWIuvdJmO8Zmuap05ZyYce1TxLj9OUQDFmw8lb9RO2M2tE2i9Ic0FfA4Kr+cpBvLNvR7YpU6KcXTfNJf9xrzmumLZMoPg2Les8zVsgycNxiPbdDC684QT/b3F6bbWq9ELicBkIx7K0UFF3U+5obyMERkQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ox96lpdRdCOUZj8Ce6QxEA4q6KcemjJRs49gIUS5UTUyZdRs5M9RLaNc88JysjjCBFvqXw59HHEbMOZ2BhvBwcHKbSYyQXM0p/gzqi5qn41UyjWupbg6VyeXY3wYmn/tcEdRKesoP0kFVlK3QSCiiLqNi20D6W57hW0qnLlysYEnQXH7H0IEOuaI8wBOAqkGL1eal3xEaI43bspKYXLhuEfeTWFWZFQ1hT25bEfQWzwz5mUkNQ9PYLV0QpzwocGZaL2783HyRgBtq/vB1iWHRlYDe1fMTWcnOh4quk1AcEW2C70xbkp7rPUqFTDqSFiGVMYcWSqXcvknf/pzXezxO+QaMGq0QxZKCVAuy+l4t/WeVjFTNhhaa2lx7uJJMeT7K5z0Qmsi80GdSHz2qZVqQT8J87vv5ywRfFTqUwDCazso9ozK57rThI+frEQC5vVT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 18:09:20.8317
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b83ced3-ca3c-42dd-8a0e-08ded21bb704
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4072

From: Harry Wentland <harry.wentland@amd.com>

[Why]
dp_link_settings_read() passed strlen() of each format string as the size
argument to snprintf() and then advanced rd_buf_ptr by that same fixed amount.
The format-string length has no relation to the formatted output length, so
snprintf() truncated each field at a NUL it wrote inside the buffer while the
pointer was advanced past it. The result is a buffer peppered with embedded NUL
bytes and fields that are silently cut short, so the data read back from the
debugfs node does not reflect the actual link settings.

[How]
Use scnprintf() with the real remaining buffer size
(rd_buf_size - (rd_buf_ptr - rd_buf)) and advance rd_buf_ptr by its return
value, which is the number of characters actually written. This both bounds
each write to the space left in rd_buf and keeps the output a single,
properly terminated string. The now-unused str_len local is removed.

Fixes: 41db5f1931ec ("drm/amd/display: set-read link rate and lane count through debugfs")
Cc: stable@vger.kernel.org
Assisted-by: Copilot:claude-opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 20 ++++++++-----------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 1f5dde2bc74c..6b07982e3aa5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -196,7 +196,6 @@ static ssize_t dp_link_settings_read(struct file *f, char __user *buf,
 	char *rd_buf_ptr = NULL;
 	const uint32_t rd_buf_size = 100;
 	uint32_t result = 0;
-	uint8_t str_len = 0;
 	int r;
 
 	if (*pos & 3 || size & 3)
@@ -208,29 +207,26 @@ static ssize_t dp_link_settings_read(struct file *f, char __user *buf,
 
 	rd_buf_ptr = rd_buf;
 
-	str_len = strlen("Current:  %d  0x%x  %d  ");
-	snprintf(rd_buf_ptr, str_len, "Current:  %d  0x%x  %d  ",
+	rd_buf_ptr += scnprintf(rd_buf_ptr, rd_buf_size - (rd_buf_ptr - rd_buf),
+			"Current:  %d  0x%x  %d  ",
 			link->cur_link_settings.lane_count,
 			link->cur_link_settings.link_rate,
 			link->cur_link_settings.link_spread);
-	rd_buf_ptr += str_len;
 
-	str_len = strlen("Verified:  %d  0x%x  %d  ");
-	snprintf(rd_buf_ptr, str_len, "Verified:  %d  0x%x  %d  ",
+	rd_buf_ptr += scnprintf(rd_buf_ptr, rd_buf_size - (rd_buf_ptr - rd_buf),
+			"Verified:  %d  0x%x  %d  ",
 			link->verified_link_cap.lane_count,
 			link->verified_link_cap.link_rate,
 			link->verified_link_cap.link_spread);
-	rd_buf_ptr += str_len;
 
-	str_len = strlen("Reported:  %d  0x%x  %d  ");
-	snprintf(rd_buf_ptr, str_len, "Reported:  %d  0x%x  %d  ",
+	rd_buf_ptr += scnprintf(rd_buf_ptr, rd_buf_size - (rd_buf_ptr - rd_buf),
+			"Reported:  %d  0x%x  %d  ",
 			link->reported_link_cap.lane_count,
 			link->reported_link_cap.link_rate,
 			link->reported_link_cap.link_spread);
-	rd_buf_ptr += str_len;
 
-	str_len = strlen("Preferred:  %d  0x%x  %d  ");
-	snprintf(rd_buf_ptr, str_len, "Preferred:  %d  0x%x  %d\n",
+	rd_buf_ptr += scnprintf(rd_buf_ptr, rd_buf_size - (rd_buf_ptr - rd_buf),
+			"Preferred:  %d  0x%x  %d\n",
 			link->preferred_link_setting.lane_count,
 			link->preferred_link_setting.link_rate,
 			link->preferred_link_setting.link_spread);
-- 
2.53.0

