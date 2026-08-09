Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012014.outbound.protection.outlook.com [40.107.209.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6549533ADAE;
	Sun,  9 Aug 2026 07:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786259542; cv=fail; b=Efbsa7CwmVRpv9vccAY42e1a41R7NDhojr7hwjjeLVloP778r5A3CeVjBZdXDcA6xT92F6i6ba/oGSTX+7C0mYlilNK61MCg33NyF9DncGuTdZmrudvrhuPiQ2Nz33FlzvYQX/2sM48Ab+T6oL2OZuWfWGK4FAG24oKPquXfM1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786259542; c=relaxed/simple;
	bh=hfzsfJVZgzDo6AKMBwRTY5s8Z3jd7F9jiZwcyM/Esf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ePyDXzbNJIRUUEe+D0TR/AaF1xMCnCkSNd9ydHegdWT+OTtU4Jz6KBlV0itDnLyD6O9+TexVWh5AQ5vKyQZ6ttsrH6X4CC4YH+qWXnqQQdqnCBkpX5/wCXnnnDJjrxgpEnZXfr+03lVLI+mtGLfk1J06Kxgg07e9Ffs3kGPFyZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C0RYq3ga; arc=fail smtp.client-ip=40.107.209.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C0RYq3ga"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yfa/9rAhjjeV5hd6vJNzI8EiptdBF6u9vZtlmwCz+3HDCXIlr1oObxAQz/b0mHyCE6qXFG+yttiWzb4ppybgsBNM6mbpSXOwgs89hMvbieft0WmnO6mU8pZxTbht8qdG2T/7WPJ9kbQW6Cm3N2dsLJD53rCBfB9owwBK9c+4buiTkeQc4GeB51RuzbZbAY+QlSHEnmEJHhq17HZ8mmtqjFWTTDy13wKNYfUb5ySPAG86TLGd3lU7MRPKpwCdBFviPIcP6ldT4lFII+QyUQBTocHick0hg2kgaade++2r/JJ45M1cscMR7eSjPMT1QUhHtITAOwQ8HyXxvt6p6xTlRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TGSyXk6I0yetTFeOJf50PagQEgLj1ClJUMUAMD20VE=;
 b=YA+ydqaL4dcG5oQpWS5cljjGIg1EvPvjG/Zx76bdnS+fqeZTpUK87+rUv1ZjycvQ2Q6YjuXZdDTReh/uAq4aRfm5VEn/FKdwhdBiCicf+mocEasy3Y5+LUJoFQ3iB+dCh5SYwoXY8qhmZNLIzcElW/KRITT7KcXdNYx0Mnd+WNvourvJXPhxAecy7Zl65SiF3io1f7hW+7Fxq/aSShy00sRwMqgng04PgpZUgbv+cgqOLunD0se0A57t/paoJQNThuDu3Da0/YE/CO0kjsnJ9V6djler7WotXvV3gVB5ppWD6Om8gjfJMXC//ygujt2hjAAAOrUbcb0tvuTQdGX+Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TGSyXk6I0yetTFeOJf50PagQEgLj1ClJUMUAMD20VE=;
 b=C0RYq3gamV5OJa8u6jQUYkWeW8kFzHBAa4tRiQj1sEy4qI+Wfhr1W5gDCx/TmXM8x+kaFDHJ7kUKe6b8pLHFGxSD6UCRo0GN4gnHbj4ttF70Bm2smQFX0wIm1+iOTV74shAFxHPejR3HIquT3ARSMgUypRmuViHapWFtofPaEJwl1lL3S4UwKNOKz2IrQM7nhLNaftRgemT+Ne6jg0MRRoUOsbMPDsdJITLMGA5SKxpRbMeDNfobGjJ5V3OjTp7Z37ObtKE6WU7I0RFjH31nRUpbhrTUn/beYv/Ehl/pi91l9reXqUlKje2DWmE3o+Df7hZPjPwNaF4cjMGQH+L8QA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA0PR12MB8253.namprd12.prod.outlook.com (2603:10b6:208:402::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Sun, 9 Aug
 2026 07:12:18 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%5]) with mapi id 15.21.0292.024; Sun, 9 Aug 2026
 07:12:17 +0000
