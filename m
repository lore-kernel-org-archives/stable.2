Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795795428;
	b=sJxnerRh4SVXLFvDVdbzz6crTMHXzKpiqzbgSxb9W7MWIRk+Mxu9nI+Ax9JQJxbTVU9o
	 7A+NctpSM2J0dnjKdMK6be3whBCsEkU9DM4arrwGUapUjla4YuHGh9ZXDm/nor67iltmj
	 xEJLz6bArqUueefwySRzGFlbSNY6BRkmFg2dO49XSF+2DAioashdx3UYfNvtdFjnqAaVk
	 bNXlL9NmTxzuIBXN132TzqQbgNlOU33MGONUnEykdabv/NICxA+ljXxU0CgNkWqg0KHQM
	 bDHSfnk4QAvGwWC666qpAmfYFOhWjFXla5YliakPut/7/6hEIMwmFR+Z/KTpqH9ugxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795795428;
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
	bh=07fkwAeqgMBegKLGgK+uI+k/IeANHBS5leVo+kiPWqU=;
	b=l8VsJiCvTV+/nwZkXYAuHehNH365T/lMsJ2w8tmn1GQjQ5pFrKfVEUxEs6fgZsnf0aD2
	 VmZgwXMl97LCwZK//7+eLEtw9vG1QAL6Tp9+XC3qE6Eo5GdqtH2BVBwvQXAo0iolmiQVq
	 zS1siWzufX0BG3ZpiFVnYrPH0Ld5vwuMldGTleP3QIrjMq2G4miQeIvkpYbxNEvy//NW0
	 VLQr6t7vinRMDlexL2iUycdZTKKAE6bgX+h8FeTo2qidw8tbzHtw4cvCzIk0FUWqlRZNk
	 CE8W0j6P0Htrh5SRf8op6iUvbJHjgr+q3VBAUktJIIW8shKuAtRxQ8LzvHLEMwwBspQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=AHN8yMGt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.39
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010039.outbound.protection.outlook.com [52.101.229.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4005A606A324;
	Fri, 27 Nov 2026 16:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4005A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=AHN8yMGt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QS4LUzvMzQtx1I+a1diA/GY6p5ZDgrRLn6iwHZmevX9ejKIN4Ze8+tP1bDytY6ynVr7WfG+McWANubYi1X2ke2JjXmQ2iQY1uPOavdCozFgZqK1licGkQqujqPEAjFRuIOTQh8MgwFhM7BKbvMaxkc+yan7Suo4XM7IY8cKptWKl9Lzxhm0Rf5Bs5CJpKOvEmU8hiQWXpiJX+64S7YCRNszklwqk3Neg1cRDeinG7lCxQEJgZrM+qKnXJm336qIo9ricWnc/noCa0qG6FWSEooIGzozdr5IywHjNuFPSA4jGDXY+1RhxdgjAl03a396m6ox3OoRYTkzn1MVGN3cLWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=07fkwAeqgMBegKLGgK+uI+k/IeANHBS5leVo+kiPWqU=;
 b=Y4DfvL6YZmo3kA2BDFqDpSNJwnk+HTOo6FdXq2kIJcSpxxTLxSgyAVvHo/26DzPjaQHKVYgIaYsbDoytSNdlWmFqOLtF6M+qBRRYk89EPwa0c1oO5ZpGz6VJivKhrVKz3lu4NIqM6RSbttxyda7ErZVwpWuCUlQovzx9B3xz0yIvcxXmMu40vz0e1NHFcK3t4UV6Xt2T3tQYFOs+/tVNrkFsjSAXnCSe+3v4+X4pOD8vKp78w+Yi7XEvicGrWhfp4kGVokuzabkCYPGM04s1InlU26tM2UpIF7S9O8qdOfqKSDvsle9Rpo3S2G+LiwW3+LNLVacsKU9WWZhAY2UWOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=07fkwAeqgMBegKLGgK+uI+k/IeANHBS5leVo+kiPWqU=;
 b=AHN8yMGtFaPC8J6rdIlx8zECYcQ6uY/4JSXqeWLYync8J0eJeFtotDooIrdival/UKHBn6gNpoTUCKv2bjxfV6uiz/1KiJPyOvBorT6dtm2xOHNqRx4O7j9+/DTQI3qdB9tQFKeBFQQON+tqdhz2msebC3W9nGUTVQGK2TtgxdQ=
Received: from TYCP286CA0090.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2b3::19)
 by TY3PR01MB11949.jpnprd01.prod.outlook.com (2603:1096:400:408::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Fri, 27 Nov
 2026 16:03:43 +0000
Received: from TY2PEPF00005624.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3:cafe::66) by TYCP286CA0090.outlook.office365.com
 (2603:1096:400:2b3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.11 via Frontend Transport; Fri,
 27 Nov 2026 16:03:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005624.mail.protection.outlook.com (10.167.240.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.5
 via Frontend Transport; Fri, 27 Nov 2026 16:03:43 +0000
Received: from [192.168.1.200] (DEU-5CG63502GH.adwin.renesas.com [10.226.92.79])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 90F3D300029D;
	Sat, 28 Nov 2026 01:03:36 +0900 (JST)
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
Date: Fri, 27 Nov 2026 16:03:08 +0000
Subject: [PATCH 2/3] tty: serial: sh-sci: set the RSCI RX FIFO trigger to
 half the FIFO on G3E
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
Message-Id: <20261127-divo-ssgrlpcsrc-2996-rsci-rx-fixes-v1-2-cad6ce9f83bc@renesas.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795795401; l=1573;
 i=diogo.ivo.sx@renesas.com; s=20240529; h=from:subject:message-id;
 bh=ZxfPj3YC6QV2l98oiZJitelb5eJUMQDm99ydrzmtfTU=;
 b=lD/ym3LoNQcxx8S99EcTd2ioYzV2uv8dXMdi1Y9v289zxlt03TUKOX5En9cNqzdkSFi+I4mM/
 ZxfPT+JClAlD5B+NMCro/lYMP0gaVgn1L6mtvXsKW/vmcX4YZPUSyKS
X-Developer-Key: i=diogo.ivo.sx@renesas.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005624:EE_|TY3PR01MB11949:EE_
X-MS-Office365-Filtering-Correlation-Id: 46c7e96b-ddb2-428e-a329-08df4ca002c2
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|261102123227099003|261028144727099003|261021123027099003|261022105027099003|261021121427099003|261026140227099003|56012099006|11063799006|10067099003|18002099003|22082099003|6133799003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	amWxiQBQoTVMY2Kpl72MjSwnzWwwxTd9LW8U7VVzKfeduuzVoE1MwNIt9EH9TarKKs5SiEHFSJmQZHNCT+5iTQ5YQZmtZcIJQlZqiEa6Q0d/FyP66fRH8pIWtqcV1TDRerZWPhILYmKOfdnDfKqjBTRqohMh6GUYqJOZlxWoN+vAR3ucHkq+Z+kejnavrTgwsLqRRGNMVeWiEOKhFvVyMBx3UqAuMqQrteenaGxK4wmxquhumdI1WwWsFksZcbNsV+BbyqQyPzyGmOxPQXxSDM+31tVy/x25uDYvMn6IoXbtQQB8uQBnj9HamsC2kcP6oDoYRJME2AS5kf3Z/AZStq6w8SS4h061z+Iq2BeUXAZ0kXe9j/ZTwKEoFIXdFHwEf9O28mSc77+UEZq0cvAUquJcK+O4J3nCH5iP0uJi3y6BFbSH4A4Rqs47hNGEewUQO/rqznYaets6pouhLaXP6ukpaNRxgJvI3evg4T4toVpUKRSUZFZrXbNuyX64U1Z0HqkYM270QSks9XzuuPjcp40DxhS/bPXW0QGnv6gMtMP6Kdv9GqfBVCCJVCCUVB1msVjdBHrY0yqrRvxyGJ/cOLaYuyjAr6bbpXE9cJtw25RnZth0N75nnxS+qBoIPEM1X4liJ7yFo9Y+BVZlARQ60vTEHRGxcCC982m+7pHqSEEMnNH1ODwSTuR66H87a6o/HiJx9yBIT/78NrcG45vvLg==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(261102123227099003)(261028144727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261026140227099003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DdS756JBX4T8Rpelew8M7nHr0W8MleTf++uTrx0cfmc4LgDdKqQRsXT4PbGCrREEpsy1gwoZZ+wqxZ4ali10Fm6yfTnUbQ6bjCHShe92TePE0ZEjCS4GRQN1NPXM2YvL80ZPf2k+iHb/BDBMgXAzzugb2Ci7L+/1mdXkhjn69gAmv1CWogNEaqnj8uEkmP7ZmSWiGHsRe1Jmj6X6gqfpJUTcgTMLkDxOPs2toMQ8h7Pj7JI0crFj84/zZg8jygOd02Jzm/IHkIZBIpvYiNCRtNt/EdjJFqzx4Lpq0RFySKi4tGmud7HQoqUlk0HYldFRk0mDkef9upBV3knUnHayH3lUK3cSlPybxCxSp+S7XFmWLVek81V2bZVChA6mF4J1a3AVzUYeM3Ps5J4pVZbYmuqaOe8AN9inRQfc4uNPTIX3x5fVZ2PM0AECZcPGUxA3
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 16:03:43.4182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46c7e96b-ddb2-428e-a329-08df4ca002c2
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005624.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11949

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

The RSCI port types ask for a RX FIFO trigger equal to their FIFO size,
which rsci_scif_set_rtrg() clamps to fifosize - 1. RDRF is raised once
the FIFO holds at least RTRG bytes, so the receive interrupt arrives
with a single byte of space left.

Every other port with a FIFO triggers at half of it, SCIF at 8 of 16 and
HSCIF at 64 of 128. The only exceptions are SCIFA and SCIFB which set it
to 1 because they have no hardware FIFO timeout and a higher trigger
would leave bytes in the FIFO.

Trigger at half the FIFO (16 of 32) for RSCI_PORT_SCIF32.

Cc: stable@vger.kernel.org
Fixes: 42eeed6d9f31 ("serial: sh-sci: Add support for RZ/G3E RSCI")
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Co-developed-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
---
 drivers/tty/serial/sh-sci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 6c156646d5cd..dcd97f9b5268 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3348,10 +3348,12 @@ static int sci_init_single(struct platform_device *dev,
 		sci_port->rx_trigger = 64;
 		break;
 	case PORT_SCIFA:
-	case RSCI_PORT_SCIF32:
 	case RSCI_PORT_SCIF32_SINGLE_TCLK:
 		sci_port->rx_trigger = 32;
 		break;
+	case RSCI_PORT_SCIF32:
+		sci_port->rx_trigger = 16;
+		break;
 	case PORT_SCIF:
 		if (p->regtype == SCIx_SH7705_SCIF_REGTYPE)
 			/* RX triggering not implemented for this IP */

-- 
2.56.1

