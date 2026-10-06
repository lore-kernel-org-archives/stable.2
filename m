Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011022.outbound.protection.outlook.com [52.101.57.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305A33DD52F;
	Tue,  6 Oct 2026 10:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791283992; cv=fail; b=L2HF3cbPnpGmj/jdCoRs6m5MBbYTf2Tl/0qZ+fZum1Vf/wCUpPidOh67RdXIgAmzgduYqBsizUnOzFU0qImOgNgi6ws72FvdCyvdJkCywgOhu4XMzRK0eY/yhFRZ7wd08l83DftqY8HPa6UxUGjhJQkSUQvRH/rP4sTgeKd3WX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791283992; c=relaxed/simple;
	bh=uPZYYXf5r/uasy6gx3mXXNCWr4RoEQoYhASJoM3YLOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=An2nPsTyCrlXS2XIXyfWH9tAMTd6GtfqlQBDOxOTNS3iHZgaNhDrFbVVFqC1T+yzucG81hvqxh7BsmzgvBjo8DUgNzclutf6r6n3swIYzyCW4c5W6jPHpoiNcQilEDwJsiAyYjSxgiY1jJzmxQh7vJNEVHdLnfo40GGauEk22Jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=gfM8Ggzc; arc=fail smtp.client-ip=52.101.57.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="gfM8Ggzc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUmi0lnoCzAZ7uk4ieU0KHbFFUJjV+CaE6U8EnmwFOr4RwnytLIdQsnmhHq7YzX0DpAMnElte9hBbizipvsnZp3NDNosUFOqwS+nzcuW9XOQxOi+m215rMAO9xhxI/rXRlFD5Lp0ecqxw6r/pfcBcWCIrLgUi7WppVxvb3BOouPGv+QiWElkMHXhf/4MfDFhaGRnXDvaLtyKr+Q88MxIxy6fIiB5bULah5NHVW+1QrkMGUXwv1VEFfGdzWfyuQwmwdkfDtDrUbcAiL8KdxvPukaSSl7TfBTiYBEgf05U50HMEepvMmSdP4tWWm8x7h0xLHxavN/vq8T7OGtkmnRxTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mSgi5zuM2XAqa42vQT6O2w/3Bh2HnoxcNEP2kmrFSoM=;
 b=F9jCkConRY9NI9FD/Nx69lWYY/4OUP62O4eKna4KTzl26LSkR/zDehmZEk83+pJVgljjBuJd+Hp/8pDw3ybR11a4bQhyiJ0gi7VUvJGLPhoRgSCeCejvtS4mU+X9CUS/QEr/jXWO0Jtdpw43Maxs6fpbrWEBXD9iV4+znJj27WY6z2xp76Rkst3OeaMZjaS7fm3DBDOm1tyr893K51RSMTF93D2C+LXBLq+gua2S0w5imbd9v77OmMYxAMmeU5XJry4Fs8CZ/zg9ctfE8SKaljXR1YWOnOBhXWWZYsWvcYB6JGbvjf33vqZwjJerx9IwU6KB6Twspx9A6RiZ6IjcNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mSgi5zuM2XAqa42vQT6O2w/3Bh2HnoxcNEP2kmrFSoM=;
 b=gfM8GgzcuaaTCjdzI2NTgO+cQE4v2XQYBHGHuB2/CqPfuQVEETyV7ZBDaubsnxvESxSpX8DIpLeqWWMJCjoOfO1IasJ0hmPScyVKQltH51KZTtrwHTC44AV/GCmMjc1y9iBGq8ajNEih29hrXx89HXKaKyb3LAUS9BfnD9S/wWlXLGD6UpVIdQei3rUKuf8ix+s2UE3rzXekp2f6NRUvafvpj+D88I89azyWPNzVr3YyIK2uAn5r2/v6xFzNJYu3Qoy5yTw1EgNDkPxQDc88iNSZMOAMoALZ9Xv0VhXc7OMron65rt67okgTmEFou009w1uWE+ntjLlj05PA9v5eiQ==
Received: from MW4PR04CA0129.namprd04.prod.outlook.com (2603:10b6:303:84::14)
 by DM3PPFAE7DBA499.namprd22.prod.outlook.com (2603:10b6:f:fc00::e3d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Tue, 6 Oct
 2026 10:53:07 +0000
Received: from CO1PEPF00012E82.namprd03.prod.outlook.com
 (2603:10b6:303:84:cafe::1b) by MW4PR04CA0129.outlook.office365.com
 (2603:10b6:303:84::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Tue, 6
 Oct 2026 10:53:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 165.85.157.49) smtp.mailfrom=gehealthcare.com; dkim=none (message not
 signed) header.d=none;dmarc=fail action=quarantine
 header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=atlrelay2.compute.ge-healthcare.net;
Received: from atlrelay2.compute.ge-healthcare.net (165.85.157.49) by
 CO1PEPF00012E82.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Tue, 6 Oct 2026 10:53:06 +0000
Received: from zeus.fihel.lab.ge-healthcare.net (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with ESMTP id 4BEBB1A2D0;
	Tue,  6 Oct 2026 13:53:03 +0300 (EEST)
From: Ian Ray <ian.ray@gehealthcare.com>
To: Haibo Chen <haibo.chen@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>
Cc: Ian Ray <ian.ray@gehealthcare.com>,
	stable@vger.kernel.org,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mmc: sdhci-esdhc-imx: map unsupported driver type to Type B
Date: Tue,  6 Oct 2026 13:53:00 +0300
Message-ID: <20261006105301.996-1-ian.ray@gehealthcare.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E82:EE_|DM3PPFAE7DBA499:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8d27e1e7-8fd8-4b86-7bf3-08df23980131
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	bH6H1jhCpbaxUFHmwebfQF88J7zg9bQJCvfyVFfKrnGMJtA7mxqq6HC7n1fTkt2e8/YU38Q/C3pjtFsFoJFX2QBxuyP87NAqw1pIQYhKo6/AMEutHsigfCH49udU57mNV6qMSSXO2blNYzttdNI/4UZeuEbvTlDl7uvtkXpy36OHLGP5RhUO8W2IwpwpPL2Rlsc9cMwhL5NRCTPso1nmKbvAx82Gv/YdqZv2s5T/BofpTPApV5CDVGtjMbWncsPVEhZAQtgp5Qbyq9FcinSCipQExdmdYo6O0uskOaF2Ccj5gawMxkco9ij6NNPp5HO14bUTYAFnQ+vNTXZHy8cUMpJi99zMuwGEwjp2QW3+Tih8RIdh28LoAwv4s8qQWVfk+6X59yNaIY9obd0/u6Yn9F+hwjLtwUsUaZCG1YC5hsLQNTjn5rO56q1Ffckz5+ezA/mvJ4dyvwpAGj2ksupMTBU0qwJCyHvw+6hi7FMsQ6g2M+yJMk0oerbiKH5MJs4lZVfhVmp3BdWWBnOtDlUYxLgLKv89TNkfnbmbPBnvVWmqyrQeir29nqhc1a6iA1UT60V8g664wnf11Mr2UbNxQWIMdzIOb9+H5AwO7QuRnNO81J6VQkecYJA/VyRw3cbN5UywU7AQv76lUG7yXaUeh2GSDRH8EO0XhLOSOJGzahv6CZ2hUguwCUspNnyCfg15Wf0ULb2dDREXo5l33rONVA==
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:atlrelay2.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(11063799006)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7HEvmwQq8HVYrVfn/b46uYJlmcTZw2HML+5Fb6dpo9iS5P7eXvucbQpPhBKVVYI4H2JRntXmnufJiR4BC4JRnZb3t++LFLyZGR17pLPGhI3WVm2tCp6pdc1DHpOx6BMarlQ31C/NU335/bxANhdvnMMXl/WOO3VKKKvS2T0HBo8jsN/WnM3NEVI1g9+y00LmfWHTutIvFPPQCi9yL0KE55AH4+aodGcKWbJJlSsJ3NXZyoQ0bRjdeigYmYgSMZl6TFkxwP+CdqmltJLAsU6CMfGf+x75BzVjcNu1vNM0UH/dQW3Zi14QojSEEdRsYo6VQXV9PlIiPgyrmowjrTOfwOEQsPyPVr2YOBpRds3EH6IUR9jpl90fBel9Y+JhpJMJY87VxNZb8I+REqR8DC3HSi6xjm75CtxDk1N2U1h2l+Sptf+MF0vYr6HZu4mrkUW7
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 10:53:06.7416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d27e1e7-8fd8-4b86-7bf3-08df23980131
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[atlrelay2.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF00012E82.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFAE7DBA499

Since commit 5a52c5701a67 ("mmc: core: Fix host controller programming
for fixed driver type"), the eMMC driver strength is passed directly to
mmc_set_driver_type(), which propagates the value through ios.drv_type
all the way to sdhci_set_ios().  For 40 Ohm driver strength [1], SDHCI
correctly warns:

  mmc2: invalid driver type, default to driver type B

Hook ->set_ios() to map any driver type value outside of the SD-defined
range to default Type B, so that SDHCI always receives a valid value.

Tested on i.MX8MP (usdhc3, eMMC in HS400) with
`fixed-emmc-driver-type = <4>`: the warning is gone and the HS_TIMING
register contains 0x43 as expected.

[1] 'fixed-emmc-driver-type', see JESD84-B51 Table 206 and
    Documentation/devicetree/bindings/mmc/mmc-controller-common.yaml

Fixes: 5a52c5701a67 ("mmc: core: Fix host controller programming for fixed driver type")
Link: https://lore.kernel.org/all/20260926122908.866-1-ian.ray@gehealthcare.com/
Cc: stable@vger.kernel.org
Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
---
v1 -> v2: Move fix from mmc core to sdhci-esdhc-imx driver per
          review (see "Link:" above);
          always provide a valid host driver type.

 drivers/mmc/host/sdhci-esdhc-imx.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 6ab59d3e346f..33f63c6dc8ce 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1142,6 +1142,14 @@ static void esdhc_reset_tuning(struct sdhci_host *host)
 	}
 }
 
+static void sdhci_esdhc_imx_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	if (ios->drv_type > MMC_SET_DRIVER_TYPE_D)
+		ios->drv_type = MMC_SET_DRIVER_TYPE_B;
+
+	sdhci_set_ios(mmc, ios);
+}
+
 static void usdhc_init_card(struct mmc_host *mmc, struct mmc_card *card)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
@@ -1949,6 +1957,11 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 		 */
 		host->mmc_host_ops.init_card = usdhc_init_card;
 
+		/*
+		 * Validate host driver type.
+		 */
+		host->mmc_host_ops.set_ios = sdhci_esdhc_imx_set_ios;
+
 		host->max_timeout_count = 0xF;
 	}
 
-- 
2.47.3

