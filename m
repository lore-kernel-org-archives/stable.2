Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012065.outbound.protection.outlook.com [40.107.200.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C53C339708;
	Tue,  2 Jun 2026 11:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780399177; cv=fail; b=dO/g3tU0uCxsfP/Ofasp88QiAqt2uFmSt5/bhfvr9vKGketzi8bA2PWPNbIkhTrl13LOtWvePYQO2TjLahFjXEqMq8srudewMhwGltAK9Ha970iC7MOmoVvFJ3pNbHox2WkGk0q8BOBdKZoWi/mxoKBC6odV4OAe//dVGJddqt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780399177; c=relaxed/simple;
	bh=oUkhgoAhq7FqIYOxEbAqzevo9fDk0nsA4YpZWik1D6U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UQ77xHr+dXte3v1qLg82utCGdoi+Yiz+amTJS25XxG6p66wcf6A0wpDap1DPA+lSaUcDp7POzoBj5IwujYqcjrWQ9wD5/xQi+q3ZLlQQpjMOJ3ONekomwQc85OcPLYM0eRBP5r4pX/Czb3lWccj+4HanjgkI6Tbh1B9TRWp6frs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T0rpCcGC; arc=fail smtp.client-ip=40.107.200.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T0rpCcGC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V6SEHWFv6/ROIUKThT/dVXL+1lgkWOUHCBX3E5aev1EC/AEF707Llxt4l4mkEeWIs7hsBTPW0OFj2ikyPmbpqeKyvIKicwZPUHPSJCU8HO4UiLm7aq2Cu9ooSxq33in4/XjxHM3Ot4BR5Wi2YgLvCrWKcRoaawbwn1crhuW2pYNmMqDHnfVHqSXu++tSiSiaKLuGIkiM0Xqmfo9TlurHXQh/Sks3G4h5tXD5mQY7bqoDpj44d3VGss0AfrvNeqzfuVNuAfwy0pcWRqIPfKoPObkNLOD6cV8xTV2tzq/ryUfaSz/dgz11q40ghUnya0LJbQUhpqUC/EZ6azQwrV8TUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXG6RYaoegMiPAZauJKZCxwsP8DPmmfUs3bZnqmW6xo=;
 b=OSUHmYr4MIRXkiCWVn92UkYYoSQXPu9/BvZUbOc+blLeRPyi64/dEdZDZWX3kDHOXmQRUHbrQX8EOBW8Foqk2LtvE/bGhqvhNxtl4qM6cSjPCotph+UcDvz2W2Tu5YSKR49qLhH8FDhnwa9+sowQjeoyXd9VJ4UX7SoNynF7LZfBGmTplz6TvDmmnOzADMRste1rqrjsEqdQqMz/LOGMhkykcFYhMxYX1wpHKQEqzOwz6OS2rJ4Su1rFUN2YnME6OkFXTi5DaaUuTP1KLekljBMYl9vVAS1I05AuCdLS2OTHAZ/OaCOqOofQDoymXBTk7wErZsRF1OjTZmP1pik28g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXG6RYaoegMiPAZauJKZCxwsP8DPmmfUs3bZnqmW6xo=;
 b=T0rpCcGCEfCZqsLg0bXs7kA4o3lLVXRYbZCz35S3swRExPYgVSl2mikmoKGje5dQMbtaR9vaPIlZ9T8ZMnOLB6mwXsLPC6FJjaXF92ChdghxoEaZHG8zcEAHzvHaqUDNrOA6ShfOVFE4CJOllIMpPPKlzeZNucO2B/fQekPvgOo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH0PR12MB8550.namprd12.prod.outlook.com (2603:10b6:610:192::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Tue, 2 Jun 2026
 11:19:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Tue, 2 Jun 2026
 11:19:32 +0000
Message-ID: <6d0aba3d-2f53-453b-b5b1-39a0cf12c551@amd.com>
Date: Tue, 2 Jun 2026 13:19:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu/mes11: fix queue init wptr reset
To: =?UTF-8?B?6IKW5ram5a6H?= <220255722@seu.edu.cn>
Cc: alexander.deucher@amd.com, airlied@gmail.com, simona@ffwll.ch,
 kenneth.feng@amd.com, kevinyang.wang@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn, stable@vger.kernel.org
References: <20260602050354.2237095-1-runyu.xiao@seu.edu.cn>
 <20260602050354.2237095-2-runyu.xiao@seu.edu.cn>
 <bb4e417d-5669-4d06-a731-c9aa369f6bd7@amd.com>
 <AMgAqgBUKT9GR95Sm49u6arg.3.1780397583210.Hmail.220255722@seu.edu.cn>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <AMgAqgBUKT9GR95Sm49u6arg.3.1780397583210.Hmail.220255722@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0178.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::33) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH0PR12MB8550:EE_
X-MS-Office365-Filtering-Correlation-Id: 234f985d-9a80-43e6-7d8a-08dec098d1b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FoHVBuCKOMXBMc6OuGxKUmfJWKZOuIaXB2cvG7UAyVLyHCq4hG9nrCRYrRJbX0CdlmREIAq+PHgnkeG3Vgp7RDbjHGP//AHt2cU0Jzw4RZtQRz58JBfrcxnWb90nRnivkwlTmZ4fy7+1TC1Nl5PyOE+6yA2I0InM3bKcDKQ16M7na8lV9qW0TKQkcnH5LpTtULx9aEzJPZqgzLcRczgH26zAIAql4/p6jZELaf+wAarfBi3avEjUKk0QWC+67V/9b8llHJjK3TA0V9XPIRD73cbjk3QRGp/seS/guzoVscdXUz98so3h0SWKy/JWPbXf4stkMqSnx3yUUQMVPEZVp6uBi++WC1IGXwY6wFU4nJMeiZSvstWhOJ3WbS8ou0AASbqQWq9jy5es3PfuGxpfu0qsk4o8G6qQ6yGMFNhb9c+Cf2tykNFVK6lhD85jDFIuxN5DlxsYqhh8tFsN08Hz0RajV2D7Rd+LMHt0Kirkwk+Ymfow4jOUR3dNIKokR9C/BJRZP9In8K2U5Xc6ttCWfPt3HDwFAv0uW7xNj/5VvMZp0MFS+o0OM7inb06898yNaXRV8cYiM7ujhwLHs1A0hi59E6c5mLiEejHOrKmZrp9KL1ayPzBIZqqGO33cssMsM1yWE3805Rg9sm6LJElvEGgb5s3IUfCJAZIgtOtNK96hSUslKrpsYTFaSERuFxYH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDlCWWtzVHpxVUVicG9HcHFCZkI3MGJsTGVkNUtqWFF1aXpuU2xHTVhvdlVN?=
 =?utf-8?B?dU8xMjRIVVlDQ2ljS1BnajNDVm1HWEQwekZXR0VBSlN5M2FQSXAvZTlSZEE5?=
 =?utf-8?B?ZzJ3dy9zTERlVStKSXk2em4wMXE2MGIrdmJUNjRVQ3JjMEFUN0w1QUVoZ1Qy?=
 =?utf-8?B?Ump3ZmZrUlR0L08vaW5oeXBvVWZNYnh3SzBGSFZOcUNZUndoK2UyZmI4dnNV?=
 =?utf-8?B?QkxQRDVSL2dhUU1DTEZaTFB2U1Y1aEpNek9rRlVxUGg1VE5oaWR4cURIUEJV?=
 =?utf-8?B?cnQ3RnFnQk9LYURuQjdSMjlvOEFaNmRuMzFmektSbXVXaTJ5NmlWczJhbUdx?=
 =?utf-8?B?ZkFOaXFhY0R4eEdMdXM2YzErSGlFUFZqUVBBL3ptWk1pbFYzSlVIL3lzTnVR?=
 =?utf-8?B?aEd6TmMrd1hmamo5aTd5OWdVSFIxNVZjZE9lRzVSZE9TUnl4UWJwZ1BSZi9W?=
 =?utf-8?B?bVBWUGU3MDI2c3pxN1ZGblN0VWY5U0ZRaHRtcWZwbXBQVkgrbExUbUhNY0V0?=
 =?utf-8?B?ekFia21KMXQyeDhMQVN0a0h2VnN1bStnWi8xVGFIMkZIM0ZkOG1PbGZrUHBH?=
 =?utf-8?B?WWE2WVMwQlNTdjh2WEc3b3dXKzdST01LY2o3Z1JXRDNBQWFyUUxwTzY0Q3FD?=
 =?utf-8?B?VHNIbUNmbUhhbkZ1cmpIWE1RN3FEOFpIYW9OSzhuQjdveGFKMjBXSnVhcGJK?=
 =?utf-8?B?cXlTQUZndS95SjFxbjRRTXJyaVN2blJ2ZnJmOXF1ZkVNaGRaR1ZtUVZvazRx?=
 =?utf-8?B?a1VRWFZENmRhUUdvK1AzRHRNQ3lUYXY3RHZFcDA5QkdGS0kxSGZKZ3BqRUd1?=
 =?utf-8?B?YlVLNW9nUDJmUnNsR0NSSkVxNGdVV25jcUVlRktmYXRmNXVaZVpDNVpMOUNM?=
 =?utf-8?B?Uk5WaS9MYXpjQkRtY21paWR6YUhyZ2hrNVdxdkxQcHRYUmJuOHNDNzNKRzAw?=
 =?utf-8?B?WUY1UCs0Y21mQTJEMkdpSWdoR3Q1M0NXRjdkbTBMR3dzeG5yMms3aWlpWUNt?=
 =?utf-8?B?c0VDR0QzdHdSWGNDb1cvSmp3cTFpSDdGRFhVL1Q2R2E3RFhPdUV1UFY0cWMz?=
 =?utf-8?B?cVYxcm96RkRMRWZrWHFiU3RWcjVCMW8rMzBHMFhpekNaVnNCN2xRa0c3S1Jy?=
 =?utf-8?B?eElra0xNdUVUcU5zMS9tNG1TaUpMdHovTHN4SFVmOFFXTGMveW03ZGtzOG9w?=
 =?utf-8?B?TmE5c05vZlBOTFhGeGVRYXhDK2swOTBXdTllSUxxNEZ0TG5GQXZtcnF3NG9p?=
 =?utf-8?B?UStLUTFTM09HRkV1K2VrVVBRYVRXSEJadGg2YXQ3T2MxNWhKVElKOXUzdENE?=
 =?utf-8?B?K1VTazk3MlRJQUpOYkR4VWlWSkVRWnRkSks5Y2hLZGFzaG4zSmZibEpPT0hl?=
 =?utf-8?B?NzFJUG5wT2FCVnM4M3RQOWRlajNqdE8rQzgxd3BrYXBaaFY5UUExVENFNFhB?=
 =?utf-8?B?Z2grVW1iRzBoTVJjdlRnTHppKzNUOE04bWU4dC9KMVlFelV0ckgwRkt4UmxD?=
 =?utf-8?B?SS9XbXM5VFZxb3h4UlVnaStLZkh3cmxJRGhqK0dOU1FMN2FDSTN0TkZIRkg5?=
 =?utf-8?B?M09RaGQ2czVJUjF1ZW85Q1ltWERjZXZtdzNHd0prQ040d0ZoUkU3SitpRzRj?=
 =?utf-8?B?b2RQL0Y0b0grSGVuYzhMa2NoejVjU1pYbDJacHlhRGRCeisxNk1LTm1kQ2h3?=
 =?utf-8?B?SVl5bUpOeW1ieThxU2FIMjc2OUdTanZOb25waVVTTEg1T1pQdTFzb3pnVWoz?=
 =?utf-8?B?R0JqaTdvQTNxSjlSZmJWQ1A0QnVIcGJuM01CRWl0a016bDZJeGRqT2dDbjEz?=
 =?utf-8?B?dzRXVXhJTFdXUmh4RHgxMHZxWE9pUnRzcFJxL29sbDBUZ1FvUE0wVHh2aG9M?=
 =?utf-8?B?RTJhY0sydk9jSmhBdCtiL2t5LzdHVGFCSnY4VEVmYXFFZytDa2NBRUVsVkt6?=
 =?utf-8?B?dmdwQzJMeVkwaUVyREMyT251WFczNy9aVWN0dzU3TXVVNVdqdythUXdRMTVt?=
 =?utf-8?B?bEFhTkFpT2crR1llQ05HNlVKUEtzeS9vRWJRTmhtaWpVSUs1V1BQL0RYd0NL?=
 =?utf-8?B?NkMxR3Nyc2N0UHNFb1IvcytuWldQNTJwSlVUbjZBSmphY2p1WVI5UDhxVllx?=
 =?utf-8?B?QXppMDZETE1rVUZLVFF1U3lIWFpyaEhFeVY0MTJ3N2pSbWZPMy9MV3NEd244?=
 =?utf-8?B?Yjh2RW40Zm9Oa3hzenhvQzhvOWRpRFpCaVpSMHZVekRNazdCV0x2ZitnT2VU?=
 =?utf-8?B?MDFYR29QR3dGMnJFT0tTL3NGbDFsMVlRSDNQTjkwNWlQZ2hxRldEUmswOWxr?=
 =?utf-8?Q?loifMDJVaFc4WFjNcZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 234f985d-9a80-43e6-7d8a-08dec098d1b8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 11:19:32.4926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eYKAejecXYbGEQZXQAmtUnn+OcnfvknYEh42M3QYsfIVEQDPbz6QarLKeKHxM20e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8550

On 6/2/26 12:53, 肖润宇 wrote:
> 	
> Some people who received this message don't often get email from 220255722@seu.edu.cn. Learn why this is important <https://aka.ms/LearnAboutSenderIdentification>
> 	
> 
> Hi Christian,
> 
> Thanks, understood.
> 
> To make sure I rework this in the right direction: would you expect
> this reset path to do
> 
>   ring->wptr = 0;
>   amdgpu_ring_set_wptr(ring);
> 
> instead of writing wptr_cpu_addr directly?
> 
> I am asking because amdgpu_ring_set_wptr() also updates the doorbell,
> so I want to confirm that this is the intended sequence for the
> reset/suspend case here.

Yeah I was wondering the same thing.

I think the correct approach would be to make both rptr_cpu_addr and wptr_cpu_addr void* in the amdgpu_ring.h structure instead of u32* and then cast that to either (u64*) or (u32*) depending on the ring type.

The atomic64_t hack should really be removed.

BTW Reading the rptr is wrong on multiple instances as well and should probably be fixed in the same patch set.

Regards,
Christian.

> 
> Thanks,
> Runyu
> 
> On Tue, Jun 2, 2026 at 11:49:05AM +0200, Christian König wrote:
>> Clear NAK.
>>
>> The atomic64_t cast hack is just something we did for older
>> generations and is not something which is necessary nor should
>> be done here.
>>
>> What could be possible is that we need to use amdgpu_ring_set_wptr()
>> here to correctly distinguish between queues with 32bit and 64bit
>> wptrs.
> 

