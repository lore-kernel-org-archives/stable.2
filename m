Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.25
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795624375;
	b=TmTlD9K+u5wlxms4Q+FHEyeqPRFEx7/XiBb8lJiySwcEQvDcV/+oNCz4+BFp+e6geE61
	 dE82gjyKNSx+Q5JYHm2RMw4PzYC7ruW8yy+/4M3o0nRnZ03MWcFyrM5pezz+W8e026vjd
	 688o7PLDyWOFsFBlZNpxfP0yDg8DuTnP4PCHRBlwqWCbuRZwRkdJV42DusOf63aFS7n7Y
	 Y3oaN5dg6SOhRLE1SEaQNxZLgPNGPQID4xYeaAsUGpXgRhKZ422fOp0itoTz+YHAEiSYk
	 Ryor/05EkmyMtd8F+uPC/vcQrGuObUHPifMRNUtUJYWmp+KuvYWV49Sxv99EyMTcEow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624375;
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
	bh=KfmUk8QI1AV4ZYL3wSAlG0i2GOI4oVzm2QONpbqQMr0=;
	b=FVWb+bkPaLEa4gNDq/dtigu69qef4ySPKWgNmtxoMnOXTuKGglOsXmkvHYGa8B/iuB0b
	 y3MqsPzuDed3wpxm2nJFKNtCk810MM/O2PV0DHc2DlPXDmDlcjqjG215SvPmEd4mk6tKz
	 znnWmUVj5NN1omrGDrv0Oc0CRNwSkQGJeybImLs6h/L8tCV0EJDW5k1xUB4We0er+7sHE
	 bGI6Vmynt1mYqZ8cuEe17fl69hf7AIKlbyrGgSEenZXLttqHEjO7Vt37VZhUS9U0+gELi
	 tn9eE/tvbLxK3+2+0dfn6PDNWBcQUnA1UUtbxlMQdgwueVLC3CLBK7IClgr/OmpttNg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=XC9i466h;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.25
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010025.outbound.protection.outlook.com [52.101.69.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45607606A33B;
	Wed, 25 Nov 2026 16:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45607606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=XC9i466h
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vti0NvE46x+R2kl7BFAjicQCL/vVCAfadUlJemm0Ed1PI36gdfmVFm/urKMsbfDw90LsO3TnVdHQrqAq9UgI3VIVQfMTGuBIIsnB0mRrLv91mG6pw8bOdK6WSlAmGCpVG6HWc/IeM2Y+vXd1PIM8kPdflr+DcwEVvHZwR0tTLkXj7B/Y3IlXPHEXwfKa/wJSYvJoTSsfTmXaPniGeVHRTIkt2sELaUVz60K46jfJlXUIaoDMALagUGA1F6Dk2FEgCowENIAT/pTFHAYP5kqpOVwDg5CK8hw45LBuLwoAAttMvX6WonWsNF40xJoRsDwNE0/U4lAi6zo2HD0Y6kpZTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfmUk8QI1AV4ZYL3wSAlG0i2GOI4oVzm2QONpbqQMr0=;
 b=e9R0zgiHAfmcC2Np7kYY6cUwC9x1DutjoTGjLy0Av+G/t0KXC38pJKDirX/JVT68pw798Mpd8bfWrvgpUZqJ42t8NdrA+8MUpqL5ksXx2J00XZccBdAX7WP2ffTSSMHbMFutcQvPHw+0zUNIg67ADOA4IM5eJJe57/uDE3ndY2dJ62BHAvinxqDfnQGj6J5t+Qq2TZYEGeRkynd8RggIcYDXX4aG09YbbTgOkcfWiqhEdMS0YzdfBndkw6n+V7XNuaWyLIxy21hd3LMNL3fkv0mJIsM0opXbAy/e/XJyhqPLJZlaeFYlxoeO1goiizv8jzKhxFtHEKQz43Y7stjxew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfmUk8QI1AV4ZYL3wSAlG0i2GOI4oVzm2QONpbqQMr0=;
 b=XC9i466hltJOkUVXb9ZaLZl6XilKhmgvGfnVYKohp2pq8QVQxTvOO4UAzpkEBGdudDR96VsBsMw2qO8vCipYMV6Q8poJxJFJIRYHV4ChwvlSF8WQVzTTtEgwUXpAHL5TWvCbcMehFvOqDxeuW8tpgkusCI1a/Nl2LuiYuhq7wFg1w6EjKAnBwZtmiDaYib8NLC5IPkSr7u8NtkYDpM3jJDs4S0qjWsSlvM4pry/BAyrttisQ7aaQeGRbO+gqS/OwtexIY2Ung0XFV17/ZUSjX3283dU7ePficj2SWHwmZ9/FnQrT3SaFKkmFN/N7DJwb6eQ5+u2R2nPJL1hzxAaY0A==
Received: from DU2PR04CA0349.eurprd04.prod.outlook.com (2603:10a6:10:2b4::6)
 by FRWPR10MB9493.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:1b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 16:32:49 +0000
Received: from DU2PEPF00028D07.eurprd03.prod.outlook.com
 (2603:10a6:10:2b4:cafe::69) by DU2PR04CA0349.outlook.office365.com
 (2603:10a6:10:2b4::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Wed, 25
 Nov 2026 16:32:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF00028D07.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 16:32:48 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 25 Nov
 2026 17:33:54 +0100
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 25 Nov
 2026 17:32:48 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 25 Nov 2026 17:32:08 +0100
Subject: [PATCH v6 07/11] usb: dwc2: hcd: fix possible successive vbus
 supply enables
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
Message-ID: <20261125-dwc2-low-power-fixes-stm32-v6-7-d5df33b93eaf@foss.st.com>
References: <20261125-dwc2-low-power-fixes-stm32-v6-0-d5df33b93eaf@foss.st.com>
In-Reply-To: <20261125-dwc2-low-power-fixes-stm32-v6-0-d5df33b93eaf@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D07:EE_|FRWPR10MB9493:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf3d04c-494a-40a0-8560-08df4b11be5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|7416014|261026121527099003|261022075727099003|261021123027099003|261021121427099003|11063799006|5023799004|56012099006|10067099003|261102123227099003|22082099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fAdj4OK3i6pJowIQh/2OTvb3YHRoGUrTWHTzb7XHSZ50U64Inex4j7HG9WbZU1gwcc083EiK5Hb2qwnOqswLdgC/13sKYgSz8frYJNxkgJgTQicF8ug4ps2I9s91JYZMyTXQUA94iXSKQkFWZBRTr1/nFFxY4pY6PU3fn6xsJh4JqzGzlQe9gCryTNSuQxq6HkjvvoH/YiSKLhpB3Z8dj7jJAfjV3nvjCNzLycG1u1v7x/75WYtNXDPH1Sa1h1z5H+h5kMSLI+7NMy336ve3Wo8vt16UUreb8w5sYlrYxJntzqL6FGqmkUI96zG4wVZEk0ijEzvybVe2RTn8sdDjfMOf4eVYY6GdzbtqigioJ+Y4CDNmmF+pwVMi4GzJENY+Y4qRH/pU9iPbSs3Ed5FeiqMBvWVOhlY2FrhW+6WlJoWK6DnAVR1OaPKJsEJvKWUq87rbn8PrwA28sjITALte1g4EH856G2jiCawaHTsqD1e9rA1sKZ+bSEGFe7CdarYVGBtAHYShhAEtNgSP/q6lZy6Cf6kCpcs62Z+chBSr1i5CEIfPf/8wRs5woZAbASVTDdM+4O17HKcSqBx4k1h8fjC8fcZJmmrYNlIKTxdtLgbgIXvkNwXfbeTdvPjCD+vphy/ShSzn/gsNntsFT1vn12pR/yUYgrzHlMCbzBFWzjZlm1PDqeBJwDRttGPT3w1GWcU1Yd7JMlyciWzNeXoq/w==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(7416014)(261026121527099003)(261022075727099003)(261021123027099003)(261021121427099003)(11063799006)(5023799004)(56012099006)(10067099003)(261102123227099003)(22082099003)(261009223027099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lqVn10CxNHGVy19mNX2iHyxwjeCT8yUbNh5F8j37iX/ynTcYDBKkOJ2Fqkb2Z+DiWesFZ/EurxWK1WCLhnMmKIug5a5kCoqwwrpWgKo3eKXUWeLQxbXgzEl9J0fk0yzGShTQS4olBCu/otMjOxwEWLEEpLtWg9QCjdHVDXQNTwhbna1B6iY0vn/k/d9FYb9aSAxitkdvaXmWKFqj5mcwMJJCVu/aY5zNfwiMisfzNPnE5LwZXq9NkPqnJsvcKX+/RhfraQNS3RXEME4MNDYIrBBiwgNAMxW5cubfqEm5/PKabtsfmYTdbNYqzS+lJ3MB5RB81ZRdHqplvL6ZQ93b0bd/PziC1VVVRQOC6lrOVt9y8E56FCnxbHHUYZobMCCBDVIlxGbjP5Kasr6ebYzZymSTYiAEuwZwnAB/cRbyCbcxngD46rWIQ1PwyvEsZUEC
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:32:48.9057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf3d04c-494a-40a0-8560-08df4b11be5d
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D07.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9493

Relying on HPRT0_PWR value to call dwc2_vbus_supply_init() shows some
corner case resulting in vbus enable count to increase.
As consequence, dwc2_vbus_supply_exit call done when clearing
PWR bit won't disable vbus (for example upon suspend request).

Address two case that has been seen:
- In _dwc2_hcd_start(), external VBUS supply may have already been enabled,
  before entering dwc2_hcd_reinit (e.g. the controller is in host mode,
  without any device plugged).
- Upon resume from low power in case registers have been lost. In clock
  gating mode PM suspend flow doesn't disable vbus while in host mode:
  - dwc2_port_suspend() enters clock gating (it sets lx_state to DWC2_L2)
  - _dwc2_hcd_suspend() nothing more to do as already in L2.
  - _dwc2_hcd_resume() - checks HPRT0_CONNSTS. If it's not set (register
    loss) it sets HPRT0_PWR and call dwc2_vbus_supply_init().

Fix this by adding a boolean flag to balance vbus enable/disable calls
instead of relying on HPRT0_PWR value. Clean the existing checks on pwr
bit. A mutex is added as dwc2_vbus_supply_init/_exit calls can run
concurrently from hub_control and dwc2_conn_id_status_change.

Fixes: cd7cd0e6cedf ("usb: dwc2: fix unbalanced use of external vbus-supply")
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v4:
- drop previous vbus_was_off boolean. Introduce vbus_supply_enabled flag
  instead and vbus_supply_lock.
- remove checks on pwr when possible as now replaced by this flag to keep
  balanced calls.

Changes in v2:
- Add a vbus_was_off boolean to check explicitly an off-on transition
  on port power, to enable vbus supply, instead of relying an XOR check
  that would be symmetric, e.g. wrongly enable it in case it gets switched
  off (1 to 0) as reported by Sashiko.
---
 drivers/usb/dwc2/core.h     |  6 ++++++
 drivers/usb/dwc2/hcd.c      | 45 ++++++++++++++++++++++++---------------------
 drivers/usb/dwc2/platform.c |  1 +
 3 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 89a34956bf22..1bd652c1bb42 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -10,6 +10,7 @@
 
 #include <linux/acpi.h>
 #include <linux/device-id/pci.h>
+#include <linux/mutex.h>
 #include <linux/phy/phy.h>
 #include <linux/regulator/consumer.h>
 #include <linux/usb/gadget.h>
@@ -889,6 +890,9 @@ struct dwc2_hregs_backup {
  *                      removed once all SoCs support usb transceiver.
  * @supplies:           Definition of USB power supplies
  * @vbus_supply:        Regulator supplying vbus.
+ * @vbus_supply_lock:	Protects vbus_supply state and regulator operations.
+ * @vbus_supply_enabled: True if this driver holds an enable reference to
+ *			vbus_supply.
  * @usb33d:		Optional 3.3v regulator used on some stm32 devices to
  *			supply ID and VBUS detection hardware.
  * @lock:		Spinlock that protects all the driver data structures
@@ -1083,6 +1087,8 @@ struct dwc2_hsotg {
 	struct dwc2_hsotg_plat *plat;
 	struct regulator_bulk_data supplies[DWC2_NUM_SUPPLIES];
 	struct regulator *vbus_supply;
+	struct mutex vbus_supply_lock;
+	bool vbus_supply_enabled;
 	struct regulator *usb33d;
 
 	spinlock_t lock;
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 7729581d1102..cfa5d2af60d1 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -140,18 +140,32 @@ static void dwc2_gusbcfg_init(struct dwc2_hsotg *hsotg)
 
 static int dwc2_vbus_supply_init(struct dwc2_hsotg *hsotg)
 {
-	if (hsotg->vbus_supply)
-		return regulator_enable(hsotg->vbus_supply);
+	int ret = 0;
 
-	return 0;
+	scoped_guard(mutex, &hsotg->vbus_supply_lock) {
+		if (hsotg->vbus_supply && !hsotg->vbus_supply_enabled) {
+			ret = regulator_enable(hsotg->vbus_supply);
+			if (!ret)
+				hsotg->vbus_supply_enabled = true;
+		}
+	}
+
+	return ret;
 }
 
 static int dwc2_vbus_supply_exit(struct dwc2_hsotg *hsotg)
 {
-	if (hsotg->vbus_supply)
-		return regulator_disable(hsotg->vbus_supply);
+	int ret = 0;
 
-	return 0;
+	scoped_guard(mutex, &hsotg->vbus_supply_lock) {
+		if (hsotg->vbus_supply && hsotg->vbus_supply_enabled) {
+			ret = regulator_disable(hsotg->vbus_supply);
+			if (!ret)
+				hsotg->vbus_supply_enabled = false;
+		}
+	}
+
+	return ret;
 }
 
 /**
@@ -3488,7 +3502,6 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
 	u32 port_status;
 	u32 speed;
 	u32 pcgctl;
-	u32 pwr;
 
 	switch (typereq) {
 	case ClearHubFeature:
@@ -3533,11 +3546,9 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
 			dev_dbg(hsotg->dev,
 				"ClearPortFeature USB_PORT_FEAT_POWER\n");
 			hprt0 = dwc2_read_hprt0(hsotg);
-			pwr = hprt0 & HPRT0_PWR;
 			hprt0 &= ~HPRT0_PWR;
 			dwc2_writel(hsotg, hprt0, HPRT0);
-			if (pwr)
-				dwc2_vbus_supply_exit(hsotg);
+			dwc2_vbus_supply_exit(hsotg);
 			break;
 
 		case USB_PORT_FEAT_INDICATOR:
@@ -3741,11 +3752,9 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
 			dev_dbg(hsotg->dev,
 				"SetPortFeature - USB_PORT_FEAT_POWER\n");
 			hprt0 = dwc2_read_hprt0(hsotg);
-			pwr = hprt0 & HPRT0_PWR;
 			hprt0 |= HPRT0_PWR;
 			dwc2_writel(hsotg, hprt0, HPRT0);
-			if (!pwr)
-				dwc2_vbus_supply_init(hsotg);
+			dwc2_vbus_supply_init(hsotg);
 			break;
 
 		case USB_PORT_FEAT_RESET:
@@ -3780,7 +3789,6 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
 			dwc2_writel(hsotg, 0, PCGCTL);
 
 			hprt0 = dwc2_read_hprt0(hsotg);
-			pwr = hprt0 & HPRT0_PWR;
 			/* Clear suspend bit if resetting from suspend state */
 			hprt0 &= ~HPRT0_SUSP;
 
@@ -3794,8 +3802,7 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
 				dev_dbg(hsotg->dev,
 					"In host mode, hprt0=%08x\n", hprt0);
 				dwc2_writel(hsotg, hprt0, HPRT0);
-				if (!pwr)
-					dwc2_vbus_supply_init(hsotg);
+				dwc2_vbus_supply_init(hsotg);
 			}
 
 			/* Clear reset bit in 10ms (FS/LS) or 50ms (HS) */
@@ -4397,7 +4404,6 @@ static void _dwc2_hcd_stop(struct usb_hcd *hcd)
 {
 	struct dwc2_hsotg *hsotg = dwc2_hcd_to_hsotg(hcd);
 	unsigned long flags;
-	u32 hprt0;
 
 	/* Turn off all host-specific interrupts */
 	dwc2_disable_host_interrupts(hsotg);
@@ -4406,7 +4412,6 @@ static void _dwc2_hcd_stop(struct usb_hcd *hcd)
 	synchronize_irq(hcd->irq);
 
 	spin_lock_irqsave(&hsotg->lock, flags);
-	hprt0 = dwc2_read_hprt0(hsotg);
 	/* Ensure hcd is disconnected */
 	dwc2_hcd_disconnect(hsotg, true);
 	dwc2_hcd_stop(hsotg);
@@ -4415,9 +4420,7 @@ static void _dwc2_hcd_stop(struct usb_hcd *hcd)
 	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
 	spin_unlock_irqrestore(&hsotg->lock, flags);
 
-	/* keep balanced supply init/exit by checking HPRT0_PWR */
-	if (hprt0 & HPRT0_PWR)
-		dwc2_vbus_supply_exit(hsotg);
+	dwc2_vbus_supply_exit(hsotg);
 
 	usleep_range(1000, 3000);
 }
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index d89a30308f86..24ede0b6ab81 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -471,6 +471,7 @@ static int dwc2_driver_probe(struct platform_device *dev)
 		return retval;
 
 	spin_lock_init(&hsotg->lock);
+	mutex_init(&hsotg->vbus_supply_lock);
 
 	hsotg->vbus_supply = devm_regulator_get_optional(hsotg->dev, "vbus");
 	if (IS_ERR(hsotg->vbus_supply)) {

-- 
2.43.0

