Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013052.outbound.protection.outlook.com [52.101.83.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B298B3A5E78;
	Thu, 13 Aug 2026 21:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786655169; cv=fail; b=BYhai2cZOY0JZY30Ary52+9l6jz0677jcZZguCZZ//SU/4Rqk7rY9YFIJFjDd1f/jv2jyPH61CjuEz0vzMnKrhYus7ZSuUYgwtzZAmuog7xQ5iDHj21z1lrBpJkfptJQgATVXUbmd4usGjN56EBIb23yUE2ufF3/Hf8tL4XjEgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786655169; c=relaxed/simple;
	bh=uScXjF8zRdTIiQGCJrKhHgtkGutAPTkupsg2LJ2fNPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HtNj8GvtWLoLSjnGN1Vm7dxjNXCg2y3tEaKoJkrcUgBs2C3EeSfdhSDs+9PDI5QEbWpn5C+LPv4UPARmc4ML5e45UPgdvzYT4J2vczEgnzJhFAYPkyNqYf76/1nqTust1AIEOWNwd0tFEASN2vcSBO2J02vN6MD3l5zrLosgFq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=oyVED8BE; arc=fail smtp.client-ip=52.101.83.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oyVED8BE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCNAKQOAXtqDVT6q9V1i8NvvP1an++fvxpPfULGQkNywiQApkcW409xsIqVg2A/yS/FKCBxEGoKToOBdBjD8WF/Ta/ijeeEDIngITbml81asr0fosXCmMZTUnS80Kw0mDTL9f1rG7PQvTzTCzriorc8RExAfXilwpAU0GTGCUVBMMpfkK/oxqo/+0AO7zkhZMcI88vYmTUO9JZIkzX3kMAyRd0BoAzpNTlE+aEUOI9T/YyMzxT1QiTP+chWoZ++CbVZV/YOcpRkZIl3vrUeVvxwmWECFIsg53vR2heZGDSKOQbaJzttOJxBZZWrLLLG8KfJfh2biywxjFTQfNlWB3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mnza5oqEJ3P7cnptGFgBYUH3Qh7+6XheJJuA69BukDY=;
 b=c8IBtZZIpgSE37j411o55e7lyBAm9RcKM+R6+08j32PRJPtazDNEbIXBoEVG3TjoX6Fy2xKMmfPtGZYZaSyHDz5jhbPmS5YnmKRB8FwKBP8UtDF7d1g1vuGzTwWrYNPpDVeXvZhNefn53M0xOvXydubrEWNLrO5jFt/27skQ7bMbImXrN+SV6kvISzb64iTwZm4MFygO6Qxjy2bmELbjfqsce0IUG4qm42RVD6WDGZdUKz1jz/m93CkfolcC7p/fo+hsyufZu2UhXZaGPzw9+MYDrZqy4wgz+2P5qLyaEG0nefjhRDEKMRC1d3t2qj4Xc9sfcF7dLTbm9pv7HF/GWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mnza5oqEJ3P7cnptGFgBYUH3Qh7+6XheJJuA69BukDY=;
 b=oyVED8BEnob5zBDQAtN8bDI8vUTg+2OIE24VUDJB4j7kLwC7UNe+nu7MtO5V8nfEaKjih1eCUmVXnf02n7l/WPfh7CrD0wuOUcmITZxjkKx+7a6W8X89CVZr37tFoA7r4s2FW48jkiaTOAi9SIxf9Dkfr2dkghE+1Gw2CHzdZOtlul9pFvNYg24oV3UmRiYJUsEKupJ1uUw9kYQFmS4b1cX07KK85x2k0Lgs2CzvXydwwgUrOdDCPJOtTftTdigCgQSsNr7wO0KBiRCQz9PIa1L8HDUiJJy/sZsYtb1bMSz6rPP6jTQHmrYxxRleWBuPiTXzCjoMHcmcQAFW+iRCrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AMBPR04MB707085.eurprd04.prod.outlook.com (2603:10a6:20b:7d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 21:06:03 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 21:06:02 +0000
Date: Thu, 13 Aug 2026 17:05:54 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Jason Yang <jason98166@gmail.com>
Cc: Steve Longerbeam <slongerbeam@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v5] media: ov5640: select the MIPI lane mode from the
 endpoint lane count
Message-ID: <an4xspA58wlyxZd3@lizhi-Precision-Tower-5810>
References: <20260811-ov5640-1lane-v1-v5-1-14849a3d3a71@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811-ov5640-1lane-v1-v5-1-14849a3d3a71@gmail.com>
X-ClientProxiedBy: PH8PR20CA0012.namprd20.prod.outlook.com
 (2603:10b6:510:23c::10) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AMBPR04MB707085:EE_
X-MS-Office365-Filtering-Correlation-Id: 281bedc9-562a-498b-23cc-08def97eaeb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|19092799006|18002099003|22082099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	zSsJgjLinnftVyjwMPhsTl5Vykrd8MUm4pWdRlAFw4XjY5vvPoXT1qB9dmAdLBJasjir7hRv8JMiEnmLjbnAI2sXIJjWRowuhUjomSVoIhx2lHVc/QpKEts/7YspY67EwwyhU8y27ooyodijQLEdIHZjZPjVnO1X7B9DMD2AT9iGGx2WaBkzRp5Hh4X9C0b5LJhAuMIPTLKV1UBJEqbgRUslgwbMvvlUyHLMTxpx6a9ZUAw/eoxl2p6jg0fIe4UiPePtBTEpbBQSY/zxfiu06n6DeYHJ5c5dMa/LNoQU+b7WZ2KR87MQpeJfgD4iYoTrKo6TwE/kebEKBtuagmo27dgqqUtmY7Ek5eOn5MXDIlmYHCyEEOwWBE9rdZ2muaFFDSdnSiq2ch8OQgL34Pd/EfM6pPBrvWCYxBLlXp7RjwtKOq8AeM2svuGuh30ef3ULgu7O4d9uwE+X2Ycrfntq4wjk8dDR1Nb6Kk0tIqe9TakUEGgzXYONHzrqRdKEmJUNdZVEokJiWkaq+ZDE1t3tODSfBNHELy5Za2Yg7hWixcvydpUfw0REe7mp62m2ZJ5+Q/HQZCvfgQ6CbMDrzHkPpbrLGOblaUzNNw+oIvu0Sp25KEU0ABYlbwYT9li2izIpDvaJGkxaDsQF+Q/v5aqF7iItQcmSc/az3O6fAsdO0Zs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(19092799006)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jYZKEOxxJN4Mb3W9RFspz4QAsYn5+Dk3s9HxRxSKL4QAHi65n7ogNWCHvZUI?=
 =?us-ascii?Q?II8jBFH2O4eTKfJg4eB9UI5yZ9DmTHyiJPKu802g/4sqLZVDG0l4HZE22u/1?=
 =?us-ascii?Q?Wly9wDQesS6YRbkY50LOpUE4gieBbW4xgTIWeIRZnOOSxNfCAIshD6/Z4/MM?=
 =?us-ascii?Q?egSKp+KIiXpP3fis5SNxFJ54xJvKuyBHRxDZRyhHnACrbAW8qOJz6AQ9Vv5A?=
 =?us-ascii?Q?RXAV8QzoYmNR+8bFXs3k0shfXArUMxw9nYTSkpbqCpzSJkSvIdK4d5TX9CFl?=
 =?us-ascii?Q?xImyvq4xZ+5SseaAIrgJpcEmMqUZatqf/hc+ajgl2Q6UhHXvhL4elu6Iz2SB?=
 =?us-ascii?Q?ZSmurRRqzugCOxHYEQ+0xEa4TzV4p6CQH9sLMWihw656lhELZOkkcRnPOfa8?=
 =?us-ascii?Q?hjt9rQT/vbED6dgQ5DE3tX1/g/ovjhScSW9xTnzNzQ0VJpgBKa83t420lXsV?=
 =?us-ascii?Q?6FvqKEFaEeGcQap1OOQ3MCE5axlf43+eAFIW0+Zk0YJo+IZ7tOYCUVFQf9/M?=
 =?us-ascii?Q?QCvajEssCUvjYCcZu+5oQ/fxfqT98/HI4dWzinNiJ5ysI4K53XDS+8RQvLGV?=
 =?us-ascii?Q?ZDxS7gVF4EOn/WFU4tvPVdFBFOs4jokGC1STxcxH+eItLJNS1mIN6K5KbGyZ?=
 =?us-ascii?Q?9rpyzMWRl9cSoCS5SlAzZPe5g4hxpgCEkcjvQd7YGR31kMGS+ua7M7HU3+uY?=
 =?us-ascii?Q?1pHJ7fV6T6dO24/b/j728bu21kJZQdPxk0WQbzXowZOhufO7/0M4dxKiN5eZ?=
 =?us-ascii?Q?uvAQiC+FFS+YzMg2hyVHXzL/oOYv68qbyB559UNmT2nCti9gj6YDVZCKkVu/?=
 =?us-ascii?Q?9C10na6pG64tjh7a+2LqfhEvI3dHP5MMnRBp3Iy179ReE7x7XkHqL8gwkeK2?=
 =?us-ascii?Q?0DD8GuYbLKKJnfvIHQNZOUJBPX1THnxbI9pBC+N+eK/30Cxx/F+EWR6z5aaT?=
 =?us-ascii?Q?jAC007SJxlMpEt/qJUgdYDFvm7MdrUi0ix9hRG1y5F9gdDX7PeM3whDAlNiQ?=
 =?us-ascii?Q?p3aLZ4IIsD7NPOO0WYujy6OCIalhRUPHsljvnOG6Ge7WbVKaABEQ7LcPzLjX?=
 =?us-ascii?Q?iQ4uQUhg1OIavTfEi8+a9NTnYxq7rz3NWSTXJ7STOO+rO4T0BzsssWsgP36n?=
 =?us-ascii?Q?0FvXeba9ZEsYPjyc44G65Nhk6OQL27q89s9SkYO6cvpRTlYTpQYw96V7jfjE?=
 =?us-ascii?Q?vqyB105otnwSsED8b2/4IMSEfinI0HECnH0gJSurfZXOok8Z+w8QOPZbqJrH?=
 =?us-ascii?Q?Ezy3ugQTM5r2VOtGsVWQN7/5YeVQ5Y6rSY/ulZK4hTqfkwZ4kJlX6YXCgH4o?=
 =?us-ascii?Q?1s0NcVeV94WTZpCKVbTlXKB99672tlW4DdxmMv47cKfTfdVQ+e5dwRpKBfvo?=
 =?us-ascii?Q?aAtgfXQDZaCQ+DCMyTLqp9FUJTdFtz4/nobs5gexgPvHiQ29LhNjEB/PbuYs?=
 =?us-ascii?Q?pK1vSfAlZBpldXLurQQz9Qi9+kmMzLV2E4l0caD2CIvc1/pmAf1RUo6RX2OW?=
 =?us-ascii?Q?w5VJHgXWhw74Y8E9bMY/Cq06JgKBMghyMT5jgdphxQG4BvwI36GXMKUPJh+q?=
 =?us-ascii?Q?up+fRBkK9Ihtch9/by9S3aLocymVidhQHg9WodnXYZjNFg2ngmfHIJLGNuIc?=
 =?us-ascii?Q?Ta8u1tXdGR1h0LyuGX+mLWkKyNi3XNzQmIxlPxLqwM4ugrbPINSKNB2QIPDi?=
 =?us-ascii?Q?Q0o+ckevMryNbSmIfvvcdXqDbb9K2uD9ChxXQFfm6/brpVOe8gwe812xKc7v?=
 =?us-ascii?Q?VYZsKtYMoepB/TIVFGXNyUnb3dO6ngL7BJfOyk6zL1N3XHI+Di/F?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 281bedc9-562a-498b-23cc-08def97eaeb2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 21:06:02.8459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xv+RPjiFVerFGzqhlSiorrQgxhh7T3TTRP65iuikHf7JNcm3bUqp/IX5wqw3iMv6us6W5D8QGzZTpeQBMdQgrsCv/tj+L4gkoMbdzChqeFw+MHNB3Uw4bCBCKAKmUrUr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB707085

On Tue, Aug 11, 2026 at 10:06:24PM +0800, Jason Yang wrote:
> ov5640_set_stream_mipi() always programs IO_MIPI_CTRL00 with 0x45,
> which selects the two data lane mode: the number of data lanes
> described in the devicetree endpoint only feeds the sensor's clock
> tree computations, so a module wired with one data lane starts
> streaming in two lane mode and the receiver never assembles a
> frame.
>
> Take the lane mode from the endpoint instead, both when streaming
> starts and in the power-up path. The field encodes the lane count
> directly - 001 for one lane, 010 for two - per the current sensor
> manual (version 2.33). The 2.03 manual documented 000/001 for
> one/two lanes; OmniVision corrected the table in version 2.1,
> which is why the long-standing comment here found 001 unusable for
> two lanes and validated 010 instead.
>
> The power-down path still resets the register to 0x58, which is
> the chip's reset default.
>
> Tested with a single data lane module on an i.MX8MP board
> (imx-mipi-csis receiver), where the unpatched value produces no
> frames at all, and on an RK3588 board.
>
> Fixes: 19a81c1426c1 ("[media] add Omnivision OV5640 sensor driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jason Yang <jason98166@gmail.com>
> Assisted-by: Claude:claude-opus-5

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
> Changes in v5:
> - Program the endpoint lane count in the power-up path as well,
>   instead of leaving the hardcoded two-lane value there until
>   streaming starts (Hans de Goede); the power-down reset value
>   0x58 is the chip default and stays.
> - Credit the v4 changes to Hans de Goede - v4 wrongly named
>   Hans Verkuil.
> - Link to v4: https://lore.kernel.org/r/20260811-ov5640-1lane-v1-v4-1-c4a05d4c1b32@gmail.com
>
> Changes in v4:
> - Keep the lane count programmed also while the interface is
>   disabled, toggling only the enable bits (Hans Verkuil); with one
>   data lane the disable value becomes 0x20 instead of 0x40.
> - Link to v3: https://lore.kernel.org/r/20260811-ov5640-1lane-v1-v3-1-ae476eaf5024@gmail.com
>
> Changes in v3:
> - Inline the lane count in the write instead of going through a
>   local variable (Sakari Ailus).
> - Link to v2: https://lore.kernel.org/r/20260811-ov5640-1lane-v1-v2-1-65205ae86feb@gmail.com
>
> Changes in v2:
> - Compute the register value from the lane count in the single
>   write instead of branching on it (Sakari Ailus), with the count
>   in a local variable to stay within 80 columns; the programmed
>   values are unchanged, 0x25 for one lane and 0x45 for two.
> - Request a normal stable backport rather than opting out of
>   AUTOSEL (Sakari Ailus).
> - Drop the quotes around the function name in the reference from
>   ov5640_set_power_mipi() (Sakari Ailus).
> - Link to v1: https://lore.kernel.org/r/20260811-ov5640-1lane-v1-v1-1-79699457ce13@gmail.com
> ---
>  drivers/media/i2c/ov5640.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
> index 8deb5f5501fa..526939041ad0 100644
> --- a/drivers/media/i2c/ov5640.c
> +++ b/drivers/media/i2c/ov5640.c
> @@ -1831,22 +1831,16 @@ static int ov5640_set_stream_mipi(struct ov5640_dev *sensor, bool on)
>  	/*
>  	 * Enable/disable the MIPI interface
>  	 *
> -	 * 0x300e = on ? 0x45 : 0x40
> -	 *
> -	 * FIXME: the sensor manual (version 2.03) reports
> -	 * [7:5] = 000  : 1 data lane mode
> -	 * [7:5] = 001  : 2 data lanes mode
> -	 * But this settings do not work, while the following ones
> -	 * have been validated for 2 data lanes mode.
> -	 *
> -	 * [7:5] = 010	: 2 data lanes mode
> +	 * [7:5]	: data lane count, 001 for one lane and 010 for two,
> +	 *		  per version 2.33 of the sensor manual
>  	 * [4] = 0	: Power up MIPI HS Tx
>  	 * [3] = 0	: Power up MIPI LS Rx
>  	 * [2] = 1/0	: MIPI interface enable/disable
>  	 * [1:0] = 01/00: FIXME: 'debug'
>  	 */
>  	ret = ov5640_write_reg(sensor, OV5640_REG_IO_MIPI_CTRL00,
> -			       on ? 0x45 : 0x40);
> +			       sensor->ep.bus.mipi_csi2.num_data_lanes << 5 |
> +			       (on ? 0x05 : 0x0));
>  	if (ret)
>  		return ret;
>
> @@ -2532,16 +2526,17 @@ static int ov5640_set_power_mipi(struct ov5640_dev *sensor, bool on)
>  	}
>
>  	/*
> -	 * Power up MIPI HS Tx and LS Rx; 2 data lanes mode
> +	 * Power up MIPI HS Tx and LS Rx
>  	 *
> -	 * 0x300e = 0x40
> -	 * [7:5] = 010	: 2 data lanes mode (see FIXME note in
> -	 *		  "ov5640_set_stream_mipi()")
> +	 * [7:5]	: data lane count (see the note in
> +	 *		  ov5640_set_stream_mipi())
>  	 * [4] = 0	: Power up MIPI HS Tx
>  	 * [3] = 0	: Power up MIPI LS Rx
>  	 * [2] = 1	: MIPI interface enabled
>  	 */
> -	ret = ov5640_write_reg(sensor, OV5640_REG_IO_MIPI_CTRL00, 0x44);
> +	ret = ov5640_write_reg(sensor, OV5640_REG_IO_MIPI_CTRL00,
> +			       sensor->ep.bus.mipi_csi2.num_data_lanes << 5 |
> +			       0x04);
>  	if (ret)
>  		return ret;
>
>
> ---
> base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f
> change-id: 20260811-ov5640-1lane-v1-b0fe37eab4d8
>
> Best regards,
> --
> Jason Yang <jason98166@gmail.com>
>
