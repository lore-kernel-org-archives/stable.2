Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794958870;
	b=OFRMrDk67b7AG3ZT8IegtJjpJ4nu4oHKEto1+VPBOQEK5x/ux5KrAdACCwUmmFSIHmkt
	 qf/XPJHZ6l2XppRjhbRH5suJiRh/xqQMAolHyahGTy9wSeZ/V922t/m+gFecn9aXldPKQ
	 0IKdOyGaU5Lh4sxf4c7qh97Ndp0Gh2Q61KAefMh8j1glicK862hvbseZ370wMofEDEvdT
	 HpI+OCQtQ+Dlaeb1PbQorfPfwSQGKfbQI0RGTZ7FWA87pYl39nXLvraw5xOyaflETXwC5
	 Z+yrzaPZ6FAs9G1c+zTwx4lOKdRJusoZy5Il7WJq03rxnH0sciDViZFF/BzKuxNA+0w==
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
	bh=5v3tDZG7mRUPOQs+14M721A1pv1SGmCtQuIFsZl/HDA=;
	b=xc9U1sgOqsP845bPE8YGWyxWcD7gYg4HY2f9CJQY5rR+F4a/VxJ8sK65tGMPNVugGjuA
	 oK7CxAFNuDVa6v+TcLsnY3vv5Lnq0i5m91IOHC5Fk6GNfTyvzsLbmTaIZ44rHOOWIaECB
	 HqT8UeK4FyP1g4O44RRbXZfhI567DJJTLxDSaFy5JvCWgukxpc9HNizX+sl+mJr/5038P
	 PxDy+ORYAUiRoaLlMUxYId8CiY9LeIyKv1XPa7BgZcyIyVDa9De173dORF/IrYyCfJkkf
	 mwf0ySs/33xrHHhfckJUG7maOO4pJZOKsFI7nu6d6UTj5i51mifLqAU19DAK5xoYCUw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=NNgsvVMw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.39
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011039.outbound.protection.outlook.com [52.101.125.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE32606A32A;
	Tue, 17 Nov 2026 23:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FE32606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=NNgsvVMw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVyxobQKNu5Dia16GxTtxKFgLzbTEAL7W/Ju5g3YHeUyGVzrsfnhegoudxxx6vOe5HT+ovjIQLhOeC29sspuWQvSgO3MRRSQ/mXJb33esOZZrGdqCMVTH39vNtI1aIr950cb88tJvJy8BJi0ryBRGR11yRFQteL95c1qEOqWxWS6GsGM6PO3tVjSOI0HHSSmo2dcNwqAmyGAGuKwWVK8rrbI7CwBcJ+VfHDG0PuM0aBFQuLg62ZO9oJ9ekQxCvRE4TXPx1xnLvUiLt56bPlOwwgVy2CmMnZ63OjKkYCe4IZY6XkBK9vriXrATf0/uXiOww50hzfxdHuBF3/J+8DuZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5v3tDZG7mRUPOQs+14M721A1pv1SGmCtQuIFsZl/HDA=;
 b=Z+CyWS66qn8IrZj8T5DSds63OIGt2utJySfUhBCyJyARxmOSfD77+pgzFJ39ypnyuCQsakmFJd8UHwnM7fUYs1TmW66iYHj3ucLTLfLLy+69HSyU687dOSBAy2HvSNSBcpD/4Zos3HDMYvwPbG2DlWNtL8i59w+ubkrys8EXUeTgtYYapLwTkyqFZdCq6sINVSNTNiZty/vOoDcpCF8oaW5+b020dgZvtuiuDiueTA0rDIOjeOJ4ld6nKjuFmrKQylvW6VimVbctXLkGeBRNMlKRPo2+bn+KuMDO+lvhmggtlQ7cbi56JjYHeHRf5xXfsGFnR/CD/g8/952OZ2dc1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5v3tDZG7mRUPOQs+14M721A1pv1SGmCtQuIFsZl/HDA=;
 b=NNgsvVMwKD7UZ34yBawuTnv7hjPcad9huum5UipM7Y+VYZzLVaQNsVy9REk24xOqsDLiteL3UhJsf6GbDeSaSFQ9gJ1bC4LvyTWQ6goSv1z7MFLb26Df4U9BhlrXjCS2e4169oY4PYvpnWCehOwHKKAVDLdUW61A8WlymVbT+/4=
Received: from OS0PR01CA0187.jpnprd01.prod.outlook.com (2603:1096:604:1c5::15)
 by TYWPR01MB8673.jpnprd01.prod.outlook.com (2603:1096:400:13e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 23:40:59 +0000
Received: from OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1c5:cafe::3a) by OS0PR01CA0187.outlook.office365.com
 (2603:1096:604:1c5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 23:40:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003B.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Tue, 17 Nov 2026 23:40:59 +0000
Received: from [192.168.1.82] (REE-0069499.adwin.renesas.com [10.226.92.1])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 0EB50300025C;
	Wed, 18 Nov 2026 08:40:54 +0900 (JST)
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
Date: Tue, 17 Nov 2026 23:40:33 +0000
Subject: [PATCH v5 3/7] serial: rsci: Enable transmit end interrupt in
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
Message-Id: <20261117-g2ul_sci-v5-3-30b58ea18923@renesas.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794958839; l=1413;
 i=diogo.ivo.sx@renesas.com; s=20240529; h=from:subject:message-id;
 bh=0OQlLn+dpuFnmm9jfClwEo6fjBL2dNEseU13U4pbRBg=;
 b=rL8a5T2bnYNWJF51uwRGmi/GTMxrxIflqVyilc1o/GhduKhlvQxWMI4ncUsKrYQ9bMMhX8jMx
 GbfpbPACHfwDQYJBD/hKJ3hFzlp+U9fyQtiEfdvbKhRAtkswYv8d8et
X-Developer-Key: i=diogo.ivo.sx@renesas.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003B:EE_|TYWPR01MB8673:EE_
X-MS-Office365-Filtering-Correlation-Id: cd238e26-be9c-4391-1966-08df45043bf9
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|22082099003|18002099003|261009223027099003|56012099006|11063799006|10067099003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	m4KFxsGtKuUNAfljTdRWnpyTaCikX8c4x70SXYpS3a8bPtnPkDOirctGc0Vb7gqUGF2oDiN02vtvT8aKpjezPkiitot/s/NR6HvNCArg9KRFX8UtggpBvRHYWXOiOHjsZm3fDKcnhBqJRXbZidGhsQiw4FwKOkT7FrGUw1M6GI+bfrLkb6DEHVgQCM2kO4MnO2ZtVaTaoKWpmB4OOLHyFJx9jBmXfYnOX0wtofAsz/WaCjdrVR2E5K0a/IuJaM9PfKAZtDIjgOfjdPP4Uenk0mTLy73mHPy51giXx8Hzzy7HXsHbe9PT58tYvlw8zQFypc7KVVbOwBPVVwJ/tueybDUhmYxFn/5gLGAgm+EuNxC5WFdFODZHrRSEEFEvZpi5P7AjyGYIcFNfekJG1iGnRYrfvxDdfgqXPtNWL6NM3xUkUS/lW/8fR40PpklGNrxm7t1xnla//++Tasba/KkxHz20Xl1R6uhodPrymrFXTziJWgxZXKCZ49AWXOLZfRZitnD+/sQTQzwJKa5dekGsdpIxJ9DQsQQhtfLkQLp/HaG2LehipP3EtUz+9TSij+CbPNJ09ffWPMFOpP4bof+iHvRd+WIV5n4aAQvxfvdgp6nFT9lZqgAp8PQAv13CcfqwFvF3ojTnpsgDbDXHzTPcDFyHnTSZPVbT9hh55KhQw1rnlB2WRFGbT1319HBTZpIA5X2otURy2jmSYnW0L1GNRA==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(261009223027099003)(56012099006)(11063799006)(10067099003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KwOPs23u4xxGGiLcYuT9LIt+D7Fjr99OITP+cZo8KZvD1MaW+nJOu/CMJLV0H76tJogns7hW8WhLwQTe24XPg5VQkuuHVeVfXExZnTfu1Z++R/i37O+6bEY84cF/PLKpkDdtVdsNez/sq+QU7AsLn1CU/E0ka2kNIOZgyfkSL7SBBqETg11akJjfzBa0L7YnAPLRQ13+EbjoadrV/lXbTDOZovPo6QwqhSN+XPW25bzvfzjgmFxfNbcrGZ5J2fReKMNP15jb7+UCia7buAtgOTYEA0vnjAgRXx4Wxt13j3iFli6Duk9vzXI4xwyquhvFfFlqYgG+JWS0+yXS+hi5hs2G6fyFnnVbntcwbMBI7XBRrdR8GZqj614tPrWlCQHDJaitROgL9kKdY84SRo3ppI+0sXxekEfbgHwUeYwSmNkSdtbkzzKE22UNbCAN5xb/
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 23:40:59.7624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd238e26-be9c-4391-1966-08df45043bf9
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8673

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
2.56.1

