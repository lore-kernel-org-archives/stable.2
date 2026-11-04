Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793814907;
	b=M1bwCI4ppXurR0CpBc1wqvkicNOKBLNo8Jwp0JeT0mhXDqqrQ0W9oNfOysR5OAHO7sKQ
	 j4DJBBCFWsAZrxLQLAreWMcMTlsNvAhgcLCTJOWC70ijPhVXjLzcIPPgalPjYrOEHfbnC
	 RJ4ihTV5RZ1ZQt4vLqThpmSSPWgh7uwT2nbQlTDjet0WPQ6o08227YxAmXnOXZu3NjhbX
	 mNfvmcrcM4apec7X3JLrPx7YbA0AMyEqsSkvUWY3k5+sJ8X7x3eOaGgeLvaTBj2CBfAEo
	 1bEObO/zGda5jIoD6sOOdY5TFxRVl3NeZdnlRtKzt7q6BPYbDpyhKfZbWlbBcKFCSzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814907;
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
	bh=XVIKCNpv5uq+g4VJYQBIAQ6hlHNAF13PHJoap8ZInlU=;
	b=EaYMR97Qt5p0A6cQVxGGkY2VqIcHdwVxPCUSmmRteCWnK2qF7vuPbK/0cR6Kw8rkRGso
	 q6yWCqRI30CMykg+ahVkM8ulRDlRhHFCznvlq5ChaWjFLHP9nkie1FxqqOvu8qcQhyh9X
	 SBLOLR0wUIVEHdJo2b3yiyuR5ps6bcRSgPUZF66k+Pqxq6JfAreBFZHfT/5TbyHOcyasz
	 5BRRbGYJZlheB1qXfWuerNXAoI5p29qmwKiOEjDbzvgz+y6L4cZaB65xPo0QjC7vU/E6b
	 T8tymcebwK7MkL0IsHbSzf6rINDENELZbikXxpNDS7Srf1gQy3wuuImCNhqyXbP3EfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ZaBj7L7l;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.59
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013059.outbound.protection.outlook.com [40.107.159.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE658606D31B;
	Wed,  4 Nov 2026 17:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE658606D31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ZaBj7L7l
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mALgntKJJgmb6yZqP4LI5n++zovlNkX638t7+pGExGCkRBTmlOKjW/aU+2svlcVz0PGTIZIcvpEujLDw6Gy970ZWft1+K4WvRVB0qFu971GaZ/MFPlSRDZy0Su5nTKZbc1ghNIXGLEqFlANRCJPz1qoQYtVeEEiTsBLq9ZVAid7aFRhIDrGH/u1WVJy4Ae8s+/1+yGhJmzz1ayOz8w5cLAZT6itGcvKehPFxV08Lh59zylFcANmtOB2tvFu8k5kIw/7UXSNg2Q15OYycyY8/1GyWh3vF2DjObxaxsnfOQRIkGB3eJ1qk++ClsGLVUgC/BqsjPMiEnIo6dIZTFLSqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVIKCNpv5uq+g4VJYQBIAQ6hlHNAF13PHJoap8ZInlU=;
 b=p32wkY17sUeIgqq9OY7JFp5bZCfuBBNOWtqkTooSEMYzmAG+ntxonxcEg+NHecG1RrF6dkJXAbcws/cymSNeVxK5J3QR3xrja/VbQNDW6IXd6FOJ3SnbEzPobZEVL1LKJu4PTVYo09Mfbwy0J1Equ0ed0rVK3B/WvrZEa6xTyqaKhFkvaiP7f/VS6aLgMa7rwBP4+hx5WVAquZUzXvV/arOOPnuhWAoIjQ5lua6yaENBRH9IfFesprEjoGOuoDinEn/lMzf8aTDks1ZZoTkaY4yI2sWW1+LFUFTfGoTJQyDKD7bYnhdL1V4zsLsC+dq4FmHHuevj33F/kZkZUxxs/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVIKCNpv5uq+g4VJYQBIAQ6hlHNAF13PHJoap8ZInlU=;
 b=ZaBj7L7lgoLYKlMANE4P4RUb2XJYMbXD+2lGb7VBRVVIzI5C8/n9XmLkG2mHihPrTUczsE01AnXA/Ku2McdlxIARefwNzw5eeKLZwXPxs0SNTgU0Ei4uRI2dyCTsa8taP5LJD2o2xGt1JfNe+XtpFUaglmSoC07yT1jt27HvZ9XjN8S8VEg3FnpXZ2Nf6IsqyHn8Xe3dlSxQvoVI2EeELRfvybdjY66DQs+wlP4eTw9AQcg4rrT1Fprd3ssz5N5fBiol35WdvArhlu+lyfpxebd/HyQ31KrFerWkwWknrOiZEnzPksFG/lKZmAYiodBaGZY11Y/a7nY0spHEkyKGhg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by WAWPR04MB489017.eurprd04.prod.outlook.com (2603:10a6:1d0:48::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 17:55:02 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 17:55:02 +0000
Date: Wed, 4 Nov 2026 11:54:52 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Tony Lindgren <tony@atomide.com>, Daniel Mack <zonque@gmail.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Julien Panis <jpanis@baylibre.com>, "Mendez, Judith" <jm@ti.com>,
	"Francis, Sebin" <sebin.francis@ti.com>, stable@vger.kernel.org
Subject: Re: [PATCH 3/4] dmaengine: ti: cppi41: Restore QMGR_MEMCTRL in resume
Message-ID: <autxbBcscD8YahBA@SMW015318>
References: <20261103-v7-3-topic-am335lpm-cppi41-v1-0-d7213446c5f5@baylibre.com>
 <20261103-v7-3-topic-am335lpm-cppi41-v1-3-d7213446c5f5@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-v7-3-topic-am335lpm-cppi41-v1-3-d7213446c5f5@baylibre.com>
X-ClientProxiedBy: PH8PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::18) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|WAWPR04MB489017:EE_
X-MS-Office365-Filtering-Correlation-Id: 3250e5d3-583e-44e6-ff29-08df3a9cbff3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|19092799006|376014|366016|23010399003|1800799024|10067099003|22082099003|18002099003|4143699003|11063799006|261102123227099003|261022105027099003|261026121527099003|261026140227099003|261022075727099003|261028144727099003|261021123027099003|261009223027099003|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	kYTMjlHP/d0zzTn/oSQzP2WNmXIX9dDP4ViQE+7/h8IuQPlRpTIjth36RAa+YaNSxt3JM5YqtY0cB4AzRHYfQO0/yFK35dnMDNFiQ2uMP1pF5eRl/h+xmGa9KxxnzfVSsl9NDAcsum1Vqcsx8MLPvHphyV4TWoG+j6yW5Qm7/0yjoMlKjmsVKuu9AiI6j6tLuCdQCEW1j47ILCqFNudO9ulozeB03bG/p75wcU33Tanxc1bSxD9U683iXADMpqEpXBbM286nvdljoQXIJIQAWaUT7cPOFJkoIvNR/UrkYWrf4eOpRVuYlKkLGnFAaNiOjrDwFXwRRoQHugEkYDiu7HS9bqn3x+gwmhOWohRkWssXEEdKfsPide0xcSRHtz41d0ytchKJyF1GYuvUeZlFwMKfDGhQZnvXBvm/j96wvBsb+XJHrSPssiPy5u4rJi9o1jgqv7kx41LevOSVKdA0oMkyTRCYKaHrJUTVVS/vsHDPniHuNwlc8ItHBfCtAUamY/67zvYvXEmqTHa3Lk+F/xqpmL2Re7Irq7JvBPJcuow5hnxfEePZZFdPaB4anHo7skk9LwTWLjS7UOuJXKcL0jyC2jNXni2qPNfwLJ5+YIY6/Xv6G905+ri2zaFrumS+OP4D6TJOQ7rtSXoPzKJjtZm7kI3nKWoZRp6xEx1xVw0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(376014)(366016)(23010399003)(1800799024)(10067099003)(22082099003)(18002099003)(4143699003)(11063799006)(261102123227099003)(261022105027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261028144727099003)(261021123027099003)(261009223027099003)(261021121427099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fJ8Gl9ZmbKYCUxhD3/PacdTrMovR3bj9GNt0a0cIBTpgDRcf+Y6dWth+vi/r?=
 =?us-ascii?Q?KfUoL9gQz08ud5BCKgkPdIcsQG+11Lhfo3AvNh6NhX/H0htS1/jYoxi2twCc?=
 =?us-ascii?Q?gEj2TkXgRHtJaouc1SpSFy+Pfa55he6tt+kfKebuGMcMGjlWkCDIpOrATmjo?=
 =?us-ascii?Q?Upj/56kyEvFpf15f8ZRDTxtSZuYZdkyShCs6EpVca9nn6r4SRbo0lsswFmtP?=
 =?us-ascii?Q?FnB4iesZD591SeM0MVtsLFLlu98sul5Am1bKICzfb6UglpAfRvtQdKrlRKps?=
 =?us-ascii?Q?OVxKvT8KOKPB4xpcyvtp+3PDWYNHEUyvGeiq48/li1AqvRMwtzgck8BJ9H57?=
 =?us-ascii?Q?K61hXGqLPD3qiiTlAK8UMounSzrp+avUOdoHeR4EngnQ6AQ3h782cUV8LzuM?=
 =?us-ascii?Q?1+xgJoqqfi17pxh6S9XnaEdLcxk0RyZqKIwsmstLip62N7/fszA0H2Twfts8?=
 =?us-ascii?Q?qjctJuIk21fAbnfAVUEzRcKeqmOIe4rNEGpiSOGJNBzCP1TLkPzzbsw+9e4/?=
 =?us-ascii?Q?idg6DOp2/8U6BMDQyKCVC6zKvZKM3g1G5VrBBmvfAXDtXnWPnfx1MWjeQocX?=
 =?us-ascii?Q?+VkYMnettLaol7vDtIkMU83OFh7Vi9L2mVeKS7U/qIs55FlnOKMiesKIj2CA?=
 =?us-ascii?Q?eEk+tBzmLJtLZCJv49OfVeLbbaOj4VNBr9CiC5r487A7fcVNlWjjk4z8Tpww?=
 =?us-ascii?Q?U0PeRE1hRnfzGytRu5qyoMCV4fSgmkqmOPkSI72wZDeZJA5oDtvE136pmrKD?=
 =?us-ascii?Q?ipTkuB66dcgtaZTE6Qt0h/S+4rTRE8T0Hr/lKtwapJTrEHlceEg2eS7o7Zwb?=
 =?us-ascii?Q?/jSHzTolYMxaVVcMOetUdhScziEL9U2ow4VSAJh9d614IvvrVbVQQOTFh3Op?=
 =?us-ascii?Q?Y6zwCGyMQ3inyR5CZu6kWDh64ryL0XOeKvPeiY6WavrXF+rSt+OZK97HGIjy?=
 =?us-ascii?Q?Ix2sWs19ezT2h/5nwocK2SSyhU4bG6raZwsi25iXH47DxGYyLUOy3EYSQkMK?=
 =?us-ascii?Q?Apsmd8dh+Z3FVbfqDPzC4RKfLChvnHcdb0EVb/M21giLPz4+VxTeGq5J9Zb5?=
 =?us-ascii?Q?JMvw9UwQ+7LZHUU49huhSM9qjgPp+IfZTk1WfUHhi6MnVvmTlCy6QrfX61+Z?=
 =?us-ascii?Q?UJwAwzJ2PI5p9mlO4oK8JizkyBkPOk+cMWtO57eLGT6gl7dgTOUR1wa/r851?=
 =?us-ascii?Q?bURO5Xn5zYof5khNZ8pbojEWFdL4dTSHia7F5CHsYKziLv+QguKAnfhWL7+p?=
 =?us-ascii?Q?nwB7twoSJyk5OU3rnQiIF+HKAowX97h3xtp2ienrr4KLGmW/Zw6jeyGkReLV?=
 =?us-ascii?Q?lt1p8VSbnhrU12zXkDfk4p0zIq3E7IEaCHdIxB2q7BUBjK7u5Pjv6I883DvR?=
 =?us-ascii?Q?JphXwi/Y3UnvN4ARyk284Diu5KrbvPSmcZos1u4qKaAFlisGjwD9gSXcHCSW?=
 =?us-ascii?Q?YqtKXi3x/wjz06ZDhN0qcWgyDGn2+jZ8hNYhe5XRq5A4OqkyvoGr/OuJVgF8?=
 =?us-ascii?Q?Yhq3N1DkdOtOdf6b7nol8Ag+liWyaIZcxj3OZCFablAcPbcKmphxxNJ8p8wZ?=
 =?us-ascii?Q?ivDKCvkWiJsZ472iyGae08R59FZmzPNcrmVKyxCSCSS880Q5z3j2OFCGeqQ+?=
 =?us-ascii?Q?L072xuIEobF4sPWuF95XMx1l4oPMiab+U/5l2VfSNiaDX+bLjQrdat9J2XWq?=
 =?us-ascii?Q?cjF8jDAWbgcPc0Tp3ebeVcFY5ATKFT0cPrvjL1dTkh7uO3BGigr1BskEHi/z?=
 =?us-ascii?Q?fG1dIoJexw4pzFN05AdFCUUcPlxyF3UybRkrpclEFwbhzcdOlWQ+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3250e5d3-583e-44e6-ff29-08df3a9cbff3
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:55:02.1684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qLsfDm7BMiTPvWvJo1YkGQVs3BdvTasIlZQFJ0ks1tLfGGUiJOS4o6hXizhDcESb6/id7nC6Ji8NJCsB/m7mDbVbW4MpdjrLUu+x+a+BwHJXYNFWXlgcsbaGAPtI9Mr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WAWPR04MB489017

On Tue, Nov 03, 2026 at 08:37:30PM +0100, Markus Schneider-Pargmann (TI) wrote:
> [You don't often get email from msp@baylibre.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Currently only QMGR_MEMBASE is restored in resume, QMGR_MEMCTRL is left
> at its default values.
>
> Add a restore for QMGR_MEMCTRL. This introduces a helper function
> cppi41_memctrl() to not duplicate this calcuation in init and resume.
>
> Fixes: f97b98d6d02e ("dma: cppi41: add support for suspend and resume")
> Cc: stable@vger.kernel.org
> Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/ti/cppi41.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/dma/ti/cppi41.c b/drivers/dma/ti/cppi41.c
> index f5a824418fe7..e2a089066c6d 100644
> --- a/drivers/dma/ti/cppi41.c
> +++ b/drivers/dma/ti/cppi41.c
> @@ -842,13 +842,22 @@ static void deinit_cppi41(struct device *dev, struct cppi41_dd *cdd)
>                         cdd->scratch_phys);
>  }
>
> +static u32 cppi41_memctrl(int area)
> +{
> +       u32 reg;
> +
> +       reg = (area * ALLOC_DECS_NUM) << QMGR_MEMCTRL_IDX_SH;
> +       reg |= (ilog2(sizeof(struct cppi41_desc)) - 5) << QMGR_MEMCTRL_DESC_SH;
> +       reg |= ilog2(ALLOC_DECS_NUM) - 5;
> +
> +       return reg;
> +}
> +
>  static int init_descs(struct device *dev, struct cppi41_dd *cdd)
>  {
>         unsigned int desc_size;
>         unsigned int mem_decs;
>         int i;
> -       u32 reg;
> -       u32 idx;
>
>         BUILD_BUG_ON(sizeof(struct cppi41_desc) &
>                         (sizeof(struct cppi41_desc) - 1));
> @@ -858,13 +867,7 @@ static int init_descs(struct device *dev, struct cppi41_dd *cdd)
>         desc_size = sizeof(struct cppi41_desc);
>         mem_decs = ALLOC_DECS_NUM * desc_size;
>
> -       idx = 0;
>         for (i = 0; i < DESCS_AREAS; i++) {
> -
> -               reg = idx << QMGR_MEMCTRL_IDX_SH;
> -               reg |= (ilog2(desc_size) - 5) << QMGR_MEMCTRL_DESC_SH;
> -               reg |= ilog2(ALLOC_DECS_NUM) - 5;
> -
>                 BUILD_BUG_ON(DESCS_AREAS != 1);
>                 cdd->cd = dma_alloc_coherent(dev, mem_decs,
>                                 &cdd->descs_phys, GFP_KERNEL);
> @@ -872,9 +875,7 @@ static int init_descs(struct device *dev, struct cppi41_dd *cdd)
>                         return -ENOMEM;
>
>                 cppi_writel(cdd->descs_phys, cdd->qmgr_mem + QMGR_MEMBASE(i));
> -               cppi_writel(reg, cdd->qmgr_mem + QMGR_MEMCTRL(i));
> -
> -               idx += ALLOC_DECS_NUM;
> +               cppi_writel(cppi41_memctrl(i), cdd->qmgr_mem + QMGR_MEMCTRL(i));
>         }
>         return 0;
>  }
> @@ -1191,8 +1192,10 @@ static int __maybe_unused cppi41_resume(struct device *dev)
>         if (pm_runtime_status_suspended(dev))
>                 return 0;
>
> -       for (i = 0; i < DESCS_AREAS; i++)
> +       for (i = 0; i < DESCS_AREAS; i++) {
>                 cppi_writel(cdd->descs_phys, cdd->qmgr_mem + QMGR_MEMBASE(i));
> +               cppi_writel(cppi41_memctrl(i), cdd->qmgr_mem + QMGR_MEMCTRL(i));
> +       }
>
>         list_for_each_entry(c, &cdd->ddev.channels, chan.device_node)
>                 if (!c->is_tx)
>
> --
> 2.55.0
>
