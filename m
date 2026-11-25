Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.26
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795624376;
	b=k8j6zsz9QQr0Yc0GE8PZzPNtuJT9Nb8qSdJtc7gJKYRzUgZMiWxDUl0GRRTYBCQPd7za
	 4s3Ic3XGsFrWFpiSkzzBlFfPEn6ohkYwEbhk3mlaORC/gbw5T2ZHZwffAg8fwY9I0y2cO
	 l7JKki36ekJjYbuOIYUlhYsiWUBkM83QxcSyGFHCGbPOLdJVwCpjtW9f9humbuqNC3tAe
	 qAqYXINf49FSgm6C13/CrIeF8l8NtU+OBxnwVJDbrZDerhIePqnMTuUSETDMcIVtnvMwN
	 oGH4bXd75JlMkjpkeDFScZG2j2Q6LqqDo/lqylzoLKtCTbO23ZGjQ1QwxKeksZphtpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624376;
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
	bh=cX4ieytK3JB714PlJhzyua0FX/8x869vyx/gj+u/EaU=;
	b=oWZ4thtwPBpWxxBXF/Ite7Eh12JUiqX/tVV8h58dDy7z9FbLQu3ryNQDVI/k5qmKh31K
	 hCH8prVbaRoLNqzbGl7QTHf9evZI/2yum6EJauPNUh8uE1Xj0L6bknErXgdgokfM1ttWx
	 /IqcTO0eYmpia5fiMP62SM51vLtlv05kEAOWZOmKGJPg4//lC4q5WP67bTbryEoAB3aLe
	 ipMgMqOKtYFomJNVO4u2GUbc+HRD7KLaPADdVGxxgE5NBl2ZUktbfBA7pfehjowCSglCb
	 DrPdUKBoeZF/H5Y/SBNJUON/0nl8IWUsN3nVQfsnBjroCyyeSSfT1m/bem59MqUgRlw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=W7EHDPdd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.26
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010026.outbound.protection.outlook.com [52.101.69.26])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E76E606A696;
	Wed, 25 Nov 2026 16:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E76E606A696
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=W7EHDPdd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0JpyeKnZ9eVXyimQpsAdy6q0QhaZrgqGbDumXDOR2IDuapGGvwRYJupll+zNS2r6pW432F2TDWESw1M8HebNyye4w0oHb7AvKAeBtccQae9L0iAtD19/PO2wSAeNBDyWoON0qGL4qnlFddKPYS/gKqd81iZGkECrzao2PZy14+gBoELIOw410ELdwCxC6z4teQyHNohWDYWx0HUuMgh6VElXwxaYcnUTjrE8bVOtQF05sqS5jBHturwXCjerwWoOfmnnWRKBtH/KskQ8O5ZRUFYk5Q7c0iOIEaqgYUk0ChfGmIAk3LbrgFFpcZB/JdDqXUOkHpvq8TYSqDO+SuV2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cX4ieytK3JB714PlJhzyua0FX/8x869vyx/gj+u/EaU=;
 b=A1g+oUEI2pVGq5nxXglmnUSZBlZ1HkxWTqQR39ov1yJHcIMDQ5pw3zeFlUhRNCuKOT556Jg1ZIaJRj+PgN3ateRDVuYNI1l/PhCZBe8AUTjxo5pub8RNRXx1BeP+FcThIb8kf9bpXNEQSS0c+xbENx4rpwpBuhOn4eNHtjiDYeoGCeki5rCuvaTVO+KJ3BjlXNTuYd7P4R8Pk9Rx/toKRYhOaC1tq0c+HyZZ0l9LWbNmDjedD0WK2x7PfveWfXhqWXKng+w2BVuMfaHIl/wQyhKiAr3oaWPEx2MuuaUYm3FJ7zGhjfFqenW4zoVrnA28dYzy/yJNvMuQTVVujsO4RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cX4ieytK3JB714PlJhzyua0FX/8x869vyx/gj+u/EaU=;
 b=W7EHDPdd2LNF3/Th/lh5Lz1c10+ZtJQB4+4hjOLrv5mEgseAVq1s/eG+TNrzkv3waZTQNLNcoTG2T/q8eW47f4whvOd5MUIgDVsZH9R5hdeoVV6re6c4LqYupgyhJcvCGG/qtaIP2ugStcpJkdhrIlA8Z5kUddV7usALyjet1M2fHtRSlzBWIXjICkLgv2ffbzpSeOfioH3lmoALj92PZcOBDTtZmHZMks+omcuhKZamnQ1dLDEHryRHMT1YqRBrU66NxLarqAXNRYN/BNJxLo30SYJ3aQecUIMTbLvfPUAqklLlVwyXdiB0aLbFkqh2LS5LsA+A6qAlYA6SI2N3nw==
