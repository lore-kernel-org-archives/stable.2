Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795679911;
	b=D/r+uaUqm7jjts6w9GE+abAcXBcfF0dSN4jOqew/ZUoowvmKhnk8XQfRCoFVKB5JcUuS
	 SAFhPfT3tS+vZyHOLEJNbNQfMs+5HWTByfUizrt3Xz3srzvN9xc5HCq7nGf9fKCKb+MQP
	 j1FQcV4jF2N8yqrFIfUfSlRaqUtnNifNOUnr4ikw+nxXMOQF9vK6UMH6l8tZPJNg0PLzX
	 S2VwmKmL7YoyQY1ofUda3dZRpAwoj2WXb5x3VwISK0zLAYj2Pqa5/2LtfmbL5cyx9MvkU
	 KSCMeaKnFuSocEKcoSFSNfcMLV4+Dczu2/tL/Q8LTat8g1fDALKYuX82HjdRW+qYdxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795679911;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-ClientProxiedBy:MIME-Version:
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
	bh=Ibjn+Ecec92gz5TjlsMMteNFIWH6VbmlAqzJ1czKOwo=;
	b=rnDBEkglEv6FEh+7QitsmjsyeeRE9G2BR8CotJFLQyUv+oox6jwfQP9Goh378xfcHoEb
	 SPngPXUQg41mOqfPp3zm05COGp6Tk77qWNaAGlPXsROmKicofoi8EabOIjrX1KAXX0p/5
	 ITKBE34tdbnTF1nlhw96Ym3QN0NWgOWGxOGoe+wZl/AF1r2HWCfdgDuZuGp/Qe4OK+Xkq
	 SBedT4vVD3ZRNRfWdo0sKkQDKCItu7zkeEUYbqtE3DMlYsKylDh9gqeZEuDtszX+dpozi
	 B0Y7HDY1uaiphb25/FoT5syUu2lgRUvI7FH71uGsShl9xx4TXIaTWf0ihDjiMOX0eYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ATX7ZpZu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.48
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010048.outbound.protection.outlook.com [52.101.84.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCBF606A326;
	Thu, 26 Nov 2026 07:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DCBF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ATX7ZpZu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gt0TR/Urv6HQtMXboX0IstmRvCUsGe8fHvPXW9yXKdyKr9M9nLVogN9PHsSnQp9hAHtYKEJcURiNKi3Ln7MXoaX2BFKfR5hrndnHnwLeYPH+pPXevSrkw0KjLmjCyr/8I8uiywE05pg70S0eWWzxUrxpjG/mHxeD578VaeNyf19uBkyJ9xAM8FmyJXZ2+XcaNloIR/Q7VxiXypaqySzhLf5HKQVAlwbuJXpcDbPpHptzNIQdEfOeKKAy3keEgsWehPJKG/o8t66w/mCISpdQZGsAsm3LHPOh5JU7yzJuu8Lv99xnbxooSdv5f7WALK6D7NV2x3LqkXFrrOWP5RmDrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ibjn+Ecec92gz5TjlsMMteNFIWH6VbmlAqzJ1czKOwo=;
 b=F8YRs/jGiYq4hOCWEMBZAb6hUJxqS74vS2HD9Vk7Fq0AH34iKVXQS0n/poxB+JEMvZ5amZZVarvPVgIFfU4m/gDQ5DUfWm4k6UUHg4U9IGD7sac+ybLtjWxUdpfUe8AY+t/jVF8B6P8WaeJ5wP3J5qLbErDuzX16zhuhfKcHJo4snxqpUFD+xdQ2PD75zOIg9yoGHQtGGdBJzbOZxXkgIImm8ez4ocKyrUP2U+kNVDi9XNa+YlWUt6aBrdzsoA1MZndofPc4J6cOR9cezsJRTIBjNCggMMbzMDRa9uGdZvKKF0n3ceWLo7XW8p5biCzm1RIpCD54vMe2z3IRPWGrXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ibjn+Ecec92gz5TjlsMMteNFIWH6VbmlAqzJ1czKOwo=;
 b=ATX7ZpZu6HZCIpr4jxBZT5uEQ+8//cpuELaFHzpy4F7oTtlOFm2xO72gMHOIvsUm9NMptaEVcsNtoXERy0bNhCx/pu1f0QcieT6fzRpsiD+VJYsKzEtz+3/3fiIHF1J2sW4BXP04UqK+qYVFBA9qCf1AX/qiN2GnVf69HKfjMUB1GkiUuvj/6S/QKR6QB3NfQUlpAmnvwuX0aYHztgIYM1cKQUWLYP1mAd46SNK32EFrq+QWDmtutj5A7Dct4umhwIRQy9pSO2xvyvGrCR+3laZWdSm0y+bXlrqI6a6ao7iktl0kLNRLsWKmkk4uL2qCFTEJh6S3Q1Djv7++znKUYA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 (2603:10a6:150:32b::19) by MI9PR04MB135841.eurprd04.prod.outlook.com
 (2603:10a6:290:86::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Thu, 26 Nov
 2026 07:58:28 +0000
Received: from GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa]) by GV2PR04MB12318.eurprd04.prod.outlook.com
 ([fe80::a498:2b5a:cbdb:d6fa%3]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 07:58:23 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>, 
 Denis Arefev <arefev@swemel.ru>
Cc: Lucas Stach <l.stach@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 lvc-project@linuxtesting.org, stable@vger.kernel.org
In-Reply-To: <20261119113031.36945-1-arefev@swemel.ru>
References: <20261119113031.36945-1-arefev@swemel.ru>
Subject: Re: [PATCH] drm: imx-dcss: Check return value of
 drm_mode_config_helper_suspend()
Message-Id: <179567990223.1088660.11027335035345339261.b4-ty@b4>
Date: Thu, 26 Nov 2026 09:58:22 +0200
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-ClientProxiedBy: AS4P191CA0040.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::9) To GV2PR04MB12318.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: GV2PR04MB12318:EE_|MI9PR04MB135841:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aaeba84-9512-48a5-9b8f-08df4b930b79
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|19092799006|10067099003|56012099006|11063799006|261022105027099003|261026140227099003|261028144727099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jan2FEOimSfiO2lZ8eVgp8/Za0YdWRbsDO9I2UtYyrd7bOm+kwcAJj3wtQVrYvm4ls2yhDCeYUJYn+bWwUhQk13+lcIJqY+/n+l6kkLw0NsD3XqCqqVLGQ6+y8X5uudppsMyKfUoo1ZL7pzIFYGQ+7N7lj2G2kDdcjWDOJNzxMOJKKCNWDwUjvtbf7hL358bE6YY+KJsTVcREjdLIEHhaIngCO/XovOAm/ysc2c/gYePjXzBVrb3gzGYgTmo50j9gRr572QDss0NR0ZS0GkG1RLhP6wN7ZTE/5gvTrSWJqiIFID+K6euYb2M17LjNedZMrArrbwZCqgChYHZCPr+b9nvm9yQbwxvemyMAFQzJG0fKCAA8O6NiH8gtSituSRSjBTrBIVKVl7DLXHDRgs8rAuybDsshCaMC/8YpwYzQZ6c/W9B0OAPwBDBlCKc2NW76n2AK4G3ZkgQswA/VfC0s7g2kYHkt8pSqBxwRwZGdQv2qM+CINqywH28sQCWXVY5AnbvjOtR/DmUMQq9VslJpUs0iIhTk7Oe0QbR7UH5wDC1B6t3Ib8IZ8tpvAqxqJd8HVRT5VDeWgW4PwLiPW9+OBUFn5Q2APKaP1OCwBgGeN2yA2V4qwZMoVSZeSZNdxE//7NHyMjFwEFBPFTutZfm+19X03fTO69w8OLrB6YR6oA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12318.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(19092799006)(10067099003)(56012099006)(11063799006)(261022105027099003)(261026140227099003)(261028144727099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWM3eDB5Z2NDK0tLQ1R1MjJUa3JrR0N2dDBhbzlPOGVIdy9hVGFHaDgxNVVz?=
 =?utf-8?B?U0txeEczWTRyUm9jcTRrVnF5RG84aitGdjRrWHB0SGcwQ2R3NFBtVmNiWDFC?=
 =?utf-8?B?N0dUTDh2MDBKNGJrMU1sRUxERGFFZWt4NXhVREUxekhpaVdQQi9lNThiNVZa?=
 =?utf-8?B?R2N6R1AxbGp6aW5wQU1GRTlQbHJzdlVaWkkzd3M0cVhBVXNBWmpsa0hzb2ZE?=
 =?utf-8?B?MUpjQmFwcHFtcnNreEJsNUNxVTBoNDBlc0M2Ryt4M2JBSnZuZWlVbUVUU0lY?=
 =?utf-8?B?WkZGenNMcjI4V2NXa2NxNFlRUHYvNzV1UWFpSXBPVS9BczhIUFlJOGdtb1Fl?=
 =?utf-8?B?bDg3WFdXVktmVFRyUlYyb1E5VlpyMWl1ZmM0bE0yOXJEb0ZObld1R3dGbVB3?=
 =?utf-8?B?enNNNGh4cE5nQWhMSFhXbFBJUmhGV2FXYVROWU1KZG9IT0E3dFNzemplQjA0?=
 =?utf-8?B?VGRwUTZFdnZIRXY1YXBBSnJsWVBCaUtFbHV2S0V2aDBKQVRQZlh5RXFtUUVp?=
 =?utf-8?B?TUhlQ3NheUNoNFZyZzY2UmpjYzIxaEhCSHJoa1JhVkFaL0UyazRhVnlYUFkv?=
 =?utf-8?B?V0VoK2pHZ2Q1UWhZWVVPcWh2dlRaNHg4MlVsd3RNMVN6VGd1bTl5ejJzQmU2?=
 =?utf-8?B?dHBKcEtNbkVDRHFvTEZmamlmYTZIU2Vzd3QxRmttQ3BFYlkwZjZJS1MzcGdG?=
 =?utf-8?B?WmRBcytUSzRjb3p1aCtUcHk1ZW5xS3ExN2ZqY1JHcHRCOGV3VG1EVG5yS1gw?=
 =?utf-8?B?YzRUdFVaaXdXcW90NWM5OWlaV21Bd1hWU3QwRldidGRyTWFsOHo1TTZualI5?=
 =?utf-8?B?K3JoQmo1dXNSL1lpdTAyTGxPL0ZVd2tNa05Cb2Zvd0JPSFlma1dla0R6MEtI?=
 =?utf-8?B?d2tsVjBDOVg2V0l1aTU5a1pqaEorVXkzRDQ2bVRiOE1RbC9NVUN3Tnd2L05m?=
 =?utf-8?B?bEdmSmNsU3lrMVB4Ump1ZmNNYXlOSFExbDZxWXA2TGxhYTRoQW5XMXJHRUNq?=
 =?utf-8?B?ZzdNbWZYRUtMTHlNWEU2dStQTUlTNEJiWGRRV2I4MmQreGo2aGxYNmd0eVQ5?=
 =?utf-8?B?dFdBUUxqZ09CeG1SZjhFQWpscUVrZ2ZqY21udnBNOFZWbmxzWldxQ09WVU4w?=
 =?utf-8?B?akxuQkxZcVA2TStESUZNV01veVNGdVN1U3dXdGdpdldjenJDQVpHTk55MDRD?=
 =?utf-8?B?MUJnTmI1TzNEeHA2Qy9uRVdUWDEzOVFoenJudWY5TS9ZOVdUTHMyenJ0SWFB?=
 =?utf-8?B?SDBFTDJJSFlhYXpoNG5PQ2g5d0p5dTdjbVpKcTJmS1NKVXNoYkhzUDMwL1FV?=
 =?utf-8?B?K2dJOFVISWJ5TEpqdEljYStVRXVUanJUK1pkSlI5a3BSZVlWYzBnR0RQWUNs?=
 =?utf-8?B?VmNmY2U4VUlTYjExMVZCOWpCNWRRSnlLU3dNZ1RhSmthNzRGWTNKekFvS1lH?=
 =?utf-8?B?dVA1N3h0eGNEU0owZmtzNXQ1S01GamVVYXhDbUdYaE5lcmhVb1RGMm1XMDdW?=
 =?utf-8?B?R251R2prcXJ3SGMvZ28zakNmRmlHZmQ5TElNM1RTaExCZmh0THpMd3RlTFJI?=
 =?utf-8?B?bStlaU9UaVE3NFN6aVhGdk5QMk9ISTVHWGZxTVovcjJ4RUhoMFdiTFh6WTdq?=
 =?utf-8?B?bk1nN253Ny90eXVlcmlkUWRoUkV4N3FCSU1QbFJCY05vRFQydnNES3E4cnpH?=
 =?utf-8?B?eEsya1YrM0RCYjRTOTZ3ODZxc3BBNnhVVzVtdmZrcElnYlQyUGxkaVg0TUw0?=
 =?utf-8?B?Q3UwOEJzNkIwSVFpRkhuVXhobDVaNkRZeTUvTklLMy9Ia1lxY1EzT3piOWUr?=
 =?utf-8?B?N3NmTVVtMVVVV245OHY1U1VGV2FKVzdySGc0U20zeXpzenZhbjdrd1dOZzFG?=
 =?utf-8?B?dll0aVp5YTJONTd2N0tkUTBzMm0wTG05RnhKeElZc1ZzemFXZlJKSHNEa3gr?=
 =?utf-8?B?b0dKeVJKQ0dNVUFZQ09WVmJVNzRiWmd0MGlQVjVRK21OOXlncktrUGpONmxC?=
 =?utf-8?B?MzlmZHNYN3RyV3hWanU5TE05NW8zTG5XOVNJMC9yL0YvbHBxMGdiWXFEZngz?=
 =?utf-8?B?akxwLzVtUVNaSEZ5RWlTMkR3VVpvM1dXY2hwbDVMamEvWGFGNks1YXZwR296?=
 =?utf-8?B?VUNyQ3l6WThYeFNidFM4VXgwUjUxV0l4NERPRDk1YWYremxZa0ZjSFRjVzlz?=
 =?utf-8?B?bnBMOWVFcGhtMENmRWVoQlJyVFpRUll0N3VzVmpzeDFDTFdOZWxzTTFQbVZr?=
 =?utf-8?B?ZGJTZWpmUEErUDBQaHFzKzVWNmdXTlNWRXZ1eVh6MmhFa2hHTEM0aUJ2MVMw?=
 =?utf-8?B?cS9qUFNTd0FNTDJMcGdFb3hkdk5paGMyNnRLdlB2MW5EOHFuZTFMaHo1a3hW?=
 =?utf-8?Q?Ayrsc8hvWvtzF8+o=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aaeba84-9512-48a5-9b8f-08df4b930b79
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12318.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 07:58:23.7042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 542YyzWhabvoSUwvDrawBYvah1TmgMsEJgbprdNB7Q5zrAl6UeU7sKLH0ZOXNBOz57AqzLy+UB5UtI/1dtSz5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR04MB135841


On Thu, 19 Nov 2026 14:30:29 +0300, Denis Arefev wrote:
> dcss_dev_suspend() ignores the return value of
> drm_mode_config_helper_suspend(). On failure that helper rolls back its
> partial work (re-enables fbdev and polling) and leaves
> mode_config.suspend_state unset, i.e. the DRM side is not suspended.
> Continuing to suspend the context loader and disable the clocks then
> leaves the device in an inconsistent state.
> 
> [...]

Applied, thanks!

[1/1] drm: imx-dcss: Check return value of drm_mode_config_helper_suspend()
      commit: 8a6e49c8557d3ba0fe4c7f1cb7f428289b13bfed

Best regards,
-- 
Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

