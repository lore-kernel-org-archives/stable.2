Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794935196;
	b=CUzATTIe9GGkNdTGws8fwGJLOJyt3jrPH3bZwPEYm5z7cW5clobFTsAIfQG3IuQ2w2bp
	 vir8J0LvEPRyMt1atjCi+sa+U2HBMbarfwOms9P1nhSxZkQns3U5zCjmamGCI8ZlK9cLP
	 ZojggzT+nNNe/b5DrlPKY2Gea9vtTa6dNbq1dxUECreQyoqJgUVqYiH2UdvO9A+MgnqO7
	 zEUjGozQYsp7X79WgbkUKoolPqxe0cpSzOTpWNonuoFHccdaPq8Dyhka4ElZNFF02msax
	 4czO6LDpgcSnflAXp7zbUSKAXl8njU+ShSrz8XCmuYrytfSwIpu7QRP5RCHDi/S1DVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794935196;
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
	bh=jepB2Ie1ntY4gqpTgoJ20hXwXTUbAaHII0qt2raLjFM=;
	b=NocWwfwceqwRRB5NrRzhHY7xC756Y9aWnO4c1MnVnUhwJjyI/Wkz+an9Qa1qU9wFZN60
	 /z/GulQ86z+kTqSsjxtFNzT6lF7qVqQSL3QKTt+P9xjskzhpf/QrCA1Ov6yLg6FGdRDvN
	 1/jdjkMLqhNrdBP9P+bXszsKEXu4lSPyHH6ksYcaKSyzUgwBHV6YjYQU1qe2kzgl23ix6
	 0nDC1FKzgyhuq2MS+cQTQK3toDOQ24XfDoiDsS3/1C3pzdBvQIbH2KAiTUnJ17elhpWTt
	 65UuoIp9wvukIxEIm4Rg+bCk1gz+B/JUbpxjJHWqz90SHEhf2UPobfijVSW9W0nNorg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=XX036xNc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.35
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013035.outbound.protection.outlook.com [52.101.83.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8186606A897;
	Tue, 17 Nov 2026 17:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8186606A897
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=XX036xNc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZMy6rjBlAFVKUA6neg8Y5osfivNg2jojPpz+u6qBw4g4qAfzMgocsRoDWVIXB75mc2Kb891/try9m3Y9PVukWdtcoNLKQZxlX7XGOwicQVnQUjcyh4UikPB6YEDaFQLmINUZNOVRRCyf19tGJQ3eY2ip4uy4hfsJGEkkelo6JrsvewmzGwWVC5OBIorRgJpqCwgXWL6mwFiUp3hWiwtJMqHKR2IKQDem4IFZ9rc7aPFNr8POvQVkhSAP3Yy2D194qctf2uoHpV4Pvcs4LGR3YtbI28A8+eSpqWjEBZPoe+bBz6M7tljRo8KmZy58v4329CT99K5jMFg/wWtruABFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jepB2Ie1ntY4gqpTgoJ20hXwXTUbAaHII0qt2raLjFM=;
 b=fPyt+kQM9wGRa/fTg6sd83y0/500SiMz+EnNsnmqc8LXKsXtWG4VKN3pQCmqnaoG6iqx+80M3NxOtot0S3PCmFnfqwCCRcYhZmsAxK7jPlJNIOGgzyOU9s7m7V7qqAs6aHNqMjj4eZ742bDkizdopFFN6HD/P3H6eduEir01XcaJ/XNCbhexzfxA8/KY6LysLSvkhjoSSLf9O+nmYyIgnShJcVnrSNepnk+/PILf05E4D8ronY1td0FbIMPv+mWzkz6PJFyAjYeBbC4NKtUJPsqbQUm1FxIqLIwvDHoCZZ1urkt1N3pdmcMRWI/jslZRbhEbDNvBeTpWWcUiKuPMTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jepB2Ie1ntY4gqpTgoJ20hXwXTUbAaHII0qt2raLjFM=;
 b=XX036xNcfQUSSg/aca0HtMVVZBM3XlDgmupgK6urHvpJ023ObxuWJIPkjxEEZ7lYDSRRb2a/B4g8OhF0EGiU+lQex8cVPznusmmMFLv78hudOlhdxX8+EkIjACfNKH80SkSnidAeUF7ZGmNwOh0E4oAzcixa1ZzIii7JRHSd08avfmz6Rao1MunbUEcJUginQLCaqkOOBOsRray5bJnlW7vPirXK383Uw1eJqRU5GqW0MfWkL1APv5Jv/CV+Qw+cHYfB4F5Bs8TDtDCex6OQ9giiI2wk4hNJhe8P7wClxqhR9MS6ihFai+3i4uqEcqujAAwv8NX1mZmrmguHPESFHA==
Received: from PAZP264CA0039.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fc::21)
 by AS8PR10MB6152.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.6; Tue, 17 Nov
 2026 17:06:25 +0000
