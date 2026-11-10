Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794318589;
	b=gkFogaKwm/fdrDvZmYCa8f4bz0bulrtrtzRhm+U859NvEXZFP5yrlr+9VI8ghcs2VUTL
	 s4hvoPCVeIkrn+zECdtHBRgB81VMgnl6YFk1y8K7rSdylJk1DxkKJrUNj3Ls/+gcdTnX8
	 tEYz3ibWCvMBq9f0qxVPftcmbeoiA+kOw09DljBAPVAa5SYKJvug50ZMeXWy60YI20ItJ
	 YkB76rAlaMzOWUkaB1/gFvj8WMng7sMW+NHA6F7GP/McZP9KDHTCnwkAUyUDeVdX6LqzR
	 nIkqcFEZPGKIODS9ovDXEVjo1ykzLg9dRVEG9M+2sKjvOgG02lyA7OrcW5Z9uF2roEw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318589;
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
	bh=RkH1T3hHWTzZmwAFaAhC4oTRpRqNJhlhTgDYlyCBn0A=;
	b=Pg56ItrJ/qOvZ8t+SlSCa4uOOoQ58woHxcElx5Qvv/BM4PFH94VPYEqFLL9G01LFltnA
	 7RCJcyrj+Yf98RMKPe7aQGVDqZM+4QYAL9nEZQmX5pMcZ5InH5m8deG/rPXAb5DQfkCHf
	 uLjxQz2NKSN+Hr/qApiH5wTUSAobes8QMKftyM/cbRarVOUVmA0eVVWoZBZDkpxjHM5OI
	 PhpjU45L9bbi6LJaPX6Fz3238tGfCbdzcz0pg8rqHyfRQAFvq+aziJScBio7MiPurHRxU
	 Rk3Y2hTg9CKP/OUw6I8dTqf+1yv0405sWeiaEslbS5fKQcijmHkoFk2mtvuQDhBZxoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=H2mhGIb3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.29
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013029.outbound.protection.outlook.com [52.101.83.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BED60A2600;
	Tue, 10 Nov 2026 13:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7BED60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=H2mhGIb3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoFxXr/LxR8ugp6bPkdY0W3pGOprbdSKlIwsCYkC/WUc2kRZPdHR0przUNuMx/N1QhrmRcfJLNIZnP2Tm7BPZU+eLEAezlFaxy799ozhzz7ayi7cD6a9GmqiaS54z9tCChPCXKPftHhLB+mEB49CAZUkDxgXOM78M6zqVNntmDPKBvKvq+1jVoFuoPs7+UhKZbNvA2vjmsOIUFg/joeiJjoGJAuaNbeh/78XMbUeR1wL9N0qUf43X7l0yQ5/h+y5zYHnAjQRbXh4lTyW/v2JjD5k2rqsWq7pE7ECrcsxP4HY5/CAvwkLGfSBnIQpRPc1NjIobl9gk02Hlz4YYh18Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkH1T3hHWTzZmwAFaAhC4oTRpRqNJhlhTgDYlyCBn0A=;
 b=cXkZ4DIHjX5UaKZr+dpRYo7Uvh86NUR9v6gqyy1x5sramM8dkuGbu8nh2kMe9Eu594Y0Plm94eGQ8NsWzwa4C1O4mp/lyghGUZ8+XJZMiYjNE61Nf1AXkGKTYae0uimj/LijFcwLMoi5DL/nc0hz/ZdZifF9O9IDnjG6THI4u+dDrSHRtbOomVsE32dUTd43OkqdC2wCwIejAMURwNInKvjqomSHVmyh0Iiyekv9JqEqx1+Pjgo3Sc3JYHFZGtdUqHyuLKPSALoK1YpKAbDlDaeFrfIlQHxrPwnHQpnGDQbcHSVNA5D5opb2IMSQOwnKC4Yc9woWEZ6vCbH51l75tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkH1T3hHWTzZmwAFaAhC4oTRpRqNJhlhTgDYlyCBn0A=;
 b=H2mhGIb3O2KM5EMVGNhUHb8oStiK7GRIbFuGM7cozpp0CqfwaBXfAmE9uRFN8GQgJ4V6Dk2eh22q0o3KItUDs+pL0eedCoR4rpNOO0QVCHPI1XHao5/Alvq2/wCZ3/GWafPzTXg7KswWbO+vH0tpSnt2qdXUhgbFwoWdjji2q8L5BHHhO6Bok7UB2mszxgj3fQaDIQSqj6lARQqR12yBc6clRgF4sc/TE2OzkqkodYOk7RXun1SR1lglosNcyG3TVaLrdkT28LIXE/ynrcpJnHrSWzciU274Y/Fl9q0Hihxbb6JaYxORiSHBrCCs1SfupgJKZ60KmN6SDCYocNzEPA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DBBPR04MB7883.eurprd04.prod.outlook.com (2603:10a6:10:1e9::23)
 by AM9PR04MB8508.eurprd04.prod.outlook.com (2603:10a6:20b:433::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 10 Nov
 2026 13:49:45 +0000
Received: from DBBPR04MB7883.eurprd04.prod.outlook.com
 ([fe80::3a91:cf25:36c9:c3bb]) by DBBPR04MB7883.eurprd04.prod.outlook.com
 ([fe80::3a91:cf25:36c9:c3bb%7]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 13:49:45 +0000
Date: Tue, 10 Nov 2026 21:46:12 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Richard Leitner <richard.leitner@linux.dev>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
	linux-remoteproc@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	weinshec@holodeck2.de, stable@vger.kernel.org
Subject: Re: [PATCH] remoteproc: imx_rproc: revert channel freeing order in
 imx_rproc_free_mbox
Message-ID: <avMgJNyGez2Eyr3a@nxa18884-linux-1.ap.freescale.net>
References: <20261110-imx-rproc-free-mbox-v1-1-3e33ff98570d@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-imx-rproc-free-mbox-v1-1-3e33ff98570d@linux.dev>
X-ClientProxiedBy: SI2P153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::14) To DBBPR04MB7883.eurprd04.prod.outlook.com
 (2603:10a6:10:1e9::23)
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
X-MS-TrafficTypeDiagnostic: DBBPR04MB7883:EE_|AM9PR04MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: 3482adf1-8b28-4003-8c24-08df3f317a73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|19092799006|7416014|261026121527099003|11063799006|261021121427099003|56012099006|261028144727099003|261009223027099003|261022105027099003|261026140227099003|261102123227099003|6133799003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	FFCzrKyhOSKTKZr/CwZX95qjOJBQm9RAxI46OjXs8/1OEH07v0NBuvm7/UYepdzYE695SfZmu3WI00GguvHL7UEIyLb+2X7YazfBDNMze8rWD45mmz1MmjbJjYmGjGFgPVXdqUaRwq3Sg457ZczLNs1R+Z3o47GGpjlqKx103FGaQEdhWGedfqVxKyFDIjv20MuQ/q8+73T4gjZbcPoIkYgKRwuDEzPOsb1YMJNxQHkC7PPnobUvxxtjvfoblkibC8cFEtrq7pEpb1hx6wLbeTGjUQ3F1tRulo0GGO8GCweEuj7T798/t35LikSrFKk0HKob9LG41u7PhwhS6W9OjY1iiWhIU91PzlgMXTS7vSC2i6Okf2f2OPKSMualox8U05Tz5TXBsXB8uEj2QRQxGf30S+wqR/CBYf0Ce0RMmR1YmwPQ1FVuYhuASoTVzskOqD9nEIzgZ06Nz0dBzC+HGoJCOZVKN4FEce2QP7UXj4tqjx1esfxJRXyHoAxdqTHE1YS+XqefpGuRIzvYGPtAS9tji6P06XGqzuv7WeFbHYexM92M1slwuEP0ZdXUEO3iLCDMOotP+oTtQ5t8kr1MhAYamPd9fc5HhY48OGjslm/VZ2qOKCLYD5x4Vzk8kUAfcEgHSDMngGFqdtziVWXLlCYwGDkZmuQ3zwOkgWO+9aU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7883.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(19092799006)(7416014)(261026121527099003)(11063799006)(261021121427099003)(56012099006)(261028144727099003)(261009223027099003)(261022105027099003)(261026140227099003)(261102123227099003)(6133799003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jdjGNnIz8uwE9BFKu1WiWfLm8J/cU5G2vD2hOeZf2oUHBIBUsMGSR46701F8?=
 =?us-ascii?Q?Sfh/rha4+xEg/wCOdxcRfUUCWsjH8Y9SWIheEw8fgY66yyxiJZgeANKDwLdE?=
 =?us-ascii?Q?lkp/0vJovpdoh0kCf6e0c/KpzzvjNIiXkpmbpI5/oOh8hE95WTaPFTPlyMXF?=
 =?us-ascii?Q?0Y53MUnU+8HUv8LIVPeWtJqw2IAviJSbI330rGuSaI/vvmNI7d5r502dZgBF?=
 =?us-ascii?Q?vkodBKqOL7iyaENo49etJHCS2XbwssCzEwMJzWJPcxm17DsBSA+2v2HbVELT?=
 =?us-ascii?Q?0ucuUUlSNyA9AQwngbtZTfutyLqUMDcUNb6y6Lm8Z8/VsiWorBvmp25DNExf?=
 =?us-ascii?Q?ANhn58cJ8E7hR/dtbB8Ki/sVbWUccBoJE9TUp54Kw65TIt0D6Trq5DrhXH3d?=
 =?us-ascii?Q?18OuYfhAtHrSoxGgEiEp+xF1QYJh0s1UDwc42sgzeOBy1luLeHF+M3/U3mYN?=
 =?us-ascii?Q?hLWqABpeIwqZ0rd4yeUC+R2sm5K5YlWyF8jYk5X6mfFOluksA80WrkJ9tye3?=
 =?us-ascii?Q?gajHgM5NuFV4nxHXi+CyUVVkPfp/nLAeVl7pD2797SNt9zW3Qc72DbWO96gI?=
 =?us-ascii?Q?o25UJGOg3GkEW+sAXt2APkaMNKVQm8vP5Pqtogb+Erpa5B8XbafL67YW0M8h?=
 =?us-ascii?Q?eXLlB0KRxoP95pNdydafTNpKZQxi/WyfKAtT+DZcyyU2GLL3PD+ogjYTT3Au?=
 =?us-ascii?Q?tMtkuCuVFU8K9EYQ3lUCvhFItYOhqmNfnE6WfYrD394trEmtRiX80IJiaBfg?=
 =?us-ascii?Q?Cb4I5M8d6LGmDqt/ftlKSAu5ZGkRGmuA3ci1SrjgLjcxI4hE7fstCXB1UbjQ?=
 =?us-ascii?Q?gdf7DaRRSrxFlUNs3e9dom5bObZbIMYS657vdJl0RROPufv57J2CpmsoiDG6?=
 =?us-ascii?Q?dR07xbch7IzHxytpEcLT399Rq2b9+2FQsc7u75zJQ0JweWmPD+3xdQemBfOu?=
 =?us-ascii?Q?lF9zx3A0gZLAEm9eoippHxpw38BUfDUphceYSdE3OPqWFdsn+M2u9L7uee5T?=
 =?us-ascii?Q?/61NQF6r+nIgJRJdjfMCY58F1hKYfhXZWBZ3u7fxsHbyaUHH5Gj9E+ddaRlP?=
 =?us-ascii?Q?ai+7og6T/6GbbCfaZMi0XorujPRN0ZQt2dRoqoc09k/+XSPPYudLGVi51+S3?=
 =?us-ascii?Q?mtVEjOsKhia03fES3hrgUBhWDOBdU+C9UFUZ7m+uEGQ3yGH6XtcoG15qfwpj?=
 =?us-ascii?Q?x28gMdL8iblQoNvEa/qigNgfT6Es59NiMKubAZXRRLGHnMVXHK9aX/RrIjJF?=
 =?us-ascii?Q?ZnhKOHCZkqna5x20ziwmjxGL0tEPsrR9kmtZzWL2fS2AtFCSXATDRm+5FnZi?=
 =?us-ascii?Q?mJIDWFH4i19HVEijjf5/j17h3qjovYE/7cCVWr/0DTd66vfDBSzMXkFpK5Kc?=
 =?us-ascii?Q?td3Q3iSeAYMQTTOYRqJAuccgaPqy8R26l8lGS6fJIRzBZ8T28WgfRq/fUYIC?=
 =?us-ascii?Q?GHlIcsxlkbRJ3yhvhk5Qgq4lbPIw1cUvbo5DQnZXQCnZu73TaAcrwv+68l4B?=
 =?us-ascii?Q?BrHjO3KWCsJTfAQ2dhJ7J4eve6SqTPSX3A7HO0HUCu6ax69WlaYex4m/fXT8?=
 =?us-ascii?Q?OZVAZDJaDtEdUkKpzeZzVdRdm7844C13YzjIAgWldwsb6tp9RjgddsBTMi5p?=
 =?us-ascii?Q?fF2WadkjXkGDB4dIrOaFUG4prI9WUUcJ881XpbXzzZks8k+w7/07t+NPwuNB?=
 =?us-ascii?Q?ttrsJQXYRUVUv/bMy6K/e8I0fWIOL+ZrijOuCJE1u/hQ/W5pMNYiNMZ/sFZC?=
 =?us-ascii?Q?/rY6VCUEyarVeaRioB4KPOUOtg7gfA6Rn1/5YiMBPOe9MObH8oY7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3482adf1-8b28-4003-8c24-08df3f317a73
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7883.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 13:49:45.7493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5gqJaV0S8KWBCBYdFoF1XTFtssTKRdSC3tcELgp3t1IOT7zccjEF2YqOy/G9qKO9XZlsXyyzBVF5ecXr/8wHq9XjvMKgiFfKtrvz9iMM0w00u7R++MPI0ViII2rEF3t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8508

On Tue, Nov 10, 2026 at 01:29:08PM +0100, Richard Leitner wrote:
>The imx_rproc driver is affected by a race condition in the shutdown
>ordering in imx_rproc_free_mbox(). A received message might cause a
>virtqueue_kick resulting in tx_ch access. When imx_rproc_free_mbox() is
>triggered between the if (!priv->tx_ch) check and the mbox_send_message()
>call in the imx_rproc_kick() function the mbox_send_message() then tries
>to dereference a NULL pointer on the tx_ch (as seen in the call trace
>below).
>
>Therefore fix this behaviour by first freeing the rx channel, so no new
>messages are received and therefore no kicking on tx_ch can happen.
>Afterwards release the tx channel.
>
>This problem was encountered on a fleet of i.MX8MP devices on about 1 in
>500 system shutdowns, resulting in Oops below. This Oops was recorded
>from a v7.3.0 kernel before the work-queue removal.
>
>    remoteproc remoteproc0: stopped remote processor imx8mp-cm7
>    Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
>    Internal error: Oops: 0000000096000004 [#1]  SMP
>    CPU: 0 UID: 0 PID: 32710 Comm: kworker/0:1 Not tainted 7.3.0-XXX #1 PREEMPT
>    Hardware name: XXX (DT)
>    Workqueue: imx8mp-cm7 imx_rproc_vq_work [imx_rproc]
>    pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>    pc : mbox_send_message+0x8c/0x178
>    lr : mbox_send_message+0x88/0x178
>    sp : ffff8000897f3b70
>    x29: ffff8000897f3b70 x28: ffff80007a07b248 x27: ffff0000d90e1a20
>    x26: ffff80007a07b328 x25: ffff0000c1d31300 x24: ffff0000d90e1a40
>    x23: 0000000000000001 x22: 0000000000000005 x21: ffff8000897f3ba4
>    x20: 000000000000000b x19: ffff0000c1b24240 x18: 0000000000000000
>    x17: ffff80006a453000 x16: ffff800081ac8000 x15: 0000000000000000
>    x14: 0000000000000040 x13: 0000000000000228 x12: ffff0000c115a3e8
>    x11: 0000000000000000 x10: 0000000000000001 x9 : ffff800080cd6570
>    x8 : ffff8000897f3ba0 x7 : 0000000000000002 x6 : 0000000000000000
>    x5 : 000000000000000c x4 : 0000000004400000 x3 : 0000000000000000
>    x2 : 0000000000000000 x1 : ffff0000cb268000 x0 : 0000000000000000
>    Call trace:
>     mbox_send_message+0x8c/0x178 (P)
>     imx_rproc_kick+0x50/0xc0 [imx_rproc]
>     rproc_virtio_notify+0x3c/0xa0
>     virtqueue_kick+0x4c/0x68
>     rpmsg_recv_done+0x224/0x658 [virtio_rpmsg_bus]
>     vring_interrupt+0xbc/0x158
>     rproc_vq_interrupt+0x40/0xb0
>     imx_rproc_notified_idr_cb+0x20/0x40 [imx_rproc]
>     idr_for_each+0x74/0x100
>     imx_rproc_vq_work+0x2c/0x40 [imx_rproc]
>     process_one_work+0x194/0x520
>     worker_thread+0x19c/0x320
>     kthread+0x134/0x148
>     ret_from_fork+0x10/0x20
>    Code: 37f80574 aa1303e0 97ffff39 f9400a60 (39402001)
>
>Fixes: 99b142cf7191 ("remoteproc: imx_rproc: Request mbox channel later")
>Cc: stable@vger.kernel.org
>Signed-off-by: Richard Leitner <richard.leitner@linux.dev>

LGTM:

Reviewed-by: Peng Fan <peng.fan@nxp.com>

BTW: would you plan to fix the other issue that sashiko reported
regarding imx_rproc_xtr_mbox_init()?

Regards
Peng
