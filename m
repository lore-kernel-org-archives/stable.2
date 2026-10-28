Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793229023;
	b=FkbwnIieZfgZH/R1gnITHneVmAHsV5sAqLltDdbKc5ly6j38bOPOF4kbC/zHtNK/Pua4
	 rAqhlYIGYFHPhruTfPXgWnGeH9IeTBKtH+ZsjmQaIcPMM9sN8SziMf3MJmcZYhvZso/WN
	 ajFbV1Urst60qzTJjKFcdcMZR7+WavFEKKsBfGB0pDf8UNm5o/AC7ymZSytXRV+1BYQA1
	 8ihaLZ92YgQt0Y993KJ5/P0veVFr0V4iCkJPhNSUzNyHTl3bkWIaL6gbXUSFcE5umFWei
	 95zN4wVZyv+DCU7YqJ/krmEyhSQZNFV2HBhN0J6DsIsm/NCRM97bDBA6e4Y7cRk3jfA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793229023;
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
	bh=g5xkFd6sI1uZhxmA+Gp9yYHBGpaJVAJ+fhDw86P+1AI=;
	b=WmxhjcbntyuaLx40pMPikDtTAG2DEXlfkkBPXbao37pyaQfNxQSV8i/6nVFDaxGpTOPj
	 pGdN8QXpBYgINTppS/4ASi9w/T+yXOrcpU3Ne9qJIQueD9yBIVOScM7lJNYsHPzwMA/WF
	 SaGqCJoi7xOOi9LvHE59H/oBjS8oxTNZjAZvJxtX7xRP+o9Zqbfw5J9MR7wKN9IhJEQTL
	 NkSrgeAMiTw/sv/rEJ32OhTpOn/bMEXX8gORpo4DP2MgHdjfjnYP/SToB/bI784m+keQa
	 e9M7sUeLBk0Pc8OIeD5GjwlBT3taAIUYN1HVfYKeSuhsF39t7S0by/RBxRK+OmDWuuw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FyqiRcMv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.14
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012014.outbound.protection.outlook.com [40.93.195.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DE2606A323;
	Wed, 28 Oct 2026 23:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8DE2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=FyqiRcMv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVqWQgoGDde2H9KILAInPhoTrCx241JThpFz9a5r9DyolOU0JpdfJ1GySBvGNheN3swqjor2Bgbi79squDwduiMFD1VouO7yHcKgRMpwqRQwqzGBNvQLA8nkKiW9c8YZy+f/yLyreuwPBjTkgvpZvKYrQMtR+Iq4BG7gc5IyaM1ljQqaMspbRDrROoXS21gTk2FLbTL5IIBSxN7jyNAvrVKx/PfNNXp+LThB6eE04KZNtNZgrMN9MszaBZFKkGsJKolrC9XIhUVGm1oN6LXhA1DuNMjkXwcK9Ml4SqxnqDi5ESyAV4n+xPpXcjmz8b/PW/BTXxOaglKlnGr1E6zW4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5xkFd6sI1uZhxmA+Gp9yYHBGpaJVAJ+fhDw86P+1AI=;
 b=dyJonr8dIDHC9xc5UNmOlHJCP7WRdhtjv9snVDb+7CVgSE1SYaDpBDQQ990tT0yixmmRVM5OzUQFVWieNM5XgMAuAUs2a8iwE+dFPTd8Uj36cAda2wgFRug802UnWNMQcyWO1pNV1c4himWrJ8eEvwz3OGay00lpapGIB1SKvsxLB9xWiE/6Zdr4UhPGq0q8vr9/AO52HsjvEQ3Kj+rbcuwf3vpXRJAgJm7k4ReuUtsy9DArOfm798OM/2Is8P4kHV/OdUeQXpO46L41+mUhyjpgCOaQsWCqVRk4SBKrVa6Lod04cKnqwEQ2jpcTUQHeeB0mhFTC8cdBc85DYsCIzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5xkFd6sI1uZhxmA+Gp9yYHBGpaJVAJ+fhDw86P+1AI=;
 b=FyqiRcMvs3oC6xEMLrwSk7xl7lSl5SMX0tGm1vrMXKWCYeDnvA/6liLMVZeGD9MClRDIfZohWrgQfVZuFbTlfsfnfH5EEx9BoewtJFqpM45fbWuXHE26cy+nIUIn9ORVDbA0bcpUoljKQhdcxT3H30zq22wGTc94KmYgc6ZfTYfoQFhhpDp5HLFXvEJYR7RovtBdLyrPiCfA/1RAGiXiFHb+Ibnw/drvKSul6TIdxd5L6u519uuiNCZhiVdQyL+wXKTyQzmsqv/UO5sNJqaSK3nFjXBWnPx2D4sJi9nMxW8HIqvv/CNv0Xy5lVN6lGxtdYF82vPn/kxmmpFeDrn1vw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB9730.namprd12.prod.outlook.com (2603:10b6:610:253::9)
 by SJ2PR12MB7848.namprd12.prod.outlook.com (2603:10b6:a03:4ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 23:10:18 +0000
Received: from CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128]) by CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128%4]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 23:10:18 +0000
Date: Thu, 29 Oct 2026 10:10:13 +1100
From: Balbir Singh <balbirs@nvidia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Vladimir Davydov <vdavydov.dev@gmail.com>,
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lukas Czerner <lczerner@redhat.com>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Stevens <stevensd@chromium.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	William Kucharski <william.kucharski@oracle.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Nhat Pham <nphamcs@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Chris Mason <mason@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 07/15] mm/shmem: stop retrying folios that cannot be
 split
