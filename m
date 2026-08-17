Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013013.outbound.protection.outlook.com [40.107.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FAD3CB2E9;
	Mon, 17 Aug 2026 15:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980058; cv=fail; b=ShGP2qlzjYjRsUxRYHTc0szNCHv105xy36CVP4PnkHPm8S+2faLgSW5JsAGr6ixwni1ZQ7L8KPt3agNFwv+XcTXD/v9c+yhf/65CIDeNYeYBrkNrGFhzgC4yLzFzNdCFoRgntwghZ/o9l/mU3CLlgZdRRvDZ8mXh66e1wpMNG4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980058; c=relaxed/simple;
	bh=owZEUicXdhwE+cwZYmVMReVlVBveBlseqg3+OlAFVVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n3xO4BLM79NsUcXTB6yxL1WoNnFKCzmtHLooHNpf72RlZEphIopTTt/oxxwHeCPp72yx2JvPhD9DPuYusWJSPCd8VKrBE+eRByWytht/x1uuW6Z8fGCgfWy9vRiF1F0duFkqMsJvpgCWMoKgF0hm1CxGmeeVxv6xZ+UEaiC570I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ahzKTBEh; arc=fail smtp.client-ip=40.107.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ahzKTBEh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XifDWf2NwWufKP/07ABIfOCytn6j71fkG5ecZLQKgUgZUBKKKRbDiTgSrsQN9epi9DcmRGTpNvPOxxRdHEombFDONuPom73yIEOqve0BRr/S3pmdFAqC08M9nfn210GuWHd8/WqGAa3KPxBqlZmqWYj+yW2Hxagf/J8INPmEP3YXU1WOhcoPwiEHfalFHjzO9xJfMNlpK6blPtL36HUF9UBwSGrnMcvjEsBuAAK0SBbLOQPVyVxqUMBgtd2NrjYQUVvmFd5da4n3UMKUhmLqUkUt/5e5/dC3IMEZGzxL67UZvHugEXdeDsRFnYD3Thxx1fPWlON8i6TW4xf0nvgkwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgA5k1xtZruABIfEx05fCcW+U8gJSqzdyVEppp8uinc=;
 b=on3+hnvzDen4f0MsNnXnhZ3u+IpK6VgKkzb0eJDK125YYTmP8KbI7LqB6v/YsxathgWgDaTR6lMPTBr1Q7jAOSEdjxgIsHbaYNb7L4lCg3I7gdMuyT7VvPuo1STLrta6sZl22G32ZIsLaNpELSH1ZsP4cgrw6e8Pteg+be7nbXBPusc3HX8HWTB28z6l2i14YaJL6rPtESQdP/G3dsM3j+42janvP5+85oHxHxfaiWthTXyMmyz+klxOGmDLYj4gYSknhYPggAh+R7Utk2jU9BKM7NYBG9hlpMYLQeukCJwRy31u4JXlPwAG9fASCu35OmIAeKvfq6C0kw6ZQz0MyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgA5k1xtZruABIfEx05fCcW+U8gJSqzdyVEppp8uinc=;
 b=ahzKTBEhRrunXMFcIkrbAot11NsvswyRfltsrf2tdoEIkchzGLc8yRok/xXTvoikqfCbx+8nSqopAC6GaZ1IXkqrc6DORKyLvN1dIrWClWQEOENWigHZW6nDyE+d/mV1xUUASRB6cAqfsAdNsl8PdndIpBbmYZ4bAdi41mwr7OZ+QzuRMBRm3fmq/mfS/d3iJSWaOPxCZZk9GxVqiBXhg0svDO8OuA57YvnRKRAfpLSyE2uRl/UORK5JUMZVlD7ZYy+z9SwyhxTxT+VinPjpa5VNmZkO+80VVpXt2P/TmzoDOmXSAR0f4yLRRqTwx3jAsbI4YFj2UekiJytYwFuZKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MW6PR12MB8960.namprd12.prod.outlook.com (2603:10b6:303:23e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 15:20:53 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 15:20:53 +0000
Date: Mon, 17 Aug 2026 12:20:51 -0300
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
Message-ID: <20260817152051.GB1410416@nvidia.com>
References: <PA1P190MB25578C482C8A3B06A4DCC6FDDBDA2@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
 <20260814174825.GC510472@nvidia.com>
 <PA1P190MB25573D7CFE42EF7DD2A8CDE8DBDA2@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
 <20260814221103.GE510472@nvidia.com>
 <PA1P190MB2557D53CB7FCB70EB8F79D09DBA72@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
 <20260817114158.GA1175472@nvidia.com>
 <PA1P190MB255719949EC777E6D2DB2606DBA72@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA1P190MB255719949EC777E6D2DB2606DBA72@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
X-ClientProxiedBy: BN0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:408:e6::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MW6PR12MB8960:EE_
X-MS-Office365-Filtering-Correlation-Id: 547a1308-1c89-449b-0e20-08defc732064
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|18002099003|22082099003|56012099006|6133799003|11063799006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	DiEpuvCnfcz0ITheCeE2KVQVsQcAm5aEzJcjv7hGafz3joNy+1/FqDkZtQyUSp10vEnO7uNn5ypghrLjYfETtSj+mXnEVMMOPNtHUx7cF1VFPVmSB80YXXfTSt+pDHhx8i2zywcdBdPaiwUJy67EEo2pj3mKQ+V1iyTrwUZNvCHC63OsSJuVqp3dgf6Sz6RXcwFvJJzH75d5dtJH+nIlNvbV+Hfa9y2c7E+vEEvaPbTluxhW+Mhu1XP1dMUlpNHdv/+d7sBFgQPQ5+LpvtSbbCo7JM7cXj5e2jNBBBX/e60fv05LyKpBh6LFiTYFUbAJOuUgFdfTo6+Bk+U7m8izH+3dm0zFhLT2I6UjfUgzhYJkhcOZIHRrFi3ugiCffj+1N0oj+hRrhZd8aitPpjgpeKrq3deNI+BsZID5Y7fdJbk01Tr/RdBOc0DRrLi6zzYidnHjC1seHz87ah9Ppcl6h7wzjfv6zkHEhbQusQhId36zh9qa2lgyxKpC7zhUy0p9zB0ReU6ocrwIl/WXCXCjCngGv9n/GvkRvO1ivGdeTqzIOtXsEmVmsqCE7YD14eMF1DbWjRAmIeSoiRKElw+FJLNHH9JDq0/3heYnOeX3JAo5Aonf8aqCt+NEcdwen3hEnpEyb8eV7hsmaBClAfa4j7YUJTdqpOlhwvVVr5A2cKk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pbxj86eTt0q3uY2B24kGrvcsl0dwWngDhTEx96zPug3J9rIXjEEtc/qaeAcr?=
 =?us-ascii?Q?4K0PZ2KeyA4KimoOp/l7q2PlveiUW6k6WadvVEAQceburDUUoBlNHy1HEWR0?=
 =?us-ascii?Q?tm6QvBP8qIikaFU3YE+Jf61D9NJ35KkJrTrRoAmBTmiTKDKtI4mGE43gzJc5?=
 =?us-ascii?Q?6dTrYYzlyIGu7Wkmrvfobq0PN1ELEg1EXSS+nPMTs49R6a/r1K8bRYZH9WRF?=
 =?us-ascii?Q?RaDuLPN12k48SYp/wO4dEe1zsiAl7QTFY7MMgjzvjGcjlFlSTpmtv5gdS3t0?=
 =?us-ascii?Q?BJVlUzDWjoJtAIP8U9jrb77gUdIr+Dnb7BybGvy0OWZxUpTCdGlNuJpFefCc?=
 =?us-ascii?Q?ut1jzvzZNtp97GSTwW6MDFI6k4iUaPxM9Kf7pMxGIvIB0jeKKJKXwCrR4aHu?=
 =?us-ascii?Q?ovFqAp34/8EG8GWunwOTPSXWgGBI8goeN66l5MHZzoQ7R453t/q9ERDwV2Fu?=
 =?us-ascii?Q?o9+Oc95MaT8swJ2WalL9CAELoqB5pcOzQtgwPtuLU2ZFpRGuQeMnso3+sW15?=
 =?us-ascii?Q?bAySxVGq7WJsGT7EaQBgsck2JFTVc8DeiSodl/vI8yBYSKJjYKfeptomSAo2?=
 =?us-ascii?Q?2+FjNAs5dc9m1hQqWDvAN5pmNBdIFvXbmiI1gygAzm8RxPAe11649uq4EM+1?=
 =?us-ascii?Q?LIPi/HPMMU+71CCbucARPfoSGcbzKR9AlpLR8Zv5/MLFErYWZq5EpHE1b+oq?=
 =?us-ascii?Q?wym217FxxAGHr/cFHJYyCZTlMBrtNDW2KQ9BaeavvYclWIX8r4MK0DK4ei6M?=
 =?us-ascii?Q?yJvrow9aaeFrEt2gbfo7TdBUALzI6jAKMdPm885knVDj+MTPb1cDFg4bbdPR?=
 =?us-ascii?Q?LCGH7LIVIcy5Chrd6kJkjHAp98g5HR/CFdFDidbR0O1/V5wYIbPGbWWOmSkC?=
 =?us-ascii?Q?ho2K9xjrL6yRAUWmvYcR4OMXcmZ3pUykBklTB0JuWcG+qOGphaeTbtuX0tOF?=
 =?us-ascii?Q?anzHUHgYidlbdCkyNvMKC6I93bQ3GzsiCUeDJeQx8xU1AnRSWE6WF53iIeNK?=
 =?us-ascii?Q?eUdxTWP1w3qwt/09yfzNJphBWUxMbGHZEuT11p/iUk/jSIVqeXUCqrm9xFz9?=
 =?us-ascii?Q?tmXXDrsXF82ZSgj3Gan1PFA9derzec2UWRmvMVyIZBrYTWyY1xw7fbAM4ox3?=
 =?us-ascii?Q?K/3LyZgwFWxOBJH6wLXKLzTwXrfY0hb3HZkNKUJWravaGP/DeTeRyHAMyFP4?=
 =?us-ascii?Q?6z7yRPw8d/eHMzWh89prtJD0Lvc5jeAu+VoGkKgnFSmiuuQL9j4pO7i+kook?=
 =?us-ascii?Q?pvdvF6DWqj/MhecHWPaMJwrhwA82na5YzLhKyr7x2NeiJVPk6rsYQGHnvVYk?=
 =?us-ascii?Q?9Mm9rCCkSTOhUczQEqdWQ9UXySMLjIl5wPbz9hWJMUK22pEkxgsF29Eod7E3?=
 =?us-ascii?Q?05BxdVlWH6PKWJU9Ki5vRA1AchCMf0vdlU3zpjtoXB2YP81/yt140uCYV5ie?=
 =?us-ascii?Q?hjasW46QAh8tSu1nbqPPjoJiA7XiMNEOLlwd6P+8rBL8oWn8r7rMEctw9x2E?=
 =?us-ascii?Q?gmrUiooMkD7bM++2a1h5WJctd2xTk/KBNEwOMzbprA19bW64ckoCISIt8+dQ?=
 =?us-ascii?Q?bfrtR9ok1bA5id/aMVb9fdl+U1dEmqQLRCaMwhSIqG3L6a7V8iC4/u3EMJAt?=
 =?us-ascii?Q?n+rIUPusBb5uHABRPWRumBTj3wEDD1+H4YUzIiK/1NbioH2j5QtCMpGnCLaH?=
 =?us-ascii?Q?Lff5H99/rskokcGIHlxw/vTIF3HaoTChoS/YKTs2IwJyfrqvgGm3v4Fk6UcY?=
 =?us-ascii?Q?HUQWb/e1PA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 547a1308-1c89-449b-0e20-08defc732064
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 15:20:53.0030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZ5kjmnfnOB08k12Eir2a7QkS5V1soBYXGqk9pLlYctR4sOimE6yEJiSKMCq4cpb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8960

On Mon, Aug 17, 2026 at 02:26:46PM +0000, Dmitry Malkin wrote:
> 
> > This kind of situation is very challenging to setup in the VM, and at
> > this point you may as well include the switch to the VM too.
> 
> Passing through the PCI switch would not help because the device without
> a vDEVICE is the host Root Port. Neither the Root Port nor the switch
> should be exposed to the VM.

Oh that's probably because of the unfixed grouping bugs in the
kernel. The root port should not be part of the group with correctly
set ACS flags for switch P2P.

> A multi-device IOMMU group is an intentional effect of using
> 'pci=config_acs', and I would prefer to restore support for this
> configuration upstream.

It doesn't work. We tried to make it work, there are many problems
unfortunately. Don't use multi-device groups in the hypervisor.

This patch is pure hacky, there is no good justification for the
kernel to ignore certain devices in the group inside an iommu driver.

Jason
