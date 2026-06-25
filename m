Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011017.outbound.protection.outlook.com [52.101.57.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521233126CA;
	Thu, 25 Jun 2026 19:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782416361; cv=fail; b=K8q/5QN8qJNPuLb3jTd7q1sdaLVKhBC2t2zqj2xE+6kkwOlWWY5MOnjdvt/1GGwszwxquhXMKPE3VvjQ/owxbFHDln1mqvLLxYJg2j39VLFfz5MobyqyqoeTtA5IOxtZtknNniw9vIuHbuBq8FACeW3e/5g6xC5YFj4owMeDzHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782416361; c=relaxed/simple;
	bh=aUVysc9lyI+xE7uUX13zEsStqqWIrQtQoXscuexnLgA=;
	h=Content-Type:Date:Message-Id:To:From:Subject:Cc:References:
	 In-Reply-To:MIME-Version; b=HhRzXe4PpA63JTQtPhZLCvSS+e3Y/6OSaJkuJ7k7p1Dp8Nv6ICRhT60RH0aY/BrIHzfk4HpDu2XNHrCX0iVaCmd3w9P2WFI2uwewQffai2hs7Adf4zgNBbXZ1c8cNro8iz16rfh82LxlsgBn+dBfOsmi9OfCW8Gx40vblum7hTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ofQUhgUx; arc=fail smtp.client-ip=52.101.57.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ofQUhgUx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DxGRRVM/ombrB9EESt7d2cQ5jcUYaM1yDwuZkVC3G6BGfhFq0qbJdzx+HwV0crg9w6ipzLr8mfsXCZDxIiXdtkCX+P8HduQylppckLaTWDMq3Rh4jwcGqtNtQv6elRtc2jXQpXSD1UiQ7My8FjDIyi3wD8hVISfxFxBYNysinYHtbX/NXuXShsQzOz0ps/i/6vKXJl+AhCwlLgCFkWwHA539zl7NUuR4vOLyiuuTP/gsvoMaFOGrH5R/kzGCy1krao3YguLrtC+V7zRmdjN39VJK7DPADmk/QaY9v99HF8ZcX2tRIZMUCT3st7EBrbvBMZvvDGfMsWR7sDQa+xZ9Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8feXrMBtpkQVYwGFK5wI1XRp3CObZt5XsZlgI25RUwQ=;
 b=fCF24HLBH/UQOgEENJ3QQ6wz9T6QJcYWDM5DmjbtIYMhoR3aHjPjFAbC6AzA32RZvxdNwXWQsbq9Owgeln1bwqGowGMDaEFkSCGd5K02xZ9SK2/2GKlcwVKuc4KRDziYBdKpgn1wXOWLk4v2rS45UknB2UUJmc+SuVVC7wauXy2ij1ymmyiOg2GrspwjtCPii7hSH8TqXtpKk2M9SamXYMhEbAcBMEvDbW052x9lIB+HRVsfxAKX7T69dQcvfYc57WnHCbcXx2F5ScG03CCV1u69XDtRueS3biOprMheG5hg6mVA29beEKemqBBiZW1LFRU46J7HsqjacpD+JL0uXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8feXrMBtpkQVYwGFK5wI1XRp3CObZt5XsZlgI25RUwQ=;
 b=ofQUhgUxtQ4/tjIRwbPNjAApMCGnuqUIA/Je6ySfwAOt8W/gECVs+4PMLtlgaQANlDtHNKfR/wtLpUXErN/rFGjPB7ge2SV4vbjLERIV20TpeHqpIlcp5uCLJRkA2jKlDu3Ji3M0UPP6F3+YfuEahruYTYtiF9xbwmLqmGAIeWULDhv8bGfi3H4R/2OU/F9Nj85S07LqxrT3vqxX4Y5ezwYZT4FJrn6ob1H+Grl1uzDGpCYPLKtQ2CV5S3UEbGAm0znOUKdq8AzXeBf3+JyZsEW25bikYhgCqIXzGgDnYKn+Xv41XbVkxld+Db5c2OqAOTgB586bkFarFyG5HB38RQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CY8PR12MB7436.namprd12.prod.outlook.com (2603:10b6:930:50::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 19:39:16 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0159.016; Thu, 25 Jun 2026
 19:39:16 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Jun 2026 15:39:14 -0400
Message-Id: <DJIDV5DKIKAV.1D2ELFPGLIOSP@nvidia.com>
To: "Wei Yang" <richard.weiyang@gmail.com>, <akpm@linux-foundation.org>,
 <david@kernel.org>, <ljs@kernel.org>, <riel@surriel.com>,
 <liam@infradead.org>, <vbabka@kernel.org>, <harry@kernel.org>,
 <jannh@google.com>, <sj@kernel.org>, <balbirs@nvidia.com>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [Patch mm-hotfixes v4] mm/page_vma_mapped: fix device-private
 PMD handling
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>, "Lance Yang" <lance.yang@linux.dev>
X-Mailer: aerc 0.21.0
References: <20260624065353.1622-1-richard.weiyang@gmail.com>
In-Reply-To: <20260624065353.1622-1-richard.weiyang@gmail.com>
X-ClientProxiedBy: BLAPR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:208:32b::23) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CY8PR12MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: cb293914-c08c-4f6e-0eb6-08ded2f170f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|11063799006|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	lxPygt/faqCvIN+XcLbPtYd9Qgfc5WxMYMZ+3LqcBRgv5qgN9byWhlZTYDX3rFxsYoJ2nAbGYtdrGnsNNPefVX45axSeNkLI4OYmt/Ak3yXop/+4y61qDZnLHXQ8YByAf2rIn+V0IK1hFL5YHTF5mwSUgr1iYroOdSnDuyQzSp0zeCtSMgBK2ZofBWLNTZhcyo4lkyUio77//PkSst7LMxjjPwG8hqgx18GMP42MK1y9Z+BRUEj8GbqQjjIgSBzGWo1Y5JmXZE9PusJ8gFRpJiGGanvlVNqiVWGZVmN2qar7B6Xiny9cBLn9WF+oMtMT7BAY8/EAt0CO6YDUYVTAOMbpu3HUiuKRzQrA11LF43PGTIwCN7JCDgPJf8HHJ8dvwD/u8OHifRIRoi+fqv7sh07y1T0dytIXAiSSEz6mFrArmoO4N8u9BttKTk3YmHtQ3pqh/Yp/DEzYthHACJAXSC4Dk8cC6aVyd5zwNyfGTTQbuPcnd/wNrHFgGMEGddoPXFn6eJIwlWoYl0a3fuM77UrdoXw1vv6s5MeJPNC7SRGQSYUsHsTmzC5yPcAZ3ktfFpwp6kTzy+PJpfpnwvWPkxFFB87x1hzsnWI0b8sbz8R10cb252VotON6fsjtegh+LSBSYR9AJAEVt/KGbRxe7xgJ9X75EPfI7aB5YAd+q/Sv8Wr1ADGerVZaGmd26HUZ+N+dVjrg2NaHNB5P3DINdQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(11063799006)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVFkYW9PR1NYd0hEZHZYZCtGdTBwK0VvOEtLNUw2dG5adDhVaUdWSmlGa2d4?=
 =?utf-8?B?RTdPeXg0UmFqVWhVZlAxQjlEakFqdGVqNldaTVEyaS9YNW1NcUZRVGZhTDhk?=
 =?utf-8?B?STloU21OL1RCeDJkWm1zVldySG8rcmU3L3Z3TkE1Zys0WDlCa3duc2dDdVFJ?=
 =?utf-8?B?dEtoY2IrMTdwZFNzb21rU0RSVmM5ZmFwMzRyR0dhZTFUbDJmcXdWcTNCdEJF?=
 =?utf-8?B?eDZIL1hKK3RVanNDSCtpdTdJcXlzWk9NajRtUGd5TUlOR01YbUw0UEdEbXdm?=
 =?utf-8?B?NVFPQkxZUGQ0N0ZmdUVWdXZBUWcyMWZFVHQrSUplN21Zc0JlYlJyR2xqUzJk?=
 =?utf-8?B?b01WVW1wOTkwOEpiUks3dkVrc0JhR3Mza3BMTDN6QlQzWXhacGZQK3liRllh?=
 =?utf-8?B?NkthQ2pTSWtZYlZ3dHhPSVRkYXB2SVJsTUl2cEQ1L3pTRmlta3VJUzNXWUlk?=
 =?utf-8?B?ek00WDAreEFsdVY1Mm1tWElwZWI4RVhtVER6eTNEYWYxTkgyVXZiYVp1enFk?=
 =?utf-8?B?KzRmSGU3T3JMWHhVc09NNURkSzl3cUhtRkNoSXVXN3NZeXFRZ2lUdjR6M2xO?=
 =?utf-8?B?Q2llOFdHaE1GTFRUTDZld0lNbVBKek11OTM2eHJGakY2NER5MnNBeEJ0cTZu?=
 =?utf-8?B?NTlRSWdyajdwa0V1b093NVlxdVYzMXUybklMT1JyaDhNNmU5YlVvVTNJcTJr?=
 =?utf-8?B?eUtGZlBvTjZZRUlRYzBvS1N0L1QxeWFVcEFqWGVVQkFVNGcvWG4xbE5RTkJj?=
 =?utf-8?B?eDQxVnUxQmw5T1VSdVNhaTFtbWRYK3lXZ01ucHV5cU02TUcxQmZZUkRuZ2kw?=
 =?utf-8?B?WWZvbklvNEpaYkVQV3phOG1MT0tEV2U5QUZCdElCNUdCSE01amhpVHdrenND?=
 =?utf-8?B?WXhJdmxTbWU4d3JGUlFxRURRWFlKWmlOZUl2L0VYcWQxOFZIQ0xiMDJWOWZ2?=
 =?utf-8?B?NnFCeWNKdkl3K09sRUQ3TTFIcVJNeWZqNHBJb29vUjQrMW9KSFVQeS81Zk4z?=
 =?utf-8?B?ejVpeUR1T3lGM2YyRUY0a2JoZmVLcTJPNDFnbjBmMHRwWDR2aFRPTHppV3Ri?=
 =?utf-8?B?NENldzdMakJOM3JXTXcvM1NwYk5RekkzR3R0QTAvSWR0RXc4TmtKeFF2M2hS?=
 =?utf-8?B?cGJpODBrSGRWaFlIV0RaSzg2OTZEb0JaTURkTSt0T05vL21za0M4UnVROGRi?=
 =?utf-8?B?RGVPVzl0bG1sT0FrdDJQWFJjUHFKSHVNelRoQit2aWlpcDJGcTd5R3pNRTc4?=
 =?utf-8?B?VzNkeFlvTWRQek5jNXpTcHF6SWVNaHNkdlBhLytZNjU4cm1uTUhuVllmTmJ2?=
 =?utf-8?B?ODAxVW4rWWkxL0prVUc4bXc5Y04rUTFEUUQ5b1RwZXo0ekRPWHM4VnVKZS84?=
 =?utf-8?B?cHhvRkhobHhsVnlPSVk3VndicDRkMlpwY1JsVHZ0TUV1M3NxcysvT0lXMnlh?=
 =?utf-8?B?Z1pvbzBwTDNlKzh3YW9xVnozZWhpZnB2T3N2aGlaQks5NjVmc0hEK1lVK0ZY?=
 =?utf-8?B?L3ZaWG01d1hLdTF0Z1VPVFVDbFJ1djJ5RFpjUmN4dDJYS011VFl3QVdSaG1u?=
 =?utf-8?B?YmFpemYwZk5CUlJsQy93cVNGenFyb0ZWbkw2MVNPb2ZseTZBbEhDRDNnVWJC?=
 =?utf-8?B?R3BNRlBIRXQvOUtoTGxNdUtzbVR3YU92d01JSW9PRVhIZmlDYXI1b3NyUEhZ?=
 =?utf-8?B?K21kVzQxTkcxNTZpaGNzMTBibldWVjVnN1Fmdi9hOU4wZ2FXL1dPNllSbzZk?=
 =?utf-8?B?aFhUQ2VVaVZydStNOFo2ajBoU2tqcXUra1JlOGRDUUtwNmVobjF2RzFMRXhl?=
 =?utf-8?B?OWordUlBSzk0VnNvWFV2Q296bnlOb3RORFhSVzJxUWkwNXBjT01qb1FJQ3V4?=
 =?utf-8?B?dEJmSCtLZFJiNFVBWHJVK29nN2JySWxLeGxrWDI0ZXRwNzRiZ2VaazVxMzg2?=
 =?utf-8?B?MEFxcGd5aFErSFNld2dzb295VGdwaHk5NUU4MTg5Y2g2UHJFVFNrblE4a3JT?=
 =?utf-8?B?cEsrN0lHTVMreFFHV1BId3NPME0wMEhLekVvOTMwT2N0aHZ2bGh4WnpaRlBX?=
 =?utf-8?B?bmJSSXg1VFFBeGh2VkxZWlkzYWtYOXZzVlE2N1dNMjIxZTVQc05tZUVJL01H?=
 =?utf-8?B?UWVPT2RPZkZkUWQ5QWVMZEdiYTY0Z1hzMW12am1BKzdJZ010Z25icjZlbUpK?=
 =?utf-8?B?Uk5Pd3h6RlJDWEcrTjVLN0ZvY2Fnb1Yza0JhblhEY0hUelRXSmdORkwvY3l6?=
 =?utf-8?B?alpmRGxuckZYSm0zYU5LSHF1R3hQVGFPL2Y1QTlnZkpBRHZ6Sy81TkpYOXhH?=
 =?utf-8?Q?JbL/ZrwZhCfH9pwwuq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb293914-c08c-4f6e-0eb6-08ded2f170f5
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 19:39:15.9225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ps8GHCag5xQBlsDJMtBR3OXO/B/9iOf30qHcRGoJGQ2YamSb+gKfGaTo1QNLi5Q2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7436

On Wed Jun 24, 2026 at 2:53 AM EDT, Wei Yang wrote:
> Commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration support
> device-private entries") introduced the concept of device-private
> PMD entries, but did not correctly update the rmap walk code to
> account for them.
>
> As a result, when page_vma_mapped_walk() encounters device-private
> PMD entries, it takes no action other than to acquire the PMD lock
> and exit.
>
> However this is highly problematic for two reasons - firstly,
> device private entries possess a PFN so check_pmd() needs to be
> called to ensure an overlapping PFN range.
>
> Secondly, and more importantly, if PVMW_MIGRATION is set the
> caller assumes the returned entry is a migration entry, resulting
> in memory corruption when the caller tries to interpret the device
> private entry as such.
>
> In addition, commit 146287290023 ("mm/huge_memory: implement
> device-private THP splitting") allowed device private PMDs to be
> split like THP mappings, but again did not update this code path.
>
> As a result, we might race a PMD split prior to acquiring the PMD
> lock.
>
> This patch addresses all of these issues by invoking check_pmd(),
> ensuring PMVW_MIGRATION is not set and checks whether a split raced
> us we do for PMD THP and migration entries.
>
> Fixes: 65edfda6f3f2 ("mm/rmap: extend rmap and migration support device-p=
rivate entries")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Suggested-by: David Hildenbrand <david@kernel.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Balbir Singh <balbirs@nvidia.com>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: Lance Yang <lance.yang@linux.dev>
>
> ---
> v4:
>   * refine subject and commit log based on Lorenzo's suggestion
>   * put pmd device-private entry handling in its own if branch,
>     suggested by Lorenzo
>
> v3:
>   * remove cleanup part, only fix the issue for device-private entry
>   * refine user effect description based on Lorenzo's suggestion
>
> v2: https://lore.kernel.org/all/20260616063436.20455-1-richard.weiyang@gm=
ail.com/T/#u
>   * specify the possible error case of current code and user visible effe=
ct
>   * besides fix, cleanup the pmd entry handling based on David's suggesti=
on
>
> v1: https://lore.kernel.org/linux-mm/20260508013728.21285-1-richard.weiya=
ng@gmail.com/
> ---
>  mm/page_vma_mapped.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>

LGTM. The discussion from the patch history is very valuable. Thanks.

Acked-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi

