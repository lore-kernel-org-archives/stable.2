Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793798481;
	b=WCfW+aPQt1C9AHtaDhghK+KnvIE2fwq4Ljq9q4E3av1/89RTQz0V5h35kyC4MLc/xZtv
	 g6zqtQ+NiY3Oo2gXpY9GjcsqpDlgKdkiXOVttRjxDlCdnXJoUmlWOE8CyaDpZY6YlbK2I
	 vCJLnaN1BtMZqMRHKMk12q2xsiJwBibR2Gpdt+7YK7Y14cnlCUmgfMaSAnQMYtnTB4RBR
	 nMKWilS4LXxa7nwDe8c/ImkIeiiUE/iV4cVoEXT5nlILV8zJu/fuz1tCqOlg0kLkpPKA8
	 w1WCmKaKgQd+PEyCquNZ50qCrkkOuwXoNllABgq5At9qJSbKjYP2ekzh40YlAOFS/xA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798481;
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
	bh=EI+Y4hM0Y2Uxn0QanIh97nJB176vQx71JD9cvBfdBtk=;
	b=TIYiA58rWFbQ/UybCKXZydPimtNrhXS7gJWshP8iLyitxnjsfrjTbrEjyEXE8MXqoFvg
	 Au+ufllq4IvE+35s90AhNiS13++sXzDRzBl3qDU870AVFnuMtVJkg2ZOk3nDM1T4v9xcK
	 L06DSWeF7GlteEFHHQ0yBldELjwLfra/JOCyuHfGhMljM8mGED0fQNadMtZBANB/zDzVe
	 5WySr9v2S7MIR/U7kYATlCGj9rd7eZRth/U4K/pXFHUNBhMZupYxsmeenF+YWm6sitrP3
	 /4zcwZNI+S3kWeZZvsRQz3fcEk95sERwL6isouOUSirJa+xvVUvOsGKdsRkG3uiR1VQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=FaZVh6Kr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.68
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011068.outbound.protection.outlook.com [40.107.130.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD5B606A330;
	Wed,  4 Nov 2026 13:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FD5B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=FaZVh6Kr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1d+02ynqyJqXGUy42M1QLYbTXlM+QTPQPVi5BlvIjS4DH+ydTrPMm5+N6raRqTDYxGUZRyHurHCERHNkIylSJlnjW7NOtGMknbXyq5IkQwIw6CmTgBrm1BIk/XeoMOSqSWLEr4nGFNT04XOrUDw2Xf3lXUZIy6wbHEJR04B0umM52ma0R2+TLlJZNo8nMzgN12ANUvBrI3ebu+OSzd9t1W0eptd7KqWWaWeOT8bWEY65jaXU6pNXIFW3Dhy1TQ1k8X6rekDaPdSd3nt9Pl/73izG+WgI7wUd5wHcYZkJK10KGv7hK+LbF549iePUgp6yOfgRuD/Kgx4v9lyZlMCtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EI+Y4hM0Y2Uxn0QanIh97nJB176vQx71JD9cvBfdBtk=;
 b=AhXug/ROZe8v8ja8eSVjS8M+Akwc8RqY61GwI5Hk29oOYhjKYEb67p5sN6v8+ZZecyD/2k1LdoEQylLllSeB7p1hKeTp34ZMzwhsmRbDsX4wRfkYbaLyYHlniyHGLyU9ukDVJzM+qwfnlpwO2BW4MiRXsBPyGiAznOj3Gr0Xc/GfaqXR5LTs2GhNhD2ixVlVCFaM8xdB00DuMmQ4bD9IHOet2n125Itx9T40N+a6FkSc+0QNLrpVG2FzznXHK+hywVWzpW8FMQT7ndFeZTtKb5kG8kruHOYXvYH50zpCu5VzvrUpkkIu0e9YMTg77fKPLBvTUNkEaW+nTyGuCWauvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=synopsys.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EI+Y4hM0Y2Uxn0QanIh97nJB176vQx71JD9cvBfdBtk=;
 b=FaZVh6KrsRgkuEdu9dXPUpVh8rfwVknukAU7txuO1qcjQH/yPqlPinEDBIpXMCBj97oMXBg4qydK4ltJjZM6ingcJLMx+c9SmHUGSsJPv9nvaQhA6F7VZQJhremkJRqqB2BqILsR9yh6C+ZNq9vomgtc/A8R9JxzqdxnYOZg1FEUkeD9xOLlOVUsvZL37JO1B3/WrZcmLkm90PG/L4+wcry+Ro39PTzaW+fdJuVZXSoxwmqEBHmdqlHNBOMiS/9tYyx3AzKSP5HH2UPJLuoZvVszgUf+Ek9PLaT52VQNZLCwom5EFMnW0KizaPzEaFD8rY/UrYGYCxfU93vWYYl9RA==
Received: from CPBP307CA0003.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380:1::15) by
 AM0PR10MB059815.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:7f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 13:21:14 +0000
