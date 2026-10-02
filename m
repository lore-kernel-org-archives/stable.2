Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011071.outbound.protection.outlook.com [40.93.194.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F1337A498;
	Fri,  2 Oct 2026 11:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790940811; cv=fail; b=XKND2ZH2kVcUoj97laxVIVtM+oQp/l/2Gs2b+gIgttk6+Z8MMR2xBBykiK7GFvcvSmYBSDJno237KjiIu2VhSMyjvJnGga9nCzNAh/v7RhRsgdBI64k3jszNKKG61MlwVuwbltmFMZZ5/wNXU28BjrOwgRlqdUCgYPNK7WrVb3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790940811; c=relaxed/simple;
	bh=CWWM/slTh2qrUiXCUSQLnbOBEEsxSWMx2KZkwJnWakk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qh0LqjpuVedC5LFgQh3YCISD+YadtJXGoGpdRv9Po2zKaa/heVdHZiYjC9/T+ya/73Ng6pPd66Uezi2fJNtIVUou/OU5LoeoKpJjBIv7dt3U4Njj/xgQlouieLrwBZMMITsoxmYrnSMYUfDtvFblSJAEWkwYGVZ2tyPfi66Be6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JhIK79lQ; arc=fail smtp.client-ip=40.93.194.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JhIK79lQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AaOtl9ykvur9LQ2YTog/m+e0MPAE9sLmgskRdmgv3OG6E3Rsp9GHKwle4wMZ2YVPbcvCwVxteScSSZ8X7FsE8xR++/URaAbXjjFpHtG74No1P9RYLD6DsHzKI3Vs7h9P1LFDFtHhpc6xnmIMaFJ4ssN4Mt5bF+epgz9mdIG9gcEDB8sjX4FFTUnfn0HSxR40nsp8Da+Zz65XjfNDy++hvEJsT8QJeh8cSko17sQJ4slJXq1ViSXs4NuCK4FUfiz/FbX46rmBaClz5LyCPII1H7lJG8frd65rcb0iH2LLTygg5AVrauUWJcPXE+gKUbOLBQH5U2tKPMcsqxQspeU9XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmRdJru6A5jPqmN2THG4uDL2xxTAeZNsOPag9ass4Zs=;
 b=E1qphrmzStverQjdeowJUDJJYXMwJOYwOOS7jEfMpcXRXhbp2QZR8+pT4PCe2c5+sNEk3AUK4I+By/xVxWxGGHcyt0a/z/+aUL4Re832brldU0HEFBJjevXSGBery9vW9Xy3EUWNFXT1vmAxG9BCOGbI5sv8gjlou3lJy+8XTGnLedHxaRjag/Nkx1osMg1n40u6mqHLdquHToMWoxdNp9e4ycJxXikSNJcLz2O0zTXlhqRPQmZLVGfvZTb/IHIUuQPtj4CG/1Kyzl8/HnD/XF9iLVUPfg+YKmodTzl2E/crrI/A/3owCXNptxf3UTcPkUXi6l7r/ib1BphiI7vUCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmRdJru6A5jPqmN2THG4uDL2xxTAeZNsOPag9ass4Zs=;
 b=JhIK79lQa9LyIKEwC+Ro24o7p8tzqK4ArJLbN5qGIa4NHGqQ3SkyYgDIWKO6WyjlPv+ttd0/ZOcc9kf7Md5atTqmVK5FiacSHa1BjIL6bGrAgmkVxHATU0mptEE8szcZNbXoLevzh5EAtbLqT77nnjRLK4KIpbEaI/j8hJxUifk=
Received: from CH0PR03CA0346.namprd03.prod.outlook.com (2603:10b6:610:11a::32)
 by DM4PR12MB6040.namprd12.prod.outlook.com (2603:10b6:8:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 11:33:25 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::75) by CH0PR03CA0346.outlook.office365.com
 (2603:10b6:610:11a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 11:33:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 11:33:25 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 06:33:20 -0500
From: Vishal Badole <Vishal.Badole@amd.com>
To: <bp@alien8.de>, <yazen.ghannam@amd.com>, <tony.luck@intel.com>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Vishal Badole <Vishal.Badole@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v3 1/2] EDAC/amd64: Mask UMC chip select to the four implemented selects
Date: Fri, 2 Oct 2026 17:02:03 +0530
Message-ID: <20261002113204.3358815-2-Vishal.Badole@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261002113204.3358815-1-Vishal.Badole@amd.com>
References: <20261002113204.3358815-1-Vishal.Badole@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|DM4PR12MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: c9be1b84-8e54-4608-20eb-08df2078f928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	c3mUoZNw/wy0/S1BqARnSDf/Zjv7gMQ/lGW6VIitpbVYDU+Gl0DloTaXIglA8f+RGmHBnYcN3V54srR2pc8xTCTh3qsHOkA4J3A9E4cnLWr++KenmVsPZlsWVIgOcUXe4LEBvaINDqY+o8DYedVG63YQcIuAIraG/HMKM6vcBxdUA60vQSU/35cc4GLHPtaoLwarQ5fo8fesLyb15gDIzRZXv9mxDOkm0AJXo61kPTShPDDzuugPBbf7k88ztcBBkN9BkjkSmreh40Z7VYIRppNzsOHYq5vjUxcya0l3saT+e5W0F4NFL40sxZPKAEn8dobrEityisTHS9w2lfUJJ1OBJ3e6wpRAez0EaqYIWdCMiVrokOwKMhTJfLeB2xHRx/FqFcwU2bfV5PW+SW49S14mW3D8dVIivVDaALixGR5p4WtcC+UDPm9QmNw8gn8WrQJG67s8Rt6TG4WFauX+RTfnbnVw/Su4YVZBlxREXwxrwqE/RcA4NkRu/7Za7R416Zlex68Ufzr2Y7bQe7Z0Tz7lS29TtBANzOqh0zpni+tKDKmHugs/TsDrc54FrAi5KJ+VsRrUvk/zjJfqvBKR87ioNrZpjnm6AbyFW2nMbyH7ykIT7ACPeIQp9Gfg158lvuW5zTjJqISnoJb1qsD6EISQnfJUhUMzlVqInt9DDutCusy759TfC6Bo44umDDtJawzsncpvMj/1eFf5fwBY5A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	okHSf2K23hiLejc4uVjONYwQK1cCYoPcAntx6JK7Hpzlx8bUjsJSATz0ZZzPcAWMW7VAbEZMT9MBpVSzpxYjFFeXAuvZPQ/7w3mtVg64bLcC+koLijlE9GSgbsNu6ITGu0NgcRCDRVTPkXbP7rePWI6A23cH/NixGGrodco0GXz828kwfu6PY317wLmnZslq9/eJl8/cUYK50y8EfxdiNq9IoF691caKyU1Z8c3PRXTIIr+Rn0Lw7niY5tMWKcCPMBRIvHZcKKaKmvCYlRhAwWsmCsjkbwwt347QKslEHY/4TdAX9bhttbXG0hsnWFzxU9lmaBI2CAfQfnlrH6myU4w2PRuKUrA8NZezrXvPZ/6HhduiGb0SPL49w1chOTQK7jzGML6BJYbE2fx/re/nScIovuB7g/1ezSwnzgwe57Axw9rryDv/1EZsP8o50gKm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 11:33:25.7661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9be1b84-8e54-4608-20eb-08df2078f928
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6040

For DRAM ECC errors, the chip select value can be found in the
MCA_SYND[ErrorInformation] field.

ErrorInformation[2:0] was first documented in Zen1. The 3 bit field
implied that up to 8 chip selects may be used.

However, all Zen-based systems have only ever had up to 4 chip selects.
So only bits [1:0] would contain a valid chip select value.

Future systems are redefining the field to ErrorInformation[1:0]. This
matches the existing 'up to 4 chip selects' implementations. And it
frees up the extra bit for other decoding.

Change the current chip select mask from 0x7 to 0x3 to prepare for the
decode change.

Fixes: 713ad54675fd ("EDAC, amd64: Define and register UMC error decode function")
Cc: <stable@vger.kernel.org>
Suggested-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 475235c402e8..0c0d11c72925 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2796,13 +2796,13 @@ static inline void decode_bus_error(int node_id, struct mce *m)
  * the instance_id. For example, instance_id=0xYXXXXX where Y is the channel
  * number.
  *
- * For DRAM ECC errors, the Chip Select number is given in bits [2:0] of
+ * For DRAM ECC errors, the Chip Select number is given in bits [1:0] of
  * the MCA_SYND[ErrorInformation] field.
  */
 static void umc_get_err_info(struct mce *m, struct err_info *err)
 {
 	err->channel = (m->ipid & GENMASK(31, 0)) >> 20;
-	err->csrow = m->synd & 0x7;
+	err->csrow = m->synd & 0x3;
 }
 
 static void decode_umc_error(int node_id, struct mce *m)
-- 
2.34.1

