Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794958862;
	b=ZsjjDb/+xH9nYsjp2QBIzy//TbIpr/2KRWxTSkREd+67Bgmd5k43es9uliPZDKnMOaq2
	 DVnEWkkMB96l1K7OcOkVnRSdlXIk8Zr/P2QPNYTCrFyQ1SwTbFTY3GKJguZ4Xq5SvgS+P
	 lMQ02ECZHP9AhyaHeRffysjo3I8HEiVQJYigFblq7ffXcP3zviyvyvL2wJMdUUpTup3xS
	 UpIv6hwmzw81kChEE+0v6vbcxwrdWTYR37UA5F0hfzVuLlF3WSKhAX70F9wuxcoMWt94q
	 KZNyyjRaHnN6OvCCcArxvuG4bCb/qnQnQZK0u7SJFkJ6VeiRNmChra+dKF/fuW+9yhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794958862;
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
	bh=jNlHQGfnwFGNyP7OU4tePQzOLefCnARDP1qBSmW5lTg=;
	b=gKqLKrP+4+xSZcjsMcU7t539GZNPjr7i/4+hCvuRcUs8uv2jkhk2oeWgvkLQzb5NyB96
	 dzCjC3V8ryERLvswT0Ckukb4eWgTXKidUS1+RZw2iKwUZ2Ewjao+qQBpqNlyaiLsC/+rv
	 3v5WejpBYMg+KLgcBZfbum/blbC/fo2sD9KS5I2heXULalccVzE0HbAJEygI7YER6Ek9c
	 ENF9YXjRtDv9hXuI6kBjAQWBk6KrVFp58y4F26E1Ug3HzDz27u6xnUrAuMgy3c6aaDmzt
	 oagS3MSFTJMSbvQyVZco+C/jOYRNCK19rgCb+Xq7HFe9C6pWevhUsIVCwvF6cQe7AOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=VmPg2yQ3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.16
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010016.outbound.protection.outlook.com [52.101.229.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D368606A8A8;
	Tue, 17 Nov 2026 23:40:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D368606A8A8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=VmPg2yQ3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2qRT7/4wQcF3C6hETYhFoB/7yo5+nqDRe+/M5RXoJaVrEXBD7X97jZpFTXb4POCu4z9skBI/Lgfn9Yg6LBQlOkRkfDskHHfbEclyJACAxweBaDBM7aMd9p60GLZmQLyu14+hjMmSJHZdhxSEwUqkb5qo+LyF/oTRsgw7xiRvT4LVEoFUJGr+KYufn8phykhYnOr6/cSCsWHWybDb1WotaKyb5m4Bd5XcSCAj3ZDo/uhV/y7vh0+0tKg/8mldggMYh18UzPMxOUOph0nsHOgSpt0aevYUeDVoCByvYzYtRlUvBpN5sAJ/A6v+e2zSsQuJb5+M5PlvFGeTo9e0VWHxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNlHQGfnwFGNyP7OU4tePQzOLefCnARDP1qBSmW5lTg=;
 b=w0UlaXGWzAF/j+zpHFV+EskvgwWk9FsBAS7dF3fMJGeedOAcVwq4udE1x+iZEpKsV0OtkiTmrzAgpqw2pFh2MBCxnQxm22Ht8le3d/ZuS+UCAd659pciJN64EOwfFGkUv+KV9En2xWS/OyLroP2SbFpVzuaM3+I7ztgkiIACxURhjnUkdmrzDaP+jYLsh343ADqVTCg/UHVbYpoVshP3oFVUbdDGxRprlZqjKvLGJLucm3p8QVt89b4yNaQKyc7Vz19fh+2hhTt/CKqXYkYyOqKX0Jxa9QhOnZ2zZIz5NPO8oE6FnU2ADmibOIjq5o5st2y75vyGzAOb0XdiYziF3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNlHQGfnwFGNyP7OU4tePQzOLefCnARDP1qBSmW5lTg=;
 b=VmPg2yQ36LdbIUvBLqSPghJjfX6OhDq3bdDPtfehh6zrc14+wRV6qtmt3u+4JW9mXM9/I1JqP3w+nZMMQT7Atnaopi3WU5Og4j+4sB/JGyOn/NIbCJ/hH7OyhOgdP9R0HWCUfJp3/LAs78eRx111duGT6rNU2vAdB/m4kgzpgIk=
Received: from OS0PR01CA0005.jpnprd01.prod.outlook.com (2603:1096:604:24::10)
 by OS9PR01MB18209.jpnprd01.prod.outlook.com (2603:1096:604:4a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 23:40:49 +0000
Received: from OS1PEPF0000D20F.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:24:cafe::53) by OS0PR01CA0005.outlook.office365.com
 (2603:1096:604:24::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Tue,
 17 Nov 2026 23:40:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20F.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 17 Nov 2026 23:40:49 +0000
Received: from [192.168.1.82] (REE-0069499.adwin.renesas.com [10.226.92.1])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 38581300025C;
	Wed, 18 Nov 2026 08:40:44 +0900 (JST)
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
Date: Tue, 17 Nov 2026 23:40:31 +0000
Subject: [PATCH v5 1/7] serial: sh-sci: Drop TE disable at end of
 transmission on SCI
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
Message-Id: <20261117-g2ul_sci-v5-1-30b58ea18923@renesas.com>
References: <20261117-g2ul_sci-v5-0-30b58ea18923@renesas.com>
In-Reply-To: <20261117-g2ul_sci-v5-0-30b58ea18923@renesas.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794958839; l=1429;
 i=diogo.ivo.sx@renesas.com; s=20240529; h=from:subject:message-id;
 bh=25e20aaXmjb5CaefzJii2yxlL2YdB0KWoIcb8m7Texo=;
 b=ngJ/CGkM8tmttgeRGxyPawZnydBYaZAOImfT+Rkn4/Qe/dU22/cSoZUr4sgPLEXsjBMySeGg7
 vPLTAeeST1+CjGJXwRdZitfHKhqBegFNBPWLJH7YYx130/3/bLHQG87
X-Developer-Key: i=diogo.ivo.sx@renesas.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20F:EE_|OS9PR01MB18209:EE_
X-MS-Office365-Filtering-Correlation-Id: 3698533c-3641-44b5-3344-08df450435fc
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|261009223027099003|18002099003|22082099003|261026140227099003|261026121527099003|261021123027099003|261022105027099003|261028144727099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	iLPzkPCsXcREEiX5tXjep7zWiBzdK4/zEYENics7fLbCtOvcnUGHHrNPajw+8QMbxu1GsW8uXZ0GMZ0PB0KZmf94LkFUX37Eu+AlHUL5S/blk8rHw/eXnV+P+jC0fmtImRrtOplhCEOkeCDJRGlKZRDaePMghK8fVnQvVmLopUhnIMosWs1w9QN1THwHO/wUA+3lVlTdLJ7XZuQ1nrIvor+q+klcEpgRoJuXuiNHwkevZepQyS8yi0yB231NEW2rSMNfajRxbqjZuzOuuY5e5p0L0t3O8o3WhFMjhx3jI3uTVwUm13nj2EmYU33Fik9rtG/Ej/Tb+MSUCMqNKQchkhaxuvMXbxceOez9cidtWmOGgXQ4QDU0XvK7mYKe7Fz/2akHH9dfYuzjfoGLYw14Ko+ipPTo64rRCe+uXNjoENekYbq8QdlZ1gdThXjW7x2pKUrb0tVCCpv4Bf+rXsepkoX2nDThJMfEv7PdrQ5n67kOjMWxOMHON+NrKxWRC1P5sjF4ikYW0+tO/h1aG7I+4Ar8rLu6uEit/+d2Iovx6rfZIdZGli6whTf3Em7Au90GwQLK+Rm7JrOTY8zhK8tGQu4AOlmZK0PLPYnizSvYcNExgj7e7e4EoVIE1nS4+ctRjaLgLKo7fGwTZS3xLA1qdPopZ7ONlxKxtSuSKbXa1BuQhR1rhVr7VMcmchDTky17BVHooRM4j5WXpxKnKDSGnw==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(261009223027099003)(18002099003)(22082099003)(261026140227099003)(261026121527099003)(261021123027099003)(261022105027099003)(261028144727099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7Nonsr3684QgypxrFJ0x0OQxL6KsGswkRgd1GtjO1V+fICs/C5NXeV936fpwm28QSz2FWlTyD/67O0et5gyBt2rEYUTCp09Y42owcpuMp+dYBs4ots5BShigBiL6FNnEcRxjZiESQKaSgjKA9wChCfOw5lSE7IDjs0wTXawfddxb2++Z8irmzTA5eOSCIIUBzVDIuLL1/x9RsTgf14sGAakjiJvGt8CHhauN+/c6r7AN4rPcczTpq1CmmqRSxwsM3dK+Kq0s8gy8WtjbnuQcDIjRLCA/cmkZ+qHLuS31dcyCsfvyMJMHo49LEMHKJzORS3B0dLZYCx7GWGiFhryxM5U7XiMMIvKWJTLE9y8hpYScfC5uy42dAAFAn+sx5ZYL60vdZ+H7zxz8+akVePt9SdzPmzLNcpYwX5KAD/6tDGbVBzZa5wsT5C3Y+b4dWeFp
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 23:40:49.7169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3698533c-3641-44b5-3344-08df450435fc
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20F.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB18209

From: Biju Das <biju.das.jz@bp.renesas.com>

Commit f06c2a9000eb ("tty: serial: sh-sci: Fix end of transmission on
SCI") made sci_transmit_chars() clear SCSCR.TE and return early on
PORT_SCI once the transmit FIFO is empty.

The hardware manual does not describe disabling the transmitter to end
a transmission, so this special case has no basis in the documented
programming sequence. Remove it and let SCI follow the same path as the
other port types. A plain revert no longer applies because the driver
now uses a kfifo, so the code is removed by hand.

Fixes: f06c2a9000eb ("tty: serial: sh-sci: Fix end of transmission on SCI")
Cc: stable@vger.kernel.org
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
---
 drivers/tty/serial/sh-sci.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index bd58bbfa65aa..9eb297dbc901 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1036,13 +1036,6 @@ static void sci_transmit_chars(struct uart_port *port)
 			c = port->x_char;
 			port->x_char = 0;
 		} else if (stopped || !kfifo_get(&tport->xmit_fifo, &c)) {
-			if (s->type == PORT_SCI &&
-			    kfifo_is_empty(&tport->xmit_fifo)) {
-				ctrl = sci_serial_in(port, SCSCR);
-				ctrl &= ~SCSCR_TE;
-				sci_serial_out(port, SCSCR, ctrl);
-				return;
-			}
 			break;
 		}
 

-- 
2.56.1

