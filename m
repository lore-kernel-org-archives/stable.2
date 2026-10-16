Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD163BED75;
	Fri, 16 Oct 2026 19:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792180507; cv=fail; b=UuyDyasJrHCetXsdVXX6fcA1iyi7mhT6ndgdXlt2EN2xTxodRiUXUrRf80pVfeP8sevCQ7S48t4LuFXzM7DcP6EkBnOMfJfDiGATHbIe2ecdK+FyzRsLRahY1Cz2nZKBqacAW9yNViTHiQa5UVQ3P4rjNyGAFL8ICxnP50gfqvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792180507; c=relaxed/simple;
	bh=wUMJV+WnZGcd4hOnuCHiR8lL+auinLOFHm914BrKs18=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rvhmDyH5iHOPYR8hpn++qoYY+CGX3mq7v+aRmJx0L2c24AMkgSeIH4VaLCVRuaEnCQFaIDBK7vtF2NYZQc49r5olNEL8mM1qZ6JUcHh7+gUV7LB8fliZ4yZOw/lfKpiMaQZZSvE6iz1s18OnFy7bKEnwNE9pY4vH5vlFXFCxUps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uRDl2g+X; arc=fail smtp.client-ip=52.101.56.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uRDl2g+X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4WSeXFBK8d42aLNM5MihaglBbpZCni9EGBjr+teTjbA0cMcVgWsiD4vApRFMRQjgjcc8z19ERoH7X4cDCawe+lxD4RV///gWEQGSCH5nY58GwGuAXGLQlnOpz+RazXBWxrFGLgo49xBzqYwOMzUngfguEqJWTX9MLGaaUPvq61KWgZOYXDqaG11ehYYdA0F8rBN7K47coSh0GqLHd3hvlRdrVyebLXiJWEzXP4GVXklBciPBLX/f/47HovsfA79SY4V8WIzn+RjOTysU6qS98epU6s84N2NdZ9robX3FgGch61WBhgVgSyZjrm3n04+cb6Y73ma8Ee1blVLfUyOXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UWge0hMojffVxeiah128SrF256MNR2o9leytTsYw7A=;
 b=NSKzWJhGUUnzjALdRvTOGyVvFeO9tBGqMs0keOIfVaFWQwjbByuakYLxKW6c/MEaVORV7WxEARFVrgkCLbot6E8WT0nWh8FyhJSGyqIoz19UMU2B8SW42LKVMRmdUtS2PjYVgDZKZyGJRUx06zT4mA9xVxX/YD2wQVpw8/cfL/yl1fnUeZ9XCHeLY7joXwHWxumedprRMNSHVE4oVduhf2h0zjEYaD7yxswLLvSygPfXKeGotNUeg5bQEnm5xj/Bo5iQkK1pX+Ul5lHqCcmormKsMrterbmHjP5ZYEvvh7ctNRdG5KZgW/nhLZxktaUh8pAlhYzKbhMo4Q+1PF+1gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UWge0hMojffVxeiah128SrF256MNR2o9leytTsYw7A=;
 b=uRDl2g+X5RjSDeQJo1SZSoldXdpwkQLVP8PXvzVBssiNKO4Gb1K6XGs8D7c3bKtumoyAngIoqCAljiiw/niWg9YwJQxucE+3O2tlP76vMMI7MFn60hovLaOjP1K16YzaIGXbPVlIDWzGD4cpBS2zwzrqfovPHzD+/TzUr8o2zik=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by CC6PR12MB259526.namprd12.prod.outlook.com
 (2603:10b6:170:209::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 19:54:59 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::23fd:d049:8f53:2054%6]) with mapi id 15.21.0522.012; Fri, 16 Oct 2026
 19:54:59 +0000
Message-ID: <439306bb-d5f8-4dbd-8fde-6f497bebb323@amd.com>
Date: Fri, 16 Oct 2026 15:54:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] drm/amdkfd: validate SVM ranges against the target
 GPU address limits
To: Daniel Huang <danielhu@amd.com>, alexander.deucher@amd.com
Cc: christian.koenig@amd.com, alex.sierra@amd.com, Philip.Yang@amd.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261016170546.88570-1-danielhu@amd.com>
 <20261016170546.88570-3-danielhu@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20261016170546.88570-3-danielhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0332.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::6) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|CC6PR12MB259526:EE_
