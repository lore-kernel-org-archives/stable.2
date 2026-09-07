Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010011.outbound.protection.outlook.com [52.101.46.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB93948BD54;
	Mon,  7 Sep 2026 12:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788783530; cv=fail; b=FrFFyk9mFQ4nXu6H67moNTPXVqZd7gz/rEEeBrvr96Nh6HOyK0x+uNfnW/r5c/EOih5flEp5NJcgk5NZEzk6x50XozP4E9NhEBOdt4ryj+AISsFj4etKotoebD2YIyDNiQ0Yg//2nS64QDovkkR45kY7zEyYZPmTwXy8o1lXrzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788783530; c=relaxed/simple;
	bh=jECwCgjXChYKi4lD4pofDYFih364f9sqbF1oZOZySjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=amAY3EFwJzwbHwKFVtaRDzBxb5Fmcw5KdkFBIz6Qz2yfkoYjY/JfdOBjZC0kIwks6ye758e7FdxiclzFgv7TlaiJoX5I8KTnfvvWuxUDCGBrjsR2S8yhkAWxbNdfCZp8esoDzbO7VTGJaLXjn6qrToNodky6BBFv8fd6ZfnWIJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S10MVWWu; arc=fail smtp.client-ip=52.101.46.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S10MVWWu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLJLeUIlH2eDj+EjajEcfzlRzaBOPmHmSKqVZ6jOF02snBRV6w+OKTQLPO9dZT8PH/yvtepYXrCrlAPVzXifkH9x1lmfxL4mCxPd9xevZyC0NWGaZUhqYLmHE5jBhqDfW9gWPYjOvIK2wIT5zGDnsCAPDeAOV0E84kqGNPLZ//dyKqVmd+5st4oKsQn8z4t8xnYJY7R+RUYhFHCCmgjlxr/TLUv5Qj1JR0Fjs+IU9XE3Qc9RP7JOAC98xpVxW8QfkWwQ9QkNVwvsjfyq1XPwTRQ05Pv2SjzrdovlzhU1xNyeCeq8eQYINERNM6of8X4V+dZQE9quhRX8ObS85kB/5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Luh00z1pUuGrieR2XJewYlB9VVec2a0YWsHTXRwFTkE=;
 b=MPAZ1PPBL44epcHAP7Pb8hBOMIzhB1J0H/KSH2cJiUF+n2Cup9zjh8xepFZika/gRyc41GvGcRGnDD6NAmTL1J2YdDgbkMwlAmCcHUFzHKWOPg7mpVijKFFRC03s8Ti3DOZM0jGc5HtNEpRXI87EN7bQRGsWh3psVXao2QkFc5ugkFIaSsHH4DVbPUcj6abS98qo8XTwWvJAwAHwxsoOYJPZfJSiTvNt6XtpZ06zIu5wV3xP177vcAuoAmtUiQId0yZBkG8sfGE77YUkg1H616t0PV0DPsAYvFKJlx68EIzGEADIrj5MUGqUpx4Mtz+3luiHaaXFfgUUZQnh5igJrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Luh00z1pUuGrieR2XJewYlB9VVec2a0YWsHTXRwFTkE=;
 b=S10MVWWuv9M6lZePdVxcdpEFloRNfqIzT5hyIcPi13Z4Em8l1IRYaktNEfPFX7a4sEtIgiuMAnbprxXRlSHacIZZ25q8d95MeGSmznt7t98jcSwSotWYAP/yZw9ZCPz860AhxMpyb4nWKeA4k0dsfKidxtLJnt52AglLYSlyXe2zszueendtarwLZn0YmLyfwX+BPOyfAcAGuF2f+b/nTfgIfJmwvpo5nkYwEm5K6t7qKdvPznL2aH+QzslnHxgcpiUBoVHUuyr3y1wgfDFZGzT53bB8QvwSFXO29tjoaNTbBTBgXWnz4jY3sjYDQHlJy+xAjIb2Ws82jXcJFCyMlQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by PH8PR12MB6892.namprd12.prod.outlook.com (2603:10b6:510:1bc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 12:18:40 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 12:18:40 +0000
Date: Mon, 7 Sep 2026 15:18:30 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Benjamin Thery <benjamin.thery@bull.net>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Vega <vega@nebusec.ai>
Subject: Re: [PATCH net v3 1/1] ipmr: account multicast table and route memory
Message-ID: <20260907121830.GA647811@shredder>
References: <cover.1788765185.git.zihanx@nebusec.ai>
 <ef4076c94466ea4b147653e2b7f933778f245437.1788765185.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef4076c94466ea4b147653e2b7f933778f245437.1788765185.git.zihanx@nebusec.ai>
X-ClientProxiedBy: FR4P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::20) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|PH8PR12MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b4b2fc1-6fc9-45f4-1354-08df0cda26a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|10067099003|56012099006|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	vAmoDNsgbw+n5oHZqx2vYZsaoOEuUX2RNRWyCUpgTQGKbK9I5u5ClaIn+GKFumWjLuzD61IemqvStKvSoZuwiFmvSCWnYxV5rPhmno6qHngFEsHThnDMkZUUWdaYY2W78+1QKzo0RpTanqDHRU69VPcqyC2rU+xCFg5CBfdCe9ybUytt6B9SHNIxbq6yUk3J61RnLEWQzTX0hlZVxqESUhCAewBWk4rxw4fdzhC2asohksDZUdHQDtT70fqDKJ+xEnLixBnhczCw0qx3vVHFfzy1iXzrmxsevtfFBfkOPNyu/AS79SlV9spK8FpIdIARNdnyT42phdaaMfdGLG01H39/PDVgiQzcLHp03qEqsyYshgqZd+vu1UnkXh8RDV/VuyzGlJV/ycTPn3eiu1HIIhJeTF79Ki6ec89LhvjnCp5KQCCimul9vgVm3rZDMueuDxOeqzuyXcgl3rojOnYzc6EjBZgr2caNI/rmlq6WvW9Ou6nbOB7CLKedMGvpPGRnjBliJvDG5cHOuukbdfkAZ61ANqfS+5e0snMQGlX9+Eh3kYgBaPgACRSWknkZ4dgAzTtCr6qadQofYT8dyaNAU1mUtxKV3F1UFg5qFIoMC2WGTcadRvhaULuJcRDIjFYeWCljv86dG1kxRDBktXteCtF1jFnDduOFs7cFjig6rXE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0h+F8RytdaVdiJS2ivnb+nYUhU9u1tFPYOa/i670C6MrQXFpnbIDXLXSSbgZ?=
 =?us-ascii?Q?z1dLtCOmKC1BgZmHwOMwpddifWm0t0fpjtlILpxQwf18NmvK5lXCbkKc6VoT?=
 =?us-ascii?Q?R0XTbEkngCpZXObZHaEmr8ZZN4usW7j2APxLnVM/73ghPP8BYXTf6WPoBIhB?=
 =?us-ascii?Q?UwgdnhL3FwNRvPB++zkIU3ITRHfTrUk84BvUPhuWixZf1Nwtu1X49X8Gzvw+?=
 =?us-ascii?Q?PuGU4doGlOoPSe3ajyR9OdHTVF2DX5eMv6ZdCYqq/j0qDs2Dj8NX9Xn/Nytm?=
 =?us-ascii?Q?bHhjNgsX4wvd9T5Xgvk83QJwBxneGzocrORrJBN8b8d5oBJXDU6d4FE02VI3?=
 =?us-ascii?Q?kUtbRZPzHgvUHXdd5Q5WhTpJuEfQwFI4f8H+I4oE/5St2WMRKY0JyGRBR3Yl?=
 =?us-ascii?Q?p7zNO8lgXK1L3ARtu5kY7rZIzAt1ITw39z4W9fzEZGjCUyC98MHvmDnB60DI?=
 =?us-ascii?Q?FbvF/e70wLE3ukWopQlNM9J7rezfRWkUTlckAYakTYtcutwNrHufkS8bfwg2?=
 =?us-ascii?Q?NIcYP7sbT4Z2YV5pAg9of0MxLOQch0AKihd6zMaxBmX5Ohh4OZKuCpvKMvlT?=
 =?us-ascii?Q?7gG8ZIrytm2MvHVBLT/mvrXVAFd+2yugac+d6yVOBjd8PkD7hAn7pOCWJXXy?=
 =?us-ascii?Q?5Wf9GG3H66g1WoY2EjsSop87S2tDfsXC8bhvKpTXS8dzc4E2vUKJkvQs4hhs?=
 =?us-ascii?Q?pQDuzHUluUEJznFNBMISUpVhtLNgK39JZp2xuyo2Leba13KOF8h+VLAGY/1C?=
 =?us-ascii?Q?ywXCsWBZy0t610SmoHWhKNFG0iAX5N/DO8xewY1mqto5hIeCtrH+FSWzqkLJ?=
 =?us-ascii?Q?EQEf/3iTscez+s8zvdHq9p+2zq8ROAKAdLlF0gpUgLGVA09hdV/b3OIzHou8?=
 =?us-ascii?Q?fkn5pmlqKkgVYNGjRUajd7F/ghDpvJQHlHjQhg+aYbnQx1BVWGqJQN7ToVNy?=
 =?us-ascii?Q?ni5QG3U0aNwQO2Yl/sKnvl3gebsdWkg3QI2ag9V55dLFZ8Ad53ra8zbqpWzJ?=
 =?us-ascii?Q?YReN6xrY3c14lgBbY3WjXgEEV4H7/5t2TNVeLDJjqxL70qOIo4t8UqXGBvgK?=
 =?us-ascii?Q?FykQNJTYt5G8BRGMisQYM3N76+zjl42BMvqEO38qeJQ1Lv1X3awrwmB+of9g?=
 =?us-ascii?Q?t/7jvYiW6Yz/8W4vpzkiE7spBRC5rIjovaRTkgRo+yJjFr+f5HlNOXBzdjHH?=
 =?us-ascii?Q?wj+rPX+t2+TphQ3lfI0ZdwG7YxXTN4kLSNXPr4VHyK3It20nPdp07mpRxIiP?=
 =?us-ascii?Q?62VpUFdYjbJRz88Vu8gZy2syyhwcnQpm5SWxUh58/gA+raSTEqhWsTfvbJhY?=
 =?us-ascii?Q?sZw0uDtxZjOzBjADSduku45qjwaxlQ9fv3WF46qKxcn9EWILK7QyrjYK4yin?=
 =?us-ascii?Q?86gwdhK+M4jxY1aaTGDLG7AqTSV01a+hD1ctvXrvGb/7gVsYIoR/ohoXozuD?=
 =?us-ascii?Q?X81lNkaIS+Ov2nXjhqP2Lq2Rs3oV9FNVva8Zo7WXIUwCJz4wyU28OmPC1X2q?=
 =?us-ascii?Q?AWZRZe+KS+Kq6TZqN1sRu4Ogs/jWzYSmS4DYqf2D13M6y8oFP2iHsDIJWcKs?=
 =?us-ascii?Q?Ki8PhEY0Vv+7qRS5TOD+0oWlkYLQi4kYL0sCp6IdDuJemZFf0Mu51cKDcMBI?=
 =?us-ascii?Q?LrKnrA8iMfpFPXYHCfI1jofCvX68P9W1JhLeKwUUhCI5Mq6wZ/lrsS3m7DaS?=
 =?us-ascii?Q?6QS1XyJfanatiACcgmeqcsVX0xZu/lXLStWsOIJZ457PPut3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4b2fc1-6fc9-45f4-1354-08df0cda26a9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 12:18:40.2547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARMzrzelBuYsvi/wiYMxRC9Ru6PFpH4U1eVq8O1lkJ+w/x7YYMvyMrt0ivqyBmipiiqDm0oCLFEljY/V+tr83w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6892

On Mon, Sep 07, 2026 at 08:10:56AM +0000, Zihan Xi wrote:
> A netadmin in a user+net namespace can create many IPv6 multicast
> routing tables with MRT6_TABLE. Each unseen id allocates an mr_table,
> links it into mr6_tables, and leaves it until netns teardown. Those
> objects were not charged to memcg, so the host unreclaimable slab
> grows with the table count.

This reads like an IPv6-only fix, but it also applies to IPv4.
mr_table_alloc() is used by both families. Please reword this paragraph
to reflect that.

> 
> Account mr_table allocations with GFP_KERNEL_ACCOUNT and mark the
> IPv4/IPv6 MFC caches SLAB_ACCOUNT. This matches the established
> handling of IP addresses, routes and alternate interface names.

The bots might complain that this doesn't cover unresolved cache entries
that are allocated from softIRQ context. This is correct, but: 1. They
expire after 10 seconds. 2. Bound by the socket's receive queue. See
commit 0079ad8e8dc3 ("ipmr: remove hard code cache_resolve_queue_len
limit"). Worth mentioning in the commit message.

> 
> The first unaccounted IPv6 heap table appeared in commit 4e16880cb422
> ("netns: ip6mr: dynamically allocates vif6_table"), which replaced a
> static vif6_table[] with kcalloc(..., GFP_KERNEL). Commit
> 6bd521433942 ("ipv6: ip6mr: move mroute data into seperate structure")
> only wrapped that already-heap state into mr6_table. Commit
> d1db275dd3f6 ("ipv6: ip6mr: support multiple tables") only expanded
> the table count from 1 to N. IPv6 MFC entries were already unaccounted
> from commit 7bc570c8b4f7 ("[IPV6] MROUTE: Support multicast
> forwarding."); IPv4 ip_mrt_cache is older still.
> 
> Fixes: 4e16880cb422 ("netns: ip6mr: dynamically allocates vif6_table")

I think it makes more sense to blame the commits that allowed user space
to create these tables:

Fixes: f0ad0860d01e ("ipv4: ipmr: support multiple tables")
Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")

Your reproducer depends on it. And dropping / rewording the last
paragraph.

Please wait 24h before posting another version:

https://docs.kernel.org/next/process/maintainer-netdev.html

> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