Received: from CPH1EPF0000051C.eurprd04.prod.outlook.com
 (2603:10a6:380:1:cafe::66) by CPBP307CA0003.outlook.office365.com
 (2603:10a6:380:1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 13:21:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 CPH1EPF0000051C.mail.protection.outlook.com (10.167.241.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 13:21:13 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 4 Nov
 2026 14:21:42 +0100
Received: from localhost (10.252.2.138) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 4 Nov
 2026 14:21:13 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 4 Nov 2026 14:20:16 +0100
Subject: [PATCH v2 2/2] usb: dwc2: wa for isoc packet tx fifo flush at
 periodic frame boundary
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
Message-ID: <20261104-dwc2-fifo-fixes-v2-v2-2-2bb13820f662@foss.st.com>
References: <20261104-dwc2-fifo-fixes-v2-v2-0-2bb13820f662@foss.st.com>
In-Reply-To: <20261104-dwc2-fifo-fixes-v2-v2-0-2bb13820f662@foss.st.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, <stable@vger.kernel.org>,
	"Fabrice Gasnier" <fabrice.gasnier@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CPH1EPF0000051C:EE_|AM0PR10MB059815:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cf7ef56-b21d-4764-0097-08df3a768010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|6133799003|10067099003|18002099003|22082099003|3023799007|11063799006|261102123227099003|261009223027099003|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ujt90ZG8Y/+F+v+1PqyKZzrt8yjDOZCy4ewjKa3ep50SBeQlS0iooSVO+7Y8RSfKMTj1m+ThHOjW3I+lWs4ZxunKXehSN+lTyOQ5fM8jwGuuh30p/Qajxad+2gd8a2XodL4+8MpvG514zAA2YTafoPG5Ay473v0r7Efwxg6T529oUp3Hfa9HjW8RWSIUCtGLByqGQN/UPVpprkEpCQfjcSa7l6FzhBLu2sD0rkn3FkZlitq/BOqpcU/hIxvjbGoJ8Ndw3OiNnP4Yeo1WrnJ+gjw4n0Vw6hj7ZnQ7ZtcHX1mRErbw8/4Xhi2Tgy8syLfNJvOhqwrA/1e6bv6xhq+VmPV1d0ekYmIW11BCzIU3/X6uK0vkFK4S5C446IWU0J5RVQUq8Z+8xwcsdreexB7Z68I+NSz9zsPZWXrA6nuVeBBydlJWSJELAXMVsS+keW7E2eNNRqhLlWQDPwOoQ3yItzbMNUVIsoGFxF9GX8ePDpLOYJRxlFhHJaqBdMUYEr2tCTd6+i7VSI8oTNyfLVbaPFuxMEhrU0sCXkfeG9H3E9c3taG3pnfpsHDeJwsED7QmE7d+NOZRwXCevKi3DPmuzMKQ9xev0YXGJvFg9Vo3aiBX3nAPzPpxl9s4m6unl4BJqrAczpja5R4Y0bsmnmmxYd7FgB7KcAt90FTNWRVuP1cC1sCAMp1HjpM/IADlS6ed8YqabgQ2yXC+Wz70CKPdAQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(18002099003)(22082099003)(3023799007)(11063799006)(261102123227099003)(261009223027099003)(261021121427099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ee/Kr1qzReRMph6LjcnnOWfNLYY9euw815j8nbVzispuGOIrz2ILYRaMgdninsct1dDzN+N/R5Dh5bO2cfmyyfzq7ysU0d/EAUUzA6tjtzfPTE9W9j7D6kkkRNgP0iQrBRFfyjhlCVbmasYuISetR8zl/GXLuGpN41iPQrwbBaZfhPjsgElhh8aw5+8qzGN20mXnTWvwhH8HDaH0JgMcW6YE74T3kRUKmMVigEgkZaZ+aLDu4FIeaLWeJIEi+Cf3s6g/uCUY3+SJePr4GwuV6sU5JHJktNi3lfkihuKnrPrKqA9Gv+nKrwL07N7HKYXeyQrsaRB1pJVKxj1yftDK7jdXtPnC2UnIkNp5BOEtqQoOwGXduHM/wizcsn80YtdNvtsF+HLPfGaoYZJ3rTui5KtXN/cVKqnSA3dYEiFgfJPE/sBjCbZj9O5LDQ8ub6sl
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 13:21:13.8052
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cf7ef56-b21d-4764-0097-08df3a768010
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CPH1EPF0000051C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB059815

If an isochronous packet is still being transmitted, when the end of
periodic frame interval elapses, using dma desc on dwc2 controller,
the device wrongly flushes the pending packets from the tx fifo.
This can lead to a huge packet is sent on the bus, leading to the host
finally reset the bus, and re-enumerate it.

Workaround it by tuning the periodic frame interval limit from 80% to 95%,
on the affected cores (2.70a to 4.00a). It makes the issue very unlikely
to occur.

Fixes: 540ccba08599 ("usb: dwc2: gadget: Start and complete DDMA isoc transfers")
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
- Thinh review comments:
- Fix a typo 'flushes'
- Use DCFG_PERFRINT() macro
- Add DWC2_HS_IOT_REV_1_00a and DWC2_FS_IOT_REV_1_00a core revisions.
- Add a Fixes tag, and Cc stable
---
 drivers/usb/dwc2/core.h   |  1 +
 drivers/usb/dwc2/gadget.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 015a5fb7842d..54c040da0cae 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -1108,6 +1108,7 @@ struct dwc2_hsotg {
 
 	/* DWC OTG HW Release versions */
 #define DWC2_CORE_REV_4_30a	0x4f54430a
+#define DWC2_CORE_REV_2_70a	0x4f54270a
 #define DWC2_CORE_REV_2_71a	0x4f54271a
 #define DWC2_CORE_REV_2_72a     0x4f54272a
 #define DWC2_CORE_REV_2_80a	0x4f54280a
diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index bdabf3c39da1..b84cb6b2cefa 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -3511,6 +3511,21 @@ void dwc2_hsotg_core_init_disconnected(struct dwc2_hsotg *hsotg,
 	if (hsotg->params.ipg_isoc_en)
 		dcfg |= DCFG_IPG_ISOC_SUPPORDED;
 
+	/*
+	 * WA for Device Flushes Ongoing ISOC IN Packet at End-of-Periodic-Frame Boundary.
+	 * Once passed the end of periodic frame, and the controller is transmitting an
+	 * ISOC IN packet, the device flushes the transmit FIFO. Tune periodic frame
+	 * interval to 95% instead of 80% to avoid it.
+	 */
+	if (using_desc_dma(hsotg) &&
+	    ((hsotg->hw_params.snpsid >= DWC2_CORE_REV_2_70a &&
+	      hsotg->hw_params.snpsid <= DWC2_CORE_REV_4_00a) ||
+	     hsotg->hw_params.snpsid == DWC2_FS_IOT_REV_1_00a ||
+	     hsotg->hw_params.snpsid == DWC2_HS_IOT_REV_1_00a)) {
+		dcfg &= ~DCFG_PERFRINT_MASK;
+		dcfg |= DCFG_PERFRINT(DCFG_PERFRINT_LIMIT);
+	}
+
 	dwc2_writel(hsotg, dcfg,  DCFG);
 
 	dwc2_hsotg_init_fifo(hsotg);

-- 
2.43.0

