Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793257213;
	b=mjRkm5X6qS1QA4zRNJYSvXbRRStuHo94paOHCEzpV3YJQPEcx4xuydzRbc5YOHJXzHxc
	 81Acmo5WgoDxoKfQmC5mxK0BjUmiZI/bQT3EpLexcJf7T9cLwGYAQ90dR4En4+rOl5WJb
	 jFvgEzDFkKYDBuYFkUjvCw7l+OkizQHksdDWjJ0ql1oOQhcnnu6lvCiz5vHkweLGXCuL4
	 4tieNPrVHvrVLy6CnSYWUdkPIHVze7FgYJZ2pemwXTzpxJp4p4iK8/xlPGCZcPdiuFShH
	 fSSVoOtl2RYnUE3YnatYl1AnpcZAaEMb6j7l/5gRv9FT9TiDXsU/a9C0dYc0BN0PlhQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793257213;
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
	bh=tVhqBPiJdhGZuhd6jFROAK3ZvAO17Z4FadtOewBUeq8=;
	b=CfMv8YYYNLwF3DWmdnNsz/ptej5/Qrn07t2SXv+kXBm/vl1LbsS2VYyyvnsACiB847Tq
	 A6yT92auj6/tQ+z2z9KhoCJ83sC39srqe7MFbCUQgGpL2IKixs+0/AgbVxN9+KaimbWrZ
	 bu1+/M9VI/eZQJcssZ4iNPtQ28DhMTK4A06up3h/Z+1Wsuc+QZ6d2Vnw19HYybycPmvse
	 SlP7HyAtCw8idM9CQvyOdddJTwCN00dxiPG5ner1K+iJjh23+Q6ZCyP6Pqww/SRetVs3M
	 Vpz9C75tDiKiEkIVKo3LRagqKFiLwP4ysDtfd9J9e+DWT55g8k4ek31Ln6avxnHn7+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gYYlVPX2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.200.2
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012002.outbound.protection.outlook.com [40.107.200.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBED606A31C;
	Thu, 29 Oct 2026 07:00:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EBED606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gYYlVPX2
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnC9oJxUD9SfEppyJSTm1X+soZH5P+Daw9AjfK2L8G0jAThgh5rlTyO8Xo5boXirD3n3zzQ6onzcGZoTAPd8UbhQzRAo1hrK3cInT4xNy9Lb40j1bJs1OY+qJckdDDL3pFoo/K7H4juT/3YoCPZ3cvSVUlEONYDNI6TWen2yvryPTxtgje2KeYWQA8hbTgC2vI7a8WTJtjiITkgDSgS/PtTHOw1Rt9r/jNYyc8mxWSrJfET/M/LvwvSqAAoEFJML11Dtn8U/dX0ObVZNYsjsdZMqIRSHZfJqvmseB+wywngNLbpLLFvNfHW6+18VyfEaM7S8XQAXfL3KZxhrWE2o2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVhqBPiJdhGZuhd6jFROAK3ZvAO17Z4FadtOewBUeq8=;
 b=A4VVpKIQ/MV7MCzotV9AcumXG5dxTbUD4zdqbaY3RCRWIHrvT97ZsMeQF4RXYlpJjEBEEZyC93T92DUKtF6AiYob1UcLlZcRGjUtysXrxE9vO3D7SrbCiO932BzlpMwsX6um5eB4anWkD5/5L4f6FzSO8lQdkG6TkgoUH60U9Ij+q3TdvmknAPqLEH3EM6hoJnb0MOKSWTE8/XOahpP2hM8QJ5+ZRCdQCNWeWFYmZbVMIYbTNzb1MAMzYiyMVVxLHIX2bzP/FZnEq/3nU0Dl3166Xqk0Sr01rUZeol4K8+TLc/q41OIkuctEAig1rC4it0AUYbr8OlqVfbXNC9jgLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVhqBPiJdhGZuhd6jFROAK3ZvAO17Z4FadtOewBUeq8=;
 b=gYYlVPX2YOpSlLGOYORJkLRveGbHlwsaLWy+QsoGBjPTC2vFeD4iM/McqYSR7OuDLpU9ZPXZa4thwD0qXSEV6l79OY/MhjQV5Df6mREbuzFxtg7sCa888L7w+i+v9YBnDEcOQVTvmHMcIXN5lkcp6DpEKtnChqs3PgIN8Rp09oBwELPoWFmiWjiw7qg0ho/2yE1Ei4jHpgwR+SR/A4mKIZdjKKlnHT/R94UIHX/RGXFPZ2CpQR39ab/ACa1ZjSKJbS2M1QzynHE5NcbTz5jbk2vB/poAlhq3TodVh2rMgxwZY4DQ9xnc9lvcNCxrggOnEwv4jbe+8HLuFGgRKdq36A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB9730.namprd12.prod.outlook.com (2603:10b6:610:253::9)
 by MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Thu, 29 Oct
 2026 06:59:59 +0000
Received: from CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128]) by CH3PR12MB9730.namprd12.prod.outlook.com
 ([fe80::843d:c1f0:b2ed:4128%4]) with mapi id 15.21.0569.007; Thu, 29 Oct 2026
 06:59:58 +0000
