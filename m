Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010025.outbound.protection.outlook.com [52.101.229.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0318433C19E;
	Fri, 18 Sep 2026 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789696545; cv=fail; b=nO5EBZ7lVNANYbHV7JOTQpwm5/f/JejXNJOe/cPP/86LbkshAsKC7kFRiyfP7mnTTHLvfYaH+nG6DJc6oBm2HS8m0IkME7DYxGK254BySvnvSfB4sr2mnuv66hwz9DJI9SVmc8RclXWzYSkD5I7rscUNf0eeDLiEsKRwwj1pg4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789696545; c=relaxed/simple;
	bh=G8iN+Wccm3AX9BfcTFwPskjuO5IzHDEWal2N4ONqvd4=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=FkvK/3s+meFE4/bYyaW+Ih/ENzzWyT5ODWiv3Y6xwnpfdimXyZSNv4Aa9rdNvlJIXXhuB+12V7upWP9xMLix2bXE3wsggLojbifnjzOwvCP5UgxXBIK6mvpqowyqlHL2NrQCCIlqIAZ2zaQmvWX0I9pvkRh3fw01oKUiKs2xdUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=W+vqo9IT; arc=fail smtp.client-ip=52.101.229.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="W+vqo9IT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wtTIbbj4YQh00dAM/l4Irsgjr9YXlH/oZJSYhYNrrXbfvIzL6b0LcUsc9KpxFPSCQgZGMdv5hExAKptUxrnYwJkw5Idf79yYYnFN2xJGYFB6z0kWBD6Veh6wSRmy1B1YoA5L65ecRtTBmHL6ztkyvb6ULddrw8NRG/+HRJgrE/9m2vwr0BPNk+qqnokW+dwSCuWM2hgQUquW9+m7LSbvndg+z/M4GNt/Loxgnu2TMayxxvwHzxrYN2UUsxQY1QkQzDsHePNZdobNVbUWvHxIzzp49irBl9c2lQXnmOj7or2mvQDaE5TeLXwhMuSRfCaZjDETorBdcP9OlbCwHv3QSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hsARXNd9pdG7gmgwRs94sgS3E2H0Q7mUzOwK4Od9eTw=;
 b=BWgYyGftj8dVu+ilFLRbW5BlbAao/fs8r/5BgsMOzgwnh6Kbma73cEEJrybKf27dXSRqosYd3KwSvad4ed856gZ/x5vKHcDSqPShgKs8Y6/dFm1bRId9BD5HGECBX5baIw2fyMpvtU7WHoQW6csHalaw7cP4QvC+LQAONP/bwy2gyjfqhuiCV11Lw2+VjIFSwDoZ7E5RKHk19hTE/kXGKLuqiRlOmUK489h2miCmqwqN6s7EkZ+uOjX9c7gDknMqaf9tHv1mofsF0hx5Jn7k1SqljaCUkGvN7xdyzTXjjsw32Tnweaosv7psaS5YIKduZV/suvRpZ/Xok22CueP1UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsARXNd9pdG7gmgwRs94sgS3E2H0Q7mUzOwK4Od9eTw=;
 b=W+vqo9ITvZQmI7e521MquRIQ2wTOTjocNQWHasun281xyR4a7ZaezTDutAnKP734jv8vRXUvSscpFyRwN8Du7Fy17Dj52Tml79Po5Bf0Awlt+5jAyBRVScqmFjlAzsGYKGpBbyeNfq+vxIYi60cZDX6KQKJ/KeXpSYpIJs/R47U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYYPR01MB14118.jpnprd01.prod.outlook.com
 (2603:1096:405:214::12) by TYRPR01MB15632.jpnprd01.prod.outlook.com
 (2603:1096:405:285::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 01:55:33 +0000
Received: from TYYPR01MB14118.jpnprd01.prod.outlook.com
 ([fe80::846f:9035:6a33:1f45]) by TYYPR01MB14118.jpnprd01.prod.outlook.com
 ([fe80::846f:9035:6a33:1f45%6]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 01:55:33 +0000
Message-ID: <87a4pfjpbe.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: broonie@kernel.org,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: audio-graph-card2: Fix use-after-free in audio_graph2_link_c2c()
In-Reply-To: <20260917165851.2163548-1-vulab@iscas.ac.cn>
References: <20260917165851.2163548-1-vulab@iscas.ac.cn>
User-Agent: Wanderlust/2.15.9 Emacs/30.2 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Fri, 18 Sep 2026 01:55:33 +0000
X-ClientProxiedBy: TYCP301CA0060.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:384::9) To TYYPR01MB14118.jpnprd01.prod.outlook.com
 (2603:1096:405:214::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYYPR01MB14118:EE_|TYRPR01MB15632:EE_
X-MS-Office365-Filtering-Correlation-Id: bdfb043f-9f35-4fac-fe4e-08df1527ed03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|23010399003|22082099003|18002099003|11063799006|10067099003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	58oP6tgUrGteyjiHcu0hAEM6d9zUvhpFBkvxzZORnAUJ3FJs63HIHmpFIYSXxnICtDzaKJ2sh2i2BWtzGxrMiEpiwkYSkZLndZ20Ryz1U078wvLj0I3CyCFMDfBgP7fao90PTQymn+JRcoMcBi/bMY+LLa/Kj9Df7hsBXWi4U+XGqoXbStsxnSzKbIWrQ8HUKqZRg5moFGZvASH0D6kS+Ia8io2nWCCdqrzXUzvMTvhCDZciwjkME/j+OBtTt6yHmgRWnyJElEYedJZfR9GjDKrUHY9YwWuBbATqzUqapURBgkStl78AMewzCJuaMckGIjeVn+lu8QXolSpacy1+XhNxDk4m34E4/+5sDJPSk9axlYcS1lb2o9tmq0YnafdH7UFJASsYwt6Q65v2VWuDKshux8iMYThlDXuEOwaEN0rMpeeUhhcpBycfc1z7wPEmwW5y5kirX+vobXhXL3eOlZpm4itiNa9SfKefCbb40wIrTfoaxc4+gY+iWnUSlNtqIQJKLLygpMU3DTjQLVg6l4FADQU/t3/jF/lHp581GJzi//ojaOuj/jgAI/m/0Lwz+8YoYL8y9fgmzzINdRoJM/n6Wou9VDmg79tlNcFTIFPu9A1C2S6CnuxfemjaVEK7h6aUpaU/w1wgZx6Onz1pB9vpNKDRd6g3TYbdzJqMDin/OcioI4abOIFexcaIipJ0XiWz+ZIYiejAhAy6jzjMp6Jd8t9kTZwuge9+uTgV0Nw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB14118.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nWEBzC/9vEXEqiej2rAshytx1V/8PMnQrdChlOGAQxO0LQf7K+G44lm/ESXn?=
 =?us-ascii?Q?LLRAGB/3vIEQD0zzlUwJn4wzbSAuMboS2PHjwKFD/gVmXwX3rm3yoigskSmo?=
 =?us-ascii?Q?PNAK0qN3SOF0gL7OLkyaDGTEofzXVnnpzIOOfuId2uXmEeleu75BP0uY+NkA?=
 =?us-ascii?Q?7wEINumcBnwu/4iXrIEGeQN8t1iHf91SEeijRfdCNkTylcVvCtfdVpODbZtK?=
 =?us-ascii?Q?UodR8KeAO6xOHn2uteLiN3Vw2QXp/7EgArautvvxAApLDVV8GI4hWW8By8KL?=
 =?us-ascii?Q?wqN/c7HhUHd4anYiNr/WKSoGpVCPVUlV1CmViJ/KelARXrBSGplZM8cgBAbF?=
 =?us-ascii?Q?W2v4oHQwHJWI9Uj5Vn04ZoB4UVSh2eYzb2jbcBog2PmtZ1mZnaUscGQpT4Vu?=
 =?us-ascii?Q?OX9rrFhApi6TZuK7fV+/hHplqn84H336WNjWRQLquc83s7UOnhdhJByl49uk?=
 =?us-ascii?Q?DBe8ZeASPy1Q1NLq3can9oSmmv3eUNYNcmxT4yqx92LusRo497i9crI2r7kx?=
 =?us-ascii?Q?XTVcJGGnKMQbk7KbNWv8ULFUS/GFUKZqHRCIb6Rce21rMFWSVcIFLELIEjUv?=
 =?us-ascii?Q?nmWDdva7XYiqi3K0chwvsMKnlYSP75DiD2WX46rUF+KnC8d2j+h64nH8pgHX?=
 =?us-ascii?Q?4vhUC+wBmG+6KJI/SDki8aFFNkOUjsgcuOWqmyTY0EV5AIfoHBdVODbXdjAj?=
 =?us-ascii?Q?pJaE8ZhjSR//8HVgC0aARUuxBgnpezDXxLo4sJtqMMKqhq2bDbr/3Zx7dAxd?=
 =?us-ascii?Q?gyZEODQLQNZZuIoVu18YCFRtZfLNfZEITNnCZlUVMGovDdnq9BtSyEXDIXlt?=
 =?us-ascii?Q?JOUSGHDpfNtQKEg2wLtHCit9Dn7JzLLoUb+7P2FMuREQk8W2YBMrP66J2EaE?=
 =?us-ascii?Q?/s4lrDgGjkWh4jfBdbpXg+zBTIqEIkc/rWI1dylSFm5GBFkUqRIDpVc3oMbB?=
 =?us-ascii?Q?VmvTJL24aJu/JVxOgKRABzkDe6qemjzqzL7mAGYRocMXUiK3wg617vWoWGu1?=
 =?us-ascii?Q?MKNBwJYCyCSxa/pUXcjinRsmvZmHgZuyTRSfY8PpxwztiI9a6XcQXSVRx+7m?=
 =?us-ascii?Q?SOyZtmi1qFaoYojFhuHaM6WgF3ON1Wx+cgDpHHz0pdNvgoGSH/txNN7RmWpJ?=
 =?us-ascii?Q?fBVAswx/kgqiXuW61eopisGF9c5tlyL0wGKnYKTHYaOD+3uGO3nsJnqzJj+6?=
 =?us-ascii?Q?ixjkMZjuyG96qqfBqf7pt8BLBP0/wdffi+fZa2u6jA0N1E2BoUIOTnhEml59?=
 =?us-ascii?Q?uychCXd+TpqWaKpOSe5xh9CFCtbLL/Wt2pS7qfyCU519d0fa85pC3KvuXaor?=
 =?us-ascii?Q?3hNQ4hvWVgWMI8mlNhP2mc9oygTuJznykKjLYgP3jocB3S0KH8IfjV4hCix5?=
 =?us-ascii?Q?W8/EZz0kE3Ln67aTJr6fKuy+6tL+fJRLt2pB6JVHtu3ecitnma3wCGbXg3LZ?=
 =?us-ascii?Q?DTP8NPSoTkeL5MxhBwnONDQhmoXd99ZPnjVt/TmqTcDOJXLlF6V+L7jPiRap?=
 =?us-ascii?Q?8bW0qe7Yqk38moGtJyOzBI0oiy+aO5zv1eG16TAPh9BCAsWlxlyiV3h0yh/m?=
 =?us-ascii?Q?lj2IZH1FGpLrpoFQKCTKzZrmYqEwGaCYUC4LHGku0TBNnGJT7rjgI006T5xY?=
 =?us-ascii?Q?5Y/RK6qhW2hOYi2G/gs+3ALXBN4zdZCRZQpRa3IRK32sKiFrHLiE3PKz2mpw?=
 =?us-ascii?Q?PwpyMv/zXadKPItRJwzxYOcMgDEJGmY0NKPJtCxreXdHE78YVyjRosBBLndw?=
 =?us-ascii?Q?TGeaOL93azuFk3VWkh/gGw+lcveZXbE6Li1F+Qrs9PzOm0VNOS0q?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdfb043f-9f35-4fac-fe4e-08df1527ed03
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB14118.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 01:55:33.6062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkPGfXsXSSzmlb8186+0ZbB7OY3hgtwTw/cH13ja1qBThDXjScmtoD9EegpQA21vzTvlngVMaf8QwLz28TBccVuvLmEvDx60Wz5s8xHLvU8j95DfVEZJcai4JD3ZrmZ3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15632


Hi Wentao

> of_graph_get_next_port() consumes the reference of its prev argument.
> port0 is only borrowed from the caller's iterator, so the call drops a
> reference the function does not own, and port0 is dereferenced again
> afterwards. Pass an extra reference, as graph_count_c2c() does, so the
> reference the callee consumes is the one taken here.
> 
> Fixes: 5f281c3e82b1 ("ASoC: audio-graph-card2: use __free(device_node) for device node")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
(snip)
> -	struct device_node *port1 __free(device_node) = of_graph_get_next_port(ports, port0);
> +	struct device_node *port1 __free(device_node) =
> +		of_graph_get_next_port(ports, of_node_get(port0));

Ah, yes indeed.

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>


Thank you for your help !!

Best regards
---
Kuninori Morimoto