Received: from DUZPR01CA0318.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::7) by VI0PR10MB9467.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:2ce::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Wed, 25 Nov
 2026 16:32:46 +0000
Received: from DU2PEPF00028D04.eurprd03.prod.outlook.com
 (2603:10a6:10:4ba:cafe::88) by DUZPR01CA0318.outlook.office365.com
 (2603:10a6:10:4ba::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 16:32:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF00028D04.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Wed, 25 Nov 2026 16:32:46 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 25 Nov
 2026 17:33:51 +0100
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 25 Nov
 2026 17:32:45 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 25 Nov 2026 17:32:04 +0100
Subject: [PATCH v6 03/11] usb: dwc2: drop stale state after register
 restore on resume
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
Message-ID: <20261125-dwc2-low-power-fixes-stm32-v6-3-d5df33b93eaf@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D04:EE_|VI0PR10MB9467:EE_
X-MS-Office365-Filtering-Correlation-Id: e423150b-5674-4eb1-5502-08df4b11bd06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700016|1800799024|23010399003|82310400026|10067099003|56012099006|11063799006|261021121427099003|261022105027099003|261026121527099003|261021123027099003|261026140227099003|261028144727099003|261022075727099003|261102123227099003|261009223027099003|18002099003|22082099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	9SMY5mNwxEqrQWTUN68DpXaaIXHHpAFUmBRGb8J3FPWsYRwHUe/Ghum3J99rVzhg6bb9pnVYag984765PAsFwYLyGcSaF3MNqJuvOPHy3gasgV+/RuaPrpirNQlZyDH8dvy1bQOOJW2jIMuq8DeLcLXLS2u5yUmGwLr+Z/uL3uLo6uThF5S9uRIcAYJGDrkyJJnTKUioY4Izb9mupXrNLbieFLfDwQO78aT79BeMn3pnrIYVT3moRE14XwHrFfkyWKXfI8pdHN/TyGwRDsxRsYl2XUB1W3GPaQ25QSKv1R2TUZClGxoB+0apeblbopD8jfJvTimqyRnmi2jp4oHj8BNLUSdxH08SjtatxHxrDyzSDFxb/J9ieOcLgC50hMforTtpqudMiXGsDVFc0I7fftgTcAElB6TGEwtDLbjxVM2mFikJt5MRfXTXctsPcQUR6Ng4Tea1Cz+CXsQCCwiO3JRw5bnUk01Z00JHg6s7qDsfIXQFa4SxNMCOSqvQZ+P9akS4WDLm7SwtuFuTFyWAqrwv7KQY4f5YBZ5/sKP7aqsgK9d6TIOhR3nJaaqX3Ap6PB1sMoh9bzFrm/792n50kjxKEkz4i6WdyK5jM2XgFcl/LATxsSLmy91cNOSZGtZTlwDsrI508D1CQDBFsbjOP4XB3fJ1X7L7Vxx/f1q7rxs=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(261021121427099003)(261022105027099003)(261026121527099003)(261021123027099003)(261026140227099003)(261028144727099003)(261022075727099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4MFCiiKlwJTqvds3/cPYifngoOEZOVtV5tWEjODEJ63ut4i/ZNd9iGCKtY1NhgDRFwtuo9fIG+ChCiOkdUvtfVILbsdXYJmTOToz/W4x1kBHg/Lf3HjSecvL7J1ts7Rv1Ptjq9cKkks8TG4Og9n0lHhetS23zTVRR1kIwLWUrK1eK8DFmNbsjzvWrdRK9wWd0W2YQ4DxKZcDYOGb42QoVRTeePIEcoAS+yjzgiBIsnfjtqWd6GhtVCixzzJ1DLgWrC7sKim9lS8wBvdiVd3NPUz7AoZwlUaWmNJ7cFxriuNSIrboMcbyv+qUvxP1ARBvfTT9ICNB+nsomvyD+Sc7nqJjd5DdfrlzKXawdd4iZcaTUPaV+TRR+xhnSstv0sH4BmsKaQKUtZt73Upwwcw/Xn8cLymUr/zlGqeJUI+0dUvCruun5E3XhOlHdkVnbyJo
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:32:46.6524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e423150b-5674-4eb1-5502-08df4b11bd06
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D04.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9467

After a power domain loss, dwc2_resume() restores the registers that were
backed up when entering a low power mode (clock gating, partial power
down), or in dwc2_suspend() when no backup exists yet. The restore only
brings the hardware back to the state it had when the backup was taken.
The software state is still the one of the suspended controller, and events
that occurred while the power domain was off have been missed:

- lx_state is DWC2_L2 and bus_suspended is set, so dwc2_hsotg_resume()
  returns early and _dwc2_hcd_resume() tries to resume the port, even
  though the controller has been fully restored.
- in_ppd, hibernated and the backup valid flags may be left over.
- In device mode, the gadget speed and the enabled endpoints are stale,
  although the host most likely saw a disconnect while the platform was
  unpowered.
- In host mode, a connect or disconnect that happened during suspend is not
  reported, as GINTSTS is cleared by the restore.

Add dwc2_clear_lost_state() to reset the common software state, and use it
after a register loss is detected (GUSBCFG.TOUTCAL cleared):

- device mode: dwc2_hsotg_resume() gets a "lost" parameter. When set, it
  disconnects the gadget, disables the non-EP0 endpoints, sets the speed to
  unknown and clears the stale state, then reinitializes the core and
  reconnects as for a regular resume.
- host mode: dwc2_hcd_lost_state() clears the stale state and flags a
  connect and suspend status change, so the hub re-evaluates the port.

Global interrupts are disabled by the restore under the lock, and only
re-enabled once this cleanup is done, so an interrupt cannot run on stale
state in between.

Fixes: ba6e518d136b ("usb: dwc2: Implement recovery after PM domain off")
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/all/sashiko-outbox-202003@kernel.org/
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v6:
- patch split from "usb: dwc2: fix recovery after PM domain off" to ease
  the review
---
 drivers/usb/dwc2/core.c     | 17 +++++++++++++++++
 drivers/usb/dwc2/core.h     |  8 ++++++--
 drivers/usb/dwc2/gadget.c   | 24 +++++++++++++++++++-----
 drivers/usb/dwc2/hcd.c      | 20 ++++++++++++++++++++
 drivers/usb/dwc2/platform.c | 18 ++++++++++++++++--
 5 files changed, 78 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/dwc2/core.c b/drivers/usb/dwc2/core.c
index 6a0135e06b00..5da76f0fbcf6 100644
--- a/drivers/usb/dwc2/core.c
+++ b/drivers/usb/dwc2/core.c
@@ -600,6 +600,23 @@ void dwc2_force_dr_mode(struct dwc2_hsotg *hsotg)
 	}
 }
 
