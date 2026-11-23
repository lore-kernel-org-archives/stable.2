Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.4
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795425824;
	b=Gr+humUqEst7t8JmyLXg6refjptm7E1vXNkvyAc5cfdx6uWy+LKOelpzl6fWoUMg+WX5
	 vidWdLQMlQPLxFHi1MVm9ZzGIl2tNWkKZPaBIz0amyYhPlbnNxwEn9HKVD0Opewf4pdqQ
	 ECKRoMVDszz4QfsflgBeBlK7HUcUzmEEuRZEwZwoXW2xF2dtc8qrdW7rWV4+Jya70cKtr
	 l98thsTt5gpBEUpxTQcnSO0pBS+t0hY6HEgdKq2sqZZPPAaOrKVEH0v9CTqVW577VpXle
	 KXSxKPyu0toMkApkYC2Zf/Mxbpu5mkW1GUdwhsb+JpMVZ7p8DVyUduDrIZ/AAvQp5rA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795425824;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SharedMailbox-RoutingAgent-Processed:
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
	bh=WEDFWHZ2jvUwTjdMWSt84PGAjx5jfxfv/wgRS1+CzQY=;
	b=4Q7vLWpwyHF1k0z9LL2Ei1C7TCdvR0aNDRk8ylKCx02CARkFPzOMRLAEg2YY9CxWqtSR
	 G+MfpjbYe40zcfet78YSjDSAzrTHh3Ca1PQxngCxFTlaiH6kzQ7Y1D/JBtf3T9PHu8cUO
	 nZ56LXwLK21GDYEWTu6WdsLht5DX3rDqk1BQwTzxg3cIQB9Sa6uKWMb66aPR5GQrmNAco
	 dCntWcwHULAtEfp13KzNe6F25EXCDxzKLAvBSlAEM7s+Q2krXRA9mI+4BAiCvbQZvMzwX
	 vjmIVgCakDFOnn+XreHUZrG/oQmO1og3wndLKYQKnIr50CtR1Ig9MZttHxDa/dSwUcg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=YUbps2ym;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.4
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010004.outbound.protection.outlook.com [52.101.69.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB98606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 09:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BB98606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=YUbps2ym
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTHgV+8vXnuYzohDmhln9pMooquwa3qoKZPWdP+bej7pONVHYyyMOPuyZpQcjLU67BfhD45Wr+lgp+7j2HzD6nucoEi6lXv/T7q7yi/t5OEnHY7GznPwbxMf2mnAJKoy1qtKOyhKoioTXEGnoEferBrTgGYskqW12+lUJRjOMZkl7ZTvww2yRpqnOZTE5BIcmwrxm4ib9yjJ1ORrFOqLnr+0mqlbaOAiQY7ZekwlC0Wsolgd5Kpo++z70O6TTqSDVLTWqaJHGfOXsOvwFlvwFU2D0zddQLDeFTepNFbc7kQO7QpSKw+SR2neBlvfW/FHsI/lVNtjPoA2sTlVJ+QuNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEDFWHZ2jvUwTjdMWSt84PGAjx5jfxfv/wgRS1+CzQY=;
 b=KWG11yILxhsSQnwEmWkKw5O4hLPDcaWpmW1Bk5p3WL7PXG/GqIRId0j2qyUzlwc3RdFixaaUsO9tRvBuhQQ5XzSHw71r192LbDZjfEBDcQ14Aj9+eVFPeEvlMIdTsh/e/IOaA1j7X0bQlYvO1yEXWKE2bkeiHBT8RmMpqCZYKBVXoVpTqPbjc5ubrbbJlmVYCngto9r4eLtqV6gttQGz25Sg0LfS+aVhCxYF4TdVXA9RiCiD/NWDYSvWGgqMGQ9Ul4Y44rTPJyrtG1BF5TqPgONl5c1EKyKGSf49yIK94tBQAzP1/erFZV4GyD0SsWWOXf7WF2LCYtx+5lIXO909vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEDFWHZ2jvUwTjdMWSt84PGAjx5jfxfv/wgRS1+CzQY=;
 b=YUbps2ym7XQDGURBQuAEPbxrsp4Jw0QEIbCJ9FrtwtWlM/TKIbT5lJr8JidKMKevdbL2rlMY7EGMcoKeA4UaCAhid1oGccbhbs3Yv56uTlGipQ8ifdxlsRl+GUj0Qt2PkdjW2L6LuxYgxmN+9Tp5D270Lkr8i6EN40dbz/oINnK9rAGCTS6p4Snvf1qQbc+Mglyvz+k/AEiP7KffbVsoScJFaESdEUl7OywAJTf7vIG1dU28e1JynYE1aKVKJ0U5FhuMHI08eDqtWk2396j3Pl8VImdJycOEwkGIjza6iXskeXsaMnqZy4s0lEPO9gwp2vrDS+duy/MOkqKDexDAXA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by MI9PR04MB608809.eurprd04.prod.outlook.com
 (2603:10a6:290:b5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 09:23:40 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 09:23:40 +0000
Date: Mon, 23 Nov 2026 11:23:36 +0200
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: marex@denx.de, mripard@kernel.org, imx@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/mxsfb: lcdif: Fix use-after-free on unbind
Message-ID: <awQFcyLF3u3Z8_f_@vm>
References: <20260909210213.946159-1-festevam@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909210213.946159-1-festevam@gmail.com>
X-ClientProxiedBy: AS4P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::7) To GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|MI9PR04MB608809:EE_
X-MS-Office365-Filtering-Correlation-Id: ac648deb-e9f9-4fa4-23a5-08df494375dc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|19092799006|10067099003|11063799006|56012099006|261021121427099003|261022075727099003|261022105027099003|261026140227099003|261009223027099003|261028144727099003|261102123227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FmuDSP4648SDG9M1WSdu28L8rBk+m0rK8V39QhRBRp+hwqDPMGQQ+8uhFYtYa5+FnLR0Em6oZmy0PAZw1ertZqcXLRWkiecZtmCDgx/eS1dg0AOvzOhvIhNKIlC0J95TpVB6OGlbsn3oQI6I0zomZb4BBUMJ19hAYonIrDAzqTQRlwYx+34ALh5ZOLcIaWH4gA/3Y7CIGx9muXVAQgZoTEScvpcOCakT1AlGreCjckEDuSnUMktwk6EKAGDXOFwRPq4fTlIY59BNsyVBmsOjJ6wZvOlsWtUKAv4s6R4AlcE7Op+u4MQW49mOuDrixl9U2rdT2i3TQR4wbpJJll5k2uap7D2jNQ1jzLOYtpjeO0httHAU6bWDBMx8X0D6XyLlxHDrkUj5d2WmLePttREE5ZMPeigxiL71uzIGfayFMQrAVx964+S1Wg8M0NRZrrqw7c6yEXcpfB/7M42rZQopODVnMQLAgwTg5Yh12ywVETo7iZFkyh2rx4efthPfaqAWrI43PFXg9BNohmka819hc7wXYrg1beHh5k6Q5/YeQNgtPsH3Ct1gSdAQcULgNjYrxrQYAwUP87R8UO/5f3Pfl8zkreUIWd8moT4Jx/7O2yqCuKVO4Ppndr/BNs2MI75lKKUuikFStEZvoVteQrmIJXpNMtVY0Zinh6EWjxQwCVQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12318.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(19092799006)(10067099003)(11063799006)(56012099006)(261021121427099003)(261022075727099003)(261022105027099003)(261026140227099003)(261009223027099003)(261028144727099003)(261102123227099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ot2Rw4dVJLbquU7q2CnGNAMBzOcZKPWrZrJ/moSksPOCq+1zmFh91qKGlMJ6?=
 =?us-ascii?Q?+TeVHaObKJkETzfbCunCMW5InInUrag1fHodpTJtYa59J4w0in5/HxvDH3Qy?=
 =?us-ascii?Q?7BnSbAfCYdkTO+B01epU80T+V1jRe6Mj0NBPqoqAWEUG1iZm1HPVBw0nLFc/?=
 =?us-ascii?Q?HxaOBuxJCjbmJ7cpjrXoff9+8fpvuJZz0+ICUkYNVG5DXgqddu2kLDkN+Nt2?=
 =?us-ascii?Q?Tb9sWhtqDpOHyxd2WZg1qAQlp3voMaj1K0FGvfSOQdDcnMwPkfj4/M39Dgz0?=
 =?us-ascii?Q?ivuxr58tioLyFNyLxe+Noti1H9Zltms02FauxmwIUcKeyQJu3wL9mINDemGr?=
 =?us-ascii?Q?Q3MrhpwRNerILxoxPteq8HsLzxPWTZPYvi8inL8QinRMCc1y9jNS3+CLXk1I?=
 =?us-ascii?Q?pTlMpo6RSqsENzwD4aa/aXRTgzRiVx4HR5DsFhdhdM+O4UCibLeuzP1afXs4?=
 =?us-ascii?Q?vArQGRqjJBqf9XSc2/jO9cwGKbX9K9kvzMhZlSuqccUFTzbhSKRN8lft3doh?=
 =?us-ascii?Q?x9xkQXlWmDdSNr8oms2VR8eWmeenZ4VfYEDr9aAzW7nqHhnI3b9NdufPaVH4?=
 =?us-ascii?Q?S3ffX27DtzOT0L+4+Sq70m5uKeV5VcVC/qv4LJmMAWOWMFCnCBgTfwx2T1fV?=
 =?us-ascii?Q?UPum2NGWfZ1IDsgK5Fb7vytAYaBnf/qfvRF7USiWPD4i90nKOHawtqswSt+n?=
 =?us-ascii?Q?C4e8Q3UyAgNS5u4cRk9dAdaIctk8sBaYJD5O1951hBqcrwWnM+gBnosjgE7q?=
 =?us-ascii?Q?Pcre0zO1JvdbQuGz81lCEnw/G7+NBaiZiiqd+e2JJxXKiiwxa2g1B7G48rYI?=
 =?us-ascii?Q?H+W0Oxp3SqxedUWE9Q8/0pgWyolW5YUAhJHSFAgxzRg++lB2mxIfKZRlEppv?=
 =?us-ascii?Q?CQNusUi0HvKF92c2eSwm7zMF2p8o/0Y5WJPGiDHc9P+M0IgBkALHfH8mkCu5?=
 =?us-ascii?Q?aXhjDJvdLFSGCHsuOMH41BSBgwKmH8knWY6iH1FOnBXYRiaHT+nrq+abvgOh?=
 =?us-ascii?Q?TWcRgNmR4+w7+vSz4aduUWDOD2r1U9vuJ0EKeYdehlI1U52Gpw/Gu13PWAQ2?=
 =?us-ascii?Q?8XTZGg+6b0kj6Twg/Nv1q2nWTW32XPn5PCazYOolSVfCg+YI5cigTJ4db+14?=
 =?us-ascii?Q?1SX+wREwIKgg0s73EtNFf7h0iIfqR1YBAnrJYSKH7erFyPXe+ktV2tZ9DtRn?=
 =?us-ascii?Q?UEkKSciW4vrlcpL6P+QtaojqwD6o7VWpIe5giApTYlyHcZOjtq5ZwVfcZYmJ?=
 =?us-ascii?Q?3FZcFK+GIVG/A6m92/x46YHWGhZXDosh4bAwl+ZkxTkPufJpeDf0dNbohv18?=
 =?us-ascii?Q?6bu6TEVlqGevk7v+w+sbaNnTXydAZm4aBo16NuZcWn87cgU/j617e64bl1jS?=
 =?us-ascii?Q?OZRMshuRIUVY7CREA9b71ZLLY2ChU19XtUlQaSkIunCN8ZXMd++wq53aADis?=
 =?us-ascii?Q?JCaiq0LUsX7N+qxU+orrG7GD1kQTZayYmuHcH1WSPUsjasH1NPl3hvUj3Elw?=
 =?us-ascii?Q?PjwqwUcbEgKA6G2lvEVFmkQZwpN8jU+43BSF2UnCyupZCamx92pao5Rj4Z8V?=
 =?us-ascii?Q?JKDaQI25bfSgSvK+p8GKirLQI6pQNSo6iOWdLyjR9Nq/hFjiKRjM3VejV8fy?=
 =?us-ascii?Q?CNKZYQM4e+HotDPa/uiHetHvKJZFduNWaXTao4zYYDzVwr2bzE2PvJzIo62V?=
 =?us-ascii?Q?7KFK4TLhW0di+YVk0ERDN2GJ6BGYhudUcS/1j7isLA4I8IDHVV0/bSB1AXkz?=
 =?us-ascii?Q?0alxdDSBXg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac648deb-e9f9-4fa4-23a5-08df494375dc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 09:23:40.4717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H69ZmV1/wRZXzNv2B36DaDxM3F9JmV3HGCs6ztbxrc+xEarI3rRf4GuihnOo7IKFeaVp++FZYcg3clnKZ44qRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR04MB608809

Hi Fabio,

On Wed, Sep 09, 2026 at 06:02:13PM -0300, Fabio Estevam wrote:
> lcdif allocates its private data, which embeds the CRTC and primary
> plane, and its encoders using devres. These DRM objects are linked into
> the mode_config lists.
> 
> Since mode_config cleanup is DRM-managed, it is deferred until the DRM
> device is released. An open DRM file can keep the DRM device alive after
> the platform device has been unbound and devres has freed those objects.
> The later mode_config cleanup then dereferences freed memory.
> 
> Allocate the private data with drmm before initializing mode_config so
> that it remains alive until mode_config cleanup has completed. Allocate
> encoders with drmm_plain_encoder_alloc(), which cleans up each encoder
> and removes it from the mode_config list before freeing its memory.
> 
> This can be reproduced on i.MX8MP by keeping the DRM card open across an
> LCDIF unbind and closing it afterwards.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1c71d925c03a ("drm: lcdif: Switch to drmm_mode_config_init")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Just a heads-up, this patch will not apply on latest linux-next. Probably
because devm_kzalloc() was swapped for devm_kzalloc_obj() in latest tree. So,
you may need to send a v2 anyway.

But other than that,
Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

-- 
Thanks,
Laurentiu
