Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795166294;
	b=YgCouIl9nquZ1MAVZuYQP92S9WbMCIKzSjWStrJYF6w8Sho3fujblOLvP3j/Ixy859+F
	 cWrKUc4Z0zkfO0EKwc9907fcgM8et67OYo5j2ySRT1q4zDRSePNMXX0dRaiRKO0zkxK1A
	 DzdPaDkJrvT6KNV/V4g9ddjIWxyg7WMi5f27230GPX3HU8ZmSVrmgqJNE6VV6N9TzQz59
	 ImV3smvDemIW6oFIt88fDk48iRrNAiXY85vGJm1owl1DTDDaB221RBB0SnPzvHmMCe3T0
	 GIsfBcd9+nrBcYrnhivq0qgwFJ9fvjK2SG12+OcH8PYx9If40xzd6zex4Lw18o++YAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795166294;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:
	 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=bS72ymqc8FtQfMOJri9fTYNXdwukagCD9tTAdFGy1QQ=;
	b=UeaOyDY3Gl+8Vwj6OK7vOD2EopMrt77s7MVS/m6WqHPVYzj9YzLHcTL7QxWTeLH8ZGG3
	 r0otIDdlXsE1PadN6EILQ5PceiKjiPpBfmaMsugVAH+CtnudaUBiMe+PhD+JDrb7gF7aB
	 szPcL3Od+8vXfyK0w1SW2H+OAf5NRoV02DW8YiptaCw+ksj8NB9ihwDeolHaKPO6bceBl
	 DMDERAt+PGNCloW/JFYfEs0xfdPjjz614Jap4ua9jbzy6fwP8iqI4EfUkTrMjcmksl6ek
	 VhqUGsHQTCmebZ+cOYvbN7oXWLoCC8DlUhK+qVwpApKzUkT8MIDpTh/Ca4tfaI2sI4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=cH2WNGTs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.34
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011034.outbound.protection.outlook.com [40.107.130.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75056606A326;
	Fri, 20 Nov 2026 09:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75056606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=cH2WNGTs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IWRmewx6L35bpHQzeCrAeFqJHvE8t2LuHf2010mWsbSky/vUFIwOczSIjJ6Jiw66+qurEJ2GH6ZnrWw82PQEmSnWxVd7mWQ5M8YMKjttECbXiv0PaZUXJxsQuzcjJGlNiOuX90glxBuUJ1ys7V59A0PdXDfXtdm49Fc7+01Oz67+TYYE57sAh3PB9QQdupeuFaC/nUhYaXBR5HLK6UIZGKtogNX9ZOSfe1NpeWGXYQr5F7tXyByzku2aMiZLNdiyiBGT28YY3RkvcsAkskBop1+s1q2uDsvlWQmKCX7Zcttolrw6wceYauAraYX9lpYleRdDgDtyoW3zxcGhddZXEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bS72ymqc8FtQfMOJri9fTYNXdwukagCD9tTAdFGy1QQ=;
 b=sd0ROAHYj/p11wqpTfjJb9trRQ3bFe/GVt333xWETLu6DFI+t1yi6OEtaNtEsxWB65hF1nxkk/aNtLC0joOXUgecjbnOBYpKmIUMG/leRMjr8+iKayXxWTfihZ4DV+cg7SSXoXllU0lces+lqGmpLLGPTPObFBB5yc60AGPGSX8WGqylRqJHgXyEi5pbwCOirgljkfrcIGgv4tWbgAd3oGXCcTWFMIoztTYw4TPP5rnKjU/xSjP6Q4pyqHjs7d8z9BymRlltpzfu/K5ZML5JZn2J8/ZDJHQrrLMOgYfnQ4pwlszqQzBBjI7iIGWwN92PZhL4o4VnMMTC67UmKp363Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bS72ymqc8FtQfMOJri9fTYNXdwukagCD9tTAdFGy1QQ=;
 b=cH2WNGTsg9l03c5U7Av75IITGSbff76RrKw94MeVGZGQQkUZik2JsvSWEP4eyQOuTMmK1EpMqi0Bv8wILWYKJ2avncgjmV2PWuRnYdjF6oh9drjhIUqN22QYNJ1M2/wL83y2GqaCHPINtiwrRbcbeUzJuyYMUwElNJ6oAhsnPU6Od2wM0FmYSLflnR1fSeCN+iwUFDNY7K5rYOrV/acpljHj98EC9i0PATMX93RTZyZJqg4l7vQkZzNHWH6BTfDoNhjrrHPzCMpBT0q1ytr2NAJrbjiTs75Wgp065+zSuQ3QZ0Qb9N566ZAGB6nPKPN+BW3nLC/xd16A6RQnC2Rg4A==
Received: from AS8P250CA0011.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:330::16)
 by ZR6PR10MB130213.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:910:e8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Fri, 20 Nov
 2026 09:18:08 +0000
Received: from AM7PEPF00000053.EURPRD83.prod.outlook.com
 (2603:10a6:20b:330:cafe::44) by AS8P250CA0011.outlook.office365.com
 (2603:10a6:20b:330::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 09:18:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM7PEPF00000053.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Fri, 20 Nov 2026 09:18:08 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 20 Nov
 2026 10:18:52 +0100
Received: from localhost (10.48.87.222) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 20 Nov
 2026 10:18:05 +0100
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH 0/4] dmaengine: stm32-dma3: fix IRQ flag race and
 linked-list handling
