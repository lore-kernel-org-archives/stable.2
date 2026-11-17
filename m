Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794958870;
	b=mHcM4LbSNzHxcrI4p2s2YKsrLM+k3gRQuA4H8spEMd0LcmMbYzGuOYtjqPG1wntvwN1S
	 mcDAJVLQskK9O7wn+22JhrahLoze8SmkDUq6oHwua8EUs1otR8MbE7Eqh33qBvEuB7+nN
	 CF3X/4wg5mom06xofLEpSx0ukzCINra+79ZmWXuJd4rkILrZzIx2vsjxcO0NQ1F4bOkpV
	 wVKWNWlIeLnc6G8N1IOu4b0Z2Y2UME7BrTNBnLIiXChBfIkEwJ39Tjz5TKW6OmJ+cdlbj
	 0fJSFh7MP/2CJnkwcQOKcv/CgitqiiMnY91zwtPQtCoOP/62VazseikhMXh6cOtsT/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794958870;
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
	bh=ArSmNVQbEJ4ff7BLnpfnvZWgAJuJyrwkrojFrLKtRCM=;
	b=sODIx/81Z919FXi4HQF6mGZPRKTq/nhQt0AKK86RtG05uDjOWKjThbq4frCLQ2PHnQwu
	 0sbok379aS52o2F2Z5BGrsTsksUCzhA3Qg9Xd5Xvdv8zt3UGUKHon3pKeSf+d8Dx9b3dm
	 zx+qOUqkLPLssdWCmwDZfSgFlJfm8QFjZ12uvbxD7/aUaKfzoks4INsHvr4/wWvKPo71x
	 RC732qoLlnpWFNeERxX5mgj5fWXHLimhzSNEm82TsUnbJzwX3Cf/mG9mK9uMfbM/sJ1SG
	 mE9qamq++ft4NrpDVKlKikHY/bYTD7/srxAviBqhHXOegeDc0p7xK2yCxwp7g/p57Nw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=AaZBzHvz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.18
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011018.outbound.protection.outlook.com [40.107.74.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DF9606A31C;
	Tue, 17 Nov 2026 23:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2DF9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=AaZBzHvz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fr6GgSPtUkxUsNJPozk55C/R+WIiriDOfIj8R0lrJkUvI2KZqR9q6pbUo/Yljcax2LF9pBWx156DLzI30vo4/Ug9kMy33pAIzPLYxgzZDdKl8ft321hha8ltWLws6wqI8ZKpRFB9h52uRjak51Cezx9vSbwiPEC8ijuVVxihRusZ0JqjopI1A12ULNJB/83Tjqa7FfOcBz5dDBJM+HaK2IVHmX3ALDNqYsknbV/iJD+yg42X3oMWrH4mufhnu1QTgLOPfjH64Qk1mMmAfcxujHbbVpYwizFoFiHA12ttOlqtg63zD6AzoHXB+NK7EDT7jLC6qCtc1QX1m/nfzhCyqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArSmNVQbEJ4ff7BLnpfnvZWgAJuJyrwkrojFrLKtRCM=;
 b=tOiQRS3a+v2e0jHwpUhcO+w15MnPfIsCC7yOczo3rxYvGAfZuvXVwi1djw7MR6cSte46Kc3caDF56t/nR8vtWpthoUnlMufN10d66SRWMFVytcZOmGmi87o9E8mAoRIG7AU3x0/BqjNK1HFe3X/szXMFgq8AY/Ov3+Njf0JC078Hr5lBMmf1RvOvrpxZw9D0oUxRXS1Du/5gA8eKRMqocyuNOEvQinJPcApejT/JklnfDg0kuIxye5Ukk4ZlAAfG8vJfGr8HUVRekeeleGtkRsV76hqsx7jJIW6fHl0dsteLR4FySEGmxIszjf643VeLdI3BoGP2PZobAjFwoEuztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArSmNVQbEJ4ff7BLnpfnvZWgAJuJyrwkrojFrLKtRCM=;
 b=AaZBzHvzDIp2lsiPxniij6memjjR+7NQMiStAO20zF+pvxo2dPTjyWV7DKE2t6UE7kWPln+sU3qYVEION4oBFMiSbmSG8FoWsFuEIFpt+ZbQD+lKSZ/Mkxh0NIrjx6fs8NyC33mjD/x4YLHo87BqqBHo7xubbHDmKJ7PWCynEFs=
Received: from TY6P301CA0033.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:3ba::6)
 by TYRPR01MB12654.jpnprd01.prod.outlook.com (2603:1096:405:1b5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 23:41:04 +0000
Received: from TY1PEPF00046B4E.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3ba:cafe::17) by TY6P301CA0033.outlook.office365.com
 (2603:1096:405:3ba::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 23:41:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF00046B4E.mail.protection.outlook.com (10.167.253.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 17 Nov 2026 23:41:04 +0000
Received: from [192.168.1.82] (REE-0069499.adwin.renesas.com [10.226.92.1])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 2C5013000F93;
	Wed, 18 Nov 2026 08:40:59 +0900 (JST)
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
Date: Tue, 17 Nov 2026 23:40:34 +0000
Subject: [PATCH v5 4/7] serial: sh-sci: Do not kick TX from
 sci_er_interrupt() on RSCI
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
Message-Id: <20261117-g2ul_sci-v5-4-30b58ea18923@renesas.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794958839; l=1615;
 i=diogo.ivo.sx@renesas.com; s=20240529; h=from:subject:message-id;
 bh=4el4PbVS8r/pE772FnhZHD7JYQ4fvnJtEfvWz6CcoHs=;
 b=FqqxZKWOqbjK0YDlurS8EQhaAYKB+NTqF3PA5DHH0SmcosTp7d3kgu+umQyksDuWKDmvz1CpA
 pCcH4za1uY+DBdXp5Oj6YjV7FdRqbYAs2PVJF2bfoUTegD+YN5RcRNA
X-Developer-Key: i=diogo.ivo.sx@renesas.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF00046B4E:EE_|TYRPR01MB12654:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c23c257-a8ff-452a-9766-08df45043ed8
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|6133799003|22082099003|18002099003|261009223027099003|56012099006|11063799006|10067099003|261102123227099003|261021123027099003|261028144727099003|261026140227099003|261022105027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	o2vwF6ks1z2v6Nau1rPSwHMemg7JTz/aiif0rXdAruQRrr0kZE7xLNdlhxVXe/YSLxpmdQAFP1uIua44+7pA+rTMIP6A8Ikp2K3ktO179H0I2sp34Qt18uC4ZZWmx/3VJxrg0UZ5m8G3lZImRYzg/ukWUcdJ7k9LrrkSviWwTpSt84zuCeyPfiskmd9siifN/n/GmU0J8WWKLmwRcnAJoYtVSZPl9w9O9+SOxua23Qu4yJEyQRc4atEYQwnfcMYnpGhVoxUQy1U6/WNVRMCDYUjQ7OH9+3kxKey7dL0xoskyg0USCEOQcn7v8Pps+zDzU8Ez5VSYm9TSRCobNcd2qeJH4BeOTgFWPJ8klQsY7YoFUrhQBZ81s7eSoHeydDgOxSwlvN9gOaD93eBmCX0xMMzk2u+fxTV/fXWzpLkyhF140uEvyCLdfUYcTzQV724grguWJCNenLfGCm/GemNqLRn8cL0pTnC+rxe6LtT+Nfvf9GJAK1REwnLXDqGU9/K/YUhS7h307iUajHNCUh+6bGxCDLVNlbsO7U31yYJpO4rmwD0osCzoUTjxmIEBzCtK6ws+acUg4LX671kYvBU1ddUe+5TOXIxupP8tZ4936p17dLGpmxbhbq0uQoZZCPE5jEBxKoBlNNsVaRbS+w9UVN/kSpMaHAcEY8TY2a3Y3NlAWDxS1RF8ecSQIKBaG6LloiTaVHM4B9GGq77SyaZZAA==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(261009223027099003)(56012099006)(11063799006)(10067099003)(261102123227099003)(261021123027099003)(261028144727099003)(261026140227099003)(261022105027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5W4jxGGazzt6eFdtsO3LlIES9Q/bPLh3XE2HABLhWCIGIH10dpnao+vNvW17aWmxAZP1m5Wb+0gBMwXwSiIrVWBxK1wNNzPg2KRmQ2HCrKurWNS2fMfTEaJPEI+So9qMzBQrD0Mv34RW3W0NCu+zs2PCDho17C0sDz7MLy7+rjjWGSS2EWtjQg0Y7U/LDLHoiwKsT4lAdv1QFrycoNaWCxvK3WLU78LvdPp+Q1ZMoeJuOzSNeOYwABt3tRgVk7Pq/75V6ym13X06JK2J/nN3DpokvzQeofFWg4eBRfFOQspz8JaasBlMbYql0oOFY8Cfm1pQmDIZKMc9N3mVApUu4zYwpY7k797QRywshDmc8PjQJlvKaeKTXyDjfmxC3HsHlWqAtud2yaBhKsORxzO0CWXl/P2L9I1D1Zsm8ITjAczEPUTWJl+fNLCbnqq0CjHm
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 23:41:04.5965
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c23c257-a8ff-452a-9766-08df45043ed8
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF00046B4E.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12654

On RSCI, the receive error interrupt (ERI) has its own dedicated
interrupt line and status flags cleared via the write-only CFCLR
register, with no hardware interaction with transmission.

Calling sci_tx_interrupt() from sci_er_interrupt() on RSCI is
unnecessary and causes rsci_transmit_chars() to run in invalid TX
states:
- If an RX error occurs while TX is idle (CCR0.TE == 0 and CSR.TDRE == 1)
  and xmit_fifo is empty, rsci_transmit_chars() sets CCR0.TEIE while
  CSR.TEND is 1, triggering a spurious TEI interrupt.
- If an RX error occurs while the hardware TX FIFO is draining
  (CSR.TDRE == 0) after xmit_fifo was flushed, rsci_transmit_chars()
  clears CCR0.TIE without setting CCR0.TEIE, leaving CCR0.TE set after
  the hardware FIFO drains and stalling subsequent transmissions.

Skip calling sci_tx_interrupt() in sci_er_interrupt() for RSCI ports.

Fixes: 0666e3fe95ab ("serial: sh-sci: Add support for RZ/T2H SCI")
Cc: stable@vger.kernel.org
Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index c2de7e7faab6..2b6847f0ea72 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2099,7 +2099,7 @@ static irqreturn_t sci_er_interrupt(int irq, void *ptr)
 	s->ops->clear_SCxSR(port, SCxSR_ERROR_CLEAR(port));
 
 	/* Kick the transmission */
-	if (!s->chan_tx)
+	if (!s->chan_tx && !sci_is_rsci_type(s->type))
 		sci_tx_interrupt(irq, ptr);
 
 	return IRQ_HANDLED;

-- 
2.56.1

