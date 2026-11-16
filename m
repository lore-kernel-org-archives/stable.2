Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794865098;
	b=2WI1wnttU4gRSJyzqz4znroPWf9ok+Ss0pokdUZxWehZ9hj/BmOVjyoZ+0F361cj2SKI
	 msmJknpM5HxqjkioewSxi6SlxoTPiKaXnXjUUjwR8yXfbr1ZcS7y+Njd9WO0bkfVHfdBC
	 ByAhgdu0Qut/iQOV+1Vw//RSUuxtmQe6l7AiL0LznU2Hx0tB+29nkEkIeecQFoFPrpnXV
	 K4NoOBhac6kcCyScS7tDPs8ysWGgC+5psQNPHMU24FbR9zU1VOATwChcD3BJEDM4Ars+8
	 TRXdRtMqoQk3NUNS8P/EcZe/4hIF2rXg15KdwcRWKF3bmM0HlI2owucE8d0aRI5p/bg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794865098;
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
	bh=MiCOLM1CLXK0QXdudHmM8Em3RBX8TqgZAHwsxIQu7RE=;
	b=LbSl2I93aQfsTFSYbsF0/+zkEZP5jX000m6zRGHgii+rzCFTogJvQXsVY57sFYgHR2jC
	 NAV+cpSME15NXpEGwiqNfp1+vo9iZNPQVBUTZmRHhlSJiTXOKV6gBT/pgU583K8j1Ijdb
	 bJToY2gRPCKpGIpUn6h6+IL2b3X3jG7C+bERlhG4jq9rPDgn7dmPO56URqNVA9NIK4Ghn
	 qctFLkb3Q/g/TJWkKMW5Mq9/Q9Su9zqSfQgthKmotYH2gQP3hZrEax11NQHFObPt+z0WJ
	 06ynrhmABUKw87S4ruLWAH+eFVCw58RoWOcfkwMEPozcy69FT4CD1OMdP53t7XDRGfw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=pcZg0bdY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.44
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013044.outbound.protection.outlook.com [40.107.162.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9E8606A890;
	Mon, 16 Nov 2026 21:38:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A9E8606A890
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=pcZg0bdY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pyNWKiKICJtIDJ0R7bO0R0C1c/KLC/SYmt7M3L/HDJlLnMOuPqEG09EvLU12aNBaVvHCEiQqsNlQRoSrokFzd2NcoxyvRo/nul/LZi0G0xmz6VRWEGd4c+YxZB+3KJiiK2J9PAVA7DutBIjkTrYzb/wIsZIT5Aq7tBzMJ1Wnvh5PEcUA5pRAItNikxfqNxA/xQW96vzZvlwude0C6EfZFSFQkV24j3paqA+FlgoAWfs8CcvlAIofcc9/uR6pFbS8m0XY4orN/WhDadx9eVHP0q3NHQcjkqFbHyMugIWo5fAa7ghdSDG0aGeQkizhT98voUuUEEJkGEEchi7Hn2YDsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiCOLM1CLXK0QXdudHmM8Em3RBX8TqgZAHwsxIQu7RE=;
 b=fGr31skYPHmuS+ICR6FvimIsrHe7pYBplMIg9V9G/EArDhqNHgDh38mcmGCmGj5KDP6PvolZkY5CsCJRnOx4LV45XSaovQwgZxsyniz5vmdZ/PNbVRw0Npf1Jlb/W11trRvbVFWY9SDt23j/gEAq8Owd8mX03dJmAHNFDR2C1ocBpZzM2IavcDkgGL92HuRqYAKZlPLmdOVZxIO40xfUobX2Tlu1Ya/sdOOe+qgGoowXps2j6RJmT0Y6Wz+wGWaAiT11Yp05hP6ez06qd9Wpz4yfJjlfPwex/qYLbRBOeu0hbI93C5pDR8NQRfRXBtV+J5uOJzPnL/QKDrG9AqwPWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiCOLM1CLXK0QXdudHmM8Em3RBX8TqgZAHwsxIQu7RE=;
 b=pcZg0bdYrPIu+c6yrdmHnQahfOntP/pK29ptL3vKU5clz+yxISYN/4yh6MlILIF10f89XqtGLzf9eMpWZBwbac3YCRelNSFnzcMB1HaXRbAPgcHayT/A67cY/pluEK8d0zK+qrndfG0E+41ArxH3byHFEvxNhlZ0WQI4k4e2Q94C9RC0C1X6sK/q0m454BTO92JnNiDD2xW1UROMRmFBqx+4fnp8Sr7kcccXQtwUMGRftjhbpFij4mNeZH0YwDGmi8h3AO4MHwhfBO/KqsEa6HNjCx0qyBWjwqPrklHkqCE8i8MT/UrSYdM8devebOZKBAoH6sSm954DGJCc2t2A3g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GV1PR04MB10378.eurprd04.prod.outlook.com (2603:10a6:150:1d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 21:38:12 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Mon, 16 Nov 2026
 21:38:11 +0000
Date: Mon, 16 Nov 2026 15:38:00 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Pavan Kunapuli <pkunapuli@nvidia.com>,
	Dmitry Osipenko <digetx@gmail.com>,
	Rajesh Gumasta <rgumasta@nvidia.com>,
	Thierry Reding <treding@nvidia.com>,
	Akhil R <akhilrajeev@nvidia.com>, dmaengine@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: tegra: only advertise supported pause
 operations
Message-ID: <avt3uCyDpzDt25sb@SMW015318>
References: <20261109-submit-tegra186-dma-pause-caps-v1-v2-1-accf568bf0cc@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109-submit-tegra186-dma-pause-caps-v1-v2-1-accf568bf0cc@gmail.com>
X-ClientProxiedBy: PH8PR07CA0011.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::19) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GV1PR04MB10378:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f8cab8c-9dc2-45fa-f1af-08df4429e9d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|366016|7416014|376014|18002099003|22082099003|6133799003|11063799006|56012099006|261026121527099003|261026140227099003|261102123227099003|261022075727099003|261021123027099003|261022105027099003|261021121427099003|261009223027099003|261028144727099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	3OVZmRxhMok+ASA1sGoG9u1kj6yrF/r1HmxyhCSJpbORmzz4cpBO1uKs3y9MIj3d8au2hGtqKhX5tOnL4ZUZfRJOjVYfeo4v4iFzEldz1ZEGfEXQM/7NEsl+vHHVmCerQhIDPcIhULOan5a4JW0f4MxDZ2dUNLyL8CNaH+boW27IwRirtoQOH8zLrXRRYmXLfnOuUeMYmqT0htDf9sZ7aN1OlQrtgE8wT6J31RBdGl1e7WR5AOvyD1V4YH+PXZin5o91oa4a+YmuhhfLPSsrbubfCw6g0xY1lAOMlZdIikEerGgjen3f/67SQ7kBwGTmUw8hz09fwQtjozQIW9eHrMwFqShXEWauwSviKnou5nQUQTzGPR8d9SoocssWwu4/+D2u12+tSgH0pqp+wO8UV78dBDcTjG8qpmDZxTvuguGBhTjiSiflrMI1p75sNhc6833QbQvVMRTNeRvHTZePysh/kx214g2BqnnUP1Tyn3ageuFC6p9oyX3SJfu/CrF8knF9WwU3j0KBRWVlY+jIIaWQI8oJMODIc97Lw8/356tw4UCisAkvPAFi/ihaRxZ1dFW1zKJGG92wlMYY0IzTUQuBmwpdr9bH3WWi0c4G8leCBRYt1BShD905DGqUo2Qv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261102123227099003)(261022075727099003)(261021123027099003)(261022105027099003)(261021121427099003)(261009223027099003)(261028144727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HuLlG0LIJ1tIrZivL5IMTyBJzJvQiI7mPTPGi1M1ZFMrLxbT0A2q8zglbqWm?=
 =?us-ascii?Q?f/5dNrhWbvD1w0ryRYOiM1UjMjYke7+gF423pp80ZUBhn5uaJha+NQdonuMd?=
 =?us-ascii?Q?XvKvwckzvPGzJ6Gbr8c3/J7i6ATGKmg5Thv+a5J8hRZxidHey/ly5nxqfJ++?=
 =?us-ascii?Q?tM5SavEN/P9mPON7jf1y5qA/XkI9UDk0QlhDdPtgoGzBiPHo/LHVGZ1RJ98X?=
 =?us-ascii?Q?cPsat9XbSlTTh0U/49HJ1AbGsMI7aEvwxJmD1OL2/zRjegndaijlsb0KoKkO?=
 =?us-ascii?Q?4qBqhMvJz0AZ7ScIcULx+nLUCLH1ihZlOaONSubUZzq/aFtrylkAtGBN9jIH?=
 =?us-ascii?Q?wLGFmj+CXEMrkvIW7kDLzP6WarDO+wvlgZ3iVk41ra6jaQ7T3+1wtdOpsYzt?=
 =?us-ascii?Q?4QMunOgpPbwzsteS95u6aGhYgH14a6+aX8d2OMcp/wpb8J5ZqFfweaCrRXXX?=
 =?us-ascii?Q?VAwYptsgUcFY60UcTbh3M81a/IHLZhXE20MdYf8py47FxkV38IPcqyzTSY2B?=
 =?us-ascii?Q?kM4gtPXkxQzzxz5DrHfZkRUG3Adt8UxFIBlPfLOydVzy6TI8WJ0zNcf/PKZl?=
 =?us-ascii?Q?9Nh4yCCDbjGAT3/POVpQgG4bA68RuUXYzyl2dalhi8J7+WYLrJisDLnSbjZW?=
 =?us-ascii?Q?lcPKYsB27xK7vXwwZEVB4lOYuQN2WjDoZRsFxisf4WdEn1teUgY+ROK2zCYt?=
 =?us-ascii?Q?t+M7TGlCz/r15sn4nFuz+h5Ih8ioLTdR4IGL/ohg5+Wm1rW1lsXSBj0zxs9n?=
 =?us-ascii?Q?bOQeQ8j0VHKdRBE22Mtz65+SQcVUx5NiDGi8FT6joP02a2nDBE4Gq2cmYlXL?=
 =?us-ascii?Q?SoD+YD3WcCsOELsBjYMyFUHn0t9lgJelaVHTZdxAPkyqnPbJz3jxB0AyDSY/?=
 =?us-ascii?Q?+g1YWJs74gC0+9gJPlHoWZtIcFKTy11Uk5vLZPXtCmLZOqjT67wR4wbki/GE?=
 =?us-ascii?Q?oEAWaVWm2V3SLp7Yx8ON1QYpew8QpVI0g04XJYEWkj2bp7Z57Xp9/H7a/XZw?=
 =?us-ascii?Q?J+2V/yDzAivcePSi5fw1souOonoXt5bEKwTQVlmY9cWkRUPIHn42krHCaCET?=
 =?us-ascii?Q?4qI//kCgdAfkTpu2C0cuHTF+vAJuLXdAN1XEOyR3ep0iW2SyOcJHjYzpq7Vh?=
 =?us-ascii?Q?NJJH3I5J/mbW5pAirZuIaFBChT2H4fsRJpCc9ixATNkCV1+0fUzQm2f1Kt5w?=
 =?us-ascii?Q?fh3gomcuqL8dhJ0f3e0SvtuGiETyFNpmqdlJfPK62IMcLDnSgOwB3fabxVoG?=
 =?us-ascii?Q?jEw1ByNr6Yr/zFh6w6t4S7lLltTa9RiVFtY+K4Vaclt5cGKsDGmoVUwVMEnN?=
 =?us-ascii?Q?wjRHOxIJ9u/o1E7VwJ9tRAzEsljYBiDJmQpwgbNjuFqIucfHxy53B9jxGKh6?=
 =?us-ascii?Q?FTlKAB+sZPTet9vh6QLv06EO0AE6mp65lguh9pUEqsDEIKWBzPofsBmCMCKC?=
 =?us-ascii?Q?/uTGGNHTO2739OiqyJ6ORRTLtkp5apkQetdde/qSeA4yiXpNgCfBPd56j6p6?=
 =?us-ascii?Q?yc7Geucluu1h1+s5pHdei9AJRRG6fW8/Au174+IdH4xoNfdG+VfkZB0uCrLs?=
 =?us-ascii?Q?3l5TIbZzXGkS4lm5S8f9i6J8U/amaXDMUCRc5Lpikl+OMKWYkgl3O9DWEwM9?=
 =?us-ascii?Q?nnZUD7MAx0fcxi1Vc4yYLvkUruTzjNAMd9gRlrycVMxQ9Lvlr0aU2Ay535TD?=
 =?us-ascii?Q?CbUGE2BlywS85yTVsJrsVYe1si42iUNAdBPgx/ppL/6X65VAh73EO50w+Wmv?=
 =?us-ascii?Q?3GoToqEd/D9/8XPi7Qe4YYwhSxXz0Mjr0eJZmiQY0utIunBBoMoI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f8cab8c-9dc2-45fa-f1af-08df4429e9d9
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 21:38:11.9608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KGxC/6ayqdx237uz59Z1kQZ8iPbYbr5L5UUbKjAHiaVtm0adLQwhRakHbELfcywTeqQPfXeu4GOu13/HNiL5+xIqCRsDR0sBvnbpWc9oUFORFeKDND3zWqDE3ZSJe4HQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10378

On Mon, Nov 09, 2026 at 08:02:14PM -0700, James Hilliard wrote:
> Tegra186 does not support pausing a channel, but the driver installs
> device_pause and device_resume for every variant. Both callbacks return
> -ENOSYS on Tegra186.
>
> dma_get_slave_caps() derives cmd_pause and cmd_resume from the presence
> of these callbacks. Clients such as generic 8250 therefore accept RX DMA
> channels that cannot satisfy their pause requirement. A receive timeout
> then reaches an unsupported pause operation instead of being excluded
> when the channel capabilities are checked.
>
> Only install the pause and resume callbacks when the matched chip data
> advertises hardware support. Keep them available on Tegra194 and later,
> and remove their now-redundant checks for unsupported hardware.
>
> Fixes: ee17028009d4 ("dmaengine: tegra: Add tegra gpcdma driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> Changes in v2:
> - Remove the capability checks from the pause and resume callbacks now that
>   they are registered only on hardware that supports them.
> - Link to v1: https://patch.msgid.link/20261108-submit-tegra186-dma-pause-caps-v1-v1-1-9cc9b17a033d@gmail.com
>
> To: Laxman Dewangan <ldewangan@nvidia.com>
> To: Jon Hunter <jonathanh@nvidia.com>
> To: Vinod Koul <vkoul@kernel.org>
> To: Frank Li <Frank.Li@kernel.org>
> To: Thierry Reding <thierry.reding@kernel.org>
> To: Akhil R <akhilrajeev@nvidia.com>
> To: Pavan Kunapuli <pkunapuli@nvidia.com>
> To: Dmitry Osipenko <digetx@gmail.com>
> Cc: Thierry Reding <treding@nvidia.com>
> Cc: dmaengine@vger.kernel.org
> Cc: linux-tegra@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/dma/tegra186-gpc-dma.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
> index e76c58f213d8..bd606b71e714 100644
> --- a/drivers/dma/tegra186-gpc-dma.c
> +++ b/drivers/dma/tegra186-gpc-dma.c
> @@ -419,9 +419,6 @@ static int tegra_dma_device_pause(struct dma_chan *dc)
>  	unsigned long flags;
>  	int ret;
>
> -	if (!tdc->tdma->chip_data->hw_support_pause)
> -		return -ENOSYS;
> -
>  	spin_lock_irqsave(&tdc->vc.lock, flags);
>  	ret = tegra_dma_pause(tdc);
>  	spin_unlock_irqrestore(&tdc->vc.lock, flags);
> @@ -445,9 +442,6 @@ static int tegra_dma_device_resume(struct dma_chan *dc)
>  	struct tegra_dma_channel *tdc = to_tegra_dma_chan(dc);
>  	unsigned long flags;
>
> -	if (!tdc->tdma->chip_data->hw_support_pause)
> -		return -ENOSYS;
> -
>  	spin_lock_irqsave(&tdc->vc.lock, flags);
>  	tegra_dma_resume(tdc);
>  	spin_unlock_irqrestore(&tdc->vc.lock, flags);
> @@ -1518,8 +1512,10 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  	tdma->dma_dev.device_terminate_all = tegra_dma_terminate_all;
>  	tdma->dma_dev.device_tx_status = tegra_dma_tx_status;
>  	tdma->dma_dev.device_issue_pending = tegra_dma_issue_pending;
> -	tdma->dma_dev.device_pause = tegra_dma_device_pause;
> -	tdma->dma_dev.device_resume = tegra_dma_device_resume;
> +	if (cdata->hw_support_pause) {
> +		tdma->dma_dev.device_pause = tegra_dma_device_pause;
> +		tdma->dma_dev.device_resume = tegra_dma_device_resume;
> +	}
>  	tdma->dma_dev.device_synchronize = tegra_dma_chan_synchronize;
>  	tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
>
>
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261108-submit-tegra186-dma-pause-caps-v1-664d1320d502
>
> Best regards,
> --
> James Hilliard <james.hilliard1@gmail.com>
>
