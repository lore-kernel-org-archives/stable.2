Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.39
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795208045;
	b=EPlLfM4Umv3FgqBjIeROtlOu/cmhBS6dFDqs6GxiGxj9+w2hf1EpEh1Ey6Yra55IktNG
	 r5iDfof3J7J3W9+I6bLzDlGaYw3KogyRX0bIyXMNfRdZj0K1abtWKSoCRA1vdQFFXXj0t
	 ocW92J2GOift+VGAmR5AcKF1VrDgL+UUAKvrsHNc0JKKeNLyiWYepIlIU7Qfqc1Lw4JIb
	 fbdDjfffp8qhiUfDfUn1gxtn5CoUa3+sRuIFhOV2Vm52wSwQQVq4dETY9imSdBq6saKD3
	 ejKEXQiFIiPkcMm3RRIjgIABc7Oq4CUs4yeR/IKT9DvMVfpCZ2S3eghpRHHt5qx4Kfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208045;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=RyLZFkfDZ1pYXmX6+9K7BltbFhAeNweFKJJ5TC8klXA=;
	b=xKC1GW+x++wi3OH7pw4zCTy+mUNaboNE4xWzHwUHLwb0of4Ja/AEx2jtErc7JmKGa4u/
	 bYNz51koDg4mYgvEVr2FvVQFxZF53QwxQJPTe+CKRWvJzKftcDcmEedWTwm9/C5/W/KjV
	 DxTWGG87/md7/TSa4YQPsCUEQZ29A5Dpjl26BEmlYaO5yANHjjwJuFpnpuCuZCXbkL7dF
	 J9sxZT56Us9ImvEfEQ4taX3+UGPcQO3ApWLLFmWz6tvCmcLmWGhjPNP+td0+EOrfKZvLw
	 VjhgZ6trpB4yOsmtguVwVlRBwNaJuIdfCw30EYRHthZ15gRx+9v7aZ4tpYHLfizdk4A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=E431B6Kh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.39
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011039.outbound.protection.outlook.com [40.93.194.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC38A606A690;
	Fri, 20 Nov 2026 20:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC38A606A690
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=E431B6Kh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFtH4REeM20jQKJmCWk3BrFZn0PxBpzjjm4bPwEjcg+qmA74l+w8eoVG+aCRtxFq9DMMCJLXjs6xUsHS/ke0X8YH/4Wc8fGsz6OX8yN7CTAu31A8P5PgsuMQaMPEmVdNyw4/66miN9ABbuGaj1z7Z1wAYtl1VXVCgYcLecsKG6a3phHiw6W9aHFUKV5MsrCprw+vCsklvRph9t3sUE1F05IibvySItsULphL/DAVVHSwaGWPIcijnKHuOTJPFn8BGpNzyufv3CGK13O9tIrHLFgnrYgZB438Ppur62mkISdNFk/9BhB/dHqaa7S5O/TBWjPn4FIQWr3w3czu/TkCgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyLZFkfDZ1pYXmX6+9K7BltbFhAeNweFKJJ5TC8klXA=;
 b=fHGaiB4MGeIYRFNHKFOPpmeyrwNFh8yh92oSCytTqTVcM7oYE/OU5W4kuo7qO19ZuFYU9QP6MLiI+6cYO0sNq6nDwsB7Fbmy8iiRfC/HfsCDxQRQ4x24BGKdFhPFJ+Bq057bz1tMSnLK++tnrftlqhkyRf6QU+dFIcn9rBGedv9T1pEOnmNz3R6e1WvVNBJMvP//j35qr7VWLmZ6zuSuHqg+ErY2G7wzGO3DjmHpHwuelSIhmN3yGL2M+ZyRPg0iKtv5ypynzMQWIwmcBr8Gap/m/zovpCzop7ctvR3iG2ODvMBR1J7/kQKydRqNiW0kGoxX3h+c8nrfXmLplVbCzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyLZFkfDZ1pYXmX6+9K7BltbFhAeNweFKJJ5TC8klXA=;
 b=E431B6Kh1/PJnnVVosR7QiPcSqZUrxbf5o6Cmf/sl+Y1bE9pnxlALhe5c2rZkIYWpbzX4ClbvFB0JhRbVWpK7m/pvWU/bx0aDgvKNy8X8TQ50uT9yCxlOfcc1ORKiVQ9JeIFq0eco9YOY/aIiQEmbD5fSnI2OSWkgTH9Asvc36feE6nWPrBCRqlU30qECMTRG8jLY8sS8Q+7g7j1OU2fn6HGTgR8g8E5cnhQIQGSkmEmLVbXHBSEOmKaQslFuuIVBcw2Wzor1x1MGikXCkyA7snOujhbudJoLvqpEUE96I1gNPwtlwMR0dlOd0wQlTSch7xx0e4fw0/1YNXLpADX2A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by IA0PR12MB8748.namprd12.prod.outlook.com
 (2603:10b6:208:482::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Fri, 20 Nov
 2026 20:54:00 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 20:54:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] iommu: Hold group references across
 bus_iommu_probe()
From: Jason Gunthorpe <jgg@nvidia.com>
To: Peter Chen <peter.chen@oss.qualcomm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>, 
 Kevin Tian <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
 Johan Hovold <johan@kernel.org>, Fenglin Wu <fenglin.wu@oss.qualcomm.com>, 
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261112110747.1903321-1-peter.chen@oss.qualcomm.com>
References: <20261112110747.1903321-1-peter.chen@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 16:53:56 -0400
Message-Id: <179520803625.1164516.5819106673711321760.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: BLAPR03CA0109.namprd03.prod.outlook.com
 (2603:10b6:208:32a::24) To CHBPR12MB731189.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|IA0PR12MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: 820e79c8-4d05-42b2-7955-08df474866c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|23010399003|1800799024|261021123027099003|261021121427099003|11063799006|56012099006|261022075727099003|261022105027099003|261026140227099003|261028144727099003|261026121527099003|10067099003|261102123227099003|261009223027099003|22082099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	19beTQzfpBje85K0iDUNW4HA+G9Xo8e16Q+nvHgSu4EcLK+BRFK10cmUYdtEIGR0zdHBpGcf/OG+J6ujsepTkjt1Ft46xs8VWGTuu5oQFid7l0NBRY1ToOrL8NVEH9uW6wDzfRsO+D+S/8bL/9G7SetP4b3WrxU1SPQNZif5FT5fkfUnSaDCel9TY3Ly6uu83cbQK1CJ35nSLq4AtNf0CR1dt/szWMfdByYRRJaB2bBzvatXnYRGkfB4Z2gZUfVkHNfMyB6eqy+/W6QKSLUe+eMyciersVt/WnV9bOYIUN1Bu7me4PX+0jcQfy+5/8e6Au2+SRHoirVEgllGlSCy3H0Yt9n2ht6mWWeU4/HHh4+UOZbNAW6otGb4qNLRMP5bSVOJcXDBMwagWhdEVlNKBigxStadz91JUaJHeWtWLDK9qK+mh1Z1/GgndDYfsy39d+91lN1QkcGZ9dIuenUIk1YjmgcIBsZ4OFUuzP0sdfCntGjamv9iAsy2SNir3XAZSSkKch09UbMyueAPNt4qRpBSj2FDEHfrqFLxgp8XsYvj7zzUGxsEBROGgLv1mSYpJ6SiLRNihPvfT0Ju7eGfgeW6sKw//e7l4G2k1woE6X2Lm5gKGSVgamMUGK8VOzThXrnCM7yPngMk1afPFeBYgjvltI2CNsJwjHzixZyg4DA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(23010399003)(1800799024)(261021123027099003)(261021121427099003)(11063799006)(56012099006)(261022075727099003)(261022105027099003)(261026140227099003)(261028144727099003)(261026121527099003)(10067099003)(261102123227099003)(261009223027099003)(22082099003)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eGRsUmYreFlabFpwUW12Q3B4eTB6eE5LcGVwK0l4YTN0d21HbW5GbmdUaXp2?=
 =?utf-8?B?dlVJVzBwdG9pQVRFVHpEZ1hSVU03emUyVjlNV05uSjNqWXZKQ0QwNEdMd3A1?=
 =?utf-8?B?K3YxSlRJdjdQZWVaUkJvemRYM1VDSHBtemVXUWtSS3ZjU284Sm5rU2V6Vm12?=
 =?utf-8?B?dE8zTU9QZ24raUd3Qk5GR3dpQnh1ZnpCWSt5dWZ5Y3pZcUVTY3lmckExR2NQ?=
 =?utf-8?B?SXMzaE9OUWZPZ2pzWFBseHI3eGw2UnhweEhGZlhGOTNjTGo3aEsycE42RWdQ?=
 =?utf-8?B?V2NLSEUvUGdjSkZiaVA1YWRlUk0xTlRvQ1QzUTlWRmdUY0RtYmNZMVhwR1VY?=
 =?utf-8?B?TXNnWGRKUndBemkwdThhOG4rRmJIeFNxU0JMQk9UYkswTHd2cTR2eFk1cnox?=
 =?utf-8?B?SzV4ZDUvbGdiNEJYNkVTNXpNVVp2Qyt0SHpSSmRLSUlTSzNjdFpQSFBFSVNh?=
 =?utf-8?B?bXBZNXNVaXVpQXhlczFnUHFDQkdoemJ6anorSzR4TU5Sd0NoeGx2NDJVUjFL?=
 =?utf-8?B?MUVPY1R0dkkyN0FrZG4xZzNVUk5uMWp1eDBFYlhpSmptTFlrVSs1MHcxQU1V?=
 =?utf-8?B?bU1BV3FOSVRuby9UOFF4U09mcXFFaWViY2lhdHlKT1pTaStpOUg2V3dTQzZh?=
 =?utf-8?B?cEJKdW80aXJudDBrcnVGOHNITmxzZ2dXbWFHZFFuNmVMRmFFeDZSdWI1ajJh?=
 =?utf-8?B?K09NaWxDMHVVZWhDSTFHTXBDZDgrMWh1V3M0ZUkvaklYd3V4ZUZIaG03aWQ5?=
 =?utf-8?B?QnR2cFNJTW84LzdYWFE5Y2VnMFhzSU51cXB0ODBocGhGYUNQMGQzUVFuUlBG?=
 =?utf-8?B?NnZQbnpVUzdpd01Vanh4c3c4WWcyY0kvK0J3N2VSM0JPOER2T0t2Y1Q5TWE3?=
 =?utf-8?B?SUZ0eDk3WjI0ZVpMZzRDUnVWaHowR3A4ekV2RE0vMThpYXpiS3dFTHJ0TXdz?=
 =?utf-8?B?V0tFOGxseVdPVHYyVmxpeHlaR0dZTnY1cEZXcTd1MGdldEJZY2YzL1Zva3B3?=
 =?utf-8?B?VGtiU1FkVGpuam5FQTVEZU9mV1dzZDVjc2l0c3I4WWNTZXlBY0JSejlqNUhk?=
 =?utf-8?B?VjhDL2JIUGM0SFM3UDd5SW5IWTM2eThKaHZjWmNqQXNKODRENTVHL0UybHZR?=
 =?utf-8?B?dG1BWFppb2E5VGxGS2t0YzlNQk9UazMzQmMvenFUTlpMcURzdnBvQXhTNGx6?=
 =?utf-8?B?cWhGT082TS8zSXp0Q0JxZEdKRDF3Z0h6YWt5WDI4a3VSZmpVYnN2NVZMai9x?=
 =?utf-8?B?aUw1cWtUcTV3R2dNdGsvMHdvUDFhRmkxdk9qMTdFekxVWFY0TTJJaHoveGpx?=
 =?utf-8?B?dk1Cc1g0VGxlMk9UNGVRckZBQUNlRGpHemMvQzRWcDM2L291SHFpdzNDeXFJ?=
 =?utf-8?B?MHRsdzE2RVVJaVkrSGdyY1BFeURZSDg1Z3Y1OTBHWk9DeDVrTHNWSVpneU5P?=
 =?utf-8?B?Sm1BczgxS1BaWFF6YUl5bkU4UGhUaWwzMEFwdCtUWTlxWTFvNXg4QmlTRi8v?=
 =?utf-8?B?MmhOZ0ZzcWc3MEpTQXlKb0ZyU3NQaVE0QmFXVlhJdTJsUGc3MVVOZ1ZCSHdF?=
 =?utf-8?B?eDBJa3VzVjdOazZ2QUtLc2UwdmgwRDNHUktkQnhRK0txdjhnWG81a0ZsY2d0?=
 =?utf-8?B?eGVUQ1dXbjQzMms1V0VYMFVVL2l1OHBPMExPT2JoNU1IMTdKN3JrdzR0NTdv?=
 =?utf-8?B?STQxaXZLRlNEeWYrS0w4d0Vmb3N4bGZaMk9mVStzMEpSM3BKV0dTdFJYM1A2?=
 =?utf-8?B?eE8rU2lJNjRwZlY5SWx5ZTd4cXJUSlY2Vlhscnl6Mm5EeldVTjMvVWwrbThO?=
 =?utf-8?B?S2E4Mkl6QzJHeVlKUUhHdEhtc0RLaTNINkUzVGU4K1lDM054NWxpUitjRkVX?=
 =?utf-8?B?cEI5RkxEN2RuUmhXQWxXeXdDb1lCUGtNSVBkd2JFMUszYy9SeWhONngvM1pF?=
 =?utf-8?B?YUt5c2FRQ3VDM1c4Vjg0WjExSUpNaElwMkViS09rTFlTa1pjeVJXSys2SG9o?=
 =?utf-8?B?d0VUZkxzZEQzZUhnaUVNSUtMTTF0dno4V0ZMSUp6Z1FOM0pkeEhvV0YvMHhH?=
 =?utf-8?B?MnlKaUNrODF5dC9LczFmanJyQzdQek03VE1Db0g2WXFVQzdIN0ZmMUJlWEhC?=
 =?utf-8?B?UEdHSUs3dzY0ZXlNSEtVeE9IRmY2T1ExWmNxdmFlemVaUEU5MmQ1VUFRaXJC?=
 =?utf-8?B?SlFXYXF5VVFoM09BRnpocUpiT0NiOWNDR3ZNMmZYUzluYVJRU3hTNmtDYlRF?=
 =?utf-8?B?eFJ0K05LOUVjK3NEQmZuWTdKUktNYWRPd2xYdlRLSWRzbE8vUjhLdFA1M2hs?=
 =?utf-8?B?ZzZraGtMVWVkc2IvbDVNYmFKS09uMy9FeE9zNE5nUmc2TWZ3TlpxZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 820e79c8-4d05-42b2-7955-08df474866c7
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 20:54:00.0964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4EgUSqEX1oOylvLTDhtnNEdO2Pfcj53gkEpZybiC5Iymq5sHm95xQcbj8pj3smii
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8748

> [ ... 9 lines skipped ... ]
> This is the "iommu_bus_notifier() being triggered during
> bus_iommu_probe()" case that commit da33e87bd2bf ("iommu: Handle yet
> another race around registration") left open. The sequence is:
> 
>   CPU0 (driver's of_platform_populate / of_platform_depopulate() path)
>   CPU1 (arm_smmu_device_probe() -> iommu_device_register())
> 
>   CPU0                                CPU1
>   of_platform_device_create(T)
>                                       bus_iommu_probe()
>                                         __iommu_probe_device(T)
>                                           allocates group X,
>                                           queues X on group_list
>   platform_device_unregister(T)
>     iommu_bus_notifier()
>       __iommu_group_remove_device(T)
>         iommu_group_put(X) -> kfree(X)
>                                         list_del_init(&X->entry)
>                                           <- use-after-free

This seems odd, like shouldn't something outside the iommu subsystem
be serializing these two things? If some driver is calling
of_platform_device_create() and racing it with
platform_device_unregister() it is broken, IMHO.

Can you explain more how this arises in the first place?

> @@ -1951,6 +1955,18 @@ static void iommu_group_do_probe_finalize(struct device *dev)
>  		ops->probe_finalize(dev);
>  }
>  
> +static void iommu_group_list_put(struct list_head *group_list)
> +{
> +	struct iommu_group *group, *next;
> +
> +	list_for_each_entry_safe(group, next, group_list, entry) {
> +		mutex_lock(&group->mutex);
> +		list_del_init(&group->entry);
> +		mutex_unlock(&group->mutex);
> +		iommu_group_put(group);

What is the mutex for? The group_list is a stack head so what are we
protecting list del against?

-- 
Jason
