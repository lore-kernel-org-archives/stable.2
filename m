Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793205141;
	b=F/kNA20wjvasn7S8s0cgaAgokE8LbCz7Rk+B6ZmdVxBJWbJsiGsCMlksEPSm+Y1j3o3U
	 fZfhU1RpHVK4zG4+t4LH+h2NaLsjiU0oSZ0f99MQlIIpkeZtGay/IWMT4pv8QI8IpdkjA
	 K5tM98pWw1ns4B+0S/wQiYRUrIjekd8K6pHHzngaQLLKHHQFwl8B8OxkxCnVwqxvz9ETq
	 R64WA9nHQTEyhyJWmfX3T5l62R3mvyJLM05adIanOPtJcD1gTLgNwh3CSykj1XZaSTKd0
	 e/Ja7oiLZapciGYtY5otw5m98wHPSaF3K3xyKav+W+AweCG05Gna3QPH0vAeqsyCqaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205141;
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
	bh=LbcPgy9yjePUBLpMmfyMq1CmC6u4XUSZ2g1183V9m3w=;
	b=Z7/16mNTjelmuO4Ccn2WdKpM+VfN6OT6rc/jw5yGifN8SRe7JbJawiNV79xjG+piD5Wm
	 uM97kAC9K3bONeUD2o3jiGmuYHr4AeIuXGuFF9yKd7lesMHH1M2k5DBFM7h4tD7TzRosL
	 03h/0pTVP0rFA/d86Lh7VCiHW5Ri8kCJPrl48/0cEyTh/SEs2iQdPGWwlph23jl2E4dvG
	 JLpAIJHcsPvsWuxxjqYVianR4mVQxeh6SF6aCunkspPXao/zlZByN0pwsdtKzeUMt0pil
	 H+mt2O0gW1pCVBar4PwbIUa1K+cuwMobfLdKNWehhf3apBXfxmINUvuxwx8iqDmAcsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=fm6lIYEK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.56
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013056.outbound.protection.outlook.com [52.101.83.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD00606A31D;
	Wed, 28 Oct 2026 16:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBD00606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=fm6lIYEK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4cyr1ZgcRS38rm26b7NShAlOWJgQABDFLivkhZSdq3o48dcwLUy6bMaIEfjK1BjJ54m8elqi4fQvqkJB2cjX4sEi7xxDcSkFJ8rNbx/DFHSEBhnIGUJv+juSA07Gmtp0AStb5h5udfgvP5qPl5fN/2YYPK1+lwmuEK8YNYk7uG8kkhGAA/nef4WSlUew+eYmtGkDkiy4jWc1w/027MIQu3ICY+xdcZHkaEDGBzA8SDnvtcw+bhINF8maEHaZnCjFlZ4UuG++xZwk04OyNgWQskgOyFCQK6cez4hTjnL/BU1NkTwLjhsWwZg9T/g6AXGAKOLv7O+eA2oSEEsgCFI5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LbcPgy9yjePUBLpMmfyMq1CmC6u4XUSZ2g1183V9m3w=;
 b=Kcx1kNuL5iy1CSkqXdcCOkeh2uuCSXKvSKfx5OthdfznXTCIaq93DwDlO3WFsvSHCD650fzpI/kirxhoEfnXPgcoDgguHfd7Uw3vsEJqZKXrjo3GrBen6neKbHJE9Aoc2CkzdIz2v8pY7ppHXJUUd/Yp4ffknCSMfybZXbvrPiR7RbQOWIkPM+ZGMTpoghh1OBbMjC+BFpmc7WPJQbLWWwLke6ssniLIiTZvucjrlWsM+omFcfAL6/nueH5nbtrA/AEhnwXkLGmfknztUSlQtZkCK0WGZiCGnYEANR7gc2eAPB9jm9gTYcnFDnBj4lB7oTQQ0tqw1QT0nR0YyDCIIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbcPgy9yjePUBLpMmfyMq1CmC6u4XUSZ2g1183V9m3w=;
 b=fm6lIYEKuQDuQPV8UbyPuFsVqYvRAtwhoJw+1iACsUQAg7eTlU+ccP1vT+KyaZWqEN9RsqSKURo26Je0b/lQfc9LmQDl9v9lm/NiNvFpS1gSHAkkUfJi1NC3xznZECGdLWUNNC4fmOV2nR2j6alKe4WCF2heqqUvsyq3WxJ3YT0hZ5o+9YAW4m9WyFYuHkqueRI3ixC1GsBNpF7yYCwNnJnTJpXQrV33w0VOCHBGIBVnIZkCthlp69Q9+rPqkDjiwMx+F1zZ0sguADPsDShVV0XLsBAjSzfJ9Tjn5sKGSiKxmdQkxv7+0MQRL53EMX4j/QJc/6z9NgZdzckn9MWiAQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by VI0PR04MB238080.eurprd04.prod.outlook.com (2603:10a6:800:365::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 16:32:17 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 16:32:17 +0000
Date: Wed, 28 Oct 2026 12:32:06 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Maciej Sosnowski <maciej.sosnowski@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Haavard Skinnemoen <haavard.skinnemoen@atmel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, stable@vger.kernel.org
Subject: Re: [PATCH v3 4/4] dmaengine: dw: synchronize completion callbacks
Message-ID: <auIjhrsxsP6KHaEE@lizhi-Precision-Tower-5810>
References: <20261023-submit-dw-dma-synchronize-v1-v3-0-c62bf048f5ce@gmail.com>
 <20261023-submit-dw-dma-synchronize-v1-v3-4-c62bf048f5ce@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023-submit-dw-dma-synchronize-v1-v3-4-c62bf048f5ce@gmail.com>
X-ClientProxiedBy: SJ0PR05CA0102.namprd05.prod.outlook.com
 (2603:10b6:a03:334::17) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|VI0PR04MB238080:EE_
X-MS-Office365-Filtering-Correlation-Id: fe09e265-6170-4227-7e7d-08df351107b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|23010399003|261026121527099003|5023799004|11063799006|4143699003|56012099006|261021121427099003|261022075727099003|261022105027099003|261009223027099003|10067099003|22082099003|18002099003|6133799003|261028144727099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	fEUJJb6lRd7di6GXMB+a5eEx3TsRpb0+cocijJy6AbME49htgvk3MG1cpTLtW08ERehUz6OPChgqpbTeQz18nJPygb0MxmDqD1j7CpDGKCVRtUXdufh86BqjH1iYEgb/UTIR0skSfDGh/VrS6SsHgdAP4dqkLpAslrOC1q8y7ruH+dd3Z0D/D+k9RgoSX23iD/UH5PC7kuaSAEWfizflh9aqR1TupxZ0ntgVrKshgvoIgdgMC2nqYxhQALCvb+GkLDUKvwVRTGTSKLOkvNsuy0H70ymBd5evnaLT/mwflPyYP5knkjldJU0pYA2WAHI4TzW6C5DRqToh6tyC89Il37i5rL2ayEAgKv14dEX7kUIzOsiC45aSoNAsEBrYGWoHnvLvvjW+x4oIo8g6RKLB0sgXqPZ3j2bptQcFa8iPv0FjlfGuHhL/HjmOrG4C9oOqsH0WZBqHXUfEcvxXaw1U7LnsuldeMUlbFgiMIHQISbw3ovdsj6rZ3z0ltCDl2GnKzTYMnXRZGlI7pG8xpeFHpXSwvS0sLBDZ6JdSaZ+qNBye5AKOP9yRluDi8+rlYqEkcRZ+HvR/iQk1bFRaK9wj/0Ct1Uv+9+AkBuweaRw0IH6T49YpiHHy87xJqQiDq3ZB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(23010399003)(261026121527099003)(5023799004)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(261028144727099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/autIoupveRaybiyf5lE85PXqt3/32deg3gummMNHSKWvivmv9HAt8IUdf//?=
 =?us-ascii?Q?gWowjclJfdYBCK0JDU1UBwhr6/ieu3dp+di0qJuZJXXMCDzQGlcrAR64EKBA?=
 =?us-ascii?Q?21VFaQYmjyr6ruSkDqKmMT8bZWO2ExI5t8x3ebBwlQ1iRGao25yueyfSa5P0?=
 =?us-ascii?Q?8aMwKEMBlV+wXrjgerKHkRT94Omj/+xg5ZP3/bdr2VH9tq3RY1Y0mGCP88iU?=
 =?us-ascii?Q?OJ75HJWG9HMGCanC3oD8cM1yqKBVntZhlUcS09Lj8XXYYxEM7NI0+rBqO8Bg?=
 =?us-ascii?Q?yWBQfN6xQNTtzNxCDSkZTboqpnKuux/3SCbOB9vH1tRirNDgf0YN4ntHXpXB?=
 =?us-ascii?Q?EDgQq+MVh6qI/c9kR8uoVW5hDcUA66eA9doXqPltTtDAoUlawwLzt64bM9C2?=
 =?us-ascii?Q?uDrtnBf9uFx6o+QJQbfl7RXzaFaOpqDTRsLl5cr2RdkKOolimGRX4JRlrRoc?=
 =?us-ascii?Q?1zc/W7oQgEvMvhcyFaKcjU6SFGIwD95jChRSXT2mvT7mUXYUkTNMUgmji7pu?=
 =?us-ascii?Q?uPKtmao2ZvtZhOY/6WeOpccEz1vNCep9WvHhtdNtJfNXs+UDrM2yT9qKyKkM?=
 =?us-ascii?Q?V72xlVe7st/dIJzqqSC6QfEuyn0WhK+4LksoBsIyIG5QZ9is5F31T7d0r4PE?=
 =?us-ascii?Q?7odWJvnL5O6iAQHC6Z8ejhTC0MGtTaUf1qRBlaewgszKno9drcLH3GvDJtwi?=
 =?us-ascii?Q?ESIvIFYcVDipAcsrANfvMcwUr0r1sUskKWeO324S6oEkJSx1lWL4EsW3LMPf?=
 =?us-ascii?Q?V2rc5Md2AkXOV3w7gKVxIepOyo/MF0PyprXwYjETEklDKIND8g3xWCvBS4Ma?=
 =?us-ascii?Q?G6ETbgjK8eZxkaSMDpxCijQ1MgBxo1i9SqiZMMyznEGnYQJcdOS0mAwrdjxI?=
 =?us-ascii?Q?pZZYGZv5VxEYrAJtld6wWRmRawnJyguiEPY4E1dYx2bqBhckw5/23s1k46hL?=
 =?us-ascii?Q?+Vtz6wjJyztx/ctMUb6mRIZwFwRcKs3cqR2mE6rxJQ2wwElIBbe032B/2DVD?=
 =?us-ascii?Q?c65IuLcbFpyyXAbdYf8J/VgVR7cEyyXNRxFXMTVVJGf/PL4uSJtToxyMSz5n?=
 =?us-ascii?Q?UbzFGNovz5AxBkkdHHJg94ZCey88tYlr7sNpY4HD63a+AxRzJVmop1Lq2Nij?=
 =?us-ascii?Q?WGwdHQK48/VCxpwFtFoT8gVL8WbaWcAWo64mLGZu234/3E/9bKZuEtWrbk11?=
 =?us-ascii?Q?xNndB65M1KkflWKGkTWDT7szmrhsXadjCGHu5t1qfw2SPTacg9vO5wCg+UM0?=
 =?us-ascii?Q?eTv3zNbpSsIoqdu3BywE74HWRZLWTJfjKf3EgdoqUpjIoAVE/w0qDuugaej+?=
 =?us-ascii?Q?Q7frfdJVRdgjbL7iVJViTR65IocDaCAzrlbX6RA4oWNyKEd6X0if0GcrBB+X?=
 =?us-ascii?Q?YVA0iYLECkt11ydm0rsGJRfqkaCRQSv3rGeS4DeCYPUaUrgGUX91JgVyb22O?=
 =?us-ascii?Q?FfIKtYvUIVa76RKFDkkN5nhHeURGV1sBzVctO07i5I3wviehFn6pvGQToNS7?=
 =?us-ascii?Q?BpFs7RlvaIk3/ZdAS6YGYXzeGtlUtDc8ny34OvQdjcwS/B/8W5Ho9DhgFrvm?=
 =?us-ascii?Q?8SWAt3iIgqtiq/HifDqWJRvLgOnHvP1w84XH4G1hFvtGZ0x4+oRkgwSfcfsR?=
 =?us-ascii?Q?7EXLb0f4OeLtltnXjb9YdfvHKmoEwPsUNxLxkbzw+EbMeAQb7WqMxEpRR+nu?=
 =?us-ascii?Q?jhX9AvVj/RM85EMy+gB82IFIxNSkltJzvyJWFvvX2EJURFrYoOvPdncayf2s?=
 =?us-ascii?Q?oc++3Rn4+Mjxz8rTJfYItHRV3z5BhaqQUGh1dQdisdG8bwAXnED4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe09e265-6170-4227-7e7d-08df351107b0
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 16:32:17.0898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s5Y9iMBsr5OOaAr5N3PctFdmDkXuVYyIwqOU+oZDiD5wA9djsK+cT4DqUyDh+NR3ynhj1p26PbJ7eBmd7VF2MkgxezOx0xHB35vJ29GOSES7N7kZLldz/Lk3efURl8lZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB238080

On Fri, Oct 23, 2026 at 10:27:25AM -0600, James Hilliard wrote:
> The controller tasklet can detach completed descriptors and invoke their
> callbacks outside the channel lock. Terminating the channel does not wait
> for those callbacks, and there is no device_synchronize hook. A client can
> therefore reuse callback state or release its buffers after
> dmaengine_synchronize() while an old callback still uses them.
>
> Disable and re-enable the controller tasklet from device_synchronize,
> outside the channel lock. Disabling waits for an executing tasklet,
> including descriptors it already removed from the channel lists. After
> termination, a later tasklet run cannot acquire another descriptor from
> the terminated channel. Clients must continue to exclude new submissions
> on that channel until synchronization finishes.
>
> The tasklet is shared, so other channels may schedule it while this wait
> is in progress. Preserve those pending runs: tasklet_kill() temporarily
> owns the scheduling bit and can consume a concurrent scheduling request,
> leaving controller interrupts masked. The disable/enable pair leaves the
> scheduling bit and pending tasklet queue intact. Other channels' hardware
> transfers continue, though their callbacks may be briefly deferred.
>
> Fixes: b36f09c3c441 ("dmaengine: Add transfer termination synchronization support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/sashiko-outbox-180707@kernel.org
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dw/core.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index 6d27af3c0f2d..d80be93f0c49 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -910,6 +910,19 @@ static int dwc_terminate_all(struct dma_chan *chan)
>  	return 0;
>  }
>
> +static void dwc_synchronize(struct dma_chan *chan)
> +{
> +	struct dw_dma *dw = to_dw_dma(chan->device);
> +
> +	/*
> +	 * Termination removes the channel's descriptors from the lists, but a
> +	 * running tasklet may still own a completed descriptor and its callback.
> +	 * Wait for that run without losing schedules from the other channels.
> +	 */
> +	tasklet_disable(&dw->tasklet);
> +	tasklet_enable(&dw->tasklet);
> +}
> +
>  static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
>  {
>  	struct dw_desc *desc;
> @@ -1318,6 +1331,7 @@ int do_dma_probe(struct dw_dma_chip *chip)
>  	dw->dma.device_pause = dwc_pause;
>  	dw->dma.device_resume = dwc_resume;
>  	dw->dma.device_terminate_all = dwc_terminate_all;
> +	dw->dma.device_synchronize = dwc_synchronize;
>
>  	dw->dma.device_tx_status = dwc_tx_status;
>  	dw->dma.device_issue_pending = dwc_issue_pending;
>
> --
> 2.53.0
>
