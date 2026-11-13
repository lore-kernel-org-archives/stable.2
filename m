Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.62
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794587784;
	b=HC4yC9HJ+MUUviA+nxYmM6ODKq8VEZiqGc6s7u/PTin1N/60bivTmxy1IcIGpEnAxIfc
	 C3KgTo3NwuFize8Xq5ynNR0/umF3xMk8L4zF7Z3SjozvtJLVJo9Hv4XM1T1cASsZGrMmZ
	 A7rWmUgI0wHwB9N2ij+RB10m7hY/P4zV+zEy0PDXMY1ybHYrHi7NZs3hNMB5YOLTIX3rm
	 Nq4ykMN7Ss8uIQyTxo5P5vBlzXHI1xOYkY0cvz1lqz+wHkzXtIYIr546d2dJvHNhjTcfx
	 U/LgeDPsWGBJw01fXrspIMS1SAaskZPBr745fBzkM2eVr31rD9qn9iHB/MoCNsKpvlg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587784;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-ID:X-B4-Tracking:X-Change-ID:To:CC:
	 X-Mailer:X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=XIT6gy58F9vc0tid6eriE6hHQCT2iMggeX1MLHglbIQ=;
	b=QcyLvxuliLAwhtvPfpY5fHiH8UUixIo3dVhthyDP7pVNvoINWdwWKuwf1FdtYADw6+6/
	 gDs5ufm2e/xotQ212yD+3aZTVQ5HUPG9mAnH2dgjQ50nLbuPA6LHm70ak6Ut9RP32v5yV
	 jXZeOOBt4PdirCPxbMhvTlg7rCKdsb4RymiM3Q9XPocQvW7gkuVV7WGkxcZV3HMI0D5n+
	 GKXrSumlp60uxeYYmz2UDaxaTxKK7j1dQj2b740vLhA0AVj13ww/2SgS/9xew4s9Feeng
	 fm5s2p4U8mH6v4E13xqhIKTY85+G6i9iKcuNY1qz1jG6Op5Q6t2xguHdOy2RNTBH33g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=cHF7qBtA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.62
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013062.outbound.protection.outlook.com [40.107.162.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DE0606A323;
	Fri, 13 Nov 2026 16:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71DE0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=cHF7qBtA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ntus92OL7tR78ZSVFv6XNCpVbKR/PrBVab29dF6Aqwh4KYA+MeqVZrRHxNC13rJDlnkfuu2NlHZ9k+VTJ0L4NaOX+QzXpyQLgd060HK+O1YkCT3yVGBxllysA9xr1mM7mRr9i+t86OrE3NniGWhAoiNtoinRTXKeas5yf/WdSuOn06+/nqF2BAYki0Yx1/5DkDEdsWeBMvtH3ifl/R1KyvBbE4x5pCTtyFUzAOuLOMjfPVp2SHFKdey+DwU4K8hwZBrLq2Cg/yEi7pp/0DAIjFvukHuMVAEetn7U9+IDnxXa1petulkGtbszlPyqpNwgfJlAs6WMpxgP+gS4G34l0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XIT6gy58F9vc0tid6eriE6hHQCT2iMggeX1MLHglbIQ=;
 b=GxdQL/1ueQZp1FSSWNUdXGK+wtS+NpSw7gMD+AsJi9fcITInrsrZYfiZDn1S/+SDX3IyOYBipAsRXJTfqh5gkK+wA73oyxIX7s2VU1lFPveHuQBe9Pu2VRaUjBGIbySobplaKAjOa33jJMjmBZNgpIIHOU6Wx5DDSuSBNVNk3/cdg/Qwa7DqgsFDnQ0wlYsq1n6fmoxY44c6uWGaEvOyqP8vYoDIfsywag5LOscWFFM2k96jJYwgdp62tPbX+7vmDAHJjesWWuCwXJPfh+eF8C/r9taSH7ON5YmoqDEOFcbaKOjSrnVufXU7dbPmX0HKLzTsjaWhj1prQsmR+nRnHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XIT6gy58F9vc0tid6eriE6hHQCT2iMggeX1MLHglbIQ=;
 b=cHF7qBtA5iIPMcqPPeMQ6ln6QlW1Rq9WSpzOU+SlSWSAS1TC2UhsSI3XK4Kp6giGFpJ2nH9LWR4LbQgkDA9g0m9U3Pb2RvhFE/AhJ3UwToqQrWkKHAtozAZ4vMmeamUu19V125ZD1iitOpAWqrUkq89pPnQ4VOB/iB5RcstPD24zIEwF2HZ3UnCQDglHIZDNvsI6uj6qErQvTtOY6wUS9DfkpSfLdwzxkNPP5MQ5la/Q63/8bNndslVaHxHRiZg55amry/vNSmPrrG+o2eY1m5mbSFXbR1OaUGIit/nH0xkJfQwaap5rPIbPp03To+S0RSubY02bWo55milwnfM1Bw==
Received: from VI1P190CA0002.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:2b::15)
 by PA1PR10MB8740.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:453::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.6; Fri, 13 Nov
 2026 16:36:18 +0000
