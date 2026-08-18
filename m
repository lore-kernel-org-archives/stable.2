Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011019.outbound.protection.outlook.com [40.107.130.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8083B4E9F;
	Tue, 18 Aug 2026 16:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069577; cv=fail; b=KHRyICXyu7LvjQaGpzRlMMAAvrVQzYCpox942zoM+rlfsJMFhIQvE6o6udxf1G17nKnTrJvGnn0QgMeFvXIeuN1Zf8fB84a0pfNCfAJ3N2lAIZec0lZNfUS91qI7IhdpSbTaHczRGiiyYBaXPv/i94wcle0l/YeY4wVB3VwYrsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069577; c=relaxed/simple;
	bh=198VEYNNgpVR0YPUFUPS1MJ47DloDi5euLSld6mmWQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E7oQ7pO8oCoyH/GiG6PUxUX9ovMXGprpBrLOoLWkFaOMBHfJL6L0/M6TnUGvrUjosgFORQMbUkDKsY1kgvaLAPNkOpuLN1GRnYrS1iLjfPDm1IPS5u35879PLdWdFFPS2apRI8TwsI172H5C0IScxjTyKHzk2j3btp7951/VJgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=EAPRwQp0; arc=fail smtp.client-ip=40.107.130.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EAPRwQp0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIKB/CkGVAw9/Sej0iC0cF9MW+q7PKtHN18evtPFNwHxYtxdMoyOaqbXIS7/HTiTLkTwpVE2MPFDfWodWPrG1uuE1mMFfNN6WmLA34NiHttrx/ZKdYTqNBDdqN8/pLtvidvo8N9F0DhTk2B9fxM3xSsBVZ3Pqj2lWbvPpwodp44cjjcm/4IEqYQUiHK/oqQ36mp8HeWk25iMWXs9kLyc2boEW5KMdqxsg54Z08T+4aULfsev7ks4JERsDLdd2IBR+HW400S40cp5RcPm+P0WiyEEyzqVZDDelxbsylsQp5jLWrISZuk2e/uIiuCYfFl7Jdk1MyC4uBhTDnahS0UyHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sP8i2AmDHKuNhVDYnHQ9IkiKMU15+2EeWFL30ZtKsoU=;
 b=n1E3LQ6OuLiQX+EMrQ/1yI2ZI9DineeceAal5RHm0M39MhR1nfE4HV0caZAly8RSRgDfKXazxwJ/ku6Gly18F7/qGPf8LHFr2rk3jkPYUS37HteYYtsrR6oEQOeSyruadeK5Xvxbe9RHqY6WpgsAiajDMs+fpmmkfwlwhea7yAQKkOyN1NvUHnWtaTzATbOErhT2/DZRY4BmvWK+lMbNu49Kf/k6OmmTrN0D/0nrM1NlFVoV9n+1UIE6kIBz9GtoZUO9P3207PiYDGjTvvRhJAmlKLP57tYNeplLn+86bADpLziUcKMHnBhat4G7gImKQJti20Y8fnTAZhOqHviFoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sP8i2AmDHKuNhVDYnHQ9IkiKMU15+2EeWFL30ZtKsoU=;
 b=EAPRwQp0KPhYgWqZwxv7h/Gp/M46K0yGjfrCEVfOCZ9lKcH4xYLlLyfAEXkCk2YfbZpqZusFXPH0s218c4NE0hR31XFnNOMoBD3g5JoktRdeOuWui7U4Rphrx8kmbu8DojXdZgmWvqnle2Sw3dJSwiW+REcBPmuuYCIqWhPIfsucXdlqV5Zu84uQoBn95qnUi6Bcz26Ye1DMmcIXjhALzuDI6eqyzkgEzT520fL1C0fSVMwDY8Jk2vhapiylVI7yv+lO5uXGujI2GTa8Uys/4ojoZJjz3w1NbU717BBSphvdpMzhYaqSdZWwgf2ZKSCzJ2PMSxDzZRW5/c1MKMnhNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DBBPR04MB7963.eurprd04.prod.outlook.com (2603:10a6:10:1e1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 16:12:52 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 16:12:51 +0000
Date: Tue, 18 Aug 2026 11:12:43 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Shivank Garg <shivankg@amd.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v4 1/4] dmaengine: add dma_device_get() helper
Message-ID: <aoSEe2FujhG6J0iD@SMW015318>
References: <20260818-dmaengine-kref-fix-v4-0-c6ef991462a0@amd.com>
 <20260818-dmaengine-kref-fix-v4-1-c6ef991462a0@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-dmaengine-kref-fix-v4-1-c6ef991462a0@amd.com>
X-ClientProxiedBy: PH3PEPF000040A6.namprd05.prod.outlook.com
 (2603:10b6:518:1::55) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DBBPR04MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c13ef42-2db5-46e8-6dc9-08defd438d9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|23010399003|22082099003|18002099003|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	3XcoAycmERCkRdRqKvuxBCA10KzF41fmTSDfQIoGDuC5lc5jth1IAVq0tiiIEVLlMpXkO1ncRgB+AnneAl67ZBYUHxF92Chrxkm79TVLR3u5O0nI+xx+v51CvhLYlp9GICSd9KnutpBjiHe2KOteIA+61mVC0eculK6XJmuhNZnBrE7QbUDiBNJfFMCq2X/1YgXnpuGkmWzkUeyB1A4L33P87HWhgEElTcIQZsMdpbIVo5CBmc/xtLl17LfVQok2va1oAL684WBApT9wlyJO0EfeVSR4+1EVQWYjRtYAhSOpGp8IdNvoFSRGpwB21/UAt3INRbmt7bSTS60qHatK33tV2hWBjGpQnax0s8YcI1vNOguFw9pfSm+PcXy3D7btWn554sG7x1Ehhh7SwYsAzvScrUPxwIC9B0qHZMKCSHpHuWllPjnNmVZfoWJ18YUtYl4gK60An6zbhIzjLML37JonDb1fwtkDkKO3HWkrXvcF9z1A6H3V0I+ZLef7R90cnA0uRU/g83GOzjJ1ZJ79Aikfmhsw0cPTETNk/n2VwjYHCk9kyC7i4duOjM6esfdw00oK9CY7Y/RGca7DzN6JBXpsBvN11h/xc26yCPUEOUuZ16QCNsuN2E0SShqKBFYI2Lz26fI/jr4Uxyz/xU6nvj2Yof3DKe4IOaAluuo7GCo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(23010399003)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O0YjO+90GFLrDwyfJnBgAZzUxYp4JfdZtiCKFYAdQFQB+SQOP2wYZmP+sgrw?=
 =?us-ascii?Q?Lr/mcrtES8pqsrDS2zowndu6JQdWksWZSor9aJvqD21n9SR2yXBv3M+xDhVy?=
 =?us-ascii?Q?tgwSeJhBHvazxfuBFZoNWTv6sXtHSvSpGfXwvcLO++uCd79V0w2hPkZ4dr9M?=
 =?us-ascii?Q?9Z59ob05oGZZOIM4+b44/6Irf9EvCrCp5vTqh/D2svM4c/chCCsbtr15o71i?=
 =?us-ascii?Q?bKze/ZZtYs1Agd4Rq55I1bHxUUOTGz3miVRpOH8ilm9JBWF+6FiXG/PNfU2s?=
 =?us-ascii?Q?PT2kRYXCZFcApOL0kewAjn5WYPgJu+pUcSY821ZoJuDj/fJWKto5/+5uKyYh?=
 =?us-ascii?Q?Y3FKb6/inOvf4O0cRAjnxokpHnO9+G3cr8num6a4EzfgFN8usyjtX6auc53a?=
 =?us-ascii?Q?BWU2fBfNqqr66TJVm55WffLqvkqTDAjHAEiS0cW1vyKjrOSxkA3O5U5KiwIC?=
 =?us-ascii?Q?eN/No4Abb2nJphqLJElEl2z2iqcklS+WnWWcKiJ/CYjXJCD1YVrb5p33AbJZ?=
 =?us-ascii?Q?/0KOoA3OOMMARZRC+DBAO9A25RGLcdMUF9eu7FSUuKuf0YI5s356e9hCpBnc?=
 =?us-ascii?Q?uj5nVl+hJs1XMYZ9mVboDeFEu/v8gJ31b5EGOlkfp8AteVOqdxB7sI6PEo7z?=
 =?us-ascii?Q?iN/4P+DCNykaRr1n1wO+Qc+9Q56o/PjscqXK2ShSw0CI5jDQz/W6BAIbBsGi?=
 =?us-ascii?Q?lroZPzxDUIQLWKjx+82yOQx6aLwpLQ31MtrbfMvOLfMsFlIpWHrM2rltCh2c?=
 =?us-ascii?Q?rQ4CnzosX8JMeZQk+9KDHIw6btA+tIFGIMjkRMNqEoDcUy88of0O1s2HB/lE?=
 =?us-ascii?Q?kFITpqdTHyYsi8UchFo8/E+TKDliKNSm6SzFxaozegafLmB8fAywIREPx5+C?=
 =?us-ascii?Q?BbkMgHtwxLQA+Fo7cA8owAPoM4dDx6dqtyDWMQ4VoEkXE10TrBbwui922sa2?=
 =?us-ascii?Q?iNuTqO97kIf+EwaPLk5HmhDHDVfHYashmk4427vQZoTH6aPMqUHOna2V/DXg?=
 =?us-ascii?Q?LEGrIy1iI96qfr1lm1rihaxXu3yH3i9pWiWJ+KsryZP56wxKBz/TEXwRBQiZ?=
 =?us-ascii?Q?Dzn22N0vpag0n1aXttnES1bZSd+UCNaQzfEzJYEgyq9RKlbjeoXYpg6nlsQE?=
 =?us-ascii?Q?AqqV40XlYCISbSClHmWvLoCCtsWT9zUdBbG5cWnU4UtRJx7mn8qdLkiAXLV3?=
 =?us-ascii?Q?TSR1ggBmHmHCkT0x4YhUn7FYzILHAlbMvvPHuLhIK0d695IMlfgP2UDzFnk4?=
 =?us-ascii?Q?KX72m3rRo9CfifVg48Lq3kJFqp4oORQqMqpNScYJ8EWLUymsDSwVUiOWNnBj?=
 =?us-ascii?Q?EhrsaNH0mnwH7Zw7isy3xHZpeCg8bYnoZqtekiMmZCGS6/nyY9389JMNEuVd?=
 =?us-ascii?Q?+qNRCqpB3DaxdzTQpmpDnvWxlLBj4DRUp7Gt8hgg3uCzvjRGLZyPTxlGAFny?=
 =?us-ascii?Q?e4xJc0VLJK/+Hs4tmelqddlNzDZbW3HicseIbhstTYkWqsJJ8dv6Q3EImyak?=
 =?us-ascii?Q?nwTDjrfWtlH3oXJ1B8FER/KuWPacvA4rBWuIKx8k5327KZC0wqrU7xmsA9Z3?=
 =?us-ascii?Q?WCThADzdkPGFgHU2T/flSxRGwSlnabwbUE3U9FY8rptgn0REdhDU5W08kw1Q?=
 =?us-ascii?Q?EnGC4KSbao1/RoRAP/Q+2Vvt0/sqpZjhPNNiBh47YmsVS2XR163snCjILOgU?=
 =?us-ascii?Q?2Ef3/kwxOfSMc1YcA9KuTz/zugtn2AOXm+H6XxCA0nyycajXTvnjWdpu6sHE?=
 =?us-ascii?Q?Qg+k4oY3Scc1l0E0Dn3N+xsXr0KXMfgZAnjpSLtXSYsXydwLWUvH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c13ef42-2db5-46e8-6dc9-08defd438d9c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 16:12:51.7058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3lRewQ/TIXEN17E5JEAbu7cHciSH9Vm2+mMi7nk+U9OMku1KTx3r8ffbbjrJQ6ygbaJLTFCiVeF3Tbb46aagDmcj0wxMgVCnzHK7kGA2MPcxft3/TxQVOjntmsKcaBos
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7963

On Tue, Aug 18, 2026 at 03:43:45AM +0000, Shivank Garg wrote:
> Add dma_device_get() helper to match dma_device_put() to make code
> symmetric. It wraps open-coded kref_get_unless_zero() and asserts that
> dma_list_mutex is held, matching its put counterpart.
>
> No functional change intended.
>
> Suggested-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Shivank Garg <shivankg@amd.com>
> ---
>  drivers/dma/dmaengine.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 6ffd8bd82154..77638dc16e71 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -433,6 +433,12 @@ static void dma_device_release(struct kref *ref)
>  		device->device_release(device);
>  }
>
> +static bool dma_device_get(struct dma_device *device)

Please the same return type of kref_get_unless_zero(),

it should be int.

Frank

> +{
> +	lockdep_assert_held(&dma_list_mutex);
> +	return kref_get_unless_zero(&device->ref);
> +}
> +
>  static void dma_device_put(struct dma_device *device)
>  {
>  	lockdep_assert_held(&dma_list_mutex);
> @@ -460,8 +466,7 @@ static int dma_chan_get(struct dma_chan *chan)
>  	if (!try_module_get(owner))
>  		return -ENODEV;
>
> -	ret = kref_get_unless_zero(&chan->device->ref);
> -	if (!ret) {
> +	if (!dma_device_get(chan->device)) {
>  		ret = -ENODEV;
>  		goto module_put_out;
>  	}
>
> --
> 2.43.0
>
