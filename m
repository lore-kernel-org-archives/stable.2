Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795022443;
	b=3IKLhtql676Ive5emYb88suAuz3DMuXsMMWvxGUaK8vSZLxiLqtU3sDVmqsm2jCPHapo
	 2pwOqxTUMmZTef/Oa0QDV7Z4Lflr28uqcyAz8ds6IacumKqO0iRU08M896XbxIqh6dHoQ
	 MZEyasTkdpu8byjJPO3CvOnl5iH1SiWUvHyIiFHGAML1+ApwbBMeEFQmCPb4g6SC21CVn
	 J7pE6+BAcsRfsn2i2SDqSpZTHmctjPxMnZC0eAX7AxwIq9ZfnVxcvm9nH2+IWUVP6LxdC
	 hbEtxxSd5s/1RNPuAOHmRl41TGMUfUCUDnpSESAy3fqdsqETjCMTWxuuT6B2NtuLEfQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022443;
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
	bh=XMxT40yig6VoMIdGl8c3p/xXnTlOl5pevtAgNc70YRc=;
	b=TUGo09/AL/FgPs70QJ15sE8xP94aMx1iu89gg3cAKkoRBmBX0jKDUh2FOT9gb+8lfbLb
	 ZxvkvkZ18Js0tlNsOxpiLqfgDssHXjVqFqXl1azft91ypatDnUySlgFF9/cO99ZjQJi4o
	 F1OciIP5bxdw0A2bVHzqLF9VIAfRe1kMRRHoguc3SXysPR1Bl+vxlD3WceILkShHwiVEQ
	 CiKUvnvmHMjizbaz5AAaO/TIczFvkznsIAyXKq82nivRhl21CGRyYINi0pYC3yHXRi1Mt
	 imPtWqjb3Blo8QqhPjdQ1bTADKrPOlG9jQSa0OKbIwBXAa0PjGuFikrWaei1lS9eWOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=qn8NXxPS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.8
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010008.outbound.protection.outlook.com [52.101.84.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A6E606A331;
	Wed, 18 Nov 2026 17:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9A6E606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=qn8NXxPS
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NndIfaFt/sW/c/6AN/ON2UA9iNja4mGdoGnuuODUkOIXtR00V/uHNmXinihMEFtAPJicw0jwCSZw3pIw2JQgZqQC317Mj8By1xLUDrr3xofNjM3d+pf7M9KngiS7cVYoLdGuMC1+9nBL710RixFLP/bgraPsY5AsKuj4Ek4Q7EZ1NRooOoCC+PK1y4QPsc9FyY7YmZml/RPkOxbIESC7711E7sQWUCpFmp6Abd5wKexH9VSbKtOOMPGCfrY6xF7vUE7KpM1UwRQxPxD0VC0bU6u3+aGSbY4c5HfWVOxVNijoW5nm74v/w1eB+xYaoFuc1qfOqgmm+YTbxhhHquTpyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMxT40yig6VoMIdGl8c3p/xXnTlOl5pevtAgNc70YRc=;
 b=oqBCF6hb6qweLHe1Q91Mir7xJo+SwPM/wHe1atqLHA/nGkjWukbF3riDXBFawXqEGYs6VTDIwBzld0XzsgJ/HUsIIpd1BD+2f7USt8CXx6dRvksvQqdxLHM7agSsNNA4LX4D7PzFWt4i94vKWpok/mCNO5k4GBbAPC00aYuZMbqfGyPbWUG0N4iBVFZvL+L+ZQ0MoqokMv2WoGgwLMhAzBpg5fNnJPjZE98O6QwM+B9ghHQOvzC+nnNciXtD0+xnsaMTubYSy2ukoAgCGpfO27SYZeLZYG0kOFfGA/hVGfkVtHCkVWEgBLR6RHMULJi4bn17nA/z0liB+fHfOEdLPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMxT40yig6VoMIdGl8c3p/xXnTlOl5pevtAgNc70YRc=;
 b=qn8NXxPSxIOd2zEvd+iTicMy8VlVrQvyHLoVMM49WbsrogeerlaHbEduqjrVvnDX5Xw1oJP+f/dZIatzVdy3eS4wnXy8hnOqmclenATQrs24yPC4wGIEbjcuw15a9t7EywkZuwuj4cA5eyqxmTY9MCqo5mQL4nQvKtFF5OMwktKyYkT5Re2jdNHYfwYvNVxRQXXZyIOGB8tcwSNvGHWq2bdhactat7abzBfeNYqSaIX+HtCuQlGlig2RVBD2eSTouE/F55MgzFpHDz6AFhTLem1QkHx70kS+RUqmmQTI9hUH/GOzn91g1knEIuF4kRZ+SI1L0l8ruASp4cEhl/8Lzw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DB9PR04MB9284.eurprd04.prod.outlook.com (2603:10a6:10:36c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 17:20:32 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 17:20:32 +0000
Date: Wed, 18 Nov 2026 11:20:23 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Sergey Khimich <serghox@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sia Jee Heng <jee.heng.sia@intel.com>,
	Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v7 1/8] dmaengine: dw-axi-dmac: keep cyclic mode in the
 descriptor
Message-ID: <av3eV2pXR5ZqYQQC@SMW015318>
References: <20261117-submit-dw-axi-dma-stop-pause-v1-v7-0-d5f2309afd72@gmail.com>
 <20261117-submit-dw-axi-dma-stop-pause-v1-v7-1-d5f2309afd72@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117-submit-dw-axi-dma-stop-pause-v1-v7-1-d5f2309afd72@gmail.com>
X-ClientProxiedBy: PH8PR15CA0012.namprd15.prod.outlook.com
 (2603:10b6:510:2d2::18) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DB9PR04MB9284:EE_
X-MS-Office365-Filtering-Correlation-Id: dd4ca633-a6f7-4327-f2c9-08df45984029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|366016|7416014|1800799024|376014|18002099003|22082099003|11063799006|4143699003|5023799004|56012099006|261028144727099003|261102123227099003|261021121427099003|261021123027099003|261026140227099003|261022105027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	muHqE5woUEYspTyjWh7zEzNpN11p2UeIhOF/Hl5O5qXN9DBIoFEIZ2YYKNHKRZ9P4obnywSlOyQgFCJKsB/Ue8ORSGcA8MqE4ie1z/2eEzofz2KzHdCWbo9n65u0G1Eh5hfKpcxYztAms8RA/gz/K2yrErKTYSDULktTjk7n3yfTlpAoX66HDEeRdDJFCxEfLPtoaZ1wnkntjFRlPw8HCzvMMtmxFzTfHdcLPswsN8k405gmFNugLpoiH8Qw9HyXktjjUk3TWMiO0MeMhkcY2E7yxbffns3pMRvR4LZEaQrbmqbXpI91Nmb9WghGaIyno73yfwJZomjgpFBkfPnymV71ZTL3D7sNtDovv1OvN9cUgO8KEFu0Op0dGhR14MeU80dwiU67Jn1jIvdGPQHO4UIgQAZkEhFQT0PEsCVx8cngjkCWPYPFPC8ZpUqEIZuAgcJ1TQXm1RNsiswRtGOtQOeb0BoVh058yByRMBM0Raojf80YnhmW138N0Irqo9IrJtkeHkO3U/JDu9sxfKQ6pu/lX1D/Kc++VHIK9N/aPdu2SThv22wAfHDWUO6XnHaw1SB4XS8iao6QPzWG1bnJRo98p1wwvIHDsOj7WwCvRaibIPZW5ffjwEETaiaK9B7F
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(366016)(7416014)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(4143699003)(5023799004)(56012099006)(261028144727099003)(261102123227099003)(261021121427099003)(261021123027099003)(261026140227099003)(261022105027099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+bHFDowcL2TbJ/tGYVYhXo+a0nneNACoWfwoS9t6OSolW+7sFWIgC6XeuPaO?=
 =?us-ascii?Q?Pwba3xeTU7+KhBRihOtx3f+NowrQM7LDp2VDbtLWcy6BpRkAP9D6m7cBzM/u?=
 =?us-ascii?Q?r4nS0wONfqKE48Uu5ifWTNVjdLQw/j9hzCDqXSKZQIYReJ524l2vRVXXOmk9?=
 =?us-ascii?Q?BT6EMFDZ/knqz3wkO1cf0ps9IFFCniayq9K3nsE/nqZD7LOYnzaav+8qEVyk?=
 =?us-ascii?Q?ZjQAkvKvRh3yHirCUD80dBV66G7V0ShHr2p9PgCYYG3KlO1cDEXHoCpqjuBc?=
 =?us-ascii?Q?BbeSJ0gsPUD9cjW7hdZLdacqiBgqnZW2AwlxriYthx3/0f8U5n6c418SuOAU?=
 =?us-ascii?Q?8qFc+ZCM2HhUEHmFpe+XK7gra1R4sxlEj8/N+0Z2CMNoFvjsAUiWCSYtwdIS?=
 =?us-ascii?Q?nJjSk++bI+Iy9xBd2P3L7RhBAfkuyR8Q8op+p8o+K2N8uheN5Fi7s6XwDG/h?=
 =?us-ascii?Q?1HIsR3eFZ9qEktK4YnEKVzKU+vVXV+S0rDeYl3FadgkJTsqmvNnSuS7oQSfy?=
 =?us-ascii?Q?yHd/af3kEPmHeWaEucCfQMzD6+gtcAvonturePVFlhOK/f2xsKBnMN5KwiwG?=
 =?us-ascii?Q?l/o4s0TVRimsXR+ZS9R4XSxIzsiMFQ9sxyuo8k4hdT+qTwXhQIFxwCIkmF7C?=
 =?us-ascii?Q?YZZULHK7AmSAi591j2vQJ8Qf9bKqoLjdZg1bNRJ/qQkUr9H0YUPcg2JRkAfQ?=
 =?us-ascii?Q?ypQ+7kOI6oM88/ysLqVoRUDq7y/NPBhOtAfmEM1nAJ3hxO9kMAGyK8vc0FSE?=
 =?us-ascii?Q?Jt2w87FXHN119+mkkoJTIe/5WCGtWUogYAYyTpuAwoWvKRnV6gP54gfyEBkq?=
 =?us-ascii?Q?QSamnF12XY1gxwyvBeQFpp+hb4M6Y/JpjyJsy9nk8okJyx1bmumgLrmQ2Me5?=
 =?us-ascii?Q?HsIHvUpGjcDc9f9Sy+ufM9fSjABMz/KG402Svh7n6F2mvrECAf13vqt1S9SO?=
 =?us-ascii?Q?WN1FaJN9kQLyEYiBFJhrLoaZ3PcTw6KoNgOpTEK31lRXhzlL4WbszswkGHlQ?=
 =?us-ascii?Q?nA682A5uJ+kC2KV9QxbwpZMWv/JWO120VAreJizihjixiK41CoDQb+tLvTgg?=
 =?us-ascii?Q?lUie+9RUZxGaUeF4w6bkhNmVLSfzsxtAiQrbwEjj+zvOBb9jVHd783fcdQnE?=
 =?us-ascii?Q?BoSH7ImiXNQkaoZtTBY1sxekeP4ZWui+KLqnoigwmghWUE7k4gKpR5sFofxZ?=
 =?us-ascii?Q?lHLpBZrzxN1sgROqobWNSWtlsNWafWvjJVd6xbCdRRlAoGfx/JqDGX7/jZfg?=
 =?us-ascii?Q?kbyq164ulY3jKUHkF4g77QchF/wCtAriVmucWf5OCqRCPNGKSyfhR9JUjnUL?=
 =?us-ascii?Q?e8FQctuQW0OAcLTfnAzpH7umIQ+Aa0zkTr6mSi67FZ7fEoeNbOTSQS6Til86?=
 =?us-ascii?Q?Wj5gM8BDNj0sLoPXoFuz8ra8T8G8uM0oTMSwtCjLpPjLIoMRCZymgM7XX2iK?=
 =?us-ascii?Q?KU4CTUaH5Vo9by+12rZ+ii/qsnVjO02PViGaf6hYcGHJftSwgaRv0xn56gCZ?=
 =?us-ascii?Q?UKPGfhJ0IYQ6C3CJ6mYxuZPuSI6F+pX5gRph2VfaKhYQQR5F99jlivZZF1Tl?=
 =?us-ascii?Q?ztEtY/He5wHflDUjdXMoIbC8wvcujVwCtXOSzCotnIQ9UALYvJD+nhdspoEc?=
 =?us-ascii?Q?RwU1X52ph7U3HikYdywaL6uHkrIoSgmKeUJIPXZlMufCtRT0wVY2n8DZowS3?=
 =?us-ascii?Q?phXTeQXWQyAWuFpQ+OudRElRMHDCUje0TpN/x53sZn3e9hVNN1TLO4JWPI1g?=
 =?us-ascii?Q?zW2ZTByKiwVMNlf+EfDupjMRxy/HHLcTLiBNao8oRLORF91H26Jz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd4ca633-a6f7-4327-f2c9-08df45984029
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 17:20:32.5841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZByPgxBLim7Tl476b8Ca6hVrSSkgSqarq0/4g2ja3W6DxQiUcoykf64VaswNjde8Ftwf0TeCOy1ZI95JTILJGqlgItFNsI5JuEfzbUkX7w7PtjTSBZBgor5DlF0a3/D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9284

On Tue, Nov 17, 2026 at 05:07:40PM -0700, James Hilliard wrote:
> dw_axi_dma_chan_prep_cyclic() sets chan->cyclic before allocating all the
> hardware descriptors and leaves it set when preparation fails. The flag
> also survives cyclic transfer errors and channel resource release. A
> subsequent noncyclic transfer then takes the cyclic completion path,
> leaving its cookie incomplete and its descriptor on the issued list.
> Its zero period_len can also cause a division by zero.
>
> Resetting the flag on failure or channel allocation is not sufficient:
> preparing cyclic work while an ordinary transfer is active changes how
> that transfer's completion interrupt is handled.
>
> Store the mode in each descriptor and use the completed descriptor's
> mode in the interrupt handler. Cyclic preparation sets only its own
> descriptor's flag, while the zero-initialized noncyclic descriptors keep
> it clear. Error recovery and channel reuse then use the next descriptor's
> mode without relying on channel-wide cleanup.
>
> Fixes: 1deb96c0fa58 ("dmaegine: dw-axi-dmac: Support device_prep_dma_cyclic()")
> Closes: https://lore.kernel.org/r/sashiko-outbox-208213@kernel.org/
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 35 ++++++++++++--------------
>  drivers/dma/dw-axi-dmac/dw-axi-dmac.h          |  2 +-
>  2 files changed, 17 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index 7520c78f55cc..6dae63024721 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -801,7 +801,7 @@ dw_axi_dma_chan_prep_cyclic(struct dma_chan *dchan, dma_addr_t dma_addr,
>
>  	chan->direction = direction;
>  	desc->chan = chan;
> -	chan->cyclic = true;
> +	desc->cyclic = true;
>  	desc->length = 0;
>  	desc->period_len = period_len;
>
> @@ -1117,25 +1117,23 @@ static void axi_chan_block_xfer_complete(struct axi_dma_chan *chan)
>  		goto out;
>  	}
>
> -	if (chan->cyclic) {
> -		desc = vd_to_axi_desc(vd);
> -		if (desc) {
> -			llp = lo_hi_readq(chan->chan_regs + CH_LLP);
> -			for (i = 0; i < count; i++) {
> -				hw_desc = &desc->hw_desc[i];
> -				if (hw_desc->llp == llp) {
> -					axi_chan_irq_clear(chan, hw_desc->lli->status_lo);
> -					hw_desc->lli->ctl_hi |= cpu_to_le32(CH_CTL_H_LLI_VALID);
> -					desc->completed_blocks = i;
> -
> -					if (((hw_desc->len * (i + 1)) % desc->period_len) == 0)
> -						vchan_cyclic_callback(vd);
> -					break;
> -				}
> +	desc = vd_to_axi_desc(vd);
> +	if (desc->cyclic) {
> +		llp = lo_hi_readq(chan->chan_regs + CH_LLP);
> +		for (i = 0; i < count; i++) {
> +			hw_desc = &desc->hw_desc[i];
> +			if (hw_desc->llp == llp) {
> +				axi_chan_irq_clear(chan, hw_desc->lli->status_lo);
> +				hw_desc->lli->ctl_hi |= cpu_to_le32(CH_CTL_H_LLI_VALID);
> +				desc->completed_blocks = i;
> +
> +				if (((hw_desc->len * (i + 1)) % desc->period_len) == 0)
> +					vchan_cyclic_callback(vd);
> +				break;
>  			}
> -
> -			axi_chan_enable(chan);
>  		}
> +
> +		axi_chan_enable(chan);
>  	} else {
>  		/* Remove the completed descriptor from issued list before completing */
>  		list_del(&vd->node);
> @@ -1204,7 +1202,6 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
>
>  	vchan_get_all_descriptors(&chan->vc, &head);
>
> -	chan->cyclic = false;
>  	spin_unlock_irqrestore(&chan->vc.lock, flags);
>
>  	vchan_dma_desc_free_list(&chan->vc, &head);
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> index d8dd07efe60f..3c86e5d468ea 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> @@ -50,7 +50,6 @@ struct axi_dma_chan {
>  	struct axi_dma_desc		*desc;
>  	struct dma_slave_config		config;
>  	enum dma_transfer_direction	direction;
> -	bool				cyclic;
>  	/* these other elements are all protected by vc.lock */
>  	bool				is_paused;
>  };
> @@ -105,6 +104,7 @@ struct axi_dma_desc {
>  	u32				length;
>  	u32				period_len;
>  	u32				nr_hw_descs;
> +	bool				cyclic;
>  };
>
>  struct axi_dma_chan_config {
>
> --
> 2.53.0
>