Received: from MI3PEPF0000848E.eurprd03.prod.outlook.com
 (2603:10a6:802:2b:cafe::7f) by VI1P190CA0002.outlook.office365.com
 (2603:10a6:802:2b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Fri,
 13 Nov 2026 16:36:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF0000848E.mail.protection.outlook.com (10.167.240.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 16:36:18 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 13 Nov
 2026 17:37:15 +0100
Received: from localhost (10.48.86.101) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 13 Nov
 2026 17:36:11 +0100
From: Christophe Kerello <christophe.kerello@foss.st.com>
Date: Fri, 13 Nov 2026 17:35:44 +0100
Subject: [PATCH] mmc: mmci: stm32: reset and restore SDMMC state on system
 resume
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261113-fix-resume-reset-v1-1-115b3da5764d@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAGY892oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0Nj3bTMCt2i1OLS3FQQlVqia5mUZGpuaJKWYmpgqgTUVlCUClQDNjI
 6FsIvLk3KSk0uAZmjVFsLAKd+Jv90AAAA
X-Change-ID: 20261113-fix-resume-reset-9bb5714fd505
To: Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulfh@kernel.org>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	"Marek Vasut" <marex@nabladev.com>, <linux-mmc@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Christophe Kerello <christophe.kerello@foss.st.com>
X-Mailer: b4 0.17-dev-ce4c1
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF0000848E:EE_|PA1PR10MB8740:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c2c0b3-0a3e-4910-3bff-08df41a43e43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|7416014|376014|18002099003|10067099003|261026121527099003|56012099006|261009223027099003|261026140227099003|11063799006|261102123227099003|261021123027099003|261028144727099003|261022075727099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	OPH1N/1WJ0ikYsZtYqVQdCdhBJgIMuSxcjLxsrNRjjHAPul854P1kdCDrhKUVo/57DpJrqfsKCnAikeXSq5jwyUDVljdlK27wFAzIFtqpaBbRhDzy1o2gLWG18kMUmnQfywG/PQWJFDH7+ITcVwt0pzZAPeTtbvjmHZgG/Zg2pF1VjQQTzc/9uv0viSD0+sT47qNeJMG7yPt4Ho4uO2au1K4r60vkwZAQqGP0+1l+r7zDs8RkPDDnziKF4pfA76IfbcgnOo8S897F8VjR3hPK0eGUyFHgrPR+pViVO8Lg+9wL6TQzp/cOgt+qL3DXi7zAh4Na+M4rNUkDuIxZ93OWozRh9RZfmRxE49Y92U4l+IBPo0arPIbwpjlM0y9KGGXc1h4fvx/LkJnxxgtCkoweA2XBoPnoLHb2dLUVNTIgQ6RC9LpqemJSr3T+7fE7gaouzt8bog2xDWkeupKOpdBsrxLbKQHu0X9D3GF9q1yGdDpK89qTf9Ksq6o173BGvcJjKrgA0ryxRaqvsbJ+1lvIM4fMAulBYVo02sEZ23x5FC6xwdEWUQa3WT1AXBv08FjGARHzZ8Z0YKhtwJnwQkaWHnjot9TEEVgZwdEenRg2ZEAeJFaml4Nfo/TAc0pCkMiYt/BVr548sWJUELU2PZNroE+kkNylRWD+BFqKwnuSlslExpyyQOCxC5GJMDYRYxU9bYDntrdU9Pkjh3sPZDmWQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(7416014)(376014)(18002099003)(10067099003)(261026121527099003)(56012099006)(261009223027099003)(261026140227099003)(11063799006)(261102123227099003)(261021123027099003)(261028144727099003)(261022075727099003)(261021121427099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	R1bSee8ws7r5aEDc8IjkMWChzgyUM25HGew87zEgXrvd5oxJhy2drMzhafXB2fn2x8Nzkaw91XVMAaZsesKInHaTKR9TSDUl0cVy+B3BpzkxWKwWr0KfQMwIQTrR5ZRYVOyZNNX4O0TUGD4Jd58GnBC2toukTsDDPkjIO0ho4HEcYxcHCn01Tc2fdOD7oP6R/UpVrK4RBrRO3+9EY7FQaQbhXT/oAoyq3BrSutHajebPFWmr/1uWaqt8Z/uENZYKrU2AjEXvR++32jddbgOYIzrlfvtr2w4B3hwNw30xxzWpbzs2WvnVOVUsYfk1XVjmYerIHti0klPDWVbaXbsdHmYJ3KHIUoLtJdX0J/NE2kzP7btYahZOFhTIOMEhQiVqCKXD0K8PiQbZ1/b9oDYInHt7S2p6hHu3EeFuiaHym85QrJdiR18saEEFE144YjZu
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 16:36:18.4517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c2c0b3-0a3e-4910-3bff-08df41a43e43
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF0000848E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8740

On standby exit, the bootrom may reuse the SDMMC instance used as boot
device, leaving the IP in a state not known by Linux.

STM32 variants do not set pwrreg_nopower, so MMCICLOCK, MMCIDATACTRL and
MMCIPOWER are neither saved nor restored by mmci_save()/mmci_restore():
their content is expected to be retained by the hardware.

Add a reset_on_resume variant flag. When set, and if the card is powered
off and a reset line is available, reset the IP on system resume and
restore the cached MMCICLOCK, MMCIDATACTRL and MMCIPOWER values.

This is done from a .resume_noirq callback, so that mmci_irq() cannot run
on a state left by the bootrom once device interrupts are re-enabled. It
also runs before pm_runtime_force_resume(), which does not resume the
device if it was already runtime suspended before system suspend. The
clock is therefore enabled locally for the duration of the sequence.
Clock and reset errors are reported to the PM core.

Enable the flag for all STM32 SDMMC variants.

Fixes: 46b723dd867d ("mmc: mmci: add stm32 sdmmc variant")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
---
 drivers/mmc/host/mmci.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/mmci.h |  4 ++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 5ecb4d0bdaa5..f5affe4fe1b2 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -278,6 +278,7 @@ static struct variant_data variant_stm32_sdmmc = {
 	.busy_detect		= true,
 	.busy_detect_flag	= MCI_STM32_BUSYD0,
 	.busy_detect_mask	= MCI_STM32_BUSYD0ENDMASK,
+	.reset_on_resume	= true,
 	.init			= sdmmc_variant_init,
 };
 
@@ -307,6 +308,7 @@ static struct variant_data variant_stm32_sdmmcv2 = {
 	.busy_detect		= true,
 	.busy_detect_flag	= MCI_STM32_BUSYD0,
 	.busy_detect_mask	= MCI_STM32_BUSYD0ENDMASK,
+	.reset_on_resume	= true,
 	.init			= sdmmc_variant_init,
 };
 
@@ -336,6 +338,7 @@ static struct variant_data variant_stm32_sdmmcv3 = {
 	.busy_detect		= true,
 	.busy_detect_flag	= MCI_STM32_BUSYD0,
 	.busy_detect_mask	= MCI_STM32_BUSYD0ENDMASK,
+	.reset_on_resume	= true,
 	.init			= sdmmc_variant_init,
 };
 
@@ -2586,8 +2589,63 @@ static int mmci_runtime_resume(struct device *dev)
 	return 0;
 }
 
+static int mmci_reset_on_resume(struct mmci_host *host)
+{
+	struct device *dev = mmc_dev(host->mmc);
+	unsigned long flags;
+	int ret;
+
+	if (!host->variant->reset_on_resume || !host->rst ||
+	    host->mmc->ios.power_mode != MMC_POWER_OFF)
+		return 0;
+
+	ret = clk_prepare_enable(host->clk);
+	if (ret) {
+		dev_err(dev, "failed to enable clock: %d\n", ret);
+		return ret;
+	}
+
+	ret = reset_control_assert(host->rst);
+	if (ret) {
+		dev_err(dev, "failed to assert reset: %d\n", ret);
+		goto out;
+	}
+
+	udelay(2);
+
+	ret = reset_control_deassert(host->rst);
+	if (ret) {
+		dev_err(dev, "failed to deassert reset: %d\n", ret);
+		goto out;
+	}
+
+	spin_lock_irqsave(&host->lock, flags);
+	writel(host->clk_reg, host->base + MMCICLOCK);
+	writel(host->datactrl_reg, host->base + MMCIDATACTRL);
+	writel(host->pwr_reg, host->base + MMCIPOWER);
+	mmci_reg_delay(host);
+	spin_unlock_irqrestore(&host->lock, flags);
+
+out:
+	clk_disable_unprepare(host->clk);
+
+	return ret;
+}
+
+static int mmci_resume_noirq(struct device *dev)
+{
+	struct amba_device *adev = to_amba_device(dev);
+	struct mmc_host *mmc = amba_get_drvdata(adev);
+
+	if (!mmc)
+		return 0;
+
+	return mmci_reset_on_resume(mmc_priv(mmc));
+}
+
 static const struct dev_pm_ops mmci_dev_pm_ops = {
 	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(NULL, mmci_resume_noirq)
 	RUNTIME_PM_OPS(mmci_runtime_suspend, mmci_runtime_resume, NULL)
 };
 
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 4d3647f9ec06..3a053e40d113 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -334,6 +334,9 @@ enum mmci_busy_state {
  * @supports_sdio_irq: allow SD I/O card to interrupt the host
  * @stm32_idmabsize_mask: stm32 sdmmc idma buffer size.
  * @dma_flow_controller: use peripheral as flow controller for DMA.
+ * @reset_on_resume: on system resume, if the card is powered off, reset the
+ *		     IP and restore MMCICLOCK, MMCIDATACTRL and MMCIPOWER, as
+ *		     the IP may have been used by a bootloader or the bootrom.
  */
 struct variant_data {
 	unsigned int		clkreg;
@@ -382,6 +385,7 @@ struct variant_data {
 	u32			stm32_idmabsize_mask;
 	u32			stm32_idmabsize_align;
 	bool			dma_flow_controller;
+	bool			reset_on_resume;
 	void (*init)(struct mmci_host *host);
 };
 

---
base-commit: d2616724e01132376c78872b8324f38659af9f28
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next
change-id: 20261113-fix-resume-reset-9bb5714fd505

Best regards,
--  
Christophe Kerello <christophe.kerello@foss.st.com>

