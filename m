Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012013.outbound.protection.outlook.com [52.101.48.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECBD3BE16A;
	Tue,  2 Jun 2026 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393757; cv=fail; b=ekYhC/4KvlHbmmoRkbqCVnjUNa7DF21SNp5QvmTWGnEr9+PWGuBC/oXrkRdlsHZfV4MvbdorIyP+zkQ9sUEnBKLxhk+NLCC+A5hNZDrJT6P7dFeB4jsYwkLPAlyICXCOQd1OdVquicefgvbCANpD2CuUJNkqXZOZaUe8q0mVzuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393757; c=relaxed/simple;
	bh=jIsX5K52WiWu7PwF6mnGVjk+upffPXZlC/ZF0UWDCnQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QaGSYuZbchC4mZPdKPjVYXrmipBjjdg3BK1DDz5Ucc97axX3DA466wnm/qEvHk1Yi9+7A7YW6KkfdJFOsND0oLwaGtILzwHErcocXbS3uF4Y9StSaaHyInvj5/iCyIADiuhSNfzeIidz1lYsgvc02vmxUvqAQj2gUINYgbHBjMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xAdM+XdU; arc=fail smtp.client-ip=52.101.48.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xAdM+XdU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcGU9J3FyrrvthpFKkRvFojES/hAXIqg/Hy0ZaxcXCMUQeB4286gOIcrjGzYEMeceaa33kfG3V4gqLmZxNP4mq0efMFQnH/2Fago7NPbSOB9dX3tbctHyimnGiOKULBb5Db19ask/q70jYEYDVIeqPLKoI4dZyc+XOkqV4rKMVa6RRdk6P/SgN8kFqgAVy/1DOJOtO6r1qizVC+162pHoV7UMZvBp9YFvfm+5X86xY00IUY28LKLEWm8eeMoQvpc9E+P6jqPf21AxEUVrt4VpvHZ/eZSf6k10R9y0Oo7Nh4S8jeB1a9x0FTdyAcAPGlj4FRKGbAywhuFidhMkyrIIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQftiW3WpOU2vaPmiuBQts+jIDPF8bMZINfgI5e+ivk=;
 b=EPgJuXUMDIyBVMLbe7S/Uftf+BaNL5MeCGc1RgWdwNcxtdZtLEHoL+4BLAeCnyEuU3FRsi3lrvVlpiAxdMj/nA3YubxK0EGvMCaKWFkbDPyWLPZfo7bxeY2vt+zvCsFLUbk2CWNZe0Eg8fb9f+yc2g8FHU0UTNV14ZkVylA9OKb1gZ5hozdp/nZr9OxfJnpO1MzWYLfcOp03Cdw77Zj9e2NPbGx3DrwNKm+Olzoa91uHyqlx+AsMD4LEszHz542A3paV65bEj/+1UR2f6MbY8li2DxBhTjQr+Dp/VFQOQCTnEYw6CewyytpQa28SHwzmnM4en5H8t7Q7jTqE2Ee4Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQftiW3WpOU2vaPmiuBQts+jIDPF8bMZINfgI5e+ivk=;
 b=xAdM+XdUOrdUupxQTNMSa3VkF39+7xIAG6k0LymVHLDlsnsOgCOjyPNkGZE8l1l/XSAGXXnnzSEJkVHTmsmElTGljtbhZ0FEQ/lQ90qhsO0Ufc0Ujqxx8h1YtWh83OH8rvcGtmItj6cTx/zYLEwfJGetednTgT3DPqZw+lNOOhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH0PR12MB8531.namprd12.prod.outlook.com (2603:10b6:610:181::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 09:49:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Tue, 2 Jun 2026
 09:49:12 +0000
Message-ID: <bb4e417d-5669-4d06-a731-c9aa369f6bd7@amd.com>
Date: Tue, 2 Jun 2026 11:49:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu/mes11: fix queue init wptr reset
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, alexander.deucher@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, kenneth.feng@amd.com,
 kevinyang.wang@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn, stable@vger.kernel.org
References: <20260602050354.2237095-1-runyu.xiao@seu.edu.cn>
 <20260602050354.2237095-2-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260602050354.2237095-2-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0256.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::21) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH0PR12MB8531:EE_
X-MS-Office365-Filtering-Correlation-Id: 907f4963-a9a5-4a79-30c3-08dec08c332d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	2L+c/NQ6oqZm+iR7Se0MBBbxxBCVdZcbf3p1aIs1Qj4qzktkFOGRdQBmBhyq/5MCs62qXDvOKVmWebDtI2XGPm0jg1W+26D9IvWP6Ddre1x3Fd7Zo/3TmxF+mqxmnsDh05F991J3KhMH8LSPV5HCinfdKXC+zrJFrnonwmqxel8CNH9lBt+tq2TyzEDGZ7U3+4edANHF6uLUCG2oe++uw45mcG43NP1FrL6AFTo2SUiHFEoJKgkXSJRNyNVQOI149f6ZA4K11D8MVI3N15eLvCA6BfSEmjQ2ITWe4KD/ruWDFecHOdSgHRBeZS4mvD6nx9kM2s0tj0bLuyk/cGJ+pZNmG1DeExuqDIj94pWrsoDCqBFI2tz2xYwN3MXmQKldKOgutAXvf9kR3KIVz87kA6WgsKWqZkLpoIvoenZj/xH0tH9iV/3jh6rF77TP6UftNW+tizoukVndT83nr5yQ5cwcQIPY+1no0mL0g7COa0GohY2V2HLfJ4Cp3UzznrZf6Hx8uXEm0fFo1rRnncMXlmfz4oePdi6VGHCBAKGXRieK3mEp+WQea3VZ4QgoX5xGdcdpv5M5D0JeTdFipyeEB6RWXow0uKDSD7d1zWc2cxTlENICg5lEOPC1aOUzgnxgqah2BYsu6jWam3B2K6jbos/JdHgnr2mI8V2fBWV2q81ND4PHEJ/93EdeMJi1CPO2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RW5HTzJFbGVKVUdtOGJCQWQ4akhrQnRMMFhJdXR4U0VnWUVtREFRUHlRaUJJ?=
 =?utf-8?B?cVBKMUdiVW5rYkRtUzN4Y0Z0Yi9VRGhweGgyT1NzSFY2bHdkTzhyTkZGdGVE?=
 =?utf-8?B?N3hhMEhkMm1QUTdaYy9RTFdqbElRL0NFa2ZpS3B5QU15Mm9tV3kwM1hNMU1Q?=
 =?utf-8?B?S0s5MWFYSUNmaklnMkt2ZWFwSDJuRmtma29VOEpIN1VUc3VXa3JQNmY2cTZn?=
 =?utf-8?B?WFVQK3YzM1pFSWU4SFBndnhhZ1NTOWswdnkxRWdXVjF2OHhDQUFwWlN6WlQ5?=
 =?utf-8?B?TWNiVnJVcHVQT0QwVnlla3JEaFBXTC9wWjdDVkFJbnNKSmNkVU5LK3V3N216?=
 =?utf-8?B?MUVjTll6UzF1Qk9nTjNuemRDNVBTb3JSRjgzWmtFMDBFdXRuVGU3cllaNjM3?=
 =?utf-8?B?U3RXRnRmT1ZNaE9uK3lhcjNKVGNCZkFZWmZOWW9LVmNtN0xQUVdLVkZTK3Y1?=
 =?utf-8?B?UmliaFRQblYvajZTN3ppVGpzM3IvWnM3ek9yTFFkOEZVV0RtYXUreitVZTNp?=
 =?utf-8?B?Ly9FbndSbEw5SmFPNnNMMXFiR3gzNk5BRWx5SlZwVmdWMzRkZDFuNGRXMFg3?=
 =?utf-8?B?bkx5NVF6UERTM0k3bFM1Z2ZjZmk4R0l5RHkyVkdzUlBSVkdoeDBYSTFaK3ZW?=
 =?utf-8?B?UGZJSFBobzNYN3BNRmRzaU1TTjVXUnltc0wrZS9aTHJNSVp5T1Y0cy81eVRL?=
 =?utf-8?B?eXk1eThRM21aakF1N1FOQ0pBcldrTDN1N0N2SWhiSUNiYlZBbjZDQWJIV1By?=
 =?utf-8?B?cU5KNkNpU1p0YWRtMk5sWGNYcDJrY2dUaXpmaTVlZjJ1b0o5SXVpNzlya1N2?=
 =?utf-8?B?Ums5c3ZXZEp3SStnV1UrVnJnR3V6anFXQlFlOTd5NUZPWlBnR25tbkVVSWVF?=
 =?utf-8?B?ZHlYL2FEV2JtQ0tzaktPQXFLMS96UjVwNy9ZZ0o0MlFydEJ6OTB6NGJDYVh0?=
 =?utf-8?B?U1lyYmsrUGdjQ2wwbXJNUXRabDdDZXZXOVFLMm96Mit3djJxdFdTRm9OeW5u?=
 =?utf-8?B?R2FoRy9QWW4vdk43U01HZUw3V3lKdGJlZVFsKzBCQkZRTU04b3ZyMmRmbFR6?=
 =?utf-8?B?VlVBT1Y3V0o2QWtFL2x4bzFBWGFNcEtKRlBhZ1laVndMMkl4SC9DMnF0d0g1?=
 =?utf-8?B?YnZLNW5Nc2lwU29MVmMybmpFb1pZaWUzTnJNelFjMHFmV1YvQzU5NW05d0Zt?=
 =?utf-8?B?bFNDbjhJU0prS2pkdTl2aDdCakxnSGJVK0dsNkxoazVoaW9zMG0zS2FnelJn?=
 =?utf-8?B?T2RYQUVmOCtCSSs0Zk1LNXFjaVBPVTdKS2RnK2lNTHVvSXhia3hDK3hHL01K?=
 =?utf-8?B?cVFkZTdDVkNabnptZjRmeU5ZRjEvTFZNNDVnTEpzaXlJdzVvY2JDU3J0RGhU?=
 =?utf-8?B?bFFtS3RGSmtjMGNJTWxZNXBDcE9xQytkd0ppV0NCM0lBZDUrQ0w2OU5IYjUz?=
 =?utf-8?B?MDBIVlY2bGNQUXNWemY3V1ZDUHc5OGhteU1CYXdkcUtOb20yTFJ5SmVNYlhW?=
 =?utf-8?B?RDFqV05xT3VZdzhRUFpnUnIxb0hncUZpcmFQcTgrSTNnYnE3bnlvb2N3UmlD?=
 =?utf-8?B?MkVrZTZpL2hsbC9qQnBrd1BuNXhsd0NwQXhWNFdrcGFCR1Jac2szc3FUeXJs?=
 =?utf-8?B?dGhBakZybGJnbWV0djZMYU4wdjRNK1RVRDNYUUIvaXRKdzdVNjFVckU1bnY3?=
 =?utf-8?B?ekxvcTYxMGFUMEhyZHRpM1JnU09jTkU2ejhOZGUvQ1ZuY3FPMk4xUFlRcXhQ?=
 =?utf-8?B?UDBHK2VNOEhxbEdiSG9ubGFvcDZucHpEa0lBbkw5ZndzTWhtQ3lNa0RyTmpW?=
 =?utf-8?B?K0FLRWJuRllPT0k4ejZKbXdxWTZHODQraDRDS1JYWXl5MzZRUVhneWdwS0RO?=
 =?utf-8?B?VFlNQy8zRTVGWXBXVDVPOS9lQUxQc1NQdWhtVEpySm9teHpzTmVHU04zcTdq?=
 =?utf-8?B?RUliUWhGMHNOZ1A4cTIzcVVzY1FqUzF6VVVDQTlZVFFRMzBrZXZvYmRaaHEr?=
 =?utf-8?B?eGM1M05PT3lHTGlVL2lHcllSYTZlYVpTTmJuMWVKOHdkNkdZWVhZOUV0NmNS?=
 =?utf-8?B?T200TkdXdnk2NWluT09RM2FLRmZiY3RicEtNcWZYRjM0VU9vSS83bFRqSi96?=
 =?utf-8?B?bTRDSDkxdjQ5Y245dVhrYmx2eUJyakNlY29oamdhTmgyTkc5ZFArQmptTkFv?=
 =?utf-8?B?ZUZ5c05uYVV5dTFwam5ZNjhrcUNib2owOFRId0ZqYVA5SHVscmJoM1JzcUZu?=
 =?utf-8?B?aUJqRUFoWjgyTU9vMC9qUUcvVXlJN1R4NXp5MnJLcWVGcU5aL1dhVkJSQWwr?=
 =?utf-8?Q?2p08GUIeFky+6ulumi?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 907f4963-a9a5-4a79-30c3-08dec08c332d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 09:49:12.2285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K72P3tjxBFWs7NweeCNoPzJ6irhTsgzPsuPuKLDPt//bd+P0F09z0bpfqg122ZZN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8531

On 6/2/26 07:03, Runyu Xiao wrote:
> mes_v11_0_queue_init() resets ring->wptr_cpu_addr with a plain 32-bit
> store in the reset/suspend path even though the same carrier is
> accessed with atomic64_set()/atomic64_read() and support_64bit_ptrs is
> enabled.
> 
> This is not just a missing atomic annotation. The MES queue write
> pointer is a shared 64-bit carrier, and *ring->wptr_cpu_addr = 0 only
> clears the low 32 bits. A later atomic64_read() can then observe stale
> high 32 bits instead of a real zeroed reset state.
> 
> Use atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0) so the reset
> path updates the full 64-bit wptr with the same access family as the
> existing readers and writers.
> 
> Build-tested by compiling mes_v11_0.o.
> 
> No AMDGPU hardware was available for end-to-end runtime testing.

Clear NAK.

The atomic64_t cast hack is just something we did for older generations and is not something which is necessary not should be done here.

What could be possible is that we need to use amdgpu_ring_set_wptr() here to correctly distinct between queues with 32bit and 64bit wptrs.

Regards,
Christian.

> 
> Fixes: d81d75c99936 ("drm/amdgpu/gfx11: enable kiq to map mes ring")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index a926a3307..e2f762c2e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1308,7 +1308,7 @@ static int mes_v11_0_queue_init(struct amdgpu_device *adev,
> 
>         if ((pipe == AMDGPU_MES_SCHED_PIPE) &&
>             (amdgpu_in_reset(adev) || adev->in_suspend)) {
> -               *(ring->wptr_cpu_addr) = 0;
> +               atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
>                 *(ring->rptr_cpu_addr) = 0;
>                 amdgpu_ring_clear_ring(ring);
>         }
> --
> 2.34.1

