Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011028.outbound.protection.outlook.com [52.101.62.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA713C199C;
	Wed, 19 Aug 2026 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787153496; cv=fail; b=ViW10vkFRm5maf6Fenp9WZN9kRRHP630CFwUOnCK1V6ASR3jeva9wGeOBdlvdsP7owk/j/lQHFvemt9+k9DR3X3gXMUs/BUa2SaO+JoGxNUp0qxnqHiuOmIwRb4xYsgSWQrU7Ia+q6PnM7URKCUiT2rxVbfTW3BqIs9cnGzA7Bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787153496; c=relaxed/simple;
	bh=6TqdZ49AKHHDxTiP3cKk+MpaoF5fEa43QYf1gDeEKmU=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=Ebp+pIRZPdzpSpnUt+kSHKD7BeB6PiHeMS0Rq7WgWKaUsyajbDZs0uQyz+5Vq2rWZHfojhZYdaPxSPgZsA9ik6rgiO4ubcj1D/P+dD98KUoFvYyqX0sFKotfVtv9bDErXB5IWNg1c+0+bu+lOpEIylZVvlXPzK3zlbP3HL3Zffs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jOJkhznB; arc=fail smtp.client-ip=52.101.62.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jOJkhznB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wlLwtLd2SwZyzuicfVypHk+05DHB0m29v4LWCFAsuUq56LTv6yyneLGp50Dtbwf219ysCwg61R90kYDyvXkkxHT43IpZCFjfYQ3FMSVUeZPKDtIaALcJR3Z8jwD/7FHJ09Ajd7W3K7INmbN8MY2++9Z30KFGo1+ktFZ3XMpsroXO0t266iGsF2rGJw4K2SFJubdBH5vQnDZZLHE0Jey9nlPAtY2XAiGPPqv2azpxOs2vTFhaSnHPT9S8FuokSjQ/x1pnfi6zeS7ipFsRGlkPJz9ICWuIp2zFNWKsqu0cLtMHkkUTAjJdXUkZAGjkOFW2DeQb8+vObgh5Z7ZXWQ8dsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m74dhNLkX0vhzAuGzX8zPqBVFdDLAsIXHKAEJkxZN+c=;
 b=h9IxR02niIdxF505zKgBa//BNd/Sk/g/vD7WXn1aIU9cBgLZRVDoErbQFzUN2tuoPikOl3fbN6na6LEX2RMBDo19dVqFC4WjRrL0o8D55M+zkaFT/Oqs//ynbeeVrOZmu2K03y8CWVtK/5t6IvIst2y7x1+LAQdGL4fgVlZTkeURMae6KDC2tG6xx7uhpcu24MqUM4VHyr48ZiyboF4msOZEYL0k3XRct1N8cKEDwrU7DfMpkwcMvwa+nKZF16VnRTSrwgCSxnQpkWI2Vv4wb6+RhwKJSjKreQrGVcrCkQF3Q04IbS2xNDR8MbtgLSs4SUqCShZGd/QpVJGyDUz65w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m74dhNLkX0vhzAuGzX8zPqBVFdDLAsIXHKAEJkxZN+c=;
 b=jOJkhznBwhXMvHDBzQLoeICfShLMz3uBCCntK0OPECPWMV5rCWXWd1usCY1CRSv9dm7pTFpIjR5U40DzTVg80BohB2GzGDz1WHY8Y5/VUZOdjO/cJA0ACvVZTZJNCuiDhwZGACjDwglu7Gk8KvPRFIAAWSZ7y3wF9srCRe65n2tqV1WHooV811Ud71C7d3jZsl75mwGh9ErOUhHxha584o7yC9nosM7KVRfmSbAu5kVMD6CZrHOGcr68xUrVMSEJv0HEMunt4sz5+gbUepiIm9vC9m/qTL1CVa4BrLiFOTbQHOG58DIEMUDWV8qi8CLZ6ylNRbI4uHMk2MXasRzcgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by BL3PR12MB6522.namprd12.prod.outlook.com (2603:10b6:208:3be::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 15:31:29 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 15:31:28 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Aug 2026 11:31:27 -0400
Message-Id: <DKT11E3OTU4J.1CJOE60Z2XSNM@nvidia.com>
Subject: Re: [PATCH] mm/huge_memory: transfer the pmd dirty bit to the folio
 on zap
Cc: <stable@vger.kernel.org>
To: "Usama Arif" <usama.arif@linux.dev>, "Andrew Morton"
 <akpm@linux-foundation.org>, <baohua@kernel.org>,
 <baolin.wang@linux.alibaba.com>, <david@kernel.org>, <dev.jain@arm.com>,
 <lance.yang@linux.dev>, <liam@infradead.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <ljs@kernel.org>,
 <nico.pache@linux.dev>, <ryan.roberts@arm.com>, <kas@kernel.org>,
 <nphamcs@gmail.com>, <hannes@cmpxchg.org>, <riel@surriel.com>,
 <shakeel.butt@linux.dev>, <kernel-team@meta.com>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.21.0
References: <20260819101222.3732660-1-usama.arif@linux.dev>
In-Reply-To: <20260819101222.3732660-1-usama.arif@linux.dev>
X-ClientProxiedBy: BN9PR03CA0359.namprd03.prod.outlook.com
 (2603:10b6:408:f6::34) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|BL3PR12MB6522:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f584ee-4b14-462a-ea07-08defe06f039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|921020|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qfSJAKR5wfws3/anbI5HpnOY54BPZHUvTchuOJLr84aFhDUkLnRhD7kSCOBXeqT/KyHzhq2k/SfPzXAvLEtIhfEMoRYJagcGt9fWdo2HnaAKLHmz3sy4L7PiT2KOKXy59DxZZVytIAeqEu2HloNVm7Jy8bTgOA4sQx/+haQcapzOHsyaouXMpfeX5+NnvKcOOLPGySRkwEe3APbXj1VSZCp4AmKQdv9miwG3LUAPkU+oK1Bg8SxpNSOyDxho9XcRWV3BLVCO9NixlA+9PtTlp5Nfx30aRz2NbbHwUPIPqrqY77QLt1g8u0J6FmedCp4dzuxndRDCiuze7kagIQPSGewkbbVVRAiVoDjrvxgw9zVTguEFRvDxri87WvMpnDFF7Ckk6FUNiJAcTqpNkVzLqzi6vFivuDE+Mai6UXXOyJHhxVcZ3g3kK6OT37usdfMVWJz/uO15Nx0n8oQk0GG23AeObSJgZYg9/ZC/+ZHES8P9vS5eNOnA7PL/r6jHm+4XVjZjAFnIctErf4A/f/xLIiigL4OijDUm2r6IbR5tiyoAZNc9unFT6X4N6Fq/Bs3d3EolM3ZAr8NILVttqI/7s0UibywCapuFwnForDQZXAv9fKcp/j6OR4K+/aI0HeqHv6diRO44hE7bK3q5XUthGWhVJScY1Ai8vVOpGDS9LTYmxy//IuRfaoW4+i1P3PGwNsypLgIvaiLUJFAZEgQobQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(921020)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmFkZGVBMGE3VEwwQjFvWFJCa0tvWVlOV1dEMjl6Rk1RSzJCeW5NNkJJSitQ?=
 =?utf-8?B?NUdiY0RUUXhabEduOEFUUTJKZ1RybFNSYnNSbDlZRkFTVGIwNmI5UHNrZmgw?=
 =?utf-8?B?c0lXZGxWV0czb1FOYXhEY0NWSlNBMHJISXlnaHdUajk4eE5BS1krNk9kY0Jv?=
 =?utf-8?B?WEIrQlZZN1Z3YjRCalNZdkxuSlhvL3d3RmIza1BscW9IamJiYUhWa1BCMkQ4?=
 =?utf-8?B?S2wzNWlqYk9IYmhyRXZHRFo3eDBGamgzM2cza0VSK3FjV0hOTFJtbDZsVXpU?=
 =?utf-8?B?YkhsMHhQSC9BbU1JdkxYS1Z6dG1VQ3lsVTN2M09WcU8rekR0WDZYa2Z5dGNH?=
 =?utf-8?B?c3ZISHYxcEJ2WFU0ejBLalo5RWw3WFh3YW5nVHFESm5tUUlKbTRCZDNzOGRs?=
 =?utf-8?B?QXdtNi8wT3NkNTBadTVDQmpkc3p4WEFSYjMwdE55UVNUU3FweFZJQ25mdmRp?=
 =?utf-8?B?cWJZYkcyWk9RTGJNNGY4L3dtUzRRNUk4Z0p4SEJTN2ROTG9hVU1wcWlwTXFZ?=
 =?utf-8?B?ZUhFU3Jqdkw2UzlNYmdQVEZJRmFuYVVJYk5ESU1GMzhZM3NWb3NrbHpOV0RZ?=
 =?utf-8?B?Ulg2TWlLL2FKZUlINHg2N3ZWWWtBRUp1VS9oOTEvU1lKYmJKTzB4QWdMRkls?=
 =?utf-8?B?WWhRVnEvbVc0bWdTb0FLOFRLbytsOXF4bWt1SVZFc01GUC9YTVI2RjllU0h1?=
 =?utf-8?B?QUQwOEZMZEhzTFAzcFBPREJjdGptN1d2UWxINElDRnIrUExxWmFxWkZuMnRk?=
 =?utf-8?B?cUFmaVJrZE1aR3NhSjFFSUdPSDUvdUNud2hYSlhWM2MrVkFGQVdoSllDTlFw?=
 =?utf-8?B?VThkWkpLMENpWHcrL2VnRXozaVBkMW9NUkx3Q2Z4WnZDVjhvaFMzMXpGVE9G?=
 =?utf-8?B?cWFLYWcybTJYRkd2U05rSG4zcWg0UnYwN3diT0ZWVDZnaG5XUzVnT2FGRE9t?=
 =?utf-8?B?YjVpY0tvUklsSlN5TVBqakZIc0FaekJ2SnVHTTJIcWk4THJMcXpYUHdrTVls?=
 =?utf-8?B?NUdtRnREQ0RWbFo2YXk4LzYrWG1vZU9SQ3ViWFIxWnA2Smg5eDdWWWZzYy9N?=
 =?utf-8?B?c05VVGthQUR5WGdNNFZpYWpEdTVHMDBIU2lQN243OWRQUXcydjhObjVVeU8z?=
 =?utf-8?B?dHRiVC94ZmNVYlBqNlB2a1FNQytXVyttNmlLaE13VmVlNVhkT2dMc2tVQnIv?=
 =?utf-8?B?MmUvSWdaQlVzdm5NRXJJSjBJQi9oRExOMHpiNVFFaDVnZkFZekRXS0ZBdnhw?=
 =?utf-8?B?U2wyMGkwZCtlZUdnOEpYSlhsRllJSWRPc1dRbDB5dWkvbjVBajRYelZOb0dJ?=
 =?utf-8?B?d1BDcDNuNmI1RGVqTjYxaDZOWjliaUJEbjQweVpLdXNvazQ1VGd5OEhyLzZ1?=
 =?utf-8?B?TUhmSEVCRzdDbVVlaUVZbVhPU25DdmJ4WHExQVBFM1lOOWlrNkRzWWFCUDhF?=
 =?utf-8?B?UXNZMVV5YjdTRUMvYUR0RmQwSytCanZ3S2M2dEpVZDlSYXBKZlBSRlY3NWRy?=
 =?utf-8?B?cGdzYVJ3aW9YYjdLMW4vQnpHUmtUVGd3clJDNk5VTzlRRnRLRVg1WWZYTTZK?=
 =?utf-8?B?NGxuRHNHM1p2WTArOHJUblFneEU2NDVFRVMwc2p6WTJXZUdpNHd2RG5GRmtu?=
 =?utf-8?B?TER2VHFjcnJDK1FzZDU4eis0Q3VycmNYMnl2amdMT3VRL1pzblJTNHR6T0lE?=
 =?utf-8?B?L1FEcXFxTUlZdjVZNXJaL3BlYU1pUGlQdUgzblVndHlaY2JBMG5wK2l2ci9G?=
 =?utf-8?B?TFJnL2wwNWVxUlhadE9rbHpHYVlRb1pVdlhNYkJyUFk3ektLUHVkcTRMZHly?=
 =?utf-8?B?UzJyMVNlbFJKRVNCUlhXenA5TktHdGpIU3Nyak5zZEJkRXhSNnpHYU5tWlR6?=
 =?utf-8?B?MklNcVpEa2FkV0ozUTcxRDhTL2c5UE9kOEFuaVd6RWdLQkNKa1V1aHJSaFBQ?=
 =?utf-8?B?R1E5akp4SWdPdzlLRlgwZWtZVDNScFZMMjZPb3dhK3ZPWGhTdmtTeVlVZ2Ja?=
 =?utf-8?B?ZmtrVS9vMEhXZ2h2bW5TekNid0NaTm9ubk5Ea0FNblNDUnZUWW5jNGlnbXpG?=
 =?utf-8?B?eGF0SlFnUTVpaTRxakRQMnFzSnhmaHN4MS9lZ0oxTGdJT0V2MTZGM00yNGNz?=
 =?utf-8?B?RWpaaWZNR3R2WkFEb01HMVJBTUo5Wm9SUjc4VU5TdWtyZHRxV3ZKbHE4TWpt?=
 =?utf-8?B?cVVaRGgwNkN6aXhXTkliOTNpeUtPeWJCb0t6WWpTT01qU1VRNFNDQmxCa0kw?=
 =?utf-8?B?Q1dxTkhmaXhlMWdyRlN3TGF6ME9DNDNBSTRJU2U3N0lETE12NzEyWXlmRHkw?=
 =?utf-8?Q?XobtKLlwKHzMKoO/cV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f584ee-4b14-462a-ea07-08defe06f039
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 15:31:28.8367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+1hcgH0kic9Y9S5XOabaVlW6JitlmR1BiX1Z9c8yzwqeZKmAF3ppn87cRtTEAgX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6522

On Wed Aug 19, 2026 at 6:12 AM EDT, Usama Arif wrote:
> zap_huge_pmd_folio() propagates the pmd young bit to the folio for the
> file case, but not the dirty bit.  The pte path does propagate it, in
> zap_present_folio_ptes() and so does the pmd split path, in
> __split_huge_pmd_locked().
>
> For most file mappings the omission is harmless, because writing to a
> shared file mapping goes through page_mkwrite(), which dirties the
> folio.  tmpfs is different: it has no page_mkwrite(), and
> vma_wants_writenotify() is false for it, so a *read* fault on a
> MAP_SHARED tmpfs mapping installs a writable pmd via do_read_fault().
> do_read_fault() does not call fault_dirty_shared_page(), so subsequent
> stores through that mapping set only the hardware dirty bit in the pmd
> and never call folio_mark_dirty().  A shmem folio allocated by a fault
> is marked uptodate but not dirty (see the clear: block in
> shmem_get_folio_gfp()), so PG_dirty is never set at all.
>
> Unmapping such a folio - munmap(), or exit_mmap() when the process dies
> - then loses the only record that it was written, because zap_huge_pmd()
> drops the pmd without transferring the dirty bit.  Reclaim afterwards
> sees a clean shmem folio: the whole swap-out block in
> shrink_folio_list() is inside "if (folio_test_dirty(folio))", so
> pageout() is skipped and the folio falls into __remove_mapping().
> There, folio_is_file_lru() is false for a swapbacked folio, so no shadow
> entry is created and __filemap_remove_folio(folio, NULL) simply empties
> the i_pages slot.  The data is freed without ever being written to swap,
> and the next fault on that index returns a freshly zeroed folio.
>
> This is silent data loss for any process that keeps state in a
> MAP_SHARED tmpfs segment across an unmap - for example a cache handed
> from one process generation to the next through /dev/shm.  It requires
> the folio to be PMD-mapped, so it only shows up once shmem THP is
> enabled (which is what we did in Meta fleet and started noticing crashes)=
;
> with THP off the pte path transfers the dirty bit correctly.
> It also only becomes visible when swap is enabled, because with no swap
> device shmem folios (which are on the anon LRU) are not scanned by
> reclaim at all, so the clean folio is never dropped.
>
> Reproduced on x86_64 with a tmpfs mounted huge=3Dwithin_size: read-fault =
a
> 2MB-backed region, write a known pattern through the resulting mapping,
> munmap, force reclaim of the cgroup, then re-map and read back.  Without
> this patch the region reads back as zeros and vmstat shows zswpout 0 -
> the data was discarded rather than swapped.  With this patch the region
> reads back correctly and the pages are swapped out as expected.  With
> huge=3Dnever, or when the first touch is a write, the test passes either
> way.
>
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---
>  mm/huge_memory.c | 2 ++
>  1 file changed, 2 insertions(+)
>
Make sense. Thanks.

Reviewed-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi

