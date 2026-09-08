Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010058.outbound.protection.outlook.com [52.101.85.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6E7545D82
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788875779; cv=fail; b=eO2GkU2pZuilzHyy66NwJ+Thzibo12rcXN3hxdRwByX1z2PX71POeZikrx3JO39WUE/hf9ZLcHwS57WNBV97UgLbsz0Nq7hu21uCzq15rXUwdNNEPpda7x+dYCiKkuNOLLbd63+U512NG/4G+0Mg8UkWDASNvUv6RuSCMbDtfK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788875779; c=relaxed/simple;
	bh=njJ1UWo6TGb5+oCQb7Y8AgsyuiOwnKmrlh0GX6hljQk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u5GQQEkPxSjHhSLU8wIOQOe3ZWGXggNLBQyBWz9sRoo2Z/y7GQAQwSE8bLz2NyNgM4BQ/NVJ4zB7DcMu6+5cKUqqFW9/TC2lxF9rVuu3TfSA1HCNvfetR/MyRizLvGZq16MIZWkE48iXsoxXVPntCRWWxOdCipRFnddZyvdXpD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sq2gmfvH; arc=fail smtp.client-ip=52.101.85.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sq2gmfvH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PtcLZLaNvkyo44G5Pgau+5a+KyvARKILpRl3uZ3zfPnA7Ks9aQ9YwRXkrE8u2XhVs2ARDHIF73aACJ3s5vy9/NlrPUQrod5X5ctVqkkm96nIbV7OmNLTzWTaqxs3IumDJlFMC4z/3CqsiLKkrUMj6BsE5iNswpSdCdXMl6op0raEj6jEzs/4OYJqXCtSg2xxxGY2419wS0IN1GvvDr6YDE1RO7tp5Rkvho549sNHgFSjwIGPI6u1ymMyyyMwIdUTKg7NUfF80bJ1mxTpZpxer8snCzoocoyXCnzbbd4xUQQuvR6W2j9j49NGY3idEOLitXrhAo4dMt615TGM08wZYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRWEwPBmh0Ai7TS+Sm9kO8OhneCiUc8vRShGm/o1yLo=;
 b=Th8P4e6Z2m0adCIbIPMQqGaui++2gQXQQ5IRcjOBEW4fBZ5gqbLmuSnyPeEwb3zluDn9SxDe1CxGgTDpdnwo4Qp+qg/gCdvxZNEKt9U3Et3UyEADn8KHrm/VxEA2emamxj6maYhbQeidTAljngD2BtfooQNpUwArJhJURHFuAuLXd0GmFtKzabulpV35PXLR/i0NMAai+lIo+lMgYDpxUklccnYgGEe222t1aHMmFdEFJeiNvszgMHTbIcl5qTaPnCW/k6KcNDZs7+oTy0zCno5BXzuGw84ZqrY7fZYxhQik4NjP0NuYfk1wtTs60VJeAZPcODGSYupdxKhd2Y6iOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRWEwPBmh0Ai7TS+Sm9kO8OhneCiUc8vRShGm/o1yLo=;
 b=Sq2gmfvH3WGnBopnTbdV0mLTn+vt1iUfyKgfTS+hZy2R7MDBzFyzwQhwowL938atyAuiHQ46pp/icMypQGzCSwKwZUfAXBkebRSMvLk6txoTj3Oc3L1kGOHbJPwV6JdoKbkJBfFHXaRp3mIIVTJGsdAXwglQtr7UypqpMcIwFbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL1PR12MB5924.namprd12.prod.outlook.com (2603:10b6:208:39b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 13:56:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Tue, 8 Sep 2026
 13:56:05 +0000
Message-ID: <1081fa83-d2f7-40be-816d-29f28c6e7576@amd.com>
Date: Tue, 8 Sep 2026 15:56:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/drm_exec: fix contention when num_objects is 0
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: dri-devel@lists.freedesktop.org, stable@vger.kernel.org
References: <20260908091729.2749399-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260908091729.2749399-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL1PR12MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b444c36-6852-4cfa-bae6-08df0db0eccc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	8OTxwZFl7KDPL/s/ABzBN7VmcjxibRgKHmC2sBWACDW+NouDpTtl3UY0oizQiw6MHrlzYVMI3zhYUXDeQNStnSjng+MDiCA3M4kGxTUQXuIKTOyJ+2nuacAKxK+pWfaQ3HAGWXWpK78+U1BQdheZwQVRCiqWGKGsqhk2iIWyiS0fnZuUJQJceGO7ARtIZ+/q5KcXkErtASyRApiepRqe+Oa3LX8fuVKHjYbgoOxaFiDWnf75Vymzezlmo86FBuIXGai6FLHiBDwAuANgYij+Pw4yDg8aHIDW89Jbin0m69F1/+JzduEaF6Dzsa2H22k9BG3O1EEPTJ5kG/3dTSOxyNwAoPgpbEuuBg1wgTzcbbqSxeVH4sSetWP6w8wyUckN8+HFTeg+Ni1eSFexqui+TmQlvxDR4OXWenrjQZj6FfLsTCItggj5kRH4ZmO7bUQ5mtD2X4IX++QiutTsqy0Zbx3KOFPWVHSj+nbgWSV3UK637LFvMGjBq8OrkmE7zxBSIXH3k/aq81q+alwSYM03ceoDBOeqVYrSSfWtjppEoi5FuuK6ugmfK4axNEV4YJyti9zMGaln1MfaRki5pMSw0HCJrjwwCdamg7GV5gF2RVRjscaN9A0diy8hNpvcq0j8Oy6oLHBuY5pdgBoWHSqk6roF0TRhuK36lThHsPylwbk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TW9TWHBQT0krSnErWjMzUityQ012ZU13cjlMNUpXM3BCVWtpQjZYS2V5dnpX?=
 =?utf-8?B?QmxBSitMUUhqdVpzWVhqR3J5S3k5Q2swWUlRNFQ4NkZ6RFVtWHVCSFFGUXo0?=
 =?utf-8?B?ZDRsemxaQlhNZU9zOHd5dTRJbjJKdDF2WHNyQ25TS0JPVWJOOENTSGV2QjFY?=
 =?utf-8?B?T3NFOFc0QkJ3bUlyMm1JekxzSC8rRG1qMlZUU3BTYkIvdU5LY1poMHlGUDZs?=
 =?utf-8?B?WXVvTTdMallRZTNDbGNTQnY1TVpzc1RPMGEyd2VRU25xdjNQVXVzQlBEWWps?=
 =?utf-8?B?cVUxTjFCSTJldFJ0L05tUEdOVjh6anRJY2RoOGVReldIZEFUUUNqMTZJRWNJ?=
 =?utf-8?B?NnFTTDR1QWkyRk1zNEM5bVJBc0RqWUUvVHZyQkxwK2Qrdy9JTWRwS0dxWnY1?=
 =?utf-8?B?K0l6YXo2a2NOUUszeFBoWkZZZmRzUmdoM3h4VDY0M2J5aFRabVBrRHRlSW9K?=
 =?utf-8?B?dVByRHRlUVFsTzUvbFR5eUVFU09yNHJFSW5Qa2JUN0VkK1ROVVV1Sm96Q2l4?=
 =?utf-8?B?RHpTeldLODZDNTlNdnRydkh5UEh1WnA4eFIvVE04aEZwRkdMUklTSC81TXB6?=
 =?utf-8?B?NnlUYlROSWdROUx0RlJXYkhCZGxQK2QwSmJnRENWeDh4NlFCaE16emhRdWla?=
 =?utf-8?B?WW1URzNGL1ZSMUdKTTlSeUlXSWtrdHhPYnlKZ0xSMXZSTSs2NmRhTEtLYWZq?=
 =?utf-8?B?dDByTDVyU3hZOVJxOWRCQVplekZMak9JNVFxQ2FkTjdvelR1bSswOFRHVXdu?=
 =?utf-8?B?d08zSTBtaGpjekMxRXJZMFZYeUk1Qld5Sno2dzB5MHM4NSt4dmFFeEtyRXJj?=
 =?utf-8?B?SUJLc3NjMkUxZTRuZzQzNXcrWU5uZGRGYXlYbWtTdVROZ0xjWmJ6Y2FzUkgr?=
 =?utf-8?B?SVM2Z0owZDNvV3JIR0g0eW5uS1FXTVRKeVk2ancyWkszRmxnZGNFUk8yUGgv?=
 =?utf-8?B?N0Rxb0twczRwcmdsK1pjUi8xZ1lzUFFQa3pXdE8zQUtoUjJoSmNwOEY4enlN?=
 =?utf-8?B?emhGeks1amhGbUI4NzNXM1RHUXJpMENveCswY2hTaENMS3hlVkxaa21rd0Zi?=
 =?utf-8?B?dlNnTnFlbzRveTlZdm5Da1lnemQrVEN5QWFVWTk1alloV2toR2taWjV0Z2c0?=
 =?utf-8?B?T1UzanB1OW5uYUFRcDZoSmMreWFJOThCOCtRU0NaSmFqMHJhVnUxQ2xhU3R1?=
 =?utf-8?B?T2d0dVU3WU0xNnNOYzlzcVhNWWFPQUswMjZxcTBzTGdlSjBUTGxoUHp1djFK?=
 =?utf-8?B?TTBEd2xkY0VJZEZWbWUvQ0RWK1h4QWREVDE0Smx1YmN4SURFQW9mamZqd1lC?=
 =?utf-8?B?M1A3R2xaN0RhVUI1WCtHM2NRSWIwUVcvT3RJeER5eksrM01tRVdCQ2lQa3RE?=
 =?utf-8?B?RVJZaTlkcmtqd2FTUkkxaEpPMk1pR0d6aHVVWTJXc1NFUmFPbVJsL0R1Uk5O?=
 =?utf-8?B?SjJ0R3laLzRyY2dFWVRBZ1UvbzBaYTd2YllYZ2xvS2VtbFhQdFhITVRwNG9H?=
 =?utf-8?B?UERibFJEZlBlNWZRd3lzc3pUUFBTem12c3M0c09pTWEvQnN0ckxRL3IvYzdj?=
 =?utf-8?B?cTN4V0tMTUJUU0wxTFBqL1ZxKzdTRGtXWjNoQXhBdEdjWjVCenMvSi9nUFRl?=
 =?utf-8?B?c256ZjhsaHZ1bjJlemlhWDNJM0IyUVVyYUVwYWhkSmtPOFYzTllXMjFpaXBB?=
 =?utf-8?B?aFRLN1Y1SFVOMHN6ajVMWTFEbExoMU44QVFTOTJZY2tzZklYZjVvbnR2WEdG?=
 =?utf-8?B?c3lRb2tsSU1iOTdaempmQ0hvaEVZWStHNzdHVWg0QmJxQVJQVDdYU0QwTk9q?=
 =?utf-8?B?NkFZUkZGRVBYQmozVzB5dS9jSFc0NWdZVllwT1dSTVZuN1JOYTdmbmJqbmtR?=
 =?utf-8?B?MC9ETndwbk9SeUZEdlo3UkRHdVY5VWhqY1V4QkhqTktwY1BabVR4dmhPK2RD?=
 =?utf-8?B?c2xGUnF4T0pFd0xkdFBMc1ZNa0pxN244WXExRlNtR3N5K2dYVGtjWHVvTGNo?=
 =?utf-8?B?ZEdKcEp2a014amhBdnpSa1N6L0ZBS001ekVNeHdEY3lCV0pmTVk0dU1jaE1t?=
 =?utf-8?B?NW9SNncybHVMeHpBWVRzL0VLZmxvS3Z3VGlYbmV5bzFLWEpzMnRvcitNdGs4?=
 =?utf-8?B?Rlk0MVErdTduTVFNbWZubCtkU0pKVWZMYjVKQXVJSXNMNjQyRmxLMzZzS2Z3?=
 =?utf-8?B?bCtITXpiRHdUK0NHOEdKeVAyTzNMSEtzZzczdElCWlpZKzByTVN0V3l5STE4?=
 =?utf-8?B?L3RTTTZic2FReXhUZUg5ZnRnZXJOeW5XNzBqVkxwYjRIblRuVklaNlM1VHZM?=
 =?utf-8?Q?gPZcXWJ3l3N6YF6zzU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b444c36-6852-4cfa-bae6-08df0db0eccc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 13:56:04.9552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lr8sx185owEvjnvRz+jNw/2W8rewVZ1FxF4vzOGinTgBjLzDEQqEwhy1IUEgKNgI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5924

On 9/8/26 11:17, Sunil Khatri wrote:
> drm_exec_prepare_array() silently returns success without calling
> drm_exec_lock_contended() when num_objects is zero. This breaks the
> invariant upheld by drm_exec_lock_obj(), where every entry point into
> the locking sequence must first attempt to lock any previously
> contended object before proceeding.
> 
> Drivers that chain multiple drm_exec_prepare_array() calls per
> drm_exec_until_all_locked() iteration (e.g. amdgpu's userq signal/wait
> ioctls, which prepare separate read and write BO arrays) can pass an
> empty array for one of the two calls. If contention is hit while
> preparing the non-empty array, exec->contended is set and the loop
> retries; on retry, the empty-array call preceding it is a no-op that
> never clears exec->contended, so drm_exec_retry_on_contention()
> immediately jumps back to the top of the loop without ever reaching
> the call that would resolve the contention. This spins forever.
> 
> Fix it by having drm_exec_prepare_array() call drm_exec_lock_contended()
> directly when num_objects is zero, so a pending contended object dont
> loop infinitely.
> 
> Fixes: 09593216bff1 ("drm: execution context for GEM buffers v7")
> CC: stable@vger.kernel.org

I've added a # v6.6+ here.

BTW: If you identified the commit you can use "git tag --contains=09593216bff1" to figure that out.

> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

I'm going to push this to drm-misc-fixes, please sync with Alex to get that cherry picked into amd-staging-drm-next as well.

Thanks,
Christian.

> ---
>  drivers/gpu/drm/drm_exec.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_exec.c b/drivers/gpu/drm/drm_exec.c
> index fa923852fae4..f4503ab82c66 100644
> --- a/drivers/gpu/drm/drm_exec.c
> +++ b/drivers/gpu/drm/drm_exec.c
> @@ -322,6 +322,19 @@ int drm_exec_prepare_array(struct drm_exec *exec,
>  {
>  	int ret;
>  
> +	/*
> +	 * Make sure to lock a contended object even when no objects are
> +	 * given, otherwise drm_exec_retry_on_contention() would loop
> +	 * forever on patterns like:
> +	 *
> +	 *	ret = drm_exec_prepare_array(exec, objs, num_objects, ...);
> +	 *	drm_exec_retry_on_contention(exec);
> +	 *
> +	 * with num_objects == 0.
> +	 */
> +	if (!num_objects)
> +		return drm_exec_lock_contended(exec);
> +
>  	for (unsigned int i = 0; i < num_objects; ++i) {
>  		ret = drm_exec_prepare_obj(exec, objects[i], num_fences);
>  		if (unlikely(ret))

