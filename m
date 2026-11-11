Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794438165;
	b=jeqYHSxK+dyAJbYjgswKit5+ujW4Kj03eWQecgXDv4ukOQBxZtdnBOROAnszBjhO6i/s
	 5Ad3eC3REDgfuL8LJH2Yu9BeyuCUKJVTbuzZX5jqBjxbadtLSqeq4HiPZidc0JEHCLwBE
	 4q1HIfh9d32JPMwfbgA23DNGiMhJK6wCsOnMxCPZ7URgoy7e5G22bQKywM+BANIeEDjGd
	 km+u/SmD9hWb926MvmM1iZ0renGiiEZEHzlvGN15/zNyn1wX8cUmCpFikdRrr8eE0mOK3
	 Q12+hFU9QW44bs1Hv2aafrK5APXcuEePmg27afCLjvv4WjiuyTKbiXCUw2RQAM+ogpg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794438165;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=s3BnHoE8kFAlaBkYu8qmnJVA1zvoFdsDfmIrlb1JmdE=;
	b=Gf73N9Lyhz6vra84omefeBiGVKAbAgJ4aZ0AFN5t/Hep9M65QHhzYUQraZMRut4FC0Kf
	 Tm52RXxLxGkgQ2C67stZmaxX83DRl7gFhm+mUSqr8XheuBfsJDcqja8xkHVPhafaCoXCN
	 lM312Bjc2J/mSR89q3UUwmtltwXswcgJsf6rBYHxfZV5bzqhbUy/YT8zLWRcGUbFKSz+G
	 etLlo7eOP09Ewpk1NiHKSAjnlbsWIkDrE/d8W/wmCWF4yvX4R7x9xo0TWWFmbTThDjIS8
	 IRIcap2mbVgZA0bHQrG6Ih2P8nMRrZbki9EtFOn89TyTWSQknxBaFi/LyyH0B1uto/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aesMqvfB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.1
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013001.outbound.protection.outlook.com [40.107.201.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2476606A327;
	Wed, 11 Nov 2026 23:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2476606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=aesMqvfB
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8hmEOoHFrjQU8HYLljZu0i0v//V7P+hCJUbzS75t3T0GK+fmmgxMDo097qHalBm7qcuNZG15V5kHRaA0gXz9uuWnLmFaPt6U+dGFCO3xgw64ywzaSP6yuEu36QZrI0Q1uOY+ype6qHbNPYUxqsyaL5nHzEqjqo60Dx4cj4yjWndLvjh+GZxXD2V5cC4M/YvjbxhAQ3HCnFspmweAKHcMm0UL6thhVy134w0CuBsG1ucQjcAtkI9gy6P4Y9mJsk0reJO6KJpZzVQHJED0iuFWTUc4sOVPcTsdH/iO6OHXGP/T1E/jidqIEIt/Z8iQibIHbg83+ZfQl+NomxjnkaDIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3BnHoE8kFAlaBkYu8qmnJVA1zvoFdsDfmIrlb1JmdE=;
 b=BK8UFyzI7dMUQ1+P+WpLd6UKY122CXjLlzatuF+a4/XonuVnlI72TrwsXU4apBoyoIJy8gefuukr6lG+jij9c5/T7xY43RXQgjvv+ImLm7Q5lChojF8oBpMWZnRlOsQErTqG5q1jiUDzoxJw77w2/hGnN3MecXyRYVAZKaazDIh0E8E3cIUiiFPLDGZ2bQrOtHaxRLSjRfUt4SaeNAES63bhYpVjMXCa/T0TsObRIlEhEEn1rj06ZZDStcX38Q4e7CJQIKOba30VlIn3bhbyUplRu0gdG9NwuW4xQ218OLdy5NviOFlKVGDW3MLh+zpifWy5/kTbOF/t9Fu6pKHM1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3BnHoE8kFAlaBkYu8qmnJVA1zvoFdsDfmIrlb1JmdE=;
 b=aesMqvfBtLjOg5S/PvvebWLOoAOyg43RVE5lipind+FK3p5uoSRSyz5rjHZF3CSKaCXcb9mg6NpnKy9dssZE28uxYrXtsoXJj2ZVyne3HkxqIUsWog4EnHo9KOvyz3PWRGcQE3Xf6gDrIwzOhsxV4PxnpeTS1vWXbf9/4uPI2G1xjc5gNLrclwMOGB2mHFBN5uHmzVpGMWUg5pinzce64PDNhM4n8PRE8mbJNvpsC9y0EM5wg8Qd1Y2oDKXu6b1Kdny5YqC9gai7QY8TitqumwXy2RjVq6YpSmlUjBjE+HjbjvtaV3JC+7G/7YuXGW6rNk4BUSXNxU8CZ4l+OvjGrA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB9730.namprd12.prod.outlook.com (2603:10b6:610:253::9)
 by DS7PR12MB5936.namprd12.prod.outlook.com (2603:10b6:8:7f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.8; Wed, 11 Nov 2026 23:02:33 +0000
Received: from CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128]) by CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128%4]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 23:02:32 +0000
Date: Thu, 12 Nov 2026 10:02:27 +1100
From: Balbir Singh <balbirs@nvidia.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Nhat Pham <nphamcs@gmail.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
	Kairui Song <kasong@tencent.com>, =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>, 
	Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
	Chris Mason <mason@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Mark Brown <broonie@kernel.org>, "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Subject: Re: [PATCH 04/13] mm/migrate_device: allocate THP deferred split
 heads
