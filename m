Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795595314;
	b=vFCZWCpX1q1oLpeF5xR0gInBeXenApt2Y9IZIr5q43mUPCTMBPXDbKJemcFLTVCCLpXt
	 Pl0PB8nTnkFWRrwASTVMVPPDOwreQEjNOZ7ydzrrBLmdPjZIue+w3SIi6DnQCXaVaiyMl
	 qVFrpcKrNnKjxuWZQKQlrOF6qixZgD5NWmRJsjcjcpr1XUhD4bTM/D0D9oANg9UL+CmxA
	 k4IrARxlhT0xNgjKSot9hXaQVeo5FNI4bB3jdxWPUX5enbJEtSCnbE/kQQhsK3q/Sc2JP
	 0pU0tMHarjd6zp81FXxd53Yw/lFovEI7NNtVK4TuSjw10l2JPIlFfpwBmFAz6gUVRPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795595314;
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
	bh=pvaif42UsfINSlAAimCpmndZRtT8DKtSjfaklfpubAU=;
	b=EQhXDsYkz9hV977JuE0ifA/Nufji767dmYAhMjC0172aLnE0pp7rQDy2u9QfJfxkbHZ8
	 pddyh0cW170xTSCAjVkVncYFXFs0r7eWBUi7ZfppRajP3DukywjXbju5JCX23i9TQjKTt
	 3xt3tFYlqWGQnfjv4ELz8BaTOkC05dwxIbGD0rjQECFq6t2hLCn/Mm3X6SYMepww6qeTq
	 hy83zsM7B34y6iIGOJHikQWHr62aiMEDc+QG+iBrhgTsYh31RtrBciGKqzXmXea8Xwnbp
	 zvf7d3LEyd2+Fuk2QC39jhz2YaF2TZYiG9dpac6gB8OAJZ3Yy2/uPqznf1cL6JaIpvg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=uRBgQTiG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.22
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011022.outbound.protection.outlook.com [52.101.70.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AA7606A31E;
	Wed, 25 Nov 2026 08:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47AA7606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=uRBgQTiG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TII+2Q4hlT9jSG7/281TkeDD2ItQo0ibMBaXElz2EblFvrwfjiCA5pqOc2QGlos0GOrhqe03ploWkcuDTHvylgjZetBxa2AxkQ6bSRqBVqNlQCKEDujwp78lUmDPvDubWKkYuOh5RLHqh+OcCD55VcQUm5cpb9vn8lVqqufaZGyZU1FevipWdV2A+0uKkW0cv6nMQf/+Fwd1ocISEN5x15S6XBLYLmKO1d1T8bfiFMy1OXTawkEkOo8KniEwvhYq11VxPpMjmdfh+Y3fW3/u9TZZc6aRjTmAUZKpbm3eqED83730+A01wH216UQw249xBJqb/K2sDgdSHN0jb0CyWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvaif42UsfINSlAAimCpmndZRtT8DKtSjfaklfpubAU=;
 b=VK9JKpTuN1w67mFdCtKAiar2KLPvhhsCGDZObriAfLZh+4ieJG4HvzZYH1GPeJLRj0w8x6NCoM4dp3OKtladg1sVik8YzomE15UeqrhqEhu3z0Z0aHMrSL30exspqQuCKoMMikL9nwYHY6pQ7Bf6M0JL5Y5BR3w8eI6z/bBrkBLXf2xcPsxTDhKhh1LjAiPjDnQECbnXg6xEHW3IdxBs86ljmTaH0IuoZByPkD/biM+KVmtuEr/Gzl2WsdaLY77IeRKsVut+xrlLIg3zIGjszJBtT+nsyR/m7tsvrAyfYwpVRy2wWGfuAa3STbdDezjvrwQK0vCW/0tx3zuQLs0qjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pvaif42UsfINSlAAimCpmndZRtT8DKtSjfaklfpubAU=;
 b=uRBgQTiGKq+BrDj7AUiNa2KdA1rhNGStUVoAOQfohSxr5rlm5R+ObGdzU2cSr73omq94F9XRMWZf1me2zeUqc3EaNOh8Ttj7Pbd37Voi9vVcWKtlUN1whcttNzCSn1HsGWo+FalLeN/nGLxbzM4/X30G30+aMoiMZQP5wEMzfbKW0GvMFLk84S1GP+EfxkQP4JmsQz1vSaPbNDjkOHG7p63ZjB3JO77iisD6MHCoXBmmUp1ukmeU+K3fgyhK5PZarVHOvspFhmxOt1CrgoLZVAQpj5MjXTrOYJh06JirNuUCXbom5EQXHm/exbaTWwgexCOdsUD6bvghcZxfClSEYA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by BR2PR04MB728579.eurprd04.prod.outlook.com
 (2603:10a6:2c8:3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 08:28:31 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 08:28:31 +0000
Date: Wed, 25 Nov 2026 10:28:26 +0200
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Denis Arefev <arefev@swemel.ru>
Cc: Lucas Stach <l.stach@pengutronix.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>, 
	dri-devel@lists.freedesktop.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm: imx-dcss: Check return value of
 drm_mode_config_helper_suspend()
Message-ID: <awab8eI2696Nj1IR@vm>
References: <20261119113031.36945-1-arefev@swemel.ru>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119113031.36945-1-arefev@swemel.ru>
X-ClientProxiedBy: AS9P309CA0004.EURP309.PROD.OUTLOOK.COM
 (2603:10a6:20b:45d::14) To GV2PR04MB12318.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|BR2PR04MB728579:EE_
X-MS-Office365-Filtering-Correlation-Id: 7176f908-ed7c-4e68-50ec-08df4ace1644
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|19092799006|376014|7416014|366016|261009223027099003|18002099003|22082099003|10067099003|11063799006|56012099006|261026140227099003|261026121527099003|261028144727099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	KlscykmmVa3sqwcj7A8QYuu3RKLSXl8Y329+46fSrfJuBHVF39sDUNAXGeKRSJRz1h6TLetowQO5EB5406XInCzvxtf7Hyvu/stVw11uaRqhf4Uj72hJzH51jO+VA6ig4f1+f7oNfcO78kZ5KEl3eIBCKbxm/KEwN3olamZcqZ6OscPgIgTIAcloRDd39P4iMArUSra3VIVUPAk+bWWCD4in6oX3JDasxJph5fDPERYDn5kfDKXzSxprlSsdXisKldrCjQDU5IxvTOMdHryia3blonyfj7Bmso7u+Tht3m3OChQ/vTI5DsyKtdM6kx5pYfFdt7eJ0wm9xQefoC186is6P4DyyfKzRGFP3pN0YC6UlTu33ulXsYa1JrOHf4yNZerEimFhg2dmhtkqX2yZ1EXszw0i4TaWE8pJqpOVgQ1giEm3mVXr7w98Aqst3vdHHy6K8GDvzX6JocvKegOf3ObFYtuIfmrNWvEU/8X0H08pUua5mNygKnTlh+RedUVnsE6L3QiloG2qUoTvd+euaDtrkCXxjNg26f/bjQW2TEeIU3gqM6yUh7PVa4QZ5gGQVwFpuSZc6QrGQ8jqC3VvOZ0G74yrUZlllCsM4R8SSmf1F5S8wULp9d/b5GhoMvImziKMvZe0lId1rBUP1WqXrdtX3lLOKkcSyZnv1reYhgw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12318.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(19092799006)(376014)(7416014)(366016)(261009223027099003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4kzr4YwIvIN1L1V042dYNIEGzBtooGf6WS0e0WkNUerU0Ue5UGuVqkJcyPfv?=
 =?us-ascii?Q?a0DH1834ox4NfzVeH/MZW0EOXvZoygaTtIWzC6Fr36FZClXqNuOwjOd8CAWx?=
 =?us-ascii?Q?NOm9FrArubz17lVOw2cnBKQQqauhdobBjJln5hKLESwXSfz07Xr7vQIvXwyB?=
 =?us-ascii?Q?GQF2OTwNjeXq2v0LucPY/w/KvrvJWDWaggiYODDfx9MiwEk90s0dpBlAMHLw?=
 =?us-ascii?Q?lWmHfxOoISZCeKcYPDmXh7hvMJw3OFUvMG236/5dUlMtp4p6q9r1QL4JSKsQ?=
 =?us-ascii?Q?pJIuK/SiRafUOrlCeuttw6k0aOF08kvqJSBPSWiOiwEYoyp0uLTM7UewUixT?=
 =?us-ascii?Q?WH04qTIIdI851v+dOmpVtjUdNRonHv/8NsKuQJGbopkUxx4O5PldbXNb5e/+?=
 =?us-ascii?Q?i1cWGWnVH4HIHsl63U7pimJnfa5mhHbF5SNVH0jC06weqbTCuDcemYevBhL8?=
 =?us-ascii?Q?ENs+9r3yIku1ETsVlwgXVVUPtpFECDVUJYUgBtMLIOc6P7iR616dMQh15VSc?=
 =?us-ascii?Q?1d7Ju/eqQvzBuMgNKZPXe/a+/9oL2MEppEN78qi9L4z3ytR/8jh2P1JQpUm2?=
 =?us-ascii?Q?qA+9oU1xG1M+RRd3maMIDFeBVydLG5o96kh1iw+/52uphhBJJpyO1kWyeCkS?=
 =?us-ascii?Q?AOZdvrUKuJsRkQHihXEBmYjP3CtIGX4atdxodV2nMrv11vMBx9XgiPOsgYcK?=
 =?us-ascii?Q?/2xd7tJCax3kOinMA3kRWwiYMwA4rncHZionQywRZLCk0mdf/rpN6TbTw8yQ?=
 =?us-ascii?Q?w3Qvc2XmbO+CX4RG8BqcbE1weQH2vzqB7JXjcEyWgW5HKJM0Xg2hDI0FIyC9?=
 =?us-ascii?Q?EVnrt+1N/8AWQ6FoL1CqDnskp+mJCX3M4YiBuk9iXyJgIwpB+S9KU9UeIoK4?=
 =?us-ascii?Q?iJd0U2ZAIE3kdCLxdPWovyb8dbtY3YbyG2h/csBW1edcZbUNuGxo9LbHX6Sz?=
 =?us-ascii?Q?+/r1ljMjlTzYTaECXz9jWuZDPso1WCs/JlKM170JdA9wZMsaTYup2dOBRRxr?=
 =?us-ascii?Q?2po7FkE/cTOF2iqdShYsahiNRmVxY9a4WZ2JxEWKY/wHQBkeN/IDqPKFxKrX?=
 =?us-ascii?Q?zpaMlQGduA9qGSKMSsnMENW/26Am/AADunWF50GonH1eYzyTE7yoFd9Z5//a?=
 =?us-ascii?Q?BFk82I1mWFJKIHf0iT/DkSyI6CZ84n+VSJHFMsI8uqTM2jb8ObD93mq9JunK?=
 =?us-ascii?Q?e42cNdZg1+UySqCwZI6uwaOF63Yl4QymjDOE4Je/9Ye9MnUlPz+FC3oPmEx3?=
 =?us-ascii?Q?2ItKn8nuyTZNN4NmiJVydg8CtPly58lc8buBULdbSF0k1MVjLQB0ITnlf9uF?=
 =?us-ascii?Q?E8YX4iUTcGjPoZsbpACqnaxyNJ2yBiOhFh1D4CUJQMjL3Wf7HbKbtS1SaTAo?=
 =?us-ascii?Q?6TjP3tKosrx2SSlRwO4kWPnra6W5ABTU5tCVQdn9LnGJToVl9CqBU4r54Pr4?=
 =?us-ascii?Q?idinwhN6rFROtbKt0DuSSmyzWTgf87fizJ243z56kMOJBrLy23v7nXfkM9+I?=
 =?us-ascii?Q?5Z8Fj0/lZJVhuQSHldNt+NLS57BTdKaCHYs+froo4Ndl0Y92rv4LoO67X2aI?=
 =?us-ascii?Q?242nx+UU+i0NuuNvz3br02sTy1Xyz9BLoJ5WAFs5K2Fs3qqrUPZczTUKZoCA?=
 =?us-ascii?Q?HZeM93mbhstZdRPvLNZNQM+E8mZLPY3879hirk5hAjq9A18ZlL+QcPBr9vbn?=
 =?us-ascii?Q?7tyzBm9LBuqOaHff7Ih/hBNMkIUza/hLMokEs/IjgSUXwa4WxRiiPSf2IIpS?=
 =?us-ascii?Q?5Xj7AEyvYZkR8l8QCbmvWsLg20SxICs=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7176f908-ed7c-4e68-50ec-08df4ace1644
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 08:28:30.9401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4htefDhYutlaXoy4mHKKMjUc83qHuM+MnoKzB2vYvWCxPUtJbsJz1L1zAiwU72n/ve7t4iJIMRLPE0y7AjGkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR04MB728579

Hi Denis,

On Thu, Nov 19, 2026 at 02:30:29PM +0300, Denis Arefev wrote:
> dcss_dev_suspend() ignores the return value of 
> drm_mode_config_helper_suspend(). On failure that helper rolls back its
> partial work (re-enables fbdev and polling) and leaves
> mode_config.suspend_state unset, i.e. the DRM side is not suspended.
> Continuing to suspend the context loader and disable the clocks then
> leaves the device in an inconsistent state.
> 
> Check the return value and propagate the error to the PM core, as the
> other DRM drivers calling this helper do.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 9021c317b770 ("drm/imx: Add initial support for DCSS on iMX8MQ")
> Cc: stable@vger.kernel.org
> Signed-off-by: Denis Arefev <arefev@swemel.ru>

Reviewed-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

-- 
Thanks,
Laurentiu
