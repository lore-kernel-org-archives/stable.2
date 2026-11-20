Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795189801;
	b=xHRWpqF2e/DKCRDUdAMjhdy+FnyWqbJA3yp6icRJSwHny6Z/6IJju63713yM/raQz9RH
	 JOt3e50PuJ1MVncy5SVCBodVKd9q9Ox44w+U4vuH5HcpnOIBgfDxkz7XS4TdJBRBGppD7
	 ogQGXiA0oTEeyFEGoIc9kOAZWOimorx7FZ7FXlE/wGQoMdSOQkKruif/o5XudpZGYo/B6
	 1jJgXXMyDI18/4Y00LsAtLSyZjxRM7GMqHoexYIlPbZPwppwKdY5FYcEobctOgWXd2+to
	 MzUVwXkA5hUBPdDhrSYdStptTYX0d7TLQHKmRLH/CyEiwwdnfJKQVhYTDPOeo3di0zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189801;
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
	bh=Pz57ncBnQLuAtRnk5ydmSamqzHQbKZpJcvEUMXy0/Jg=;
	b=JRONQYhJmvKdq4btOFUuu09au1M/wgLhQV9ZIMvDZgruj/6WgQoN0ODcqCUUbAVkqRw4
	 azRI8QY0dK1iMnrjxRKUVZvGfDuiDcPf9t66kYQlLrd8vsfTBD/PeRZ69qn9B4fLWwG4J
	 +AlxZBYq6mpTaUps+7bTKQhnufUanA9sVhMH5AOrQXgkeoG9lKOy2Ty0kW13CXOt6N9YQ
	 niIo44ZsKwMXs7S1MTpJJ6kDNl3gyoIyDeayvyKeo+2Jibk0uHidIxG306jiMT1putiKv
	 +euhk6lRz7iaFwm7D/B1efHgxdImBBDnPQvnTyXTcKHtPZFhBmOf/tfWewQCFzUvuBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=bpUP2cDU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.63
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011063.outbound.protection.outlook.com [40.107.74.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F012D606A325;
	Fri, 20 Nov 2026 15:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F012D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=bpUP2cDU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnusW5FKvebaCkhTrrIy6gjc22K1uzf4/bqBWkKE2jwOHnkPkGF15C/c1EiHc4O7FP/qoMqIhMWq54SOlZzbXBi9z7tU6F5hxHEKmCYeCCOOHQN0oB9GmThfQOqUrKV6WrM8wEystA1XX7zqToBONxHo8Z9C0EOrJxE2Q//qr4dScJKcMfy2+2AqN9k9+Jja2lfkuMaVKwySgVWM5Q/SIvnnL7IaqI9Rycsz2NY5tmlRWjtiSYxBNyBKsGKL44kb8PPlHPB01SR+A7w1bkfVVcw83k3uvxOcDhF9dVdSmVFcrADRz/2cA9C7+wrsz9NVWJ3EalUURK9mlivkhDbb9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pz57ncBnQLuAtRnk5ydmSamqzHQbKZpJcvEUMXy0/Jg=;
 b=etNGhwfDHjLjg65z76VU/FOVs/eZS9km2xZknn96kb+xgDR5BMnWwFFiNCVdJQ4OTosA9fuY3+vZw/akxcCQg7Li2UzTTMWAeR8L3/RG7yRof7BRcVrYjPrwUvSKdhlHzLknunO6BcA/S7tCLcxtOihQ9/jLc0hXzqXSUkFqjbc7as/HRoDSDoQlIkLyfHhmkEJ/h2AG7e86Yt+vuu3nP1NH8mg4jybLUxAWroEptSkYzCWaF0e8SeyTGhPbNwc36zmngIIXaiYmDX7+Un4a9OCOdUneHzQrh44mvmRRn/8YwbJOJXTs6CJodl25vHpAXNnlj/774e+B7FapSiR1PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pz57ncBnQLuAtRnk5ydmSamqzHQbKZpJcvEUMXy0/Jg=;
 b=bpUP2cDU2IxDKWeX6fh7RlhQ3iviDJvaa5m1NMu7JrA/OH9eYOFzc9YDkJ+x7YOGRlNNaAuiIznKUNpyZ043tnr/7ha31jT5zS8/YldtTlvAStdarFoxR0SnnR7ouR0+SNSGoUGfoQ5Ldbq/LBYIqDdFqX7yLi7mGMculL9Y4Nc=
Received: from OS3PR01CA0068.jpnprd01.prod.outlook.com (2603:1096:604:de::19)
 by TY7PR01MB14891.jpnprd01.prod.outlook.com (2603:1096:405:252::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 15:49:51 +0000
Received: from OS1PEPF0000D210.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:de:cafe::37) by OS3PR01CA0068.outlook.office365.com
 (2603:1096:604:de::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 15:49:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D210.mail.protection.outlook.com (10.167.240.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Fri, 20 Nov 2026 15:49:51 +0000
Received: from [10.42.0.1] (DEU-5CG4161SZR.adwin.renesas.com [10.226.92.16])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 4E99A300023C;
	Sat, 21 Nov 2026 00:49:45 +0900 (JST)
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
Date: Fri, 20 Nov 2026 15:49:24 +0000
Subject: [PATCH mainline-linux 1/4] tty: serial: sh-sci: set the RSCI RX
 FIFO trigger to half the FIFO
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
Message-Id: <20261120-divo-ssgrlpcsrc-2996-rs485-v1-1-a989baae3559@renesas.com>
References: <20261120-divo-ssgrlpcsrc-2996-rs485-v1-0-a989baae3559@renesas.com>
In-Reply-To: <20261120-divo-ssgrlpcsrc-2996-rs485-v1-0-a989baae3559@renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Thierry Bultel <thierry.bultel.yh@bp.renesas.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Diogo Ivo <diogo.ivo.sx@renesas.com>, 
 Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795189777; l=2085;
 i=diogo.ivo.sx@renesas.com; s=20240529; h=from:subject:message-id;
 bh=rn7jW2H4HXyaMaYhY6cRLSXstfKh91grVPIiucFlmzA=;
 b=8H/7AviKuOd1fcWo8GVH889L87fiWjHUM6zlxUBQvG3wvEky9tSglsr8FgA6dQukIhZTiWTcC
 0tmAY3HhjtXATmKygVtPzEaxHX7n/BNIpB24oMwovmKOnQjsMID3ZZm
X-Developer-Key: i=diogo.ivo.sx@renesas.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D210:EE_|TY7PR01MB14891:EE_
X-MS-Office365-Filtering-Correlation-Id: aa729d21-824b-4c10-23e3-08df471dea19
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|1800799024|376014|23010399003|6133799003|18002099003|22082099003|921020|11063799006|56012099006|261028144727099003|261102123227099003|261021123027099003|261022105027099003|261021121427099003|261026140227099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	/gVHSwxDjY1kXCnGXrRfC3hEkhWHOXwsl3TUfHxtpTpXp7rDjrFpp2LpLMgIc5uWjrQ/P3luZGiZVVKtn+tkaQS+m43ZkW+2TzLK/O/OSmoC1TwBOqdXIgNz4DmiCq4Ltft6MRUaxaLyOg3LdtkJTEs0L3KWljz0ZXUiDBnxBheW/MX2LFm/d4gCWgmHvZUsUZ6Q3Y7ikZuOnUnje0vPvZvburXKFju+qZl6SnTNy/7cVN8Xfg40+GTmPhosf8WZpSOiPInFYVcugZnCmSWesvTJvcpdktTf4QrsHWJ4AESW7E7PYMqsK0adG4FO0M6sO0qSe37b1rRRx0oaL0kvHOa3tqtKYSbJyrxf4h9Qvkqw2Gh2iagTR1HTkgGabu05oHBGXii6dH0meqXGr7QhCz+SmhGjsb2y0maQe6S60ebOrnKyVFxnkdChazdYqhrBYQ7TMik6gn4q8y64l162l/wsYcbWP2CIsUUGqOc7Mdj//OaDdq8KPrSaVLjeI2U8N/XAMHYtI/FCFt/T32WlMZnMppU6PYCw9z0FMtjgDqgs/hn7tRaOymRGEJGnp9ww0aWL8Gfi+b6yQK/qsRtzjHAspMyThjs/X5vsD7eyK1A4RgzJoks+if7ChFMgA2+mt1I0EG4km6ZyQxWqY7Tts4S5vYmGx3tI6NVMH6fauKa24Ejsui0vs9Zqht0h6oJXIOUoCgCDddvNPbsx5H4VeP+P/C5Lm6xc0xH+pbfMSh/9gjNrqgRYweqhB8XMPx9C
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:JP;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(1800799024)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(921020)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261021123027099003)(261022105027099003)(261021121427099003)(261026140227099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4q1MvD7pFOkAtO+n81pElC5Rful1g8fR+0pkFD5nsa74Up++lV8vbsXlLQI2Uenq1sjZbB3clldBEwczbL14R/LdBHfmK6edVTItJytPBMoYcIki5dEjfrKaxk3REz6RCxoO5RP+LFjQy/lrQSMOsiQeDhguBcEe+35ZYjcRZY4sZwxrH8u4FxsmQRi+Gcct/1aJu4N1PKmqk7js36yLlrL1cRxnEkAkQT+wIJqprNixppXqDlqWiPvfFjnT3iRMrpa/vo43WYgP+c+YT6u0YdYZR9NPbNpLTUSJX4TyOUgTsFHErv+71UytdSMAIJWiT3Qsrf4j7sf2z5d8GOO0F1H9n1sPhS9a2fxvomCGg252BOY/47Izoxvh4mOMgJV5fk/P4H4hVTecawcjhEQT00y80fQQFm08Ow3w7ITz/UdOfrC56i5Z+444i7OY4Uw5
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 15:49:51.6348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa729d21-824b-4c10-23e3-08df471dea19
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D210.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14891

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

The RSCI port types ask for a RX FIFO trigger equal to their FIFO size,
which rsci_scif_set_rtrg() clamps to fifosize - 1. RDRF is raised once
the FIFO holds at least RTRG bytes, so the receive interrupt arrives
with a single byte of space left, causing overruns at 1152000 baud on
RZ/T2H, and at 115200 baud on RZ/G3L.

Every other port with a FIFO triggers at half of it, SCIF at 8 of 16 and
HSCIF at 64 of 128. The only exceptions are SCIFA and SCIFB which set it
to 1 because they have no hardware FIFO timeout and a higher trigger
would leave bytes in the FIFO.

Trigger at half the FIFO for RSCI as well, 8 of 16 for RSCI_PORT_SCIF16
and 16 of 32 for the RSCI_PORT_SCIF32 types.

Cc: stable@vger.kernel.org
Fixes: 3a3ab10245b6 ("serial: sh-sci: Update rx_trigger size for RZ/T2H RSCI")
Fixes: 0666e3fe95ab ("serial: sh-sci: Add support for RZ/T2H SCI")
Fixes: 42eeed6d9f31 ("serial: sh-sci: Add support for RZ/G3E RSCI")
Fixes: 8f18d3cbd920 ("serial: sh-sci: Add support for RZ/G3L RSCI")
Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
---
 drivers/tty/serial/sh-sci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index f5194cfa3364..1ab0e5677791 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3348,9 +3348,11 @@ static int sci_init_single(struct platform_device *dev,
 		sci_port->rx_trigger = 64;
 		break;
 	case PORT_SCIFA:
+		sci_port->rx_trigger = 32;
+		break;
 	case RSCI_PORT_SCIF32:
 	case RSCI_PORT_SCIF32_SINGLE_TCLK:
-		sci_port->rx_trigger = 32;
+		sci_port->rx_trigger = 16;
 		break;
 	case PORT_SCIF:
 		if (p->regtype == SCIx_SH7705_SCIF_REGTYPE)
@@ -3360,7 +3362,7 @@ static int sci_init_single(struct platform_device *dev,
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

