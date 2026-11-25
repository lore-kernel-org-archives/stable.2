Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795624378;
	b=enpYcHRl9hclKlYqBTcQGBdFF2lqFVB3ZXgY3mcZ0aNp17LgUweQEGfAYNIhVIPylPEp
	 qeCfHdDxIHzUIEKrPUJbmzte7rSYNT/a4f/zD1nfQ6dLFpVL4Cs5lJ3aYIY0kPfW6ZaDi
	 8LckbXimUwcJYPUxorXPJxoh8muMJ0KipgSKOLmFuBGnj3e36AsCGetyRrxnmY0Kjmylp
	 3FJPpBf9V7A6uLq/O23UK79Ve2+KYHKdnrhDW+aK8126m6o1YI+0COugJ8C+hoDUWujQq
	 Y30UbmDbzilt/Ko8JqkPSeKvjwJ68T6JEpGZC74y5A8P/87iyS9Tb7dsnEHYMe4Bz+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624378;
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
	bh=H45BjX8T/R64QiwV+Emc1kWhRKM4agy57BaKYDaly+8=;
	b=xy88IZI+y6Yg+YeDAMy54FjSE057i9UFym60DmyQB3vBWKxGS4gbZxs6HEwxfQHeBmwB
	 QXhBz6+RKIgHFG+oy2X9/EPr+GuKOe2nZnwSDWntj+vqkOxzpCQSfhyEOo+TdYDOlK5aB
	 MlXBAQBRESrGvI64gM6xj4ftEmE5X+OKAjO7z7MpigCrEtgvNx8tw2P+seRMiuvoJCHjN
	 Ksk5k/q54jUprvetwSf9viK02fxkNwcBBNB+vjlSKGzO1695WqSMgSVUD09+PcBOMglGd
	 y5yVr4MAhlvh398g0J/D5pyOpTbDWL5J97tfVnEaJWO4faxLdwTE9arvbdLau9iukQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=jeqrDcIl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.46
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013046.outbound.protection.outlook.com [52.101.72.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDF3606A331;
	Wed, 25 Nov 2026 16:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEDF3606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=jeqrDcIl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vDZD/0djnccwTET6/MHSwimf2RQrmGshfzGdpNRuFcPafe92ivfQKp4GVvgIg9k1T+T75buA3GPOvA2Ot8tI/FDkea6cr16WcaCSa+qQyXM9VTsf82/yBRhdDw7E/ihd+xePqZb5PssisI7C54PZZrBbfJ1Na9MTPBQArPcR7XNe8RRf0ePve2mo8ZbOYWxkbEQTxiW/qZ26qGuLf6cyTdZEZupXFG3AgpI70ZbNnQ9bTIQIyFvf2dZS90XOgEDSkYdR+w8AS06ju4sVMh7Yd9ImNCHyzATsCBn9zUnQmf404+9TATrrc5EOV2nD4HRYy/w+UMdkkF/scVWvf/yFqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H45BjX8T/R64QiwV+Emc1kWhRKM4agy57BaKYDaly+8=;
 b=YuLPT3MqOe11+FdWCXgaRc6cVMtHUZblQ5oNFFpGMm24CNpi8Q2O7ICAQepWyAdDXhk0de5vjeBjEkiVr7ST6gKmsqv2jo6s9pmOjIyHodXm9blfMdsIPuVpzNb3rvLELoMRbdefGRNQboBRklquy0vPyTz/QpB4uqt0CSLzyz2NmC90kdPzvqPytl1ZZZ3WU54lBCozSDyFdZ+dJzABZqssNnDLhKX0UOHLw8wn9eKUWdFw222tpjug2mxX9a1Ab6gTmN8weC5kCwszoi5cN/39JKoE46a/GfvkveZg7sJTXwJBpx6DhjUplllAdmnqFlVoFQDHbyBzalCXmsEkkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H45BjX8T/R64QiwV+Emc1kWhRKM4agy57BaKYDaly+8=;
 b=jeqrDcIlM5lnf/IF/2mLIMGiUjzDQR5GoX+ppNWz5dBvnlR9EGiVDNXSM3ICcZfJcGrIYQetyPbrLub5BnriJ1KQsm5R+p+JEKgurr+QUd/9z080p7sSaOqqsMDTece1dpmdty53FRARmgucFXOV2VZ0fGI8p2iYCVQ8sCghwJuKV2qmaiRzZAs0dsAPmV8hmj7atMzX/DNlMUp/ZZLCxVHJj+K3RnnnUgluPLBBDWIdT8opNuHnRP6cwqwxEk+BKfW7FJNUHUUn8hGuCHqEm6/o6L71RoNP/C7Z00ExGg3nhXBFssCqYFOIya8xCukBtKdD8jdjn61zk3uTufQ82w==
Received: from DUZPR01CA0322.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::20) by PA2PR10MB8720.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:422::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 16:32:50 +0000
Received: from DU2PEPF00028D04.eurprd03.prod.outlook.com
 (2603:10a6:10:4ba:cafe::26) by DUZPR01CA0322.outlook.office365.com
 (2603:10a6:10:4ba::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 16:32:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF00028D04.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Wed, 25 Nov 2026 16:32:50 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 25 Nov
 2026 17:33:55 +0100
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 25 Nov
 2026 17:32:49 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 25 Nov 2026 17:32:10 +0100
Subject: [PATCH v6 09/11] usb: dwc2: restore peripheral mode on low-level
 enable
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
Message-ID: <20261125-dwc2-low-power-fixes-stm32-v6-9-d5df33b93eaf@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D04:EE_|PA2PR10MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bc6cc91-1954-4124-fdde-08df4b11bf2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|7416014|376014|1800799024|36860700016|18002099003|22082099003|261009223027099003|3023799007|13003099007|11063799006|56012099006|5023799004|10067099003|261102123227099003|261026140227099003|261022105027099003|261022075727099003|261026121527099003|261021123027099003|261028144727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	kvsfPK6KXnD8O9/KhWoy5XjhPP9R4bnuSCQis99XOF7SdSDxsPrt5BaDG6wYM4aHcM1XCD3UscKyMT8usTV5br0WeqNnkl4NKwE7mVI2XibVKdqt8FQVGuxyf+dR9Kl8nMdlMXW8J4K9Wzk0/OVjdmePT4Sluxap5gvQ3BC6GSud24U6pV8S+maMUv5coS25oTSpYmlCPAQp2XjXwfNtvfVHJQJJT6pXXzlaC5ZiMMyXZPHOlecfXrd8aB0jAg06zMf5CXvDGPCxBPC4JApyhTcOJwa/ak6g0zrULlD8AukJ4TJmRhMWlHppPGE7D9zANXwe8Jk9P91wcsctOBC69OdpCNWBULn5IhxjMzer0eNd+/JtyigXZZsnE6ZJjo/yGS0e58Gfq1MB4Ioo0iDNBGKEdXPGpwbrrRheq6jjHmzCN6DFqMcfpszZWxR+/3+2CWQ8aHyzmcM+/R4PxDpbwoDRow4VQQRV/BQh2Q6mU1a8UvJOV46DKQDIgeGds9FdraVFZ6IVS5WJSpEQRBK53aab0ym2rxqUFtl42YO4CDbmh4Y+Y86MKmRikZf6IXv8oAcx/kyqVOpTke0tTpN88XNwHRX6iN/uZu5Xre7mZSjFwPkVCrbOXJkZWsRsN+YKiQ60MyCAw6vp3aLElhFYPQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(7416014)(376014)(1800799024)(36860700016)(18002099003)(22082099003)(261009223027099003)(3023799007)(13003099007)(11063799006)(56012099006)(5023799004)(10067099003)(261102123227099003)(261026140227099003)(261022105027099003)(261022075727099003)(261026121527099003)(261021123027099003)(261028144727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4Ibl2cY9Ej8rnyXbdSeN38qNlCzFYsoDQujo0iTo+zjYLiN4E2pNOW6H8ar+oXf5E0cq44QCwvTL/IwfDl5yYhmUJSSTu84tf+UN0aRIBBcRb2Luel4foZOrIDW+OfGx58uDicRQ2t867j9fI1w6pgkBodOEQsjrO6YYOoelkTjEM7hITKaURpYxmpLOF2re2j/PtCvxEDDQ6ZKyrTh/V04HxXSTeX2IA71OGq/Bx2+yabMdqUmQT0b8HHH7rFaHwVnznhrNWHpkKXpcH5PkklHFSQ0C8CjfFaNgD4pb+yDFwNAYauMJ/THKLOUCb9UoMtAVruAe46SJvdXnbQUG5fILR0pLRr0EVYam2zYUQRTq0YcqfeCpKKHmaRVoVS0Hzn+B7RXTG78ARESsPKEMH/zPI6iMnFHel0Ije+fBxsBXZMijdUiza88lGcjI3HD6
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:32:50.2685
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc6cc91-1954-4124-fdde-08df4b11bf2c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D04.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8720

In fixed peripheral mode, the gadget code manages the low-level hardware
on its own: it is disabled after probe, and enabled again when a gadget
driver binds. While it is disabled, dwc2_suspend() and dwc2_resume() return
early since ll_hw_enabled is false. If the DWC2 registers are lost during
system suspend, nothing restores the mode selection when the gadget driver
binds later:

- FORCEDEVMODE is not set, so the core may not come up in device mode.
- With a usb-role-switch, the session overrides set by dwc2_drd_resume()
  are not restored either.

Restore them at the end of __dwc2_lowlevel_hw_enable() when dr_mode is
peripheral: call dwc2_drd_resume() if a role switch is registered, or
dwc2_force_dr_mode() otherwise. The dr_mode check leaves the probe-time
enable unchanged, as dr_mode is parsed later and the role switch isn't
registered yet.

As this is now done on low-level enable, skip the peripheral case in
dwc2_resume(). Other modes still restore the forced mode or the role switch
session there.

Fixes: 2b94b054ac49 ("usb: dwc2: fix hang during suspend if set as peripheral")
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/linux-usb/sashiko-outbox-219235@kernel.org/
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v6:
- Also restore the role switch session overrides with dwc2_drd_resume()
  when a usb-role-switch is registered in peripheral mode. Issue raised
  by Sashiko.

Changes in v5:
- New separate patch added since issue raised by Sashiko on next patch
  pre-exists, e.g. missing forced mode restore in peripheral-only mode.
---
 drivers/usb/dwc2/platform.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 24ede0b6ab81..38954dee6ad0 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -129,6 +129,18 @@ static int __dwc2_lowlevel_hw_enable(struct dwc2_hsotg *hsotg)
 	if (ret)
 		goto err_dis_clk;
 
+	if (hsotg->dr_mode == USB_DR_MODE_PERIPHERAL) {
+		/*
+		 * Gadget code manages low-level hardware on its own. Restore
+		 * the mode and role switch session after register loss while
+		 * it was disabled.
+		 */
+		if (hsotg->role_sw)
+			dwc2_drd_resume(hsotg);
+		else
+			dwc2_force_dr_mode(hsotg);
+	}
+
 	return 0;
 
 err_dis_clk:
@@ -778,11 +790,12 @@ static int __maybe_unused dwc2_resume(struct device *dev)
 		spin_unlock_irqrestore(&dwc2->lock, flags);
 	}
 
-	if (!dwc2->role_sw) {
-		/* Need to restore FORCEDEVMODE/FORCEHOSTMODE */
-		dwc2_force_dr_mode(dwc2);
-	} else {
-		dwc2_drd_resume(dwc2);
+	if (dwc2->dr_mode != USB_DR_MODE_PERIPHERAL) {
+		if (!dwc2->role_sw)
+			/* Need to restore FORCEDEVMODE/FORCEHOSTMODE */
+			dwc2_force_dr_mode(dwc2);
+		else
+			dwc2_drd_resume(dwc2);
 	}
 
 	/*

-- 
2.43.0

