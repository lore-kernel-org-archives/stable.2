Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794615636;
	b=EsWmBl6Nvr7UNDpZBhfKCmtw0+q4FqLIlRgc+5SwjEGFu70YbA2ry5Mz+W2LGPRGtM98
	 mFNc+6gi21CilZEvIARV9VZk1vK7I0+XgWwDraPK0cHw6d2kbxFZ2eu86yjB6pgSeAvgN
	 LTo/Rr8kvIGxQObMxIoiF3unRUWjx9jstzLvutDPcRD2kr5Exc9KxnrX/lx4Nyw/sYUCD
	 +Ya5RyDaYX53mofj9bedKj9OOlUqg1Tn1u+3c1D9g9pormYRwVIwxxljnqOEYke1yPDSX
	 AsV2Wz1rh1Gf321qKajNden7S5rC22uxSEU58rmiaOb+v3Rp6uH8HanDUP+ol3/b4tA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794615636;
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
	bh=qXwOsnh4dCt9oGTs7JN42j+2MkUICLA9aQfsAvxVJuE=;
	b=qnKeo86vIyu8YfiaaQaGx0xPAvamdWIoNaX1ttu8P+6+mQLNcDye5WyXtSTYZ/4qDAmt
	 i2+W62Vg8ZpQNy16U/yq4EooGLcYfoNiPJdtZF0VGGdgjQRfe259K5oaSXPjaUXsE2Lk1
	 j41ip32QBeuNLuxXQggUaW/bF4bNG6j24n9AxNGi9CiBJ2YsRVQ2osrGWW+4weaKFYCTe
	 g/TmM94LwJw+w0IkVcjV7HRHAyRXz/5OlCyB/ITjgm8XJU6iZUqFthAsRh1/XfbhqWYOT
	 hnYNnowwxlaz0jqSRLdHDwCLTQBRGf5drQR0DV8tV+8v0hRiGrpv/62ltdOnYuvPVtA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=E76DpBSO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.46.22
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010022.outbound.protection.outlook.com [52.101.46.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFC5606A331;
	Sat, 14 Nov 2026 00:20:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFFC5606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=E76DpBSO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jlsk2X9gQItGIyD48xurxoO/3liXUeylkdIfnvQ2Zvntpnw5cH13PCfOe47wJzyPAnMG2WUTY6CyBrpj0NJyAu61397pFz6d4iVBfCLIqi0y3E1wusyUnZGrxVPhVkz8qTEweoKPBrzdYNOa4Fn4jWJilT0NHPAWvvd8RIaWFx5Qp7lQHgPQxVXjfusDc0wFMTdv/7XcWlvda0CIcVPhPLcwxZbz9gqjE/Y7tydlEPw+1Y0DDoxoJD27raYjwAJh6TDYlNBhu2sXUNMZg4NquZjkdqiSd7ju/uHIiGD33XQcNgyoL+K8oFl9qlu8I/oLSYoKDtM6+J9kkyuQ8fNrAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXwOsnh4dCt9oGTs7JN42j+2MkUICLA9aQfsAvxVJuE=;
 b=i2+DFwU6U16s6lPwxR2wG9y5ljQa/x8t3uWrOsQ94m6uoioJwZBBtwlFPBpTAd1rI7/6dIUuSoGrpjm202sHVD/nlFo0ItWbfwpTNwOwyGhNOAO/S80NjHRjEF9D9kCsRwW4//y7Si0KS8geHYqiUwT3T5yk0sFbHviL/A79rumQr6SKBm8LemaIzBrBH4+Y/WU3JdOoDi2R7EgTR+z7YovxgWQLKKD5Kedjuc73jFhlfZ/7zAK6uvs56ninWaLd1UwEh0hfu8w5jC6RP3Q3keHz+C7iMJaczIOMcOrt6aN0mVTrVxttTw1itm9nJUym5zf1la5Nv8+S28iyQcGclA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXwOsnh4dCt9oGTs7JN42j+2MkUICLA9aQfsAvxVJuE=;
 b=E76DpBSOUzarOqeE/BAnQQO5PvwyM5ABtw31krSWXBTmKY+X3MojCiYxOijSKKPpqNtjdsbWMdHNqokb1dOMe5DNRu75TevWxcmRBZg/M1FJcZdHI/4KcYSFDj/mT1+sEJrVepw3SOZx8m5QGiG/sr145wU0duaGt9IH2IXhmnH7aLSAM9fgL4GwGUGOwlccaBav/vsk9ARydxLBlBBnFLQbf0upQMMR1qgEZ8Hj49dY/pVj7nnjmOeDPhw2pxfqPk4AN8XCF9VsqYoH9abAtkAjzp8HHVNPzk7MmaXpraWpSN11psuoWWxD4u43FT9aYdg3XqLWm9II/AOrcpJueg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by SN7PR12MB8819.namprd12.prod.outlook.com
 (2603:10b6:806:32a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Sat, 14 Nov
 2026 00:20:30 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0615.009; Sat, 14 Nov 2026
 00:20:28 +0000
Date: Fri, 13 Nov 2026 20:20:27 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	leon@kernel.org, akpm@linux-foundation.org, david@kernel.org,
	kas@kernel.org, dave.hansen@linux.intel.com, bp@alien8.de,
	rppt@kernel.org, stable@vger.kernel.org,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: Re: [PATCH] mm/hmm: reject shadow-stack mappings
Message-ID: <20261114002027.GE3706007@nvidia.com>
References: <20261113195536.2660763-1-gourry@gourry.net>
 <20261113200303.GA395967@nvidia.com>
 <179460249376.482102.14669935557901467762.b4-reply@b4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179460249376.482102.14669935557901467762.b4-reply@b4>
X-ClientProxiedBy: YT3PR01CA0141.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::34) To CHBPR12MB731189.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|SN7PR12MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bb38f0f-0cbb-4546-d6f9-08df41e51628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|10067099003|56012099006|11063799006|4143699003|5023799004|261021135927099003|261021121427099003|261022105027099003|261026121527099003|261022075727099003|261026140227099003|261102123227099003|261028144727099003|261009223027099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	5bxbefQh5wco0/YfY/a8ngTQlYOdBL8CP+xregfVUCrt0Sq8UfoqY2YC08QlWA2az47f57hkseh6oa+FKpoj0vPYiUA9RS0mBP6H/IerTj/8qzFjpPsP9ov+Cqm9zsEqwUEOLzywdu98GUQ/RDrLHvZgbRze8cFgLjaFOD/rEq20+w6mVir0QuUxq8gyEa5ugupX3jBvPfunbtEPzpwBRgMHR075QYPBS49WDxjK7QS9jsgs1O8m648feBKnyaA6MsVvF2B3JmSK+1yZCq1He2m1Vzd8fPXUEeQLTXWtDLLvkRSUD6Du8cTH53a0YknA30ZbI+15C6+nPK+iPXIoPw98vN/85hMtSf9hOXzZsbaskxj1zlO38ywrNFugV+gVDiPnMoDG1USHtcPNl+HXR9tXTIM6Y3tt4Lnyrz8Hw7xIkAvV0mruwKP1fgf6jmzB7CexWDRM0BHgU6WWMaAiIAnTaWMWViyCbTBP2nXzI6AIeFEcpu2UE48exi9O1BOGdgp3Iigh2yh6i0sRGL+Msv7pCKjnzlAQfy5Fiyj+dNdyvZm/gsqoX/wS3nj7i1TKyjrxVpyYDuY0tCpO/wCkb5lXZrqjhvbi086UyjpyQnFctExL+thaNIcSFkg9du2swISL9392ar0/cZRnlqhpBSv5MPkTvi7HvEaTH+GD73g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(5023799004)(261021135927099003)(261021121427099003)(261022105027099003)(261026121527099003)(261022075727099003)(261026140227099003)(261102123227099003)(261028144727099003)(261009223027099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aXiSL1T6CYXTAkQm3OV6RcNnbYYc5RPoMeGMpKPpvLIEjaDtuwWjRjhiSaiu?=
 =?us-ascii?Q?V9j1NCBxgkJPnaCD3PblDKygDOIvWmMay7j95eL2XjEf36j0os39OB1k9OP/?=
 =?us-ascii?Q?FJwtkiqKmzrWvqTb3vXgnYeAE9JXDjAHmVjlCWIBU9XY5xpv50Yrp99olQbk?=
 =?us-ascii?Q?NFxUUetl21K09/K0qwy6/CKQx5n5zfemrVh9IAH59tFGz5AMMsZodF4tTECV?=
 =?us-ascii?Q?fbV7yImO5yAzkC3RA1kUTW9ouBDRhHUUP5EJvewLAVL3wykz0cRa3DKI2tFh?=
 =?us-ascii?Q?mS9X/pBxrYbjNjBOjFhaU5pDvV/T4e1uiZC/rdwqJ5LUGkgtu8FauByUEu3Y?=
 =?us-ascii?Q?H08V6rN0fIOQyMc1U+GvERVT7nGvd2XGZcCHw1FwlZmuKoRUeQ/FeIedM6uP?=
 =?us-ascii?Q?lxRECAJPyy6g+Xqc3zmw4xoA0yX9yubtgfk46zde3AhhVjjXUyc1zREt0Qpz?=
 =?us-ascii?Q?eqLcMf6WsViWMaXFKlbL3OaJew/Q8gLC20xyHmwz+Fm8Kn7SGDXJ+mQ2iSzx?=
 =?us-ascii?Q?cLXXbgajZe3BR8jSL1YRftz47HCV14YU+3s0SQ9eb2aENottkDL24mlbutwY?=
 =?us-ascii?Q?yh8/BRgPFweOIrNSS83mMNoKCivnvLOsjS7ujhjm3+hyM2SDpuusaxWAoOpV?=
 =?us-ascii?Q?oJFGSHeD7mA7+0taI7PnkerNTqqbNYDXV6kikySHgQRbqEohMbeUOm0R+pbE?=
 =?us-ascii?Q?zzB1yBWFFS8rcnHqxXKzHGVJeZbOZVeW7Q2c5OrXQnKmSPmDzsSgIjjLey5k?=
 =?us-ascii?Q?MYN36+TjPZefbqbs/sH62t1PYAVzuAhtuCHydvjwlOwWdt/NBLwB6xh5u980?=
 =?us-ascii?Q?0Z0fRrvRJmfsAgQZ+e80crJdPPuVlrY0a6uGYqTziOFOiZ1cMNxni3RvalUM?=
 =?us-ascii?Q?3XVk+4SAbZ29rgAhV5Nr6MygRProUbNpmQMT2qdw6LGPmx54d6mZgB0pKqNM?=
 =?us-ascii?Q?peSN8Ox9ZdSfyLBxhzQskT7JwMKnLs8/idIamaPaTiDY+Dtcw3srfTSTP3+N?=
 =?us-ascii?Q?if5ktwbr1/c72afC75XY7xDI8xcPgMpz/DYhn2mJg86K87M0rR8YedwY/DJD?=
 =?us-ascii?Q?oscKIFHbcs/zxxJ7DLv25T6gd8PIG9v2kwjF4pM7zTe1cDqXdN1PUvRpZI5S?=
 =?us-ascii?Q?3+4vnGdDaDg5/YR1GVFOc2EQSqlc73qKJayrBuyF0YHqPLYHvePTJkSht3eu?=
 =?us-ascii?Q?D3fkB8nqDWZwzw+KJnHVERSmUNcURQKGYyHciPL++sdnQOxjx05cjJtkB3Gk?=
 =?us-ascii?Q?mHDDR9tOuwjXRbhZVRAavDO/ZxXpNnKCQXBM3EaDzcPveNVB4y7dpeEnJsfM?=
 =?us-ascii?Q?t5cqluLPNkgDCMmFJfBQ1/gKgqhOW9ko8itLYxzskxouXejmkr5p0gir/rgQ?=
 =?us-ascii?Q?28dILb41pxwlhXT82rTP91hZv+ivOgnrZ5JYDOIKVLz/PBvnYZo6W6LQlp+Y?=
 =?us-ascii?Q?BNyYogyERxup1tOkVNqMRoSctG1HT8gt9Ac2H5jVqK5MnyvHx1vlDGonIbYK?=
 =?us-ascii?Q?BMc0YM7ov/7o7ujtZbJMNID+H/FwFQleP1RBAcbbubHo7Gwi1nESXgnY/G3b?=
 =?us-ascii?Q?/NErolT1uwIWV++tHK12EhhmIw+zRvd2tJMErenFLrK41IGymlaaonoxn88T?=
 =?us-ascii?Q?OIkpCZIxjLvnxovBoj7Z9f0EM8kj6RjL9bDRZjt6iHWnyLVrd5gQJoxFeHKG?=
 =?us-ascii?Q?XsatsOw/LAlyRKm96hPZvKx+cPBjHBXTGfq3my0Pe2Pj4+98?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb38f0f-0cbb-4546-d6f9-08df41e51628
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 00:20:28.6146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1SLaInid129KiIlepflH/MCcei0WTI005smUT7p//WisXPJi+L//q4HKKyEE7Fuk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8819

On Fri, Nov 13, 2026 at 03:41:33PM -0500, Gregory Price (Meta) wrote:
> On 2026-11-13 16:03 -0400, Jason Gunthorpe wrote:
> > On Fri, Nov 13, 2026 at 02:55:36PM -0500, Gregory Price (Meta) wrote:
> > > HMM can grant ordinary device write access to a userspace shadow stack.
> > > On x86, pte_write() is true for a shadow-stack PTE, so a populated page
> > > can be returned with HMM_PFN_WRITE without taking a CPU write fault.
> > 
> > I'm not sure I understand this? The pte is writable but you don't want
> > only DMA to write to it?
> >
> > Is there something special on x86 that makes the shadow stack pte
> > non-writable by the CPU?
> >
> 
> Some of the context is here:
> https://lore.kernel.org/all/20261111-mason-migrate-et-al-fixes-v1-10-3d2454362e8d@kernel.org/
> 
> We had a similar issue with migration, but this should handle the DMA
> case as well.
> 
> It's "technically writable" but the kernel is supposed to prevent that.

Bah, it's not writable at all. The CPU PTE has write disabled and
someone thought it was a good idea to make pte_write() return true
because the CPU allows writes through a special instruction on this
special PTE? So now all the places like this think its writable, when
it really isn't.

You could also fix this by having something like pte_real_write() or
whatever that doesn't lie about the write bit in the PTE :|

The patch is still fine, in that it matches what everything else does,
but I'd include these details someplace..

Jason
