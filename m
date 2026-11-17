Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794958859;
	b=p4zJ9ljGO/UbmzBNN9ffnyOqjYjsHltc+VQlGX5g2bW0Zhmr944BECPqgWFPC+uqcM9S
	 0f6LLDe5QO15nSAJSQAJssp8iIHul6gDMEzOgxjzQBijgjUJfgHkKi5jwYGVRF/yrLixc
	 +zBN9FoIFIwCLk7DPjP5HjTzV2l6Y2XWhS8ANKgA7CE/g35HDWmxmZwFB7O5pNO5MV5Y/
	 jxz6bglff8Ne6j/lCD57fxVMwwFrAog/W2s2ulX7/merhdXac6wf447kCq0O1tAeDJaW+
	 Ff5xEVlttAorYpw1OCiuHWsxLA2ga91Z/fdwmMlvam+n8hh1NZG7sN3Vz7Hekji4QVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794958859;
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
	bh=B/akW8YTT9qImVbfD8Q8NPivFb++rUn0h+uv/krmprY=;
	b=Ze+krt0LXEH3VdGcK7i+oB+pSPciiu6x8QxJ2qaospRHEHbiiWLekKzE8++IDPn1OnFZ
	 hy0bNm2go/IiwX1rQifn19OcmhWYkwnfSq/9kSmkDnwuG6d0arE5WxFADyuI64dLBnKr9
	 Iyb5sSEqiCyB9XvthVsZLctkZuZdVxZu83eb2R18Lbpowiw5+jmLA4iQ54XOae/0yDHyL
	 FyvYMGV9mN0ffyKKYij4fmcf+X+Ir38hdsishFUNhHHYr40/Ns73FnKGohyI4okXFYfGA
	 B7VCfZw5qt1tz33+M0r2ZjcBR62hvpA9OpNkj0JJa6la1Xa4JpzUDQ9MUFiCbaE6Nfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=ay+IUKJF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.0
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011000.outbound.protection.outlook.com [52.101.125.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE16D606A332;
	Tue, 17 Nov 2026 23:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE16D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=ay+IUKJF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ifxc9Od7FxJQPodLzp/6Xo1F6I1Rfba1C4tNfrYfgVw5yE6sQr8TeWHr8hOdg99FRdne559yVADPx5CtYpjYSsdt6qYjphxF9NyBhiSXFs0lw7u2KIyw5u2RYKDx8+KGBUreNSXxGLD8H1yh5L/gijJlVI8qT+OpDfQgZaLOXV/DxdUjsi7u2J3QgpSwaIv++7/8Ic21ySjtdwQrLozxZF1h+CFtfc4x4/s0LRt9kHKtfxtvJ7vTwgtT3UWsAGzmVhG37jX6njzPapkfT67ECwFWXK7mbdLa4iCksXuWVSgUAJqqUqrNorFVCUkf/b6B8JiMwRCRDVhlkOtY3YZGcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/akW8YTT9qImVbfD8Q8NPivFb++rUn0h+uv/krmprY=;
 b=SCChEGqjYquBY816iHzA9+kVWW4lhq0wMXdAxR7c6BmPz0sm5Zy6buX38/rXaXG3WeL8zFVy1zN4CYvCl3szaUeJgRQBxUZ3j4nqNtDnslD1Q/Pk+snNMyMCOllvQMkUytJ7GE4vz8LzyNnt9neyQh4NRrglf03kDYSdjuZSjMbgF2x9Is9IKEvF38JctOZAZOmnCqgwl93AAFd/gfztO0KCBaQNJCys7ffL975E4/xymSsovRANbMwdCnLo9iCArvssjIddTskXwTwG7stPH625jmXy5WibzwGDCyMDUFEZU922vTriPMpf4n/V2IzXHw3ly2vQNK4GaIrc1Vu4pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/akW8YTT9qImVbfD8Q8NPivFb++rUn0h+uv/krmprY=;
 b=ay+IUKJFxWG1Z3coMriIOxkAqIsh+WsVUhRorrXdNKVoBFKxICbQUHqdrs6XOwneE2yei5v2F27Ns4FJSdp9gA8EJGaUAKmNHlQ0cZdpQASf+OaqHdu7cQCydfkQUgSF59QUJ++q0LHbxFpHLo14ba/co+11OZ2wZSMlp8DgRss=
Received: from TYCP286CA0064.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:31a::11)
 by OSCPR01MB13209.jpnprd01.prod.outlook.com (2603:1096:604:351::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 23:40:54 +0000
Received: from TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a:cafe::1e) by TYCP286CA0064.outlook.office365.com
 (2603:1096:400:31a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 23:40:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD9.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 17 Nov 2026 23:40:54 +0000
Received: from [192.168.1.82] (REE-0069499.adwin.renesas.com [10.226.92.1])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 23D48300025C;
	Wed, 18 Nov 2026 08:40:49 +0900 (JST)
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
Date: Tue, 17 Nov 2026 23:40:32 +0000
Subject: [PATCH v5 2/7] serial: sh-sci: Keep TX enabled on TEI while data
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
Message-Id: <20261117-g2ul_sci-v5-2-30b58ea18923@renesas.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794958839; l=5572;
 i=diogo.ivo.sx@renesas.com; s=20240529; h=from:subject:message-id;
 bh=mcngIzwFwwqALICSxkvyu3romyKLMgWY9CimoZk/Of8=;
 b=D8B8poXUtAjcsQJaVlq4Pmp00vPowV1BacmAogQajHWRPO3R8ZEitGcYAbhGR9KbEZgPpGZqX
 IP99m5+9R9kBkMclS8B3/HRAdjdpiAG0T2JEcY+Nqhli0mbplB+euCC
X-Developer-Key: i=diogo.ivo.sx@renesas.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD9:EE_|OSCPR01MB13209:EE_
X-MS-Office365-Filtering-Correlation-Id: c9400047-75bd-48ea-c57b-08df450438df
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|22082099003|18002099003|261009223027099003|3023799007|5023799004|11063799006|56012099006|10067099003|261021123027099003|261026121527099003|261028144727099003|261026140227099003|261022105027099003|261021121427099003|261102123227099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	fmHk/VSQZ9ckG+mXzkXVvMd+IITwOjpZe7WP2UJZRhDtFaZ5Cv6MltXb7S/YuDLFlDY2M2ItIrcjmjb8B1UpMx4zny/KSDJwnmCRB7b7ZCLGA+HPvq6cBtuHP/X26ZKeIdgcy1bFUdDO+gdCpf7WiJhHE1DJQOdmHTpuT/BSVcIrYg3izMlgVOz1rsfMjFwkyrPVQ9U5esWKxrDcyMgZP2Gnv2lCH5b7xq61MUREfUAWRHrkC6mqDHAhSvdHoNkbhhi6gxcT0zDd+7lw4aRRV67kmjT+ettqJ72QxNYn2fhjPXsOSdNTsg0QZ8NVrQ3xSZNAtutBvrcGHcB/d0oCYCLOeQUlJjGot+HRRlqSJZpF2pxjwq85s9HxG1eVOW0Jv8TqXYF1mLDdpFF30ajrTSw/Vl0Zvg0bYMn0wa6A4SyfT2XDTqKvtfSEti93sot3UxUf9at/sv0fOtKBqk6sdbQa8klWl/xbagpALZFxrXANeSlP6YTVGWDbm+FJ0B33I0PmNZHOZJnu5Y104EDn7XNeaF71WHZ9XyDAlHObeXqKTYHf837441IYeeWNNYwhSvzHUjxLjjtTb14gmLdtwDD9Ia58qcvgnHtLofzJKEYmDXsQIe1Hk2rGNL3Me3fVc2VCVHjgMKFmzHH0CuUZgtk/wKaAz+D4jsF3YA5yefe5MEG2+xBpUy7ijGmuw4OmpVy/oTkJJ1Mf1i82Y/xMLw==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(22082099003)(18002099003)(261009223027099003)(3023799007)(5023799004)(11063799006)(56012099006)(10067099003)(261021123027099003)(261026121527099003)(261028144727099003)(261026140227099003)(261022105027099003)(261021121427099003)(261102123227099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Yt+9x/NgYg1cY56friKSf9hglLOOd7nwxQZV5OuBeODxNU4mRYovJcHS71kzNvI7ZUTLfBChnO1+6F3eEnuWuwct8+kc1FI2ZZ/kf99Q+TB5pzKQ6yTIQ7/FajNGWrMGjQV208tsQBz9ZZrVBSTZ0nkbx0adkj+WhArBKj5/VdEEYy2h8hxjMrw0TMrK7AVQuMgdtXcqIffMt5RLTLJ7p8rCtaY3+qhNLJTDxFJ3vWS3EZbzPVswQLeIq84ZWRCE4DQfbynNQHg+pbnBXpXVmsBjLGhRJAI1/+8UxUpLwJM5f+KvhlNQU/9p5I1LNy+zRotR4Ap1h82gm7aI16bKza3pY4ZUwA3dxxcya1yzryAGro8f6UCTILUvjXtHAiAGakK4P6CgUiXdIKcQ98Jdpqcy8S/zr6f3mMNgzQ8rg8Tm4YiSk3E64NK/lLx0IryX
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 23:40:54.5759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9400047-75bd-48ea-c57b-08df450438df
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13209

From: Biju Das <biju.das.jz@bp.renesas.com>

sci_tx_end_interrupt() clears TE and TEIE unconditionally on SCI and
RSCI ports. If new data was queued or transmission restarted before the
TEI handler runs, disabling the transmitter stalls or truncates output.

To fix truncations, verify that poll_sent_bits are set, and address
stalls by checking for pending data (while the port is not suspended)
before clearing TE and TEIE. The existing TE/TEIE teardown path only
runs once nothing is left to send and we are sure that we are not still
sending data.

While at it, make sure to also stop TX when the port is stopped with data
queued.

Fixes: d61ae331d6f3 ("tty: serial: sh-sci: Add support for tx end interrupt handling")
Cc: stable@vger.kernel.org
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Co-developed-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
---
Changes in v5:
 - Make the commit message more succinct.
 - Drop unused tie and teie initializers from sci_scif_port_params_bits.
 - Enable SCSCR.TEIE in sci_stop_tx() on PORT_SCI and call
   sci_stop_tx() in sci_transmit_chars() when empty or stopped.
 - Check poll_sent_bits in sci_tx_end_interrupt() before acting on TEI.
 - Prevent sci_tx_end_interrupt() from restarting TX during suspend.
---
 drivers/tty/serial/rsci.c          |  4 +++-
 drivers/tty/serial/sh-sci-common.h |  2 ++
 drivers/tty/serial/sh-sci.c        | 45 ++++++++++++++++++++++++++++----------
 3 files changed, 38 insertions(+), 13 deletions(-)

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
index 9eb297dbc901..c2de7e7faab6 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -261,7 +261,9 @@ static bool sci_uart_earlycon_dev_probing;
 static const struct sci_port_params_bits sci_sci_port_params_bits = {
 	.rxtx_enable = SCSCR_RE | SCSCR_TE,
 	.te_clear = SCSCR_TE | SCSCR_TEIE,
-	.poll_sent_bits = SCI_TDRE | SCI_TEND
+	.poll_sent_bits = SCI_TDRE | SCI_TEND,
+	.tie = SCSCR_TIE,
+	.teie = SCSCR_TEIE
 };
 
 static const struct sci_port_params_bits sci_scif_port_params_bits = {
@@ -810,6 +812,9 @@ static void sci_stop_tx(struct uart_port *port)
 
 	ctrl &= ~SCSCR_TIE;
 
+	if (s->type == PORT_SCI && (ctrl & SCSCR_TE))
+		ctrl |= SCSCR_TEIE;
+
 	sci_serial_out(port, SCSCR, ctrl);
 
 #ifdef CONFIG_SERIAL_SH_SCI_DMA
@@ -1049,16 +1054,9 @@ static void sci_transmit_chars(struct uart_port *port)
 
 	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
-	if (kfifo_is_empty(&tport->xmit_fifo)) {
-		if (s->type == PORT_SCI) {
-			ctrl = sci_serial_in(port, SCSCR);
-			ctrl &= ~SCSCR_TIE;
-			ctrl |= SCSCR_TEIE;
-			sci_serial_out(port, SCSCR, ctrl);
-		}
 
+	if (kfifo_is_empty(&tport->xmit_fifo) || stopped)
 		sci_stop_tx(port);
-	}
 }
 
 static void sci_receive_chars(struct uart_port *port)
@@ -2012,17 +2010,40 @@ static irqreturn_t sci_tx_end_interrupt(int irq, void *ptr)
 {
 	struct uart_port *port = ptr;
 	struct sci_port *s = to_sci_port(port);
+	struct tty_port *tport = &port->state->port;
+	const struct sci_port_params_bits *bits = s->params->param_bits;
 	const struct sci_common_regs *regs = s->params->common_regs;
 	unsigned long flags;
-	u32 ctrl;
+	u32 ctrl, status;
 
 	if (s->type != PORT_SCI && !sci_is_rsci_type(s->type))
 		return sci_tx_interrupt(irq, ptr);
 
 	uart_port_lock_irqsave(port, &flags);
-	ctrl = s->ops->read_reg(port, regs->control) &
-		~(s->params->param_bits->te_clear);
+
+	/*
+	 * We may be sending data while we service this TEI. If so,
+	 * bail out so we don't stop an ongoing TX.
+	 */
+	status = s->ops->read_reg(port, regs->status);
+	if ((status & bits->poll_sent_bits) != bits->poll_sent_bits)
+		goto out_unlock;
+
+	ctrl = s->ops->read_reg(port, regs->control);
+
+	if (!port->suspended &&
+	    (port->x_char ||
+	     (!kfifo_is_empty(&tport->xmit_fifo) && !uart_tx_stopped(port)))) {
+		ctrl &= ~bits->teie;
+		ctrl |= bits->tie;
+		s->ops->write_reg(port, regs->control, ctrl);
+		s->ops->transmit_chars(port);
+		goto out_unlock;
+	}
+
+	ctrl &= ~bits->te_clear;
 	s->ops->write_reg(port, regs->control, ctrl);
+out_unlock:
 	uart_port_unlock_irqrestore(port, flags);
 
 	return IRQ_HANDLED;

-- 
2.56.1