Message-ID: <avTwlHT8x6A9sCGU@parvat>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
 <20261111-mason-migrate-et-al-fixes-v1-4-3d2454362e8d@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-4-3d2454362e8d@kernel.org>
X-ClientProxiedBy: ME0P300CA0013.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:220:20f::11) To CH3PR12MB9730.namprd12.prod.outlook.com
 (2603:10b6:610:253::9)
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
X-MS-TrafficTypeDiagnostic: CH3PR12MB9730:EE_|DS7PR12MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: 758d449b-3917-4fae-f16a-08df4047de3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261021123027099003|261021121427099003|261022105027099003|4143699003|11063799006|56012099006|10067099003|22082099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	aIi1sfOlhnkZJ7mfeCwceQ8T9J2RMG2mso5drecXzkSVwEtU+VDR2t/C8OnYw6QTSZ7uGkMqKxKVqNRGUuKBXe0+Ui7ZRbxOabI4tC4exzupBZMbeUYvBJfi6IYpgkK5wgmMSZPE+FLLY2njVJCvwxaKy04GdQ6HkwqJ5YaYmC++VgNxnSRXFwWTdmY5XQA2AeIzFjYoP/L9Bx91VJZ1wyHtnLV7ZM6qC4gRumhxv5Z/7u95xJ/4K3mDlGTwQrzTGY9xEq91qcALo5sZi+8r/ACsdGUvIAy/64a7qZhWMeOGuI7WqY6zsv2KPbgO0qHmKCbzKcZmyW+B8RVjMMr2TmGIoN6ryAH05sjA+MHwbAMI/54Tw+Oc4TCnkSGL//87f4Nv3npAGZSG/aRAqBrCwhBb2BZY3zQr0mCUNYZiYZxR7bMEohvr02iHqjPY7j5AmKSAfra46FQfnVq7kmOsYuOi281axG/U6o1WpZ+O+0O/eL+ihy7pMKHrgtD9520LRHGvgCDu3IxS0NCpWmPqqi6DRkPzhwl/eqrzODCidacGaK/3iHodzOt3dCp0v7bGiCWg1XM8ejHWmTFHLO77HsLy6yWR+lQ1/jd2jBrNOKJtyXD0sflAGwZcTDVzs3SbcEebx+/2GM6ZNDpICQv8NyNRVI2pTQFZDf7a+DnNtXw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261021123027099003)(261021121427099003)(261022105027099003)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(261009223027099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1XGVFRcJBpd1qllYqZnCzQTJGMyiWZa/4I5hapSG0Qf8CZ9dneCQhsk5IBdu?=
 =?us-ascii?Q?qaw9dpa5QbURyLUao49RqrCdXa0DqIpq7a9UFVzq2+DOQROm0eVNhpoBLtjk?=
 =?us-ascii?Q?/WU6aOEk604JRt6FplWgFBOFFGvCbyM1iXCvToenTe+AGgXV9pgjHItpzIvF?=
 =?us-ascii?Q?w1m12/x9U4LmX4Vo1RemzpHWgZxKXh4z37D+VNbjHMJReXcei9+Y93e6G9nG?=
 =?us-ascii?Q?E1C6hN0GCbmldRvQgamOboBDttWHIW1aEjZIbuJdOMae46S64a+VlwfJpF9R?=
 =?us-ascii?Q?A8rNHaky1KHJ9lXTN19qkPbwehJxAa9B9v8OBuYpXZD2geVGMmN6W6AtWW5f?=
 =?us-ascii?Q?+7vu9Nr8gKJcRAMmoyjtYa25J6k7RGqMKR7h9Iuk0w6qLPko1QxWinqcnQOU?=
 =?us-ascii?Q?C5+/vjlN/EJc73K/9xhJgKrv4mAktA4zWb4K8BAH+8PvZNJkMcthnDwS36kw?=
 =?us-ascii?Q?6qTzaXoJ/BUc4ciUBL6wSPL5GRbI2dtdTQRzfgxZ6S762hmY62w/aCF3ZiPH?=
 =?us-ascii?Q?I5T6ZWXE7ep80wFxJTc2dy0w4jl2KJaCKRz6R9vmb0E9kWQ5nbC8cGzCMlwD?=
 =?us-ascii?Q?gNSQXYVUs3LIIjC/7lHmzuw4RLeMgHTzGBTtapKpdR9C1rx62NwyyMivxqfO?=
 =?us-ascii?Q?dskgrXait2IohVefTNPLZNMlwp3QixoiJz9Bf7HS3Q3jWxwSnfgHtcq0s71y?=
 =?us-ascii?Q?C6h1n9y0FfwKWdqcROa6Fb/PN3DAYMdsa6XUTiexrjM/vvcx6fZoC7MlJOa+?=
 =?us-ascii?Q?dSUX/90qrUD6Y7TnMU/cTCZt8m/NPJvE4MTnCWB+AjWFhZmeJAqoK0z/Dk+d?=
 =?us-ascii?Q?lNj38nf9ED1FOTvhjh5T2qP8Ip4wxciMszrvVQMCQZ1TdSdQTfLk80NPspem?=
 =?us-ascii?Q?cjvmdL8viF9D/dXq60b3qfRS+wfbSof4YxDRESP/ibCjOlIOgiPrmsiihH75?=
 =?us-ascii?Q?DJlOGQN2LRfO6GP/R329P2/5lWf5XglP54w7x0HUdy+3LzN4k2uumGbPHmUe?=
 =?us-ascii?Q?Azw3pV/4/8b5tWI1k+aqltZROM/YYVD/GgUAislXkjkkZJfw+rrAQqkdeL+4?=
 =?us-ascii?Q?bJveP7FtJlD6mm1/nkubFrJ72reYIblkFzQFtjk77RPehY0SKETzKNza37Ze?=
 =?us-ascii?Q?f3C5NVseWM6ie1gkL5Bt0cxtT/ZojsOAllGAVMy7uociXJcbCnEWs4sHvNai?=
 =?us-ascii?Q?YmY+kzVqpmuuUvPHmK3khFvt5gT6gPsXregLqk/F+T2/P30pJx1a+y0G7KvS?=
 =?us-ascii?Q?+XlE4yT7OgTKJZ3rdFU1wSvkA7Y0Vs1XmnmmA6XEEsne3dt0l3euchsAmits?=
 =?us-ascii?Q?AkRpRzix55PUT1eL0xGathoqaOiw/uTo4elFoI+5ZvNtD9X9jHLfpUuQNWAd?=
 =?us-ascii?Q?XonE+pBnRwK6/ic7NAzH3sQ+cHnfDk0l2zHlC7rPlyZsDMJj85EPFXwzB+fY?=
 =?us-ascii?Q?y53IdzLAbfIWVOSFkmxvr05YE5IdFpao90E6odxQnswvmG7YSu6ob60FXLyv?=
 =?us-ascii?Q?c6RIj6brQYPJSkuis+7jF3eS7kpndhKQRzlXysWc1as4GaVYBfJ8Ke2SuSkz?=
 =?us-ascii?Q?0fPmGto34d+tvSnDo7+dgeL4WTIndtdjYbONDsbyTtODmQjHtbwFAQp1KOla?=
 =?us-ascii?Q?MC3OXGpwkfkKWekw9TKLEIS8WcBfk6OjSjncvYAZZQECei7JU2qEqj1F/ztj?=
 =?us-ascii?Q?y3RQs5AcQnN6UQT6SDIdW9OCdfHfIuLQv5womfUxjGgPjmIT+VXscBSByfQ+?=
 =?us-ascii?Q?KKt7IYGIOg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 758d449b-3917-4fae-f16a-08df4047de3c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 23:02:32.6757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ajxrapcjq3Nm+c7bMi+anvswv3t4jvwltGTJCheLNtms4vIyLRoeH8s4u+apkhB+CO5D7YxhmSQ5vtsITbDbIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5936