X-MS-Office365-Filtering-Correlation-Id: 711813f6-f775-490b-1a0c-08df2bbf5beb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|5023799004|11063799006|4143699003|261009223027099003|56012099006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	8HxjANjwbY8FagZDQPHmdF0q+94Wn+T2iRDknwPjw9dG6YSplGp3bhBvpIfWclB+QbkmSAgWjwFLlceFcMXn3xFbQ1ukgtdFHf19jj2UDHGnq9nhf33e00C4HLBNTvQBiGQJoxHMS84NY5m/iXDZ8+/39/3CGfu7BsCw7E/FiBsMvm8k4+ZEbYYJujzf33oK7ALPD9l8epGDAQ5mpkdT/JyWYMq4XcrdPp/napDOTgPsteA3ZYnk5vdetv2xA+/aB4wB578MWjaYK60qDTpK2f9ARwlWs8oeLv1v8UnYoYy2+7xPJ1q/YwsCafmrcOra50buURp0pZ3nIvSV4ap2ZsDvkpKzpSN9N2EcBEDPZVbL/XpsrnOH8KENxJGBK2akmQNI6eh2DcNf0J43el7t4JmLOKbyfxxGT6OqyJCrY5P7U8qrJWQC6ZkSmXqAv81SzfjKz6Jok/5Ok4oGJ8feQUiaxQXTWa7nfoKh2H8ootxf/M1feCcs/1fRQI5vl/gV1K5NIH/KhNjd0w/KRiiKpcb0STVUGA9kztE67+ui0M3nnmRbKZKj9yRxl3YgMwVKOH1O6AqUqaPwuZo0VUF6RghWIiZWpjoXSUMEiDGM4+A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PPF78FC67EBA.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(5023799004)(11063799006)(4143699003)(261009223027099003)(56012099006)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXRoVFFZd2p5OGh3MmVRMVZQTlZabzNLUVowbSs0L29wZnJBOTA0eUNxbm1i?=
 =?utf-8?B?MjZlMGNrWTlOaXM0K0E1U2lXNjZVaXpTb1RHazM0Yy9yYklIVnBSTVF3b3RL?=
 =?utf-8?B?WWNFOG1HeWNXNkgxTnVxc2NreC95TGVXc01NVGxQajNNQUJ1NmJBNGNOb1Rq?=
 =?utf-8?B?RW9pbGowRnVSbUxsM2FXRzdmQjBpUUZLeTZFWEFNM0dwbXJLdVRFekIwSlVX?=
 =?utf-8?B?R29KOXFIeVd0MXdka0tWdlBxampzRnVLRWEwcnZPZ3RHTHgyaFduN1BXc1pT?=
 =?utf-8?B?WUxkVGxWUnVqNGNQdFRSOGJYKzBGZVFZT2t3cEh0WVlvWmJzRFBXWXo4YzA0?=
 =?utf-8?B?V1ArcnR4RjR6ZTVpeHVmekxIY3FuTUZmUURHTmpOUU9VOFJrZTlsNVJSeUMw?=
 =?utf-8?B?ZE9EblV3VEZXbVQ4WVgwY1huRDRsZGV4dUVwOEZXVU9jRHE4eWh4eGdFT1l6?=
 =?utf-8?B?TXdBUlZKdW1ueTJBZ3oxbStQQjFVWHByeVBlOXgwVmNnVWJWQzVGZ3dEUjZK?=
 =?utf-8?B?ak9OUlQreWdwOERtRWNCY3FtWlVBajNsaHAvVTNRNzByMDBPanRoY1gxcytC?=
 =?utf-8?B?RlBER0s2WEVTRVIvOEtRd2x1bW9heVo0Q21yL1V1eDRiNHZReVIxUXQvR3hQ?=
 =?utf-8?B?UjJCU0FYbWU5dytVS3BHOGRuQ2x3SnVRM0JGNk9Yd1h0ZE1Jd1p1NGlyL1dv?=
 =?utf-8?B?MWxTeEkybW14K3dCK3Vsb1dPYVRaYmltdWhUS2RYTWFvWU1xS2R3cHRBRkt5?=
 =?utf-8?B?U0hWSGgzZXVrTU50Q3ZNUjdwU0J0QUM3c09uUy92Vlc1SlFoOHViZXFzOEpm?=
 =?utf-8?B?VUlkd3MvaFhrMklwWllSS3kzVTJqVU0yN1RMWEIvcGV0aWFoQy9vQm4vLzc2?=
 =?utf-8?B?a0NFL0xvNmhYNjQzOVcwRUlPK3NQcG1iK1daRVE5VlpuQ3JxeThGd1AybmR3?=
 =?utf-8?B?b0Jrc0JnRmk2V2FBTW5QYkxnNDM2ZEFBYWdHMDlURnlBODdZVDM4Z3JsV2JT?=
 =?utf-8?B?cElWaysvdkFzdG9JQjdpcmY4VDFLV255Z2lqTkRzbXZ2U0w5Z2NyNGdwM1pR?=
 =?utf-8?B?OU96ZmNiT3p1eGxSRHdGU05QNXhxZXpLUW9LUHM0YTJxQXVpdUtXOVB6d1p4?=
 =?utf-8?B?YmRQN2N1SGtBbFFiNzRvMHZpZlpJYm1XdTRHaHJNQ21PVzZFQ1VVSHZna3dP?=
 =?utf-8?B?dDRLUGZib2t6cytSU0FCMW5RMTYyQnNhcXdoa0krZzlySmhKK21xZFZGMmNa?=
 =?utf-8?B?dUd4ZllxNmNPOE5JLzFYaTFrREpvZDlXc2RoY3lCY0M1NWtVc2lIVVpTZHRS?=
 =?utf-8?B?cTFxL2tXZkYwY2pXd1ovalp4SkdGYUpFdG01T1N0VWIxWHRGbzF4blg5ZTN5?=
 =?utf-8?B?bkRjcnpWV3QrNzRYY1pNdjdXaDc5OHowbVJNOTlBUXhBMXZFd3AyU0NWSDJa?=
 =?utf-8?B?OU56emptSUlTNW5yd1Y1cVRadWtuendseEoyUzlhY3JUY0VMQWhwMTB2SDIv?=
 =?utf-8?B?MzcrOFQ0TGN4V1RTa0hRYmYxM1BrUGFoWUJHTmZtelgyaTNwRTFOOVE2RlFZ?=
 =?utf-8?B?SlBJdXlRZ0xVZU10MjVIaHhab0VXOW83Rk1KY0UyYlBuTW0xTUpXSkUwVVpt?=
 =?utf-8?B?L1V3bWFrU3NrUk4xYjRxN3BJM0tFVnFGdEtUMmp4NGNxbWdiQUIxODl3dUMr?=
 =?utf-8?B?TUFLQVVQZVBONWdSK0dxRGtiVUMxc2NxbEExRUU5RmsrTEY0MXJna0hPREwy?=
 =?utf-8?B?cXlYcDdxSCs3dUVTc1FjcVIrMVpCbFdhK28vSHg2RlBSZG8yZnYxYXB3TDhB?=
 =?utf-8?B?K29mK0Vxd1ZGUXRwNlZQT0NWeTlQTzRnQ2k5MGs1RHlaTTBaSmU1NlhMcU05?=
 =?utf-8?B?cGpPZHcvcmxzZFNYRFVwb3R1QjBvQWlFQmtjNHA3ZXhSMHRwUW43S29KeGN0?=
 =?utf-8?B?SjliRlRUdWE0S3h4SkdIajJsWmtmbEg1bDUwb29pWTlUbVhoaEh2TWJkZU04?=
 =?utf-8?B?VGhiZE5rZ2xEWHFQWTI1ZHp1NnNLaUxHTmtiYXhEN2l4TktvVXVsT0J4bEhn?=
 =?utf-8?B?alU5TWUwUzJiUk04cjZtcW5nR0RMT2w3cjVuL0NZaU1ub2F5ekY2U3MrL2w3?=
 =?utf-8?B?UlVEK3RsZGZMUnZwRCtCdU1kamhKVlBvb2p0TkRuOGNSMlNsWjM2N2xNOWZ2?=
 =?utf-8?B?YkkyKzQvaDgxQS9HZENjbUhoOWIrbUx1M212ZEpnZVEycEhxMlJtVmRoTmtE?=
 =?utf-8?B?dXhoTXlWUEVXZUlTaE5CZy90Wkp2TGk0Y0k2MW1XajFLcGhrS1ZrL2ZvTlI1?=
 =?utf-8?B?aHdiWkxpTDlUaTVtTThJd29qb2IzZjA2ZEIyUzY3STFwdDl5b3dYUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 711813f6-f775-490b-1a0c-08df2bbf5beb
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 19:54:59.3158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gghwgg0fI8DL8ElNCAz2DDE2p0Wbe9hqM8Gr8BMLSxno5PxndhN+jcIcvCVF/NtB/S4d3bSXt7eIyiMEiIMmRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CC6PR12MB259526

