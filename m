Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010040.outbound.protection.outlook.com [52.101.56.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C99224FA;
	Wed,  1 Jul 2026 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782913114; cv=fail; b=eg7JozzHyAwK706kMRL5a0GEH3I8hpZADnVtcDxBOKYwQeVlydOYfTvLoUlzuIRA49BikKIodw/BsMBvSH9jJlaCM9KF5FkcLn6DODumGZEnIoI/qR8gBX5LQo6fl78baZAxBcBLaXU7dG3bQCOzLRwoj1E7enb4jrTy2cztwxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782913114; c=relaxed/simple;
	bh=v3Ko9inRxKt+0/MIbvNQRT5U66RABoVlnb43J3jug0o=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=UOCocme5TXTuFG7kCBO4xi0NlumH+55sFn4nItGNwYgkjs//NG/uwUbx4mvi5vqbL4VS2TesshaYmVx0DaYDsD8iktuI2yiATaThKySDaQ1DsgnX3br2ZgTqdAvvYtDfxN4RYx49LNOf4vEdDm1b+zwOBhXCI3/CICgU5JkWoN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CCfYDPmP; arc=fail smtp.client-ip=52.101.56.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CCfYDPmP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKMGtDX9o++8xQDUZbo4/+rrhHMGBBlJ1gSe3xQyLsEYyIw1F4ex1tRh/4fEE3bJsswsARg9AsQ6nR7vr7T5dxV0jitHs7GHzlXlVO6XW7GpZdpi+7TXzXDqgh9QYB/3o6sDl4Qun6WVqc7OIjnSgh16Pi1NeBT9bNrewy3VdgXg4FJyd29os6IEbCEQnVhQJjCy7up6MceB0gUJe7u98iBX6X7exAwKJcZi7o52yGWmDzR5eA3VTxiToOwGpXYqwzP0iekG6G9jjAhSuK6hGlDB4u70+FyjTWp2GMoLBmU+GqWjxTKD8ESfpuiCvMKbUleGtdvS3GYIjTdWsrpT4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97kKvDuMLgE2mg/Kfg4bSOvShRt4UaNSJWXybDawUzU=;
 b=pEdSEbAdsWannv9DrMxw+9NYpjbfY/53nCjlBBZJBQaTdyQ+XNvlxxjWbyjFm/KiDIlx3b/BYpLikBubV9aLIlebC40wRSVkoEcm8/b13hJsNndZ2qfYwAO0i1GmPUAhCW0bc4dnE7tHXs3FpiGfm6DaijkwujJJSuEBgA5BOjSvw3UlsvPfScJb+Uwk25w8eOv/KrTHsB+64gTjsiQwKIT6D4hucdiFaE9/jbDFpp4qWHGpdcRZ24PTl2Lzk9FGzhnknCfde22K4COS45OmMRYVE//GGODb3G85Hy71ejTBdLFcTJ7IIMKicpPfTcn6YwnWEWptUVN5amkzarroKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97kKvDuMLgE2mg/Kfg4bSOvShRt4UaNSJWXybDawUzU=;
 b=CCfYDPmPcGOjLMY4hzD3tl4AUzuxdIorTzXZAYMlB1BPHVlvmXtyBPHJ6Vuh1YRU3Z9xq/9ZFZgv7sZHuRq4xXtUa9OogSWGBFfFIYVVqlXRqEKsj1Qb/+ec+NhznFQdXMZZofmqssOteFy/StVHpuLMQg7dZFzHVyOUK9yfkOfaGE7AM2sRGNwQ8fEFjzJR7ue0ohddKqIoCSGcPOiZWGgC+Osnu+qYBjdxC6hshEZzgW1shnRtX+m0QVTMjPBhs3EY1ufUVzidFgP3qPFMQnin3s20lp7Sz/iIuf5Z2s3n9wG6MHgbvzh5kCZVJE90RTGe9xb0eOdm8X4oPKZQOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by BN7PPF28614436A.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 13:38:27 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 13:38:27 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 09:38:25 -0400
Message-Id: <DJN9Y5MG7IZP.31NPXPVYWU5@nvidia.com>
Subject: Re: [PATCH] mm/page_alloc: free allocated PFNs if the range does
 not match
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, "Zi Yan"
 <ziy@nvidia.com>, <stable@vger.kernel.org>
To: "Andrew Morton" <akpm@linux-foundation.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Suren Baghdasaryan" <surenb@google.com>, "Michal
 Hocko" <mhocko@suse.com>, "Brendan Jackman" <jackmanb@google.com>,
 "Johannes Weiner" <hannes@cmpxchg.org>, "David Hildenbrand"
 <david@kernel.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, "Mike Rapoport" <rppt@kernel.org>, "Yu Zhao"
 <yuzhao@google.com>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.21.0
References: <20260629-free-pfn-on-alloc-contig-range-error-path-v1-1-496ff9ca22db@nvidia.com>
In-Reply-To: <20260629-free-pfn-on-alloc-contig-range-error-path-v1-1-496ff9ca22db@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:208:256::32) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|BN7PPF28614436A:EE_
X-MS-Office365-Filtering-Correlation-Id: b07d7fa0-2ea3-4f20-b4bc-08ded77607b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|23010399003|376014|1800799024|11063799006|5023799004|56012099006|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IDy2KN7TKavGYU5AqWEJU7liBZhVhGmpan18uYls4bWhwqxF+432DQIovfcTG8ksaz5x8ZSvh1LJxUvyP5xQ+L46I/gDiUAWBTV80h6/Kq9EwnxPTN3c424EFSsIWAWKOnORslAZq5/yEESW+6yMswnNON8sOr9s3kFDEA6IwgjGsMQQvNGRcYnrFX9EjuwlO/w9pM8u11OtKPaYclImFKDFlwP8uiK5c+yjesUx7g/Q5M1zT78CqJkEkbQg10i2Sywqj+Lbcp3YKL+Ma5RHdB5AC6xLxFTefSGt92fOtGSNEf+LpdPQIXm51d2eYGUJwBbkv5+oGNpoJWsbYAuMcAY3oybOLk6ZRhO6/LD+zmuAm9zWA9BSqmwNc+8Nv7EOMrP3+gG8OAsbmTgk24s4fnAOmLgFMDMkElgagu+3z1ez7Qx47Ex0AmNTeEVjodTyi3oQTZMHUQTLx1cvqPOlNDOcF2w2b3SLJKkhzf5k0w6illktVxRmksWS+C7ViuMWhPrzRGm+iC4tIomTserh5LkatS0Y9C0KEEFkcIPDUc8I1n7m6UyTZnzx2ApHYVq80w6U20n27uGaCQoABPQ6WWl/wCLPulcEtzUZCxdAptsF4c8MaSP/7H5Yap7wbJXaQ1ycgbpk4HP8wV0y2Z1Dz9jJqhaJsfiSzE9km2XA4k2BDGfR2xPe2YnTMGz6i4MbKa110C7lXtiHsL58zdLjLQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(11063799006)(5023799004)(56012099006)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M29BVTIySUpDOTZ2TEpsNWdpSnRRbndTcHVyeG1RYktnWVRwNHZSaDRBdllX?=
 =?utf-8?B?bm1OemxyeDh4a0lMbXB2dy9FRGNydlpKb05VcGpqYXRYVmxZRGhGRGlLb3JQ?=
 =?utf-8?B?dDhwY0w4TlJzbGxHNzBXenFmNUdWR0t2dXNXamdhN1d0K2s4OUdWbytCM0Jt?=
 =?utf-8?B?bm9KbXJVK3VXMGFoamlDYi9kbDlnNjA1L2JMVXdBeEo1am9sT1crYlZSRmt5?=
 =?utf-8?B?Y2pOb3FhT0c3eURqOVBLN1FQclZBK2w4OGx3MjU2cFM0Y21Rbmp4QWRrbUJa?=
 =?utf-8?B?STNvbjh4eEVxelRIQ0VzbGFGNVg2K2I0azdyWm40eGFwMTFDb1hHb0FUa1FL?=
 =?utf-8?B?TmV2NVI0dWxQbWJMSWl3dFhkYVphK1lMYm9ycURiaXpzdFpqUWRmOFJxWnJu?=
 =?utf-8?B?WElUWmY4NUpib0hPTjE4Z2sxL3RiMjBjNDAwYmM5VG9FZmNNUHRHUE5QUWlu?=
 =?utf-8?B?SkxTcFVQbHlhMng2Z3Q2aWs1aFh0YlZGYm5tbzExWCtpSFJxb3JSRmg0bGtp?=
 =?utf-8?B?emtSM05qeEdmVFl6VGE4TE9XMkFOVUFOSUlBWVhxeXNhN1ZPWXpYZG9KZ1Ew?=
 =?utf-8?B?TlNEQzU2eDh1RXQ3Z2hvSERPSDN3cnROeGdDUmIzeXluZ3VlNUsxZWZlUUE3?=
 =?utf-8?B?dHpnYW1pMjVkM0VzMEFMSG5HQlYwVTlyU2hYMjJjR2d1QU9xbmJSRWRiSnUr?=
 =?utf-8?B?bFdodjUzYXBNOWQ0VFlLQlFnQk9Dc3hsaUwycEZyZ0JUTGdpN2NBN3J3bDRG?=
 =?utf-8?B?VXpWNTkwcUl0dmQwQVRScXVUZDB6ZUFSMGYraFh2dnNGN1VtUWt6ZXVUK29s?=
 =?utf-8?B?bWdvcmFsQjJYczA5VlE3eVBzNmpETlJXWkNGUUhYdHkwczNZZmZiUkRZT0pN?=
 =?utf-8?B?R2VtUWlHMisrZks1ZzNNSWIyS29kaDlhMzdTZjF0RDJIWjFXQmw5eklmRnFy?=
 =?utf-8?B?aThWRlJwMUlCWUZYbHlWdlNXcmcwU3VzRHIxN1dLaU12WFBtUzBsSlVNNkV1?=
 =?utf-8?B?UXkzL1BOTlI2VXBLQjdLTVVUN1I4d3ZOamdsKzF0allNZDVlY3hnZ1dTUjZ0?=
 =?utf-8?B?MHJ0akJLVHJIbXNpN1NieThCelJUK09kMDZiRzZxeWdVVm1QSEdJQ1E4bWdG?=
 =?utf-8?B?RjU3eUxUU0pab3VIK0F3di9FckQxWk9wVktRdmFjUmZsVW5uZWdvYWtvdS94?=
 =?utf-8?B?bHVnWmV2SVNCSjIrN0RhaVIvaEc3QUFYUXR2UnJiNmFEVHpBV3lDSmlieHpW?=
 =?utf-8?B?NzkrYlVpNkFOYXRJcmNxdEkyTm5vN1JxQXJvRGt1QmFldmMrbkpHWC9yMjZt?=
 =?utf-8?B?TTZoQ01RYmxpRTJkNitqTVlKSllnWDFOQWx1dkFrUWUvVTMrc3c1VE5xa0hB?=
 =?utf-8?B?d3RiYWlWcFNRUEs3ekxKR0lTdzRncnJvNmxaK0RyM1JLVit6d1JPV2xOdXVX?=
 =?utf-8?B?V1NldlJlaEdsT01aUHBwTXJOYVcwM0YxNDlZQVJJdDhrUzBsK3hKUmlWZUps?=
 =?utf-8?B?Z1BqbFhBNGc1K0ttdUFCT3pvWXhjcnBXa09VTHRFQllvKzl1ZXVQTzdZNHhv?=
 =?utf-8?B?LzMzWlBMWS9RTlJtTUNKSVRkZ3hOT29ieEFobjVLNG9YOGpNOGk5a2lOT0o0?=
 =?utf-8?B?Vnhkdm1CdkFDTjcveE83OGhKbjN2LzhIMi9EaW5JTnd4c1ZSWEpLdTZsRUhN?=
 =?utf-8?B?TmdWT09yV2xZRmhoMjNSeWU1Vko1dEZNdFVYSDRLM2YzUWZqSXp3YjdqR3Ar?=
 =?utf-8?B?T2FBK2d6SW1lZzhHdjVGSjlRMWw5ZmxIRTZiV3p1OFc2WHpBdVpjdWpRalND?=
 =?utf-8?B?dUxBb1ZFNndtOHZET3RTWjRxYWdOaXJUNS91V2UxMEorSUMvZXBUL0ZFQ01X?=
 =?utf-8?B?cHVIK3RyY3dEaXFHMFFNc1ZpZUpsOUE4MGo3cU44NUw4Lzl3cVVRUWlQYmZq?=
 =?utf-8?B?R0JaRHRNOWZ1eVhUbHhqVE5HaTc0eFpnTGp4NmwzM20rTkJNdzBXNm4rS2gz?=
 =?utf-8?B?Y0ZTTDhQdW90a0dDOE5iM3UzVGdiZmlvTjZEazZpWUtabXNLSk9WQi9VUmdy?=
 =?utf-8?B?bU5HS0JpdWpYbkZhTUg3OGhIVFE3NVdnbjY2eVdGeFN4cHorUkNicnI5T0Vh?=
 =?utf-8?B?Mk42ZHFIb0NJWkx1clNaYkZRdHJHOXlMTFY0WDYvREtMMk1ncU9vcWpvY25Z?=
 =?utf-8?B?eER5Tm5GSUp6UEplOEkxS0NpRzg2OGlpODR1OUxTTDZVZEM1aGtIWi9NcTlv?=
 =?utf-8?B?MXJxbEd3WTk0UEpoQ3ZFSGJKK212WGVMaG43dmlXbkJ0L1RvVk0wN3RrT0J2?=
 =?utf-8?Q?uQklfAqSwcjk8aThh/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07d7fa0-2ea3-4f20-b4bc-08ded77607b9
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 13:38:27.0576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bl3Ico1AutZrOsy9N2zpNQkGm1CnOhWMA06X5xffsWn1LW17Q5Au/e8z6lKI4h4U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF28614436A

