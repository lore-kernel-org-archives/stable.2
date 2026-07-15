Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012009.outbound.protection.outlook.com [40.107.209.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3001B808;
	Wed, 15 Jul 2026 01:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784077565; cv=fail; b=Tp6mZB9m1t5q45ezV0cilwsKuTjxkon0gufsfmu/dWB/I1lZtNoJa/tqihBxfwIwe9+2E1cyMGynUKzz19TzQIBJbqFlPH7LGpA2Lp8q9lmJU7tzcjnVwucQ/G0cbBezzYczlR8Uah+jqLFRvVntIlEJr5uspGlV8k9GC/nmAvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784077565; c=relaxed/simple;
	bh=JcV/zmwOIKFrap9zB6q4mG52Vyew9mpsdQLC/qSZ5Uo=;
	h=Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To:MIME-Version; b=aQ8+CdFpe7qBI1/ylCMVxda/FdiAEcoiqYS13NEmqU7OmbfjJkjyXhRmML0941Vi4Owfynlnzxx3gB7zXzzegArBynRhJiplqiyV4Z4vKhT05/9n6BnBlF8uBufB66M3WZbIgxP39KN49zXBRBM27ucSjJLbHOARfe3MgXj7wLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ue9JpYsf; arc=fail smtp.client-ip=40.107.209.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ue9JpYsf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/EbTaWW0QSHfTFEYgjVhl4IjwTuY7WcQX3DGQGkWD70V0WtPg6NJUTlw38odN89UNbfq8TiS9MQ+5qFMjV97kwlmUAIgp4EUK5zwvJmwi1OHXHYM0DvTjnf9xY8agB4aLJbo99o49KcOnNhRj3l/qNBnrMG1n0OX2ie2gp1qw5d97wN/XqRnjJlDnTE4fV/w9G+UxDy6Jis4mTFg+z25ZW92OyQbfo1TZbzyEhGtqihxNWrkmVx8bZjlWdQUddJ0wYMOC1Sn1ljP/h3vnv/bfTdsXlYIfGRAgC0TRfZLiQJnZjiunpIUjVCM5Y5laWMF1heqJ0UmC3EU8ohOj91tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/tR7yEMQAcBi3h0g+6bW8/9twO2Mh4hGwsSHkrLQSo=;
 b=BAf55fgpVRbSffChGNnJxNFCisIjjeuLNAsYkfz4LDwWllgtjtWg/8/oU/cLOFabPrKHsKWIx87VCMDLaRNOr2l2ySYseWLompMXggLtKjj/JuukWweWxBaCzybEKyGEDXh6Okhy5SmuvKdvHJ4n8ooq1BTJznu9zZMKcfBs3xAZnUgEtn39TpacrnTLvukk3+qIjpiS/i+9tbM2xQgnkCb9/nsKZg/4hzcuBjLvknglR/Dg80Q0gcmY7CuocNRbqwX/YQw2GqlZ9VTXIeUCwNu6DWzPWdVYNMCSavbV3uapc8FH21i6krrSZK40kzIP7kP6pNIY6qWlGuUcUKLoXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/tR7yEMQAcBi3h0g+6bW8/9twO2Mh4hGwsSHkrLQSo=;
 b=Ue9JpYsfR5p1afnJRZKuy9T7pW3WS4JzSeI27Uo9Jjc6XEGgVB19xjDxZkVeV1+5ly+IWL/DAubBgPgwv1SO5iharAMsVbwrFO1gJ1iMzy732WB5J3HRH1in2sOeeg/n5SFNPg+kp7LB2GQTfCusK0rmmVk3f9kyvNvqTdc9GYwNVeYn3NuXrVZQ86ugvgt+kT3HaHalLHpoAOziJC9aRmPTEGSyhC8FNdtrmOOrzbYVPr+DZ8SdpJOgjBdmL9lgcpRa4JEhcmYISxnuemF8Mkvmgwp5LWlRObgCLIsDBEXX+S95kRVdh6svq4bvtAEziXsVZzlqL4toCiA5KNOymQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SJ2PR12MB8689.namprd12.prod.outlook.com (2603:10b6:a03:53d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Wed, 15 Jul
 2026 01:05:53 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 01:05:53 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Jul 2026 21:05:52 -0400
Message-Id: <DJYQPL4G92KL.K1QTSHQ0JSU0@nvidia.com>
Subject: Re: [PATCH] mm: huge_memory: Fix kobject cleanup in thpsize_create
 error
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <zhongling0719@126.com>, <stable@vger.kernel.org>
To: "Hongling Zeng" <zenghongling@kylinos.cn>, <akpm@linux-foundation.org>,
 <david@kernel.org>, <ljs@kernel.org>, <baolin.wang@linux.alibaba.com>,
 <liam@infradead.org>, <npache@redhat.com>, <ryan.roberts@arm.com>,
 <dev.jain@arm.com>, <baohua@kernel.org>, <lance.yang@linux.dev>
From: "Zi Yan" <ziy@nvidia.com>
X-Mailer: aerc 0.21.0
References: <20260711084624.207777-1-zenghongling@kylinos.cn>
 <DJYQMTVRAHNG.1DTTNWHH4006X@nvidia.com>
In-Reply-To: <DJYQMTVRAHNG.1DTTNWHH4006X@nvidia.com>
X-ClientProxiedBy: MN2PR16CA0066.namprd16.prod.outlook.com
 (2603:10b6:208:234::35) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SJ2PR12MB8689:EE_
X-MS-Office365-Filtering-Correlation-Id: 43574d88-b9f9-43aa-a705-08dee20d3805
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|18002099003|22082099003|921020|6133799003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	HCiHoWX1KeB4zCBTn8FadT4LPa+rLkg/1Z88Yi3yYX1nv8SxHu28DZLiyk46pmQRlG0s9V0Ew4mexrVwxTbbIEVY1ZJ9DGJD33gLA7+Z05eQ6CVb2P01FQsmxFSoMu9J2mqswrVtwKoTy5efh0WSJ5cjGDdmB8tviFJkd9Ii7LLKwwuGLJY95TfhNqFW5UFOGQihNH1Vax/plkHizoWtnazJ9KMp36GMknEYB+DNesLgeGDDPL4qtK4ttYuknU42wWygG4Evb50N0qr0/Sbg3XFdh6GhGtzLVdadGU1BbZasd2sB1tmDHkOSgyp1DwnJhHnDIiTAKd61bFNmgCtbLDdoo6VpUkV2dQwqMvJV34DK9+pMDkHlzGkSIY49yIQVipGzD1pB2odvIHfPY7R067nAR8cf/CXFoBUG9L4wHwrC4mb1HmQYhDLN3iznErvMqJsvjlSnXvU6pDcnE2ggHOSgictKwx2Q4l/gP75bPZk1ux0EBFSBL/BXWUg52gjODsp7bA0j9DTB0o7gD1sph49TlnDBRLTltKHjObEs45e/OFpp4kRV1Ra0gKB0dYV7LXme8iZ34+A0LKRPEgOgdMiywehaJ5IiZvehisVdAgny4YsCI47/2N8et+XGYZhkRHHFFNrqYXcj8BrwqzYVcrGXN36wbKK8O4JTEN1vzedHybR+bnv+4Z0Hw642r/VGllFoedBj7H4MBsJkKkrWAA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(921020)(6133799003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ty9zTjZnUVJUNWl6OVpXblZ5aGNXQnpIRDZTQVlKM0pIcUE0ZWhnT0xDaldO?=
 =?utf-8?B?UUorbEtZTEQwWFp6bWp4dURSN2ZiOVZwSlVVb1U4SG43SElKaU15L2NIdnNx?=
 =?utf-8?B?cVUzR2NWd1lFdW0zTFdleWtMbXJORmFLUWhlTC9sNExQMjBxTUVGczk3VkRC?=
 =?utf-8?B?T0tvRGtwNEV5SEphVVNsSnFRZi9zYmlPc0k0cjB2K2U5K3p4eHhreDdMem92?=
 =?utf-8?B?VzNad2xWQnVIY29VUW9vOUlaWmVXM0ZlQTlCeTN3S2dWNnRwR3hXUjhyZ2Vi?=
 =?utf-8?B?UVFTNng2YjV0SjN6SHVrWXp5cnV5RTcwY3VpcXJVaHZZR1lDSVRWZ2lpVnFy?=
 =?utf-8?B?U1dJVjRQcnRwNlp2czRHQTNycWNCSG44MjVSL1ljb1E5L0p6YzAxNFNtQVUv?=
 =?utf-8?B?VmNsNXpqNGVuRjAwMEVZVUMxQmovY0ZDKzBkblJaZ2hKVU00SHVvYlYreFpK?=
 =?utf-8?B?WStCUDlPWG41UHp5YWh1bEc1citkQ2lDd0V1WEZWVnBWM3RlRW1xNm1iNzc3?=
 =?utf-8?B?RTNzbFU3MlFZeGRSZDFFazZKV1pqbjJjZWdGYWJHc3ZIWTdXTk9ZQTFqTG9U?=
 =?utf-8?B?ZTlLaGFtbmFQdzdJdXR4b1NFd29kRElmQ1A5Sk1QcXFSU0k2YUc2RFRBcDAy?=
 =?utf-8?B?bUlLTys1U3VsNDAzNmxPeXpTMTFMdHRFZ0twZHpvVW50WFlveHJqM0ZTbmpx?=
 =?utf-8?B?TnFBMGRtaGtGQmJnUTR5T3lSVUdpUThLZkU0OFlzMnF4TVBjTkRjQnFYNlY1?=
 =?utf-8?B?TW5SdEFkYlA2WlZKaXdrU3JkUjducnFmT3dnTHQ4azJNMmQxWW0vbE83Z2pX?=
 =?utf-8?B?T254alFFQXg4ZUk5Sy8xMFZmVjZFQjNZUWVRQk9jSWZkUWNiWnhQOCtXT09q?=
 =?utf-8?B?eU1qcm1LVWMyejc4ZVl6SGo3VDcwcmE1TEFYalh3dElRb1M2TjhXMk1SMHRM?=
 =?utf-8?B?UnVBV01vcjkzVXp5K0NRM0hKZ2l1amFKUU9YbEFNWEFuMVZab3FWdkJBcU5Z?=
 =?utf-8?B?YmJCb1dRUFcvelZiUmNoa2EvQmoveFVWNGNkMHNvcnZGK3V3azYvZGxCSkJL?=
 =?utf-8?B?RlozZCtuWGcwT0wrYlVjY1RrcGxtUU9xWHNHc0dPc1AwWmxPTmsyaTRxWE9O?=
 =?utf-8?B?anlieW9DNjJwR3hCaVZVa0JRcTZBcG1lVnA4djdGU2d2ZGFGRDlqUHpma0xT?=
 =?utf-8?B?L2VENVdUOVZjMDQrRjhQYmN5Q1BueUNxQ3oxdmtEdVh6b0lQZDFnUmZZdVZX?=
 =?utf-8?B?RktDcUVXZGZXaENHWHhtcUdPNUpEWlFCMEd5YTlzNWpkNWdYdWQrS2tkL0dk?=
 =?utf-8?B?c3pyVkErK1F0VG14V2xtVjJsbGRsYkdnamVYZlhEU1QrN21hTExDYlNxT3pU?=
 =?utf-8?B?ZmNsa1h0amZ2aE1DQ3RIRnBQR3A0ZFpodDk0ZDJGbjBNK3JNT3k2bWp1WHds?=
 =?utf-8?B?elRsQVFDdWNsVjFQb3lwT0RYL0FJZFdCWlp1b2JERGxONHl0bFR4RU5BVFBv?=
 =?utf-8?B?S2ppbXZlcW13MTVHSG0yVmtzOTcwSEJVTGxUZzFDUUxYR0w4ZUVhWjU2aW5v?=
 =?utf-8?B?ZjRPNU9TSVF5eHFOa0xNU0JqUlVNM0JzL0kwUDd0QzBRTWZ6QzZTWDYwRFEr?=
 =?utf-8?B?Q1RpS2xFN0UxWVBLSXQxRzF4MFNNcDZqRm1YZW1KT3crTFZWWjJjYnR6SmFM?=
 =?utf-8?B?a0VUMTJkZ3M5d1lDektCWFgwck42YmVTRkpoRlFpSkVxbUh2cTkxZ25QV0xn?=
 =?utf-8?B?cTJLUG8rNHc4VTROMXYyaDlXUURmelBoWnNTWWRBVVlmNk9lK3NEMWlPYmp5?=
 =?utf-8?B?ZHNXWDkxMFlrUmdUbCtUUTRYbGRhTU9kT29Ea3o1L2thUXR0UFZjVk1CMjhH?=
 =?utf-8?B?czRnaktWUEJPNXM3YURQcHhTRU1UNGlOUk9Hbk8xckRBZlA5SVROejFDQThS?=
 =?utf-8?B?cFZpQWRkaC9NZ2p2aHYxVlVpdkkxOVhkM25PR0QwL3ZRMThyVlFuZTZ5azJu?=
 =?utf-8?B?a05adkc2NzdBRzRHZGZISWlPLzVLZ2xBQWZSajVxVGVuL0J0U2pSZ0dlaGlr?=
 =?utf-8?B?Mm1pdGVRZGVqWWFEcjY3aGpEYVhqaS9oRnRTd3BuUWRiMkF0d29YdlU1Q1cx?=
 =?utf-8?B?eGlQYjlQUmxwLy9MektOemZ6YTk4ZGdId3ZNdm01Yis3ZWN5VUlvOG83Nkc5?=
 =?utf-8?B?TmRaL0tBMjF0c3hGYlo0cGVhczA5d2NmakdPbmRiQXpIaUVkVTlrY0pDcTVT?=
 =?utf-8?B?ekpzTWNJempzcFQ1ZFB5cndobXBJR0xIT1U3UG5Gbjg0MW9ja25Iem1HYXJM?=
 =?utf-8?Q?Cmss1zxDxbVJk/wLz8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43574d88-b9f9-43aa-a705-08dee20d3805
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 01:05:53.6591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xq2FV9AGuxuH2flgWlM9KG72b3YlR+dm/aUBUAHfPblIbndKHPZaKQiBlyMOFHuh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8689

On Tue Jul 14, 2026 at 9:02 PM EDT, Zi Yan wrote:
> On Sat Jul 11, 2026 at 4:46 AM EDT, Hongling Zeng wrote:
>> When kobject_init_and_add() fails, the kobject API requires calling
>> kobject_put() to properly clean up the memory, not direct kfree().
>>
>> According to the kobject API documentation, kobject_init_and_add()
>> calls kobject_init() internally. If the subsequent kobject_add()
>> fails, the kobject has still been initialized and must be cleaned up
>> via the reference count mechanism (kobject_put), not direct kfree().
>>
>> Direct kfree() leaves the kobject's internal state (including the
>> reference count and kset membership) uncleaned, which can cause:
>>  - Memory leaks of kobject internal structures
>>  - Potential use-after-free if there are pending references
>>  - Inconsistent state with the rest of the error handling code
>>
>> This fix matches the pattern used elsewhere in the kernel and in the
>> same function (err_put label) which correctly uses kobject_put().
>>
>> Fixes: 3485b88390b0 ("mm: thp: introduce multi-size THP sysfs interface"=
)
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
>> ---
>>  mm/huge_memory.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
> LGTM.
>
> Acked-by: Zi Yan <ziy@nvidia.com>

Oops, forgot that V2 was sent and missed Baolin's comment. Sorry for the
noise.


--=20
Best Regards,
Yan, Zi

