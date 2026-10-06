Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010062.outbound.protection.outlook.com [40.93.198.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB9D3BE174;
	Tue,  6 Oct 2026 10:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791283113; cv=fail; b=SUHIl5k+RQOiw1r4F1o7+DtWPfcfb17FogBkChN5WgKeDGOvibreXDG1Kyqvfstblqh7GToKGv+hfKhMgae8oWLYLE/mfzk7GiKtAMrSsIp9o1wp9vuM1UKjsTwmAsEZeLAoIy6OYjriL9CndXZM3wEBMQ2VsM2NOua2T1yKT5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791283113; c=relaxed/simple;
	bh=UoxF8iwiek6kyPEjMGwszkoPitV6kUqn6h1x+h3Nl1A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rS6eLgY3VUp0hOHfF4oIBJH5qriNUgY8t1ixTC5b1sJ8zDnZdDdFL62VnIZK5y/WK7B8nrt4T6/rWuDiGEYyBeWi4ZqHcsQiJhYc9lthxaivN+J9VKT5st1TJq9szs7uI5BEfd9HYhYSNuCLpscZt/BPqSaVRYLhbmEd5PXYdZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EIzV0jXL; arc=fail smtp.client-ip=40.93.198.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EIzV0jXL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGvt3KutgIFgIppyyHa50wJBFXTK9QbjHgCKZe19LPmbfxGG8m7sxyzc9JdiPqIx2gQNRi9k6sLpFTQZdfleZ9+jU+EtttClkP5sUgv3P4OTNEaj706x5e39GAchvIusvlQluvRvz+ZXY5ABtzQpcrspH3G7d+xFLVe1tPcnz5I0rh1PPr6DNq9B2fDt7msSsNEXA4e18W/dWRdyOTxyZYqzwccqdOs853jbxeNJUg/thYOR+oedYgJOovr1BCmqkRziCy4XhatqVq8XGZyBrYxwZfFNZjYc3vsWjCv3ZdjC81VhNq7Tr77Hwzaoigtw0CZ5optxSu2hV/lS3hqTTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7V4/aNohugNUlsbX9nhir5BnqB7eOdg10xUKFXaQRV0=;
 b=nExpgT117M2GGmURHOjHRZwrIrSvFputcg6jiTAQQKV5OQl6GZexlnWpDPS2cE+Eo3J6lkBAiqJCz8KH2+a6KX/umpxWOf7zY/HCnWYmqmBvMv0W139Z8kYTq2Dll0aTlm8x2kimcqtWY7goF0jAa36Bz2L8XrVmdsJXz/mnfd2hwVbSPI46OYsMyXq1sbwiGFH/vXDtc3Ffmd7RRluGbnW2RHwdnQMn9KX4n85muAHz5A15RbEQgPSSMMMbwAkvo5XBA96jT5Er7SQlxUXyaOVlTgOoQ/xaChk+9d6bg6Drm2F1O/9FCtZeBcizhKQIb5QFihgjet829P8pCnnpDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7V4/aNohugNUlsbX9nhir5BnqB7eOdg10xUKFXaQRV0=;
 b=EIzV0jXLLDVuJFuB2B/V3uog4bZiwcxIdNmURrJdlr8sbo+lE1YokUlX7QA5u2rOgyRSL3TyG07NlGJuEnfa79fu7WkrPjrm2TbcOSOvGchuhTNA03y2lbyVJ2cA4JHMBAbKDSKFPcJXjwFTMJetoK92bblTTjpCUNrUZaDyEjk=
Received: from BL1P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::10)
 by SJ0PR12MB7083.namprd12.prod.outlook.com (2603:10b6:a03:4ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Tue, 6 Oct
 2026 10:38:26 +0000
Received: from BN1PEPF00005FFE.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::58) by BL1P222CA0005.outlook.office365.com
 (2603:10b6:208:2c7::10) with Microsoft SMTP Server (version=TLS1_3,
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
 2026 05:38:20 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <jikos@kernel.org>, <bentiss@kernel.org>
CC: <linux-input@vger.kernel.org>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>, Andrej Scek <scek.andrej@gmail.com>,
	<stable@vger.kernel.org>
Subject: [PATCH -next v2 3/4] HID: amd_sfh: Remove unsupported motion-state field from accelerometer report
Date: Tue, 6 Oct 2026 16:07:53 +0530
Message-ID: <20261006103754.3614316-4-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFE:EE_|SJ0PR12MB7083:EE_
X-MS-Office365-Filtering-Correlation-Id: b40c14e7-7ab4-4700-7c00-08df2395f419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|13003099007|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uHMyBY6JWYnzVizQIlvJUbEcm+icxzkRunyjSwYid+HH0tnY1bkTCF/o+UhxwA5ZUFb9bNz3l7zeLR89hsNSCatn2lsRlEvAKK9JVnc/dMofCLsE6MYqKhI++iCpsQO1emIXQGOte6sj9ABmZrGzBLnLeRpoNQ3BRNrd8+5DTSA/s0flQyHGY29RnVhV9+ykk8kED4jpaxsnU2jQosZeBAhuVHEqMxcw7CxGknnYVTUUvG2YC+Xp86lz48PhyvFDmIJQJ+cUtzE9kQJT7u/Iy1mt/HNiNdakOC4jXjxjEJHniwwdgNHkE5X/n2+A4BuO7Lra9YLiHVcsyXYHsmYOYrKL1ATvF6rBDYXqFoS3zFa16zCrpIu5AdUrLNIdOnf6yN57W5aEXwZYasLrxfUnqXezZXJ18S9miGQcHR8Qqi0D9hPmA9pF6kNcfjxUqLVjH5SsaVDfbiaFNxnuNqI1AV63Oaq3/ReNyEpmiMlwoXwbpZfzQFzOuGpDQl0eYDROJuTOG/6Jl6z3fberOU3cCKuEnwe1S/Jjc4/C57l8LAVC2hVtjuvbgrB1H5npiz04XSFtQvo/P6QLIwG73NmStY2anj8zphqmpkYbW3I4NnaI5IzfznpLX19FfytBfWJmfoeVcFS+ZHs+1cH4yDqO5w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(13003099007)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1oEZKZEOQp8W9lYn4oBVOPD1bdnCJUKQBf5epyoM4qF/d2j0+XeTCHCxAGex4uqF0a9UDXLUGrDHLYxo4Rf4pRavRRXdoVlokNxyS9nM6gfIbc1jdKKRVvc5OLu1J0lrZaU+D5CMPQma1yKH1iGEAgRm2TRDPIvhZgvQ5v8XnbF39i2l9Xe3fZ0JadGlCcO7HMXDmvo9qDko00Ne1zkPRLHXXjcNbsxxenoS8/8XsJ/I8gLpoGUJwxMIfP+Irps7utWeiok5UjCN4EKG7xpFxnsOnR9LbbaOC0UybKO7splngukv9glfqJ0h4hIlylINCwOnp5PBaTSrugmHafunXikWyWuV9LotzHJPVZN2vWz4Jx0q0Pjr+O9qL3nQnsDUQMc58OUT0FYcm/erC0+9BejeITvNlPdQxKIp7n/o67bbxpLGKco8dDwqJTHyllSA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 10:38:26.1869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b40c14e7-7ab4-4700-7c00-08df2395f419
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7083

The accelerometer HID report descriptor declares a trailing motion-state
field (usage 0x0451), but the Sensor Fusion Hub never reports this data,
so each accelerometer input report is one byte shorter than the descriptor
advertises.

This was previously harmless because hid-core zero-padded short reports.
Since commit 0a3fe972a7cb ("HID: core: Mitigate potential OOB by removing
bogus memset()") such reports are rejected instead:

  hid-sensor-hub 0020:1022:0001.0003: Event data for report 1 was too short (15 vs 14)

As a result the accelerometer input events are dropped and screen
auto-rotation stops working on AMD SFH systems.

Remove the motion-state field from the accelerometer report descriptor and
drop the unused in_accel_shake_detection member, so the descriptor matches
the report actually provided by the hardware.

Fixes: 1434f9fc0e47 ("SFH: Create HID report to Enable support of AMD sensor fusion Hub (SFH)")
Reported-by: Andrej Scek <scek.andrej@gmail.com>
Closes: https://lore.kernel.org/linux-input/CADrS85612m-Hh-G4BJmOhy-y6r3Ni3kD8_GM-2QRBeWWEEZWuA@mail.gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h  | 2 --
 .../amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h   | 7 -------
 2 files changed, 9 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
index 882434b1501f..230fb69cacfd 100644
--- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
+++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_desc.h
@@ -48,8 +48,6 @@ struct accel3_input_report {
 	int in_accel_x_value;
 	int in_accel_y_value;
 	int in_accel_z_value;
-	/* include if required to support the "shake" event */
-	u8 in_accel_shake_detection;
 } __packed;
 
 struct gyro_feature_report {
diff --git a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
index 67ec2d6a417d..64cff842e5f2 100644
--- a/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
+++ b/drivers/hid/amd-sfh-hid/hid_descriptor/amd_sfh_hid_report_desc.h
@@ -169,13 +169,6 @@ static const u8 accel3_report_descriptor[] = {
 0x95, 1,		/* HID report count (1) */
 0x55, 0x0E,		/* HID unit exponent(0x0E) */
 0X81, 0x02,		/* HID Input (Data_Arr_Abs) */
-
-0x0A, 0x51, 0x04,	/* HID usage sensor data motion state */
-0x15, 0,		/* HID logical Min_8(0) False = Still*/
-0x25, 1,		/* HID logical Min_8(1) True = In motion */
-0x75, 8,		/* HID report size(8) */
-0x95, 1,		/* HID report count (1) */
-0X81, 0x02,		/* HID Input (Data_Arr_Abs) */
 0xC0			/* HID end collection */
 };
 
-- 
2.34.1