+/**
+ * dwc2_clear_lost_state() - Clear software state made stale by register loss
+ * @hsotg: Programming view of DWC_otg controller
+ *
+ * Must be called with the spinlock held.
+ */
+void dwc2_clear_lost_state(struct dwc2_hsotg *hsotg)
+{
+	hsotg->hibernated = 0;
+	hsotg->in_ppd = 0;
+	hsotg->bus_suspended = false;
+	hsotg->gr_backup.valid = false;
+	hsotg->dr_backup.valid = false;
+	hsotg->hr_backup.valid = false;
+	hsotg->lx_state = DWC2_L0;
+}
+
 /*
  * dwc2_enable_acg - enable active clock gating feature
  */
diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 54c040da0cae..9873ae7b52c2 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -1411,12 +1411,14 @@ void dwc2_dump_dev_registers(struct dwc2_hsotg *hsotg);
 void dwc2_dump_host_registers(struct dwc2_hsotg *hsotg);
 void dwc2_dump_global_registers(struct dwc2_hsotg *hsotg);
 
+void dwc2_clear_lost_state(struct dwc2_hsotg *hsotg);
+
 /* Gadget defines */
 #if IS_ENABLED(CONFIG_USB_DWC2_PERIPHERAL) || \
 	IS_ENABLED(CONFIG_USB_DWC2_DUAL_ROLE)
 int dwc2_hsotg_remove(struct dwc2_hsotg *hsotg);
 int dwc2_hsotg_suspend(struct dwc2_hsotg *dwc2);
