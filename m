Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794595706;
	b=AXHFtJzKwBHjumgPOCMpHFbpxX0xCkLz80DvhTvxb/lyJarkJK7U4DTushTxJXZabz6S
	 pRq5fWGVtYyxFEknw5saSi+wkzVBv6+O+XdEp1tqBSFlV0bCk3SA7QJjjKkfcgdTNimA8
	 uwH6UEElfcOYNA6aWS9O06/1eqXd/sfCOKcjmCXTsbzqRxwAddxJZeXttcCY5qxz7E5TN
	 sbSkhgEoTCZHePAo1G1u1I24pCOVknEgLNh5YrXrvsaZIzejBZQKIinahgnShOhpg3qjW
	 Poc45PZqTq+P8ojeokraELkageZx7Lotytryt4jsWgYI57ip6UID0e2lfHmpRRVC9ww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794595706;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-ID:References:In-Reply-To:To:CC:
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
	bh=0j61V/C2OPCuMWiWPU74bhDdvoa6ShUtGk5NsiZYj1c=;
	b=rrMz3bgbVKlCivOMhi4yzwxpxoZ2C5V6lEMNTVD053zF3JPkov6HtoPwMBcJB1l2zct7
	 1ChK6rOpuqmXXhlsvYsWuBrVx4KoluCpFBG1aT4P5Ac0VR4YEZCy0lDI0UXZxwwxf8BSM
	 ZeAzpfl1+3Vs2jB83xZPbs+p2DBtxAueoI0QNUhXuZWlj7Mjt5hfAiSFEyyZjisV9MWMq
	 KlDnNitPsxHxoRaMwmJTkvTvXry6T+a9S6dE3fazf1K/hLmX23Z4Rlo3Adh3rSLXX6Y8s
	 6T1IhjhixylVu1p/C8M5Pv3LkqVyzbvHsMkBj991l3gHrxv6jyuG4kZLd66p8RbJ8jA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Qw84eDt+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.36
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011036.outbound.protection.outlook.com [52.101.70.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B764606BDF3;
	Fri, 13 Nov 2026 18:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B764606BDF3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Qw84eDt+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5jHKyd0dGAEpvnl5qwmk3ft5Ie8bxiosYqxaYUk52s4ROduF6UfJrF0pF3/73BFSU67PI7zYEqoAu9xov/HuBqyUYgHAcnw/b9eQGMYUagpeiKdBkvfV7KiH50IbaoVc7NHWYc/KIjN8wsK8JAA4u4H7RG6ALpiQNhvDpuHHD1gx5P2VQxvRpI3vDCA7M6MLAUppFUk+DcTMefE37JnRBjYxEyyhurYzQ+H3ObcjMmWrI1t72RZB9qFr6E+sVpdJjUUVx5ZErGNKsO5KkKPxQ1mAY9i9arhN/9IDqTFwDVoS/2xtdZEkm7rQDpyCFVgUeUUW8Mb0NkmFhxEDSE+FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0j61V/C2OPCuMWiWPU74bhDdvoa6ShUtGk5NsiZYj1c=;
 b=xabzrkv6osk2Nh/JXZnlxG+TP50oQ1DrrVkI6CBaB0gKwB2keE/DbeUzt1142tuviDkprxqT91Zjw3BBhROBCSuqBG8cHazPBAjPSxItFqz+TUIOOTyFp6INC0WQSNvO9Looo8LiAmPVPSZ5oQTYpDxmClzvjGHtD0AG4RwjRr9LB3l4+lZVS4+8fUJw1DIf2QLcuChH6PNqYUmDFSGWoXQ+DV3o0LBsYFY1XPZiVjk/n1LrJvw/dvwWHQlQUm1hLp/pABUyAL5LPrmsLEOJeo4SBz8I1DlcVpefuk2Mfn66ugjnxU3HjiacZ119YeryyPBf3RM4Yw0fSmsYloOTrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=synopsys.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0j61V/C2OPCuMWiWPU74bhDdvoa6ShUtGk5NsiZYj1c=;
 b=Qw84eDt+Jlbka7wk2sIV1b+3fx4Q57FsmnB+UGb8WWlsqpJZ3DK0unaIC+AlqDpQVp9ej5kTUztu+2y1YXP3Cpwu2B9LN7O7tL7mQz1h/ALjNkndX5e1x29aLj4D+is7N3ywdpjM2yC4wk231lz7JJNPnrj1ZVdPeIVaoiXwC9zjgTQ/hs89bx1JE0d5Hdl5O7dd7LHNm9fjzXE9UjeZCqDG7sstm/QMXoxMr1xAn7Ct0JxfxHrbIhrs0HtwP3onSNcdPoaiNNWBR7mL+oZ3cDN8qKH7hWH0LurO1rqbaJhmlqCEnKFdTD6BkHR2Eq8usg/1iuBZzX3ARVz2mz6zVg==
Received: from VI1PR09CA0178.eurprd09.prod.outlook.com (2603:10a6:800:120::32)
 by DU0PR10MB6439.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:408::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.0; Fri, 13 Nov
 2026 18:48:21 +0000
Received: from MI3PEPF0000847D.eurprd02.prod.outlook.com
 (2603:10a6:800:120:cafe::90) by VI1PR09CA0178.outlook.office365.com
 (2603:10a6:800:120::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 18:48:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF0000847D.mail.protection.outlook.com (10.167.240.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 18:48:20 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 13 Nov
 2026 19:49:19 +0100
Received: from localhost (10.252.31.200) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 13 Nov
 2026 19:48:20 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Fri, 13 Nov 2026 19:48:03 +0100
Subject: [PATCH v4 6/6] usb: dwc2: platform: fix stm32mp15 detection logic
 power management
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
Message-ID: <20261113-dwc2-low-power-fixes-stm32-v4-6-08a8c962a09e@foss.st.com>
References: <20261113-dwc2-low-power-fixes-stm32-v4-0-08a8c962a09e@foss.st.com>
In-Reply-To: <20261113-dwc2-low-power-fixes-stm32-v4-0-08a8c962a09e@foss.st.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Douglas Anderson <dianders@chromium.org>,
	Stefan Wahren <wahrenst@gmx.net>, Artur Petrosyan
	<Arthur.Petrosyan@synopsys.com>, Amelie Delaunay
	<amelie.delaunay@foss.st.com>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Jisheng Zhang <jszhang@kernel.org>, Felipe Balbi <balbi@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF0000847D:EE_|DU0PR10MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: f7dbdd7b-fc19-4ab6-109c-08df41b6b058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|7416014|376014|1800799024|18002099003|22082099003|6133799003|261009223027099003|3023799007|11063799006|56012099006|261102123227099003|10067099003|261022105027099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261021123027099003|261022075727099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	yTWBjQJ1dJXcLFGtIZQtZS9DCTsB1Y90XqwJ3EJhN654ZKDdSnkqgnGhmRVpJzfBaaYsXisK2gM5Gk+ZVXrz52SflNpdIcuJ6xaUD+pp4L0Aw7AyWkIgaqC2LFhxGLc6bhdyQqACwOCc6RIa+rwhpFCkopic5Iwv0fl3AADQbBwRIXJMXECF6kTRK0hDTuUZUm9KHpVpIRjufrsHf0uGm/mE5o1OUsDEve2R0hioWMT8w/c8H/GDdk8blqki+0Y/wkFHSDguBP5nVa5J4M0ZWWx4TZfxKozcWdUcQPX95FpkV/DxHBCZNSpA/r/Oah1SPDVwRI4B8HzwVV1K4MEna6u0s8BosxqFKq5Osm4aoWcaDkz9KmOf97AbnYDOusUC3acAv/rng7s9vqpplaxVB8tv9SV/TBnNBjdw0iZw/f0AB/NvzKZIhmKphhsYHhFxkkFqtJkFsmWG6WI/HC8+6rKq5iK0FaNdFKjT9vYiyR9wmnjDxs8SCeYEubF40qRFDB+8pIS/tZk8QfJEF2RkiMG+H4yMl+mlYV2aLRhAEC372jV4BerYFGNwx675ovgViNsZCMJ96hu+HUwD7v+DkAfzwXO0MPRDvdXCX2eBvxEErJlN/48OcJ0j2pPQvMUq9err7h4dndLiuremR0weDZbVyjuX7fE1WsOnsmkbjmOHJ8Vv+TB+a5GTG7zrFIzIg1eND2ROqWkceU9GJYy10A==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(7416014)(376014)(1800799024)(18002099003)(22082099003)(6133799003)(261009223027099003)(3023799007)(11063799006)(56012099006)(261102123227099003)(10067099003)(261022105027099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022075727099003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0LU+6xQDUwCCymS9RPkb7V3+Ruk1VMVoVj9mabW8Jocfx0LFnzKAAjf2k9fJqOLAgr2Hob+V/eKg7C1qrSVLIIuJJG629mI8bly2Nz6bcqIYv8iQqzNUdpQe4GymWrBqqKS1ygqI4EpvlIQexA6/1ombTQse6CmQn0MiiRlq0tGv4y9uDEVKBmsBjP4NNVoxgK2Asirzv7xAtVda0KInFrOr0onjGoDXsGFv2T32vL1K09mapZ6R2XEo57Jh1Lw3zDinxxaDRmIdmUD45LTJzVSXFyk+BtoCUhxvZ/Jn3Xtbg/w3v5Dq26HE7z/keGwIVSHWR5gqZEqMOnB1SXrZGzZuqJGRqEHjG9huBiIXeRumeAmCXdOfk0eu8uWgdEtDMsHux7RJoqLSrRKNeNdTpq/5LtThaKLNBvZjwPLzufkKHp9pfVHUsf4aMnpjl9OM
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:48:20.7953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7dbdd7b-fc19-4ab6-109c-08df41b6b058
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF0000847D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6439

On stm32mp15, the STM32 detection logic can remain enabled even though
the other hardware resources are disabled during probe in peripheral
mode:
    /* Gadget code manages lowlevel hw on its own */
    if (hsotg->dr_mode == USB_DR_MODE_PERIPHERAL)
        dwc2_lowlevel_hw_disable(hsotg);

When entering system low power, the detection logic resources would then
remain enabled because dwc2_suspend() checks:
    if (!dwc2->ll_hw_enabled)
        return 0;

If the stm32mp15 enters standby, the register contents can be lost and
not restored, leaving dwc2 unusable. This can happen when no gadget
driver has been bound.

Move the STM32 detection logic enable/disable procedures into dedicated
dwc2_stm32_hw_[enable/disable]() routines and call them from the
__dwc2_lowlevel_hw_[enable/disable]() routines.

Factorize the probe code by replacing regulator_enable() and GGPIO
register access with a call to dwc2_stm32_hw_enable(). The earlier
dwc2_lowlevel_hw_enable() call during probe cannot do this because
activate_stm_id_vb_detection is only known after dwc2_init_params() runs
and the usb33d supply is acquired.

Track VBUS/ID detection state in stm32_id_vb_detection_enabled so it
is disabled only after successful enablement.

Fixes: 2b94b054ac49 ("usb: dwc2: fix hang during suspend if set as peripheral")
Fixes: a415083a11cc ("usb: dwc2: add support for STM32MP15 SoCs USB OTG HS and FS")
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v4:
- Track successful STM32 ID/VBUS detection enablement with
  stm32_id_vb_detection_enabled, avoiding an invalid regulator disable
  during probe error cleanup, as reported by Sashiko.

Changes in v3:
- Roll back if regulator_disable() fails in dwc2_stm32_hw_disable(), as
  reported by Sashiko.
- Add a note in response to Sashiko's v2 review.

Changes in v2:
- Fix the probe error path if devm_regulator_get() or
  dwc2_stm32_hw_enable() fails, as reported by Sashiko.
- Describe the hardware-disable error handling in the commit message.

Notes:
- If dwc2_stm32_hw_disable() fails in __dwc2_lowlevel_hw_disable(),
  there is nothing to roll back, so return immediately. Alternatively,
  the error could be ignored to continue disabling other resources.
  Similar behavior already exists for phy shutdown/exit/power_off errors;
  this could be addressed separately.
- In host mode with remote wakeup enabled and a descendant enabled to
  wake the system, phy_off_for_suspend is false. The STM32 power domain
  is not expected to turn off, so registers should not be lost.
---
 drivers/usb/dwc2/core.h     |   2 +
 drivers/usb/dwc2/platform.c | 185 ++++++++++++++++++++++++++------------------
 2 files changed, 112 insertions(+), 75 deletions(-)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index c97c958b19a5..7de080507b5a 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -875,6 +875,7 @@ struct dwc2_hregs_backup {
  * @reset_phy_on_wake:	Quirk saying that we should assert PHY reset on a
  *			remote wakeup.
  * @phy_off_for_suspend: Status of whether we turned the PHY off at suspend.
+ * @stm32_id_vb_detection_enabled: True if STM32 ID/VBUS detection is enabled.
  * @need_phy_for_wake:	Quirk saying that we should keep the PHY on at
  *			suspend if we need USB to wake us up.
  * @frame_number:       Frame number read from the core. For both device
@@ -1076,6 +1077,7 @@ struct dwc2_hsotg {
 	unsigned int reset_phy_on_wake:1;
 	unsigned int need_phy_for_wake:1;
 	unsigned int phy_off_for_suspend:1;
+	bool stm32_id_vb_detection_enabled;
 	u16 frame_number;
 
 	struct phy *phy;
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 968b4ba6d814..7aa8d7c58e75 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -91,6 +91,95 @@ static int dwc2_get_dr_mode(struct dwc2_hsotg *hsotg)
 	return 0;
 }
 
+static void dwc2_stm32_hw_activate_id_vb_detection(struct dwc2_hsotg *hsotg)
+{
+	unsigned long flags;
+	u32 ggpio, gotgctl;
+
+	ggpio = dwc2_readl(hsotg, GGPIO);
+	ggpio |= GGPIO_STM32_OTG_GCCFG_IDEN;
+	ggpio |= GGPIO_STM32_OTG_GCCFG_VBDEN;
+	dwc2_writel(hsotg, ggpio, GGPIO);
+
+	/* ID/VBUS detection startup time */
+	usleep_range(5000, 7000);
+
+	spin_lock_irqsave(&hsotg->lock, flags);
+	/* Remove overrides when resuming from the disable */
+	gotgctl = dwc2_readl(hsotg, GOTGCTL);
+	gotgctl &= ~GOTGCTL_DBNCE_FLTR_BYPASS;
+	gotgctl &= ~(GOTGCTL_BVALOEN | GOTGCTL_AVALOEN |
+		     GOTGCTL_BVALOVAL | GOTGCTL_AVALOVAL);
+	dwc2_writel(hsotg, gotgctl, GOTGCTL);
+	spin_unlock_irqrestore(&hsotg->lock, flags);
+}
+
+static int dwc2_stm32_hw_enable(struct dwc2_hsotg *hsotg)
+{
+	int ret;
+
+	/* params are only known, once dwc2_init_params() has been probed */
+	if (!hsotg->params.activate_stm_id_vb_detection)
+		return 0;
+
+	if (hsotg->stm32_id_vb_detection_enabled)
+		return 0;
+
+	ret = regulator_enable(hsotg->usb33d);
+	if (ret)
+		return ret;
+
+	dwc2_stm32_hw_activate_id_vb_detection(hsotg);
+	hsotg->stm32_id_vb_detection_enabled = true;
+
+	return 0;
+}
+
+static int dwc2_stm32_hw_disable(struct dwc2_hsotg *hsotg)
+{
+	unsigned long flags;
+	u32 ggpio, gotgctl;
+	int ret;
+
+	if (!hsotg->stm32_id_vb_detection_enabled)
+		return 0;
+
+	/*
+	 * Need to force the mode to the current mode to avoid Mode
+	 * Mismatch Interrupt when ID detection will be disabled.
+	 */
+	dwc2_force_mode(hsotg, !dwc2_is_device_mode(hsotg));
+
+	spin_lock_irqsave(&hsotg->lock, flags);
+	gotgctl = dwc2_readl(hsotg, GOTGCTL);
+	/* bypass debounce filter, enable overrides */
+	gotgctl |= GOTGCTL_DBNCE_FLTR_BYPASS;
+	gotgctl |= GOTGCTL_BVALOEN | GOTGCTL_AVALOEN;
+	/* Force A / B session if needed */
+	if (gotgctl & GOTGCTL_ASESVLD)
+		gotgctl |= GOTGCTL_AVALOVAL;
+	if (gotgctl & GOTGCTL_BSESVLD)
+		gotgctl |= GOTGCTL_BVALOVAL;
+	dwc2_writel(hsotg, gotgctl, GOTGCTL);
+	spin_unlock_irqrestore(&hsotg->lock, flags);
+
+	ggpio = dwc2_readl(hsotg, GGPIO);
+	ggpio &= ~GGPIO_STM32_OTG_GCCFG_IDEN;
+	ggpio &= ~GGPIO_STM32_OTG_GCCFG_VBDEN;
+	dwc2_writel(hsotg, ggpio, GGPIO);
+
+	ret = regulator_disable(hsotg->usb33d);
+	if (ret) {
+		dwc2_stm32_hw_activate_id_vb_detection(hsotg);
+		dwc2_force_dr_mode(hsotg);
+		return ret;
+	}
+
+	hsotg->stm32_id_vb_detection_enabled = false;
+
+	return 0;
+}
+
 static int __dwc2_lowlevel_hw_enable(struct dwc2_hsotg *hsotg)
 {
 	struct platform_device *pdev = to_platform_device(hsotg->dev);
@@ -129,8 +218,22 @@ static int __dwc2_lowlevel_hw_enable(struct dwc2_hsotg *hsotg)
 	if (ret)
 		goto err_dis_clk;
 
+	ret = dwc2_stm32_hw_enable(hsotg);
+	if (ret)
+		goto err_dis_phy;
+
 	return 0;
 
+err_dis_phy:
+	if (hsotg->uphy) {
+		usb_phy_shutdown(hsotg->uphy);
+	} else if (hsotg->plat && hsotg->plat->phy_exit) {
+		hsotg->plat->phy_exit(pdev, hsotg->plat->phy_type);
+	} else {
+		phy_power_off(hsotg->phy);
+		phy_exit(hsotg->phy);
+	}
+
 err_dis_clk:
 	if (hsotg->clk)
 		clk_disable_unprepare(hsotg->clk);
@@ -166,6 +269,10 @@ static int __dwc2_lowlevel_hw_disable(struct dwc2_hsotg *hsotg)
 	struct platform_device *pdev = to_platform_device(hsotg->dev);
 	int ret = 0;
 
+	ret = dwc2_stm32_hw_disable(hsotg);
+	if (ret)
+		return ret;
+
 	if (hsotg->uphy) {
 		usb_phy_shutdown(hsotg->uphy);
 	} else if (hsotg->plat && hsotg->plat->phy_exit) {
@@ -346,9 +453,6 @@ static void dwc2_driver_remove(struct platform_device *dev)
 
 	dwc2_drd_exit(hsotg);
 
-	if (hsotg->params.activate_stm_id_vb_detection)
-		regulator_disable(hsotg->usb33d);
-
 	if (hsotg->ll_hw_enabled)
 		dwc2_lowlevel_hw_disable(hsotg);
 }
@@ -542,33 +646,23 @@ static int dwc2_driver_probe(struct platform_device *dev)
 		goto error;
 
 	if (hsotg->params.activate_stm_id_vb_detection) {
-		u32 ggpio;
-
 		hsotg->usb33d = devm_regulator_get(hsotg->dev, "usb33d");
 		if (IS_ERR(hsotg->usb33d)) {
 			retval = PTR_ERR(hsotg->usb33d);
 			dev_err_probe(hsotg->dev, retval, "failed to request usb33d supply\n");
 			goto error;
 		}
-		retval = regulator_enable(hsotg->usb33d);
+		retval = dwc2_stm32_hw_enable(hsotg);
 		if (retval) {
-			dev_err_probe(hsotg->dev, retval, "failed to enable usb33d supply\n");
+			dev_err_probe(hsotg->dev, retval, "dwc2_stm32_hw_enable failed\n");
 			goto error;
 		}
-
-		ggpio = dwc2_readl(hsotg, GGPIO);
-		ggpio |= GGPIO_STM32_OTG_GCCFG_IDEN;
-		ggpio |= GGPIO_STM32_OTG_GCCFG_VBDEN;
-		dwc2_writel(hsotg, ggpio, GGPIO);
-
-		/* ID/VBUS detection startup time */
-		usleep_range(5000, 7000);
 	}
 
 	retval = dwc2_drd_init(hsotg);
 	if (retval) {
 		dev_err_probe(hsotg->dev, retval, "failed to initialize dual-role\n");
-		goto error_init;
+		goto error;
 	}
 
 	if (hsotg->dr_mode != USB_DR_MODE_HOST) {
@@ -638,9 +732,6 @@ static int dwc2_driver_probe(struct platform_device *dev)
 error_drd:
 	dwc2_drd_exit(hsotg);
 
-error_init:
-	if (hsotg->params.activate_stm_id_vb_detection)
-		regulator_disable(hsotg->usb33d);
 error:
 	if (hsotg->ll_hw_enabled)
 		dwc2_lowlevel_hw_disable(hsotg);
@@ -662,37 +753,6 @@ static int __maybe_unused dwc2_suspend(struct device *dev)
 
 	dwc2_drd_suspend(dwc2);
 
-	if (dwc2->params.activate_stm_id_vb_detection) {
-		unsigned long flags;
-		u32 ggpio, gotgctl;
-
-		/*
-		 * Need to force the mode to the current mode to avoid Mode
-		 * Mismatch Interrupt when ID detection will be disabled.
-		 */
-		dwc2_force_mode(dwc2, !is_device_mode);
-
-		spin_lock_irqsave(&dwc2->lock, flags);
-		gotgctl = dwc2_readl(dwc2, GOTGCTL);
-		/* bypass debounce filter, enable overrides */
-		gotgctl |= GOTGCTL_DBNCE_FLTR_BYPASS;
-		gotgctl |= GOTGCTL_BVALOEN | GOTGCTL_AVALOEN;
-		/* Force A / B session if needed */
-		if (gotgctl & GOTGCTL_ASESVLD)
-			gotgctl |= GOTGCTL_AVALOVAL;
-		if (gotgctl & GOTGCTL_BSESVLD)
-			gotgctl |= GOTGCTL_BVALOVAL;
-		dwc2_writel(dwc2, gotgctl, GOTGCTL);
-		spin_unlock_irqrestore(&dwc2->lock, flags);
-
-		ggpio = dwc2_readl(dwc2, GGPIO);
-		ggpio &= ~GGPIO_STM32_OTG_GCCFG_IDEN;
-		ggpio &= ~GGPIO_STM32_OTG_GCCFG_VBDEN;
-		dwc2_writel(dwc2, ggpio, GGPIO);
-
-		regulator_disable(dwc2->usb33d);
-	}
-
 	if (dwc2->ll_hw_enabled &&
 	    (is_device_mode || dwc2_host_can_poweroff_phy(dwc2))) {
 		ret = __dwc2_lowlevel_hw_disable(dwc2);
@@ -718,31 +778,6 @@ static int __maybe_unused dwc2_resume(struct device *dev)
 	}
 	dwc2->phy_off_for_suspend = false;
 
-	if (dwc2->params.activate_stm_id_vb_detection) {
-		unsigned long flags;
-		u32 ggpio, gotgctl;
-
-		ret = regulator_enable(dwc2->usb33d);
-		if (ret)
-			return ret;
-
-		ggpio = dwc2_readl(dwc2, GGPIO);
-		ggpio |= GGPIO_STM32_OTG_GCCFG_IDEN;
-		ggpio |= GGPIO_STM32_OTG_GCCFG_VBDEN;
-		dwc2_writel(dwc2, ggpio, GGPIO);
-
-		/* ID/VBUS detection startup time */
-		usleep_range(5000, 7000);
-
-		spin_lock_irqsave(&dwc2->lock, flags);
-		gotgctl = dwc2_readl(dwc2, GOTGCTL);
-		gotgctl &= ~GOTGCTL_DBNCE_FLTR_BYPASS;
-		gotgctl &= ~(GOTGCTL_BVALOEN | GOTGCTL_AVALOEN |
-			     GOTGCTL_BVALOVAL | GOTGCTL_AVALOVAL);
-		dwc2_writel(dwc2, gotgctl, GOTGCTL);
-		spin_unlock_irqrestore(&dwc2->lock, flags);
-	}
-
 	if (!dwc2->role_sw) {
 		/* Need to restore FORCEDEVMODE/FORCEHOSTMODE */
 		dwc2_force_dr_mode(dwc2);

-- 
2.43.0

