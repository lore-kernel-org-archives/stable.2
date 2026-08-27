Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010068.outbound.protection.outlook.com [52.101.193.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5100247ACFA;
	Thu, 27 Aug 2026 19:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787859313; cv=fail; b=j79g93n8XfX98vG/keq0O+extTt5I2DnDV7lN7nzmtVtlOYaNX+aaym3S6gO2jTTigexKiMUBoWJ78i7up1snJAWBMDXOCWCbjR/DFyayWbigGKPSHb1CAx+NmYiDU/0sbhLNXk+GTKCkiQIbehr3vhLIjJ8qg8+lyAvuRe2y9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787859313; c=relaxed/simple;
	bh=2xyrxPcljIUszz7JIpljVHxthi4SO3vkl3X7pYfqVhM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lXFDGE3EGpB+OiLbd8g6YU0rhDS2Ru64UZm10CL0itKCRrJix9ILlASM6Wkdo53y5x9u4+eXwmZJohrRIy/IeoDkFKW5yMoecG1vEu11RbhRIaQC84ZQ1wqzLt3gG63R7zWdHC/y6udv9u0MqgIu83RbVWGv/bNOEXztvuiYrag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EELF85he; arc=fail smtp.client-ip=52.101.193.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EELF85he"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YfPVii1Vo7Jb1aa+VbwFf0tidmlxm9szxzodqi43j7nZnQ/1xfQjXECkbdfqoZnLc12rYfWY7gTTUVQ8QU1CWc8e07wgt8yDtTuLdYs7SofQ7EdWX7m2DeERdtl0P8gnMtPmqzctnL04endnHhV+3M7YaZarak6ZIn4lW4tfajS0IuHjcaJlj46VpCPjAdXSpjSk/AnXvEKGSb/+SvmaCcgPp3RyTBIlq7ApI7keoC+GqbaddzvJ4Lyia598fVHgI3fNcfyWDJOszs7Uu1ElM5S0oHJ9UbfRWqOUiWLv7DU35joBv6wz8V203TcmzQ0PFO/HC1yVR/A8bMkPBLzfDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUMSoxn0FaGvbhnQt/41Mbnme5KZ96sXGUo82hO/5Po=;
 b=TJJbtnQN8vFdhFugFUsHSPfT7xNfrpE+Reu93A0mEGmSAoVdsiQHaF7eCGO57G14SK0MH/dvGnU83ux/Q1b+x3G1IjPAs39J4I7Hi+6qmZFNkhWrgFe4vGD8hcF2W0zsmlIGhBQBXZTL5YQASOl1ZjpUSGTvNVIXCKeuVmyMGJfzhQqr3ddvOx69M0+MXdLlD64FgZd/oaXZI47k8nXTPSk+yROaR6CQN/HXFz9SrtykatM0orc5G3Ugzwobr9d1SGv5hWcZGo3vyneCyeyPgxRyqTH0+Ny+sf3akrRewAKOd61jl8bD3nOQ3jKwr3qoBeWs7TvKzx7LEtyj/0nf1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUMSoxn0FaGvbhnQt/41Mbnme5KZ96sXGUo82hO/5Po=;
 b=EELF85heG5CKRQh5VylyGiV0jOOuuwENJYCjGiyCZbSA3QXGzxjUgZ52mrfaoAUAK8F1VDJqf+YzcHaYrgrse+yOHekKeOIainci/cKDCIA1PbxbtZfclw2pfXImwK8y+yQ7kbU300bmVcIR/JeY7wc89De1JcH78Ca4/rhbPfUSLy3LqoTEvo7mchEfcFnEdyJJjdV1/qJb/BVr0HeS52XzC6tC3WkFhgg2Qq+X6uyrovVViF+fz9eSU/AaSCeNDMznhlZyzaCrzS88jYhNQ3Y44AhBI+eB1SgAmBekt0endRuZ8zSSmQms5NIGiyp3QdkT1JJnW4GbMg5gDcQm3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7957.namprd12.prod.outlook.com (2603:10b6:510:281::22)
 by IA0PR12MB7674.namprd12.prod.outlook.com (2603:10b6:208:434::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 19:35:03 +0000
Received: from PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499]) by PH0PR12MB7957.namprd12.prod.outlook.com
 ([fe80::9251:acc2:cc63:3499%3]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 19:35:03 +0000
Date: Thu, 27 Aug 2026 22:34:54 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Peter =?iso-8859-1?Q?N=F8rlund?= <pch@ordbogen.com>,
	stable@vger.kernel.org, Vega <vega@nebusec.ai>
Subject: Re: [PATCH net v2 1/1] ipv4: avoid divide by zero in fib_rebalance
Message-ID: <20260827193454.GA2320979@shredder>
References: <20260827182514.4667-1-zihanx@nebusec.ai>
 <20260827182514.4667-2-zihanx@nebusec.ai>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827182514.4667-2-zihanx@nebusec.ai>
X-ClientProxiedBy: TLZP290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::13) To PH0PR12MB7957.namprd12.prod.outlook.com
 (2603:10b6:510:281::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7957:EE_|IA0PR12MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: fb13e689-8c06-4064-ba0f-08df04724a7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	bDCZwYMEpHzu9xO0lUBteaNuvi0YTBrRAZLBe4yyoqbwyZENt4XccNVI74gx5tXrozOPW+RZRAHGcksrgKS0+UOPLm4ZzSdDKsU8nsvkt/ezYqgwQpaMSCeDiW9MIjRfvZj400aJsf7FeE5CH17OaBedUWQs5YviSFGLLOMJBRi/ivMdxmQlqrFwz3V4sZCw//O4Jr7aw0TAY5TY4x9pGfzGb4FzmNPwk5UUfB4VCgLk9FVHk/maTHgJWrET90LgIEwyKOf9RXQKNzMTYf2hu91Hx1gdh4XAgmkxFKN8YHrdvfY5ZQGGU6RphnehIVIqK4I7LcSqPfIJOaVmjxTVLDyKbDsKzKh95/Ejq9oHHTVTjX4r9rjwZT3eiT9fIOvSjeLJFi//WG0v+AssPy1OUAdSvfq2jOSaNPd0PWMnSyiYNqQKONpnu0u8KGKAmco3oaQJ+BcVkS2CFZ/qvYCsCJVX4p8f59wPfOZCqckgbki6Urf5TprVWInNBJb0gTVK1Ic6q7ufefW/Q4XfFB1KOXUHn7Q7S24zzMmKV55DyYfcYHCKAvcA43ZS1ZNxZE58/IvZTeDBQ997ESDk2IZXY6LEy+bIWwzs/8OcbgHTzPQPrBVMub728TyBBG73bTiqjS58nl7alM7gPOhITjURq79HcDOgApajEgtk11wpzM4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7957.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l4K0FT7rHP1YDZIOb+AN3R8wqrXzVHtO3uaUjUPdj9Cj79t2MqNrKXTf9emW?=
 =?us-ascii?Q?Ys+71oLcwexdkbdbdk0A8wQo2lObkdwwx01yvIGTD78Kl64Ugr6aC998Y+Bm?=
 =?us-ascii?Q?JjI5zT+IawvV8IYZD3zF24Ci+tG/rPG/8EZkgh/zZyg/X3pTzeQP9Ip2KxZN?=
 =?us-ascii?Q?Z8+kXY1Vax+rC7DGndeGpn0U5fV+jCxiBseCYFw23d5NvDUzZn12xyuCLcSV?=
 =?us-ascii?Q?WYDhqECU7nqntO2EF9I/G87E1KPdiPjWcQG5Xc1B9CyiHJA10gy+k6JaUiro?=
 =?us-ascii?Q?jcv26DzrlRfToN5v0MtpBu2Y7LpzpkAAGLkZW0IHhIJKW4WQdu0BZbptphUV?=
 =?us-ascii?Q?iSZZ2aP8LX5DEayhs977V7Wwwke+QPWazr0fcqmJnr+maTanhUvLLnKcu+uc?=
 =?us-ascii?Q?8MUi0CVliH9Ff5QmRHR9rdol4LlaAvHw/btL6y79JeHrJewikbh9Ju91zeaW?=
 =?us-ascii?Q?BsDfwdhnse6Xan4w/dBaWxPvGaL7Nx8Hh/pzdydRIEtpY8SlyyN7ZJgMXnX+?=
 =?us-ascii?Q?weSx9oRjrhNkFWhsoheQMRfusRyE0dHehcfplu8F1FF1UesAE78HKeO8vBZy?=
 =?us-ascii?Q?ELlP/slk7wumVwSyZzUc4Du0IeL3dOi/xNMvVykxD5AGjM+6gcfpyAysWfh3?=
 =?us-ascii?Q?jg1KPjcZpZyuBFG0R/17gQ/AV0dPAuyzZB6THNG+Escf1NUfJ6IR3nD1RNSb?=
 =?us-ascii?Q?TgVuDTWBXB8HVmLQD7AnUtR1ohEdiImI04Umbj4WZ6kJvgcve4ISkqiTASJ1?=
 =?us-ascii?Q?CW8KGoG5jSIBi8W07Y+Z41G0RX1y49liM23sutyazMzwYZ8psoWB9CJFrZTE?=
 =?us-ascii?Q?R+xkL2I3fK9KIwPS8M3F3npOdFwiBeqnGYLw2mrOzAik3v4femiMvyz37aeL?=
 =?us-ascii?Q?n7UcmVMiklPZeO82xrQs62JDhMnDHLNr5s6nq/lDH4dFWvMdrrYOVWDPDhfS?=
 =?us-ascii?Q?kF0LGIbB7LeiF5sx86PXLtnRExwGEhTQVGGW2P/65Ce/l/II7I+YpwuuGKs2?=
 =?us-ascii?Q?NdiVkRvnTPmhPd3A6NH8kH1useVJPiIlGF1Q5LzdoS7bjdbgPk6vFOh3BlIL?=
 =?us-ascii?Q?ZgzTFnIJMkDNgraJWj7aMxd1HPCpIRlyy/CM8oEoear3ZCEIXLxw6nXl9LPY?=
 =?us-ascii?Q?jXoIp+wOUp30KwJjJpFe65ezG2FnOa4UAs5Cl5XIepIVI00We2G+Ie95COvj?=
 =?us-ascii?Q?8gqNVLn69Qi5ctq/EoJ9CU26T5EzSNPki/T7wI8VRL37oiv0K/mzYIhYbYTE?=
 =?us-ascii?Q?0pVXXoSXyNLRnv8ob9UoHUkWWjDvMGaVkQXrSRigbaiQbn4D0NbQvreEDvk3?=
 =?us-ascii?Q?tuCh0cnV5+rlWJgkTaGklYL6+N22S1bw2oFQQ3CuiQW5EWRvcFTB02J6tkuz?=
 =?us-ascii?Q?Mwp/HpWpSptbXlN3PUaAPL5uaMsoH88mXZuDFWflFN7f6V9WrODZad/w3M0E?=
 =?us-ascii?Q?89BPxosXbQKKatwlERKUuPGqKgcESarIsAQ2HZQ9aJhyweVovedQA28ElsX5?=
 =?us-ascii?Q?aNlvl4Kt5D53imrRq2m7GmNAPJls2ma3wa8IxRT5+TIyDnAKoG3w7wdUnMJv?=
 =?us-ascii?Q?BSUPpZXXonSGAVeNvFgAbOIeSdCFg3v2rIJh9ZlPZOP1I72A3ZvcDSjI5hOg?=
 =?us-ascii?Q?24cq6JMDH3PFgy9vy3ESdxpQ4GpcV9hLI04yDBHgveliuudWVYPahS1niUYl?=
 =?us-ascii?Q?xH+ox8VuCLic9kauvebmaEVWx9Gsb7Z4HwlKvPSv96R8nPWYOAqkuCjM+uGw?=
 =?us-ascii?Q?+zS+BMIOTg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb13e689-8c06-4064-ba0f-08df04724a7e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7957.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 19:35:03.7639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ll/HJzEEvjfIC5Mg0EtWdwkIfY7tSjkkJPaDWoZMVr07K+1cNx7yTkuvOrPfcM7A+cbzlTMQwPNIOtm5AM1x6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7674

On Thu, Aug 27, 2026 at 06:25:14PM +0000, Zihan Xi wrote:
> fib_rebalance() computes the total eligible nexthop weight in one pass
> and programs upper bounds in a second pass. A concurrent change to
> ignore_routes_with_linkdown can make the first pass return zero while
> the second pass sees an eligible nexthop, resulting in division by zero.
> 
> If the first pass reports a zero total, set each nexthop upper bound to
> -1 and skip the division. This matches the IPv6 fix in commit
> d2c26c2911dd ("ipv6: avoid divide by zero in rt6_multipath_rebalance")
> and preserves the lock-free rebalance path.
> 
> Fixes: 0e884c78ee19 ("ipv4: L3 hash-based multipath")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zihan Xi <zihanx@nebusec.ai>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
