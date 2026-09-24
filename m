Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011025.outbound.protection.outlook.com [52.101.52.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6964A2A41;
	Thu, 24 Sep 2026 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264575; cv=fail; b=XXIaG//xzJdMI0A/fFB+Ct2vuSfBah8lH+7im3KPLGcqQI09HnoyO76wyhhblKAVb4xu515TKGQX8uJWaQMT42RmAFTX+cnlvz4KBZHAd2F+vjfF4DK648b9wX6u5PQ0y62JvkqK0ZjKl4m0IhkkIe3g2tG/daKTrIvt3CNP2dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264575; c=relaxed/simple;
	bh=SWcky/VAUSAFla+aHfz+Su1BB24L9ZX0bvc2thwsy04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e163cAx4AcJAxPpu4fy+KUy8RmZ/SCZlc+I1z6YL3EYxk5Gd28pNObcnjoOcmlPSMGeTwDGr69tBsItEtNfWhdY6X/bQAjqp6QMdL1vdKegyQp4yzzdZ/twvkJhH1A3Hdz96t7rtZ+g8gxU5/tng1yJI9ZR7M50m8nHiY1ZWsXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E/UncQXw; arc=fail smtp.client-ip=52.101.52.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E/UncQXw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0IrOl6JuQrc1gdcQt8iQnq5Z49fkUwScyKoryA3PkE1/Xew1CzHQkXKaRXCzJ1hGZxKYW2Cb4DpRip6DV+ZCZiw/A/EW9POehZWWiRhxCcEF3cw2OY/PiBGuDgIzpQW4nuFta6xjAsOCnQlz0gQtRAP+1EpjBc7GO51zcV2BUor0egv12WK/JPNBdVIKn4eNH1VbtV/bdiupXCzDXE0E7Gaa/pdmNYL8VzmxdsyxES4hDF2n21t1+rxGLNPqwjpDgviCDzLWY5r3ZFbyfeGAqWae2Oqx8kVOg8a1gVrlaMVXhD/OpMp0fBeoQKtVcKJOhtMU3U715s3FcCkCeSknw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wb9yCGcLRmRkrBIy5gsXJXhr/8BW5fYERBkgwIDYsIs=;
 b=GHPz/NgvkAFC1+SV/dcbAM/30EYoZf4CrkPYPnm3JnuIXnV6ENzqinkBfh3ljy/vqUM9g90ftggSG4rtYMtwh6rByupdIDfvqx5FPD3u8l/ej3eywgIlbLMS8hKscTbl26bVRM1FQfGCFjPhHWCICUMHKOXYu3TjoRheAhz/DKGwpZyw762q8kbIe7i4iQ9fP53HPvjwRPji4UL5LUALk1rWO6KMRmT/KBtOx5UTRS2UEuFs8yZbDuHx77weVWvTr6PA7iUUlTCnzDtanVZvJtb/2Z1zFFHfFvYiTdC7Yr0mvcwFEfagdaIgvNks/e9cLWuikuIgBBIb3xu2O/no9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wb9yCGcLRmRkrBIy5gsXJXhr/8BW5fYERBkgwIDYsIs=;
 b=E/UncQXw5ZoXWcVWhMiiis+e3i6O/cK605/IfrTerHA2Y+uWY0TTM3MDW/3ap8D25LlwAjNyn9IDRYfLbYtdfxavjPywy6H6VZ0XFcCZe5R26iDDaMAT8QgVSKeMHsePZkDqoRIxE41wDwF3otmVLrH9afKy0iBZf6/9DdMP303CVXxwRQFI7+AVxW09UbckKmrR9ZxHPJAa4sN0QFsVJMpB/Uy0oXIKIZiJ8FEV1/bUglqUU4NBrY+AyRIVCKokxHENCAqBFZLOlWsrOPJM3YRiST3UbGhlDXZw2h6+5H2k+bzYkmTS1EZJAmNGcFjONagw2qZBGIQFHAtPmJesmg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by BN5PR12MB9512.namprd12.prod.outlook.com (2603:10b6:408:2ab::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 15:42:44 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 15:42:44 +0000
From: Zi Yan <ziy@nvidia.com>
To: Gregory Price <gourry@gourry.net>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 akpm@linux-foundation.org, ljs@kernel.org, liam@infradead.org,
 vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 kprateek.nayak@amd.com, baolin.wang@linux.alibaba.com, nico.pache@linux.dev,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 lance.yang@linux.dev, usama.arif@linux.dev, kas@kernel.org,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com,
 byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com,
 jannh@google.com, pfalcato@suse.de, hannes@cmpxchg.org, shy828301@gmail.com,
 raghavendra.kt@amd.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/7] mm: allow shared folios to be promoted to a fast
 tier
Date: Thu, 24 Sep 2026 11:42:40 -0400
X-Mailer: MailMate (3.0r7032)
Message-ID: <54D318EB-647E-4E52-9223-507B2913A6E5@nvidia.com>
In-Reply-To: <arVDeAId7Hb-2RvD@gourry-fedora-PF4VCD3F>
References: <20260922182928.2199090-1-gourry@gourry.net>
 <20260922182928.2199090-3-gourry@gourry.net>
 <f0cd5c54-deca-42e7-bc85-1838dfa917f3@kernel.org>
 <arUtcPIw_FaUSPv4@gourry-fedora-PF4VCD3F>
 <e7f48cc6-be21-4ab1-91a0-df0e3a6ec0b5@kernel.org>
 <arVDeAId7Hb-2RvD@gourry-fedora-PF4VCD3F>
Content-Type: text/plain
X-MS-Reactions: disallow
X-ClientProxiedBy: YT4PR01CA0376.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::7) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|BN5PR12MB9512:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aec65c0-1f73-4e26-ebd7-08df1a5279e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UMpBM0C/Y2dJ35WG7QES9t8RCjeJcYqBOZPSv8GeWQSH4soqtq/WG4QTD4drsEetNs2nS3e6i5WYyv3bTblG2bH2oQFFGZrxmAYsbs4i1GLX8GdEDLiSz7ffKVmQH1IklkN00uz4V288xi54VDpdxsO2cfLsEeaRnXAOh8+PY3TPf3qxmz2DPdO9g4C4QZ+cKZntVIipckv0I6kv1g1DD2BI5ltGCz1Sl2MTF+H+ceELN/sbNXwd/qMUsvNg39rPlgDGxgcwmGcVLqveDQxatLJHHcRABJFQCk67PH8LfweYN11wmRcu/TGQusz9UgEfa2RvDpEaa1ABkb9/aUCo1+KIdbnVODEaYd1oQ4QyR9HullVKS/meeUlj1Rz6PsY5fRycduh3dy8Nd/6QBaFT2BH7mBAKbe12d6h911jfqwHvBeNqkEILFMzQBCmP3LGfHjkNFOQ7LHyyWcfEIVYduAJWoS6g+dck44Ps4NxRKaKsrRfHLmiC9tXKYMp6svweU5hkHX/KfYGVmWLzQhTPGF9yfZIKROnYrVmUE40HUW04+qL0ZYV7GidWA8rVqd/RCxxU9YdGQcfw4T03aGFw+E4RgwNJoLRyFcjE493mNl524ppRbep1ZEeDG6TQmMH4fcSGRxEDqfDk7fN73qs1r9pHlvxFp6tPgSefusUX6zg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uuNgvUE0L78aC19TQ2K6tKfPm3/dnqejls+e7830lKTRVIrdB970gNLpmR/y?=
 =?us-ascii?Q?5XBewqEpyDY49yB3VqkOAU4BlPgUzT5+3x9SM9FoQtSFs9sH2E9pZXiNBviW?=
 =?us-ascii?Q?fJBzU/0PzcOxQ69uIHsNfG9GXOzNQZdhHXk9LfJtfhDKJi3uon7e49l8OffP?=
 =?us-ascii?Q?TIJ1i3m3MsaAdL5HCHS70AWi2V20SRmHQCLyi42A7+tW4da3cewa88DCBp4i?=
 =?us-ascii?Q?vi+opvoGxCBfiUYO2N0ZeaglqP8Z/+Qs2mi26wAGq6AyC/eoAcavY6uXkaLd?=
 =?us-ascii?Q?cjQv67FqTFZua6EMmmVLa1RZ/TkGewAiVw7RplqJgtMQChecSbprHindmXFS?=
 =?us-ascii?Q?BpQoYvvRW5n4VOzKFn9Vhbi1WYs1QR9EbWcD8aOwlWk+Jzcolci2ss6+iTVl?=
 =?us-ascii?Q?6ogDU/WUS2HW08JlXNidE0K25OBUIZwexikuVB/5eMh0Ab9xQNo/vJRcd+So?=
 =?us-ascii?Q?j3c1LjzZ1dYT8AzHhtO2Ow7zrNabHMMzUAuQcnkhFxMZ58MOEDBZ3u5oFmIn?=
 =?us-ascii?Q?WC1iHH2An/oLYn9r1r3Q8JbDhErQC5MuIjudIL137LzIi6WPiM3OBhT4NGBe?=
 =?us-ascii?Q?YWaWdTLDsY08+UB6+1ME8OAHM8Xzuti7egZ9g7KTy+03jDphFnpUGREUu5ZP?=
 =?us-ascii?Q?Mprg2xGN9ed13l7nl11UC55bOxw9zb0JYrdw4QpcDJbE+QBCp4zwxCdvUp1v?=
 =?us-ascii?Q?nIAMy+TObjmvaEwbVMICX+WVbAoReSRuFNfy6pMvaM0d0CkJkN3g0TimR8/r?=
 =?us-ascii?Q?WYhSK8wmSBI/60eHesNAqvwfj7xwxasnhtqNjFKZDHV/aNvVJUld6Wj1QjOe?=
 =?us-ascii?Q?Rvo47yFSPivBkMpae36qBD1W41r//jCQ56MPm1JvLNmc09yWcTDJwtYlPwhh?=
 =?us-ascii?Q?37VRhDwmrMR9+pBr2vdCC2kV7vV5N8Zk+pbzp+Jrs16uedpnAkw9Z4w3rilL?=
 =?us-ascii?Q?C4i2XDOWmXvTxTPDrQTInhPfsA0plzpSgjxEfLSaZqYezUhNKs6BVdi3Bcyf?=
 =?us-ascii?Q?WSIvGh1geMu8h+Rr8DUWiEOdXT1uD6AnE04hEDNCs1i89tsyDTjqjCRLmilf?=
 =?us-ascii?Q?Tk/hILl9B1B655JEbAWppQA0s4xJD8C0Ud2P1lnfwo+Q614RAfBJRxBwxymg?=
 =?us-ascii?Q?Ff6B35nphO6mmyKgigK3iPiuSwfuLl7GXQIC+3BPQu46a+UZPMIBCs5vZhO8?=
 =?us-ascii?Q?8DchFTxLJ6CxfP0Eu6EJ+wAK60nhrOH9Y6oIqx9vuE014qbF5RaGP27z1Y7K?=
 =?us-ascii?Q?AR9M0uaE1nRiXIOqet3bgXuHI0J3BzS99Iz2r3+mAcgH6DYY1OigsVmzJ6oe?=
 =?us-ascii?Q?WIy1AQvy7QqO8FMR0f/Cp1OIbjPU2JasqAcL9kMzF/amfurayAm58y4V059n?=
 =?us-ascii?Q?wQB2b5wS84H2MxHD8Vs9hY3vahenH/lsYFgtOeLUkSnccdor20cXfLEx7lNl?=
 =?us-ascii?Q?n69cuaJKDDsQ9+8BPJqbWe4Tem0w442D7X3VyslsnsFSBBgnQF+vVUkkQJz2?=
 =?us-ascii?Q?Olwt0+HqZLGEVxjhQE3779aq2li16lutjI/uTu6hBRFpQ0i8VMOb5QzkryHx?=
 =?us-ascii?Q?2Y4Pf6vJArXlVOp3N743JG7wMfweS/cllTClNscNgCR4ChBa1/f36PKsUKiR?=
 =?us-ascii?Q?0AgNwQlPMskk/HkT1FkNZIhEgWfJZDoAGt16d8lobdejoccwsf1bmYtVkiwi?=
 =?us-ascii?Q?XkmEN+koab5L4GI1j2rfqvH7XRb9Cc7R+fQT1SCun2OArsTZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aec65c0-1f73-4e26-ebd7-08df1a5279e9
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 15:42:44.6417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oy0Mkh7Oo8e1zf7MHrc3epB+MQuTR4gLxdv/OCtxLbCIjcmsYr43KCmCFtl/Dgj6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9512

On 24 Sep 2026, at 11:37, Gregory Price wrote:

> On Thu, Sep 24, 2026 at 05:32:22PM +0200, David Hildenbrand (Arm) wrote:
>> On 9/24/26 16:07, Gregory Price wrote:
>>> On Thu, Sep 24, 2026 at 01:59:15PM +0200, David Hildenbrand (Arm) wrote:
>>>> I wonder if a better name would just make the comment above (about memory
>>>> tiering) implicit and make more sense of the sysctl_numa_balancing_mode &
>>>> NUMA_BALANCING_MEMORY_TIERING) check.
>>>>
>>>> 	folio_promotable()
>>>>
>>>> 	folio_is_promotable()
>>>>
>>>> 	folio_numa_promotable()
>>>>
>>>> etc.
>>>>
>>>> because that seems to be what we really test with both things combined.
>>>>
>>>
>>> maybe:  folio_numab_promotable() ?
>>
>> Works for me if "numab" means numa balancing :)
>>
>
> Sounds good, i'll let this rest for a bit before spinning a v4. I think
> the rest is pretty solid, but there's one other sashiko thing i need to
> think about whether it's real or not.

folio_numab_promotable() sounds good to me.


Best Regards,
Yan, Zi
