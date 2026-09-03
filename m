Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013002.outbound.protection.outlook.com [40.107.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB6A382F28
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 18:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788460387; cv=fail; b=poPDTEIz/8eQj02J9NGECiuuXSArQ1L/LNMFhgPHAXMVA16BWg1oqqd2OFIbP6yOSgLHUTOYVXeUINKTqDqPb01T1q18j1M7E6VNzQ1mRV3lYq5E53BDdPtuGMQYa9cg2ZpbnD3v7at/jgR6vqqmfCy4wVDKDcdT/jfh6g8aUVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788460387; c=relaxed/simple;
	bh=q7YA5EpBN67n+LtoOnu0jnpXnZMhpD+MXjvRu2Jp9W0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YB+ZQ8gkRSaBB1ibhb1/ID5uDmlaqiN+06DaDtwofB3BZdgEcxbT1BE1stL91r9BJ9gAAhREeSo/v5XjqP2QYzw+KB1EqI5H7rKh5klysuM7FyKwrw8YDhO+D0OKDzwbPkN9sTYw2uGEDXeC/LEZXCHsi7E+RuVwt5SYXjIZHos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3LfOdUwZ; arc=fail smtp.client-ip=40.107.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3LfOdUwZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6kQTIzjzqzLbgAiCQujOoMThj7nHf6NUBjk8kmN14QeHW71lXOGza4V9T9F5Hvv4GUugFXTR3vIV0cqB2oNknXnoT4jcqCO6Wa+peTdc/vBJxgi3glLBMpuyA01a8GRqJTbbPBpJzFdDN42W+f9mE/o+qwprx6h9TrFHIxpKexh5HZrq7tlfXdOYxfLas35vkC+gYnfRIBSvaAuR+TUfv2BHJ62zt9gzCl5WkVHUISGPNFDe6UiJAf19OB5ozFLQgG3a3KASFo06kotnuJpWwqmtSpCCqtV91gespI0exHtDbZruum5pX5BwWaTe1LTnIehsJyN6TATM6eX7xX/Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzuCLwqBgMs54r+QCo3YDM3e+7KGTwttc5UKLAccN9g=;
 b=iDRAY7etvdQ3DE9j2ZTcTepntG++QEmWm+KEfhN/1M69dQw6swFIjcDZMs8p+9jJb8q5r/q1z8IvMdXlhPB8AMtQhj/IhO5cdSg2zYjrt7zY9f/Rz5t+OhKNC+f11mhyF6hWKaWdp5zPvmwu9A2i55ZzIwBiyZr/t+Cc07CpXkSRbALfkQinh6C4qJNbHUwWKBfjURgsDw77VwAZHek87JWvDbmIhB1qTO5hZzFYobnvmejjYVkZdc9rYKxyYFJFmrGosN7HcehrK10yrWgF6AKHqzlLiebsSOhPqDdEfogRqw7+RE4S7nTRXZBD8FNPUhy+S9sGyXs95T/1cBTLVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kzuCLwqBgMs54r+QCo3YDM3e+7KGTwttc5UKLAccN9g=;
 b=3LfOdUwZWhWM5R5qH/H7QwIivTshtC+TUuEvHPcHw/71iE9Xq3AOVcSFsR0nYnovAfdpwrG2qnb7mp+q1FRRaLVc7zJG01yB7m54OXegiUNV3yEO1C9M/gn+kV6aqUoHNKTdj+Q3Xi4RQO71MdHOAmkR5DZAEC/JSwIf9qNzlVQ=
Received: from BY3PR05CA0041.namprd05.prod.outlook.com (2603:10b6:a03:39b::16)
 by SA5PPF916D632A9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 18:32:47 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::50) by BY3PR05CA0041.outlook.office365.com
 (2603:10b6:a03:39b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.4 via Frontend Transport; Thu, 3
 Sep 2026 18:32:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 18:32:46 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 3 Sep
 2026 13:32:44 -0500
Received: from hwentlanryzen (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Thu, 3 Sep 2026 13:32:44 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH] dm/amdgpu: fix malformed link_settings debugfs output
Date: Thu, 3 Sep 2026 14:32:34 -0400
Message-ID: <20260903183234.426984-1-harry.wentland@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|SA5PPF916D632A9:EE_
X-MS-Office365-Filtering-Correlation-Id: aa312611-cbf4-4753-caea-08df09e9c040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|10067099003|6133799003|3023799007|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	q/+3tLt5J8hc1Ecy7U9fUuDldMQZjaIxrzp7aLkccVu76OhDgnWcS8lRXLu0eD5q77Wjx4X7a33WugqyYAsv/cc9SemDjovBzA53QJhqJjcep29OJcAtM9+1sqecd21oVctahVM2MugwPBZpz+cwy8g5KXIsb77EScvxGcuyPIth2rrPVSl10zTGO0T1W/efTNKW8REAnqyiosz4zMM1zMescFT1NtXoClBFQJ6N1tl2YKtYT+sBhWbe7MlhAfJoZUFt/gasuULipqrvGwjUowNTkt20LL9Pnzxtt9LKU5VUCyJpdqCT+SP1nsDsJOuWoSDSmkAQ5wTmEcotdZ6IfRgG2ROBeptAQGlv/DtxZG5oeyxcY27xQEIRXAgaKtTuY33HvGYSTUuEAenly0bI9lPTHzheSj3OdNz+flcOBs+1MnMrSRqggMo5sxrkBSJljyKT5LIAcin1mI+ml58Qy73FJgvwvrw1E2wgNaPS196e1OsTNK04nfPE2QuIt5ZpOfhVsJ0+Mw0G2jHfeooeaHT6UbQXLlx+XRvz3f9vfHD/xCr7Ty2CoNHo7hVVAHGzT1JoYycyH6dwqG0BgZsXElhxEfz4fIvBTarHCnu6mtOFVuMY163W2Tbml8qbFpzc9Fe9+SW89+5pu1/idygw0EPWOyxItinpkf0R4Uw2DAbJsr/56GSelzH/qQOmjuz6945YIOzBzoddQzJhem/+2Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(10067099003)(6133799003)(3023799007)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	e4caGeOmYaiElJYwxi46okv05kMKbSDTYbOOncZmg87ojl33Mv2vgvADWXufUQ9biZI/WW+sojwxh4xKcN/lxXD41hHtEK0MXl+SHN4Z9MTv8xEtN957s7rAjwSiGep6+7GSJL304WP819TDhcvq4c1uX96hLQdQW1XXy+zO5bGIaPJ+C93LTsgmMZEJWf76nmI4narBzSoMkhe3dL2xVNLXjJI+v8On02C3ocA/YzLytGo+L9qMTTeyLVj9sjB41jy04dVs9WvfK07+1+4e1yT/e7aT3lFYl06gwqIM8U7VJsu+ffmr9q9vDX2R02rEce+Eped2ponxnnTGAA9/he58RZ9Y1rjBJRyU1VVXTNSIgJ4h5mLxvgsDRTxGjFlZyaalg0bDyI+b8jHL0Xaptdj8C8mTlz0i+elUvr5JqMpAR1oRQAAw3+2Ms0hzG5M0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 18:32:46.6116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa312611-cbf4-4753-caea-08df09e9c040
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF916D632A9

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
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 20 ++++++++-----------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index e4c92b1fa22e..36f32ed4b87c 100644
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
2.55.0

