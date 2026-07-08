Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010062.outbound.protection.outlook.com [52.101.85.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9EC37FF43;
	Wed,  8 Jul 2026 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783524504; cv=fail; b=regvgLvqD13tRf4s+7J8NQmgapW/t+TKF/yuYVkO2H8CXTaw/rKuBWIznAb/Z625mQ/Pe5iosa/WwN/SpXsuKm5bB65Jc8AIFWEXiP5quMNCgXHz6MbzwQzndcRrYTLm9e30g4M0Hv7y7929KgvA20j1QEbvCUGZ2kgwxbqiGHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783524504; c=relaxed/simple;
	bh=R/qiWs4RdiZmc3QQiffWuBiUIWB5oyLxy7vAMMll7fA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LvwqEt+IfNZFcN8zU9VuKjNuY2OOgYCzXor+Jre6TJ75Yggs7apnfNS7L05B62c1r72yuL5pG9V6SfT1K9/5s1df79/V+3pLkZ3AQRJicXeMu55qmJvEwtUpmVX36tjEG5MGfWsBqmaP+Nn975Hb/DalDpHsHQZVqlCyvRa3jbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g/eTuiJI; arc=fail smtp.client-ip=52.101.85.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g/eTuiJI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R+uEH5kiNlOy/w3oklJUmBpDXtqAMIUxZbn01AiP3rl60vVeJQ1oVXsmggcJmho7iK7OZRlc4lR0YGx/pDpGqLGXpxau4vM/PhAr5CrqsS2xTIDG9c+/BZb7uW9Otugsp9hq1HAq+uPFujGzySnez2bejmFoi3dr7yue/OIteP5tn5GQHkFPlMrHif93KGnvQfi1y2oj3fbN1xwTQmhhgGQ0dLpassr+qHzBVewd6uSgxEPknYDUF6BdBL49l+MPtbKa7yO0prK+aECfaySagFb6jaOI2Qpue0AIdkx0EzAR3KpEthcqz04uh61oot+DD/BQGy3mfmB/fpvkNuBQng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1bsZC070r/HUYYrj9v83jamnXNdhYOyNFv+lw4F4Qo=;
 b=IpUq6g9kWZ1KWhRqrlKdR/HGz/Ey8sAeqjcV0qCvIPmHRmkhdb6N23OdaVnIebmu4pYus0Bzv7X/BrlzpWBufHNXH54o9KVOnwmXrg9Il3FRiJYUwjUNCCuaEjN704eryw6b8bN2XA7f3g6WXsjP21soWjvBINPQI6SuKOp+Z+/WXEhMnMURTZ58LJWI8GMwaDzrQ5xddqH0AUydF4N78VNwyvYsDwWqcGDBkkgaCpvygJ7S5q59AyPc4HcDxDm0yVD17GSqVMiUFJm+pGqK+jMhwAup9qWJG0nUUmGWBUSvqfTjMlE9VwaZMaCnpD65bbMpRQe++JYg8a386kykdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H1bsZC070r/HUYYrj9v83jamnXNdhYOyNFv+lw4F4Qo=;
 b=g/eTuiJI4vFcRCJoxkACbhfsDEbbi1H1bZeuU9eKg8y6FX7j2QfuyTFsC6c117ZgYi7IKmTJzyiAgurxjtFOlv1hetb7hxojzhDwPGDhsyUw2w7kQt/Js2QSFVpXIkMmZcssLYZcYLtsevyW0k4SrRRc8jei13lgylY9iZubZ1h2aeZ16STl8dRnYMdRUI/ALS73dHDEt5SkPLq+F7oYi/OQUDhb5WslcG+BsqfaRLwtPs2VOOOIizIDXXMl6OfytxzsxfrYwfozp4MwqLFT1tvscyhalhygIieoesxzubQruxHDqKGXTH6G5xfv4IQrES8qfXfKsu/gy1K2JAYCQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by IA0PPFB6B4D32F9.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Wed, 8 Jul
 2026 15:28:07 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 15:28:01 +0000
From: Zi Yan <ziy@nvidia.com>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com,
 balbirs@nvidia.com, baohua@kernel.org, baolin.wang@linux.alibaba.com,
 byungchul@sk.com, david@kernel.org, dev.jain@arm.com, gourry@gourry.net,
 jannh@google.com, joshua.hahnjy@gmail.com, lance.yang@linux.dev,
 liam@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 ljs@kernel.org, matthew.brost@intel.com, npache@redhat.com, rakie.kim@sk.com,
 ryan.roberts@arm.com, vbabka@kernel.org, ying.huang@linux.alibaba.com,
 shakeel.butt@linux.dev, hannes@cmpxchg.org,
 sashiko-bot <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm/mempolicy: skip non-present PMDs when queueing
 folios
Date: Wed, 08 Jul 2026 11:27:59 -0400
X-Mailer: MailMate (2.0r6290)
Message-ID: <9BFFCAD3-2DA2-40D8-BC06-B138A577A857@nvidia.com>
In-Reply-To: <20260708122040.861335-2-usama.arif@linux.dev>
References: <20260708122040.861335-1-usama.arif@linux.dev>
 <20260708122040.861335-2-usama.arif@linux.dev>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN0PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:208:52c::9) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|IA0PPFB6B4D32F9:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc6c3b9-5d08-4464-a06e-08dedd057f4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|23010399003|22082099003|18002099003|6133799003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	CaLGvazuvKKW45UB5pjbiQSBEKe+Qjg8h8Z9UFjW/urkqOjl+1OyB3lNE/BxNlumpd3vmj9FyxvKeuVbUFHUJ5pYso3vrT+dIS+qWVaLXjxLTQ5V5hOaWhpgw2L6wlKpFBTrEj1JRs9GfUqYUkB74oocuOn1qhIP4NO22rBeK8+j6GFg/Zfc2NXSoZvb4JVv48DMbkD1bCm2QjBP9t/MnR+/kh3xE2mghaltDossHz1ZOlzu4nrIgpAwJud8vmBFMYSy0z2yMRixtm3WuvBsYKpje8e2bUNLJyrTVIyfgE6vCEhdNMaRxTO65sSv4JnbtUTLZxmecu0epegqyLcT5Au2a02pgvQFRjlIfe2xTM68vM1OMP/AXUGTxK1JFRG5USPeXVPFLafF9mHpYiEJu7rR4Bo2hTC9NTbKmxRGoPZuqhE2pZyIdLxswCbgoMdjm07CriNHoeoHA3YVddSQM2Zy7ybxQlcto6Ih9jyMyMqdGcfNtI2a7LHzeg/YPEt3paVpBQdx3wLw3yp4E1PNxjBF2NpuundLwiMoE7Cwj+48ToEVNKwo+Y6oM79ce6gJgeKrTa4hqAi6NNmQhwmG8aRXykYXldl5UoB8Wcj8F0Lq0+ceJYUqspLKpsGUj5JoqF8n5ORRB3hkB7l4T9eys2/6OBm/uGcp47n/9+y2QVM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1l27fWIxZqy3kOsOGRHN3M4rrKiwsAwJOxniJIF32tSfBOLishBEGI46jpwM?=
 =?us-ascii?Q?iVLi6eQC3TZWDnsZMoctjKnjNdd5PZpXW7VEKQRf6qr0ALt80yM6mu7SQLcB?=
 =?us-ascii?Q?Uopzva6IrQWIh7EV80J2OO3ELHjKC+r0ra1ZavHMh0Fxa9mfPVbMBSutl41F?=
 =?us-ascii?Q?QLwklPyOJOBW904tA9VVGaEIfXwt3AG1TNT/McaqhwvQGZemWE5Pq/Kxthd6?=
 =?us-ascii?Q?1EEfFwRSYDxtePiaCdfCp9sU8EVrNY5i6e5PXkoHKwN6q9Qa0ut6RCUM4C7T?=
 =?us-ascii?Q?nCjvN3feltYx5qlmoFFnQ35AnIh3koqLQXVLlT66W6Nb0O/NYl11WSVUhczR?=
 =?us-ascii?Q?rA3BGu7lm2dGW0zh+iUu/HVRYX4NT2GT/JV1LD2HdTOOZxR56x09CTrI7yp9?=
 =?us-ascii?Q?VUDJ83PKPcXKXBmHFlz7DprTBUqpGyK+qAajj5GHg1uTMBIR9O4ZLiY0mahg?=
 =?us-ascii?Q?72stvN4r+ZtMH87jtw6fco/dPyePvHmC9V4uohxz/yajoA0tw1T4A4fVEpKY?=
 =?us-ascii?Q?P9AwarRIS+/qOsb287JH3cnyOKgf9jwREYxTqxSpLQjuXTgHRuuz0ZD+yp5u?=
 =?us-ascii?Q?H/vyyTC/OK0tRgZVbJIG6fja9NlZiE0NxJNjysHEenz7oT+tX5t7XUiwhhgl?=
 =?us-ascii?Q?94a604DDyEtxFZGQ2cXyWiEMGBb3MBNpKixn7+pwpt84R6PVuOnEYsICYaUG?=
 =?us-ascii?Q?GhAFvSgiW9mV3mEpl0yJImDHsZUuCFHZqt7m3OWApxp2RPEqIOp+y5JwkcDl?=
 =?us-ascii?Q?SoHvvyuJ6CKLLIiUi6RZK2vLq9OjOoZHW343u2VNDqPe3ckLcGoF0SOsd4aE?=
 =?us-ascii?Q?xc2x3w/FKnnP2HxymS6L/7Ji/CeILc/tLtR3wMXiUyS4bsA/hSE0Sxyx/0cW?=
 =?us-ascii?Q?xFF7gQsZ+WiIEddzkhVRvHtjYH6YWOTjj4reYWQyIH2pumebHv4jXt1fkago?=
 =?us-ascii?Q?HR149n0QUWEIAPjNabLl1/2gWqTLl4tcShvzQJudZK8zPSACMJER93KedpHX?=
 =?us-ascii?Q?YKY4fN11iHEAqKC2bUOFtu0YyWZxTh24EPue/CJnmYx+I3lBDylFw6YWWNqr?=
 =?us-ascii?Q?wA65f5WwZasvR6JdOqWvy/lqZg7IHP8VQjcNhsnMIS1MZZLVpXUoUEQf16SQ?=
 =?us-ascii?Q?CqcHjZv0eU1UBlTOXozrCDqoJnFS2Tu1n0BFWlyy8li6RAP9KitWWyPBMqku?=
 =?us-ascii?Q?j4voaVaTNuOiKci6D828NmfgGUVQMznukDQlfzuDNpfE/whmkrfmt/DBEVTn?=
 =?us-ascii?Q?oSKIfVozNN9rUG+Xf1nmm791c2gX3Xuh7XBStAzEuhlIZctgjE/kKFjKXcQh?=
 =?us-ascii?Q?OsfZCXre7+Y6fMZPgW9ToYRHe2Xaj4eJsU/1xctOL7Uxw3y307mADYmq4IYi?=
 =?us-ascii?Q?oNbZtYHENx4Fivq1cVSaU2kN/p0RGGINOLd3fMIxzKBGpvlW5UKFARgB/Gnh?=
 =?us-ascii?Q?hh+8Kv1tU5pytgRkDGQjxMOfnq30WpUN/Z+PNq0426FW5hKmS6ISO1/v3Xvu?=
 =?us-ascii?Q?GLDGNZhRo/pynsIjsF87rlHcavBtEBIX6WGaZQEClSuXYLouyXgS/9DUyOu4?=
 =?us-ascii?Q?f6Ny4mSKuVVb2gjj/fv90XMRxRtfdbeiAvZfuhhPPpXo9+AbSmnhxls7rMWI?=
 =?us-ascii?Q?WsK6AsbRqNWW+GG84Jc/bCNiqKOMGD2jkZ9632Ws9OZ1EBF5QP5EEovDmaJf?=
 =?us-ascii?Q?VE4OjDMZzT2KPKgx0KDI995snE38OWX3QHZZGy2yvGO4PdNePAIO422l18sz?=
 =?us-ascii?Q?q37063NseA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc6c3b9-5d08-4464-a06e-08dedd057f4a
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 15:28:01.5374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qMUx4L9vDzXXp7Vqg1EVBf/Owj4LU1wgW1zfcSk6Dqp3flijMB7NKS31nwPt0WCS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFB6B4D32F9

