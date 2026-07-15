Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010018.outbound.protection.outlook.com [52.101.61.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7862773D8;
	Wed, 15 Jul 2026 01:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784077347; cv=fail; b=KY2ZtHG295qLnF2h95+Ko0473lwi7bq9C8RWlF3MhvQ3Vnv4c++NCTSRu45w0nXBhqkQgOxOTNGxR0Op0fXWiTCjk0u0eSzcStS6fYXPHKzAfEVReT2piOfg1naYzZjrrtgYnSEeT06w78oeYs0S2ETQ+QUfjj6nrmLE/Nh0mFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784077347; c=relaxed/simple;
	bh=ZzKbl4bsypvqKR5pPiQ/oeiRv2lG079l2mWQdx2xgYY=;
	h=Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To:MIME-Version; b=W2FPEq8MNp3JrBo8uTiUp6ICBshAEEIvYw0ca0VkmON1EIedK12fY3ca+3/hqHZvaQQP51JeaJVxPPleQtmDApyQmiSb5+YCmE0JAploCx2AHCFONXXO8mfvT86iSc8kylOT01IpTVVWfhWr+4xwbiYmernf+Xf6Q0vg1rTodbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m1zRuI4R; arc=fail smtp.client-ip=52.101.61.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m1zRuI4R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6whVJA2d1pHiG0m0CHzid/M82V/TB8m+V/JCjhy6nO9NZRP0WaaTmsf4Wp8tgKQ7OoPCWA4jnShvycGJarKZLE51dsB/QwUv6saQ8mLx47Qhm1IiOBnmOxHCnxTrzarbNvtQmKqapNTfjCX55qd46fnnWk2Ba02LvaHSmdGVG8LBfJrgfslXqZjPy3Di1MyBSh6Khjbp3FJuIoxt9c2s0vfegNLEiOsOLloNRvtSs+M6V7fnT0HzfERfX27zKN6UjXxXDsf1nvtHKkaP218jkQKAtRGZGgiNgpMP/PbewJAb1eDZtTJqCxHm9Q6bWN9SAT2kl5aGXi3pHuXZ75Nsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6mxE3xjt/Mc8VC7nfyYootatX7UmYTWpC+Qejrzhrk=;
 b=Jia3Z40EB3t6497GPRyUlSYYczzDGei/wg0ziZopWablYfiK0gbctEyyiOR5ZSgODNMIBUjOeFrZD/qkbIRqn+WZWV9BJIUxjIAM1EeIpAD7q3GTFxeIEIlxDRKb0SxbYQhxIvFG65CimX/jTcG4rRhy1CYfauBzAMwMAX8+4rRg3Bj6PiCgBfTMr5HvgStuzEkEt7dTHZYyEQZm3sv9VlWnOACcWys+wweNOL00/U8coxQjLf/Z41cgOfUbS/qElsZ96TVkJHJy2aS092vPV/BnA8rFjZqNkaDeyT23Ylg2LtHFthMiCsQB/hT4BW66PBSmV899/CDn/PgTicN20g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6mxE3xjt/Mc8VC7nfyYootatX7UmYTWpC+Qejrzhrk=;
 b=m1zRuI4Roz0YOggT4yHUlNECb4iulQuJG/ijhlF3DtonoS2SMDacUsD6lKstScnVu4yw0Ffg1KTwZ0K47JiiEKmsmBzNRSbhniOpCe040KkSg64Vc+3dGMAmD/6Ff2oenLJR4QGXA4Uy4Ed1bxAKhqdXUCQQ+saZzMvHGMr17PcnyEbT7xl0iTHp8qN5soVuA38n++jbW4FB5hI/nfDGq1RUdPk+4j3GOmT/jSsHj7X9NRC2yYwsPIjVV7tHftY0hxD8DyF0t9Gx7QMvdSAbiRBPDKbVOIdjahws2gDeZi/CvApItenvEKfNhu4ohOUlg/dV4SLkm1OQe5kE+R0rgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 01:02:18 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 01:02:17 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Jul 2026 21:02:16 -0400
Message-Id: <DJYQMTVRAHNG.1DTTNWHH4006X@nvidia.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <zhongling0719@126.com>, <stable@vger.kernel.org>
To: "Hongling Zeng" <zenghongling@kylinos.cn>, <akpm@linux-foundation.org>,
 <david@kernel.org>, <ljs@kernel.org>, <baolin.wang@linux.alibaba.com>,
 <liam@infradead.org>, <npache@redhat.com>, <ryan.roberts@arm.com>,
 <dev.jain@arm.com>, <baohua@kernel.org>, <lance.yang@linux.dev>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH] mm: huge_memory: Fix kobject cleanup in thpsize_create
 error
