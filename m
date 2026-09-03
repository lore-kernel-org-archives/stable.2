Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011006.outbound.protection.outlook.com [40.93.194.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E59447803;
	Thu,  3 Sep 2026 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788460211; cv=fail; b=eNBYiQ+AxtadEWz6xeDXGd2R1WoMohsGX2wydI7p31GYoibmNGCqAkT48S7dfSQz8zr4mXCD5GHiwoOQq/6CCUrbxJUynyK9P1GJyImyWXoPIzmVoLUZOPm52PTGv7VIUeSzI0mJPkwfLsd9/SWUhh9lm50FPj5TWzsBDwdidcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788460211; c=relaxed/simple;
	bh=I3Q/qzK8/ToY3ogW8e56opCITrI9XPOXsZJTjHXBy4g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=X1Z0L78P7FowmNxKI4qushQJ/eDm6/8GHt85vwWxD0j6jzwmcUTHtNOUiElQbR3SBawI7HW1nN80+7aIlZmHF1e4/JnqQV2szi5hAlOt4O9KrGhtiWRpjKwzHxsu3sbnkuStLRckyZjFjPLgcHoKDAeKqYzI9kmhXxFoCtNZvX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OMS5ZRro; arc=fail smtp.client-ip=40.93.194.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OMS5ZRro"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQWNkrju0Oc3HqupFyEPyXWM3krgV6nWk69MqiOE6ZM+p/ADAIgT1fD0v1xvFY6b9Osey9AqAq8ERX5y98+vx+pw6xSApFe6HbANB3DXn/Ef22yADSvTPYgOyo3yzdJn63xaEPhT5HR6hoJxRnHQWjhj2H30A7DlqnXir8P/DKqulFI64GT63Sg8uJuDXOVpOrdzopEte5rZS6h7SCxUy7mLL2u7GxsDOS0nbtz45QldzfuYZMD2D34Mjy/ZUcANztVSJME/fqH/ON/vdPHN9/xQQaRVBK0DgdLbPUlLeVg8zRJVeJ0e9TlzxRWDQ7KUpYIbPllFSSkKKdyh4RMSgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysNBAje/hr0wxEqPz8aOz79DIaDsosNEAFnUyIYEitE=;
 b=Gy3qgngV1AL+eY0Thm7sOM2tx9oUUzTD8e2ueKEwxY41zowp7hRlNguVTi1qJdlGwlz3kI7D9tDR4Lm7149BwKO9saEem97cDrZm10rutnzK04r8KGQuuB8UnF9M7uGWzpOZuSfUZz80CUcEjDEdnlGHqH6l7wdXWtq9Acdw+0rYFJvXGxKVaO0gwAc+Rnsp2Sf1B9en+BJ+se0WDlLz8IEaScS315BqjdumqZIpjKKhInb0+ZLYznHyv3XeG/fB1ZNuklYoV2tTGXYKp6S4OZczzAOU5r3i/RqPG7B8GhA/eyHQQQ90ABudiKmrC+vZ00CPHghOFC0C3WPErg996w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysNBAje/hr0wxEqPz8aOz79DIaDsosNEAFnUyIYEitE=;
 b=OMS5ZRro4Bb/cd/zwaKthEKIlMqXSXTt2rAz9kHFNMmIOX6iAjuFvWmqkF3XO0UfAldilwgD1hxyTKUaJfDPR6TI91d7upe2L1VwFFQauq0aojO8xCZyLTu/AODE8R8yDF5picBr3uWIbuaO9YdA1aFw1Nmabq+YAVAPFDqO8wM=
Received: from CH0PR04CA0098.namprd04.prod.outlook.com (2603:10b6:610:75::13)
 by LV8PR12MB9668.namprd12.prod.outlook.com (2603:10b6:408:295::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 18:29:54 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::28) by CH0PR04CA0098.outlook.office365.com
 (2603:10b6:610:75::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Thu, 3
 Sep 2026 18:29:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 18:29:54 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 3 Sep 2026 13:29:53 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <Shyam-sundar.S-k@amd.com>, <hansg@kernel.org>,
	<ilpo.jarvinen@linux.intel.com>, <Patil.Reddy@amd.com>
CC: Mario Limonciello <mario.limonciello@amd.com>, <stable@vger.kernel.org>,
	<platform-driver-x86@vger.kernel.org>
Subject: [PATCH] platform/x86/amd/pmf: Validate the APTS state index
Date: Thu, 3 Sep 2026 13:29:26 -0500
Message-ID: <20260903182927.3556274-1-mario.limonciello@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|LV8PR12MB9668:EE_
X-MS-Office365-Filtering-Correlation-Id: afe594e6-1c3c-4d81-df2e-08df09e95969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	Ocgd7hbLU2NM/3zKkWblRw4scdmoQCdvSaZ0EPcsRanvOURWN8WsPegNZ6nTjowWZG9DmkJW4ItL5s9og5A/kVZyb8VJABmvW8seaFAy71Lf/PUBr4k3mwkN9EE0+dKoCLX+xnBw54itMPufU72oVYEWHDIhziG+Fw/+7KWCUZUiJJieGzTEfHuR18+qF7gP6i7vAW+xt3ZFlvXRy+ewklhB47ULbf2ee42Gi4eIEcqHLcHUvOvCaKdGOocSj4UoCgtDiyNOtqV4AzOOVBu0GHWVHl9tPf5qNz3d1pYGMbVFoDFZNqADmBopBzL0FRPbUmBS9um7e/knaZq5nWloIreW4Cj1btT1qEQ2mJ8ynVm+4hm/2pISlge+GZ9oEwxo86xYBi4FOtOI8EJ27xklTJ3gX5BWBItr6L1IDWN+u/PFfqXkG6mHKXKizG6qNk8iJkvBjB293y6K0dAsJn625mRyJdk5nEOOeE8WV8Tj+adnzAtUIVDzokqe9POIzUH8AXp8AfIrFgoX2dodL6KfPKLkpQWeE8gcdZZ2Z8CD+ig7egdv4E4Z14cleLHoVDLKVwJlvofqXgj/q8k/YFae9C/O8LrmuGqNZ70a8zOLOb5vkhs7P3LweubxKiQbVu3AaJEi4hJTqZYKpS5SCWQOB1+8T1UhL55+Q6ThuKJVgzThJ9qAxZdxWDePFOV58RRWRiB1kS4kaMwthTbWc5z4Rw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CubenIej55wcha06thufq19isP4ZGVUeMX1O8Tj3q84bIiIYogkyqvc8coRoWR5OziTn6+ZURAE+wjBeZsjxpFZjvKTSaVlmp0zAzoSH26sKxBfv6W/BBIPlks2GPcx/66FJXtK98Py2sitAcijx/likMdPG9BtwOEDLPUXCvWZIXOT0nQwsbEwEzm7MELlQq3N4bHG3KgisyKPRjud0vQX+dhXkJ/kSU0f8GbBcFfcxEn3SJKcSYIeJpha1yNCFk88nYKQ817CGY4SksS8lnxP4j+KAE6l31/83QKnl8HVC4vxABxlPNZuQoUeNkWxqt+G+7EZZ23IF7uZKD+FBCa5XoWmxe82i9OLkC95OElLecO601jVmqPx1bbmV5ORgiLjGbfuG6Fmo7V4yi3iHrgdwb5U7BWIXE5Y3OaP+4cPqlGEPS5BKqaNGYUOMLphQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 18:29:54.1605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afe594e6-1c3c-4d81-df2e-08df09e95969
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9668

The static slider APTS state index is supplied by the BIOS as an 8-bit
value, but apts_config_store contains only APTS_MAX_STATES entries. An
invalid firmware value can therefore cause amd_pmf_update_slider_v2() to
read beyond the end of the array.

Validate the selected index before applying the slider values and return
an error when it is out of range.

Fixes: 8362e862fb87 ("platform/x86/amd/pmf: Update sps power thermals according to the platform-profiles")
Cc: stable@vger.kernel.org
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/pmf/sps.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/sps.c b/drivers/platform/x86/amd/pmf/sps.c
index 0b70a5153f465..0918fb388fde6 100644
--- a/drivers/platform/x86/amd/pmf/sps.c
+++ b/drivers/platform/x86/amd/pmf/sps.c
@@ -248,20 +248,24 @@ static int amd_pmf_update_sps_power_limits_v2(struct amd_pmf_dev *pdev, int pwr_
 	switch (pwr_mode) {
 	case POWER_MODE_PERFORMANCE:
 		index = config_store_v2.sps_idx.power_states[src][POWER_MODE_BEST_PERFORMANCE];
-		amd_pmf_update_slider_v2(pdev, index);
 		break;
 	case POWER_MODE_BALANCED_POWER:
 		index = config_store_v2.sps_idx.power_states[src][POWER_MODE_BALANCED];
-		amd_pmf_update_slider_v2(pdev, index);
 		break;
 	case POWER_MODE_POWER_SAVER:
 		index = config_store_v2.sps_idx.power_states[src][POWER_MODE_BEST_POWER_EFFICIENCY];
-		amd_pmf_update_slider_v2(pdev, index);
 		break;
 	default:
 		return -EINVAL;
 	}
 
+	if (index >= APTS_MAX_STATES) {
+		dev_err(pdev->dev, "Invalid APTS index: %d\n", index);
+		return -EINVAL;
+	}
+
+	amd_pmf_update_slider_v2(pdev, index);
+
 	return 0;
 }
 
-- 
2.43.0