On 2026-10-16 13:05, Daniel Huang wrote:
> KFD SVM maps memory in GPUVM at the same virtual address used by the
> CPU, but nothing bounds that address against what the target GPU can
> represent. kfd_ioctl_svm() checks only page alignment and a non-zero
> size, so the PFNs reach amdgpu_vm_update_range() unvalidated. Unlike
> the SVM path, the BO mapping path validates the address range through
> amdgpu_vm_verify_parameters().
>
> Disabling SVM when the GPUVM cannot cover AMDGPU_GMC_HOLE_START closes
> the case where the GPUVM is globally too small, but it compares the
> GPUVM against the GPU's own address hole. When the CPU address space
> is larger than the GPU's, the comparison succeeds and SVM stays
> enabled while individual addresses can still fall outside the GPUVM.
>
> On a 5-level paging CPU with a 4-level GPU, mmap() returns addresses
> above the GPU limit when userspace passes a hint above
> DEFAULT_MAP_WINDOW. Passing such an address to KFD SVM indexes beyond
> the allocated root page-table entries in amdgpu_vm_pt_descendant().
>
> This gap was found by the Sashiko AI review bot, during review of the
> first patch in this series.
>
> Validate every range against the limits of the GPU it is being mapped
> on, using both vm_manager.max_pfn and the GPUVM address hole, and
> check the end of the range rather than only its start.
>
> GPUs in one process can have different address limits, so the range is
> checked per GPU. svm_range_validate_and_map() skips the GPUs that
> cannot represent the range instead of failing the whole mapping,
> matching how it already skips GPUs outside the XGMI hive.
> svm_range_map_to_gpu() keeps a hard check so that no out-of-range PFN
> can reach amdgpu_vm_update_range() through any caller.
>
> Page fault recovery is rejected early in svm_range_restore_pages(), and
> svm_range_unmap_from_gpu() skips ranges that were never mappable rather
> than returning an error, since unmap also runs on the eviction and
> process teardown paths.

