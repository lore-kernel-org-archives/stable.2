Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793014564;
	b=HuluPTL1ntIrUy3dNs5mAFKaH5/YQpcRkcL/CSUbEFAZIg/vVXc8sgu25iCnc1iRhzOV
	 UbEIJ8ANixJ3uHQNERm+Bz/IcTQXJ1YLxS5wUgArVPNRwcod9j6DIZZ1qSFLETxGLhRmY
	 zHHSyevdQ9XNdryCtu7371TDeyjXStEFicnjimMAfUIWtxXKFMEt3UZuIWHR9fpu8fZtB
	 WRV2ldmxKp3TOvcc8EgpmMtw/1f+gJMWd4HT5iTAcZaoFNwz84+UTXOp+e1D0WbKwoTPN
	 EI5y5ERPDkHLJmfCryIRF1c1OHzzAMx7q+h4Q4YXRUc8omtp9AGbY2iNlES79QItW0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014564;
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
	bh=Iq431SJVYtHtYBld82ZsXB+E+LKti4gwwfcIzs0CMhc=;
	b=I0A1XxQ7++a5zzDZkk89kidvwenS8DLBNasy8+qD/2hA5vqZvuY1koEvThbTWhR+jWmy
	 RYjJHd1pt7M3k16tlfUiYz15XbSfkupu/VJoLF46IePR7kuzU9ONdCLeMKk2lmX+yGltx
	 FugBibxDXN/+2nugR4C2hYjx0AIh3fXrlFBNAcWhT+dfIA+I9YviWjXLXKyqxv/gJxoct
	 IGSLuL5GBd1glQgmmEAAlwgi4fbSqv1pS3H9caQLvl6hn/iLb5CFyxa3wPFXfxVHe5pGX
	 Ycjg3ZxTXAu+YEtXjiQhGZ29+p8xloSGBcF14pC6D8DPKXulbrOTeVRPd3AmMDgRsPg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=dmxXG5Ty;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.48
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011048.outbound.protection.outlook.com [40.107.74.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079F2606A31B;
	Mon, 26 Oct 2026 11:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 079F2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=dmxXG5Ty
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GeDEp7odfvBQCdV/wcJ0KAHZh+qixMY4n4BLagTAzOU2FBYs0zZ/JJk86hG95Vbinp452H5ySQTGd5HioxWwHn3qfRxdmK5MQckS5Wi/ZNegzRRfaYAgUbLXWFFry6w8qjzen2t2zhGztLq7Km3SmJlJMgKkhSjGnAB01zjegkAzRZA9RaZAmggw155ouRQPeUzXZQwiwrKwzbdoNdCLf/xXMRpVe8LWN+DKvevWhQDLOjsowFitN/eZ0Kwob58tevOYYyypA5nQ6MiOKXTN2eT4jOtq/4pg/g1QPkL89RZJhtKKrBaF8XJYATyyk9OzK7MfycklZW7f6QSSDHFYPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iq431SJVYtHtYBld82ZsXB+E+LKti4gwwfcIzs0CMhc=;
 b=n3oA7KkmEmd0/oDkgabHDOwwFYOTokcY0KmxJfU2jIeYrwNGNIHd4xw2HHb9xi/Qwtky4uq+KBRAk3LBPxhP6AgkiKVk0yJqqMClYlZkP5i9kMSL1g+WhjpRFGSgWR6WEXQo7MIrwUebJhCdGbkk/IIKDQNqtVpLWTyJTZ7Gl2ZcvVoGV8tXKnP2wakWJW+B6S0uvn9R2v+lXDj1sMsJLbV9RQp29StDnfgGj2seC7rTxna5JFhHF8tAkrmfNUXsnJnAKAs9iDNtv6/LO4+25Nhn3i5k/Gvg4vMvPs4XHKsnTyvfx8J9a6yR7Ew6dK4KtWqLQE9Rk8Bw1Ub6FsnJkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=baylibre.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iq431SJVYtHtYBld82ZsXB+E+LKti4gwwfcIzs0CMhc=;
 b=dmxXG5TyJZTKTWmFjaSAkIRM/T3tlDk/hHeutbnn+d/KU/foYmAUSdLbNol1+aC4O3KzL+NkCPGcBgz/kJrmSwUdRYzFaih5d7qjIVJMQ8wAaRyA54/yrNnxTzY1M2QkW8Ru2XJGKugKT4wrOANPgzdBxQwtnZLjeYL9B8TdEdc=
Received: from TYCP286CA0191.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:382::16)
 by OSCPR01MB13210.jpnprd01.prod.outlook.com (2603:1096:604:354::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 11:35:58 +0000
Received: from TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382:cafe::84) by TYCP286CA0191.outlook.office365.com
 (2603:1096:400:382::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 11:35:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005622.mail.protection.outlook.com (10.167.240.53) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4
 via Frontend Transport; Mon, 26 Oct 2026 11:35:58 +0000
Received: from [192.168.1.82] (unknown [10.226.92.223])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 362103000253;
	Mon, 26 Oct 2026 20:35:49 +0900 (JST)
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
Subject: [PATCH v2 0/7] i3c: renesas: Add RZ/G3L support
Date: Mon, 26 Oct 2026 11:35:43 +0000
Message-Id: <20261026-divo-ssgrlpcsrc-2966-i3c-v2-0-2e76b87209bb@renesas.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr0K6dkxbKAIr72FYlDLAGKWkg42Gc
 HcBL+DyJe+/vwjGQMiiShYRMBKTHzfQp0S4wY49ArUbCy11rqSW0FL0wNyHx+Q4ONBlngOlDhp
 nC9NkRVdmqdjmU8CO3kf6Vv+YX80d3bz3dmMgnn34HN9R7d4fN1GBhFTa7NJpg0aZa8AR2fLZ+
 aeo13X9Aq9k6tTUAAAA
X-Change-ID: 20261020-divo-ssgrlpcsrc-2966-i3c-bca85b48f943
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Linus Walleij <linusw@kernel.org>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Diogo Ivo <diogo.ivo.sx@renesas.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793014549; l=3326;
 i=diogo.ivo.sx@renesas.com; s=20240529; h=from:subject:message-id;
 bh=s1WHqKHNwMdlqfCJn8dBx/XvKcN97686CeW5rwxfau4=;
 b=7dgDli/P9S/D9QQpp9uv5RAJuhekJpVzn8bcWGi2P0hjzQGPpdM1npVEWHQjWALmnexkxPX9o
 BqLaAK27MjzDf5QqMR7ukBwr3A0Y0Z15t3CKLPyey4fbnq9AdNFgX9e
X-Developer-Key: i=diogo.ivo.sx@renesas.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005622:EE_|OSCPR01MB13210:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c3e998b-5fc7-46d1-32c0-08df33554e19
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|23010399003|1800799024|13003099007|921020|11063799006|56012099006|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261009223027099003|261009221227099003|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	W0HBLlsuE+aKQ2JoFAORft2j36Y+Js71cuWhxyls0IfS5prRYFWUxO15XPdyomfrL9I5sndhoa4EkOlNpirNZosNTHyOJyTMGrP3PFD+WrcAvL0ZzLsORm8OzA0QHUXc+8/jDIdKZSXgoq9H2l1foeVKrA6FQ9vRAYRcEzxFYuZyWcVrD8gWshedLEyEGkZ3Si5Mdfcv8v/LYYl8UHdIk2LWHebNgpH6dwvsZy7C5xySYpC/amfdN4EDLLEbyIWf6LP02GaROK+ugpg30b5fkB7IVGC45cEb28luFGxzfM9L/j4OJztEAZARgY3/09p/nKPtp7BPDm9XU7/s04yaFgdXG5ORskikU6phjF8VevEoDf50kHRRJhwndTV29TgQouuAfNqtJy8BkyySGPKAAOkpwP1FS4QJoN2xOzdAJ3OZ2bDD8Zd4x2j0SMixw4fUgk9TRVDgBXgs3rHlNDfN4xNtqYxajG4JYNwo/FdZCtV53PNlCUgq2VcwrppFWSS2PLztP3FcqsfNCyLFwTn1buxqlukI723aAfv486QEhoTxPCcquPTRM49unf/RjC1RjbfdbJotXvqVM92SM5Erzxfe1GB8IEChGxBpjyHnqB/ckT7CpYBjhTBVO2nkvU8wAgMRDJ5+niL8f03d1X0+B33HrgqTaTlCXmlO0+3FB+uX5ldsVjw1TvO3MSI3vJQq
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(23010399003)(1800799024)(13003099007)(921020)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261009223027099003)(261009221227099003)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4AlO9ytrkX5+SnXgAdbX3kSB5/LHn5yr8EpCVHQtViYttQ5mCKJzfVCab5yz3g/MSGRbgSZwSbYkP9pUH1rPrsOF+xalJX7vOm6yjpB3kJci2DEtzsBG/xnFObpcJ02Ou/20nUPeV0QFnW8qFulCxVQp7E6stZsl5tgKC7MulqLKaAoQjaqlcue4xzei4DBs+sMgSKfgMIBEMNV6bxlb+1ypD+k8BtlxIXVuYir2PG4QcYQO2C5IAOKLCFhyYWhkga3aqBhdGH2eFzL47FrV1FFDDrKneTyE4lXSaSVjp3HN/yBLsXKIYJpyl5NPJOnrtFE8iygiVNgbgZPgRgJDaXGx3Aj6HlUwSri3c33QOaYnQm30ymf6aGkMTYVSb9FFa8g4Z8kymXnoGVyQhZkHOtNyY1bXBQP/TuyQC7pEIFzTZSfSumwEYEt1/Na0Es78
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 11:35:58.4917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c3e998b-5fc7-46d1-32c0-08df33554e19
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005622.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13210

