Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794594643;
	b=W58jqqbTqmRf+cNndBYjjrjSgZtRVjJlM/UXhzKpDmsRzm1Wu3+DrSMNIlQcIK3UKJW6
	 C1mwpM3TA+lUkKj/weIgFyQO04mqM/J81aZqBjF865e832SPpoRccIqPQIs/aCh0oKgrX
	 6NQOxHzxdcwR8fIxYOgHCNMv+BLSgPQnlSG27v63uL3olxbex0UptmOKEp2gXLxaOA4sz
	 micth3EzmREkuvdfDyv9+2GB9yXgCNQ06TKN5lvSk0ZeMDdZhnNogMbfHf/Vrx8a43c7P
	 tXEnS4KH9u3DqOAWpjEi1kFrjU//KgT6tC5vp5ddzaX4wNR869w/hpInhmHqfucAkoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594643;
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
	bh=zLdx+wKYIeunjSodb0+/45o6ZMUez0DKyKu5UCQXzg0=;
	b=2/xergGX88uUPVy4tObw2KLI6btiIFICvJqW4fUuOl1DtF5a+tm3A6/997s32DVOkPUJ
	 5+cw6WrQNy2MWeigiKWBPjRPo+IkhidF8C7+HYdMJew4IHOOC0OQ5tlwW8brzjAWLYQD8
	 pdyXHOAzVBeOQcJSSLyXIL2reqt8xi92d8AcLztbYlX5FMZyuWujoJMnPgNdKGhpk2X1E
	 8NCwqxAChdUJLZG+bfkDMFbr//C5BFwmlsKUNjvhqXQQY/8WRfa6GxWrOig2PgtznGOWo
	 iEE0Fl8QhXii8e+MPnP1eE0lt+vAMcyUI2oWOJ8szSeeowXSkaxa3NG7N1d7yqOIomw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=YrHgolin;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.48
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011048.outbound.protection.outlook.com [52.101.125.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9BF606C156;
	Fri, 13 Nov 2026 18:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C9BF606C156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=YrHgolin
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NdCpr1+4wzj9ItKiu4i79m1ItExDYndzos7qMSuBkh5C9utUmhGmIXmG66ArsgCj8LFfcK/LXZbGeMbLJjnzAKMw4LWqNrVlOIupe27szBnixQIZ83xmXSZImfWeWJW6ajh0bjzygYeSsDRHfzRF35swlNsccAwqaoyIu37smQpgXakVNy+UXFfCGiduDXT2NK6B6L1guEYbz9TU8J6ihD2VGFMvUkQdc/TsC50VoeQSXdnYIF/OkM/fBaNCDKP74IOpeUh88Oq75eyz/6tfr0p2t731Gv7nM1tmrCBrlRWuoTENyK4fhl4IVkUH0PGqNfg34nGHHczuBCQljCH6wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLdx+wKYIeunjSodb0+/45o6ZMUez0DKyKu5UCQXzg0=;
 b=WiL7pM36ZJKjQR9VnnBO2LuC7uCG8hiblhUFK1vASMQCQeiG8Y45lVM3s9MsvriZefU+vpPJiUiITLMXyyncWUsph3GZs6ShcVay1XjMQVhTgOxOciXqjELMq0scm2RXzLm1OpbsQf99pqymQ092ZhtU000tKdptRdnGNmj+2CY/sqhD/sGI2886F6hso+sr8jGFUO0nU1M8x7Mb+BDBUd3dQliWLQj67GTwSw6rnWw/XBuMKcsVKvBY+kmKEJ2H/3HlHimjsF3pr6P5bTwBZ0dG0m8pnoZDvIlVb++R22J/0GN7wXLxGu5prN3xcu4Pctn6ispDZGJcUj1fL1a5EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLdx+wKYIeunjSodb0+/45o6ZMUez0DKyKu5UCQXzg0=;
 b=YrHgolinq1LGwsTxOsa+3Xqr793wUNACOzfx87yMT54q8Io+HUp+WjkvZKT6jH7YOdCO8qmhSiVh92cSQOfKwgvCTvXEhXYPgrewN+U4Kc6w4PIs1SwfwnkSgkdpJe8E/EAz9cwR+EUH47MRgoBpa+BNB8M+U3G8yhU4uxG+yXE=
Received: from OSTPR01CA0089.jpnprd01.prod.outlook.com (2603:1096:604:218::6)
 by OS9PR01MB771544.jpnprd01.prod.outlook.com (2603:1096:604:546::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 18:30:39 +0000
Received: from OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:218:cafe::2d) by OSTPR01CA0089.outlook.office365.com
 (2603:1096:604:218::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Fri,
 13 Nov 2026 18:30:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003D.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 13 Nov 2026 18:30:39 +0000
Received: from [192.168.1.82] (DEU-5CG2204K0P.adwin.renesas.com [10.226.92.17])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id D3077300022F;
	Sat, 14 Nov 2026 03:30:34 +0900 (JST)
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
Date: Fri, 13 Nov 2026 18:26:29 +0000
Subject: [PATCH v4 4/7] serial: sh-sci: Do not kick TX from
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
Message-Id: <20261113-g2ul_sci-v4-4-6815e41d90c5@renesas.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794594615; l=1615;
 i=diogo.ivo.sx@renesas.com; s=20240529; h=from:subject:message-id;
 bh=/wDy+0+5qXDcsp0OckoijSNxZkLrXxfdLjSp+lh9XAM=;
 b=bta59V0Kp0sRc0W0OVtRTQYoP6XbIoJ3p+H+ozBnASv5WRI4BWYbngypM1rRX6gH/56tdX2Ap
 rVaSUiOug/HCtMewTCto06ZYxXl2PRRCA5mZhjkm64HmNDxDolKraik
X-Developer-Key: i=diogo.ivo.sx@renesas.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003D:EE_|OS9PR01MB771544:EE_
X-MS-Office365-Filtering-Correlation-Id: 10eff2f0-21cc-44e9-71cb-08df41b4378f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|261009223027099003|10067099003|261026140227099003|11063799006|261021121427099003|56012099006|261021123027099003|261022105027099003|261102123227099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	NfrYi5Bdl3oGmBzL2qHGBb3xLAgD6EzK48VtCQQz+6ZnXbiwhv7NxMEZUgFIpKKYiAr3jyFWJdgVEF5VcNVANrMQIbL5KTDeTWBbOZG1rglPpZqinWsOv8ttu3uZN41nbbo2P1I8C+4wf1toBim0Hp4HKXAz2RK1q4rZvbBRK+gLiVc99TPuts+Usci5QJWoqTZr4+1WQA98oxbrTb5wYJnLiHfWITf2isVLIhL3tX7cS2dQHUlaiWFqMzQeb/268QA4UEoUcFV4lIAE43Oh+oisUyAKQKko5dEMpy8vzoZyCD2cF/5ZOZ3xmrjGTEDPGPZ/IFt4XPkALzEYL0oa8QFCpa5OxL87QQOJEP7lnLT6hjosPi1VLukm34qWleUDg/XzWlkQ7NPkImWqf4lB7zmPWvQmfvPoI03auStypzfmhWOsxwbuCE0MsbCNxEWeEE2ywzbOT8woZkZgh4YV7dzFAdpCBJH5fZlir6Dvuh3q14LROuQhtl1UMdz1mYXzyAkitQDUP8UY/pxtz2thCRqjpezSE8wVf09mja7v0sdupXMIVzwrkaSzugXSTMxzjnEnryUs4cd4whP8wYhOPlFcU+RUnM9HrF2kwq4guIWG+pnaMABD5fPmA9a7Goq/w1gFx8j3Hnr3lRmPBCUCdKALN79DS8MHs2LfOGQNFco2ESpx5jfjGKZRUXpZ7HRquJQoSB4DwLooR27M5KVT4Q==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(261009223027099003)(10067099003)(261026140227099003)(11063799006)(261021121427099003)(56012099006)(261021123027099003)(261022105027099003)(261102123227099003)(261028144727099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YFqNWOuHcSRd8oj60Ekm/FCUzh0u6vkiTsc0lb9mXhwQeTpwGeSk8nhClh3sre1gxSZlnD+xYiBnfRFlSmEF+hyZfSA02BQG0Ue73aicljjK0viVyporJbenIYGxSoaEO2lCdLPg5OYPEU0iI0CcJl0vBJd9S+RiB6rnwEgNz+244hu0Kamv3mtCOoEGXbDpjxQbQhD2LKNlVUMpXy+Ae51RwDA2YfLEX8uUuJ/UC6FwyHjFZZ9De7hj40wMgLzgcp+yAJrf89Fy7PTTJe++2ugtLH9DDlRjNZQdLpu08qCUSG9GeS5e5MApW8e36S90l6mEDoG1UixZoOWqTUKUOtxt1yeKt0EgDDEqe/qh8uqu14DC78k4nktotMGrIw/Igqx7bRO1mE6XCeaCSWAZPhc2zDgA2gTh+DH11to+Yyktiq1zDLIR5EQsVP3fJM0C
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:30:39.1323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10eff2f0-21cc-44e9-71cb-08df41b4378f
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB771544

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
index 6df25fef5a5f..39aa90131918 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2103,7 +2103,7 @@ static irqreturn_t sci_er_interrupt(int irq, void *ptr)
 	s->ops->clear_SCxSR(port, SCxSR_ERROR_CLEAR(port));
 
 	/* Kick the transmission */
-	if (!s->chan_tx)
+	if (!s->chan_tx && !sci_is_rsci_type(s->type))
 		sci_tx_interrupt(irq, ptr);
 
 	return IRQ_HANDLED;

-- 
2.56.0

