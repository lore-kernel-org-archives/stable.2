Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795795416;
	b=wFOondvl13PDwLju16UXR/7xLQn4m+zlJ9lUQ8Hz4rxMNc7pSiDTHxldMwT3XZEW2SpW
	 DiWE1qRYyzniW6fUWc0Loz5yfaPQXm6UdgCQjFr2u2Q7ajtlgEuoo3C6EEnkAThScB3AK
	 OPSClp8WXOL4scJ6/3WqTKpocnob6YNUHL/KYfNmCqZSYV0ioFSkSLw31W34SVF+EEAc0
	 eYXe2c/Ki9/l0d0WemBMStESoWB3xKa6jAt2uq37JQCkj6opp5+mZwWKN8VuJXuaMNVQn
	 UMmlL3/igiDmFItyl7O0DGeSn50EzGZMScOoSeSMsc89VIgNjpM/tsL08qWo0ulzLbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795795416;
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
	bh=9prKf1io9NyLIshrFb/kwvgcmB4vFRZFXC8ubabMRts=;
	b=Y6Ah9R2qMoE67btlYo85THuFP3gXGQSwRbT+W1oZePCxKxAwoau4y6Rz8exruw1pi6T6
	 +0Ab3lk3YQcNU1ZjW6C9aAWgKD8ckuLF1ld5Tapx4jfPjQqe+7syskLw1L7oJVOHqWozT
	 Xwm5ncuLGcsHSXEqJ9A6lXrXYgpv7wTfpwHwYZOznwzViFxhieJbOD4Q7x2PgBBZNh7vP
	 0tWU8S3E+XUhpKfzFhTGDOnDX0mkzkKhtmua8EeT5j00Zo9KTXyz9aIK4/rGY1i8b4/V4
	 HPoYBgwPQRBbqTAl5IDxZuF/RmSrwBrSDsy7qM4PxiILdUXF2HN96Q2+7+YsDYr25Kw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=Nx8ADg6Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.228.16
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010016.outbound.protection.outlook.com [52.101.228.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F6C606A31C;
	Fri, 27 Nov 2026 16:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21F6C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=Nx8ADg6Z
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVJgaVfjDa9gflB/233niR1fbfvDI3kTiMUJdmNOvkHBq5hzB38G+RyIle5DY4oVfDPQYMP7ZrorFBpAEzpZsxoxQd4IbNNzaDR9J7Zi0RKJKp9CyzRB/GoTuPbxDuYCSgwtft3XfRQ1yv+hDNy9K5xzFBs7/Ium1LbLy70snySiOZmcFKP9xyYcKoyRnYKzsTRkbEKqPCiS/o4LTh8EI/UoevVVbok+0VWtMpLq+8r8m+HiCUDxyXwM9K4FtJ1PIaq6+E2UJUq2VG9mqrD4t6kfC0ntf/sCvq7Io2nEIna7hg0ZqcIXZmKfrMXWaVcW5u2/M8VnfbUTvHYZZ3cCvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9prKf1io9NyLIshrFb/kwvgcmB4vFRZFXC8ubabMRts=;
 b=GYTpS08M2d6SeFYTxPPyPThCFc5fGVQPGJSrWB7lLJfFUvV0f13VFskos1Z/mWne3r2U6jKqPi1s2L8h2yQKi0JZ75JhahBB5TOTePBGKv+NgOfDOamMg5Sa7P7jy2syDaupPuJSsWvmp+hRx0U2spv8LIaV8khTEJISHd9oGXnFonPm/2/BLO/mHOaVzhnR5xIhn/xsRdWr/jz/CbyjZK0mgaeU7pn6sedJoksjo5DXrTe31MN/LwNlkaEm/a96Rhdgi1SkJJHrumU7wjSkvGS52wYjlEj4Zm4FgTFEupqzOGG5OLK1oMXC9H/PtVARpgg5dsiW5Ek620V52jafZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9prKf1io9NyLIshrFb/kwvgcmB4vFRZFXC8ubabMRts=;
 b=Nx8ADg6ZhNiBg2TUE8AAtzssapkVzxF+BFptJoSLd97sUMxfqbEJP63fujCDNEL8MfUCW9JK81jzDlJPR3i4Y7Emvoi0QVT22CLTE/3xkShhx7dUYkhshUSFFAUY54SZFWw8gbu9aOE5tXFUM9nNe3IZK2fOIrJyqkLIL87fB7A=
Received: from TY4P286CA0094.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:369::13)
 by OSCPR01MB13063.jpnprd01.prod.outlook.com (2603:1096:604:32d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Fri, 27 Nov
 2026 16:03:27 +0000
Received: from TYO1EPF00005024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369:cafe::23) by TY4P286CA0094.outlook.office365.com
 (2603:1096:405:369::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.9 via Frontend Transport; Fri, 27
 Nov 2026 16:03:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005024.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.688.5
 via Frontend Transport; Fri, 27 Nov 2026 16:03:27 +0000
Received: from [192.168.1.200] (DEU-5CG63502GH.adwin.renesas.com [10.226.92.79])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 18990300029D;
	Sat, 28 Nov 2026 01:03:21 +0900 (JST)
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
Subject: [PATCH 0/3] tty: serial: sh-sci: set the RSCI RX FIFO trigger to
 half the FIFO
Date: Fri, 27 Nov 2026 16:03:06 +0000
Message-Id: <20261127-divo-ssgrlpcsrc-2996-rsci-rx-fixes-v1-0-cad6ce9f83bc@renesas.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WOQQ6CMBBFr0K6dkxblFpX3sOwgDJAjVIygw2Gc
 HcLnsDly/95/y+CkTyyuGaLIIyefRgSqEMmXF8NHYJvEgstdaGUNtD4GIC5o+fomBxoawsgdh5
 ohtbPyJAbVZ3MWRlpnEiikXAPkude/pjf9QPdtJm3Ru95CvTZX0S19f4ajAokyCa/tGjRWFffC
 Afkio8uvES5rusXLP3yO+gAAAA=
X-Change-ID: 20261127-divo-ssgrlpcsrc-2996-rsci-rx-fixes-371a4751707c
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Thierry Bultel <thierry.bultel.yh@bp.renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Biju Das <biju.das.jz@bp.renesas.com>, 
 Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, Diogo Ivo <diogo.ivo.sx@renesas.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795795401; l=1714;
 i=diogo.ivo.sx@renesas.com; s=20240529; h=from:subject:message-id;
 bh=ayEkCepphAfoVxuDCBJI352bc3fKv4EtyF+Y5T6dr5g=;
 b=YAFKRbZfGpCCgI2EjRGu4VvHarhUx2OsQkhbBeEohGL71sKnf3GZbU/5z8HPA1wc3dFEC58CG
 hRpF/JMgkyRAvuZQ817xtogP7fsBbXn57aXohhUmf62OUDUoJ/2waUc
X-Developer-Key: i=diogo.ivo.sx@renesas.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005024:EE_|OSCPR01MB13063:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d0b40c6-d9d7-421c-83cf-08df4c9ff977
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|10067099003|56012099006|261102123227099003|261026140227099003|261021123027099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|261009223027099003|18002099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	nHlvGQg+tmqLbnve8xmhPxTX7ly/J3HL3eFMhH2FqG6055UUsaNrqnH+qVF62iDIdPnE/2mji9liFtZ6GilH4e1oTGPRa944TGM/R9Jp5i6emrBY6q44lt5McbFvlMp+TtbHyY69VOmO5Pd7jD89Xfli3zzWCsKm3F+jaIAWbmrWmQ+NRwU/8wMNj70/ThWZaXaJTLEgOaGwhu2CDAnwT9Rx2KofHNyXGwRB8RNY8nHcQA+sP+rhhucy4locwlk8ebSkzU9aLbQBn81F0vUwxR+/CzxXJTbLn+t5Qwk6Xyg05PlFwhsukFGPwzoitIY9DLof2vJqA0NWYe/MJoY+srKnZoDA4i31eRLOvDgGNTzXYahaRMMPO0nH0C6bLvEd4rs98jYyao+gEqHEAP50E/eUMuMe0d1wIrJ3zRUjkzgo4vUtvU3PMwCJMjy2XL4hkvHF2XfteBs/DXpx3Q3a+Qq2O0gqsf2EIpdiNVG8Ed/KggTDCi0FcmYy3pxw5JbPMc+EIK+CM2o8MKHGfp/TOvkBMXFmFH6vmaUVd8QgU5BjUFi67JiS/fkd1NYdbOrv1dpJOD3De8K/PNyzWoO//F1pUsOFAYr9dlNrsOEvyJSYhsPUqE07bbqpFJp5XRAT6OGZ6oESZ+uC0xKcl0XW+2RyOCu20bG6tawFKyqomQYp6MPAr73TL2kMBDZoXR9V1WA3kk2pznfKNMx5M1HbUQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(10067099003)(56012099006)(261102123227099003)(261026140227099003)(261021123027099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261009223027099003)(18002099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gbzXdxd6lXBkU8MU5N4PNytuDCoXSbMMZSSNaU+cTHz6Oc89n/SroRGWmqUkbkmSCEcdVT8+N9wdaNUI4cfs+Lfcbl9dGd3LfVg/IWkd+3oCMMSQzT6Cxo8GpoBIRVnnRURjeF7K0L+Ze5ME6PcvpW1ARRotrLEzOTrev9mFRx+052cQrhLM/9zjR+++s2gP30ml19SWRaE8eSFOEBfqa41i9LpOu3aFOJHbNjnidyC//gFjCCHLOBTwnTm1zqea8Bp3b/E3N6ppIeqLHIjS39aAPuB4WDsvvClIQu35vggce2TX7Djv0oTuWyuz6HLpiySVBz3c5X+HVIC7PPgvo2doGZzHVMUTXARClJNcNJLbVA2lpRhC4VWdFa9EavaiWqC3ElBNMmRGP2fkoxc079Lckk/JJzhTtFklshX3NsLJeBwxXcmRfjwUETNEfFyz
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 16:03:27.8257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0b40c6-d9d7-421c-83cf-08df4c9ff977
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005024.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13063

The RSCI port types ask for a RX FIFO trigger equal to their FIFO size,
which rsci_scif_set_rtrg() clamps to fifosize - 1. RDRF is raised once
the FIFO holds at least RTRG bytes, so the receive interrupt arrives
with a single byte of space left, causing overruns at 1152000 baud on
RZ/T2H, and at 115200 baud on RZ/G3L.

Every other port with a FIFO triggers at half of it, SCIF at 8 of 16 and
HSCIF at 64 of 128. The only exceptions are SCIFA and SCIFB which set it
to 1 because they have no hardware FIFO timeout and a higher trigger
would leave bytes in the FIFO.

Trigger at half the FIFO for RSCI as well, 8 of 16 for RSCI_PORT_SCIF16
and 16 of 32 for the RSCI_PORT_SCIF32 types. The series splits this into
three patches, one for each RSCI port type, in order to make backporting
easier.

For the first patch, adjusting RZ/T2H, some changes are needed in order
to apply it to 6.18 stable since mainline has diverged due to commits
3a3ab10245b6 ("serial: sh-sci: Update rx_trigger size for RZ/T2H RSCI") and
d53f4aa9edaa ("serial: sh-sci: Rename port SCI_PORT_RSCI->RSCI_PORT_SCIF16"). 

Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
---
Diogo Ivo (3):
      tty: serial: sh-sci: set the RSCI RX FIFO trigger to half the FIFO on T2H
      tty: serial: sh-sci: set the RSCI RX FIFO trigger to half the FIFO on G3E
      tty: serial: sh-sci: set the RSCI RX FIFO trigger to half the FIFO on G3L

 drivers/tty/serial/sh-sci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
---
base-commit: 27fc36c7e3e22d67db77f8076020cb4c5080668e
change-id: 20261127-divo-ssgrlpcsrc-2996-rsci-rx-fixes-371a4751707c

Best regards,
--  
Diogo Ivo <diogo.ivo.sx@renesas.com>

