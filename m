Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012069.outbound.protection.outlook.com [40.107.209.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4023E4C69;
	Mon, 17 Aug 2026 11:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786966926; cv=fail; b=mKfagvDW2qJJ7rSO8XsnUXWj+MRTArf9egUJMfOBw9pZaWgYjBoOsO3MInHPsMpXdHFzsbr18nf9JxbOVpWZKWZLZf2pF+ezGVWfHiw3L7kwSD6qm6hrfBcl1uG26ROw5LFkH4L6ipxlZxAWpcKDrkfUGHnTKWOvLQaz9jdpYmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786966926; c=relaxed/simple;
	bh=Kig64/omhkHPty/HiJI/Z/qnMwjkGbUyYS2Lse3Z8t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=exw1iY/VIe0H/x+KWrp1gGln+nQeGSnd0W2rGcPlZTayW/0pGfcWFNbcE5fvABjWu0+FhKU7w4mwcD5fUD8AORyIhZOvojciY51C2OXngEGgOdQcfOPu0sQ74ya6gCrKvTnAjk3b8IAg22QYo8YSapr69bMMKpiXZLFkKX1qXG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EBKQF2nZ; arc=fail smtp.client-ip=40.107.209.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EBKQF2nZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZuqKN94VvQ/y7a6EUPndC0ca0zazTBdwLw587jo2YlFtyX3mZ3itL40o5xWTvpboadvEGvewPFY4J72snUUtNuR0sIfx7c1f4659p0GDM2X7StreBtX/S6cBALQEiXPjaDdrhHIQOIss/9PzFIbnC1/cknknnrXc613UlWuDma3bX0ZpNB/qyj02ZjQNgVEnKQqTVop0VxlyEQEsPc/9kBsAvNP+AA75U0H2qaJhXZAcMfjeXZpmQnkmC4kZ1mGpAiiOecrSIwrfw5m0wFj0g72eCXKUSS306lgCSCFt08FFk+Sp3sV6xcTy2cQc1FHoq+xL+qB9gLEN/WpceUj8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NTYrmnixuX4yI4UC2brmsGyTPGvPf8dmW0OnEYhhfQQ=;
 b=NfpMU8APQ0HWNPljKnDC9E1+2FBm20DXWcYGUkVZERGcOkyww79IKIhKYisdsQMaE1mEWVJiMwqf3xdfWFz1h6pZteP7ihXXQBtKWX9JRLEQFEEeaDDOSLaVl1I0QYSaom8Di06JbkzplSZa9UyNL6l8Zp6g3vWwb7wrSlqtFh69xYPhMNC6/6sMJL2uDp+XfjZbt90rKYHJe9Z+tyK0+oUiGM0VLvEfMUS7ewNTmcHbUERN0RBLWPfyU443iw3VEMiigw+5QoX2KayqsA01w/ce71Q+eyLXD8prWaZIEIbGOC6fYWxflcG+Gy9poPAp1jQxgHGSXNujk0CrQiBnRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTYrmnixuX4yI4UC2brmsGyTPGvPf8dmW0OnEYhhfQQ=;
 b=EBKQF2nZoQ1SXRQ2a4KkyqVMnck/Mgk2T/61GKGOpIKzrReMarf4nXlAiwGZEHSFqMI4LAawpVLWpF6+GFf+Q69Tjk1lMjIAPYXOdltKELLtLSF8PQXq1dn5gJyF2sr44ziwF++7ePJqokCboaN/RBqLYqswWN4EkgXDbWZyjLA1PzGLE38V5HSqdq/1xXgq2tkssAv8tRiLVzpt0CamVd2DR4u4zpof6xBiKUwBRTBW8st+ObVaP166jw/dZHqCabk2HfZ00yoZ66MYIPUSxlz3FPhCsXr5CuqA3FchCWHA88HwmUvW8cX8j4pkzklo7ijaLQFFBnHR3V44ehEtBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB8117.namprd12.prod.outlook.com (2603:10b6:806:334::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 11:41:59 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 11:41:59 +0000
Date: Mon, 17 Aug 2026 08:41:58 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dmitry Malkin <dma@nebius.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Nicolin Chen <nicolinc@nvidia.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	NB-Core Team <NB-CoreTeam@nebius.com>
Subject: Re: [RFC PATCH] iommu/arm-smmu-v3: Allow nested attach for PCI
 bridges without vDEVICE
Message-ID: <20260817114158.GA1175472@nvidia.com>
References: <PA1P190MB25578C482C8A3B06A4DCC6FDDBDA2@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
 <20260814174825.GC510472@nvidia.com>
 <PA1P190MB25573D7CFE42EF7DD2A8CDE8DBDA2@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
 <20260814221103.GE510472@nvidia.com>
 <PA1P190MB2557D53CB7FCB70EB8F79D09DBA72@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA1P190MB2557D53CB7FCB70EB8F79D09DBA72@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
X-ClientProxiedBy: MN2PR18CA0010.namprd18.prod.outlook.com
 (2603:10b6:208:23c::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: dd210891-64e5-4091-c500-08defc548c3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	PEe/G5IXxzIBM5NM6RNkSatxO581h/xRiUu77nYeguX0XvSpbRfmA8byD8hWbKUQnVmJEWq/g8sRaQmEzx4+Xji8Qr9LenMqvoS4/PVbN2wuVmIBXW7i5OVII4songwVjq6DB0UgUxAMs4ZNWXMmjKJK88+vs1vi9Ra4hsQXAJAcSgK4S2dR44pSpJMZrAbtwFB8RVKEpT+4qsq6Czlh+gQRBKGai2Dzw7MEDdejVpYhPFEHapEURNnMI/FleEVSGq/7we/XEjhesNyutytjTp6NFEYBCB8Xl2H1/bVLwFkqlUZJniq7Gs2zklu9Cy1tUM71N1gDdf+XFoE42fwU4NfazzOWU0J3bGbTHBqUojoIJ5AhHO911SCDkwv11RLrfpQxK4DGSupy5FNRFtM4CpaSsbFVOvJU8uJsvpi24c+ynJobPPVn6rAkqW+qS0erYyFN+ENv8VkxZkKIlsr+OYmiLBwh5uyWDeMtV2z3/aymi0TL8qm/8YXsz4gPPiYA8e49GAUdVI0dBZf1lEPY6vmuMPoFK1ipK8oTk33zyu6gkrADIXbLjDPNaQXW4USnJyz5Z8iAZaK+1lXdic44kMceqL1Kn7ZdMJVItZLiS2TEZXqytxI5GVXMm1Ys8e86u/OXs6MFDyd/X0Bga1Gf3TGh9jhmZppEASTSt+RBciI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WlQXAOU3+ARThuRX20+NWl1KlR4cHQEbMTDaG53WcoqYm1ItrPFMqSFe/J3J?=
 =?us-ascii?Q?cF7+gm7wpBVRHMGghaNsrBtY8Ey52TnTc7yAsmteFwJHWIr/FA5kMrlQDqyF?=
 =?us-ascii?Q?iZVXY7cFrG0FLsRLzQXvV6OYGVznyY7BSLcfkDzxndwBMrxAJJ+dYXVTsKCB?=
 =?us-ascii?Q?4y8KBTGovt5ZkAaNdl60UUPXt2Fw6wWdbIKZOphSXTnTUYpW5V95TyXl5pwI?=
 =?us-ascii?Q?+Q2tOCtvAeM5POIOVQ0gaVabc5Gd/weibDhVwEhn6T2i2W5uQjHz90Wz+dDi?=
 =?us-ascii?Q?1pQR59erailvweU4mfjvBQhnd5kLOGK5VaJVsiaKcCd/NGGj6tl1ycaAFDu2?=
 =?us-ascii?Q?JPifroo5hdWU4jHDrjf7L2auifqzLa/5kpdCdGr7V3z3Jn+w0LGG/9RPL+rA?=
 =?us-ascii?Q?Kvd+PH/p7WSn+VD13BrW44XcE5ogtFpdnH2KqxtLaZTznIUBcadUVSL2x7RK?=
 =?us-ascii?Q?wui5UWNl2IDaWSXvh04IK+EedE8QN1Yt/W5RJb0EttLTcQOZsyazSfYGrvyD?=
 =?us-ascii?Q?xVH/nNp+UJOJwo48wVSU5WUs0X2jJ6vE3ExXOm2vBV/pWv3gy4d3UIo2RCx7?=
 =?us-ascii?Q?2eKu1CUwTHScuUlJ3IlMUwJqj5nbd3uIBI9AxXxKlub4KtJN1JW5Bxc2pkMw?=
 =?us-ascii?Q?kjEDNNjsR5o40lZD8ViFjfFbZGdULDUKe2dIbShQ0maD0SoVJTl2ORv/OWhG?=
 =?us-ascii?Q?8Lu7pGPmMaidJbw2EHXLQ1fAdNpP8eDUhGi5e83jImaWbBuQ4g45v5hjvMto?=
 =?us-ascii?Q?7DAXR0zwYRA+IMhuPOU0nRxAAhmUqxXyKueajeOpGALCDrvbntkf/JgB+a0M?=
 =?us-ascii?Q?Oq7ZQR+1yi8gcYlpnQwMyvEhmgKWdhIwCZxHOdf2eQkOofurC/377/D2lQR5?=
 =?us-ascii?Q?sF5jWtEFw3t4fFLpOwhcPtATXpSkhI9jqSBwyu2HdYAGlGKKQ3AgHiL3dNSi?=
 =?us-ascii?Q?hflXi/FR85QeWvMa1+WzZfw3Sik+HUE97txDCxm4Lt6nFeXvXNxOoVp82Kgf?=
 =?us-ascii?Q?Q7bpIG0ypt7LgAt/yXvVB7O0hss5QWX6/ZCcyLb0qajZLnUuvg2x9PKklzDx?=
 =?us-ascii?Q?vF0LIuPjgj5Bx/Ht5xaQa/0d3pEYEkjLJR3btIzekwwduAWjlPwjBGkng0eb?=
 =?us-ascii?Q?TnR5lU6wZxcKuYcAm3OQWWxGwFaG7DVvW0XbzuIe+x+Xm+oCAzmYiv9zdBDJ?=
 =?us-ascii?Q?m1l3w+JDCTIf20+nFnv3oEfVaEIrjSVmP4q7QkLVzBD96S+vBWKLf5VCPTV9?=
 =?us-ascii?Q?gbIUFgl6U5nnlpLOGXhhgM6cQpvMTbmmUpoTMieSLXuJnG77OooWWlkOW4+d?=
 =?us-ascii?Q?kGcTtcUrapGCsckwDylfn3Y1+S+jCzhGzMO13vCDQIHxdJ0vblpoPYfqiEFs?=
 =?us-ascii?Q?tOftHbFUBAf3s0Ise9+667JMwXjjTEVd651QbHfG1cbkOi0+qKVSq89VTAbU?=
 =?us-ascii?Q?UvGOMP2dW+O8Y3XssoLrTOWtB1PyUgO3jh/G/h82JIyBsD4PX5GSmongo5WO?=
 =?us-ascii?Q?YQK6jETjrtMOqqFZ235OGq7zujAZmL7PutBdkPXREtufqDG6+QG/V+PDl/NE?=
 =?us-ascii?Q?szKlfkMn0LOUlJ4/d+56je14dkAo4Bh2Z9LR+e2SpF6RYVCzAuyvVhdI4l9W?=
 =?us-ascii?Q?QetBpYCAErfH5CZEpJLzh0Pk4WgdmRon643INaN95XfKPhWgpC2zCiRQbGgx?=
 =?us-ascii?Q?ExPfJiJkx0GC9I9nv1SUl3kzyWahnhyhQsJ79w1Yp1Gzp+qbe6MXq2uk2A/R?=
 =?us-ascii?Q?V3hf9D+UvA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd210891-64e5-4091-c500-08defc548c3e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 11:41:59.4931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mwy4+lCUoyQzdvbiierD9AkS97LNoK2YXNMzj63pCyHUFYiP/c1cNtX+7KQVcD+6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8117

On Mon, Aug 17, 2026 at 09:29:10AM +0000, Dmitry Malkin wrote:
> > Don't use it that way?
> 
> Why not? We use pci=config_acs to configure ACS at kernel startup
> and enable direct PCIe peer-to-peer traffic between GPUs and
> NICs. All affected devices are assigned to the same VM and IOMMU
> domain, which also reduces the memory footprint by reducing the
> number of page tables and lowers IOTLB pressure.

This kind of situation is very challenging to setup in the VM, and at
this point you may as well include the switch to the VM too.

Then you don't have issues here.

Jason
