Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010052.outbound.protection.outlook.com [52.101.193.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD90B2E414;
	Tue, 13 Oct 2026 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791858032; cv=fail; b=oAbNBTSgTYqBJARsiRyNSC2+ByBaqpRjtODVc0cGzfOuyYghhw2CeeDpMSsNjUrS1ACOf54N0jk3hi7afFRrYBa+9pWHpv5Yx4EZ0kwuW9LJ2n/mhhNEltp5PlDbXzuGKrF+zYc+/aWZFfZ494HB5vYzde0oxN6JFbHFTgx0W6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791858032; c=relaxed/simple;
	bh=/27mF8PogWQCWertbU5N00wSGBoS2Soz9pvuXnLGN4c=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=O3NeZKLUS0DQikZ44nysKPYJcnooY+I1nion32dR5T7q/v4kq2oheE+rXBbaWRp+DVwJXhJV0vjoA3RXhzWxr+w1V9HMFHJNMAEZI0cT9uS+EFOmeHuxCxsUMndnED6ics3SnXWdYWZWazhGlwW9sfKaWpoJE9mfxGbHk6CW1KU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SwvHGSXR; arc=fail smtp.client-ip=52.101.193.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SwvHGSXR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0fHIcG6oygHUz0yhUMgaNb2GC59WdoX7LH8uz9A7PtkjtG+kg/KP0pE+u4cDhla0oI9QoRUPX5XtTENeqI8fGMgYh8X79785RFQW2b8oogVOor7cEiC5g96ogj7tOdrfVQqVQ/cK2zMT9qItFbUhkSI6mIfX9zCbOBcXoDXHSu/cAjeoixRKKMlcjIm4IzncMUP4MHeKuzVVLP8rrUJrq63g9/bh7+x9OKTaFUpK4zNSOR/SfB2bCPNXdfwRHhPJ2nIZJNiH/Yo/5znvT14pqElk/oMsZyVnsnWIsIVKOdw6wOm3wGWIGUTFXonUEGV5/KxnDp6PfkKSEoUqeiLrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/MYfcO8px+Kk+I9XlnpNAZEXFBhtgezUT2Jed5Mal0=;
 b=PAPtxp4DalAh1laUUk5GggwZnACtWXWDvAqbENP6qe5gymbiCiLXGXPOue06H7IC9VyZb+r02U7wAG4QpP2NqSMX5nK3Hj/5G/w/9jxjhB9GYWby/0ESrwlOfMPDAyZl21HCjKdqLs8P9/80nmqPiWzyzRL3vqnrXJVpgMOVnLDGeT3cXy5DCTJKkc3/zHfEMcIj/QEpfXiCGEgMwfzU2n8l51OIBTbVEJ/JvK8rgUGbbgLRGnr7cNMI+Zt0/pkQCGei8RDe73rLN/5enUOs2nXY2DrpWTjp4shI+du6M3ZOdtyUuTn7CRszBu91uJ4GC0K6M8jWqHQZAsT7v4umSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/MYfcO8px+Kk+I9XlnpNAZEXFBhtgezUT2Jed5Mal0=;
 b=SwvHGSXRbwqB9HyS0fftMREyZ+9hK/cEtwdES7L9CqnsARPipes1nBCFMni6w+LCG/uRlLFSt6U8Ld8SDUcIHPqaBhTqze+ByuifJ6pVHlm9z4V6W9o0txFUuA8zOUtQA1S2V38XQ3Io0vFQiv8WXEoJWxVENIGUiENsheUOw43DHF/aMJw2MIZacOkz8GusjyGcpuA2dCYmKS883Vf12tePd0jGcxsQA148KlY1SoHSqUtk/ef5ugX3I5yGPDKh7ttOld1kojWa2a7IgWWYJE3bSpSyByzST991oWfK6zPEbnETBnvy7wgCXMMli15XBtp3JPNXlOh0tOhzxzcQ6Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 02:20:27 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0472.016; Tue, 13 Oct 2026
 02:20:27 +0000
From: Zi Yan <ziy@nvidia.com>
Date: Mon, 12 Oct 2026 22:20:16 -0400
Subject: [PATCH v2] mm/rmap: don't discard lazyfree THPs at PMD level
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-lazyfree-stable-fix-v2-1-6387d6e30063@nvidia.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NwQ6CMBBEf4Xs2TVto5R68j8Mh0IXWYNAWmxEw
 r9b8O7xTWbmLRDIMwW4ZAt4ihx46BOoQwZ1a/s7IbvEoITKpRAGO/uZG0+EYbJVR9jwG3Otpaq
 UOBnnIC1HTyneX2/lj8OrelA9bVdbo+UwDX7etVFuvf+GKFGiFsZocy6oKdy1j+zYHuvhCeW6r
 l96tfFQyQAAAA==
X-Change-ID: 20261009-lazyfree-stable-fix-67712b2049dd
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Rik van Riel <riel@surriel.com>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, 
 Jann Horn <jannh@google.com>, Lance Yang <lance.yang@linux.dev>, 
 Kyle Zeng <kylebot@openai.com>
Cc: stable@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: MN0PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:208:52d::18) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SA0PR12MB4447:EE_
X-MS-Office365-Filtering-Correlation-Id: 67812a53-d226-40ab-30b3-08df28d08bbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|23010399003|921020|56012099006|11063799006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UcW0LmQXNqlJIy591e14WXI6ZAflwahsD3A2fpMBmnWX9GwiuGAGJlSKCneeR1p69/YgrPpbG2eEmqFlTph9q8K33vHgyKTTU14UVLPagTRoI3VEhNvrnUQPe8XtdvA21gTZCJT+D1LZvi8FS00rtXHUJT5smVCUUWCqVFTcP2hL9qKybbs7LXCSYxMGPmvRREyfT9O1AW90MR2jtWJvFT7pvF9ca1LvsltO6aWoGC0BtRuL9posW7d2IfsL3XIGGaaETOo0DRpuaS1Ym42J8Lbeavzp3ZMLbsm8KpyOyaS9MhPV/sroOf+xcK/dsV6e1bSBSh94oJmKGSWDHCdZV0+DKaxLfuiBeh/10Yt9d5WwFUwNY/mmpSUqdkDz+GHzrWJU3en+RB5Wpf3aqoY7x+BsnGfwPgU5/9z5uIW/k8vvSDMuBdcQj4OcnTO2wvd8/2IetvR3dDzlcjPQud8PPoPSDGi5hsgxyAtwh4KtDqJN5oRyw/Z/mSLtoyPUslLOg0JKI+nrRO7OR1P7BNBMkdYxQ6pn7jUkiHIh9cQRUpXnbHJQXhIjO+HjNq1Ir4T4zIFOltZwDt+Lw8C1Sav/ZFviCQgysk8imRFSXF/OHmJRxrnh2qVF1PYpl2hH2g328VhTOLJM8CzJ0zUd05eSkuYHUno/q38p6I2sTfLuD8EeFkeAECzmr261B2RyO/Fm5yuf30ocumfz0317rSnEnw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(23010399003)(921020)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkJ5RVVBS1lrVk9Pai9TOTh2Mm53Zm5MV2V0V0FtWEE4Sk53MS9uL2R3cm44?=
 =?utf-8?B?TE9OVGRSa2FqNmhQcHZGdnlKRGxjUFBJeFVTblZuTXBDYmhVV3lkd2hVK24x?=
 =?utf-8?B?WkdvNXp0N3lhblhSVnI0cVdsRkpmbjJHMkZDbjBRSFRvQ1kwQWFpdm9CS0Ja?=
 =?utf-8?B?VklBaUpUQUlHaTNFdGlxbmRiWFovejJ2aHc4ekFML0loV044bG1aa1ZtRkls?=
 =?utf-8?B?cW1mR0wwbG9yUTR3a096UWVpK3ArcHMrKzdGdEFYeHY5Y3lpRUpGTElXUk5Y?=
 =?utf-8?B?djNxYzNVaUJDK3U5bmZlekZOVkJVNTZzRE1xeEVEMFVBNUZhWFhTVW03QWxL?=
 =?utf-8?B?NzV0WUR2dzRlME5zRGthYWp2aXg5QWp0WVhoT1BhZW1sK3oxM2g2OFZvVHBs?=
 =?utf-8?B?VkNQd0JjcjNCNGlVY09OSFpScDFlODE1Rk1tcHVJeTM4SG5BczJ2MW9BeTFT?=
 =?utf-8?B?Mzhjbk5QYWpFeldDQmM5akpzd2U4OTcxZFRBRHlTNTFZRkgvUUJEWVE1Ymkz?=
 =?utf-8?B?KzAyMlAyUWFNdmtwQjJBYmJpMUJGTWRLSlFDZHRncXNMQnNGM1gwbTRVTlcr?=
 =?utf-8?B?N2c3WFk5MU9yZVlUQ1c3RjRqTXAzMEIwcmtnaTN2Vkl5S0JNR2xId1JkcnNF?=
 =?utf-8?B?aWZHWmhzd1V2UXZVVVg5azVSZDBRdHAwaXQzTlhFK1doczVraU9FcVpFR1Vh?=
 =?utf-8?B?eVhCMi9hSnNpYkMvOXE2ZGx4RnI4S1dZNzRVUlpIZmNkb3RYaGJwanhqMVV1?=
 =?utf-8?B?aXdzdE9rSUo2Njg3VG00YW5xVDVKOHE1VDFOWjlndXFjWFNsa0JyblJmZEFo?=
 =?utf-8?B?eGt1MmRVOWFxaWxOQjArZlZ3RjVpZ0hLTGpIbzFmNXFNWXdmMDRuamUvYlIx?=
 =?utf-8?B?c0FRbWVMWCszbnpLc2ZpdERkYlB6Y1FJUWpKd2RDSFdjcEZxcUdNaTJpQStu?=
 =?utf-8?B?UFhmaW1DZW5tNlF6S2luTWhUcjc1YVpsMVVXcXdUSXJlZlFEYXBuVWszNnph?=
 =?utf-8?B?OXNXc0ZaUXF0QjhMMG1PdGM5UWptNmVoSmpyTmtGQ3hCdmVBUmxhcmtFSWdO?=
 =?utf-8?B?NjBFTmxNdHVJdjBUenZPQlRDVnlzd0hkTWN4UmwvVXBQWm1EM1YwSTB0Ymxy?=
 =?utf-8?B?d2VkMmorOW40T1FndVFIaWptdHNHOC9pWVVBVy9Na0tvSTgzemYyemRXU0pu?=
 =?utf-8?B?VzZnYUx0MFZVWVppYjBrQUlXbWM4NWFhckVuSjN5SjI5N3dFM3plL0NaQU1r?=
 =?utf-8?B?Ty9UVjJHUmxiSE9CYmJsbUxwUlhORmRlYnBaSktjeG9MbFg0NzZhNWJHcksx?=
 =?utf-8?B?V3BvVlZWNkYzT08wN3IxWUV3N0tCZkJmbGxTd0xRWThIWU5SRjkwbGV3aGlh?=
 =?utf-8?B?b2hxRkh3WE9kbUtTOE8ydm81L05PbjAxUzNZR2xUNHNoSlVZaUtWRlF0Q3Zk?=
 =?utf-8?B?UHVUZE4vSFJibTdrMHBuMEx6VDB3ZFFPcHpZTVZ5bHlyN1VpdGlXcnhmdW1H?=
 =?utf-8?B?UFBjd284dkZWeEVaS09Sb3dFN2FrWXMrakhrV3hEYS9mNFJBK1h0NnlCUDVs?=
 =?utf-8?B?N1BacExaMnpRWUowUE8wM1BqZGVzUjZNVW5Hem1GbnJwS0ZXaml3d2N4VWJE?=
 =?utf-8?B?MVY1VEQ3R0tnUlVzSDExZytwSkx0WjZrT3FPM2pqdk8vVHFnMUtINFVWZ0RV?=
 =?utf-8?B?aW1ibTlzd2poZzJEZWhLamJWM1BFWFpyWHlrZzYyUWRXYXpxaGJmcHFPcC8x?=
 =?utf-8?B?M2V6cnVTWXBkU1Jra1RWem5uTjJtdnB3M291elBBdHJ4R2NLalp0cmNLakpE?=
 =?utf-8?B?djZuTG5DQUo5OWdtZnhObU5OT1JmL3lMQjh4c1NkK0NLL0N5djJKblhiN3Jk?=
 =?utf-8?B?WkI0Nkw1Z0NEVjE4NzVMUXZUbXVRd3hKa2tQTkVzNE4vQ0NPaEEyTWkrMEJr?=
 =?utf-8?B?SWhlVVlqM0Q3ZWlCMXRMTjhiUCtsVTNlU2VaRFg0RHdlZklYT3I5S2pmQVBM?=
 =?utf-8?B?SUZjdFY5cnU0NDRPQTNuQ1lMUHVMYUtpZW1wVzIzSm90K2VXeklsWUtDb1ho?=
 =?utf-8?B?dTNEUVhxNlFpUU1tYjgwMGFHL3NldWk2a1lRTUl1Y0JtU2lZSnpiemxPSkYz?=
 =?utf-8?B?Y3dleEFOVitqRVF4S2h6RENVNGRSWS9sVFlBWi9KSWt6cEYvNnFFSWtib2xC?=
 =?utf-8?B?WGFvc2kyR2JobUhsZks5ZEFzZ0pqY1o4VFBibVJodVc4TkRWRUUrZXdmU0kz?=
 =?utf-8?B?NTF6MUVQZy9nRkYvMldPN08vMDJmSlB6MzZGRCtIWTZBbzZ4bWlvRm1RS2F1?=
 =?utf-8?Q?DpbBtHHRDjCTToafTO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67812a53-d226-40ab-30b3-08df28d08bbc
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 02:20:27.3705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DeA1G4TYiUuo2cTLFX+4EI7lmQ6FQR7aG8ZiQ8hO3ZHzYxcczturFWsXQAtR/h7t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4447