Date: Sun, 9 Aug 2026 10:12:06 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefano Brivio <sbrivio@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3] ipv4: fix use-after-free in fib_nhc_update_mtu()
Message-ID: <20260809071206.GA2297836@shredder>
References: <20260807181710.1178747-1-nicoyip.dev@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807181710.1178747-1-nicoyip.dev@gmail.com>
X-ClientProxiedBy: FR3P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA0PR12MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b496ea-2c9e-4bfe-5e1d-08def5e58bc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	r9QA2uC0mCfC/UhCwMk1Pwv/WOezInZB/SU3CF8LluJilfJO1VOOc1BLUF02oiSHlfUMyD3iL8P+5shRecAsDvXFKoNNEdh87g9E/BO3Gtm4IoZFdAgqUu2dwLhEHUzdUdYloME/yJfORUeVvnapKw4IuWUJPilcv651OA4fWe/IsnVO8c78ysvBMH8uuM5sUPxrEYmKbm3S7POdCoWZWv4RDIRBoLQ4rlfYoORUihWQwb6TK37WtOk2uE+RkDt1Nq8azOoT8OJQVjJzQtTu9BlzbsIJuqWsYsYct/1SaV5rCXKYB6aS07foZWjsXch3yTdd9SwVX+Rk1/bC3LpxjDa7dBTlwG8IQCizQM5qaAEDEp5wIqRC9/FEnNQr6BGiR1QDjU/z9q2n3KGLPJntm+GCyXdygpJlM6QK2rRUwY8IFfYK9St/tR9djG8C6/6qOl5rzBA3ukwaFloAgX61NivzRE2zdqj/KkSg6tAn0EbyLj5ehpkt0/ZHXk7o4iSOUFQG7bUJVLkUcQpWhmbk0YktS5u84M9krNnSTpnq3VlNWN9Frdc9h5WGNCSvPWOtby8jDpj0uLX6C5/FOH1PukdMopMocngpAuAe/633EkABGNyDXBDU5sUcipeU0PqK2n8ggROzPO9val8UNhJDxj3GufC17qQDXSOGW/yH/oY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dqwik05npJE3FScxL7YTACy9uBx4dTH23roA0EGrH8091ohZbzQSRDJG1eXr?=
 =?us-ascii?Q?6CVVV7J/ao4iztk3Ahh1WoAc0dKy67eeS9HlGvsoUa1YDmHNGkk6LJAD3wFJ?=
 =?us-ascii?Q?hSxRhtShq1tQcp6yjX3BFn9hcFG5EDQRp12IDevfKxetfPYTaMBR8ppOd5Fw?=
 =?us-ascii?Q?ad140+ADNbgL6aqmwhOm4zEbb91JLrfDBJQB4xttHUv5MPLREgjb2CGMjoMo?=
 =?us-ascii?Q?uc6Ixal3KiV52jZLfJoM+OdJ4q/s71OF+HJVHin5W/ufsw5/t28nwfYyOeXG?=
 =?us-ascii?Q?iQMQgjVPQnNzR4cIjFTnucgvoYRRoCINsLltgwroJPQCChxhV9X2jnSQoImd?=
 =?us-ascii?Q?38vHpgYWZAwASyzqta+jSUkKeRgIlwA8tboN134Ht2ruKdyTMe9QFMVuZg6l?=
 =?us-ascii?Q?T5tWajgVskgQZ8YM0svcPWKY0ZKMjuFS5WQNNr2wK5js9jWoE4P7hY9qgg7Y?=
 =?us-ascii?Q?a5/ElAh0zwQ+lPM3O39DQUim5TWTd6TSpXV6hW61C5ynVrt5xNw4LcOk9Ulz?=
 =?us-ascii?Q?Mb8X0JgVn+ApbUIaU9GaujJtrS5ccgoS5Ix8yuOC/xkdXCHGnE5wsbvVsgTT?=
 =?us-ascii?Q?e9tsDThJwEbnzu3DmxJc+McOIyVPoC5blbh3GGyiH5n2SMbEyzCLTQVHygbm?=
 =?us-ascii?Q?VBA87t47kkzefr/T+UYPAQG9qKB2JED3tc+DCZE+Hq7ly+Y+EYVNqXOck6pL?=
 =?us-ascii?Q?XoDpkZ484dmOIN7to1bNSr97HeFmaCf7IZ9jpoC7ukmTIJtSE/QfJ+N4z1Ul?=
 =?us-ascii?Q?biernx8+B3ttv6EJsEAqZQCaCKAV4OgUA+qIUYA79RVGyeXOZ8AIB6kYISLZ?=
 =?us-ascii?Q?3ahlVXO1in6E0j43yMXgpxiXf+Mq3J7E+nPULaTcLalsHL7gfEOyggBSZ++j?=
 =?us-ascii?Q?mRWd17j2sEk8NPHnuRkExDX8jLMvA2xddHsH3tZu5CuFvIVpKsiEU10yCKe1?=
 =?us-ascii?Q?xMZPX12y29GSXwW2oXs3ZjKNo4Lf2SnqTICy/5jFba57ElGNryTl+J2RXRJ+?=
 =?us-ascii?Q?KRa8KNc7DMmYI2HcjGffAnpprv1BYhanqIjVE9jXMsDxpyombkFY1wZjjlzd?=
 =?us-ascii?Q?UB1YBvwCin7KgB/qns/LktLIrxEVwxtqNR++qQIv9Es+Y2ZK5UJreAsYc/TE?=
 =?us-ascii?Q?gNhniXiQzgKhfY0h8uNWLq3vV6diFQPdgchH7PlKK+ZEDUQszfxHXNjHKr3E?=
 =?us-ascii?Q?5wmLBzJJh4eB/W5OhQstQDnI/nlVZq1XSfeuebi3KfWLwPZ9qqYRqieEiCJO?=
 =?us-ascii?Q?snBV3VCOUoTLmvKylX1h7LnSDvnsqlKGYFzP4eJjFgaZbVTMbFnWwvhThMIK?=
 =?us-ascii?Q?sZKgo6txaZDxuvuWZiCVBjalmeNEY5iwFE7UNggJVaLaYxthD4gRoEodE0kW?=
 =?us-ascii?Q?IoEvd27+pcLpKjrtsiV78B/d0e78ERTTrK9pFpjH20K+ojekfAByaMBN+OcN?=
 =?us-ascii?Q?Ne8SoS7Eh0Crz/lcqBram5LcxztQOqZmxu/bMJMILoRdqgqlAqxkPMF3AzQT?=
 =?us-ascii?Q?0j8hrP+yg1BssXZ+qT5XpCR9+jfV8bS/SziRO4kQTjSKkYAxbQLVlgRhrlgK?=
 =?us-ascii?Q?jL6YWy6rIeMVIozukdmoiAGADv6Lt6qdB+KK/BGpwBlCnjxo2ZpzxjuCQx5d?=
 =?us-ascii?Q?Qxj2bnsKwa1gDBXKP7iRRihitCTjWuDCXVHK25FHsBR5IlL4+dy/YKvsvcds?=
 =?us-ascii?Q?LXTY2lZJA1CJnXrJed2B+tijfZxgJKgjXIEFIow3nNphA80O?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b496ea-2c9e-4bfe-5e1d-08def5e58bc6
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2026 07:12:17.5785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6aqRm3vmUeW4muflIAvi3mdLkvf3palcLVHFWfeRTxT5J3BazxjuXXmFh7BU5onemorWQ1inQAV3pn4H/noxPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8253

