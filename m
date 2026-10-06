Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011034.outbound.protection.outlook.com [40.93.194.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35723BE174;
	Tue,  6 Oct 2026 10:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791283112; cv=fail; b=WfnE5tE7y50IeBvcnTWW51UqVo40S4pDWbZVCHN6MenKlwTnnKF5aoKlZ/J5n/f+xHxUW39qQ8niJbqS9FDFrnOb+MjZWU8mZEmvsuqWTr2oNtrDga0eUBy2DjTjCmOCegC3FXTHtQK55Cw4OfMzjnKgbtN3PvASrB/mj+jpPL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791283112; c=relaxed/simple;
	bh=ZXS6z67WGA2uKc1q3MmoWgD0ELXLnDAyzejE2sgb890=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Io4pqAv/ksN9TIWAwxm3YIjm7goymXcehI7eZojfJ7wvICc87JefqlviPAa/814UQ+nPJZ9lDgIpNEsS3DpdkPxaPWldy6CVFTffAlbLCH7WRS+4PrkDi1e59AFoY38FHrgDXMRjJsLHVjrL1h8WzYiABmMDw9wOy3Schi4NfZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ioyo3fNA; arc=fail smtp.client-ip=40.93.194.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ioyo3fNA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LECbau4feKYIyxgIaG7YVJgYaClF/srA35N22QCsoSEnApIu45KOAVZXoGFZVsBdFIH90iyUKLYf6TIdwBGswAWdEbFpnhY5eZh9S1RcjAK6SE/tMR+xQ5hAKKNf81qHyp1ScHbHE2iC6nNg0v1A748J5v9AlCycrV9t8mxBSsBhdZD7dxmZsS5eTBwBhTeVnboY/yPWgumhcmQbgOD/9DNF+4OgAGF9MNnDLyGGWdGgwbUp3v+D2Z8VT7suXhOnCxX1Zu+AmKObQOb+s6r47A9a/58Xm53ISmu892iHxXkmnFm2z1W05uiqafze5k+ne52aKbtdxm+HYFGKOxpkfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wu7A0yrSJ77OPdz1kFucg2oa35uwkG3tgvV2cbIt39A=;
 b=b7pNnaP6798U936z6ZdGdbbjLNWQj0JL+ot3ba1Tdk6hPSddZsKZ7lmNXMDfyZmEYL274eFHq38jh8gRPqAXYeUeA3l0FTo7d14pWP4y+4X8PJa4W+xJHPpd7HtqIdYDMEySl58MnhAW+7Rcej5hBwllI3kg6gJxo+doksu+jMQ4PlBRDIfqAkkWdticAnBCvs2p1Z/luIg0nMxYJHQcx7fY1DZZ8bLd1d3bvqnRpfb1/G5M2MnjLEM7lLZtbFzIqU3RSoB6CB/hyxssP/uOsL9Is5AA9xt2yTSl1NyyZFxmgcx8nF/T12Wn8qaCCq4bnG9y89C4Y1TkdrivxY0uTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wu7A0yrSJ77OPdz1kFucg2oa35uwkG3tgvV2cbIt39A=;
 b=ioyo3fNA3JK3aAYgOE6YiFGr4Vm10fxaF05/f1MZJw9XjO7+0TLEkHN5NSh+VJuLFzjMBE78PK0nxsJNXzse7ixrmllDc3PXTjR645bX229aZLHWtlM6l9Zk9egNa6TEfwawA4cjqvooBHdLEWDnOmPmzKwdeV//HjP6ij6lSBo=
Received: from BL1P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::23)
 by BL3PR12MB6594.namprd12.prod.outlook.com (2603:10b6:208:38d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 6 Oct
 2026 10:38:26 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::58) by BL1P222CA0018.outlook.office365.com
 (2603:10b6:208:2c7::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 10:38:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFE.mail.protection.outlook.com (10.167.243.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 10:38:26 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 05:38:22 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <jikos@kernel.org>, <bentiss@kernel.org>
CC: <linux-input@vger.kernel.org>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH -next v2 4/4] HID: amd_sfh: Use report type from request node
Date: Tue, 6 Oct 2026 16:07:54 +0530
Message-ID: <20261006103754.3614316-5-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006103754.3614316-1-Basavaraj.Natikar@amd.com>
References: <20261006103754.3614316-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|BL3PR12MB6594:EE_
X-MS-Office365-Filtering-Correlation-Id: 7695ddda-d919-47b2-3936-08df2395f479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ZJnHdBnXDS0EJ4mj+/Zun5nb//FTenjvNOgXS4P8GyeyATm/8uEpHQhh39/4Rd8icz8VIBQnrR1ieSpYKykZ6p7uKktTupotXtAEyGP889smD4o+uMHHY+csG5p+cvmqpsuNO52tx6wFQsYV59NooX2gTwlP6LoyLASVkcF6lu2WMoL1W7yk0ax6pfq0TGd6jpIJYk06HZUYZSPBcvpHtvHw8vu+gN02wSLCPOT6fG+eAuWvF5Am18gmnz3oCRQPzkGz3pJAf+n6ta5B2ZRhmGHqP2Vg9VC0bOU+ZkDdTIo63VDkEpZHZ8fnmUYnv+Q1VsjyWay4a7KfXeH/UanEGsZ4hQT+vTshnyJWKEAtIAn2+37ChBg1IlWhEfBV/ybrqYqAXQTMxWYwsVjdOIKwpZukqdN65cW6CBmEdY56SEtWy/Zu7IC0bXuWFOgbCHdBXfzp2mXpFYAo01Y2TWb9CLKYScMu/ZY+SDcHzQsz+lcUrVXvW648ZBdHroy0JQE1QEklA7swRD/mr+WNYYkC47FfHdsrBt6XhEHXW3Fm8YyBZcXpTguOcyv0PUJM5JkPhv1r3DHhV3P1wyY/vUTb6/CR4AVGN2jYj3HdF9CM+TBLN4VGAj3nWRY2l2bVryvJC0p51UTAsi9OAtBy2QNVMW0PehwAH/mOmJIq7FzgepnyvGTtYThhHzHHodDfMnfWTIQvXHyp2wWq2ciTWBmtQQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	86xUe88jK6wr1Qp3FnFydHUr8NLNwkTEhbF2PczW/+2jafOLjrYEeNQ9l2mxuoobDoA6WYOQWuOFIufJsrXOt+4fPUk0mEz6EgCypOsmuGYiz0D4+C63SKpxyd+OXRmprCNo92qEcCf3jTLDFnsU64M/BrQtPI80jBD9uwJ+WDdCS6vPg6LKdevFEPRmHL2VSJfAkNm0ta2yLtduSdv4EE2xnZAzMn/4YSk9AC97GTcIGvRiFBzs3X0YB1RN8A6T7NHf9A7kn7avaSYHmT193wRFppJe8Y/wJqigA/8GC1XWtb9Pv7wgj5zYFR6B39h7Yg86YkNiylUAjA8Yn/mAOjKHAGf8SGqDabeWQfxxbh5i/vzMC0vQpJIR+HhRidQcdPwDzqQm5ITh+7M5KymSBCu9F2YQnj7ttHVXBIOamBu5o2UaMg7+h9WlDgew/w6c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 10:38:26.8160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7695ddda-d919-47b2-3936-08df2395f479
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6594

Use report type from request node while sending feature and input reports
to HID core. The cli_data report type array is never assigned and
feature reports are sent as input reports.

Fixes: 1434f9fc0e47 ("SFH: Create HID report to Enable support of AMD sensor fusion Hub (SFH)")
Closes: https://github.com/ublue-os/bazzite/issues/5796
Cc: stable@vger.kernel.org
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_client.c b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
index ae6add0b9ce3..a68b275f0456 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_client.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_client.c
@@ -95,7 +95,7 @@ void amd_sfh_work(struct work_struct *work)
 						    cli_data->feature_report[current_index]);
 		if (report_size)
 			hid_input_report(cli_data->hid_sensor_hubs[current_index],
-					 cli_data->report_type[current_index],
+					 node_type,
 					 cli_data->feature_report[current_index], report_size, 0);
 		else
 			pr_err("AMDSFH: Invalid report size\n");
@@ -104,7 +104,7 @@ void amd_sfh_work(struct work_struct *work)
 		report_size = mp2_ops->get_in_rep(current_index, sensor_index, report_id, in_data);
 		if (report_size)
 			hid_input_report(cli_data->hid_sensor_hubs[current_index],
-					 cli_data->report_type[current_index],
+					 node_type,
 					 in_data->input_report[current_index], report_size, 0);
 		else
 			pr_err("AMDSFH: Invalid report size\n");
-- 
2.34.1

