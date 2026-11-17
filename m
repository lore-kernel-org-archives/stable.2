Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794944461;
	b=rEQ3THz4+5MGhpwqHmH6wVdwN1tZERXp5yILBWbB5GyEMCKtRmxRn94IL9tfjjbtdoHV
	 jaWbXy725yAcWjYdWxmNpKdrUFYAxWoV4siew7RtrBv2nqbZ5RdhfN6syUogg8t3Px9bW
	 g7B8mEvm0haYtI3TTxzFwM4m1PLhBUP/TTRLt2CjVgfQCL7W1Sv+dGLe21MJqcvgtLPhu
	 Jr039JyZY3RdWmxRPFvQ2Zk4t/8KWRdZwCe1K2WQt3ccUgpEb/0MuGEmwTyIl/5jGisIO
	 5SrARSL/xrYIvY+42AGUYyZ7KaaOaa6mu71VsPYhB7sl6CEpOcZRoekCMXi77+fIfLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794944461;
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
	bh=kc80e+FJ9evYbB4alfAxgRQo/Vu2Gn00hFmla7mEPIc=;
	b=OT1iUm73ZE6KePoDVWFTaXBq1HYFPm11phL95pgJ8VgOEChxJYKU6hmvui2K69zbxH63
	 JqlZaKidJusIYffdnv02DOBog8nD7Mmpzq6IxcX54tBOe+c/vn4Q6BIu6lxOAOnJnXXhj
	 eytnGJeafuIly+d8K8HR23tf/gB1HwSBhhxo7wGLs2S40tTCNmX57P3S+4PeCyFsavwv3
	 7ZAMVdprJs1bc8zGYyxOmubYV61+Oo89IXzvU3DcBfWwNhQt1cXRAkmxM3pt78+oSMXzn
	 TR37iP+AkGYANuTpv2JslIaWOEef49VvMZRkgrPvM4Ce/6acSdzxkZzpDpCHi0Uqidg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=JYUjOfg6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.37
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9D0606A31C;
	Tue, 17 Nov 2026 19:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD9D0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=JYUjOfg6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5A3QBlUJE1O6IY10gGB8Fal7sEEM+cQquVeYr+Z/OW1KUb6cNwal3dbO3B08Ir2CazDnFPjVrGJH3t62XLiUhaxNPwN+CkDFPv4c8DiLeBDUh5b67UppEj0GoV4cTPwKJrSRm7jahA611UNXw1ImcAEyQ9T355584MRl3qSdBw0VEmwwI3UYN7CRAn9GKyctql/RoZTY9e7qipKIqG6U2RxCs/k8aVrkviEdI0YoKWO17NhjnkDkeyjVKgIxX5TCnS3GsuUd6oFzpRFOjkoTJie5X0L7ehYBRf2Boc78OKTzJO/vbPtD4Qmy8FjNkiktATWMpJ+qS5MF6aMkyN+jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kc80e+FJ9evYbB4alfAxgRQo/Vu2Gn00hFmla7mEPIc=;
 b=BYUi0Bdqb6xu8n3djThtgYswuzf9E2uDM1kZVHAqvOvzvTRdLGB5s+VavNwzvX6KO3SVXAY1JVw534tqmvxlUhAdRZSIrS9/4BRylxDOIzuvhOVN9fazPv3I9UEAxaNgrB26pbiK/Z2Jh9qzDlRsFBNhCPbKh7nPN9Jl/IMFEeECX3ACWdQaUft6cccABq9knXx3On650Ytu6bGfcfPHOq+5SCwnVZbbZ7p5m85qVnXsnlNpG7pJFMItZxydjjBvQ/83KZdlxP7kq7fYjnUBF/YCXBkyeqt99WDhVz0aaIWoH2G/ZoI2zHhljM1PafTxvGxSbie3Au6PkDkMKc+nRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kc80e+FJ9evYbB4alfAxgRQo/Vu2Gn00hFmla7mEPIc=;
 b=JYUjOfg63EeCoey+W+l5ft7iiRGR07+Rx2bTpjGV4+GYRZnB1zYLyV8ecj2fG9ZhA8HF2jHCzkTTCW/herg4sWMqmi06TUyRE3hAVKh+5IsKhIfjQmTsxLIJxpCbIOek7Yxl0a3/owCBffH8miLTTJtpkFbYZE0DU1x9z/Fps/nbb2Gb/LMrgZp4sbXsCyAnxEyE2+bUOgxP/WvOU27rUyQQhddP6MP5bPrlQSLJoRAVQrhTBpy2klEHPymmCad+pSFYApXwcroCNRn2iNnIUcAoLHuAl6y9VHHCFz5MySW2awxp/XGXl0fmVIFy4ACKT73nRbcYCc3zgfS5phO87Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by GV2PR04MB12191.eurprd04.prod.outlook.com (2603:10a6:150:33a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 19:40:55 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 19:40:55 +0000
Date: Tue, 17 Nov 2026 14:40:48 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Lee Jones <lee@kernel.org>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Philipp Stanner <pstanner@redhat.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 03/11] dmaengine: ae4dma: Unregister DMA engine in
 ae4_pci_remove()
