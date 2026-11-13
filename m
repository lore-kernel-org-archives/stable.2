Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794594639;
	b=TN40KNTKEAOcmxf7cVAQEQoTiJLHqwWw/vqXK8tb4KA7jEZmR1gMY52vf546Oq2CMwi1
	 uUTIqLmXReyAUHAUDQFy0Od1Co8ckH86RFyf+VWz8gPdzVHnOywWBKIb/3hSJqRlWw+o7
	 oOOcds00V1ZInfWkB2O+KJpgcGprnaDHjTxhw7AVlMYGDiOPBiY/zkQ+kDJlqCgBGM+2J
	 xnZdS89Rrt8eIOfiW2f+FSIAAChx81mZ5QShHWIH8GY2adO7wMBiWz2eYEL8Tr7ybZaGl
	 gpkjJf9Z5u3Y73Wvz52e01O0vfZOPskoIeiX1cWxPQgcJwapfOlbsq2CeRyqs/L9zHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594639;
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
	bh=92c+DcN1UKbeJPyyFfeACMA0ymIAhNKQjubGX/YwzEs=;
	b=3ou9qqqRxdJYE6iC0ilIgvWfOVFadvYwr0X2YRI17NALteMQ6wt8R/Y1krq1AW9eFDiR
	 naTr/kyOpwaPzOX5sw6gP4ZzEQxXSbS7x8emH9nOq6yReVGS743agAiLpB6oygI+FFwa8
	 EGwsaECuey0V47uZpnwzepnuBA7pfD1njWW5gQYbmNoY2fXaisv4OJQnwI3+cPgvD0/aj
	 QJOyl8JV2XkiJLRx6pA9v28WsHyt6hnfUdSJNRWhDYSlQf+74VSOAs0AS/roVGLluNkCv
	 19Tc2dTax5NFoSPTeipWavNUttnMUvxMFuJygGYD9319Ov3YJX5lDxNBoaNNywj/Byg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=Ktbwmbau;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.43
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011043.outbound.protection.outlook.com [40.107.74.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A945A606ADAE;
	Fri, 13 Nov 2026 18:30:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A945A606ADAE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=Ktbwmbau
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFokFWsWMdv75dDxdiBeokAdsUKo5bsutQwGXmOHadJh/9RsBD/o2YmbgZIvpwCiMdFE8EPrZGQS+ZB61KkJ6Cu+S7OYQZMnAzUjr7XD2c8kc1XUeytekhRwKdEx3ZRKEwVtArR4eVM/sB7P3JooNJJNU7rDfycE3lGygOkRF3D5HkQHLGYTOJ6kfxlkCX1sMeQ93fUngH5eosAJtuitKgsW+fmf2DqZy/uffA+zlBE5ETG2JybfnljvdNDGEuPiLhavHlNISEk0ACPzNXOuOszzsuM+VGbdD7d4broaCHoyaFxykVgPADQknLD3/5l/k/oaNlnnSlhB9dCljhJwuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92c+DcN1UKbeJPyyFfeACMA0ymIAhNKQjubGX/YwzEs=;
 b=A1GvZ+Q0TIVXQ+hUk7XcJMDiwXMI2IbyRK1lX4OiJ7zM/0QVmQfLT1PNH/O/8eIzraoPExMRekpaJKccvahGG5YaHCL9Wq7SdEdyH/Py3eokw1oeGvO+sg2AlDYg6W7XXubh/TPZJUro3i+/ykC8Gujq5RBNv5KrSsEvV84InDrWK7yU2HbdPe1HSFX9MbZVd5GRuG3auOc+brk/AUEIBawbjWr4WrjfN6+umdl10ub0oOv48VnfpzXaTeOu1h09MwJQx+u8+Ajvc9FgTV94Sc0X2yvawtigcNupbPtBa8ClXnLcAJcUE0np6/ELhz6RbV8+PsqBeewUfRW3VyTtLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92c+DcN1UKbeJPyyFfeACMA0ymIAhNKQjubGX/YwzEs=;
 b=Ktbwmbaunrmpa7DGVJYN65po2IN8ZyD3rtssWCnyW1oW4mMCgw3wwoB5f3CRBfjWjuNBrVmF3kmD4lTbiv9xCFBvEUYi3mFUfNpLOBHdyeGSjG07HkXYBn/N9OPiOOpaN98eZu+zxrDYlrQlKV5JkT7tLl7Y/ARGTex8F9COU+U=
Received: from TYCP286CA0059.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2b5::16)
 by TY4PR01MB14007.jpnprd01.prod.outlook.com (2603:1096:405:208::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 18:30:34 +0000
Received: from TY1PEPF00046B4D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5:cafe::9c) by TYCP286CA0059.outlook.office365.com
 (2603:1096:400:2b5::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Fri,
 13 Nov 2026 18:30:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF00046B4D.mail.protection.outlook.com (10.167.253.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Fri, 13 Nov 2026 18:30:34 +0000
Received: from [192.168.1.82] (DEU-5CG2204K0P.adwin.renesas.com [10.226.92.17])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 2F7AF300022F;
	Sat, 14 Nov 2026 03:30:29 +0900 (JST)
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
Date: Fri, 13 Nov 2026 18:26:28 +0000
Subject: [PATCH v4 3/7] serial: rsci: Enable transmit end interrupt in
 rsci_stop_tx()
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
Message-Id: <20261113-g2ul_sci-v4-3-6815e41d90c5@renesas.com>
References: <20261113-g2ul_sci-v4-0-6815e41d90c5@renesas.com>
In-Reply-To: <20261113-g2ul_sci-v4-0-6815e41d90c5@renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
 Au Dang <au.dang.jx@renesas.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Thierry Bultel <thierry.bultel.yh@bp.renesas.com>, stable@vger.kernel.org, 
 Diogo Ivo <diogo.ivo.sx@renesas.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794594615; l=1413;
 i=diogo.ivo.sx@renesas.com; s=20240529; h=from:subject:message-id;
 bh=xcBeSFVfaCz/yRGGk8Y2jCIghvBZbnAAuSbbBWNHnqA=;
 b=wsWH26b6pZcuru7KqZloJRlTi8EGgE+bFJoVTlQnLtnMtAOtSeoibuxSRsVczP59Z7Wkf0Vg6
 t5tQTv59lGYD1RahdRpAJ9g3qvH73qmWFMA/2CA6ghLAvxCaC0VNk1s
X-Developer-Key: i=diogo.ivo.sx@renesas.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF00046B4D:EE_|TY4PR01MB14007:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bef6280-2582-4532-70f9-08df41b434bb
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|10067099003|11063799006|56012099006|261022105027099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	cvYSAB3uLyhOYpAlZQ66kMZmuw6WsrVzeV8fW//U62WLcxx0i6Phf6Yc8cXVXnVzOmNpGL79yFJ7DHh4ppmlJJHpA/5Qmv0PWeo9dscVXvhjucts8q/CJZGpMSqaR/2Ry3LzsJfo1qzYrwPcPy81CO03lWWN9/1s+2IMwTPsv9tPA/xRRUk9nKVfMbUJUW3fJ/l7WN9VLfSxNaLNee0yMFxOItnC+qyJWcorIoovSiCjjZ3N8dAZWY3wPHruS3mgxjn+7q2atIkCycnFQvtzYSfjmoqxOkMO9fx/El5S0xIfvnLCv8oD7mVxG/qaAnB8y4aiqcXEpyzol4KGmIjxf3LAdysiWNaAiAsjSOtPSayfsK7Dz0QGa/4yK9ANT3ARiLjYCSqoJwLJrqkgKqpCslfCo6vAJa2FgBbW3s5j5OFG4dfCr+hmes4UiNMJY1mtbwFvEbP3uZ7R4gkjOPEXCq8oJK9MJhPHAy5ny85S5L6AynTIc8OAqWaJjjIDd8avwjJ/6o31V+Fec1LWKsTDSxFkEQ1L9JpB33LKZK28EwJSvPbwQtXsphhOrFci6lUfUZctHdDyMsQgiDPygfJIfLRj50qOtUb7+lsyaFzki+dBRnqEnjbWpFV5qZz+Lzf9Q58vjtE0YwmXpoiUxt24tIObfLk/BZ5Q6AiN9ljDOYdUXw/Zu+0pQJYNqoAzX19YxcvRT3dKHota/9PazlJOFw==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Riyy0oWzLfDMZ/MY0jShIsFrcSNHgnpvFRrZNEG2hBp3RfQkB9DEuQtiWrEoPTYT3g9FUOKYxb9eMUYbVMLaNxnioM/Uyf2aiaeAIk+/k8Cixdfotv8NIYq3Z0pNBULDcFrRTH6XMlP1/J9mO3RIx6jHoQ9nC+b0Avr6d7yO8pzmn+ThnaDbVLn9jcbaiMZco2OwfJ2JgCqmTKVxXATVFjxD2bh/Ia2SBRBwHELPC+B8es0PamvIELCCha3rCCsSzU4Tg9rnswO4d4ILI+zd4aq0vS44uzBk2X2EvNNwrIOJ2Qp6KCMbgTSBhbt/XhksE7Q5nf7OTU6i/F2UR6zEsiQCvWKE7ZqsfeELlsQST75xaJTPQ1Y7nljhcqNjZYZ3adIzJlRD/rvsYfuA+GTZcuqUydWlXaROdf2AyGh+EIvzoIDzpvcD4wWedWMTNQLp
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:30:34.4003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bef6280-2582-4532-70f9-08df41b434bb
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF00046B4D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14007

Currently, rsci_stop_tx() clears CCR0.TIE without enabling CCR0.TEIE.
If transmission is stopped while CCR0.TE is set (for example, via
TCOOFF), the hardware FIFO drains and sets CSR.TDRE while CCR0.TIE is 0,
and no TEI (Transmit End) interrupt is generated to clear CCR0.TE.

However, on RSCI setting TIE while TE is already set does not generate a
TXI interrupt. Thus, if transmission is later resumed via rsci_start_tx(),
setting CCR0.TIE while CCR0.TE and CSR.TDRE are already 1 fails to call
into rsci_transmit_chars(), permanently stalling subsequent transmissions.

Fix this by setting CCR0.TEIE in rsci_stop_tx() whenever CCR0.TE is
set, ensuring sci_tx_end_interrupt() fires once the hardware finishes
shifting out in-flight data and clears CCR0.TE.

Fixes: 0666e3fe95ab ("serial: sh-sci: Add support for RZ/T2H SCI")
Cc: stable@vger.kernel.org
Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
---
 drivers/tty/serial/rsci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 0391111db8ae..05703bb31afd 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -409,6 +409,8 @@ static void rsci_stop_tx(struct uart_port *port)
 
 	ctrl = rsci_serial_in(port, CCR0);
 	ctrl &= ~CCR0_TIE;
+	if (ctrl & CCR0_TE)
+		ctrl |= CCR0_TEIE;
 	rsci_serial_out(port, CCR0, ctrl);
 }
 

-- 
2.56.0

