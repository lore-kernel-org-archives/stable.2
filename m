Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012043.outbound.protection.outlook.com [40.93.195.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827065592E5;
	Thu, 15 Oct 2026 17:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083865; cv=fail; b=XnJIoZTc3b1uEYMZRSg+NTsgNUmN5i/e+/XLhzpJTQIiVAfjG2yoKxjS0jCyVKIyucX2Yttsv+M1RNwQ8MvD6GskB+CRqzpotUxTN4e622zCJpp05bKTtRqxFCwMOo1d4vvChlvKwfcDY10FbR+uaSEmUkbBe9Qtk13dpnHNWEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083865; c=relaxed/simple;
	bh=f5kgaYG45+X5k1mNpxQ54O8bqSoA4p8xOJ84aoK6HNo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 Content-Type:MIME-Version; b=IeOzqZEjyS2zQ3V5tXSIm3d1T2t1vUXBb9rPMHg0eFAANczEdTfx0qTADqtuKfeSYITrnKpezRjG58yCzbi3ANL7X06UwcxjFUwqF4ukUMXjdMUBRtrcEo2ZPhAQGoKqU6r0Cfc1xLhYcFhpi+HJQirxnLADI2D/+Vy0eg/Ywww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k7Kt+yH4; arc=fail smtp.client-ip=40.93.195.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k7Kt+yH4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOfWSYXkktux9b63jtp8GPJuHaPfual45QuRbDI9/rDY+EBZe/l8DRSuVq29v2t4ytliaEfBOGE98BZ4WPY9KpzVk+cgeCm83WtITsJw9CqM+HTRsEVpm8yfhuk0nWtuaEWc3MN72fzHuiMJYvjE0MLV2HjED3k2E26jYAeQr2bcmkrilBI3i2XgckFEIYZXbjHHw5ML2vZ4de6MnpY14nOBUEchPhT1l0nQfBDtx5ZU4AQAi1PVT2BsrJakvAomyShDmWpxtn6pDK8+Ybz4XVKYpkCsh2eiRS6xP4zAvcwa8+TEoe6hKbqKtApBptbR0mBgzsgs5QpAmuYgQziSDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfMNDTgTjnMhWg8VUxqy2Yz7vaE3wUeaOYhiilcvSsM=;
 b=ZA+4AxzESKrsRMJBuEwxuIy336tHMEag19FmVZQWTFg6kL83L1YSmbqN2NciTDkvTGBLAEYRDuTZFAxOtzcdYT1VMOa6vEAnQjsG6ojgwvugI19xBESXG91GCubEPZkKo7ahuD3tvXlDcRmiEaRdkvGD/RaVMqKi4Js8ithZNMZZPxnRkiMIKYZ04gFVpT9qF1cGlmPdaZ7N715LkbJ2CIt/mV5oxyK4YsV29+m80uUa8QF9ggds+BeIBkdmpOTHPcFcGwb+l5gFBpyxD0i8PzBX+mm/DalW5lUuDl/SVnxsTBluUxsomPaQ1EuszsQu/8pblxTPU0x1WAPTZ9uN1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfMNDTgTjnMhWg8VUxqy2Yz7vaE3wUeaOYhiilcvSsM=;
 b=k7Kt+yH4bUJOc//3eAeYrgH9+3unhZa1JqafLbTx3UFZvF1u5+n3700u4WkkhyB3j7/zgs3m2vF+VecxSEq2+w6mh6T0qTr23+9GDl8hvCea8yQuwd0tnDFKmEcx9cB6FElyIGJZp2uHxAqTMaWndeRiw5tQxsl1Lmvjkne26XRBIJI8rKPpt53VMvf2Gipyz11or93/VGn0ldGu/jKLKmT8NEN7oAT/YOuSREHczGDEV8MFb9DJl45ulvwBMzGju5O74gTDhdSWvQh7Dj5P5TczMQvEz5n3658yHn0Ie88SwGpiN3dj5xfvxpql+nUshBusifoYR0o/hsoqY/gLiQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DS7PR12MB6069.namprd12.prod.outlook.com
 (2603:10b6:8:9f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 15 Oct
 2026 17:03:39 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 17:03:39 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
 iommu@lists.linux.dev, Nirmoy Das <nirmoyd@nvidia.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261014133632.3440297-1-nirmoyd@nvidia.com>
References: <20261014133632.3440297-1-nirmoyd@nvidia.com>
Subject: Re: [PATCH] iommufd: Fix event queue release use-after-free
Message-Id: <179202511140.3602487.15546971129785788830.b4-ty@b4>
Date: Wed, 14 Oct 2026 21:45:11 -0300
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT3PR01CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::15) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DS7PR12MB6069:EE_
X-MS-Office365-Filtering-Correlation-Id: bc419f1a-2045-4bef-0d12-08df2ade41ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|11063799006|18002099003|10067099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	slDUxkFQFx4jw+iyu2j9Vu1mz+5qi83zDBiFWfnRwvM0c19KP2hAl+AuwctzMl0dcKBQ6SdQG/L7hvH9+OY6WUVsfu9uOnSZ7TBccr2rr5//IO7DAxZCC2aE7/YCXdGsqEgRXyNOt9xLi+YrL4T42W5wt9NQIGW4/d7kPz+HP2WwXyNksiLcq7K/MfLSN1OLoTNLi9l7hsrJ8Ry0RwLVIqSFJDNPv8DrVK42f2RZOOJKmvhHFjQxjLooT48J2yb831dWJpxDgVTrZVLBcr2w3ZinBgRmKJs0BGpo2wC/s9VZcDesRFtKgv/NaDGgxpOKGEyoZpVf6Tec1er3C7WrTQHoQUq07AV9POo4wqI6vYxAUQZZrIMJiyVQVZCliL9+WgajEbrFqHl7L4Kdtw/SKJ7X77ngJbMTUNtiCKAHueMrEjokb6ik+7NZOEWe5r5hOX3G3gly08/f6UTcxwgB1OrIoCJgxy9uTHLAxDfFFfMYYMS3wJdkjBm8G/tPsoJ1U2obC1MfH/ksAdf9qP/q/igCIERbDyitchuaOfsL2C3cVX8ClybbbS96aemMADotmRCC1Y9YBE8Stk9f10I+tzTKWhk8JosE7onC69iF9L36bKg8hKlXCZucJRXShtW1BKaF7wHwOkPNqHhOkePKt4pnuOYfIzGDDGqctlVk7cs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(11063799006)(18002099003)(10067099003)(22082099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODdVbFdDdG1vS2IweGsrTmtNcmVkd3I4SktESHY5QUNDbHV4eUJhS1ExWVRq?=
 =?utf-8?B?aUZVK0FrdHhMUUxPWDU1U1pSVldNajRZd0Z4ZVNMNm1uUWt6SnRzY0xQZVdt?=
 =?utf-8?B?UGk0Q3VhTHIxZUdBVWtPSkNwblBVc1NKM0ZVdGg5cFNGMVZQVEV5clo5emJt?=
 =?utf-8?B?Z2RhckQzSjd5eEJqY2hBb0VYQ1BSQWgrc3lmTjB1S21pNTVWaFNxcXZYdlVr?=
 =?utf-8?B?bGV1V3NUcUNPd21KbkhaaWcyRy9LTzVzelU4bk9iNzJndWxHbkdjejVsSXRk?=
 =?utf-8?B?MDVTMkxXNDVlb0p0MXBXRWN4YnIwVTYzMVZNd2FHZFp6ZHMzSVBZN1FwZ1RY?=
 =?utf-8?B?bUJJOEUvc3IvQUJLQnRRYkFNMEp1cDVlaXg3dVUydmFMMUVrbDExYXJ2ZEV1?=
 =?utf-8?B?QlZzM3BEZk9paEp0eWdWRU5XVHJDUUU0d0lhaDZRaXRsK2NkaytpeWRmekY0?=
 =?utf-8?B?ZDVRb05lbE9qQkxaRGVSNDhEZy9ocDlpQUVlaW41eHZ0RjdNRmYvcy9RYUhv?=
 =?utf-8?B?STFuTFJOZHREYkxPMWgvNVNFSm9VRkpKTzBJTEFTU3l2UWl1K3RCdk5BSEpG?=
 =?utf-8?B?Q21GSEdzNThoRnlqOWZyVjdGSXM3b0xLSmVhM3RweFVXSUVWam9SOUd5Ujkz?=
 =?utf-8?B?dGgwZEMrV0EwQlpqa3A2aGZScG1kbVU1QjdmQmtXeElwbUh0YUZHNXNtQkdI?=
 =?utf-8?B?SDN3TXI5L1hZQUZCR0lyckdPamJGOGs1NmRubm81ZDRHMW40c0lGUEREc1F0?=
 =?utf-8?B?RDZKYk9ETFR2NStIeXIzNk44M3JiUEFSTDkxRkVORnJSS2dyQjROSkVNM3VF?=
 =?utf-8?B?MHh1amtjK21qcG5DekJKeW5SZDdvRmxnZGY2T2RGOUtRK1N1SVZHV29PMFZp?=
 =?utf-8?B?L2lrMit6YVU1ZkRGcXoxNU1EMTJxM01SVTNOaW1hWitIZjd0d2p1V2dwclAv?=
 =?utf-8?B?YlZwQ0h5MHJ4L0ZrdW92K1gxNjdqcGcxU2Yyd3I2RE5JMW5FZlg2MVg4VHgv?=
 =?utf-8?B?MzdTcTQ1MVpva2dvT0VJbll2eTZRbXN6L05McWtCYkZrWjlsNytSTTgrM3VM?=
 =?utf-8?B?OThlL0g1MlJoL2g4ekx0aTBkSjlvZW5QNGJ2UzZKeFBlSENUQmN3TUdkYlM2?=
 =?utf-8?B?YWVab0VkL0pheEMxalZNZWtrUzVmWlUyNStXdkJkS1JUMkE0b1hxc1o2RWZQ?=
 =?utf-8?B?TU1SK2RhNU0vdVNDdWtIdmdXd2pEVmV3STN5cTFpKzdzbThLRVhaWGdFWTNN?=
 =?utf-8?B?SC8waTloSnVNb21RVUgyT0Y1N1FMT2xzNkhUY0UzU0RRa1dJd3RQQWwzcEZV?=
 =?utf-8?B?Y3VwdjV0anIrTmllaXNpQ3JYRFVQMktVN1BGeXMwdVh3VklNS3V1cncxaHRv?=
 =?utf-8?B?d2ExT2FTRk9mOXFCQ0hXNXMxVE1ONFh5TVhSVWlpM1VrM1ZFNCt4dE5lcm9y?=
 =?utf-8?B?V3Rid3h5NTRxOHlFZ3ozZTVwSytPNmFvS21oNzVvMmIyT09LS2h6cE0raXg0?=
 =?utf-8?B?RlpPeFF5emdyaGNGWm9BcGt6elNIY0dqMUZWNGQ2TDBlNnhvUjVOVWFWOURs?=
 =?utf-8?B?eXNORVVOL1FyYkRyelRhQ294YnV6aWV2VkpjNmxIUHFQcFB5MG5YeWhtSjkw?=
 =?utf-8?B?cHkra0lnUjdYK25zeFJaSU1vVGNVUFpPRWRZcHNwWC9rRFdaUlI2QituR2tI?=
 =?utf-8?B?NWcycjQwOGkvUWJzWHhrMHc5VHNYWXRpNmxTREhkcVd2dlErT2FlbVBOSTRj?=
 =?utf-8?B?Y3F5dDgvM0N1N1JpdEZKcTJKUDhSN2Q1SWkrWDAzZ1NGK2svNk1vODJ4enRJ?=
 =?utf-8?B?NG9hb3NoNTNCVTY4RUJtL1FmdnlkSUh5eUZ5dU5yd3VSK1Q1QkNTZ3p3Tmw5?=
 =?utf-8?B?clRCWmlZLzBINmdwRlJXRHVPSWg2TzR5SXc3Vm8zcFhYZmFOT2Z2YzR3aElO?=
 =?utf-8?B?anpRRFFZN3Z0d0YwWDA3UFlCdGF2VThJM21ZUkM3dS9SaUFTZGxna2ErenFa?=
 =?utf-8?B?L1BQSk9oYTI2cXBjVUJjcGUvaEZQdmdGRXRDa1ZrcFkrWmdRbXY4cU1KRVlS?=
 =?utf-8?B?RmU4SDRGdjFYKzg3UU1BQ3R3clA3OFZVVFlLdlZLUmliSnNMbVptQmZ0OC9L?=
 =?utf-8?B?SFlOaXhwQUxNTkJaWkhCQnkvL0I5ZGNIRjhQS0xCUXk2ZCtuTWVNSFBNRWN1?=
 =?utf-8?B?SlpsR1pzTExtWmlZQ0dMQ0MwZlZDWG02TXlxeFZlZ2lYeU1OcS9yY25lV0Ux?=
 =?utf-8?B?Wi9IZ25CRy9jQ3VIZjFLM1VKNTlQdWRRQ1FoQlNkam9MVmhic2dmby9ZYnlQ?=
 =?utf-8?Q?DoGlKE1e1kL3+aDyo9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc419f1a-2045-4bef-0d12-08df2ade41ea
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 17:03:38.8093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pOl8bhnOB84DTz5pqb6fn54bNp8ijMoKDWpCyYqrZ9zFE2nooCfZEXSezFOcb42D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6069


On Wed, 14 Oct 2026 06:36:32 -0700, Nirmoy Das wrote:
> iommufd: Fix event queue release use-after-free

Applied, thanks!

[1/1] iommufd: Fix event queue release use-after-free
      https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/commit/?id=440ca8a4b69f40088065b9e05ef11373292a254e

Best regards,
-- 
Jason

