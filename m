Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011026.outbound.protection.outlook.com [52.101.57.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BECE3D6CC9;
	Wed,  9 Sep 2026 07:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788937822; cv=fail; b=mHGX/dPfjtnVL/LAtsbLdF+WwdzXp23eGmkvr7UgNFpjpwlLtAkAJcyVNL4s2BWbZ3HxpEZ8uc9APxTaK9Aegy8oM5hGF8wAbnC1HU4cRr/dhzwKGasnIvReMgK981IZFMbgIQ1r17Y7m3WuMqLkumeh6Bx+F+46Wxgie7Am/Hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788937822; c=relaxed/simple;
	bh=3SAep+BQiPG/7v/PBzqlJ1oSLxKHaOF4VbMz9Bc77lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k+GI5J0+M76KzNrdJiP6okrN5ViOmbG5dZaMmpJYJnfXI25IQP5q6SP+99IVqXM4TRUHVOqgfy2GVDQ6YNqvs0YATWni9fWXMiS0ciDUbXHqy/TV0l2ZwgMOuclXOFXjWRcXyXoJbs1EIxJePUzVLgxvmvTnlNDvbahmqcckenM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lW8XgFhB; arc=fail smtp.client-ip=52.101.57.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lW8XgFhB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSCurUuNjmHZluWqMAMhmaD3LOpuOce+eibTcm9iHT+gJfJpT0WlN+2vhOqRPjK+M48hMTbfzHG82cnCqbKt+qZ2JDBGDbJGDizkztxuSLrRB1m6KEf11GuOCJFeEHsQc8eUMsBODG3Ri01jxT5jSVm1aQLkdevMgyVgISo6iZBV3o/QvwQo5AxCUYUfBZCimkugD6e2Ht1Efx9jSzs2ASP+hKTTTBUjFc+UsYaoDzjX/2U/D6UzYvJAa2oXyu49+UOuNVLL8lQBofwUGwtAO9tS9QPnum1WD8pUFIvX3lSUIAjPnHVf33v7rhirhMgeIcnNsLtQTuWPg2xJ0SsVWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qaS0GNvg2wAe4fG6Wbhhe2NQPUi+KcWa/+6pK5LjaiQ=;
 b=ZgmR1qB7//beBbyl6tEdVfRnX3pZJZbu8u5E5S4DaPqPP3jvFNECtGZ0GexsTPY7grsaHbwNDqgGiB0+5eOz19oD3XRRVnXh4AcltCnZQkPz+UZ+IXDPfmPNYfMEWCUAZ/yfORoM0D5ooN0vJSYTiA1JR8dXAcdtQFB8uSf+ZyIZOCOzrASN6n2tdqfYMRUgTXQmnMQlmJ7P7fzhL3A02/zXu6Va6RCPfaFyvwkqZrWPn6lfLnlC8A5STzQIAJSqAzNs9kXRk7KVuQhDpetGr+66uEJ8/nDo3tcb+zH6TOI9H/hDEaVQuMGjAMwPb/9CKSoedDhI4tP3x3CDfnQLIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qaS0GNvg2wAe4fG6Wbhhe2NQPUi+KcWa/+6pK5LjaiQ=;
 b=lW8XgFhBDhQtHz1hMblS/eOY1KlfSPg03GeY+ydzn4CHw/cVRRCh1/FVLiSJ+zD1xdtCFwI/OzEQGrKvGVQpIio5SVGKnCrk9MveFFcPemqKtxaDH7/Cw9oQ2So/PfDsw67vGEO7UdceR8yXkbnO7kXPf3/lgQOka7dj8sAAZQQKlH7IoltXQBBJf0N6Zn0S+TYvnXKoOuGlng75ajxRCH27U7XXyJMSf1yT0Nx4McGSgmAPFPazYCNKEgY2MrAQYJefzxl9IOXfByuSyThskYz8RGIjPGGb+vTfIMs+b7nKqE69dfSEZfnhbezJN93YIQ5hgc7D68tpmvubKrS/IQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by SA1PR12MB9492.namprd12.prod.outlook.com (2603:10b6:806:459::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 9 Sep 2026
 07:10:16 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 07:10:10 +0000
Date: Wed, 9 Sep 2026 10:10:00 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Patrick McHardy <kaber@trash.net>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Vega <vega@nebusec.ai>
Subject: Re: [PATCH net v4 1/1] ipmr: account multicast table and route memory
Message-ID: <20260909071000.GA1211770@shredder>
References: <cover.1788784801.git.zihanx@nebusec.ai>
 <050b58f7fc6b45da0fb12768ebb62d18fa46133d.1788784801.git.zihanx@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <050b58f7fc6b45da0fb12768ebb62d18fa46133d.1788784801.git.zihanx@nebusec.ai>
X-ClientProxiedBy: FR3P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::19) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|SA1PR12MB9492:EE_
X-MS-Office365-Filtering-Correlation-Id: 705d5fc1-14cb-49b6-3fa6-08df0e41627a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CEYclvUczDmW/XSox134jzJq6PJoQMMzdYlvolevxSuGq6mmqqXyYB7wXcAb/ScxqUB91jaZKdJgSZow45yEluMvgSPzt2wP48fS8IDZ2NKNfrK8jjuuxJRU+stavH/kA1aYNGC1MgIX2lGXl/g03JhVNZevWHQDKBigBruDn5Mcysr93cU8GDDIjBBCeFEG0goVEy3pOothBeqiczZ+xOE3t6jOwo4bBxE2fU3ehrQxF8s3IFwjII18CLQU5GT0Xz3DlyecsKjdv85x+abtn+AvIZ6XgyWcX7uxyiNA8HIV3l4YDEB4g5nGzfJGvstdmud4wK4P2MHN/dT9I+GA7SuHn3zHxm2R5awzuQoabe9lDsYTd1XohzIXvlxm8GfqJiPWRkBv5D5BhGw7CXJDBoS2hsr091QkPbkBJKp1H069jIw/3ly5vTHGNd8tc5rlUygL3w69zfbrfXPjXk++LaeR3jwO7m1kYku+nhXhm+4dhyuDlRU62lr6nuIoiYTYJIbevf3243ySmNWzNdV1c21RDQ0BoFWfljjSFdO0fNPE1iVpgZH4fL6xxABidEVoHjquZ98s0uM0ksIb3K2VZQpKeE4vlxpqjpHC1WgLSzpoFGBtuLiXUweelNTgYYfmLfhwD4d3QIHsa2+C3jYQal026H+8lmzNd+9+BkYayrc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f3ejJX+UtgGI4kTTtg7ATwhgG7zh12CAplr0c/EGvDZTJtY9XmCJT3lX/UtM?=
 =?us-ascii?Q?dF53R/CjQLxGLFuvPo323bZxt5RexeAH7Ke6gTvmfNfFpP2beIz9X71fGDV0?=
 =?us-ascii?Q?vT3BIWbUF5+dRO8at0CFfaCrrfwQ6iAAxPTBsHyNnzkCPeC0yC3d4zCgBh+s?=
 =?us-ascii?Q?mjUBTDVWyhAKnOXlgl3jThpUv99QP/UE8UcW+By52AwOz23o9e2VxYXErHZ3?=
 =?us-ascii?Q?/wbQ+sPsBJ9t9oOyOmPGgR5xW0n0Em43bHrA+98ldcsTxAJmu9GJ3jTkg1mx?=
 =?us-ascii?Q?ZB3PpHAxrBajkvfwvrRvArEZVu9drwZRF9P8zgR9aDLeOJ5U3SXjFy7SuAR0?=
 =?us-ascii?Q?BEsJF8IjcMaozQE1n/Z4rsklVr87g39ZJkML6GUaXNphEf1Cx9Y0UK4hGtz8?=
 =?us-ascii?Q?4J0FVLp08rvQeIhN+GGQdpdRVXoX0MAhEHlsyEiCwSLCxaHbvczoV10+xpFO?=
 =?us-ascii?Q?/L/rcPXLTictNVuVKiUu++uUJoV0uZIV7ykHFObYl3aJxzPEze0OjcUmxwOa?=
 =?us-ascii?Q?vVXiRfXCHVpDa38rV/XRdbhZOXBSOR7VAY//2USm2/01mpFpVjTkvgR4K7Kp?=
 =?us-ascii?Q?ervFbgfp43kKKwqGg+kLYc2AyFU3W2V0hPolrBaknTN+Nl+R8FN8pC0PSKkL?=
 =?us-ascii?Q?AgL70afl9HrTXjm/2kjTrSOAfZFC6oZFwE7EgSSRt9eZrWO/ZSIwJTZw19hR?=
 =?us-ascii?Q?QWrqoXBaIyWLc4WcGVQPADKiS7FbgPCuUclO1gVV6S7UcXXm7eVNviBokdbO?=
 =?us-ascii?Q?2gAYUQixdXaFIwjouqXj7DiSEnqNlRPv+xqhKOv45PJlNWtltK8nXhs6TTnB?=
 =?us-ascii?Q?r3VGrSRz3MW3su9a2nITh8oL8uUnoMV9eZZQh0zcVAfqWUMXWrQ2Sdwxxfof?=
 =?us-ascii?Q?MGgcR1iiIv2ye17rim0hSq5leufW19qkGOR5EooQxihc3lPuAy+S7ys/YydS?=
 =?us-ascii?Q?I0pHGn1uLdc7Y6f0GkXAIID2rZHHESttUs+o+m1svKjxVAldZFeeUu5TpZfA?=
 =?us-ascii?Q?Zx3b8owpu4F0lSqnjVkGYTV5ik+EPj2SAtVYGLtztNRBFlz0DniXdUNXEYLP?=
 =?us-ascii?Q?4afbqPkC00GyWBKGclSV/mV/2lQ49lqzkC2ykm0P7UjUG55vBfyEYJerf//8?=
 =?us-ascii?Q?wQsv9HgcuIb3QAKugj6d4cd/MAjduVDt0zDZE2my6yt9We53AOrqNeMKLUag?=
 =?us-ascii?Q?9cr5ibpnyHFAZJcxrwP0CqJ5Ba0ylwhlg5gbm+//qGTThQkVqdxM3Y2gmyyM?=
 =?us-ascii?Q?k7PDWqp+K1HlQlhWuNkg4+NCZ7qv2lwo1cRip4/Vm9Vbh9LcH/fDaT+t+ECo?=
 =?us-ascii?Q?GGw6aj0cOi4mVnJ+QCn1lI4n60gbqgX7lwX63QloNIOR9jK4XvwuKzUFgkVI?=
 =?us-ascii?Q?o8hcVUXgaxPrd44vX4Q9smyI1RAqLui3PrGHeVcVzunM+bn33j2NjF0LhQ0C?=
 =?us-ascii?Q?lcRK0A3YXgzd6gMWWtSwaDCh+E0C0VGwU6RylYM6QDf9YP0/ZeUmJkdQF+hc?=
 =?us-ascii?Q?0P0CFurSIMVic6U9VkHCQTQwG04cXK2LHgQEHw7m2l5jrP0UuaIK+LpEEmLq?=
 =?us-ascii?Q?yo3PRHtGtrirUcEZVDN2nXg7g/VCrFjF5leoi/MxzGrjOaZY202X6fezGlrD?=
 =?us-ascii?Q?MqdKm2E/UyoZsXf0HSMPqpckBk+6Y3xyJ3+2IHo0Yss2m58Hr+Z2eKbobSvx?=
 =?us-ascii?Q?gMgjr7UxbeeNO4HsL+90+8wKwK/Kw09fZd6sBH9OO1hYKMoZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 705d5fc1-14cb-49b6-3fa6-08df0e41627a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 07:10:10.0267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMMisWhGL/7cGo2qOLFTzO6ey3PKTlsClv4stnRleiiI1O8qdMt00FIzMa6+A5HUVkZpfSkvAoRZBxhYYiupXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9492

On Tue, Sep 08, 2026 at 11:58:39AM +0000, Zihan Xi wrote:
> A netadmin in a user+net namespace can create many IPv4 and IPv6
> multicast routing tables with MRT_TABLE and MRT6_TABLE. Each unseen
> id allocates an mr_table via the shared mr_table_alloc(), links it
> into the per-net list, and leaves it until netns teardown. Those
> objects were not charged to memcg, so the host unreclaimable slab
> grows with the table count.
> 
> Account mr_table allocations with GFP_KERNEL_ACCOUNT and mark the
> IPv4/IPv6 MFC caches SLAB_ACCOUNT. This matches the established
> handling of IP addresses, routes and alternate interface names.
> 
> Unresolved MFC entries are still allocated from softIRQ with
> GFP_ATOMIC and are not charged. They expire after 10 seconds and are
> bounded by the socket receive queue; see commit 0079ad8e8dc3
> ("ipmr: remove hard code cache_resolve_queue_len limit").

Not worth a v5, just noting in case Sashiko nit picks on it:

Unresolved MFC entries can be allocated from process context and in this
case they are charged correctly.

> 
> Fixes: f0ad0860d01e ("ipv4: ipmr: support multiple tables")
> Fixes: d1db275dd3f6 ("ipv6: ip6mr: support multiple tables")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
