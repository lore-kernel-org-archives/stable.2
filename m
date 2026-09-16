Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA044EBAED;
	Wed, 16 Sep 2026 11:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789557554; cv=fail; b=Lmx8YR7Xr3DHdJGimhcY07JIeawgflf71ebK7f9jZwdLS2oJaW0b1LFyqRlYLKBMnpIQdNK9z5JG+h7+iRXLwvZIZonDpnsfPZ4cFxZr0nVzMQtYudcKJLuK88OcsHFwujThSHjpUHlCfZl3zJZ66pnS8SxwtsYeEPCFE8mpHqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789557554; c=relaxed/simple;
	bh=mOPhpXEUAUwuY/p+2HEMrZdKQSLUMQtqWyZkFfVMppI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UgxQjmnK3GTXsqJlDSGwv/ElGsKM7fI+WdDC92/uandHtaO/6Ba7+h9p+7spaEUCV4R+rEJ/6yi2MU7WG1hDszE4DJjogQ2i/duyKNttWPJWl336Njqcjz3GONicaaNoR308i9+Nb5Ze5g4mfLWBlITRwtJF/x1NcHNZquVxTXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vzWIHTmU; arc=fail smtp.client-ip=52.101.56.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vzWIHTmU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WA/slzZ7OjC4CwjDZ5tutFO53KY8E3jJ3zhnv6Yrr/uxKD9d1LI5MthqNkgdF1BUtSL3c50lreP+tQ77kplokYo1RThnhWVR6khAQaV6QAMXRGrkgsp/8gJdIypon6OtCrjlmzTYaKJ0CEBP/j0/ptDEqHztMLvSQgHpTgra4uhAODvzlZcCKfwEhI9m+Eol9nro7JJSulthbtb+a7ZR/VE4xLsl0suG5ylnNXFGSacYbhmcVtjzUPF3zEAqzStcBkIcLvUqFYa37MiF2TWhKQwB7qL06c0xa+dS6nSfe2cNj1Mct1vRpKO74xZzjTD4BMuaNg80ZdI2PrtI7Ykbeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24KkJcuLcIDtrYRK/8ReN6ySBnOu0wkjbuD3eGn3dGQ=;
 b=Loz+KXLbQ3Sk3IKASResYO0XVSdzzhwxYWX1hyhD8KRR4t03ctGlI5C+FXA2rAQRgcTuAEC9L44zSBJDXxteNA1dEHcA2shrAXkTPb216qGYvWUX9ppufOCTpC8c1vFfqBFdXGXy7uJ04XNEwdG+tTH83wUdRO362E7lBuzwarJ1m0Cjk26kDtJYlTXOu8SY5anDKIYDfZPGOY78lBo9r7yFC7sL300BXM49Y2e89/0Fz3/GArufK6StZ9sEZjbo3QVpfr3rca9QN4fnD2XUdeY6oQAXumHfUwy/DVQYxR+BFl08RjvTgT/VScqLb/tVPrbcEAALbz7NTNuKyYtw+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24KkJcuLcIDtrYRK/8ReN6ySBnOu0wkjbuD3eGn3dGQ=;
 b=vzWIHTmUyEAUdv+5tG4pqvSsCO8Rc7QjpjixEkHXMhFxqDMW8+B4mc1vLUHDWLOmQFK2DaQc2B8Ozi0A6HGJcG9IU6mtGTZxZWGtM/8C6CSBpEwn/2xphjMflcKWZjAU4d4jwgunuypgyrB2HD1NZm/9HO9woQmy77UFXyh/HPk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS5PPFDF2DDE6CD.namprd12.prod.outlook.com (2603:10b6:f:fc00::665) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 11:18:59 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0428.009; Wed, 16 Sep 2026
 11:18:59 +0000
Message-ID: <931daaa1-5c90-42ea-ad86-20ee22130851@amd.com>
Date: Wed, 16 Sep 2026 16:48:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Fix acpi device leak in
 amdgpu_acpi_enumerate_xcc()
