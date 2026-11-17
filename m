Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794945044;
	b=M9+IrAew/9Z0PAJkELtVO2ZsAtws8SWVTy9A310VJT9tr3IkWKH142Vw6KbrKl0HJ7oN
	 f0hqRB6bp/A2Pw6Piu6/HHPfaCcZMr3Y3x211q6u4r9ArIz3lM+rDiXbo4AKFbQxwrE2/
	 4/JfZWg6vGIFe5oq/IhisZMVQqdbqJE2+PGd4N1hUH8+ErbLHthuYbp/BwGidiHfALKMW
	 zbucSbNchddEWeDhPNiwyd0DmX9pyrBbKOr0sot/2a5A8mvFqR1UvvfJT3+eHwThz58SB
	 GVWNhfnuQWVDuthchrc4Eyr0eygp5K1rZr2Wt6ZkBCgZtxWhrLlNqGC8GnW5H6BOAGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945044;
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
	bh=czFocsfarXQtm9zkgaGeIo4LmhEdfI1fcIFK/ZCfOXk=;
	b=r50vkBRFCEpPL8XSEpauJi9voRy2woodGolNfJ/lLk1iN9LsX6s4BRjnnqMjP+TSbY/g
	 jQh01ehr+a4YpC+FtX3AD5bSr2gQbRAriEcb0tzeJquprc7tyS8xXkRTdphGWxTgYfQa9
	 HBocLsayzFZGrS2V7bhaPQoMF8VBXDode1H0DwxB8zflpSOCEfs2JYpluXiuvUgUZ87sL
	 FZOE5ahZuwnurvy6duDtpZYQvvzpPKNme5VFqa4f9LJsRe83DRd6nc579hATzlhx9fe4L
	 n4sx7RqwS7m04DQK7R2nOYhhM5mTZMoTneoOaIde0KA1PN91K4ECo+nVcvev3nsKtaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=VuLvRe2o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.9
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011009.outbound.protection.outlook.com [52.101.65.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C82F606A31C;
	Tue, 17 Nov 2026 19:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C82F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=VuLvRe2o
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inRFRY7r+KFTfb6yWqNE6OGUwJqe24j+MdkkB7irpyIZlYqmAJCI/gJ0gBJQW+dU0iFoZB660lHzkW9kescEhqZQiGU2CpwMgzRE/dEMdQ1Qn3IsjytuczXMCSNxFPpmjytS46CTUmWAU7PgCfOuF76PeDoHEYrT2kj0bX87aLC5wDHNrt3+qUR/YneQmMmJjUgZsG+6tSLnf64E4gHBDREQTY3u8Vd8XxxO2CavDGmqfdGbr+6jLM1DIGyfdkbL2Q3b8E+CMpgq0gqAmqjcJhGN5kQajhjMNYKP1K1cVL8QoaE0MWTQrdw/xYn3nSYzaEmfdFgfsvxHQXsy8FdUDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czFocsfarXQtm9zkgaGeIo4LmhEdfI1fcIFK/ZCfOXk=;
 b=hhJaw9iPB7Oi191NHSV9nkttkdEs27ff7RLk7PSWO1tCJ/zwSf8GVM0xv8/9Ov3TEBhT7nG7JUxs/97G6abGuW6oOgAkEMB+4z3k9htJ5KXMd0CsW9TeSp2Y7b1bahvIFXvyX5fofnk0fzb5pdFZ34ldvCwNkK9ypRPbOS7bNLrboqx/4BZGBBQN550s6gumrsQMBvga3VxDJPnatRGR2N3Ou7MDQNQ+6Z7PkZC34+FaJbLvG3iNlNfcLt9VS9S+Z0QGDKgk/JyKQeLU7yu1IcmxbsJbTOk8rCrfuBhNfV/SlnpIIzE5vELFfv9iEI2DRlUBGl90ue6rcrZze+yJbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czFocsfarXQtm9zkgaGeIo4LmhEdfI1fcIFK/ZCfOXk=;
 b=VuLvRe2onIHzLGgsTW090oCZvWEkTSYd/CKL9I5CYlnmAba1PYVnnBFmluVwl1Tx2dSSCsrCjdvn9HljAt+BpthDBsMJ5aMhvm7fzpVC0+syDwu4owH0/MJ0/mZKF+JCMHjYWFCVNiZi2J4bSq7ZtzjJDo/DKvf/xj2GySpoNsqsl2ffm+ajHYVxK3zUpkyfo1QV5YhTT+LgpzVtJIWA1zpCo6ElbCX0sMPXLGGLgPA7X2qUSoDsb8TwnqsE/0IuWaw/UI1eIzc9jX7D4Z/5CQa/2rZp0DcnT/phbL88MbaMdy3lhoaTloxgdmwgLZ9W/m83pK0EM/HntwWPllZUeA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by VI2PR04MB11051.eurprd04.prod.outlook.com (2603:10a6:800:26f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:50:41 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 19:50:41 +0000
Date: Tue, 17 Nov 2026 14:50:33 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Lee Jones <lee@kernel.org>
Cc: Paul Cercueil <paul@crapouillou.net>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Alex Smith <alex@alex-smith.me.uk>,
	Colin Ian King <colin.i.king@gmail.com>, linux-mips@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 10/11] dmaengine: jz4780: Fix descriptor cleanup on
 hwdesc setup failure
Message-ID: <avywCU5k0B_AnlWR@lizhi-Precision-Tower-5810>
References: <20261117163809.622249-1-lee@kernel.org>
 <20261117163809.622249-11-lee@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117163809.622249-11-lee@kernel.org>
X-ClientProxiedBy: PH8PR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::26) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|VI2PR04MB11051:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c716628-d3b3-4ae1-39f5-08df44e40f89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|1800799024|366016|376014|7416014|22082099003|18002099003|261009223027099003|56012099006|4143699003|261026140227099003|11063799006|261102123227099003|261028144727099003|261021123027099003|261022105027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	a6bLCIUXkB6ZY8Az5LbvQNKGL2sbOleSHa/Ch3/Ozp2UyiZPnyz5jO6zjXemSINwBXWrtmXLQGvkZGdG5BT8Acio4m/dXUrNxNGaswpES5eY0iOVCLT8qXVTmbKoI/RF0Aa72FvhNloXN1y698TyywrY+MAmgRALXBYhixg7fmDVclz8HhcgJogHBeoK15bML6Pe07ZEwcxPQ3HCj/69NtDvrLFgH3985f0yGXrlEI/2NXdkQu/A3Fkxsw87gKtPwmJJXnGKx+bRnPOJDgpGFenK8L78eOn+Cc0cioBmkfrvjCXvIeNKfdKc5vNiVA3IGC+f09Mj4uwJxuLjsA+FKBjcedxT/fhHX5KVAGhlTJVx2eDx6il3o94/QygTyG08JnRVRXHuCj6sh4GRCtcUJ5kd11qG4tKVbhQzrK7gCMCFlUueyjJUf4Q6T2g110kXP3gdAL5pCfuHAj1itDbXYmJdPjhvPDG7fPjawQwN6KXAqjNz8933TpSkOmUwf++0I9n3rwjoPuWt7AEmUv9M6QvEYueJ/UkVNiExNtRRuq3HsM4qgy8QRlHFipNFTOn5b15Ucd3mbhZiNDC1WrpHgzey39S2NQZMCxIkPSg6y4o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(261009223027099003)(56012099006)(4143699003)(261026140227099003)(11063799006)(261102123227099003)(261028144727099003)(261021123027099003)(261022105027099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rQwr5Q+lsRzpmDX+aqdGolEmDzvXoa67XsI7PFTtExhL/zKMmTWmSidNtA/6?=
 =?us-ascii?Q?EwFBQtI2d2y6RiGu/RhdbMHtlmbEyan8wuiocUPoXgn69R9tgd2Fib+m83tN?=
 =?us-ascii?Q?UXONxSd7ET0fXEDbKIAVSjecugP6eqJ+cP1P7+vVnyguQRGxZamkXwRRQSbw?=
 =?us-ascii?Q?9T3bv462nq7A1lHb8QXBiiyQPgyr6MQTrX9JjuzROGdCHNpYRT7SEYPVTyPi?=
 =?us-ascii?Q?DHoZFRc14kJT96Cz2k9DkodCdX17caAV7WbXA8bhw5zmpulQUuiyJPun6dzS?=
 =?us-ascii?Q?IBZuro0Eh7LBRtZUXFnppl5zhL3Oo7Qg5TesJ4Beg7BqEeVumfddbbEK1cnX?=
 =?us-ascii?Q?4oNSwiB0c/u1s8eJnGXY+qT8tLoTkmF42Xz49et35d+vv9Mg/rzh85UnKaAW?=
 =?us-ascii?Q?caIZJWPwlgzsLE5ji7At0dR0TkKMzCRXBTJOXE4OTP34LtnHsnkNX6bnqtKj?=
 =?us-ascii?Q?E2sOYzgUl619BmvtjqWUyhxCOAHnZFDuSLSdTtbHmMEMypY/8mH9uwxKMyCP?=
 =?us-ascii?Q?7oa6De+MiyWoMZnBJp4yNk11Ppp7A4Yh6cSrQr2Gi8n75r33+Z+xWDKWdmI3?=
 =?us-ascii?Q?wGnHJU6ayVCsT92ZL25+Qic8I2AGto2A/r/PGOgbdzVTzWTidWlFz+4lfmp3?=
 =?us-ascii?Q?VqCodP7auwxnFni1MZnMfd87yo0qXStCEC7So9Dt9xY794ytbznCoHLbKbYW?=
 =?us-ascii?Q?8meTeNz4IBqGlGttHFnN4qDx3sy+LH0Aws8u9Alng4FIVL3ZdZsmyc28RZiC?=
 =?us-ascii?Q?JjWwHxZz74BcR9Jq4RzopbM4PrXFo/HTEp6iMEVBfGh50d/zD88dYxhHAuQP?=
 =?us-ascii?Q?YSpiaJ35BVlKphKQdUGmEDf6gjD9hlEdkqE++qye88VBzQqiTFisRsuLlIi3?=
 =?us-ascii?Q?AvIeQcwgm2sTDPBF8kp30vjajoNi2bgNmbkGXMxsqZzf0iUaO1YW5mJJ6qxF?=
 =?us-ascii?Q?OMGpm5cn8teBTIoVZ7Jt2OnbbU/1YEnQPYXfvz0glvFk9UVFW3zcsQ+3KWmJ?=
 =?us-ascii?Q?9GF5HSyivS2eav6KxKm/a9rbipuL0biyDuUCLd41dLJKyhnsxgpBIxibJkbq?=
 =?us-ascii?Q?nGxUDWcf21fodp/DNrBjg3Cl6r8NhRUQKcd3oP4C6DmbZK2J2LmYhpa6WgaA?=
 =?us-ascii?Q?64EqpffPXmZ1TywliDU1XDfJT1jQFlSpqNdqMUcXFliKWcDrZeBeAxBsUQFq?=
 =?us-ascii?Q?RiIF8ZGSTsXcNIBDofa5lwF2pJycc2yYpuEpCiERsdazMeLsptbgrJKLu7Un?=
 =?us-ascii?Q?wn9Agxvwk8h6shCW5ukg3zZ9BktlDwIS+nQFPpwyMw9msXcwE8TWV+yC2EXd?=
 =?us-ascii?Q?WhLyl2+EGc3cjOG6pBoato54Jia/dvB38RF5J5wUvNV4KcUZe2S5VOryw9a6?=
 =?us-ascii?Q?jvWxBf2GwuT2vEUKECkRnqR6m0bQoLEPPxNH2tbz6lC2ampQVa18ThuW1qyj?=
 =?us-ascii?Q?E7C+/AnvslMor3ZWm2EyiuuvRQaX8Dv+4P4+4iZ118v40fbn5YIlehkUu+nH?=
 =?us-ascii?Q?SdstJ8Vm0KoW2JHW72LX4MW0gbbQnUUgt6WYqVWLVUaoy2U72491nheIBaFm?=
 =?us-ascii?Q?rjg3V+1lcx9eKtjUyFjp0uOcQtP16pFHb9rKVWyLbybJDvJKX/rwAebryMW8?=
 =?us-ascii?Q?PiZ+rRXT1NAy7EAcbtDdeRN6tmNkHJy9PzJc6JSPyvylBYfes6bVI0GLyz+A?=
 =?us-ascii?Q?y0yr2J+zQiieS/gQyDSzE7R3w8DivRD+LN0BNIxcgQspaeeW8xCJFACdz8rQ?=
 =?us-ascii?Q?BYMD6c97myfKAh6zPe7zD30YOEhC643gmOE9Wtlh2AVPX32ozdUU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c716628-d3b3-4ae1-39f5-08df44e40f89
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:50:41.4404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GAHq5vXa1Y9LHQc3se/Jc56g/wFzwVaXe3b86+ODdOUeA7n+eRj/C3AYFa2gJvsNcDXe95f3OyVMQF/iOUTW59TT4USbUnzXhZwlBdFLhEk95xeA1jTz6QCDQUzSw/W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11051

On Tue, Nov 17, 2026 at 04:37:11PM +0000, Lee Jones wrote:
> When jz4780_dma_setup_hwdesc() fails in jz4780_dma_prep_slave_sg() or
> jz4780_dma_prep_dma_cyclic(), the error paths pass &jzchan->desc->vdesc
> to jz4780_dma_desc_free() instead of the newly allocated &desc->vdesc.
> This leaks the newly allocated descriptor and either dereferences NULL
> when jzchan->desc is NULL or frees the currently active descriptor while
> it is still in flight.  Furthermore, jz4780_dma_desc_free() derives
> jzchan from vdesc->tx.chan, which is not yet initialised before
> vchan_tx_prep() is called.
>
> Initialise desc->vdesc.tx.chan in jz4780_dma_desc_alloc() and pass
> &desc->vdesc to jz4780_dma_desc_free() in the preparation error paths.
>
> Fixes: fc878efe84c3 ("dmaengine: jz4780: fix resource leaks on error exit return")
> Closes: https://sashiko.dev/#/bug/linux-b39121ef-5ffb-401a-9d04-0afccd467bde
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>


>
> v1 => v2: Correct the Fixes: tag to fc878efe84c3
>
>  drivers/dma/dma-jz4780.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
> index ac2094e65ecf..c3974c825ba7 100644
> --- a/drivers/dma/dma-jz4780.c
> +++ b/drivers/dma/dma-jz4780.c
> @@ -248,6 +248,7 @@ jz4780_dma_desc_alloc(struct jz4780_dma_chan *jzchan, unsigned int count,
>  		return NULL;
>  	}
>
> +	desc->vdesc.tx.chan = &jzchan->vchan.chan;
>  	desc->count = count;
>  	desc->type = type;
>
> @@ -379,7 +380,7 @@ static struct dma_async_tx_descriptor *jz4780_dma_prep_slave_sg(
>  					      sg_dma_len(&sgl[i]),
>  					      direction);
>  		if (err < 0) {
> -			jz4780_dma_desc_free(&jzchan->desc->vdesc);
> +			jz4780_dma_desc_free(&desc->vdesc);
>  			return NULL;
>  		}
>
> @@ -426,7 +427,7 @@ static struct dma_async_tx_descriptor *jz4780_dma_prep_dma_cyclic(
>  		err = jz4780_dma_setup_hwdesc(jzchan, &desc->desc[i], buf_addr,
>  					      period_len, direction);
>  		if (err < 0) {
> -			jz4780_dma_desc_free(&jzchan->desc->vdesc);
> +			jz4780_dma_desc_free(&desc->vdesc);
>  			return NULL;
>  		}
>
> --
> 2.56.0.679.gc527c65306-goog
>
