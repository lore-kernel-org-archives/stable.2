Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793823730;
	b=frD5mW9/brVRPIbZ480ygE81c4fpheCzdIW5M3nzUQm4dNpVYaakC6HTiqPESWKHrOd/
	 m5cNHdYhzaYuSoku+TflW7ELJuyrltSULxKweAI1KUcn0G7Baqih76Td9mlfIjozupyV0
	 /L5C23l7X3+p4qNaSFN4mjqi+HvUtRKSvbHiJ19Lny2nR8zy5xWM+0y22OQX0HsML2r9j
	 IKKQCDsCJJhxWTqD7vJ/KH923jzScnuyWcWnI19qntVNkVl3EUuj2oqqD5vyuzGlCMtkD
	 ibfy+bwcyMKA6bPMmab6UqOLtIMkzqejJVGGBte+qhG8Tyy/xZuOltoiniYnJ6xhccA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823730;
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
	bh=u50nfdFBVNw7e40dxmLgsl789Wy7af2F/Ff1KJFsa9Q=;
	b=mL8xkKVMUwKuqSopCjcHVJOSSrdS1+NmrSA0wBPFYuIK0FMJ84h3yXN7L5X2IloxRcC1
	 HkapotbZ/gpsutVFLSyAOLUA3RlEKEpBZuwN+pIhvW9lsPp6tYliSiKOxKLE33qK7yi7X
	 wt4H7PIGc95DHgg65Y6QyUwnQQi98nnTiDb1m3ADp2fI0cWNFXo3mZOxbA0DEzwVo2HcE
	 SLC681l9SLvkF0zFV5s12pVI4OFnawkOBlJG2QXrMIMqUnPQt63aHCGF6B7oqZGNy+hsT
	 hhb5pGlhFonRIhoMJ9BqeSDFhyYqVOvPBJ9nsyx8vLbgsJl8nYkxs1q3yRD+g+PVegA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=k6XEKotA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.66
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011066.outbound.protection.outlook.com [52.101.70.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE506070433;
	Wed,  4 Nov 2026 20:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AE506070433
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=k6XEKotA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDrqnNCISCRr5gYUIjIlOIP6dz/DoMIBJ6tRBexyi4yUpNUnq1Ig5RHF//Gp/ls8+bfTsvMiOCzQRfJflEynb1WQIyu6cJj7ZszQnsArW6ey8X18/Z/ygGfGSCr5sz7hEymFw1N4nApV2mN/jUFzKSFzIKQv/rsIt0dqza3qO8El3dwEjjRnjFFHFHNTnV60dy/mBxduhNuMSXb5HCjoAyBUoIID8EpYUvi2PAWVxvbY7DQHxmJGuripcnpC7733cNeYPy4MaEQ5LIwXkIi1t/RtKgIA8uEtyXEH81OLgVnCqC5W301DbqtU5EpJrw4gSq/aaepNcbcDxtgxMaHrEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u50nfdFBVNw7e40dxmLgsl789Wy7af2F/Ff1KJFsa9Q=;
 b=rRx3Tu/rpNIlHIMo7DGe+bFYO6ekRgGuaopFJGAzF3DAjctqeK4PiCGQ2xJ5ZpCxhsRJj8j+40UnSHUV14Wt5Ye0ks9WLynDTOdYCqo51PBtiN/McSyXcnAIhtPIgK7HzvhRkgzJXxluG+swkEhjJ/7v6AuONspmezuko5jB/9ZeNYD4T16FkicXytxCeCb2mHu253o9cWy93cXgVtOTg6bm9a3baOXSUdqRnOi5VdD4daOCe0z8i/C40A09zvtJa6gaER+gA9PFVUMUpjwZp/v+bN74mFwjEGsVy5wtvjcV8G7q3/kU4IkdyymxExMpG1fnqlF9aMcP2vaFWUG6gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u50nfdFBVNw7e40dxmLgsl789Wy7af2F/Ff1KJFsa9Q=;
 b=k6XEKotAN/u6v8m1zQC38t+RoA8E/13ORBS9SKFYlEwN8vWZO7lX2YvjxnyW8reCQ6II9E08FbGgiI2ewSwQPy9alxQgMiQcL3JO0YD6lndZAvKxlyyydoRqZOPHfpQ4fDGWI0hU9yilRx3oI7n9XNo7PgSHLnax44gLs6Yk5XA7ujGRBLZjfPTVAkZ1QCa1zAJnJo8hF5CEA0Vc+4sL6/g3P/OvKpSrJmAID3mh0Oy6OxuQWLTXoLgJFwXZRUILYLQLa9kUG7h7gs7nWP7iVqdvZaZUXpiHva7rl6CFo3GjKBh6HDlKxx7XMZaqWwjNdE3yQPcGEerz4U2Pb2tlLg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by PA4PR04MB8046.eurprd04.prod.outlook.com (2603:10a6:102:ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 20:22:00 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 20:22:00 +0000
Date: Wed, 4 Nov 2026 14:21:49 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, stable@vger.kernel.org
Subject: Re: [PATCH v6 05/10] dmaengine: dw: calculate residue in the status
 getter
Message-ID: <auuT3TaE0oQakJ1f@SMW015318>
References: <20261103-submit-dw-dma-synchronize-v1-v6-0-2ee0c348224d@gmail.com>
 <20261103-submit-dw-dma-synchronize-v1-v6-5-2ee0c348224d@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-submit-dw-dma-synchronize-v1-v6-5-2ee0c348224d@gmail.com>
X-ClientProxiedBy: PH8P220CA0057.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:2d9::17) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|PA4PR04MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: b871eac6-56d8-4913-b192-08df3ab1481c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|376014|23010399003|1800799024|10067099003|18002099003|22082099003|261022105027099003|56012099006|4143699003|11063799006|261022075727099003|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	rLoRTc9uBhM/4bQ5Q0zmhFFbyOD/tiuSR19lwNalCtVdmyhMGiPHzJKCNhgiaNmesn5gB2odbxcX7N0JE75rX6lHn9QvHjXma/3Psl6SH027A6ZlY1sCEDFfoYMzw3/k6K/jj/pnlAZZG+lr70HncoorYEkIV5ssJ64hkrPkVf2Pqku7CSi8Nb+sJO1MfXq9C4BWOvKra5ANgKQRNphSpfhzN18dKzB1nHNKafw4Emy0RcT5M72zi65Zenn0xpr9pNZ4USHEQN8QMX0Xuop/tGRsqpXEGGJYQrriZmc7RNCKOoS65Cj98/ipuulEP6P7dX9gVe1zrDn+O/vvCB82tnS6az/YIefIP107qpHLvTETlwpAJg4L3sOo+1DDUPmTBNgZG/+HqEvYzJa63YGBhTsktZ0m5hvXSXZihoV4eyVeG0QOFWBWsP6pkUgOoEjvNi8tps0gmUdq8exzfwUE2dxYPS8DDaYE4m2o+5caJpQ5B4jHx+n0OSXG+vQh+tpQnFaU8TVTb6O9LRHGdimkPoW2nX29av/bZ7qiRdQ+XZddK4oL2siJku4rcY3W4q93o0S/7Y7WjM2+cxL39u87s8QvTymlLRhaBVptqIWg+bit3DqVMLD6G4bqUSsORQxKb0MVVwOdsjWkHC5RI0gAmYZIyLkYe045Cd3Qh+fepc4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(261022105027099003)(56012099006)(4143699003)(11063799006)(261022075727099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261021123027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h2kgaeP0XwcRNr1MZomXDL+g8K14aV/zn3sn/em2SZT0v4CwkmEm2gu3ewuS?=
 =?us-ascii?Q?/QaYakuQZm3kZ6UmTONrzrvVO3UUlKxhuZhbU6ZetSa0OLW20oO5Z3wCz0pT?=
 =?us-ascii?Q?TpO597Y6pdPM5dyevBAGut6C+vDiP+t4BPJeokozcK6N/mVIfGmGTuRPxwcK?=
 =?us-ascii?Q?ZBqXdIh2LymPEgYDe3dNHxuwH1J26KGCXooKshOGfoVFQ2aRQpfeZp+F5QyU?=
 =?us-ascii?Q?Zeml8+Hzah9etrqIqyJSksQhABPgU6+LqYhEOOnlVta/z1Po+XlJpfIoLukh?=
 =?us-ascii?Q?IorbUAX0CyQ4oTaCCb4ZJDz74AQY/0zW/s/2IzoiXmeCKiFCEiCuq02Fhubj?=
 =?us-ascii?Q?BOK8ZYaYAmeXePZ29hiNZs/lfYIWEgC4I9Tnrk/9EwXVWgbMq3rwWEnNbNH8?=
 =?us-ascii?Q?bclfe7Q7QuIJnZNEPH8CWMmERutR9hzvFmwp8T3mjB/tVsaJMlXmnpIPU4UT?=
 =?us-ascii?Q?BvswGgch/phia9nlGfszt2SBZehpv9rndy4yDKBZWVbNRaLhHWkxU5lY7VRC?=
 =?us-ascii?Q?u1/liIu28kf1+IiOsUWM05mpksL6eqH3SyOXYuxTa7kwD0aaNkOkI9qa3bfk?=
 =?us-ascii?Q?o/1iOxscERTBJhoz9S0W1UNd5hHH3M3+Q7u+H150CGX6JuRB6Ij9CZ8tUmpf?=
 =?us-ascii?Q?C+5YjRl/0B4uongcqr+4lDBd8p7ZWsRquT5q3MPI3QhLzKrOznRrsFuUX026?=
 =?us-ascii?Q?lZlO1anI2JVl5R1vrKqhK/Bp4uvg34nzJVlUZbsAyLmQ/OCaFhNJG/osjwuz?=
 =?us-ascii?Q?7MFqdJDmbXKtnSRmr5ZDbQAGApyP1YesmJaeDyyuRHZfRXo9+xQIrQ7vnesN?=
 =?us-ascii?Q?+iou7z7IaJAEFCnUgl9Q+Y8uihHwvBEn3aV6/ojG3Gm891+HUsm9/mgORF97?=
 =?us-ascii?Q?Qmrbz7w7j4+CemxOyitds/wFvmMZK/b1/80hC6Zs3xBwVdIfwIwaUCn9E2wU?=
 =?us-ascii?Q?1fJuiZ7czZ1Xvcc2NCrUbyL/3Ju1nbYZJsgKF8BrsJ0so28N7hXv2RAUB1iM?=
 =?us-ascii?Q?bRkPaM/9ZdVqCvrozg1Hnqu30nGqPvguU5LROc/Jnrl7fbbDb0QS1kjpw5vO?=
 =?us-ascii?Q?x05fOKB9z6pRNe7yfrR7glYPkPmfF4/mQ5cngkK5thYqBI9wup3kuZovgLHa?=
 =?us-ascii?Q?BxRaYwe3qB2wvx5G6+1cHEGbaV+mEyfimTI8wtzKZCg9DvZfwTkdbDH0ObjZ?=
 =?us-ascii?Q?LEt2p3oEXVmEdEgAh5NqObodl1/2EcxS+YSY7uLHJ2GPRHTH+cAq79iD/Nst?=
 =?us-ascii?Q?LClaEvV440Rxzu+/63EKowTmbZbt3HlJhIJPK2o7Z1E2JEQQwPbgbB6CAe5I?=
 =?us-ascii?Q?v2FdexTVgOG+45TFI7oTgR4gRhL37G7NaGKADVKO+XF9JNrwiMqCh91OqSIF?=
 =?us-ascii?Q?LytP+/5iQzuk1XbQU9HKpO7GbBlZxsOXcIHp+X5c0t8AN/cBm7Qlh9AAauKZ?=
 =?us-ascii?Q?9oXBL43tZhFkJrw+TMLOn8yv35i+QFkwnTEjdqRWBOdmUrilNEN7Yc0sBpvM?=
 =?us-ascii?Q?GDy/lD0HMkfqelremUB7XROO7BPvG71SMWU2Jh9w4yJ53xlVPSOaEs1G4mq/?=
 =?us-ascii?Q?tcKSOv3mKoZKicoZTHevFnqTzmcyVeWPYKkISl7xsHU2ZNt7uj2t1PjlsC/f?=
 =?us-ascii?Q?JO4XkufGpuQubz4c4qWGnD4cTKgDoRQ0Yz/kfSYQ9KbI5TgMngtypLST58hN?=
 =?us-ascii?Q?st/ZNqa8f5BtmnKgpkxrjULorqeA5F4E7cJTCWszckmt+HNfhhFevgfhgAQH?=
 =?us-ascii?Q?LE0KgUkQEFkQnv2h1ASsDFT6sOC4E7QiwllHp6eKzcdT6QP2ovUI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b871eac6-56d8-4913-b192-08df3ab1481c
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 20:22:00.5512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7O4YdZw5szp+YvWhFCp7xWWq/R9pVG1hvZDOpTOakUGpycPozta7WXmASgZz0esc38hz0ZySkfPKKBQUt5yneRpCOmF6G43RWJjB54a5fKxwAou1bL/TQDPX0C/piSmk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8046

On Tue, Nov 03, 2026 at 03:26:07PM -0700, James Hilliard wrote:
> From: Serge Semin <fancer.lancer@gmail.com>
>
> Calculate hardware-LLP residue while looking up the requested cookie under
> the channel lock. The scanner and the status getter currently take that
> lock separately, allowing a descriptor to start between the scanner's
> residue update and the status query.
>
> Have dwc_get_hard_llp_desc_residue() return a local residue value from a
> fresh LLP snapshot. Keep the persistent residue field for software-LLP
> block accounting, subtracting the current block's progress when reporting
> status. The descriptor scanner continues to advance software-LLP blocks
> and complete cookies from RAW.XFER, including for polled transfers.
>
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: retain polled completion and software-LLP progress]
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dw/core.c | 64 +++++++++++++++------------------------------------
>  1 file changed, 19 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index 5a1caca7ad68..d9127337c849 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -267,41 +267,34 @@ static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
>  	return dw->block2bytes(dwc, ctlhi, ctllo >> 4 & 7);
>  }
>
> -static bool dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc,
> -				       struct dw_desc *desc, dma_addr_t llp)
> +static u32 dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc, struct dw_desc *desc)
>  {
> +	u32 residue = desc->total_len;
>  	struct dw_desc *child;
> +	dma_addr_t llp;
>
> -	/* Initial residue value */
> -	desc->residue = desc->total_len;
> +	llp = channel_readl(dwc, LLP);
>
> -	/* Check first descriptors addr */
> +	/* The first descriptor may still be waiting to be fetched. */
>  	if (desc->txd.phys == DWC_LLP_LOC(llp))
> -		return true;
> +		return residue;
>
> -	/* Check first descriptors llp */
> -	if (lli_read(desc, llp) == llp) {
> -		/* This one is currently in progress */
> -		desc->residue -= dwc_get_sent(dwc);
> -		return true;
> -	}
> +	if (lli_read(desc, llp) == llp)
> +		return residue - dwc_get_sent(dwc);
>
> -	desc->residue -= desc->len;
> +	residue -= desc->len;
>  	list_for_each_entry(child, &desc->tx_list, desc_node) {
> -		if (lli_read(child, llp) == llp) {
> -			/* Currently in progress */
> -			desc->residue -= dwc_get_sent(dwc);
> -			return true;
> -		}
> -		desc->residue -= child->len;
> +		if (lli_read(child, llp) == llp)
> +			return residue - dwc_get_sent(dwc);
> +
> +		residue -= child->len;
>  	}
>
> -	return false;
> +	return residue;
>  }
>
>  static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  {
> -	dma_addr_t llp;
>  	struct dw_desc *desc, *_desc;
>  	struct dw_desc *child;
>  	u32 status_xfer;
> @@ -309,7 +302,6 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  	LIST_HEAD(list);
>
>  	spin_lock_irqsave(&dwc->lock, flags);
> -	llp = channel_readl(dwc, LLP);
>  	status_xfer = dma_readl(dw, RAW.XFER);
>
>  	if (status_xfer & dwc->mask) {
> @@ -372,27 +364,6 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  		return;
>  	}
>
> -	if (list_empty(&dwc->active_list)) {
> -		spin_unlock_irqrestore(&dwc->lock, flags);
> -		return;
> -	}
> -
> -	if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
> -		dev_vdbg(dmaengine_chan_dev(&dwc->chan), "%s: soft LLP mode\n", __func__);
> -		spin_unlock_irqrestore(&dwc->lock, flags);
> -		return;
> -	}
> -
> -	dev_vdbg(dmaengine_chan_dev(&dwc->chan), "%s: llp=%pad\n", __func__, &llp);
> -
> -	list_for_each_entry_safe(desc, _desc, &dwc->active_list, desc_node) {
> -		if (dwc_get_hard_llp_desc_residue(dwc, desc, llp)) {
> -			spin_unlock_irqrestore(&dwc->lock, flags);
> -			return;
> -		}
> -	}
> -
> -	/* Residue describes source reads; only RAW.XFER completes a transfer. */
>  	spin_unlock_irqrestore(&dwc->lock, flags);
>  }
>
> @@ -987,9 +958,12 @@ static u32 dwc_get_residue_and_status(struct dw_dma_chan *dwc, dma_cookie_t cook
>  	desc = dwc_find_desc(dwc, cookie);
>  	if (desc) {
>  		if (desc == dwc_first_active(dwc)) {
> -			residue = desc->residue;
> -			if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags) && residue)
> +			if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
> +				residue = desc->residue;
>  				residue -= dwc_get_sent(dwc);
> +			} else {
> +				residue = dwc_get_hard_llp_desc_residue(dwc, desc);
> +			}
>  			if (test_bit(DW_DMA_IS_PAUSED, &dwc->flags))
>  				*status = DMA_PAUSED;
>  		} else {
>
> --
> 2.53.0
>