Hi,

this series adds I3C support for the Renesas RZ/G3L (R9A08G046) SoC and
enables the controller on the RZ/G3L SMARC EVK.

It starts with a driver fix, which is independently applicable and
marked for stable: on a pure I3C bus, the I3C core leaves the I2C SCL
rate at zero, and the driver used to derive a zero-width open-drain SCL
from it. It now falls back to the 1 MHz FM+ limit instead. There is also
a small cosmetic patch removing a comma after the sentinel in the
compatible table, for consistency.

The rest of the series adds the DT bindings, the CPG clocks and resets,
and the SoC and board device tree support for RZ/G3L. The driver only
consumes resources that are common to the RZ/G3L and the RZ/G3S
(R9A08G045) (the tclk clock, the presetn and tresetn resets and seven
named interrupts), so no driver changes are needed: the RZ/G3L is
described by the SoC-specific renesas,r9a08g046-i3c compatible with a
fallback to the renesas,r9a08g045-i3c compatible of the RZ/G3S, which
the driver already matches.

The board enablement is guarded by the SW_I3C_EN switch, as the pins
are shared with RIIC3 and the audio codec behind it.

The I3C I/O voltage can be set to 1.2V or 1.8V on the board through
the SYS.3 (I3C_IOVS) switch. As software needs to tell the pin
controller which voltage is in effect, the series also adds pin
controller support for the I3C power source on RZ/G3L together with the
matching board device tree configuration.

Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
---
Changes in v2:
- Drop the "i3c: renesas: Add RZ/G3L support" patch and express the
  compatibility of the RZ/G3L with a fallback to the
  renesas,r9a08g045-i3c compatible in the bindings and in the DTS, as
  suggested by Krzysztof.
