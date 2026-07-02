Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011063.outbound.protection.outlook.com [40.93.194.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CE038D6A8;
	Thu,  2 Jul 2026 07:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782975923; cv=fail; b=MgJTWyfpdy4ca3bDgFpDN06pD/eNQZKHHCFHkNRgIM6sg/b6ePXv4slXgbMuqu3qkrNy5MGEt4iHDIaGvYa47Pk9VncCXTXdy3IgWM67baQJSTmvfxEg6uuqiFagTZuFvp5xAqyPZRxnCQJC1Jw7WaJZeXLq3SNwXabPfO10jbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782975923; c=relaxed/simple;
	bh=joXHzL09fA5AD1iiOaKruc4Jk5pfPCIE1pzilbUod2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cm/TYwuGzwk8PEaOBodFE+i+bCXigN2zT61dnDEclC+tTn88JkHaqOGQ4h8MzZf8VtOr+eB6naJESsQIFtHQ+UackJu3Ob2F0NOzYW27+VdxUkNVse0mtNFltItGXrwjJkILnYvV9Pnr2G0KNrmtXnXje/WGrvCM604sO6fTXgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LqPTL/Va; arc=fail smtp.client-ip=40.93.194.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LqPTL/Va"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7NggHU7ePATmptcFZlmHAsOTJO66r+MGwN9hQFDxk2FeSbNltUWL3gq/O0L5HcF2t2Fb3ImaI75kIDVEWqgD0kBaJEwSGvegcrD8Km1/z3BMQvQolBCAY56sjvaJsU+O6siHmntFsdwGNXWVNh9VPHfNpLbm5lPDQf0CEk0B1BwOzbQRd/q/bF7KSytdcGm2zzFJph7kgyr0cuwYYnfyDsbTenrg186fFrbNg0jYQPv9xgdYMyXoNCf9rK8cfb3hDnCUWQr0wqyfO3yz2TD49ecjiS6OWU4QOHj8PpOYMhA+Qk1tB7uGLxyzxPwvsMWgvoVhOJ+pBjG8QIMzRXdMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ggsi8DbW86xv8oIdasEqUvsK5EuAa7MyN4L3TLfFg0s=;
 b=jfbtNYLTMbJBb7XITuSIQIve4/6gSErVowUrSb/neX8c4gNP6E3ZX2ddvPAsE5ZS5xPeRL4fd4BSdRhP8xi41TkRk0cAPsv6t84zjQoPq9YNUblr30jWBHIZyeWh05Wul6rUfxNDR8NHC/eF8ri8J8PmVjz+pViK0IFfLOyHTRtLLUYAFwf/E6MGzYwEY/fFdeI4CgINYkoj8PxRHu6wLly/mVgDDxuwgFuh0fNuqyWWmvccRR10Ct4zSLj9XYV1PvVPEBrXf1uHybMOBQyNg6RnavBLeWGwMjH26qePqLY4fGjDSeH7dXzgbI+3gFlv7vnCm1DtPR1zNgg4Wun6sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ggsi8DbW86xv8oIdasEqUvsK5EuAa7MyN4L3TLfFg0s=;
 b=LqPTL/Vapq42rxkfDjuNZgt1dgRsrmmu5k7Zc+lqJ/EXzN+2VuLdQKKJtvbH711i08EHJRkc9hHah2mN5TWByBDpnTjDiOv4IQt/vNdpl2xOiWxGfSSq4/BdKON/iGMw34mcr3gE613MppOa6MWvVlGCxWnaVQcTUB2xFIBMZH7UUNfzGjhtfS5nsb0dhFuZAHxe0Rz4VAco3xx8LjG4UrvU+eofwsbHKaThQu+mlnxiOwe2v0N+PUqS8mfgk4i9K2iH2NQWXHPB7rI0bbccPRadzPEFToVO8M7s6bp+3Ctukwq51SIrPDL6fL5K2iflkcoDEsOg3FFereZzsxVdXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB9058.namprd12.prod.outlook.com (2603:10b6:8:c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Thu, 2 Jul
 2026 07:05:15 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 07:05:15 +0000
Date: Thu, 2 Jul 2026 10:05:03 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3] ipv4: igmp: remove multicast group from hash
 table on device destruction
Message-ID: <20260702070503.GA1544468@shredder>
References: <20260701235014.73505-1-yuyanghuang@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701235014.73505-1-yuyanghuang@google.com>
X-ClientProxiedBy: FR0P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::19) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB9058:EE_
X-MS-Office365-Filtering-Correlation-Id: 190d56f7-90b9-48ba-e9f9-08ded80843fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|23010399003|376014|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	M8zXuzv1CBYcLH4jdIrHbZWB7/dC+UoCXHNhPoCruUVQxeGBJwU/3I2FiEMD34gmrQfCJ6SBofkPFchCtV6hO6R9SE3awKPFxuyW+Hb0gTMh2BIgM/IizlVDSMcGjQgbDRoV+iszn9Uj9m3vuj7wKOA3JWiRjeUWcNs/wFPU6j1IjKIG7JtS94HNbhuZpa+d3+cfWDHuxwD4/iZ7ME97gwQOcRtz4Xnz7HSzhW6n4JbQ6f3HpJQrkFh5v31qGkiPXvY+C6zg0D0F5zeDkK5N8wpSP0AEq7m2s0o+oqD4+gxbAJ6zHxD7f7ad6o1aL7Q27hIOLuWlDGBw3GvhTyKBZfspBVs+m3aTgdo9ToKFIZPE+q36bDD48ouyLJfsUzhYTJ5UjyOrtzKuXJtwgju9+bg2q/4U4hrvnGpDLJFSH2rmV1YUN06V07CthZ2Pheb8hnM43Zbq1WNDUfvHyuhM7PUJNT+WP6w8FOgGJiVHERwU50cn7T4SyBwaRGUOECZHa9YCaiw9+/gHeUkAaiLHxm+dKA0R1x9AI6PXkylnFDOAO9kU86MiaDIEAaPR9OMjAqOH3pMx/IgvB3g/b6SLYiWLWxjP+6z+N80Fy3jHf/M6Yr37Vst5QJWDGgJngssCmSeKCIgQDREMjsXQjTZV/ok04ZEZR7ugQDwxyx82Zfw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(23010399003)(376014)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b/flcu/Z+FLnpZu7svGr5V5v9BgaD2z8D46vdF8XP8H97yjQcLbdy58dVHlh?=
 =?us-ascii?Q?SR6xmhLVpOJ8WfjJlYbuigtcyOGbgY9k811SP6K6Y9U3PdG2fU7FWntMgaGd?=
 =?us-ascii?Q?dmX4kPO/ORk7fPJQQWpUqC6w9RM9VCjmfIzy6O/cG79+MC82ZM16LvVOaqWp?=
 =?us-ascii?Q?cvBUROWush7ytttAdS4oO3mJ3ujgGkePv7Swcsgh7ZlhL3+TdqkXho3ogRBe?=
 =?us-ascii?Q?sZBCeXKU/AQUb8CSo2NuFIx4sK3hkr/VKcczL7kk/d40i6jKKiF4lkwDOUUG?=
 =?us-ascii?Q?0YqnbzWfWKCUkQ8DTXIkT1a54lZZ07bw9mGZwfkm093e0PCRnF0VFK9i1JCr?=
 =?us-ascii?Q?smzpVQq6+Ae/821iKLeU70/F1NFh6y4ybmkG3DHyB29nK2B5oDaMMrMjTGFF?=
 =?us-ascii?Q?/9HiEejZ1cFSek8kBuTDm0AKBoU7VqUQtxYFTRLjMBv1Z+xE7+f0xJ4X1ST5?=
 =?us-ascii?Q?KyDIS/uk61tPJ6lqa+Oel//6BUqjm+X27hqBtSy0BIJHb0q8/n3IST9lCEhU?=
 =?us-ascii?Q?DsbAJVOX9SBWZqYdhpd4+ne23/Uh5arEiewAG+3o6/D9ZIi6gAM3vhgeZjZQ?=
 =?us-ascii?Q?z/yuug5uy2gxBmN6prB3J7Iq3w4ufkitk4CkHRV35GY8sIS/2oCYAt/n7doN?=
 =?us-ascii?Q?g2Wk33hVAS+qPYaQ36y3nDd3aKtITItM0UZkbdLmL9z1k0GB243FeSRTEuQG?=
 =?us-ascii?Q?DSV1NYFQFvzbNK5d155Sm++IHKszU9lNPTrjSgsd5/qbzj/CgjMNiVtVwO6W?=
 =?us-ascii?Q?zHGgEmGdUvUhv7qbtFaqlcYapS/6wBCNPA8IwsOgmVJx1aYW5v3PH+Pz1ddb?=
 =?us-ascii?Q?aBlQqCY9yjLxOn/bv5SXjNZ3WxUaxwV9UXd13Jz4cUwWDEr/JaECYSHONMJ2?=
 =?us-ascii?Q?ZRBVPpT5BlXiOE1mamzTqR1Zm9stO76tPBl5ty9ebe+8BOsnPiipDwNRa2iw?=
 =?us-ascii?Q?oMTdfgr6g43NWdPKpqVmLf/Qw3AA7b2BCmhX4FolEqKrDPVaPSh1tQ8ORpQT?=
 =?us-ascii?Q?Rkd16pQm3WAN8r75ttue1pOJqRUTT4oYEopYSoinP3yVzfYmZPCgpSf1uBGa?=
 =?us-ascii?Q?whiLsUtYPb5Qf87J8JPI96AXg2J1p3WlMRZvj3D+iXHV1LNY87mC6iKUzoMd?=
 =?us-ascii?Q?tp8QrtBXArs1gqH7NccdK8gIyeA5iv5FKg+OT0xKndiCNzJd/Hw/tSrlU7wC?=
 =?us-ascii?Q?ns0npEetI1h2Tj3gDqqIRHjvhzkA86+tcHQqmV9m9hg0doyrqamIPf//KsKn?=
 =?us-ascii?Q?/qSCg5yr6K0J+NELRa2XrfsyjGVFozHZ6CQtF69nDCA4pjW7kIXZn7fI+XM3?=
 =?us-ascii?Q?MFbD99trumCGwEML/jX8xqvJt9rWUBCgyctejeMlJqQi3ioENWh82pbEqH4w?=
 =?us-ascii?Q?E62HyYN0uINh3Mb5+6c8Ql+fdh3QrEe5lTfM/XaD2dKHe/y8GdhoKC806Ftt?=
 =?us-ascii?Q?oSJcO0tIJ0N4frdMYM7kTX4x/vTqtzj5V8zzYZ/RJ4ySKwRI6raNPahYMi3S?=
 =?us-ascii?Q?zYlZ91mBIwSqmqDoSwu7YQdeAXJ9FeBGPTXraXNaGeSVm1p9ghIYz81w+/Kx?=
 =?us-ascii?Q?GW+72JbGMa7omxalpy6+GHm6DO6Y4hJOyq5pv4l4PrgmExGZI6vYJLdnKaxm?=
 =?us-ascii?Q?MGdGX6AVePQQH8SMYr7dHD/cHbWkMpPV8/lO0GlntmymbFr1OtSzE2M6r1Hs?=
 =?us-ascii?Q?iroDqki18oi1yIosC8DDXAC97jy+0a+9KMas0rDDjpjQ3dpI6Wexwf4VDoJ6?=
 =?us-ascii?Q?JMradqf02Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 190d56f7-90b9-48ba-e9f9-08ded80843fd
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 07:05:15.0991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFcxT1QyKkV0fg85VnrKZ22iFguEO93l3Xz9xVH60boGAC8JdyJtJEsgur8RGVKPmAkvQImXYdSXGWhEM2gV2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9058

On Thu, Jul 02, 2026 at 08:50:14AM +0900, Yuyang Huang wrote:
> When a device is destroyed under RTNL, ip_mc_destroy_dev() iterates through
> the multicast list and calls ip_ma_put() on each membership, scheduling
> them for RCU reclamation. However, they are not unlinked from the device's
> multicast hash table (mc_hash).
> 
> Since the device remains published in dev->ip_ptr until after
> ip_mc_destroy_dev() completes, concurrent RCU readers traversing mc_hash
> can still locate and access the multicast group after its refcount is
> decremented. If the RCU callback runs and frees the group while a reader is
> accessing it, a use-after-free occurs.
> 
> Fix this by unlinking the multicast group from mc_hash using
> ip_mc_hash_remove() before scheduling it for reclamation.

[...]

> 
> Fixes: e9897071350b ("igmp: hash a hash table to speedup ip_check_mc_rcu()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuyang Huang <yuyanghuang@google.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
