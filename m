Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010058.outbound.protection.outlook.com [52.101.61.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833A9360EFA;
	Wed,  7 Oct 2026 07:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791356611; cv=fail; b=F1EaI2OigJSnDysrwtNyo0cT9KgJTBynMd62mmpl2D5Zx9RKmMRcnkBk7Qp8GRFOgf91xj30wgxlMv8jFpHNde4jYcP21viw9S8yK20Vug2WnvXyJ41L0W14QB8d+W3Z6Vs/n9FGE5w5Ww9+OiANmlclXY2hZXuNgNZ3Jruui4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791356611; c=relaxed/simple;
	bh=rgJ4QiBPEUYKKSBxlXOkbdt5q/l76Mke3AB/fMdnyng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XL9RKl78nAPDb+FTyyAPBp3g6sCv17n0a1UjrfcRi+k9Tw6ELHuPjcqDgTNa8ImbioaPbti4fi++vvoSmY3p57w35fvAO60OW9qs5C4+4nGSM902G+U2YezAd1oxRyKDMbxd87ynNqcuWV5RvLKoA3vCNUWz6JqEsHHdaXJdBgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=T55Z3AzW; arc=fail smtp.client-ip=52.101.61.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="T55Z3AzW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KCd/M9ZVZuC/Z2q2I2OFyMnNzNnq+YjlDIuuBrbmIDKY2+WWnJp+A09nyijBbLDWnek8TC08lpRUxE+saqxQWWvi8QJhBOA2/T1VVbakhqMQRvkxQgEsdlCA2av5fiMSsKhvxfbinUGXXRWNsHTZV1YR0RGSpx6orzucGwqTBoxjaeDf63yY5nUVKUT83cJVtKnj8fALEas9tsRe15cMyMOZR5wNT8OOi8xwwRLYeGy4HX7Z6uGl1X9ApiCbbAqvBBzGDJVy+GC6STg8U0kj75DUHAkrkG05PwfoMrwIoH7X3MOYNKPZ+CgGPAKTioAT3a1o4EcHJGOPcUeXjbQdlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txmoDk/ds2V4BjTKqJdf0tNY0fBbXynWMop4yiCdJ5U=;
 b=GpFG0qP4imARbT15nJYJ/60UmnTciLJRHkFLfKAtkemLWfQntit8W7Y6535e5+9QquVQLfjfThDJX3WL40M3a0IGs8h9LhUVTTe2+fTHbpAOL4WXaz/qGeyGwj1LhvraMTeog6kiZscLUYYIdGzwzM4/TiVYrTWy58mDtmTpj9RUcjLP8333EXEHxBLwN9R5Bzc9vTKd43rk5AvAFIw8tjIXtqBf7Iyexwvz6fJzAUDBGL1gTPvhEz8OyUcYHgwMkn75p2t9QXZAuRk4raxLis5AlaXh/fUCeQLIPzfKri84Hr6MzvFD8jvtMrYkMsdZ/x+cqc7/hiOE5sHev6qWtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txmoDk/ds2V4BjTKqJdf0tNY0fBbXynWMop4yiCdJ5U=;
 b=T55Z3AzW8yOTfiyHR3lUiObU+qaSZfEdEDuoBGylWREqHSV2EZafMAl2u+CHszy2fDI+paUZzWb18P/tutmm5miWEUpjbXhJHL0rVrrQqUMa3oNSaMT1jeM+9dtE9Vcb8dA2vBTqUVwXhsfHHJov+OY4oW3BRAB2GF3dptag1VCh98X7jZHQ2rr/f5QABmZIN0+LBfWxNd0y55U+c4D24z1nzecdzYZOyXVTtkwGZvvAxH6aIr6Kwmn2U4ZZ0t2R1Le/Rt5fghPdPpZ3ZV8I852Iv1ozT6EGG4yCd207ux8m1I3CXvjhdEfqP7MEGAjLYyO5tsYoAF5MESh/xBAybA==
Received: from DS1P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:8:453::13) by
 CH9PR22MB454451.namprd22.prod.outlook.com (2603:10b6:610:33b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 07:03:19 +0000
Received: from CY7PEPF000000F3.namprd05.prod.outlook.com
 (2603:10b6:8:453:cafe::2f) by DS1P223CA0005.outlook.office365.com
 (2603:10b6:8:453::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.21 via Frontend Transport; Wed, 7
 Oct 2026 07:03:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 165.85.157.49) smtp.mailfrom=gehealthcare.com; dkim=none (message not
 signed) header.d=none;dmarc=fail action=quarantine
 header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay1.compute.ge-healthcare.net;
Received: from atlrelay1.compute.ge-healthcare.net (165.85.157.49) by
 CY7PEPF000000F3.mail.protection.outlook.com (10.167.247.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 07:03:19 +0000
Received: from zeus.fihel.lab.ge-healthcare.net (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id EDC311A2D0;
	Wed,  7 Oct 2026 10:03:15 +0300 (EEST)
From: Ian Ray <ian.ray@gehealthcare.com>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>
Cc: Ian Ray <ian.ray@gehealthcare.com>,
	stable@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	imx@lists.linux.dev,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] mmc: sdhci-esdhc-imx: map unsupported driver type to Type B
Date: Wed,  7 Oct 2026 10:03:12 +0300
Message-ID: <20261007070313.863-1-ian.ray@gehealthcare.com>
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
X-MS-TrafficTypeDiagnostic: CY7PEPF000000F3:EE_|CH9PR22MB454451:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9fad16c6-e719-4c84-ff43-08df24411196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|18002099003|13003099007|11063799006|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Ej0xbdRhY7DQAK+mTNkBr8R6C+3nyv9f5ru6zX98Ot5sHIwszfKdYpeo3DTV3x9SCFfVSS0LKIo2RN6Gn/JuVNlIvQGHRK9F0mFWr4NV6qwahv+fDoTY/6bwsPRm8Zhy0wnZOmrkxB8661b1qClWccsClsUULBsOBuIIqcfjecUc0cgvsbV349ofJt1g+wPO4OK56tYv2/2ouzRtDWtnRYOH/DNKRjvVW3P3/TDmzUOBFLSPWOiT+KFIsBAFgGtY4jDmWgNtbnRDQWJelL3FmHbYANbV/EcqxyYy13CBInyy8tQIQwqqFhsGDQFcOmYkMxcEHzfwEW87PtVT7NdticeZuzwKdHxAjScXHsCpsidGllz8hvCGLLka2kvy+5Xw7P5LE2LwyaVbl+otlRSpHNqVkw14nF6wP2SQARob7xvfuytb6AkMBfoO/JwMHW4DNw/cQTsCRNyeUVSQGm4e0GFeuIMAjl/YzYw548tqZjWm5tkAlLuv5iVc1W3QdVKC9NTnCFxzKQrdd1JKnVJ1331W+g6cwt63DQbOnAh5m472erJMvQmiakodDb6/SAXlnyTZPYi8+6vgomBBpzFbpAKYovB6EW2UBXFX7yF+4XUovgPSH8fmuQYBo99CsGrMrfP2V5+Voc5OzAgfXNHQ2kyBCstGgwvi2iN9L1Rj3TotqbBEj5cM+0ul8uWTxXhq1CJJ5bzk7Hn/eOX30agy/Q==
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:atlrelay1.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(18002099003)(13003099007)(11063799006)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	twt2k50VTCy+6rpG2LhyGn9MYyZ5Wi/nNLJZ3dhWcsqN1uuks0OiRtZyd8b+1TeeGqCMoZ8mkkv9gbNF79kZSY0NpNTBx5E6671fU6YBe43hjTFo6WrEgNxd5GjWtoOTSrIaSzoCaviIaF6Ykby0S0Pl6D/dC1W7EYtxx8WA9KIJAnu2BFu6nblXFyNovAmZWjG8hji69wjAq4HEJNnBj3w3bEWVbB7XzzlKHEooKDuhOceLaPWOF5y1P5Xt+hVaICndqwevjCb4HMImmVek6eZ06b9SIGTtat4u0+1Fxoq8NG1Tl5mI8deu7FYhu7ju/6WRXq4GaAkf1GyKVvFysMcDcYXNp5RV2b6wFFx2MZ+vDBsm95Al5d2wqP4e8Dcn6YmOGS82Ss38sfLLZB2eFJI7NKNnFPx1qxulUFYB7I6uZW19khJtTpqRQDqT2VxM
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 07:03:19.2940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fad16c6-e719-4c84-ff43-08df24411196
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[atlrelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CY7PEPF000000F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR22MB454451

Since commit 5a52c5701a67 ("mmc: core: Fix host controller programming
for fixed driver type"), the eMMC driver strength is passed directly to
mmc_set_driver_type(), which propagates the value through ios.drv_type
all the way to sdhci_set_ios().  For value 4, SDHCI correctly warns:

  mmc2: invalid driver type, default to driver type B

The host driver type has no effect on this controller: esdhc_writew_le()
never programs the driver-type field of SDHCI_HOST_CONTROL2.  Hook
set_ios() and force drv_type to the always-valid Type B, so that SDHCI
never sees an unsupported value.

Tested on i.MX8MP (usdhc3, eMMC in HS400) with
`fixed-emmc-driver-type = <4>`: the warning is gone and the HS_TIMING
register contains 0x43 as expected.

Fixes: 5a52c5701a67 ("mmc: core: Fix host controller programming for fixed driver type")
Link: https://lore.kernel.org/all/20260926122908.866-1-ian.ray@gehealthcare.com/
Cc: stable@vger.kernel.org
Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
---
v2 -> v3: Force drv_type to Type B unconditionally;
          hook set_ios() for all esdhc variants, not only usdhc (since
          the driver-type field is ignored in all variants);
          reword comments.

v1 -> v2: Move fix from mmc core to sdhci-esdhc-imx driver per review
          (see "Link:" above); always provide a valid host driver type.

 drivers/mmc/host/sdhci-esdhc-imx.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 6ab59d3e346f..931e383748a9 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1142,6 +1142,20 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
 	}
 }
 
+static void sdhci_esdhc_imx_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	/*
+	 * This controller has no driver-type control: esdhc_writew_le()
+	 * discards the driver-type field when writing SDHCI_HOST_CONTROL2.
+	 * The programmed value is therefore irrelevant, but SDHCI rejects
+	 * non-SD values such as 4 (eMMC 40 ohm, from fixed-emmc-driver-type).
+	 * Force an always-valid Type B.
+	 */
+	ios->drv_type = MMC_SET_DRIVER_TYPE_B;
+
+	sdhci_set_ios(mmc, ios);
+}
+
 static void usdhc_init_card(struct mmc_host *mmc, struct mmc_card *card)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
@@ -1952,6 +1966,9 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		host->max_timeout_count = 0xF;
 	}
 
+	/* No SDHCI driver type control */
+	host->mmc_host_ops.set_ios = sdhci_esdhc_imx_set_ios;
+
 	if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING)
 		sdhci_esdhc_ops.platform_execute_tuning =
 					esdhc_executing_tuning;
-- 
2.47.3

