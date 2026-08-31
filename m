Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011000.outbound.protection.outlook.com [52.101.57.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57C41E1A3D;
	Mon, 31 Aug 2026 06:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788158727; cv=fail; b=EnJmWIrsbuiUMENAmRfipPmIsrot0hJskWmgAy/l08u3NaJIxNWWddvVe6VHt7+cP78parY0caXbe2SDvPviz2knnNdzeK8h64XVOU4fAWjEQ0p29ymej91NXDsMvUKvnkgrCD98trf82SSSYKJNXglzm57jp/JwupN23Y7b4eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788158727; c=relaxed/simple;
	bh=Mj3NIqpO7T9KlNOYbT7dLgyuLd6RZ2EXNzxu3kHGo4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oUIaJlHmCIH7IYPIgSFHGejucx+gTzL1xaXE7vY6RSseczgLaHlQnTzstTaCHZOFFghHjzj+2PulJqFB5uXsyhnxfWQLQIkiuNHDzL3UWNfZx0hi5aEaRjk1lokZ2E7L31DP0GA7Y7MeGH4jHgmcbK+wuKqu4+z6RQObyONlNsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B6LmR+gY; arc=fail smtp.client-ip=52.101.57.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B6LmR+gY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfiIXaixyPaD6AyPce27fKpDHR6g/5ERANtxja1ci23FYoYE1w3xnV2OfOZOf2rY8NwkTrs06EaJqQzX/3aRYPZNpqm17w9mW/BWoSrjQQxxKXMl6EV+BxigyQ5FNc7ixTyqGtzrzaE3a06DAElmun3wYnfH1eu5xHDBiyLsG5WFcdbK3TC4sE0bjLzIbJb+im77cpdkbjUxRfvN8bPNwGZPi0SpBViSJdOdXLaikv0wX1I+jSCEahCHXqnaPuc54nOAzNwuqjZ9gkbgpdIMQnCSagPVFguJsSop/sUn5Jq2j+o9jo7MqM5jWlwwRN+cea6oT8HfmEOZ9zznMTVnxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqDz+XjnZViqDAoV/TQWVUIM4XE0vo5igslhhs/hmzg=;
 b=Cc2zBiDRpIOE2KwXg8tV5pjfa6dr+AvhEed6VkaDgLHKGgFixznRuhsivd4Ge+mn83He0x6S9cRqYocQLUS3cyngSvkUHc4K1ve9RXFq1pHreGzaNFZHTFUYFdT38j2rgQylFOGqtarx+evEy0r2i+a/qTWMzVTxG1Rn4dB7vMQPYWo3sXyEfsqH/Pk9i2485nlUXUgDTKMMNPCh9M29/jcUzRE338pIcJ4P4UUaqOrOzuUqJCeLj5zKstqH959utlXOP3DcWLuoLn6x/n5MzIuLga29GEskR0QU5x6Wg2EvYrNcEr5CqbCuggMqzlTmhqEUS//myw/pGnFyU0yadg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqDz+XjnZViqDAoV/TQWVUIM4XE0vo5igslhhs/hmzg=;
 b=B6LmR+gYW429SXMnPEI+0fKQjlXM5403fEwOicybOBCQbAFecqAPLGbzPUED92afS+D/OSyrQiZwtbTjOBTp6wI9lQdgRzErWQWym3cVaBoOSKKe+0HhS+xSA/lQ1uVy1VTaQbI2TVY8QjKZ9yOnX7jDSMzDEoF3a3I+NDSm06Ae1DtyJTkUgFgeH7bXEVBnF3dGqU45wF0O1yHj8PdwiMIKkGnyphQwIetVVBAov3ce4rXVQmqIvVRbEl3isTZ5RbCEZSD7tAoeTmbcxSldK88hiiprepgFFESYAWPHl7kszv9oaZA8VM9gDLhV3tCr/zXSwHDXWgn2juC+VcMTeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by PH7PR12MB6696.namprd12.prod.outlook.com (2603:10b6:510:1b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 06:45:22 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 06:45:22 +0000
Date: Mon, 31 Aug 2026 09:45:11 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, dsahern@kernel.org, horms@kernel.org,
	willemdebruijn.kernel@gmail.com, aksecurity@gmail.com,
	noam.caspi@mail.huji.ac.il, stable@vger.kernel.org
Subject: Re: [PATCH net v2 3/4] ipv6: udp: Create exceptions before socket
 matching
Message-ID: <20260831064511.GB3079008@shredder>
References: <20260828192344.2596928-1-idosch@nvidia.com>
 <20260828192344.2596928-4-idosch@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828192344.2596928-4-idosch@nvidia.com>
X-ClientProxiedBy: TL2P290CA0030.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::16) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|PH7PR12MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c97fd46-02db-479d-11dc-08df072b6e1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|23010399003|366016|376014|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	sL0+SoaJG0N/qk2vEmMjvzlprIkP4YydJwveFPmw1s6z9LieegSZbU8BiaBWafd2Hs5Kt3MpAwLalOSmM0qp8056szFHDMOTdto8NrYjE+qBcwVlBLcaUIKBN9V3eEehODxXykmwQ0iWJ+VICWrZcRGdrjxO9v8VSRwyzaKI5TE3hX9/oLY91UcdnPAfVk+etpPXs5zKyiOQa3zDWfHZtoXOWBe3lCXE3ec4nTQF9ZCN1lzEHJ+BHaDpq2Y7837quaEY8I/Yt/sfGvjCn2D9mEmYnnb2pFwH48hiFiTwyD/63Sad6o/TT8LnKNSc6gNeVtKj0XixyJZ+oy0nxo/eQmdvV2bjdL0vTkz0TVnav7cJOInQlEOpYtkx+ItrCCE9pC51sAkJAT719zfeiA7lC2H1Dh9OJHpwaoo4T0PWF8YO30SNFBQ15PksFAC/GlKO3ls1OnEO6AsPmMZHAzz3zhFbBe9mWvuioBin9iQNlE79c2xkpGAay5iELwiOxuuUY5atkFjpQdDl9cggIzBpz/pgpiHcpYOk65HE2S9yasvIb0QtAbfubSclZ03gqa+NqcucZgDiBDU6txN/P+8cTgNGae1QrLNXGmlu4/mecfsd/EeqBBlu5aECV/esaONgqBXHPZleZ2wY2/WAs3doFpnpEaS976Ew3HYafXEAf/Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(23010399003)(366016)(376014)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mp9QHYJA4yyF8MI5GSG689bHUljmBKXG+DHUvTbzjE4zUXgDZtHoidOuskbq?=
 =?us-ascii?Q?i2HVJWasPyTQytK+mHPt+eN22P5aM+C8M7LropoCEIPMCxKmosbN8K854vjS?=
 =?us-ascii?Q?CGThDV7VMqvNLsl0Q7H15Mp2K7YfbeeGxWZCd9ohUx3Aj1ABcRrGJP9VOanB?=
 =?us-ascii?Q?JBv08lQ9mNJpinRerJfV5MpFpnmzcj5VVzSYLM6SUkAZHFt+ViWeuJHwy3gu?=
 =?us-ascii?Q?99WxK90JqVwd5ffuapc5dcJ9gEQ30eoO/FL0kZs+0ICgtJifyN0Lg4BrCiFS?=
 =?us-ascii?Q?iKejTDmEkAwax83cB96YR6ZersfF92SfqSrhtQRMh7+780/8s/7j/ySmsfmX?=
 =?us-ascii?Q?zQcYSO/QBRWNGFnNdeIiu29Js3L8oW4k0GGMdI5bmpO30DQTrS/3pb1AN6fj?=
 =?us-ascii?Q?I5ukOODmuBPZZUVwxC8zqfyAzc+JlTElQ2hU+lRgnSIFP9SXbf90F7wGSjiX?=
 =?us-ascii?Q?e9Dh2VYfVOlcCliGYwCKUNZX/Euqqu455mh/OvVEFOd3oXYtjf9jHoZRmFmj?=
 =?us-ascii?Q?pZD3YSI1UVk4B/q8OlABIQ+J/a8DBYSZSKkKQdghkOhhxHF4BiOAMl/N1Vh+?=
 =?us-ascii?Q?QHXbEfHD8bd3AMhSRKuspJl8VxbOad6d3zSqMlwB2DKroaUZx4FYMNMeVIUK?=
 =?us-ascii?Q?QZRF8KUUYu4Bw3txtq1tmfCtjVnuQFrGy3zoveggj/jVjf+IvFE+0SR40dKJ?=
 =?us-ascii?Q?U0vj8FN4HJPnCtFKszXRHrkgkt3P+40bRZ4aBm+jVSBR2zp/ZrzA4VtwVNvo?=
 =?us-ascii?Q?37O4bGgTp+XjkhF6V7TZ5QM81rIQKM/vTSbt3DKRyh0HSQHslNYqqVMFjqkh?=
 =?us-ascii?Q?+T16oYItTqgy8vjbOgcOSAlIQ2Am8gaCDGBF3rX3NmBCqwgUG8GcgVMlL59N?=
 =?us-ascii?Q?Baima+67QZRKlQPA6IFU1CWULindlGw6sVSAh+efoAmxeC3HhDALTKeluk1t?=
 =?us-ascii?Q?y+9Ow88QYnFHtHYU3h3nMkJC52z8L4kWw/d9Pubkrg3UfqnXlLfRLkGraAUT?=
 =?us-ascii?Q?4DkesDkSLExl0DC54FunSaqWG/KZF3lI722mv2Z+NZyKOvmosxsoWR5ysUQR?=
 =?us-ascii?Q?vy1Oml91pzggW4VzdVKSmlTBSSML0iBySqbuU+S/SEsgWw76tYTE6OrhnPIB?=
 =?us-ascii?Q?HfDap85MkNSutGrZYF8J8Q123FZCkLdeihIx5qjPeSwuwu0Zo3VvrhMr+lp8?=
 =?us-ascii?Q?cdhdq9jIuKqaNcN6Fm+1e4/QX5MxEehemsq/xaHOpNMDPhuQPi1kdtEmEqHu?=
 =?us-ascii?Q?bsrh378sTlNWCLiJ41Qp6aWAW1qJ8KzxgAirRfpAmbg3JKwvIBCgzT/1WE1D?=
 =?us-ascii?Q?Yy3X8Qpun09JMgG6rX0Q8NT6M71zFdmZ1hEntZ675uZ9tZKCEMxaKe6Bm1sw?=
 =?us-ascii?Q?LS8BTO2toSFmi1KPNwEExTmydbgdEy9Bck0Ll0BhpdPaRgFFpard5/dfbFGD?=
 =?us-ascii?Q?KMX3mnyeLNYYsctxLnrkpIn0l+VIqvfjzam7EvAmnqlyiQ934c5Xf2cNrzy5?=
 =?us-ascii?Q?KHKZmTlfOFTM5Q+nxEpQE9IweQHULLlsLc5mnoA7UgYN4HklLL+SEcOSuUEv?=
 =?us-ascii?Q?vvbRQS9QkPN4BAfPoGyLra4wDhQfV9btSjA4OCUEhOS+48duKKw9ZFJ1KYBP?=
 =?us-ascii?Q?i3MzHjpULF7DVVOKffOZWpwsdjyoOMFWuCZD/2VW9eLTpKKZa/SFubFr6xpX?=
 =?us-ascii?Q?wth9pJAzpRRZwik/byIn9Oz8nDfuToYFqkAV4YOfbGbCH5yc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c97fd46-02db-479d-11dc-08df072b6e1e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 06:45:22.4284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNuXlfHUnJOIaXiG8Kxg3AJLXNhxyHtqFnxzpkAP9gidracy48y3YRRtYUCskqhabksxyYNBKa6ZeFdjv7A6CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6696

On Fri, Aug 28, 2026 at 10:23:43PM +0300, Ido Schimmel wrote:
> Currently, when ICMPv6 Packet Too Big and Redirect Message packets are
> locally delivered and quote a UDP packet, an exception is only created
> in the IPv6 exception cache if the kernel can match the UDP packet to an
> existing socket.
> 
> This behavior allows off-path attackers to conduct a side-channel attack
> on the exception cache in order to discover the ephemeral port used by a
> connected UDP socket.
> 
> Commit 4785305c05b2 ("ipv6: use siphash in rt6_exception_hash()") and
> commit a00df2caffed ("ipv6: make exception cache less predictible") tried
> to mitigate such attacks by making it harder for attackers to discover
> hash collisions in the exception cache and by randomizing the number of
> exceptions a hash bucket can hold, respectively. Unfortunately, both of
> the mitigations can be bypassed.
> 
> Instead, mitigate such attacks by always creating an exception, even
> before trying to find a matching socket. Do that by calling
> ip6_update_pmtu() and ip6_redirect(), the helpers used when the quoted
> packet did not originate from a socket.
> 
> This means that guesses (right or wrong) from an off-path attacker will
> always result in an exception being created or updated in the cache that
> the attacker can observe.
> 
> Pass the ifindex of the ingress device and the default uid, in a similar
> fashion to icmpv6_err(). Unlike IPv4, an oif of 0 would not match any
> nexthop in ip6_redirect_nh_match() and no exception would be created in
> response to a Redirect Message.
> 
> Note that this does not allow attackers to create exceptions that they
> could not create before, as both helpers can already be reached with
> little to no validation. For example, by sending an ICMPv6 error that
> quotes an ICMPv6 Echo Reply or one that quotes a UDP source port that
> matches a wildcard socket.
> 
> Also note that in the good case (matched socket) the above scheme comes
> at the cost of an extra route lookup, as the no socket helpers perform
> their own lookup before the one performed by ip6_sk_update_pmtu() /
> ip6_sk_redirect(). When the two resolve to different nexthops, it also
> results in two exceptions being created for the same destination IP. One
> in the exception cache of the nexthop resolved by the no socket helpers
> and another in the exception cache of the nexthop used by the socket.

tl;dr - Same as patch 2. No changes following the feedback from Sashiko.

"Can the Packet Too Big path still leave the guess/no-guess difference
visible when the two lookups resolve to different nexthops?"

No. The side channel only exists if the attacker can populate the
exception cache of the nexthop used by the socket.
