Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794785256;
	b=bbr5DkJ8Mk5m72rDwj1XtYISuC0imVkexGRBZdGvzIde+0VW0B5gu3DZLsrTqaKdkQsI
	 s7epRzJDpL7572NlGEwycHJKtMHfkJsbOilTf6o3Dw+122HVT1i4SQlM52orFw1ITNu51
	 ThjMr6kj4eRic6LNNy/mPN5UnwpfxytdNYTeQT9ZFu1upGC0yj0xxA52s/1cnvV+w28ki
	 BRQHHLaS8nm9F/RkrJfKXN35cgZiStiBEpFgOMv++4KbsZWS1Z1lxwHus1StgEOcvyKFE
	 L8R8UrnPGDPo9dYvSZh6tlYj//WRz6vIzPenTpCcD0RYvEdSP4YJS1loB4EYnfjTtbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794785256;
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
	bh=fl6eSTMU/fmjyMNOFYNvVEb6RZkhHYOSLflB/dPQ4fY=;
	b=KnClCHKelQS6DBoV1Ldx6PpVWWix0kBMz6qqH5ajWwsmdzXojnkZXhvyjWmero+kd+sc
	 jXoO/zsN8tdy+r4S6MrMAUkxjOu3MWaOC2dT8u5Re16rLwo7Kc8bLYT3TyQRR4Mo7zuny
	 EFSxBDEhVFLZlgUUrl52+m1kAe1vL/uMnkRK20aUeOOHVbH+SJFupG++F0ykJIeXOu6HY
	 Um+6B+U4NQe4u5bx0Fz6s5ojkCLUG5BoQF5pFmxB/iYalonJHW4ZL/OYzfURzyXhKDACV
	 Dw0fPc3G3W2xyLjmS55571Uca0fAYayfLxq946YSj5lf3zP43beueayIsv85MCnlMyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GUaR+v49;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.57
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EC1606A88F;
	Sun, 15 Nov 2026 23:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4EC1606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=GUaR+v49
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7fgJ3CDj1WPgEzsG02+krqMspD7i46Ze1cqm7St+ecsLzgKONHXQ06irzxAnI5xke6kyMx7fU3heva+pc2F5RWHUXoJvOPX4frzV52dufB9nCxysmTuVvc6R7FPqq8mLG7XHus2JtBxRTZwiGcxbCrRnhvy4CuqH2agOQFBl0oDfAyxZYkbRil1bbc5NqoAklm+27ELpIZGJoKLI8y05AxFy/ZN8B4KWvelW9h3esfH0o1JKl46jlxx6uZNEMEbD8hxVSPvOAsqDxyE4dJYOXcpwMH58osI528JOqLIWTJ2ks/w4oxWP9TvtgZP9l4APHzs2ue3mOiILkdb2zB8Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fl6eSTMU/fmjyMNOFYNvVEb6RZkhHYOSLflB/dPQ4fY=;
 b=JaG5xPHvdNMMryyioMqXTuoIadeYkkk/HHKU2+rl7NihhKbqLRsubkDFLioWs2PHPEO/T1cOufG3KccbFekdMuyK2Fyv17Bjqj2uPF7rxQGXB1J8wYI8zWDhfxy0dIbNO+TopvkBvGu/OHAtjmXfQ17sOTlvi1pmiLOy/HJMsdO1U3FHtiLve7/ZQjzLLiAA6uof0yUCqnVOnOvn5swbFfmfgFL7i5bxas76zqGI9UpL4d2yi/COXGJT83i8VXvcD/3/yVwJsXUBhNNuH/Pt1NhewKyCZno7Wy6a58C4YPy1dONExJIO4biw+tbFBYWO2qFhcxuTWjkiVvDMtj/iqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fl6eSTMU/fmjyMNOFYNvVEb6RZkhHYOSLflB/dPQ4fY=;
 b=GUaR+v49U+JaTuRUJLH+RBqVaTTMrKffqBRK1wEa3yPfqhzGsHH+KBe3fGm0YKBmkKmtddj7Zs66KImgHsTNezaEFc2XhZs4zC07DI+J1zjPKoU2YYfABfSPWo5hS9EXS1ohwLCs3mfUvvd0RqGAwNXxPMknPr+FQnq1xjdUCHoJ2isge1lAoAzPcJFw+f4KlV8waEBhJlqZmnAdpnv+wYFB4abkiN5gstRxiunrhF/ubhRnzWueYtjTgSRXBdwQqfRrFwdnSMFTcgHJVC6Fx8+D2NWfPCT+g7wM1KreHKl25V11Ij3UJzVAFt1EP8r4hpwGy03YAo0MnUhxaKh8NA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by DS0PR12MB8815.namprd12.prod.outlook.com
 (2603:10b6:8:14f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Sun, 15 Nov
 2026 23:27:31 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0615.013; Sun, 15 Nov 2026
 23:27:31 +0000
Date: Sun, 15 Nov 2026 19:27:30 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com, leon@kernel.org,
	david@kernel.org, kas@kernel.org, dave.hansen@linux.intel.com,
	bp@alien8.de, rppt@kernel.org, stable@vger.kernel.org,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: Re: [PATCH] mm/hmm: reject shadow-stack mappings
Message-ID: <20261115232730.GC1239159@nvidia.com>
References: <20261113195536.2660763-1-gourry@gourry.net>
 <20261113200303.GA395967@nvidia.com>
 <179460249376.482102.14669935557901467762.b4-reply@b4>
 <20261114002027.GE3706007@nvidia.com>
 <20261113181025.6e8b9475b29c13d29f59e02e@linux-foundation.org>
 <20261115000005.GG3706007@nvidia.com>
 <20261114170127.3d29199864eb352d9045eaba@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261114170127.3d29199864eb352d9045eaba@linux-foundation.org>
X-ClientProxiedBy: BLAPR03CA0072.namprd03.prod.outlook.com
 (2603:10b6:208:329::17) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|DS0PR12MB8815:EE_
X-MS-Office365-Filtering-Correlation-Id: 57dcd6d1-15e7-4b3e-0462-08df43700555
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|10067099003|11063799006|4143699003|56012099006|261026121527099003|261022075727099003|261021121427099003|261102123227099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	1F1NMMcVwK2CxZJFJcjB0UsHec034gk8ETZo5kCGFCIXPkNSTt8Hz1c15XtORFuMLn/EpJoDyrQ5Bl6mKMRQcfyLzStcm/MsoNZ4W4par5xk0bDOdFGm372hNp1gpy649sfD48GBHAIbd0mKgG//v/7YM+3knTvvJmmWSKNOPD263cccPtjTfusDH4aOXuFeeqDJptnu+cbpjOOmKDssg+hA2E3bqeiQthZV3CgMdib6n0029WQ1Op5RYlHH/8taT1YPEZ9YEjpn3ubH6ZArteHWO7XdkEjoClsl1/CrtyGBZg1NN6rKBlGR3VNisjjW8SOpydJejbSu+NInUR3r++CY2qChNsdEzAHJG5blyOGyF03Kr5qCiIUE9/DKs6Hd1xZZEkaMIX7FXpJxZtGwxFFCuleYajcsB8g5coSPPmh+CdALXfo7FmvK3Fmp7e5ABgO3Q2J45Q9nQJX20cgZGLvPbW/2t7+vI4W65SCPIfRdgkDeLEM30s3lKx3RIuMs2Q2X/u2mz9Tmm3Jyhdqm4NpQ53j4QfMJ6Ngw9gZXNFS5avHWb+inlV90QxiCE8m0adrPZkqda5coGmO7770Z0NWT8O+4njNmA9OGmoKehCJ4ev7wh0ZB9afqhjeFpM8Zk3UWAg+uM4Dl6EQ75qsTrb4taGHUMXwDU0wNPb2JtIo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(261026121527099003)(261022075727099003)(261021121427099003)(261102123227099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8U22XWlOagtrVegvaghheBxqljo2dbcEPVBBDz3c5ZYfifEeXh9+fEoIixp0?=
 =?us-ascii?Q?k6z/HVm0DbNG6C7MmSqfhH97iDsT8JOgv2JYPpVbMUHhug6Pp5zKjqJD6QGv?=
 =?us-ascii?Q?1+fKGnK66oSzq7cmN8uSWOcOAQ6mpX80hP73anTyQe+80U79flubii9XnXse?=
 =?us-ascii?Q?aqVwMdLy6JbjcAyh07MZ3M2bS0oBcQFgKQtoRQp95R4ScUWUZ+S6HRiCE2pO?=
 =?us-ascii?Q?MwbJFYXbnAYf8od7JTR/Q7kPH5iU3ytahdz4+Qpr+XAhpRQLjYFbhQtgiipK?=
 =?us-ascii?Q?qJT7dFw1xNUmzMj72wU4YuDA2oZhuml0RuWjvSiErN+u1+Dz3BbaCEKsREVl?=
 =?us-ascii?Q?bPCUEnk/a78S/sZczqwoBTAHMhNL5LFlqvcVsXnOyrYoq2EMC4x9k9ysUhrG?=
 =?us-ascii?Q?uPFhZWGn0vmmXCWCxIdz4q20V9P0r3mRNR5cJILrHOwRO76oQl3dLLJylBCU?=
 =?us-ascii?Q?jGJFM1qBgRyskWJHMzSPIdB3w2ve4ZfXAuC2/G+45bkRDsIqlzU0SLzO3qFZ?=
 =?us-ascii?Q?TpXhyjp7+svKmdZd5+vJx4cKiNN9QRAD1H8nXep9g24aZl/XDFZRI9AiBcC7?=
 =?us-ascii?Q?2Y56SAziis5D2ZfDYwR3aAFU/4E04Zytfigb7fY5TLm2QVLD8AVkon8rHyMf?=
 =?us-ascii?Q?gqP5+WQfMKqV5YjFEcQJYQW6euQ0xS7bjqYNXG5IqYR3gJ39hCfmph2bA3Qs?=
 =?us-ascii?Q?u3Jf1ElQ+40163cMTgJ57YTR53C1xUJg/ymhUqhSG40Lb+vv3fuQJOVcUoiE?=
 =?us-ascii?Q?y3LGPaueKAMU7ChZKTzAaRltFtzn8MHGy8KQtXPoOQbzFnnDSjNOlAY1TeDI?=
 =?us-ascii?Q?K9bH5DRB/8cTPTtVYXrHI9HCh0AhXX65Gfi3+9qq1rU3hCifhjLGi3Y6LBcY?=
 =?us-ascii?Q?hgz/b5AD7LtSEt5t2rDiWXOnjGwIci5hiKTxzyhOds+KOc9eWNEVpQF5yk97?=
 =?us-ascii?Q?xDZ9IWWAHoyj3R5FyRB5DDQ9NySS+9AeKpc3mnUR4DBEOVXN30enNNv9UsCN?=
 =?us-ascii?Q?S7tSWNcXuXFqbIMdWcMrrSrJUW/lO0taeQIRn3dyNe43yWqZvrve39JV21Y3?=
 =?us-ascii?Q?P/6aB4yJzZl6yrcAzxZ6EarW7Rvd+Ex8VP0/O/KdlbR9MUMJWN0R+R2qmHHj?=
 =?us-ascii?Q?B2wdA/kar5AWThitLSMADdLibWLjDtL5lpSktUYT5SOuJf7ZhVEFXnuhOaSb?=
 =?us-ascii?Q?TJUZzxlN8Vk0hhpsVTzmBEPv+brSE1LzcNolzc463wGunjJzi8hCq6tGNDYs?=
 =?us-ascii?Q?3yEdqgWeDioEUTVzmTD4Koe+uKtulUQaj/D8sggb6tWCEGlLCmXDH1tfUi7f?=
 =?us-ascii?Q?eEnialxxilGRcsSHfr7UWp2KP8yAGTec99bf9S7RuEnlHoXUrEQksSwhFOzq?=
 =?us-ascii?Q?517/NPZpGjxFM7QdwHRM7enH4ZIRkgxeyLsg3ZjGp4KKKihEZDrmibrVn4nn?=
 =?us-ascii?Q?FX2G3iapOb/1WeTQnYIocxtMP/JLgKQdzFkXLBFEoT8b9nCl9Bc1ONirUSKI?=
 =?us-ascii?Q?eetGhxDN/1/DxZrEK+t4PJQI7TRuGhS7NhY5A9oeOW7ySpUb8e2LnAvDu/K4?=
 =?us-ascii?Q?OJw8NoCxOHc/TH/E7tDtnq936gi2frTFDDskbXVYeGx30HObtV4Qnz/JS6nz?=
 =?us-ascii?Q?7Dy4adTPJMOEjiZUizT9bk6G1YI17FgGrUgGq2pGDIVaXo7FMaPDEJZk4Er6?=
 =?us-ascii?Q?VWyfHxrR+N0MS0TITPAI43dFpoOYvOwwnBC+CPipHai09pUf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57dcd6d1-15e7-4b3e-0462-08df43700555
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2026 23:27:31.5694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhafV+H1lE4cn7SV7Q8JEdtmoQOYI/M/bLquUWorFUIc0WTewie3XYkxeqecx7Fl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8815

On Sat, Nov 14, 2026 at 05:01:27PM -0800, Andrew Morton wrote:
> On Sat, 14 Nov 2026 20:00:05 -0400 Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Fri, Nov 13, 2026 at 06:10:25PM -0800, Andrew Morton wrote:
> > 
> > > How does this look for an altered changelog?
> > > 
> > > : On x86, a shadow-stack PTE has its ordinary write bit clear.  The CPU
> > > : rejects ordinary stores to it, but pte_write() reports it writable because
> > > : shadow-stack instructions can write it.  HMM consequently sets
> > > : HMM_PFN_WRITE, which Nouveau turns into ordinary GPU write permission.  A
> > > : process with GPU access can then overwrite its own shadow stack,
> > > : potentially corrupting return addresses or bypassing that protection.
> > > : 
> > > : Reject shadow-stack VMAs in hmm_vma_walk_test(), including read access.  A
> > > : requested fault returns -EFAULT; a snapshot records HMM_PFN_ERROR.
> > 
> > Yes, but it is not just nouveau, RDMA user can do this too and
> > that is far more common..
> 
> Thanks.  This?
> 
> On x86, a shadow-stack PTE has its ordinary write bit clear.  The CPU
> rejects ordinary stores, but pte_write() reports it writable because
> shadow-stack instructions can write it.  HMM consequently sets
> HMM_PFN_WRITE.  Nouveau uses that flag for GPU write permission, and
> RDMA on-demand paging can use it to grant device write permission to a
> registered memory region.  A device, or an RDMA peer with write access
> to that region, can then overwrite the process's shadow stack,
> potentially corrupting return addresses or bypassing that protection.
> 
> Reject shadow-stack VMAs in hmm_vma_walk_test(), including read access.
> A requested fault returns -EFAULT; a snapshot records HMM_PFN_ERROR.

Sure, thanks

Jason