Message-ID: <avytwLqjt07JhVg8@lizhi-Precision-Tower-5810>
References: <20261117163809.622249-1-lee@kernel.org>
 <20261117163809.622249-4-lee@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117163809.622249-4-lee@kernel.org>
X-ClientProxiedBy: PH7P220CA0047.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32b::6) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|GV2PR04MB12191:EE_
X-MS-Office365-Filtering-Correlation-Id: a4e13277-e797-48f6-dcc8-08df44e2b24c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|19092799006|376014|1800799024|22082099003|18002099003|261009223027099003|56012099006|11063799006|10067099003|4143699003|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261102130727099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	BzYIiE7vzI6ckG+nhD4EQx9HA4STXaZryN246pHSwubsmr7p91jOjYN2Nuvi2s7/P/why3GZNeoqXrRbONdQckYWghUz4ySs36cuPR4+2UToitulQnyIZVNMQNkQujgK5lDl6l7n2BCoQMSDm002XFiohxm+AbFhKSuKbl2kP0YCa1ZdZwKZbgHSVGdD70lN3YjjJWvShHUs1AT20L7V7ik2Fjf+T6QliP42QtmPv3+hE5XlBqqFzGKDbxNOtc9Adgb+5hgsznUUdPvJw9qgT2NXceXlAhBh10axPTdBuzfI3qlmUHnS9/HGvsKiQW4j9hLvQ0vx2heXOPEFhq4RE4GSGYMJiNNR86Ls2oZXfnjhBG0sedPItyCvO3SopAg3FV3p2FWeS4ZgP31vA2IchR9wEHftiO+MIG5FX/ikBxov2TKb/nEmIavVgkOB08mkxazwNusjvKEhDqSPLNnm4gv63nskuWM7KNUGbN7Tzn7RORImeekELTIsQBdZ5dk7yrgQ/VlBb9RVOo9Oh765boYmjJ8IgqIynXQ0Ao0mUb4LhwD/KglNVvsWVO1kZZIFD6DFv6jiUu70pDgVOeuGKX48Pgw4eIUt5H/RftOWNbY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(19092799006)(376014)(1800799024)(22082099003)(18002099003)(261009223027099003)(56012099006)(11063799006)(10067099003)(4143699003)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261102130727099003)(261021121427099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R6hpJQAJlsVRCBQruwSP0N27OVGcEJ9qmKunBmBga6e1IZV+DifW4OqKF+jY?=
 =?us-ascii?Q?fSN7Uv+LDJIt7gQLi6C/5+A91StdFUw9IDbRMdufDnTuA0G4EuQNi7gxfW6u?=
 =?us-ascii?Q?1TNgN1riU9cEDt19WseFsT/2/l/hdRBnAg1tXWK/JYD8HXwR791HykZekFgU?=
 =?us-ascii?Q?ePy+UOCbbLyuJUjGEuOhYJzJVO/tkhZ0Zj174OilPSSCiGGpStk/WY9Ak+P+?=
 =?us-ascii?Q?WlrlResHcZ0/TzDDCtm7BKJLH70YWJXgl1NyoN8geJ0GVBmCPo/7KX122qMv?=
 =?us-ascii?Q?0KZR+cqzVmqhsFyVTdirOJlMuRh/gQNJp6ixYlQ0AuhYQn/dqYyhjEkBdnc9?=
 =?us-ascii?Q?mwAnFwDu3T4LjHIf+c4bsqoXfB31wU1LgsbBc2921IFvdYT3FrrQpWpZr65E?=
 =?us-ascii?Q?11TGWRQPSN/c99wsFrUH9PUMVrpZdLPoTs1GHoT7DgdeVSjBEYNhJYol53Cz?=
 =?us-ascii?Q?fWZL/2NbVWh7C7F+JeYC8zciICYFTdcUmgUlIXPZuy0Old4oW5otj9yYhFZQ?=
 =?us-ascii?Q?ehoNLfvT1/5tbboUNtRbmgqSDlXH3cMSxNMHO3PDFerOzpAv9KybKLBBcb/A?=
 =?us-ascii?Q?C+Zxb6LeXZoT0Qt/+H9rVPVIebpx7lmELp7nmVXkU3kF5XEjrWEC5BSDQerN?=
 =?us-ascii?Q?cQFStNdJD9fZ5vA7fvlxKLEDIhySQ8HZhTy58PIHFxH+MzDG9EtGkSRRQ4bs?=
 =?us-ascii?Q?slhbwwOKBQWq+wo4i8tCI42g6e+81djI1zOCUiaVusfrreg+vKISUeY61U0m?=
 =?us-ascii?Q?BQ4Iy9KX1bZaqmVMgOwTs3hlGJIBN/J+OsI0vWdRN8GNA6AnFR6btocmjGOu?=
 =?us-ascii?Q?WMmO0/8PHiVPNlJw9iHOfuyqOpyooT8FL/aYwA+Fs26ADoojmRLCIOF1WxOb?=
 =?us-ascii?Q?oWKCMUsAnqMm77Gmrf+3fVPAc6Hly/xXW3pUV6wnwxc4T9JUOhuR72tKq4aL?=
 =?us-ascii?Q?qCyga8dmLMSkTF9kMakgb8mlRgeWSc1+3a7Rrw6c09ruB+s+l9IPBaD9jgTB?=
 =?us-ascii?Q?xAGksxtJ+ciRXsS2ylPVdmY4ZrPycQBhEQoPucIZhFEMNh+99V7epGvRrPeb?=
 =?us-ascii?Q?FU2Zg8TaVF7U4cl/dE5JV+xjudefHGYVFNfI6A3Yllvc2OT+4C24ZfloZlar?=
 =?us-ascii?Q?TAmId03IqThV6WXJmHi1nthSASk6CnxdMV/PyjeWHUXwbQZ25/cFjmykZKW2?=
 =?us-ascii?Q?RKxtwD1DQTw6PI2lOpTDyWqE1o9c13hceO6vkOz1QtdBAPpBHo1SQbu+ft8C?=
 =?us-ascii?Q?olRAezf5f64oZbyJno7ltFQ7fO/6eASod703os7Wnn4jzCcKM3VhJQNUGz4g?=
 =?us-ascii?Q?1TMcRTtFQZA5WabvjCZrQG1q9SJVn+nqfdvQA0ROJr7stGgmirJd181Cj90o?=
 =?us-ascii?Q?79CCHjo/q5iK9fQ9UoyrN6U4x4/cvvRC15x1ZjhW5YI0/6AT1hL5eIc7sWIt?=
 =?us-ascii?Q?wECPnutkZORNwA9j+0DiVAAqIEKi5hhG2Ynqdz7Oy6b0pMqNfBRCRIVcSGWZ?=
 =?us-ascii?Q?YK8JBky/xyMAKs9CdMc5RIp2mP8uC/GCcaOTjW0lxauMSbNkgGBazDUyT0Yc?=
 =?us-ascii?Q?Gcs/lyVsUtGwMiMA3czETtQOZwhJySKPn9b8zRTDJgGPqz48WnxuCzLL9VrH?=
 =?us-ascii?Q?9hev/Qga47yWvyR8lHsViyqLUficCWYcrT+AmL37q+rFYmSXt+hFOJHbP8HF?=
 =?us-ascii?Q?Lxwm0vayqaGS2NIG4YMfzZu2lTyI1u3sgKDtTtpp0GiKXXy0ZeIXfCvkA7/U?=
 =?us-ascii?Q?15ahLtvB5tvuGvTTad1M74kaEG/BXL0ZfXU90uDswAOgvG2kOTPN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e13277-e797-48f6-dcc8-08df44e2b24c
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 19:40:55.5152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OxPDkKYPZcC74A9Ph44v3O6UXULB2pj0k8Che7XEB38g27got7n8TJQfu43LgryBpRB/EFT5OKn3B4LaYQrGjwjRC8chynljL7GPJaeTclxgtwaqu+KKjuwYxI66YbbS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12191

On Tue, Nov 17, 2026 at 04:37:04PM +0000, Lee Jones wrote:
> ae4_core_init() registers the DMA device and creates the descriptor slab
> cache via pt_dmaengine_register(), but ae4_pci_remove() never undoes
> either, leaking the descriptor cache and leaving a dangling DMA device
> registered after device removal.
>
> Unregister the DMA device first, so that no channels remain available to
> clients, then stop the per-queue completion work, which may still free
> descriptors into the cache, and only then destroy the descriptor cache.
> pt_dmaengine_unregister() is open-coded here because it destroys the
> cache immediately after unregistering, before the completion work has
> been stopped.
>
> Unregistering the DMA device also removes the ptdma debugfs entries,
> which were previously left behind after removal, pointing at freed
> device data.
>
> Fixes: 98f5a4432622 ("dmaengine: ae4dma: Register AE4DMA using pt_dmaengine_register")
> Closes: https://sashiko.dev/#/bug/linux-10d41112-e133-4bc5-8e53-b3e96592c70d
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> v1 => v2:
>  - Stop the completion work before destroying the descriptor cache
>  - Open-code the unregistration rather than exporting pt_dmaengine_unregister()
>
>  drivers/dma/amd/ae4dma/ae4dma-pci.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/dma/amd/ae4dma/ae4dma-pci.c b/drivers/dma/amd/ae4dma/ae4dma-pci.c
> index 2c63907db228..b97fd37bb87d 100644
> --- a/drivers/dma/amd/ae4dma/ae4dma-pci.c
> +++ b/drivers/dma/amd/ae4dma/ae4dma-pci.c
> @@ -131,8 +131,14 @@ static int ae4_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  static void ae4_pci_remove(struct pci_dev *pdev)
>  {
>  	struct ae4_device *ae4 = dev_get_drvdata(&pdev->dev);
> +	struct pt_device *pt = &ae4->pt;
>
> +	dma_async_device_unregister(&pt->dma_dev);
> +
> +	/* Completion processing frees descriptors into the cache, so stop it first */
>  	ae4_destroy_work(ae4);
> +	kmem_cache_destroy(pt->dma_desc_cache);
> +
>  	ae4_deinit(ae4);
>  }
>
> --
> 2.56.0.679.gc527c65306-goog
>
