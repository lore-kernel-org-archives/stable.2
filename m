Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013061.outbound.protection.outlook.com [40.93.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539961A6836;
	Fri, 14 Aug 2026 17:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729713; cv=fail; b=CtEzSZCU7s2vY1jTzEmZfcsBC0CNTeFXCQ42KCttevgJQXudQqXAFqDWjpjIL+PI92NEUetxqBDJ9piQDlqruXkkv7/y1z2mthHnZwcW5stkvtzS+FjTiCgOd/l19CH2xpwLaQU2EiGcdmkbf0rKApk99y7ZgE29jTeiXvGOjfM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729713; c=relaxed/simple;
	bh=zLz+4yvXbeZ45n7SNvXQPiAOhunyob1lE9sVXCJQyhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qhTQ68oDUwbkd1nE0U9hlz8uBP1Zu+xX5kMTf88Qj+Gi/zDXGWeyksBlQGmbExtqFyKiW85WcwRXmYj/G2pQcMybsr7HXFeOGEg/WAP7aQp3i67DFhDhsKkdaE6K8Kh1nWq6//fDQNhhPVVBMT0vVu4CSMJMibiqMu8cstBxMd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XWbHc3XT; arc=fail smtp.client-ip=40.93.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XWbHc3XT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNo0Rm/0b4saepZ7Wy8i29IprutlJURC371qcZu5QlUPuXyPbJr4d1D4bQGmWaYgJwp3zmcY+oYweiYbCKK2yZT2YoNum4VDvZow35GDBNPVlwGk0mC0YHeftBagwuHQNb3Fsa9KqS1J1WZ5Vrt+E5Fdd0CQEUuQOqlugqoCBWOC6i1NRUOYRrvMvmDRCE5ZOkGeOMVqnWWM9u6LtEcTJ7RUe3YUF5iOQLOCQT6a35Lw1qEP5Hv0P9Ldy2w1Z1HEQ20CrotVQJXc5gMv6URQ3NlPhvvZIi6+Y7mmvp0cLFU+Xb7C/1CND7xALKjO5cRYyMoz2oXE/dWDD8oo8h0fDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biJ/DQuiYKHHaopOS5tcrTFcArghckA/BOZQbRQ38T4=;
 b=ylKBuDmPBUZdO3UX3kFoIZqRyJcNtPVRCSk2zeUHsS/CzguHAJTIK0Y5yeLyReqoJ77BYoBixloiK8RQJXxE689pcHQdcDF0eeLig6IPjEMSKJvgIC0aG0Vu81UlLAJX3bWt12E7neEF5z9rJFmGeVuaTsQ1a+aS92CelVSUN4emE4a9aQBsDkr1pp6LGD92Ftl7973/jh5curyrCNqEgDMTUoF1VEustCNVqBYC0xc2OKYv+ILUm0gzfecZux1l9ITjp59W92YBtBpdXIGaz6J+T0ux1vnaV1hznLiThpWwyqTsSW8ytKJZgNnYUMQlSsuU1iGsG5lqZ0LiAyh9tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biJ/DQuiYKHHaopOS5tcrTFcArghckA/BOZQbRQ38T4=;
 b=XWbHc3XTwCY0JX6TRBQ9IHblBvhlUmadHkdrCw5uewDQlR53091D3/4K37yCVWWuzrQNRruRXg+ZWN60senhv8LbJ8x6jY0sRQdjPozdsPJ5I2ZDzplJ/8no/u39DRZAqNj1ZFc0xSJ3qw9PaOyW8OpqU0NggGBLE4Os1kc5r74Mxmn/h8d1g9uclgIK+Pe8RKZZpI+lt14QQM4g4uAup52507oMp+d96uzICyJ/GmfqPIl9H2hhNrHpCLS1pTiQZRbt+BMOrSnV/f1hX/c3cIts3+YEwmgajdlniQ9FCIeHElq/rPfmkkR40eYvF9G+y8VR13uK1rN5fWYv8mvvNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DSWPR12MB999175.namprd12.prod.outlook.com (2603:10b6:8:36f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Fri, 14 Aug
 2026 17:48:27 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 17:48:26 +0000
Date: Fri, 14 Aug 2026 14:48:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dmitry Malkin <dma@nebius.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Nicolin Chen <nicolinc@nvidia.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [RFC PATCH] iommu/arm-smmu-v3: Allow nested attach for PCI
 bridges without vDEVICE
Message-ID: <20260814174825.GC510472@nvidia.com>
References: <PA1P190MB25578C482C8A3B06A4DCC6FDDBDA2@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA1P190MB25578C482C8A3B06A4DCC6FDDBDA2@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
X-ClientProxiedBy: BN9PR03CA0372.namprd03.prod.outlook.com
 (2603:10b6:408:f7::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DSWPR12MB999175:EE_
X-MS-Office365-Filtering-Correlation-Id: 013abad3-3b92-41eb-33a7-08defa2c3e65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|22082099003|18002099003|11063799006|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	BIZ7FZPhdIcU3ZI7posFwFhs54Hd6y4OzeRG6U1RjkMuLz3nxzYeks08HzUHQA1N9BvhMfiqbhqTbqxVC32zG5eUXecWGVno2Zpn5rxwgG4p1ELHPtljWzYwUqpoV6sl7XDZKZfjA3u9T9lDDyBWPQD0Zn2abAR4cyJMEWpDfp2lmcYaks9T8Ff6+5HIHlX2XHM7+C0jG1JF9DAI4aNZg+hhPAiZqpy1Wjem8TOGHHi500odJjcWKa4tMzLo/BfG8OmxZorXzku2yGhjXZiMtDEP6kmwiGk1ivqWrG7Wji5KhtcT1Cgtl93fAuIbSe7Mx6XQzPapQfYqb/tcXHg7+Dg3fYHogbvFLhdKLxtXkjsMYZ7zp3n1T+JmlUk3GCWBe7B0oyl/b3GdlUlgqDC4DKlhwO0m8mM+Sjq1/2Fr6vvkQ4rJPDT5tkLGmu5nrwKv0xbjAgKNZgil2FZQ9mUm3rmEII6/WBmxOSt6CifFisaNTK2E7eYD7S3216rUzRE1TsW6klRL+mHGpqHlAJBNR6OZV3IzWg298ihE5M9LiCV8FN8FXlqcxzlfNftJKjS1szH4w5pyZ+SRpNfcNDIfU6aAY46weF1Hj2mcHyppywaLI/xtYFMe0n7tvhXMGOzkoR9JSQ4TdOjDDEwNh04sts4Oaa8Me2GBLnIUIqbFzEg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Jq0QIT0cUYLP9QXzGoFW6YP1XwHR1dJrj4z09vys9jkOjJ4mDnh2gOvtieSQ?=
 =?us-ascii?Q?cePuiCktWg12WAQ4k/l3NC1pQZTErH8Rsjk58Lxqt1RIN1UPvJcThJA1FOSG?=
 =?us-ascii?Q?ThH0nwMVhzvjHnDxQ8/FjoyPQVIXuNE+oUi1OHYCB48Oizati+5dj/WNBG8K?=
 =?us-ascii?Q?mNIAu74cKyIseymKqAVmXp65zi6juI667JzD2KAWU/mIKEuSEjYxH3VRp7sb?=
 =?us-ascii?Q?IwcivMZlu7z8LrIJCuJc2MbqyfD0hkrpQdsgxZvBAAl7SVtOoGAAjuensEpg?=
 =?us-ascii?Q?oyGaOqA5/1/r+2e5Y3PaJHhFBj0pubgtxrdm8PV+PyHSy3zv4mDUF9Ug9ADY?=
 =?us-ascii?Q?PHD7dyb3o9fukArvyvbKi44m7eAlV2oQOcNjB31R9qwuqN1te/HBDJTogTjB?=
 =?us-ascii?Q?NEyaZVAv65NKxWjP35aeDN7kRL4tQiDWTdYOD3K48B5nGW2d15w3oJYcYqiU?=
 =?us-ascii?Q?SRrmw1WNsD4yzuzP0u/BSLqG37FhFb1GwQxeFonRWORnQINwfCxfJIv5CKiH?=
 =?us-ascii?Q?w9p0mG+qq7XbfW4+wLUqaL5klEc8qOV6gk2Y9f0hz4rEJE6/1ed4j3MCiRwq?=
 =?us-ascii?Q?gsGXnYCxPcnL73vAz+WWnEHmQ+FIl7T/nLXW0EP2AGP3s93boKkNYACB9PFS?=
 =?us-ascii?Q?AGLebm4XzTvFmbQgX8/bq2ANCmLRMya+SyMCSUKmt23wHxCpYSlewfzgFNQx?=
 =?us-ascii?Q?aZGuU8XYUHKFbpJmCH+Sdjvdv0NllQtIRcMehEp5L/XZxYNCsiSAlBDqJMjg?=
 =?us-ascii?Q?bo+dnX2s1V24EBMwB5BXfMwbgJkK4Hq03oQ0MbMA9Jf8uHq1CKtUOMVG9zRs?=
 =?us-ascii?Q?80Jzt+2nFtYyj8PN43nSyPmAmIhfZ0pOrcI08MNvzuM/gmvFqUzmRpIIFL23?=
 =?us-ascii?Q?gZYN2Oe2Nx4xQ27MCUAlAgncUMcixnITzLb6FSsJSF7ElkdokPaH7yYGZMkZ?=
 =?us-ascii?Q?GbE7rfzdR384bnEiucm6pu2PDN7r+TLIYg3IhbtSfpohYxAmQeH0+lm9vLsD?=
 =?us-ascii?Q?nV9otf3US4h0kRleMAgq/VMHLoCHm2D/Dn7dM0TbWKu9iTTghYS8377nc6Cn?=
 =?us-ascii?Q?8NFiiDmi4k/TVJ3x9s93yShcROtd6ltfiHmCJ/XKkp43ndJv4IggCxZ+amCh?=
 =?us-ascii?Q?Xm5IzWhIkyxQ6Ia9L47Jf5tMXM9/EMBrirXPXA9pi3MrUlLht6GvQ0U7Q4B8?=
 =?us-ascii?Q?CbO5NZrQ7Iy2tWglXIZG58zI5wdxBgkni0m5Qu3g+AETUnCazdQLIBAPd1uK?=
 =?us-ascii?Q?8HxkVRknlq/rUhrbm1SlyuQvIxst7ElHNYyK8IiBdK228SRj40Jb6njs9gfa?=
 =?us-ascii?Q?A8YRFOK5NGFBuK6B18yGFDlQn1EZAVSq64HRz+DWX85749E+ZhD1wrdCeTU5?=
 =?us-ascii?Q?FUFNVFZ1Dtcy8x+5qNlefVxeGVJwEZBxN/0xPWVCxxr2W6qcDR3RM6KviW/n?=
 =?us-ascii?Q?rKsjQe5fIa6cS9UIVrDo+RQkjwnNbaLYUjEMrmF+x4mHAgW46MTJ5YD45FPO?=
 =?us-ascii?Q?mmN0brkSZsIwU7zdR2bVX0nM6wPTHDz40GzTmFQuIdZs5pKDrYkQtRdrHC39?=
 =?us-ascii?Q?dZfpizunr+0DrK0mG2UYjdWaX/3u/p8UsRyQr0Y8cZwn+A75u9Z3qWaRffS3?=
 =?us-ascii?Q?QD+c3QlNY0n5HBWV5NfTOSM3pRgU+87MZelNAyOVqw7I/MkyXHa5N1vtAmc1?=
 =?us-ascii?Q?SdAvm111P+tfuYaulWhwIPZ4UpXbI5HOZPZ3AmFoi1szzrG75v3OTwV8dzI8?=
 =?us-ascii?Q?TTCsV1qbRA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 013abad3-3b92-41eb-33a7-08defa2c3e65
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 17:48:26.6970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0UPUoHeXZGr3T2C459xHNIXylBreD/0jcI92fEmCNVwkkB1S0NQMQYnHiiHtdrBa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999175

On Fri, Aug 14, 2026 at 10:07:09AM +0000, Dmitry Malkin wrote:
> IOMMU groups can contain passed-through endpoints and host PCI bridges.
> QEMU creates vDEVICEs for the endpoints, but not for bridges that are
> not visible to the guest.

But why exactly do you have pci bridges in your groups? That isn't
entirely normal?

> Since f0ea207ed781 ("iommu/arm-smmu-v3: Introduce struct
> arm_smmu_vmaster"), group-wide translated-domain attachment therefore
> fails when the first bridge is visited:
> 
>   pcieport 0009:00:00.0:
>     missing vDEVICE association for translated nested domain:
>     cfg=5 ret=-2
> 
>   vfio-pci 0009:03:00.0:
>     VFIO_DEVICE_ATTACH_IOMMUFD_PT attach failed for pt_id 19: -ENOENT
> 
> The same configuration worked with Linux 6.14.

Hmm, but without a viommu we shouldn't have this vmaster stuff
activating in the first place, I thought? 

+               if (new_domain->type == IOMMU_DOMAIN_NESTED) {
+                       ret = arm_smmu_attach_prepare_vmaster(
+                               state, to_smmu_nested_domain(new_domain));

That should only be happening if the VMM is setting up vIOMMU.

And vIOMMU wasn't supported in 6.14, so if it "worked" the VMM was
doing something quite different - not seeing this as a regression

If viommu should support multi-device groups, I'm not sure. I want to
know why you even have multi-device groups in the first place because
that is not normal at all.

Jason