Message-ID: <auKA1a0uYXfpOjFi@parvat>
References: <20261028-fixes_shmem-v3-0-4ce3baf2db4b@kernel.org>
 <20261028-fixes_shmem-v3-7-4ce3baf2db4b@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028-fixes_shmem-v3-7-4ce3baf2db4b@kernel.org>
X-ClientProxiedBy: MEVPR01CA0005.ausprd01.prod.outlook.com
 (2603:10c6:220:204::14) To CH3PR12MB9730.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CH3PR12MB9730:EE_|SJ2PR12MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: 164170a9-e714-4524-cebb-08df3548a1d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|261028144727099003|4143699003|11063799006|56012099006|261009223027099003|261022105027099003|261021121427099003|261026140227099003|10067099003|261026121527099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	Y5Tsh81ZCFKPtVv5o5Tbq8rAU53TeR4EYJj2QK+b51OmmV7mRucCVgCeGEkHtyQ4QTYYNu45NTV71VysDqjf2HCglFnFfNMBSItFhIhNtQor2HyLw5MpV0OxR++rzTANh1hjIOQ6l878/I/H5zQCrLmrsmFUY1hqAiNWbEbJd2EAMQ4HXIElXLr/9Lj9jsPiTia60yhKibeN66KWUm+Gs+UngOJBsAjeTP/2eR+UYoFQ/HZR4Hmam6NEKo1axjiPFHUXCRHYacfkUxgzhfKpgKAhBCWC983HcodkTmNdHSQNm0x4TBzHwsyASBF1WBdnRbgVgEKAIUAUg8gGP4a0uz5g4jnUVBWkHdtTUnHaqwxNlOuIHODINwLQKkZI+/zcO6Ql5PXnKyQ/ckwupiFnKL8bOIFRDIa6Po0hLJcWkyTW+ZQe7Aobm8w/YKwCfGl+V6WFAKkFBk2VdouRsHBxSIoO7TXkVVgaxaiYkePybycJJMUzuO7cpdCVeJLCwdLNL90UuEbl0GYjE8p5HnaA9/8ju/xaFlRDmG5IGltrE06ymI8zWqPhPUCF3Xs+9ufk5/Wxs1sXnN1UM3fXjsnhpX70RTcyNGt9NiWrmFN3eWrNRAeLtH+Aj996s18EVVyBOyPbW9V/acgaybaJ2dnIjf5c7ZQ7OZWL6AVXQZ2T22k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(261028144727099003)(4143699003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003)(261026140227099003)(10067099003)(261026121527099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yfq3k2VxQNxnY+D5aMOtcSDk7GgCLVViSdSEdvKKnEhWbDlgDJQeJddUFf78?=
 =?us-ascii?Q?vs20+oETtGBa4S0p2GeHDxJOc/LotN3RNm1CjYQcnvcZ+6WI2jx+cDT7WiF2?=
 =?us-ascii?Q?VRnlaxu1H68T/NsoZ7/nLmpb7R+5Wu2n8Qs3SNt5jL1GGEFshXSnKhwrspsC?=
 =?us-ascii?Q?36MKNmLu5IFziqHMWEjJPZoW/raSp+bUne5JvhNGdq6H9UTEageRMvXa9yi0?=
 =?us-ascii?Q?M3FEjoJyUZHgcitqk0lgey89Cdcil4QiR/g+rFgR1IQclKHYzpHdy1gFwpm3?=
 =?us-ascii?Q?tfB9yU6+dYEH3gL+Ckq5fRA8hydITHjyUeg53Q59bbG+jyKFunBL9U3jLiL8?=
 =?us-ascii?Q?APCbHthwqJEEX71AizxQoyOVV+UG6/tk8oVT2V+Kocrh+FtCNMbD5rGzG88w?=
 =?us-ascii?Q?twp/kTmsGzgX822978LK+ZEpe5UwtHBIj6XmBopTce897CbeitiJfF5MzWWu?=
 =?us-ascii?Q?0wYHPIFO9l2kgEnSOCq/NRNupxxhaGGliEmR/dLiKIcAbfn+mysjCF1gNZo0?=
 =?us-ascii?Q?kApnLuoQy/0Gc9RYNjks/qwJNw1ofg6ds4Y6mPgeO+zL6CfgEJWTNCbmo9JB?=
 =?us-ascii?Q?OBAtz0hN2g+QMgDogvpgC+7V2oFy2hnnh3/dpRM4GiMmJg8pELHiKhzuxmnM?=
 =?us-ascii?Q?C8l/+In2Ew3QT1Ef7r5hYyOFwa+ojdOCACkuRQYd/Ou67YrgxLuTMZhRuWfZ?=
 =?us-ascii?Q?XHGE99jQkgOR+/PEKtg72CrbvKsKsyE4I7/rfHe57O7l9hgyrVpBEixyYnYb?=
 =?us-ascii?Q?8bjY5OdGUK0t9RHNP0moD/q54oHm2Ck+DodwPUET41h5a+NKe75gzWQocpEh?=
 =?us-ascii?Q?6cZtOGvFlyWonK4eN9eLnyZ/Of0bRF7Mvs1NfKF4MLeD57/4P1Pln+X9HFSM?=
 =?us-ascii?Q?4/V9iTkw+JcSfvIxu1NV4uD81I+EexQaJ9tUpkU12Ad2P1tCHFV7Tb8Vt5a7?=
 =?us-ascii?Q?Sru+nn3Po6lR75tvsI4aHsR/rMyfffZyPOTA5cV5wO0whk/I8Ry3oQmJtUyH?=
 =?us-ascii?Q?JBRZInl2QnGteAKzkC2gZRgKpZyYqdBh33l7qQ0Av1I0eXrhQXEeiW8L6CHK?=
 =?us-ascii?Q?D2Hf6k4Oe8+Y9JPNC014gt+YvAOV/CPDPtqGYoHz4VYa7ZQcY7qOU9fKw7Mi?=
 =?us-ascii?Q?rL+dYqYNAKKTYJAfLS5ErsfyNA4lebn4FeWTkfcbvZQy48p3f5udEovoQ7pN?=
 =?us-ascii?Q?2yma+Em+1boeG22bFx/rp2Xvv0W2X5lK9AaRLBL3mw+qrfyYPa4BigS6mxa/?=
 =?us-ascii?Q?N2rPoKg6dMFfXvYdrLH0A7oCvoMEGpsVRd4NIi5gBgWxQf9OC7rfpsd9Zvy+?=
 =?us-ascii?Q?nT23ubTqjZUZtWNaid9Rzp0XFmcPYCzWJbYK4NUqBxavzPdoWQ0lXZqfR4qc?=
 =?us-ascii?Q?bwv2sF6TChTfEh9vEkjWnVgv0Fh+BydNLWcmGiwV9mX1JzurXMMkH9gC3MQL?=
 =?us-ascii?Q?ptBzbP8Dp7iO7nasmTiJneLlE4SJzbzld/q3kFEf/CoWf/HWLHzYFJgjTqvm?=
 =?us-ascii?Q?eUnDR5GhedE6XX+psNDuXN9aUxka7+tX88k3dhzmz9AJm5ADe56K0KSNb1BU?=
 =?us-ascii?Q?TQZX89aGyvUnomHBFOPHVVa4U0eiiI1MY6aeEZAsK9k/omOGXHqgCK6UzsGd?=
 =?us-ascii?Q?7BJWYamh7rsYwWOHmeBFjMUQ0HN7SomlMaT0KXbb5C0n70Duy/8qeQIvia2O?=
 =?us-ascii?Q?iU5o0wfw/M+ZhS37EDlE4OWm3wpOUZ1Shlkoto6qM2w8G0+KhC3l7aPuXoWs?=
 =?us-ascii?Q?rN2RhDH8XQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 164170a9-e714-4524-cebb-08df3548a1d4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 23:10:18.1668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 713BIuzGXGGlzYsZkm2XilAt3232gSz2v98WGU+5c55j/xArngnaobZFCfRDOYxteOmO5wzUeYxXQq2KOWoFOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7848

On Wed, Oct 28, 2026 at 10:55:05AM +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> A fault or collapse can insert a large folio crossing EOF after
> shmem_undo_range() has handled the boundary folios. If splitting that
> folio fails, truncate_inode_partial_folio() retains it when it is dirty.
> The final scan then repeatedly finds it because it restarts from an
> unchanged start.
> 
> Truncation keeps the inode lock and ignores fatal signals while looping.
> A concurrent unlink() can then block other directory operations while
> holding the directory lock and waiting for the file's lock.
> 
> Advance start past the retained folio, whose truncated part has already
> been zeroed. Do not move start backwards if the failed split has shrunk
> the folio.
> 
> Fix generated by an LLM and sent by Chris Mason in private.
> 
> Fixes: 55ac8bbe358b ("mm/shmem: fix race in shmem_undo_range w/THP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> [ david: split fixes, simplify descriptions, adjust comments ]
> Reviewed-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/shmem.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index eddd5870be07..50d526edc2d4 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1481,6 +1481,15 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
>  						index = start;
>  						break;
>  					}
> +				} else if (folio->mapping) {
> +					/*
> +					 * Splitting failed, but the part in the
> +					 * range is already zeroed. The folio
> +					 * was not dropped, so skip it when
> +					 * restarting the scan to avoid retrying
> +					 * it forever.
> +					 */
> +					start = max(start, folio_next_index(folio));
>  				}
>  			}
>  			folio_unlock(folio);
> 


Reviewed-by: Balbir Singh <balbirs@nvidia.com>

