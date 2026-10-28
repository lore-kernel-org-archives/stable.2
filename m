Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.6
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793181758;
	b=oqJ0Vx5e0wqfmBTlbLNKUE4+9uadqAUtzSUknzwQEPZQMWSrRrRAAAxGTQCq0xdcmVDd
	 ciWx18sjV9HYNFB8w+bAJJEz2Sxhd2ALHEaE+l2h5VQM8gkFqSMjlCXrdAatPuK2IK+UD
	 KxpG5q9z/jlH08AztbSg3CIMdZrlkgYL7WEPx98DqZoySt7Db+vSyjrRfxvtczUQDrERA
	 kc/GvLULHKfU3wh2CeTnLvcpNjUleBoG5q6iF5DghX1I1AH5JFsUL12FWTaoD/oB+gYCJ
	 HUdThTqT8vY6FpNbCPyNsaQw/h2Nj+Ortm/SL/4ts8g0LLSuCHfAga1F1AajNUBS5Zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181758;
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
	bh=Xwu5xDcFrvHWZBCT8bp+GJfHpCrH28IBTd+F5xEqNSA=;
	b=erFf30sYbPwHspbIaQOh+6SG85eJ9cYOJXHI0lT8ll5yZx+ji7dM08gHEZVReL0TpQvr
	 tU2ALTFCKtkFcUOYjlFRIfa3L/P7mr4VEJvrPSQ+0RxUlEH0a5rdZ4fOD+1b5kK3U+ZzL
	 9JigFPFP1V4+giOg1Vx9RBGwk/Vqx3vhfiMsZsFen2C1FNu8q31COLaRGNJs6YzWinY5P
	 VD4cxVLgUotUgc7CsJs29zPEOm/TPiX6NMjCzM6BIKFFv8KfQ+0uLGD6GEwJ3i6FwAbni
	 16Kqn0q9+9adEfVl+OLanxLpFz24vJSG9stRTr3z26/gEbT0MGC42QqwBzV7cCbFZPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=F4Sh6Qkg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.6
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011006.outbound.protection.outlook.com [52.101.57.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CB5606A31A;
	Wed, 28 Oct 2026 10:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08CB5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=F4Sh6Qkg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phXOmGvXVZPswMGN+bnMPZYKV4Dm3mDTqgwTcye4VRIs6qu+NpmxoIc5FnevToCNAGHU2Ag7ZAFyrQq98LhQL60FkwhOyu7RrqCHKgjPh3a3DVmUqGiCot4nsFa/YtCyVkKcJlLI0TQ27Xjh6YXpDb8oGABFAIjbJ2wg7YFLsf4qAC/q74TGDXA3SrOf/rgdygYSQgfgV/jvJPyiy65pSv8RihbWlSO/4oQJ7pMckRPaq8YMIgxvBi9ueaniLXA8mNQFxhEJ1zPkfAadzTq9HTAHJm6HMQxamBvUYwvBnKeeWWUr99h04CvPxpTBQx5ZDfhFeechy/HCdXyQznwAjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xwu5xDcFrvHWZBCT8bp+GJfHpCrH28IBTd+F5xEqNSA=;
 b=GmvPKfaGoN5FVw7aOjjjWJKTioMst6vVpGoSYOHcyjnoa7+oDd+aiNeUvtghQogCLOCsn9qyRS1gSYmf75rtKBqGqgjPT6o7aaAqLe1QA1EmgXqoLjpqWFTwdFUAFIolPYlrC+IF1z3J+kz+a8ec0jkQF/tc8Ih0tufB6Uej1uLKZpOh/gnZc1UQjZNH4NmVbR8qEzjavHZ9sJLUP3XHSB8ieyrzFtyZAryImePcIF/Y6RgubeXavGe+7qW32opPhiXnUYikr/4JczUREPihrZLBMCwNuM+oPcVKaKokKcxAvkDp1U5uKBaiBAdvaGL3l/i0cOK+IoF44YrglE1YZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xwu5xDcFrvHWZBCT8bp+GJfHpCrH28IBTd+F5xEqNSA=;
 b=F4Sh6Qkgo/Ku2L+0pAyD5kw3KMunUJHy17XW5kFjSgJOfu0LwGXc0aDZkCGqWUJ1eVYbnKg/MhRJjK9Hz57Q5P/PuFtu+kF2etJ7pxJhupoZJUHjHSk4gP2JVOyyjGXqREiPdu1aHhLBrVmK9nVzrlx9IfKnCwS/A0/jqdHGEuLYuRMkh5fEfpR2nhlbIZ3n3Yh8PGfyQzdOlPeVol76Fc91Js+q8GmJaKwWAHOvVZsKgAhlM8Ee80ikPfW1L4hwkreWVPKyDjP2cJoOVlfEkXCgO9W70Vy6UH1qeeVssZGQHJ+ybrNuU0twn0YVsXsUNu03WfZ7Qnc1fYkvFlspgw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB9730.namprd12.prod.outlook.com (2603:10b6:610:253::9)
 by IA4PR12MB743615.namprd12.prod.outlook.com (2603:10b6:207:150::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 10:02:34 +0000
Received: from CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128]) by CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128%4]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 10:02:34 +0000
Date: Wed, 28 Oct 2026 21:02:29 +1100
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
	stable@vger.kernel.org, Pedro Falcato <pfalcato@suse.de>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>
