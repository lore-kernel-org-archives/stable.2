Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012018.outbound.protection.outlook.com [40.107.200.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D168044AB6C;
	Mon, 14 Sep 2026 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789409106; cv=fail; b=sDsa82Z5VpL9xZWtRrIp8fpFVZbn9GlGQ37F7PyU7iG9JrdaA21QRahl5i8G8LSMEcz2MCPXu4znyUHHGGa3i3XewQujeqz+Jc5u5M405Ctcts2bKUakkD3NIEGkIkgfW5B0nlAkt7CRxzAe0Ltz+b10DRrhcMh2zdBycSp8hsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789409106; c=relaxed/simple;
	bh=cLkk2Acss6thriHcuHWnadLEzRi9p8Q/Y4X04nz00IY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QZNUVUowVbIMF89gW9rPHt1mF8gEf7ofovlrPtb3E4vIKc3JKc/SGuSNW7JkQ7OegYPxQwMaEDiaeDociIhJMx9M8tzcXlnXFVmvNKdHqVEudzCbzneG7V9GLQ6J34kIrifs2qRpaXKBd3vnN16xdjPmZMdNYzCZ5AeThUHLrDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rJ5ouBSI; arc=fail smtp.client-ip=40.107.200.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rJ5ouBSI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uChoOnJOxwO3gjnPjl3uOJPDnS8HAZGDzFAum5Y4gvaFH7vm1z1DdT7sfZwENuwbC+Gwzxs0kSgFOdig2ntdWUmirvZdK5hjQKVD3su5snqO14aaiqVRUeBglfi6Dcp4zMxjsHDUALRV/rzbF3VtBHtXjZmiYLVHWqZLY5OjcBuOS8ajDg4XqvGWFMFTZDm7U1nLtp6Kty/hmwXj1/EQWNEi1WHRSxsdbu/sfd7ZZ27ABJL5oKTo8jJyLQYRi9PLUNfk63kwkYuFEAicEZq9Hl4IawisxN0pb7BsFHmFDhiZOsSSZxFPtW9iotlsBaFj03S9NC/Wqyb7/w//TtM5SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4h7rafOmRPUxLqkjodLRK20qDKV8ULQrrO+q7GrKEk=;
 b=Ro6fR59D6e86lKyqRBQ4Gm24KtuBf4uGvekKPjqnPy4wralol6NgOvawpJSqf5XI18SrTS3KoSuHsN4y5ynS/IRVMcAnXkCsa0cDp6eSRnyZUX6+EI/YCccs7rurC2JT5k6IdS5rTi9yMAlW609fskpy/BhDiPEbaPpKGk6BUSJb0PL6a5gzsZxn139ixxGCx0C1yqjWgFuNgKfd+Ocd6VRE4o0zg42+uIEHjRWVUW7W7WLE1wPNQb4s4hPJ1eU32ItahSVU8t+lURWjJkvX1h+TP7Nua/6Mdn1XqmkBWjy8WVg7yQr3pc4GzIkan0OVfbffUA9NJCm5zb/bcWJYlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4h7rafOmRPUxLqkjodLRK20qDKV8ULQrrO+q7GrKEk=;
 b=rJ5ouBSIc6xOMTAWqCC0edT2Nx9KyUGm5e5m+zQiZoGt2AFPxlelEscvevqhvGtZmbPrSbL9tUMZY+p0awKVJhOe6JUHwFlRP36wmoS8+zOH0Ng55X7woHlN1whodp7kQWYQurIMNwsVQp1///Q/4nc+HCNe/maL4JjX9tP4oVI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB7036.namprd12.prod.outlook.com (2603:10b6:a03:483::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Mon, 14 Sep
 2026 18:04:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0406.005; Mon, 14 Sep 2026
 18:04:51 +0000
Message-ID: <47b7f1e6-0c14-42c1-8224-d5d86cc08159@amd.com>
Date: Mon, 14 Sep 2026 20:04:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/amdgpu: keep freed VM mappings on clear failure
To: oushinnyo <oushinnyo@163.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Harish.Kasiviswanathan@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260905023151.90699-1-oushinnyo@163.com>
 <c0f0b76b-fc3d-4473-83d7-ad820efcbbbc@amd.com>
 <3efdfbf9.7999.1a09efb9469.Coremail.oushinnyo@163.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <3efdfbf9.7999.1a09efb9469.Coremail.oushinnyo@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 04bf739b-9365-4b9b-6c5c-08df128aac62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|18002099003|10067099003|11063799006|22082099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	lMi3iX93LAaJ4ydQCO5iiEQbrxoumDCljeNcXjhv++p1zMHj9+d18MZ7HNGq+hopROpV7Skkbrtvv03b6fau5tOuKjPsvGyD98S6FGlFGuFdTGrRdcUz8DT1yIqxd76hIw/sd9l0yj53ws9WcdKiUrF2BhhbHgEj6qXp8t78DcY2rz+/UBWgoFM4ho2AOyCPoA/GXX9X8sRwvW+gylAmuZne06+k8rW0hn2nae1Nv2PSsw+xfPUbaX3jgVOnH47DWLB+5oEkdycrOMmiqJs5IEjW6CAJuGa1fDdNdWsICowCoufyLddcTHoT77t2imdRQDHLHibqof3k3PMktJMFmUHwlPzegogBZzfO804CXKFjBDmDMBcKAW9k+14xO/thOSQnRWCZY2bMtYYxCQ3lnJweIvyGjcu0eHI1v6Q+itReRT+NKMhe9QC0f2qogvKs459BS3Jacm4AXNJKxuOkdrh5KWmDWIE65a5/mYyG7bXDyS3caxMpYUxKO9hrx2WjzLjY/Tkz1GPaW4PQVlPJoB3nxKUcHdJeaaXFmZ4deZ6p1VmqXZT9+qPkoP0ak71/5Z2AeR5JfhYSBNsKRb8oPL225SBcGTTFSe3Zb5xpG59jFEdB6dSdClHVP4ZIWj/WDscrMdUXA6sGXNSAJ49xYS7Pi4T24qplfAn3ARvjcpI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(10067099003)(11063799006)(22082099003)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TE1ZK1FKdzQyWWNHcGl0U0Y2akZkM1ZKbXI3ZHNrSVZINEpDODRVTTdMemVk?=
 =?utf-8?B?YkJhTm1LOFRIMUViRlBDY2NSY0tsWmZpSmx4VjJBK3NxUGh2NkpWb1pJUUMv?=
 =?utf-8?B?eDdORE0vNmlpWFI1VkpacmRrZGVLZGE1TCtFRUI1WGpWNjFZY2FQcXg0SkFY?=
 =?utf-8?B?VWVBRHh5dzFDNzRMcjZlaDlkWDc1MG1HbHFyRDFUTFlJZWtzUGs5MklCQkgw?=
 =?utf-8?B?Uzg5VkdoUDhOa0hOUG9CWUQ3OTBhZEo4eVhXMzlHK0dDYVlWVXdIaXRBckFN?=
 =?utf-8?B?dHFiZTdUd1BVbXJwY29CdktsZGxBMG1EVHV6NTgwQlFKSG5NUElBV0p1MkM2?=
 =?utf-8?B?YmFCaUsxSVo5emo0TDdUM1BpR1o5ODhjUWZobzNJYzdMNk1yZ1lMcGpnUUkz?=
 =?utf-8?B?YmZjRnU1azRPelpHcGJTd04xWnBDa284MUR1RW0vNVJiR2xQeWZ5eTNRR2lt?=
 =?utf-8?B?akQ2TlBUSDM5TjI2UlpEaUhVVWU1Q2lteng0cUtsRmJkMkJabkNDdzhBYThw?=
 =?utf-8?B?WFM0M21SbTVxK0wrWXpiN0Y0bXU2eldFK1VaaEZxRlJjbmtKSmFJaWRIalBS?=
 =?utf-8?B?Y0VIOWlQTUZpeElBREZGOUJQK25mY2RETnNSZGlFM3J0NzBVOG5pZ1VCcmRT?=
 =?utf-8?B?NlJ5UUtxYlR3VENxczduK3RLYUtGaHNYS0tZWWx0azBzbG4vaEpMWmlsU1pO?=
 =?utf-8?B?anZNenVFdXVNa3VNUzBIUnFFM3hQUE9wV1g3NlVSTzh3akloLzNQSEZnUjIv?=
 =?utf-8?B?QTY5R2JXVmJ0dlc2K1JCb1J2ZDVDamQvcjdjbzdheERyK29XNTgvaUhsdzlP?=
 =?utf-8?B?WC8vaHFQQjk1NjN0ZEVPZ1JJRXNTcWU0bk13dTZ6OXdIY3lzNkNSR0txMHlW?=
 =?utf-8?B?a1FqYlJhaTZCdHZPTEJLMTBpY2xKZjdLcm5UbzJFcGhXU1AwVTdYb25GaU1N?=
 =?utf-8?B?d3BCN3k2d1V5UU9uVGYrWVRGMEdMMWlHdlhnSjRIUzNhMCttWi9abFBvQ2JN?=
 =?utf-8?B?aWJFMURpMVV1VXVjS2NhVEVLWjdscVd1SFZzZnJiWTRyZmUwaEhzVjdZOE10?=
 =?utf-8?B?K3gwejBRTUFlTEt2by95MzVEZ0JqTGpkWkR5dnNTL3F4cnE3dWJwTW8wUjE3?=
 =?utf-8?B?WW5wNzRMUUx4MDI2SWJucGk1eFI2b2tiRG5qRDVkMkpKYW9sN0ZJYU13UFNu?=
 =?utf-8?B?bThWYzhqa2pkTjE5bG9hNitzYXRKVXpveFVVTHpaRnAvRkFYaXlWWjh1NlJE?=
 =?utf-8?B?TWZJUXRwMXlNbGE5aFB4RXNPOUhQdnVieW9tN29ZU2VEV3JXUlZibHdkeDMr?=
 =?utf-8?B?d3B1azJHM2QvWHI2aDd0ZXZVZ09YK0h2UHY1eDJYT05NNFVwNTJBS2tDczUx?=
 =?utf-8?B?ZHc5Zy95eHVDYU52dXVsamFObzVqMzJzM0UzOW9ZVXRwWThXQnpGKzlLc05n?=
 =?utf-8?B?Nk1Dc09mRmh3N2RXKzV1VGxxQXNlM0FVUi9oSThxdzhON2RDMUlTS0FCZW1M?=
 =?utf-8?B?RndXUmZMcjcvSHl6VmtMcWVOWURyUlU3TDBKSDQyUEJ3c0JzNmRpb01WdUpk?=
 =?utf-8?B?ZkY2cDVQYjNmUGVvczl1NzUyNiszSkZBNGxjZzhGZDlOdzhxbGR5eCtqZFJ5?=
 =?utf-8?B?eWYyTVJLV0tQdlhWSS9FLzdhWHlpWTNpMjRyN3dlTWVyN21oeXVyZUZHbmg5?=
 =?utf-8?B?aFFaS1Z2dlVnK01XejJwMVNZNlZnNXhqWk9MT0lrcnVzVzIvblFOWFVYQkpk?=
 =?utf-8?B?Wjk5YW1vTVVkWXp1Y25hc3JybXYwSHFBeHcxUDUxOU5MQjRiYmROTnJOSjhU?=
 =?utf-8?B?RGJDTHVVMzlpM0R3V1BxY1Q0ODZsOERPZlp3a3V4dGFZL2dmbENkR2xvVHFU?=
 =?utf-8?B?cE5MTDd4dDRMOHZvb3J6WU1ybmIwenVjN2thY0R4a0NvbXp4dDBkTXI1Wm5F?=
 =?utf-8?B?dDB2WXc1dW0rdDlMVEtDOVgyNUlRRnB4S0ZkR0NMNkplKzdUWGlPYmpLa1Q1?=
 =?utf-8?B?TnRnRUNjb3poVFQwYVlnenQ0alZpN0J2dEdWeU9RSVdRQlI1R3p5MksrUzd5?=
 =?utf-8?B?N0R2SVA5TGV5Q2dsL0tWU3dsMTRLSVdNZ0M0cy9iZlU3djQ2RS8vYmhuRllx?=
 =?utf-8?B?VWc2SWNIa0YxcGFMRlBoRE96RTd4SmUwUzN2VmQzZXI2K1VoNDF1UktzSjNl?=
 =?utf-8?B?SWcrdklSYTJDY0NjTU9WZVlGaXNzVXpVVGNnRzd3c3NrZTJRK0lmeGNMalpS?=
 =?utf-8?B?OVk4a0VJZVJYc3A3RHJnZXZLdFVCYWc0NmFWcVZ4bXZRNVptUzFzRm10Qita?=
 =?utf-8?Q?sdTfKs1nz3sDj2dfXH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04bf739b-9365-4b9b-6c5c-08df128aac62
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:04:51.8619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IHcPMxMyCB7UDDIa9LQSJ45BwwZGjS+oC9n15XXvnjP5/ZV1v91RUzyL5V7Zgb/G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7036

Hi oushinnyo,

On 9/14/26 17:00, oushinnyo wrote:
>   Hi Christian,
> 
>   thanks for the review. I understand that re-adding the mapping to
>   vm->freed is not a valid approach, so I will drop this patch.

Keeping the freed mappings on the list is actually ok when the updated fails.

The problem is that we then need to revert all other changes to housekeeping structures as well to still have a consistent picture and I don't think that this would be easily possible.

> 
>   The failure path I had in mind was the interruptible CPU update wait in
>   amdgpu_vm_cpu_prepare():
> 
>     amdgpu_sync_wait(sync, true)
>       -> dma_fence_wait(fence, true)

Mhm that wait should probably not be interruptible, but it is extremely unlikely that this actually matters. The wait is there just in case.

The only thing which can potentially go wrong is that the device was hot plugged and in that case it doesn't matter any more what we do with the page tables.

Regards,
Christian.

> 
>   I do not have a minimal reproducer yet. I will investigate the actual
>   call path further before proposing another change.
> 
>   Regards,
>   oushinnyo
> 
> At 2026-09-07 20:04:16, "Christian König" <christian.koenig@amd.com> wrote:
>>On 9/5/26 04:31, oushinnyo wrote:
>>> amdgpu_vm_clear_freed() removes a mapping from vm->freed before
>>> clearing its page table entries. If amdgpu_vm_update_range() fails,
>>> the mapping is currently freed even though the PTE update might not
>>> have completed.
>>>
>>> This is particularly problematic with CPU VM updates. Waiting for an
>>> earlier submission is interruptible, so a signal can abort the wait
>>> before any PTE is cleared. The old mapping then exists neither in the
>>> VA tree nor on the freed list, allowing a later VM update to reuse the
>>> virtual address while an earlier submission still references it.
>>
>>That would be indeed problematic, where exactly do you see that? Do you have a test case for this?
>>> Put the mapping back on vm->freed on every update error. This keeps the
>>> pending clear operation alive and makes later VM updates retry it before
>>> installing new PTEs. It also covers partial CPU or SDMA updates
>>> conservatively.
>>
>>Clear NAK to that approach.
>>
>>Freed up areas of the page tables must be cleared when that function is called or otherwise we run into tons of problems reverting previous changes to the housekeeping structures.
>>
>>The only valid reason this function can fail is because the device is hot removed and in that case it doesn't matter any more what we do here.
>>
>>Regards,
>>Christian.
>>
>>> 
>>> Fixes: b4d42511b7f2 ("drm/amdgpu: Support page table update via CPU")
>>> Cc: stable@vger.kernel.org
>>> Assisted-by: Codex:gpt-5
>>> Signed-off-by: oushinnyo <oushinnyo@163.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>> 
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> index 47cde5459469..e20905d2d90c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>>> @@ -1606,11 +1606,12 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>>>                 r = amdgpu_vm_update_range(adev, vm, false, false, true, false,
>>>                                            &sync, mapping->start, mapping->last,
>>>                                            0, 0, 0, NULL, NULL, &f);
>>> -               amdgpu_vm_free_mapping(adev, vm, mapping, f);
>>>                 if (r) {
>>> +                       list_add(&mapping->list, &vm->freed);
>>>                         dma_fence_put(f);
>>>                         goto error_free;
>>>                 }
>>> +               amdgpu_vm_free_mapping(adev, vm, mapping, f);
>>>         }
>>> 
>>>         if (fence && f) {
>>> --
>>> 2.25.1
>>> 
> 

