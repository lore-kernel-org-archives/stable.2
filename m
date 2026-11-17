Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.60
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794935186;
	b=crkDDnxWf8Jk2py4c4QY0D4sBJbAEGsCGQ1dmuYzms8HSgl3w/NfL2z88izezDJ0IXeo
	 VTmVeQBC+lE+Ln8owyvc7pl+WUvO4+AIpza24nemgdSiaA1u2k/uUBiSSn0cDLjHKPjca
	 /GNi8Ow7zfZss/MKRdvaSNy2XiMhbH5rdlyI4agftmh5fGL6oJ3m0eQDSPqtR/csVui0A
	 bTT52U9VMvBpFwBWmKbks5l4NS034ZR41QuLYvhk147jP6UlDtR+r0lyrwbkYU+DsF1vr
	 WSSYsjSQV9Qs/Wu+j6Fcrb1KasrHGM2uCwNcir7apgP3Q1Vwfy6FhA9vm5J3CCt2NJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794935186;
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
	bh=drXgqVnA+k0QdjGDjwtNBqIRLrSK+qqsHWVu+X37XHQ=;
	b=wyX3dW9h81ulLqEg8BFdY0CkmE/pnaGZVDLyFZ0d4FE5OYUvLMTdY284roWWRu5OkKL4
	 08MNftB6gdgPD1KYNkKDCRVtP/I3GgdIWVAdpgmJ/beHYiEQdZF3sIAVnbY/Sj+rKDTT3
	 HDzRfJkSXVf3XKWHucxOYqmEQtC2U6h60lc2rB3aiIT9F5Oxpkor6OR6wZpTX8UNNbe26
	 DGJzhl6GyU49OTz6o8TSwFgfyOYFKJO17xFhqB2IvCcSHYpAyVhod+UDmqyZ+cB+ErbJb
	 L/lPn5a+N2ArxIspXR4Mtetv13Wc4sG27yVdl3BacclScjHU4MPCSx1TLUxQlFOp2Dw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=U4hd7C+i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.60
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013060.outbound.protection.outlook.com [52.101.83.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55B4606A337;
	Tue, 17 Nov 2026 17:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A55B4606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=U4hd7C+i
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Un/jwkBzVuzgJtEPvZWqI46PzLHVQw7oMMeupfTkaRqwNwmDmQnfjphrmKlXrjwefzViBaKOAOTIcVcknzrX3yZOryuohfbje+VUTvC5AsDHp8KBBX4ESK5Svt/ijNqCtad+rdfkRdNsc7G2lR6+C389CQm3HyAUhEjgMU0AusbstKxkps2lfDMB07mURJiOv5/qd+aeHbLBo0Ww9VwVDQsENGaJ/2ALn7CX8q+c+eBTMvnNxPQbEK/5E+Nai15g9fU8ZAxxuLkoHKNWsLlddk4PukK5h5S5RWA4shwbwI8mC8TQy0Q/AchmGFbNBTUwT2yi8BqWDH3OAJmJSmIf+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drXgqVnA+k0QdjGDjwtNBqIRLrSK+qqsHWVu+X37XHQ=;
 b=kpu2eAS0Ad33/fbfSkjop+CLS2YV8iFqCje2uivGBhLZjKMfGZItz9MYV+KCWrN9mQ6sV0pIFtVmw0d8b5+dcVOeCB3u2NsCY/BWK4br/gIzhjPemwe4fc1Gv0KuGRSvwWGd5zfmiQqUW3Cfj8zHOZ3frEYyDsMAY9vtAFQUwYIvKlaKNSPGEm/oxasIdRk2YvVuvHxCQtZde8WeYbcdrQxNc8/hbvcC0cvZKbm1nai8ftcHIvcU7zlpro3yvZKrDRTjpGlg0FYkB3Ll/mSUdRM4YfQ1CAiXFSa6grbT1+ossRkB0q0tGdLWSUCRuAA9NIiJeILJwsifmdJfi6rpsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drXgqVnA+k0QdjGDjwtNBqIRLrSK+qqsHWVu+X37XHQ=;
 b=U4hd7C+i6bNFDo0Ud1K0xoUpbD+MFeVQBJFpHZvQB6Z6SA5qUMau7UAxTfz6AklsOJYcvojpGE7h5Xj3Tj4s6xMLCls0KNpigJlytV6M9Gf88Z3O0vM8lo25cPPjFPoc1xMvRjjkV24SQMPLalP2djFSUOwchbUA6x86QbA0ta8ZEPquULrsgdtQCj9BvK+HbiUHsOsJUIMxP2ppBy1PFf33eK3IPXI8RcqcZYA8NqocfjC8eoFLi4bfJZY22rAMNeK6I3Yk3uKLApatfU4u0alUkpXBYhv8vrGvaY1kbyHC/P4chflcgVAOWyoIWpGTLVRcoIfHL5cW2EjHkON5oQ==
Received: from ZR2P278CA0052.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:53::16)
 by AS4PR10MB5574.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Tue, 17 Nov
 2026 17:06:21 +0000
