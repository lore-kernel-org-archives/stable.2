Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795609951;
	b=ZgKwAalhMHq1P/ZvSJBTH25C66v4OKXoYd3oIcGMlK9szVvX5Jap7yLHO8x9Pksv0yeG
	 0nTtrKeS+82sbIfXbAzj2D5zduvjyBIWSw4eYzwgaa+cNbZUQ8rcz2aO7e0Gzi5jYw/WB
	 42uzt5n7wRXg1B1IG9S5hag8QuQuYq0BtPVpnEoEq6TaD3XTZDF8D+i8NekqRBFVGXZLJ
	 EIGedvodD86lmUXOp/c1/3sOZvnYDKcvnp61crVNvPmKIGVhnamGSWgf4DNYluU0L7fhq
	 yKu6eAtNIQeKeK2LTsQanFMwHYnf4Wp338Z38W9+x/DzMaeRcPn54lO4xEIntn2mCww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609951;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
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
	bh=ME98pSrLrTgg0bMYbtaVsPhWG1zei41KLUWYybKStZM=;
	b=lpcwyuujHKVOOLxQ//BSIsE070vhy3EDAEq7OWJYW8+g7P3DRUxLhQBLAXXwWxd+1mCa
	 44oyq46InqN7cbBN/ghQpVRCx+uKIFc2grsuaajozPxYT9ODIC/U+g0L4ey/G/Xfup1pB
	 K2vzJ5YwXD02dkcta1dFdiClVT1WVhSJToGf9M0BSlxW/AzUwSxHVOzye+z0dkUKi/Zvp
	 TpJGH30keP9Nf4ofRlSGTUjqO8koKDdmb3h/abvIoFTtQHYNe87j4nz/wsp9oMBneXEla
	 nf4TnKPmXuvT+rF21Y5WMvanVL2SeAEoyYozB3y/ackVaXlRVQLILtn5W3Mmh3KT4fQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=TeFRChdT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.40
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010040.outbound.protection.outlook.com [52.101.84.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E47A606A33E;
	Wed, 25 Nov 2026 12:32:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E47A606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=TeFRChdT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJdRRgIN+UIMZvF3eg0otSbrmmvZa0Yh1sAidZC2iKjI5H1lyzDt/lNTF+YLzXyF5BPN45frOJKCoh3rOrSStyBEb+odYj2HGABVIxkNwk7bFK58OmeVfsdTXxS8W3EuOYuwME1IekDPgFX5S5J/8WwE0USEgKUonaNlJ8YoaZFm4A8BLMq2e7JJzW0jWY/cH/jjdxfLDRmSt9xwyaW590qolykgCzMM7POuMAoe8rQPWdQQ/1jpeSrg+cYII2UFhBCtrYC8F9Gss/kxAQwgZUTR3VV3ZbMRFSWSL3RHw4FPeFuSGXmwsKs00BX2ESLvws17nuQSkoxsmbHOcoK1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ME98pSrLrTgg0bMYbtaVsPhWG1zei41KLUWYybKStZM=;
 b=Sx43OizKv0PoPfjsLZWcTrW4CczGUrEwGpFUgi6KCMope9ftU5w58ifEsVuzfiqAJ121YfaHUhuC0R2dB8ttj1z3fspQyTgLU5X3h+RPvEEV40vyMiwjC6+f/CDtD9VKAwM+6TGJa/mT+pI3NBlv/yfawy1HthwS/WR1wajr3hiD+vPHPTorhNiSMzPeK7Icrr9bRKrgyXO5mFW8xiOzPVmpgM9gZhGg5nkKromvQvwwtkYZa/W4XwWRjd+S/Ebl0RxkQNw9fmmAwXlwu8uMVvp17oOdUgiEbyKRUkH23Qa8/aq46+Ox+12RSD0YkotV3Gg49c0jPW2pkt4Mo13e4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ME98pSrLrTgg0bMYbtaVsPhWG1zei41KLUWYybKStZM=;
 b=TeFRChdTgQZa99jLnWGFf/0pqYFw5devOIos2B9GP46VnAOPGDU7AaT8kta2x5jprrVkiB0T+YOd9BtL2QktXqpf+b1fxDR5IrWwJ1Wk8UFCSo5BDAUzDUHqIumH6ugpHhcudbCYqA9yc8EMn8bEH9f7bm+CZEMKZ882q/wlPOSanIF9t0OaF5+doEZ37mmGUxme66xdHZYGRIVQvnuSl6qHNrE4d7ncBFoFupjBmR7YtwbY6OzYYJ7EdqoSa5dNWSFSTrwyNJbM8Nc8F10EKbkQqjD5DdFf9laZCeDv2qv91FKL0Esf2pe8VrbFidw36LqmHTV3g/sve3RhNGw4Ow==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4472.eurprd04.prod.outlook.com (2603:10a6:20b:23::20)
 by DB9PR04MB8347.eurprd04.prod.outlook.com (2603:10a6:10:245::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Wed, 25 Nov
 2026 12:32:28 +0000
Received: from AM6PR04MB4472.eurprd04.prod.outlook.com
 ([fe80::aed9:e8b9:c352:9ba0]) by AM6PR04MB4472.eurprd04.prod.outlook.com
 ([fe80::aed9:e8b9:c352:9ba0%6]) with mapi id 15.21.0639.010; Wed, 25 Nov 2026
 12:32:28 +0000
From: Stefan Ghetu <stefan.ghetu@nxp.com>
To: Srinivas Kandagatla <srini@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	kernel@pengutronix.de,
	Fabio Estevam <festevam@gmail.com>,
	Peng Fan <peng.fan@nxp.com>,
	Christian Eggers <ceggers@arri.de>,
	stable@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Ghetu <stefan.ghetu@nxp.com>
Subject: [PATCH v2] nvmem: imx-ocotp-scu: assign nvmem_cell_info::raw_len
Date: Wed, 25 Nov 2026 14:32:22 +0200
Message-ID: <20261125123222.839732-1-stefan.ghetu@nxp.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125072736.769516-1-stefan.ghetu@nxp.com>
References: <20261125072736.769516-1-stefan.ghetu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0008.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::14) To AM6PR04MB4472.eurprd04.prod.outlook.com
 (2603:10a6:20b:23::20)
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
X-MS-TrafficTypeDiagnostic: AM6PR04MB4472:EE_|DB9PR04MB8347:EE_
X-MS-Office365-Filtering-Correlation-Id: 414314b0-1139-4f2c-b1ef-08df4af02ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|23010399003|261009223027099003|22082099003|18002099003|261022075727099003|261026121527099003|261102123227099003|261021121427099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	N1Q9uPKgSNeeF+S+s+zhNIkyR0HCUXrV2aTsNqKRvpu35flrQ0BwV9RbSycDRbizZiyEHFvHta7t4Lvyn85mLw1TgsnF28i9oIPru2OYstVTna+bl1Fi+iySbqHjlB7aq6Kjtzv3+YGGudzZ1Ye+wyJWThmndz8WqzFYYkEtEjUDCXO98D6RPH9KEbmmATF+Ddfz2IR3QI7B0CZ1itukBQsVfb9t0MOB6dT5WXDUf3rHD9NS9TxYoSc3FneEtt71kslYP/zkh6OiSXLxyGrA8lgkoVX9wd8hXtrad128KTSVQT0FHxnnzgNLStZ/l/Ct/LXfcmSDXX+8vb8nxDBeZSLSn6h9ESpt/iTvnh7aNohNO/Nx+AbSV5/scg7WbfaME5CxAaj+2lTcuOzQcx2C04s2rw/tFU8bq19Wl6WfQqRFdOeupPhF83eonME5q0VuMNkRfdiMgCKcWeb2umA2Ukf8GWBhiPv7dq7WaOh4tMq9FiUsJeEwOjBu7SjT4TaIJZl+nNfrjAmz92PrZRFfJI8gZm2LPN1cXil4oFF70KjcrXoDaT+0kXlK562FNOehP6rHn2t30kXuw5Z4Fps5xy/qFDOsNiAdlEOsConO7V3D26AQMnvk73dYy422uch8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4472.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(23010399003)(261009223027099003)(22082099003)(18002099003)(261022075727099003)(261026121527099003)(261102123227099003)(261021121427099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MaO4vQ+SvrgMGW0BCV+3qVlyHJU7A3YDvpjQ7VeAhkcqjjo2OJ6bNWL5Rian?=
 =?us-ascii?Q?kTaivGPl5NUWM/9HsutQIAE4suxqx7xmIPnmMiqnkEmQtTLRm9FXBhaC1OOb?=
 =?us-ascii?Q?+qftUo088QruuVt29pGLvMn9HKW3ydNOllNPquD9Ig3j5vnitPZ4oRGfrzik?=
 =?us-ascii?Q?1aYESQlUP0SENQJR3F/oM/ZzmLgSqp0d3nmV7LyL/whykOdYw0hkQv02EF1Y?=
 =?us-ascii?Q?uXfcCm+g/krB8MkzwlMM2NTqDU8xCZ/kKhULCfF5lszvpSRQBLwEQkvneKW6?=
 =?us-ascii?Q?36Qu6r7nQe6X/6zq5fPvfRBsyiREEUPBBCjTYjkFXFleue6qdtcTjp/knYXY?=
 =?us-ascii?Q?MA/75z78LU8cOodLsAp0Gh0ZUWGgIdgGz7Jw4MpseR2WmpaocaBM8Pclh7VX?=
 =?us-ascii?Q?GnDNu7opTvFWpqzUEqxzlG3CSWgMEviAGJHynu7BWG10yrmCFSDRs2sJke9n?=
 =?us-ascii?Q?WtjGXrbcc9RPl4R3VqSpNfRGLaVDmqoz8Kxu5JpECyQOCmUMkDefH+V2LV4c?=
 =?us-ascii?Q?LHD+guw7stMmTrwMYBtkBpnRmCXVp1UZJlEpuWWHvjygj/jmLhdDyBVLHlNK?=
 =?us-ascii?Q?5ZO4jdEe/x1yzA1GvYiklvMwD6mwlJ+aUXsM7dNds4/IQi2G9GmWp7SHbQLB?=
 =?us-ascii?Q?sPG8OD8BrkidH8fM1bQpos6rZ1DSaJNpdG//rP48i09A0YRNXCcujtwFj0IX?=
 =?us-ascii?Q?zG+ubL9p3RBIuq0HJB0Fsc2VUuLSVi0022NZZeWZi1LszRCra7bdivjhAiXi?=
 =?us-ascii?Q?I76We4qRfSbcvVjm6npxCJsk/FVWo1APXGlfj6+TCxtZ6E5wU867ccSlhXoU?=
 =?us-ascii?Q?FDnPUJ6MopUioaNZ9gnmJ1aLXS3qXDer8l2zTS9z1a8hwcCQu4TB8afgLWeb?=
 =?us-ascii?Q?3IadE3Lduxf/ZhkYC3KAo6b987vmMx/gm93LzcJ3xRTIs/9Ld1srXVNe9s9t?=
 =?us-ascii?Q?+M2qpP+4MxIWfw3/vxlTlCwSiPnBgOgW9VE//XnChP10DBygoS9577PR9jNg?=
 =?us-ascii?Q?hlHHAvUe9JABUKLlR0BwDF2gxryEKiwFF8awRENj6inV0LlRfljFqcXaPY4g?=
 =?us-ascii?Q?u7bn9OhRztMUQ+aQyEyASS4BDMYrUTkXwe0wVwj6m2qWTPjA1SxML22hWdID?=
 =?us-ascii?Q?C0fdMIAPsCSDPU3Z+cvxJv5ppyd1SuF7qVaKI5KiZ5uajpfhmyvGS45bKcTU?=
 =?us-ascii?Q?f1NhGyoK4ssZyGWk+LwnauiY6Z+wi7TaCRvU84ExwnRTgHEcaUx2cbm9z402?=
 =?us-ascii?Q?HLYVR05XSUpPhPe3z3zi7h0n9aAaZMwuwq9FlfneVXB5j4NozVUWvlswavMC?=
 =?us-ascii?Q?FoTtgG6UF4hLfzhkVZkLVvzQLwhOvst8W5fK1W5yC3/3CsCXinPAbSKAOjzg?=
 =?us-ascii?Q?5S8vduc87xSgE2LkXlBDfpEEymfunU7NY6suoNvgvYSo7E8v+8yTsEpZ3Utg?=
 =?us-ascii?Q?viMao1C5ha8C+Up/YyY1ayre+jYQ9SMuoqg7T9UGG4q+CCpLcvB+qDXG8UOl?=
 =?us-ascii?Q?Kj0UAp3L/6ZktCL1dOUKLCibUi9sh1zsikb6Y78YM82S2kxzP5qyWPWzWXns?=
 =?us-ascii?Q?yb7mUn/LS5UZJv0dwGQKkVZzue9vwZCViUy5elpedTlDhZQJGYD5bHfFqpiC?=
 =?us-ascii?Q?WcREc4xnMEEnas9ElyVV0OPukrKs/NPITYLz0XgBVJFml33/5jzCNnQMsZVb?=
 =?us-ascii?Q?JiRm/KmNR7DnH/hL9AvxcvdelR5VIgd1srrYrcpGgMPcwPZQxFr6sPke+CXv?=
 =?us-ascii?Q?4xrcIxgABQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 414314b0-1139-4f2c-b1ef-08df4af02ac5
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4472.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 12:32:28.1723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kskWgaoHG5qTxuFb8EcdNuwZy4xumD6ORtfriJ9CaYgyCsYbHJky0sG4Xs/LXRjmQmoliM9aioK8FsNYnWBDXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8347

Avoid getting error messages at startup like the following on i.MX8QXP,
i.MX8QM and i.MX8DXL, printed once for each MAC address cell:

nvmem imx-scu-ocotp0: cell mac raw len 6 unaligned to nvmem word size 4

The same was already done for imx-ocotp and imx-ocotp-ele by commit
48b5163c9575 ("nvmem: imx: assign nvmem_cell_info::raw_len"), but the
SCU based driver was not covered.

This shouldn't cause any functional change as this alignment would
otherwise be done in nvmem_cell_info_to_nvmem_cell_entry_nodup().

Fixes: 13bcd440f2ff ("nvmem: core: verify cell's raw_len")
Cc: stable@vger.kernel.org
Signed-off-by: Stefan Ghetu <stefan.ghetu@nxp.com>
---
Changes in v2:
- Add Cc: stable@vger.kernel.org, as requested by Srinivas Kandagatla.

v1: https://lore.kernel.org/all/20261125072736.769516-1-stefan.ghetu@nxp.com/

 drivers/nvmem/imx-ocotp-scu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvmem/imx-ocotp-scu.c b/drivers/nvmem/imx-ocotp-scu.c
index 20312fba22d23..80f78bcf3841e 100644
--- a/drivers/nvmem/imx-ocotp-scu.c
+++ b/drivers/nvmem/imx-ocotp-scu.c
@@ -218,6 +218,12 @@ static int imx_scu_ocotp_write(void *context, unsigned int offset,
 	return res.a0;
 }
 
+static void imx_scu_ocotp_fixup_dt_cell_info(struct nvmem_device *nvmem,
+					     struct nvmem_cell_info *cell)
+{
+	cell->raw_len = round_up(cell->bytes, 4);
+}
+
 static struct nvmem_config imx_scu_ocotp_nvmem_config = {
 	.name = "imx-scu-ocotp",
 	.add_legacy_fixed_of_cells = true,
@@ -227,6 +233,7 @@ static struct nvmem_config imx_scu_ocotp_nvmem_config = {
 	.owner = THIS_MODULE,
 	.reg_read = imx_scu_ocotp_read,
 	.reg_write = imx_scu_ocotp_write,
+	.fixup_dt_cell_info = imx_scu_ocotp_fixup_dt_cell_info,
 };
 
 static const struct of_device_id imx_scu_ocotp_dt_ids[] = {
-- 
2.43.0