__discard_anon_folio_pmd_locked() clears a lazyfree THP's PMD before it
determines whether the folio can be discarded, and restores it if the folio
is dirty or has extra references. It is done under only the PMD lock and
the anon_vma read lock inside try_to_unmap_one() and no mmap lock is held.
The temporarily none PMD causes UAF.

A parallel munmap() or mremap() is supposed to serialize with it on the PMD
lock, but zap_pmd_range() (called by munmap()) and move_page_tables()
(called by mremap()) do not take the lock when they see the temporarily
none PMD and skip the PMD. There is no more page table walk after the none
PMD is restored:

- munmap(): free_pgtables() waits in unlink_anon_vmas() for the anon_vma
  lock, then free_pmd_range() drops the restored PMD as bad without
  removing the rmap, so the folio keeps a stale mapcount.

- whole-VMA MREMAP_DONTUNMAP: dontunmap_complete() unlinks the source VMA
  from its anon_vma while the restored PMD still maps the folio.

- plain mremap(): the THP is not moved but unmapped, so the THP's data is
  lost.

In the first two cases, the folio stays mapped, but no VMA that maps it is
linked to its anon_vma. When the anon_vma is freed, it is still reachable
when one rmap walks the folio. Racing lazyfree reclaim against
MREMAP_DONTUNMAP as an unprivileged user reproduces a KASAN use-after-free
in folio_lock_anon_vma_read() as reported in the Closes link.

