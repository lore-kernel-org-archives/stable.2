Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010059.outbound.protection.outlook.com [52.101.46.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA231A317D
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 02:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781662285; cv=fail; b=dM6fuRUc5TpHeGAvThnlHyUrA/m9W75NvFCgVuF7n/5jF73pPTP5XFOgpZ0mbtR/7wnPCvRcftvMq+3KmSSbi7HiCyD5VeKu5X7kdeea/T/oJ1ob8B4W4Ayabvbz/Q5+1RMvhxndjrQVrl0MtebpfsKEPQVJGDtzEdtCLRqheW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781662285; c=relaxed/simple;
	bh=Qiys8x19SY/fUDhhqpln8Es3qw9uJHi5DsGJ4RD5k6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FMzLOZtvCSrsYgqkFVXR3xolJEI1nnAgLA6deKzjffTMdUCq7oYTWsfjAf4eVzHKBqTfOOvGhRHIGxNhlNt80mJYZqUen3qJSJ0VOWUzFTIsnC+562LXtPlSq/gYcIGUza3acQT/MJ5osN3QNph3Q/h9HAtV5SOWPfrbxcUM6Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YAMCI/gO; arc=fail smtp.client-ip=52.101.46.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YAMCI/gO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9KhQT0d6TIEGHpL+pHnrjDtEOX+9+ct9tfS/NvOmndmzk41/ezaHJqMZqAEr7hgcYpjQf60Kv/pI15a6fGgyRSXzxhpVbNg0b5uAl6CXshJoTsR12fJCv5KsbTI3jixZrBVl8dWdET+0WkBpMWy9IW3z75Je/Gii+UFkDyXUUlOA8aT9N653nCVW9VvJP5BfaZScOhMVkjWkcacyHvNqAaaWedBYpmGMW/T7ulczTTZES7rX7rcjvYkGKrqeukoxZ4rNhssWE5pYPAnmXbOYoBhRPdKGRv6ibNpZmGWHXibazxI6yxeV92OXtepxCYi1qRwDhKta4yGN+OCSxeiFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZjjcXnBFVi75p0bA7k33TIZNQRjprVt9pk/PysYpK5o=;
 b=A/vkZOsAV532WD2DxChI+OxRm/uxS2Pn4GFP1f5/+pTsWTQgSXjX9mlRnY6Yy0nQ0/i4VndiGIZcb1+G0kba5xLHpv4cHS2ZfnVCpwLriWEpX6suysF9lb29aaCHOuSuFNK3aJ+MtkPpeyL8n2LUfvACcjWN9JXGVHhn8Ze5wrkeHZFE9V/MoKjIdgm7yh4aud0gOeTtlUJIIXFZoU/jF2PN5xV3nFMqNJxzV/O+4zczlW77s5InFzdizkupmcx/KdDRB5YnSAt5xvuoDpTZEg8C6uxtZLCnssmZmgDrFLGxPENHuYTRyUdjHuWXafSDzHYw2h2unwpCzJEJp4Fqgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZjjcXnBFVi75p0bA7k33TIZNQRjprVt9pk/PysYpK5o=;
 b=YAMCI/gOiI24qvMGNuhfeJEyo276H2rSanp5Sd5aU9zgmtWZ4JBcN8GbGntqaeheL/3RhrIqy4qILogR9eogMs5WmDq0ItY8HaIQwEm5dfL7ix7u2QnU9scXHrGnFlzkZHnD7n8BeFNk8ZLW+1uUVkdZpfGM4jY7/LO8QagXfrfAfX4ZkJko5zlIpiOjpP1Dibo+YiyDytrOceqEQVm/7C4f2v6UQRtmE2GjUScAm0nSaSKO16HI0rl9eXnn2klPldH5mOTg5zy0tWzeTr6y+ZLJ+wr2rTR6Tb6XUpb/RirNUPBQJeF8/AQLLFFKu79J43swO1Z6lNFbJk8YWyvfJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB5001.namprd12.prod.outlook.com (2603:10b6:610:61::18)
 by MN6PR12MB8472.namprd12.prod.outlook.com (2603:10b6:208:46c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 02:11:20 +0000
Received: from CH2PR12MB5001.namprd12.prod.outlook.com
 ([fe80::89e3:6df0:de90:8dfe]) by CH2PR12MB5001.namprd12.prod.outlook.com
 ([fe80::89e3:6df0:de90:8dfe%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 02:11:20 +0000
Date: Wed, 17 Jun 2026 12:11:14 +1000
From: Balbir Singh <balbirs@nvidia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>, richard.weiyang@gmail.com, 
	akpm@linux-foundation.org, ljs@kernel.org, riel@surriel.com, liam@infradead.org, 
	vbabka@kernel.org, harry@kernel.org, jannh@google.com, ziy@nvidia.com, 
	sj@kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	stable@vger.kernel.org
Subject: Re: [Patch v2] mm/page_vma_mapped: revalidate and do proper check
 before return device-private pmd
Message-ID: <ajIBTyWCLDo9RAHR@parvat>
References: <20260616063436.20455-1-richard.weiyang@gmail.com>
 <20260616123001.6501-1-lance.yang@linux.dev>
 <666dc40b-e37a-46eb-af55-7a81bc1643f1@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <666dc40b-e37a-46eb-af55-7a81bc1643f1@kernel.org>
X-ClientProxiedBy: ME0P282CA0054.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:20c::7) To CH2PR12MB5001.namprd12.prod.outlook.com
 (2603:10b6:610:61::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB5001:EE_|MN6PR12MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: bdb36210-6177-44ca-773b-08decc15b87d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|22082099003|18002099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Up9AehzXJuiChn0O4YXW9dxxyYm5fk+/bDZq1vghZjuDfoyZpJF/fTZL00n+VczTn2OHUdK+LhHDQ0Gd7pWn2DkDJaHN5c6IvkKyXcBgA/kWFG3ywE2/aAvQAgqKLgLlIZNn2U+p4LDIfeHT6pcIBUjb8SDHPx6jXYr4mWkWUNVTLNz5F0TnFewTUoTHYK4JPJiXSYngkb1+C5B3i0RVspW7cIohYGj02bcgzblj7YlwUa59bF4Zku/AeE8Bc7zalhjZqqRcs/3FTNcXDyolShVBb69pyM3V5U0RFd4md3OiUGw91XCKNji76T9PIZ79HTDbk/8E3UTdo9Jq4gS8IMHSnqUQ96WBfjRxGXtSCteR4YpAJijD9dctEx4f0aAEKj56DlOzZPcMmmjS3HebklAPKLjZy8qior9kpGjoyIHjH7miZLGk1lLFEro3M6V0CkZdIvyHH1DisqGT9VvQlGo/+6NyQIo0BUFRy6ZsY1QmesvkEwpLXEc7os06dIDy3tDWz4ePwJYNrF36B8p0NDpAjb+aa7dTRDMskFn7O+Z9CpWQi4nrTvepM1UUkp77HkKgTTloAAfE7jzOgPyoZV3SYstQ2K/+YZ8/sKfC/Ud0y3NEE49wX7JrsYy0uaKOZ/Ac5T1G91u/254r4JvJj2djN2pfl+jNRGSnpnRE9OEqJUBt+FYopau4gN2lIHvf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB5001.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y13EuX5oa8fXN9Ib7w0E6WAnpo8Hh09NSupTeL8Wqc3pNut3qet6HqJ3VTpW?=
 =?us-ascii?Q?tC6qW4mwFBUqrZA5hGOlGAVgQ1vIWrfvAijN/tAK0vlJbOnxncuzYJC6pwoS?=
 =?us-ascii?Q?d186QtMqp5dZtFCB2uQWFHq+LS2Wkij9QgLWPXVjBlJKpin90obqbmSLww0m?=
 =?us-ascii?Q?eAon3YwBdpWO4ZaRrYYZr1GNYcIlc9PDV93VGBSllgiTupbd0A651JQLznvH?=
 =?us-ascii?Q?NY5v8n+kn2mJo1BLMDKjTVgAvIsziw1WStjq+E5TiP0GGQom5DUZpNNIahqP?=
 =?us-ascii?Q?EIpnnrKBDIlVe2ZkOJBtKzv56o+7vuwzrh12JJXWNoyoBfx6ddipLd+ulwIZ?=
 =?us-ascii?Q?/kQ+xdhytyvxJaTYBXQy+vE2sfPJBzY0spX4N4bGhzv0G0NwjUzmFbfQugJQ?=
 =?us-ascii?Q?XPlaOCRmwFr5XdXrA+JSSfjOfsJV8d/DEjYzuTBTyuM5Fg1kEAkK7W9BMpPP?=
 =?us-ascii?Q?vkvY2/corHliGAGP3gPw3WW0WYfOx550wJ0nsGUZWYlLCe6voNhG+2oN0kv2?=
 =?us-ascii?Q?8LNJAWi1Uu8XjFUyL+87jkjJn4wvcv35sev5lUBhFJUjmo6+Ss+jbMVicqSY?=
 =?us-ascii?Q?Bpgi4tB9bQcPqVuYjXbVwhvFMuTHVkxgJYM8cBj/AGVmbWzIqsWCRIrKI7uC?=
 =?us-ascii?Q?3umH4DSRNMwArGYheUSp7Cbt77zH3QA1AkfNplUA5vHxU2wQqqAwJtFz3yy3?=
 =?us-ascii?Q?KOf6E3WIPpEQqbdl1rZC0xuND8rvLsI9V7Q6ylykXLOAEMeObU5awa1Fffdx?=
 =?us-ascii?Q?QZv8qYkbszGPeelHC9ylBM1hCDofy7dTUnO7lIwndlXnaLQo1ESZwMh9JIum?=
 =?us-ascii?Q?8N+U4Vc0P4BdS41rF2y6gY9ag3XMeZ/hjLoHk1PGwa1xlCqoEIiHmEWb/8vu?=
 =?us-ascii?Q?4HPJQQcoMCVyFzWun9nwjykv92vZZfqwDsxwSsKjT0xLsPcJcbvT88DTlIkD?=
 =?us-ascii?Q?NJ0Q8cVgtkl+/4IHFcXTf8NSH/HOimo0lQmgHzAilqZXvQJzkp8qF7DY8Lxd?=
 =?us-ascii?Q?iekkMT9WsDl5+HennvLmU9Zgta4M6zDWu43N+juZZtJj/F25a82lFiSnqrRR?=
 =?us-ascii?Q?RkjaWY3P7b2XS+btyBamQ9648RW6MbHY2bjTtvZ4XFM1c2PBZNU7qKpohW9/?=
 =?us-ascii?Q?BxaWJfRd8dKwxSxZZvws2XO/ibi2deCewE1ZQYkzcZ+pzvlyRGdqPSK7vTwg?=
 =?us-ascii?Q?AmlEBka37a1niyoHYlYdvY9Vj7/xsFrDs8tcy3Eo98TRkuGZm9LTLa3Z/Qw0?=
 =?us-ascii?Q?386O+NduykwBTdqlNGZCAQrZVyN7Bb0EQclJwr8epIXyMVZWRnz3KRAncCl8?=
 =?us-ascii?Q?LzJKajSEi/RmxL7bDxswL1cQrB2dNkkFlgQmYQ2yB2CHe+iFvFAUxy88ZnRa?=
 =?us-ascii?Q?poyyW5CLDwSuLuFqelUNj6BrqyKoVaiqUEtTlFusAQe1IWdtnvm3H5ketlW3?=
 =?us-ascii?Q?AxS1uEpxEf1yHSNKcAkc9Qtuh/OR8VpNCRJYmZCqxrFnI7oyu2us2KDqOsZP?=
 =?us-ascii?Q?HB5gLKdHXSM0GLcKyBwrc8KANWTtOpFjyidLRTXWO8miiauv1H+xpSxapa0i?=
 =?us-ascii?Q?GF+3YLTGe2tzDR1M08TVoees9IaNbVmVczAXJmOvfYffE2amL+HCjmi89lAP?=
 =?us-ascii?Q?OBytQQTqiLpGU59i1cbc0hHrKLGjZ9TuQwuO3OYmw68ZSooqA+MnLZbswigz?=
 =?us-ascii?Q?joCsExHUbXUqpUV0aDiCZH1XuHz28p9b7/8SVhXlz3q9NUn1FbT+2u3Xb6BH?=
 =?us-ascii?Q?8Bi5M5pnMw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb36210-6177-44ca-773b-08decc15b87d
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB5001.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 02:11:20.5169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pTcVI4/Sk6fBCRk+z3NH3HKcE7ESV94bc6CWT3DsTQEt5Ygpx7tD8EyD8q+p8OM9n5KjGHDHMzJBgqA8Hko8qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8472

On Tue, Jun 16, 2026 at 03:07:53PM +0200, David Hildenbrand (Arm) wrote:
> On 6/16/26 14:30, Lance Yang wrote:
> > 
> > On Tue, Jun 16, 2026 at 06:34:36AM +0000, Wei Yang wrote:
> > [...]
> >> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> >> index 2ccbabfb2cc1..21635fab209c 100644
> >> --- a/mm/page_vma_mapped.c
> >> +++ b/mm/page_vma_mapped.c
> >> @@ -243,40 +243,28 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
> >> 		 */
> >> 		pmde = pmdp_get_lockless(pvmw->pmd);
> >>
> >> -		if (pmd_trans_huge(pmde) || pmd_is_migration_entry(pmde)) {
> >> -			pvmw->ptl = pmd_lock(mm, pvmw->pmd);
> >> -			pmde = *pvmw->pmd;
> >> -			if (!pmd_present(pmde)) {
> >> -				softleaf_t entry;
> >> -
> >> -				if (!thp_migration_supported() ||
> >> -				    !(pvmw->flags & PVMW_MIGRATION))
> >> -					return not_found(pvmw);
> >> -				entry = softleaf_from_pmd(pmde);
> >> -
> >> -				if (!softleaf_is_migration(entry) ||
> >> -				    !check_pmd(softleaf_to_pfn(entry), pvmw))
> >> -					return not_found(pvmw);
> >> -				return true;
> >> -			}
> >> -			if (likely(pmd_trans_huge(pmde))) {
> >> -				if (pvmw->flags & PVMW_MIGRATION)
> >> -					return not_found(pvmw);
> >> -				if (!check_pmd(pmd_pfn(pmde), pvmw))
> >> -					return not_found(pvmw);
> >> -				return true;
> >> -			}
> >> -			/* THP pmd was split under us: handle on pte level */
> >> -			spin_unlock(pvmw->ptl);
> >> -			pvmw->ptl = NULL;
> >> -		} else if (!pmd_present(pmde)) {
> >> -			const softleaf_t entry = softleaf_from_pmd(pmde);
> >> -
> >> -			if (softleaf_is_device_private(entry)) {
> >> -				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
> >> -				return true;
> >> -			}
> >> +		if (pmd_present(pmde)) {
> >> +			if (!pmd_leaf(pmde))
> >> +				goto pte_table;
> >> +			if (pvmw->flags & PVMW_MIGRATION)
> >> +				return not_found(pvmw);
> >> +			if (!check_pmd(pmd_pfn(pmde), pvmw))
> >> +				return not_found(pvmw);
> >> +		} else if (pmd_is_migration_entry(pmde)) {
> >> +			softleaf_t entry = softleaf_from_pmd(pmde);
> >> +
> >> +			if (!(pvmw->flags & PVMW_MIGRATION))
> >> +				return not_found(pvmw);
> > 
> > Looked at history a bit, and I wonder if this changed something old
> > here ...
> > 
> > Since 616b8371539a ("mm: thp: enable thp migration in generic path"), PMD
> > migration handling took PTL before doing PVMW_MIGRATION/PFN checks,
> > including not_found() cases. So lockless PMD read was just a filter ...
> > 
> > With this fix, true case gets final pmd_same() check, but this
> > not_found() case happens before taking PTL.
> > 
> > So a !PVMW_MIGRATION walker could race with someone, e.g.
> > remove_migration_pmd(): we make the not_found() decision from old PMD
> > value that still says "migration", while real *pvmw->pmd may already be
> > present again. We return without ever taking PTL :)
> > 
> > Not sure about practical fallout, but should these PMD-level not_found()
> > cases also take PTL and restart if PMD changed?
> I was hoping that we could so something similar to the PTE case.
> 
> In map_pte(), we check whether the PMD changed, which is slightly different.
> 
> The actual check happens in check_pte() after grabbing the PTL.
> 
> For the case you describe, map_pte() would find !pte_none(ptent) ...
> !pte_present(ptent) and !is_migration, and effectively grab the lock and proceed
> to check_pte().
> 
> In check_pte() we re-check under lock indeed.
>

Thinking of the practical fallout, not finding the PMD for a non
migration worker should be OK. Is there a case where it's not OK to
report the old state.

Balbir
