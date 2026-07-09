Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012005.outbound.protection.outlook.com [52.101.48.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF204192E3;
	Thu,  9 Jul 2026 12:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783598574; cv=fail; b=slK7/nUEcDCU0UeMtkNimjuU9+FA7FURudbAW7m4eEgCi8JM2g1tVlvXvicuWmHmBzzDu6yb+d/eK9eVgxPQOJ9zWjfIICgqcieFG/gI4GxpIaXZ1UkP/Xh/N1PgvOqduV56gfhFAPz6fJ/AQ/wWGcpH6TVOyiQu8ohiF2a1LOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783598574; c=relaxed/simple;
	bh=nolCjcc1S7wwi8OOcGieUMtq09H5Xz+RhujFrl0pn4g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T9V+YTsboHkok55feRoB9JtYv6E26dgPNwXPG5UJ+kB9mOCqbbnPDTNT0g7B72STcrCV7xQHifjSGinc8W7kWZpvdxFPmPLydkpqT9InyovY5r34BgwfmXxGcEZQHJHtTekvLYMhya5sLi6qSHdsyh1/lID0mctswvcUOZHgoUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vjyZ5yK/; arc=fail smtp.client-ip=52.101.48.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vjyZ5yK/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uy2wylPdVLuhoV6oqs/Ctj5mTeCEF8DPsUuDTWJkG5HQBHe61kPlBzssZ5HPDKK+Mr9SRjKWxg/bzP8pHjI1W4WaC/+GELqRkUPTmDZ4gstb0tb2zbVTEiIrrDHKiwwdUl/xVZLc5QelHumY6fIJm4eF1XikfhggOBl23W7tdbfXvlyBI7b50SDGA/N3UFmN5Ts3P/6NS8eS29F+Aih/f4m2WThVGlf9xmJb78sthSFT5Q+Yhrv/nNZN3lvUgVLDr0bMW/WTJiDMtOj3YwCWugRu3EEmneh6+B3QsVmqWRKZXJdr7ROcfHRehdcirsK1cTT7DSiQZZFAPuwZFKE9aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSVq9H8cdhCaUFSqZRi9VVDuI6AWsqw60aoQO1YJLlI=;
 b=ARDjQBoHS8vVMeedVlnwar6hAmCAlP9wA91nCncc8u2Xox9mjKQgxR6r8011+GT91+z49NTZ+u0YRU/2zuKp85WIG92HCoJJNL95f4e8OG1Bs3PLhJr+iuVnn+8q0RIrL2rH4GndBxHUKDQHaPsTaloNMBuGdQ63ncRqT4zztJlitYHItJZLO2PQB0pgw3gx7ouLyM1j1REusgmSMqA9MPQjHMbrB0r7plWYvp2Fse5XYK7CcjO4udI0dVGXns5csXtW9mAzYfEszUG8AnumystC+xHZmWN+AN4btKVqxoqhklCNSQFjfSC57/ofGDCPlnamlVsZ0P0nNGOHGZ85zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSVq9H8cdhCaUFSqZRi9VVDuI6AWsqw60aoQO1YJLlI=;
 b=vjyZ5yK/yYePJpt5p22NvY04lkqWMCO2g8b+61KkfwUpk4SrDhH3fjkGpAPeEad4wqgI5ScCRrR6x0nWuVSeUd9MA5k+nsKZBQqok4eOjdJx/WmLMFaN2OXIzHXPEWOCIz9EStFQ7G3XOUUY2v+8lpoU0Og3VOvXUfuCAd/o/5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB8729.namprd12.prod.outlook.com (2603:10b6:930:c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 12:02:33 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0181.008; Thu, 9 Jul 2026
 12:02:33 +0000
Message-ID: <bc45a40a-7cb4-4416-80f4-ce43272821f9@amd.com>
Date: Thu, 9 Jul 2026 14:02:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1] drm/amdgpu: Use scnprintf() in amdgpu_mes_add_ring()
To: Evgenii Burenchev <evg28bur@yandex.ru>, stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: alexander.deucher@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 daniel@ffwll.ch, Jack.Xiao@amd.com, Hawking.Zhang@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20260709112825.40016-1-evg28bur@yandex.ru>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260709112825.40016-1-evg28bur@yandex.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0054.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB8729:EE_
X-MS-Office365-Filtering-Correlation-Id: 34668baf-340d-422b-6f6c-08deddb1f5a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wACUf+fSxZhREa56DopBeTBAab328nEpqYQVGito/6jYra6xELjgiYZKEc5QVaA0sLQNrarrNCgGgNP2H6MatAI2abJ9fQ1LVGDDMc1ySIDDiY8VE60PeY7BlZ+16rpwKpHWf8gtMvhHZmFg+YYZoIA18dzDxTEFnnjvSG9ba/M/15JVc6EPdSckPwWj8v9WrXtoG1S03NseoxWQoQltffheuj5rVfW2J1NKsjpYvUQ2Dv2TDq68qpoIOH/T8zdipZuUyiUimqZALZtHQdAH4Ns2Dfo0xUjGbWAD0+9a0wz16d2sec/aszb7D1OE4fABjo1nuzqq2txXuV/AZTYX7Ve5WdEqzl3vULtzytYm3VwOhtNTwxsVX8l/7NQa1hA147qGI5rjoqaHClclE3OtAUXRpjqW+7PQTeVAdnFZKmxc8zyHn9peg+421GGqnh/A9PpSxk0t8CgOrXyBIbksViy9wfb8OFggJYkY0LlnaFnIggyfoEWDkByndnQJINNuV5q38Wv1nsnePu5xrogR9YDz/XnVO3MTEOPMkgaK4t81YElyFAfVj27p7WMOu0OFgTNNQR9ba2Hs/Ho5O8oxNaTFFU07666r65DWLtu5zHWu9Ge5IAOFvwLFlLsQNC9NyOtvUVdPV7LY/dZnJKU8DlqDbzK5xrPlezmsKKExn0M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODU3ZkE0MnN4dm41a04rK3E5elRpaUVyK01md1RsZCs2VEUvMElud0JlaFdV?=
 =?utf-8?B?SW5tNmhheGF5UEk3aXB2dW4yNk1sajE4czg1TElBVEw4NjFVOEY4aFFlTmVy?=
 =?utf-8?B?TkUwYlhERFVsMGpVZFYzdVRMOWZSK3ZtemIybVFTYy9NL0g4UTNlYm1ta29p?=
 =?utf-8?B?dDFjYkxHWkpSNlhQVi9Nb2tkV0ptL2g2VTdSeUhuRzgwZElXdzJZVjBlY3Zi?=
 =?utf-8?B?b0FJMFdqbEtwWjZUUkhwZ2FVeFNSRWFzZ2dqUjNxbWdUK3Qxblp2d01zOWh1?=
 =?utf-8?B?dTRZbmVtZTduQlBxSDNyTTNzL3h4SzRZM1J3MWpQWHkxdUdnekdaOEcwSzJX?=
 =?utf-8?B?Z2xvSy9JWjI2OUtqbkdrNHJzUXhVdVpic0hVMDM1dVo3K3h0TW9qZGVMRFhO?=
 =?utf-8?B?cWNDSmxzb1d6SDJMWjBiNllOS0NJMUZ2VnRqV0ZKOC9kMHMxRWtQZm52YU5G?=
 =?utf-8?B?b2krNnU5Qm5mTUd6UURTYjAxL2lhbUJHVjFLakd1TkVQaVk2Wm51WHBYRWg1?=
 =?utf-8?B?MmdSeWpjcmVxaml6cGFVMUlVMnRhY3dCNlhmS3ZidmszM25OQnhzbG80LzZI?=
 =?utf-8?B?TGVUZDI0ODJtTlhmeTBNcTM0NVRzdkRuT0xmZkxJaG5sWFgzTzhMTkx0bzla?=
 =?utf-8?B?QVdmQ3E1bzhBZHRWYmxHQ3VwNy8zMmJNWmhXMi8vWjQ0NWRJSm1vb2xaT21H?=
 =?utf-8?B?dEthVVZGWXR2azd0cnU2Q05WK2xmOXZDL3d0U1k1RURWNFlrbTJhV3ZkV2Ey?=
 =?utf-8?B?bm1rMkRPV1FGbG9ZRjg0MmQwNllzV2R1ZFRFcjBjdE5QVmFLWFpCa1VtY3Fk?=
 =?utf-8?B?RG1NQ2tDNWROWGljUmdIQnhYb0NhWUE4VC9DZUs5QlhhWnE5MWg5bXRkemZW?=
 =?utf-8?B?ZGR6clRFMmNXaUp1aDUwaDd3aTFvekFyMjJzWlJFb1Z1MTFhVmVzMDhPZUpR?=
 =?utf-8?B?YVpCL2x3bzYyeFZmNy9VckRvUFFiekx0NEc1c2JJcWd1NmlscHhmQ0xkOEox?=
 =?utf-8?B?cVJrS1hYUVlVMGV0dHVnTEJ2elhlUmJuQ1UrbkF3NXRHYUc5Q1NydCtxQlk1?=
 =?utf-8?B?OG0veFRmNGszMUhEcXV2Y21UeWVvaVFGMVBPVi9xQnhDaG95bmFqTkNqaEF2?=
 =?utf-8?B?Sm9jdFdRenFQd0YzblFCT0NZdjJvQjgzR3NLbVYvZ2puaVJXU3NpbjhTcVZM?=
 =?utf-8?B?RVkyMW9scUsvNkZFYmo1RWRsN1d1cDZqak5YdWJrS3NiQ0hqdGFqZDRwWXFv?=
 =?utf-8?B?MEVvcSsxS0VCK3V5VUlhMVVXdXg4ZWRobFhxOUlwWEpYUDZDQ01KYlNMZjBx?=
 =?utf-8?B?a0JweUsyeStMdkRFYzZhUUxNQmxzeEhNMUxTcTlEYUdpVlp6T2tlaVo4UUU4?=
 =?utf-8?B?K0ZSM3R4elFOZXN5Nm9lWkM4eXVaVDFhTjlIOHgvTVlIaFQ2T0d0UmgxZFdE?=
 =?utf-8?B?OUFQKzJvcjRPMVJNc0NvZEhSMmdtWHFKUUVzb0NWZHRMeFBlblJGZExrWG03?=
 =?utf-8?B?Yy9kMm1DWDFQcStxQ09UN0pzQ0FzaEZGY0toblRYM3NYQnBCZy9aL09ZMEZq?=
 =?utf-8?B?dVhYNzF0aXBjSU5NUnJSaGNkbDlCOElMcmlTT0JaSzJnYUNkR0x2SUlVVlNr?=
 =?utf-8?B?Q3lobjM1Rm55L2wxMDMzUVZCY1Y1N2p1ZFRUWk9hNGlQcHFPUDQ5MGl0YldL?=
 =?utf-8?B?Y3VxdlZNUXA5QkR4WU14SU83YTNVNHRPTWJFN3VldS9nZUs1MG96MjlqNFBX?=
 =?utf-8?B?Qm04YVkzelhQVDMvWDltUFhHSEFUcEVhb2xSMnFMNHQ0UFNrSmNpSFIxeDRz?=
 =?utf-8?B?NEk0VENCTmtDZHJORzQ0M2hNMTVxUzVnNFpEbUlmQW9RZUZiM29MUWJUT29N?=
 =?utf-8?B?SWtBQTNib0x5eUtPaW9yVm1MeEZxNDlUS3d3ckt0M09FV3pMQmRSZXEwdm96?=
 =?utf-8?B?TmRJY2xtUlpMeDJVMzVaSWIwS2JHS3ZlZWp3M2NnT0RsR0RPWlRDU3JoM29n?=
 =?utf-8?B?alVHVk5sUDR5Y2ZyRnZML1pqMkpGam1hU3dUaEdNM2pEZkNCa3pLYVF1Sjh1?=
 =?utf-8?B?ZVdWbm9ldE5RS0dmc0JKbHhPbjRPcGFSZ1g4Z2dpUEhNY0MwWmcxelREWTVI?=
 =?utf-8?B?MDVYeVFVVE1NNEJkbFZHRmhUNVVkaDZPVVpKU1hvWFI2YzVyYXFGWmZkRXhS?=
 =?utf-8?B?TEJjU3BRT0RpRlVkQmRIK2RPc0RFNGFpbTJZbjdXM2NOWFAvS2lsU253blJ0?=
 =?utf-8?B?RWJLSG9PL0xBZ2pwdmNUOW1CNm0yUHBjQklGdndmMmVNWnZOSUFkcW9lNHNG?=
 =?utf-8?Q?fYzpM8eVzvAt5kfA3H?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34668baf-340d-422b-6f6c-08deddb1f5a0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 12:02:33.4859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUfihP3zeRn/njHWcoQuH62DhArYwFy3JPvkX2kfnP+OBNKXVw+9nPkq4Vq835K0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8729

On 7/9/26 13:28, Evgenii Burenchev wrote:
> Replace sprintf() with scnprintf() to prevent a potential buffer overflow
> when writing to ring->name. The buffer size is 16 bytes. For compute rings,
> the string format "compute_%d.%d.%d" can exceed this limit when the total
> number of digits in the three numbers is greater than 5 (e.g., pasid=1234,
> gang_id=0, queue_id=0). This can lead to memory corruption.
> 
> Using scnprintf() guarantees that the buffer is not overflowed, even if the
> string is truncated. This is a minimal fix for the issue; the BUG() for
> unknown queue types is left unchanged to avoid additional risk.
> 
> This code is only present in LTS kernels v6.12, v6.6, and v6.1, as it was
> completely refactored in upstream. Therefore, this patch is specifically
> intended for stable trees.

That is not stuff which should ever go into a stable kernel.

This is just a minor cleanup and not a bug fix at all.

Regards,
Christian.

> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: d0c423b64765 ("drm/amdgpu/mes: use ring for kernel queue submission")
> Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 3feb792c210d..6208967f0e6c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1057,13 +1057,14 @@ int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
>  	ring->doorbell_index = qprops.doorbell_off;
>  
>  	if (queue_type == AMDGPU_RING_TYPE_GFX)
> -		sprintf(ring->name, "gfx_%d.%d.%d", pasid, gang_id, queue_id);
> +		scnprintf(ring->name, sizeof(ring->name), "gfx_%d.%d.%d",
> +			pasid, gang_id, queue_id);
>  	else if (queue_type == AMDGPU_RING_TYPE_COMPUTE)
> -		sprintf(ring->name, "compute_%d.%d.%d", pasid, gang_id,
> -			queue_id);
> +		scnprintf(ring->name, sizeof(ring->name), "compute_%d.%d.%d",
> +			pasid, gang_id, queue_id);
>  	else if (queue_type == AMDGPU_RING_TYPE_SDMA)
> -		sprintf(ring->name, "sdma_%d.%d.%d", pasid, gang_id,
> -			queue_id);
> +		scnprintf(ring->name, sizeof(ring->name), "sdma_%d.%d.%d",
> +			pasid, gang_id, queue_id);
>  	else
>  		BUG();
>  

