Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012065.outbound.protection.outlook.com [40.107.209.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B271C2AA
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 22:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788734823; cv=fail; b=PTzRdIfHRvU+DTcjJXKGXTnZSHrWp7vebERMWnoRW58lIRlk9gdCV0/2fPs9Pu6XEME1u6+xJfJnGetm72obk/4N0sszaFit4hZgkOGiUMr4JP1dOI2fpJ+qua0cWKmA5UCigO+NbTeHu8Rzyjd8PNv0iVn6zDj06YXyEZm/pJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788734823; c=relaxed/simple;
	bh=1Edb+KFgzJ2mj6Vl1i0lZLGa8H91ydiHfT09EGHdVoM=;
	h=Content-Type:Date:Message-Id:To:From:Subject:Cc:References:
	 In-Reply-To:MIME-Version; b=cjGe/NQLlZ5mM4zpf56P+Xd+j4IMMfEK9E2va1ctsmqJafJO/kC1Oi9BUcsxgAKSMN7SQewvDGPOpA4rDeIlHcyEsA372FyI42q4gJR18bm4mRUIz08u552hQdXPwcPRAmAZR9sMj+WclzAj2kYFGLegIxF2XRdRGZDp7PdL2+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Srk632mi; arc=fail smtp.client-ip=40.107.209.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Srk632mi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lx6tQmR26wdx135jDRi4lffQqFukXQuihY8dhAGMB/felIUBk+mpU/YgbvZezu/2g6A1EWnTnzto6nZFE1uv2cF7I4/FPu64j8NvHQuO5r+WZCQZQJ3UW5HmvQ2gVFBuoXRk7C/XsTubKngXqcdYX2I/9lBzrAWw7iW7oz9CosSpkzPsllXkUNqVodTUstjlG/PjdOCMzEplWzNsCmSHWa4VsQqwcjOsJ1el/a7kpyfS9q7Th4jQVAryRTuilVs09L4SpX6ZvTqifudKMquSx/FYpUSToU/sPnuJbMjmqR7kkEzIKJX/wKyN3qATK1kkAZ+85vZbFhLK1B0D8Pd1/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vBp4H0R3sien8kSCrYdnOGcIlEpHF+yCm9jbqCT9/0U=;
 b=ZPU9oeMzbOZ2mbBTroxyirfEWDw3RPDMbFJMyTbzDPQ6P79Td7VsD3d70Djb7L8sa5Nn6PXb6YiS/Hd+yXFszQjwU7x+5L/EPz5SQIzBVO0LjErXyLVvjR9o7h5wcwHEpLaf2FMKewaFLfuV5tmzyU9NXdZtuBWDJI1lJogJw4iHkVeUJ2i6LqE1GyTb9uHZhUpxKu8+tIA9RKyjRftyonaX28JDVBlnBCQf00r9nysNd1dQZIGwwwM0lKq2SlCxjcYZvPbdidmBtnankLFmbip12QSM3F9oGnDd+Kk4PpIQyyldFIiB9ul+drTubBKM+mFJUnsXlREmKoLC2mbw0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vBp4H0R3sien8kSCrYdnOGcIlEpHF+yCm9jbqCT9/0U=;
 b=Srk632miousnv5t5l6K2tEPCOvGcFLCCXeSOVE3oNJwV4ehzJSIIrAbhzzXB2F/kqP/g2XGPjPEDQFB3Un0cB4isRiDwFsjNi3sHoHJSlpqtcjj4YFxhZHtuF1HwhF1zjtcIymtzqbRok0I44qJqizKwvzkBPEseVI/tssYfH3+LJGXvjcveMbjWz9qNdUuuSCui+AA6LYHrjy/m8gtkGYes8OcGe90C7xC/HRDqrQdE4mKs5UWiW/GbfGI4vlcmJ8VsvI3wm7dGO8PjEr5ojekPoRxz6SVA2I+SglkoIJJrgD3QM9uetmmbj+zxwT++IOQfyb6MkolBbbFtsqdIaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by CH1PR12MB9621.namprd12.prod.outlook.com (2603:10b6:610:2b2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 22:46:56 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 22:46:56 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Sep 2026 18:46:55 -0400
Message-Id: <DL8LKM3Q9LGZ.DENNSVG6XK1C@nvidia.com>
To: "Sasha Levin" <sashal@kernel.org>, <stable@vger.kernel.org>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH 6.6.y] mm/huge_memory: use folio's memcg inside
 __folio_split()
Cc: "Johannes Weiner" <hannes@cmpxchg.org>, "Baolin Wang"
 <baolin.wang@linux.alibaba.com>, "Lorenzo Stoakes" <ljs@kernel.org>, "Barry
 Song" <baohua@kernel.org>, "David Hildenbrand" <david@kernel.org>, "Dev
 Jain" <dev.jain@arm.com>, "Lance Yang" <lance.yang@linux.dev>, "Liam R .
 Howlett" <liam@infradead.org>, "Matthew Wilcox" <willy@infradead.org>,
 "Ryan Roberts" <ryan.roberts@arm.com>, "William Kucharski"
 <william.kucharski@oracle.com>, "Andrew Morton" <akpm@linux-foundation.org>
X-Mailer: aerc 0.22.0
References: <20260904022657.2656810-1-ziy@nvidia.com>
 <2026-09-05-daily-reply-0043-folio-split-memcg-6-6-bounce-v2@kernel.org>
In-Reply-To: <2026-09-05-daily-reply-0043-folio-split-memcg-6-6-bounce-v2@kernel.org>
X-ClientProxiedBy: MN0PR05CA0023.namprd05.prod.outlook.com
 (2603:10b6:208:52c::14) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|CH1PR12MB9621:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c454490-bd96-4f6b-2472-08df0c68c105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|10067099003|22082099003|18002099003|5023799004|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	BJjAmo9keyz0UaevPrx0OQLRVb3IF+8t4FcACBINu/xBByFOffdGZyNa7BT/qJiLppGeO2jlAUyRxmju5O1ARGyEOcc20N20U6F3gxyS4RGk0lAAbP9a9kHsdcz13Vjh4JMxBHCbeervR/biUidTVD6i+OZkB93iGqQ8Kc97R7J2neSUG46/X0pPx6dvvrpF3ks1v7J2beShD+oE4lJatshxwWFH55uezyBsv4eSBM5tqISREi5/Xdskp9rC2rW2vaUuK5EkOB/atHlRFnQ5CiLIUMmqViHV4S/GQXyWGh3Gp0w/zklplP8xx+rQBoe45Jin8KvRb4tGgpmJhiJM2E3jDB27fnW55QGSA6jaGYj64//CSQmQTXh8FoRAfaUKnV1K8qgUr+630xMGnPUPRehrWBPcTWapUY9KOFIl7QToJy+YdmsBIK+MQlt+03OtjNWGZGeGfEuBESCeM+tpLYyci5UWH8HKsIpZNKRKij03p0BJiHQ1CwkMpTqd3c46DVivoJBFA/Z+TxyO5qGN3HQpezD3Egf/D9Q9SxmH0OJGKRFF76+3WuYT/qASzN/q5eTrB7YNfmoTcyqsecDQJ7ooiGngnqNVAz+neD5euUHlNsA7jkRc9OBqAGbjdUn6p8nwCa7cvoF6BW+GRJAYLuYDvaAgAS9JbkJ8ja/+xlM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(10067099003)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1RuZHlIdzRsZS9rZjlUdFVnV0dUdjF5d29WcStTN2xBaW9jNVNTSURCZFk5?=
 =?utf-8?B?QThRV3lTVVpPQlpwMjR6RGRiZXRRMnkrUHBoM0Z1ejErYlQ2ZmFRazAxeGQw?=
 =?utf-8?B?dFQ4SkFGRlJGb1FnTitlZFgrODMzU1VzK3Z6RlkzaU02eEFnRVdJdEI2U2NQ?=
 =?utf-8?B?eU4walV2ZlRGRHZOOStoc2lRSUgvWnBXWlpWYm8xRDZubXVjY0lkcWFCaThL?=
 =?utf-8?B?TzZTVG55c2I4K3M1WFRUSUNoWkR6ZGFVUWhocmc5NEc1VlJjQko3QkI4V0c5?=
 =?utf-8?B?OEsxZnk4aWF5QjdTd1ZnUDAxc1lwSUg4Y1kwQUhRWmZaT0ExcWE5VlVBOFZu?=
 =?utf-8?B?Z0I4bndXVkYydkpKWVJSVW0xS2FDMHZhWmhpL2xPc2xwZ0djOHp5d3dqM2ZQ?=
 =?utf-8?B?RnRyMG4xRDg2eHZ0dlBlVFkyN3dRVXFWZHk0a1krQnBLSE9aalRoVjIzR2JY?=
 =?utf-8?B?MUFidTRtUDM1YVUrUEhRb3VQajNyWUk3d0k3ZUtsNmtDUTZxMklQaDNoNG9B?=
 =?utf-8?B?OXIxd0JvL3VDY2tYbjQrSTdIMUhGQzJpQUJPS1BxMmZIcnUvK2FKRENwVmpl?=
 =?utf-8?B?bmVzeUFmeGh5OVJWaFFTUDRkR0p5T0lpSDBoMUFFejg3KzhlTlU2N08zbzlx?=
 =?utf-8?B?MXNYa0l3cHZ1dFZueVg2THk1d3VkT3JHTk5yeDFTU2NIWWhrRXhtRk5KYVB2?=
 =?utf-8?B?VzJta0RuWXc2WGU3VHloOGs4M0w3bXdZM0lZNjMwWjRLOW9OZ203eTQvOWZ4?=
 =?utf-8?B?eTA2bmJGRmQxbFhabEdCM3BZMjlFWEVFbTQ0eUx5ODF0VkhnTEQ4NTNzT004?=
 =?utf-8?B?Wnlxc1VBUTltaGV1bk9kWU1sZkxmUHQ3dmJPa3NEU3l1eXNDSDRNREovSFIz?=
 =?utf-8?B?ek9yUENxdlZLUWVjaTdFa0MrL0R1elpmMEQ3c3dyVThMeEhKUmlEQjBRQ3dI?=
 =?utf-8?B?UlF2bWU3ZjhSZzVJZGNQYVFkYVQydEwxVmJJblJQaktlci9XMEVMUWFwaWhn?=
 =?utf-8?B?Y2dqamdmSkRhNEg4TUs5K2JySHhxU3FrL29UVzJId0QwVjVWNGV0RDIvT1A0?=
 =?utf-8?B?RWdhcW5yVkU0eWlvZllaMXpKbEd4dC9NaUwzajI2ZmhzeWlSYWRSTDFyWm9F?=
 =?utf-8?B?TllnejYxMlJjL2xrOStSSUFtUCtyZlZrQVZwV2Zia1h4QkltYUdmVlc5aXdw?=
 =?utf-8?B?bEFWcEFxUlF2a0hLRmNIVnpCdXdYTFJML05YY0FQWGhUK0ROTUdxV0J4UDcy?=
 =?utf-8?B?dzNYNXA0cHZ1M01vZGk5VHBMK2htczJ4allvdXM1ekJreW9GaEpOZUVUdTdq?=
 =?utf-8?B?M3llZWoxZzVWbU9VL0hWWTZRckFMT0lZNGhuc3VQRlJUdkxwZXUzcit2RjdL?=
 =?utf-8?B?OG10S3k4Q0RVNkw2a0xHMXRlNFpKYUpSdmFYT3owY0x5SUd3ai84ZjhhZWJu?=
 =?utf-8?B?ampFZWVzek5YVVJPU2ZSb1V3N1VyUWxKbmRrZ1VHMmI5RGJENlFxbm1OUXBh?=
 =?utf-8?B?YnROOTVkUG1YRmVvdzdObllFa1hOZGwwazFvOTVhcEVaV1h2QWtYUkJRNlEy?=
 =?utf-8?B?QzJXQ0lxeS9xWkh1OHhTU3c4ZEZmcHZ2RC9BOGJ2Rmo1THYzekJIVXpodndl?=
 =?utf-8?B?NVFQWFJEajBSODZRTGVFN3lUVkVhNWREczVVZXlWRnFTOTJ2TkMwVGhjUmNL?=
 =?utf-8?B?VUQ1WklqN2lWMUtNaWpUdkhHYWxVa25hNTlLZDRWbGliQm1UU1Rwdk1TcW12?=
 =?utf-8?B?RW5JeTNNemdqUStXZWgvK1VOZDR4WVl4OGt1OUtaL2NSRXVqazgycFFCcXhz?=
 =?utf-8?B?Sk52aVpBNkwwY1NKdGJ2bTJJUExsWklDZWJoQlJBeTltR2NST2ZsaHhyMVZ5?=
 =?utf-8?B?Nmg2bGx5bXg3aWhFN0hiYXhHWW5jWStYdzlHZWt5dDJLQTdLa3h2cjFtak10?=
 =?utf-8?B?VkxqbXIxZmxrQ1QrcXV5SkZGY3dhaWg1ZjFhdks0aTl6ekIzamlkUHQ4Q3pJ?=
 =?utf-8?B?TjRGVDJJaXBBZExEMnlyd1ZRRkc0NEx0Y2t0VDdUaFowWEtuVzZJVkxyRnlz?=
 =?utf-8?B?eWF2dEVLNXNjd2R5SUxocXFRc3lCeG1NZWJNdjRwV3ZwNmhwNVJqcldkNkxP?=
 =?utf-8?B?azdKL09oeUNsZFpOdTZ2ZmpHSXRpLzM4SkFLTlNLRCtkdmNObjFXZU5tVzhr?=
 =?utf-8?B?L2xvNDVRT2ZlMTlTQzYwL0o5MXBPMzA5bHQ3YS9KdERROUZNdmlJK09rQnZP?=
 =?utf-8?B?akhPWlZGeTFVNi9WL21NbXRCZzNURVFZZm4yb0hVL0k5Wjlxc25LMU9vY2Jj?=
 =?utf-8?Q?C+Bo7y9PZ5madi69Gb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c454490-bd96-4f6b-2472-08df0c68c105
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 22:46:56.5367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhtWf/4HWGd03mKM7aZYEQYrkvYG4NxBoOqmEdGEdcRZG4582oG99GPX7jIrwRgn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9621

On Sun Sep 6, 2026 at 9:33 AM EDT, Sasha Levin wrote:
>> __GFP_ACCOUNT is needed for xarray node allocation accounting when
>> XA_FLAGS_ACCOUNT is set. Commit 7b785645e8f13 ("mm: fix page cache
>> convergence regression") fixed a workingset regression with it.
>> xas_split_alloc() does not have it and needs to be fixed.
>
> Mainline's c299a2285d9d takes a reference on the folio's memcg with
> get_mem_cgroup_from_folio() and holds it in current->active_memcg for the
> duration of __folio_split() - rcu_read_lock()+css_tryget(), released with
> mem_cgroup_put() afterwards. This 6.6.y version instead holds a bare
> folio_memcg(folio) pointer across the same window, which includes a TLB
> shootdown and several lock acquisitions - exactly the kind of window the
> upstream refcount exists to close.
>
> 6.6 already has rcu_read_lock(), css_tryget() and mem_cgroup_put() availa=
ble,
> so nothing's missing to do this the same way upstream does.  Could you re=
send a
> v2 that takes and drops the reference (under CONFIG_MEMCG, as upstream do=
es)?

No, this is not needed. Before commit f1cf8d2f36dc3 ("mm: memcontrol:
eliminate the problem of dying memory cgroup for LRU folios"), like
v6.6, a charged folio take a ref on its memcg. During split, the folio
is locked, so will not be uncharged. As a result, its memcg will not go
away.

According to Claude, adding a ref there might cause a deadlock when a
to-be-split folio has a dying memcg, where css_tryget() keeps failing
and folio_memcg() keeps returning the same memcg.

This should also apply to v6.1. I will send my version for 6.1 backport.


--=20
Best Regards,
Yan, Zi