- Split the clock and interrupt constraints in the bindings into
  separate if/else blocks to handle the RZ/G3S fallback on RZ/G3L
  nodes.
- Sort the &i3c and i3c_pins nodes alphabetically in
  r9a08g046l48-smarc.dts.
- Link to v1: https://patch.msgid.link/20261020-divo-ssgrlpcsrc-2966-i3c-v1-0-30a47f25e515@renesas.com

---
Diogo Ivo (7):
      i3c: renesas: Fix zero I2C SCL rate on pure I3C buses
      i3c: renesas: Drop comma after OF match table sentinel
      dt-bindings: i3c: renesas,i3c: Add RZ/G3L support
      clk: renesas: r9a08g046: Add I3C clocks and resets
      pinctrl: renesas: rzg2l: Split SoC-specific masks in struct rzg2l_register_masks
      pinctrl: renesas: rzg2l: Add RZ/G3L support for selecting I3C power source
      arm64: dts: renesas: r9a08g046: Add I3C support

 .../devicetree/bindings/i3c/renesas,i3c.yaml       | 27 +++++++++++------
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi         | 35 ++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts | 21 +++++++++++++
 arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi   |  4 +++
 drivers/clk/renesas/r9a08g046-cpg.c                |  7 +++++
 drivers/i3c/master/renesas-i3c.c                   | 12 ++++++--
 drivers/pinctrl/renesas/pinctrl-rzg2l.c            | 25 ++++++++--------
 7 files changed, 107 insertions(+), 24 deletions(-)
---
base-commit: 5d13f5297a1bd1fdff5fab7efcdbc9bfe407e457
change-id: 20261020-divo-ssgrlpcsrc-2966-i3c-bca85b48f943

Best regards,
--  
Diogo Ivo <diogo.ivo.sx@renesas.com>

