Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012005.outbound.protection.outlook.com [52.101.48.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CC52EAB82;
	Tue, 30 Jun 2026 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782832029; cv=fail; b=oayGT9D1zFldwiRkN6EajjM7MDI/OkcsqpHWE+BuJ5h7nuSA+morIK+l0QpoKpEIebaqZFZmnnnEUs3KyYk4XZj/TaTlbyGsw8EP9EAbZRDQKVdbjq3sRfxl+bV/IN1K6FfDwsJOYScvtoj1EpE2WO3UCwgIAUNDE4JIw5kRKg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782832029; c=relaxed/simple;
	bh=M/Ab+Qs2laR4wA9jCNZFC1jX0p0hZf7WGz+XDWoQB44=;
	h=Content-Type:Date:Message-Id:From:Subject:Cc:To:References:
	 In-Reply-To:MIME-Version; b=AeGqyQ6ZKS7DNMjz3fitTra/c16X1OTWc1nqHSU9ote5wEe4YwakoUsRBQYHFUMwhHkEpIAkAYtYoYnSKj++q8OXmjI3lhP2UrNWPmkLX+c3v+WpFTd5tFWdvsmmtcgJhFGy61Ui99ZQzqt+zd3+ODNMtOOEOu2App3F84uzUpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HKBE0lCL; arc=fail smtp.client-ip=52.101.48.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HKBE0lCL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HMWQaJW91amOPk5ZRdWoUKADaNT5t7x4Mki2dI7UX5zCE2KDK49QGiLrLxt2Zo7JHYRPzqlv/PhpI5UzuZ2ARd67k72nxxFwl9JzMPCxVe1Cd42IxTlkL/cYMcFRzT+CA1k+fwlHx8yzacKa9OZpRd/9J+YeabDkbD91rz64mVCm/eJkWl3qKv4KTJnreYYXakFwX66n1qCp2iEX4ENQsNAeZ6dOCZiGixA2y9eLWUK7Z12FZBHtXIX0ts+dvkZzAdTkHRvLOqUscKX2ERVeAopWIJQU0/sQy1q4wHyMjocS0OoJ4WwdGVy9Gaj0IMQwrYScZjxHYhIsJGJ4xCvQ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLU8CqZnoAqMbfwvvS9pPYji7oGHjBeni2LaY9TVYbk=;
 b=RoCNHZjfmP2VscnRiFdyKysZYGfyCI+Fw5NY2LLKu3B5fjGqVvOpQesbiNlL4WEFBVn+YRXXz/zjDT5JxDblN2GEFazM3eK7sEXGPtdWu0NONmsO4a/jM60cixtQucO7qVw5PvzminpxE/n6KJ687ssCsZP4h0UGnNBvcwLKtfVJ6scJw8GU49bAPBlFDjSZb7UsfmT9wTVGnEaarbndEwgNE98J6QPnpsP6BTPelrTsb49tkgmWnJiP4ljAFvwXzatAiJiSZwwoaA7qzkSpDp4DvYXfc2u0cnCwaxIZxgfcNZt3TrxKPisORNPwpAsLQpwmTrSBn1iCINAtIcHt+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLU8CqZnoAqMbfwvvS9pPYji7oGHjBeni2LaY9TVYbk=;
 b=HKBE0lCLJcOa3xlNhtehSnfK6l24U7EA3rbs/vwdPnVvfhzpCBAObWufu160IL+9VFZYDyz26FJgDJ3/aU4Gk7+wd6LE6QG5u4v/pNmk1bBHvFLRswgp/aEOnbztOdTupv2dGweBP07xV7X5+07vS67oAlppGE0lSlnacQ9rS7uBor9dbTNuYedzqYAhX6zg4IAUpH80F1LCKm9CQA2gekJsUdZ7t5o4DFlGxHe0phs7Yx7vDtU6/6v7pOe+gFYu2vzdeKytFlSYDzSweeNkd89yUUnZkPDtVJLn09vQFZA6JnXPsqZp850Vmp71mxwbp1NSo7V7OMbgbEjydxCLYg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by PH7PR12MB7258.namprd12.prod.outlook.com (2603:10b6:510:206::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 15:07:02 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 15:07:01 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 11:06:58 -0400
Message-Id: <DJMH7EKQ3SBB.2REYPX4LVFFTF@nvidia.com>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH] mm/page_alloc: free allocated PFNs if the range does
 not match
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>, "Vlastimil Babka (SUSE)"
 <vbabka@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Suren
 Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>,
 "Brendan Jackman" <jackmanb@google.com>, "Johannes Weiner"
 <hannes@cmpxchg.org>, "Lorenzo Stoakes" <ljs@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, "Mike Rapoport" <rppt@kernel.org>, "Yu Zhao"
 <yuzhao@google.com>
X-Mailer: aerc 0.21.0
References: <20260629-free-pfn-on-alloc-contig-range-error-path-v1-1-496ff9ca22db@nvidia.com> <4549ad0e-abb1-4156-95c6-5e3c1319dffe@kernel.org> <d44ae8a5-ec70-456b-92a0-ce7ccabf6917@kernel.org>
In-Reply-To: <d44ae8a5-ec70-456b-92a0-ce7ccabf6917@kernel.org>
X-ClientProxiedBy: DS1PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:8:44f::8) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|PH7PR12MB7258:EE_
X-MS-Office365-Filtering-Correlation-Id: 87e3b50a-2fb2-481b-0603-08ded6b93ca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|56012099006|22082099003|4143699003|11063799006|18002099003|6133799003|921020;
X-Microsoft-Antispam-Message-Info:
	BXSM9yY3C2lIjKCD7/msN8JT2iwfx/8eTcZ+Lbd/i/K/USCWlgKtD7Af5ny+8VHcUX7Psv6IF8oJFBHu14IjW83GdB6kMv33QyFDPUK/tCc6lIRTON8UjduSp7cKcBt5RCUZ6mUHTBM0B3cjlyIBiajUhEPk/Z9NeJOs+GvCx60HW9f0BFLSvS0Q3OiYLEu8PegNBWX8gY+RjFbC5HimtPwDHm5ZRXnh5ND0tACuZU0bw/nn+oUvvG3OXdC+s/HfLMF8p5TFOIFuUhvfoTiRhTyFYUkOfKo7pezOMo/puji3Civ6so/stRSv5pFsvOFBpGXZtksFJA9TA+QdFD8MeUPrGJJ2/zf0d1EKGX2H85tUHUFYWzMUvUJJtRXnZov6IykPmYxQ4x4iLIImTsOvJLHAlLym7ClLTrSXCP5wJwwUChnLGBlw4DUIk3p6v2yMwNUrhVoOG34HSeYTI8Fkk0jyVuCjOiMafAX0k5U2dMPpQ75rEvbLKmHCQHMGaVLmSV+aUL0a0r3LolHNR1ez9IwA820+kR72ExDus2EribCEYmJxt/MAsuRwrVADy14Sz5roqKBv5eI5aID+4CYvMQUSJRJRMfalBABxsglAeapzb19k/v65q1QjP6MdzWAOo7o09dAPcwv645zphLhKP3LXqOpVWwN7D5gut4n8DVu+uYfPhM4FCbcGMQkZaRR/ZIYF+lvod78x0sLnHdPpOg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(56012099006)(22082099003)(4143699003)(11063799006)(18002099003)(6133799003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1RWeGU1ekVncUVoampTWlJqc2k0VDM5ZlVZNE9UQ0JVTHNVN2NvRWFQYzNS?=
 =?utf-8?B?cmQ2MkNKVldJZ2ZDdFdQQWFzamMrdEFzRFVnSjQ4TGlKWTFPSyt1aHZvc2ps?=
 =?utf-8?B?dnRUWW5LTjVSUlpsUWlxRVhVNFNNRUlNOXc5K0tTWFcySWVzMGZ3aU1lTDhy?=
 =?utf-8?B?SU95dTN4UktpODVpSkw4S21KVlhUSzlpeEpYRmhjN1JxTzE3dDNQdmtMNDNu?=
 =?utf-8?B?WG1KMzVzQ3g1dXAwSlBNR284Rjh1dzlQQ3pTTVNhWmdwa3JiVzY1M1FBYVFw?=
 =?utf-8?B?NXFQK25yV0J3M0ZpWTBFMzJFVHdXUTRCNld1dVJLMzFvUjArR1pwS3ZsOG02?=
 =?utf-8?B?QVZVN1RDTTBCcS94VTh6SVdGemRWVTh4Vm5jSnR6NStUaGRocXV5aTJ3RlJG?=
 =?utf-8?B?V25XbkJrY2VzT0pVSTlXTENXcmZqckZsRlJaeG9KMm1RdTZ2eUtQKy9VT0FB?=
 =?utf-8?B?SFExb3lXV1ZKK3Zva2JQSjAzazc2Vm9WM1BTN2tuUmxPQlgybjExU0cvSXoy?=
 =?utf-8?B?dU82UlZqZzVHMndzL1MvRHJoWGtPZnFrZU11WERPV3ppRUh6d1NTNUpLVGU4?=
 =?utf-8?B?bzhKS1FzY1NDVk5jeUQ0b2xoWmFuT1pOZmVoQ292ZG9lVEtyN3FUc0oySjht?=
 =?utf-8?B?QW4vQlpIbmhZU292SE1OaWdqT2xXeHIwa1h2bUF6Mmo0ZXUxUlRFbm0vY05I?=
 =?utf-8?B?ZmpTbnZmS2tucmhBUUtUUXJGQVRzS3FXaXVZcjRxdUFEUGlJRVFkejRuajdH?=
 =?utf-8?B?Q1YyelN0NXlVOGhId2JObkYweXJyREJGYUwvWDZuNCtLRFpHOGYyZkVXQlNV?=
 =?utf-8?B?eERYRE9YSUYzcFNyeU1xRU9SUzREdHdKT0dDaVIyZlRWaWFwaytIUktsS2tP?=
 =?utf-8?B?NzZKdVRBbkJRY3l1MkFDWDMyRTdSUW9QL2lycUZvWm1GQ1JpeTRHYkY3dnFn?=
 =?utf-8?B?MWtvS0h5SjRCc2QxVXZVNWpaaDhNUkFuYzNsc3k1UzR3ek5TZHRYSGkvSVkr?=
 =?utf-8?B?c2EyZXlOeWQ0ek9HMGt1QzUxTlBQNUtMbno4am9lVCs3a1dmeW1HVnBHNW00?=
 =?utf-8?B?QjhzM3FocW9jSXdpMmtLaUFiWC9WTDlUb3dMQnM4MVUxZTNLSGxvM3FrcE5B?=
 =?utf-8?B?RUN1dVY1dHBheXltTTdWTWk1bUJ4VUFtZnl0NkpZbWFIb1R4U2R3NFhTWU44?=
 =?utf-8?B?NVh2czcvRmdZa2NxamZWWUVSRFMwdjBreG95RnREemNaOXZ4L3pjSlpua3RC?=
 =?utf-8?B?YjlRemxxNGZiaENZa1g0OFFPRVBoNk5vMGFHZzk0MHRJV1F5T1RKMERrR0V1?=
 =?utf-8?B?dGY3a2F3M2syNktEeUFNSDUxZ2czNERrQ2ZsUklQR2VqTDNrSmVlaWdSalph?=
 =?utf-8?B?bnBrWVlkQjZkN3NjeUFSRDUrVHZPNFZRd1dZKzNmcDJTMmVBTUZhV1ZYN0tv?=
 =?utf-8?B?Y1loSGlUV2tVcE1XS3NrTnRiSXpTdUxpUCs4U1QwSTQ1ZDdvd1d6U3A0SHNX?=
 =?utf-8?B?Z2hkcWt4aE0vRk0vZlhERlV5SzJ1MkNHTVRZTDdQd0V0aHVFeGFkVVhGeitz?=
 =?utf-8?B?WElTSElwRkplNWppR2c5Si9YeUEzdGVkYUlDdDA1eVZZc2lkK2tGbkZNVXB6?=
 =?utf-8?B?dExyR0dtdmVXTTZJOWljR0ZKN2J3ZitjaUxtaDRSNzhqZk9idnppWXpPOTEy?=
 =?utf-8?B?aG1YdWRoaTNiQmJuRFA3NnJBYlZJTnJKZ3ZJQ1ZKQVlrQnRaRVBRbmJ6OVpO?=
 =?utf-8?B?NTJkTjMwT3I1aXRwc3FwcU5uZ3lyUzVQSmJaV1pQamY4dUQ2aVZlc05wODZq?=
 =?utf-8?B?aVdFQW15M056a0ZrbXhLbW53Ulh1aE15S09PTUg2U1p1NVM5d0ZlYlpIcm9L?=
 =?utf-8?B?eDZhS1FFZjc0c2NnVXBXYjE0SUZ3L1lxdTQxeFVpdGJ3ZTFRMldTa1FBUlZv?=
 =?utf-8?B?VmZnRzNKTzVzY0x1OXFlOTd1SFJSb0ZINWQ5YjlRVlVTRWZwbWhOVW5sb2tr?=
 =?utf-8?B?RmJOVjB6T20vTlRydTNDVWh6czE0aHBNdW4yalIwc2xEa1JBMHVtcFNkVHYy?=
 =?utf-8?B?ajZUUzRuWWRnZGF5U0xFem0zTmxwVnJXT3FDQ08yc0l1K2FZZlo2MzFDTENj?=
 =?utf-8?B?cjBYUksrUlc3RklPY2pJczI5K0V0VWlMcUY5ck04b2xrZkcycW0vcUd0T0E1?=
 =?utf-8?B?bi9QUWlqOVJ2R1pOMm9Ed2NlODJqekFrQWhnTUFMZWI5Z0c5N3pia3B1eVpT?=
 =?utf-8?B?SW5Xdmtnc0t3UjRZZ1NoYW9sWEJvejdxN2piRnV3bWQ3TGU0aDJVdGdscno4?=
 =?utf-8?Q?N9Q5umO/bfHnivaImc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e3b50a-2fb2-481b-0603-08ded6b93ca2
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 15:07:00.9581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TehMUaloaw814Tdz2H2rbSi8gwpbV8vGT5abEPaH5GLGItFUGh/0Lm63AWo3Dzh6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7258

On Tue Jun 30, 2026 at 9:39 AM EDT, David Hildenbrand (Arm) wrote:
> On 6/30/26 09:44, Vlastimil Babka (SUSE) wrote:
>> On 6/30/26 03:35, Zi Yan wrote:
>>> When using __GFP_COMP in alloc_contig_frozen_range(), if the allocated
>>> range does not match the requested one, the code errors out with EINVAL
>>> without freeing the allocated PFNs and causes free page leaks. Fix it b=
y
>>> calling release_free_list() in the error path.
>>>
>>> The issue is reported by Sashiko[1].
>>=20
>> So this?
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>=20
>>> Fixes: e98337d11bbd ("mm/contig_alloc: support __GFP_COMP")
>>> Link: https://sashiko.dev/#/patchset/20260628-keep-subpage-private-zero=
-at-free-v1-0-f4ce3930d10f@nvidia.com [1]
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> Cc: stable@vger.kernel.org
>>=20
>> Hm well, it's a path that warns, can only happen due to a development er=
ror?
>> Not sure we care about stable then. Anyway.
>>=20
>
> If someone would run into the WARN we would already be in Fixes: territor=
y.
>
> it's a path that should never be executed. If it does, the real issue mus=
t be fixed.
>
> So (a) I don't think this is stable material (b) I am skeptical that this=
 is
> even a Fixes and (c) I am wondering whether we should touch this *at all*=
.
>
> :)

