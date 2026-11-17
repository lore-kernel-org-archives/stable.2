Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794944329;
	b=Izt+b+pftciVdXB8A1px1LedsLnqJlLx1YIoyQ9faQzD31erCybCXBzsI/02He2neBE1
	 BE2HeJcQrtaYEGTBfCkPszsBQGTzq2d1IrAvRtE9KND+LEVDTBvMWcf46vKXsj9Woxvnr
	 +i7+52VXD9b1HF809TBjz0FxwNc61N6hOh+FGgXLxz+Bb07Rt+9m8HisE26GoTOMUc9pe
	 ky9tsWdrDGS6Wll+2ep0xBq4H8vVJ1soEGo0D19mWA6ILAbtaRNYzbnJs+pAbU976VbFi
	 r/XkAdE/1EM9330n1DRWLr8bHP8yMVuCSzsrdqRhWOpw6YqpT9a9BG9/vBXiH0UUO1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794944329;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=XUHGCjUuuWAd31zJ0SXd2PKRfMGyoMnH/QJzCJPkpQo=;
	b=3Rh6QSLfvhkzSXXXp5yw8rPwxHGPNaWaBM2WB2sNFysejpWuGqLFw+ZjGc4HwGRyUvKD
	 di5FRZz7gLy79sdUWQCRUl+rnV9ps7rcxUpXMuqcpxieN14REcuDkALR61RKueCZPmrAp
	 Uz1mKQIxgVWph01Ui7T4sRKEvr0YY8ZcASEykWPk4Wacpev6DgvwAgbo2QKn2XtHxAqV4
	 bMdOJdsVyoCpfz3/FLjNof5UIhzngKC6uNGUBNJ6Es5Yd/fMp2sWUVT0GDHj7p9/ka2bA
	 dFF151npA/07XxTtEJnwWvhxM6L0ak4hWu62MmL85w+MZbexv3HftAxMk+Er3O/COgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ph8amRDB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.49
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010049.outbound.protection.outlook.com [52.101.69.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669BA606A888;
	Tue, 17 Nov 2026 19:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 669BA606A888
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ph8amRDB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M1KzzwImzQyapcD7v8szETnWNfW2XiOzstF0UqQImi5bKZicziDcs+Pbz58c0N95NjAAuf8DEh9ucIB/FUCV5OSWwW4WwtsyWohKwu8HuVYQXR8AQmWDtQsuXCDV+Tamx6rG2IeZrPnhmpyiExysqqmN5OwmCuAVxFABc9Yq2WskO02WePPdMzVQKbTvpL1dIickcZ434cb9T1mbXzDIvwm8RrLkRNGOgomTQxC7QBcks3Dr00ZX/bshVQ4nYsh+ncFdB+sPiqMwByAXrvrxmICUjVh/SqMCVCKySTPn+3Rz0yOZmUuwrEiKTzAAho4VQw8VzmcwDiDDIq4xBy898g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUHGCjUuuWAd31zJ0SXd2PKRfMGyoMnH/QJzCJPkpQo=;
 b=m5DSbJMYYo3VSE8BUnCljg6yn7jE8WbylMqzdRjTvaL0fvfy+HyTfi0H63Lr79kubYuKQ+pf+zhQffayuFpTiDRodKkmSUwRLKNO0uc/VOcWrr+jZnpznueWIir0Hbl5/hkDTX9rWm4zVGMJ+INfuN0+z5couPQS8jVMkHCtwnitxGDo718fye7LgJGsiU9oZ9fniqCOllFgfW8kgYUM8uAcOI5uNQVwmRhd4gndGQAxUz2YaJ+dqD9VcbofQ9LKwlXy68S7oluTp+nCAoOWjPSw0yGG78/lQuR8QO8NtFK81qjD9xYcVi2ua8QdjBz3r7Z/e1v+fepWiekV5D7kag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUHGCjUuuWAd31zJ0SXd2PKRfMGyoMnH/QJzCJPkpQo=;
 b=ph8amRDBhbBwpaBaXyZO0D8aKWtXEvRpBUXKwiK9ox0oAu6nt94Vf6v9YwDRgr8DnR3l5y/v3yaFGdLopxNtsrrkGjETJVdhldQAAkkfUgtJpny+87CHm90sF4+qVoEPFe+xDX3X8cTNnEOIp/9MaM9fZVzCgLDMuHLAr/8aLnv3F26ac/ALz1bk+XKDJvakgTHN2xxdQGUNmhqSnYlu03MINRcDzTfWGQ8jnp8FFjk2cUGLbW27Gkyg0+2d0AQpXFYv0kotfgyVFCKdICh2rMcwS0XpxpU7oQ+Gs8iF6IzwEBOBjxA3VeMF7x4fcFEjBNmfxMK6FZ7bUbet8bNapA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PAXPR04MB8989.eurprd04.prod.outlook.com (2603:10a6:102:20c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Tue, 17 Nov
 2026 19:38:45 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 19:38:45 +0000
Date: Tue, 17 Nov 2026 14:38:37 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Lee Jones <lee@kernel.org>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Raju Rangoju <Raju.Rangoju@amd.com>,
	Philipp Stanner <pstanner@redhat.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 02/11] dmaengine: ae4dma: Let the pending work exit
 before cancelling it
Message-ID: <avytPWyL3aH-cJhZ@lizhi-Precision-Tower-5810>
References: <20261117163809.622249-1-lee@kernel.org>
 <20261117163809.622249-3-lee@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117163809.622249-3-lee@kernel.org>
X-ClientProxiedBy: PH8PR07CA0022.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::21) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PAXPR04MB8989:EE_
X-MS-Office365-Filtering-Correlation-Id: fee63405-9cd4-4004-1f64-08df44e264c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|23010399003|376014|366016|10067099003|18002099003|22082099003|261026121527099003|261028144727099003|261009221227099003|4143699003|261021123027099003|261022105027099003|261009223327099003|261021121427099003|56012099006|261009220027099003|261009223027099003|261102123227099003|261009221727099003|261026140227099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	2kbBw/kOxQGCagcOaBqfyW+yg8xNpM8vrpuZWUX2y7cN5E45W+DEST0AIP0Q01c79v29lknUaS8Shm7IzPwyoaRRCeLbR3if3gTwFdnup1di//UO1blgZmdiRNbgHJ07kZOAg6jdndh4IQNCMVKzMC4MoB8ZJwolWxPk3iqX8c7OmIMl7QNeQJ2fKu+y57+yBtEVG6P8eLIWOP6LVGRImDHmFBheV4FCFUJNhjeztgGZzPAJwBbwmpofSyDzIHlV2mdxrBysNOI9lfBwIRgmwEWOg1IlJXLTLO6NUvHqr/NC5C4kvG9FieumLSK5pcPObQYOE2zRktHHWEsfsw5muT0lVyute9rwoUFRm322NkkwLE/NfVGu7UXPDmiOAGnM+AAg2YUyFhB37XUyv3sCB3K9xkwh23gCIDgV5lQViFmx4SFtdNd1g42x0m27VzNaHi7VTcWleYS+jXBvNFxvyVMdC4yTzYLb3HsOu/WdUyHze9pBSUBwcw19VGCVem9BDlPVwzStlpIyfiq37SYDAfhHPTCX+ojZvy1Ga0DdHnk3wqsL/Hx4QX78DsI2oB4TsA1KZm+dXATiH27LreswWwRqG+OXTLqFRQrCebECUWwopBwlBFwM49g37JD2Cp5MtsUmsKQSrVobFSHLGyjXSUq4te+Limk2iFvUatq6yg4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(23010399003)(376014)(366016)(10067099003)(18002099003)(22082099003)(261026121527099003)(261028144727099003)(261009221227099003)(4143699003)(261021123027099003)(261022105027099003)(261009223327099003)(261021121427099003)(56012099006)(261009220027099003)(261009223027099003)(261102123227099003)(261009221727099003)(261026140227099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aJ2Tyw/dwtLBciJReqsuthhm5S7m0JLNo62/edtTBTnmPP81uqERH+uMmvea?=
 =?us-ascii?Q?US/7d6VjeQFmYvdF+WTdxp2NieoR8CHekAXtLgcGGqIVFxfUCRYiGQRc9/Lu?=
 =?us-ascii?Q?mwg+4JbahoRwpiLvsunmslWvpJug+1MEiiirz10jpINHTU04EsrOXLdbMs1A?=
 =?us-ascii?Q?UA/489w4/7gZj1pplzXsykb+uA+ZiLkpYojO+Kzgy10BMl9CBGto9ljYVryP?=
 =?us-ascii?Q?lzzSDQmo/cMR8EddWr07JFfQ0HYLXi1zDds0qBwIuk7tpkqI2VEPSDCkyyNJ?=
 =?us-ascii?Q?oZh6X8N67X/P9MY1pPKVRnL+xpBnX/oLO9CwmD7q0W+jPVdburfueVtJLKLi?=
 =?us-ascii?Q?vnuu8KRdfBmTHhUj9rUo3B9reJsb4uxZNmQi7Rh9660hMOIMqOoIqtRrKO87?=
 =?us-ascii?Q?1J0koQbi7OuC9UFLYPXO00xESrLxD5w8WPDD2RK8VNH3CPSFEsNyOjWUTbgt?=
 =?us-ascii?Q?Ax9l2twxTV8rMaGlGfbKoCXqozt8XZz1ztG5DhBUrstj6M7gfVqGSAAgL8Zp?=
 =?us-ascii?Q?e5U7wMql7mANOYl4vMg2c+n9OdQiGtzb6LcGYkKwJ81FMRxYa8A5pUDlRnxz?=
 =?us-ascii?Q?B6Spk9KMvZ6tMLOW9Qn3u/9n1uZRxynKAo4eh05w7SCKv1EW5T/R4Xdnv2af?=
 =?us-ascii?Q?ncYYzclzhPcUw6AEcucp0+pjoYqRBjij2sSk6zQIZ2x39j7fk0/MOjPaOC3q?=
 =?us-ascii?Q?wpEs+hiOdn4KlCqsosbAFRtcKbjQ6tjRaZJ8SkPTHbdAzhJd8biy5pod1ON1?=
 =?us-ascii?Q?aR2RQHQEq8PkXTwro6ljM9KXIrscJD/i28WtDyafKOnmpoJ6Q0iYemI6JVAb?=
 =?us-ascii?Q?oafokfyDS6HLLPKLiqAt/0D+++MaBlP5NsglKUON/vF47cK5+wtPHb6Orx7P?=
 =?us-ascii?Q?m7xcFskSwXSKvFSgGgHxEfnRma4R20JSZELFldZr6/TIJ5WkbBEZ6HwmmHbE?=
 =?us-ascii?Q?E+6YqNT05zATQJ3ddd7DpjaWBxL6vp5PkKiKN2GWFiqU5WLym06iz0veMmFF?=
 =?us-ascii?Q?lokRRdXlx545F2dIWI21hgILkeYUQsJ76Hggno1BsVjkLpOElX6hXxxuCvfW?=
 =?us-ascii?Q?bmTGNNJGuZgki1Ija9Qs3xRI0g6tgIEN9RYy1pbdGLMG298olUwUZNywxnps?=
 =?us-ascii?Q?dBbn+H6mQ9qyFzu2DvL5s8aCWT8NFxf2tni/z0JLxrFeAM8goj0Dg0UngZIw?=
 =?us-ascii?Q?pxKbXgnH6fRiHxZcnB72QIF8f2nwquxYaMaCeGjd3MoeukhMq3NbH92m18rb?=
 =?us-ascii?Q?wWrLWSZKK5yLFsGqR4UM8hQcDu9GQC8dklEe9aOTDG//48jh25pkDIWoPSU+?=
 =?us-ascii?Q?GhoffayeRlOvC4yRn5rxpNSO4hmc31oRe417OFX9p0pD7w+5fjm0PONDBd9R?=
 =?us-ascii?Q?iWWeLKfWedOEa63m827n3XBlzb6GI4hY0Ea81hOqw0/fK3hcyH7PYBrN4yac?=
 =?us-ascii?Q?/iSRQxuWsZJsb15sIm+u1pbnFUmqj/H0vLuV6HAJN/jujQSzRiWf9KRkdll7?=
 =?us-ascii?Q?3lB5OiRcsl4AbYnkxSC50mPs2UEiNsC37q7IWkusVrrw3sG1j0tB4obeJCdK?=
 =?us-ascii?Q?Iod8Rlp4uwoRyDptpJ3fSvMm8JwLceR9uIcNHXZfmIMqxYtcBEZBBLkGLlP5?=
 =?us-ascii?Q?tCMYhS3d1+9+749+Qx5rccLzQHHX7MG9VmztZn2FIQeTvSf4rkC2bFsoU5V5?=
 =?us-ascii?Q?VUuypr4Rdshz/KHMIjVLAMMbNwcE5YR9koQiSVh5jDDRhLs2StcAyYPsgU9d?=
 =?us-ascii?Q?hAUWLSxf79wh0EcFFUVhn3BrX1Rz7kCX3nKAgrrPx8VZ+QdK/40b?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee63405-9cd4-4004-1f64-08df44e264c7
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:38:45.4558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bje7KdNxVBAYJmglrgoz8PGdezvJLjiK9Gjo2nIZRuVzB3AiSxO3hqGJ5bHO/lmnZ/ul2vL+sGtiYznz4Gyk+pZd04OGysh79pT5vgdvjiFfL6hLdUi1fbqctYBuk2oW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8989