X-Mailer: aerc 0.21.0
References: <20260711084624.207777-1-zenghongling@kylinos.cn>
In-Reply-To: <20260711084624.207777-1-zenghongling@kylinos.cn>
X-ClientProxiedBy: BN9PR03CA0334.namprd03.prod.outlook.com
 (2603:10b6:408:f6::9) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SJ2PR12MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e241afa-a8b0-434d-c53a-08dee20cb765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|18002099003|22082099003|921020|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	XuZcSrRjpqQF0rY03Footg/qRyiQ1eQ+j4BO37r/1Iqr5CJpmbyOtpuN57Zvo8IJGSsUXy2o/wLuc/VAJTS2TX6/89bebG3Q5LSoOIYR1z2QSB3hZUS83qC0/ZvHI5kDmz2S86Ez0+Dscoml79gIivsaDT6Kpa642DGjtbRDJsgY5mgiJtZJB+3lBJ3AL6rNnAw7j1mzoa99EDDvIlSyu+Mj3SeLfaOQVxo5rmIdLRhYmRmShdK8XLxtwCwISTq+rGhlf9S0Nf9XrJqgFdmBfHn5EsvIOTwHv7riKJDPimCQkWawmlRyKi2YFsmnkQfF64FmprskmG4DfCqpzLxXOBw3LhTBNuvw1cJuIGG/PxgvzhV7JOkREv5nkMdlZ9WhSHYk+CU7osnMVAOp0gLk40enh6SPQ4mcOkm5qlQobXoIwMi21UdSiEm0WAkz9IDYm9jGiX+01rbbX1t9jr7KqqOh/LJbZYcnhF1kGoLJhbtnGMF62NZeI9qSggtJvskT5tx2L6dQ7kqnI4MrKKbj4/Nbi3PO0WSZYdL2Rnb01SS//0vp/bSM0F6LmKm34kBN/lypiqKJUHQzx5rmV6wolEyode6oef+F8KXGq2AdDfjrbYz/CFz+A8dCONx1g4VmZPr0Qn6XTc4lMIcJVD+L0CCv3Ej27BfUy9W7zLgB5mJt8fFkdW8pRb2sSb8rlQYvGaTwOBAxeNsGyHf2d1s+Ew==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(921020)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUlwNE9HV3FEZDFGWnZNdWI2bGI5T2J6ZjlFZTY1alNmaWhZanJUVTNEbDk2?=
 =?utf-8?B?Y0o5UDNjS1pjVHB3RjZkVWRoL21aMEI4bHhWcytwRjdPbDV5VXNYN3BBOVdq?=
 =?utf-8?B?TzVwL0VSOEwxa3AvUjdhMHgwUnFXM3BITERyN2VmSmp4em1IZXRpbStYZWJ2?=
 =?utf-8?B?QjQwb0pWRGlQcmUyMG4vWmIvVTlKbFlKdHN3c3M0cXJaUG5QNmplRkhJQmEw?=
 =?utf-8?B?K2oxblhaV2dQNVJ0NThDZ2lac3BwYXdvQ2xlb21qdWRuU1lodmhlYTI0dUxN?=
 =?utf-8?B?TDRoZUljVUw3WkdtdEZaRUdKRFJNQVhvQXYxV0dJR0k1Nm1ZTFFSdjUrR0tl?=
 =?utf-8?B?bG1yQXNOSG9kMGQ3V1hCcXpFSk9LNHJpZXlxMWJmSmdrZWRhc1M5WWRld3Jr?=
 =?utf-8?B?VEIxclc2TGZzSFVML01HYjJMMTRlNHUzalR1YXhRcXNvWmNna1NCdHFhUUVP?=
 =?utf-8?B?bllnc05JT2NVb3ZaWUZVaXFmTFdmb3ZJZENOS05FU0lCeU1VV2lDQ1hNOWdC?=
 =?utf-8?B?cEtzWkc2aXZsNkVzSXlvdlB0RTNqOXExZmxFVmZvZmFheFc2VkRoU2cwTnUz?=
 =?utf-8?B?Si9oY3ZDL0hXQnZEb09BVUZVMEtCUVJjODl1eWxvd0lVSmEzeDQ4TlhpR1ZW?=
 =?utf-8?B?a1hGSzZ3R0o1RGJKSTJyS25pUFljVWEzTFg1QTFiTmJTTEVLcXQvbCs3QllR?=
 =?utf-8?B?amJwT2RaakRKMkQ4Wmc2YlRXZDBFenZMRlVodituT2ZEbk5adExYcTlERGdy?=
 =?utf-8?B?TTJNNWhPS085MUwyMmNnY1N2Z1hXZXFvdXV0dmJXaERkYjhrZXFld0xpT3g5?=
 =?utf-8?B?YU5YVjJRcDFpYjdnL1QremRnOWt6Ui80aDNDZHRCL3M2ZlJIUlN5K1VXbEpj?=
 =?utf-8?B?NmNIK2MzWUxYRUdQS0JZdHo4WldMbm9QKzhqVm41eFNwSHJkTGVFNm1RRzYr?=
 =?utf-8?B?ZXgyOUpiVVpianhuL0hJcSsvVFdIY0laUmV6OGVmQ2YxTG12UTdkTmhOdDJw?=
 =?utf-8?B?S00rL3dsRlhlVUpzYlFoRHNpbU12THdQNWFKd2ErQmlrWHB2MXZ5ekdlSEw5?=
 =?utf-8?B?T1o3MXhVZmMzRnd5alJxMVJHRDJEeUw2ZENTOHAxdWJEM01OTWNtay9wbjRn?=
 =?utf-8?B?aU9mTTg4S3FVSUFwbEEzM1h0WkUrTFVVWDJFWGdxUUk0VFpvMkIybER4TW4y?=
 =?utf-8?B?UVMxSzk5dEhOUTF0SzlVZlJHbUFaalhlWS9CcHFjd1BrQysxcDBPVTA1eVZW?=
 =?utf-8?B?bVlwMUlXUGIreFZxc3FnT3FwdU1mREdnaTBEd2dkRlRTQ1RPYzVtcThMaHMr?=
 =?utf-8?B?eDkyalphVC9hbkQrUzI5QVNXUmU2SHExMGRteWQvZ2tPSWJ0NWNsK2FMczYz?=
 =?utf-8?B?blVhR0FXRTlGemg5bXk3S2toSEtYaDRILzVBejFIaEZEbkYydnRObm9xL3Qv?=
 =?utf-8?B?SjZ1TUZWaVFDa0xjU0dmbXYyZG9OWlp5cjRWckwyczBWUUN0SjRzSk9jRm4w?=
 =?utf-8?B?VlZyanlXMUFKWjAxSXM0bzFsWnFRRTZic1ZKcXZJWTBoVExoMVE2b3laQ1lS?=
 =?utf-8?B?YWgyM3pKejdBMkxIamgwa3E4cUE2TXdRY2kxZmJ4eVFKdVNCSEVRWnVic3JI?=
 =?utf-8?B?djVwcTdReGd5ME1lT2RJQlpPRHh4cnNtOWxFRFRRSzN1VjROdEtGZXdVU202?=
 =?utf-8?B?Tk51aTZPK2lhNDMvSWFWYUhzQ3FSa3Y4Rmp1RXdMekVnTk53SUxDUW55LzBT?=
 =?utf-8?B?MkQ1K0RWMFNkVFV5UlVZMlkzQnoydjBqMWcvc1FJWGJ0cFVTT2V2MitCdDN6?=
 =?utf-8?B?SXpRMUhmZkZPQlpMYnVMdnJ5dm1LKzlWcTlzU3R5dFJqTU9NWVZlS0Y3SUZZ?=
 =?utf-8?B?Y3VMT2EvWE51T1JOWFhaZ3NCUDdUK254THAwMW5kcGRkNGxYRC9aVi8wMUVw?=
 =?utf-8?B?ZHZiVjczdTM4ZzJBN2szSEtRUVk5aDMweTBsekRlUHVKRDJHaHo1OXU1RVpr?=
 =?utf-8?B?NGpSem02UitwbWRHQzJCNm9ubk1xSmYxd0NmRENwRm5wekpVaVUyUmRteFIy?=
 =?utf-8?B?Q29DU3BMY0FvME91SW43SDlER3RDR3B4aDJhMVl1a0F5aVdXbE0vTE1EY29M?=
 =?utf-8?B?a0NBOWdQNFIvaFFBU2JQY205VU1wTXFqNGt0ZFRsU0I0a0hUbHhoMUVLNFpR?=
 =?utf-8?B?OUt4QUtmZ1R4TnpqeVlFbTF6b2c1V1JTem8xUlU5Y095Q3B4L1FDeVpBR0g2?=
 =?utf-8?B?bHRLOTFhZlZQUDNjVFFjQXMzanJOaXBKcE1wcnVGOXM0Tm9yQnd2UndJWEpL?=
 =?utf-8?Q?IBF0nVr7pzebpkwD3m?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e241afa-a8b0-434d-c53a-08dee20cb765
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 01:02:17.8667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PCU0gPgXSL+Isoy0ja6gX0MyRuDf1ARaXCLejBRj5Tn/LleyVrMzJyfwDmv6N+jy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8689

On Sat Jul 11, 2026 at 4:46 AM EDT, Hongling Zeng wrote:
> When kobject_init_and_add() fails, the kobject API requires calling
> kobject_put() to properly clean up the memory, not direct kfree().
>
> According to the kobject API documentation, kobject_init_and_add()
> calls kobject_init() internally. If the subsequent kobject_add()
> fails, the kobject has still been initialized and must be cleaned up
> via the reference count mechanism (kobject_put), not direct kfree().
>
> Direct kfree() leaves the kobject's internal state (including the
> reference count and kset membership) uncleaned, which can cause:
>  - Memory leaks of kobject internal structures
>  - Potential use-after-free if there are pending references
>  - Inconsistent state with the rest of the error handling code
>
> This fix matches the pattern used elsewhere in the kernel and in the
> same function (err_put label) which correctly uses kobject_put().
>
> Fixes: 3485b88390b0 ("mm: thp: introduce multi-size THP sysfs interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> ---
>  mm/huge_memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
LGTM.

Acked-by: Zi Yan <ziy@nvidia.com>



--=20
Best Regards,
Yan, Zi

