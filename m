Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012000.outbound.protection.outlook.com [52.101.53.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9323CB2D9;
	Mon, 22 Jun 2026 16:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144885; cv=fail; b=BcWqi24/TKm/6xhM1c/HNCHMK+FCap2Twe9zKstHZQADF9JAeqF7loHE0S6SBVfNIVzuKjJS8z/FqKQCmGpYQ2DfqWirmOllsDlhEdw15wbJ3BRIJCMpBIzBXSOSCil2NaLJJ2T/ypsgl1bWHckrVOmyvcei/wONpI0gnP8vjMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144885; c=relaxed/simple;
	bh=1Rk8uUxIOKHFKIJH60IxeCjseqJpOKsu7Z+PycQHF3U=;
	h=Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To:MIME-Version; b=euIVdaOn3OqcCyvhunxKGr5ZNLYEDldpNvr0nJq+wxLTasl9q7Fu954o5NKElBBQTc/IqUc1YUOPQXBT6Q3Jpvoq74R72OWhTcmsArqVIb326uIcOBkZIwoeVDWQlDa3l7YR/69alQ4KCWI/WviKivcgcZhjDgZ9Y3Xo7+Q//hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T+74WsQ6; arc=fail smtp.client-ip=52.101.53.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T+74WsQ6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9pYv0rWTwwwH+NiAym2yHLOPoWwjPMgPRIAmUgjLpbo/S9B7FvAcqopy0d9S3ld44XH5sIYKhPZIIy1nPgr0gdAQRNjlSrrk7hCFyLkUMCHtG/kqsedoao2HseQfaj/cgj4M9r3JzjZRU9cZZHNBKQ+J1F3ftuqaf2+y8Qv2PlUIqXscybruW2Dr2rUOuMytzTbUG+Hjy9ScP/9gIDMQn2TAvNwBg6+4hdIEQ6i0td0XEfOKgKKxPi2BOAuTWpuV3O9fn5CNjSNHYMYOjHHghDqigFc1JVh0gfEpnyA2V3mI3bu1O51e6h7bzZMX4S/MarXLjwwVrzzKJTkgPH5YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZ+1i3lmJhAxC74zGrRx556TCzq6eS6pgxdNOKxZoxY=;
 b=X9gd85rJ/eAF8VRe6vjFxcw+IPefiOPoGNdIASIODqzcLsRH9CfyqDvquxwajrIPAFGEw7H409NUSPU6IcNiQ6ZJ1Kpw9wH7MYQyd/uOQwj9MbzZ0mcTyyINsMI46ffs6A7fjDaBkh3Gv8ijqTJHFmRSIusLCvRAA+bmU/Xt+mk6B1Y7RToRXRjZt7qOVBK3m83Y2WgD6VzFfUbwquupvWl0v9PgzoMfRLZQ1+qlTYkuw6PIp0c6G5A0WigZlTFbPTJL5G0vWbk/CGlU9btvegEFaWbfRHOJSuvO7a4Jn+V5J7FMSqBGzwV8aNZ6lp7hyLw+7rokmvCPzojJAzJn6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZ+1i3lmJhAxC74zGrRx556TCzq6eS6pgxdNOKxZoxY=;
 b=T+74WsQ6sx+kOmo/I8pQ8YNS6TNPBVJIX5wRtSMHQJGR7pzEFmB4e0ukjnIhc36sJ6dIHh8wZZKb0MpH7NBE3qNT4kR39H9/T+qOmbwyrVJi7YVis6k4S47AszcMf2QbX2CzBTDIZ0WH8c5T8suBIEHVadNbaiN5VSOy2hlGDHKNWPbT3yIUFBF8+xlE++66sUP3J1Lyz7Sfko0kDEsnSzI2G0MDWo3P7j1XrIw/PXqUwCfiLvOHM1247wuLLPVP81O3hhRl1RuzhCNnFsm+1L7/E5RIJ5a2NUHm1m4Cl96B3RlIb8WD7OfDYoftYTZ7+92hfvwH7FEXZ85k16jqaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by MW6PR12MB8661.namprd12.prod.outlook.com (2603:10b6:303:23f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 16:14:32 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 16:14:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 12:14:30 -0400
Message-Id: <DJFPMRCQLFCR.26LI8DHU9YSJO@nvidia.com>
Cc: <kernel@oss.qualcomm.com>, <stable@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, "Matthew Wilcox"
 <willy@infradead.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, "Mike Rapoport" <rppt@kernel.org>
To: "Ketan" <ketan.kishore@oss.qualcomm.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>,
 "Brendan Jackman" <jackmanb@google.com>, "Johannes Weiner"
 <hannes@cmpxchg.org>, "Luiz Capitulino" <luizcap@redhat.com>, "David
 Hildenbrand" <david@kernel.org>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH v2] mm: page_ext: add count limit to page_ext_iter_next
 to prevent invalid PFN access
X-Mailer: aerc 0.21.0
References: <20260622-page_ext-v2-1-135d4cfbc42f@oss.qualcomm.com>
In-Reply-To: <20260622-page_ext-v2-1-135d4cfbc42f@oss.qualcomm.com>
X-ClientProxiedBy: BN9PR03CA0466.namprd03.prod.outlook.com
 (2603:10b6:408:139::21) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|MW6PR12MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ddf4978-fe8e-4dcf-edfd-08ded079581d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	5ezjx5oGP3/HLc4pyKy/XjkGqTjnB6y5rY64T8olvrQjFgtj0vLzUCr/IsMUj32fRr4EWNM6EAViDrF2IgIVx0CJE4hVzu6yn9E+62YxZCViovldqipAlr3oPPqZca3piljG9ZlAJmDQQ/CoLT0j/CGsvf+lTRkT/X+s/BYhEcaxU9RGH5TUNGZE63Zv3r5LcW2JylGw/RDWTOPZLKRY8aqNnSNUsksCw4K8kbrR+IBa7Y+3EwSAZPr17K02XRDEcgLgMiah2GhzKIAlIbpz+ntan3MKySlv5V4awGUX47Emq/2l8iw/95iZGMybcIEQoivByLDJDmhj1Lgi0z5qH0CF3rwBknSGnWZMoF7QIwW5NNCnVafl5BrmGD7Y5RXArfd6ZAc+Qbs7N/N7DZDrJYmuD7kvNvKl/GLk7FVVL3va71Bj6g1T17+Vcvh5HGa+37wloQ8T9UDeeFslzzNYMpKb152BqW/MmFUm3tXwdaUeWV/Y9qcN82DSwB1xZQob9qC8aAV74cAEx9t9bpHpfHICWju/Zc4QzOcmOop5bTjuMG67k7Zl2Tt+WEsZJZx7+P8kZOZIN8DNUeSNplujRVd7h42fG/1nFrIfaUOOjpGmeNARAzyhq1Q0TSvegYuQq/axR1pzVK3nRdjXVCO6BI+Berp9Q+/BNUDsyr9ECRY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXBCencyRDR0QlZTOTRFYXl1UEJDaEkrR25hZUZuOGZSUnpUT2Yvd29hd2dv?=
 =?utf-8?B?TTBFOEZzeGQrTm41MThFMjU3dFowdzdZMUtrSTVhU2pDNjFKOTdWUGQyZDAr?=
 =?utf-8?B?SHZMYXV6Y2dxUUJ6R3VTQ2t6UG9JZGN0VDFXVzB1MUZZa3kzOEtqSDFCRHZE?=
 =?utf-8?B?UEk4VlJjTUp2ckRETEtyang1aTdYOVg5WTBSNHk5SldNeS9qNHFCTXV4eDRx?=
 =?utf-8?B?VXpvdTRhTCt4OEpSZW05TzNRdW16ZE5pVmV1L1ZEeHBWK0hvRmJ5QUk4RXB3?=
 =?utf-8?B?NjJZUFIwbFdZQzBiKzl6TGltVkdMTlpQVWtQWCtjUUk4UW1HdW5yVXB2Y2VF?=
 =?utf-8?B?U0F5b096blFFbDlzWUhZR0swa2F6Z0pEaVpJeVZRcUN3RjhaNVNMeE00S25U?=
 =?utf-8?B?Mkc3ZG1SdCtrTHhRZGxGcWVhZ1haajlMdE5mM3prNXh1akpLVVltOE8xK00x?=
 =?utf-8?B?WjJPdnpaL3M4RDJRZzhYRE1ZdXN1Rm1jQVBtYXhoa3ZpbGZFU2JibzZLQkt2?=
 =?utf-8?B?aG5wUlc4OXdXUkl2WElIZUdCenJRTkZ0OTZwY0N3VDUzalUyOFBVVXZEbTR1?=
 =?utf-8?B?clBtZ01zMzJDWVp0S0R5TUFsTFFSSnJvQmNVaVNmZ2I5VE5MOEdkODU3WU1L?=
 =?utf-8?B?V0J2VHhBbjhtaVVyOWY5dDRJaTdYaVh5YTlkTkxMRmg5KzRtZHpEdzZqVWov?=
 =?utf-8?B?cmxFNWYyejNWZkhNQzhRUU9scmtTU3R3dWZ6bE50dCsvRHQ1RGwyOU96YzRx?=
 =?utf-8?B?Wnh3cGYzdm5paHhXVHVKaG1kZDI1dlR2S3N1RzNKaHhJN24zeGNock04ZDZx?=
 =?utf-8?B?L3Z0ME1nUGlsbkpIaEN3QW9WYUFkRTRvMzgwN0NaNVF0ZE4yRXVIWEFSYVZv?=
 =?utf-8?B?UEhmNnJNbElwU0thbW9nMXdEWDRNNEpzRExuRzVuamw0bUt0RVczc0cwTFlF?=
 =?utf-8?B?V3d1RTNDVGN2TEthTG42YlZOekRYdW5RUXVvbmxwaGlERHl4U1A2azNVYmpN?=
 =?utf-8?B?VHJhZTlDUU9KSit3Z1Z3TEYxa2kveDdHKyszVXhuQ2g1NXhqdVhacG5SQktV?=
 =?utf-8?B?RlppRkpXYmdXRndVaTFtTVQ2cFhnSHhoQVBRWitmNFYzU1JsckpwSThPNFNj?=
 =?utf-8?B?QlFnalo5RVZHZnA2YkNTTlQzT3FPQjNoek96cW1QbEhnNXRYNVJ5QmxGMHJu?=
 =?utf-8?B?Q2xLT2NOOXoyUXJvaEJ3NDI4U3N2UEVXeFd5TjVNSmRuTERKYkllOFVzRXli?=
 =?utf-8?B?eFVTUmJQRXZNY0tzQm15RXFEREUzTzJ0Vk04YjZCaWdMdWIxVXc4VTRiNnE1?=
 =?utf-8?B?Vk9yTmtoS0FlYlhlUnI0UFJScnRLMm5RakpsdjVaMUhkT0dwZldaV2dRUEl0?=
 =?utf-8?B?Z3VFNDJWWWdLcXdXTkdMN1BGNGhOaEF6VEtBUkg0RHA3MHJRK21BdGRKWC9r?=
 =?utf-8?B?ck50dFJ3OW1WV1luMUIxSk0yYisrb2tpOWFXcDNTQjJPNThlenc1ajA2UStF?=
 =?utf-8?B?NG5FeDFrajBzS01HWjlhK0hVTkU2Vm5TYUZXNnpsM2tjbnBxYkxsMTRWYjRO?=
 =?utf-8?B?UlpUWmk3SU9iVWF5TEdEZU9YN3BubWdYajZzcHBMVXdLZFAvQitRRzdpNnFl?=
 =?utf-8?B?SEdRVVdUTi9VaFh2aHVDWm9hQlU4NXZxMTVPdlNib0t1NWZDZXpiQ0taZ2hC?=
 =?utf-8?B?ZTR2Nm9PcnZuNVlPWkZSZDh4OVp6TEp2Ymd6SWx2WVQ4cmdySGR3ZzlhT2VQ?=
 =?utf-8?B?cWJ1NXRQZnl4OXZsVnE0QnIwWVh0cHdzZE5lRDA4VUNxcENRblRzckovR1Zo?=
 =?utf-8?B?ZTFrem1jNzZNVkFuSDduTHZaQWV1TU5rTTVpUVkveDdYUzNDS2xBYnczVG5G?=
 =?utf-8?B?RjBpUzRYUWhXN3pGblRLc0ZIV0R1L1NnL0FYbkI2dGptOTFkRWlDcFJKVXdD?=
 =?utf-8?B?ZjcwekNxYXNNMFdjeGJ5ME9XVUEzUXc4RWR2TTM1S01WZjlQVXhYVnlUOXdS?=
 =?utf-8?B?aGpNZmd4TlBpZEdsblprcjlIQXJ2RExtSXZRYmkzclMxRkhKTnJOTklvcEJQ?=
 =?utf-8?B?VzBDVzJJc3gxRFBtbE8xR3R3ZEJweDgrNzFaekhOL1RJUFNoN2I1bHp4RkM5?=
 =?utf-8?B?MzR1UlpuMUxBdlRycGpCWU0xZGQ3WDRUUUlJUThUUE1BR0E1Y25WbXlzVHVv?=
 =?utf-8?B?Q1gwTFRxc2V4dWlSZjZrbURqdlZnVm9xOCtSbzRybGZZeU5WVFBMY051RUtV?=
 =?utf-8?B?Qm05RzA4VUo5ZldRcUEzUmNCM2hDRFR0a0pjOUtENXpvKzFrdDdNVXZwVlNO?=
 =?utf-8?Q?4gNTgJU+S+xLCHcjDX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ddf4978-fe8e-4dcf-edfd-08ded079581d
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 16:14:32.2345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /mYERY/THf/Yh3n9PyW74nqE+NiZUfsmLySDep7tXdweXIky6/ViiET2FK/mp1FK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8661

On Mon Jun 22, 2026 at 10:14 AM EDT, Ketan wrote:
> The page_ext iteration API does not validate if the PFN still
> belongs to a valid section while advancing the iterator. When
> dynamically adding memory in the hotplug path, it can lead to a
> NULL pointer dereference during page_ext_lookup at the boundary
> of the last valid section when iterator count equals __pgcount.
>
> The for_each_page_ext() macro calls page_ext_iter_next() as its
> loop increment. for_each_page_ext() does a
> "__page_ext =3D page_ext_iter_next(&__iter)" at the end. This
> causes page_ext_iter_next() to increment iter->index past
> __pgcount and call page_ext_lookup(start_pfn + __pgcount).
> During memory hotplug (online), the PFN at start_pfn + __pgcount
> may belong to a section that has not yet been initialized,
> causing page_ext_lookup() to trigger a NULL pointer dereference.
>
> [   14.555124][  T846] Call trace:
> [   14.555125][  T846]  lookup_page_ext+0x6c/0x108 (P)
> [   14.555127][  T846]  page_ext_lookup+0x30/0x3c
> [   14.555129][  T846]  __reset_page_owner+0x11c/0x260
> [   14.571201][  T846]  __free_pages_ok+0x5e8/0x8e0
> [   14.571204][  T846]  __free_pages_core+0x78/0xf0
> [   14.571206][  T846]  generic_online_page+0x14/0x24
> [   14.597782][  T846]  online_pages+0x178/0x30c
> [   14.597784][  T846]  memory_block_change_state+0x284/0x32c
> [   14.597787][  T846]  memory_subsys_online+0x4c/0x64
> [   14.597789][  T846]  device_online+0x88/0xb0
> [   14.597791][  T846]  online_memory_block+0x30/0x40
> [   14.597793][  T846]  walk_memory_blocks+0xac/0xe8
> [   14.597794][  T846]  add_memory_resource+0x280/0x298
> [   14.656161][  T846]  add_memory+0x60/0x98
>
> Move the iteration boundary enforcement inside the iterator
> functions, so callers cannot inadvertently access beyond the
> requested range.
>
> Fixes: 9039b9096ea2 ("mm: page_owner: use new iteration API")
> Cc: stable@vger.kernel.org
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Ketan Kishore <ketan.kishore@oss.qualcomm.com>
> ---
> Changes in v2:
> - Incorporated comments from David and Matthew to check for invalid PFN
>   in page_ext iterator rather than checking for NULL section in
>   page_ext_lookup.
> - Minor improvement in commit description to include the issue with
>   page_ext_iter_next
> - Link to v1: https://patch.msgid.link/20260617-page_ext-v1-1-37ad802b1a3=
8@oss.qualcomm.com
>
> To: Andrew Morton <akpm@linux-foundation.org>
> To: David Hildenbrand <david@kernel.org>
> To: Lorenzo Stoakes <ljs@kernel.org>
> To: "Liam R. Howlett" <liam@infradead.org>
> To: Vlastimil Babka <vbabka@kernel.org>
> To: Mike Rapoport <rppt@kernel.org>
> To: Suren Baghdasaryan <surenb@google.com>
> To: Michal Hocko <mhocko@suse.com>
> To: Luiz Capitulino <luizcap@redhat.com>
> Cc: kernel@oss.qualcomm.com
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/page_ext.h | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
LGTM. Thanks.
Acked-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi

