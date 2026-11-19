Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795124849;
	b=ZIl9Ocbit2gvOiIESvgBySoT+P0+UPNk0UhNG1mfzjK+2qJNOR1ERvIHofp6SIIBkIse
	 y4VrC5sSkSx3DOiVwU0TsDHr/33amTn0YV2SCDscchCQ+40akP725AyIzmIhBiqCfvC1e
	 mfrTvNUkMNPS3V7wbyHeRMsLl1DKNrKM9iwFaRHE4knkiLw+E3yZsmMnPDAzri8bh0W5G
	 RGRoIaK1j0HuoPvR6e2R0D+8xr8GsGA9VeYSt0frmtjZhSIez11f/aref6bexEcUK8bl7
	 TOE3YM+CIe3xmVT6Zukvv6O4Lyblwoch7eh9F5AqCi0BPDAOXP3ocfmRVa49R/6O1CQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795124849;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:X-Mailer:Message-ID:In-Reply-To:References:Content-Type:
	 X-MS-Reactions:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=NMlFebgAdFLtndzHd8g6KCosKNzHLk+Lbi9q5dsjTHM=;
	b=Gdcwftr/vjO1feJj0i7Wl6CGqZ/O8ISahMK2VRskK/DCOEIxWdPSXYDsP68o6Vz0qu4Y
	 POv9JX7kYo786k5GBVC1K1OW6cFBQV0dnCE6VOCrqmZfy2nrVRTPoLXYhZulz8FhC8GYq
	 UJIRRRVIQToTS69eEDOBNUcxt8EBL2TS4RdwgEqceeaRsnr7VahyU6gXkaAb+SEE0y0QW
	 KFwK6fkuJv8x1dUdb6B5UgrLJ29DRapqqD9JMctjghnpVOOcs50S0/Fykek+2TNFImjZJ
	 Ax/A2hsJUFrgYnQCqSkc5ZOQwCAIc2osg9axX1PRGFkl1vznxOZgMsQ7coAt7yc6aCQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=X3fO7Qsl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.21
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010021.outbound.protection.outlook.com [52.101.193.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A866606A320;
	Thu, 19 Nov 2026 21:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A866606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=X3fO7Qsl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMVml5prmzhErHg/+1+DCCzrdQ5h5byi6pyXpQVBZTpAH72ovLX7sDWsOWPopjhdjQE5Es7Q0UhMkPjdefHbi4C0N2n193w2H5Mx2qQXqQeYTVBraTvjF68FXkrtTyAVdvPauy7KjqyA4Nr9OO643zkLbLselyNTvOAaLOZNa3PEYJ7x/X8wpwRtxrMugu+kqLzisi/zqEp/UrjmgQB87B0SRW5w0w1IETc8Pax09hExzbd82ElGzmer0QpcCw8PindSzFtBsLkv83aIuaiNB1y7653nM9tA55Ya4t39Dq6DrfOO0U0GCtnTbjT5TX6vp/vVnfVQ3F/OHGztk9c7UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMlFebgAdFLtndzHd8g6KCosKNzHLk+Lbi9q5dsjTHM=;
 b=cYtxKkcZYu37wJJWZzZCAsHxIsLbMQ3t3sSoN35ufdexb811FismWlM0rqXir7hEgfDKizGceBLZBE7/Rt4cFNZjythMKk7cDByHWUpNH86xtQfjwZ87+nz0KKhY0aa7mkwtHmwSeCffiBGaLc0nH4/s8BhE04CKwrjg/BFq9N1IalIZwRqen1gK3ZDsQWU2wl7Zs4gBTQpFijhmFEcvPo0HFY2iWDfSadqbvzsUjLZkOsU5XXOxlMsbi9wx9Xc77VoWuOW6f7CBIUyJVj9u88Lso3a5X2sq8ZCP8yIpGdFslS88+eUWfllGpoY/9jIgDvMM4JkPIJE7EtzSRX8rWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMlFebgAdFLtndzHd8g6KCosKNzHLk+Lbi9q5dsjTHM=;
 b=X3fO7QslrwhAzEfaUcWvm5csUvRQSJ00HpDBR4JCx/aTtlpEeBVTeGkW+2qyWardgi6/iY3OhDHocCBnbl+Zxq0UuiqXSxcZEOVgKrTPNIMf9grvQ8rimf+c8TVFo1ycuIs/BZkmtTb25HmnXUq/pEW5RZW0cXiCUA7IhYkccdZnO5iljfvqg9COBAb86HOsyTmDqSwBDHFLC6H4Gu9iHXBl36Wfmrgm02GMNCtok5PeztmbkUskdLnyCNbfXSbygwX7U4Mr1QFf8kgy5MqZ73z0VSiMnK3/HZVBSjceqtbvsBhJmyxHzU/SuNSU66oPucZwEFiYYCPmXgwEvTRIWg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by SA1PR12MB7173.namprd12.prod.outlook.com (2603:10b6:806:2b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 19 Nov
 2026 21:47:21 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0615.009; Thu, 19 Nov 2026
 21:47:17 +0000
From: Zi Yan <ziy@nvidia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 =?utf-8?q?Cenk_Y=C4=B1lmaz?= <cenk@deepfinresearch.com>,
 Zhang Peng <zippermonkey@icloud.com>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>,
 Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>,
 Mel Gorman <mgorman@suse.de>, Sasha Levin <sasha.levin@oracle.com>,
 Rik van Riel <riel@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] mm/vmscan: flush deferred writable TLB entries before
 unlocking the folio
Date: Thu, 19 Nov 2026 16:47:14 -0500
X-Mailer: MailMate (3.0r7038)
Message-ID: <270E76EA-7C09-4251-96C3-8A8C45AD1AF8@nvidia.com>
In-Reply-To: <20261118-file_folio_flush-v1-2-e9e739ed14e0@kernel.org>
References: <20261118-file_folio_flush-v1-0-e9e739ed14e0@kernel.org>
 <20261118-file_folio_flush-v1-2-e9e739ed14e0@kernel.org>
Content-Type: text/plain
X-MS-Reactions: disallow
X-ClientProxiedBy: BN0PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:408:ee::13) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|SA1PR12MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: b3eb8179-9a08-473c-95bd-08df4686ae50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|261102123227099003|261022105027099003|261026140227099003|4143699003|11063799006|56012099006|10067099003|261021121427099003|261021123027099003|261028144727099003|261026121527099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jKPJkinmRw9/gltqiAjW6hKxBCNTFqCUgbpBmDtZe0lfeUQqxH5T1IFfwv9xBGIzAPlIW0mBCPS/NNAs6QKxOWVdJaosTSU/YkdI5gwrT9Qo5UfQQFYtsRjINSv4M0Bm0eSGYXtKFkEoZXVILVU51TkiloAU5mozMoZvQIOjSI6/YFe3XsJGMmDKcpu46xMdf9D1tP8YBXnZkaKgQBxhxhtcucErpRkJJKUDaISq/Jl9WqQOhaoo5euP2QmRBhLAk4YpgRMOgKbsWTayybR2Rp3CALX5OCKqAcrVfHemlOHRoN936DvT2UaLVNWSqvZdwsCnvvEGHWGFVLMbHtRodniiGncarbHKkg2/Wzjza40T7FCZYPdKz5fTlZdodJbEB3n4TKId+laoXoMCoXhLPmH6As4+LptQLtxFtYR6mKcqt4wIjeDVrl2SX7l6rjFkGrEmIqRyCIOnQw14l1if8/FQRozg8ymMbfHI3cT22JcI96xbLiIrYslpLxxhXO8UylW3A8qK+qivOxnv0Q2tcREhZrzaG7ZTbnBPPTjNvvRopt6HlNlMOJf9EM8af1MNam9WfuukjbOXAgf89MXvndoPRHIKv8sv5BvM3t1V8aqo9xFAUtkQ5b97tzf6TCKNYSKpiNCxYSlFvkWSFtL5yWO5i2QXRGvPN/g7s9MeAFM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(261102123227099003)(261022105027099003)(261026140227099003)(4143699003)(11063799006)(56012099006)(10067099003)(261021121427099003)(261021123027099003)(261028144727099003)(261026121527099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TbQnZ2FQFUdWpPjOXM6/2RkN98dY+IZvs0VYmb0r4o6GyV28+4B7W9h/RMrE?=
 =?us-ascii?Q?qKm6IMS2eCaTla+FB2YNdy2xbq4LDXD1DT+6ppXOg0O3HY+co+Ke1CvN8fHZ?=
 =?us-ascii?Q?RGkHnMM3co6YEA0dWFOx2/NW4Y9CUSVSxhwBvAojub90rrS2rGMgjuXjVm7h?=
 =?us-ascii?Q?SOvv3a5QSqdjar0rsv/i4e7h/N0YxOn9wM20mLSIzXa/h2oT6VLJXlF+3KVt?=
 =?us-ascii?Q?oY64vH7AwFSyby29+SiIMGozC0ys6srbGUe9EP5Ugy0ImBlGQwsImg6Lzj+m?=
 =?us-ascii?Q?xwjoNPSGdyttKztuPcnCr7Hsk3xKZTocFhvSYywot4LjeT5Uytws+fM4olkk?=
 =?us-ascii?Q?/2q7x1nLX4zB0wgq530FuJdz+Bd8v0d/JarC3lGPS+L3qxcRynv5ja6Dpslv?=
 =?us-ascii?Q?9qrMq0Jt9f4QjMnuBSQ3v3McmQ1lezdiENMjC2mYdTGPbUdpMQvjA5BOfraw?=
 =?us-ascii?Q?N3JfMynciEs0opqbX0G5k1MV0kQgC8GGdVjD4wrXFKW+1Tm14RAd6QiUMg1p?=
 =?us-ascii?Q?+qRAKOf31Bnxli/w4YrROqdfxW/AqlT+lLtQTt+DcpR6f7dCD+JLQIF6ZnVo?=
 =?us-ascii?Q?gmQuvAtfAWhN1qQbLo3OcZJjJNIMHNcXWV4IVNp94YOzNCwUdA5yuy3yMBPg?=
 =?us-ascii?Q?H2CsZOK9v4L1Qr+dI0ivh5fSq8eTRtNhCKhCKEIhUKagCc3BL1jnDtGQp5mR?=
 =?us-ascii?Q?nAb2kmEq2hB6L9o98J77kwCzQXwB48Xo71u3VODN/Y/xuVg4C7RVyu2SmSrz?=
 =?us-ascii?Q?IL26NR9RWdHPMwtgUDwjRtjn1SgPZEa/tcDZ5QB7A3OOwHMKYkOKbBSz9CDj?=
 =?us-ascii?Q?Ktik9LeYU9VHCYCm3zUXax5i4T8sODYnLihdZSm1lTnzvpezYgXjFO4UJYUc?=
 =?us-ascii?Q?8lkDT7uzD3GUz9G+hJUOF2hfilCqMlNMc6uyTR0UDhCi/j0g5j+y3LRPpW5V?=
 =?us-ascii?Q?mrHLTqeXoPebep4rpUuUbvIEtngXCyd7+0PO1w/cZQDk2P2yjL0b0u8efd6d?=
 =?us-ascii?Q?FI0qddxGMCVIkA4DJQfXNoToyjTjhpjA5zGZgXqw7xLOuc8TxHmQaXDDElNi?=
 =?us-ascii?Q?NINu+SOLGRl9udZzVfdlpayGhf0FxdNfiJ4A2NSn+TeQqcb28yskcfHCo8EZ?=
 =?us-ascii?Q?QN8j93kXgV7Fynx2ONDpwgdjnSV2pQHaKZpeWxPinBHFCFaqy+LD1igfLgNg?=
 =?us-ascii?Q?3wk8xaV22h1ERKjaGG99b2KKJsiTwVMec8Fysolt1Dw/KTsBTownxl7kBMXG?=
 =?us-ascii?Q?gHzv+gnD90638HHqf2yElgkiGJNYcn5YpS+FQaz7Pu/wvF8bu9VrTekQjx23?=
 =?us-ascii?Q?FV3ppEwygEDkqhg2Lph/QF9tL+njxqksoRX6qRSxgi6qoVAA0dVI2GzV4Cns?=
 =?us-ascii?Q?ohJTw+/fDINlipC0CAxxyGMaWE0s66zXe+NBEwB45yNX4GZQv4UDmZVPEVOU?=
 =?us-ascii?Q?i6m1fI0C+Z+KjeHTCiY590FaTKTm57bULttuKFR5hh5D4bKA3UgdRS5vCoBq?=
 =?us-ascii?Q?ulxJm+kYRXi2bY5N/AiG1hFQTdYXfB9p40jFMWdmm+RolVR17LQAc76PWdqH?=
 =?us-ascii?Q?q7Nq4KxnXF7XRYcEAqhKhqaw1woyRDutFkAT5TKPRXvHhfNRYfrhTuzNgyoY?=
 =?us-ascii?Q?0eTaeOxamFZSYmRV0UoagY+DBD9F5Re5AmyBtw5Sl0PcCfqqmFh+rz5uQhsR?=
 =?us-ascii?Q?f6hSmg1ILBwFTiuNgx1zIQcxF67aIiDkJBg7O5aweG44Jnp7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3eb8179-9a08-473c-95bd-08df4686ae50
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 21:47:17.5881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ef5+tBd0i/i0TYCMAKcBLWKac2TTUvh2OAmBbUc7OmXfsN4PdeX0gNLzMUyH6zph
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7173

On 18 Nov 2026, at 4:20, David Hildenbrand (Arm) wrote:

> try_to_unmap() with TTU_BATCH_FLUSH transfers the PTE dirty bit to the
> folio and defers the TLB flush.
>
> Reclaim must flush the TLB before unlocking the folio, otherwise stale
> writable TLB entries might be left behind temporarily: writeback started
> by other mechanisms (e.g., fsync) will not find any mappings in
> folio_mkclean(), so it will neither write-protect nor flush anything.
>
> A write through a stale TLB entry after the folio was cleaned gets lost
> once the folio is reclaimed.
>
> However, reclaim currently does not flush the TLB if the now-dirty folio
> does not get written back (e.g., gets activated or kept instead). Fix it
> by flushing right after try_to_unmap() if the folio is dirty, which makes
> the existing flush before pageout() unnecessary.
>
> For dirty page-cache folios that reclaim activates, we will now flush the
> TLB immediately after unmapping them instead of batching the flush, which
> is the right thing to do. Performance-wise, it shouldn't really matter
> much, because folios with dirty PTEs are usually young and reclaim won't
> even try to unmap them.
>
> Fixes: d950c9477d51 ("mm: defer flush of writable TLB entries")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/vmscan.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
Makes sense.

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