-int dwc2_hsotg_resume(struct dwc2_hsotg *dwc2);
+int dwc2_hsotg_resume(struct dwc2_hsotg *dwc2, bool lost);
 int dwc2_gadget_init(struct dwc2_hsotg *hsotg);
 void dwc2_hsotg_core_init_disconnected(struct dwc2_hsotg *dwc2,
 				       bool reset);
@@ -1452,7 +1454,7 @@ static inline int dwc2_hsotg_remove(struct dwc2_hsotg *dwc2)
 { return 0; }
 static inline int dwc2_hsotg_suspend(struct dwc2_hsotg *dwc2)
 { return 0; }
-static inline int dwc2_hsotg_resume(struct dwc2_hsotg *dwc2)
+static inline int dwc2_hsotg_resume(struct dwc2_hsotg *dwc2, bool lost)
 { return 0; }
 static inline int dwc2_gadget_init(struct dwc2_hsotg *hsotg)
 { return 0; }
@@ -1503,6 +1505,7 @@ static inline void dwc2_clear_fifo_map(struct dwc2_hsotg *hsotg) {}
 #if IS_ENABLED(CONFIG_USB_DWC2_HOST) || IS_ENABLED(CONFIG_USB_DWC2_DUAL_ROLE)
 int dwc2_hcd_get_frame_number(struct dwc2_hsotg *hsotg);
 int dwc2_hcd_get_future_frame_number(struct dwc2_hsotg *hsotg, int us);
+void dwc2_hcd_lost_state(struct dwc2_hsotg *hsotg);
 void dwc2_hcd_connect(struct dwc2_hsotg *hsotg);
 void dwc2_hcd_disconnect(struct dwc2_hsotg *hsotg, bool force);
 void dwc2_hcd_start(struct dwc2_hsotg *hsotg);
@@ -1530,6 +1533,7 @@ static inline int dwc2_hcd_get_frame_number(struct dwc2_hsotg *hsotg)
 static inline int dwc2_hcd_get_future_frame_number(struct dwc2_hsotg *hsotg,
 						   int us)
 { return 0; }
+static inline void dwc2_hcd_lost_state(struct dwc2_hsotg *hsotg) {}
 static inline void dwc2_hcd_connect(struct dwc2_hsotg *hsotg) {}
 static inline void dwc2_hcd_disconnect(struct dwc2_hsotg *hsotg, bool force) {}
 static inline void dwc2_hcd_start(struct dwc2_hsotg *hsotg) {}
diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 5e75d6975baa..295091a87b12 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -5213,26 +5213,40 @@ int dwc2_hsotg_suspend(struct dwc2_hsotg *hsotg)
 	return 0;
 }
 
