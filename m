Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.42.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794202153;
	b=WCVRWUrE0QCXMMR+2pQ6za2BqhHpKX6mcOCEreLPDGK0Q8cQXK7uzJEyZTbGbSLKdZdw
	 H7Uo4ntoZmmPYaGxJ0bPuxrdfWVgd2Xvi677riEQgA/djapvMSAiKPMrWCyi/xKWSE8CQ
	 s7+UP14YCBgdr73WZ/yeF5hk8cayfFkITTxJOn3vMiDgnE9eKCaaM44etd2HoYp3qyZvl
	 hTvqFpIpitwVR8gkPYHovDw86//Q0qNPfTXMP0b7JAD0Mr5d/YRd7ObF0ksZWQk+uFvM4
	 9zz/+SEKi7kWMS6ZuQE5p8AeyAVVooSv0KxWqUC1yn0zwZBjaiIrrbu0RERKXt4bJeQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794202153;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=XmQ2sMdIKS1TGPnNUhh8QsAfffR3rTzosLTT7oxGcAk=;
	b=OtaFbqh6KeJ+pLfDPReRO1QRDt3zWfDPRvfVj53C5eyTLkZ/O8B9ngXTLSFGLt1eibQI
	 zqEM+t+Mh+D7WUTpJ2BSMXIMsM/e34uk1u28MZK3mK4Z4fXx2ydWSx5IgsXLmaz19ap/M
	 fkICJFOwKR1kkA/R3i4o0OBOCPbTOlV63iEzYLz4ocFdZ3z8A1i6pJesiLcgKAPFEdxdB
	 9JG08YjxqFaR5+028U7DN76jcgm7UWaUd6TbxBlNWrvQdcTViT2CoYHSkubZ1ye/wftsT
	 IJNQqlqn2eK8wMX/KLLmnhxPvW7vxM3ELlk4i98kR9kZEKbZlaHl3suZINlGAgwOaWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chipsnmedia.com;
	spf=fail smtp.mailfrom=chipsnmedia.com;
	dkim=pass header.d=chipsnmedia.com header.i=@chipsnmedia.com header.a=rsa-sha256 header.s=selector2 header.b=CQoLtCzy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.42.75