Subject: Re: [PATCH v3 01/15] mm/mempolicy: charge shared policy nodes
Message-ID: <auHINbCObZYzpNqC@parvat>
References: <20261028-fixes_shmem-v3-0-4ce3baf2db4b@kernel.org>
 <20261028-fixes_shmem-v3-1-4ce3baf2db4b@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028-fixes_shmem-v3-1-4ce3baf2db4b@kernel.org>
X-ClientProxiedBy: ME3P282CA0097.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1c0::18) To CH3PR12MB9730.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CH3PR12MB9730:EE_|IA4PR12MB743615:EE_
X-MS-Office365-Filtering-Correlation-Id: 74555879-bc07-454c-a9ce-08df34da96a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|261026121527099003|11063799006|4143699003|261022105027099003|56012099006|261021135927099003|261022075727099003|261021121427099003|261021123027099003|10067099003|18002099003|22082099003|6133799003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	DO6IQ0fWjEJGjpHqEDRXmX9rtm25TaYXGNQzpsc2KRtDtk7GLp4hgWjOXnE/b+S8iac5zQTn1tMU0w1GMT7Uzo32NTUXR4fJmSvMlMWdywpQROZa60bL1SOk5vekgi6gMNZ4/FI9m6Cbf3yviSSfMVTdPuW7QaZ46ldU33xweTc7L+obB49xpSXkfiE5IfLEaD7NvTmGOhGnx0gs7PcP4/J2EYjl3TimlBuqhqkGPEyFGMqKFyC5OL2OCja3NvtwBERLV2xCix0WAdNMJDydS+cOoHUnDbKtXhIMeG/1chxrAnY7HuJ1hjG8O9/rZu7Zic4wk/8+VrY2Ag90TsG6MQLO1Rs4NyoOQKh7PZL5oAzM5T3fglXUbyr23QnPNzfr/P6g9Zn4EOxA+d6RSJmhNSSH4JrkzXasBFLzwA6PSjRbeLcOHdugp4Mu+Vi3ITk1GZwT30EtT2GatEvTew03wTbmVf9NkzLH5ZGjgGo75nkLBtKF6fVxA5EfY7EwFkbso2oj2hJNWIJYDPHHZVSwx4lwpk6/4h9p5Muh9i3nMHCeWrb2QKvB1xObdArAGpg+P/WkC6dtehaL9knylSa6/jFtB2TPwyFr6bwJAKhcAgRg6mVttMiSa+Rgk+R1oiO7dT/cdzsIB6QX/DSkfLAWoCFnTxEaccA4wPWKDIa6NiE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(261026121527099003)(11063799006)(4143699003)(261022105027099003)(56012099006)(261021135927099003)(261022075727099003)(261021121427099003)(261021123027099003)(10067099003)(18002099003)(22082099003)(6133799003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bJWfcahnGqRlmE4KCIQXOyeLnWAzz5f65bkmG0gcQE+2m2qG7WYiz4oZZpb6?=
 =?us-ascii?Q?7JYmERLlvrzzKFeuiHxVtfZ+ZYM8Bs6nZC0K29h40Jcj/Tv3lfrxcFbjyh3/?=
 =?us-ascii?Q?HXWnTK9/WuqajdWhd3oLNDFzmpHx8X0Dn7p2qpmmYDhujD4NgTkI387cj1k+?=
 =?us-ascii?Q?j6qpbnsTB5PFnFtiWvUY2vYRuIKwNQLiujtGGK8Isc+RYgHbxm2/7mF2J5Jx?=
 =?us-ascii?Q?SJGjCB/mhe9gRerh6yG8x03HtAO0qA4TyaOjVUptd08McEutGWBEaOcJ5n2N?=
 =?us-ascii?Q?eUCaDwANSvszfHZaXopOp1KZKJ1HLmuDysi4byyKNd+bv79dKQaViWiufzmm?=
 =?us-ascii?Q?grblS1iuF/g3mNknW1ChVwFWrXVva3v6iDr22c17OFS+IEl2/WnBNTl1i307?=
 =?us-ascii?Q?sgT68S6kijNQDUjjM9yrFNCULzRrV32ZglTeABHuXDvugtg3RKLLF8hLPoTY?=
 =?us-ascii?Q?CkUUU2UwUCUO1Xbs2s6k8yli7DyeDZj679ImE2+C70e0C6ZEZcaC3RetmiTa?=
 =?us-ascii?Q?b/jK/p9GdfpXfcubihdQ7OcXF4p3yLb9moXFf301XIhNjObXNRz/nH00OthT?=
 =?us-ascii?Q?Fiwj8EZpJbKGbl4MANEKgwGAAWTW06FW6dsg8J4D2kd5bV/j6T5pxOnJv2Qi?=
 =?us-ascii?Q?W0rSCA72FVmG8LqEGE6bhfRjAB2kq2mR8XhOK2FINz4b08Tlhg6oy6gPzj05?=
 =?us-ascii?Q?5XqUoIEeNMSavM5AbQ1ifnsx6fOAZBbWubNUV4qAjM5pX1EIcb+mYncnSDaM?=
 =?us-ascii?Q?JiYijb4S13Vk6386WCUstof0deAsnWaofq7xtKj+hYradiQNaoWv6/asPUSi?=
 =?us-ascii?Q?RtLabcT80OG4Z7z4dM/dOjt6MfeMSwm+YJ2jflryMIVKkTqQA5aakFhGQWsL?=
 =?us-ascii?Q?QVdUGs85JsE1iw4las9L+TWMbRQHp5wd8O89YPZIsJgeFraNbdF+z9qGih0H?=
 =?us-ascii?Q?RirDIKNu8ZYb+S3RI1kR1WX8Sei6TRkfIXVvvqwCQTox9qUqWlBzt5XGuGa4?=
 =?us-ascii?Q?BZ5nl7p8Zd+eM/MS7UOtxJWLABcFmV+6cdTwNr9MwZdHK1YIHsGzqoMQKG0k?=
 =?us-ascii?Q?Wj4n5sFy7yiPkSPt3ktWMN6Yn2nZQ6FeOfCbW1qySNoUe1M74Mfvfz+p4xTS?=
 =?us-ascii?Q?CQ1bsfq40XQYzOppEEDN0Guh8D2GO1gPkrvtTnr+PLXdJSKXTu2X9yh2zaKv?=
 =?us-ascii?Q?Ju7HTdw4wnvO/0HSAiV4W4VsEVm2wjdctesXcRL0g3q6Cjw7jetCCbfcaikL?=
 =?us-ascii?Q?KGT1rEvn6qTYsVvL/zelczE7fgpVLMQWNEczENUMOCQcXyDtd1tPzL37WXYt?=
 =?us-ascii?Q?K5NhAKm2NCVUxVHEjQ26VynqNpT8c1Z6pzVQNyHcvvCKrd6YUgbYrswaiDqu?=
 =?us-ascii?Q?NCmzsJ8Y7FfSzekOoS3kiWhyWF2y6AY+Fupe0ggfgpk/PBKIKvY0vuDVG2Ew?=
 =?us-ascii?Q?2X0ZcpjuHauwPXJua1Lzj3EvizuY0wIpEz1y9KYcBY1273Om2gSkTftoqu9p?=
 =?us-ascii?Q?/qU0fKS+mm0whXGPNcGQ/io1wY9asQuQAEuuwnq5EyDYbMzmTb0ztI3CEKUp?=
 =?us-ascii?Q?Zp+M/2wDcjBVa9O76SCmrwdDiyWJ0H7ey85WukLLUzX4+6LmysFwg3ZcfetG?=
 =?us-ascii?Q?b/Tq6+HzlAdD5WBWPm1PECLWlH/w3JfzkBWtXXBy/iJObZo1aLp4FQdtu2rI?=
 =?us-ascii?Q?Czy7sJGzZUsogRc5AxiiUTTHPAk4XDskK+/uPriCmnypP/4VTj26SW5eYmuF?=
 =?us-ascii?Q?ZBC1bxFWYw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74555879-bc07-454c-a9ce-08df34da96a1
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 10:02:34.5532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QR1E1FjOmTwszosi9P4cxttvpmLzTblJY33Y0RoLBQ2SxjtdY9npQr3wZnBRCKUWu5Nm8FgYPGK0ZLV8PxtrEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB743615

On Wed, Oct 28, 2026 at 10:54:59AM +0100, David Hildenbrand (Arm) wrote:
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
> Acked-by: Pedro Falcato <pfalcato@suse.de>
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Acked-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> [ david: smaller description tweaks ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  mm/mempolicy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 0884c629670d..4da1cb8777f6 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -3372,11 +3372,11 @@ void __init numa_policy_init(void)
>  
>  	policy_cache = kmem_cache_create("numa_policy",
>  					 sizeof(struct mempolicy),
> -					 0, SLAB_PANIC, NULL);
> +					 0, SLAB_PANIC | SLAB_ACCOUNT, NULL);
>  
>  	sn_cache = kmem_cache_create("shared_policy_node",
>  				     sizeof(struct sp_node),
> -				     0, SLAB_PANIC, NULL);
> +				     0, SLAB_PANIC | SLAB_ACCOUNT, NULL);
>  
>  	for_each_node(nid) {
>  		preferred_node_policy[nid] = (struct mempolicy) {
>

You have many of them already, but anyway

Reviewed-by: Balbir Singh <balbirs@nvidia.com>