On Sat, Aug 08, 2026 at 02:17:10AM +0800, Chengfeng Ye wrote:
> fib_nhc_update_mtu() walks the nexthop exception table under RTNL, but
> RTNL does not serialize this walk with PMTU exception updates. The walk
> uses rcu_dereference_protected() with a constant true condition without
> holding fnhe_lock.
> 
> The following interleaving can therefore occur:
> 
>   CPU 0                              CPU 1
>   fib_nhc_update_mtu()               update_or_create_fnhe()
>     load fnhe                          spin_lock_bh(&fnhe_lock)
>                                        fnhe_remove_oldest()
>                                          unlink fnhe
>                                          kfree_rcu(fnhe, rcu)
>     <quiescent state>
>     access fnhe after grace period
> 
> KASAN reported:
> 
>   BUG: KASAN: slab-use-after-free in fib_nhc_update_mtu+0x3df/0x410
>   Read of size 8 at addr ffff888107d49000 by task poc/90
>   Call Trace:
>    fib_nhc_update_mtu+0x3df/0x410
>    fib_sync_mtu+0x7a/0xd0
>    fib_netdev_event+0x229/0x3f0
>    netif_set_mtu_ext+0x33a/0x570
>    dev_set_mtu+0x88/0x120
> 
> The same walk updates fnhe_pmtu and fnhe_mtu_locked. These fields form a
> pair and other writers serialize them with fnhe_lock. RCU alone prevents
> reclamation, but would still allow concurrent writers to leave a mixed
> pair.
> 
> Walk the table under RCU and acquire fnhe_lock only while updating each
> exception. RCU keeps the current entry alive while the short critical
> section serializes its paired PMTU fields. This avoids holding the global
> lock while scanning all 2048 buckets for every nexthop.
> 
> Fixes: af7d6cce5369 ("net: ipv4: update fnhe_pmtu when first hop's MTU changes")
> Cc: stable@vger.kernel.org
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
