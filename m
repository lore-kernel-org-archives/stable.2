Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013004.outbound.protection.outlook.com [40.93.196.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D06D3CE0A1;
	Fri,  5 Jun 2026 10:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654010; cv=fail; b=qnA1MQk3yejc5i08yy+KO7pXPpk8F0QV3jbTAzmo1IyzI2ag7EU0O6SCvjD0RHeDrjuW+5b+2cXSjhLsG4qZ0QwJxp8n/8UDJbgb6aIg35hEdIRS4qGg8IMW/igP7/Aaf9snk0b+vOubUZjmny7WgSm9KRN4LE+AaNY6/ygR1+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654010; c=relaxed/simple;
	bh=ZPDfAFk4EsRVtB+TOzXseJlwTRyPQMPOuQuIZO8uJ/k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WYXevbXKo7kQSTFaWDheN3AQ9fbzEEBmhldi+ePJaE3CJH7ZZuJdEt1fxN1xFawqUrG7obkIA/qh44rb/Y4k2qOQO2b1CNzcUqliJ9K7hrWdzGDf5HQ30fJk+ZPj7N27v/JvBr/ANnyMfCfqVzKPSlojhAl1L+yRG5diuh0XFcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dbrY+3e8; arc=fail smtp.client-ip=40.93.196.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dbrY+3e8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=haG4xc4ftqDfT4T3kiNA9z/xg9CZImfiVWtGX6GIImGSjAsWPZWQpYaCtaG07xKZENlkv+gva4XUlqHcRsfOFnbcipGlgqilvxPWLLsLrcEUsIDCcJDDp2HMgTqT7RxTzBPRfyf8UFEP0gtgB9TnCyX8erwcoQ1lOU8A0oEK1DvFMiwSHWc0wKl05bj20aPHgVQdWtXtuLFJYEdPjQotruWzE5X0xSZtMy4Wfm0mWvV6HtREl0WsgPn12OX1hVqE9OvlY+Ob+dQlZ9iuRJurBcpeRDhKHg5km69n/4kLi+f4xVn4JRX1aNNyESgDgCnNl1ys6kNFNnJzORCw3idIAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lyvm82eCvC6wF0ltDOz+hcg2yRszglRldaAaBWPzKr0=;
 b=QfK7/nKa0K/UGXJJT9BwJNf+J5eGuqfWashzaykCIkAr4Tw88CzAfBLvsLCqGlkYAzREXGIy/rlp1c+x5DGBgn/qKDatjewryr2eVImZGk1k0vEyWQ/3K1O4thGLgsyOYpO0Av7iEBkYaULTLp58Mc36FtqzNDfK0lsZCdNQez/G2Wr5jJoASQ9CzYRx3DRJ5pNOPOVgSuhCE1KOy0bU/GiBq3RoXi65XXld/LYNzCQl6bPaugRNMVgZw3GSuXVJ0m0kun0nZzP/iGcaSTyzrfd9RPOs8lh3zEk0trFoNUkcQFAeM1OSXYMbpQUmNoEidNWX0jwkhSxpibfMHbl8iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lyvm82eCvC6wF0ltDOz+hcg2yRszglRldaAaBWPzKr0=;
 b=dbrY+3e8zxoeV0G3XhBwHweAG2DNNqFJbM5G5aLYrrJ2M3Lg2gcqpPtLAuN82o7srZW9cvkxTLgQ/uBAudUd2Q1Ml0qZtAPwLGbWKPWX4WB7pNwRbtpkNMGIcbvl/dqr5JKq/0WTRuQz8k4XIXA08jIrZSMJER5VShV2kto0Xbw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ1PR12MB6146.namprd12.prod.outlook.com (2603:10b6:a03:45b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 10:06:41 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 10:06:41 +0000
Message-ID: <1452380a-6a54-4285-b8da-3a5e74f30e83@amd.com>
Date: Fri, 5 Jun 2026 12:06:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix refcount leak in
 amdgpu_ttm_clear_buffer()
To: Wentao Liang <vulab@iscas.ac.cn>, alexander.deucher@amd.com,
 airlied@gmail.com, simona@ffwll.ch
Cc: pierre-eric.pelloux-prayer@amd.com, lijo.lazar@amd.com,
 felix.kuehling@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260605094827.7982-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260605094827.7982-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ1PR12MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: dd8bdc37-9912-46f8-8708-08dec2ea2390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	nzfvyQv/W5SJBRKb9G+K7QI6jsSY+wv5/CqL8C1UqKqqppuldkuVXnmupi7eE9ZdF9Npp3b4ty7ZAbE2+JEJ9pp0A7AHnSkDtvtvtQb59kGHkmYxiR2hkUusehchBlN+o1lDciWnjaGdmBH++22yVefHrRztj2VLjaqXsIVKTKTWa5MCrWqYpI1OsWS+sd3zToreqeyc41WeQt7uTWSmx5zWAQ2k9Xtylphsw6GguyjwnN2DBq0dfTBImHJYKIqyQdht/qMv5sx8avGnktnJz45r/Efg4r1gMlAiIQsbiPSszIMwIjMfIj7GW6kzJoNrJ8TkOrCWFLy0n2QUKjxalh4CzukEFfRw4xzIVSRlAF3bSBwn2q+RvG1FnM4wML9HM1860emdQYhb1Q3akMmxDOCEbxMsVgpSNgkfxxO8kX91RvQtuczrWCiJsxSrS+yy3PJ8h3fSSHGtq3RWLKSgoFT+gj+NmIFjNAs/NsYcugPshjFZxldf5p7xBafj4XEWD4AWHHL5a3k5t3aQy+92z2LPYkX87BMt/6dDrnb6daoEHGqlAnfLl6J/UhK4HdSU6erPjDY7N/PS45uQ3bWkvl86gLpNbE9AZX7c3ii6dYznaGimZNL9dRvfgOSFQyaq9sQ8PHXy42wo1YbEwHwDN1gIaZLbE5glpuzOgJVzWPkQYrfoEqtLb50oNKFIwCB8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDQrM1pmOWJqRXhTUkFnVFBDN2gvVjhSQ25lbE95TTdwbFo0Yy9MaXNHdTJv?=
 =?utf-8?B?VE01WkJZWXN6M09uNXdTWlZqZU5rbHYvREVObXBVVUlNZ3V0ekYrSkw3cWVQ?=
 =?utf-8?B?Qk9ybHZxS3VpanFyMWx5Slc4RHZFa3dKOXdYNGVYZXU1dWJHTnNWSXZyY0w1?=
 =?utf-8?B?WVl3bjNKSW5YSnZxSUNjdHp1ZjcrdXM4dW85S3AyTW1XT0hib2lSVG00ejlP?=
 =?utf-8?B?SWNMb2dsTVBDUHhaaHdXWEt6VEFiUFZlMDQzd3hZS2tnSFNBUDBtRGkrdm5J?=
 =?utf-8?B?UjNNTHVESnJEb2h4N1YxY2Q1VGtxRDhBVDIxK0JxMXhjeHFCVTBzNU9DMjQ1?=
 =?utf-8?B?elZMSGtFVEdoOGYya05pQlc5WkRzZ2ptODcyNDVKRENrWHJ6a3h4dVNBMmcv?=
 =?utf-8?B?N0VSV0hTWng5akVPKzNBVTZTTXo5UkQrblE3MVZvUVJFMkFvS0V6NW9HUnl2?=
 =?utf-8?B?MTFaVUxyUjdXWXJMVmlTTVpUU0RhZlNrMTBSZm43aVV6Q090L1hDVjRPZThy?=
 =?utf-8?B?OGtVZnZyTEhrYmJ2TUx2MkpEZXk1cHppZ053K3RuTVgzamFJSlQ1Qyt6OXJO?=
 =?utf-8?B?UGg3TEJMRjkvU1RKdHA4NklyVy8wZS9udHUwL04vaGpPaXVrOWFPNEtjTGM0?=
 =?utf-8?B?bVE2bExlS1ZLc3NRMEI0UmJPQktoVmduajFOL1NlZGU3bkI2VHR5a1ZZdWJk?=
 =?utf-8?B?Z3JGSm44ZVA2WkVDV0k0WUZlV0VleVVEUU1CMGU5bHo0MGJNSWM3SGw4Vy90?=
 =?utf-8?B?azUrN1FhZE96QjVuZlhIOStBMDhoMWY4ZjFlVTQ2WVI3eDBFT3FORHFLUkF4?=
 =?utf-8?B?bjI4QjR2TzZ3dy8rbWpqVmt6T2JZVDlrUHNYT0QzVC9nYTEvdlBXbkpOVGVx?=
 =?utf-8?B?dHVjOGhyK1BaQnR5Zk9iNTZoLzBXaEJtSW1SMnA3c2RRUW0xVW1RanhXczRI?=
 =?utf-8?B?U3RMUG1STkFza1JFSmdiT05OUW9aZ1VkSnZzZTNQZnd1d3RUL2QyL2NKRzla?=
 =?utf-8?B?UGdzcWpEYW45V0llMXRhand5NldnUVpJT2pMWG05SUxqcVBFQ0Fiamwrb21I?=
 =?utf-8?B?VnMrTjJ4WFFybkVrdnViQ1Z3YjV3Y25FQXVpb0pxcGY3L3cxK0hRTFpHSUF6?=
 =?utf-8?B?UmtrUytwU3RkQXJFWGpFUy9oK2ZWL0Q3RFFtakNHT3A4VUpld0ZnejhEREUx?=
 =?utf-8?B?MzJIb3NNWTZSN0xxSVd1bVJ5UE15a0pLV1hwVWJzQ3lSOVlTOFJIUE5OcndL?=
 =?utf-8?B?QzF3OExBYk9nOExNMXUveFZNcStLVHdUU0VBMU9uOVpvSmVQUmUycnRtMWV1?=
 =?utf-8?B?S1pvM2krZWJEd0x5WkxYc0MxYVhxNmJQTVk3WXl6OXRhenhEc2ZWc3BvNE8x?=
 =?utf-8?B?K1B6Zy9JeDgwOURWOS9KVmJDeGpZSWhlZW1PM21DSjA4VHJybHo1YmRBMmxD?=
 =?utf-8?B?S0tabkZXblE4SzZhcUxJUzVMbzJVaklINDM0WXdXMmdGNGpCOSthV0dRMklS?=
 =?utf-8?B?eWduUEJUcEFUWWw3LzB4aGhKSGFKNzhISU12Z2xhUFRqSWZHNUM5dkVZL0hj?=
 =?utf-8?B?L1ZRSDBDN1BQcXA2bndidjFLSFBTMHRHQzYwekw2QU5WQ25LQUl0ZURuZVdO?=
 =?utf-8?B?K1JVZ2oySWV5cmJjakRHR2VuU3F0K0JJamMwcGQvVzBqSzZWL1N6ZEhxclVI?=
 =?utf-8?B?elNNbTBsaW1kNlFVZUxpODhzb3p1YmoveTBJdytDcnM4a1pXN2xVMDNFVGZm?=
 =?utf-8?B?M0pmRTZkQUNnUzRaZHkrckJyZEFpUURPREROTk5zU0lFWG45aS9mNVFROEQ5?=
 =?utf-8?B?YU1FSDRhTXk0Q0o4aUN5eGxFQlRLSXRBdGNLdFRWenpGbURSL1lZd2YwL21T?=
 =?utf-8?B?ME5aa0FSQ3pnQlFnOWtxai81dHhnaVJsUlJxZ1l3YWhZK05PQmx4c25YbTQv?=
 =?utf-8?B?VVlrNVZqRXNjSk5iNzJmelpDVXJMMHVGVG9NbVowaUYvSThDSDNTZ1FKdkl0?=
 =?utf-8?B?dzg1UnEzK0JadW54aHhpMWNzNkhFKytza3hBMU5tNXBZVlRjUmN2UU56VENS?=
 =?utf-8?B?NVNKbkVZVm8rL21uUG1kWkhBdjluZ0J6SHdSeFhscnBXRnhkNXpDbHdhQUZi?=
 =?utf-8?B?S252ajYzeEw2a0VMeHBpNFlXazU0R1pOR0VJTjBOUFdvblFPeG91Y0kzekdY?=
 =?utf-8?B?RnQxSjQ4eVBmQmg3NEdabWRNd1NwZEI0ZnlyVE9XeHF6aWpRbXBlTGR6SUlN?=
 =?utf-8?B?aWpJSkRaQ2hUUkJPSjVBZFJnbXArOGdxcWlNZWExSWFIUTZPck9vMlB0R2p6?=
 =?utf-8?Q?bD4OZLt2PmJeCTRDm0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8bdc37-9912-46f8-8708-08dec2ea2390
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 10:06:41.2999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z7WcwIG58MMqwVtBIgpX++PShwehRTRlbCDI0vyPZ1B8xkDobtQiEgxp2udUDMAw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6146

On 6/5/26 11:48, Wentao Liang wrote:
> In amdgpu_ttm_clear_buffer(), the *fence pointer is initialized with
> a stub fence via dma_fence_get_stub() and may be overwritten with
> job fences in the loop. On the error path (goto err), the last
> reference from *fence is not released, leaking a fence reference.
> 
> The sibling function amdgpu_fill_buffer() properly releases its
> local fence reference on error, confirming this is a missing
> cleanup. Drop the fence reference in the error path to fix the
> leak.

Absolutely clear NAK.

Even in the case of an error the fence must be returned or otherwise we run into random memory corruption.

Regards,
Christian.

> 
> Cc: stable@vger.kernel.org
> Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 3d2e00efc741..d65f1df3574f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2585,6 +2585,8 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
>  	}
>  err:
>  	mutex_unlock(&entity->lock);
> +	dma_fence_put(*fence);
> +	*fence = NULL;
>  
>  	return r;
>  }

