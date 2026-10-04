Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012028.outbound.protection.outlook.com [52.101.53.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857C32EF653;
	Sun,  4 Oct 2026 16:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791129619; cv=fail; b=QZmZpPeX94uPFRU9GJNKSKZkrwv/NQ7V/F5GrjhuyJ1eAO+AVCNoa/R6Cw4BaOVig+lQN6PxduXlDqDNcxorTTRHNvSQqCVqd5FWbaHkc+/MvS+9JPNLcOt5iMzKNqWFsD7i8OEhGg4CwkvJOUdrf+z0gcIs3BkqrhP42m3vLqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791129619; c=relaxed/simple;
	bh=UoxF8iwiek6kyPEjMGwszkoPitV6kUqn6h1x+h3Nl1A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6DJQ4+Osbl70OhyXL5wbrfNKr9VHPV523nzP+CrbUXyIqp5uTIsuARQSJ4pHvtqjlDlwD+jyeyW7JrKY6pj4Hu74DBxp8JdB+pQeUf4FeLmt3W6TUrTN8AKV/dSsxABPh75p9IixIlJ69cI5+OeDZuPImgBKV59HbdZAPjG8Vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AeP/I56M; arc=fail smtp.client-ip=52.101.53.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AeP/I56M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJJjc1sfn8X/7E3hcoap96s8n9tSs2AsYG2+0ep088RyeLuD6rIJNV0Rs9J23kcSCZFFXFiO3740N/NnA5d3fwuCKxarbNL60/wZDOAGTEMmz5YRG94H9FGSpbRnskO90CkKGKJ1rnKGcRkIBoAaMoyemv/eOXARJHK90/fhvQpYZ9Usc2zzKtD3Pt6Ik6p6yhgXC3HZ2wLgzttJj65t65UjmFt7qeOiuIjDIg9MOqWjoJ/CQZgxTFhajN8vu5REjEI8djuHX5261cR7rdw9eemYht7fo3uF8TmbcjfH1j3mJP3YYm89S4rRi1IbRNUXz5lhhkkjOMiIVupVaZmbmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7V4/aNohugNUlsbX9nhir5BnqB7eOdg10xUKFXaQRV0=;
 b=coyh7owU8KBFHAeHJWaflMGWrvd1SFaTfycxz2Db6m2Td2CYQiQGoVICFP3QyqkNDDuPWpellwaRVlI70Mol7DXKct/AAAP3k6xSdO++Z8lWRWyzZ/1t4hxJg3FNJWJmk2e7qju2+8VifkSqO522B/k2+VV/+u454uuWxVE37HXIczhguRubw4dY2sCci5uzbXCMsH/ovozDoxUb3t4BAzOUHU2SgcpNqH3H1pGWQbSiUeI2L+5ueSeyjorpaRS2gsywjOp3uZuVfTzVAwzcizsheeSCCsubgBDxNyITnK/6ud5lAWN6trGMnCOerO3O/TuOrOWdcYgjqfwUVEsAIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7V4/aNohugNUlsbX9nhir5BnqB7eOdg10xUKFXaQRV0=;
 b=AeP/I56MVOcn6NOq+nzyQROMrkFbopbSY8y1RYFTj8xAkFZcsFYLlKi76wBjrWVcsGZvZDQEarnl22Rc/lqTuXinOb6MdtQEc+dEMQ3M7Xk6DT2fPy/leFjQGHbEH4V9h14n1xMxkWpM4GoTt5VSStJY5xgiyj5d2ErjDD/s+Vg=
Received: from BN0PR04CA0059.namprd04.prod.outlook.com (2603:10b6:408:e8::34)
 by DS0PR12MB9057.namprd12.prod.outlook.com (2603:10b6:8:c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Sun, 4 Oct
 2026 16:00:13 +0000
Received: from BN1PEPF00018070.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::76) by BN0PR04CA0059.outlook.office365.com
 (2603:10b6:408:e8::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 16:00:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018070.mail.protection.outlook.com (10.167.245.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sun, 4 Oct 2026 16:00:13 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 11:00:10 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <jikos@kernel.org>, <bentiss@kernel.org>
CC: <linux-input@vger.kernel.org>, Basavaraj Natikar
	<Basavaraj.Natikar@amd.com>, Andrej Scek <scek.andrej@gmail.com>,
	<stable@vger.kernel.org>
Subject: [PATCH -next 3/3] HID: amd_sfh: Remove unsupported motion-state field from accelerometer report
Date: Sun, 4 Oct 2026 21:29:19 +0530
Message-ID: <20261004155919.726226-4-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261004155919.726226-1-Basavaraj.Natikar@amd.com>
References: <20261004155919.726226-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018070:EE_|DS0PR12MB9057:EE_
X-MS-Office365-Filtering-Correlation-Id: c47fd693-c81f-4fe9-1fe0-08df2230934d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3srNGB4bG6vkOliZiLbcmr9Jy//bwj2uX2/LP61JNT3P8E2hilc1S2Vm48IwfeKndzMhFyCphcVJ/TlZOSM7jGhkSntryxNZCk46bA7Zz/J91HcENF6VRTQC1g/hie2CdPv3ZvwlJ1tnTJ/ObV0/UQjwE+iqT9gngf+XXIBuwp0SZMnqjQLpToFGqU36GXW/zVlPbe7AaAdmhB67uTcsemZGnMPbC2btbr5SecU3gXs5i0Os4hHp9fDGa4aUV1d4bY+wCrGa4DInJpwCQowcGhMyjKmmSHpKv/ictIG52zHS9DzGbcE6m4axOH6QC/pOJRiA/Dq5z0uWsWCwLP55yxt4maErBehf2jN1BcQegXk8EjdGq5lGYAguj4fKLSzWDhlF9d5yxG/5KYNoz8cV72xqc0mX8G2bBwcdOr+J4/UwROtRNupsPfu8atsGoUFMJdS2CaQ299ZUh3RjuWW6Z4U7V/eIDEbK75wpDLhbkdGI1fk1Ymmt9GVyjhk1er5tsuRg2ZuEnPezzcvOD1xheyZWByDQs3AuocEv34u8HKrGylqQ8QCp8oLx2gHRbPajPBvJOzDTgmmUuxyJ4tdW9oRUADEIFinYbYkR3a/ucYudTBgaTutJMH9ttNvi1Hnvh2nU57wLKJdTCGqyggJLld8UArYrWts8CkVdEJ6TQKltJY7bIG8nUHDZgqmXYpo71QVhC7vYpxMIA5G0FKxrTg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	55mnR+Q01ved1+Y3lks8ciz8uwdyNtUW/Vq3rEeegN49UEmJaHZr74CWBNehRCpJBzaAoRn0KAYhCaL5OG1DQO+4kdrPp0zlzTJikcvxTKy0HQ6UsTi16V3bv8IsMl7wR4WS4Dz9I2LD+RfZdKVTP7AIf7l9YinPBdnaPb2twL39QJdxj+HoC84k+O4+iRg+wnfyAqo+tyr4kwm3XfMZ5w2oc2kxKPazgiz/KRJ07ICC9MgpS5KciBP5EKryJOzXgtC6Jj9oPydESNld8aVHBZjGXgwj6q8DFfMq9mnTVkHMIvZP7dnRvEXDIFZPjjc8jsZ34Cwp9KQTocr6Ch7BMXOhFf2EkFU8l0Pni3flxK2YQ+x7DTQ2oAzcecv62+pG4LEYudMgPr5uBckHtugiB8o4NTvJCFGTx78QzBBVwyq2K4YXYQKRZcRtunzUWLPV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 16:00:13.4592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c47fd693-c81f-4fe9-1fe0-08df2230934d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018070.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9057

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

