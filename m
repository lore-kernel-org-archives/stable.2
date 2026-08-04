Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013053.outbound.protection.outlook.com [40.93.196.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DE1468C18;
	Tue,  4 Aug 2026 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838450; cv=fail; b=DKEQfd5B/yy6fdneYX+N2DAAtdT0DaLjauMjSJf/R+d6ckg0f+WAh0UnwZ0eHFM6GkuVIst7GwzqvrnKJrO+xNqrUz+Skmj8lTBTnoDWfYei3hQBUhAJwKbbn5M6qnMagXCD94Z2RKC77KZPrk+edf9XwEbJ02pS9fW9j/NcOTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838450; c=relaxed/simple;
	bh=wTQoOVCJLqSQ0wLKlHscB7f5O/MeHERWrWCozgWRcNo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtrHN9QzbgxNt5+OuKAELtS0223FN3kZ0HvWUiXUchJszZ91dc+6QJNvQKWTQNUtbfEmLdYA8FkR7jaC+iWS/nk9q3ARBoHB046tTNNDJhjlvadFTQaK8h8pX1vzS4cxqY5/FJJ2Gcgpb1usSwPssiqwOcSIZjXlDYl55Fk7gG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XH1LAmOC; arc=fail smtp.client-ip=40.93.196.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XH1LAmOC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KR0WuiEd/E9Kd0mf2W+KTq/HeJZ2OqDdOM2Y2AZw3li+6tfMqiiKvmlSg6wh+YRYVrM902LEQaZGnP2022HbW9nI6ednR6/jLZ0cTUUbAh9MrdPn2RlEQca/L+HDEFXz/F5kItA1X3XfUxvpt33ccy0pCfDgX53l8OuWl5feC9gIQSL7a0WSBPxiNhBHQSUoht+reHSDsyZTdWoOhKTtDRawidJZ6OA4i+cDJEadpMSliLQJmsIMRFsIdQJ5EyklJ8xdUC5WYxknA4d/9v/4kWAoZT8xjaJe2izl11xAQfMc6/ZWbF1I3ZZtK6/EZX7tjc8lEcGkylEScpNmM51UIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lA/fIyErFHdNx0Zs2P85YoJHkeYILoXQ+OFFla5TWh0=;
 b=yFZw/LlCoBc0DqvFPv1j1hidE1A/o1zgueuXjVUNie6MNo2CyL+uXgYbBHzNszWQTJhYB5ig2nNyHuwgqTQAb6IHlhycXp9l8rxOfIUdObK8+dcEf6LWOxu/x0TO6tpDBVAxRg5xSWVBHuuSFd8yRKYHW1/iSG4mneh0t/GUjX6UBSTDaI/ejOUgWM/aSKTTya7ZIqoLqfB+KLw/fiqjjsxO07BKhIZDT4aUaoh/c1ClfPQq7pw/VdhNTDHL4k2JB3hvjrHtutAO/wRdYmN4yCmnW6pRzMRqjo/KosnJXBKC6ANlDGoToSJDdrXtYNoYASM2B5mQ9d+vbgVUNpfN4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=bootlin.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lA/fIyErFHdNx0Zs2P85YoJHkeYILoXQ+OFFla5TWh0=;
 b=XH1LAmOC+43JLGIy8+ivKOu2slmnKI3/PnyNpNBEr7cG+9rv1QpQQeWu4eu+EQQUxqLarqN/9CC+fTp2pbbP2f2KUn0EnADJT+qcZiVzvR95MaJoY2TxeYM0depdRK46NQHpUcNhNMLA9/ZDr6K/cLl25PhFf/YQ+JI5JCRZQZcgHp4TfCU2LteZPZpl26hMNjEKrrbE/iUTs4H6P/k+DCWLsPnKzZry++87eFCuV2SEnSNIRzZ+JEDXSk7OEHvYy3scNviWMbO6+XXfYiEBFyeOzslIHhNQv9Ev1STiB5uKVROnFlwPvFOf3exD4VNQ2J0NedNmKT77tuy6KSFfug==
Received: from BN9PR03CA0089.namprd03.prod.outlook.com (2603:10b6:408:fc::34)
 by PH7PR12MB7020.namprd12.prod.outlook.com (2603:10b6:510:1ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 10:14:01 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::80) by BN9PR03CA0089.outlook.office365.com
 (2603:10b6:408:fc::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.18 via Frontend Transport; Tue, 4
 Aug 2026 10:14:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 10:14:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 4 Aug
 2026 03:13:44 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Aug
 2026 03:13:44 -0700
Received: from build-akhilrajeev-noble-20260602.internal (10.127.8.11) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Tue, 4 Aug 2026 03:13:41 -0700
From: Akhil R <akhilrajeev@nvidia.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Frank Li
	<Frank.Li@nxp.com>, Adrian Hunter <adrian.hunter@intel.com>, Akhil R
	<akhilrajeev@nvidia.com>, <linux-i3c@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Sashiko AI review <sashiko-bot@kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 4/5] i3c: dw: Do not use OF match data as a quirk bitmask
Date: Tue, 4 Aug 2026 10:13:00 +0000
Message-ID: <20260804101301.2975911-5-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804101301.2975911-1-akhilrajeev@nvidia.com>
References: <20260804101301.2975911-1-akhilrajeev@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|PH7PR12MB7020:EE_
X-MS-Office365-Filtering-Correlation-Id: 835cf45e-c8a1-4ed3-7f70-08def2111a6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|13003099007|22082099003|18002099003|3023799007|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	c207WugExjtol4YtYuUgF4MveRTtUCVGtO0T0QnFXINkErGZPvi4rrRjky5Aj4+Wpn0dZ3iqq6Amo2EvdBd5M17iBhDJKsdbEByOOaeITnmL+eGOr6wAjf1dQJxiORNFvAXU349jqdYOnuZM1+NNph51wCd90LuS35+Baf7AvrcXyKLq+HNcM5nfhfxDADzuq2Ho2fZEonQulxOEuEnAvvKeWvu034UqE9OjDqTmlOcAf/DJ/Ch/p2xEFCLS9R8a23EGFO4CznA9nqApv1vdZsAkJtZB3nIhQAg90HIVLukjhWw1oRn7wfMPI/Cj9RHB8QyfQLZ/WTZOe/FAGllryr+Pm93QxATNtjA9Ki8ia2fqyaQKNKjpPtu35n+7Ef2vxsVIMNNzvcwZ4eikjWj2YGcx487oXoTXcqEq9PyjApt3h9SiGHAJqkPM/+1P7b0uPZZDleQEb/bGZgLt9vze5J3O/oCYzPQtBIAuHCKLWbnYv7JhNlau6cnEyIGnHog4pSLx2tvPT0d5slrc7xu5OEC40v3fgzxspmaONpYdPPZss/wXYPPaFESBOAF2HRVHM1IMJ4TsPdXPUN78D8xFkUbUAeTwnresWWq6H2/6bva6I4ab4RuIA85++19KAiJV/QyzEK5hO+OL3j99Af+Buk5+zu692+mbMdJWoG8XMrsTqcSMyalxAL/dhsKEpFGGmT++1v96qSIcPxPAF+BbaQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(13003099007)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WMqk69oUjcFPM8ScIQLNx9xj+cz7viyEziIMIgvI4lzEjvJlCV1giiw8Miaplz64nzfmHdfi5MceFovxcSGKh/YSrzv1I93KIhlhg59rHHaYifxTSSHZuNV0WNKD60Q3XR1GEuuNHI9k0z+UuS+UebBudicxUo57qRBd8P8tA15PvIlOhXB4JrOQFDrAXRyhxRXnzJACjt0FFIHmm9ewFm+sGl/LM7Oban62g8PLFpGH6nGfq5s01dZ6bXElVMlvBDB32PTP8yzIddBS91Qq7GeYWkR955ihbp1H13AwgwHJ6ONIT3rlHiECIzV7bHaxG1qSTbjrjLEHJUjlc4UrdH8nS956i96qc+zFlZp+5fYow+W5q4YGfEkPBN4bvPLOJ7uYSd6SbxxuAiA1Y9JQDQMwDV+58YOtHcR3ShnCa+7xsDsoLIFXvFZ7VHUckWfV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 10:14:00.3228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 835cf45e-c8a1-4ed3-7f70-08def2111a6e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7020

dw_i3c_common_probe() takes the match data as a plain bitmask of quirks
whenever the device has an ACPI companion, and as a pointer to struct
dw_i3c_drvdata otherwise. The two are not interchangeable.

A device that is enumerated from ACPI through the PRP0001 device ID
matches the OF table, so device_get_match_data() returns the drvdata
pointer of the matched entry. Casting that pointer to unsigned long
enables whatever quirks happen to line up with its address bits, for
instance disabling runtime PM or skipping the clock and reset setup.

Look for a match in the ACPI table of the driver instead of merely
testing for an ACPI companion, so that the match data is only read as a
bitmask when it really came from that table. acpi_match_device() returns
NULL when the driver has no ACPI table and when CONFIG_ACPI is disabled,
which keeps the ast2600 driver that shares this probe on the device tree
path.

Fixes: fba0e56ee752 ("i3c: dw: Disable runtime PM on Agilex5 to avoid bus hang on IBI")
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260728071757.5B3CD1F000E9@smtp.kernel.org/
Cc: stable@vger.kernel.org
Assisted-by: Cursor:claude-opus-5
Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
---
 drivers/i3c/master/dw-i3c-master.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 3816a50a52cc..17e1dd4fb5f3 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -5,6 +5,7 @@
  * Author: Vitor Soares <vitor.soares@synopsys.com>
  */
 
+#include <linux/acpi.h>
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/cleanup.h>
@@ -1610,6 +1611,7 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 {
 	int ret, irq;
 	u32 thld_ctrl;
+	const struct acpi_device_id *acpi_id;
 	const struct dw_i3c_drvdata *drvdata;
 	unsigned long quirks = 0;
 
@@ -1618,9 +1620,10 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
 
 	master->dev = &pdev->dev;
 
-	if (has_acpi_companion(&pdev->dev)) {
-		quirks = (unsigned long)device_get_match_data(&pdev->dev);
-	} else if (pdev->dev.of_node) {
+	acpi_id = acpi_match_device(pdev->dev.driver->acpi_match_table, &pdev->dev);
+	if (acpi_id) {
+		quirks = acpi_id->driver_data;
+	} else {
 		drvdata = device_get_match_data(&pdev->dev);
 		if (drvdata)
 			quirks = drvdata->flags;
-- 
2.43.0