One solution is to use an invalidated PMD instead of a cleared one until
the discard is committed, but it needs arch fixes first.
1. GUP-fast still follows an invalidated PMD on riscv, LoongArch and s390.
2. sparc64 miscounts thp_pte_count when an invalidated PMD is set again or
   cleared.

To keep the fix simple for backport, stop discarding lazyfree THPs at PMD
level instead. try_to_unmap_one() splits the PMD and discards the folio at
PTE level.

unmap_huge_pmd_locked() and __discard_anon_folio_pmd_locked() are left in
place, unused, to minimize this fix for backport and the invalidated PMD
approach is planned as a follow-up series to use them again.

Fixes: 735ecdfaf4e8 ("mm/vmscan: avoid split lazyfree THP during shrink_folio_list()")
Reported-by: Kyle Zeng <kylebot@openai.com>
Closes: https://lore.kernel.org/r/20261009165214.40212-2-kylebot@openai.com
Cc: stable@vger.kernel.org
Assisted-by: LLM
Reviewed-by: Kyle Zeng <kylebot@openai.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
The proposed fix[1] requires additional arch code fixes[2]. Disable it
first for stable fix. The function will be re-enabled along with arch code
fixes.

Link: https://lore.kernel.org/all/20261009165214.40212-2-kylebot@openai.com/ [1]
Link: https://lore.kernel.org/all/DM0II2QHWWS1.2RXEJXC8S0101@nvidia.com/ [2]
---
Changes in v2:
1. added more details on how UAF can happen.
2. provides more details on why the invalidated PMD approach is not used.
3. explained why unmap_huge_pmd_locked() and
   __discard_anon_folio_pmd_locked() are left unused.
- Link to v1: https://patch.msgid.link/20261009-lazyfree-stable-fix-v1-1-70997958ef8d@nvidia.com
---
 mm/rmap.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 805db93fe0428..1131b76bbbc28 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2275,17 +2275,6 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		}
 
 		if (!pvmw.pte) {
-			if (folio_test_lazyfree(folio)) {
-				if (unmap_huge_pmd_locked(vma, pvmw.address, pvmw.pmd, folio))
-					goto walk_done;
-				/*
-				 * unmap_huge_pmd_locked has either already marked
-				 * the folio as swap-backed or decided to retain it
-				 * due to GUP or speculative references.
-				 */
-				goto walk_abort;
-			}
-
 			if (flags & TTU_SPLIT_HUGE_PMD) {
 				/*
 				 * We temporarily have to drop the PTL and

---
base-commit: 8b38ed9ab5b09c8ba168cbcc49524e9b380ee5c4
change-id: 20261009-lazyfree-stable-fix-67712b2049dd

Best regards,
--  
Yan, Zi

