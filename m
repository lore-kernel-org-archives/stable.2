Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011020.outbound.protection.outlook.com [52.101.62.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C60315793;
	Fri,  5 Jun 2026 18:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683012; cv=fail; b=SbXwIWrpzeUm6PdQa2bkoAj4/UQY8XTg+KzQRot45/emjK3NAEPha/ticP9DnkKRGHmXGDo8rE2uD7retzVTCtPxlCzSOQooZ2nKdEb1h8kFTyYilATxtDK5MGmoxFiCPX/5Pf4NtBCElYG282NRzgydO+cqoTk7/HoRe4UHaEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683012; c=relaxed/simple;
	bh=euXEQy41di/WItuiJ8vz5KikZFYxDESjNZVjBIBc9g0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aC6cZ8kSbqsSIl7wK9wPtAknV00YcvEqWHsCfPGdktgUkEFZ8olvuH6E3oMCcj4x7UUKd5+YRokeUXqrVBQMpPFgdoWJF90XJcpghJkn4kRV+SanVCP7aP8nyJITGmTWV6LWy2lBAxSRihNJw6AjRB0nx9ZGqHTxy0PcX7vku9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NwgQICD2; arc=fail smtp.client-ip=52.101.62.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NwgQICD2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIfzuuN3ffNCBTIOTnX7pNE4kZy+ggFiVbs/dgpbODzHaqy+CUEnBs/qUWhrXcKNr54Az64vicDQSmLvJ8MZcqFBGPGnM4aZ+T+sGhSpTYJmBbyG8l9H5dKRxMKDKUoPg7oOjEeP3ZJuKS/ehlcaM4iHic9qdEfUKNQmjWjNV7PJ6gHDpFLrv15/zy+YqRvbQXf8JS4zNfp9UoPfctE6LlrYvlWhkap2b8xPhY2RYqAKRSnQKDlcKx88b4qBORZHugxc/jTIwDLa6/W0jyFCvwcd9xgx2rzBePBbb3bQCKC2oFMRgks95ZW4LRoPinUN6RuswHqxI+dpZuR8hcYa/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBO44R4anweleJCR/BReHPl+9Tqn/W+rxRjv84t9Yt0=;
 b=HjH+MQEzjA4BZ6aBJGzp6k7zty25vGsXsLW3ysoONr6xu5SeRZg9uI+1Ns8HgikQqN59zVJ7Sw8U3C35EkvOWueoUUwOj2k4rUscaBMdreaJvanyiwsWAfnAEBoS+ORb01rkhyfPeTYnDdznKX0Kcj+fHfY6/Iz4a8zaJGIcvzhBuF3+62PJxFL+DHHFHHRmG3GUhfsUgJzvBByme+ZOxI6jaVq7BkbBducYajQyM54jHijKP1U5HCminM6WAx9vOTS/rYY28VahztbynMCj9aC2CM9/fWrXws5aQZ+xSdVu9YX9hDOFV0Tppl004HraokDUp5zr8bXI46NubGvopA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBO44R4anweleJCR/BReHPl+9Tqn/W+rxRjv84t9Yt0=;
 b=NwgQICD2zTNKf4IT7Dcz6j3izje0lfVSUp0muGL71o2lkLhwBXQd8xhKyc+L8sOJPcCPvu71wvzumqMlO8eNW/9i8CKFKKiMYKXTMsAU2NsGc6Z7O2AAX+WzvPTnyWNh5SP7EN0Ssvanvh4PVfw8t8Ck/9dfBfpezmjFIB3n9nb1JBdDiJJ5D59OFOerMPApUnUa0KNNl5IOJiYh2ZJ9Mf2ZQidwWnW2S7MkcdDyohAozsY1L/oVSmCbwjrgC9/0Ns9DygPOYZdWXzlB5Jn45dEKpP+dfaVdIDYgnmy+uN7cigEzS45h/c8t+c7Z5nW0ootoJqfEwVYoYwFQeTJn6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.9; Fri, 5 Jun 2026 18:10:01 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%5]) with mapi id 15.21.0092.007; Fri, 5 Jun 2026
 18:10:01 +0000
From: Zi Yan <ziy@nvidia.com>
To: Alexandra Diupina <adiupina@astralinux.ru>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
 Jinjiang Tu <tujinjiang@huawei.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>,
 Luis Chamberalin <mcgrof@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Michal Hocko <mhocko@kernel.org>, Pankaj Raghav <kernel@pankajraghav.com>
Subject: Re: [PATCH 6.1] mm/memory_hotplug: fix hwpoisoned large folio
 handling in do_migrate_range()