On 8 Jul 2026, at 8:20, Usama Arif wrote:

> queue_folios_pmd() is called under pmd_trans_huge_lock(), whose
> pmd_is_huge() check returns true for any non-present, non-none PMD
> softleaf. Passing such a PMD to pmd_folio() treats the softleaf encodin=
g
> as a hardware PFN and can return a bogus folio pointer.
>
> Mirror queue_folios_pte_range(): handle non-present entries before
> looking up a folio. Keep migration entries counted as failures, but ski=
p
> other non-present PMDs such as device-private entries.
>
> Potential trigger: an HMM-based GPU driver migrates an anonymous THP
> folio to device memory via migrate_vma_pages(), leaving a device-privat=
e
> PMD. Userspace then calls mbind(), migrate_pages() or
> set_mempolicy_home_node() on that range.
>
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260703173903.3789516-1-usama.ari=
f%40linux.dev?part=3D6
> Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to=
 PMD operations")
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---
>  mm/mempolicy.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 914f81863db5..4785b55c02da 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -654,12 +654,14 @@ static void queue_folios_pmd(pmd_t *pmd, struct m=
m_walk *walk)
>  {
>  	struct folio *folio;
>  	struct queue_pages *qp =3D walk->private;
> +	pmd_t pmdval =3D *pmd;

Use pmdp_get() instead?

>
> -	if (unlikely(pmd_is_migration_entry(*pmd))) {
> -		qp->nr_failed++;
> +	if (unlikely(!pmd_present(pmdval))) {
> +		if (pmd_is_migration_entry(pmdval))
> +			qp->nr_failed++;
>  		return;
>  	}
> -	folio =3D pmd_folio(*pmd);
> +	folio =3D pmd_folio(pmdval);
>  	if (is_huge_zero_folio(folio)) {
>  		walk->action =3D ACTION_CONTINUE;
>  		return;
> -- =

> 2.53.0-Meta

Otherwise, LGTM.

Reviewed-by: Zi Yan <ziy@nvidia.com>


Best Regards,
Yan, Zi
