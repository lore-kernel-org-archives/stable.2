Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013025.outbound.protection.outlook.com [40.93.201.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B6746D541;
	Tue, 21 Jul 2026 18:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784657901; cv=fail; b=Hwm4+JtmZR4QFgs8reA/ernzJeX239GVH0YAFbGYrdpIyw6G+8oL1hJ952af1RUfjMFvbzL75b2HmMjVtmZXNGeawyU3wVssaV8i5UX1/VIj8911RxWgROrUQMBpyYtt1dBCQtBRJpovPgdodVGqdaTcFzPWIh1crccUzaMpD6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784657901; c=relaxed/simple;
	bh=fdhI+lapjR2mKosbVXJPW4fydzhqVXqbEfZgscHmPF0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fC6hQPUPDFleUW7/FGrgBH4wz28in5rnZiNJbcMq2ao30cVP/7iM7gRzylT5IR0inWLInOf9pE+023nKsRKpbtauVBvEgvn7lyqsChvI0zhlR/88TDoCRLRS75bnf6dTg+f8IF4IUqEWgZ0nCF4YI7rd+vAEDNSPgH+vDPpxzQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jNW/WoVg; arc=fail smtp.client-ip=40.93.201.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jNW/WoVg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gY6LKxHjvLXyAC9nI/ZQupPwNU9PLhi0nld2zKjjS4ryB1/G/fTDT3LNXA44EneEHbnKDTTVuJ+WyBdkFgGqTLj1mS2ZGlInFL/zaloMI43munZVLei43geli3/TDsfpXsndJAvYQtekGpm9TotWniNLGg08bp+A8sCih9NT8T2HXFv8XGnIbBGB3IcVt6/Pbeic4ta6hOxB/C01IbxsaJZLR6km2u0g7tprYZpBV5g79Ky/7+2CouKWOimba1MX4GRIlbVO/Avx4iJ3PGYgH10Dw7G8kOWFu7kshQQUusU6ZGogZkjqNnazY1tjc31mzFc1oI4xLI8/JfDihgrG2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r536CnIwqq+LVO4xQQaswQRBss1DLai2J6ZXyHPx4jE=;
 b=FrKl/o2qXbGLPQxTweE3fF+K/3gfOZmxyj9R4F7KRIlccI2haviYwUdTIhMYi84v/iTwV4KWWcpUEc6OK3xuEkspyM6KSMfhS5Ag/tckC65QECxAliGaYyuQtrUouvFDuZjzJUq70XV+iiYm2KPCWyaEcEojqVP6e7lkgKs/dqdLi/VuGxUkjgVUB90U5CbDS2mEe7pZ2vhym5a2dWJDoDvg1AKA3As96MG2yxKjZ+cyG0waW1QwFQUvROHM3fPRHkIQ+RLLFwzW40JCfSKtJv6tqGSBNLwTcswnalMTz8Vl/24r9dcKxYNwrf/c/hhmh0gSrdEYlAHkF/uA7J26Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r536CnIwqq+LVO4xQQaswQRBss1DLai2J6ZXyHPx4jE=;
 b=jNW/WoVgNahRmWU85NSk7wfIaFvP1a2nrwEQXBsTG8CSTfB62ZVgPSXNu4XdcUUm90Y5JFMcjB0kLiwPesbsQroFj2yNuelFKJZ6SRTLOLNBPJdUcR2eG6scFXkFh72MdhWkb4t40zYT2Ln6+KZePS+2cnk/RoW41Ift2eE5+mE=
Received: from SJ0PR03CA0298.namprd03.prod.outlook.com (2603:10b6:a03:39e::33)
 by SA1PR12MB8843.namprd12.prod.outlook.com (2603:10b6:806:379::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 18:18:15 +0000
Received: from MWH0EPF000C6189.namprd02.prod.outlook.com
 (2603:10b6:a03:39e:cafe::9d) by SJ0PR03CA0298.outlook.office365.com
 (2603:10b6:a03:39e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 18:18:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6189.mail.protection.outlook.com (10.167.249.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 18:18:13 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 21 Jul 2026 13:18:06 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Hans de Goede <hansg@kernel.org>, open list
	<linux-kernel@vger.kernel.org>, "open list:X86 PLATFORM DRIVERS"
	<platform-driver-x86@vger.kernel.org>, Mario Limonciello
	<mario.limonciello@amd.com>, Francis De Brabandere <francisdb@gmail.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v2 3/6] platform/x86/amd/pmc: Propagate SMU errors and validate S2D address
Date: Tue, 21 Jul 2026 13:17:53 -0500
Message-ID: <20260721181756.143084-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721181756.143084-1-mario.limonciello@amd.com>
References: <20260721181756.143084-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6189:EE_|SA1PR12MB8843:EE_
X-MS-Office365-Filtering-Correlation-Id: f9ede1fe-671b-4eb0-dd0f-08dee7546d6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|11063799006|56012099006|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lLmxbEy87Qp5SV6CGUHZN3XJapn8c8siP7ExIqd+v97Rd0KI/4G7zXrVjqZnO72bf164ClJaSCCFdYbN5/sEFuxuZhNHCRvFEMfKQFZWviwxStXqPbh7wlM1QI+KVF4Hbu0etyv+JknDaTs6A611tk9jelgJpumR7IUJieJmxQFqwSlFkjZRQ+5TEhYSTCwKQy8saVXH68IC8R2iAIbweUkrqss+wgR6CFttY4bPU7wl/oaymFjyz289HetPJNKYr+4DJDGI0aT7BUbEzJYO1QyzPp0H45X0beAhefan1xuzcTKDUtDp8N1zkzcaUB3XcEyCE4pX7NZOwNGtjOwVVQZtFEEIP7hVM3ROylXFgTmQIZW8qYz8yhpvvhty9tGMuy8PGEbEhhoT31jYGjAy0KjAR1h582U7XoGiO54OBompgxDoLaPgtdzeVI5A3SVU75iU/U0X+7l1HyuWkEAm0jG4SDOIcLgPRYBJ4ZH2u/FEdAau1qqJjvFTxUkpBTcwTB+4JTBdRpxqa1pnVi7CynArQ8PNw0EG0jO9/sIzYj4x8E4kc8kE7V98Exm88jrEN1YgQbWA3oR2cyPOnGZ5amUfKnvmxJE+fo3az+Sq/Qg4+EHX2R+y9U8kS0zaDIS6tPuQpMcomfDuAesj+IRt59UAJiZBeiH+9PrVWq1z4IXORJKU3DM2vexRaFPs/c2/x8+VaEan1i/7Mr+cb0tFlw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(11063799006)(56012099006)(10067099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PHAW1BRazrd5quV4mq2BqsrvkxgS7Pe5O7mq/1HTAANBQENRREgd4y4Ch+Tk6EHB5lq1tdm4bwTYkpZfvQlGyudiSVbysXFtbihxyLl3HAA2/knU3KENuhV4dt0C7nHwfej7kFL0ILg9uOVffGzHUDbU98LQrAv9Wh67xo25Amva3Wc5nE33DFTomuKfyluD5mSkSB4N2VE9R4ZlJxWOkpaAr27iGdbcL9vFAMEOKZEGNzYeBR3AvhyfujB1xa0zuzVODW/zh3L9rpioDU2ChhL7OX1wbodoA3npvgqfg0jmxER5EOCcGQDdHo5OrbOv0nbYi2mBdBOmIGl5MNjUjqHiI3Mg8vMLbMZsVmD/HrXgCPnMkgLjZAiOm75SCoDe/DfN40wKlm/pg9Mq5O1TzBplZw+SAsr6gs65LFOkn4Bwg8bXu8YdTgucdQecQaDl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 18:18:13.0834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ede1fe-671b-4eb0-dd0f-08dee7546d6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6189.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8843

amd_stb_s2d_init() discards the return value of several S2D SMU commands.
When the SMU refuses a command (e.g. "SMU cmd failed. err: 0xff") the
failure is only noticed indirectly - if at all - and reported as -EIO,
masking the real error.

More seriously, the S2D_PHYS_ADDR_LOW/HIGH return values are ignored, so
on failure phys_addr_low/hi are left uninitialised and the assembled
address is passed straight to devm_ioremap().  When the SMU leaves them at
zero this maps physical address 0 and trips the ioremap-on-RAM warning:

  amd_pmc AMDI000B:00: SMU cmd failed. err: 0xff
  ioremap on RAM at 0x0000000000000000 - 0x0000000000ffffff
  WARNING: CPU: 13 PID: 4592 at arch/x86/mm/ioremap.c:...

Check the return value of each SMU command and propagate it, and reject a
zero physical address before calling devm_ioremap().

Reported-by: Francis De Brabandere <francisdb@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221759
Tested-by: Francis De Brabandere <francisdb@gmail.com>
Fixes: 3d7d407dfb05 ("platform/x86: amd-pmc: Add support for AMD Spill to DRAM STB feature")
Cc: stable@vger.kernel.org
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmc/mp1_stb.c | 31 +++++++++++++++++---------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/amd/pmc/mp1_stb.c b/drivers/platform/x86/amd/pmc/mp1_stb.c
index 90b8a5cebfa82..1ec0e599df7f3 100644
--- a/drivers/platform/x86/amd/pmc/mp1_stb.c
+++ b/drivers/platform/x86/amd/pmc/mp1_stb.c
@@ -311,30 +311,39 @@ int amd_stb_s2d_init(struct amd_pmc_dev *dev)
 	/* Spill to DRAM feature uses separate SMU message port */
 	dev->msg_port = MSG_PORT_S2D;
 
-	amd_pmc_send_cmd(dev, S2D_TELEMETRY_SIZE, &size, dev->stb_arg.s2d_msg_id, true);
+	ret = amd_pmc_send_cmd(dev, S2D_TELEMETRY_SIZE, &size, dev->stb_arg.s2d_msg_id, true);
+	if (ret)
+		goto out;
 	if (size != S2D_TELEMETRY_BYTES_MAX) {
 		ret = -EIO;
 		goto out;
 	}
 
-	/* Get DRAM size */
-	ret = amd_pmc_send_cmd(dev, S2D_DRAM_SIZE, &dev->dram_size, dev->stb_arg.s2d_msg_id, true);
-	if (ret || !dev->dram_size)
+	/* Get DRAM size; fall back to the default if the query fails */
+	if (amd_pmc_send_cmd(dev, S2D_DRAM_SIZE, &dev->dram_size, dev->stb_arg.s2d_msg_id, true) ||
+	    !dev->dram_size)
 		dev->dram_size = S2D_TELEMETRY_DRAMBYTES_MAX;
 
 	/* Get STB DRAM address */
-	amd_pmc_send_cmd(dev, S2D_PHYS_ADDR_LOW, &phys_addr_low, dev->stb_arg.s2d_msg_id, true);
-	amd_pmc_send_cmd(dev, S2D_PHYS_ADDR_HIGH, &phys_addr_hi, dev->stb_arg.s2d_msg_id, true);
+	ret = amd_pmc_send_cmd(dev, S2D_PHYS_ADDR_LOW, &phys_addr_low,
+			       dev->stb_arg.s2d_msg_id, true);
+	if (ret)
+		goto out;
+	ret = amd_pmc_send_cmd(dev, S2D_PHYS_ADDR_HIGH, &phys_addr_hi,
+			       dev->stb_arg.s2d_msg_id, true);
+	if (ret)
+		goto out;
 
 	stb_phys_addr = ((u64)phys_addr_hi << 32 | phys_addr_low);
-
-	dev->stb_virt_addr = devm_ioremap(dev->dev, stb_phys_addr, dev->dram_size);
-	if (!dev->stb_virt_addr) {
-		ret = -ENOMEM;
+	if (!stb_phys_addr) {
+		dev_err(dev->dev, "S2D phys addr query returned invalid address\n");
+		ret = -ENXIO;
 		goto out;
 	}
 
-	ret = 0;
+	dev->stb_virt_addr = devm_ioremap(dev->dev, stb_phys_addr, dev->dram_size);
+	if (!dev->stb_virt_addr)
+		ret = -ENOMEM;
 
 out:
 	/* Restore the default message port for subsequent SMU operations */
-- 
2.43.0