Date: Fri, 20 Nov 2026 10:18:00 +0100
Message-ID: <20261120-dma3-fixes-v1-0-f29c1f437399@foss.st.com>
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
X-B4-Tracking: v=1; b=H4sIAEgQAGsC/x2LQQqAIBAAvyJ7TnAVhPpKdFjarfaQhUIE4t+Tj
 sPMVCiSVQpMpkKWR4teqQMOBtaD0i5WuTN45yMijpZPCnbTV4rluAYRZGJy0Ic7yy96Py+tfY9
 2bCdcAAAA
X-Change-ID: 20261119-dma3-fixes-d6c3ee1dada0
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <dmaengine@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Amelie Delaunay <amelie.delaunay@foss.st.com>, Jerome Audu
	<jerome.audu@st.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PEPF00000053:EE_|ZR6PR10MB130213:EE_
X-MS-Office365-Filtering-Correlation-Id: e27e9919-d761-4b6e-319c-08df46e730fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|6133799003|261009223027099003|18002099003|261022105027099003|261022075727099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261028144727099003|56012099006|10067099003|261102123227099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	rppEBUwEXnN3xbSez8kDpP5XNVQnOF+vQMXBuA0XNFsTTId+WO8Nl7fbsCOxCdethm7VJvA/CfBQ6fF9FYl4x4LxcdyNF+je0WnqTHJUGei1ebe9vccuEpdnWwiZtdiBVMo04m6EpIapAL0HeQ/NVGF7pgO3WA8jBt7JfAYpwXaTmxwbSiOdeiqo1xeN5/MS0rlEu4RL2eo3uQPqlZxetMactM6FZMPJYj4eyBNgTgGXkstzDCS0t/B8HDqdgTNzavhnLOQoPDelZSb6vgMRbH+BiCILyY+sWQBWEFG8FN0yFPu2s9Tfz4qh0TeuaM6xy1w7R5Qzy2LGhEAsHTSQ7ty42EXeQs4jrTxAXoTWuYQTA26vHXi82N515dQ2tJ6ccU6/VHRy0LBjkOmmMSMA1V+zN5Xa3YZBNP7GmkZIthpWzSpbCh4oBrloOgII36pQojYGC+ss8Uy4Gv8XDZ4xQMb2IS4fMIKgPaJX02oHM/0ImIHxiP/Zk35qh2i62XEJ4TMPJRJGBtJoFHPIQrGDJfQwY0pJueBytBIuUAEUul7xRG1B1DeaMgdJypAY6Y8TrIXeF3UKmBbaTY6rTkl26zYnkKq3QNZ34GDubLsliPWsn25YA4ENXGi9zuNJ37XLxb/TssFZRooDpvvCK04lfkS/stazvJCk7FcOmqzQLp4/aJebcPicXtbeavEL0ssX9nGjRpBSJWB8m1Bnt3Gpjw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(6133799003)(261009223027099003)(18002099003)(261022105027099003)(261022075727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261028144727099003)(56012099006)(10067099003)(261102123227099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2UibzlHPTBbPFr3VmfbmkEUA8120+nR1nAGqYu0Gxq8TgnDEFM3qY5r/UYHTfxQ4BKwBryuelCZfs85g2P1I80BmgONmTOvZOALPfHwTQkznmspCExwMG8DXQ8SVTO/WK5ALSlznqLXaDuAGs4e5azBHCZV/Uq9exv1gOdGtq60Hq9bgxnJ/yiSaW7xW2uB2wtsQyEQw6Gi/hG0SmXFFBrGCsPvxEGA1KSfFoqBzMlEnxaNTH3KUx1nMMgS+G/Xivc343IMa0DoNwH5v3I8wGsKqPeEkUEM+8HBHVqET99oCaHCaY8eSv4jJPGVxN2OBxC7qwoou9zUTUWLNmieZbJIfTWNEkkIWeEvZ8zflLZanDRVTArS9sks0a5xjcVZ68JSoUbDqBlFbM7Wq8OGYVTxpN8+YexNG/PJkb1UVUE0kNZtOFMyMXt+M4R16pitu
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 09:18:08.2242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e27e9919-d761-4b6e-319c-08df46e730fc
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM7PEPF00000053.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR6PR10MB130213

This series fixes issues in the STM32 DMA3 driver around transfer
completion and linked-list (LL) handling, plus a related cleanup.

- Patch 1: clear channel flags before handling completion, so the
  Transfer Complete flag of a new transfer started from the completion
  path is no longer cleared, which could lead to a timeout.
- Patch 2: write the LL base address (CxLBAR) when starting a transfer
  rather than at allocation, as other transfers prepared in between could
  change it.
- Patch 3: reject linked lists spanning several 64 KiB windows, since
  CLBAR provides the common upper address bits. Lists may now fail to be
  prepared when crossing a 64KiB boundary, which is preferable to
  the hardware fetching descriptors from the wrong addresses.
- Patch 4: cleanup, derive the descriptor size from the structure and
  correct the maximum descriptor count to (CLLR_LA / size) + 1.

Patches 1 to 3 fix issues present since the driver was introduced and
are marked for stable.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
Amelie Delaunay (3):
      dmaengine: stm32-dma3: set LL base address when transfer starts
      dmaengine: stm32-dma3: validate LLI pool allocations and fix cleanup
      dmaengine: stm32-dma3: replace hardcoded LLI size with aligned descriptor size

Jerome Audu (1):
      dmaengine: stm32-dma3: clear flags before signaling transfer completion

 drivers/dma/stm32/stm32-dma3.c | 78 ++++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 29 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261119-dma3-fixes-d6c3ee1dada0

Best regards,
--  
Amelie Delaunay <amelie.delaunay@foss.st.com>

