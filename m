Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795624381;
	b=11c1vjxpyCajUzsxyzQdY3WeV6IxhHHpWFQquQkLMd03TLFz5kKXHhYSp+GyfYaRav73
	 nwntXW8Cqgw/q+BDH3xw9R68/Sm4FZCJRcixAexyzEUhxzNoOJCprySNNHMwP1tpNT5yc
	 1bKNTdRhlBxEmPFVQMafS7MSwh48fy4um6yN0VA4pnQJNWanjVbe+qldjQAGpQzYjgBmf
	 D7VqxkDO26zta5h0ZVjl8cgIZz+GtPPmPo7sakbuhdKhdmiHHrPxrm+Ptt5hjQa/U5AQW
	 /OzOf5ih9IZ8kiZ8HvYw0rPQyar71VfdOXqJnlLuzaXKYWr8soOZgk3i7Hh8+jf8fug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624381;
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
	bh=5v7CY7Uqdb/iDuxnv9M7e19xM/o64AV8+RNpBjx1CaI=;
	b=eg9GXbKqtNrfCy0OD+Xbv+waprJH+9YgF+zbEA2y/do0zqD9Pq7g6Kin9wHTQCQjyJ43
	 SoOBgRDepirfZj9YkDx0RoP3IhcctxgvHCT0JO25ZVabGn9m5OF3qrSFLFvEQJcGvxYfd
	 ZXThirUFvcT7HWzvt6yhLZri1ncb9ZlJnrwWTutEyGsf88x6IbSje8CXW4cJEu+gY2jZw
	 FNCz0KEGNEwblvnSZ5G+2W8XHq4Q9ZUw9h6TCBoqN8FE3M56tNLBmleU7Z8edz/bxNQI/
	 mS6Vqnh7EptM2L+kym/DymYaHBeXjBpV/pDRrByAXHFUxrB8Pf336KdcCQi70yNG6wA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=KOlsanW6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.49
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012049.outbound.protection.outlook.com [52.101.66.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5BD60A2613;
	Wed, 25 Nov 2026 16:32:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D5BD60A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=KOlsanW6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbLHKjK4ZGDP0fmvM9nNm00TfSBQ+ZslDvf2v7v5vlULbNi32d3sJcxbQV9t/cQvWRVVLXDcj5S1fWfHHfl0kDw2Ona0T7cC8BuseuVk+AQOSnqtaAI5BQzbW/16kAkVVEkhIR657u9JrfJUNQ1BABpkbcIa3s7Tm2LrIWihjIio/dKD6mYiUW8+3BgdnvZLYNQSh4UEqG7sA6MklNRN816dGEYilkTgAY/0YIkCYGqUuIJQ/Oe/BKcnqf8r2/DUYA/2btV3Pgbx+Nby4jJKXofNKiePe9SXwn2uvN08x65YqbA2kRLjSEZgJo/XwXf00yu+NjsE4Iu1v2plgciwqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5v7CY7Uqdb/iDuxnv9M7e19xM/o64AV8+RNpBjx1CaI=;
 b=geYSQn94rtrlAkayLxTgoNcc7Ce62EWyJ52nFDH4WqHjdbxP3frObghE0SxD8T9HVbopSQhjYLjjQblRA1pFhnGZiMaFyhz4Uu74WIcIN+rMviOHHjPMFOqo049POL924+59wVz1imYCvAuGsXQem7DeReyG5WGA8DK6312lA9fvSIs1O67fF0thXPlGaLqPtGqi4vAuSCxT2qVYOiea+km3rglfcJGREud6DZI0GNik9ll9XnBWacV0hrj9tvkQeCtothswkXd+jhvrt/s3uO9GUNBs8wlhSon+CMN6Q23+lD/0vhZ83TD+n1Y94sOI6/WNrT8I4tIjBEScJf4BVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5v7CY7Uqdb/iDuxnv9M7e19xM/o64AV8+RNpBjx1CaI=;
 b=KOlsanW6gU+P3e8ok2GUVhydJcSsP4EF0plFZNvBDf3/rdBuZB4oo84WgNr7PccZnor/qMlf/FZNdlv/b0ebT+p1dKsc+Hv1g3h3RFnfDdHakVHLWrZF3KnugBSuzvpK+Ow411TSpc1zusA65HIwEHMtjJRqNk5E1ybkH9Kc8naUhde5dR2sOwzMc+4VM2PkPh9UEJ7hcAEZ1ESFdAouykjudHMV9uuibpckK4iuShRfP3EiAvhtd5ZXWUcL+5hzRsoXX1BKIp3BaZFASw+lZ9UIvCwvXKxLGa9h7opxoJjIee6mQ/owq3KGKITuHjiYwlnj58sKGAosMhlNbCQOMg==
Received: from GV2PEPF0004811E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::1ef) by VE1PR10MB194643.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:1f2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Wed, 25 Nov
 2026 16:32:49 +0000
