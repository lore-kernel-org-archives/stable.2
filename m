Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013007.outbound.protection.outlook.com [40.93.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D6E30C165;
	Fri,  3 Jul 2026 19:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783105817; cv=fail; b=La72QdnB3UBoWmhb2E6h97VrJpGBGzdzCnRDkoSUlJqkBdZa/TGF38t+VIq8JmavxSKz8p2n7N0Els55diMBy3xlSExcYReLT8s+zvMgNu051A5rQiwotgUw1DOrHEz3KGUh5KRPH1BnsKl6yiyZY9BdXPyBQDiOWs+gZRRHcXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783105817; c=relaxed/simple;
	bh=xpSdSan7IjbqMswR5bAdLkihSY35cmk4L1LzlIp7FOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OFMjBGYjoZBpyk3iav8rHgsC3hV/8wb9pgcvpkcwvVT+0jHtaeUXuf0f9lLQ8z8ognnF5EsopWUdugVembU+4Y7D9/4fzy23KCQ+YojCQDOjhhvqB93/ZKsWlJQDKnNHHIyOvA5JiTUAID7gAUc4d+HeoNTAtkiPI4WP7Lwjt0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HbbQeP4D; arc=fail smtp.client-ip=40.93.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HbbQeP4D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hM7ZGPnU3hpY4W5hoPlSGCEyEVv1GaAlW3GPKGVKvWnDeDB1bm7EGgKSIxYeNeNkaRRs8zrp72WYp47Pk30PN26OpJ1lk8O7/yo6GRyl3oTFx5oBdd8YxtTdzU/gYlpRRVJRq9sQa7fsmksrFoOMF+Nhbu/QnCjejUngko7bbcTvQnKmPCo1Ks3GQJnw9jJwoGVx0TEKxDXm9WW8HEv3kevzj/4sPysk/9DjGaFDhlStE7/WyWGf5Dou7CbFelv8m145+rnuDi+XT0QCszMh6sBbvuuNWIGQ8/dWrxiIP6Yf6/A4kySFXqNwbA0iD6GAeX47Xrb0H00ObEX492OK2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=er2y6GA5qqkVjv1SlPPbUHzie4ZJJs1RxTvaZ1hJCnc=;
 b=pwEZG+mHn7VUF8UQQvMRDMdqRUW52R7XgphStnSuow/+SpJGbqTJl46dw95c71W8NN7msfIX5ccEjXnHZZapMlRXJYKHv4qYTgIdOZzpyE56RB7ouflWsPQOL1bM+wAdHkWM7JtWeffdRSvgY9lXFnycvkvQFY3wzKm5Fy8G5CbXDxR3D8o/eE/9V89Y8wwM6xXTGnSl76KRbNHLh3DrRb84luBuiri0IU56B6KZPKHadAvNuDsxsvKcdysufF3+YA4uIQsmp+K+W9vtwzBShRmQjFlUs/5NBLqbQp0YZ6NP55EyVoYPxnS4Aeqtn/DAQtY/BsyhmAEJ3Q7AL9eHfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=er2y6GA5qqkVjv1SlPPbUHzie4ZJJs1RxTvaZ1hJCnc=;
 b=HbbQeP4DXmIoF1Klnz67eIfBB95OCVCoHpU6OPf/UPKCyeR79bBpBH/B/5d0URpI807HAc1ME8B49qVSIeQF27ZA4isjN9P0mC3M6ZTeN5kXrdzIGKSFw33SdSGpH2UYkZ9RfDjh2lCzPLfCyDFph/KhcYGwWpj0Niht6hQm8kk7XKsnxbU1r9l7WtKy6+80jAgtORuHFAwM/xOmPzdeQLOBoAO22S1Xkuh+orRCu9EE861oy6xxdefFT227UkCI18Oc9O22/n6F4QiIJr+2L1BiCNTztEM/ifZnUzZCsuUBBCNgXX5Ho+4BF7mPt+0EBqyot49+Kimuub9misL7Ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB6394.namprd12.prod.outlook.com (2603:10b6:510:1fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Fri, 3 Jul
 2026 19:10:12 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 19:10:11 +0000
Date: Fri, 3 Jul 2026 16:10:10 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Pranjal Shrivastava <praan@google.com>,
	Mostafa Saleh <smostafa@google.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, kees@kernel.org,
	baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, jamien@nvidia.com
Subject: Re: [PATCH rc v7 0/7] iommu/arm-smmu-v3: Fix device crash on kdump
 kernel
Message-ID: <20260703191010.GQ7481@nvidia.com>
References: <akPhuF9pAWaBXzpi@google.com>
 <20260630185942.GF7481@nvidia.com>
 <akUQj2pa1W-MekgF@google.com>
 <akUX3T3fIoN42sdM@google.com>
 <20260702144157.GM7481@nvidia.com>
 <aka7N6oLVq3CoBqn@nvidia.com>
 <20260702235004.GN7481@nvidia.com>
 <akctXFSALBNfYWww@nvidia.com>
 <20260703115716.GO7481@nvidia.com>
 <akf9cjLaBLn82lKP@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akf9cjLaBLn82lKP@nvidia.com>
X-ClientProxiedBy: BL1P222CA0030.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::35) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: 233a8814-b9e9-4b28-94a7-08ded936b49d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|56012099006|11063799006|4143699003|3023799007|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	KCqPwpuE7buO8p0OfCOXdV99SOQcjf0E4/gaQvy3hVHN+3ZNb0llp83euG3f9y0WydaO3jikL1Pw3jf6vzlXwEWrZCxIm41BH2JoRYCztpESo2D8/eNCpgua2mLuKJqlFs4fRskuj5FdMBrF1PWEkMPz1uZszb+25v2lpgITiw/D6jYo4GRuykupngSdEeYyNg8ndNyLaSE1tV9Ta01jh+dMmU0Ha1cuODY2eZm6NVKC5FfvEG4WI6HLxNAPkAU0KRH59nREAN+n7OBBAbzPfakFycE4g6iHl3+XY80GqxaHuqDclLc4zacfnXMZHKAgjBuzSk3WEwPSnwbuNiST4tl+4X/L8v8nv1AvJyBMPXzI440gVoCDXMPxQwUnOzI7iK7FZTt6TilNwbFmN2oR0s/4QDCmHA8u+bR1lVq8iH7IKb5yKetBOctNfY6clmuMk/fYv2mycGu46sl+tBGnzNtqrVMUbYdLETl7kdXp0lpuwKGITUoIScs0ynfIgNiI091/NQDZw+EsgJMI36ovpvrCJ1wWKCD6W46ismqaGdf2fUPsZMOgWziFjJQPyir8Qcz5T9tD0KAmlr15Ixor5OxwZEG90JvCkMX2VUKHUKfB+6YH9yFjFlQ8zanac5lL4cGwPNrpQ4vTKBbRkty5Zwu7W869HEA3y5fhLtlFKm8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(3023799007)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qvmYEzlKndZnvJ5H9v4e/BHtj+ZqeK2vhnd63ahTISeN36D8ik2EtKfy19dC?=
 =?us-ascii?Q?WRy4LsrMsmSXbYJIYwrGqmFyK/Yg27tBLlTDz+NLXdpRsyDjHV1YiXd5p5A6?=
 =?us-ascii?Q?V96CDJPOnYUEDNaSxjO4pXorjfhzq+6A8bpsfNLGIZTJoKGmPPnFjkI6LWLl?=
 =?us-ascii?Q?Hu3FfaD+yHXQK7o3UMcz7qNKH7+6UmtIjYxJjsmU3AhJEtq/AaYfCLyOB3x8?=
 =?us-ascii?Q?JBxl4TUVrqOXV7nkLvoLOuYEFzouHuFB36Wu5to9CpSlWRIF4oOFFgo55DDg?=
 =?us-ascii?Q?s3CLh3mvVdfjF06Yk0scJMn7v6O6UbBnD0vWayH6vabYkza9m0cMD47P806W?=
 =?us-ascii?Q?kixt5WnvjkaQh4nKbtY8D05QvL0lCCg/yEAo5NUtYhYx1eJLJzfvDxx66oYP?=
 =?us-ascii?Q?Mj7707vqS40z6Fa25QX0CoP9fnDhMBdnVPV4OGbDRzX7H8ymAuCO1sr4es4a?=
 =?us-ascii?Q?gihy1HjB5fPJE6ga5zt9bnswEfV5aW9p9XqCa7OBQoovmMbFuYyNioNYXIGO?=
 =?us-ascii?Q?tVxvNPj7ieweBO7MdoRY9p7vz2pXgCxFMvECrZ1WcyzZNRJd9oYPk3wl7ATY?=
 =?us-ascii?Q?F7IZ2Z1Tl7YvoWzzjLCX4EK4iWG5vGRKQ6EMiEb0xRuTiaZcv0l0sAB9c/5V?=
 =?us-ascii?Q?1cGlICMnIX5N9TI6vPN1WzikSDucyOFXkE1dlK3LgUNA6HvHz/YpQoEqo9zi?=
 =?us-ascii?Q?ja4nWHiYCtp8ikhws5gbZWH1/9/5AQ833locgpc3vfre7DtnIlb5rmt5o7v4?=
 =?us-ascii?Q?QfepLtnJYrVKKUDBE4D5xY5CycHaWNVYzTNByDtpd7QcGwLBjfDcq5h7Vbyg?=
 =?us-ascii?Q?bDinYO1hP+LbBzYrhAi9ImiMPspg4VXdVDbtQm1P3NALIJFeWcSl+r1pfpDz?=
 =?us-ascii?Q?JofW5vdpuE+N5CpfCFSCemEoCaLOpJ4sUr8yTOXLRrda5vTk3mYNGjmUmWGQ?=
 =?us-ascii?Q?KIG42XaoVs2e/mnLuw/iQmBExmBJzi15ElJBNle3RiqYiEOHTohO6PN6Y2d9?=
 =?us-ascii?Q?c1quETpnZoMz0LHqfpfsp6E5v8FQ2YX2by160NIP0PkgiffDpyP13kSEiTvk?=
 =?us-ascii?Q?FQDLTUK+EcHJpATsFkwHa0UQc+U1nXB9GUuchgbMrgKz5RrRrDN9nA48znHe?=
 =?us-ascii?Q?6rKN0CYSJtObJXuQRFwB4fSUq+XSPKDD6x5/LCBoDlRJsVWGs/eNxOsxAF0c?=
 =?us-ascii?Q?7o9f+9gGrc6/YQ3Thb3HCExUIfqaO2XtOpZXql888GHsnB4urN3CLq71ZKD/?=
 =?us-ascii?Q?s3fjQppKFBvUcHwFQqL/ULMOPNVxt2TaHk8H5zMnKNZGgdWFlyaelv6t+XZf?=
 =?us-ascii?Q?SQjGVV+Mj9Vx2XexGLFvlM1cOglCtavYJM5XnPbs4OEEUj5/Hk63ZcGyQj70?=
 =?us-ascii?Q?RXLMxrWmmJrYgO3scmuRYnEiDXOHlPTBCIIbSLRuWi1kcHopBtlnFMq7dc+R?=
 =?us-ascii?Q?FPbTXnX5Xmy2dnwGXXZdHOj84Rf41biuIAzya+7mV1fkTH6hShtngz3T3ji9?=
 =?us-ascii?Q?UR0eGlwVkKf3uk3SjYK3H+n2ofzBvmO0Qq8k4XWGJaJlRyW/KoTp6x5ZbODA?=
 =?us-ascii?Q?OYFg6d5zJODg/T+ZfanmKaimizhSypQ1VF9jucO4lQ7nUmF5ov8Ht1tFPV/L?=
 =?us-ascii?Q?h5CfY8SI/WK6A6Xa2AutcdRiNS5LR7aUueQFX3fDXO5eAlMS7ELJQwaBePNA?=
 =?us-ascii?Q?50oYwoUybEORr+561QpZl5HFMEbtE9LeT+vpwOh0zRHrrEmc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 233a8814-b9e9-4b28-94a7-08ded936b49d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 19:10:11.7629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4X76UhbIIWSIzd0kRoZEMvTtLO/rmKVOHSUZMwDJZNLES/MTGwiwnwon7dr3EFUw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6394

On Fri, Jul 03, 2026 at 11:20:34AM -0700, Nicolin Chen wrote:

> > So if you disable kdump when S2 is not supported it also disables it
> > when EL2 would be used, which effectively means it is not supported in
> > a VM.
> 
> Hmm, they are actually not exclusive: e.g. Grace has both.
> 
> EL2 is from FEAT_E2H, which is set when
>  1. IDR0.HYP=1
>  2. cpus_have_cap(ARM64_HAS_VIRT_HOST_EXTN)
> 
> VMID is from FEAT_TRANS_S2, which is set When
>  1. IDR0_S2P=1
> 
> So, host-level stage-1 TLBIs use EL2 commands (no VMID); guest-level
> TLBIs use NH_ commands (with VMID).

Oh... I see the half baked BTM stuff pushes STRW it into the NH mode
because the CPU runs in that mode so we loose the VMID :\

I guess VM support is important anyhow so you do have to scan the CD
tables and extract the ASIDs, carefully considering the STRW and VMID
of the STE :\

Jason
