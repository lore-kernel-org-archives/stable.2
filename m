Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793722381;
	b=bedicvLqDH6LacM1nylhAEKbSxy7/16ufpR2k3r5KkeXygmRYTsr5n4ZaYdbhX2B2Fff
	 axKhyGCoJ5G23n9yfiWmAb/xUaxVjlDroBva0gQyuZ6mqBAPfMRYdczT7Y24f+Kfb3U9F
	 4BI3mS4zNRzkRJ6HXEHzpkGaMV0z7TgeJ9sknHE872vUz64KV0ogKJgljnIWwDtPnobha
	 XJip9GBVyrkeU1moH9efAmiaw+1ENBlUaMssozX0/ST5ptnfirmIeRY6Q+5gkXHK9JqVz
	 UwYi/0LOLUqEUucbNB+CiPLlCJKUT8L1j+UsH5cKbCbAqHjcBWMF3g+Ym3y9UGqxqtA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722381;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:X-Mailer:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-MS-Reactions:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=brER5E6AiOc41/iMcDOMIPpJ+BAylAFG8gkZPPLfEHE=;
	b=JMdIitMXyDw6R1zntNFldYcFuwzEMZXj8p8PQs/nleS2Rpkl7bS4OBS5dFJ7dLu+gIUV
	 k0MdslygK5ex+JN/DQdCd8YRT0NCU1QopN0cGaNYiCVJu7YbpHxhxQVeFXc4x9C6oSwuG
	 iLnt2FEvcVnWJXsrD4EfY0nVBF+M/4xMp4KKTASJTRMqBgCEBcV9FaAXtpA12fBucyabh
	 ofxHYoJ4iOgVKfanU1ElV+qwc6SV0Pn7tXJaD53rcSDidXr0SmDSibqyls76TyNZR8dpX
	 8kJONJ/gWDjNgYtQh+c/hJKP+mAdGkmnrVCsAN722/xiPUvygj1aFMMu+c7RuEANNMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ljfLG2xK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.3
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011003.outbound.protection.outlook.com [52.101.52.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382A3606A32F;
	Tue,  3 Nov 2026 16:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 382A3606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=ljfLG2xK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kR8YtGFM1AlvOdL0hlOiwtgsh8Js+9cqsO0JTEr0J0y/CMtzkTKyq/iwajYVeVUSdti//ftCma6bitoHXFsgu5+uyTryLJOpQ4tvCc36D88O61AOHvuiM026bCDqyO65/RP95YAamNN4jW4kS23vpY5mcF3Z9kdLOxFWtuDObTA0MZG+FI/RlVlRU6xnTguRxyCVrLtSg8gzYJRxrC7oSJCsYThyNwawvG+Mi5jQQqBW0MgwQBJelTJDgwqyGQmdMssmgRNAoSj9rCZVt2L6r+S9oR9c2lSB8EOAwMPqF8NH5V9Cg87Tsgf+52s85mONQwRVexHpXefeLPPK8h3R+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brER5E6AiOc41/iMcDOMIPpJ+BAylAFG8gkZPPLfEHE=;
 b=Gt8v4BhYboTr05cLAff62WErua4E6ljFxV7ABrjt3/Ldbmr8A0FCcTDKCg40eC21M/EJ7B3ib+qftoEEvKT/a32TMEI9ehP40wDL105b5ElNIFiMA6nGJV7Nj1d153+royro+Y6jS39KuO3bsleqQ1k5lnmMd2kYTuTCp7BGqw+BlaLbeeseK2Bt+0KKTRnqJ7WDMglCvvwJ2sbsqfM4vLKB+3oAcQfAsUOrWi4jFqfscnvrhepKdl9oyiscS+gZxpZt99eVbVD/fQCj1sdzxv+vKTDtivrldrslfIrYlU7O06ipQNkJXdX5J0gAQu7+QFFqE9oG79yysQZNhFr8+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brER5E6AiOc41/iMcDOMIPpJ+BAylAFG8gkZPPLfEHE=;
 b=ljfLG2xKmm8B/0lW0HB/xvYXLGP2FpfQVX5jHXVgw3iffGKonzuulz0GkPrTZPbEzTjCbl3FxQh1h05mdpAkK07FrShAmqtTjSjtWzdHFNrosdWu7soOYZ9vHq69A26HHEwbQ6uBFKOaXNqKc/imz1cgFyjPb0Tb34ZuPntvT7gEdjN91+bfeAk962zc2QrteSadjM49jk68qfknFY5Ih39Z6SZb/2MCbIsV99nLLZwwlf/ETMScaEAMhIBYabzzBeV8ZIkFUNOTTn8tKP3qrtkl5vEfRhb7D8GdI3skvP+PHhFcsvoxWDM7Enm/+kdD4tPg9VL5rKJR+v+dX5Y9fQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by DS0PR12MB8478.namprd12.prod.outlook.com (2603:10b6:8:15a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 16:12:55 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 16:12:55 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 kernel-team@meta.com, akpm@linux-foundation.org, surenb@google.com,
 mhocko@suse.com, brendan.jackman@linux.dev, hannes@cmpxchg.org,
 linmiaohe@huawei.com, nao.horiguchi@gmail.com, david@kernel.org,
 ljs@kernel.org, liam@infradead.org, rppt@kernel.org, osalvador@suse.de,
 muchun.song@linux.dev, iamjoonsoo.kim@lge.com, anshuman.khandual@arm.com,
 stable@vger.kernel.org
Subject: Re: [PATCH 4/6] mm/page_alloc: don't undo another isolation in
 alloc_contig_range
Date: Tue, 03 Nov 2026 11:12:52 -0500
X-Mailer: MailMate (3.0r7038)
Message-ID: <CEC81354-7239-4F7F-B46F-935BFEB8930D@nvidia.com>
In-Reply-To: <6091a4d5-ded8-423e-a806-2c4b11f21e09@kernel.org>
References: <20261027042204.3741307-1-gourry@gourry.net>
 <20261027042204.3741307-5-gourry@gourry.net>
 <6091a4d5-ded8-423e-a806-2c4b11f21e09@kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-MS-Reactions: disallow
X-ClientProxiedBy: BN9PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:408:fc::14) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|DS0PR12MB8478:EE_
X-MS-Office365-Filtering-Correlation-Id: 4656f0a4-0907-4233-4cb5-08df39c55158
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|4143699003|11063799006|56012099006|261009223027099003|261022105027099003|261102123227099003|261021121427099003|261028144727099003|261026140227099003|261026121527099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2Q/Q6OTyUnRzQE+Wc+vK90DL4wlQPZg8t5y48ZTS+F4od05U8+HlWNa/j12dG03n6hbdCxB4yj4ktBUCgEFtAgz6I6IdNZEPtT27mdc4CYkqWK0KNe6vnOYetDT1gUBwF5ErNdwrvR7oQTlfDPEA5dAjSoTZzznDJCFgY4t68rvIcaehtb3UcoKHrfmMKKw8AIfux/epl+yR2VQl1wLcUyoZyblS9PiNuMCNCjLsK/a0278hrhEjqKZ+RftpwXyKNhxvLgfz2BqpHLGEzdIcO61oKmEAAdf0ZRjnkrLfIQXYwfB9M+hNzYqg5TwH4vTrgSoA6XPRKIbbocAAn2Gk0rPsn+SeSJPsUKQsboBMexPuYV4+Q7pyJLv/AaXH/8Vkn5kdX7l6T1USNLv6zffNLhvSV9m2p9oPGeop3+R68cORHaNJOK0b8ZjFy4dHiFV1tl0Ct44s1NsdbNT2JUIwapxqhVyc7SyMwfaztF2vtSO4bd5PgHlvcqZkHdd/Ig96p8mT2VeekyWmAOlDyUI0WRj2tOfXY3c9WpYoQp/pXWlfC3PcEDWZ7cpd7y0vT/9XkBXpjBGEXJoS5gDDlNnh6+GujF4/XO9oKyVWyjGxXWElxjpPt7qhE7DTSOjuqG6HzokuK5/x1m5CGM15bUQ3FkTqbqVtx3iQ4Tv34kZisI4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261102123227099003)(261021121427099003)(261028144727099003)(261026140227099003)(261026121527099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bRDdnvkIm3P9iRNO2GcLAcWuFayHfgmYtI9V9ThTUTaJay8A4NNDKp69yeLM?=
 =?us-ascii?Q?VMrbNFxENH7Y4LYKmSXyOZBLGIFHqtpOVwuUu9MscSzhESKkVSqHstgekl89?=
 =?us-ascii?Q?9h80Uzk1jmx0Q0upbTqmGN+a+LWN8xesflIeGifPDSIS5a228WceiEiZikC1?=
 =?us-ascii?Q?hgQuR2anUHhgDr1EkR8xDDzLLUrj8OgbMVO8OaD7Mh1Z8Jvbq5XZkTgOLcmp?=
 =?us-ascii?Q?wv53Uiw/aspjouuzqf/4x0Z7aMIc/vXKk+NQOcgP5m6tbhMbL446gXVSqLyi?=
 =?us-ascii?Q?GAX0p00iAoO1k2j42wHhoUuPVUJHN4IIMVa8u2vLkwnMqAM6W5kYFvDcwhtK?=
 =?us-ascii?Q?kwiPP1HjUBNrEMAJdlTc4ByToqKtjSa2DsdjTueC5976bkKAGHOspRCMKmra?=
 =?us-ascii?Q?Y6zRiEZfpjzni/GEoVMXk2WPGhYBhNPc8FDeGi8xmtjf6SN5vak6wGVXIRhk?=
 =?us-ascii?Q?+EzqkKWvFJHwnXWBFg6lkrtwxU+vnFha8o7jueAx4sIkDbyezhMYUJZmk6eS?=
 =?us-ascii?Q?p44UEMU2ADJuIwFOT/BcRu7yuKx8uJglU6cLzGO7LDCEBi/pHE2wf2eU6GXC?=
 =?us-ascii?Q?iDAIKQCgpqIMghwUfYFXB2nr9yKjTtm0qStg7nFCAIWgktHQhDhfOzSdoPVl?=
 =?us-ascii?Q?SOYxCD5TxkYrbL8oJ5CpjLlsiOL2m1yJL5Yv3RnIbYZMkCSl18eXMQHSzeHB?=
 =?us-ascii?Q?5jC5NIeCbX6wYJNZFwqndlW0AAbsTopO6KvdMrLie0HqOG1STo2A9edsriNn?=
 =?us-ascii?Q?o1dIQGnQHebunYy2v2r7CBAXAtRqbqXPdA9eY4v7iEAsl79xeJVlyCpWmGdI?=
 =?us-ascii?Q?OQQOmWcJXl0FnrsjWPkuvLrhcWD8Rht1PtGd4hm0BwWSl6zVam37mmvlgiGh?=
 =?us-ascii?Q?7kgMvCHN6hxiJWFYu6gtpmHSTeQqlkeeEGkHCYJLu6ig/sVoAwlnn0Qwgwfq?=
 =?us-ascii?Q?TR2fyY59BTfftceEzGy5JcXcc2UtJh0sUJxrdaxSW4q+tmebEPNjJaORj4M5?=
 =?us-ascii?Q?5WFz7kptU2KqI/7uoKnFSoPEoYowsMV3JAwV9Q0vkJo9HgGp/6avZQW1o4EK?=
 =?us-ascii?Q?f+8Mq+QK9SGplEn5W1/dcqWBGe1VShRN8PqNSBr/mXJ0QPp+fWxJlSecQLk4?=
 =?us-ascii?Q?31l0a2FaGOm1XijZRw0LgCONboNE2hJPVC433vnE1R69NQhN/J5uY6Hh4qIb?=
 =?us-ascii?Q?nbt8JgSx6Huxf9T9BW4UeFC/owfqUf/ZfanwkBO2OaTtR+Z2GLs9JuU5ReGG?=
 =?us-ascii?Q?cYjz6KWGkEdJPSupNqY0zwDM5B/LPNW+ZpvBxRCPlREkIyHoOsYevfErSpHH?=
 =?us-ascii?Q?IP/pB5zkgXhBj9aupgcw34Flhjbt2C2kVZ0HaQGgFPSyp7V+p9CWnfLk86hA?=
 =?us-ascii?Q?bdoj1DtYHxqfBEsoWXYO0ngTdcVPSgqRjLLXzy+U/bv1B8hdvlJF7UC4Npy3?=
 =?us-ascii?Q?3nWhCnT5IYDx9pE/AhZxAFtoMGDHuSv/O0gysSDkwL51BRUwszXriKaSdvY0?=
 =?us-ascii?Q?hiWaCofXWF5wK+pdQvoKiZVVnukq2ocbQ74y3Yxfd2EZj2oLmbpuSZWZYco0?=
 =?us-ascii?Q?FHxo2sr9KyXx4j/zGhjBCCfnlNpOogevPr9KQKmIBh5mCmcBqD68Ton1b8RF?=
 =?us-ascii?Q?KPb9kTUbhbF0SxQaG75j0yK2w8CaXBK8gz/P+D7i0wQzQ2Sf0ZiIJVnTRXyd?=
 =?us-ascii?Q?/1s7935IkiorZnu2dJ5m7up8rYoU2gVwzct36dSZL2R10WWr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4656f0a4-0907-4233-4cb5-08df39c55158
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 16:12:54.8050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AuZ8oyWeWDYNkq05fnUFwrpDEuvDc1YRaPCNFNxfN9fJsz6OSAmzxAxCPCcaRfO9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8478

On 3 Nov 2026, at 10:12, Vlastimil Babka (SUSE) wrote:

> On 10/27/26 05:22, Gregory Price (Meta) wrote:
>> An alloc_contig_range() that overlaps a block going offline can leave
>> the offline spinning until it gets a signal, holding the device hotplu=
g
>> lock.  When isolation fails, alloc_contig_frozen_range() undoes it ove=
r
>> the whole range, clearing the offline's MIGRATE_ISOLATE too:
>>
>>   CPU 1 (offline_pages)               CPU 2 (alloc_contig_range)
>>   start_isolate_page_range()
>>     blocks are MIGRATE_ISOLATE
>>                                       start_isolate_page_range()
>>                                         -EBUSY on CPU 1's blocks
>>                                       undo_isolate_page_range()
>>                                         blocks are MIGRATE_MOVABLE
>>   test_pages_isolated()
>>     never succeeds again
>>
>> start_isolate_page_range() fails only on a block someone else isolated=
,
>> after undoing its own, so this undo only ever clears another caller's.=

>> Return directly, as before alloc_contig_range() went pageblock granula=
r.
>>
>> With offline_pages() parked after isolating a DIMM block and a 1G
>> hugetlb allocation made over it, the offline on base still loops 30s
>> later in 4 of 4 runs:
>>
>>   offline_pages+0x5b2/0x1570
>>   memory_subsys_offline+0x17e/0x470
>>   device_offline+0x250/0x340
>>   state_store+0x88/0x110
>>
>> With this patch the allocation still fails, and the offline completes =
in
>> 3 of 3 runs.
>>
>> Fixes: b2c9e2fbba32 ("mm: make alloc_contig_range work at pageblock gr=
anularity")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
>
> I've applied this single patch to page_alloc/for-next-fixes and will dr=
op
> the version from Josef [1]. Also transferred Zi's R-b since it's the sa=
me
> code change (plus comment).
>
> [1]
> https://lore.kernel.org/all/20261027-pgalloc-ai-hotfixes-v1-1-9c7d1aca8=
01e@kernel.org/

Thanks.

Best Regards,
Yan, Zi
