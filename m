Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011008.outbound.protection.outlook.com [40.93.194.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488E746D0A4;
	Tue, 21 Jul 2026 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784658395; cv=fail; b=KJrPSbhWm1qfAA83zEnsEO/7ivKqXJqX8EQxoozOV07D/fvK6wsalXcupLiyxq173I3KmVA8Ana9mjIqNa8O+FM1JipF/tC+YxTg/LsmAUfMNTkHXNaX35crhtyJuGuCAZi9cZpJz+u3Bf3hL99BqzwOvSOgB+IXi59E9VOgM3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784658395; c=relaxed/simple;
	bh=JGZRxkXmRhTi+lz3L7DahycgtvyRoMqiL+fS6bQZC5o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aKRLZAHvDkiyemNF1IiAFPcGWeMD4QP+TpswyROl/6S/34F2gjFpUaXFcNn3W04w8144Jn6cD+ypUd91Ks9hNPs6T05U4vaqAGbeXtMWTCGS/olkOo0xe4oFIQgG13A8iuNon5zPRLIiuQSXm2yQIjLTaaoLAjpYv2rUxKDKOvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tlb7nyYe; arc=fail smtp.client-ip=40.93.194.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tlb7nyYe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sC9q1lyhgc6xSAUNZni/Kk8ssPWukgsQ+iA4fjroUPIPgCMT0bPDHVJ3H0KN7wfVMQ0n+kcRkVh+a4Xia+iIpNvPwh9p3sQverYsIKtYvCHmJGQE1LpHspKtOZadFOEdlu89yhz0trt/0XUXyd9SGlPsR+gL7fokEakF3DEdRAqC6jTk2j59HHy5fssrIPV028g+LOZz3VTFQf3ywMJgsa/ONG00XJNzIGC55PTUXjdPvKc83hzeY3SH9rhFdJcNWwXQ2Ob9LfWHaalHcdZ0uz0YsqefnwM5JVED43IQDSkOan5U+7qZARNz7IBeoMqNa6lczHIUyNZ50A5bixVfWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ED5cuYD9Sn6qvCZ6kD+K+Nl03TAnTRSJV8ztbMTkaCk=;
 b=sS+b7e1wOPbCiO9qUDeNHQjrqbYcbsGHGjyeVp6/Dm4QdItWVCJJyGY/LYXvsCRwYlskgUYbBe5tQcX995flxgQaaJ4CYKXZrgydy3pNKyOJ9wTzNv+2E4hhSNr1R1Fq/ijS+OI1neCRoZk6dStjZzJKhp6rClIVkOu20UkXIr09rzA3W2y2CXjOHBCvnLrD20+X3lXdfBiT46UMuuSwDLwMDQISx/Ckaxa1mFUKu+N2cLzpxRk7cZVMHmm7gmisHjTgIcZC2h8ge5sIbVEAz+irB/bzktkwu/hVCZft9EXMiVftePqCMQR6bD7z7ym1y18y3acY9paQC5sRlod43Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ED5cuYD9Sn6qvCZ6kD+K+Nl03TAnTRSJV8ztbMTkaCk=;
 b=tlb7nyYeG7FskCOb/iF8HWNbyptP59XlwoXZf2hq4yq/263QHjK7PIIpqN3UpgV3bpLlJ0yHvMuZ4STQtHchORVAiXODUxca/oK7kSbxw0aOASrEbppQsDU8oqqZUKOCokye3xQUEksXQ/bd5ir7sVBe2SBN/UirbZN1CS01iS3q92utdLAyHaGkS8suKe7d5Up0Z6bfLkGrVWEHJd7jCSq1x03FyfqYSs+BBr8ZE4vdJbeAN/S1qzlfXylScadweXGPsaHpfp34slgTwtcvQ7E+9wfoYa7m1hGh5O5rl6Am58u2IO1dkPkWVMIkoUwYbnzYsJvmvVjqWYl2jU2Uxg==
Received: from CH2PR18CA0031.namprd18.prod.outlook.com (2603:10b6:610:55::11)
 by MN2PR12MB4343.namprd12.prod.outlook.com (2603:10b6:208:26f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 18:26:26 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::45) by CH2PR18CA0031.outlook.office365.com
 (2603:10b6:610:55::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.18 via Frontend Transport; Tue,
 21 Jul 2026 18:26:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 18:26:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 21 Jul
 2026 11:26:06 -0700
Received: from 82875d6-lcedt.nvidia.com (10.126.231.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 21 Jul 2026 11:26:04 -0700
From: Nirmoy Das <nirmoyd@nvidia.com>
To: <linux-acpi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Nirmoy Das <nirmoyd@nvidia.com>,
	<stable@vger.kernel.org>, Kees Cook <kees@kernel.org>, Tony Luck
	<tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>, Borislav Petkov <bp@alien8.de>, Hanjun Guo
	<guohanjun@huawei.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue
	<xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Jeshua Smith
	<jeshuas@nvidia.com>
Subject: [PATCH] ACPI: APEI: Fix ERST timeout unit conversion
Date: Tue, 21 Jul 2026 11:25:51 -0700
Message-ID: <20260721182551.2434933-1-nirmoyd@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|MN2PR12MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: 00d43816-63f2-4b4a-60ad-08dee755939d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|82310400026|36860700016|1800799024|6133799003|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	eWqblpuGI7NzmiWG1Df7j98tp4j6pTkGRjfHXf7WA/qr6U3wx4aMtev2xhQl11qr5rnXO7Z/Y+sD3k3UgfbeAZqQ7rfZv1tNECPJ41qW7Mx6/2dPLDjXZE3YxYBgOShMntcr/DZ/lBNTmL1W/xGId6hPHfjySTkK//Qyu1e0TPZtBHZxX7ef8xyO2qlpXIQV/cVWGCTSBGAMTvFbMpQ85R5N5HQdsUp0blqCCUPp1XnfdFb0sYa3Nz53t8IaoDHnUyIfGjy/FfnP2R54Fb2XB4Yj1pXP6Fr0qhQQxK4S36odK24OK+s3NNDIXMLu1IvbHkgCVA7a2rHLNH7pXztuALCotlfSd2HPtAq+pWFWzYMNG/DyVoNTntZTCWgBX7iz7bO7bZpLHUwzGGVkTCsdtsNUnpTwWjgZXI8sEtQrvSPcQumLvXm3i8HL3NsPR5jk6of2pASz+wDDzSGU2X3LNlRzYxo49pFubMeNkQH9OznawdkWDooRVGgx7Nppyn2RF8z96wQfvDEVUbTu5xo51dywurxtWWVN92cuLHx37XNfNzIIEkJknuEFels7+4Hvn2xkGltgaQM8TiT/VzVe0z6S524x4MxIvgiBEpqgwNp/sTZyqhucVc0ooMoEw7vIAhXHwRuGZAyN/DByApEjEhUh9+fpqiAOHpxdvybIpqBLyR8uo5D5gM2IfIrLAWEuDosapRJqNn/1HtX5cCqbxQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(82310400026)(36860700016)(1800799024)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	caXQjHkqFICAzV0fZQuEAhuDlY5Sttuy+tB13SS1jfLxCjB4beu/rQBVdcGdkKzDy/fgancDlAwkFV6KUyCzMiBDI+5Fou0Mm2qGyaDcGfvi2d3X7PrMdEZl2VbHx7zpi5YjOclsZhYBMnXxPMH7P4umuRYZpM0fvbbmLrT+xyEn3gBsUZfSeZz4IEAsqv4mV1NRTJX56JQQWpYECjj9e/MN1VbOOyeCm24UZ/IcB21/XpAh4lY+0izRgiuCti3W7V54wSC2uFdEZ+/RlQhjgYJ9A0XVPyUGDOZ+1Afk6EJ/pO877nYq66fcnNqcwfYYVrHqPcawyTNBqmM+G0hv4e9ea9eEfUQK8atX/dOLojmvYEQ9JvJtbsHlwpfiNZPIvv+6o4fisBtoWW2aFzPVTjSg4Uhpo+Rto7CbxrmcmaVQcVLR4mnnFyOw8Ln0tzi+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 18:26:26.6425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d43816-63f2-4b4a-60ad-08dee755939d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4343

The ACPI specification defines bits 63:32 returned by
GET_EXECUTE_OPERATION_TIMINGS as the maximum execution time in
microseconds. erst_get_timeout() instead multiplies the value by
NSEC_PER_MSEC.

Use NSEC_PER_USEC to express the firmware-provided microsecond timeout
in the nanosecond units expected by erst_timedout().

Fixes: fac475aab70b ("ACPI: APEI: Use ERST timeout for slow devices")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
---
 drivers/acpi/apei/erst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
index bf65e34615314..15ab797641cfc 100644
--- a/drivers/acpi/apei/erst.c
+++ b/drivers/acpi/apei/erst.c
@@ -108,7 +108,7 @@ static inline u64 erst_get_timeout(void)
 
 	if (erst_erange.attr & ERST_RANGE_SLOW) {
 		timeout = ((erst_erange.timings & ERST_EXEC_TIMING_MAX_MASK) >>
-			ERST_EXEC_TIMING_MAX_SHIFT) * NSEC_PER_MSEC;
+			ERST_EXEC_TIMING_MAX_SHIFT) * NSEC_PER_USEC;
 		if (timeout < FIRMWARE_TIMEOUT)
 			timeout = FIRMWARE_TIMEOUT;
 	}
-- 
2.43.0

