Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794594629;
	b=dYRVsrDuzHSmPi7N1Bpz5DNp92THJElIbijbd72qBYRL0Jakz0jsKrnek5cCnaEoMEbB
	 EYyFRbF47OwnE/Nof1voMO6N2XWURQOgKvuuoykoAcAXvT2bl3wnXpcZUNcr9yq+z7XVw
	 txoE4bgRRXPgjMpq/MN14zvpuNkLxPL0Z9WFhgYmiPxffXPbqSurtn0FcCcI/Mvf5sd9S
	 3iR7rjJf/h/54/qjRqqdpQ+s6+IHd9Qj3/q7NICSM3oBEz3X56bGXDyjVmgRAZwS1J7ko
	 4VEig2BVNIcGjFPShBCQADQSWG5M9LL4gqMrqlcVuxcNOSEDSK1/n58uwds5H98K/kw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594629;
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
	bh=red1pqlmUuAD3xFAyu5xETn8jltL3d/Tz5YfTq9M6ZM=;
	b=sNTLKyglj8sjsTwFlTGin0MfRdXEyuHSWJtYq3zTP2tkxizQXT35WpaVGaUVPip/to8D
	 vyNiVzmKoKRW5CuEoRuuEOBVXvyRrYlXAhnmUeswCbyOHpih+6+0cxb/iGoQcsvsct58E
	 sF53q3kvrneb9O8nfi5n3C4wA87WhGBl+S2qOM8MjgW+7Af7M/CQ/Dvjg7vD1vbM6DSbU
	 3HwVWu+fSAKSTcMga5oszZPpenqBj1yae6rgFhVDj8RUTfslMrJPssQdXy2tJs2kIWBma
	 D+MNCp2iQkPbk/P9Nd+xeLs2Zu/caMTz4bJsgI3b2JVdj7KR39fGDWNBa8Yko1py3Sw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=l92WB34z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.56
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011056.outbound.protection.outlook.com [40.107.74.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760F7606A8AA;
	Fri, 13 Nov 2026 18:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 760F7606A8AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=l92WB34z
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MrNn2GqrZlbwbwFKJ/fQ76ctFPSY3saDGpz4YJKuMTeh6MsLEKS2E3Lywi4B7E8Y5Sy9pk/0aiTtqf74Xs/26iVtqt/5tVwAxCDXnackrqcPenrUpUOrhuy2MGPT04XoZtRvyKXPcRmh25ISRdQVdFhAPsCnMhvJTWY3EzTOgTHLxFAflBP6Ntm8KduxQER1HN1ww2jXeeXH3u/MbTj6QH0uW6NCnZdVi3EHkGDNZlYMAHbRJz47I/MaaeimXo2brQVZfVXyk4C0ySKeij8sJWzo5CbZmL48Zaf+irVsr6Y6sEin3njcB7E1R/PGahxovIrJFeLAT4p4vWjNOF5XEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=red1pqlmUuAD3xFAyu5xETn8jltL3d/Tz5YfTq9M6ZM=;
 b=OOvnNPbFlm+JQkIl68p0v32FXkasFUaUUhjxxivWYZesCRJq9gvjcOnErPJhTM7JgpNyH6dxMYmz8JiaFYYMHIexLAVgN67ip26xKeDONgFVUBZTF1sxNNo3StXt6AQVShXYcH0uK/h/vE5KetDPywLzFFxZR+Wlk44zepmqHvkPRCXUqC+T3JyvwGy0vcm2WbB5NuUYj6vkgIfhbTFh5ZMFeesg1pLzKvrIvLEMsSW8n7hfjlLt8nCx4dmKSmJemoctZZhXgdEH5VA6InatB9P+bMnF0KwPuJCh/m/PFb+mlejvKkWbmyvKLK5YtXFjRD+vO8V65Dn8CKKgqx534g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=red1pqlmUuAD3xFAyu5xETn8jltL3d/Tz5YfTq9M6ZM=;
 b=l92WB34zAtp1sqm3WLMxW7Hy8CSbrUao45hg+WB9PzWv5PR0ibkIGzEReiXxY3B3SgHcQg5av3YOZP66ce5MqiXUqsejFfdpIB2cXr4LdyuzOk/y//v+1Bm6KVkkbENN2XPUR70AxMtDG+XCGHfWycHp2VE5Y4coueOf7yej/ck=
Received: from TYCPR01CA0171.jpnprd01.prod.outlook.com (2603:1096:400:2b2::17)
 by TYCPR01MB11055.jpnprd01.prod.outlook.com (2603:1096:400:3a7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 18:30:21 +0000
Received: from TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b2:cafe::a4) by TYCPR01CA0171.outlook.office365.com
 (2603:1096:400:2b2::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Fri,
 13 Nov 2026 18:30:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005622.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 13 Nov 2026 18:30:20 +0000
Received: from [192.168.1.82] (DEU-5CG2204K0P.adwin.renesas.com [10.226.92.17])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 17077300022F;
	Sat, 14 Nov 2026 03:30:15 +0900 (JST)
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
Subject: [PATCH v4 0/7] Fix transmit handling on SCI/RSCI ports
Date: Fri, 13 Nov 2026 18:26:25 +0000
Message-Id: <20261113-g2ul_sci-v4-0-6815e41d90c5@renesas.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22O3QqCQBBGXyX2upWZWV21q94jIlyddKNUdlP6w
 XdvjSChLs/HnMM8hWdn2YvN6ikcj9bbrg0Qr1eibIq2ZmmrwIKANAKBrGk4H3xppQmsQXORmES
 E897x0d7eqd0+cGP9tXP3d3nEef1EMMcUUOVRnKoMMonS2NMQVYWPTo+t6SPHLftAZXcRc2mkh
 U34fWEkCdLEDCojAsDsr62Wtl7YarYV5ClqxVWV/NjTNL0AoMxGnyEBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794594615; l=4918;
 i=diogo.ivo.sx@renesas.com; s=20240529; h=from:subject:message-id;
 bh=oTO2ngqCBBp4eR7SqWZNRaA1xeq8LEHnc9RX6XgR0Ko=;
 b=siOWb1rf0O625vPv7t8P4gucv54Yjwa54DNzKEh69OoZ0JdrzRgTMvHKODz+E/AMdtlmPNywh
 vLcVyFflVmLBo+49rAX7KJnle6dQZcNa5AAc6W7/lIAUm09ebd2WfYF
X-Developer-Key: i=diogo.ivo.sx@renesas.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005622:EE_|TYCPR01MB11055:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e3c7c57-e5d1-47d8-bb0b-08df41b42c53
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|10067099003|5023799004|11063799006|56012099006|261021123027099003|261022075727099003|261026140227099003|261022105027099003|261026121527099003|261028144727099003|261021121427099003|261022113327099003|261102123227099003|261009223027099003|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	vY9YRdztDViXSZGBI9Bdf7Q25vgw8PGTqJhfu36mh/Kk395y5TH3Ft2vrZAW+BQJ5ZVUk946RgfXCZxsZieNEXAmbM4/w4M0DQFn5gENQbG/FFVXT5NHkb8jEXsa6Q4J8QhFhDi/5X6ELhaW8n1lTB4MOscvVmmtJ06ppW2DAkUkZgIupNvWOLIl4vPohuT+i7TE+DQZqUWh/9KCG/zCGjwajhstuSWmdTFG0hO3o1lbpsOpNspx+B5GSfJfZpS50NoygZcbIdlOHl3fl9ST5MsvS1YdiPbGKAjaCSM0/A1H88hGRodXvRmwmjc3Y4pKo9GpipCgq9aDAITfpTaLUinumszVRT2JnO41QB6+BuiSrsi0Qjzhwd578p6wnCJ6ic36Xo/YP40cVIRo2i1cx5c8fsEfc1y+VpBr+YZz56j17jP77vJp9g83sCO8d1gK6muiGqaedpWsu9KhQwjr4LYaIDfwJxRnylJG+N4zcLnWHJVB5RmIijSZyWXoxDXHyIenYSKqQTVebnry/AcxlJhO8FKEwIQMmIFofLBdfaZjXDhG05EsosfL9AB3QYbeGaFJOJYSpX6+CHqE4hTm2SncRyKmHftM9vCKrrlldVcyDW6gG6AXgRPI5B8k07NWi01tDoZdasbq82NJ9DQSBA==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(10067099003)(5023799004)(11063799006)(56012099006)(261021123027099003)(261022075727099003)(261026140227099003)(261022105027099003)(261026121527099003)(261028144727099003)(261021121427099003)(261022113327099003)(261102123227099003)(261009223027099003)(18002099003)(6133799003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FhsivzYrJdDGDfxgU7R/90eeXIvIE7L0iUJNhis94K7emOis6CR5X79E/4zN8HWQVmRCgcFZhDO/WlKcDRtGSwlf3Pd/fBBwov9HLkPeI3cJELe872/tmTDXpGZTxrQUzKHKzje6APay00JnSDjnAYN6wdQ9zoJ5r9Wfbyutra3p3nw6QTMynTXr4kzRePT57Gjssm6FAfnNMuGHN/IKm1t3bHFA6UJ95I+Ab96p6IOge/wvxSe3WX20bgYQCJT5zWFvv9T1prTl7uvJQgCielrqdtLxDjuRuJGmT6ZIzs92MakBj7K3gTY92D/bvnB3KXmEyNH17kCW2AtX9KLGKQ+xCcvjzrtE3Ez7O/UsEfb5QiiWmCAKLBmLGIqbfxMydG7i4UmhMOkiGXyyWsRs8tVua7bE3Aq6vJKF7AscjTith0AQVfP6q1r6l9XsUo6T
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:30:20.2990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3c7c57-e5d1-47d8-bb0b-08df41b42c53
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11055

Hi all,

This is v4 of the SCI/RSCI transmit fixes originally posted by Biju
Das. Patches 1, 2, 5 and 6 retain the v3 code and descriptions from
Biju and Au Dang. Patches 3, 4 and 7 incorporate additional RSCI fixes
found in the meantime. This revision supersedes the v3 series [1].

The series addresses transmit stalls, duplicated output and spurious
interrupts on the SCI (PORT_SCI) and RSCI ports of the sh-sci driver:

 - Patch 1 removes the code that disables TE at the end of a
   transmission on SCI, which the hardware manual does not describe.
 - Patch 2 stops the TEI handler from turning the transmitter off
   while the xmit kfifo still holds data, which could stall or lose
   output. It also covers the TE handling that patch 1 no longer does
   in sci_transmit_chars().
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

OpenCode (GPT-6.1 Sol) assisted with reviewing the previous discussion,
preparing and reordering this series, updating trailers and recipients,
and drafting this cover letter, as well as helping debug the various
edge cases and proposing code changes.

[1] https://lore.kernel.org/all/20261026-g2ul_sci-v3-0-b3097163edd5@bp.renesas.com/

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
 drivers/tty/serial/sh-sci.c        | 73 ++++++++++++++++++++++++++------------
 3 files changed, 62 insertions(+), 38 deletions(-)
---
base-commit: 3d229ce89862b8e82d71a9e11d6f840ca272a6d6
change-id: 20261020-g2ul_sci-b610606ea5b5

Best regards,
--  
Diogo Ivo <diogo.ivo.sx@renesas.com>

