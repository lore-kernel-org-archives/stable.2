Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012049.outbound.protection.outlook.com [52.101.43.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC6F218AB9;
	Tue, 14 Jul 2026 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784043891; cv=fail; b=n8MUc9nmSfBTIf29/iGK5+OIOMoqJCcsBA8YyTUmLHc9BkAxhcmTui17b3VxSP5RDGq7oIScLdEBUt0MVusCZmmXo1EtCNndvWy1u4ujVwrkHmzy+lPWj4s59A4IIrkfXC1CMMRdHvbmz/5j/KagBNxzb7aHWF9oGVWftRkixfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784043891; c=relaxed/simple;
	bh=Kx8XV0OtTAmexF0lGJxmBoIX4ytga+1UhOxmbpz9050=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dFSoY1qWLYfCBnZl4p21wfsnnPoghwNPMiAF+I+NfB32Q1X9ziLl1cTfwMP/DWx4wy1m0V5O3YRW78JpxmcpUPNP9486mDrIdYX2L1mPRXlD6TevzhNjx9UaAcnz5k3qvD4FSiZTbvNeYIqLHedn9bzTg6CDu0tMjwzFkopLA4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SGkqoeTo; arc=fail smtp.client-ip=52.101.43.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SGkqoeTo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgE+xDo3mvpBZt6amHa914SGMUg38KmF7SjIRK77wmkFxWs/VU8ysihr4VpbBHnSgyqj/t7ABQ0NfBRBNfmU1ccsJJNlLB4Ihhcq24swgpXMhiTFRIq+ZVUfZYNErf3G1GYZbxD6OU3fwEOAR4s2R36a3dhyP084eK/p3QwYCQisa33DBQY1fNpqk8/ecVCfYI7Y3MVW8ziWEgq2JVlmh2WCVim25JK76xryVbeo1sxkwcRpaP7/e11h8win03QyRlHvrR+fiGz+qo1A65RB+h7mC233BTRcOvIR7ih/es88wJe2mHefiFqqbJ1LXyxnJ9Y//4iSeZzfhANNe2fFlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGIp83wTOTXEuMP1RVbuzZHlmxrE8CndGqGjOuZdRNA=;
 b=hypNrSmHVPizM2EinFZ+ZbKObAonUxkgWFKFzkK7hmYJ7YJLOX8xewM+HfMrAtSkeaJ9byU0hSB/6m8ko/d5M+tem/j9VxR02LG1Ax8kTPQO2GW5tsw8geTVmNor40Yn2bLY0uJY90ggVU8ZxG5Ih7YteZpmmkm5EdoR+gskQqhCiFaz7RZpZ/zS0iIMJORPGL9lMXvNEZjwn1elfLlQQ0OQv5mj+8MXYpidTnTKhMMou+g9fQZy8LRxYvTWUD7whqtMNkhCUyd0WhDxsEitrqiQU63fw+rsYBO1+j5koIm2Jnd67j/ibU0Y40QytkZZckyXOGLtgwCFSEO+hEJlLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGIp83wTOTXEuMP1RVbuzZHlmxrE8CndGqGjOuZdRNA=;
 b=SGkqoeTouJrl2DdrVB0zcP8Z7izjPRpZo1mJUWapPGW7m7hGpVyx/vxdoI1RiGWfnNWmmNdekzNDeS7Q+oBsn3a51PDYbZNa1Duw5qjSW3llJWVh5enu6haWib1JL9oiKu1sDSNkMdRHsA7EXqahdRnFfstrXmlL7mKgowLd9Rx7emMZOEE64G5F0TpEo6dFCZ7fGm9IZ+yx2x5DwIEwnFbl6Phk20sWGMMIXaJuBDBkwR1+nrepc/8l1n/8bVuF0TNEYpnJVxdpz/oulc4xDFj50MQePCJfEY63gYLafMN7RRDJDw6c54wDfXaAn4boYNUPoUdQ59pa+FIITkTPfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SJ2PR12MB7920.namprd12.prod.outlook.com (2603:10b6:a03:4c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Tue, 14 Jul
 2026 15:44:41 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 15:44:41 +0000
From: Zi Yan <ziy@nvidia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Kiryl Shutsemau <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R . Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Hao Zhang <zhanghao1@kylinos.cn>,
 Hao Zhang <hao_zhang_kdev@163.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/5] mm/memory-failure: keep the folio, not the
 poisoned subpage, locked across split
Date: Tue, 14 Jul 2026 11:44:39 -0400
X-Mailer: MailMate (3.0r7017)
Message-ID: <66A57599-EDA0-4E99-B073-F2AE0B2ED708@nvidia.com>
In-Reply-To: <18fe5529-2ad5-4330-a362-708a152bacee@kernel.org>
References: <20260714122344.351895-1-kirill@shutemov.name>
 <20260714122344.351895-2-kirill@shutemov.name>
 <c4aa63df-30ab-464d-bd0b-48dc37c8e6ba@kernel.org>
 <alZNYYsybKZA0eJb@thinkstation>
 <18fe5529-2ad5-4330-a362-708a152bacee@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow
X-ClientProxiedBy: BN9PR03CA0709.namprd03.prod.outlook.com
 (2603:10b6:408:ef::24) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SJ2PR12MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e1c4728-2145-45dd-9762-08dee1bed1cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|4143699003|11063799006|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/2vJ+fke319pdnoMayk25BlAPdEpz89Wlara7MdOiiorRLz/GONUgIm81tQxox+zJKaXBOKliiDbcfMN/2oJVRiiAWMpywbk9vBEOt86rFbj+DJFhBkCRdF0pMCBeHm9fiswq6Xyr++HMlZkPWDgs//A/t8BTueqDI5liFAGf/4PVxqRHyIP6VN4XWR0SQJR80vqsfOoj7zpT5zabCLT/pNuCDiuMa6F3Cg0nqGhfSBVAp0Ons/kmXEbe2Wnv6+h7F3kIMgc8iJOHybm6bqJLDEb8XeFm4ebzgP1m5Rdz+TIvm67KYE1k2ou3k28Ri01Y7FRbFFqFqC/HKAv5nCH2NoDqaLu1mih8GqrDW+FteQjqwCIPlU7I0uW5TXUWa8cDwQr5t9bFCJrmYgUgPYlQdCcey5haLjCKOzVaXsCrviAKvp+kTCCt1AZGw9stkrE4MkKmyb3NzBvGxlcEA3Q3NyvgnaMUGbsrdPd9MyCmZER2pE/7koFfonVbIcrxXx21JIE4fXzRsNDL0Bwk/wmY11RUqk2MurSqTZ07ErQKPoKuq9SliZnpAwheE+1dOVkjigfXg3vOlRL7CaWVUwDeMgibhkMJgQv7sLhJIvw9+BXrdkMi+wCp3n6VL/WN4+Sw6MA6AQWFqy318R2LqtyMk38/eZYSeRupt4BmSOtiiw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(4143699003)(11063799006)(6133799003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEpWQnJLQlZ6emNBUk41Y2pQRmJsMkFjSWhQQWsyODBtT2VmWFFUUEpha2RL?=
 =?utf-8?B?eFZ1YVIwN3NFbUsxN01qSlc2S0J5bXBDelVXZzc2Q3pNN1VzRGNaVVhVcnFh?=
 =?utf-8?B?QTdTMmVhdW0wSEI3SDdrVzc4Zlg5SStqa2xFc0dtc0tab3ltREZzY3UrNUww?=
 =?utf-8?B?TzFialpsdFBoRzd6bUdkdnVZNXAwd0ZPTWhySzFQUEE2cEpNeER1Zlcvb1g5?=
 =?utf-8?B?c3E4dmdZQXQ2NkRuZ3RCVk1TNGg2UjhKeDlYZ2k4RkExbjA2b3NDYlVkTG5F?=
 =?utf-8?B?WWd4bFVpNFRZKzF1KzBCSkpFejBKVjAwN3p0ZUw0KzZ3OEVqN3BwSkRuZjlY?=
 =?utf-8?B?MDg5UUhjNUJsempNckMvTXh4R3pUeDEvc0s1VHJ5ek03V2xobDVzcjhUc1ZP?=
 =?utf-8?B?K3BkVGxyV0pNR3Vyb2drQ0tiWjQ0NlJZUzdLWjVPZDVETFY0VCtOQW9GRzdG?=
 =?utf-8?B?aWVyVWc0MC8zQTlJM01uTDNNeHROOEI1TU8rUTdDeWZEemJwTVQ1SkNzUGNy?=
 =?utf-8?B?OE9SSEdXZllpWDVZM2RDU1hMTlZXVnJQcXFkeDdzcG9mVGdJbERTVWplcC9l?=
 =?utf-8?B?M2w1TlRyYnZYdFRhVldBelJ4c0xIVWdESmlUVG54T0JEeUIweTFQS2dVTVFB?=
 =?utf-8?B?L0JNRlVsL0FWQmpLdTcyK2oxczJIZ0VhN1NLeFV3RDVsSXVBSEtqN0ptaUNj?=
 =?utf-8?B?SHdJdEF1b2xHWElsSEhDdkx3dE1ITU1kYnFNQjNIN1l5VnAvOXNpRXV5UVhR?=
 =?utf-8?B?UEJtV05taEVpQ2lhRWM0UGRNNURqTkplRGdDZkNGRUxhYmZORkZlWVJtTWhi?=
 =?utf-8?B?VHhJb0dPeEpudk5PSmRIVFV0eEIwakR1NUdZWDlpSU1aRFBBZGFZM3pvUGFU?=
 =?utf-8?B?OHlVUVV6UGxvY0pBMyszMlRaRjNveUltaFNRMFh0dC90Nm9SaWdvalpadFls?=
 =?utf-8?B?K3daUEowenkxQnIwaGs3cTJPenJsdVhudnpMUjlDNXpRaEIwL2ZWdGJCRHA0?=
 =?utf-8?B?SVpRVnhzV0grMHd4U2d1cXY1N1JOckgxVWNiK0QzdTV2N3ByWDhPMWJ6Nm1J?=
 =?utf-8?B?UldtUm4zS0s0WjFtL2JDZENka2JKanV6SXdnTDFZTTd3Y0JzSXFhc0k5SkNk?=
 =?utf-8?B?TDhVNnRhaSs5RTl6dDBlRkVRYTlLY1dHb1FESWVjZ3dUK1JmblVkQTZjVEhs?=
 =?utf-8?B?cmpIOTFhYTBRelJWTzkxdVVUOTFlUWNTQkRjZFJ0dXpkUFVDejBWT2U4UHEw?=
 =?utf-8?B?LzlIY25ySy9zd1Yva2c2V3plMk5tYUNEczlERkhzQm0rZXoyUVl3VnJuaU92?=
 =?utf-8?B?aWtZc1J5bzdtaC84eTZEK0gyVjB4M1ppenhXd3AvcXNyZVV0SXkzZzgzR1c5?=
 =?utf-8?B?b0YxZjduYU1LS2Q3RHdOZlE0VkFCSWJ1MWt2bzNERTJ6eFk5WFN2NDJnZ2I2?=
 =?utf-8?B?TjNyUU1CdkJ1cEN3d1JLeS82cmhGcTBRYTZ6dytNeUVrdTVyckFkUmxDd1BO?=
 =?utf-8?B?VzZhL1hiM21SRkhBb09ub0xjSWNVUVJvcDNVOVMwdm5tV2NTR1F4SGtOUTBV?=
 =?utf-8?B?UnlRby9hVzIrcmw0L1E2M0dNMlExVTV3OXVxUFJNRjk5c0RDbE1hWnRNYzk3?=
 =?utf-8?B?cHFFT2QyWjRQRk9qUzM1WHhodzhvTzlmSE5rTU9vaDVYZThnYWlmUEMrVWdC?=
 =?utf-8?B?K0NuZk1YbFVZN2ZNYjh3SHY1bXBObGUzb3IzY1RkR0lZL3VncGgyL0JaMW5E?=
 =?utf-8?B?dnVMTU93L2p4MnZsd2dUelFiRDFnOENVUjVXTE9MVkJrL21IcVAwMEo1RmdS?=
 =?utf-8?B?MVE2N3VOM2RpNEtncmFpUHdmMWlmNmtjZEVoVEpVMUwxU0dwdzFiNmJoVDBn?=
 =?utf-8?B?eGEwbEhoK2kzc24yaFBwdEg3U0xuRVp3clNDTndIdEp6UHp6VXlKdHpMeUk5?=
 =?utf-8?B?blZKWVJ1ZEU1U3VOTHlWSndPckJaS1ZKNGFETnhacy9TZ1VjSzY1MExNSlp6?=
 =?utf-8?B?WW1pWnhQQnQrdVRRUHZCQytEemt6Ykt3TEoxWUluRFdVVUNSYXpBUGg3a1Zz?=
 =?utf-8?B?cWlyd0l3T0NKTi9ycW4rMFNuVHB2ZVpPNThNTVdKalhYS0VuVkk4UlU0ZlRZ?=
 =?utf-8?B?eWJCcnBSRzRaODNqdGtDVEpwK2pwcGhOK2JhOGNBQWN1Ky9jaW5DVU55QjlM?=
 =?utf-8?B?NnlVSVFuanhZUVQyek9md3VBejlCWi9GOTNWaDB4NU5wRVc3M3REclMzQjVL?=
 =?utf-8?B?eitDbHdFL0pQaTFFcmRnT3V3QnhqK29SL2liWlBjSjliTlRhTnhlaU1sMVhR?=
 =?utf-8?Q?WKcyk8U09e9WASidF7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1c4728-2145-45dd-9762-08dee1bed1cb
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 15:44:41.4709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJ47FCQmfCwZgMJGUWaZXx0neY59azCoDe6MXYpCOVOso/1HEAvNtHemUUiGiwVa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7920

On 14 Jul 2026, at 10:58, David Hildenbrand (Arm) wrote:

> On 7/14/26 16:53, Kiryl Shutsemau wrote:
>> On Tue, Jul 14, 2026 at 03:01:46PM +0200, David Hildenbrand (Arm) wrote:
>>> On 7/14/26 14:23, Kiryl Shutsemau wrote:
>>>> From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
>>>>
>>>> try_to_split_thp_page() locked the poisoned page and passed it to
>>>> split_huge_page_to_order(), which returns that very page locked to the
>>>> caller.  For a tail page that means __folio_split() runs with @lock_at
>>>> pointing into the middle of the folio.
>>>>
>>>> __folio_split() dereferences the mapping after the split completes
>>>> (shmem_uncharge(), i_mmap_unlock_read()).  The only thing keeping the
>>>> inode alive across that is the locked @lock_at folio: while it stays i=
n
>>>> the page cache, eviction cannot complete.
>>>>
>>>> But a tail @lock_at can lie beyond EOF -- e.g. part of a shmem THP tha=
t
>>>> reaches past i_size while the file is being truncated.  The split then
>>>> drops it from the page cache yet still returns it locked, so the pin i=
s
>>>> gone and a racing final iput() can evict and RCU-free the inode while
>>>> __folio_split() is still running:
>>>>
>>>>   BUG: KASAN: slab-use-after-free in __up_read+0x634/0x790
>>>>    i_mmap_unlock_read include/linux/fs.h:537 [inline]
>>>>    __folio_split+0x732/0x1640 mm/huge_memory.c:4100
>>>>    try_to_split_thp_page+0xab/0x390 mm/memory-failure.c:1675
>>>>    memory_failure+0x1394/0x26e0 mm/memory-failure.c:2470
>>>>
>>>>   Freed by task 4601:
>>>>    shmem_free_in_core_inode+0x54/0xb0 mm/shmem.c:5177
>>>>    evict+0x57f/0xac0 fs/inode.c:870
>>>>
>>>> Split the folio as a folio, via split_folio_to_order(), so the head is
>>>> the anchor left locked.  The head is piece 0, which the beyond-EOF dro=
p
>>>> loop never removes (it starts at folio_next(folio)), so the split alwa=
ys
>>>> leaves it in the page cache and the inode stays pinned for the whole o=
f
>>>> __folio_split().  memory_failure() and soft offline re-lock the poison=
ed
>>>> subpage's folio themselves after the split, so they do not depend on i=
t
>>>> being returned locked.
>>>>
>>>> Reported-by: Hao Zhang <zhanghao1@kylinos.cn>
>>>> Closes: https://lore.kernel.org/linux-mm/20260710071344.GA106129@zh-pc
>>>> Fixes: baa355fd3314 ("thp: file pages support for split_huge_page()")
>>>> Cc: <stable@vger.kernel.org>
>>>> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>>>> ---
>>>>  mm/memory-failure.c | 13 ++++++++++---
>>>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>>>> index 51508a55c405..68d42cbed458 100644
>>>> --- a/mm/memory-failure.c
>>>> +++ b/mm/memory-failure.c
>>>> @@ -1657,11 +1657,18 @@ static int identify_page_state(unsigned long p=
fn, struct page *p,
>>>>  static int try_to_split_thp_page(struct page *page, unsigned int new_=
order,
>>>>  		bool release)
>>>>  {
>>>> +	struct folio *folio =3D page_folio(page);
>>>>  	int ret;
>>>>
>>>> -	lock_page(page);
>>>> -	ret =3D split_huge_page_to_order(page, new_order);
>>>> -	unlock_page(page);
>>>> +	/*
>>>> +	 * Lock and split at the head, not the poisoned subpage: __folio_spl=
it()
>>>> +	 * keeps the anchor folio locked and needs it to stay in the page ca=
che
>>>> +	 * to pin the inode. A tail beyond EOF would be dropped yet returned
>>>> +	 * locked, losing that pin. The caller re-locks @page afterwards.
>>>> +	 */
>>>> +	folio_lock(folio);
>>>> +	ret =3D split_folio_to_order(folio, new_order);
>>>> +	folio_unlock(folio);
>>>
>>> With a non-uniform split it would actually make a difference: we'd want=
 to split
>>> such that we the other folio pages minimal.
>>>
>>>  split_folio_to_order() always seems to end up in
>>> __split_huge_page_to_list_to_order() where we do a SPLIT_TYPE_UNIFORM.
>>>
>>> I recall discussing with Zi and Willy that in the future we'd want to c=
onvert
>>> more places to do a non-uniform split.
>>>
>>> So I'm afraid that would just re-introduce the problem then.
>>
>> Right. Non-uniform split can be useful.
>>
>> But my patch is completely broken because code expects the pin to be on =
the
>> @page, not on the head. put_page() few lines down can explode already.
>
> Yeah.
>
>>
>> So the fix does not belong in memory_failure(). It belongs in
>> __folio_split(), and it is really just 2/5: refuse the split with -EBUSY
>> when @lock_at is at or beyond the sampled EOF.

There is an alternative, only igrab() when @lock_at is at or beyond the EOF=
,
as I was bouncing ideas with Codex.

Some subtlety exists in these two =E2=80=9C@lock_at at or beyond EOF=E2=80=
=9D approaches.
When @lock_at can be a tail page of an after-split folio, Patch 2 returns
-EBUSY unnecessarily, since the after-split folio containing @lock_at will
be still in xarray, preventing inode going away. To make a precise decision=
,
we will need to determine the index of the after-split folio containing @lo=
ck_at
when checking against end. It is easy for uniform split, namely

lock_at_folio_index =3D
	folio->index + round_down(lock_at - &folio->page, 1UL << new_order);

but for non-uniform split, the calculation is more involved and I have not
figured it out yet.

If we go =E2=80=9Creturn -EBUSY if @lock_at index is at or beyond EOF=E2=80=
=9D, are we OK
with not being able to split a folio when it is actually splittable?


>>
>> The safety then sits in __folio_split() regardless of caller or split ty=
pe,
>> which should also cover your non-uniform worry.
>>
>> The behavioural change is that memory_failure() reports a beyond-EOF
>> poisoned tail as unsplit (MF_FAILED) instead of recovered, and kills the
>> mappers instead of splitting the page off. What we give up is salvaging
>> the folio's healthy pages and the clean unmap -- both low value for a pa=
ge
>> that is beyond EOF and getting truncated away. Containment is unaffected=
:
>> PageHWPoison is set before the split and free_pages_prepare() keeps a
>> poisoned page out of the buddy allocator, so the bad page never comes ba=
ck
>> regardless.
>>
>> The alternative, if we would rather keep the recovered outcome, is to le=
ave
>> @lock_at as the poisoned page and move i_mmap_unlock_read() (and
>> shmem_uncharge()) ahead of the after-split unlock loop, so every mapping
>> dereference happens while @folio -- the head, within EOF -- still pins t=
he
>> inode. That is close to Hao's original patch. It works, but it rests on =
"no
>> mapping dereference after the unlock loop", which is its own fragility.
>
> At least it can be well documented.

This approach works without changing existing behavior, as long as we docum=
ent
the requirement well.

I admit that this is another implicit synchronization in folio split proces=
s,
in addition to
1) keeping original folio frozen until xarray is updated and
2) do not update xarray with after-split folios until after-split folios ar=
e
unfrozen.

>
>>
>> I lean towards the -EBUSY guard.
>
> The latter approach seems cleaner to me, but let's hear others as well.

I prefer moving i_mmap_unlock_read() before the unlock loop (shmem_uncharge=
()
is already before the loop), but I am more than happy to be convinced that
=E2=80=9Creturn -EBUSY=E2=80=9D is better or something else.

Best Regards,
Yan, Zi
