Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011060.outbound.protection.outlook.com [40.93.194.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685BD3905E0;
	Thu,  6 Aug 2026 08:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786003843; cv=fail; b=S+SQ3g1SHhCNrubw0B6Rbtj4kxihTwbAZVuTd0yN5v6kCo5v8QOHhV9SJAFUYo8535FFKJPMqluG78KvDTGF//hUFGlUaIbBcUOUg15gd+m7GC3jW8FpoQpaI5aJSc7HgNHCc+v6VoG86Hs9XeXxsCYracDuOOmz1Z11LInH6vM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786003843; c=relaxed/simple;
	bh=a+x3B3sVV2+Pwn2WTLijwL3fKWGuEwHoOt5mjwzswJE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ji+99ZuuDqVLhMucJ7TuQcIXtLPpgdJBC7T46SoSEDZft7MfnoHx/ODI+8OMaLKIekWMf/EY++T6cbdAH8R5n3wVLo0+fJ3/5naG8jwMvdZdPg4kjIOKs6r31lcrSywebLgkue0RqCC0Y1EwUJ0EfeKmyEFlQBCOTDO4xdupj04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cFMmf0Bu; arc=fail smtp.client-ip=40.93.194.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cFMmf0Bu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z4Isjy7qdWVkiQZQIBCwNJgNspizPWWo07VTy66+gSJm6XNhtgIYFJpBB4IcYxlJGKUZWpyHtnKiCNN4O62zN53EAXKNUGt/YOIqumHSnMFQr78c2ho+tk4AbOZmxZwW+wcuh/XTZLiOcSpyi3NI8sFrwGjgZIPVZKLo769i6zZ07Kliv4gO3Atp+3xtns3WlN2qOT+NmTfdXVDfBwv5xFyub+DRQytF9f1KmzsvUXrggneOeravYj5Pb24RqeHYeqcVYwDq5+NvFSqRZrMbwM4+XSZyXmbg/T3Rc4mYxZTA+id/7JROnVOuNBfEMvFiU4dfgpKMzl1wE8dgAfcmOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HII6nt33jDnvsKrQpGuBfjFMTjQ3TGtKkw/P+mD4sLU=;
 b=EhboiXwLiRZt+ahVfob+2BoTXj30JJFS3wdHuvyZsPUAe4EssULVNPadAhFxWTA65Y54zuplckVkGuNoZr++HyRtmOos11rIJd4axffSaoA6omtKwCPNjFOFwEjcHX2UZoZIffQx74iyj0Vm6arZD4+Zwk1xVi5SP5c4eg8liB0AXHMf2i8Vn3brAyaGHK5EiG+tWi8NC3/Ryiq/qqMHRyWurguR7RVpGcLJVxgNbU90Sk90KsBL+/xrN7JlJz6gnEYaZTRln0/ySohopHVWOJFpphMHl3UVHcHvSBj3BIydhjVgmEZQau4wn+0qA0HtHCCcnB+NEDgL8FJLD57CJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HII6nt33jDnvsKrQpGuBfjFMTjQ3TGtKkw/P+mD4sLU=;
 b=cFMmf0Bu+mn8GS8EtQSlxH7MsYMP2tHh3Ch6/Mmgcps/3qWUjR4iMYGpBmhGt5xp0lYTjQXj3eEWz5at7apMEYGZg4BpoWyc0OsYdXg35co0R8BG70/MLz/cJss5XsUYpZ1P3f2w4IPaDDOBGJKdBbgedBn8YpSy+Bq0rXPzPbXwVlbLsidSoKQX8UCIoXLBweX9epI2RS4msO+I9ftOue4RIeEWIsnRy+2k9/UqWiXwWqkYO8tm9y7rVKs8Xhcwv4r1fJXxbzFnizYVMCY2MDloTZp8cskTKwTdtkfwE4S7BejED/w9feMuZA6AhPFEG3eUcHJhl2tT5XTjWb55aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB5001.namprd12.prod.outlook.com (2603:10b6:610:61::18)
 by CH3PR12MB9023.namprd12.prod.outlook.com (2603:10b6:610:17b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 08:10:33 +0000
Received: from CH2PR12MB5001.namprd12.prod.outlook.com
 ([fe80::89e3:6df0:de90:8dfe]) by CH2PR12MB5001.namprd12.prod.outlook.com
 ([fe80::89e3:6df0:de90:8dfe%3]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 08:10:33 +0000
Message-ID: <0719f8fa-4f71-40ee-8679-5b103c894923@nvidia.com>
Date: Thu, 6 Aug 2026 18:10:20 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] mm/migrate_device: Fix THP splitting of a CPU
 faulted device private folio
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Francois Dugast <francois.dugast@intel.com>, stable@vger.kernel.org
References: <20260805231041.3791771-1-matthew.brost@intel.com>
 <20260805231041.3791771-4-matthew.brost@intel.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20260805231041.3791771-4-matthew.brost@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ME3PR01CA0048.ausprd01.prod.outlook.com
 (2603:10c6:220:f7::23) To CH2PR12MB5001.namprd12.prod.outlook.com
 (2603:10b6:610:61::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB5001:EE_|CH3PR12MB9023:EE_
X-MS-Office365-Filtering-Correlation-Id: 421e81fc-d4ea-4c5f-bc0b-08def3922fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|22082099003|6133799003|56012099006|11063799006|10067099003|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ddpM1d/Ozp5NM0QUt0a3C6Uj7uoqWkn/iNTcReg51mdLS4v+0QY+sp7EF5CH77L2t7Gw01ZoaiDL29glptVskyYe6Vk85zk4FPxFsv7KFNt3ufnuTdpd4sT7knGlpjFbVCmLd8uWeZjDfWHfipcIerlv87/qlTfZMMXb/YUkebm4rLm9CKc7h8iIXR73W6uQpZJIaERCr7eKeF0iwry4ljP1k8/QXy4qWG669b1tgTQqR/9lD86GjONG2IJI6VKkx4bpSf4A00AtfMo9pyHo3WRam5bUqmA3BSViesKPyycEgC8NeaYhsd9w8Z79/4fYP96UEscbIwyBsrfOic/BD0RK/c7psQg1ixDdwDjrU+L3vKQ6w/RH52BbKCOvUGQuEoRQQG6Cv9FkqUqYbvKdBQyYT6Hs70VG//YuqYcwb9I18swYwpi/4oBqEtqutpr7CA9qzR0u/f50Q7b4UnAJBWfIPMaqkpoOM+O0ALHZve+g0ansSQyifLUxzfBixPIDcVaiOw4K53GT65RcSR0E7FBHh+rcCnAnmRWo/emxP/MfXks/EQXSLuZWiV/uZ4AesibKXK0mkoggwF4DupwOOfNVULvtzprdk7d82zAMRIVhCImQ3ISTeWDlSxT8VJM/JMfRSB9fV0cV073P4yeyfPlMBmkIDtwTXFy6brjJQ2g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB5001.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(22082099003)(6133799003)(56012099006)(11063799006)(10067099003)(4143699003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGFOR3kzWWRXZGJ6c3ROSDRsdXhLdHJPT3FuZ3d4UEVhVXQ5VVdJd04yUm82?=
 =?utf-8?B?VDhtcVNoVWMvNlJKT241cHZBNWNHTzB3dFVyUTZkeHJoQU1Kb0NXWEpEdGIr?=
 =?utf-8?B?c2ljS1BHOTVIOFB2RmczV1lGcC96VlJGM2lTVXRoRjgxOHQwbkZrNVpKMjFD?=
 =?utf-8?B?NVpMaWdrdjR5RXFwUEc1NTBocVB3VEFoNkRsc0RCVDhtaXkyd253Ym52SlZy?=
 =?utf-8?B?cFVyMzVlVHlKYndRZlJETVFtR0lMWG1WQjkrVm80WFB6aE1JeW1CMzFrYXhJ?=
 =?utf-8?B?RzdocGU3SWppNGRqVGYwT0NJbzgwSDVWcGhOMTdwN0JDYS80a2FGQTdGOC8w?=
 =?utf-8?B?N0pMM0hDUXhXbVcwSFkxUUlQcTZoNkxIaUIxYXZrcGZDZ3BNdHl3VlNDend6?=
 =?utf-8?B?T3lkWTRiRDlCOFFLaE95TjdyZi9abE95aWhyQ3Vpc2pmZVk4Y1hwZDUyZDVk?=
 =?utf-8?B?UzIwS09YWFJuV0RkbmhCQ09JT251TWlzYm5OdjIvYXRpRUZsOU9FL3lVL3E5?=
 =?utf-8?B?N0l4TTJqZVlCdmczbXVJcktkOUNNRGlnU0ppdzVjOW5yVG1WazJOc0RqWXV4?=
 =?utf-8?B?dUJqRWNEQ240MndERmUwTmkvT2IrYU9scDlVZFQwZ3U0dllrK2JtekZGZmdY?=
 =?utf-8?B?UHpSSUY4L2hxcHdpTTE5eGVoVWpoRFNQanJOOEdoajUvSUc1T1BYN04zaUpq?=
 =?utf-8?B?eWQ5bFUxQmxaOXRaTCtGVzUxK0UvRjlVKzdya21ISlZOeG1BNFNJcjl6cGc5?=
 =?utf-8?B?WEtNV29RQkVSUEhhTGhJMDhFOFZxK0ttL3BZcnB3OFJ1enZheXpCUFZZMlli?=
 =?utf-8?B?YTNZOUNIaWlmalpuaEk1REgxRTVwVDhJaHgrbGFRUzVxbldudjNUTHpiSUdz?=
 =?utf-8?B?SFlrMHd3a3dMSzBnVFhCODNCaWwrd1JRb1BoK0hoY2dpaWQ3YnpDM1NBcUt4?=
 =?utf-8?B?bGI3dUpibFI1Vk45NGhiYWtKQzd2L0xzSGJrcDB0bTdTUmlVSmpHL21QQW5Q?=
 =?utf-8?B?cGdkTWQyelJsSTg4ell3WjlKV0ZacDZiUVl3NDFpTUZ6WUNBSDN5YzVjS3FR?=
 =?utf-8?B?dEtwa1BoaVpuQXhMVFNsM2RnM2NTUGt3ZkdpNW1RbHdubTNPMndOTHREV0lD?=
 =?utf-8?B?MmJhMEpkTDRmNWs4OSsraDVtQjhxM1l6U1Z2a0VwNzdvVnNqRGQ0SXd5ejZ4?=
 =?utf-8?B?WE1aMVpGR01jOXJ5Q0dYOWJQN3R6VUFLRkN5YkxUVEJhUDJnTlNLUG9jamxw?=
 =?utf-8?B?VGVTbytMVXUxWHNuVjJLS3hFOWNSRjg3TmxGaXpqYmJsbC8wZUJTZUtEM1FE?=
 =?utf-8?B?dGF2WVdjTDlmOFZIRE4yUVVUVzNWVXFIbGt3aEtzUU9vMEZRV1NneDJNSGRi?=
 =?utf-8?B?WDZvTDdmUDV2ZTkvWXIvL1B4QWwyWXJ3dzhiU05WU0VLeGFVWTQzNm9jVVJN?=
 =?utf-8?B?V2FrRlVGUVl2NlhEajVHbUdLcm82WmpZZkJZVGFGTWVBUW41a0I0VE9VK1Jw?=
 =?utf-8?B?ZHNTWkJvMTM5YnllOUtYc3ovYnEwclZISnk5Q3hoY2Z5RlNkRi9lY1NJQ0M3?=
 =?utf-8?B?cGptQ0FVb2pjdDJDdDQ4M3k2Mi8raXZjajE1NW9DMStRUVRrVXFFSENBd09V?=
 =?utf-8?B?L3o1aitzVmpUYklGQXo4Sk5YRUFoT2JGbDE1SnkrT3JVOUM2SnRVbmhsVmVv?=
 =?utf-8?B?N0QrMXphVWZrVVVtdEloRmI2azFCdnBFNEZsME1Xc0QwQ1RaZGZDOHdmSDVB?=
 =?utf-8?B?Q1BiaXV3M1ZBZWY4ZjN1SEM0S01QUHNYVWJNMW1mUTFMbURwMm1kOE5FaGFm?=
 =?utf-8?B?WXZGZlZZaWtWK3B4SHNRWXFVMFp4TnRiTVc4QjJLeExTVXNZTVlzNUNVK0hr?=
 =?utf-8?B?UzhmQzg4VThiemE5MmVseWlpN1RLVWFteVlPZjBJN3ZoS3BGZmhIeE9HRnZk?=
 =?utf-8?B?VnUweXdEU1pnUWJuZk11NU9DQ2RHQzBHNnV2QTc5R3Vzb3d1OWdieWYrcFY1?=
 =?utf-8?B?Q2xVRm5wRTBWYkc5THNDNXEzM2N5RGZWSDM3NjVaWUdrSG1LSEhML1Q3c3Ni?=
 =?utf-8?B?S3NZUDNoNDZCNTBsMzhiY0FQSVkwWlI1VEpkRUtMMXBiZ0RQTUViU2hCU0tS?=
 =?utf-8?B?QUNScEgvRGUyS1pmZnZmY3Q3THBMNzZvNnB5bk45cC9laVhBTU1xbm1PcSs4?=
 =?utf-8?B?QzNKTnM4cXR4Zlg5VTBKQWRiOG1nQTNGVUNHWU1jdVQrR3dOb1VRSVRtMkdL?=
 =?utf-8?B?VVJrRk5HWmFxWGEvOXUzZEM0dHhIbHVEWmFYaG5BK3FpOU9QaE9WU1FSVzFJ?=
 =?utf-8?B?OHIzRjBiWE9CTFRCbStwcGpjN1VVMlU0NlBzeGo0aVRoQWh2NUZtZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 421e81fc-d4ea-4c5f-bc0b-08def3922fd3
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB5001.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 08:10:32.9381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHq61zoH+HLyvfJx5bsTvY7TBbJ65bW9Y+GYSaEycY2G4YGwGa2K9ebaecpOuWC3jN0OYK6nH702Q1c/upGfOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9023

On 8/6/26 9:10 AM, Matthew Brost wrote:
> When a CPU faults on a device private PMD and the device driver can only
> allocate order-0 destination folios, __migrate_device_pages() has to
> split the source THP via migrate_vma_split_unmapped_folio(). That path
> is broken in two independent ways when the fault is what triggered the
> migration.
> 
> First, the split never succeeds. At the point folio_split_unmapped() is
> called the folio carries two references beyond the ones it is
> entitled to:
> 
>   1 - taken by do_huge_pmd_device_private() for the duration of the
>       ->migrate_to_ram() callback
>   2 - taken by migrate_vma_collect_huge_pmd() when the folio was
>       collected
> 
> (the mapping reference having been dropped by set_pmd_migration_entry()).
> 
> folio_split_unmapped() requires folio_expected_ref_count(folio) ==
> folio_ref_count(folio) - 1, i.e. it tolerates exactly one caller
> reference. With both of the above held the check sees 2 against an
> expected 0 and returns -EAGAIN, so the migration is abandoned and the
> CPU fault makes no progress.
> 
> The PTE-based split path does not have this problem:
> migrate_vma_split_folio() is called before any collect reference is
> taken and explicitly skips folio_get() for the fault folio, so the fault
> reference is the single caller reference the split expects.
> 
> Fix it by dropping the fault reference across the split and re-taking it
> afterwards. do_huge_pmd_device_private() derives the fault page from the
> PMD entry, so it is always the head page of the folio and always ends up
> in the head folio of an uniform split to order 0; re-taking the
> reference on the folio therefore puts it back exactly where
> do_huge_pmd_device_private() will release it. The folio cannot be freed
> while the reference is dropped because the collect reference is still
> held.
> 
> Second, the folio is split globally but the page tables were demoted
> only locally:
> 
> 	split_huge_pmd_address(migrate->vma, addr, true);
> 	ret = folio_split_unmapped(folio, 0);
> 
> migrate_device_unmap() unmaps via try_to_migrate(folio, 0), deliberately
> without TTU_SPLIT_HUGE_PMD, so every VMA that PMD maps the folio is left
> holding a PMD sized migration entry. A folio that was PMD mapped in more
> than one VMA -- after fork(), for example -- therefore keeps huge
> migration entries in all the other VMAs while only migrate->vma is
> demoted.
> 
> folio_split_unmapped() does not notice: the folio is fully unmapped, so
> it only looks at the refcount and happily splits to order 0. The other
> VMAs are then left pointing a huge PMD at an order-0 folio, and
> migrate_vma_finalize() -> remove_migration_ptes() walks into it:
> 
>   page dumped because: VM_BUG_ON_FOLIO(folio_test_hugetlb(folio) ||
>                                        !folio_test_pmd_mappable(folio))
>   kernel BUG at mm/migrate.c:368!
>   RIP: 0010:remove_migration_pte+0x56a/0x9b0
>   Call Trace:
>    rmap_walk_anon+0xfc/0x260
>    remove_migration_ptes+0x79/0xb0
>    __migrate_device_finalize+0x113/0x290
>    __drm_pagemap_migrate_to_ram+0x278/0x360 [drm_gpusvm_helper]
>    drm_pagemap_migrate_to_ram+0x5c/0x80 [drm_gpusvm_helper]
>    do_huge_pmd_device_private+0x160/0x280
> 
> Without CONFIG_DEBUG_VM the VM_BUG_ON_FOLIO() is compiled out and
> remove_migration_pmd() installs a huge PMD pointing at an order-0 page
> instead, along with add_mm_counter(mm, MM_ANONPAGES, HPAGE_PMD_NR). The
> victim mm then maps 2MB of address space onto a single 4K page, which
> shows up later as bad rss-counter state, leaked page tables and page
> allocator freelist corruption in unrelated processes.
> 
> Note this second problem was latent before the refcount fix above: the
> split always failed, and the failed attempt left migrate->vma demoted,
> so the retried fault took the PTE path, where __folio_split() unmaps
> with TTU_SPLIT_HUGE_PMD and demotes every VMA.
>

The refcount fix to enable migration of PMD's in fault context. IOW, if we need
PMD migration in the context of a CPU fault, then the proposed patch is the
right fix, otherwise we split and migrate and that has no crashes/impact?


> Fix it by walking the rmap and demoting every PMD sized migration entry
> mapping the folio before splitting it. Demote with freeze = false: entry
> creation in __split_huge_pmd_locked() is dispatched on
> pmd_is_migration_entry(), not on freeze, so a migration PMD becomes PTE
> sized migration entries either way, and freeze only controls a trailing
> put_page(). With freeze = false there is no refcount change at all,
> which makes the demotion idempotent across N VMAs.
> 
> rmap_walk_control.anon_lock is deliberately left unset:
> folio_lock_anon_vma_read() depends on folio_mapped(), and the folio is
> already fully unmapped here. This mirrors remove_migration_ptes().
> 
> Finally, refuse the split for a folio that is not anonymous. The rmap
> walk would otherwise reach a file backed VMA, where
> split_huge_pmd_address() zaps the PMD instead of demoting it.
> 
> Fixes: 4265d67e405a ("mm/migrate_device: add THP splitting during migration")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Liam R. Howlett <liam@infradead.org>
> Cc: Nico Pache <nico.pache@linux.dev>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Dev Jain <dev.jain@arm.com>
> Cc: Barry Song <baohua@kernel.org>
> Cc: Lance Yang <lance.yang@linux.dev>
> Cc: Usama Arif <usama.arif@linux.dev>
> Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
> Cc: Rakie Kim <rakie.kim@sk.com>
> Cc: Byungchul Park <byungchul@sk.com>
> Cc: Gregory Price <gourry@gourry.net>
> Cc: Ying Huang <ying.huang@linux.alibaba.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Balbir Singh <balbirs@nvidia.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Francois Dugast <francois.dugast@intel.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org
> Assisted-by: GitHub_Copilot:claude-opus-5
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> ---
>  mm/migrate_device.c | 98 ++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 89 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index ae9027421b80..ae17bd516d24 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -899,22 +899,104 @@ static int migrate_vma_insert_huge_pmd_page(struct migrate_vma *migrate,
>  	return 0;
>  }
>  
> +static bool migrate_vma_split_pmd_one(struct folio *folio,
> +				      struct vm_area_struct *vma,
> +				      unsigned long addr, void *arg)
> +{
> +	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, addr, PVMW_SYNC | PVMW_MIGRATION);
> +
> +	while (page_vma_mapped_walk(&pvmw)) {
> +		if (pvmw.pte)
> +			continue;
> +
> +		addr = pvmw.address;
> +		page_vma_mapped_walk_done(&pvmw);
> +
> +		/*
> +		 * Demote with freeze = false: the PMD already holds a
> +		 * migration entry, so __split_huge_pmd_locked() creates PTE
> +		 * sized migration entries from it and leaves the refcount
> +		 * alone. There is at most one PMD mapping @folio per VMA, so
> +		 * stop the walk here.
> +		 */
> +		split_huge_pmd_address(vma, addr, false);
> +		break;
> +	}
> +
> +	return true;
> +}
> +
> +/*
> + * Demote every PMD sized migration entry that maps @folio to PTE sized ones.
> + *
> + * migrate_device_unmap() unmaps with try_to_migrate(folio, 0), i.e. without
> + * TTU_SPLIT_HUGE_PMD, so a folio that was PMD mapped in several VMAs -- after
> + * fork(), for instance -- ends up with a PMD sized migration entry in every one
> + * of them. folio_split_unmapped() below does not care, it only looks at the
> + * refcount, so splitting the folio without demoting all of those first would
> + * leave the other VMAs pointing a huge PMD at what is now an order-0 folio.
> + * remove_migration_ptes() trips over that in migrate_vma_finalize().
> + */
> +static void migrate_vma_split_pmd_mappings(struct folio *folio)
> +{
> +	struct rmap_walk_control rwc = {
> +		.rmap_one = migrate_vma_split_pmd_one,
> +	};
> +
> +	/*
> +	 * Do not pass .anon_lock: folio_lock_anon_vma_read() requires
> +	 * folio_mapped(), and @folio is already fully unmapped here.
> +	 */
> +	rmap_walk(folio, &rwc);
> +}
> +
>  static int migrate_vma_split_unmapped_folio(struct migrate_vma *migrate,
> -					    unsigned long idx, unsigned long addr,
> +					    unsigned long idx,
>  					    struct folio *folio)
>  {
>  	unsigned long i;
>  	unsigned long pfn;
>  	unsigned long flags;
> +	bool fault_folio;
>  	int ret = 0;
>  
>  	/*
> -	 * take a reference, since split_huge_pmd_address() with freeze = true
> -	 * drops a reference at the end.
> +	 * migrate_vma_split_pmd_mappings() walks the rmap, and
> +	 * split_huge_pmd_address() zaps rather than demotes a PMD in a VMA that
> +	 * is not anonymous. migrate_vma_collect_huge_pmd() does not check the
> +	 * VMA type, so a file THP can reach here; the rest of the migrate_vma()
> +	 * machinery only supports anonymous memory anyway.
>  	 */
> -	folio_get(folio);
> -	split_huge_pmd_address(migrate->vma, addr, true);
> +	if (!folio_test_anon(folio))
> +		return -EINVAL;
> +
> +	/*
> +	 * A CPU fault on a device private PMD holds an extra reference on the
> +	 * folio, taken by do_huge_pmd_device_private(). folio_split_unmapped()
> +	 * only tolerates a single caller reference, so the split would always
> +	 * fail with -EAGAIN while this fault reference is held.
> +	 *
> +	 * do_huge_pmd_device_private() derives the fault page from the PMD
> +	 * entry, so it is always the head page of @folio, and therefore always
> +	 * ends up in the head folio after an uniform split to order 0. Drop
> +	 * the reference across the split and re-take it on the head folio
> +	 * afterwards, leaving the reference exactly where it is expected to be
> +	 * released.
> +	 *
> +	 * The folio cannot go away while the reference is dropped: the
> +	 * reference taken by migrate_vma_collect_huge_pmd() is still held.
> +	 */
> +	fault_folio = migrate->fault_page &&
> +		page_folio(migrate->fault_page) == folio;
> +
> +	migrate_vma_split_pmd_mappings(folio);
> +
> +	if (fault_folio)
> +		folio_put(folio);
>  	ret = folio_split_unmapped(folio, 0);
> +	if (fault_folio)
> +		folio_get(folio);
> +
>  	if (ret)
>  		return ret;
>  	migrate->src[idx] &= ~MIGRATE_PFN_COMPOUND;
> @@ -935,7 +1017,7 @@ static int migrate_vma_insert_huge_pmd_page(struct migrate_vma *migrate,
>  }
>  
>  static int migrate_vma_split_unmapped_folio(struct migrate_vma *migrate,
> -					    unsigned long idx, unsigned long addr,
> +					    unsigned long idx,
>  					    struct folio *folio)
>  {
>  	return 0;
> @@ -1103,7 +1185,6 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>  	struct mmu_notifier_range range;
>  	unsigned long i, j;
>  	bool notified = false;
> -	unsigned long addr;
>  
>  	for (i = 0; i < npages; ) {
>  		struct page *newpage = migrate_pfn_to_page(dst_pfns[i]);
> @@ -1177,8 +1258,7 @@ static void __migrate_device_pages(unsigned long *src_pfns,
>  					goto next;
>  				}
>  				nr = 1 << folio_order(folio);
> -				addr = migrate->start + i * PAGE_SIZE;
> -				if (migrate_vma_split_unmapped_folio(migrate, i, addr, folio)) {
> +				if (migrate_vma_split_unmapped_folio(migrate, i, folio)) {
>  					src_pfns[i] &= ~(MIGRATE_PFN_MIGRATE |
>  							 MIGRATE_PFN_COMPOUND);
>  					goto next;


Reviewed-by: Balbir Singh <balbirs@nvidia.com>