On Tue, Nov 17, 2026 at 04:37:03PM +0000, Lee Jones wrote:
> ae4_pending_work() loops forever waiting for interrupts, so it never
> returns once it has started running, which it does 100us after probe.
> ae4_destroy_work() calls cancel_delayed_work_sync() on it, which waits
> for the running work to finish and therefore blocks indefinitely,
> hanging device removal and, once the work has started, the probe error
> path in ae4_core_init().
>
> Add a per-queue stop flag that ae4_destroy_work() sets, then wake the
> queue's wait queue so that the work leaves its loop before it is
> cancelled and its workqueue destroyed.
>
> Fixes: 90a30e268d9b ("dmaengine: ae4dma: Add AMD ae4dma controller driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> v1 => v2: New patch, so that ae4_destroy_work() can no longer hang
>
>  drivers/dma/amd/ae4dma/ae4dma-dev.c | 8 ++++++++
>  drivers/dma/amd/ae4dma/ae4dma.h     | 1 +
>  2 files changed, 9 insertions(+)
>
> diff --git a/drivers/dma/amd/ae4dma/ae4dma-dev.c b/drivers/dma/amd/ae4dma/ae4dma-dev.c
> index 8de3bef41b58..be86188da16c 100644
> --- a/drivers/dma/amd/ae4dma/ae4dma-dev.c
> +++ b/drivers/dma/amd/ae4dma/ae4dma-dev.c
> @@ -23,9 +23,13 @@ static void ae4_pending_work(struct work_struct *work)
>
>  	for (;;) {
>  		wait_event_interruptible(ae4cmd_q->q_w,
> +					 READ_ONCE(ae4cmd_q->stop) ||
>  					 ((atomic64_read(&ae4cmd_q->done_cnt)) <
>  					   atomic64_read(&ae4cmd_q->intr_cnt)));
>
> +		if (READ_ONCE(ae4cmd_q->stop))
> +			break;
> +
>  		atomic64_inc(&ae4cmd_q->done_cnt);
>
>  		mutex_lock(&ae4cmd_q->cmd_lock);
> @@ -81,6 +85,10 @@ void ae4_destroy_work(struct ae4_device *ae4)
>  		if (!ae4cmd_q->pws)
>  			break;
>
> +		/* Make ae4_pending_work() leave its loop so that it can be cancelled */
> +		WRITE_ONCE(ae4cmd_q->stop, true);
> +		wake_up(&ae4cmd_q->q_w);
> +
>  		cancel_delayed_work_sync(&ae4cmd_q->p_work);
>  		destroy_workqueue(ae4cmd_q->pws);
>  	}
> diff --git a/drivers/dma/amd/ae4dma/ae4dma.h b/drivers/dma/amd/ae4dma/ae4dma.h
> index 57f6048726bb..affb1d7d9d7d 100644
> --- a/drivers/dma/amd/ae4dma/ae4dma.h
> +++ b/drivers/dma/amd/ae4dma/ae4dma.h
> @@ -60,6 +60,7 @@ struct ae4_cmd_queue {
>  	u32 dridx;
>  	u32 tail_wi;
>  	u32 id;
> +	bool stop;
>  };
>
>  union dwou {
> --
> 2.56.0.679.gc527c65306-goog
>