To: Wentao Liang <vulab@iscas.ac.cn>, airlied@gmail.com
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, simona@ffwll.ch, stable@vger.kernel.org
References: <20260916095432.2009976-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260916095432.2009976-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::13) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS5PPFDF2DDE6CD:EE_
X-MS-Office365-Filtering-Correlation-Id: bd18ee14-a02e-4699-ae0a-08df13e44e2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	poKezRqueB36XSp73Vo/aXkrVUEdm9IPYJGIiRa9/fJEDbKz4tkHkgJ6kSEgvQKaDrK1akinzfOxeeFfcY3bdblX0INQpUbeUdMiU57mEL890M3GW/PHtfhBrQuDcoXylsOyV8dgDB3qUk0538fCmrKllZaTAstI+yEcxNC0bLJFQKcgV3yKbOdD5bnpmhYjQUaPEcmugaPW9HRYcbxtOXJ7iQYmk10tpbcbKqjYz0A2x+PcM8N974tYQ18fxlhFINVhvJKVz6tdVrqBf2fTmJrKfzOfyf0rbu/zCXOwUH5vA2RJuAD+T1pSCQxLH8QuOTxqEUXMaR29VH1tAwBgRQSleK5U+FIPu2CwllbuloUnJeL0F9uO3IYzs1qZ9t/DXdqCQnXZgqp1yDLlGln2hqkid+ZI0u+mmUxY9T1KfNgsOoVmJROqzAQP4cEQNcHy/hX8cOzn2b0VKEpJc3DyrvqRWyKZqghUO+fbcYwmFvO8Hxs5hMEiVscZGJ9RlHxt2AlF8eAX4AXuYCe4oFUG9LEzIBdGwQYQyl4YLEyCDXYFt33nvgPUhOY5GCm2izpRZrhu3ohDPB5htANDCTKCRR19wzaYKls76cAlu7xPV1obOVllC9UYgaaqe9E3/bnrfcaOEwcQdJ6lQQEEkvuANmdLsXvKXE0aZucaW9yxKJU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB7091.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEwvNSt5NTltVG9jdmJVTjF6QW9aKzF6clVrNjE4bmhEYVZPcVNCRDBqYlBm?=
 =?utf-8?B?SzQzTExiRzIzUlJGUlYrR2JuaE5pdGoyNEcrajFrVmZQd1RqZjJvRHlxWnpp?=
 =?utf-8?B?ditvQmgxUDFwUlBLeExjcnFaZ0pqdFBPUjc0NXZNWCtzMndHbkY0TUJCQ0JS?=
 =?utf-8?B?aFVmSjAxd3NPZTQ0K0ZwdnN4aE1FMmV0MkVCODNadW9kUVlSMlJhSnJOQUFM?=
 =?utf-8?B?TUZiMHovYTBVWnhUaGNTYXV2Yi9WaDVuaDlkSzVRYWlVcER4V3BvdTBSakZj?=
 =?utf-8?B?SHRUUFRDUnN3ckRkTzFLUTNrS2JHQUlnbzZQYTZWS1JNTmZEbmloa2FTVVNl?=
 =?utf-8?B?MlB1U2pnZjZRc00vSjNCWGRXYVBveWQyYUd4R0Z4Rm1ub2NBMzFVVVpiazYv?=
 =?utf-8?B?cHhsbGpWN3d2WlIvbXRBaTg0VlprNkFXaUo2VDZIclZhOFc5YmRBSmdlYkFF?=
 =?utf-8?B?cGVETkdTZkxnZFp0SnZDSzh5YzVwSUQzSTlvczVFemNHbmlBWkM4ZjNaK3Zk?=
 =?utf-8?B?WExNb3FUTE5rSzEvWDJVQklLaDlucFFnRXlxMjFaY3hjMXl1UHM0ZFc1TGYw?=
 =?utf-8?B?bHJPOXNlWmFtb04rL3I4dnNUNGN3L3NDczZoZFV0SU5YR29WRlVmb3N5SHdt?=
 =?utf-8?B?aEhTN0ZmK3pQKzc2QVZOUW02eThmRjErc2pHVXRkSTRuSGJZaXZSeUhMaXo1?=
 =?utf-8?B?dmVJUGJhNlhESkIxNGRMQnZ4bUpPUnlsVHdlN21sMnlXTnIxYUFlbiszOE96?=
 =?utf-8?B?eFA3UCszTXR4MEZoWHNicndMcnRYT09UME9kU0dxcE82YTlwWHBPbVlUN2R4?=
 =?utf-8?B?NnZtRWJVcWZoY1ArWGp2aVpjQlZuKy82ei9RN3RpL05wcEtVbGRvL1VGd0x4?=
 =?utf-8?B?THlQL05yNEZ2eWJqaFpoYWVGVTVhdHliRExRSkt3ck9yQ0xzTE01ekpHa1NT?=
 =?utf-8?B?TFpYR0xlRGVteGtLbWZWS01uRE1xaUF4NmExcGpwTlp1QWF4TDU3SHVUaUtQ?=
 =?utf-8?B?L3BFYUNwcWlPTi9PbGQxM0N2VFhtemNkSTdxQTVFOGhINnlqMlBLalBZV3A0?=
 =?utf-8?B?U2t2U0ZYbXRzK0htZjlKS2w4VllLWlM3WWhOT1BxWHFhQjI3Nk9jY2YxMjJv?=
 =?utf-8?B?UmU3NWdTNWRxdDBrck8vMjFwUW9pbWpqYlhUNDFJdDdBQkxEdG1RM2U0Unl0?=
 =?utf-8?B?OC9CNGdMWFpRVTJBRUoxdjdDb0hXS2t5NkdsNEwvSjRsVWhkbUlRb04vVGpS?=
 =?utf-8?B?b0lNQWhQdnVRSDVwcFZ0aEJYR3NWL3ljNkh1dmg1d3dreWdyZmdTb3c0dGxi?=
 =?utf-8?B?N0RuNTlEdkRQaG4zMlF1SDBVQSt5WHFlUXJUSDJid0xoN1lTY0dnalplVktZ?=
 =?utf-8?B?MWhBeWhCanh5UHQrcm1FWElQaWdkTThTMHVHVXQ1aitiNUhqUEwwbWdieElN?=
 =?utf-8?B?cDdUUHptdzJ5Zzk4WFlJT2hMbGJVZGkwUTR1QWlOY0M3blYrOFNmc0pTaFdS?=
 =?utf-8?B?eGRseW1rMW9IWUc1cEJycDBLZGlyeVJ5cE83d3lOS0pOV2lHYkt5Y284bnJW?=
 =?utf-8?B?Wk5YcmNwdXZwSmRMd1h4dnpQeHpZS0dIcjBINGNtTkFtbUhTelVYeHFsdFBQ?=
 =?utf-8?B?cy9Tc2pxeWRETExRaGFyRCs2dzB1R2RJQk91NnBUcTk0N2pCa05GWHpybmU2?=
 =?utf-8?B?MElOZC9UYkhUTVI4M0xBdjBFcklEQzdReFFVNmRmTW52NkNFUWlxWkt1Ynp4?=
 =?utf-8?B?SEVnRXJSMkRhdEpEY3ZZa2hvMzZvdjdzK0Z1cXEzODRDR0JteHJwQXoxUTNU?=
 =?utf-8?B?b3A0NjZ1dFJpRlY1ZzJKL21nU0R0amh5d2pRUHdqTFBZVUYzV0hNM1hJMDMz?=
 =?utf-8?B?UjEwMFBuc0I3WWtsa3ZkOXdiUG0vZlpmeC9JdmlhWm9zUlhzeWhMK2VWd25J?=
 =?utf-8?B?bldQb1pScGgzOVEvOEY0eit4alN1UThjSUtTcTZlRTliYUluckVmTnJydFlN?=
 =?utf-8?B?K0ZkL0N1d3h0VjY1SXp0VmVYMHQrakdEMlpkcFdZQXB3dGRZNFdXalFlQTZh?=
 =?utf-8?B?MnRqQ0krMzJ4by9jdHMwRGg3VGZhMDhrZFpKUVltem5PclZEYllzTTRuTENv?=
 =?utf-8?B?ZkdyZXZvR1A4NUF6ekFTOE5uV2ltMFNiQ0hWbC9NOG43RnpHT0hLUnhKc3c4?=
 =?utf-8?B?cXY3Z2lxVUV2SzQwK0VmNHJVQTdOS2dJUTBBVHBTMG5pdDVOWWU2YnJRMjZJ?=
 =?utf-8?B?NFhmT244MW1TZHIyK3JMWVg0TlZadVNJU1lWUGRNbG5mQS8wYjByVXJIRFBj?=
 =?utf-8?Q?M9KJUYZS3V3YdDNfSa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd18ee14-a02e-4699-ae0a-08df13e44e2c
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 11:18:59.6384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGQXaATxcmzDfMW0i3J+7CLdwvp79jqUkTwzuB7rHz0/q+EogXXR5e9LURhnTIz2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFDF2DDE6CD



On 16-Sep-26 3:24 PM, Wentao Liang wrote:
> amdgpu_acpi_enumerate_xcc() looks up each XCC ACPI device with
> acpi_dev_get_first_match_dev(), which takes a reference to the device.
> The reference is dropped with acpi_dev_put() after the XCC info is
> initialized, but if the kzalloc_obj() allocation of the XCC info fails
> the function returns -ENOMEM without releasing the reference, leaking
> the last reference to the ACPI device.
> 
> Drop the ACPI device reference on the allocation failure path before
> returning.
> 
> Fixes: 4d5275ab0b18 ("drm/amdgpu: Add parsing of acpi xcc objects")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> index 516ab9cf88fc..8d3f1f5a141e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> @@ -1167,8 +1167,10 @@ int amdgpu_acpi_enumerate_xcc(void)
>   		}
>   
>   		xcc_info = kzalloc_obj(struct amdgpu_acpi_xcc_info);
> -		if (!xcc_info)
> +		if (!xcc_info) {
> +			acpi_dev_put(acpi_dev);
>   			return -ENOMEM;
> +		}
>   
>   		INIT_LIST_HEAD(&xcc_info->list);
>   		xcc_info->handle = acpi_device_handle(acpi_dev);