Received: from SE2P216CU007.outbound.protection.outlook.com (mail-koreacentralazon11021075.outbound.protection.outlook.com [40.107.42.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1281F606D826;
	Mon,  9 Nov 2026 05:29:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1281F606D826
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chipsnmedia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=chipsnmedia.com header.i=@chipsnmedia.com header.a=rsa-sha256 header.s=selector2 header.b=CQoLtCzy
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cO9+L7EW9BRwFBaSNbsm9IaR4HPl7/4t1bR20AR6qiathoT9vDfgCLb0oJUmVx6Ga+8nzpgYP1ia32h5oP7VRpcuK4VtyOEeM33lwFQ6RyOwjS1F9FBIhDlY2bRxZl7Vwttcf9k3Pq4DxUFyX3Dr35FqImWyKzUrjzj51p8ia++56P4cUZvn0PQJyMMaFC6nupeLHeWEmi1n86oaqHy+tpuHYfB+vyS9gxTzLCAWfFua1j8at4WZoVlHY7ewAFtLBxd8berUCf7AIX56d50/A96mMFNCdjwYu9JetF4kR+hOyl9FlI+2FyUx0A6TVjkzIoDv78SRbfnXsO4hGxfbfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmQ2sMdIKS1TGPnNUhh8QsAfffR3rTzosLTT7oxGcAk=;
 b=y3C8poHy43NLtLZjdYuJjFcLp8CUosmX3rcO2rqYjK1G1J4eOMbv15QhcNGgI9wEbCEivm4FnGcEk2EjSNooe6LSfxlBgXdpiqTRy7e8x9TNuy/SxikDnBJ5sgJXvT8yWSWqDvT9eVEc2P9bxFLAqxQMNTNWRCIaSxEJcL+tvogctP4GJqIvRj4MKTu4xzD+nUcHuhTx8G3odMG41LHGGXg0RoEjKXpFQtlXU8nGZZq5tOw9GEgpwSEf6Vyr4eA67B7k/atvYs4D1ljVeZjxPQu+GYSRPInBP7QK1XXSuVRTX4xfO2vqqsb4EApw14XJRAjM8EKDwQGOybQpylUBSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=chipsnmedia.com; dmarc=pass action=none
 header.from=chipsnmedia.com; dkim=pass header.d=chipsnmedia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chipsnmedia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmQ2sMdIKS1TGPnNUhh8QsAfffR3rTzosLTT7oxGcAk=;
 b=CQoLtCzy9gKkVO+eyeP6E587Z1SRBcqkIc0F3rxww1bPkVKMMzpK2MptX81vQq3loXWuiylck9Jg3m/1cXQE0wko8/QQ9Rexl26mvg/aLl5GecaqC9mTZbFGB4e6IKqvs3xwosm17EkPJUzwv1RHCsS4eyxHUXvA5PmLd34SLiTfyBtXYLhnhCSLoUcMzZAB9G5L6vucxt0ZdJwRJ7UMzpTXDO3HMoijEYu+7T+G7AVODySz9wG+q9q79YjI8A6i5E8/vruTjgMa8zqSbYA+whgsgwOIC2dN0TvjvmV1Me1OPbYBXThpxa1kVYPgq1mBLu+9+0u/q2Mo87kV5vZ5jw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=chipsnmedia.com;
Received: from SLXP216MB1148.KORP216.PROD.OUTLOOK.COM (2603:1096:101:f::14) by
 PUVP216MB596218.KORP216.PROD.OUTLOOK.COM (2603:1096:301:173::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 05:29:05 +0000
Received: from SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
 ([fe80::8f6c:834c:6cef:7be]) by SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
 ([fe80::8f6c:834c:6cef:7be%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 05:29:05 +0000
From: "Jackson.lee" <jackson.lee@chipsnmedia.com>
To: mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl,
	nicolas.dufresne@collabora.com,
	bob.beckett@collabora.com
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jackson.lee@chipsnmedia.com,
	lafley.kim@chipsnmedia.com,
	b-brnich@ti.com,
	hverkuil@xs4all.nl,
	nas.chung@chipsnmedia.com,
	stable@vger.kernel.org
Subject: [PATCH v2 4/9] media: chips-media: wave5: ack the interrupt after dispatching it
Date: Mon,  9 Nov 2026 14:28:48 +0900
Message-Id: <20261109052853.110-5-jackson.lee@chipsnmedia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109052853.110-1-jackson.lee@chipsnmedia.com>
References: <20261109052853.110-1-jackson.lee@chipsnmedia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0135.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1::14) To SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:f::14)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SLXP216MB1148:EE_|PUVP216MB596218:EE_
X-MS-Office365-Filtering-Correlation-Id: 56081441-be58-40b4-a096-08df3e225ee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|23010399003|38350700014|10067099003|56012099006|261021123027099003|261021135927099003|261021121427099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xSdUq6iS03su0iuIQWfjkUIABtq0ZMD2ZtwrVw4Lw8x4oKBEzqqU5z5fyxQ3EuovWBzJ61bSrLrV6vl+F7/AujC+IdgZb2SNjna2XKS85eipGYEN2Zh19Vz8s2uq4Jo0DY7DnbICFVvVtofNyiJ60vnP57OR5hqkAs3wUb3aqMfKhA0X0ugTVql4RSLARn2R3vxePh3L9qS1wmJGH8hMG7CbcnOgSiyfKBQ8O2KsDQfi4aRb45JZPr2fSwNB4B3kSNniuzEuGH1qdXNWJ/AJxfJ9zTSZAWUMfjSyBVe7B40brwc5meqt4oDej3MH8ixFYl41Eiu9OfjBZRvVpzcS9RqYTThAU5eg/4QVAw1hKmWAwxYYBzMQfWCYoYrENHTZWjvNbk++CasRGW1isapGDktlfBVpvpxguEV3CfQz32K1XvVqK2O95pIKjH35H7IV9CHSlwAiTYO2xxxFQJ3SnvLeaHKaK+NNRnmvaepZf1s0GA27LR6SIbyQrIa/bzIqqzkJj6WrZbgpGIaHO4Mp14DG5AEXvhf4TEY4qZsWAk04vreDW/CBrZ9h7ZyB2JET+lgwkizhousMiMDO2itbmYwEBvPXysIRbdrh43YCtqoUFyLogBCAl4MMic8cZN4ylte6EOezfrFetS1RcpWYlPd8GaR7wnYSsHIp9LjVVStziLbD0GsWRJYr0o2OrHGcMPgL2r18YgrbbgXmUSiG5kSzNdP5xDkwCjpsuK2FgL4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SLXP216MB1148.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(23010399003)(38350700014)(10067099003)(56012099006)(261021123027099003)(261021135927099003)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UobSerfe05PjUAxELCLOdpQ8gZHaUn8VPALKgvuQuGvoOvHGEhcaflJTfvLC?=
 =?us-ascii?Q?4RwjWWkRZVg6G+NlaJo9XlrQ+hTr0q4TEp4kxOUaZp1dSozVF0YaJYvX6jBf?=
 =?us-ascii?Q?PnzNrSsu3Obd68xeJwqdSGEydz/Ims7JJdwiuA84/uvHIQSG1qTCAPvHuuo8?=
 =?us-ascii?Q?Hkxo8x7hoHHEykvFnfQCBl84Jt8cFp8FNbfa5Fu73W4PvHYanL/G5cXIFnbS?=
 =?us-ascii?Q?yluJzNk5PL0UnsGVOE5qm6J3VyXth/g5bGVrUl4Skpg5k9rallQ16zAPk2Q+?=
 =?us-ascii?Q?zaePGWftT5J1GaV9WkW+qwVDFU+T/N3+sUyTY2bVmDudomgf/yexZFnXYIuf?=
 =?us-ascii?Q?8/lBeoTu5+jGcBnkFVXjjs2iZBmZ2Hii7mXCIYueVDyVhTniamRdWsN+PADa?=
 =?us-ascii?Q?bIvJ5PfLipDakmnMo/GldIOSfFRrn1SXs8LWkRv8musDYXVO4JFvN51TtXeA?=
 =?us-ascii?Q?6P50y7PehJfQSHCH1VGFWAyMa7/mT1c2tYphNTxjIO7czrqGV/MpfPy8zBYx?=
 =?us-ascii?Q?cl+FmhGAI8/+Wm/GYNFPFhc1FRdduYyLVomaeS0TZnsLuaYe+uRA6B0p54w0?=
 =?us-ascii?Q?oMXx6PD6vKwPTDJzTi+6tNWR3oWwjusF+1AP3FK0u8EyGe7rVgTrXnBFjLsJ?=
 =?us-ascii?Q?YDb/e9UcsvZ03EZSrizWO5vh5tLZP+vTfU083h6NjvO8np8pcBldIpyHAbHy?=
 =?us-ascii?Q?SxU9Ot8uj9TKVwh/QboCuquCf7HeHmMXOHvAnWaABEd9KwUe04Fs1X8cOOcE?=
 =?us-ascii?Q?G5Hp0OF1FYoai2tlFzcp1RABO8Sbex4wyfX8ZrL6d6hnT4KD0lQeHqM7N0WX?=
 =?us-ascii?Q?1jDFBnvrsiH0xwcKweT3xLvQsf3WhglKwOz9Mfz0RLoTv0yqgBgMH1b/o2mR?=
 =?us-ascii?Q?nS9vcrR4AWuEOFRYq7r1HtXjBLF4drdDh5O9N5/P9NuoNff1oe1krrnWjRq0?=
 =?us-ascii?Q?5agxW4DqBOmgSU8FPx/AheGLnc6nbAklaeVElgxB5PgJxYfAMuH2C7m3Q1C8?=
 =?us-ascii?Q?ohKkAJBlHBRQq9ANg51wla8fT0CE+BGh2lV1FTuSVkx5yXwjcgx2g2a96MCf?=
 =?us-ascii?Q?am0YYe9WeqGiz361+Ki5Xi2uOZdR7uAnx8A2W8uF+bKAMDG3PvYNrhkpohu5?=
 =?us-ascii?Q?jGjWzwBLWxK36ocZnD6VvX3WOe9cIcFPKcD/h/4ir0yos6rNvm718PSDHBNv?=
 =?us-ascii?Q?aQd+9j6ZRUmVq64mbYmW7joqO2dz8g/ELs0XNH3QdAuLN/Sp9uBOnVbSjCIx?=
 =?us-ascii?Q?GhG5z1//2/pCuldplJfZn1Hw5DcZlPlzXNyVcdV9g+vg+N7lxq6xzTgdCjDI?=
 =?us-ascii?Q?yFOORcQTxoWBcKsOeoc4U3l9M8LJPivKTqzGlThV0DJMo6xrJKhe8c8Gurnl?=
 =?us-ascii?Q?Ey+Q/0Jv/9/QHP+YoY65lzgFQN32Ru0DWnHWs2hsBftt0D+dA6+xs9fPpnrj?=
 =?us-ascii?Q?v84wL3TZuHIdNL1hi2yptnGsyNFbx6oj9LDdh2ZjJ+vNOPtBQMFZj7g4FZBZ?=
 =?us-ascii?Q?e3DyZppTxf+6jBP8Y8DtS8AIwwObw1US2pelXFGenpdU4ELsLgb1cGQfD45R?=
 =?us-ascii?Q?2CCnptMJY7aSYlxGKTiweRCXEjgInaq5eq2ucyRCoUMB4n8VQ2n9oTYQnE0t?=
 =?us-ascii?Q?r191IXfAvv0LvFE+EFGep0J2ySq03vz2GYinUo5tZIJ/2i3kZhB+I7o1JnnD?=
 =?us-ascii?Q?tsmHHYp527j0bINduEQ/fGjP2TicO82aTcEWnovcyOmid+ogzLuBjPD14lbr?=
 =?us-ascii?Q?WVvjkTP2q1BwdB7IcSmPg95C0MtY108=3D?=
X-OriginatorOrg: chipsnmedia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56081441-be58-40b4-a096-08df3e225ee3
X-MS-Exchange-CrossTenant-AuthSource: SLXP216MB1148.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 05:29:05.2680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4d70c8e9-142b-4389-b7f2-fa8a3c68c467
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuYDIyP+ryE7pr+HPDO3EyqAklOxHNu22cHNAyzk9l9+0n7AIRgR8ZsIXNEvHQlLl79jiMTlB1LEebC2tNlkE47MFMkfqlZxq+SW6CQPkYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUVP216MB596218

From: Jackson Lee <jackson.lee@chipsnmedia.com>

W5_RET_QUEUE_CMD_DONE_INST is written by both the driver and the VPU:
the VPU sets the bit of every instance whose command completed, and the
driver clears the bits it has consumed. The driver does that as a
read-modify-write over a snapshot taken at the top of the handler, so
any bit the VPU adds in between is erased.

The firmware does not update that register, for any reason, until the
host acknowledges the interrupt through W5_VPU_VINT_REASON_CLR and
W5_VPU_VINT_CLEAR, so leaving the interrupt unacknowledged for the whole
dispatch is what keeps the register still. Acknowledging first opened
the race instead: the firmware could rewrite the register, and the
write-back then dropped the instance it had just added. That instance is
never reported again -- its queue count stays non-zero and no further
completion arrives, so it stops decoding for good while the others keep
running.

Move both acknowledge writes past the dispatch loop. The re-read of
W5_VPU_VINT_REASON that tried to narrow the window is no longer needed.

Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
Cc: stable@vger.kernel.org
Tested-by: Brandon Brnich <b-brnich@ti.com>
Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
---
 .../platform/chips-media/wave5/wave5-vpu.c    | 29 ++++++++++++-------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
index 76d57c6b636a..6a5b646ff0f9 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-vpu.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
@@ -51,7 +51,6 @@ static void wave5_vpu_handle_irq(void *dev_id)
 	u32 seq_done;
 	u32 cmd_done;
 	u32 irq_reason;
-	u32 irq_subreason;
 	struct vpu_instance *inst, *tmp;
 	struct vpu_device *dev = dev_id;
 	int val;
@@ -60,8 +59,6 @@ static void wave5_vpu_handle_irq(void *dev_id)
 	irq_reason = wave5_vdi_read_register(dev, W5_VPU_VINT_REASON);
 	seq_done = wave5_vdi_read_register(dev, W5_RET_SEQ_DONE_INSTANCE_INFO);
 	cmd_done = wave5_vdi_read_register(dev, W5_RET_QUEUE_CMD_DONE_INST);
-	wave5_vdi_write_register(dev, W5_VPU_VINT_REASON_CLR, irq_reason);
-	wave5_vdi_write_register(dev, W5_VPU_VINT_CLEAR, 0x1);
 
 	spin_lock_irqsave(&dev->irq_spinlock, flags);
 	list_for_each_entry_safe(inst, tmp, &dev->instances, list) {
@@ -86,14 +83,10 @@ static void wave5_vpu_handle_irq(void *dev_id)
 		    irq_reason & BIT(INT_WAVE5_ENC_PIC)) {
 			if (cmd_done & BIT(inst->id)) {
 				cmd_done &= ~BIT(inst->id);
-				if (dev->irq >= 0) {
-					irq_subreason =
-						wave5_vdi_read_register(dev, W5_VPU_VINT_REASON);
-					if (!(irq_subreason & BIT(INT_WAVE5_DEC_PIC)))
-						wave5_vdi_write_register(dev,
-									 W5_RET_QUEUE_CMD_DONE_INST,
-									 cmd_done);
-				}
+				if (dev->irq >= 0)
+					wave5_vdi_write_register(dev,
+								 W5_RET_QUEUE_CMD_DONE_INST,
+								 cmd_done);
 				val = BIT(INT_WAVE5_DEC_PIC);
 				kfifo_in(&inst->irq_status, &val, sizeof(int));
 			}
@@ -101,6 +94,20 @@ static void wave5_vpu_handle_irq(void *dev_id)
 	}
 	spin_unlock_irqrestore(&dev->irq_spinlock, flags);
 
+	/*
+	 * Acknowledge only now that every instance bit this interrupt carried
+	 * has been consumed. W5_RET_QUEUE_CMD_DONE_INST is written by both
+	 * sides, but the firmware does not update it, for any reason, until
+	 * the interrupt is acknowledged through W5_VPU_VINT_REASON_CLR and
+	 * W5_VPU_VINT_CLEAR. Until then the snapshot taken above stays exact
+	 * and the read-modify-write in the loop cannot lose a bit.
+	 * Acknowledging first would let the firmware add an instance bit
+	 * underneath that snapshot, and the write-back would then drop it --
+	 * an instance whose completion is never reported again.
+	 */
+	wave5_vdi_write_register(dev, W5_VPU_VINT_REASON_CLR, irq_reason);
+	wave5_vdi_write_register(dev, W5_VPU_VINT_CLEAR, 0x1);
+
 	if (dev->irq < 0)
 		up(&dev->irq_sem);
 }
-- 
2.43.0

