Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012005.outbound.protection.outlook.com [40.107.209.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDB83909AB;
	Wed,  2 Sep 2026 07:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788335777; cv=fail; b=VMegyvs9oobEVrZVNZAfbCmMsGKHfc5Csw2454fE0kBTpQqWxk+Pfhw9nfSs0RJrU1+3n8IzGk+WL/Ie4fRGgKxRP63pTqNjhxUZpbJkGm7gUskI12odKFz2EH5ihseo98wDTQdgbk1s4wYmJ6FEYrhSOHFgLnXSjKzmIPYPJzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788335777; c=relaxed/simple;
	bh=a+DIFGInLS/T650rp6Lmdwqfb2HML4m4uWnfDderQSs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Iao7UCr9nfnim8Lae/89zi54fZKkGHMiytvW+wXSUqzNGQHSfkxr9T5T5R2IMivKJjf/6HLNyrnaup7CmfANhjyfG7Tbeh6z9VLAATQBv/tXZw8xttmhP3PB0CvIN2CbsMaX3GP93C+OmaVGEVkEDCaGVw5c3/rOel/1JhOK8TA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ex3eeh4I; arc=fail smtp.client-ip=40.107.209.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ex3eeh4I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7WjG/a0IeaH8/NqrLxdlTrutXIkHQ27iCXyNAJP+ymP1tSuunMYdBIsd1ue+Oe2yk+4kjt/+vp7UVTgJjXhXoj9HC44gJ3wNXwPl8o+drMs+1Wzeprum8euWCCoEhvTDknOmWHTIRV011Z1Qq1VfzAOnnYNJDPETKtT6W7CDLAeGPMfeXp+TTVN+2OCVA6mR00TTNtHUXwGe2D/qHhQYSKztDjiMbAymFeDwgheSoRA7tkghNwX9ODqqYDOgaB648MPZ5txuuK25AtGlKB5nZQqr9FyvvOYyNca+HNPvOPLvAdWeqhofY7h0piZLCrQKwotScTOUvWeuDSBO3Nxjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psCUADqtW9u7HV0GyI6Kb3uS5JpkFGgefbruKrwnB58=;
 b=slDBIk5SJR9CZTaAr0ROTHB3ub/dqFiGaZDxn86UJnP6YST0wkY/E/Ykmvvb9k/cbmlkRhoqaIm7zeyax2cZ0l3Zxf7OOXIuJ0VD/c+lrcUNZbDOO/Lm+QWpVQtx/KLHx54DguiL2FHdZ98R6jPF+nnjDaw+rpeu4L1GiSCZWvUZ/ZpXjdwtppSuD+bBwAi9tw/wb6UXjMkTWu3a3mrx7ycyMLkYl43NqHi664RMDMuVQXW3oplnmx5NFzdG6Kmg9ohY1wj/eY/LW9AQrGK/gndS2Va0zYQASMJhD2YuNYSEwRONtl4U+pLLFOnk5MLQ6duVCntExSIkgrOrinYbdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psCUADqtW9u7HV0GyI6Kb3uS5JpkFGgefbruKrwnB58=;
 b=ex3eeh4IMBkRqUx6HWlBExyQ8d2gpHBGEq9dxQHTx16/pZsmXxK4rUT7qt4VCidjqVLTfzp1VqWGizPOU7lU3ZI033VHQ251iDDOBHeGjSJv6l5KvqQbUu75AD8LiaorbKavWhQccB0Wnl9LNaC3C5taI4DkqOw/9XbAelxAuGE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY3PR12MB9704.namprd12.prod.outlook.com (2603:10b6:930:102::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 07:56:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Wed, 2 Sep 2026
 07:56:13 +0000
Message-ID: <aed39f83-6340-4fe9-890c-6d5f340c97d6@amd.com>
Date: Wed, 2 Sep 2026 09:56:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/2] dma-buf: Fix silent overflow and alignment
To: Leon Romanovsky <leon@kernel.org>
Cc: David Hu <dhu@x6u.co>, sumit.semwal@linaro.org, alex@shazbot.org,
 ankita@nvidia.com, chriscli@google.com, david.laight.linux@gmail.com,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, jgg@ziepe.ca,
 jmoroni@google.com, kevin.tian@intel.com, kpberry@google.com,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, nicolinc@nvidia.com, praan@google.com,
 sashiko-bot@kernel.org, stable@vger.kernel.org, viursachi@google.com,
 xuehaohu@google.com
References: <20260901170849.4052816-1-dhu@x6u.co>
 <2bf581db-7cc5-4f38-a075-1b988c332f3c@amd.com>
 <20260902073936.GR24140@unreal>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260902073936.GR24140@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:208:256::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY3PR12MB9704:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eda70d5-f63d-4031-9896-08df08c7a8ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|10067099003|11063799006|22082099003|56012099006|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info:
	YRZoxo0wJudvHPqleQhpqNRShAWIUJIiEoFnIJQXWg7VH9+FkbLgXK9PTcFpJtsWZZWeUlURWvfFAUTPMX8ayCoujypwLJTi+p8dSHFfbzwYInFIHd1axICi/CeIx4dZGF9KIUjNvmSOlRqxh62ui1eDkymKQEE4o/x5ZNGDWdK/7sIv4XPG7qdH0syCElmCkvEw/Lhw0I/3mDW6WyggTYtJsBdI9uPawKHOd1nmwFNS7HFQSt3KeZ75y+PL6BYZANlVeXh2G9L8sJrYF8h98zr6BNHOb+lndqu9fD8kke8R00rrhLunGU+PXsPoLLRS5n4hIUc7tn+vQBXHqivzmOEMjQQhDU7f6Qg+hk+GxDxp7nwApLc8Oe+Yr/ysIn6yPc92EZrfu3FjJTix++jpQHxj20pwHRY+S35VN5Qc4qinrUs+4zs3As2Afnr5/HWd/7CqOwvP8GLgVLopRdC+aCpTTgRhyRbBm4NtTeOXZeSktNn3pEjlcad0oBrW3Z9GwmFopt2dglsooZtmWMY2zCxelvgLPgV6Zs1KYRn3rozaS/2TsluSfJjZT33Gn2WQ21jXp1wKAWLKJGAEH6bHYmkRARxhwNhd1TID//IDBJQK68HVHyYY8fPbV5nHH3H8VClhUAIcnFdD8ADzxjdNv/mfR8wI6zdHDN1b1YmFQCY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(10067099003)(11063799006)(22082099003)(56012099006)(4143699003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OCtyWDlnUWcvQ3lOWTNJNzFrU2hqRGw0OXZHcS9KYWF5bE9Ya2FDeDY5STF1?=
 =?utf-8?B?VVVPWStxNTcwR0Q1WlZJWmh1Y1IwUmEzR0loWFNpeXkxQTNWNGtZaVdhemdK?=
 =?utf-8?B?MkVESmRDaCt6R3NZaVFZY0FmcEk1KzBXeXZRSERwOE1vd2YyakpuZ3NJZklN?=
 =?utf-8?B?U0dlckw1M2ZnYnpON2FEYTNZbmFncm4zS1NFSHFuaXNPVnZYTnFrYlV2L0FY?=
 =?utf-8?B?T1Y5dlNYbUFQOWhBcHE0b2xqdENGR3V5dE8vTDVGaGVwTFpqSUlFT1U5Vk5z?=
 =?utf-8?B?ai9VdXZueUhJSUYrT241UWhEZnRWOTFyK1VSUWhnM3JLZDZLRjhhK3Y2eUh0?=
 =?utf-8?B?d3lqamd4Mk9mRVpCZUxkRjFrNUNMaCtvWU9ZMWRGVDNBVW1rQndTRHN6NTRm?=
 =?utf-8?B?NkphNGxscFBoem9iR0dESVhpbk93WGY4aXJGOXM5SGN6V3RmNUlyNFNCK1JG?=
 =?utf-8?B?QjRhWXFZSXpIQWVmc0NaNTJjWWFxTzZuM3pxS1RTNFBqc3lBakRVUzNYSFYr?=
 =?utf-8?B?QnNDZnZJYkxHWmFlSG8zdFJrUHgyeTB1TU1pM1FnekpyWjF3REpFeCsydkNZ?=
 =?utf-8?B?QkY1OERpQWdyaUxxMlVzU3hGdUxtcHdqQlh3RUE0Sm5rUUxIN0dEbzJrbkJM?=
 =?utf-8?B?TWxva05LS1BrditKaFIwZUNlRTR4aGhLTVJGN3NBdldsb2NIYWlQSmRiSzRs?=
 =?utf-8?B?YTI3WDh5UmxNb3Z4MkN2QUZFOXhaWE5lOWlqZ3VRZld4bWdqcE9tWmlDV081?=
 =?utf-8?B?cHZXSnlEbVcwa3pIbnJzV2laVVhGT0pLY0xzRk5qVXlCYUNPSHYwYkoza0Fh?=
 =?utf-8?B?LzZzOHVNMmpxTEFEMS8xVWVkUW54MjZ6RzQ4ZEFvUlJzT1ArQXlIWjd4R2Fj?=
 =?utf-8?B?MzE2Z1VXSTlPVmkwbXE0MXJWODFsQU5jM3AyUkZSZWthWUtLSkRPaHkzdVUx?=
 =?utf-8?B?MGpHemROR2w1dzBVWDJUR2tMcFpidFVibnlnN21BUzBiVTdhWGhrbDRwYmx0?=
 =?utf-8?B?eWFadlZTTlNpTHlBRndLMC9RTmtDQTR5and5K2JaeVQvQnBySFJPZ0dLY1Fr?=
 =?utf-8?B?NHN6VjY5WHJvcm0rYlhJK3hnLzZraTh2L0FXc29jaHhxRVJSdjlUU0FLNmUr?=
 =?utf-8?B?ZkMxZjArRlJQWmZVUTZHWHByOFBxZzREUzY2L1dPZVJMWjNuTkUyNDNlb1pI?=
 =?utf-8?B?L3hWS3hodFlVejF3SzlkckwwanNoT05tbUR0RDFkdkorOFpKUDhxc0dwV3hh?=
 =?utf-8?B?ZllVYjhjSFh1RXZWLzY4SGYralpuTzZBWTU5SkVkTlF4bzBLQ2t6NlhzcjZG?=
 =?utf-8?B?aW45N1dqdUxCVFFhdnorVUdkSmRBWkt4dU5jMzlwb3BPTXppY1o1V1NQWldE?=
 =?utf-8?B?YzV3bVlHMWhWTm4zRlRaRWtSOHgzemdJakFUbXRpb3paUWlnWUJ4YVhJZUE4?=
 =?utf-8?B?dXEzekJ2N3FmYmE2b21BckVxcEN6Zk0rUExyOTNtUGpoTWhhaGdFVlZ6TjVv?=
 =?utf-8?B?SEFzaEhqczRNOTY5WDdMS2tlb1pJeE5VZ1orSEp1R0RFWGFoT0hVV0ZQRDAx?=
 =?utf-8?B?WG1oclRFYkFZNEV0Z09ld0lWVm05T0t3Rlppek91ODFRV0NJajR0MzM4MTVV?=
 =?utf-8?B?eWhyZzhzY0xXYWdHOHBzY0w1TnRPalRmMnBDTXNDKzY2R2lYM0dRYlRPT3RU?=
 =?utf-8?B?Y0xvSHJ4L1Rud2dHVWF6YWlERGxoMU5VUjFPSUQ1VllpRWdzQkxIdGtxeXNY?=
 =?utf-8?B?NVJNSGMwS09kajVDcWFWSWU5eXlwMlJldDI3cUFydFdGcTlVU2w2cW1lTDdx?=
 =?utf-8?B?NGpPQ3FQdWRORWNwcUVBVHRYRmZ6d093NVcyazI5SUROK1ExNnlLQWpFczZO?=
 =?utf-8?B?QW56bHgyR2FXN3BqK0VJN0tRVC9vblJkWGhNTWlHaEtRMkdJV2FMcW40Zksy?=
 =?utf-8?B?RThXaVhuK2JDVGRtaDZkcXV3UGl0UXNYTWkrM29TQlBGcmRSQnU2aktmQTdO?=
 =?utf-8?B?SnIzcFNNR1ZQQTdobzFtaHhEeDRCT2Fxc1hJb3JnM29veW9Ma01HdWpZS3l3?=
 =?utf-8?B?S2ZQYWZ5VW9YZUQ2MS94ekRJQk14S2hCajBVYWlXKyt0dmJnVDdrdm9hYmRX?=
 =?utf-8?B?SEVQRWRhK0FRbHlxbTY5bHcxQSt5NnAzT2oxSWlUUWNma0p1OFdIS0YvZDRY?=
 =?utf-8?B?eWV0NUVZVXdQT1M5NnhMcXdKRGtVcHFsL1hPQzVOS3N4dXdxd0pseE9sSngw?=
 =?utf-8?B?aWprUW9OQUI3dDFMZ1NVRDNhQmpDRmxZUEkzOEtQMXlZT0dBMVY1Y21tUGgx?=
 =?utf-8?Q?bKRwqag5/t5KGDCYaK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eda70d5-f63d-4031-9896-08df08c7a8ac
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 07:56:13.2346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3hOtKCk898+MwjQWqFT5oLAUoAtjsLfXLFWm+QsVmUK0np05q8mmuUxdOq4bdLT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9704

On 9/2/26 09:39, Leon Romanovsky wrote:
> On Wed, Sep 02, 2026 at 09:00:46AM +0200, Christian König wrote:
>> On 9/1/26 19:08, David Hu wrote:
>>> From: David Hu <xuehaohu@google.com>
>>>
>>> This series address two related issues in scatter-gather mapping,
>>> specifically for the MMIO based dma-buf mapping. The fixes ensure
>>> sgt mapping is correct, and proper for large MMIO regions.
>>>
>>> Patch 1 fixes a silent integer overflow for mapping length exceeding 4G
>>> (Previously submitted as [PATCH v7] dma-buf: Fix silent overflow for
>>> phys vec to sgt)
>>> https://lore.kernel.org/all/20260609164047.486227-1-xuehaohu@google.com/
>>>
>>> Patch 2 Splits sgl by largest page aligned chunk
>>> (Previously submitted as [PATCH v3] dma-buf: Split sgl by largest page-aligned chunk)
>>> https://lore.kernel.org/all/20260722233806.3922093-1-dhu@x6u.co/
>>
>> *sigh* such issues are exactly the reason why I didn't wanted the dma-mapping stuff inside DMA-buf. That clearly doesn't belong here.
> 
> And this is why so many in the kernel community want to get rid of SG
> lists. It would be great if DMA-BUF could also eliminate the need to
> convert to an SGL, like Jason proposed.
> 
> The DMA layer no longer needs SGL. These bugs belong to the DMA-BUF layer,
> which is the one that depends on it.

I'm all fine using an array/xarray of dma_addr_t in DMA-buf, just phys_vec is a clear no-go.

Regards,
Christian.

> 
> Thanks

