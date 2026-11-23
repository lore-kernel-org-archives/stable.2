Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.68
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795455170;
	b=fHKB1+mtr5STYSrDok+71HWScFUIlAOv+6EEYuQyoRpBocJ095BrlQj1/QNawsm7+GY9
	 Lfptr/5TFTKUihf+Jd9+hcxTV6zon45spJKrEPm6bwqJr5CmgsRFkwJOm019/tC359FOy
	 TiNFECVHR2sdS4HLzxVF8i1b794GDoUknQ6uEIkNEyNM6nEtg4DZnN6YccHfsEQ7QljLM
	 AkdDbQbE/e4z0Qo6iL6XmEPx7UkddeI/9m2httNODafCp/L1M9hl4cLg0yvj3KSpNqZH2
	 XKf2agO4BhlVQelnOZUfeEcc3N9tRj/5791OeX2QUrDjKUCXIIIbK8mIqcnajrJEQDw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455170;
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
	bh=d5ErsGksVmvxRkWoIBRGzCcGV+fU+eeYlVGFHZhvQI0=;
	b=P5e+0L3prioH0Hm8DIa59wmJvqKzoYDEaXKYenBa09MDSrjKka2kvsqhkTR3GwjEWLOH
	 05NwaLmPxO/5kzS/i7h3tkjvCZtDqkuzwRwoVJ2CkBKrUBrA+kiKcBli1B8i0KlEoXVjE
	 c0eDjCkLYLDOJ7u7kRh0YzqtRqlt7LKGRql/l0lGyQZcqXmcPkRJng40gtGeCt7n7bwHW
	 O08e21fPRzcDT1+9h2o9ds9TkNlNhn/OlkJPvQQitsS1i/ct/4V/CDFwd78QLpN5ShhGY
	 mdvnJmPi/EklYK0STaOhk3AjjlaI+NlsQo3MhKC6QspYM/1uLK+tUG276cquevBTHMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=BN1bVZKm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.68
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013068.outbound.protection.outlook.com [40.107.159.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559D6606A31F;
	Mon, 23 Nov 2026 17:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 559D6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=BN1bVZKm
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihJ3xniupydGP43FiT+JVtYhAcTlIT6hLcmR74n+0sDwtmTx6RPBRoOZHnwb8Ign7u/ygXMBO1UFehUhdBQ08f5zRoM4bsRIL9m7OxsjCOUu1AgYI+sz2EcKgDR8x1UvMiToMPQ7UB5sWI0f1x3BwAEJHjp2yr+OHfSMD+rGfFMenywU7o406ET2890ilDOHqBOap958lN0C/hPLWJhZeh3Fsy02tS4OXceNVpHRwfffnLRjVnuWWoQd+NhvaqIjBHWigsW8v2/RTxTylZgpUVdzevkiQP8Zq8HYLtHFswGC4UQ3eD/M1bbwP+nZgR35MWpzEYqXYab1MKb4vHKblA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5ErsGksVmvxRkWoIBRGzCcGV+fU+eeYlVGFHZhvQI0=;
 b=X6W/e894s6sOAWl9KYMN6wL6Dx1ZODwnivmf1ff9OYIovqWv/dJcTQX4+apC3CQkFRoxGRSKL6NF1BqFWmpqbqkjPysMGAIcE6jsGTNs4tHoB2TUjI5J1hwzcxeqN40oB9Ahmgoci0acCDfl9z9NewyrpzTnZCTe6mJowIEcPSjySJG5H1umCkiRwo0hH++kPlCurTpGvqGVHssBTwm/HO0k/F9VsadmDDOXippc1zYxEoFIeHrG1JXKDduXZxlcnnw36aVes+Sl02x9NHkBbnOmRkso9HH5Xoen+5u/52xiNX1eR7SGJzzmhiSfG3QYuKOupRcj6XKjlyuSOohznw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5ErsGksVmvxRkWoIBRGzCcGV+fU+eeYlVGFHZhvQI0=;
 b=BN1bVZKmqssZCMxRBnGpGa7Ep2L1JnEV2nlupK/JsdgRZDGX2zvXM9qK2EENh1g6HyLYFv0TnbcJ+Ty3QFR8s2nJYlAppRgxlJgBW7YfJfwtL5eDG3K03qqy40n3PSMRD+rZdzSiJGSgcuWPdSllW9/YDVBGkfWntSgt8OruF/zZKZjP81Wbf2pOvUezKGl+RQSwHcIVY/+GxNsnwOPyR5la8e+AW/H3ckDH5+QBTVd2pScp5idXMS2CVGoLIZy/Bg719EkB9PuynJj5QJx7kpE1QN3hKFxYHvJB/DhAK8owjTh8cU95zrs19k++zlhPCo9BjMHFzBvy37KNeOE4Kg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by VE1PR04MB7472.eurprd04.prod.outlook.com (2603:10a6:800:1b2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 17:32:47 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 17:32:45 +0000
Date: Mon, 23 Nov 2026 11:32:36 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	dmaengine@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jerome Audu <jerome.audu@st.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dmaengine: stm32-dma3: clear flags before
 signaling transfer completion
Message-ID: <awR4tDIV-FvXG1jb@SMW015318>
References: <20261123-dma3-fixes-v2-0-0a5b013f79d2@foss.st.com>
 <20261123-dma3-fixes-v2-1-0a5b013f79d2@foss.st.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123-dma3-fixes-v2-1-0a5b013f79d2@foss.st.com>
X-ClientProxiedBy: PH7PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:510:33d::14) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|VE1PR04MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c18c319-ac03-40db-785c-08df4987c8f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|19092799006|261009223027099003|18002099003|22082099003|261028144727099003|261102123227099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|56012099006|4143699003|261026140227099003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	FFG2n9hqzJwFs5i1hjalVyPOx4mkgF62gSx64RFkkLLFfqt8REB9LSoKDZPQw9J4dEv/3CzT8tLfC7HrxDVmf1r6yvN4rUTimFHpj+2ish8tLAfbHJ6CWoNVX/6Y+WqvAvN8eNNcPvgpSA9NFz5raM2C/1jEt7g2uHdsCvW2LsVEH0v+VpDJOu/1sFiIaON+Raf/2HbxjO6QsWgqEM33+OT7KlLS3ycYgCvG4bLs9Nc1kyhypV3JCoEQ0j+tS5q0HngOHGNfLjZkMMPidfJ1RkoCXyVVpZv22GicEDfex7V/E3NFnXvArgXseGJZTwjOl4EowdcDsxx96SzJuBSKxGmkHIs55l/WKV2PcwVrjS+1aFKcFNlpqkQXnIhfxZ9h2fu6ow18GwPt4SAla/A/ePtSVbTOcdPf5ov36vc0OwJ0CeGK/AcAnGFgTwibNR0m5r1MLIvnsSlbh2VPwneZNCAuVW0CQ+kl9QpbG155einQR7C+UHZewcY+zMFhGKpzzlRwDX9lsBEs03B32ma8qlmLdYmRyJLcoA8xGdwd8TII6fu4jOaxDonnoWrXRzbMRk6xAhuRHg4JaT+JGpYTrgzsmXyvptkZDNe5gVEG2GGLNoPYPNWlGaxgI4ifQVPS694LwDRgxDWgdWgoqiBAdICdCz9P2xX5qV+MPzV1VzE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(19092799006)(261009223027099003)(18002099003)(22082099003)(261028144727099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(56012099006)(4143699003)(261026140227099003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h5AFceGOqv0UIDovL7oaUNbycrXb3tMr716Znfk2GZq/yEO6oho6uBPdan1i?=
 =?us-ascii?Q?FpyQ/242zFpGpPhcvz0l67rv0Kn0Y8cAN9V9f2EmHL2SR/f16tUhmL0PI0kI?=
 =?us-ascii?Q?7RDJA28XE3AHg3LaaGYhX+fPSRMQASU85gxkxDhOuDZn804loBj1/9QIsv+F?=
 =?us-ascii?Q?iBvfrmBB7QI934e50DkwIs9/mb3oDfLpyu/P9lXPfaMYoX2HqqZVF8kN9cIG?=
 =?us-ascii?Q?8+2vLYJ2sarRbZcEtziE6Hy9u+r4EbtlLBbK00EASWtPgmUvMMsqow+qbGBR?=
 =?us-ascii?Q?0sOuoHhlQDaOWgoaVuQ65JTjFrvh+EY6qTHJ/lHQS5Y8SZF0+NqaP/uOCoyd?=
 =?us-ascii?Q?zbx+pwWKreJ8Uvub34LFw7qeBdHjmsL7g70sAN9xikzki133UapglFBWxoIm?=
 =?us-ascii?Q?ud2PiItLq9OvqUG67zH5R48jQdsXSRTgy9CuWTiavrFWis0FqZfGex8SFSTP?=
 =?us-ascii?Q?Yv7GHahfXNqpszcHJRODSOIWhmp4zmOXuaa9xS3bG+rjsOlFRmZwJG3Lrdji?=
 =?us-ascii?Q?GR/7i3DKPjp9Sz+IU7dWUVmJdfxSJ8BgWwdSJXz0XvXZ291h6d9ZdozTQKrJ?=
 =?us-ascii?Q?zbYxWEB5qXsHjuCnS7ImAnS7FKULuMthWKeiuKYKkZ/sVS9luo9g7jgzkXty?=
 =?us-ascii?Q?jl0bDTfnOFqJZjP9nNJEQDfXx9pjdd5v0ZrwxaJuB8PSRd3kmjjZoHmy4H/Z?=
 =?us-ascii?Q?m8NOEMrf0nvi2XbIqXksA15fS2BnoT9YDyY+fEOXb9OTlNvgqkRryFoPwFSC?=
 =?us-ascii?Q?AKIdlK2CXLbM9M7NXMjcSWf1UpbX84zVAavJPVahewQ9hGQAacfTIHekzik7?=
 =?us-ascii?Q?SXRBtXWeCLcolx1Zra1sesNuKfOdLQDTniv0uaGqa0P3MuiMmkw4yc3o2jgz?=
 =?us-ascii?Q?7NVP7PXw+w+nKJ7gzcm4HW/mQfRwKRHoek0IL1ZffPP/Lbh/ZmjgB53Mv1kD?=
 =?us-ascii?Q?EbVnCZWTHNm2V4GKWUjelk63cBhTRJom3k9QfYGic+tkPq3JgansXTjsTjGA?=
 =?us-ascii?Q?Wrrwx6byQHcF5wCybJRa+BkYJ6uxIiGGpyXa9mntL0wTvcv4z3KJAeZu1a02?=
 =?us-ascii?Q?RWyKPicXZD0PgT50Cc6qxGe4kPAS73YTZFXSxEsFbCzvGOle42fcsHZT5U1V?=
 =?us-ascii?Q?4upt3uYc5OiHd+7yXONg9aVPOrXEGpF2/rdZNIrEDoZgmzHQyPoknnkz9HpR?=
 =?us-ascii?Q?3JT8YBtfZMW/UWevaSp6jWoR+kxrM1V5OaGcgw0zJE4ZG4cfIPZr7JHQjFSr?=
 =?us-ascii?Q?v60ls5M40vsp+O1uzP/cG83Kg8/qG4zMvoStDfJ0QbII0Gel5jkO9VfveqWv?=
 =?us-ascii?Q?yjdUMvcAH46xWA3O59hH16ib4So4hPX7J4Xo/X1ea+0SeN4uzh8SrVpNvGus?=
 =?us-ascii?Q?2E4WYs/JjwaAOzd9vaeEdpVI9LW31NiZZGE9YNOsUj1hOe4Psjb0ltGSkpp/?=
 =?us-ascii?Q?hzUpiHAPxOK/OkWDLvivexVXh7lSLRp5VT74bYE4RWe4oOewQeqMcTbk22wD?=
 =?us-ascii?Q?kLia6skFXK6KzRSlERuhZRSTGYUgGbbQ2mrYTn2wpqF4BlKCZnu3G7wnVOu6?=
 =?us-ascii?Q?5nIkHbgumoRkiivhClAz5kGJXuMeOfcpcUzGV1uK1xwBb6IlZ6h2oe19UZzO?=
 =?us-ascii?Q?yd1ETBEllzc90tQAnqu/0XucULbEwPmyfzpDpfr0+PpTAhtYaBN2xI79tcX8?=
 =?us-ascii?Q?mRQud/QEpJswyy+VQJZd139y9k0QS8IgLPa2vlbFXskt0GHk/bUB8UzE13zR?=
 =?us-ascii?Q?FvVuhF6Fl2HZQDyEQaiClqZKI8hsSWhoBYb8xDraH/4qbhR2U5Tm?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c18c319-ac03-40db-785c-08df4987c8f5
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 17:32:45.2804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SHltpWfABwqqwphXwu/um3Y2x3HC/XykqM6DqgCBtjEl93uPTpA17g63Fq0Akhg/8l5hokujEQsKBcNpKxN4QaULy/f7P/bkGb7DKl9KyR/i6/TKLIeOV5YCLvmNDiud
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7472

On Mon, Nov 23, 2026 at 10:17:05AM +0100, Amelie Delaunay wrote:
> From: Jerome Audu <jerome.audu@st.com>
>
> The interrupt handler clears channel flags after handling the captured
> status. However, stm32_dma3_chan_complete() can start another transfer.
> If that transfer completes before the flags are cleared, its Transfer
> Complete flag is cleared without handling its completion, potentially
> causing a timeout.
>
> Clear the captured interrupt flags immediately after reading the channel
> status and interrupt enables, before handling the events. This prevents
> the handler from clearing a completion flag raised by a newly started
> transfer.
>
> Fixes: f561ec8b2b33 ("dmaengine: Add STM32 DMA3 support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jerome Audu <jerome.audu@st.com>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> ---
> Changes in v2:
> - Commit message rephrased according to Frank Li's review
> ---
>  drivers/dma/stm32/stm32-dma3.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
> index 4fe226541efa..a464e0cefd64 100644
> --- a/drivers/dma/stm32/stm32-dma3.c
> +++ b/drivers/dma/stm32/stm32-dma3.c
> @@ -1008,7 +1008,7 @@ static irqreturn_t stm32_dma3_chan_irq(int irq, void *devid)
>  {
>  	struct stm32_dma3_chan *chan = devid;
>  	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
> -	u32 misr, csr, ccr;
> +	u32 misr, csr, ccr, cfcr;
>
>  	spin_lock(&chan->vchan.lock);
>
> @@ -1021,6 +1021,14 @@ static irqreturn_t stm32_dma3_chan_irq(int irq, void *devid)
>  	csr = readl_relaxed(ddata->base + STM32_DMA3_CSR(chan->id));
>  	ccr = readl_relaxed(ddata->base + STM32_DMA3_CCR(chan->id)) & CCR_ALLIE;
>
> +	/*
> +	 * Half Transfer Interrupt may be disabled but Half Transfer Flag can be set,
> +	 * ensure HTF flag to be cleared, with other flags.
> +	 */
> +	cfcr = csr & (ccr | CCR_HTIE);
> +	if (cfcr)
> +		writel_relaxed(cfcr, ddata->base + STM32_DMA3_CFCR(chan->id));
> +
>  	if (csr & CSR_TCF && ccr & CCR_TCIE) {
>  		if (chan->swdesc->cyclic)
>  			vchan_cyclic_callback(&chan->swdesc->vdesc);
> @@ -1050,15 +1058,6 @@ static irqreturn_t stm32_dma3_chan_irq(int irq, void *devid)
>  		stm32_dma3_chan_reset(chan);
>  	}
>
> -	/*
> -	 * Half Transfer Interrupt may be disabled but Half Transfer Flag can be set,
> -	 * ensure HTF flag to be cleared, with other flags.
> -	 */
> -	csr &= (ccr | CCR_HTIE);
> -
> -	if (csr)
> -		writel_relaxed(csr, ddata->base + STM32_DMA3_CFCR(chan->id));
> -
>  	spin_unlock(&chan->vchan.lock);
>
>  	return IRQ_HANDLED;
>
> --
> 2.43.0
>