Date: Fri, 05 Jun 2026 14:09:54 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <F08546F3-3CE1-4DEB-B65E-32D3FFEF4256@nvidia.com>
In-Reply-To: <20260605172604.16034-1-adiupina@astralinux.ru>
References: <20260605172604.16034-1-adiupina@astralinux.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR01CA0047.prod.exchangelabs.com (2603:10b6:208:23f::16)
 To DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DS0PR12MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a690f60-62f4-43ab-b9e7-08dec32da8c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	tIKlnqek13x6tw6AbNXhTFMLchsJFp/ysEBLKeJwO6cyZIDJnvC8zmbm1tzOR+B62oH5lPgT3DL0C7FBmnwWOZGrcblusW15GLfibuXyi6waJnLHcoOHB9VhDxkZXo7VCxEAnqJq9YHgnEpQGdF2brg2LcI3akXKbffzwrzi1fUWvb4EdMz9RpeABum4SEozH6zAicSiLXpuIfcle22z0hO9kH+6RQheAYeJ3c8AY3CzqJ4PX0+dhOINwNTAX3ew1OATflL2H2YWiPSEGLWaO+l7Dlb1RaVpRq/SGNSKPf4U9Jbut9zYHIotMSJQrBH4SuMeqAg0XzBkmKh4hFXa4/TDp45RGBadhoxVlJxUgEr5vSXYlknSJ56mfJiPT7xuPOz458co3LfeijEaTPFwqLX1Nz2zZ3TN9xj9BaGieHsVqB2CFma6o3bO847D5qmkDsM55iRo+6u6DOBp24WpLl+dhxEpZRyNLTH2x3/fDVdh4amJdDs6SuB9nBk6pDgtH5Nlv1Xe2/HUc/BtyT76Fjn6jHdNRDp7YiuWmuMsYmrJd4ojEz6c3HNVuU+F3kowItgznReySig3OMo+IVPwLfSgTdao9LtaGt1B6Y9kBFMP1uYZtn6k1ka2WdW04uC0CRvFfOdJpL9bqxP9qhYlIz5SLUilFTsP5lm0Xbv7WREalJJaik/nBoQb9tTzokHQ+dP4QjF1UJKJLuA3qpbsdw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFhCRkhkMnNHbmhXYWdlaG1QakpZQmVVSmgwTVd6aXRmUGk4bHlWejZZUllv?=
 =?utf-8?B?QlBxSHRPbTRJN3FKNzV3aHFybGxXKzBtcjQ1UkZQN3BtRGVyVTdrNlQ0U25v?=
 =?utf-8?B?M0t0Y0kveVU2SFJIT2Ivd3JVNnRMa2FrbHZDc012NlRMSEJKQkRiU1JHUXBJ?=
 =?utf-8?B?VnBoenBuM1A1MURQTWM1OVlQR0YxZmd6SXBvNThRc01IS2lPMmxVTEs4bUxx?=
 =?utf-8?B?Z3NEblQvMFVyb1RlNVJ6R3ZBdVZqVVdQOWVuMGs1R1BjRktOdmdydHJ5UFZ6?=
 =?utf-8?B?aE5RWm5SL0w2cTJYa3A2NU5QSkk4M3BkRVNTZWlrbk5Bb1ZnZzNVeTFZeHFV?=
 =?utf-8?B?WUtkUloyZDBMTHRGem1RU0ovQmlEZDIyamZydWFGSEhvcDgzdEU2MjM0NDdL?=
 =?utf-8?B?NGpwT1hzMlcyTjJJaEk2b1Z3TVduK3QyR1NwS3hnMlhYZnhzY3N4Y1Y3ckFk?=
 =?utf-8?B?TTUvdFNTaTRSWW5vRFNzdkRYUHVZM1A2SC9zY1dLY0tjeXZMa2k5Tm1TOGNa?=
 =?utf-8?B?a1p1aitFNGI3czRBN2lkbmNrbVlYMVB2T0Z5bng3TXlUTjlaU21hd0o5RVlJ?=
 =?utf-8?B?TGl0Wlg1bnEycWdNRCtXcmVaMkZoM2hWMU5KN3RFd25Nci9JM2VYWXA4K1Ax?=
 =?utf-8?B?d0h0MUFhd1FEK0JoNFZ4bko0RjNHYldNNXYwOXBXeDJFMW84aUlaWVdoUkVI?=
 =?utf-8?B?TEs1dEEzVVc2TUtLbVgxYXNqMWhyd1J0M3R5d2NhSnZPL0RqQzhHNjRQbzZI?=
 =?utf-8?B?endrTXdCNGlZMUFZZnFjVnJoN1Q3dStaL20xdy95YUdOZjBHTWhZa0dCL29Z?=
 =?utf-8?B?ZnNrUThLUEppS0pWZU92Y2QzeE5pUmlqWXk2bFJqYXJ2UlE3YU9KRlY1blUv?=
 =?utf-8?B?ellWTjEveXNHdGNNTkFjOFR5OW5VQlY4cEMycnlOeDRwZDZuRlg4Z1JUU1FK?=
 =?utf-8?B?WUkxQmFSNlFveXN4aDR2ZjFsYjZJc1czalJ4S3Zndy8zQnBZZ3F3c0tsVVRJ?=
 =?utf-8?B?NUI5L3ZLK2dkYk8vYzFYOWpGZW5rUWtvVjVyTlMyZG13QkhuQmpmMjZiZGNH?=
 =?utf-8?B?L3pBQmovOTFxNndURjVKQ2VjbW1qOWlhampXRUFsZngwWmlXUnpsLzl6UXV6?=
 =?utf-8?B?TC9wQmlvSXBHQ1diZWRBNm5GRXR3azFHeGRFZUtnSUZVSUZ1M1RWbEl0UDBu?=
 =?utf-8?B?cUR3bDVTOW9ER2JRd1N6YUVzcGlvckxuYkNHbFJha2JYaFdpVmF5QTM5SFB6?=
 =?utf-8?B?a3VYeDZ2Sy9jMy8zSDNkMUFlQjA3bGE3eVVyZVVGdVRiRVNnUkhVL25WOW96?=
 =?utf-8?B?WnRQSXpkayswMGw0bXJvRENZeWpHVG5IK05KOHN5RTM2WllZelFMZm5EZVNS?=
 =?utf-8?B?Wm05ZnNJZmNEaTlKZXlkRVhaOW5Pd3k2YXA3Y256SXZIUWhtSWJiMjZRR0RK?=
 =?utf-8?B?KytFdnpveEpremYrTW1GT3JmRHRYWmJwdGpTQXE2b0JWSTIyT3p0YUhZYitM?=
 =?utf-8?B?V3l3ai9mMmZ1bEZuSm9rVUVsc0ZKbndHQVQrR2FtekdpL2NTNkhPMnMvQk9j?=
 =?utf-8?B?eVNQSTBjb0VzMzBCN1hCQVVTMXNSTzdQZWw4Y0Fxa2RDZ1p4SHpmaEZ1aVVo?=
 =?utf-8?B?Tk55cGYwUU01SE43ak1QQnk5MHg1UkFYUndkSkV3aDNxUlA0RkZ4M3R2YjJx?=
 =?utf-8?B?R0ZuTml1SCs0UllWTERQZGgvbmhHQWZhbFhSQTNwM3VoODZuTlplK3M5S3Jr?=
 =?utf-8?B?UWY4QjZsbEJXQlFFcGxwU3dZL3V2RC81VDNIWEUvN01IcERIZGpuangxQ3Bt?=
 =?utf-8?B?V0t6T0ltaVJHWmxMU2FIcFd4cGtQdXJIUWZsQlVrZUFiSDhlTDlUWm5iQWky?=
 =?utf-8?B?Z2hUS1V0OXRoR1FvcGpzelF3Y0R0aU5FR3FqaTNEcEJKQnBNdEM2cmpsRTMx?=
 =?utf-8?B?ZzBQNDFMV29xZWNCSXN0Ujlxa2o3cjFaeElFdlp6NGZQSDRxc2dYblRPeXZm?=
 =?utf-8?B?Y01tMWQzUldRRDhsdU1yOGRJSmFtQjRjQzl6WFY0bUpqNGQyNHl6VHV2MlVU?=
 =?utf-8?B?MCtwWUhvSE5WYmZLbFFMNXRacVZndVBXZk96WmpIQ3pPdGJoY2hVc2J5WEVX?=
 =?utf-8?B?bFM4YWExWVlRYVpJTVJBMXBEUFZKeGpIVGhXUlZTU24xaTUrb3dnY1NhZzZN?=
 =?utf-8?B?L3Fvajc3UFRCNkJMZHl5cEJHUWVQZTRsb1grNVhuUWNkRDFYcHBNaHN5dzc5?=
 =?utf-8?B?dit6dVR1Z2RrWTBZTmZNR0ZRR0hFZ2Rhc0tnZkxrU3hNMXArRTNjd3gyZTU2?=
 =?utf-8?Q?KsslO0YbvrhnDtNlsG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a690f60-62f4-43ab-b9e7-08dec32da8c8
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 18:10:01.4780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9k89EKsYAi9QQqXoIkjDSGnLh0mvzQtqDWf3x/pKvOJEbnZSQQPW+LIw274sM9mo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6440

