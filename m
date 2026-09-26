Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9CC3438BB;
	Sat, 26 Sep 2026 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790425759; cv=fail; b=hNAMlFFtSGQjMMgNoXUPOBiMzvJIfI4UBxLD+FHSx49HR+5yjV3WdSx+0UJLqX1zkeujlyeVEsFY720eONcJVovuUbec0qf3ClHM/DRd9aRuP6ZRC2LgGwRBuLNG+fpsm+pxStNtBllvyPCCS+1HPUG6o9SuQuhLP3pS1XwKI3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790425759; c=relaxed/simple;
	bh=hyFfMPH3cy1W+xPPSw4zaCTwupiymC2PFwUtg0ZzlRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f+IwVcA6U8mXKbbrl3ezTlwiki2robLWaa7QTIEpAY1tYpr3IYqMRgWD9plu2F6IzMQ+GvPasPUhLOyHyKVwE5CJB2Rwi4hO4Pn3P+LhBV0w7Ei6QcNS3UlX0ohEj0x67Fwt1AMAuS0N8jEUaQGFsNyhZxBBMgIw6JJYUgedzQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=q74sNMO3; arc=fail smtp.client-ip=40.107.209.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="q74sNMO3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPolnr8wOeJ7dp+7tUKtFeBhDb9nC3LQIlyi7Ht0UfWHBNUZIoTRslPE2z3W8A374YCLrugirI2F3FL4NGpAHj/z4A7vjrDIqdVXA5kJMkBxqf4mld+bBhsqXA1DdGJ1+8CaT6DGU1b2EFwtd7skVO09/mbhuSGdTESD+WKd51sTJx/HBLbga2B+JVBEfgNvpmNNoiQfH4ewF466LW5/iu9x/FPB8ARktFNClO3wcTyVYpBg7YyUGxzuehGY5rWEFe4S+o60e3fdnjbHrdV+om8KS+SKt+rzDJi8iFDPctaMdLjikrE39m4/RrS6sLC2/cJ14r1XtXuzjyjfZzaSCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUqXJmlKcf8QgI7j7RSthNKjE70SyqXPC96hruaAWYw=;
 b=K7A0TuUaRQfNikYezwJgo74uU0gxxCUBn+7zWECs+f76WCHtR7BFOpcTERC5G/ZLeC//WgmSbmZ+X9hFpY8pcJ8X7iXxb/psgBo9/nYbgzEoPbQZ7jK/kog1DoyMwB5XJu81q6h7p4zbtWyDXqidVERoPHU7eqjuEFfx39DHBM2tjfXg8msXEQIdJPhTjonc2YISQzy09yEAzn1R2w2K9IdgHlUWV4pGLLDV+zlTjR0vnXYrgTrQMa8Oxj5M/VF+Ee0Uo2uO9WZC7EmarM56th5BYWLzc62U6zsydrbrpqbKoxyWauuncU3zIWoyivbMWXtWUpiqczULLvby606NeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUqXJmlKcf8QgI7j7RSthNKjE70SyqXPC96hruaAWYw=;
 b=q74sNMO3ZnzNKyuewZRXtgDifHYG16+T4OqjHtMHOAEaEF+RK+dhwqKKqiAjuR+VHZ6G/E0+/uO6ttXKt7EdySDgNDzOxEcLPC1ek4zuChsBGg+HaS3a2XKoGLQs1kuvtKjP4YyAbRRuWNhQlb9qJdXW5W7ZchSlgsQmKK9Ls2iAR1WZyXR++0w8VUCv2fWQ7xSGHhuTqEVm1RFj+RzxI0d3AaMRs7qKCB0R9Odeh3Hgq+7e5YHRSc82NTDBwl3mqgvWScsN1Q8ENDnRmQDp2DBVB2kCcMOrFpO0ZSLkMXNaBVG6sEzLB4BrCNLtpRrJ2XbgGzK8ji69lJ5yO7QM1Q==
Received: from BN9PR03CA0410.namprd03.prod.outlook.com (2603:10b6:408:111::25)
 by SN7PR22MB4128.namprd22.prod.outlook.com (2603:10b6:806:2e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sat, 26 Sep
 2026 12:29:14 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:408:111:cafe::83) by BN9PR03CA0410.outlook.office365.com
 (2603:10b6:408:111::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.19 via Frontend Transport; Sat,
 26 Sep 2026 12:29:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 165.85.157.49) smtp.mailfrom=gehealthcare.com; dkim=none (message not
 signed) header.d=none;dmarc=fail action=quarantine
 header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay1.compute.ge-healthcare.net;
