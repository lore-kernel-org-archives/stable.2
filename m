Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.67
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793038257;
	b=T9q47vKikv1mR+rtjnbXTTMISxpLesgp3AvL+O+KuJOcE+/5F4t1TzGVGGWW8h9oLC4F
	 qE+BCLB8g+JcxIujLqNnOV1Ei+ifGGwC/DT978xw/k/I+9dDVHSl6TthmleuJnVZFfP/9
	 B1Q+4+n1bmAucr7eO3tNZaU8LGEke10UBy1xwbuwcRepJyLvSw2efUWamaYUKVZbWGYeu
	 /dzWl5RL71dWtUXZYkZyAHN9ESUCa8cnli5gzdpaTIm5TYlFMosOBrLe0MgCLZV8WyCQS
	 +ffcPiMMIwwTzsgCU1Z1ofdnUCAvAKSnGvOgmH2+d6kdRt6oL8XrWiZ5QVc5yyIs7OQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793038257;
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
	bh=aHbLGME1zLdpD+ZxcXS3dYUDC7BfDhB0kmRSRoqnWEQ=;
	b=gsRKZZoND8L5baMioSd6CYf9S6nrIYmdBH6J4AH3LUKDcXenPWeLAKuUWXiVCLISRWp1
	 Hv1ScRCDfz+Y8gp3n1ocl6rZ8J213pl6Goqz5eEm6+8rxgFINEGs3rG0fSh/5qu8q9QMv
	 ar7v6f6f84ZLV/1MBUj1v/SBP1RWxqV07X2/8Bo3kyRJFkV7+NCFRH1kSBlGuL10lSJkr
	 EpyhtQ3290tSEpf4GjyNj5hEmuVSU773qSmhi3tTXMQ9SkAptWErwUSIQmDiiqh/iS87k
	 UqYH8lP1td90KCpKbL91wutpHti4eSE9XsPx7xXaWWe+RWyoD7ARwMCZ1GKf3QkNIlg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bf4bd5vu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.67
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012067.outbound.protection.outlook.com [40.107.209.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D54C606A324;
	Mon, 26 Oct 2026 18:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D54C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=bf4bd5vu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSp4TzAwSylI95jEYt8YMKswBCTPlCHkofBIwFIikNF8W/eBJXehFPKQwlJoB07v0RUfT40Y3jk4Qui1kcwPCiV5uE/N45Lco2AqvEs9OJJtTvsrcj/G+gMu1VBfDKm59J90sBIn93f/rsjtyEI04zGGDSFL5OOfDIzbhndBzj9Z3Lk8f/3euqr2mezbHscAwyTci4VqTWTHGDRttDNkR4Hq5MeG1wd9BtbcVv6C5cHtES03rm1bqUOXqLgxtYbq+qvOm+rVah4nQsZhg6YkZSMx/bCJ89+I2vboSAWDYeLXtaeL4tYPwOungE3fGsqH32mL64Ez9O9VQAr7PMCuvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aHbLGME1zLdpD+ZxcXS3dYUDC7BfDhB0kmRSRoqnWEQ=;
 b=lYZ8PgwZTyCSCR2BeeE8jnQeCu3IKZn7i9GJZN3z8SotXXW7xaDHwpgBXZTd/cXQR+5oGi6eO+TiWHL/oYMXUMky10DwQv6sSNVSA4j4K7Jed+Hxqw08Myuxp35h5Evn//w7hG/HDfbBgD3q3aLukecJ1EIOpbZU0mWrZlbs1YlvGfsmRr1u2p0jbqCQxEmnDnGp2Zb4BSkul0NMmIDcu9YtTCXCLn3xqU0W2LH9EugX+nbnvj+aW4BgbTwmY30NA4gPBCoZpYSDX8yuVshIVHq2014tfSbk68peh3jH4fuhqJhpLoQGsoJrfkICG6EhE22eBOSxB/pq+IzChxmLLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aHbLGME1zLdpD+ZxcXS3dYUDC7BfDhB0kmRSRoqnWEQ=;
 b=bf4bd5vu66XJMdj7bGFpxHvhPMT/tAhNB1R0oVeIOCt7Y9hfvWxo+UMWDfQGg3ntpZJ1aq/EJyKkyAg5NjEaFMpilUSs1StqqdD2N+QDU8Rf34h2birFOLrit7Fq6MIdfA2q9hifpGQ1z1B/blZEvoBVBTnpWe0VYFYx7IlHRbEJUTDE7GB+/u+Ns2zC2Bqhq19XIqDtGl+cpnPy407rpLLLfBm7GDTZsrRJrWvMAsPV3z1UoaUIne8YyxeCtUWbPnMIFcom84ikYgTNilG7fOx8yQMr6P0VMfxi+228u+e5W1nxFvJF/uVqpRT9X+AYXqtEjE+3x1Oz6iFtm3ScSg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by PH0PR12MB8126.namprd12.prod.outlook.com (2603:10b6:510:299::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Mon, 26 Oct
 2026 18:10:50 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%6]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 18:10:50 +0000
From: Zi Yan <ziy@nvidia.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Vladimir Davydov <vdavydov.dev@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Lukas Czerner <lczerner@redhat.com>, Carlos Maiolino <cmaiolino@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Stevens <stevensd@chromium.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 William Kucharski <william.kucharski@oracle.com>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 Nhat Pham <nphamcs@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Chris Mason <mason@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH 01/16] mm/mempolicy: charge shared policy nodes
Date: Mon, 26 Oct 2026 14:10:45 -0400
X-Mailer: MailMate (3.0r7032)
Message-ID: <56FAECE6-6DD7-4890-93A8-274776B22776@nvidia.com>
In-Reply-To: <20261026-fixes_shmem-v1-1-703206d5fa0c@kernel.org>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-1-703206d5fa0c@kernel.org>
Content-Type: text/plain
X-MS-Reactions: disallow
X-ClientProxiedBy: CH0PR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:610:33::14) To IA0PR12MB8374.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|PH0PR12MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: b371e49a-2450-4070-8f9c-08df338c7798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|7416014|1800799024|261026140227099003|4143699003|11063799006|56012099006|261026121527099003|261021135927099003|261021121427099003|261022075727099003|261022105027099003|261021123027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	VO3EO+y0r20K9UX5gVJ1ONVNjf6RZaSzQM0oWehNeh/BMbzuMGzuYdKSp4zPUA/mC2pgN0qrsWNxbjK/RG2tAHGO0+n/6/x/8UDfdCuStUyh/yXOQYiu3PRS6sGHUXEDhuE5wOJCZKI9ldyDuOZ76US4fgq6ltHCARmFRcsOo4VXaNFfcuLG8CNzNJEKht2hqIQmqvCDeJdOcFW/erx+ous+p7NMvnBUC3/dXWB831IR2MS/jYqfhGLDbazJu1+6x3GDvMABMThkNKnsJf7I39pFs7qowb8qKbNy2iDE2Eaf7PMzZ0hZXzLl8uz5CBcjlA0sB02NKrSL9nlyLZKBxTEncqiOlkpseLkQFpNHenP4eX2jAxr0/AsETotzEF1CVIcfUDvccq2eCJ59LANlYm8aW2IIDAHH5I7WXjVAx3eNPujj9ooqiagmTcqJo/d/JuC/dqCF3MBwaNJSxML3OOUIiRDL4kZUSs2xctFT8Rj9N+gKQCsfz9zqTuYM/ZImsDCKVYk2EjWaSkRuat/T/cPHKMOgqp2WdR1UiPo5kJuVZl6w5AkMX7WM69Dzh/xScGXqxfqOePKjQfl2kelAhD8WfXlSte62xP/xkJsxX8ebxtLNHzMfy7p1b1DN+sIAe/L/o0zQ5s/uzS6LI8obJfIf6TfCoPNfLL1Xwyq4PjM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(7416014)(1800799024)(261026140227099003)(4143699003)(11063799006)(56012099006)(261026121527099003)(261021135927099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021123027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uQjUqPxi5ztEl4WJBKJp22xEJhngQpxIfFXeM18he4MrN2UN/E9InJqhVIno?=
 =?us-ascii?Q?npzgyoIZQdkrcr7IHVy25S2gmKVdyfCpv3ihsUNwpL4uQ9OBt9KIJoJ9G+rV?=
 =?us-ascii?Q?gjXTREk3NY9vNLfy/c7IRiQ27JHNeigF7vvMOkIWGxe8vWgVSlT+S+GZglnJ?=
 =?us-ascii?Q?gTiwVXcvYEgGpkh9pnqXclJhFOWYSDGqjnG5ZpoPpu9zhI+NWE3/Bj05haU5?=
 =?us-ascii?Q?4LXKg9D3mba/G4fo8evUrxSY5dI8wM+GlzR2acoZ3lGkilTNd8vCV39BcGTb?=
 =?us-ascii?Q?heRDxyNEHnu/1PU6PREpWqFOEyDR4EO4MFFujDd6iFp9m/JyGv7WSIbtL2vC?=
 =?us-ascii?Q?jMsq7H7UYGj0f+SpA50hZn2lFdE8NmGLd2skg+YbOS93m4pPFl8I7bQXY8tI?=
 =?us-ascii?Q?t0N35SN4kQjnFZSCd5hAg4mHv7ngAoeebBZHmuFe6l5qXoDoJXc5+5P1ov2X?=
 =?us-ascii?Q?+MrC8tncj8Sv/r+53/aoiBc78uLonb/Tg4IqFHVPOuxR0QutcTqBn5vrnlDj?=
 =?us-ascii?Q?v+Sfz+1W5WXAPDe0FopDaajYqZoEf8KruFChsY1pfsz0+ILHBcvdbslw9pSY?=
 =?us-ascii?Q?mBVjao7wsnDxpX587Xk0MROuLftlJACbhq1/85LTq1gzwFzCeyd+TSza5R3e?=
 =?us-ascii?Q?a/C3XWT/la3sc378oM6Yxb3m381SYo7sEjUp04GtfRRTS8NEM28GYRwba+1H?=
 =?us-ascii?Q?X09Z45NOxt2YW6UK1oz+ukizmcMLl78JwI+7LhN2hUO6avIiIv4x3LIebBDq?=
 =?us-ascii?Q?PmfHQJjz9qVWjK0hEKLOO4I/+cj4vhuV5fpBLCpxigzYBTUjIpDtXSlKV4rk?=
 =?us-ascii?Q?lN0RBMo9PFGiRE+eeA9AdMewe+HFZlPYPzCu9LjA6BAB0xl6MvWeOqTV8Rj4?=
 =?us-ascii?Q?xniFo2CvMpBHkI115B+XN8sP3oIjJEEV5vgxYJCTZRAaOsqKmccjPLHlg8dl?=
 =?us-ascii?Q?yCL+6QAPj4YcSnd3gPJHwd9Lmq9QKJ6E7htP+iNAReGqX2ndvUfo688kQBsy?=
 =?us-ascii?Q?gLulKaTv+qimUpqzeMiQGG4buYj7W+KeBQM5lORk5nNxQqcQV/PE3xr1CBSu?=
 =?us-ascii?Q?cGE5uoDMX4ShPB97v/loQ3QGSBUaE6943QyWaLcVTjRt4Pq9i2JiEJzsjIkh?=
 =?us-ascii?Q?NBDhsoMrnLkUxwGhdfijCBU5WnInb1BYFnxgVLfvQnKaH8+NeTHSTosIpAP+?=
 =?us-ascii?Q?BFWJoPZkmFBnT8Rz8y1C9bYLMGJhvpRbBbUwHr+1u/HKYylxgnhQFrLrWxbp?=
 =?us-ascii?Q?SOIMYHmULxWsh53ioKHNPP0dDjUITSEErH1NVkADt2rbO8xiCk5oiwSBjdCk?=
 =?us-ascii?Q?4hk2AM9VPpxV/halUefcBk/h4avQk/ATg0RodIc9gBs2mls3o17n9062vKRv?=
 =?us-ascii?Q?YGT5IcYS1MPp8nt5/jumDhkQOW+kVcEK672dKvA4ikZoHe3X77i/w3PkhyCW?=
 =?us-ascii?Q?chj7gj6gS1FcS2In6LYav+f8Urfy/feiSY85rldWmv7olS0twgRfQ4rEihBQ?=
 =?us-ascii?Q?KcJB3W2+j2CT2RIuP0URRfWhvFPEjWsvbywbPX5t5kR+YK41IWsBOf4aKPlv?=
 =?us-ascii?Q?O6mlv6P57qfXLac/qQK/m0P+cdmFvAsDDDpkcOk0m+cKcC69lreMbaz0FfCY?=
 =?us-ascii?Q?teht0s5dyETCxx9eOL90o0gc4ghGOM0E98/Ivi/Hu5x3cVhgAWyw8CtuM9I3?=
 =?us-ascii?Q?JgXPkeZcPN5+YuChn1OsGfEpEVKRGGWHF7oM2FYMBgr95/V1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b371e49a-2450-4070-8f9c-08df338c7798
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 18:10:50.6361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Gat0S3lz8vWWFFQKCP3QvmXerfnvfQjPcUrgtjTa6wXvvrhln1BtvilXPVS1Ic2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8126

On 26 Oct 2026, at 5:40, David Hildenbrand (Arm) wrote:

> From: Chris Mason <mason@kernel.org>
>
> Any local user can bypass memory.max with mbind() on a tmpfs file, and
> allocate unbounded kernel memory.
>
> mbind() sets a NUMA memory policy for a range of a mapping. If the
> mapping is of a shmem and friends, the kernel also stores the policy on
> the inode, in a tree with one entry per range of the file.
>
> Each mbind() on a single page of a mapping can add one shared policy node
> (struct sp_node) and one struct mempolicy to that tree. They outlive the
> mapping and stay around until the inode is destroyed. The tree is not
> bounded by the file size, so the file can be empty.
>
> Memory that user space can allocate must be charged to a memory cgroup. A
> slab cache does that for all of its objects if it is created with
> SLAB_ACCOUNT. numa_policy_init() creates the slab caches for both
> structs without SLAB_ACCOUNT, so they are not charged to any cgroup.
>
> Reproduced with mbind() on single pages of an empty tmpfs file, from a
> cgroup with memory.max=8M: the global OOM killer killed tasks owned by
> root, and the machine panicked.
>
> Fix this by creating both caches with SLAB_ACCOUNT. This change implies
> that mbind() can now fail when running into memcg limits. Further,
> the policy_cache also serves task and VMA policies, so they are
> similarly accounted now.
>
> Note that per-file limits are not really helpful, as the user could
> simply use many files; having limits per user is tricky as well.
>
> Fix generated by an LLM and submitted by Chris Mason in private.
>
> Fixes: 5d097056c9a0 ("kmemcg: account certain kmem allocations to memcg")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: smaller description tweaks ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/mempolicy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi
