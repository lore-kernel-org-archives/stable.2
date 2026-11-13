Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794595704;
	b=D37/X9mlyk8tSuBSU35iTae77P0eY4npyOggqYpYO6LZD7MDs+GXLsTXFnA5UfNDOeCa
	 X9MHCbqEVuIV62CYaaq6nhrX3bXvdoIz8x15MlmqSUrxZX+Qbetg2kXJ6+Hsgo8lA6Fw3
	 1yIjp0niOAAtg6mD8NafFRPAbpXYW2ubfJPd8JdTblR09LnEVDh9r3zsNtiK66s0+3Ux5
	 QE7ADNeUPgUN7zvOigZr2n5buu8o/qASGXLanR67mb6kn/lb1Ysi4xoB6egsYboMGZmc7
	 Y6uC2zjLiO+ID6aW0kpC3cbxWH7mHPNEJgIugGgq4uz/SxTP9nZKQt/GYBikqRcgmCQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794595704;
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
	bh=+Ku1pcbuqzShJ6+nxWOJ/sWulK2ut5jTJ1zP1rhjDtg=;
	b=kRXTADGIca4a4tqvN3kqPmZ6gi/8Jktli0EBQRRdy7nX/bjvrvhabu8ca9sUzdKe6eWS
	 KxFBWZMQkHbB2O0X0+EIGQIf/0aQwx8wYEKuDaBJIh+594NsMacpHd20YBqyH8ec7nqXV
	 EXP9hR7EvoNyR5Gs+p0gUlVdsJ/bsgDBBqsb+W+MFWCjEiEne2eOjX4Lz/COGruQYIooG
	 EEUydjvLKhuXGUxBYSX9T0gSEdeiAS4NhmU179tPyRMgPLC2PXiM7IEJl4R1uJ4OnJ7yf
	 PQjojbdO4oHUmSRX9W7hRhrVJYu0M4MkbSyDY0Qq6AHd7aDazCK28YJ8p/WmILvbgng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=ETcukmun;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.46
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011046.outbound.protection.outlook.com [40.107.130.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55CA606A8A2;
	Fri, 13 Nov 2026 18:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A55CA606A8A2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=ETcukmun
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e9ewx8AcTW8/0EkzmR+DKw0PsnGOLNASJNFareSDH7NdNPtK7OqCluxagDEX+aH3C53offgc+Ce8fIlY9UfdH5U3GQ4OZS4fi7sgBA5mt0NT1r5iky6ZsmjU/GsawvAeMK82+qhY4UXnphzkHnCPjG4cn1K9g6q4G5MMepXnshYkaQMOFKxuRpZcIs0eKAAxgptu74Le3swJHiqXV/ZOrLw///JZ/QVDSld4EwzIh1cy8gz9vQGE/fBxjAUsyc5ywRZTF6PE+aYGPVlWgRfoxYyzX8DoVOnMKDLiMJzQCrXq6W0bisSBh7+fWiS3qVV7zEND6wnzmhcv2E50+FpBkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Ku1pcbuqzShJ6+nxWOJ/sWulK2ut5jTJ1zP1rhjDtg=;
 b=HFJrK7SK6WPPOX9otv7xIExk0MmzqTynBEAmwYIB+oUHADdJ+MBqySTzJv8y6ZsaySgwA/J2AbtQYM69qgWUo1xhDTocAy336WeeUg77Z0MywODopCf5u9kWYQRpA0O7ltdpTGyglMouxm17z0DJqa/XdMpmUPuxr9m0a9jewilhfPTwgtFsrf6yh0sphvSs6bMTStVygbR8O0Fl9s+ZiUHfwBYGV8emg+vrVqlCGRygeyayyHukD1GEgM3QEAD1bxKNLaV+CVPXve/XiiADNGS39bymohF8zzbCUvAuVw200E9Vyu9gna+avyof5QiNuHFtFeqIJZvGxE1oQYcjzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=synopsys.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Ku1pcbuqzShJ6+nxWOJ/sWulK2ut5jTJ1zP1rhjDtg=;
 b=ETcukmun2c97Bpvgh2M6qwnGus9uJGzC4hp+GCxyWak0PpjyqYzUST1Wa7TRDVZiW8i0AuSw3OlhoSddDqOtJkWE/ysNG657jkLyXApTdPtagzPPSX7Pfdb4hQ5mCw+ibWxriYOG0x/PT+BSe7PA0cxjiudV68DVnjpbk7MYLFsMyA77NMWIKFyLAq/iMKUSHxAtPXlxYX3BLXEuzZ56iZM/TSA11fTiht91XtEZ3NX/9CosGHDVX6SMYSnS+vXtQ+TEfWFbSVcjZqY+btdFqGPSrCBAZ/GkOKgDk5F313JyaHDd2TZiVr+brgkCulik7Myn06uOjzy/EkbhcmxHqQ==
Received: from VI5PEPF00000982.AUTP296.PROD.OUTLOOK.COM (2603:10a6:808:1::814)
 by AS2PR10MB7107.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5e8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Fri, 13 Nov
 2026 18:48:19 +0000
Received: from MI3PEPF00008483.eurprd02.prod.outlook.com (2603:10a6:298:1::6a)
 by VI5PEPF00000982.outlook.office365.com (2603:10a6:808:1::814) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.615.10 via Frontend Transport; Fri, 13 Nov 2026 18:48:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF00008483.mail.protection.outlook.com (10.167.240.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 18:48:19 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 13 Nov
 2026 19:49:17 +0100
Received: from localhost (10.252.31.200) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 13 Nov
 2026 19:48:18 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Fri, 13 Nov 2026 19:48:01 +0100
Subject: [PATCH v4 4/6] usb: dwc2: hcd: fix possible successive vbus supply
 enables
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
Message-ID: <20261113-dwc2-low-power-fixes-stm32-v4-4-08a8c962a09e@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: MI3PEPF00008483:EE_|AS2PR10MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: f483a597-28fb-4a0b-60cb-08df41b6af48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|376014|7416014|82310400026|261021121427099003|261021123027099003|261026121527099003|11063799006|56012099006|261102123227099003|261022075727099003|5023799004|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	LgdBJk5H1b+P2gIPd00nGYythyJnlmoTXtahi0e2XW+fdIAd6PvqEjNEFu7CQXD+ahDiBCEJwyLpOexE8ful5cnBaOQaUS8g53opSytsHpAtLmCmi4QNGfJjzihu8/noyCsF44XbuJaOOWC5ZT0/NyjYXyXJCjTlBjkbgxQT3xMmWh55Ny+BfmIIXec6c3APTl8ySzgLWpS8FeDb2ppRCNL6MC/63QYD09tr26a/F+EUNgnHcsu7C81MiqP4ue7vDnpMG5GOjrsOLFADMVJSC+pYwcg+bE+SQK6/duQxL+t8SY0wyPc4J1wXNTG3fDFt6k5/7UJp0hSQKjZ1xQQzPuocJHUoYqtZsWtuTt0UYSBcTZkQ8iCs0+YxHi1DPDJZmepYLmtvCsWmFp7Uck94vkLU/bOsG/VJ9i0zH/roRPjRTaGhtgVF0weY/Bo2flCOtyEnRH98PlEEM4bnKkJkA5x9VSlfyDZT4IqcQXyhLZ7qcRKoiyFmYSIY5do1FtNOTQfRZfTsPRhKMZsz1NH25TmPKj3R/Mh6gWEn5ogvBOeCbqjYJChYXjE/c/RyAHSKEMzXiehWAHGE0QTmfBlWwU7zK+y7CzQYk18ahI6MW8SlcbuF6rEkP6YTQCQmexGI/GNxP7961+aU1KyExx74K2r8nyIsPhGa9xMOlrUu1u2/To6y9D/6TtfYBU4sdSNc3sgUMFQsaRVVAeiJUjH0dQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(7416014)(82310400026)(261021121427099003)(261021123027099003)(261026121527099003)(11063799006)(56012099006)(261102123227099003)(261022075727099003)(5023799004)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ME9bXKDh8vrwS9bR99PFxWQpv+tXx3V2NS+FO62ZmvNQW1AniuC/3Fpw++bx0kK8zes18354d9xblFMK7ku0UdxXn1ZCNuA3SODyFZrdmlwevA/Zt9/5yvyH977k3He4J4JJv08QU5cQF9fyyk986hYTpaPMw8DKuWVgAsNe5Dc+kDvsNM4Im/FoXqMkwkiAezMr/jYc07tKP8uZ6F2nGra7ATRk0ZoKvk2TWjk2SkLZsJD0haBr8jfAEI4Q3kSsIFIpafJwwsxSl0Go350Zy8ZGNaWypdiqfNisuG5z9SNxiJ7nWRhozKFBW85JZdM1RRYegZca7+jMgPotNtVNlHww/JtvxFwpdyASsP/haHeW5bMYtH/F1H7tcfS6P+9HkvHnfs4fr1fbEaFMyNe7CHYx1eztnJa1LPTPpcdEwv4EBELne8M2jvRLXwZQeJe/
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:48:19.0071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f483a597-28fb-4a0b-60cb-08df41b6af48
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008483.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7107

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
index 32662cb3d3eb..c97c958b19a5 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -10,6 +10,7 @@
 
 #include <linux/acpi.h>
 #include <linux/device-id/pci.h>
+#include <linux/mutex.h>
 #include <linux/phy/phy.h>
 #include <linux/regulator/consumer.h>
 #include <linux/usb/gadget.h>
@@ -886,6 +887,9 @@ struct dwc2_hregs_backup {
  *                      removed once all SoCs support usb transceiver.
  * @supplies:           Definition of USB power supplies
  * @vbus_supply:        Regulator supplying vbus.
+ * @vbus_supply_lock:	Protects vbus_supply state and regulator operations.
+ * @vbus_supply_enabled: True if this driver holds an enable reference to
+ *			vbus_supply.
  * @usb33d:		Optional 3.3v regulator used on some stm32 devices to
  *			supply ID and VBUS detection hardware.
  * @lock:		Spinlock that protects all the driver data structures
@@ -1079,6 +1083,8 @@ struct dwc2_hsotg {
 	struct dwc2_hsotg_plat *plat;
 	struct regulator_bulk_data supplies[DWC2_NUM_SUPPLIES];
 	struct regulator *vbus_supply;
+	struct mutex vbus_supply_lock;
+	bool vbus_supply_enabled;
 	struct regulator *usb33d;
 
 	spinlock_t lock;
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 7e4202c145f2..053d1234884b 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -133,18 +133,32 @@ static void dwc2_gusbcfg_init(struct dwc2_hsotg *hsotg)
 
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
@@ -3435,7 +3449,6 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
 	u32 port_status;
 	u32 speed;
 	u32 pcgctl;
-	u32 pwr;
 
 	switch (typereq) {
 	case ClearHubFeature:
@@ -3480,11 +3493,9 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
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
@@ -3688,11 +3699,9 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
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
@@ -3727,7 +3736,6 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
 			dwc2_writel(hsotg, 0, PCGCTL);
 
 			hprt0 = dwc2_read_hprt0(hsotg);
-			pwr = hprt0 & HPRT0_PWR;
 			/* Clear suspend bit if resetting from suspend state */
 			hprt0 &= ~HPRT0_SUSP;
 
@@ -3741,8 +3749,7 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
 				dev_dbg(hsotg->dev,
 					"In host mode, hprt0=%08x\n", hprt0);
 				dwc2_writel(hsotg, hprt0, HPRT0);
-				if (!pwr)
-					dwc2_vbus_supply_init(hsotg);
+				dwc2_vbus_supply_init(hsotg);
 			}
 
 			/* Clear reset bit in 10ms (FS/LS) or 50ms (HS) */
@@ -4344,7 +4351,6 @@ static void _dwc2_hcd_stop(struct usb_hcd *hcd)
 {
 	struct dwc2_hsotg *hsotg = dwc2_hcd_to_hsotg(hcd);
 	unsigned long flags;
-	u32 hprt0;
 
 	/* Turn off all host-specific interrupts */
 	dwc2_disable_host_interrupts(hsotg);
@@ -4353,7 +4359,6 @@ static void _dwc2_hcd_stop(struct usb_hcd *hcd)
 	synchronize_irq(hcd->irq);
 
 	spin_lock_irqsave(&hsotg->lock, flags);
-	hprt0 = dwc2_read_hprt0(hsotg);
 	/* Ensure hcd is disconnected */
 	dwc2_hcd_disconnect(hsotg, true);
 	dwc2_hcd_stop(hsotg);
@@ -4362,9 +4367,7 @@ static void _dwc2_hcd_stop(struct usb_hcd *hcd)
 	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
 	spin_unlock_irqrestore(&hsotg->lock, flags);
 
-	/* keep balanced supply init/exit by checking HPRT0_PWR */
-	if (hprt0 & HPRT0_PWR)
-		dwc2_vbus_supply_exit(hsotg);
+	dwc2_vbus_supply_exit(hsotg);
 
 	usleep_range(1000, 3000);
 }
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 72214593f431..968b4ba6d814 100644
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

