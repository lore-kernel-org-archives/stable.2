Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794958851;
	b=CFvDQ0qFUP2SXew7iqpoMQGuVamE9Jug0WM3iDHhp4V6MfFLBJPtL3JL9Y/KPpmh5qVp
	 eT6B5I2rPdXa5KMX1REZryq8DHlj0ZguznrEwWXBLn1Mjwc+Nmr8ly6IQ+XxzBAKXSuJL
	 JxZ+5947WORVEGMW58piBeBUctbG6zHqIiQ7cHqJ4iDSyRUHtyR2YdDNFTfqI0Ct4dSpj
	 C1qej8pqltXrR8pp/oCitgr65K1gRcK2aYbEPyXTIGpd+CfE1KBJbhjndSzXiqaw/gaTm
	 eXO5yRFwi0onhYGmDgtuVLOFMHmnFr4p4P26zl1XPbacDLPoq2APHeKIP327N4k7kLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794958851;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
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
	bh=ecrC6wpqHRNJz7Gj6YNLDR8dLDlPXJQJBiLnEJiwG3o=;
	b=a8zg304PAFgk0oB6PyX8ro6SD90DmyYkLjFqTv+eYE0WyQc9N+UwF/NKszBrsLsKvTwK
	 cU0moCdpiRvECw7xR2QhPfAs7QDELZwl9R11V9H1uW7jI3+xQWb5GNUl6wVQfR3fUpIzs
	 4yvpuvBWExWoGLvq5lrA1f9ABQKyfGvmYwNTt/vHIVhYu+JhyE9Fgvkh+dSz7bOgDLDwi
	 GvTmGymwQpzKToqvSQXT4La530R8T2NFCoTPUvWaCt8cNmz1CFFapyNNo7RAQiWHQEnUr
	 IP8ERSVFuhLP1Ee8XieKM5mKDHDuzOYk+sd3MTTOBC3vO7hBtSF/OIuRsqpRY7cLuHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=Wbmps8q3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.45
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011045.outbound.protection.outlook.com [40.107.74.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E08606A88B;
	Tue, 17 Nov 2026 23:40:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4E08606A88B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=Wbmps8q3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1dRtfYGI37hXBZpde5Xxp9+nqkZIF/ewMOgmiCGGHmfJczQeRSsDHAs1FRve1jMdAHqRkFqApqOGxlI6uRtV5x9Y7odJ1FRhNC01MgsVyA81L1qs4A2slnVBVN5B4rC0/bcUwCpZXSzCrgqLrmzxnaJYVuopJRAuPzViTF5D3qrJWYoy7luGvpCqCV8vQd15L6ikWprbeln1guMp1HVYrhoOB/0Ms6OW4D7006lNj48//cr0zRwer7IQVyEIy2IjrFDi6dGZ/p8z5cEJ/GspS7JZOJ97MsoHkj5HaHHe47EkGw55KESYLp/dKLU8rT0uWkvrN6NO/7guEY+8IdGrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ecrC6wpqHRNJz7Gj6YNLDR8dLDlPXJQJBiLnEJiwG3o=;
 b=fFyQGGsdRyNR9JiG21Q8MeMx/5X9uKJon6Oikld3Od0xXbdyY5DSZbQn7wwgnJVhOcCFevyvEgqU370Y2+8vEh/NxzRQ+PA5p5fJ2GV5RrS+RXGcsPflhiilSPnY5Zy+VwULd/9zmUVEjlCurcUDPcMaejxnVB1bPNFrd3h/eSXLqhRx7qGWjZuN3D/hErBve5tYbe/KgnoCxLja0a69shthyqzxHoHho1II+7ttnrPuNZEtG1XRVNbXfvHKkqeM10d1oKEo4pLB0O+zROOSDiTLvoWqDoCEJqR50Qn82noQZAY5MeK1kSl6jnumrhDuUV7Ryhz0lbc99eyZfazLng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecrC6wpqHRNJz7Gj6YNLDR8dLDlPXJQJBiLnEJiwG3o=;
 b=Wbmps8q3N6VBkLnrgvF3b2R+Ss6zUHnHTOo5sd4bg41NfzW0FLXiGW6TtBBD6fQuZc8Rn3I8BiWhq0WJqPcjeV9ilkctEpWV7FzYLnkn9Hbinskxf+Z7EiRcTkU1um77W/BLYNSIK4Hb1b3Bl2wyxlAbJAesxbML+kZ+paw5fuI=
Received: from TY6P301CA0032.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:3ba::12)
 by TY4PR01MB12995.jpnprd01.prod.outlook.com (2603:1096:405:1dd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 23:40:44 +0000
Received: from TY1PEPF00046B4E.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3ba:cafe::5d) by TY6P301CA0032.outlook.office365.com
 (2603:1096:405:3ba::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 23:40:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF00046B4E.mail.protection.outlook.com (10.167.253.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Tue, 17 Nov 2026 23:40:44 +0000
Received: from [192.168.1.82] (REE-0069499.adwin.renesas.com [10.226.92.1])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 1B224300025C;
	Wed, 18 Nov 2026 08:40:39 +0900 (JST)
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
Subject: [PATCH v5 0/7] Fix transmit handling on SCI/RSCI ports
Date: Tue, 17 Nov 2026 23:40:30 +0000
Message-Id: <20261117-g2ul_sci-v5-0-30b58ea18923@renesas.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23O3YrCMBCG4VuRHG/KzOSnqUfeh8jSNLMaWVtJt
 KxK731TWbALHr5Dno88ROYUOYv16iESjzHHoS9hPlaiO7T9nmUMpQUBWQQCuafr92fuovSlLVh
 ujTeiPD8n/oo/z6ntrvQh5suQbs/lEefr3wg2WAOqptK1cuAkSh+P1yq0uTreN/5cJe45l+qGk
 5iXRlpowtcXRpIgvWZQjggA3VutltoutJq1gqZGqzgE81brl0ZUC62Ltg4NawwNdGbzj07T9As
 P7eu0XAEAAA==
X-Change-ID: 20261020-g2ul_sci-b610606ea5b5
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794958839; l=5368;
 i=diogo.ivo.sx@renesas.com; s=20240529; h=from:subject:message-id;
 bh=r1dnltKiO3NZDEiyQ3eAzULN9pRM2dg92YdCH6mjZXk=;
 b=e+p/XeTrCu9FtTU8op59kGmSaDkpCB5bT2DYhfL+GNIRhPWV1VXGG9MXjRlErKTkok+kjI8Ib
 RurZgURRcuFCIDh/8Abt5fMg1TuRHKlOXXFTc9fWhC0Ep+3B6uiIees
X-Developer-Key: i=diogo.ivo.sx@renesas.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF00046B4E:EE_|TY4PR01MB12995:EE_
X-MS-Office365-Filtering-Correlation-Id: 45e8a997-8011-483f-6f7a-08df450432f4
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|6133799003|18002099003|261009223027099003|3023799007|13003099007|11063799006|56012099006|261102123227099003|261028144727099003|10067099003|261026140227099003|261026121527099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|261022113327099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	YYRgxrLLsFZP/IPbLLgdBQ9DI6oep2zn81v/Iu3ZctKxlJPsdihuQ0Byx1oOfaQM9u5Mjo3J9GBHRLeAWCW/T0+yiYxgCj47z9hxr/g2mTuo48Swqx4KmqZWDwgIGA4qe6mTrdfhdnHmNNsgc3rwqUGmo90jZygGePKN16RDLz1ik3tB84L1dY6C5VTTuONogBVfGSQu/jL+sPtdMFVP12gFlkPXYXEOK1DuN+wAkFqAfU3SQcrVFAmsUChGuxFY+YWplP7OOcdRdKVct82wl8oDbstIG1sSOCF5uCkHJEJqdEFMcyU4PK3zkK1yQCu1zctXdkjL7DfCSnzzX8XLJZzRhiSxV1vzvpXPASvTrbq8Rr1xzXlKmrv9kjoPyUHxpCr8LC5IU+r+0Yp2KC9xz4BmBjDfbz6JvEffh7enlKRU4uvC2Of26rxPKvlHcEMD49Wfg6CU6oEfyHKlYBJRJ9i2jydbnFJ8m2VUGcMtY5z6K/7M4JaIyz8di0Lp3MWg+kUZfePFDgc7KS1J/P9roCoiIm6hhuntJM1E9bXfcOwtGSpSQU1iwMoZvu47n3gL/fJQOpTevOKWijjkjXxzbxVkwzwoReSxsT/59wfS2wcP1WdyXOxBgPy6r6WpAd/vaw2gHkJ7IYthVZP7cyWGwVzWe9uP1YE7lfMDmpZQv/w=
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(6133799003)(18002099003)(261009223027099003)(3023799007)(13003099007)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(10067099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(261022113327099003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gCCCyr/q+aaQekVekqz+HBP1lgg99pWO9u8lZl7F+r7YEHkYZy/CQA/S9Fq+1mxCgH0MRXNDpm8WrpnQmJEZm+S9a97piP5FVgxbVIl5PW2lvoiImHGwM7TfCK/hvkvAB9/8pTQiZbwfzpj41qXH60U22HdWPzjivTOjbXBdIzcPi/oFLFRujrm2sLOikQqcz4QWZ+N8ILCE3djrgn2aDjCaainZXEQHRG7Xd+focZURSt+eUIuTzyfG57E+xMgQpAYrIVgIrwSn2JtOVx+yFB9KJbLq/yM4Pdtdb9Z2v2MOtal7cqfg9PaotWrZrzZF7xzWMmJss1NEBFDyaDcsiuBDt0ZGm3lmZ4pazKFERwDGl215E6CxtoH9+XGcuhE9sIPF+Cu/SOak1RRAtI8wuxLOClx7wBY4PKQvDrMrlL/id9MhefLWrYhIXsQ2DHiy
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 23:40:44.6424
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e8a997-8011-483f-6f7a-08df450432f4
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF00046B4E.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12995

Hi all,

This is v5 of the SCI/RSCI transmit fixes originally posted by Biju
Das. Patches 1, 5 and 6 retain the v3 code and descriptions from Biju
and Au Dang, patch 2 is updated to address v4 review feedback, and
patches 3, 4 and 7 incorporate additional RSCI fixes.

The series addresses transmit stalls, duplicated output and spurious
interrupts on the SCI (PORT_SCI) and RSCI ports of the sh-sci driver:

 - Patch 1 removes the code that disables TE at the end of a
   transmission on SCI, which the hardware manual does not describe.
 - Patch 2 stops the TEI handler from turning the transmitter off
   while hardware or software TX data is still pending, which could
   stall or cut off output. It also covers the TE handling that patch 1
   no longer does in sci_transmit_chars().
 - Patch 3 enables TEIE in rsci_stop_tx() when TE is set, allowing
   transmit-end handling to clear TE after the hardware FIFO drains.
 - Patch 4 avoids kicking RSCI transmission from the receive-error
   handler, which could otherwise cause spurious TEI interrupts or
   leave the transmitter in a state that stalls later output.
 - Patch 5 skips the software clear of the TDxE flag on SCI, since
   hardware clears it on a TDR write and the extra clear caused a
   spurious TXI and a duplicated last character.
 - Patch 6 forces a TE toggle when restoring SCSCR in the console
   write path on SCI, so the TXI that restarts an interrupted drain is
   generated. Without it the RZ/G2UL console can hang during boot.
 - Patch 7 simplifies rsci_transmit_chars() now that the receive-error
   handler no longer invokes it, and reuses rsci_stop_tx().

OpenCode (GPT-6.1 Sol and Gemini 4 Argon) assisted with reviewing the
previous discussion, preparing and reordering this series, updating
trailers and recipients, and drafting this cover letter, as well as
helping debug the various edge cases and proposing code changes.

Changes in v5:
 * Patch 2:
   - Make the commit message more succinct.
   - Drop unused tie and teie initializers from sci_scif_port_params_bits.
   - Enable SCSCR.TEIE in sci_stop_tx() on PORT_SCI and call
     sci_stop_tx() in sci_transmit_chars() when empty or stopped.
   - Check poll_sent_bits in sci_tx_end_interrupt() before acting on TEI.
   - Prevent sci_tx_end_interrupt() from restarting TX during suspend.
- Link to v4: https://patch.msgid.link/20261113-g2ul_sci-v4-0-6815e41d90c5@renesas.com

Changes in v4:
 * Trim unrelated x86/TDX recipients identified in the v3 discussion.
 * Keep the code and descriptions of the four v3 patches unchanged.
 * Add patch 3 to enable transmit-end interrupts in rsci_stop_tx().
 * Add patch 4 to avoid kicking RSCI TX from the receive-error handler.
 * Add patch 7 to simplify rsci_transmit_chars().
 * Group patches with Fixes tags first (patches 1-4) and mark them for
   stable.
 * Base the combined series on next-20261019.
- Link to v3: https://lore.kernel.org/all/20261026-g2ul_sci-v3-0-b3097163edd5@bp.renesas.com/

Changes in v3:
 * Updated commit description for patch#2
 * When the port is stopped with data still queued, the transmit_chars()
   paths (sci_transmit_chars() and rsci_transmit_chars()) now also swap
   TIE for TEIE, as they already did for an empty kfifo. Without this, TIE
   would keep firing with nothing the driver is allowed to send, and TEI
   would never be raised to complete the transmission.
 * Replaced sci_tx_interrupt() with port's transmit_chars() to avoid
   lock drop race in sci_tx_end_interrupt() before TX handoff.
 * Added missing has_tdxe_auto_clear init in scix_early_console_setup().
 * Replaced to_sci_port(port)->type with sci_port->type in
   serial_console_write().
- Link to v2: https://lore.kernel.org/r/20261021-g2ul_sci-v2-0-b4e038220018@bp.renesas.com

Changes in v2:
 * Updated commit header and description for patch#2 and #3.
 * Take the port lock before reading the control register, so the
   read-modify-write in sci_tx_end_interrupt() is protected.
 * Extended the pending-data check in sci_tx_end_interrupt() to cover
   x_char and a stopped port, not only a non-empty xmit kfifo.
 * Replaced the PORT_SCI check with a has_tdxe_auto_clear flag in
   struct sci_port, set from the new tdxe_auto_clear field in
   struct sci_of_data.
- Link to v1: https://lore.kernel.org/r/20261019170139.473808-1-biju.das.jz@bp.renesas.com

---
Au Dang (2):
      serial: sh-sci: Skip TDxE clear when hardware clears it automatically
      serial: sh-sci: Toggle TE when restoring SCSCR in console write on SCI

Biju Das (2):
      serial: sh-sci: Drop TE disable at end of transmission on SCI
      serial: sh-sci: Keep TX enabled on TEI while data is pending

Diogo Ivo (3):
      serial: rsci: Enable transmit end interrupt in rsci_stop_tx()
      serial: sh-sci: Do not kick TX from sci_er_interrupt() on RSCI
      serial: rsci: Simplify rsci_transmit_chars()

 drivers/tty/serial/rsci.c          | 23 +++++-------
 drivers/tty/serial/sh-sci-common.h |  4 +++
 drivers/tty/serial/sh-sci.c        | 71 +++++++++++++++++++++++++-------------
 3 files changed, 59 insertions(+), 39 deletions(-)
---
base-commit: 3d229ce89862b8e82d71a9e11d6f840ca272a6d6
change-id: 20261020-g2ul_sci-b610606ea5b5

Best regards,
--  
Diogo Ivo <diogo.ivo.sx@renesas.com>

