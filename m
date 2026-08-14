Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010014.outbound.protection.outlook.com [52.101.85.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30F34908BF;
	Fri, 14 Aug 2026 17:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786729793; cv=fail; b=kPibdTG7H9KhsJsPDZ9PhqoHs1hPG3gAiHoRP5m4O9zGLfPknRNiZdOUmGRITzsq696sawOI/cSN65joy1IhjqdRcuDnjodGJpVk8OEvORkFppnYVFSfQpGOHG5m/A2EnI4hM5ZLfOEKK4zXJBpmwPaRZ42w6e7aL1fjHQf8oZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786729793; c=relaxed/simple;
	bh=mVc9q7jY2sxB1eWVO1hhgTM+qPxcUKZpIAq6bU4E2IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nXDlBx7mFh7XHf6nmZws3CR8b45r3p8Br5PElCjAGA8+CEpxsu47Qgiyp+Q+e60br7n+4Ct5CClXHKXNQQovsCHMzidJ2tzvmqlFjXE9cZG1I23mvlZEruq2jrip7qamzjUlRkF3MvIHv4ztejIMN5GZSu1LdldqE8VYSuNKrAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lfPCRt6k; arc=fail smtp.client-ip=52.101.85.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lfPCRt6k"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDHgmJVQzAWuji3dHPZliTDdprKFuhJdkSwjuoBOdJX1y5cO+/HQQqyKapDvAj34CR2l+ZFubvWtOYeMWVAuD9dhiRCNCIrMh9fQ6jJfIGb3WHsSleABu/8v1kqortyzYku5RvkcGaOXjlCl+297tQqN5mgO5XS9/Y93OzDjTO+O7v1VCNgitVWIcZKGYaBC1pJD5jk06MG1gzyWp6Wg1loAZiKuXiMrCskgY9OZxKf8PbdWImt1omw2iJ4ge6LV+oBTuBHYhqNpVK+zrpyNqWHKoLNFEufCOsK4zAOTuiczGreupKupw/F+barJCl9Fw2BNO3af1yZmqSmG3K3qZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVc9q7jY2sxB1eWVO1hhgTM+qPxcUKZpIAq6bU4E2IY=;
 b=GS5mt45R3eBn89+8AejI6B+o36+iNw+bQIQMr0AC57zgQHXZ0B8DlFFBMorShFEZnnWHe+Lh7A3CurZNL23fChc9roLhiFwrBuuF7V7H3YCBwCfPKseXqEN8b3mcZYrapWQJ0GNtN6I4r08I94a0sFVqBLpC0iuI0HvkB76dEhEX8lpyE8uoIcrMfU8gBNmWM29hXnqugMmAThnyWAmARlkJTGXW8+EL+cv/c5On5SPQPgkZoDoWKtnGqc1r1ipsE6BqywSjQ1akHhyFnvFacDAKWZcU9Uz6VhaeiZ5BQih9w4rYDd/KrFZzb4K2hIKhMP1iVdprEVBC1w4XXhmTxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVc9q7jY2sxB1eWVO1hhgTM+qPxcUKZpIAq6bU4E2IY=;
 b=lfPCRt6kkoSaNJlwYYt4v+vYlMkru+bFaF5bhn+POGDbBwqLqx421aasYK4uLm+DY/dOaMOrU+KFzzv0TVKFAjLTnr34+N3Jmfryb5238nT3hX+kehCeHqNMo1L82xWVbrp0BFt6XnOk/OrmYTOukp5ziEgqJg1UB9OIblj+3a1UHaxRHgP/K/7v6bLL/jiHY62UFEYNtC+uT+qyoAf3XJi56Fe7p1I4pIvyQK5Jxm9MUXVcJ7SU3qwuhJaooO90eugzSmpF0lESmy1lIDX01jTeGjsqn96xOO+chOsf67XHXPQMYD9PjWR+SegQSjdP/Nd4xUm7byNnJXNUly/C2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DSWPR12MB999175.namprd12.prod.outlook.com (2603:10b6:8:36f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Fri, 14 Aug
 2026 17:49:47 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 17:49:47 +0000
Date: Fri, 14 Aug 2026 14:49:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Dmitry Malkin <dma@nebius.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [RFC PATCH] iommu/arm-smmu-v3: Allow nested attach for PCI
 bridges without vDEVICE
Message-ID: <20260814174945.GD510472@nvidia.com>
References: <PA1P190MB25578C482C8A3B06A4DCC6FDDBDA2@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
 <an8jEbT9pAUYfsvR@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an8jEbT9pAUYfsvR@google.com>
X-ClientProxiedBy: YT1PR01CA0135.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::14) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DSWPR12MB999175:EE_
X-MS-Office365-Filtering-Correlation-Id: 727cbb89-e0c7-40cb-c414-08defa2c6e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|22082099003|18002099003|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	+O0JBTLh8C01WgGtb9Yu0CHfOiNEbKBSbnBDonSeyFsL5pUhiy1vgJtPWtndrl4NhyRn7iyqKq4yr3d4I7TCQFmfVriEa/88GfEBn9a1fJWLwmIPgk+u+ujGwptV9kgzsGmJPxTuPVeJzaoRqxjWvh1SK0TBpsVQXdo3RpV/VL7B5ALG2FUjciFhZKnGaUs+oxbKhHIFA0xWdHR2EDNKVhnd0DrCXcdI0pYSiAxxzB0lg7WjsZQK1MTXKC8ilLW/51Y1abOozkP05QY0Kczt1XntxhW/5ZlJliS8JO6pvwMqzBunnhSvR4C0/S/fbTVjPdp02JalvHtL1MBNWiowLZpGA45KZOv8O8wmZWLz8wBRzW3bFQIS0++BoG1PrUEU4S7lJHTNRdtTSDJbR5CHV+dCu86otJUqRqFTZ0S1CYqdj9zPsu/DLaHwD9r98jvAosXy7si5tkeRXljodpbeFs15IQCqQHLx5RKJho6JQbCftJguUV7RwHnStDQjssSd7umgqp0U3+eTzJ4GeGSfg6BtgjceYha+HFfmaWzsuXvhZSlwbUBpe/p2+081RzQH4Q8h89w0ozo2t719E4VhgpVCKbGMFeqBU28IYGqiBDxRzpfIEJPYFCzvuvQfr5krZNswxKBwx0GmUvc+iyYYO0xGZMOeieNMIGcHvFfaSCo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(22082099003)(18002099003)(4143699003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wkXaiTCTfLaPi1J+HK9h+D7h/X/Vrnx4HqdAj2LSJi/W2khy6/VsVEHKBqDi?=
 =?us-ascii?Q?8TJbYyr2tycf4r8nJaCvutawg72dNE4iMCnpeXclG5sDh+xoevf7QkOCkkCH?=
 =?us-ascii?Q?Gbpley+GZCrzo0PIAk5oQmt7bQCvmh4rxha0etyNcQCbBKhrhDDxMHJa5Txh?=
 =?us-ascii?Q?dDFTDKl3AzG15I1f1McO2UhLsVjL2pIhRa0qqnr0/CXLx1lzoiioM/csAOBJ?=
 =?us-ascii?Q?aUXFjo+E9JEYyaT2CMZUl0wkBoNgw8iQnE6vG4Q0oFv2g/9bRUeamM6+9/aW?=
 =?us-ascii?Q?mB9+Pzs8HLvpkNmTeNm/vsevqmD+S7aQBj8DjgdPzHv5o/BLRAeAMFYX4kKF?=
 =?us-ascii?Q?HHknBDNVFY7IoY3r7q2sABK76JGoofTy+E2JLZKPR3XZah6CRII0z9QQLvim?=
 =?us-ascii?Q?eaPCJJbCDCzPSNIrLcGXUW4782x3sP7xzkXbb5J3CUWuoprhKhiI6jr0CrNP?=
 =?us-ascii?Q?7vr4z1g9EAcuywM8VNftiavHGoegiv+S9+8Wqb6M7Tt7RmcHU70ZRRDf1l+Z?=
 =?us-ascii?Q?C8Ty/wciJ396IOhsncfaMGfo1Dq8L1GZ5Bxz6jqC4MftkasAux3CHc26A8EZ?=
 =?us-ascii?Q?+85lOlMJ79VYaabbGsWWOCc25DI6Bwu/nR+eJ1A6Jb/MBUzB295Lg83rhSyK?=
 =?us-ascii?Q?6utly6ZnQIrhHH8w4ZLux40dTS/za7DeYmsTPCWDTVQ23fglhgsSvxJA35ja?=
 =?us-ascii?Q?fkGJ/m9ghcBf9MPJPvsKVAmhg5ymyaXhFIbfKo9I+TZ1Jil08P04+6TxwJTr?=
 =?us-ascii?Q?rqSnPcAyW4FHOf8iuMQppEtdrYM3MFybuEkIQP/KYyNXtgXSnO7Q3w+CIxMs?=
 =?us-ascii?Q?G4Yux160gEkBb2RvIqNEGH+IfOXlFR9+EuPbM/f0HxVKPYy4qTkXlZ96F0Ba?=
 =?us-ascii?Q?8EoTmpwvWkNv0Gb+cQelQV4rnahZL6sYBHaLs3uXg5jYIjGfElrHIwuF3z5p?=
 =?us-ascii?Q?7t32MZCQSTfmdKzskCrUH+CU7H+B+38vKr4lsLVUSUEb/3w8jiufko7K+2hs?=
 =?us-ascii?Q?guYR4eCYIeQXqinTldEmCTnL21wYFgPPqK+vlm+m8+kkA8T35aAdtjyReaPw?=
 =?us-ascii?Q?SAyPsNsF7YtfJxd6NpYK7dmfkK3If9U1mb0X4wTJFbo+YKykJJYYaIb03Mb7?=
 =?us-ascii?Q?PUzPulmOOm5tDicJ1NukZVifi2UP7Z68urxMoBGw/vsHMKImBq07+9CX4zut?=
 =?us-ascii?Q?4h8KS4/2BlrgazUZCcje9+4V6lyYWWPgCsgQ4LG09TWMuHcBhMEWYRzzr5X7?=
 =?us-ascii?Q?XpiGSX97ZjqRXtVbDqT1dXhXARV55g0lyfQHpSrmZFIHCIK/XtH0Vy4mk37P?=
 =?us-ascii?Q?2K+jtp7GlQdk6dmBVmoi7jQoOZYrXNNM9A7dBNyyFIcJk9MeMzwxr9U5npZ5?=
 =?us-ascii?Q?R/JA2j2Oljhf80GrlL20IWpbBR7WXw5b8k53B3n1FdHYUF/5ixcggaFytIFj?=
 =?us-ascii?Q?o2UvIIC4dwvZNIkAnep80EUbbW/Mp1MiYvclV36oOHj6QY/r9oAvw81rU7iC?=
 =?us-ascii?Q?nLkwYL4llCvZWsa+Peoo7FuDve8fFk2lxIBB+3NVKr46P0ZhglhFOfRrE/5E?=
 =?us-ascii?Q?D4nCNfIcNz/a8FOsJMIFOIpsMqKcGl4H9jd7v9pzKXadiCGb2XsrB7FUocLs?=
 =?us-ascii?Q?In2RN8uJiU2vrNpiYL/oSpFfpU8v448jKJ/i8PQ01zYW9QjWM7THGFrgfd1Y?=
 =?us-ascii?Q?7SN4oEL7gBT6dUnjAURDIh+bcgQxGEmmFf0QD2gk9n7wcZVqM11Az5z5wkgY?=
 =?us-ascii?Q?dZ+qhBKXeA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 727cbb89-e0c7-40cb-c414-08defa2c6e40
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 17:49:46.9810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4S2M8mkCSEYg/KkDcFzm67HeE8AfDk7Zu0TeOUEahgZJjNnF2YO/MfmOdzg/vkK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999175

On Fri, Aug 14, 2026 at 02:15:45PM +0000, Pranjal Shrivastava wrote:

> Also, regarding RID aliasing: while it's true the host bridge doesn't
> need a vDEVICE for its own host-consumed DMAs (like AER/PME), are we

RID aliasing shouldn't exist in any modern system. Unfortunately Linux
gets some things wrong in its ACS processing :\

Jason
