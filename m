Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012067.outbound.protection.outlook.com [52.101.43.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99FC3C3432;
	Wed, 22 Jul 2026 08:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784707373; cv=fail; b=deKqM5MHMM7SdIvdtMg2HmbcobCAjtvj5xOfVWIy0tlXp3ZddzlB1Jx6WywyticqEefn7MKQWfk9BIsfsGC/sSSejCfpn3f+W9KQtSW1oY1cKKhBgJz93UoW7pb3ClGZsNab/f7PcTm4MXOl/yhhYdTjQHLk6NE4KIY8ZqLWcLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784707373; c=relaxed/simple;
	bh=gktv4Q7Wvz7OF9mL/vZ1p/5Fmn+e+QMcmeVfAt+OubQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tBAMxV2mfto3zNESoAVAPiEpJ4WqX8X6TtYLVo2igdjeIisjYPaRHfuvDmsG2SfPFf1r8BPjDl6RUQearYOzgLFXjIG+cw3HROsLDfXCxO/Gf21GBOBS8ZXFUPGcIySjQ2HAncMC0QVSwbxYtXJ4dE0T8RhEbqUvQ4x98nyp/jU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iITtUUdG; arc=fail smtp.client-ip=52.101.43.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iITtUUdG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2ITyilVNAE4teuOX3EA4QVxSfZJFCgwlxRRir2LEBMvNXUI8/AZF2Wcs/W66FgTWoA/FrOXz5cBVDV3DIi5YOLZRI+k5kMLI+TCVO4d9RGtOHHIcVB824gQaOs3U7lSLvzWlsn49g50sV5EPQHx66QjmlgZMS/2zVIEcWB1+0mZob60CDhEcu5p0sAZRC26PDi3n5N9d5Qdi6nQGDSqJ4L0qhhPBODh23Gf/YdUwOFXxsVpWHLjAOGdvY5Gvrng7VsQi28DePprWEzU7ruNCBvGtZziOlMnlO86CuHFDcw9UL86HdkOX7XHvqkCLWso18MSHjkDUFw32KtuI24Cag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fq4lkiogXQrdQ/bNcN54HuUeqixMpQ/d3Oa6fmTqcYY=;
 b=sZ6AIhBtNP8NSAAlLLrUAujUwqoA4aNm4ZlyZPAl1CQVmoNqotk1jFIb5hYvMv+Qsd9EBjSGyI/FgpRy9QJvdBejGjfaGpWdwwu8efTzq0LWs2rPtBM+u/eGdApmdkqtxeZQngeeAfHyDFP2ik+dWxxOpmPnpP0CpIG9/DENOfnxv52OQJYmCILj6El2aGq/3lfUTrLe7w+elASlvFHAg/NQwkgLqdUkJabX+1qpylO1M9n1Wh6nbGKV/wTIpiXrAAqyUEdAhYSQJXxDq0RBbp7S/aM1WddL5hDD2J/4rLex7LXN+3hc434DQjNOE39cWAGtBt0UKenGtr6D2q8aKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fq4lkiogXQrdQ/bNcN54HuUeqixMpQ/d3Oa6fmTqcYY=;
 b=iITtUUdGs3RmFQru7JccSMlyWwVBIRVbQg3RImptSlmEJcLkiQkUCQj1b/9XiAklC0FCm6ePhjmW9b+mUm+n1IC5OLsaJLGRiv38+FtrsmgFIv4B93hbtRUDMWyGNZl0cxETwj7dV/r7Ab3gDlsS+RtEvneAtVkJOF+bv7sbSRj7o8ysQV1ehUZh5DObThN4Axz7BWXN25maUMJOnOUJFREf+q1GolyVpEGnRTIl3ofm5Na/goB2TggA1b4Xjqw8zZd8N2oXkjzr/twPNYg7zyL0PAnpIFhAY+uzm3JenO6ITeN68NTnEoQ8wrPAcUrCxk/a0gRztouNRzCQ8NYNog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA5PR12MB999323.namprd12.prod.outlook.com (2603:10b6:208:605::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 08:02:48 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 08:02:48 +0000
Date: Wed, 22 Jul 2026 11:02:39 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: James Raphael Tiovalen <jamestiotio@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, stable@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vxlan: mdb: Fix source list corruption on a failed
 replace
Message-ID: <20260722080239.GA2832290@shredder>
References: <20260720160428.249356-1-jamestiotio@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720160428.249356-1-jamestiotio@gmail.com>
X-ClientProxiedBy: FR4P281CA0062.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA5PR12MB999323:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd4061e-bda0-4818-2084-08dee7c79ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dQiKr1M7atIMO46qkYm2Gk8o1MGFDzLI3HFoPotMh8UMxo31dh0wyvpxxj6UYh6J7Jvh+4i/sDOgf9Doz2ph0qymj4kzCzNN0A6dVB/85uBeTZKdh6kzSzj/LtSIuupvGvmjQEQ6w+YialXr53qhZVqTP0x30QUlNw0w61ggBq9CfI2lj6UViLAdvhftIZG53lLUxDu+huB1hq1cSCmmJB1eK9OW806RpKjkmvtBZZgXejTi6LLpaiKZ1sqQ+falQkeipIIWEShC/m/Qe68e7Wk5OLgPsk2TEMnQtvFhdgIx3dtVmPv6+kqB0ZtYPJn0LaYadx2LKKwuRLCiAcoAhTTrfUC1qaroTHNW9zWPt+exMoy0hwGNLwHoBhqLf+ZST55SZq4ShGckYPagbVgkiR2T2xcdNmqVwagYg3lQYDneGztmdtlA/GxDGi/LK0v0Gqzx0NwKn5omY+hSBDOpQWtJmzAej64f8Q/Jn+QBbenqF+Rjz3WnjXHHRga9B5aUzINRsk8AUQA7BNJGO+rQ9BLLALk/taO6Fs4nCj+hnd0fi3AMJo8mvJ62e3gxwKVF6yXagaqKQfcQKMcEux7RCLH+sUl+8ULiIQkR/3jY/heqqaqU5VLkjwQBhHll5+bEK7dosnnFgZnOLatiUKzjZbBQdStEhqZ70b/EWHXVg9A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5FVCSoZRvl7N7xBevHFn1ZRfSE7IxF57gci1us1aJQNapY9qdVwe1LHWyA77?=
 =?us-ascii?Q?Z3C3uJNjc5Meo+SNHoi9PUSBAMO8Kkrp+sd2BBD4h2aYu5GttX1iiH4qL4nW?=
 =?us-ascii?Q?JrsEdzOeodC3UJBzbCVxYOs2Ap32VfFaTvgUjAmkFxmZHf3pYWo0rcAzhFuF?=
 =?us-ascii?Q?27dhbZfa8DlX1zyzjeiqyG9LSR+vt/enoxhFUKUDeaZqbhVLtP3leZKjq8YV?=
 =?us-ascii?Q?4Ao7lpWhgsHTazG0DVhhKCODNM49viB2fAP33DOg+sv5usZNL0QVjIuxDs1k?=
 =?us-ascii?Q?7K07FbtpQ+3a+SPkOIikJdthlTYbwTVc01SDEqOFB/GGhxONC9/fdrj3oBXR?=
 =?us-ascii?Q?2EFAqbQm6xXplD5ipi235TRc0x3wEr1BslODC0e3keGHVQGucmeUZRovTu6Y?=
 =?us-ascii?Q?jlv5DQXpWqNNd9OpE6taMPERorfpiAanoHOmnh9HyLK3XRJHCAxpA80b7Wy2?=
 =?us-ascii?Q?XJmmQ8Hl5O20QWHFsAvHTobnONC6KCsJ6EWYQvdRuOUhBnstxf2UGHlY20DM?=
 =?us-ascii?Q?SKGOocuBs63bdWrdo1Oo/JvXLpFm6LNoHVt40XT7XSPzm/+qjEVK7ndEEXCP?=
 =?us-ascii?Q?n/B1WuMOI6W2Ac5WVbz/PyyEhw0JsLGV8oo/7v8MGErd/60sXOqTMOZNPbW4?=
 =?us-ascii?Q?OpKGYgiZcJJbiOmwNPU5sg2tZl+pXJ2nn/nsVjlHfFz0yBkwJOiMrWWLH/tI?=
 =?us-ascii?Q?W+SGlOV+8JGWclod2VLlq1zhtqKjMEx47ZT5fsuzhVsYq/XJ7+BR/z5BhndD?=
 =?us-ascii?Q?cuSD7ObEjAnlW6PckCFvinrmRv0ZuLy0aCNz7hKkCEcj7Ou81ZvaBluIh1me?=
 =?us-ascii?Q?GNDHug+1fEQeJuLmf16i6kQF8YeFqfECei8DjEpoCHNLcepIHI2CDJFjIiZQ?=
 =?us-ascii?Q?09loG0kiVZeOCoRU2NEvIFI48ElP7DhQJ6+pgZN6LSbv0RnmanUK7Ej9IUe0?=
 =?us-ascii?Q?fuMccbcMxBifJPbrf22NBTT68Ve5Rwiqmmrd5bY0W4pNux53m9WukEFZopKW?=
 =?us-ascii?Q?pOdoAtzkOwOP99BD32eVazorOTRNWlVYdwdYTxEz1Xz8qRJdeHDvgqBPnd7L?=
 =?us-ascii?Q?kdvofqtvnOnzo9p7ZDJLqv64VfghDRCssvI6ODudCcajeVlNqifNHhJsa7Hj?=
 =?us-ascii?Q?u6n8oouCpkhyinRxfyWNdeTxWzBm2mDmFyOrRVLhC11o08M+4TGG1hM5I/yr?=
 =?us-ascii?Q?uZXRyXxctM0W5i5nhEK1OHscPKSkdBhMSwCK0yikQiNhitzj9t8nyi5MDYDT?=
 =?us-ascii?Q?Zt7T5bH2iZyq8Riu9iCxuShiaSBP7yLSA4crfjOVtC9S0oxkanLTa1L3Z+Ss?=
 =?us-ascii?Q?nlPoouBaImHUZ6Up1YxVZUuI2O1YNp2x+glRecZsszltEbTFleUEzcATxenR?=
 =?us-ascii?Q?JOQ94wRdVfVHAIM7tiqQoivZ4ltqyJN1zLHjH0AyT7dSuBcY0uwli5CtM79g?=
 =?us-ascii?Q?73vEwRl9l92W6YGh0gEiBgQolCBffn2lUKFM1p1zeyUWqMKXV1GkzpnZGPDi?=
 =?us-ascii?Q?0nvw83K0MmfW0aIG5debGqoOhKgejiO7vfqyzMGSTmp6iKjJRkFDBY1resi5?=
 =?us-ascii?Q?t4JHW6QVW2AlXIZKkYTMy3s0p73JJYPfePf+WPlgYLWWppWph7hb97lBl+HA?=
 =?us-ascii?Q?xevZ8YTA/NaqxyanmSTgma1KjvvsBuGn2BqCmaHQVPpAk4FeAsBB79rJUUmu?=
 =?us-ascii?Q?fLnG45OuBhuRW6Jd1PLV/u1ePtvcmwOdNOmmHU/VUxMO5m+3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd4061e-bda0-4818-2084-08dee7c79ecb
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 08:02:48.4274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gw3z90rY3+UTpzOd2uDrZ33G2s/W5wRUXUNuiSWy4xuQtwUh54eeeTOnEKf7DHhWgZckyIMFATNLfxiemoTRGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR12MB999323

On Tue, Jul 21, 2026 at 12:04:24AM +0800, James Raphael Tiovalen wrote:
> When replacing the source list of an MDB remote entry, all existing
> sources are first marked for deletion and vxlan_mdb_remote_srcs_add()
> is then called to add the new source list. Sources present in the new
> list have their deletion mark cleared, and any sources left marked
> afterwards are removed.
> 
> If vxlan_mdb_remote_srcs_add() fails partway through, its error path
> deletes all entries on the remote's source list. That rollback is only
> correct for its other caller, vxlan_mdb_remote_add(), where the remote
> was just allocated and the list contains solely entries added during
> the call. On the replace path the list also holds pre-existing sources,
> so a failed replace tears them down together with their (S, G)
> forwarding entries instead of leaving the entry unchanged.
> 
> This is reachable from an existing (*, G) remote. An EXCLUDE filter
> that loses sources starts forwarding traffic that should be blocked,
> while an INCLUDE filter that loses sources drops traffic that should be
> forwarded.
> 
> Mark entries created during the current pass with a new
> VXLAN_SGRP_F_NEW flag. On failure, delete only those entries and clear
> the deletion mark on the pre-existing ones, so a failed replace leaves
> the source list untouched. Retain the flag until the whole operation
> succeeds and then clear it. Also stop vxlan_mdb_remote_src_add() from
> deleting a pre-existing entry it only looked up when adding that
> entry's forwarding entry fails.
> 
> Fixes: a3a48de5eade ("vxlan: mdb: Add MDB control path support")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Raphael Tiovalen <jamestiotio@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