Received: from ZR1PEPF0000E462.eurprd04.prod.outlook.com
 (2603:10a6:102:1fc:cafe::38) by PAZP264CA0039.outlook.office365.com
 (2603:10a6:102:1fc::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 17:06:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 ZR1PEPF0000E462.mail.protection.outlook.com (10.167.241.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:06:24 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 18:07:07 +0100
Received: from localhost (10.252.22.224) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 17 Nov
 2026 18:06:22 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Tue, 17 Nov 2026 18:06:08 +0100
Subject: [PATCH v5 4/7] usb: dwc2: hcd: fix possible successive vbus supply
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
Message-ID: <20261117-dwc2-low-power-fixes-stm32-v5-4-0f197e0e6362@foss.st.com>
References: <20261117-dwc2-low-power-fixes-stm32-v5-0-0f197e0e6362@foss.st.com>
In-Reply-To: <20261117-dwc2-low-power-fixes-stm32-v5-0-0f197e0e6362@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E462:EE_|AS8PR10MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 334c2f00-60aa-4fca-6ce2-08df44cd1ca4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|82310400026|36860700016|10067099003|5023799004|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261022075727099003|261026121527099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	s4eeuha1CSUQfVgLss82DNGEYFfq5WyxUKukoVBN/othOczh+pL3HKRIb/1T61H/+zUozuyrhMbS7qqPyQdfZZYmMzuX9vh6qrX44Gh9LdUdihvbHv/DW14wI0gNb/RLkmQa5asbFnf85HX/q6D4r8jpL7CH2etaa7pBdvmEsw1NaAsj1M0B3QgyQhSDrEP8ud8NbiwkDjvHTUoSBYUXuZ2UV0zLGMy3lQPLp/RiGI1A76RWF80iX5oofwhoqszJi2zSZrrXQphw9bvib92MuxxZsWIN4e4pR5rfUU5CHvCC7WaVct4hKc5QDcQ1XbvNMKcoIeGQoKXqrlOnKwYE0LAsaugZUMHtQfrDwUWZMymuj1XqewAQSAWuIcwRDWzs+RPp03liifaZPEKpQqLCLMuKlVwSkNP61nqBEO4i3G2H07/X6Qp5YmjTgKdBW51UWRL+blj8eZKjVAogMCLnSf3b/gp7hbhHLfCjgBK3HO9puyfeNF8Waj/dOVhC4k5a2t6H0ABL29EbfqqMh7Me4CyU5SP7jTdlVU6+92SDEiCS0jKq6cwd0dYZ2kflfajKPfEedyXv5VHegNStUThNzRQJgMzYSG/6PxnjaP9931WdqtIkppq02j2gcjOWfcCnAAOnO4XgwxHwAoQlJrGNPFwGy5AaPvZWW5FCC+bvxOUK3V35MXN8XuyWQmDEU6S0p+tw2Qvnoy7KUNByZxOZfw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(82310400026)(36860700016)(10067099003)(5023799004)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261022075727099003)(261026121527099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zwa+hugCCtXCBKqQHC7tqc3Ufjhr2NnnyV1kbp00Yu0oiDYG5iBaYDaakUOIBloVV0CgU6KczUfTqJMevEJnNlYFtbtYyIsovQ+4yCPxNUdFDmSRtmMjgEY7rlWjpEpffW9mWF0UeKHyym2EJl5oP42fWhWThdjFMnQs9WRpUvYJafEQx2NEi1Q5GtcEPdA0pqqVgCsFyy3+i7/noBJC1U556JVHPBpIHVU+KXS/yc3NaxVVZRHfccLgVYwIw4puL/5gxO67Td0RVpKx/tSJpz0rRbvcJsU0Qezntt9a8l4DGzRY7dQ57VEtujmfrUtnGttt/iMnIifMUibD+efN6kfsKszaDq0eGBTAeaDVBNCu+QX+vPaYkvucXAo8zekV1rjjAbk88u+TyJSjNp5/wgQwJv+bKroGGbzptmShZcE9XSj3rmPDOhhvhXdbSkGr
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:06:24.9054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 334c2f00-60aa-4fca-6ce2-08df44cd1ca4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E462.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6152

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
index 7dec3842ba2c..3bdb88902811 100644
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