-int dwc2_hsotg_resume(struct dwc2_hsotg *hsotg)
+int dwc2_hsotg_resume(struct dwc2_hsotg *hsotg, bool lost)
 {
 	unsigned long flags;
+	int ep;
 
-	if (hsotg->lx_state == DWC2_L2)
+	if (!lost && hsotg->lx_state == DWC2_L2)
 		return 0;
 
-	if (hsotg->driver) {
+	if (hsotg->driver)
 		dev_info(hsotg->dev, "resuming usb gadget %s\n",
 			 hsotg->driver->driver.name);
 
-		spin_lock_irqsave(&hsotg->lock, flags);
+	spin_lock_irqsave(&hsotg->lock, flags);
+	if (lost) {
+		/* Host likely saw a disconnect: drop stale gadget state */
+		dwc2_hsotg_disconnect(hsotg);
+		for (ep = 1; ep < hsotg->num_of_eps; ep++) {
+			if (hsotg->eps_in[ep])
+				dwc2_hsotg_ep_disable(&hsotg->eps_in[ep]->ep);
+			if (hsotg->eps_out[ep])
+				dwc2_hsotg_ep_disable(&hsotg->eps_out[ep]->ep);
+		}
+		hsotg->gadget.speed = USB_SPEED_UNKNOWN;
+		dwc2_clear_lost_state(hsotg);
+	}
+	if (hsotg->driver) {
 		dwc2_hsotg_core_init_disconnected(hsotg, false);
 		if (hsotg->enabled) {
 			/* Enable ACG feature in device mode,if supported */
 			dwc2_enable_acg(hsotg);
 			dwc2_hsotg_core_connect(hsotg);
 		}
-		spin_unlock_irqrestore(&hsotg->lock, flags);
 	}
+	spin_unlock_irqrestore(&hsotg->lock, flags);
 
 	return 0;
 }
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 0d20b9de857a..6f2b192f68f8 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -2324,6 +2324,26 @@ static void dwc2_hcd_reinit(struct dwc2_hsotg *hsotg)
 	dwc2_core_host_init(hsotg);
 }
 
+/**
+ * dwc2_hcd_lost_state - drop stale host state after registers were restored
+ * @hsotg: Programming view of the DWC_otg controller
+ *
+ * Make the hub re-evaluate the port, as a connect change may have been lost
+ * while the controller was powered off.
+ */
+void dwc2_hcd_lost_state(struct dwc2_hsotg *hsotg)
+{
+	struct usb_hcd *hcd = dwc2_hsotg_to_hcd(hsotg);
+	unsigned long flags;
+
+	spin_lock_irqsave(&hsotg->lock, flags);
+	dwc2_clear_lost_state(hsotg);
+	hsotg->flags.b.port_connect_status_change = 1;
+	hsotg->flags.b.port_suspend_change = 1;
+	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+	spin_unlock_irqrestore(&hsotg->lock, flags);
+}
+
 static void dwc2_hc_init_split(struct dwc2_hsotg *hsotg,
 			       struct dwc2_host_chan *chan,
 			       struct dwc2_qtd *qtd, struct dwc2_hcd_urb *urb)
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 7f3436e6a153..53c34a42f760 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -738,6 +738,7 @@ static int __maybe_unused dwc2_resume(struct device *dev)
 {
 	struct dwc2_hsotg *dwc2 = dev_get_drvdata(dev);
 	unsigned long flags;
+	bool lost;
 	int ret = 0;
 
 	if (!dwc2->ll_hw_enabled)
@@ -788,16 +789,29 @@ static int __maybe_unused dwc2_resume(struct device *dev)
 	 * In case the GUSBCFG register is not initialized, it's clear the
 	 * registers must be restored.
 	 */
-	if (!(dwc2_readl(dwc2, GUSBCFG) & GUSBCFG_TOUTCAL_MASK)) {
+	lost = !(dwc2_readl(dwc2, GUSBCFG) & GUSBCFG_TOUTCAL_MASK);
+	if (lost) {
 		spin_lock_irqsave(&dwc2->lock, flags);
 		ret = dwc2_restore_critical_registers(dwc2);
+		/*
+		 * The restore re-enables global interrupts: keep them off
+		 * until the stale state is cleaned up below.
+		 */
+		if (!ret)
+			dwc2_disable_global_interrupts(dwc2);
 		spin_unlock_irqrestore(&dwc2->lock, flags);
 		if (ret)
 			return ret;
 	}
 
 	if (dwc2_is_device_mode(dwc2))
-		ret = dwc2_hsotg_resume(dwc2);
+		ret = dwc2_hsotg_resume(dwc2, lost);
+	else if (lost)
+		dwc2_hcd_lost_state(dwc2);
+
+	/* Global interrupts are off after a restore, enable them back */
+	if (lost)
+		dwc2_enable_global_interrupts(dwc2);
 
 	return ret;
 }

-- 
2.43.0