Date: Thu, 29 Oct 2026 17:59:53 +1100
From: Balbir Singh <balbirs@nvidia.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Salvatore Dipietro <dipiets@amazon.it>,
	Christoph Hellwig <hch@lst.de>, Dave Chinner <dgc@kernel.org>,
	Matt Fleming <matt@readmodwrite.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Michal Hocko <mhocko@suse.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: page_alloc: do not give all non-blocking
 requests reserve access
Message-ID: <auLu6XEMZabza7aL@parvat>
References: <20261028171719.2043421-1-hannes@cmpxchg.org>
 <20261028171719.2043421-2-hannes@cmpxchg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028171719.2043421-2-hannes@cmpxchg.org>
X-ClientProxiedBy: ME0PR01CA0021.ausprd01.prod.outlook.com
 (2603:10c6:220:212::16) To CH3PR12MB9730.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CH3PR12MB9730:EE_|MW4PR12MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: bffc8209-4e4c-4a3f-8df1-08df358a3ef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|11063799006|4143699003|56012099006|261009223027099003|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261021123027099003|261021121427099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	8yB81I9H+mheCx+n026tQAKVzH1awtznP+w3P4xoFtUYUWwpT0wKNGB66n5B/6YbXP3opG7ZH+FtAr9zW0w9t0twxBHoo/hezd7G2M2hcpCHBO/IfUaNssxyFu8eAiHlF1+f9fdKa+5oXXHGWg5WTRgY327s+Ui+Rctf6wi5D5meHJz0Woz7Bpw9PxTpcx/JA9EmPUv/dFfbhPgOLbdW9A02ETPu89+6dwSSfnly0mNrec1stk8rs+u3qCcVymu4jcgQooGFba3NyiesWbxweAyzl/TN8yggx7+R6tvhaIikfcMONpCA/NsL4zvrxc5wjMIkGlgrS/CeaqRYtpPzfLMsVsQZ2WqyNFQsGBg9HZXFAwqrLj8DBc7aTLobqOfwbnUc9O08+I8Fqb9Kf2crUJkjICFJNW2xvGcU8G6XbOskFFUNsqlIJaEdm5kzEs/clyERLRfvouY6gx1XgGzbxaYK27fH5/sqmpyO7bigZIbX1MbmCCKY0YfulNFYXyh4c5cexR0EU8srpXHzHYQFbM7YqesgHCkpXRKNFzpM7mw6KPl0xQrbhTN1bnZxnFnMuZw6cdsKtJ5dDHUL8xn+FOScfuVESNulN8D0//qsY3MHEb4XNPVyk5ueKg6V8y2RNnecPfHVsmFYQtajguo/VgvVj49CjZ/jeQDK9tjhYyU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9730.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(11063799006)(4143699003)(56012099006)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021123027099003)(261021121427099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rvmIIs8CuH+795ySnHIXkMF8XZ/KuDc4sV5FwmvlSwGmrdoxIvialUGeZ+rV?=
 =?us-ascii?Q?ttmHXzNANm7YXgX2PCLUj3lDfIUiB8kCugaD2UZUjmEjH26398/UeWSUP2//?=
 =?us-ascii?Q?zOygx0/K/aFhbMs2U6aQy9wL5571YJp2OIwIbvpTQ+XxVyOZFiVHRzgqKwe7?=
 =?us-ascii?Q?NpPtpQTCsRerWTgR8KJPrsJoG7QfRi/6IixzY7Q4iPbTNFXW8vf57E3+FZ0Q?=
 =?us-ascii?Q?7dg0lta8XAKQAPpksqNST0Kmyq23W7daZaZpUg7vo4NQXuwqS2Y3iqEL6l58?=
 =?us-ascii?Q?7uvwlPQHkxYFyoBmB6chwOGMgC3rS4V3sNjDEPvw2tTvor5Tk4XgB0g3PtSo?=
 =?us-ascii?Q?WwNupxVD1+XnrAFMOSUXgnC4z+7M8uZu2lIM2Op1E0O4PoBR9MG2PjnZyJeT?=
 =?us-ascii?Q?1M4FPRwhjmIf/XfgRowgIWJX7NrdDhL5Jgi1Eu29XPAi0BaAeMerx6e2yWhm?=
 =?us-ascii?Q?DFLBowwvE4AhJjfE1gKhgItRqvm06KFnYDb6fqDf/9ckEgFajP8v2zaeJqFZ?=
 =?us-ascii?Q?rAEnJNaz7R9+DgjzkindTEcKj5mC9CXbWD6tcKHv7257e3XcwD3orm1IPUoS?=
 =?us-ascii?Q?TCkq+ko5MMOVtEuIh4c86xaADqut04txNQ0EGxOrZz+0E6103FyTm8/eGFkD?=
 =?us-ascii?Q?USQC97VyGrHyOaLQTMGHI4WheZaYlbp7LzH0R/NTd7Tjmofovq3JL0/AE1UN?=
 =?us-ascii?Q?gW0r7ckawm+UsFBkM9TNBll/OPl0vaNXKM6kvRnFnhcGyQnmpRohRCkvPZ0q?=
 =?us-ascii?Q?IeGfLBADzPow1Ps3jqml+r2cZ7PZ/ESYeMLg1qwCffGMzib41vVd67AovMVK?=
 =?us-ascii?Q?E8TVMu5KBCLF94OGLBW0HlDQarwAtHNeghyqOuNDd/IxzDChrnKejrXvVIDu?=
 =?us-ascii?Q?U/02gS3O9ZtZEHHxWkRxNxwOq4Xe0J4mMB6uu9OUe3fnouicdNCFNhEpe9Xd?=
 =?us-ascii?Q?6U7mG5Aqvfhw4qgK7qHfyPuac6cEa/tLLJA5gxdAl6F2AiCPJ2v4Kt6bdbuw?=
 =?us-ascii?Q?KC7/ZacKny6QpINnsOrNmK58OZQehD5eYmMc6L7o9r0azajSgmyLiNfqobM1?=
 =?us-ascii?Q?jhLoeqgLCMp1TcWuHcOdJDyJKS2AAKTtlSEZP7sTSVYHIOiUj1/Gxg/3oYK/?=
 =?us-ascii?Q?g6TMsveyAW9nOcxtCCcsG4MOanaYSA9hlsdxMjZ9iSL0bfCkAyUGlmEzbHoi?=
 =?us-ascii?Q?s1x+Q5p2s0R4n79tPTMhTvl/3T2oR+BPpl/q2bG5p1Q3WBO5IK15qLOdLaNS?=
 =?us-ascii?Q?Z8lJsLv3SpLnqS1pTQ3t3dP11sPyDuBFyRBcLT7VKKTrh4ErbpAYpOz50Sl1?=
 =?us-ascii?Q?vB7J2OUJItGDrYgfZh1Qh6U0Y62NFc3wW1FHKmNQwsFvQcMe1W8bhU5L2+Vh?=
 =?us-ascii?Q?kXSZWnX5S1pMDF1Ye17RShAAqp7hQeHu6qQpUYUOaDsqeOTtWLcUOpwzx2Rj?=
 =?us-ascii?Q?mQavd7KcvaoVEDbh7oGdYoyoRXzSWqhRACGRNaqZHKl+GMUD6ETw71e9WlH4?=
 =?us-ascii?Q?pA69dlYmeH4aIWxW1SfyX0WuPhVSKPoNq3MhgUl4EDQZtpmAvFpJtaUZ7p/o?=
 =?us-ascii?Q?z+4ZDN+ImoNVQuu8QlwxyGJwarvLx0ZqOrshwmYzgl+2F9ieFi1gjlLztMb5?=
 =?us-ascii?Q?/VP6luHIRoUbNl9fAjfQzIz4jtbakZFy2qpsaz4iUaH5vowhoBaHEfKSD4d6?=
 =?us-ascii?Q?ATV8wLpekCLUjPcKEzh4c/xF+8jYmH/rr9m4tKohHloMHY2j03B0APilfxAj?=
 =?us-ascii?Q?mYBjXqYFRg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bffc8209-4e4c-4a3f-8df1-08df358a3ef0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9730.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 06:59:58.8546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ae4uBaVwlUOctfcsLlBOm9N+XKHhAsRMyX4+BokKF+z+NoM9FgbExZ3qqglrzsNpuPwPWzKso94+LFdyIjoOaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7309