Received: from ZR1PEPF0000E464.eurprd04.prod.outlook.com
 (2603:10a6:910:53:cafe::71) by ZR2P278CA0052.outlook.office365.com
 (2603:10a6:910:53::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 17:06:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 ZR1PEPF0000E464.mail.protection.outlook.com (10.167.241.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Tue, 17 Nov 2026 17:06:21 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 18:07:06 +0100
Received: from localhost (10.252.22.224) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 17 Nov
 2026 18:06:21 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Tue, 17 Nov 2026 18:06:06 +0100
Subject: [PATCH v5 2/7] usb: dwc2: fix a possible interrupt storm in hcd
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
Message-ID: <20261117-dwc2-low-power-fixes-stm32-v5-2-0f197e0e6362@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E464:EE_|AS4PR10MB5574:EE_
X-MS-Office365-Filtering-Correlation-Id: b1ef1811-4df0-4514-c2d0-08df44cd1abb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|7416014|376014|1800799024|22082099003|18002099003|11063799006|56012099006|261022075727099003|261021121427099003|10067099003|261021123027099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	WGwVOuqUqZHAouOrzKzeDMi66Ds8xtAOGVJS74w36DQFNLDamsSwFOecHVUvFM+6Td0aemiAh09cavyROHPcSfF1KkKnKk2v4NFUlApsgAelOP56CeUqABg3pLTxfwPcnZ7FQvslweW3cOZayJZR6V7AI3rEv7kwq3J3DqVCr+luooORwLxbPU6wpBOAXxTJsusv1HBLAINyoNlUWLJMp3D+gT+x35LJmssfjzCUtysmpqNxJdmFodUVZ+IF2/LVHiVokFGLjwDUp6ZG9muKVfO0VxiQQ5vyXJc7TTuTu471sqf8OiFKAVfXOzq7/HzywNJ2qmolh6tmIjk5ZNlYolwAcr9RtvnSgA5ej2bLZArppmfIfPcj1Gkg+qULXzaYRT2Bm1dJJbNMu8NYHNEfRRdLkBgIzDkA1cTr879gDhW/1X2sLWBVwgB+iS3qy1ejwpb7o5/KgytSh/8sEXuYXB4saogmidqlBakaxlUg7aZhhaMPUWjDMgcsJA8F6rEMuIMjzb2rToTayvbNbba9YtM9gZcBIq76pfZ1AZOIpWbZaFC9FdaW2kuLga1WaiA2631SOu7veDZygL3wySQI8Rl0LpCZ42BxLo4UWM6W2O19naVvJop19R1vqGE0WoyyKlWK1b1bMvE/hgLkQ5NOwq4Ozho6RT/B3+cy825ABLyJYZwmaGpLL2kN310+VZW8pNuaoOwwiE2vzji+pCDbWg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006)(261022075727099003)(261021121427099003)(10067099003)(261021123027099003)(261009223027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WwnrXhfpimMXxs4E6wGnWfKAfCRhjenk06mHR+skaj9FxbRROAqJyJGQ11sWu9q2FjqFTUVjI6MNZ3YQUAd65ilKiDUWfFoMwkMNd2OxQM62pKQhRaOBRoj6I+ijdlCHo7N5c9pHLvVIjFjL0w+xBfkMuy+ggfQGyb5Sa8jG78c9oJbYReJksf3/ly7vf3PnxvpdGoG0WSSh5MO3nxbmcfM5JEIEawAHYALBRbuJQevTRA2lusFf3WRJ2tXagd5us/20GVAlojTanXe1CFZiZcosZZthAWOZkhBdP8xO3xGCuzOli4znAyOfkoP0ioSBt3US+0Pm9lF7ZWakRmlIBCRidfD/eci9YiQPTjB+N0bqigdUyLHee/6MSNvkd8T/LdvkLhM29xvIPCtJYkulCZCzBNVBco6gjVbNWFJsevRvBUDhr4yfEWDFWgoTslrp
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:06:21.7049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ef1811-4df0-4514-c2d0-08df44cd1abb
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E464.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5574

The host interrupts are re-enabled in dwc2_hcd_reinit(). So there is a
race during resume between a possible hcd IRQ, and the HW accessible bit
to be set. This can result in a bad_irq to be reported (nobody cared).

Note dwc2_hcd_reinit() "Must be called with interrupt disabled and
spinlock held." So, move dwc2_hcd_reinit() and the glocal irq enabling
inside the critical section, after HCD_FLAG_HW_ACCESSIBLE has been set.

Fixes: ef5e0eec4764 ("usb: dwc2: Add clock gating exiting flow by system resume")
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Note it's been found while debugging with additional mdelay after
dwc2_hcd_reinit() call.
---
Changes in v4:
- Address Sashiko comment "usb: dwc2: unlocked dwc2_hcd_reinit() call in
  _dwc2_hcd_resume()": rather move the dwc2_hcd_reinit() and irq enabling
  under the critical section, after HCD_FLAG_HW_ACCESSIBLE has been set.
- Update commit msg.

Changes in v3:
- Introduce this patch since debug session (since sashiko comment on
  patch 1)
---
 drivers/usb/dwc2/hcd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 3f9adfa7c630..7e4202c145f2 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4515,15 +4515,14 @@ static int _dwc2_hcd_resume(struct usb_hcd *hcd)
 		 * the global interrupts are disabled.
 		 */
 		dwc2_core_init(hsotg, false);
-		dwc2_enable_global_interrupts(hsotg);
-		dwc2_hcd_reinit(hsotg);
 		spin_lock_irqsave(&hsotg->lock, flags);
-
 		/*
 		 * Set HW accessible bit before powering on the controller
 		 * since an interrupt may rise.
 		 */
 		set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+		dwc2_enable_global_interrupts(hsotg);
+		dwc2_hcd_reinit(hsotg);
 		break;
 	default:
 		hsotg->lx_state = DWC2_L0;

-- 
2.43.0

