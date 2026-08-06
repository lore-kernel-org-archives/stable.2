Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010027.outbound.protection.outlook.com [40.93.198.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C543353A6B;
	Thu,  6 Aug 2026 11:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786017255; cv=fail; b=iCafO5dd93TH79vHrotdGDwTtg2q/5fiZtcYsO1qZ7kqewGPgvdnXysy5OCw/0v9dQX31W+tTzJIOAZ9mlmgQG+O2jC2aOdBEy1i3zdNjM6h7AV2MprEgdATLvbys135iZhkdIZzGLiw4IzdN+Qw79L6Ln2yzeo4UDRb7ldTIKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786017255; c=relaxed/simple;
	bh=FyhBRlzY6Y2LcImkU51W7zSzVCAIdLRyWZXYCo9/Sn0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uAJGx+fdwbSBVUuoOI/RZvCGqHUpYVhjY5rdRIFtzQBEoJRlgM82zuLgA/iIMm6GpC8/a0d+hfayO9ayjB17SNPg3LTKIAA5rJBHqiSfyGhGzi0hOMB8or88Nd9Bgu0hEyrkGAMgo0FJSP5i5aU0bDQryV4b6DwX64eiwmtSJko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WrqVQ+Vi; arc=fail smtp.client-ip=40.93.198.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WrqVQ+Vi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQC4ZYIYCvDbACz+uSoOZUfc4wNr1y8Hlp4G5hwrdTKysERPAvJ+Yrgw/cY8okRg67fuIjFe6ZRyB+j0o7D8lTmGEVSqcclNOr6uee4YDJHXHMqzEQPmP/K+emBOS0eYPj/vch0loLQ0F8H9ocXqM27j6sWtymDBy44sZoVV2moJ3RYEkjJxMry5aq7iebA6vaeyG9Gu+1IDw30asO5ZG7JnHMkXZ9NDZukvz3MEGXsT4KVYBq40mB4fRJf90PudTS3fDht4tB2kbq9LTXvKDZ69IfF+Frru7WRzabIoMvu7w14AKso1GKEQernEVzwNyyhYt5gZd0KuZAxCLGJVjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y45Ys6nPV2j0HQ14V0u7WJ7PGhxOT/geZn5XFtLwH+0=;
 b=UQYElj3+13EKBUEGvmzQEO8re6W2rK/y5iiexs9QIGUOlq93bfdai0K/+mUSatRbN9rmWk+Pt7zML6jhYW9oZ1+iDfMJ66546mv1vpgxlxW8K2gdP9or3U/vX/huLXCMx2pTEq3SXbEwSRBmV0ZSz36OGkINw3yOMecOmHUE6wefadIQo/p383w/hhIVdpC9XdZvkc3mwwEyxGUF76GOvhS7/X+pKauEWbzzy6U8N+tL4MmA7/MG56Pelh8qApGB7ZERRyWD4t0kLp9XvXNWACJexGlAlu0W9gEGRyJP0rDdXbMN3jMbdFr+DYsupvaoMASJ/XmMQjo8/X88bFIX2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y45Ys6nPV2j0HQ14V0u7WJ7PGhxOT/geZn5XFtLwH+0=;
 b=WrqVQ+VimpRhBLbl8s0f+7bISACkf6jnNs1NNOz0F9b6SZnngftgE5KlTGMs7IFn+E6hMUVzH7ugO99NGOUUM56eCIJESUCeN9gFOk52/4XTDvDbWtpdPvOHL3GGxKMIGrPDbFrvhfss0kC1upF8tq7Zjm6e8R0/e07z4ogQgKw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6602.namprd12.prod.outlook.com (2603:10b6:208:3a2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 11:54:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0270.021; Thu, 6 Aug 2026
 11:54:09 +0000
Message-ID: <75a5fe30-4ae4-450b-8053-2a4633c5115f@amd.com>
Date: Thu, 6 Aug 2026 13:54:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: disallow multiple FENCE chunks in one
 submit
To: moonafterrain@outlook.com, Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jammy Zhou <Jammy.Zhou@amd.com>, Madhav Chauhan <madhav.chauhan@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
 stable@vger.kernel.org
References: <20260806-amdgpu-fixes-v1-0-ce247012d4da@outlook.com>
 <20260806-amdgpu-fixes-v1-1-ce247012d4da@outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260806-amdgpu-fixes-v1-1-ce247012d4da@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: b7b3ed95-f5fa-430a-6842-08def3b16ce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|6133799003|56012099006|11063799006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nWLrgde+8oLFCg08nKnqeMTj43m0DNKueWTjhSfTRclxDxZ94lqEagCnZI/O9k1mD52navU8EFnXIqCs3HD9pmRTf1kBtpPlW25JSZD6SkR9XFOvwIH718+0wbbJi0twjH5gqLqK/RVeBq3Gu/Yzzc+jWAvI6s0G78OSfNdcW4lOvZDCrQkL52bC4lbn3qlsDwcbJ/vRxykDrt1psxshThGsz2GepWX6Y3BNRtO2iwP7gjk5c9MFOCeREYTWLVM2NH9DxfB3WfxXPGUdEqnVOC74mD2K2NytLvlzUWzPo9d1u1+SQ/CvK4ZWCZGYm7XFcdMM6UOr9OulpniHkpZ6gH9QAV/ndX0GgYrW/KtL32tQpwDBAiF6MgXw4wx5bBfu7eXJ7shcMIXPJ1elr6gCBTIVJbttcLAoB/3nS43nCK4PAmWfSTLY59/xC/TT1LhSHIGLd/8u96U3ihCGxi7CCOEYv3z2Xgmu7sjNAKWqoFdkA+O2aul4WEWfUXgXRWDXBu9/97g+5Xd0sjHVNDe0tORkLQkBBP1MjLVN1NGCCtgGvxxFrfZMIae7fD1O+aXhE3xYRg15sWY6mNQW78FEqDblYigiQxbkQ0iPmO78cdCovPkl5L74O3a/SfDG/3sNLhdQuwlptLSRSJRF0IardHIqSFtEfJD9By5k51dG1qk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(6133799003)(56012099006)(11063799006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RGlqc3p4OVhacWhFNGdtSDZ3UERNRHFWZy9JZkE4Y2dGMWJkS2V5aWtnOGJt?=
 =?utf-8?B?aW4rRlJBYkIzc0NBanB6ZldtZTJ0VnhRc1ZJYjJKOUt0WVlEbC84YnIzUmpQ?=
 =?utf-8?B?YmRKeTFweHhiU09Ccmtyak9VU0l4QUhpbnhiZ0pab2NLeTVKbWxWZ0dZMEtN?=
 =?utf-8?B?MkZseGFaQThoUGNxd3B0U0xCanNBbndpL1hleGlOelo2Z3N3UUQ0cm9LUkkz?=
 =?utf-8?B?bmtoUGdOKzg1SzFhVzZoVW01VHRuRGhrY25jWUxQVm1wNVMrMDBCdkZvVy8r?=
 =?utf-8?B?YkgwdnFtZnc4QTI2ZnR1NUtEbEFYZUVCVXkvNGJsb3pvUHROMzlGbHVVdmJ3?=
 =?utf-8?B?bW1OdzZkSENidFlPdVRoN25LMlVsM1Q5N2wvSm1KMW5qUVhIWUpYVktDTWRm?=
 =?utf-8?B?VW9nbXU1ODZLSVhwZ054Vld2c0kxS05RSWFVZzBVOTltSit0aUZSVDlBTlRI?=
 =?utf-8?B?Q1JhcTc3eUZ1bEdkM2FwNWsrU1A2ODBUdkZYZlo4WENPRXNHbGtMVk84OXRj?=
 =?utf-8?B?RzNVSmVmMnA0OWN0bGZlUEwxcTJ0QjhOb2NlVUVtQWlpeFB6UEJUK2ZCUXhQ?=
 =?utf-8?B?VDltZU5jZXJSSXpLb0xyV1pneUwwRTg0dHNRSWgyK2ZWNm5DZmRqUXlwaTVH?=
 =?utf-8?B?VllIc2JLTUVxWHVXMzVCdTREQU5FenNVcFNvNkMvYXlxQU1ZRXJ4S2Ezb2Vz?=
 =?utf-8?B?eVRWTWFRTnpmZm02SlBvZEk3aFduM05ETURzVGJZbG9TRXhNcGNVeldsN0ND?=
 =?utf-8?B?ZkprYmZJbFFSQTlrVVJPYWRydytKQW1zTHdHUGJlZ0ZBOXkxdVJUU25tL2lN?=
 =?utf-8?B?d2Jsa2EzSmp6emZha1JKU1RWdkpFcGh2eW1jUWJVanhRRjBQNm50dmgvUG5y?=
 =?utf-8?B?RXdlMlFyUjFzZ0wyUFFnSllWRk1rbTY3aGp5UXA2OElpV1c1ZDBwQVNGekJL?=
 =?utf-8?B?ME9hV2lBbi8xcGR2YXVzUEF6YWorMnJINmFMRXBva1pBaVNTVVY4MVpaaU82?=
 =?utf-8?B?U3paQ2pXMVU5SFA5Tzl2RDhiT0FORmxhVEQxUnNmSmRNNnJqWmNOOEZ6dHdD?=
 =?utf-8?B?d0pvRU5jL3lTMmxsTVoreUJkeGRxU2Q4VVMwTDZmc0tjK1hBNFZ5cDVwdkVs?=
 =?utf-8?B?bERXRVRNZlNveHllNnJUMVFpV2Q1K3I4d0F6bEtldzZjZFY5UlpWVFY5Y3hz?=
 =?utf-8?B?SVFnYnZ0T0FNL3JabGNOamVST2RLMzA4Z21sc2E3NENTUmlONHBac2h5MTdz?=
 =?utf-8?B?c3dkQ3Jkb0lZdjMvV05nQnlDSUVYSTd3SkVvYkQveGVMUVJBcWlTOVl1V2Vw?=
 =?utf-8?B?RVErMDJkR09hK1dHQUI0cHkveEhlbzcycVU5QUludW5zNWVaVFR2blNNWUhq?=
 =?utf-8?B?dXNSVDRCUFBFUG9wajJMN0J4TTJ6YkNxZ0xTZW03bUZxdnhHMlZCMXpZSEVJ?=
 =?utf-8?B?OUhaKzdnc0ZaMnY2M3pWU25JYkJqS1lHMlA4dVQrOWpxRGhVeTR2S1QwZFBI?=
 =?utf-8?B?K2NxSmZSSE11RjFUcXZZb0UzcEJDaDYvUDBlNWc5eXgwRzYvU2Jnd2ZRaXpx?=
 =?utf-8?B?YzZLaGFjVEtnMzE1Nk15NThMd1dlZmRpMmpQZnlFNlZwcWtVT0ptTmREUXNF?=
 =?utf-8?B?SmlkVjVrUTVDSmNJbFpqUlFqME05b0p0Um1vN2lRSTZCaFhCU3pEUjkzeSsw?=
 =?utf-8?B?NklBWCthOWZDUjNZZ0hFSXlsaUpnV0tSMGpRWTJFTzZyVGJEcXQyRXpiZHNM?=
 =?utf-8?B?bW9OUWNUVWxBQUtNWGJYZkdFWVEzYlJaQVR4LzNtQUtTdkpYMXZNTWdrZ0c4?=
 =?utf-8?B?S2JaZDhkcUYzZVg5WWdsd0lOOFdKcG9iNUMvd3BXYXI2ZTJTTjUxUWdpd3Vo?=
 =?utf-8?B?K3ZiZW9DMWEzUGt0ZnVtSWVjalo0N0E1SHdDaEtudThuZUxJVGFHdklxeFFQ?=
 =?utf-8?B?OEtxZGF5Z3JVWjV5OERnSFZaVmxPaG9ZQVhMSWtaK3RNK0lybTNuQzFncFky?=
 =?utf-8?B?UDFNcGFuN1BEOGdtVmc4S0pCaHJRKzd0QkQrR2MzZDR5bGcrWThUOEVVQWJR?=
 =?utf-8?B?RVR5QXk5WUpGajJNRStKdFIrNHlsWnVmamlaQVlLa1UwMWRzanBFL1J5OTBy?=
 =?utf-8?B?cW9TTmN1bWNyekFwTjZJS1RZVTJTOXpqOHVBV3VOZXlQdnMySG16ckdpdEpi?=
 =?utf-8?B?b250cDJuT1ZIVWdsbXB3VVlRV0RsY0k3MFBuWHNHR2hBQWtRQW1PVzdSVGl5?=
 =?utf-8?B?ZlZTVUNHb015RTdvelM2TlprNEhqZ08xYU9MNUl2NHVDT3cvM21yai8yYUVM?=
 =?utf-8?Q?YBkvl2r1DYqdvWmbna?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b3ed95-f5fa-430a-6842-08def3b16ce9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 11:54:09.8332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8hH7u0NfIuRIU28QmTV8lFcgoZ5W7mc0A7FT8qyQhh2FmfjBIXhMQtwYziUYRJMh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6602

On 8/6/26 06:45, Junrui Luo via B4 Relay wrote:
> amdgpu_cs_pass1() dispatches on chunk_id once per chunk without
> rejecting repeated ids. p->uf_bo is a single-slot field, so a
> submission carrying two AMDGPU_CHUNK_ID_FENCE chunks runs
> amdgpu_cs_p1_user_fence() twice, and the second run overwrites
> p->uf_bo with a freshly referenced BO without dropping the reference
> taken by the first.
> 
> amdgpu_cs_parser_fini() only unrefs the final p->uf_bo, so every FENCE
> chunk but the last leaks a BO reference. The leaked BO outlives handle
> close and process exit.
> 
> Reject duplicate FENCE chunks the same way commit fec5f8e8c6bc
> ("drm/amdgpu: disallow multiple BO_HANDLES chunks in one submit") did
> for p->bo_list.
> 
> Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

Thanks,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index 5445f75741b5..9c514cb01096 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -228,6 +228,10 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
>                         if (size < sizeof(struct drm_amdgpu_cs_chunk_fence))
>                                 goto free_partial_kdata;
> 
> +                       /* Only a single user fence is allowed to simplify handling. */
> +                       if (p->uf_bo)
> +                               goto free_partial_kdata;
> +
>                         ret = amdgpu_cs_p1_user_fence(p, p->chunks[i].kdata,
>                                                       &uf_offset);
>                         if (ret)
> 
> --
> 2.51.2
> 
> 