Received: from WA1PEPF00009B3A.eurprd05.prod.outlook.com (2603:10a6:1d8::118)
 by GV2PEPF0004811E.outlook.office365.com (2603:10a6:158:400::1ef) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.615.10 via Frontend Transport; Wed, 25 Nov 2026 16:32:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 WA1PEPF00009B3A.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 16:32:47 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 25 Nov
 2026 17:33:35 +0100
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 25 Nov
 2026 17:32:46 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 25 Nov 2026 17:32:05 +0100
Subject: [PATCH v6 04/11] usb: dwc2: clean up old role on mode change
 during suspend
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
Message-ID: <20261125-dwc2-low-power-fixes-stm32-v6-4-d5df33b93eaf@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: WA1PEPF00009B3A:EE_|VE1PR10MB194643:EE_
X-MS-Office365-Filtering-Correlation-Id: e1f482a6-0a79-49dd-dff4-08df4b11bda9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|7416014|1800799024|82310400026|10067099003|11063799006|261022105027099003|56012099006|261026121527099003|261021121427099003|261022075727099003|261102123227099003|261009223027099003|261026140227099003|261028144727099003|261021123027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sanK9ugfERqXd45mHTLSUb/QBuvaFM106A2MgtfsOcz6FR/G888Ml0Jd1LbB1SF71onIu5KexNhU9mBIIuIO1X3B35CVYEGfxupiR9LfPC2wXC4iXvrQtpO4osB9VPPrDPMjZcV1UqDTP6hQjnZMob2+kRoJFFslgytuF9YhY6nSm0Ma2YgukzDLtlDwSlcNuTJOB+/OdpCi6ldpZMEZQPQxNeuE/xBkZ+hqH/ZWtXSnf626lmKWCHqPcMHUZtMGLMnLa+INT2YOW6j+0kDDqEPWbC2nRzZomo0LkyP+3/Kn1O/XUXNduY9ncVbt2Fnjp/CcXeGBjdCGiRcYte0dc+5RTrUFQkJFygsDUgP4CS+dyzGfo3h/TcOzs6xGG5xEuM52YTiNZRFOjg7LiZRq7xAo3tTDdt5uwf2WDiFG01M1tZW/7szwrQX8Mo0IjfP3u4n89temy9kf+UmNdEmy0YffM4kX6qzfr5JlMt/rFARrXmNBHCDQh+YqwmZYDdTEyOtPwQOkTaj/HMFXeBJ6A/6v8Au7xgeAPg0mw+zKNtsjsofOvIGgM9ZiqKoLV9auaTFFeNjYcVzApstDucAcCJjIoXWtLl/DACVAgbcPYY8o0Nm2gjQs7bA+lp1S98U43z39TcT9bFz/tqDSBufUig==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(7416014)(1800799024)(82310400026)(10067099003)(11063799006)(261022105027099003)(56012099006)(261026121527099003)(261021121427099003)(261022075727099003)(261102123227099003)(261009223027099003)(261026140227099003)(261028144727099003)(261021123027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	i4U1/gQH3C9fMCRiXJz2dWTSBEtVMe9TJhFfy02+KYgKPAPmfMlxIwDe4l1kB5qCYlZeYgBFT1j5kt/+V4GYp/VqopCQxrUVWyGVBY2vXIhujbdC9wpqGy4f79Oc5lO6vk6Aqkv6GExCY2TLxg0O8zaDr+yE8e0n47eJ2Z4xpXKVuHc0z+KU2hvr8BD5P4whMCReihP0sAAYmx2sB+JXe6he54OVFNIpaTd1oPyTefhrNK/b00O2+VnwJbziN5XtsLQ3D3iH7c+8ZHGKpKc9BNbCiD1dVCbiHKbio99xADBakYxIatiuBowiF2e0OmP5wxRjCxCPcU40Boi0kKDw4MBJkixpqj+y86OVvG3IxnsYZjwXOrqNaSo5PQDcucUU8nsCbsI+ft8CjD67m6Kc9vmxowL+qZ9whZp3HkZZyOvG8j9sMI8SDyD5dAfryNWa
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:32:47.7410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1f482a6-0a79-49dd-dff4-08df4b11bda9
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF00009B3A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB194643

If the power domain is off during system suspend and the OTG ID pin
changes meanwhile, dwc2_resume() sees a register loss but the role that
was active at suspend is never cleaned up. No connector ID interrupt
reports the change, as GINTSTS is cleared by the register restore, and
the register backup belongs to the old role: host registers could be
restored in device mode, or the other way around.

When the core was in device mode at suspend and resumes in host mode, the
gadget driver is never told about the disconnect and the gadget state
stays stale. When it was in host mode and resumes in device mode, URBs and
host flags stay as they were and the external VBUS supply is left enabled.

Record the mode in dwc2_suspend(). On register loss with dr_mode otg,
compare it with the mode after resume. If it differs, skip the register
restore and clean up the old role before initializing the new one:

- device to host: disconnect the gadget, clear stale state, the FIFO map
  and set the speed to unknown, without accessing endpoint registers that
  are unusable in host mode. Then reinitialize the host with the new
  dwc2_hcd_restore(). If it fails, the HCD was not reinitialized, so it is
  left inaccessible.
- host to device: fail pending URBs, clear stale state, make the HCD
  accessible and release VBUS, then reinitialize the core and resume the
  gadget.

This addresses the second finding of the Sashiko review of "usb: dwc2:
fix recovery after PM domain off".

Fixes: ba6e518d136b ("usb: dwc2: Implement recovery after PM domain off")
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/linux-usb/sashiko-outbox-219256@kernel.org/
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v6:
- New patch added since Sashiko finding
---
 drivers/usb/dwc2/core.h     |  9 +++++++
 drivers/usb/dwc2/gadget.c   | 20 ++++++++++++++++
 drivers/usb/dwc2/hcd.c      | 58 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/dwc2/platform.c | 25 ++++++++++++++++---
 4 files changed, 109 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 9873ae7b52c2..89a34956bf22 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -876,6 +876,7 @@ struct dwc2_hregs_backup {
  * @reset_phy_on_wake:	Quirk saying that we should assert PHY reset on a
  *			remote wakeup.
  * @phy_off_for_suspend: Status of whether we turned the PHY off at suspend.
+ * @suspended_in_device_mode: True if the core was in device mode at suspend.
  * @need_phy_for_wake:	Quirk saying that we should keep the PHY on at
  *			suspend if we need USB to wake us up.
  * @frame_number:       Frame number read from the core. For both device
@@ -1074,6 +1075,7 @@ struct dwc2_hsotg {
 	unsigned int reset_phy_on_wake:1;
 	unsigned int need_phy_for_wake:1;
 	unsigned int phy_off_for_suspend:1;
+	unsigned int suspended_in_device_mode:1;
 	u16 frame_number;
 
 	struct phy *phy;
@@ -1419,6 +1421,7 @@ void dwc2_clear_lost_state(struct dwc2_hsotg *hsotg);
 int dwc2_hsotg_remove(struct dwc2_hsotg *hsotg);
 int dwc2_hsotg_suspend(struct dwc2_hsotg *dwc2);
 int dwc2_hsotg_resume(struct dwc2_hsotg *dwc2, bool lost);
+void dwc2_hsotg_role_lost(struct dwc2_hsotg *hsotg);
 int dwc2_gadget_init(struct dwc2_hsotg *hsotg);
 void dwc2_hsotg_core_init_disconnected(struct dwc2_hsotg *dwc2,
 				       bool reset);
@@ -1456,6 +1459,7 @@ static inline int dwc2_hsotg_suspend(struct dwc2_hsotg *dwc2)
 { return 0; }
 static inline int dwc2_hsotg_resume(struct dwc2_hsotg *dwc2, bool lost)
 { return 0; }
+static inline void dwc2_hsotg_role_lost(struct dwc2_hsotg *hsotg) {}
 static inline int dwc2_gadget_init(struct dwc2_hsotg *hsotg)
 { return 0; }
 static inline void dwc2_hsotg_core_init_disconnected(struct dwc2_hsotg *dwc2,
@@ -1505,7 +1509,9 @@ static inline void dwc2_clear_fifo_map(struct dwc2_hsotg *hsotg) {}
 #if IS_ENABLED(CONFIG_USB_DWC2_HOST) || IS_ENABLED(CONFIG_USB_DWC2_DUAL_ROLE)
 int dwc2_hcd_get_frame_number(struct dwc2_hsotg *hsotg);
 int dwc2_hcd_get_future_frame_number(struct dwc2_hsotg *hsotg, int us);
+int dwc2_hcd_restore(struct dwc2_hsotg *hsotg);
 void dwc2_hcd_lost_state(struct dwc2_hsotg *hsotg);
+void dwc2_hcd_role_lost(struct dwc2_hsotg *hsotg);
 void dwc2_hcd_connect(struct dwc2_hsotg *hsotg);
 void dwc2_hcd_disconnect(struct dwc2_hsotg *hsotg, bool force);
 void dwc2_hcd_start(struct dwc2_hsotg *hsotg);
@@ -1533,7 +1539,10 @@ static inline int dwc2_hcd_get_frame_number(struct dwc2_hsotg *hsotg)
 static inline int dwc2_hcd_get_future_frame_number(struct dwc2_hsotg *hsotg,
 						   int us)
 { return 0; }
+static inline int dwc2_hcd_restore(struct dwc2_hsotg *hsotg)
+{ return 0; }
 static inline void dwc2_hcd_lost_state(struct dwc2_hsotg *hsotg) {}
+static inline void dwc2_hcd_role_lost(struct dwc2_hsotg *hsotg) {}
 static inline void dwc2_hcd_connect(struct dwc2_hsotg *hsotg) {}
 static inline void dwc2_hcd_disconnect(struct dwc2_hsotg *hsotg, bool force) {}
 static inline void dwc2_hcd_start(struct dwc2_hsotg *hsotg) {}
diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 295091a87b12..9b12c336e4aa 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -5251,6 +5251,26 @@ int dwc2_hsotg_resume(struct dwc2_hsotg *hsotg, bool lost)
 	return 0;
 }
 
+/**
+ * dwc2_hsotg_role_lost - drop gadget state after a role change in suspend
+ * @hsotg: Programming view of the DWC_otg controller
+ *
+ * The core came back from register loss in host mode while the gadget was
+ * active at suspend. Disconnect the gadget and clear stale software state
+ * without touching the endpoint registers, which are not usable in host mode.
+ */
+void dwc2_hsotg_role_lost(struct dwc2_hsotg *hsotg)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&hsotg->lock, flags);
+	dwc2_hsotg_disconnect(hsotg);
+	dwc2_clear_fifo_map(hsotg);
+	hsotg->gadget.speed = USB_SPEED_UNKNOWN;
+	dwc2_clear_lost_state(hsotg);
+	spin_unlock_irqrestore(&hsotg->lock, flags);
+}
+
 /**
  * dwc2_backup_device_registers() - Backup controller device registers.
  * When suspending usb bus, registers needs to be backuped
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 6f2b192f68f8..60b39ccd0cad 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -2324,6 +2324,42 @@ static void dwc2_hcd_reinit(struct dwc2_hsotg *hsotg)
 	dwc2_core_host_init(hsotg);
 }
 
+/**
+ * dwc2_hcd_restore - reinitialize host state after a role change in suspend
+ * @hsotg: Programming view of the DWC_otg controller
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int dwc2_hcd_restore(struct dwc2_hsotg *hsotg)
+{
+	struct usb_hcd *hcd = dwc2_hsotg_to_hcd(hsotg);
+	unsigned long flags;
+	int ret;
+
+	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+	dwc2_disable_global_interrupts(hsotg);
+
+	ret = dwc2_vbus_supply_init(hsotg);
+	if (ret)
+		return ret;
+
+	ret = dwc2_core_init(hsotg, true);
+	if (ret) {
+		dwc2_vbus_supply_exit(hsotg);
+		return ret;
+	}
+
+	spin_lock_irqsave(&hsotg->lock, flags);
+	dwc2_hcd_reinit(hsotg);
+	dwc2_clear_lost_state(hsotg);
+	hsotg->flags.b.port_connect_status_change = 1;
+	hsotg->flags.b.port_suspend_change = 1;
+	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+	spin_unlock_irqrestore(&hsotg->lock, flags);
+
+	return 0;
+}
+
 /**
  * dwc2_hcd_lost_state - drop stale host state after registers were restored
  * @hsotg: Programming view of the DWC_otg controller
@@ -2344,6 +2380,28 @@ void dwc2_hcd_lost_state(struct dwc2_hsotg *hsotg)
 	spin_unlock_irqrestore(&hsotg->lock, flags);
 }
 
+/**
+ * dwc2_hcd_role_lost - drop host state after a role change in suspend
+ * @hsotg: Programming view of the DWC_otg controller
+ *
+ * The core came back from register loss in device mode while the host was
+ * active at suspend. Fail pending URBs, release VBUS and clear stale software
+ * state so the host can be started again on the next role switch.
+ */
+void dwc2_hcd_role_lost(struct dwc2_hsotg *hsotg)
+{
+	struct usb_hcd *hcd = dwc2_hsotg_to_hcd(hsotg);
+	unsigned long flags;
+
+	spin_lock_irqsave(&hsotg->lock, flags);
+	dwc2_hcd_disconnect(hsotg, true);
+	dwc2_clear_lost_state(hsotg);
+	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+	spin_unlock_irqrestore(&hsotg->lock, flags);
+
+	dwc2_vbus_supply_exit(hsotg);
+}
+
 static void dwc2_hc_init_split(struct dwc2_hsotg *hsotg,
 			       struct dwc2_host_chan *chan,
 			       struct dwc2_qtd *qtd, struct dwc2_hcd_urb *urb)
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 53c34a42f760..d89a30308f86 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -658,6 +658,7 @@ static int __maybe_unused dwc2_suspend(struct device *dev)
 		return 0;
 
 	is_device_mode = dwc2_is_device_mode(dwc2);
+	dwc2->suspended_in_device_mode = is_device_mode;
 	if (is_device_mode)
 		dwc2_hsotg_suspend(dwc2);
 
@@ -738,7 +739,7 @@ static int __maybe_unused dwc2_resume(struct device *dev)
 {
 	struct dwc2_hsotg *dwc2 = dev_get_drvdata(dev);
 	unsigned long flags;
-	bool lost;
+	bool lost, role_changed;
 	int ret = 0;
 
 	if (!dwc2->ll_hw_enabled)
@@ -790,7 +791,25 @@ static int __maybe_unused dwc2_resume(struct device *dev)
 	 * registers must be restored.
 	 */
 	lost = !(dwc2_readl(dwc2, GUSBCFG) & GUSBCFG_TOUTCAL_MASK);
-	if (lost) {
+	role_changed = lost && dwc2->dr_mode == USB_DR_MODE_OTG &&
+		       dwc2->suspended_in_device_mode != dwc2_is_device_mode(dwc2);
+	if (role_changed) {
+		/*
+		 * The ID pin changed while the registers were lost: no
+		 * connector ID interrupt reports it and the register backup
+		 * belongs to the old role. Clean up the old role and
+		 * initialize the new one instead of restoring.
+		 */
+		if (dwc2->suspended_in_device_mode) {
+			dwc2_hsotg_role_lost(dwc2);
+			ret = dwc2_hcd_restore(dwc2);
+		} else {
+			dwc2_hcd_role_lost(dwc2);
+			ret = dwc2_core_init(dwc2, true);
+		}
+		if (ret)
+			return ret;
+	} else if (lost) {
 		spin_lock_irqsave(&dwc2->lock, flags);
 		ret = dwc2_restore_critical_registers(dwc2);
 		/*
@@ -806,7 +825,7 @@ static int __maybe_unused dwc2_resume(struct device *dev)
 
 	if (dwc2_is_device_mode(dwc2))
 		ret = dwc2_hsotg_resume(dwc2, lost);
-	else if (lost)
+	else if (lost && !role_changed)
 		dwc2_hcd_lost_state(dwc2);
 
 	/* Global interrupts are off after a restore, enable them back */

-- 
2.43.0

