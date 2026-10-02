Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012036.outbound.protection.outlook.com [52.101.53.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5850B31283E
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790968269; cv=fail; b=MtIRvzZKrKfYI9FavC8bLPcmHgLhD4LTAgEuT5/oRNyVUFi3G1wtqjZX+mrOyTarAsCKlCRVUIlpNB9LsZzsevGQLcSg1tzweZwz0aKE0Jp8pEZ9YUh0cycVKYCs9Bzj/6SguZivi9jfnc5ft488Qk3hmRc57LgJ7j9LSXoTGDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790968269; c=relaxed/simple;
	bh=Edx/ehNwTfmMs6N/fXbIG3VxidmOKrEdEHlFCa51Dus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ct7Up+5j9AyT9cMvFtUrj/eK3LtK5jDbckfLVO2PY2o1BQ+0SHEzswPHtZoEwI34InkDSSl0d2JRpxGeBQP6nf8CGbl0lw1ywgzgduIe6R27hkhyqypBFQAbk4RhMT0N6+IO4ks5XYYgIoGW4/Zuze4WsmctR9ffhrnDtcUoVcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=M3YNwXUq; arc=fail smtp.client-ip=52.101.53.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M3YNwXUq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LmJYbFxg+ktbWOPdjgzFbyX2ljeYMZAqjUoq5km5DkyHp/IYwvdpSQu1gHmx3xuSr77KRlgm2NHgnbD+KpaRKWTMgF3W71/FOEd+L72yBbL6aLkqM1CcSC6U64n2ASLc9elPR20wMJghAYQN3UL+/I3gB+p8dDfdtgUiDHWE4YirTUnLohF2QqDboale4CU4VjQ/sVWByBuf7FL2kpe+ux7kb+vXq7Reaj6cb7H1Lrr21sEQaoZ7gqJvy9WlsJ1gqlIRbsnqW3oh8LvvJoySLd/ruxvmXsRPWcS4Vj4GVei0IdjMcPkpxjg4LDtRibbeJ3M1BiZ82udp7ql3L94jDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIT7u/PDRT/eaFm7lA7G87xqxLM44Hx49jbVmz3OgGg=;
 b=mbF2memhXyKULD1cG1Wa613POj2mAqmjsnoxBP6m5dInSHkYKzN8+dAJ3YaMNxolAELF1iWxSlAv2pRXQ029lfHATYYItcfnzvB93u5aaJ5JP+l06rz/3QOsGs/9A6mQDCGawUeuJtNt8GJPIMSynkx9HnHjflbz4EGGe42Fc9xREcu/G4gZWt5L2ktIBQ5mPrTRAz7fipf54wM8BtD1EgdoWMTooAzJLcFoBQI8/drk42tEV0daNjFpP/HfyWG3fXSvtg00eqbmz8gAbs9MoOK/6gaNbXuOuG5FZu9BzPnpB2pjtiWaNYg+My/+vKPlDDKEBller4yUUz15R3DHUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIT7u/PDRT/eaFm7lA7G87xqxLM44Hx49jbVmz3OgGg=;
 b=M3YNwXUq4eQO9zJrv4S+YXjvtItKUFS9nKHe8PrLiS8cHH0sz+fBFp2moaUkylgO5BmCuUrrrRMqCi/RSVhHqKhSS7fexOmDunQ+KRHkbnHZvpwiOiRUnPcVlj53JLKiv4FrYSbYIw/SfoY2QsA8Qw3u2pjmuIlgfvmk2uRxbAa6dndFHCG4O1iVQe9kDWNGbSQr5TZvhDeX4d9I5kzW7OKD4ABRvGIyUlQGsGuS6AiB9Caqo9J/gq9rHtBPJwoM9so615KZZwDUWjioz7FClK702EaBwvleFITiQTtEfx4M4TS5m3Lk67g485dNd52/0xJjLd1JM92Xotp6Mpb/MA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SN7PR12MB7252.namprd12.prod.outlook.com (2603:10b6:806:2ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Fri, 2 Oct
 2026 19:10:59 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 19:10:59 +0000
From: Zi Yan <ziy@nvidia.com>
To: Deepak Nagaraj <deepak.nagaraj@baseten.com>
Cc: stable@vger.kernel.org, mfleming@cloudflare.com,
 Kaz Kato <kazuyoshi.kato@baseten.co>, Stephen Day <stephen.day@baseten.co>,
 Sasha Levin <sashal@kernel.org>
Subject: Re: 6.12.110: kswapd NULL deref in list_lru_add, possibly related to
 xas_split_alloc backport
Date: Fri, 02 Oct 2026 15:10:57 -0400
X-Mailer: MailMate (3.0r7032)
Message-ID: <7C66B0B0-1F43-41D9-9B4F-89956045D81C@nvidia.com>
In-Reply-To:
 <CAL3JwHN34En=iiEB+Zyxo3=_xfODTY_k_kddb2njN+AJwSCnnw@mail.gmail.com>
References:
 <CAL3JwHPX_fJpg_Az3Et4-xrTdkcdtT20xw7Bhjz1FZSLW_xODQ@mail.gmail.com>
 <A90F7E87-80B5-47AA-BD31-0F0CA5A17862@nvidia.com>
 <CAL3JwHN34En=iiEB+Zyxo3=_xfODTY_k_kddb2njN+AJwSCnnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-MS-Reactions: disallow
X-ClientProxiedBy: BN9PR03CA0745.namprd03.prod.outlook.com
 (2603:10b6:408:110::30) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SN7PR12MB7252:EE_
X-MS-Office365-Filtering-Correlation-Id: a42243b2-acb0-4ffe-2a76-08df20b8e47f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CbtMYxqxL/kOVE9RhfQE5ChHpZAZGmTrI+x90qWE526uDItxMw/cxMAqcOKIEvRBXiOo9gsWfiO15Ro4W5wTg0498veIRrhIXOujPn2DTEPO/HJdTOvk+RWBd9KuIoEvwGNCUZv+3U0kJyfViSo6t74UqAw/v1y4EFiCUKgtWk8zaxIrIezTQXBb6TC80sNBfYiOaEM5YP98056zXssX5RAWCBMBFiMOrUozRbofHuRl2XhSJ9zlwkGx7yLJ7zbdup6vhlDwjWHUiyiDj8YUpmtHbA6HSU1xEtWa9fn1UiDu2N75mVHALTRveC5OKI/3iMWrWiEygAmTAMAO0qticKccg/iTCnGIJfxSbv61TXW4DT3n2rPNsHRELHKkv/vsJjWikBBIv8ZF6tb+Pz1h4UiBAOd5IasYuWhkzEO8x1GVQClok9dlhrkM7GCl68sL0xcD+060Cr7dsJ339h5vN2v1a+/dGhIBW0/uXYTnYlaoKWRkMeHmaAFzoF/3KwS6t23w7BASj3HTi/sko4UvtMmlJZp6awxm/Tea3eqgsXboEGeIBwPIkVFUDYBBX1PcA8OpnhA41bKp0rvU+N05lfDkj/dRDNp2XUA+3Xkm9vb3s8gXlBdztxnc79FGoMTq19Y6HzORrOOuHDzd5nK1QVkhRmDbcB8b2EfWjQEZL80=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?azhibFZiZ29IZmRaQnp5QXFWMnZiamk1emJnaDhHdVZrWjdYM05GVCtDK0F0?=
 =?utf-8?B?RXhxRjVraUkwdnNPVlY3L0FyTXkwT3EvS3BJazl4U2w0THhvemJTYmZtQ3g0?=
 =?utf-8?B?dXhCakpDWWcrdjB1SEUxbHFZUmJXbnY1ekU4T2dwdXI4a3VrZk14U2xVdmlN?=
 =?utf-8?B?NEF0U2N6MFNBalprU0FYNEszdGRnWExiTWhWVDNNS2Z4NVVUaFpYTUlFY3cw?=
 =?utf-8?B?aXJnQmZhZjVxa0lyMVJIaFd0S2JYaWpYSUlodStSMk5nc1B5OHA3UExjOEVP?=
 =?utf-8?B?eVNtenFVbzNINFJqaHVRMWhrUHpVRDZaeGx5aVAxb1Q3L0hWTjRtUTZEOVRY?=
 =?utf-8?B?TXFkbU1kcGs3Sk5lbzltK1pVWnBRaG1lKzlxTDBPeEhVREZxSnlXZEY1NWNX?=
 =?utf-8?B?VXRERGF2U1VJWEE0R09paVE1WkliWXR1dGVZSXV1b2RacFpUWDFNODJ3M3Rk?=
 =?utf-8?B?TUVaR2sranRqMllzSmQ4SmhlYWZaNlBPUkg4WGZaSTE4UFJ5WkU3V2ExT2VX?=
 =?utf-8?B?Qm5XRGE4dzFWRGMyeXBabkYzalFwNmpKK0VBMjNCUXBua3lWZVBFSGZoY2hB?=
 =?utf-8?B?N2VxWEo5NjhQeGpFR0c2NHlRUC9HZkI4YmVZTkxMSW1lcUJFYXluTWNZQkpY?=
 =?utf-8?B?MWFzcHJ0dVdTdHlyZkxUKzF3NDY0azlNZjh0VDRJTkpCZjVmS3ltc0dTU05L?=
 =?utf-8?B?bGxxU2hhWW80QzFqUUVlMExIR1UzRDduMjJFOXBGZXJXTnFTakVDWDNmQ3FQ?=
 =?utf-8?B?MnQ2YXp3NGNMazJiam1WNmVydFNBbi9iZkNHSUNLUHpVSnk4dFJ4akFpY3U1?=
 =?utf-8?B?czIzRnlhM3M2RWJaSWliMlRvQmptTGsvWHpZSjJYdUVObmxpaVh3V080MlRh?=
 =?utf-8?B?cnF6MWdOU2lYN05OalVUL0VoS2w2alMwTExrM3QvTlFIcGJNSTYwem16ckx4?=
 =?utf-8?B?N0l4eDEvS0xoODEwNlE4MjRBekdJVllIZFQ0YnNUa3lXTFh6aFlDaC9YcWZy?=
 =?utf-8?B?RWJnYVVTRnZIZCs3YUJ1NWR4ZERBK0tXNGszNXBwVzlpaXlUSDdwZ3dOVFl0?=
 =?utf-8?B?K0ZwTVl3QmtUampHM1pDUU02ZGZ5VS8wSHVFUDl1ckU0MnBmS3liWXdyUzhp?=
 =?utf-8?B?cjJWS3ZGcjJydlVEaHMzejNSRnV5TXBtM1kyejFsSjNmL1k5dGFaQ3AybXBL?=
 =?utf-8?B?Wkgzb3lkV3hjV0dYbUFFdm1ldmxxUmxMRlFydEtxWHN2SzZEQUVFbUFzUW12?=
 =?utf-8?B?RUV3cEdNMUJMa2VLNGVqMm0rb1VNWE0xRmFXbWZwK01YUnFYTVIrV1RVTlVl?=
 =?utf-8?B?TTRWS0d3OFNVYy9IYVY1Ni94M2xReHVJbERkUXNtSFZYTUFNdUFlK2R4blRW?=
 =?utf-8?B?Ti9wa1lZc1l6b0xnK2JIUWxLcjV4bDg2QklaQjRzM1RseDlvQWxpSWVEeVd4?=
 =?utf-8?B?ZzBqeGlBTzQvQ2FvNi9aQlJWWFVqTmRYc1dONGN0OVduWkVjQlVuMktYTTVs?=
 =?utf-8?B?K0xRUkgzMzB1MXNjdCtxWkVndGhHUjBMWVBXcE4raCs3Mmdha2V6elpIYWg4?=
 =?utf-8?B?UStXMFMvWWlJUW1yQll4d0pyK1U4MXQrMExSZ21XV3RjbmxhblVQUzhrSklM?=
 =?utf-8?B?cEtEd1pvMEtJOXZYa2FLNXFaaXIxcU5iV0E2eE8xRURodS82RXppdGJjVGZa?=
 =?utf-8?B?cW4vRnUzRGFBOEhOU0pyZUlFNWtBaUFPYzJvUUZma25pVUN4b25FUmEwNHhj?=
 =?utf-8?B?ZU90TnZodHY0MEoySHBXanV4SUR5ODZJNWNRQWlmQXVQbkE2Sy9Yd0h2cHN5?=
 =?utf-8?B?REVobDVGVmt1bmRuYStkbkJQdkdVWkZ5eUpCdllxQnBXQ2VkNXVnZ1lnTm1S?=
 =?utf-8?B?NWtGbmJXdnJ5WHJPUldmaHI1Z2RBV1JFMUN5aXVPYlBSSkJpVys5TzVFL1Vi?=
 =?utf-8?B?YlJjZTB4YnZRbndkNFFRUnZtaDRoTFVYY1JtcVpVRlhjRGNzUlU3YW1DUDE1?=
 =?utf-8?B?SXhXdFVidkpWTkc3cWdWWnJSWGNHSW4weEZVSjdyWmN3akRCWlBiejQ2TUZv?=
 =?utf-8?B?V0p1ODdWelJrVzJJd1Q1MlU0RWJhblQveWNvaTREdXhtLzkyWmI4Q2diU1pK?=
 =?utf-8?B?bUpOUUdrMmlJbWhNRWRMcTA3M1RFOWJka3lCQnlqT0wxQUdHUDVzUGpycUpw?=
 =?utf-8?B?ZHVTTjdkcWVyYUdSeUpYYlpBeUdHZlg1RHptTm5OOXJVUGxjejhObU0xQzhS?=
 =?utf-8?B?dzZlQ3NFamg5aE14Zkh5S0F6bjRoZE9mdXZWQlpub0tvREVrbkMwUHZhSkls?=
 =?utf-8?Q?JuNGJViRu2XPTe7st5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a42243b2-acb0-4ffe-2a76-08df20b8e47f
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:10:59.0935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjCR6AyC/KwOnBvArZDhOcjGX2qbBDszKm2LsS5QoyrK0u+b9lGPPH3I8to7XBEs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7252

On 2 Oct 2026, at 14:34, Deepak Nagaraj wrote:

> Hi Yan,
>
> On Fri, Oct 2, 2026 at 10:38 AM Zi Yan <ziy@nvidia.com> wrote:
>>
>> On 2 Oct 2026, at 13:25, Deepak Nagaraj wrote:
>>
>>> If I am reading v6.12.109 correctly, split_huge_page_to_list_to_order()
>>> calls xas_split_alloc() at mm/huge_memory.c:3524 with xa_lru unset, and
>>> now with __GFP_ACCOUNT. My guess at the 6.12 equivalent of the
>>> dependency is to inline mapping_set_update() before that call.
>>
>> Yes, it is probably needed.
>
> Thanks for confirming.
>
>> Why not just export mapping_set_update() to mm/internal.h like mainline?
>> split_huge_page_to_list_to_order() then can call it directly.
>
> I tried that. On v6.12.111, mapping_set_update() is static in
> mm/filemap.c, so split_huge_page_to_list_to_order() cannot call it.
> The patch below moves that helper to mm/internal.h as the macro
> mainline has, and calls it before xas_split_alloc(). With that, the
> 6.12 split path lines up with mainline.
>
> I have compiled mm/filemap.o and mm/huge_memory.o for x86_64 against
> 6.12.111 (defconfig, CONFIG_TRANSPARENT_HUGEPAGE=y).

Have you tried to run the updated kernel to see if the crash goes away?

>
> If this looks right for 6.12, could you Ack it so stable can pick it up?

+Sasha for stable kernel

Rather than picking your patch below, I think we will need to backport
commit aca1f2d5de17e ("mm/huge_memory: initialise workingset state before
folio split”), although the backported version might need to change
mapping_set_update() like what you did below.

>
> Thanks,
> Deepak
>
> Signed-off-by: Deepak Nagaraj <deepak.nagaraj@baseten.com>
> ---
>  mm/filemap.c     | 9 ---------
>  mm/huge_memory.c | 2 ++
>  mm/internal.h    | 6 ++++++
>  3 files changed, 8 insertions(+), 9 deletions(-)
>
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1526,6 +1526,12 @@
>  /* Only track the nodes of mappings with shadow entries */
>  void workingset_update_node(struct xa_node *node);
>  extern struct list_lru shadow_nodes;
> +#define mapping_set_update(xas, mapping) do { \
> + if (!dax_mapping(mapping) && !shmem_mapping(mapping)) { \
> + xas_set_update(xas, workingset_update_node); \
> + xas_set_lru(xas, &shadow_nodes); \
> + } \
> +} while (0)
>
>  /* mremap.c */
>  unsigned long move_page_tables(struct vm_area_struct *vma,
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -125,15 +125,6 @@
>   *    ->private_lock (zap_pte_range->block_dirty_folio)
>   */
>
> -static void mapping_set_update(struct xa_state *xas,
> - struct address_space *mapping)
> -{
> - if (dax_mapping(mapping) || shmem_mapping(mapping))
> - return;
> - xas_set_update(xas, workingset_update_node);
> - xas_set_lru(xas, &shadow_nodes);
> -}
> -
>  static void page_cache_delete(struct address_space *mapping,
>     struct folio *folio, void *shadow)
>  {
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3520,6 +3520,8 @@
>   ret = -EBUSY;
>   goto out;
>   }
> +
> + mapping_set_update(&xas, mapping);
>
>   xas_split_alloc(&xas, folio, folio_order(folio), gfp);
>   if (xas_error(&xas)) {


Best Regards,
Yan, Zi