AFAICT, this breaks mapping of memory to GPUs without any feedback to 
user mode (until a VM fault kills the application). It also duplicates 
the check many times (every time a range is mapped or unmapped for any 
reason). I'd rather reject address ranges that aren't GPU-addressable as 
early as possible in the set-attribute calls that create SVM ranges. 
That way user mode can observe the failure when it happens, which makes 
the problem easier to debug or recover from.

In other words, save the minimum virtual address limit of all supported 
GPUs used in a process in process->svms during 
svm_range_list_init. Check virtual addresses against that limit in 
svm_range_add (for ranges created by set_attribute ioctls) and 
svm_range_create_unregistered_range (for ranges created by page fault 
interrupts).

Regards,
   Felix


>
> Link: https://sashiko.dev/#/patchset/20261016145129.69645-1-danielhu%40amd.com
> Fixes: f80fe9d3c114 ("drm/amdkfd: map svm range to GPUs")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Daniel Huang <danielhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 42 ++++++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h | 27 ++++++++++++++++++
>   2 files changed, 69 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index cfb428c72686..c3e4f0367522 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1427,6 +1427,16 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   		return -EINVAL;
>   	}
>   
> +	/* Such a range was rejected by svm_range_map_to_gpu() and so was
> +	 * never mapped. Skip it rather than failing, since unmap is also
> +	 * used on the eviction and process teardown paths.
> +	 */
> +	if (!kfd_svm_range_fits_gpu(adev, start, last)) {
> +		pr_debug("CPU[0x%llx 0x%llx] exceeds GPUVM, skipping unmap\n",
> +			 start, last);
> +		return 0;
> +	}
> +
>   	return amdgpu_vm_update_range(adev, vm, false, true, true, false, NULL, gpu_start,
>   				      gpu_end, init_pte_value, 0, 0, NULL, NULL,
>   				      fence);
> @@ -1504,6 +1514,16 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   		return -EINVAL;
>   	}
>   
> +	/* Last line of defence before amdgpu_vm_update_range() walks the
> +	 * page tables with these PFNs.
> +	 */
> +	if (npages && !kfd_svm_range_fits_gpu(adev, last_start,
> +					      last_start + npages - 1)) {
> +		pr_debug("CPU[0x%lx 0x%lx] exceeds GPUVM, canceling map\n",
> +			 last_start, last_start + npages - 1);
> +		return -EINVAL;
> +	}
> +
>   	for (i = offset; i < offset + npages; i++) {
>   		uint64_t gpu_start;
>   		uint64_t gpu_end;
> @@ -1604,6 +1624,20 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
>   			continue;
>   		}
>   
> +		/* GPUs in the same process can have different address limits.
> +		 * Skip the ones that cannot represent this range instead of
> +		 * failing the whole mapping.
> +		 */
> +		if (npages && !kfd_svm_range_fits_gpu(pdd->dev->adev,
> +						      prange->start + offset,
> +						      prange->start + offset +
> +						      npages - 1)) {
> +			pr_debug("device idx %d cannot map CPU[0x%lx 0x%lx]\n",
> +				 gpuidx, prange->start + offset,
> +				 prange->start + offset + npages - 1);
> +			continue;
> +		}
> +
>   		set_bit(gpuidx, prange->bitmap_mapped);
>   
>   		r = svm_range_map_to_gpu(pdd, prange, offset, npages, readonly,
> @@ -3096,6 +3130,14 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   		return -EFAULT;
>   	}
>   
> +	/* addr is a CPU page index here. Reject faults the GPUVM cannot
> +	 * represent before any range is looked up or migrated.
> +	 */
> +	if (!kfd_svm_range_fits_gpu(adev, addr, addr)) {
> +		pr_debug("fault address 0x%llx exceeds GPUVM\n", addr);
> +		return -EFAULT;
> +	}
> +
>   	p = kfd_lookup_process_by_pasid(pasid, NULL);
>   	if (!p) {
>   		pr_debug("kfd process not founded pasid 0x%x\n", pasid);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 6235ce0f988e..57d4d79a6266 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -216,6 +216,33 @@ static inline bool kfd_svm_vm_covers_user_va(struct amdgpu_device *adev)
>   		AMDGPU_GMC_HOLE_START;
>   }
>   
> +/*
> + * A range is mappable on adev only if it lies below both the page table
> + * limit and the GPUVM address hole. start and last are CPU page indices
> + * and are inclusive, matching svm_range.start and svm_range.last.
> + *
> + * Each GPU is checked against its own limits, so a range that only some
> + * GPUs can represent is rejected for those GPUs alone.
> + *
> + * The parameter must be named adev since AMDGPU_GMC_HOLE_START references
> + * adev->vm_manager.max_level.
> + */
> +static inline bool kfd_svm_range_fits_gpu(struct amdgpu_device *adev,
> +					  uint64_t start, uint64_t last)
> +{
> +	uint64_t limit;
> +
> +	/* Rejects empty and wrapped ranges, so last bounds start as well. */
> +	if (start > last)
> +		return false;
> +
> +	/* First CPU page the GPUVM cannot represent. */
> +	limit = min(adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT,
> +		    AMDGPU_GMC_HOLE_START) >> PAGE_SHIFT;
> +
> +	return last < limit;
> +}
> +
>   /* SVM API and HMM page migration work together, device memory type
>    * is initialized to not 0 when page migration register device memory.
>    */
