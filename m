Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794594637;
	b=HmG2WuNuyqC+hx3zBzf19JVXnSoGzIaC1AxK0lDShAzClyFVYD+eLPPQRml1aUdWYj9h
	 YwjdJFNMkRYiPGr+TTm4wkZLUtiANT5+zJ0vJz48N7lryr0LxntwmIyFBQnRb9jlJYoUU
	 i0aaVsP7xjumNKgaZMmmZw1g4Ibn1I9gUdaYPjZ7dzYwb9hvqcjhoW4Kcsc5JOA0Vmw+u
	 8Ku60ljrKVU3/dd5nF3F497iWAGYrcllcgAhTK4ba5/stB4Rw1uiiymMRwi3ZaFUFa43V
	 MwdPt0+878z/A3nwMZNb0GfK5QPnRacGUwkpCCrVGkj4HnnisylLoiH8RiQyT+mlQkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594637;
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
	bh=NFgW8HannlWpgtysZC0IdKJvSa3gqf1E28oCgxEbuHM=;
	b=ITgDDQuQUqQ5SJEYMgGHDsIJkdJdyaEpN+jJ1cB1kX/ypWdVVrPi1hThAcjwc3jBle9q
	 MSMmWnrS612hii+v2inP4In/GOEuj4W02bcvG3CIWUsKPU8iI9DY9Fy87Z6ObgFPlIlu7
	 PUNspqNgGeKlbt0uLPcKQk12u2XUE0BsS/XYGnALbGim9cyAq/T6s8f+YJLUCVIbwpBiH
	 imzABoblaFLmWgnHB5mbT77hiLzp8eaSCZxDCoqbZ4rwYWPitaDH4GhBTVTjAX4eaVbzI
	 R2TAcTG4Sj7rpK6sllqIOjurNx8tG40ZH0eStoPxSEWpsT/YgCE8RkFYAvrxjwh62DQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=JHvf71Sv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.21
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010021.outbound.protection.outlook.com [52.101.229.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF88606AD9E;
	Fri, 13 Nov 2026 18:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EF88606AD9E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=JHvf71Sv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnAOk7ESReL1KZcJegWwNUcsLPHkziqlnWX/k5w/augYl0ZsGsPFT1JIN8SJ/mru0Jc5DLcHPnAMlZObtUYcIU7MuaxRjkpVjiTHydwWH47fpFQ5+qIk4Jvy5Tt59ZFIWmyfZVLhEhHqiNnsLIk29IO8+oe0T7s9DNFsOxembOQ5MfA36rkd1H432yrI6JafsaS5KU13mRDJpzX9DDJCfMvxk3JvXFngnLVFVBb6mc2mIVEcyLocyXm09153uJAKnTHPV0U6lqAY4yLw+5ZQpaD1ts6TzC4zS7BZOcN1el2YSrpfDc0NAuMyp9d7Gf//eLjjub4WmBPkZiyEXXbWRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFgW8HannlWpgtysZC0IdKJvSa3gqf1E28oCgxEbuHM=;
 b=N7lhvNk5tCd03gXd/mKEsxcNVabxwGqS+NSXUAShH6Uztfiv+JualN2pBgRCCesU2XCYAFAoeectpL1Q5rVhCUjXPXTziJ5BQulqBjJx/zh8NWKdEUxFCXehJs6MBtqXtDH5365ZRsYpK5v5kgM4A36dReTTwFt8STnVxMaMXRlrGnStZcsDPaF+yh9MllySH58FJM2zocu5ZgjDyn+pNIojndfRj3dywS0QW7XIfLM+azsN8qyJv0p9jzzf18QUqd8J+m+2q6uazpqFso/Mu6l53S9bUfjJ2rSf1L1AOrJB0eqtApZyXE6jRcK3fQQlT4wa0PWTTU6TnwRRlAFRpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFgW8HannlWpgtysZC0IdKJvSa3gqf1E28oCgxEbuHM=;
 b=JHvf71SvbJSYGxRrU+2UYGTjrqZMBqcFT4bFGtkPCjV0M7LDenRe+itdyeVjvEPWdktjdSafPpS0X7RWsZXUhD59KzBwwdX2QRnuXEuznsUKn2YlxwbUZDdKyKPKacIliSEytrghjlywLHxsO2Fuhl52wMXaE4+JkTZaE/x0vO8=
Received: from TYCPR01CA0173.jpnprd01.prod.outlook.com (2603:1096:400:2b2::11)
 by OSOPR01MB12186.jpnprd01.prod.outlook.com (2603:1096:604:2d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 18:30:29 +0000
Received: from TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b2:cafe::2d) by TYCPR01CA0173.outlook.office365.com
 (2603:1096:400:2b2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Fri,
 13 Nov 2026 18:30:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005622.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 13 Nov 2026 18:30:29 +0000
Received: from [192.168.1.82] (DEU-5CG2204K0P.adwin.renesas.com [10.226.92.17])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 7FF1A3000231;
	Sat, 14 Nov 2026 03:30:25 +0900 (JST)
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
Date: Fri, 13 Nov 2026 18:26:27 +0000
Subject: [PATCH v4 2/7] serial: sh-sci: Keep TX enabled on TEI while data
 is pending
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
Message-Id: <20261113-g2ul_sci-v4-2-6815e41d90c5@renesas.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794594615; l=6119;
 i=diogo.ivo.sx@renesas.com; s=20240529; h=from:subject:message-id;
 bh=el2BVdpbTbDYngYt+B6sLQNnZW3tz878NrxeJQQN6Pc=;
 b=cgxXPPIAdrtqK95x4UrM2PUFqA/JwW9V0RIou/dI8ZOxunlsmdieyrNzdqJJd4qNPd9HjT8L4
 s0ls2uV0Sw3ABMIOpAdgeGjwcF4uxiIb5v9UwkITpEXuRFFFAR7T1BF
X-Developer-Key: i=diogo.ivo.sx@renesas.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005622:EE_|OSOPR01MB12186:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d95673-19ac-4a8d-a98c-08df41b431f2
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|10067099003|11063799006|56012099006|5023799004|261022105027099003|261026140227099003|261026121527099003|261021121427099003|261028144727099003|261102123227099003|261021123027099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	mQOQTN+eLv5gDA+rO6Ax/Xos0M+egT62zQYFI5CUbaqQgBPynOJb7Xd78RUVKnEUFs/vO3s1BFQGM8FLdo2SKMPQj5hxUBYlzygTYM0oT8bHZkyw/1F3IZxuPPfK7Btg4dNOG2MpI8hHb4CJAKoeeUnpGMYH4vo5huVbXAWJQctPbqDKodqw4t87Gts+/NdtCLqpHWSAXYWxlzNemsemU4feXLqi9/f9quBl7j2lNaZrmtPCJw/m0ItGnIAJwxpFuhSdWi80+0alvrHQSlVeRTPHVP5z5k3hiH7n+IBxIkQQIOW09Rjlg4yNbvJPuIGNAWd1gtTYRxdggtWz7Ak0MGCO0XrNGYkgpxbukK05ZWqHh8sIqWKDNn1hJrEh3ip8NlxQ0A4JAVscjD6TJ5awIAdgvAE3IljfCsRg9jzUp/ODnGiOiut+CwM546L6iUyx+vmdP62nKoGp6/wXaZc2YVXzxSHSZDQe6mIakCLtd72DDA6w7LqZtgu92pkjEVQ6NhoG/7ALHdwrFYDd7V7QUEmTnK5uiaA0RVhZs7rYl1juDtxRUSdbk+swzqgRKF3S/ijOMJl9WFjg4JGkZlQv1VzxqZItt03X3+GgfZ1iv//W9Owv+0wbidoEtRh6s3vmUv2t1DhYCeDabDZS2TLQCF8N3cFNFKChTrhC0oNX3OETxedgeAsbCp0DopqR5yvc
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(11063799006)(56012099006)(5023799004)(261022105027099003)(261026140227099003)(261026121527099003)(261021121427099003)(261028144727099003)(261102123227099003)(261021123027099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Vg9XoRM/e/FVKIbQFIrD9kPi4ccJaSUbBLQNnJf2nd+0SmHf+rN3JW+CYLh4kGDFRczrbrZO+Q9uHqHl1WG6tT8FqtGZPxIuG4BiPIxSnMeUnIuBTmSbwXKir40WdZ/VSS7hlD6pcvmJCnxJxGzHMZySMyhax48kbumhjEolgTK5y0tfuHRChqJj3RqcjMEaz/WA9uUQEnr5fq0QRV67sKCb3ZcKH/vDKsxkFhsaFNMdSQExLEHVn8unpqwJv0gDYYxO69HAl5+DDtW3adNZ//asuNbCNUdl1zjPUQo7Q0GsT37hhlTj909xiq34aGBsYyO6mKnc6DpZrun9jDDCkiU2R/j5tj1RqVcw404gV0/K7syiW/+OvI7F5oy2IqSSDH9BLCzZQUOvp7S8YgsQkh9ZbHrctnV2kJjS57v5w3d5+1zmMWWJYdFhslyQQXla
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:30:29.7297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d95673-19ac-4a8d-a98c-08df41b431f2
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12186

From: Biju Das <biju.das.jz@bp.renesas.com>

sci_tx_end_interrupt() handles the transmit-end interrupt (TEI) on
SCI and RSCI ports by clearing TE and TEIE, which turns the
transmitter off. It does this unconditionally, even if the xmit kfifo
was refilled, or an x_char was queued, after the last byte was written
to the data register and before TEI fired. The pending data is then not
sent until the transmitter is re-enabled, so output stalls or is lost.

Check for pending data (x_char, or a non-empty xmit kfifo on a port
that is not stopped) before shutting the transmitter down. If there is
any, clear TEIE, set TIE and hand over to the port's transmit_chars()
op so transmission continues normally. The existing TE/TEIE teardown
path only runs once nothing is left to send.

When the port is stopped with data still queued, the transmit_chars()
paths (sci_transmit_chars() and rsci_transmit_chars()) now also swap
TIE for TEIE, as they already did for an empty kfifo. Without this, TIE
would keep firing with nothing the driver is allowed to send, and TEI
would never be raised to complete the transmission.

To keep the handler independent of the register layout, add tie and
teie masks to struct sci_port_params_bits and populate them for the
SCI, SCIF and RSCI variants.

Fixes: d61ae331d6f3 ("tty: serial: sh-sci: Add support for tx end interrupt handling")
Cc: stable@vger.kernel.org
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
---
 drivers/tty/serial/rsci.c          |  4 +++-
 drivers/tty/serial/sh-sci-common.h |  2 ++
 drivers/tty/serial/sh-sci.c        | 47 +++++++++++++++++++++++++++++---------
 3 files changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 40db9daa4272..0391111db8ae 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -465,7 +465,7 @@ static void rsci_transmit_chars(struct uart_port *port)
 	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
 
-	if (kfifo_is_empty(&tport->xmit_fifo)) {
+	if (kfifo_is_empty(&tport->xmit_fifo) || stopped) {
 		ctrl = rsci_serial_in(port, CCR0);
 		ctrl &= ~CCR0_TIE;
 		ctrl |= CCR0_TEIE;
@@ -627,6 +627,8 @@ static const struct sci_port_params_bits rsci_port_param_bits = {
 	.rxtx_enable = CCR0_RE | CCR0_TE,
 	.te_clear = CCR0_TE | CCR0_TEIE,
 	.poll_sent_bits = CSR_TDRE | CSR_TEND,
+	.tie = CCR0_TIE,
+	.teie = CCR0_TEIE
 };
 
 static const struct sci_port_params rsci_rzg3e_port_params = {
diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index 01ff9fced803..273856fbc20b 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -56,6 +56,8 @@ struct sci_port_params_bits {
 	unsigned int rxtx_enable;
 	unsigned int te_clear;
 	unsigned int poll_sent_bits;
+	unsigned int tie;
+	unsigned int teie;
 };
 
 struct sci_common_regs {
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 9eb297dbc901..6df25fef5a5f 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -261,13 +261,17 @@ static bool sci_uart_earlycon_dev_probing;
 static const struct sci_port_params_bits sci_sci_port_params_bits = {
 	.rxtx_enable = SCSCR_RE | SCSCR_TE,
 	.te_clear = SCSCR_TE | SCSCR_TEIE,
-	.poll_sent_bits = SCI_TDRE | SCI_TEND
+	.poll_sent_bits = SCI_TDRE | SCI_TEND,
+	.tie = SCSCR_TIE,
+	.teie = SCSCR_TEIE
 };
 
 static const struct sci_port_params_bits sci_scif_port_params_bits = {
 	.rxtx_enable = SCSCR_RE | SCSCR_TE,
 	.te_clear = SCSCR_TE | SCSCR_TEIE,
-	.poll_sent_bits = SCIF_TDFE | SCIF_TEND
+	.poll_sent_bits = SCIF_TDFE | SCIF_TEND,
+	.tie = SCSCR_TIE,
+	.teie = SCSCR_TEIE
 };
 
 static const struct sci_common_regs sci_common_regs = {
@@ -1007,6 +1011,20 @@ static int sci_rxfill(struct uart_port *port)
  *                   the interrupt related routines                       *
  * ********************************************************************** */
 
+static void sci_clr_tie_set_teie(struct uart_port *port)
+{
+	struct sci_port *s = to_sci_port(port);
+	unsigned short ctrl;
+
+	if (s->type != PORT_SCI)
+		return;
+
+	ctrl = sci_serial_in(port, SCSCR);
+	ctrl &= ~SCSCR_TIE;
+	ctrl |= SCSCR_TEIE;
+	sci_serial_out(port, SCSCR, ctrl);
+}
+
 static void sci_transmit_chars(struct uart_port *port)
 {
 	struct tty_port *tport = &port->state->port;
@@ -1050,14 +1068,10 @@ static void sci_transmit_chars(struct uart_port *port)
 	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
 	if (kfifo_is_empty(&tport->xmit_fifo)) {
-		if (s->type == PORT_SCI) {
-			ctrl = sci_serial_in(port, SCSCR);
-			ctrl &= ~SCSCR_TIE;
-			ctrl |= SCSCR_TEIE;
-			sci_serial_out(port, SCSCR, ctrl);
-		}
-
+		sci_clr_tie_set_teie(port);
 		sci_stop_tx(port);
+	} else if (stopped) {
+		sci_clr_tie_set_teie(port);
 	}
 }
 
@@ -2012,6 +2026,7 @@ static irqreturn_t sci_tx_end_interrupt(int irq, void *ptr)
 {
 	struct uart_port *port = ptr;
 	struct sci_port *s = to_sci_port(port);
+	struct tty_port *tport = &port->state->port;
 	const struct sci_common_regs *regs = s->params->common_regs;
 	unsigned long flags;
 	u32 ctrl;
@@ -2020,8 +2035,18 @@ static irqreturn_t sci_tx_end_interrupt(int irq, void *ptr)
 		return sci_tx_interrupt(irq, ptr);
 
 	uart_port_lock_irqsave(port, &flags);
-	ctrl = s->ops->read_reg(port, regs->control) &
-		~(s->params->param_bits->te_clear);
+	ctrl = s->ops->read_reg(port, regs->control);
+	if (port->x_char || (!kfifo_is_empty(&tport->xmit_fifo) &&
+			     !uart_tx_stopped(port))) {
+		ctrl &= ~(s->params->param_bits->teie);
+		ctrl |= s->params->param_bits->tie;
+		s->ops->write_reg(port, regs->control, ctrl);
+		s->ops->transmit_chars(port);
+		uart_port_unlock_irqrestore(port, flags);
+		return IRQ_HANDLED;
+	}
+
+	ctrl &= ~(s->params->param_bits->te_clear);
 	s->ops->write_reg(port, regs->control, ctrl);
 	uart_port_unlock_irqrestore(port, flags);
 

-- 
2.56.0