On 5 Jun 2026, at 13:26, Alexandra Diupina wrote:

> From: Jinjiang Tu <tujinjiang@huawei.com>
>
> commit 397f6d14f9c370e4910e6885294c340f39dedbf5 upstream.
>
> In do_migrate_range(), the hwpoisoned folio may be large folio, which
> can't be handled by unmap_poisoned_folio().
>
> I can reproduce this issue in qemu after adding delay in memory_failure()
>
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> Workqueue: kacpi_hotplug acpi_hotplug_work_fn
> RIP: 0010:try_to_unmap_one+0x16a/0xfc0
>   <TASK>
>   rmap_walk_anon+0xda/0x1f0
>   try_to_unmap+0x78/0x80
>   ? __pfx_try_to_unmap_one+0x10/0x10
>   ? __pfx_folio_not_mapped+0x10/0x10
>   ? __pfx_folio_lock_anon_vma_read+0x10/0x10
>   unmap_poisoned_folio+0x60/0x140
>   do_migrate_range+0x4d1/0x600
>   ? slab_memory_callback+0x6a/0x190
>   ? notifier_call_chain+0x56/0xb0
>   offline_pages+0x3e6/0x460
>   memory_subsys_offline+0x130/0x1f0
>   device_offline+0xba/0x110
>   acpi_bus_offline+0xb7/0x130
>   acpi_scan_hot_remove+0x77/0x290
>   acpi_device_hotplug+0x1e0/0x240
>   acpi_hotplug_work_fn+0x1a/0x30
>   process_one_work+0x186/0x340
>
> Besides, do_migrate_range() may be called between memory_failure set
> hwpoison flag and isolate the folio from lru, so remove WARN_ON(). In oth=
er
> places, unmap_poisoned_folio() is called when the folio is isolated, obey
> it in do_migrate_range() too.
>
> [david@redhat.com: don't abort offlining, fixed typo, add comment]
> Link: https://lkml.kernel.org/r/3c214dff-9649-4015-840f-10de0e03ebe4@redh=
at.com
> Fixes: b15c87263a69 ("hwpoison, memory_hotplug: allow hwpoisoned pages to=
 be offlined")
> Signed-off-by: Jinjiang Tu <tujinjiang@huawei.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> Cc: Luis Chamberalin <mcgrof@kernel.org>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Pankaj Raghav <kernel@pankajraghav.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> [ Alexandra: replace continue with put_folio label ]
> Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
> ---
>  mm/memory_hotplug.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index c8cc2f63c3ea..013db41f6ce2 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1654,15 +1654,21 @@ do_migrate_range(unsigned long start_pfn, unsigne=
d long end_pfn)
>  		 * the unmap as the catch all safety net).
>  		 */
>  		if (PageHWPoison(page)) {
> -			if (WARN_ON(folio_test_lru(folio)))
> -				folio_isolate_lru(folio);
> +			/*
> +			 * unmap_poisoned_folio() cannot handle large folios
> +			 * in all cases yet.
> +			 */
> +			if (folio_test_large(folio) && !folio_test_hugetlb(folio))
> +				goto put_folio;
> +			if (folio_test_lru(folio) && !folio_isolate_lru(folio))
> +				goto put_folio;
>  			if (folio_mapped(folio)) {
>  				folio_lock(folio);
>  				try_to_unmap(folio, TTU_IGNORE_MLOCK);
>  				folio_unlock(folio);
>  			}
>
> -			continue;
> +			goto put_folio;
>  		}
>
>  		if (!get_page_unless_zero(page))
> @@ -1687,6 +1693,7 @@ do_migrate_range(unsigned long start_pfn, unsigned =
long end_pfn)
>  				dump_page(page, "isolation failed");
>  			}
>  		}
> +put_folio:
>  		put_page(page);
>  	}
>  	if (!list_empty(&source)) {
> --=20
> 2.30.2

I am not sure this is right.

The original patch uses put_folio, because folio_try_get() is called
before this if block. But for 6.1, get_page_unless_zero() is called
after this if block, so the page in this if block has no elevated
refcount compared to the original patch context. You might want to
replace =E2=80=9Cgoto put_folio=E2=80=9D with =E2=80=9Ccontinue=E2=80=9D in=
 the original patch instead.

Best Regards,
Yan, Zi
