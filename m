Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.38
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795795434;
	b=2dZDWoWkIRFu3KqO9QNrsmzfv+nqikB9c12g7FKNtQP8d7Tl+SAWAHXkRtntSxPaD7dq
	 MzCpPYPn45JJ3Dd2DPn9TCJn9Sd0dysqkzkOSTTPCGRsBqZJoyLU7A6KQXEAJQ+ZwhZgQ
	 /Z7umV6CR9kyRGN1SHvfufXFTPXcn8hH1lKw7cqUAojRgBuWw5yheVmuGbqds+R708rLz
	 er7pIfXCm8ZLOGxgSqKkWuuo6csG43RJnnIxLdAMdnIHVkm5etRqCkdCFlYxy/N6KM3nY
	 NvETu4izL0TW7sK7Pe5n/Eu9eST/ZlmablSMqAgVY4mkjdFtZqcTLjsD+1iovijfcSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795795434;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=bLT7WPdi2uPiBxugEi1g3oorIIuyZp16E8WWzZYitPI=;
	b=SIHH+bE3wZ18w6WWXmMJbTsZMtDrGZjY0/GtQeVKx3LBwfQ3MlFJjYFkRW2u/vQJ42ba
	 3z+AVxxoys3wnyQzmKjwb/LpouMOB/ocGFMxAv75y2XcMiAXky/sjpHCn6uwCAIJxoad9
	 6qDFh5U9Du3K76h3DKgp4Qn6B+h9whoBlkp8iquqznRTW3UQ0skWrGRy+1q9HWKkxWm4v
	 v2DVd/ya7PwB9OUwtreSuuakkz2y0vYkVmFps9NN3VoXJL6Hl4dgHfyGArHslukoKn9Vj
	 w9yRzHSRsYYQ6eYV4k1X+jTbTHqvBAnVD7MqY1Me9ZiyiWcnhA5TTw/O0fUiDjmZ0Jw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=LZSDclCN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.38
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011038.outbound.protection.outlook.com [52.101.125.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976CA606A31E;
	Fri, 27 Nov 2026 16:03:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 976CA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=LZSDclCN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eKpXgpijVfVrSLezuR99tuTOHaD3c+5lX612/mzGAVXCJmEC5pEoeYAyxVNxPF0RQupTGnL65Eagvq+7zUMakDZ5Nmse5rpfRUvKflawB5bCMjHI/nP6qSl53xmtc3gMZGlq2qFFKYfwNk4LVilwRyEEYMrjdBH5BeaPCbT9MI1ymLcdZWE8hR2xrpPbVwt6JB7IDBj4OJb89lWn+x77odqbbdOCXtRWhQZFPlPBD58o5nn6UkdhWHEw7/VDobjQRNeDOAJvx9/Jq/DrdUu2cVNUdHs6O3TrCkc3XYuNTYNS0W75boVtGEbZfzIeDqa7ZkMUuS/wBp5oSBm93x798g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLT7WPdi2uPiBxugEi1g3oorIIuyZp16E8WWzZYitPI=;
 b=tNC0wjJLAYzWgjtGI6KgbVdNOhRSQqiMbeyvtAuWHF2vUOMdxsHRze9N/HL55EzAElZF2q8tss/P9z172hQZd+teKGdiMpM3BfCLoimz4YetrFrpgXmIWJLk1oBfl2PC6JdhZEgh4ODJrglzacmKd7LT+gJV2rmZiSR/hCwIUnOI7yZYlaoVkOFUpafNO2UJT0u8f/QKzvhmDIRztPbQBV/WuUt49iiE6bg7hhv5mp8py3AQUBpA0rycdoU/W5jZZcjEZ22s3wNR4laBW4Ga36H3a8AGnkmz6jylRbsTrfmAh/2oAA4ZI/BIlYgdZ0XVWA9Xz6xLSqeWLlQ4NDT7nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLT7WPdi2uPiBxugEi1g3oorIIuyZp16E8WWzZYitPI=;
 b=LZSDclCNXvsL6+fHEeZzMTFWkvcJbEWm46j5Kb1gSo6EagIIUImxBDVemNHm9y2Os4LwKPUbGbXUI70LWGykXCVGVIJZ3cXdu3IVQHpL/P6UOCogK5iUcrDurmCCFtZJq1cwsVGiTuO5dZh7oavmTn5piE0neje7MrJMRNs35Xs=
Received: from OS7PR01CA0253.jpnprd01.prod.outlook.com (2603:1096:604:24b::10)
 by OS7PR01MB18246.jpnprd01.prod.outlook.com (2603:1096:604:4bf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 16:03:50 +0000
Received: from OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:24b:cafe::37) by OS7PR01CA0253.outlook.office365.com
 (2603:1096:604:24b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.11 via Frontend Transport; Fri,
 27 Nov 2026 16:03:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D213.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.5
 via Frontend Transport; Fri, 27 Nov 2026 16:03:50 +0000
Received: from [192.168.1.200] (DEU-5CG63502GH.adwin.renesas.com [10.226.92.79])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 1BA90300029D;
	Sat, 28 Nov 2026 01:03:43 +0900 (JST)
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
Date: Fri, 27 Nov 2026 16:03:09 +0000
Subject: [PATCH 3/3] tty: serial: sh-sci: set the RSCI RX FIFO trigger to
 half the FIFO on G3L
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
Message-Id: <20261127-divo-ssgrlpcsrc-2996-rsci-rx-fixes-v1-3-cad6ce9f83bc@renesas.com>
References: <20261127-divo-ssgrlpcsrc-2996-rsci-rx-fixes-v1-0-cad6ce9f83bc@renesas.com>
In-Reply-To: <20261127-divo-ssgrlpcsrc-2996-rsci-rx-fixes-v1-0-cad6ce9f83bc@renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Thierry Bultel <thierry.bultel.yh@bp.renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Biju Das <biju.das.jz@bp.renesas.com>, 
 Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, Diogo Ivo <diogo.ivo.sx@renesas.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795795401; l=1537;
 i=diogo.ivo.sx@renesas.com; s=20240529; h=from:subject:message-id;
 bh=J6q0ITBZ4TpFdU+l+gbI6MX33obAswgOIoXbFANvxvs=;
 b=6YvEwcZZ5FhRnwsM7NHM35FI4lYT1wp6Gn1KZO9RjO+6Bn/Dfv/BbNTxhaSnN3PS7U50su9Pu
 hLGHM4OQDY9BZ1/LTY7KRzosa+cku4MKVoX1QhaYO4vkjMRVrqDc8Yq
X-Developer-Key: i=diogo.ivo.sx@renesas.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D213:EE_|OS7PR01MB18246:EE_
X-MS-Office365-Filtering-Correlation-Id: 853a5bfb-0993-47dd-3e92-08df4ca00724
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|6133799003|18002099003|22082099003|56012099006|261028144727099003|11063799006|261021123027099003|261022105027099003|261009223027099003|261102123227099003|261021121427099003|261026140227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	BICiSwHYP+R6+1b9GKFVoEC8V9lnKB1tNX0SRc7F/zt3ERKSFXAhF+FxkyfcEunnWsTTm4V19yVDp+zg04k+ODjtM4N0LOvenfnLeL+8eCQPi7JtrtbpxspJ/2GkYbELBIaPMKqclIl9b8uOmtnicjfDww4p2FpIw0jMM8ow/Lf1FMETkIC6eqiejrv3UErcoKA1kZmJVdC1Rjn6I3cJmR+7Mo6Vv2nEirqDWSeAK5t4NPNa84tks9E0/18WoF6Ah3OsvIfuWpL9+b15/NRB+Y/GeqR8X2XFrrwTrAYfj3hLgPyj9ae/2mPaVeFxl3oLHiBZHM3pmAFy8SblnPS/AE34HalqmWEa13hUQJZ3QtNhgtkJQe0Np5ux3IbhJe5pgGR2xfMi1HVC4O0hdcNU9csIOPxfLK0ea/x134noOjTLXQl76TcQViF5uSDWF4WV/s5tpVsyV6eWHUVIK9LHyO0CyaTbgqy3JPDcsq+RDlAz13sbxrljQSo7UU9hDJYRmRF/KZQPgQtbgiFXanVjhQV6cPvE/9dNWC4Mop3rkzKM132hdcmRdKXkdfQvXdQoRpewhRvyctQ66F2mPwDb2kMuqQHipiKji7gEyla72ludEy2t2gzskGgNarLPk+QOKzrsoOy2bN++C+y8V+yIx9FAc6BNL3UzFvellVWSHDc6qYDykbVTev323r77QQhclOjsPWB0BLXUJyXsWIyp/A==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(261028144727099003)(11063799006)(261021123027099003)(261022105027099003)(261009223027099003)(261102123227099003)(261021121427099003)(261026140227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HWcxQhB+1EkbprFeK/7mpQL7xWpxnWJ9290gO7s/0aRGTAx82QYNjsM6Y3BVyYebwqCVLSnzioWau4PGKYQ7Njf8EbzGXgkQSjM/bWVhhd6YQHxMF6Zrvy9nYHW2Xf1FBydifbW9NyGS06a/Tp14diKrxP3ix+fjNFkcGe5YRkpfF+V4lUxmKL6rA8CCown3+Sn3CsY2VoW51xKV9APk5lD4mUE/cUk0GFipRp6zuR9f74/q+vAJf03gRJ5Q1sc+P3hir+xPqzJojRSaaCujPWFuwiLoy+g6xL9pbuEW5Op6Z3o9coaVN+Dc2QQz6rmYlPtr4VT3koVOAzpHvABul4wonrKkV8JDmYqMdK3qxmUhKa5Qor3XP8hGDCwlqyRcujfBfRBnn77hRZJv/M9ieJ7VvWapmoA4DQnJ190kNSv3ATFazoEFwqlSCsoFRV9Q
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 16:03:50.7561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 853a5bfb-0993-47dd-3e92-08df4ca00724
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB18246

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

The RSCI port types ask for a RX FIFO trigger equal to their FIFO size,
which rsci_scif_set_rtrg() clamps to fifosize - 1. RDRF is raised once
the FIFO holds at least RTRG bytes, so the receive interrupt arrives
with a single byte of space left, causing overruns at 115200 baud on
RZ/G3L.

Every other port with a FIFO triggers at half of it, SCIF at 8 of 16 and
HSCIF at 64 of 128. The only exceptions are SCIFA and SCIFB which set it
to 1 because they have no hardware FIFO timeout and a higher trigger
would leave bytes in the FIFO.

Trigger at half the FIFO (16 of 32) for RSCI_PORT_SCIF32_SINGLE_TCLK.

Cc: stable@vger.kernel.org
Fixes: 8f18d3cbd920 ("serial: sh-sci: Add support for RZ/G3L RSCI")
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Co-developed-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index dcd97f9b5268..1ab0e5677791 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3348,10 +3348,10 @@ static int sci_init_single(struct platform_device *dev,
 		sci_port->rx_trigger = 64;
 		break;
 	case PORT_SCIFA:
-	case RSCI_PORT_SCIF32_SINGLE_TCLK:
 		sci_port->rx_trigger = 32;
 		break;
 	case RSCI_PORT_SCIF32:
+	case RSCI_PORT_SCIF32_SINGLE_TCLK:
 		sci_port->rx_trigger = 16;
 		break;
 	case PORT_SCIF:

-- 
2.56.1