On Wed, Oct 28, 2026 at 01:15:53PM -0400, Johannes Weiner wrote:
> 281dd25c1a01 ("mm/page_alloc: let GFP_ATOMIC order-0 allocs access
> highatomic reserves") accidentally gave all non-blocking allocation
> requests access to highatomic reserves, which includes GFP_NOWAIT and
> other sites clearing __GFP_DIRECT_RECLAIM.
> 
> While this improved atomic request success rate, it's unintentionally
> broad and can actually worsen highatomic requests by squandering the
> reserves on requests that don't need it.
> 
> There are concurrent efforts to clear __GFP_DIRECT_RECLAIM altogether
> for costly order __GFP_NORETRY requests, which would then also fall
> into this exemption and deplete reserves even faster.
> 
> What GFP_ATOMIC has over the others is __GFP_HIGH, which
> alloc_flags_slowpath() translates to ALLOC_MIN_RESERVE.
> 
> Narrow the exemption to contexts that have both ALLOC_NON_BLOCK |
> ALLOC_MIN_RESERVE.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://sashiko.dev/#/patchset/20260904115629.3993331-1-dipiets@amazon.it
> Fixes: 281dd25c1a01 ("mm/page_alloc: let GFP_ATOMIC order-0 allocs access highatomic reserves")
> Cc: stable@vger.kernel.org
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/page_alloc.c | 4 +++-
>  mm/page_alloc.h | 3 +++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index a8cac5e01066..8ac2e2bf14fc 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3238,7 +3238,9 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
>  			 * reserves as failing now is worse than failing a
>  			 * high-order atomic allocation in the future.
>  			 */
> -			if (!page && (alloc_flags & (ALLOC_OOM|ALLOC_NON_BLOCK)))
> +			if (!page &&
> +			    ((alloc_flags & ALLOC_OOM) ||
> +			     (alloc_flags & ALLOC_MASK_ATOMIC) == ALLOC_MASK_ATOMIC))
>  				page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
>  
>  			if (!page) {
> diff --git a/mm/page_alloc.h b/mm/page_alloc.h
> index e238ee91ed24..9c3c2830acb0 100644
> --- a/mm/page_alloc.h
> +++ b/mm/page_alloc.h
> @@ -60,6 +60,9 @@
>  /* Flags that allow allocations below the min watermark. */
>  #define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
>  
> +/* Flags that mean GFP_ATOMIC */
> +#define ALLOC_MASK_ATOMIC (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE)
> +
>  /*
>   * Structure for holding the mostly immutable allocation parameters passed
>   * between functions involved in allocations, including the alloc_pages*

I feel patch 2 needs to come first, so that
__zone_watermark_unusable_free() accounts correctly.

Acked-by: Balbir Singh <balbirs@nvidia.com>