I looked at the code again and agree with you that the code is not
reachable and the fix should not be in the WARN path. Theoretically, if
order =3D ilog2(end - start) is smaller than MAX_PAGE_ORDER,
find_large_buddy() can return an outer_start smaller than start, leading
to this WARN path. But currently alloc_contig_frozen_range() with
__GFP_COMP is used by gigantic hugetlb, thus that is not possible.

How about
1. making sure order is bigger or equal to MAX_PAGE_ORDER,
2. adding a comment in the WARN path to prevent someone else trying to
fix WARN path if Sashiko reports this again

like the patch below?

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ee902a468c2f..e87d3fced9d4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7130,8 +7130,13 @@ int alloc_contig_frozen_range_noprof(unsigned long s=
tart, unsigned long end,
 	 * In contrast to the buddy, we allow for orders here that exceed
 	 * MAX_PAGE_ORDER, so we must manually make sure that we are not
 	 * exceeding the maximum folio order.
+	 *
+	 * The order cannot be smaller than MAX_PAGE_ORDER either to prevent a
+	 * potential mismatch between the requested range and the allocated
+	 * range that leads to an allocation failure.
 	 */
-	if (WARN_ON_ONCE((gfp_mask & __GFP_COMP) && order > MAX_FOLIO_ORDER))
+	if (WARN_ON_ONCE((gfp_mask & __GFP_COMP) &&
+			 (order > MAX_FOLIO_ORDER || order < MAX_PAGE_ORDER))
 		return -EINVAL;
=20
 	gfp_mask =3D current_gfp_context(gfp_mask);
@@ -7235,6 +7240,7 @@ int alloc_contig_frozen_range_noprof(unsigned long st=
art, unsigned long end,
 		check_new_pages(head, order);
 		prep_new_page(head, order, gfp_mask, 0);
 	} else {
+		/* Fix the caller if this is reachable */
 		ret =3D -EINVAL;
 		WARN(true, "PFN range: requested [%lu, %lu), allocated [%lu, %lu)\n",
 		     start, end, outer_start, outer_end);


--=20
Best Regards,
Yan, Zi