On Wed, Nov 11, 2026 at 06:13:18PM +0000, Lorenzo Stoakes (ARM) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> A THP that device migration maps into an empty PMD can end up on the wrong
> deferred split list when it is later queued for a deferred split.
> 
> This occurs if the memcg has no heads yet (resulting in a warning if
> CONFIG_DEBUG_VM is set), where deferred_split_folio() will then queue the
> folio on the parent's list.
> 
> Once a later THP fault in the same memcg allocates the heads,
> __folio_unqueue_deferred_split() and the split path resolve folio_memcg()
> to the memcg's own, now existing, list and take its lock.  They then
> list_del_init() a folio that is linked on the parent's list, racing with
> anything holding the parent's lock, and both lists' nr_items counts go
> wrong.
> 
> Resolve the issue by calling folio_memcg_alloc_deferred() after the charge
> in migrate_vma_insert_huge_pmd_page() and falling back like a failed charge
> if that fails, as __do_huge_pmd_anonymous_page() does.
> 
> This was originally discovered by code inspection.
> 
> Fixes: fafaeceb89a5 ("mm: switch deferred split shrinker to list_lru")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ ljs: tweak commit message, remove unnecessary comment ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/migrate_device.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
> index 9e19fadfa65c..9e5dab8e1b77 100644
> --- a/mm/migrate_device.c
> +++ b/mm/migrate_device.c
> @@ -833,6 +833,13 @@ static int migrate_vma_insert_huge_pmd_page(struct migrate_vma *migrate,
>  		goto abort;
>  	}
>  
> +	if (folio_memcg_alloc_deferred(folio)) {
> +		count_vm_event(THP_FAULT_FALLBACK);
> +		count_mthp_stat(HPAGE_PMD_ORDER, MTHP_STAT_ANON_FAULT_FALLBACK);
> +		ret = -ENOMEM;
> +		goto abort;
> +	}
> +
>  	__folio_mark_uptodate(folio);
>  
>  	pgtable = pte_alloc_one(vma->vm_mm);
> 

Could you also clarify, if it is just the nr_items accounting that is a
concern?

Acked-by: Balbir Singh <balbirs@nvidia.com>