On Mon Jun 29, 2026 at 9:35 PM EDT, Zi Yan wrote:
> When using __GFP_COMP in alloc_contig_frozen_range(), if the allocated
> range does not match the requested one, the code errors out with EINVAL
> without freeing the allocated PFNs and causes free page leaks. Fix it by
> calling release_free_list() in the error path.
>
> The issue is reported by Sashiko[1].
>
> Fixes: e98337d11bbd ("mm/contig_alloc: support __GFP_COMP")
> Link: https://sashiko.dev/#/patchset/20260628-keep-subpage-private-zero-a=
t-free-v1-0-f4ce3930d10f@nvidia.com [1]
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Cc: stable@vger.kernel.org
> ---
> Sashiko reports that if alloc_contig_range() with __GFP_COMP cannot
> allocate PFNs with the given range, it returns EINVAL without freeing the
> allocated PFNs and causes free memory leaks. Fix it by properly freeing t=
he
> isolated free pages and adjusting WARN message for clarification.
> ---
>  mm/compaction.c | 2 +-
>  mm/internal.h   | 1 +
>  mm/page_alloc.c | 6 ++++--
>  3 files changed, 6 insertions(+), 3 deletions(-)
>

Hi Andrew,

I agree with David that this patch is not a proper fix to the issue.
Please drop it. I proposed an alternative[1] and want to hear David's
opinion about it. Or like David said, this WARN path should not be hit,
so there is nothing to fix.

Thanks.

[1] https://lore.kernel.org/all/DJMH7EKQ3SBB.2REYPX4LVFFTF@nvidia.com/


--=20
Best Regards,
Yan, Zi

