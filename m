Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795795422;
	b=MPlB4zV/7HTcw2E7nbj6YUhKeKoyo8jF4n79BIig7PIgPmffE6yrncy7EJKkR1sc4MMj
	 DvDQYi1IG2CIPXpor3Wk0zv8AkV5iOy6+tr2YueqiFzVVc/ITAW7YbH6RBrY6Vg/0LaJC
	 Ts1BcEEtW6Mb2DY6/pY+n1ZQdscw7VuMjQn8fnbk4FK8OVUBtf+Ti1ctk9mdXrqh8nTB+
	 1fDg/rMJpNKupGLaKqXU1p2y5Tqkk6uqCpArLugcVXsBvS7bVLB1Wje5G19slAX5Ojsj2
	 zphAlu/R4spaN27yv8rWfxrLD+y3x47uT9nXhcFV10B/1C7G5/sF36ScT1HWsuP1U+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795795422;
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
	bh=LRvIDjg6z+gwLe6eSij+KIM8gBwWXCnjTvQwVqCHvZg=;
	b=f6zoQxVwl9+hHzTUOOBS8yhGF5H7DhhLMHCgyZWIxYDkJF+BoONXcs58GQiqXvrsDFlP
	 W1tmDXNfr53SOMXcJuBWlZDrfL9l9REgMSSQvv8+VuesaEMZwgaDQWvUtAFqK1PFtTHe1
	 1nZ7n6YbjiNl25gGLCJN62h3PaOiTxXG8gStLEVMWWeZupCKwBpsIs0D4EM/rHT2RPJJs
	 u+W/k3E3hdt7r1eOwtuqd7pICNzpdR0a3qPDK7PJ5JKM9rgRXIi38DDkFzJaJF00A7HKB
	 YqfsrRBcVMXDbOXGuPurArvNKywH8tKpLN+EBFkGp2gCTO4qFlKXwnXOFSXt5sZYReA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=BHSaDVqu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.34
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011034.outbound.protection.outlook.com [52.101.125.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C79606A31C;
	Fri, 27 Nov 2026 16:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70C79606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=BHSaDVqu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T356Nmr8AqSaN828GTHVkzKuortnq4wLMhEqBJNn7+JvAdng9SU7BJxDp0iG2MDxLMVoWjaiMuxvvBw5aTM0QMr58HTPgqrks1ZHigs9KJR4HzExxvRNypaD10BAg/0+OE4qUIKF7RMz1ezV9Yqxy07QiZkq9ZGEEeXsmy75Laks2mZ2LfNRrIT3dvvP/yp7t6FDDJwbdTIuGtjAXXoQOByW9yt00DO8dtd8L11NT+BF2kuC2iWhURIuD7IkmsL7iaekKcmHuVP8SRBQJ/g4sxNdIN/prQqLTch7KG5oRG1l9hR1IvyL9fT9OUq6aEAoYKQh3KdQodBbF9JibvUCRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRvIDjg6z+gwLe6eSij+KIM8gBwWXCnjTvQwVqCHvZg=;
 b=AzXxIMnSPBsb2M5fSyOIV1TiFiA+1k6HoinulXMpT/4MvkC33Tq4ytWd48W3bc69HtxdxpVxPFxXwX59reDoFeoQrvcGAkijksVbuL/ZIJaW/79l11BK7Nw6tp6OGywG2gutwnIvf5Madnvwd43f7v7QnCb6bLSlPsp0+k7mddayFkktksGw7S+1blx4nuFxD8/6WkuNyLHeYVVqO9FMVWv6Flgznu6yfNFRFadOwLr7EJsRTW/XiU2KOTyF0dq4O07rvJJH4GufoRvFOlvfJLobFPcOt4XXMNq7YPHxHdlTYdsNywHJnS6l8lxyPoUJqai1fO/Pds1ZH0eqvqdsqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRvIDjg6z+gwLe6eSij+KIM8gBwWXCnjTvQwVqCHvZg=;
 b=BHSaDVquNBpyfTkn01+mzzZTam4/wFIRVNFkp0oeFQRV6bbsBo5jLy9ho5lnvQGUXjSB4fwM9gHZBzpBm2FZKhqGDAeQhp/9ncBuXtVvLqBeueY29bxWyucnHr7ueOwI7tkMO6MWBlhDkVaDHPr5enHcfsymiXoSZko9S4ydNxc=
Received: from TYCP286CA0256.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:455::14)
 by TY4PR01MB13869.jpnprd01.prod.outlook.com (2603:1096:405:1f9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 16:03:36 +0000
Received: from TY1PEPF0000BADA.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455:cafe::10) by TYCP286CA0256.outlook.office365.com
 (2603:1096:400:455::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.11 via Frontend Transport; Fri,
 27 Nov 2026 16:03:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BADA.mail.protection.outlook.com (10.167.240.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.5
 via Frontend Transport; Fri, 27 Nov 2026 16:03:36 +0000
Received: from [192.168.1.200] (DEU-5CG63502GH.adwin.renesas.com [10.226.92.79])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 86C77300029D;
	Sat, 28 Nov 2026 01:03:28 +0900 (JST)
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
Date: Fri, 27 Nov 2026 16:03:07 +0000
Subject: [PATCH 1/3] tty: serial: sh-sci: set the RSCI RX FIFO trigger to
 half the FIFO on T2H
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
Message-Id: <20261127-divo-ssgrlpcsrc-2996-rsci-rx-fixes-v1-1-cad6ce9f83bc@renesas.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795795401; l=1484;
 i=diogo.ivo.sx@renesas.com; s=20240529; h=from:subject:message-id;
 bh=6IdVMD0Mv9g4/x3fRUbJegL6rIlrn7nvDRhMdnm546I=;
 b=CJN7ORkjxBdSl0sduFK5dutqlJSeKUjwvfrL4I6wl7e8DJDuPFmi+C2SdBWCPtv/zrzbJYWXw
 PblukZ8U1mvCTqEzJsugp7L1XdfoffFotckuJtPGF7qruoGBNqf0IbF
X-Developer-Key: i=diogo.ivo.sx@renesas.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BADA:EE_|TY4PR01MB13869:EE_
X-MS-Office365-Filtering-Correlation-Id: fc33731d-923c-48e7-8b63-08df4c9ffea6
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|11063799006|6133799003|261009223027099003|18002099003|22082099003|10067099003|56012099006|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261021123027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	8wVquaHp30xoZFYqorEt6EnOQPWML3pYMXNG3fu7Joy4uoklrrrAdf5A/tOurd9gXdXjobjJno7lTrAOS0Vo55inw9W0lTfEEOiE4Oz6NrA/B7WG2KZeBGIFqJvSrKdVVVI/B1CC1ny5RrS93ECfyYp3mcLqARhLhk0vvnw4P0qLd3+v8OZMB4UuPeML+eXKdLXJH2uQ5SpQSStUwiFJtzVZqCndLPba8dIbo0JigVEiNC8Wswpv0doumbInBKTKMHmQuv3MOpLQ3wysEby+izlgvPziTloFOqgkfmZjCg38ek2zHwLAxEzGqOU97aVy8kXH948W7UzAiDvgRNowF4dUclNUtbp+0zskMY8tQ6GCjxyRSNDYbj8wDOJsXAppZRMcKaRL8nzv7HcN5YTQ8GiW8Ff3BlXsOKol5KgWVF4weGWlB/jnQ61L4YgL8TAImZUOPy+OmYbbOsUBzzEy8oSlh41QGbq0DHO2exT6Qh+j6iR+AB1zlKP7OIzektxcxbCZ+knUKOxNImEg7MBGHLoFZSinLWgohG5KSwLTiEWZmwYOmjjHzk9I/7BpVzVvEJ+SXSBpHginIU2cno7rtyRwRSKWxE0+xJxT5XJrPE6VXVKsAqdkvi/x5vOXRqeNylpskKsWgrzCwoAlxxaJphONp7L58D3xY4JCuBvPUUi8LdlZIp3ueXRwuevX4pJXMrj6hEgkR9P0aYWDiKf5sQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(11063799006)(6133799003)(261009223027099003)(18002099003)(22082099003)(10067099003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KBPMsM4JS84YldhdASxRLFOnvzNPt9CeesPZ+HAElhWBrZfQ+Ggsk+R81k3m9x8SgQoFcimjw2s+VT6/74sRSDU0XTyZrVyqlhZDve2/IguFxIqK9Qy93jUuLMuGOJL2swW2wwv4sOHL1zMuTwLA7GvqYuqnsQ99vvlzlTwnrhcwCcH0e0CrzqqJEVNvHdSoE6uoIPAJe4PMfS6lblMacQhQwMDD5R98jUldIR2atHbCJ7KSrqsBx12JvsQGZYVdt9TWFBe0r+CiFq/090K9VhYQqDgUU8LkrRuQl8NDaXrUwfU5qMtcHusmFZmVIWWEBQVfFYiqj6P0lJX8EJ43nSBImB56KWInOphg32hV6AIBdl2qsbSDl5hmRkr3+EVGAf+TKgmLJCY0p8+Kq+/ayPSHwOY3OpGPAMzga4F9c9L129Ae5hyvntuMMIXbKbHg
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 16:03:36.5234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc33731d-923c-48e7-8b63-08df4c9ffea6
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BADA.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13869

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

The RSCI port types ask for a RX FIFO trigger equal to their FIFO size,
which rsci_scif_set_rtrg() clamps to fifosize - 1. RDRF is raised once
the FIFO holds at least RTRG bytes, so the receive interrupt arrives
with a single byte of space left, causing overruns at 1152000 baud on
RZ/T2H.

Every other port with a FIFO triggers at half of it, SCIF at 8 of 16 and
HSCIF at 64 of 128. The only exceptions are SCIFA and SCIFB which set it
to 1 because they have no hardware FIFO timeout and a higher trigger
would leave bytes in the FIFO.

Trigger at half the FIFO (8 of 16) for RSCI_PORT_SCIF16.

Cc: stable@vger.kernel.org # needs adjustments for 6.18 (rx_trigger = 15)
Fixes: 0666e3fe95ab ("serial: sh-sci: Add support for RZ/T2H SCI")
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Co-developed-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index f5194cfa3364..6c156646d5cd 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3360,7 +3360,7 @@ static int sci_init_single(struct platform_device *dev,
 			sci_port->rx_trigger = 8;
 		break;
 	case RSCI_PORT_SCIF16:
-		sci_port->rx_trigger = 16;
+		sci_port->rx_trigger = 8;
 		break;
 	default:
 		sci_port->rx_trigger = 1;

-- 
2.56.1

