Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013065.outbound.protection.outlook.com [40.107.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F08340406;
	Mon, 14 Sep 2026 05:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789364364; cv=fail; b=EBWazsrQI71rqyGwQ1CkRriGlTps1ed9TaQyLmAENHGmSMSbW2Lxp4W77mCYd2WK5c5BVVl+YbTR9jLKY0nvgZayptLusOfSaHbjdSsOk1hSltWSBljcxJoIpe3eQXqFERIAlXEs63lqCnfsAUQFRpXr5z1fula2DNNhqJlhUMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789364364; c=relaxed/simple;
	bh=5XEFi1O/spZ7OGdJUNk430I94OiIeA1iu8mndvfmkoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y1fYgg9QSWuk0qrwn/HuksDGlkpKY//x/7zLZriJ07K35WjOklEn734gGjR6ga+5JRaClLMkCdVplMj2twKWhz7Hz9tg1ccN5d2LkyvTDolwz6iM7MHdA3nI7R+iCq7PqhUt5ISgmsp5v9eTWy0GY19blhEdDWzCX5IsHJJOqbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TCNduUTT; arc=fail smtp.client-ip=40.107.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TCNduUTT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYT6UX1wR3Dn55nAvzMx+fmHcEnsiV+tkUvEXGHGQ77neBT7r4rjar+M0IB0tBS4QRLOCxcBbEp3VfCwnrB+bDHuwrEFm2AJ5YTF7MaRrzsSSkYWpIhYKtKWPQ9iaBamPSS32MMtDS/AZPVbuQ55tOKuxIUfv5/f8VUdxg1nNSj0mRv9a0vgcXcDSPiEyTXK6jF23fbhfbWNhWqMlrqJHcYvHkHlwHpRCkLCVLwzNXMuWJV9Fl7CaBlV11gmGyrlmOXALAfhXGoLY9JJ1j0vr8Agm2EvyPJbg3EHnkWH1a8pYRUa8Qls9vFxAx/6PNC7BmrTG1F0m7/UlfWe0huijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vju8Kajksj2hTe3/hdgTgsJK9wb4LtMwQ8vdB1Xbdy8=;
 b=bYjHeyT1qKCL3y07yac+HN4/7CoztLRVWbDsUOehdhkUtOWo1fnPdeoVaStBK5Ougc/kPRgvVduCZQNTPaxlZ7+iy1xu0BGEtya/ZYp/KZ84nrJFN1hhQjsBuWBSHjfaEZwN3ko43LlbKiYAh3fh6RCrcKKs+C5wezXurtzvNhLS3e2ZkQzO8y3S8kYdFILhE0xWwRPNriB3MEk7Ebm9shY+ZJJyMtc8M3L4y/ZYCpyHaU2sAjMQzzl3+eU2s/PEIEOTzkBY4o038EALbUI8SXdx45EYyOW7F4ozmcUS8aSOM69qDVJhCIrq29wQWYrR6DW0azCyLDb274PGjHB+CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vju8Kajksj2hTe3/hdgTgsJK9wb4LtMwQ8vdB1Xbdy8=;
 b=TCNduUTT+vU62sK6qSObeSveDWG0xPtFiKAqShlUd+5CMJTJefOg70tBYs0qhRON8Y6QpLdRb+D1Qwl+UwyAGFBsoacgscC2jMo7u/5/uP4iN2aHXz+lGRlVWxpSeYDfY2W9p7ZW5tT2ft9tgyx90/yYSt7yGc4Or5h8XtycvO0hs+98NE4IM5FufXP0I++9feEXiaD8lmRAB9QrbIBV2i8C0q8YbrNIfVIndFs0bSzeGZzxrhnsUEexjdrsiBdTVtt7BQKDtaGUN5m/tPHab3NMTHQLMbd9tAegWlfqJGXbGjEfTYEqR3eVaDCd6J1CcceuI/BGBuizl66N3nP7TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by BL1PR12MB5922.namprd12.prod.outlook.com (2603:10b6:208:399::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 05:39:20 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 05:39:20 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Osipenko <digetx@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Guangshuo Li <lgs201920130244@gmail.com>
Cc: Guangshuo Li <lgs201920130244@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] gpu: host1x: fix runtime PM reference leak on remove
Date: Mon, 14 Sep 2026 14:39:16 +0900
Message-ID: <UqvaHP03S_-FFGTtKijH0w@nvidia.com>
In-Reply-To: <20260913120227.1559129-1-lgs201920130244@gmail.com>
References: <20260913120227.1559129-1-lgs201920130244@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4PR01CA0054.jpnprd01.prod.outlook.com
 (2603:1096:405:372::8) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|BL1PR12MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: 79911ef6-ea79-4755-9e8b-08df12228626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|10070799003|6133799003|22082099003|18002099003|10067099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	boU/QaCehF7gttqwBhOfqolFJlGJ4/4mtloZSdNld8Gvls8OugaKRPQLZylOxTCYxEUF2R+x7OFY36fEe23Hpc0qMd+aXhJ4A3b7xxfTGS5BYYHzTbkYoVLAzSvROg6u3OYMvvqywDmHse6vd0FlATys54E7I1S0fajxHyLcGa47nmjAqlMGc/YEqjmLCwIlTS5lJfqCVv6DpkHCtuQ9LdvBfepey8n1q3AdFucV3TbWYz98U4LrbJjwzaT/to5Mz77vnP54qHP6crSTyt2zn9dMwWXoMnDMrORQmZhZ/OCsI20YZrFFN7bqy5B4Ue9L2OFEo4f3+8sLs3Q7t9F2p1Xb6kdDjOq9IDohtEb4DUsjpGudSm6MYthzTG80uMkHVrfsn8yqz18XXL0UniNeaGs6nXDJh0vq0VhxzOll7pZwaREjK/uhuru+sfrPxMtnx8ih7nuQzeIPvq1as5uzicLvW6ygd6uG0LG76odhMZkJ/U7e0VIhEle6qMugouswr/C7nmEzb1gpXpOzlOmtuW2rZ4z4Gej3S/WwNSouyKsBd2jKHmgRwqDLJSCdZpGUX3y+sdz2c/7U1zhDgiZIiVcQayw//atHTl+q5lvkbCDatFQECLhEcaDT6xGzB9P7sGDK1EFeq0e/k5YcT9/HenDqUPLY/T+bIeQuhghc6yo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(10070799003)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFdzZHdoRlI3MFpUWUhsay92WU1CN2JtR2J5Yk0wdzZtc3VGVHdCTWNYUjlu?=
 =?utf-8?B?TGtCUEU2YU9DTHZnQnVTdFJMNlZEaTBRZVBqN3A0RUZ5K2xsZjZxQVFRamEy?=
 =?utf-8?B?UnRSa1hVbFErNFJuaHFGV0c3ZGl2YlV3Y0xhWXU3OWVvc0ZndEVyWXRPRjc5?=
 =?utf-8?B?QnBJaGR1TzBNRVlad3UrWi9LQ3NPWUxEVVhacFNmaGtYV2toSmRFS3ZRSENB?=
 =?utf-8?B?OU9QdGcvT2VhZXd5NXpyT0xTS0tLbWdaRUs4TUN6azNQUHBWVk13WFhqckFr?=
 =?utf-8?B?SHQxS3Raa1ZQRC8yckhrcm4wNXNFSnZmZUJVZXNJL2cxbTFpK2lsVUtuWmZY?=
 =?utf-8?B?V00wUFVJZTRYM0ZKVlJDNFg5OVFTVHdLMFpQdFBuQUlnbVVHKzB6bHhSalIx?=
 =?utf-8?B?MXQydmNQbHpsNW9VU2ZOUTNlT0NPTGlxYUQ3TGJnOXpnbDJyVEtJL2ZGZXdv?=
 =?utf-8?B?ZkMwUGNTSXJNN1gzUGdYSHg4LzBKU2JHdlhUdjFQcFkvOE1LZkFTYVMxaGc0?=
 =?utf-8?B?ZjFaaUhRU3RXQkZ6OHdwS0F0aUZLT3RxRnFhbzYvNEI1dThqZkwrRjZ3SVVj?=
 =?utf-8?B?REpNMGNBWGdqdUxJbXVYZ3RLQTlBbDhNT0RTQVR6YVJpSVVJV3JqQlo2K1h2?=
 =?utf-8?B?YmtqRERFam54MTN3cElIZHR2RTJBajZSakU0N0NML24rSHBjKzN3VWNIVkpR?=
 =?utf-8?B?V2ZLQXIwOG42dVZPdVZDL3B2bmZQdkJ5NUozaGNkTTlYbE1XdzdzaUxnK0Z6?=
 =?utf-8?B?ZWI2QWphejM4Y3hxRWhhTTBDcUNaSDdUSzE1S2tsOXNQSWFQbW4wOTM0N1pB?=
 =?utf-8?B?cGRyK0I2c1NZNDVYZzVqSHNYb1ZLaUFITUVqSkpYOVVYUmVaTnNxUVBjcDY3?=
 =?utf-8?B?M0o4R3ZmREJPaTlIVHNHMmRQVHJvUmFOcDNrZ200VjBLc0hyUktFTXlSL3VC?=
 =?utf-8?B?ZGpqcUF6WThOb2ZFOFIvNnRzUS83WkFqZjUrRnRWWDA5d09jMWRwT0dFc3RC?=
 =?utf-8?B?VzJEWTQweENKZnV2cW4ySFVKKzhIWnNyQTk3N0syQzVHRHhGelEzN0NYQk9N?=
 =?utf-8?B?ZnF0bGRZYmZIRTdaUEc1K3JkSGM0UGJPTmEwSG1LMHhFMm9uN1IxTWFTWDZ3?=
 =?utf-8?B?cU5paDdqUENtWmRFM0JHb0RmcitRUGwvSTY2U3MyOC94NVJjdTVsamUyS2l3?=
 =?utf-8?B?dENlbk9KbFBCVUQxOUtFNHNKaEU3bEYxYlpZcG5aeGkxQ2VUS2U3c0RLQTBO?=
 =?utf-8?B?ZGM1eDk2eVoydDdLY0luVmt3OGNLd1lmdHRRYkwyUWkzSEl4dWtWUmw3eEFP?=
 =?utf-8?B?Y2tadFExMFRGSXhkQlVWWEpyckYrL3N0L20vQitCTlgzdFdUamJILzVsblpj?=
 =?utf-8?B?enl3WHU1a00wSExpZ01lTEhnRWNZaGozNzd3c3ZmN2ErWTRmK1cwOXdtVGp3?=
 =?utf-8?B?THBMM0ZsdjVJdzE5ZkQrQVVsYkRzTWhJbGs4SkNpSnNiRnBDRko3RU1IVmJa?=
 =?utf-8?B?aEkyNUNYRThNYlhtMloyL05acStMb2xXZ1hqSzdKaEE1RnlsZ1doVnFLbWVX?=
 =?utf-8?B?dXVndjd4WUNtMHFKaTQyRUpOVmtuaUhPaS9ma1dFYzZBdGVtRlUwdUIwbTNZ?=
 =?utf-8?B?cjdsMHVZS2ZTSDBWWWNDMGExaXh0aUVhRlQwejBOU3dNcmRDQjZMMUlrNjNx?=
 =?utf-8?B?MjdHU1U3Ri9OTHJXWjdXREczbFFaSHpkdUxWL3lSR3RYM2c2VW9tL0diakVG?=
 =?utf-8?B?ODlPNFZpYnN2NVhkZWsvb2VlaEsxQ3RhTlJCR3VLWlV0Z09HRE43ZURZbzRU?=
 =?utf-8?B?a053S2Qza01IMjF3YWJ0UWJSY29qTHJVRWxhSWdVYWFuSEhuRHNnS1VXNytp?=
 =?utf-8?B?Yk9meElmQ3o3dnJmMWE4RUN2aHlCK3liUUpmblpIYmxoekZkTVN4SHFpRFJp?=
 =?utf-8?B?ZzVUMWo4Qk5QbW9lbVBRR0haa2lsQkV1ZXdsdTFVN0NPKzAyYWwyTzVNY0t6?=
 =?utf-8?B?cEdEN0QyOVphZ1hERGpCd0JrME00aGZGMmZsaDVZdWlJU05yZnNSSS9keGJU?=
 =?utf-8?B?anBIL0lDRnp5RklvaGZlMVVsRWVNYUpPTW0zNE8xWVVlanZrbEViVWZheVo5?=
 =?utf-8?B?Z1lMSFUxSE5TUU03Q0p5ODdKbVJpNDJNY0RDTTN4MXpDTFl1VmpJVkw2aEU2?=
 =?utf-8?B?bHJkMlhQWDZoSmw0WkdCZyt4cVh3dUtqSFNJZjh6WmoyeVAxMEtRRzlRZ2tH?=
 =?utf-8?B?WmFzdUJjdERTOWRjWTlUcVZNalp6d1ZWVmFtQzJBbTdSZVlqaGRRUGl0aTcv?=
 =?utf-8?B?TDFOcFgyN0wxVTgvWkRzRERUcXRzTWQxQXZtNU9DdTR6NTJjM3RKbE5EMkUy?=
 =?utf-8?Q?WDf5lMdkNosZ1p1xF1dC2/XTZpn6M+hOjwydqbanhA/bY?=
X-MS-Exchange-AntiSpam-MessageData-1: n+BEnA7XVENQtQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79911ef6-ea79-4755-9e8b-08df12228626
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 05:39:19.9864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V37uBx6JTgmtXBh2OAfXCZv4Cz4y7vp7053GskPUg6Fhhn2nNgxJWquPGy8CoYrhSVAznkZd8jVL2ZQLBljbLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5922

On Sunday, September 13, 2026 9:02=E2=80=AFPM Guangshuo Li wrote:
> host1x_probe() calls pm_runtime_resume_and_get() and intentionally keeps
> the runtime PM usage reference for the lifetime of the driver because
> host1x is not yet ready for dynamic runtime PM.
>=20
> The probe error path drops this reference with
> pm_runtime_put_sync_suspend(), but the remove path only calls
> pm_runtime_force_suspend().
>=20
> pm_runtime_force_suspend() disables runtime PM and invokes the runtime
> suspend callback when necessary, but it does not decrement the runtime
> PM usage counter. As a result, the reference acquired by
> pm_runtime_resume_and_get() remains held after the driver is unbound.
> Repeated bind and unbind cycles can therefore leave the runtime PM
> usage counter increasingly unbalanced.
>=20
> Drop the usage reference with pm_runtime_put_sync_suspend() before
> forcing the device into suspend during removal.
>=20
> This issue was found by manual code inspection.
>=20
> Fixes: 6b6776e2ab8a ("gpu: host1x: Add initial runtime PM and OPP support=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/gpu/host1x/dev.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
> index d2c64728f804..bb6a1647e4db 100644
> --- a/drivers/gpu/host1x/dev.c
> +++ b/drivers/gpu/host1x/dev.c
> @@ -729,6 +729,7 @@ static void host1x_remove(struct platform_device *pde=
v)
>  	host1x_unregister(host);
>  	host1x_debug_deinit(host);
> =20
> +	pm_runtime_put_sync_suspend(&pdev->dev);
>  	pm_runtime_force_suspend(&pdev->dev);

After the pm_runtime_put_sync_suspend, the device should always be=20
suspended, so I think we should also replace the call to=20
pm_runtime_force_suspend with a pm_runtime_disable.

Thank you!
Mikko

> =20
>  	host1x_intr_deinit(host);
> --=20
> 2.43.0
>=20
>=20