Received: from atlrelay1.compute.ge-healthcare.net (165.85.157.49) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.3 via Frontend Transport; Sat, 26 Sep 2026 12:29:13 +0000
Received: from zeus.fihel.lab.ge-healthcare.net (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 1C2EEE4DB;
	Sat, 26 Sep 2026 15:29:11 +0300 (EEST)
From: Ian Ray <ian.ray@gehealthcare.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>
Cc: Ian Ray <ian.ray@gehealthcare.com>,
	stable@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: core: Don't program invalid host driver type for fixed eMMC type
Date: Sat, 26 Sep 2026 15:29:07 +0300
Message-ID: <20260926122908.866-1-ian.ray@gehealthcare.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|SN7PR22MB4128:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 47c4104f-aa14-4ee8-bd5a-08df1bc9c640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	+Q02+5g8FIp1cbVveLoBHGwmV3TmkqpxsCT+2teWBosFtNn0TwRE7CTZiIQEu99zBrn9YL2xUWNOVzHNgnx2UZAR8cRv2oiBj+yOj3xpnxoSQe3iY5Ahx7YOn1GLpnA0wrVyEePTBX9KvH0R0UnOOTXNvPoWlcoOV3eXSsXqBT2W5nw0D+BzJGrt18yOcjTHMSWLyHnjEeTT2Uy2ectFvv26b8Pvwh19JiTzMOk7m5oGMETbJK/lAxe9JFVhu8i6oa8JP9yKYFwqCM1ZGGeKcTHa0bVzN2Eel7G7RruRjXTq3UTdGpuWY8vPJjrOeK22ZHbSBHfG3OAZtDHSef1Tq7wt4qbZxkzcihHySzHV02HSQOF+WGmvUFmnUAMiXn9tJhEGs4rLjvjHF8DGkJYotW78f8I7NsVM0xDCV6re1nYeWQYl3puvtK/xKO7SuOoEee5zVosNNvJQVCuxoHzd2qrdjbY5hUPu2uyG6SlnDoKz9rNlBPpvMqvVLl9xA4df5jbg0oNkopuElC5+bKYPXUB+k/viAeyCuUFvEgT8/vEuPGf64wQclK4H29XbWcPdL14YcJ03ric0K4vcvtO8cr/sz22in3h5BfqyNUh0r3uOFmsfyz8DJTySdzBfWfUw6itBt9cnMJ0HaYGzd+xQF3gsbWvGg5pfC75w5Bn2B2lTDTUqFDC0cfvCnwNjqaXrl+Pqj8ZWsgsFAWuDTPS34w==
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:atlrelay1.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4eEJs2wvNWIDYtHUK2fFHZM25iu6HFGDYcEdKahExZmaijoKR7dz0Vq6sCuWCh+lcc2hOVUDjigLTLOHJnJLj0EQTMDyOH9+D3RHoTD0VmfFrvH/ukHKTof+3GA/jyb7I4+rzx0brWndLDvziQ9D3Px6abOKYlIETwxX43JnKZFDa63Dl/4Ebtj7hEaZNj4b1/vietKjqvkWWaj1EG4/4iPrciABHbLkgjH7OvXSfMRQbJ9sYzlgJI4AizYrvFzok4x46Af6CLpDnhSo+exCI+B9l6dsp4CnJe/NI+Lzw5/Gh1lj4knAPUu9sGDpPoDH1tIXFexJbfudVyMG5eV/hmKRKKb1CSyEEAckA+jfNph/tATup+JoNIpIb3O1vtkJE0yJN3PdBMvYpCNAzJXjD+r8zwbvOuAU3gUaIHelL9GE4gvTZht7iSoHT0fpifXG
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 12:29:13.4985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c4104f-aa14-4ee8-bd5a-08df1bc9c640
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[atlrelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR22MB4128

The host controller driver type value used by the MMC core [1] _mostly_
overlaps with the eMMC device I/O driver strength value [2] as shown in
the table below; however, there is _no_ host mapping for eMMC value 4.

  host value/type   | eMMC value | nominal impedance | strength
  ------------------+------------+-------------------+---------
  0 / Type B        | 0          | 50 Ohm            | x1
  1 / Type A        | 1          | 33 Ohm            | x1.5
  2 / Type C        | 2          | 66 Ohm            | x0.75
  3 / Type D        | 3          | 100 Ohm           | x0.5
  (none)            | 4          | 40 Ohm            | x1.2

[1] MMC_SET_DRIVER_TYPE_* in include/linux/mmc/host.h

[2] 'fixed-emmc-driver-type', see JESD84-B51 Table 206 and
    Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml

Since commit 5a52c5701a67 ("mmc: core: Fix host controller programming
for fixed driver type"), the selected eMMC driver strength is passed
directly to mmc_set_driver_type().  For a fixed eMMC driver type of 4
this reaches sdhci_set_ios(), which only knows types 0..3 and therefore
complains on every ios update:

  mmc2: invalid driver type, default to driver type B

The mmc card itself is still programmed correctly (the HS_TIMING driver
strength field is set from card->drive_strength independently), so this
is a spurious, repeated warning for a valid, documented configuration.

Change to only program the host when the eMMC driver type value maps to
a valid host driver type.

Tested on i.MX8MP (usdhc3, eMMC in HS400) with
`fixed-emmc-driver-type = <4>`: the warning is no longer logged and the
HS_TIMING register contains 0x43 as expected.

Fixes: 5a52c5701a67 ("mmc: core: Fix host controller programming for fixed driver type")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
---
 drivers/mmc/core/mmc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 05444ecf3909..ff5d4b805998 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1371,9 +1371,11 @@ static void mmc_select_driver_type(struct mmc_card *card)
 
 	card->drive_strength = drive_strength;
 
-	if (fixed_drv_type >= 0 && drive_strength)
-		mmc_set_driver_type(card->host, drive_strength);
-	else if (drv_type)
+	if (fixed_drv_type >= 0 && drive_strength) {
+		/* eMMC driver types >= 4 have no host controller equivalent. */
+		if (drive_strength <= MMC_SET_DRIVER_TYPE_D)
+			mmc_set_driver_type(card->host, drive_strength);
+	} else if (drv_type)
 		mmc_set_driver_type(card->host, drv_type);
 }
 
-- 
2.49.0

