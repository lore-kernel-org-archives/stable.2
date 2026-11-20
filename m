Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795189790;
	b=F5/RHAw8ZqYluH6L9djs+ufQDVZUBDTUn1bfK7lyVKOiX9wibK/3vhgmGQ1hqWVLF/74
	 1bayo0W6IAMX0/RGwXnW+CuOZB3tSnYnLfILMCKMLd6TrOpJT44a6JAscy6rNog5i5iYS
	 yDL+U59C8Dy8WHherPR7B0NYXSPJkknIbRZOhVGuEdNFvxSI9Eeb2XhzqYX+nOA2oRCMz
	 LXd8soFCLUS75Kt9x54JE86PCZ9xdQimQ72i1LJqb/xGHS26L/MrpLALSin3uVeZ1kmOd
	 SkYjcsOhCnV9mA4EyuojzKucnTr4DvHT3FSk08YFGQkwBYc0Co+gUKQD6R0zvEtFz3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795189790;
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
	bh=DFyvufsVHqAR1qYS+LlZz5MxuMP24sPmrSwdQmceyb8=;
	b=Nv1TlRoWC484zxw1EVQWnTGLpdsdy+DnLgVfTncyovRHeaQNNURAXlo3JSF/xpyYgL6K
	 xEEAmLD6+OrV85A8/s9xvv1ZNTe1eA/VvrT92EjdOSWa9UrB8wjZpAdJ5iDsCJrOTkLxP
	 M3wC/m4n71/Y5d0NKoAj7RLojjQRFnvIfU8OCiIVZ2B7vpijbAjvDKuK3TnGLdXzk34hK
	 p83MK0D3laniGB5Y+pPIqBQ4T4y5IZeR3UtHxNUA/kaD0vYXygRhIG7XhERmjtIkpe1qO
	 iC2E/etayAM6a+MsFqgcGaiFUOg/CBIlsfC301tUBBGEO933ykuGmdtsy5yWMxhA4NQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=W+6CC6an;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.4
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011004.outbound.protection.outlook.com [52.101.125.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DFE606A320;
	Fri, 20 Nov 2026 15:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86DFE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=W+6CC6an
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWUNJsNAHWwAA7w0DcRUqaeZigDSnWX2dvLyZtRGK0HUP9Be94GycQ6dI6RSEyPlLvMORnnORENCVYe1Mf+TdzsEzpNt3U+7+FohWjEyUf/4xIBy+SzvKdK4cnR20ZTUPCnS1ZgO1t2Km+hamJnUhLWJ1sylsrJNsgT0hsW4gHLQdIm2h/kOCTDsvYRRkL8P9DHrWX8tArlFET74AKfwgSmq8TQiS2yaLSuGghdwVAMMxadsgsgHD6Mi08w/KsDS1MNJ0WlHkIpCVuC8DS3vSGm7kT96ykO5XaqdVGm7Io5KTZ0qx+uYFgo0sxwf8EwyWTh8IHqG//ctTSinbFhq/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFyvufsVHqAR1qYS+LlZz5MxuMP24sPmrSwdQmceyb8=;
 b=jb6kz710Rb/+egGMy3vuWd/7+Al/5wRtC+WSmEDuSK4oSqr3CjWvPDmydnnE815ULh8NvpihOUUJXOvTu7I7UwY1q1zq9DfTFyUFyFYdC4imUhMq4ghPHn5xi/jeTsiv6Co1C7gLREEVJprp3d4FfPerE35lldCA0Ecq5mAujufl1vyfH3geS2uNKjbxyfBCUOUsXNuVNFQzbCjM0cCGfTXBv6KYh3FNuwTuGEH18HwvW8iW9WoVYmVf5s4ZbwTRGRPdCWg7EFHGzJeYzsspo5Qm4wtfObk7br/01a1TY8n47JKFIy5KTB+WW+fFUOByN3Fe3K+NIdHbdocKcQ7fHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFyvufsVHqAR1qYS+LlZz5MxuMP24sPmrSwdQmceyb8=;
 b=W+6CC6anbasmFcJNsvxvI6X+AF3UA4TQ1Tepvjlt/TIIdawMfkKfcoB9q5xNwI87y+M1MdoYn8Dg1MvTH9txCk36ixSXj6eSvNRKt6hwLPcBMcJy411wM3bEAKFSE/itVMlYjgmAwb5v/iIrqQ/LPDorm8peSXvdAQMIvEVHuIc=
Received: from TYCP286CA0283.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c9::11)
 by TYYPR01MB13515.jpnprd01.prod.outlook.com (2603:1096:405:1c1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 15:49:44 +0000
Received: from TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9:cafe::49) by TYCP286CA0283.outlook.office365.com
 (2603:1096:400:3c9::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 15:49:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005622.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Fri, 20 Nov 2026 15:49:44 +0000
Received: from [10.42.0.1] (DEU-5CG4161SZR.adwin.renesas.com [10.226.92.16])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 71B08300023C;
	Sat, 21 Nov 2026 00:49:38 +0900 (JST)
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
Subject: [PATCH mainline-linux 0/4] serial: sh-sci: rsci: Add RS485 support
Date: Fri, 20 Nov 2026 15:49:23 +0000
Message-Id: <20261120-divo-ssgrlpcsrc-2996-rs485-v1-0-a989baae3559@renesas.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OwQqDMBBEf0X23C0m1aA99T+KhxhX3WKjZFUs4
 r9X7Q/0MjAMb2ZWEApMAvdohUAzC/d+N+oSgWutbwi52j3oWBulYoMVzz2KNKEbnASHOs8NBkm
 yFB252t50kpXkYC8YAtW8nOVPeFv2HXvCXaYFil8uU/kiNx4LB9GyjH34nG9mdXL/DM8KY8xMm
 tdGJzq29hHIk1i5uv4NxbZtX120OuLoAAAA
X-Change-ID: 20261106-divo-ssgrlpcsrc-2996-rs485-cecfa3248bec
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795189777; l=2116;
 i=diogo.ivo.sx@renesas.com; s=20240529; h=from:subject:message-id;
 bh=ZdPoRF7RBbtYGk2RpcDREskETR2MZPikBOb8Y+AQ79A=;
 b=5tmV+NbO7jQ7oGke3ac1PSPrM5m2HvLNGjoyLjlzBRP84k/1F5uMmCxQzGgw4845wKdLK/gai
 mv4V8Eo8D05Axssc2Yc34jRtAHpDCVSJXWhVKxaqibBQY8PED0EytUY
X-Developer-Key: i=diogo.ivo.sx@renesas.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005622:EE_|TYYPR01MB13515:EE_
X-MS-Office365-Filtering-Correlation-Id: 7126001d-baaa-481e-8c07-08df471de606
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|23010399003|1800799024|18002099003|6133799003|13003099007|921020|11063799006|56012099006|261026121527099003|10067099003|261022075727099003|261009223027099003|261021121427099003|261021123027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	y902IDNuk7LYu0UvRlXeJC26pxBlUO++c0ATXhllRq+4tE5r4467eF1Q/hqcAh+fFeAiXAhkny3Y5xobyAguWB+lNitdlZVWUFBkZ8DDtyJ/W4E3yQ14vWR5wEHYJOG9+j5KKbd9oUy0fuPc1pZ6vu2SQPtzqWpvM/FgIYht5WDcka33zYzUAFJn0BtURqs5F25NUQVQGLGGKjvBJebK7gMmNa0XXzNH4tg+REolT+oQOEH3oBWmnMFr6wCnpPdJFzEJmpPq7uAeS5FjHb7X/75or49tq0dEj+IJMwm2JyEirL4ocQJHyGAY00czvVYHVNTzeDBjBM9/6VpIS+ZPvJr/WsBBEGYT5bAweEbqsoytlj1846A7/qjDUyBoVGN6X3HDFGmcSL/bNSwy/cho5JXs/61sycCSEDWY8z/IN3M4MhcqoQFr9g7kfFt8Zvi53mYP8oET23JFWqajfaOb4ujsL0I+GRUBg5H3cnzpLiXZDHN7Tc+noV2IwAMvL0Rk+FDEeSI88dy5F3/XvpE6MRMLoh8WrI48V/gHmPbe5CNujG7TYpaxnRblc67s1foNBNMe9yAU589UNAtF7MSWNr77wyB4mu750LkyW5VzETFbaALYTbl0csQhBsZZ+dfUU8fxRG27A4gZ3RdVWinSZMMWuWnmGz2N44KwHkIcVWelyu9Gu/eMtG40SXNK1Nc2
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:JP;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(23010399003)(1800799024)(18002099003)(6133799003)(13003099007)(921020)(11063799006)(56012099006)(261026121527099003)(10067099003)(261022075727099003)(261009223027099003)(261021121427099003)(261021123027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Wirj3oipZE3HxbhvwICXRWAOY/QuHJ5ByVwilKySnC3/uIvJ4lWkNurK1g2q8spC7q4oQvu53CVQnJoyN8mwA1Rr+puX5kk4GwRmKOoKPLwPXSepwVbn4J0mlaW9AkeP7G6zLiAl83mfdzKRSvHX9AfgCDHzJx82ZiTxUMjvU2T1NZcA1wKWC9EMGdScKaTz6eFwYdC+Wj7+JYp+xfgZlb9D3ueNlxNId1Y+InMKA+kFsT82i2JSNpzfMFMVaenhAjlXTEXHXzGmpluKECvolh/b5jRJ4zyeJMSniZQ3SWhYM4YSdTL01oCtX4K+/Lehw4TuLHzGzt0EK+UK+z9EdH5PcfHZLOq3pPJHm4vQSjp4scocih8Qd2XeriR3pZbjTzW5ldy/SCGRBLAf9wvjXTOtmK0d8T+doIwRtGkS12RjbtfFFYw7pDrHurnsztRJ
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 15:49:44.8203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7126001d-baaa-481e-8c07-08df471de606
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13515

This series adds hardware RS485 support to the Renesas RSCI serial
driver, along with an RX FIFO trigger fix needed to prevent overruns,
and enables optional RS485 operation on the RZ/G3L SMARC EVK:

 - Patch 1 lowers the RSCI RX FIFO trigger level to half the FIFO size
   (8 of 16 for RSCI_PORT_SCIF16 and 16 of 32 for RSCI_PORT_SCIF32) to
   prevent receive overruns at 115200 baud on RZ/G3L and 1152000 baud on
   RZ/T2H.
 - Patch 2 documents the standard RS485 properties in the renesas,rsci
   Device Tree binding by referencing rs485.yaml#.
 - Patch 3 adds hardware RS485 support to the RSCI driver via the
   Driver Control Register (DCR) and CCR3.DEN bit, configuring the DE
   signal polarity (DCR.DEPOL) and assertion/negation delays (DCR.DEAST
   and DCR.DENGT), and handling half-duplex echo suppression in software
   when SER_RS485_RX_DURING_TX is not set.
 - Patch 4 adds an RS485_ENABLE macro (disabled by default) to the
   RZ/G3L SMARC EVK Device Tree to configure RSCI2 for RS485 operation.

This series depends on:
 - "Fix transmit handling on SCI/RSCI ports" [1]

[1] https://lore.kernel.org/r/20261117-g2ul_sci-v5-0-30b58ea18923@renesas.com

Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>

---
Cosmin Tanislav (1):
      tty: serial: sh-sci: set the RSCI RX FIFO trigger to half the FIFO

Diogo Ivo (3):
      dt-bindings: serial: renesas,rsci: Document RS485 properties
      serial: sh-sci: rsci: Add RS485 support
      arm64: dts: renesas: r9a08g046l48-smarc: Add RS485 support on RSCI2

 .../devicetree/bindings/serial/renesas,rsci.yaml   |  1 +
 arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts | 11 +++
 drivers/tty/serial/rsci.c                          | 89 ++++++++++++++++++++++
 drivers/tty/serial/sh-sci-common.h                 |  3 +
 drivers/tty/serial/sh-sci.c                        | 20 ++++-
 5 files changed, 122 insertions(+), 2 deletions(-)
---
base-commit: f2b455e5f155a969e576a1ad019a2225b514da2c
change-id: 20261106-divo-ssgrlpcsrc-2996-rs485-cecfa3248bec

Best regards,
--  
Diogo Ivo <diogo.ivo.sx@renesas.com>

